Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE74D3A661
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5ntd-0002LD-1l; Tue, 29 Oct 2024 11:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5ns3-0000co-4i
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:11:02 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5nry-0007g5-Il
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:10:58 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-539e3f35268so6622067e87.3
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730214652; x=1730819452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Mn+Xz1D2FUsiusPJC2SlclU8g8noCDEQAV1urES3kd8=;
 b=b0t7fMnrjPZLilMjagCrX7NXp/LoXisyj7cHNlIemC0xsxuZkF7QssSdhtRz4vxxzD
 lyByXm2wji+WmrNaezmt8GXrAEIgmGoJ0i7kfkLM414AS/o927B00d8DTIb5jsOHf8k7
 IJKemtcRCQYPnTO2hJ1SN+ZjyT7bsfZ4ls1z4rY+Mn28HRHXPRgNtLLdg0IoVHLgvejS
 JiQVi3PZ7ATCyMG57sr2JD6ukfsP00ttJ7yKLFXS42X0EuNTRaawB8OKxYh2eO/zt4wz
 ulyKponb8SF0lxyEdMi0aFA6UF5aFTn3lYDKZRtZdvL3qcGdj+CyqvnQokJ3WfMOz/7r
 IXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730214652; x=1730819452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mn+Xz1D2FUsiusPJC2SlclU8g8noCDEQAV1urES3kd8=;
 b=o5Nr6OC/LFPsFuyvMsOUEOXAz3NgozmGoUJuqSTzwAAucFK0ZppifZLA25R7Du3P/7
 FF1VwOvabXSaKV+DUFOGvqtCvoCT9HEWykqK6H4skVE2wzTKMSw218TDOA8nbwQDnvdF
 zdNOaA41m3Tg01az0AjY6ekfM67BHd3CAHlPaIFoNBVrD/lGftYnO/sE1uZbSr2CvE2l
 OGXc2Q16bU8bF2whCDKsaKX2tLR2ZPfSs3SHc1jncxSYMVxZtkyu63dyQ8zz7eZX/9wW
 iExb4yKl4prZc5YrmW7O8gvRd33VWC46sCTdpO+9soVnru/6qr/Q1G+KXmXLkammhDhr
 ko/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFCuuw8QzzaivDG730nt6pLQDXTQTLmTR9mdYB06/pp7Xk8OyurpsyqCVBXLS8J+omuacONjtINdYX@nongnu.org
X-Gm-Message-State: AOJu0YxdwAk+AFx9iy2edOJ3oAhVCxAGd7E6NjF/zgrzZ//gba8HGxwP
 X3TOMRn1Hnc6F8GtFGwPFvdOvQb8Ng/eWyHgJF20MS6UYNy6jfRaC2ymS2qhV1vsf0NcWOzBRF+
 D
X-Google-Smtp-Source: AGHT+IGXO0iltyo3erh/VaUsX0EJDZ/rcXUTJr4OuDTd9mF6DRjJjStH2en8PBpe9ZPzi6rVSN7gMQ==
X-Received: by 2002:a05:6512:398d:b0:535:68ab:7fdd with SMTP id
 2adb3069b0e04-53b348ceb33mr6201931e87.19.1730214652423; 
 Tue, 29 Oct 2024 08:10:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4319360cc2esm146835865e9.44.2024.10.29.08.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 08:10:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PULL 05/18] hw/sd/omap_mmc: Don't use sd_cmd_type_t
Date: Tue, 29 Oct 2024 15:10:35 +0000
Message-Id: <20241029151048.1047247-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029151048.1047247-1-peter.maydell@linaro.org>
References: <20241029151048.1047247-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In commit 1ab08790bb75e4 we did some refactoring of the SD card
implementation, which included a rearrangement of the sd_cmd_type_t
enum values.  Unfortunately we didn't notice that this enum is not
used solely inside the SD card model itself, but is also used by the
OMAP MMC controller device.  In the OMAP MMC controller, it is used
to implement the handling of the Type field of the MMC_CMD register,
so changing the enum values so that they no longer lined up with the
bit definitions for that register field broke the controller model.
The effect is that Linux fails to boot from an SD card on the "sx1"
machine.

