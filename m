Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B7EC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMruH-0003tF-4r; Thu, 27 Jun 2024 12:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMruF-0003qv-Hq
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:23:31 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMru9-0007AY-4Z
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:23:31 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3629c517da9so7755826f8f.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719505403; x=1720110203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IJEAX/bFYJE8abBHAC9lGeH6fM4rczNBP33ZEV8FrPw=;
 b=HKHgSLE5di/lsR19Ec7CadJ/rJa4SR72gUJQL3HFUqf7I+uUTofN9aeFlWjVYpV61s
 l9YlJnQ8gD0+6N1GhY3m1RK5642WeAy039xzjtPeJ1j7cqEw7BLuCOF0FDYjRhyehxxB
 5KUf52zyoJIcZPpE+BSNQBrAS7pzq/2FOn3x0uiiyfTYjBHs3aWpl1RtOi9IPsKvXOnl
 m8X9ndjuBSDgdJY6cm014y0uT4DnnPTTA7VwPwRalcefQjRXwv2c8GsuzfrDxHaB4i51
 qTmDIQIFpwpTYV64aFpwOyACRURJcXK8jWg9YOLiGcCCgvfKM+3YjRbF94rZQpUb0fT2
 K4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719505403; x=1720110203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IJEAX/bFYJE8abBHAC9lGeH6fM4rczNBP33ZEV8FrPw=;
 b=k8RNCREKeE6ijaEKZpOafO0V9ur+4NFwXHOLwVfabV8wlEYW7edJDo7c3NeQW3+wub
 avzlkDTkxDcZUp1PBqleTCQf5qE8kl2LqagLumuvB5Faijbb0XBiI/+yAg867VHBKwiX
 MkDsbkW9RLwK47ComG/zGzjITNUV28nWuu1BmGbcsS42nwysd9N480qWR+QcbkiAemZP
 WPsXPjYUOgANA1FeYHRMYCuKqnLhGdEWNUEUe1Kt9bOShFYbrsCBD/BFqW2+/3ehf9kP
 B96hY2akgKGXSKxVV/xK5kSav2k3/Wh7wlliiutQ44ba8iTG/xo6v5B0bbtBAABIY0Dk
 IbqQ==
X-Gm-Message-State: AOJu0YwAGt3xqMFA/suNcz1nrkKgxok99ev7tnQyfKEzQwSPKEIbHr8f
 h9WiqNqzROZNCafETwZnFTTNN5RF91cIUYZTT0OBBpm1Mqbi6MpJZ9DT9yQEwVfXZeeY95DBzfr
 RKwE=
X-Google-Smtp-Source: AGHT+IHDso9iBAmZ45O4b4/yd5ccUNCg8WepPyq1ui6Sfz5s+WmeEMpYJjCUWzR0uQqivTlA/p/iBQ==
X-Received: by 2002:a5d:64a3:0:b0:362:4f55:6c43 with SMTP id
 ffacd0b85a97d-366e937f048mr15617205f8f.0.1719505402204; 
 Thu, 27 Jun 2024 09:23:22 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357fcb2sm2365842f8f.30.2024.06.27.09.23.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:23:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Hao Wu <wuhaotsh@google.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 devel@lists.libvirt.org, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 03/17] hw/sd/sdcard: Track last command used to help logging
Date: Thu, 27 Jun 2024 18:22:18 +0200
Message-ID: <20240627162232.80428-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627162232.80428-1-philmd@linaro.org>
References: <20240627162232.80428-1-philmd@linaro.org>
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
---
 hw/sd/sd.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d0a1d5db18..bc87807793 100644
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


