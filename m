Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF97DC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZhR-00014A-7F; Tue, 02 Jul 2024 05:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZhK-00013A-EL
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:21:14 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZhH-0006Mp-SN
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:21:14 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ebe40673d8so52306031fa.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912066; x=1720516866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9WSx0o0NoRwLFVmVIU2eDisxkgWjS2aVMQINVCuPfpI=;
 b=XMIHQ1Pc3lsDySUScGW8Qxm8t0/LEgjWpzGCoHUzLO91eVKq3QF/8VwBVTSuU5pjSs
 tbDH2FSAX8sRAja6rWnJq1p/uXLHdpFG/1kPaqvrhhfg4wFAANq6nKVUNzEABi4niHuH
 GbqGwmyuj++0i1Bw0bscBGK2d0f1d1I8F+sDHAuIKGFNnuvUIxtfGL9fjLay0wo+t5Bi
 P97lQTmbyJL9rq6uy5Ik8n+3GbwY5mdi/8l6Z52/iwXtNxORMOXkTqSzhHO+v3JOyctS
 vDK/fubtDPpBJYM02T+Qv5tPsx6cWpgmfzPX/L0gOFWoqZ9fRonELV99wAHpO0K2LdA1
 Pxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912066; x=1720516866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9WSx0o0NoRwLFVmVIU2eDisxkgWjS2aVMQINVCuPfpI=;
 b=olVby9j+t9KRiNOsVJ+BRUvFUgaexy0og8RZLYlp1ZV1EWHjwWgsGPjV3PB5ykEe6K
 tRWV0+dJqKR/JBNOkNv2xFXYwhlyyi5RGcZHby9R8qjk7G3hw1xXSL8VoUAGuSy4GMXm
 U1yH301mNh/R1H5i+KZtd/b8AyqRty4J0IP7SNcRJ1r+7RltlpZeDVdhU7xv3ga9A2I/
 q2SJp8W8p1cAcwEL3ukupu1/8ejapPOQhBaAgboQyPVl1FlInqbPMwolBgdOaMV7n3py
 VSTpDHIelF0QuQB9IFe64THr8gTm5hvTkeGOoH3iTM91gElTuEUV6W8r71cJfEWVS+7V
 Hd7A==
X-Gm-Message-State: AOJu0Yy1ZQkfRw41dmjeLhibBh8Eryc3ZQUDdNPMBJarZ+ja9qrlsY76
 8hJKFuAP8LIeKQksYsl/CQJD+6UFFfSGr7dSpRESdsf5mrBCSZYU3D3VhcROkxsjqIAG29qyI65
 2
X-Google-Smtp-Source: AGHT+IHWVJWzLgH3m+hxe0oGMnEVH2MvcI2sJFuqkgD1m+lAutDZ5QDdR4yHVUI7nJGAMNFqrsE1FA==
X-Received: by 2002:a05:651c:88a:b0:2ee:6cda:637b with SMTP id
 38308e7fff4ca-2ee6cda6515mr35005801fa.35.1719912065944; 
 Tue, 02 Jul 2024 02:21:05 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257cdf4982sm110219655e9.47.2024.07.02.02.21.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:21:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 02/67] hw/sd/sdcard: Track last command used to help logging
Date: Tue,  2 Jul 2024 11:19:45 +0200
Message-ID: <20240702092051.45754-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
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

The command is selected on the I/O lines, and further
processing might be done on the DAT lines via the
sd_read_byte() and sd_write_byte() handlers. Since
these methods can't distinct between normal and APP
commands, keep the name of the current command in
the SDState and use it in the DAT handlers. This
fixes a bug that all normal commands were displayed
as APP commands.

Fixes: 2ed61fb57b ("sdcard: Display command name when tracing CMD/ACMD")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-4-philmd@linaro.org>
---
 hw/sd/sd.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a48010cfc1..aa011fc892 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -133,6 +133,7 @@ struct SDState {
     uint32_t pwd_len;
     uint8_t function_group[6];
     uint8_t current_cmd;
+    const char *last_cmd_name;
     /* True if we will handle the next command as an ACMD. Note that this does
      * *not* track the APP_CMD status bit!
      */
@@ -1154,12 +1155,13 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     uint16_t rca;
     uint64_t addr;
 
+    sd->last_cmd_name = sd_cmd_name(req.cmd);
     /* CMD55 precedes an ACMD, so we are not interested in tracing it.
      * However there is no ACMD55, so we want to trace this particular case.
      */
     if (req.cmd != 55 || sd->expecting_acmd) {
         trace_sdcard_normal_command(sd_proto(sd)->name,
-                                    sd_cmd_name(req.cmd), req.cmd,
+                                    sd->last_cmd_name, req.cmd,
                                     req.arg, sd_state_name(sd->state));
     }
 
@@ -1620,7 +1622,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_app_command(SDState *sd,
                                     SDRequest req)
 {
-    trace_sdcard_app_command(sd_proto(sd)->name, sd_acmd_name(req.cmd),
+    sd->last_cmd_name = sd_acmd_name(req.cmd);
+    trace_sdcard_app_command(sd_proto(sd)->name, sd->last_cmd_name,
                              req.cmd, req.arg, sd_state_name(sd->state));
     sd->card_status |= APP_CMD;
 
@@ -1913,7 +1916,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
         return;
 
     trace_sdcard_write_data(sd_proto(sd)->name,
-                            sd_acmd_name(sd->current_cmd),
+                            sd->last_cmd_name,
                             sd->current_cmd, value);
     switch (sd->current_cmd) {
     case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
@@ -2069,7 +2072,7 @@ uint8_t sd_read_byte(SDState *sd)
     io_len = (sd->ocr & (1 << 30)) ? 512 : sd->blk_len;
 
     trace_sdcard_read_data(sd_proto(sd)->name,
-                           sd_acmd_name(sd->current_cmd),
+                           sd->last_cmd_name,
                            sd->current_cmd, io_len);
     switch (sd->current_cmd) {
     case 6:  /* CMD6:   SWITCH_FUNCTION */
@@ -2214,6 +2217,7 @@ static void sd_instance_init(Object *obj)
 {
     SDState *sd = SD_CARD(obj);
 
+    sd->last_cmd_name = "UNSET";
     sd->enable = true;
     sd->ocr_power_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sd_ocr_powerup, sd);
 }
-- 
2.41.0


