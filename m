Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E792CC3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsIy-0003nc-J4; Thu, 27 Jun 2024 12:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsIW-0003Iw-6i
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:48:41 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsIU-0001MK-D3
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:48:35 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5295e488248so9700184e87.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506912; x=1720111712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Ij5pjsDB8qqEoSZ8JFKxxVUAdb9cjcc9vXzXqWT+4A=;
 b=e57gx9OoF/TpjB0MXM8eKiIuGpIc2MoOKv68hXg+vwC0jQJIPApNctIl1NsAiOireS
 o2o8+ihlCoY8xB+PGsLb8cwOMQoELhSR4URPYEtRCcb4RgOci9Z1Ky+8z/PlKpMBh3l4
 K2eCtv7/+tOMtWdxw7qKBMUfHOh/xxP3M1D7d5wL96KFUBeU6j2jrpvX192YJdnq8vR6
 1Fc+UgJDzxjfM0AdkJEEEeD05YiQyCdVQhGNyuRbOILw6jWgRJF39oXotTIzi+GdQKcQ
 8rv5i1rna+GhuBi/ZwEuWrotiWwy84RoN6mPEzV8gd7ZQV/402YVP49pmzSQEiWkwsY/
 RinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506912; x=1720111712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Ij5pjsDB8qqEoSZ8JFKxxVUAdb9cjcc9vXzXqWT+4A=;
 b=gOr3u6bn6vjrurNb1Yb/V9S1wMoQELFsA6MJQVFzUwMRohnxibQkN2jzXn2+T8FIT/
 N55IPyaIcuJSf00ZIyIdWF9hymtFScj90tLVkgq+LSPw8KU2tozF4SsL40Pvs0Ti7fhW
 rvYN2n0t3muHd0eGY7hBdUzxCuFbbm5H+ERKYgiJMzaWWbUWupm1bM6NhokyNAJ5wLx7
 Rp6HjYeVVt6EtehmLLM/yI21mqIc+5A3/LkwiXIzu6lwQdEZYi5vOQGUZmxn8gO2R7jf
 EqY+io/6Z6Ro41k8C4OUg45D2XS4EqxL7kL+d8IoqjS80td2Ddb0LBsn5Lp4WaJYEDm1
 XBTA==
X-Gm-Message-State: AOJu0YwKXpLfrMu7Vb/0PJhuz1b8SjZnasjrXQDu/o3XgTnUJVg1mAau
 PEdrOhWTDSb2/xmFfazbmXT+G/9za8rzsVCaCCa8ptKYVhdg8zvkiGIIozxrW1n63ad2HyJZgoE
 kKSM=
X-Google-Smtp-Source: AGHT+IFiwYt587NSyqOJ5rwwySHKEMWtgq9ROMygwkdC1L0QUxuIPIAfXAuo74ca24j4W/8GACvaWQ==
X-Received: by 2002:a19:6453:0:b0:52d:8356:f6b9 with SMTP id
 2adb3069b0e04-52d8356f710mr3846079e87.38.1719506911667; 
 Thu, 27 Jun 2024 09:48:31 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4249b132fd1sm86086595e9.0.2024.06.27.09.48.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:48:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Francisco Iglesias <francisco.iglesias@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH 01/12] hw/sd/sdcard: Add sd_acmd_SET_BUS_WIDTH handler (ACMD6)
Date: Thu, 27 Jun 2024 18:48:03 +0200
Message-ID: <20240627164815.82606-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164815.82606-1-philmd@linaro.org>
References: <20240627164815.82606-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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
 hw/sd/sd.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 2f853a89d1..0310a5a3a1 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -260,7 +260,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *acmd_abbrev[SDMMC_CMD_MAX] = {
-         [6] = "SET_BUS_WIDTH",
         [13] = "SD_STATUS",
         [14] = "DPS_spec",                  [15] = "DPS_spec",
         [16] = "DPS_spec",
@@ -1672,6 +1671,18 @@ static sd_rsp_type_t spi_cmd_CRC_ON_OFF(SDState *sd, SDRequest req)
     return sd_r1;
 }
 
+/* ACMD6 */
+static sd_rsp_type_t sd_acmd_SET_BUS_WIDTH(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+
+    sd->sd_status[0] &= 0x3f;
+    sd->sd_status[0] |= (req.arg & 0x03) << 6;
+    return sd_r1;
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint64_t addr;
@@ -1780,18 +1791,6 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     }
 
     switch (req.cmd) {
-    case 6:  /* ACMD6:  SET_BUS_WIDTH */
-        switch (sd->state) {
-        case sd_transfer_state:
-            sd->sd_status[0] &= 0x3f;
-            sd->sd_status[0] |= (req.arg & 0x03) << 6;
-            return sd_r1;
-
-        default:
-            break;
-        }
-        break;
-
     case 13:  /* ACMD13: SD_STATUS */
         switch (sd->state) {
         case sd_transfer_state:
@@ -2385,6 +2384,9 @@ static const SDProto sd_proto_sd = {
         [58] = {11, sd_adtc, "READ_EXTR_MULTI", sd_cmd_optional},
         [59] = {11, sd_adtc, "WRITE_EXTR_MULTI", sd_cmd_optional},
     },
+    .acmd = {
+        [6]  = {8,  sd_ac,   "SET_BUS_WIDTH", sd_acmd_SET_BUS_WIDTH},
+    },
 };
 
 static void sd_instance_init(Object *obj)
-- 
2.41.0


