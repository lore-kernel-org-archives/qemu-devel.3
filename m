Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6065CC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5jP-0006Qm-4V; Fri, 28 Jun 2024 03:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5j0-0005rK-1B
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:08:50 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5iv-0004R1-9o
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:08:49 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2e72224c395so2718601fa.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558517; x=1720163317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CoQCzUzxa0YFMI6eXkkGrxD2M8eC5JzJPZMXnDtnM4A=;
 b=zwhWvm//t2eZUI9ihqJ7OKPfEBXpxEIMn9tA3fs1Fx6uDzHxnvVrJDvHinafL2hHEI
 D7yW1jd1Ch1PpUvJfJ7M+qWuJLmI9VHz3u5iRcRsJIz85m9XJPwQJG+VNuDKhDWAQQJl
 UF0oHrVaxKKIWlMSxO4FaqsSiudUR3iH9PL6GxdwBD+N/TafF0LDvULOdvfmFOpbn96i
 pCH+g8WmSFaOAFoSRjdvxkEnSCm5uu3daUDn7uInp7sxhaQ/Xzx+ubxqRiqqEOQshUna
 YpXE38/KtdKYQ9i4e3dK4IGC1pQ22y2x1o5ZSME7bk98X3Ad5weFZjcRs8RqVBV/4C3A
 Pl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558517; x=1720163317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CoQCzUzxa0YFMI6eXkkGrxD2M8eC5JzJPZMXnDtnM4A=;
 b=POUE0bWi3tfAT9Mn/cPWKHWStxyDMXRfyH+iAdVvQMkVYk1qL2wPJMOT1xRpd64tVB
 J9rvP6I/omr8l8r1gv1wH+zYh/BWC3XgxTj+Q8cDDTrkI+D6ZkYOtUaB3NPpVYgLQeqx
 AyZ6fb6eI3+5RlmwNvvL52rePFYAJYHb3rwBzp5DsEmFcnluwqGzGBNN1l8Y6Y2WVyiV
 YM/n4LuAVI/Xbce0M+uUYS+e/eekXtbF/1A5L1KbGjn5VX66Oblf6yyvzi7zm8SNMmjn
 vy+bXzNn/d/8rKcxcvpS/JYly9v3IQzRhUjX3xLmtEF8ztT6ge4Pxuj7n0tKFz0P3aRM
 KDYg==
X-Gm-Message-State: AOJu0YwuEhh10duwozMmXv3QPm9BGu7Qh4vBhbsVuQzKblhpRJlgtA+R
 Ae5CidOJkSs1+oOrP9dgKoATEaeEi7oBhHL16pn9CgiG8lo8eDDcTrYs50Tqh/QigwSFgyx7g/A
 QqpA=
X-Google-Smtp-Source: AGHT+IHtXdwMs4lYs5l7DNNB3CVtLUUDKEe0EuQU2pe47cHKSzeBu9RjK9MZF/9ZTxJ9kXPyAqkW7Q==
X-Received: by 2002:a05:651c:1a2a:b0:2ee:4dc6:fe28 with SMTP id
 38308e7fff4ca-2ee4dc70179mr23313811fa.40.1719558517642; 
 Fri, 28 Jun 2024 00:08:37 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af55d0fsm21566625e9.19.2024.06.28.00.08.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:08:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 62/98] hw/sd/sdcard: Add sd_cmd_ERASE handler (CMD38)
Date: Fri, 28 Jun 2024 09:01:38 +0200
Message-ID: <20240628070216.92609-63-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 4e31dfe18f..17fec612eb 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -244,7 +244,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
                                             [21]    = "DPS_spec",
                                             [25]    = "WRITE_MULTIPLE_BLOCK",
         [26]    = "MANUF_RSVD",
-        [38]    = "ERASE",
         [40]    = "DPS_spec",
         [42]    = "LOCK_UNLOCK",
         [54]    = "SDIO_RSVD",              [55]    = "APP_CMD",
@@ -1602,6 +1601,24 @@ static sd_rsp_type_t sd_cmd_ERASE_WR_BLK_END(SDState *sd, SDRequest req)
     return sd_r1;
 }
 
+/* CMD38 */
+static sd_rsp_type_t sd_cmd_ERASE(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+    if (sd->csd[14] & 0x30) {
+        sd->card_status |= WP_VIOLATION;
+        return sd_r1b;
+    }
+
+    sd->state = sd_programming_state;
+    sd_erase(sd);
+    /* Bzzzzzzztt .... Operation complete.  */
+    sd->state = sd_transfer_state;
+    return sd_r1b;
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint16_t rca;
@@ -1690,26 +1707,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 26:  /* CMD26:  PROGRAM_CID */
         return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
 
-    /* Erase commands (Class 5) */
-    case 38:  /* CMD38:  ERASE */
-        switch (sd->state) {
-        case sd_transfer_state:
-            if (sd->csd[14] & 0x30) {
-                sd->card_status |= WP_VIOLATION;
-                return sd_r1b;
-            }
-
-            sd->state = sd_programming_state;
-            sd_erase(sd);
-            /* Bzzzzzzztt .... Operation complete.  */
-            sd->state = sd_transfer_state;
-            return sd_r1b;
-
-        default:
-            break;
-        }
-        break;
-
     /* Lock card commands (Class 7) */
     case 42:  /* CMD42:  LOCK_UNLOCK */
         return sd_cmd_to_receivingdata(sd, req, 0, 0);
@@ -2318,6 +2315,7 @@ static const SDProto sd_proto_spi = {
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
         [37] = {10, sd_spi, "CONTROL_ASSD_SYSTEM", sd_cmd_optional},
+        [38] = {5,  sd_spi, "ERASE", sd_cmd_ERASE},
         [50] = {10, sd_spi, "DIRECT_SECURE_READ", sd_cmd_optional},
         [52] = {9,  sd_spi, "IO_RW_DIRECT", sd_cmd_optional},
         [53] = {9,  sd_spi, "IO_RW_EXTENDED", sd_cmd_optional},
@@ -2361,6 +2359,7 @@ static const SDProto sd_proto_sd = {
         [35] = {10, sd_adtc, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_adtc, "SEND_PSI", sd_cmd_optional},
         [37] = {10, sd_ac,   "CONTROL_ASSD_SYSTEM", sd_cmd_optional},
+        [38] = {5,  sd_ac,   "ERASE", sd_cmd_ERASE},
         [43] = {1,  sd_ac,   "Q_MANAGEMENT", sd_cmd_optional},
         [44] = {1,  sd_ac,   "Q_TASK_INFO_A", sd_cmd_optional},
         [45] = {1,  sd_ac,   "Q_TASK_INFO_B", sd_cmd_optional},
-- 
2.41.0


