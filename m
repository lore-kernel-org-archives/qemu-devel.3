Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A9FCAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 13:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvxzI-00010k-Vr; Tue, 09 Sep 2025 09:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-20250909125100548c0e3bfb00020785-A2IZY3@rts-flowmailer.siemens.com>)
 id 1uvxyP-0000OT-Bp
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:01:34 -0400
Received: from mta-64-228.siemens.flowmailer.net ([185.136.64.228])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-20250909125100548c0e3bfb00020785-A2IZY3@rts-flowmailer.siemens.com>)
 id 1uvxyG-0003pg-Lh
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:01:24 -0400
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20250909125100548c0e3bfb00020785 for <qemu-devel@nongnu.org>;
 Tue, 09 Sep 2025 14:51:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=kliDhElVMfZaRHJVGqrzcFIpPd+7cusPCd8jbt9glxA=;
 b=t5l5hlFxNKF45hlWyR2nOZij0McUCii44XK+ECzCq+upOIXxKYh4/en5Y0/u5JmH3NwadE
 bYL6nMFlWJ2dYmbmRp8lVDBUbTeqYUyx1uF2ThLsSga9MDwWme531sDK6d/MUw1OZNJUdLu8
 bjxRnJW0Yw8/V6uhUL+DfQJMevAgqEvoPFnCYW6rqkPUq9Y94FYTLK2R8jAiICsrfkpKH4H2
 nAKuK0IWn4F4tbx/Jr5oHMMaFVEY+n+e3b63ukOR+X9usdD09IeC8VMlQJiR2AINW+Rf9+/I
 k5YU/hng2mgwlju4LQOw/xb/vyTJZYRNUCkp4bkQp3WReQx/rTSfUuwQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Jan=20L=C3=BCbbe?= <jlu@pengutronix.de>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH v3 1/6] hw/sd/sdcard: Fix size check for backing block image
Date: Tue,  9 Sep 2025 14:50:51 +0200
Message-ID: <8fa0fa4158dc2e62edb59d5af8fa54a41e50e306.1757422256.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1757422256.git.jan.kiszka@siemens.com>
References: <cover.1757422256.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass client-ip=185.136.64.228;
 envelope-from=fm-294854-20250909125100548c0e3bfb00020785-A2IZY3@rts-flowmailer.siemens.com;
 helo=mta-64-228.siemens.flowmailer.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 hw/sd/sd.c | 61 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 19 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d7a496d77c..b42cd01d1f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2759,6 +2759,28 @@ static void sd_instance_finalize(Object *obj)
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
@@ -2781,25 +2803,26 @@ static void sd_realize(DeviceState *dev, Error **errp)
             return;
         }
 
-        blk_size = blk_getlength(sd->blk);
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
+        blk_size = blk_getlength(sd->blk) - sd->boot_part_size * 2;
+        if (blk_size > SDSC_MAX_CAPACITY) {
+            if (sd_is_emmc(sd) && blk_size % (1 << HWBLOCK_SHIFT) != 0) {
+                int64_t blk_size_aligned =
+                    ((blk_size >> HWBLOCK_SHIFT) + 1) << HWBLOCK_SHIFT;
+                sd_blk_size_error(sd, blk_size, blk_size_aligned,
+                                  "multiples of 512", errp);
+                return;
+            } else if (!sd_is_emmc(sd) && blk_size % (512 * KiB)) {
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
 
-- 
2.51.0


