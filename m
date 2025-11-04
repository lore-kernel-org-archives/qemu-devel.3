Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AD7CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 13:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGGrQ-0002sG-B1; Tue, 04 Nov 2025 08:14:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-20251104130351d4476d700200020729-7qk_u5@rts-flowmailer.siemens.com>)
 id 1vGGrL-0002qF-1E
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:14:03 -0500
Received: from mta-65-227.siemens.flowmailer.net ([185.136.65.227])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-20251104130351d4476d700200020729-7qk_u5@rts-flowmailer.siemens.com>)
 id 1vGGrG-0005VQ-TF
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:14:02 -0500
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 20251104130351d4476d700200020729 for <qemu-devel@nongnu.org>;
 Tue, 04 Nov 2025 14:03:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=cyHNINQrX0HyoRirhBGd3VHoxG1788Ib/R5yBwqDbvA=;
 b=hgWmtENKHAc5Gb8GGlQt0I6OZwhewHp0Od3FXoyUy1DzjSEpSSy52mmACFSyvSiKvASNuF
 +VAKkF35OpZEUbgQ7dRLfGLXz5I3cYasyuJ5u0OPndSRYFLogDkcT3G0jzxNK8faPsUFTwL7
 nSs1TRJgwiFIU5I6zAOVvnOmhs/GLHuDyQkw5RuU4NvfnQ6GVUhraK36jK7ZXRtTk4X9knz5
 JSgrAe/JSFJdwvgvUmdkFGDB0juhjHkG/qyTQIfJG29rGs8QU7/8Ta7DOZzPKUCcWJsxCXM6
 NJO/lZyD3UI4rvUg7RFZtx58ndeBFD6QsxIaqJpABR8uGbkZkY/N60nQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Jan=20L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH v6 1/6] hw/sd/sdcard: Fix size check for backing block image
Date: Tue,  4 Nov 2025 14:03:45 +0100
Message-ID: <591f6d8a9dc86428723cb6876df6e717cc41a70e.1762261430.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1762261430.git.jan.kiszka@siemens.com>
References: <cover.1762261430.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass client-ip=185.136.65.227;
 envelope-from=fm-294854-20251104130351d4476d700200020729-7qk_u5@rts-flowmailer.siemens.com;
 helo=mta-65-227.siemens.flowmailer.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Alignment rules apply the the individual partitions (user, boot, later
on also RPMB) and depend both on the size of the image and the type of
the device. Up to and including 2GB, the power-of-2 rule applies to the
user data area. For larger images, multiples of 512 sectors must be used
for eMMC and multiples of 512K for SD-cards. Fix the check accordingly
and also detect if the image is too small to even hold the boot
partitions.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
CC: Warner Losh <imp@bsdimp.com>
CC: Cédric Le Goater <clg@kaod.org>
CC: Joel Stanley <joel@jms.id.au>
CC: Alistair Francis <alistair@alistair23.me>
CC: Alexander Bulekov <alxndr@bu.edu>
---
 hw/sd/sd.c | 69 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 21 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d7a496d77c..76e915e190 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2759,9 +2759,32 @@ static void sd_instance_finalize(Object *obj)
     timer_free(sd->ocr_power_timer);
 }
 
+static void sd_blk_size_error(SDState *sd, int64_t blk_size,
+                              int64_t blk_size_aligned, const char *rule,
+                              Error **errp)
+{
+    const char *dev_type = sd_is_emmc(sd) ? "eMMC" : "SD card";
+    char *blk_size_str;
+
+    blk_size_str = size_to_str(blk_size);
+    error_setg(errp, "Invalid %s size: %s", dev_type, blk_size_str);
+    g_free(blk_size_str);
+
+    blk_size_str = size_to_str(blk_size_aligned);
+    error_append_hint(errp,
+                      "%s size has to be %s, e.g. %s.\n"
+                      "You can resize disk images with"
+                      " 'qemu-img resize <imagefile> <new-size>'\n"
+                      "(note that this will lose data if you make the"
+                      " image smaller than it currently is).\n",
+                      dev_type, rule, blk_size_str);
+    g_free(blk_size_str);
+}
+
 static void sd_realize(DeviceState *dev, Error **errp)
 {
     SDState *sd = SDMMC_COMMON(dev);
+    int64_t blk_size = -ENOMEDIUM;
     int ret;
 
     switch (sd->spec_version) {
@@ -2774,32 +2797,36 @@ static void sd_realize(DeviceState *dev, Error **errp)
     }
 
     if (sd->blk) {
-        int64_t blk_size;
-
         if (!blk_supports_write_perm(sd->blk)) {
             error_setg(errp, "Cannot use read-only drive as SD card");
             return;
         }
 
         blk_size = blk_getlength(sd->blk);
-        if (blk_size > 0 && !is_power_of_2(blk_size)) {
-            int64_t blk_size_aligned = pow2ceil(blk_size);
-            char *blk_size_str;
-
-            blk_size_str = size_to_str(blk_size);
-            error_setg(errp, "Invalid SD card size: %s", blk_size_str);
-            g_free(blk_size_str);
-
-            blk_size_str = size_to_str(blk_size_aligned);
-            error_append_hint(errp,
-                              "SD card size has to be a power of 2, e.g. %s.\n"
-                              "You can resize disk images with"
-                              " 'qemu-img resize <imagefile> <new-size>'\n"
-                              "(note that this will lose data if you make the"
-                              " image smaller than it currently is).\n",
-                              blk_size_str);
-            g_free(blk_size_str);
-
+    }
+    if (blk_size >= 0) {
+        blk_size -= sd->boot_part_size * 2;
+        if (blk_size > SDSC_MAX_CAPACITY) {
+            if (sd_is_emmc(sd) &&
+                !QEMU_IS_ALIGNED(blk_size, 1 << HWBLOCK_SHIFT)) {
+                int64_t blk_size_aligned =
+                    ((blk_size >> HWBLOCK_SHIFT) + 1) << HWBLOCK_SHIFT;
+                sd_blk_size_error(sd, blk_size, blk_size_aligned,
+                                  "multiples of 512", errp);
+                return;
+            } else if (!sd_is_emmc(sd) &&
+                !QEMU_IS_ALIGNED(blk_size, 512 * KiB)) {
+                int64_t blk_size_aligned = ((blk_size >> 19) + 1) << 19;
+                sd_blk_size_error(sd, blk_size, blk_size_aligned,
+                                  "multiples of 512K", errp);
+                return;
+            }
+        } else if (blk_size > 0 && !is_power_of_2(blk_size)) {
+            sd_blk_size_error(sd, blk_size, pow2ceil(blk_size), "a power of 2",
+                              errp);
+            return;
+        } else if (blk_size < 0) {
+            error_setg(errp, "eMMC image smaller than boot partitions");
             return;
         }
 
@@ -2810,7 +2837,7 @@ static void sd_realize(DeviceState *dev, Error **errp)
         }
         blk_set_dev_ops(sd->blk, &sd_block_ops, sd);
     }
-    if (sd->boot_part_size % (128 * KiB) ||
+    if (!QEMU_IS_ALIGNED(sd->boot_part_size, 128 * KiB) ||
         sd->boot_part_size > 255 * 128 * KiB) {
         g_autofree char *size_str = size_to_str(sd->boot_part_size);
 
-- 
2.51.0


