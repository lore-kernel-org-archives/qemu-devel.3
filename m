Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF9EC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5iS-0003ib-Av; Fri, 28 Jun 2024 03:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5iJ-0003VY-D1
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:08:07 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5iG-0003fI-JP
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:08:06 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52ce6a9fd5cso265548e87.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558481; x=1720163281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/x47xZoGwEv6OAz6MBmyY9zpVBzbWRJPcmwD+bMVYlw=;
 b=sa1JGniaYicBLzcik/xnkD/uQGKIq1omdDeL1GJXblgsrJ3qgRE2RalbUsFOqgnTVm
 caQPRxfkXogr+rAlV4KPuC5xoWhidev89536ffebAtF3efnK9HoNNPXNQdtoZ191NkXw
 hRWns0bLi4LpagK+jehz1QfLq5jI/6gUT1sXuaw7Rq8YeycKzuGv1xRRLPB7C52QRilr
 hblir5XPJPzpYcBRGYPKbm7w0SXZuMfSV9EBEv0rBsgt5rqOz3YmBJmEr0gf2IJR1+Rj
 TFF87ReYnJdvW5FSiYUf7GnUfeFW13uUoSqUsZihmohNm9nehpaglHsoRQ6ydkDmaKwh
 sFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558481; x=1720163281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/x47xZoGwEv6OAz6MBmyY9zpVBzbWRJPcmwD+bMVYlw=;
 b=eiAaTusgzE3kDAF0iEQpH2Sj1rz2A5gFuLP8PB5LKt+JscoTjehlFbZDvYCSpy/KWQ
 r8vVQnRy04DkHuDSDmTiyesWK3MTr0RGmu16ksl1DHDBEvospnsUIX4vlaJGCedRzY9e
 80EGNNhJSPJyusol5vMK3I/6NHklDwDzGGfbrVvWW4c4KQCpozbGGUirItwdUG6ftFC2
 OFh4PBuOSoO+Z1u3iIny7s2AV8RT0J0zFtkXXyOIqp90AoggODcNtSWNf6ZUl2FqvM4A
 vuBDSR6JdM9YprNBv1Srlpz5ydMgwqJRvfTKvzdTf0rZqcUPnIqzrLMFMbsNUB7Jwz3n
 1ufA==
X-Gm-Message-State: AOJu0YzoybJynZeNy/E4YNQ+wSWRDQKAW2fVc2sxyslhqrdDT2u34Mnv
 gVBs0OsxQkAhxZHsqxte9dQ2ZhWDEg3BMhGVpg3et57Y6TgLv3h9Q0vB8igNTcaJgjQ2fu2eWNX
 S21Y=
X-Google-Smtp-Source: AGHT+IHIffP3eoDK3lp+Dsk1EVAr7+ayiVMUPIvMaNU+oG2qF71kpRxETFsxr3lXcr12NedK+Ixwlg==
X-Received: by 2002:a19:6b03:0:b0:52c:8339:d09b with SMTP id
 2adb3069b0e04-52ce18327b5mr9879299e87.1.1719558481672; 
 Fri, 28 Jun 2024 00:08:01 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd778sm1355702f8f.5.2024.06.28.00.08.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:08:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 55/98] hw/sd/sdcard: Add sd_cmd_SET_BLOCKLEN handler
 (CMD16)
Date: Fri, 28 Jun 2024 09:01:31 +0200
Message-ID: <20240628070216.92609-56-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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
 hw/sd/sd.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d7ed8aee73..d731c3df58 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -240,7 +240,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
 static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-        [16]    = "SET_BLOCKLEN",           [17]    = "READ_SINGLE_BLOCK",
+                                            [17]    = "READ_SINGLE_BLOCK",
         [18]    = "READ_MULTIPLE_BLOCK",
                                             [21]    = "DPS_spec",
         [24]    = "WRITE_BLOCK",            [25]    = "WRITE_MULTIPLE_BLOCK",
@@ -1425,6 +1425,22 @@ static sd_rsp_type_t sd_cmd_GO_INACTIVE_STATE(SDState *sd, SDRequest req)
     return sd_r0;
 }
 
+/* CMD16 */
+static sd_rsp_type_t sd_cmd_SET_BLOCKLEN(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+    if (req.arg > (1 << HWBLOCK_SHIFT)) {
+        sd->card_status |= BLOCK_LEN_ERROR;
+    } else {
+        trace_sdcard_set_blocklen(req.arg);
+        sd->blk_len = req.arg;
+    }
+
+    return sd_r1;
+}
+
 /* CMD19 */
 static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
 {
@@ -1491,23 +1507,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     switch (req.cmd) {
     /* Block read commands (Class 2) */
-    case 16:  /* CMD16:  SET_BLOCKLEN */
-        switch (sd->state) {
-        case sd_transfer_state:
-            if (req.arg > (1 << HWBLOCK_SHIFT)) {
-                sd->card_status |= BLOCK_LEN_ERROR;
-            } else {
-                trace_sdcard_set_blocklen(req.arg);
-                sd->blk_len = req.arg;
-            }
-
-            return sd_r1;
-
-        default:
-            break;
-        }
-        break;
-
     case 17:  /* CMD17:  READ_SINGLE_BLOCK */
         addr = sd_req_get_address(sd, req);
         switch (sd->state) {
@@ -2306,6 +2305,7 @@ static const SDProto sd_proto_spi = {
         [10] = {0,  sd_spi, "SEND_CID", spi_cmd_SEND_CID},
         [12] = {0,  sd_spi, "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
         [13] = {0,  sd_spi, "SEND_STATUS", sd_cmd_SEND_STATUS},
+        [16] = {2,  sd_spi, "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
@@ -2337,6 +2337,7 @@ static const SDProto sd_proto_sd = {
         [12] = {0,  sd_ac,   "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
         [13] = {0,  sd_ac,   "SEND_STATUS", sd_cmd_SEND_STATUS},
         [15] = {0,  sd_ac,   "GO_INACTIVE_STATE", sd_cmd_GO_INACTIVE_STATE},
+        [16] = {2,  sd_ac,   "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
-- 
2.41.0


