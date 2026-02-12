Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57307EB48EC
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 09:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqSh1-0002Xn-Fw; Thu, 12 Feb 2026 04:08:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vqSgy-0002Vs-ED; Thu, 12 Feb 2026 04:08:56 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vqSgv-00043z-Gr; Thu, 12 Feb 2026 04:08:56 -0500
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id AB68FC01FC;
 Thu, 12 Feb 2026 12:08:47 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:450::1:4])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id j8QYBp0Al4Y0-gmHDKf2g; Thu, 12 Feb 2026 12:08:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770887327;
 bh=B2NtMQgUJJCmlMkIsVvmyHZ4h0Xbl6INo0GTkQGk0MA=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=s39B+IGU89w6HQj7ddN76/uBP/DDPF5vrzlaYC38DCtWxdniYeMgCBT/At3lyu3fh
 jH+pVM8hRfzSxAy6FN8et3ZqEYOPy+x6pvEK2GnrUws2mRyXFn+mPRMKrpunLxIAnw
 9YM8aEkzM06WSZ9eN3Iu0zKD1ZA6pZG7aB+invpQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, vsementsov@yandex-team.ru,
 Fiona Ebner <f.ebner@proxmox.com>, qemu-stable@nongnu.org
Subject: [PULL 1/2] block/mirror: check range when setting zero bitmap for
 sync write
Date: Thu, 12 Feb 2026 12:08:00 +0300
Message-ID: <20260212090801.999731-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212090801.999731-1-vsementsov@yandex-team.ru>
References: <20260212090801.999731-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Some Proxmox users reported an occasional assertion failure [0][1] in
busy VMs when using drive mirror with active mode. In particular, the
failure may occur for zero writes shorter than the job granularity:

> #0  0x00007b421154b507 in abort ()
> #1  0x00007b421154b420 in ?? ()
> #2  0x0000641c582e061f in bitmap_set (map=0x7b4204014e00, start=14, nr=-1)
> #3  0x0000641c58062824 in do_sync_target_write (job=0x641c7e73d1e0,
>       method=MIRROR_METHOD_ZERO, offset=852480, bytes=4096, qiov=0x0, flags=0)
> #4  0x0000641c58062250 in bdrv_mirror_top_do_write (bs=0x641c7e62e1f0,
        method=MIRROR_METHOD_ZERO, copy_to_target=true, offset=852480,
        bytes=4096, qiov=0x0, flags=0)
> #5  0x0000641c58061f31 in bdrv_mirror_top_pwrite_zeroes (bs=0x641c7e62e1f0,
        offset=852480, bytes=4096, flags=0)

The range for the dirty bitmap described by dirty_bitmap_offset and
dirty_bitmap_end is narrower than the original range and in fact,
dirty_bitmap_end might be smaller than dirty_bitmap_offset. There
already is a check for 'dirty_bitmap_offset < dirty_bitmap_end' before
resetting the dirty bitmap. Add such a check for setting the zero
bitmap too, which uses the same narrower range.

[0]: https://forum.proxmox.com/threads/177981/
[1]: https://bugzilla.proxmox.com/show_bug.cgi?id=7222

Cc: qemu-stable@nongnu.org
Fixes: 7e277545b9 ("mirror: Skip writing zeroes when target is already zero")
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20260112152544.261923-1-f.ebner@proxmox.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/mirror.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index b344182c74..bc982cb99a 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1514,9 +1514,12 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
         assert(!qiov);
         ret = blk_co_pwrite_zeroes(job->target, offset, bytes, flags);
         if (job->zero_bitmap && ret >= 0) {
-            bitmap_set(job->zero_bitmap, dirty_bitmap_offset / job->granularity,
-                       (dirty_bitmap_end - dirty_bitmap_offset) /
-                       job->granularity);
+            if (dirty_bitmap_offset < dirty_bitmap_end) {
+                bitmap_set(job->zero_bitmap,
+                           dirty_bitmap_offset / job->granularity,
+                           (dirty_bitmap_end - dirty_bitmap_offset) /
+                           job->granularity);
+            }
         }
         break;
 
-- 
2.52.0


