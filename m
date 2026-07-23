Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E706EC531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 20:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn0Vf-0006HF-VS; Thu, 23 Jul 2026 16:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1wn0Vd-0006F8-Jv; Thu, 23 Jul 2026 16:59:13 -0400
Received: from fanzine2.igalia.com ([213.97.179.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1wn0Vb-0003yy-6n; Thu, 23 Jul 2026 16:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=7pal3GqZZpa5LcVXJJ4SKlsAffqFeeW8BFng5xdHbgQ=; b=
 fJhc+xRiZvUV1IlsyrZ6cJiYVG/5J4tnZ7W5vqibIROLv5u2p7AxFxT1bBlMsRA/bPrKBNEVbbmQ0
 /blgNtibCW+n5ULBUOCE4wUTQYko7QmYe+uNNRWZw1BS+oP5IJhwIlUh0SF7Sh2qe4GbS9vyZMb6l
 fn8s3LksvQ/O0IIJ8bLu9n1TdLU9Xs1RcahlAD+Zm9toLI+/HL3BpSMdpkYZJCI3V+uK4ZL0qQf9P
 tOXqZc2LnC5NCdxa2/cdfYf+lTd9oOPHkRhlBLPcStKaTck1fMgokY9LNsgmki87vUGLZwUBXTKuF
 qzEMVbFTEXe3RX5om5MnvXZ26OhdnJhPIA==;
Received: from 87.pool92-176-6.dynamic.orange.es ([92.176.6.87]
 helo=perseus.local) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wn0VN-003bWH-KU; Thu, 23 Jul 2026 22:58:57 +0200
Received: from berto by perseus.local with local (Exim 4.98.2)
 (envelope-from <berto@igalia.com>) id 1wn0VM-00000000Zei-2caA;
 Thu, 23 Jul 2026 22:58:56 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, qemu-stable@nongnu.org
Subject: [PATCH] hw/sd/sdcard: Register device ops in drives without media
Date: Thu, 23 Jul 2026 22:58:39 +0200
Message-ID: <20260723205847.137001-1-berto@igalia.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.97.179.56; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Commit a362b19a39 ("hw/sd/sdcard: Fix size check for backing block
image") accidentally moved the blk_set_dev_ops() call into the new
'if (blk_size >= 0)' block in sd_realize().

Because of that, if a drive is attached without a medium then the
condition is false (blk_size == -ENOMEDIUM) and blk_set_dev_ops() is
never called, so the drive is registered as having non-removable
media:

  $QEMU -device sd-card,drive=sdcard0 -drive if=none,id=sdcard0
  (qemu) change sdcard0 sd-card.qcow2
  Error: Device 'sdcard0' is not removable

This patch moves the blk_set_perm() and blk_set_dev_ops() calls
outside of the 'if (blk_size >= 0)' block so the device ops and
permissions are registered when a drive is attached.

Fixes: a362b19a39 ("hw/sd/sdcard: Fix size check for backing block image")
Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 hw/sd/sd.c | 47 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a30c541df0..780e9f6295 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -3100,7 +3100,6 @@ static void sd_blk_size_error(SDState *sd, int64_t blk_size,
 static void sd_realize(DeviceState *dev, Error **errp)
 {
     SDState *sd = SDMMC_COMMON(dev);
-    int64_t blk_size = -ENOMEDIUM;
     int ret;
 
     switch (sd->spec_version) {
@@ -3118,32 +3117,32 @@ static void sd_realize(DeviceState *dev, Error **errp)
             return;
         }
 
-        blk_size = blk_getlength(sd->blk);
-    }
-    if (blk_size >= 0) {
-        blk_size -= sd->boot_part_size * 2 + sd->rpmb_part_size;
-        if (blk_size > SDSC_MAX_CAPACITY) {
-            if (sd_is_emmc(sd) &&
-                !QEMU_IS_ALIGNED(blk_size, 1 << HWBLOCK_SHIFT)) {
-                int64_t blk_size_aligned =
-                    ((blk_size >> HWBLOCK_SHIFT) + 1) << HWBLOCK_SHIFT;
-                sd_blk_size_error(sd, blk_size, blk_size_aligned,
-                                  "multiples of 512", errp);
+        int64_t blk_size = blk_getlength(sd->blk);
+        if (blk_size >= 0) {
+            blk_size -= sd->boot_part_size * 2 + sd->rpmb_part_size;
+            if (blk_size > SDSC_MAX_CAPACITY) {
+                if (sd_is_emmc(sd) &&
+                    !QEMU_IS_ALIGNED(blk_size, 1 << HWBLOCK_SHIFT)) {
+                    int64_t blk_size_aligned =
+                        ((blk_size >> HWBLOCK_SHIFT) + 1) << HWBLOCK_SHIFT;
+                    sd_blk_size_error(sd, blk_size, blk_size_aligned,
+                                      "multiples of 512", errp);
+                    return;
+                } else if (!sd_is_emmc(sd) &&
+                    !QEMU_IS_ALIGNED(blk_size, 512 * KiB)) {
+                    int64_t blk_size_aligned = ((blk_size >> 19) + 1) << 19;
+                    sd_blk_size_error(sd, blk_size, blk_size_aligned,
+                                      "multiples of 512K", errp);
+                    return;
+                }
+            } else if (blk_size > 0 && !is_power_of_2(blk_size)) {
+                sd_blk_size_error(sd, blk_size, pow2ceil(blk_size),
+                                  "a power of 2", errp);
                 return;
-            } else if (!sd_is_emmc(sd) &&
-                !QEMU_IS_ALIGNED(blk_size, 512 * KiB)) {
-                int64_t blk_size_aligned = ((blk_size >> 19) + 1) << 19;
-                sd_blk_size_error(sd, blk_size, blk_size_aligned,
-                                  "multiples of 512K", errp);
+            } else if (blk_size < 0) {
+                error_setg(errp, "eMMC image smaller than boot partitions");
                 return;
             }
-        } else if (blk_size > 0 && !is_power_of_2(blk_size)) {
-            sd_blk_size_error(sd, blk_size, pow2ceil(blk_size), "a power of 2",
-                              errp);
-            return;
-        } else if (blk_size < 0) {
-            error_setg(errp, "eMMC image smaller than boot partitions");
-            return;
         }
 
         ret = blk_set_perm(sd->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
-- 
2.47.3


