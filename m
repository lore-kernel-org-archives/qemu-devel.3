Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4BEC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZmM-0002Gj-Ck; Tue, 02 Jul 2024 05:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZmK-0001we-8m
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:26:24 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZmG-0001O5-7q
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:26:23 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52ce6c8db7bso5943074e87.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912378; x=1720517178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VWCogmQ5YMxblD7fAdd5ouQjKmXVnhB0D5NSysNvar4=;
 b=RIezjv6RM1IZqEjzuCMphhg/sy+W2SOU1yWGDabTf8XrDUa2RPsdnIBrkLJOSfwxD1
 MMqJiMUfr1N3AlSjlbn6BIPk7FnI0QZ5g48u5IY7YR0WPKUh3ur/fDwvFlzK2HpH++OE
 WypMMXyYq9G1yA8C0X3FzAfAYW79QecBTzFbvJsCfihk8wufWgrsdE3WbHYnR4CqF9GJ
 S66tZz3Lk5OQcgdsaq+fX/6gZPWLJnUbUVjEfaWoX4r/zUqntsK//xqT7Evo6NkgsfnQ
 0JIlY1sapYrVKIJWLCUvX+gQwRC6a9vPIL2SuM1HbMHPXersTCzTajhl8ic8d1rqIH52
 RByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912378; x=1720517178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VWCogmQ5YMxblD7fAdd5ouQjKmXVnhB0D5NSysNvar4=;
 b=nv4sWFYs9XJiwHftNBVKDVYIYKkZL5ZEBgCD1AeC9nJ/GJYYsPofgs3555t9z15sNb
 fMS8MO/Yc4G4kj0yzC4+9N0AwI6HGyXpidqedopDIUOXPJpbm0bcZ8NJ3QWKY3qlntFT
 9n2xBuKFMZGVIFp9/xCWJM2a3CkF8jWzT+inXaoym4bAxzlE3oH3LF4LwXin44BPtN1r
 wP3ygPswlX8d6Ih0fLaFimUyg770QNgxs5Z8+h1hsU68ljJFDM544RDcki+eY5zleLx9
 xsGbkxoeWgBJXLl19s+U/kDdFoH07yFTSum+evJghm475r4w76RJJ9FLTB2i8j3TijtC
 7S/g==
X-Gm-Message-State: AOJu0YyNvQ80u04Pwpa0rLNVahjByPbIoT/IJiWsZLO+EKVkTcdb8lv6
 J+esn1SL0pBImRMCkV77RbPNf/wsqtei49mL0o4YODJRdoFw/1VM6UM71Bmsrp9MwSxYt8vJSU6
 j
X-Google-Smtp-Source: AGHT+IFvsQ9ePYgRzx/8fGAtfF/c/Ts5j5G5g6hHzxPKixkFgeq0OgRfAt55wxEw+h7YTDZWCS2tDg==
X-Received: by 2002:a05:6512:3e28:b0:52c:d905:9645 with SMTP id
 2adb3069b0e04-52e8265184bmr6522600e87.13.1719912378233; 
 Tue, 02 Jul 2024 02:26:18 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09abbfsm189020845e9.35.2024.07.02.02.26.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:26:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 55/67] hw/sd/sdcard: Add sd_cmd_ERASE_WR_BLK_START/END handlers
 (CMD32 & CMD33)
Date: Tue,  2 Jul 2024 11:20:38 +0200
Message-ID: <20240702092051.45754-56-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-62-philmd@linaro.org>
---
 hw/sd/sd.c | 47 ++++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b205cc4692..d517a00ee1 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -241,7 +241,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
                                             [21]    = "DPS_spec",
                                             [25]    = "WRITE_MULTIPLE_BLOCK",
         [26]    = "MANUF_RSVD",
-        [32]    = "ERASE_WR_BLK_START",     [33]    = "ERASE_WR_BLK_END",
         [38]    = "ERASE",
         [40]    = "DPS_spec",
         [42]    = "LOCK_UNLOCK",
@@ -1575,6 +1574,26 @@ static sd_rsp_type_t sd_cmd_SEND_WRITE_PROT(SDState *sd, SDRequest req)
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
@@ -1664,28 +1683,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
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
@@ -2317,6 +2314,8 @@ static const SDProto sd_proto_spi = {
         [28] = {6,  sd_spi, "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
         [29] = {6,  sd_spi, "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
         [30] = {6,  sd_spi, "SEND_WRITE_PROT", sd_cmd_SEND_WRITE_PROT},
+        [32] = {5,  sd_spi, "ERASE_WR_BLK_START", sd_cmd_ERASE_WR_BLK_START},
+        [33] = {5,  sd_spi, "ERASE_WR_BLK_END", sd_cmd_ERASE_WR_BLK_END},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
@@ -2358,6 +2357,8 @@ static const SDProto sd_proto_sd = {
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


