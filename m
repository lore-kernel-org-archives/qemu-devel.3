Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C6FC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZmZ-0002mL-Ic; Tue, 02 Jul 2024 05:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZmS-0002fa-Di
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:26:32 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZmM-0001Y4-3k
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:26:32 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3629c517da9so3146224f8f.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912384; x=1720517184; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d8cKKzD5TFUU9UNeYz0boxlMOoI7h2YEt8SrgZwBqHs=;
 b=mIyh20g+FjycBxtYzV25SgsuJyyUizYxWwoQgUuboFxjNIQtM5vCsbzlxIKRryEXn0
 qflbsMNwJowFBXrjhj9ssXMdVMGcb2JxZYnPmeh2xDGudqUp/Z9VKytHrOEaVk69lris
 AbmgF6idxRYV7s/UAI8m+qbYV65T1WLRXvDZBFv3uXRWxliQKA2TyRanMatCTB02SBbt
 7JZZHRoWeXSS/BfKsaGNuggQt2O5KMpTarW2Vq9SjLP0YPEhmkTS3AwNXISD0mZMf+Wb
 1/Kf1H/1uQnJwWXTbdj44ikQgpwDZJXpR4+IKsy2a17upv1j89rM71x2xGGfVmQ9JGKC
 fMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912384; x=1720517184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d8cKKzD5TFUU9UNeYz0boxlMOoI7h2YEt8SrgZwBqHs=;
 b=uu43o2uweK07hIm3dwthKLFqq12otQxNdvOGtlKtSO9TzhesTCIbnq1hBGjCmGlvSw
 wI4ZLO00UaB2hgDLxSJCN23O9onvZiZ5L8/6KF1gHjFD8IYvwQowrvMeK/mNoVWO7jzY
 13aEi3d5NQfPzA9DloxQ0Tn1O2OJActTcYmzTZN0DOVB/29hgBguUmfU9Bhc3IQ39Eg3
 HbfB/Dy6C0zbsi0gcfuNsT1bhjRf7+YMQH2xI+Lrh7C6/MMYQiwlrPKQSw1L9+C0Uf85
 JE4AYuZoqpvNV3iaQ06DISNw0XGd49Qjxw3Zr0jj8/Yz7w2+aK0uXFlqJYMrJNHcvdln
 xVHg==
X-Gm-Message-State: AOJu0YyJkjR4JsnFdW/l7kXFnsil6oxYAiCDJJMv0LpX2crYkxQdLe50
 TAiX4lnIOIued0WhK3M7NY/PN3UNQP25iLsD9E3GbvRsL0gqBNiIvFaa2rZDvouCyJt+v6QnnZQ
 J
X-Google-Smtp-Source: AGHT+IHQCXCLm6iVwJjCjW28T5HdPbdEHl5LVQbFLqH/aMEOWZYDGxZ0QBLQGT0/s5uO7plaF1geqQ==
X-Received: by 2002:a5d:648f:0:b0:366:efbd:8aa3 with SMTP id
 ffacd0b85a97d-36775699521mr7233401f8f.2.1719912384073; 
 Tue, 02 Jul 2024 02:26:24 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fb92fsm12755145f8f.88.2024.07.02.02.26.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:26:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 56/67] hw/sd/sdcard: Add sd_cmd_ERASE handler (CMD38)
Date: Tue,  2 Jul 2024 11:20:39 +0200
Message-ID: <20240702092051.45754-57-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
Message-Id: <20240628070216.92609-63-philmd@linaro.org>
---
 hw/sd/sd.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d517a00ee1..be9437141a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -241,7 +241,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
                                             [21]    = "DPS_spec",
                                             [25]    = "WRITE_MULTIPLE_BLOCK",
         [26]    = "MANUF_RSVD",
-        [38]    = "ERASE",
         [40]    = "DPS_spec",
         [42]    = "LOCK_UNLOCK",
         [54]    = "SDIO_RSVD",              [55]    = "APP_CMD",
@@ -1594,6 +1593,24 @@ static sd_rsp_type_t sd_cmd_ERASE_WR_BLK_END(SDState *sd, SDRequest req)
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
@@ -1682,26 +1699,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
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
@@ -2320,6 +2317,7 @@ static const SDProto sd_proto_spi = {
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
         [37] = {10, sd_spi, "CONTROL_ASSD_SYSTEM", sd_cmd_optional},
+        [38] = {5,  sd_spi, "ERASE", sd_cmd_ERASE},
         [50] = {10, sd_spi, "DIRECT_SECURE_READ", sd_cmd_optional},
         [52] = {9,  sd_spi, "IO_RW_DIRECT", sd_cmd_optional},
         [53] = {9,  sd_spi, "IO_RW_EXTENDED", sd_cmd_optional},
@@ -2363,6 +2361,7 @@ static const SDProto sd_proto_sd = {
         [35] = {10, sd_adtc, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_adtc, "SEND_PSI", sd_cmd_optional},
         [37] = {10, sd_ac,   "CONTROL_ASSD_SYSTEM", sd_cmd_optional},
+        [38] = {5,  sd_ac,   "ERASE", sd_cmd_ERASE},
         [43] = {1,  sd_ac,   "Q_MANAGEMENT", sd_cmd_optional},
         [44] = {1,  sd_ac,   "Q_TASK_INFO_A", sd_cmd_optional},
         [45] = {1,  sd_ac,   "Q_TASK_INFO_B", sd_cmd_optional},
-- 
2.41.0


