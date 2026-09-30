Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00DACA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBuGb-0006nA-VO; Wed, 30 Sep 2026 09:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1xBuG3-0006h5-7p; Wed, 30 Sep 2026 09:22:05 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1xBuFx-0004ID-W1; Wed, 30 Sep 2026 09:22:01 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id D3D144576C;
 Wed, 30 Sep 2026 15:21:46 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 qemu-stable@nongnu.org
Subject: [PATCH qemu 4/4] qemu-img: convert: flush target image after copying
Date: Wed, 30 Sep 2026 15:19:25 +0200
Message-ID: <20260930132140.2342574-5-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930132140.2342574-1-f.ebner@proxmox.com>
References: <20260930132140.2342574-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1790774505546
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

With 'qemu-img convert', when using a cache mode with 'cache.no-flush
= off', the expectation is that the data is flushed to the disk, which
happens since commit 80ccf93b88 ("qemu-img: let 'qemu-img convert'
flush data"). This expectation also encompasses that failure to do so
is properly reported, so ensure that 'qemu-img convert' exits with a
non-zero status code when the target image cannot be flushed.

In particular, the reproducer below [0], based on a report by
Ing. Alfonso Kuen Arroyo [1], would result in
> rc=0
> Content mismatch at offset XYZ!
before this change, and in
> rc=1
> Content mismatch at offset XYZ!
after this change.

Note that this change does not affect the (default) 'unsafe' cache
mode, because bdrv_co_flush() still skips flush to disk for that cache
mode.

[0]:
> #!/bin/bash -x
> dd if=/dev/urandom of=src.raw bs=1M count=500
> truncate -s 500M dst.img
> LOOP=$(losetup --find --show dst.img)
> SIZE=$(blockdev --getsz $LOOP)
> dd if=/dev/zero of=$LOOP bs=1M count=500 conv=fsync status=none
> sync
> echo 3 > /proc/sys/vm/drop_caches
> dmsetup create flk --table "0 $SIZE flakey $LOOP 0 5 5"
> qemu-img convert -t writeback -p -r 100M -f raw -O raw src.raw /dev/mapper/flk
> echo rc=$?
> sleep 5
> dmsetup remove flk
> qemu-img compare src.raw $LOOP
> losetup -d $LOOP
> rm src.raw dst.img

[1]: https://lore.proxmox.com/pve-devel/178961792132.43804.17173233935297903311@idkmanager.com/

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 qemu-img.c                 | 8 +++++++-
 tests/qemu-iotests/122.out | 3 ++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 2f63d31141..edf75e43ab 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2245,7 +2245,7 @@ static int img_convert(const img_cmd_t *ccmd, int argc, char **argv)
     Error *local_err = NULL;
     bool writethrough, src_writethrough, image_opts = false,
          skip_create = false, progress = false, tgt_image_opts = false;
-    int64_t ret = -EINVAL;
+    int64_t ret = -EINVAL, ret2;
     bool force_share = false;
     bool explict_min_sparse = false;
     bool bitmaps = false;
@@ -2872,6 +2872,12 @@ static int img_convert(const img_cmd_t *ccmd, int argc, char **argv)
         ret = convert_copy_bitmaps(blk_bs(s.src[0]), out_bs, skip_broken);
     }
 
+    ret2 = blk_flush(s.target);
+    if (ret2 < 0) {
+        error_report("Failed to flush target image: %s", strerror(-ret2));
+        ret = ret != 0 ? ret : ret2;
+    }
+
 out:
     if (!ret) {
         qemu_progress_print(100, 0);
diff --git a/tests/qemu-iotests/122.out b/tests/qemu-iotests/122.out
index 84283f2434..38794f96ac 100644
--- a/tests/qemu-iotests/122.out
+++ b/tests/qemu-iotests/122.out
@@ -267,9 +267,10 @@ qemu-img convert exited with status 0
 
 === failing flush after convert with 'writeback' cache mode ===
 
+qemu-img: Failed to flush target image: Input/output error
 qemu-img: Failed flush for 'json:{ /* filtered */ }' during close: Input/output error
 qemu-img: Failed to flush the L2 table cache: Input/output error
 qemu-img: Failed to flush the refcount block cache: Input/output error
 qemu-img: Failed flush for 'json:{ /* filtered */ }' during close: Input/output error
-qemu-img convert exited with status 0
+qemu-img convert exited with status 1
 *** done
-- 
2.47.3



