Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CB7C3DA40
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5iz-0005nF-67; Fri, 28 Jun 2024 03:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5im-0005FN-12
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:08:37 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5ik-0004Qj-AE
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:08:35 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-363bd55bcc2so170087f8f.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558512; x=1720163312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HkQna1pAjg6GCvSqtEv1yfUmIYCR6WFUzViVX0SSBYo=;
 b=TNcgBl3oDtNMsBpwS1eubTx9jz0uokT7mDPIvho096kmSEdvDGD8CQDTxvHEx9xiQk
 oVPFQhPGxSb8lC2w8Itw7FircD/IOLActUtDdJ4X6toObS0WSh2S5WK6gjuNCtPLVmm0
 zn74+EX2EVFQUxpKTXxP+eD5av5oexcN8UpNSYB1j1AlyVdH7vIYxAm7u8gQ59+gM+/J
 nGiJJqXK0+iRew9FeHciUiXH92KRxdn63kGW7nnoteRRGlJXIRhDJeoxjD6AZfYFBEE6
 6yOzfvi2Zbl3yT7U/QvuFDZYOnEkr1do8f0k6HdR1oYk8C3UzM/nBbyMkm1qc1cI3DXW
 9mvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558512; x=1720163312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HkQna1pAjg6GCvSqtEv1yfUmIYCR6WFUzViVX0SSBYo=;
 b=lmQnT3JfKqlKEn2Ajm7FJ7s86YVjrBkv8g3ngvXM3DydzwcU1WfysXfllJv5K+jdeB
 TrKJ8MxVDFkwAW/3FzZe7tdGrBoEEejV10108BYfbgpx6Gc0yzVnPyZbMGfKSX7Pd+Ri
 vlh+gimXLgh1TnDHB+RaIFG+DpmTy+Dvu+m8JCHzDE7EIkrz+yQAH1Ryq0VyQCskw66c
 cvWy+buU74BUhdJtIRI2ZD7I/8dxzZzncUL/qRGjYqaB0x90rrWK4A2pBbHhcSVxFyBp
 ybdr+U454lk4ftsuTdV8iRhaHk9Z/5/10DJ22ugoJ9aoIb57/g3FRVRwLSiUlIGzqafc
 b8Vw==
X-Gm-Message-State: AOJu0YzX2V7yFtRtLvbcRHRK1XkrcDQjMZ5rfkGYWxZBSFyUDPoE2/W4
 O4ulL9KwdJliAFvZFVFbKD5lHmqKkBHmN5+wZgipii3rJuelyWJ7mhniALHbDVxw+0ApIYtqBZo
 y84I=
X-Google-Smtp-Source: AGHT+IFj2zEb+U0LD4bMyFAtVG/NykMlc/93BH/1stnv5KF9HzLzqN9toJzLyWy/ngQcpSDgTrEoSg==
X-Received: by 2002:a5d:648e:0:b0:367:6440:ea89 with SMTP id
 ffacd0b85a97d-3676440eb88mr425282f8f.65.1719558512601; 
 Fri, 28 Jun 2024 00:08:32 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d90d5sm1343537f8f.31.2024.06.28.00.08.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:08:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 61/98] hw/sd/sdcard: Add sd_cmd_ERASE_WR_BLK_START/END
 handlers (CMD32 & CMD33)
Date: Fri, 28 Jun 2024 09:01:37 +0200
Message-ID: <20240628070216.92609-62-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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