Give omap-mmc its own enum which we can document as needing to match
the encoding used in this device's register, so it isn't sharing
sd_cmd_type_t with the SD card model any more.  We can then move
sd_cmd_type_t's definition out of sd.h and into sd.c, which is the
only place that uses it.

Cc: qemu-stable@nongnu.org
Fixes: 1ab08790bb75 ("hw/sd/sdcard: Store command type in SDProto")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241017162755.710698-1-peter.maydell@linaro.org
---
 include/hw/sd/sd.h |  8 --------
 hw/sd/omap_mmc.c   | 22 ++++++++++++++++------
 hw/sd/sd.c         |  8 ++++++++
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index d35a839f5ef..f2458f37b3c 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -75,14 +75,6 @@ typedef enum  {
     UHS_III             = 3,    /* currently not supported */
 } sd_uhs_mode_t;
 
-typedef enum {
-    sd_spi,
-    sd_bc,     /* broadcast -- no response */
-    sd_bcr,    /* broadcast with response */
-    sd_ac,     /* addressed -- no data transfer */
-    sd_adtc,   /* addressed with data transfer */
-} sd_cmd_type_t;
-
 typedef struct {
     uint8_t cmd;
     uint32_t arg;
diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index 91e9a3f1c6a..1d4e30e6b7b 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -103,6 +103,7 @@ static void omap_mmc_fifolevel_update(struct omap_mmc_s *host)
     }
 }
 
+/* These must match the encoding of the MMC_CMD Response field */
 typedef enum {
     sd_nore = 0,	/* no response */
     sd_r1,		/* normal response command */
@@ -112,8 +113,17 @@ typedef enum {
     sd_r1b = -1,
 } sd_rsp_type_t;
 
+/* These must match the encoding of the MMC_CMD Type field */
+typedef enum {
+    SD_TYPE_BC = 0,     /* broadcast -- no response */
+    SD_TYPE_BCR = 1,    /* broadcast with response */
+    SD_TYPE_AC = 2,     /* addressed -- no data transfer */
+    SD_TYPE_ADTC = 3,   /* addressed with data transfer */
+} MMCCmdType;
+
 static void omap_mmc_command(struct omap_mmc_s *host, int cmd, int dir,
-                sd_cmd_type_t type, int busy, sd_rsp_type_t resptype, int init)
+                             MMCCmdType type, int busy,
+                             sd_rsp_type_t resptype, int init)
 {
     uint32_t rspstatus, mask;
     int rsplen, timeout;
@@ -128,7 +138,7 @@ static void omap_mmc_command(struct omap_mmc_s *host, int cmd, int dir,
     if (resptype == sd_r1 && busy)
         resptype = sd_r1b;
 
-    if (type == sd_adtc) {
+    if (type == SD_TYPE_ADTC) {
         host->fifo_start = 0;
         host->fifo_len = 0;
         host->transfer = 1;
@@ -433,10 +443,10 @@ static void omap_mmc_write(void *opaque, hwaddr offset,
         for (i = 0; i < 8; i ++)
             s->rsp[i] = 0x0000;
         omap_mmc_command(s, value & 63, (value >> 15) & 1,
-                (sd_cmd_type_t) ((value >> 12) & 3),
-                (value >> 11) & 1,
-                (sd_rsp_type_t) ((value >> 8) & 7),
-                (value >> 7) & 1);
+                         (MMCCmdType)((value >> 12) & 3),
+                         (value >> 11) & 1,
+                         (sd_rsp_type_t) ((value >> 8) & 7),
+                         (value >> 7) & 1);
         omap_mmc_update(s);
         break;
 
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a5d2d929a8a..b2e2d58e013 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -71,6 +71,14 @@ typedef enum {
     sd_illegal = -2,
 } sd_rsp_type_t;
 
+typedef enum {
+    sd_spi,
+    sd_bc,     /* broadcast -- no response */
+    sd_bcr,    /* broadcast with response */
+    sd_ac,     /* addressed -- no data transfer */
+    sd_adtc,   /* addressed with data transfer */
+} sd_cmd_type_t;
+
 enum SDCardModes {
     sd_inactive,
     sd_card_identification_mode,
-- 
2.34.1


