Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8939CA600B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 13:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEnvg-0002jC-1z; Thu, 08 Oct 2026 09:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEnvd-0002i9-E6
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 09:12:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEnvZ-0002R6-7D
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 09:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791465172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7GY8TbHPUA3/mMHQSrnhZXAe64iIwMku44Rplyu2ng4=;
 b=cl+npJSs1THbkBTsDDjCDE37Try1qoh+pjkQ4TvgJKZqTXcH5Ag2uqDLH8OJm59dD8oPif
 te8yG0CVwuzr/NhN1WMTDZhU8wnuO5elJmPNizyy8TzpDKu0sw4s67sicPuGmtO8//uZrT
 S6VVKMHEup6I0N6PU7KsFIsPrRqX4LE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-VF-i8YthNZWR7dRrwxtXzA-1; Thu,
 08 Oct 2026 09:12:51 -0400
X-MC-Unique: VF-i8YthNZWR7dRrwxtXzA-1
X-Mimecast-MFC-AGG-ID: VF-i8YthNZWR7dRrwxtXzA_1791465170
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B571193EF6C; Thu,  8 Oct 2026 13:12:50 +0000 (UTC)
Received: from eblake.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1C06B30001BE; Thu,  8 Oct 2026 13:12:47 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fiona Ebner <f.ebner@proxmox.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PULL 06/15] qemu-img: convert: flush target image after copying
Date: Thu,  8 Oct 2026 08:11:45 -0500
Message-ID: <20261008131216.2437896-23-eblake@redhat.com>
In-Reply-To: <20261008131216.2437896-17-eblake@redhat.com>
References: <20261008131216.2437896-17-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Fiona Ebner <f.ebner@proxmox.com>

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
Message-ID: <20260930132140.2342574-5-f.ebner@proxmox.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-img.c                 | 8 +++++++-
 tests/qemu-iotests/122.out | 3 ++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 2f63d311413..edf75e43aba 100644
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
index 84283f24343..38794f96ac2 100644
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
2.56.0


