Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44052C30653
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsHr-0007G0-Pl; Thu, 27 Jun 2024 12:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsGO-00061T-7k
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:46:28 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsGI-0000RJ-W7
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:46:23 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-36701e6c6e8so1795920f8f.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506777; x=1720111577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HkQna1pAjg6GCvSqtEv1yfUmIYCR6WFUzViVX0SSBYo=;
 b=SUkdSze/CirXXV1UgrDF4D/BMSRnbyu2vFRwIjx7C2RUNnsei6CesSMVz0fNIk6DeE
 shQ5N5W8eSt5C19VDhPbntgXcivY4Seos9Qe0XCTCOopiQXJJ98IkJTxU7MDfMVZ5tWX
 qCExT06w8KXYb3tWCfbm5aTDMlJM0UT1YxPUqgWS4/EXEWyT917QprEmcWd6fxV0/Xam
 +okRqmcGGVeAdhYdbdYM65WUh11eiUktf7zRLR32hQbWS6L5UkiBFDJmTnmapRkl4IN+
 fjXPW08h1KJeFb/EJo7qjgE/c7zrp8/ONXC2Z8qLs5XCIHoD3hBfwEwLYL0XwbKV8ECS
 HR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506777; x=1720111577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HkQna1pAjg6GCvSqtEv1yfUmIYCR6WFUzViVX0SSBYo=;
 b=uSNAcfpErzf9+K0aEudT0xcba5FfevToLJUr3uqVDvMztxPxWu1m6JIJ0sAhj6gxKI
 w6cpeD2snBIzITTo2U+p6MIDrypY8HEuueLS2QAFb8q5IM6FOZ6K+pNQBmkKS3oXacIo
 Iw6q6G2053KcyaBbtLfDEB4+TjW9cFiCaQIAXSUo39oQ6YUN67UDPmh2HGgzd7V31IA0
 JtWVxCTyz1W8e60mzXmdKXybbxA7NF4VIn9H+VxnCc1m5ESvJwhotS9trGcPXYDercN6
 56jHNS8/D/XAztZk510zBK4LVgWf0aFXfDb40RFCEZC8KeGL2dmHCjTrUhH0yt4Uj98h
 H7tQ==
X-Gm-Message-State: AOJu0Yyopc6spSEL7XpFnl1XhWnPeesnu/HsC86n/3KjkB7GTE56s1ow
 FETM7yAEHh7ar+B6kGgzi8Q0FgEjveqLcuT9h95/6c3Eo/9oUFrGlhbenIFYhSAyr+CdPvHe93r
 khuE=
X-Google-Smtp-Source: AGHT+IE0HWcXaJLgbKu8us/Sc81KYVyEoD+Qm0sHvrpgwCpCRYfn+UVMR1MtpTH+LyTCl9ZWWOAl1Q==
X-Received: by 2002:a05:6000:184f:b0:366:ee84:6a79 with SMTP id
 ffacd0b85a97d-366ee846c15mr12701374f8f.51.1719506777014; 
 Thu, 27 Jun 2024 09:46:17 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357fdcasm2427191f8f.36.2024.06.27.09.46.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:46:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 15/21] hw/sd/sdcard: Add sd_cmd_ERASE_WR_BLK_START/END
 handlers (CMD32 & CMD33)
Date: Thu, 27 Jun 2024 18:43:38 +0200
Message-ID: <20240627164345.82192-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164345.82192-1-philmd@linaro.org>
References: <20240627164345.82192-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 47 ++++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index bf9975e9b1..4e31dfe18f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -244,7 +244,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
                                             [21]    = "DPS_spec",
                                             [25]    = "WRITE_MULTIPLE_BLOCK",
         [26]    = "MANUF_RSVD",
-        [32]    = "ERASE_WR_BLK_START",     [33]    = "ERASE_WR_BLK_END",
         [38]    = "ERASE",
         [40]    = "DPS_spec",
         [42]    = "LOCK_UNLOCK",
@@ -1583,6 +1582,26 @@ static sd_rsp_type_t sd_cmd_SEND_WRITE_PROT(SDState *sd, SDRequest req)
     return sd_cmd_to_sendingdata(sd, req, addr, &data, sizeof(data));
 }
 
+/* CMD32 */
+static sd_rsp_type_t sd_cmd_ERASE_WR_BLK_START(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+    sd->erase_start = req.arg;
+    return sd_r1;
+}
+
+/* CMD33 */
+static sd_rsp_type_t sd_cmd_ERASE_WR_BLK_END(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+    sd->erase_end = req.arg;
+    return sd_r1;
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint16_t rca;
@@ -1672,28 +1691,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
 
     /* Erase commands (Class 5) */
-    case 32:  /* CMD32:  ERASE_WR_BLK_START */
-        switch (sd->state) {
-        case sd_transfer_state:
-            sd->erase_start = req.arg;
-            return sd_r1;
-
-        default:
-            break;
-        }
-        break;
-
-    case 33:  /* CMD33:  ERASE_WR_BLK_END */
-        switch (sd->state) {
-        case sd_transfer_state:
-            sd->erase_end = req.arg;
-            return sd_r1;
-
-        default:
-            break;
-        }
-        break;
-
     case 38:  /* CMD38:  ERASE */
         switch (sd->state) {
         case sd_transfer_state:
@@ -2315,6 +2312,8 @@ static const SDProto sd_proto_spi = {
         [28] = {6,  sd_spi, "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
         [29] = {6,  sd_spi, "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
         [30] = {6,  sd_spi, "SEND_WRITE_PROT", sd_cmd_SEND_WRITE_PROT},
+        [32] = {5,  sd_spi, "ERASE_WR_BLK_START", sd_cmd_ERASE_WR_BLK_START},
+        [33] = {5,  sd_spi, "ERASE_WR_BLK_END", sd_cmd_ERASE_WR_BLK_END},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
@@ -2356,6 +2355,8 @@ static const SDProto sd_proto_sd = {
         [28] = {6,  sd_ac,   "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
         [29] = {6,  sd_ac,   "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
         [30] = {6,  sd_adtc, "SEND_WRITE_PROT", sd_cmd_SEND_WRITE_PROT},
+        [32] = {5,  sd_ac,   "ERASE_WR_BLK_START", sd_cmd_ERASE_WR_BLK_START},
+        [33] = {5,  sd_ac,   "ERASE_WR_BLK_END", sd_cmd_ERASE_WR_BLK_END},
         [34] = {10, sd_adtc, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_adtc, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_adtc, "SEND_PSI", sd_cmd_optional},
-- 
2.41.0


