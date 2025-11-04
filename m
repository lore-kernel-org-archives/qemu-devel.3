Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1648CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 17:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGL9F-0004Kr-CZ; Tue, 04 Nov 2025 12:48:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGL92-0004Iv-PZ
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:48:38 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGL8z-0005ia-Ju
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:48:36 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-640a0812658so2833751a12.0
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 09:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762278511; x=1762883311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6MvoNhO2a1p+1DZ/73vKddsN0uJ0hFh1RW/xrJuC5yo=;
 b=FfoaIMRNEJsrx1EJu6AV191DG4TW0fuzWWSiwJOTfcVXgw+34hcAqTXMCmMV5GvHI+
 RNZ8if1E05mHNdaJ9PhJjtz2w62a0sTCWGdXj3pFimaLHIBx8fVTrRT4fHp/JP1McGKy
 43uIzNtpFfsahweOiDRkC5nNe//QfNm9sen+N46hNgF+8E4d+ta8t2XMzoTKZ/rFKE0d
 IhMpF4x1GUg3x5Ag2jb/YZ9Y6RfM97QQOx5/V+EQnqhHW0gFL80l+YVobgOYk5kygCYs
 xl3iunmzKEY9HdTIKzkskmBpAHQzJudiLZbLgngQJMdy8S+DiGHjag+ZhWrG/37rbkPz
 Xnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762278511; x=1762883311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6MvoNhO2a1p+1DZ/73vKddsN0uJ0hFh1RW/xrJuC5yo=;
 b=Mj33M8tJdBE6MyDP4JcPF0OsWoCxo68uDWigWULY/reeMf9npSpesPU6GcIlDBWr5X
 EjNrgL38zxorB8sNVNgCc/uhJ+wmjyjU5jX/hTZ4/MUFIr4UKHWmG/uicbLsA6flhLtX
 3mFDpNyfD+sUxu4NtnTR2A30QubEEBxLhXFWrXuQVEhW5fwZEL2vEtSVWr+1XLUIuOck
 Bfy3lp3mEy9fu8lPqgbUyX9TQoIMw5z7wUbPvnnGc5tirQwYaz9FJNocLTCFeGlMpRli
 sp+5EKCcrneR/w9A0Feaz+qsEAwY2FLSKlRWgLvN0wHzBqUXYNwoimDp/C26QZtIwhpl
 Z+Gw==
X-Gm-Message-State: AOJu0Yz/j8p6H6UTQXici8h0PyXnewzzAY7RyQ9jtecNbyPTMTu5ZCoJ
 27LMKifRoiGZd+hAL/WePdS7BJwis7xi31GuJkHQdf+jBl+FFj346Nnoqfau/wkVmtpwob4xWhP
 TUBxocSC5Wg==
X-Gm-Gg: ASbGncvf4qTAPDBE52fgS5X9DecEtzDTVRe/z5ELB5dhOdhxLPrJhgmalkrnykA/DBr
 6Akt6n4PWyyxV5bW8nsqAOP/rg/W+JYR43CGPTlJkh70Atjc2TxO+FcM5RZFi750R2qbRqwIMYq
 yzHPLcGjo/vqWUJycwdu8OV5drkSrIyuBqQwfDpfnDB5gf6GjhNUgaZOK8/twyfmTR7Xlf3N+de
 6FBpjJMpoF621rMgg9obiz8DRZJu7t55RLhurwUqMlm4Y6mIedJMyXUzt9MIy/ki6WPJSs7qj0+
 hVYKBVGf2gn+pLLX9Af+Cos6tPA71GXOjL4jZ2v4Vm3fplsykGFzdYmiEDLjpV/cGz8IbvkFW9S
 mXuOsD/eFikU+brjMPyfg/v4SfFmGe9cORlmMhkODWjB4kiDHBobEOuZg1ySFU+XUQV43xs+WwX
 JmnU/74VLKqHvajwUR6ITfAMl6/+wbMJDW
X-Google-Smtp-Source: AGHT+IHb7epuEjqrGSCfuBPFVg7kwU/R9U8BmDOoq8QQaiOWN3TBrnlt9oo/DmvbnAPVXADxVUUEqw==
X-Received: by 2002:a05:6402:1ecf:b0:63c:1066:8bec with SMTP id
 4fb4d7f45d1cf-64105b7a621mr51174a12.35.1762278511372; 
 Tue, 04 Nov 2025 09:48:31 -0800 (PST)
Received: from localhost.localdomain ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e6806d82sm2602219a12.16.2025.11.04.09.48.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Nov 2025 09:48:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/8] hw/sd/sdcard: Fix size check for backing block image
Date: Tue,  4 Nov 2025 18:48:16 +0100
Message-ID: <20251104174823.92412-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104174823.92412-1-philmd@linaro.org>
References: <20251104174823.92412-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-ID: <591f6d8a9dc86428723cb6876df6e717cc41a70e.1762261430.git.jan.kiszka@siemens.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 69 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 21 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d7a496d77c9..76e915e1900 100644
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


