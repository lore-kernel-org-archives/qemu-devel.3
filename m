Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5CAC41513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZiD-0001D2-RM; Tue, 02 Jul 2024 05:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZiA-0001Cb-UO
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:22:06 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZi4-0006T4-Vx
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:22:06 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52ce01403f6so4485385e87.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912118; x=1720516918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E+5gh8hAsErYp4RFAc5dc/YmikXj+fQzAy2bjo6tyAE=;
 b=sZd72Xofb7JNwg5WXV63oFK9qFXkO6+I5w5srUOL2wsyAnLpiGxwnJgX3/wZaoz3GC
 hF9EZb+h9IceG5DOjLxpAt4p7soNvxosW8+y4Eh65VTYZhyF4sBChj1VtLSLCHqEDEet
 kkUh75ALRwYhVcsj89jmO7grd+I+rRJo4iYNhlMukTvg2SvcejfFdV4mwgeHZCxV2RQM
 Toqxk+sc/TD2q9DkNNT/SOB+XPz461hCAkxAwz+m20Ez9f/9sLmLMY+YvETdVEUKR3WE
 UlfgQpV4JY027i71TLadRM+Q6M6kPzLCkBkAf2neLAamSVf10hQ11AXREw+ytK4y0EW6
 SGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912118; x=1720516918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E+5gh8hAsErYp4RFAc5dc/YmikXj+fQzAy2bjo6tyAE=;
 b=sLEJgAk8p30AtIhe2EGyAhE7nD77uM8MyhDioyXWFhF4jXbCe3EF/yfhM14r8fPZhw
 4li0VKURYS8ecHvz8QjMQ3vA/756+fZ3ry+MR8XszLTx28Ya5IGeKurbq8qkmgQWOrXq
 SYFbesuTruLECDUAHl6nm6WmO7NyJjB5KuACkn5d10QWdj3oz6I8TtjVqB3IP+nOlQER
 f7sKFcZdNyWWY9vixLshmmXFjy2jin2HgYNOtT93qXJefHi+F69il9vzJfK24njz6U0q
 PT6alyyXN/a2zd6tMTZ039XiL3lvJtvy3PIoQZyPGtLdWVBVmZkGgBeBNJL8y2aJi0mt
 B0PQ==
X-Gm-Message-State: AOJu0YxhTbGb+USPhiYy5mujj+uyMIXZaRW/lhM5w5+GT+iRng7uQKJF
 bQ7mx0/NDiMfXisR4ylA/I1j7ZXKGKqLYsUwdj9iiY1uWohHuem8Y53FkgoQXvQ0j9+2jC3wQIb
 X
X-Google-Smtp-Source: AGHT+IFZs43bdbE9ypnEpwVwEfr3iKDwxS8qh9AFYj5Jo2NLmRIGnZyBN1E4MPkrpaFrvFpxymb3IQ==
X-Received: by 2002:a05:6512:acd:b0:52c:caa6:13b4 with SMTP id
 2adb3069b0e04-52e8264e4ecmr5958184e87.3.1719912118085; 
 Tue, 02 Jul 2024 02:21:58 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09aa32sm189743195e9.34.2024.07.02.02.21.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:21:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 11/67] hw/sd/sdcard: Add direct reference to SDProto in SDState
Date: Tue,  2 Jul 2024 11:19:54 +0200
Message-ID: <20240702092051.45754-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Keep direct reference to SDProto in SDState,
remove then unnecessary sd_proto().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-14-philmd@linaro.org>
---
 hw/sd/sd.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 30c1d299d4..d06e670024 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -116,6 +116,8 @@ struct SDState {
     uint8_t spec_version;
     BlockBackend *blk;
 
+    const SDProto *proto;
+
     /* Runtime changeables */
 
     uint32_t mode;    /* current card mode, one of SDCardModes */
@@ -152,18 +154,11 @@ struct SDState {
 
 static void sd_realize(DeviceState *dev, Error **errp);
 
-static const struct SDProto *sd_proto(SDState *sd)
-{
-    SDCardClass *sc = SD_CARD_GET_CLASS(sd);
-
-    return sc->proto;
-}
-
 static const SDProto sd_proto_spi;
 
 static bool sd_is_spi(SDState *sd)
 {
-    return sd_proto(sd) == &sd_proto_spi;
+    return sd->proto == &sd_proto_spi;
 }
 
 static const char *sd_version_str(enum SDPhySpecificationVersion version)
@@ -1041,7 +1036,7 @@ static bool address_in_range(SDState *sd, const char *desc,
 static sd_rsp_type_t sd_invalid_state_for_cmd(SDState *sd, SDRequest req)
 {
     qemu_log_mask(LOG_GUEST_ERROR, "%s: CMD%i in a wrong state: %s (spec %s)\n",
-                  sd_proto(sd)->name, req.cmd, sd_state_name(sd->state),
+                  sd->proto->name, req.cmd, sd_state_name(sd->state),
                   sd_version_str(sd->spec_version));
 
     return sd_illegal;
@@ -1050,7 +1045,7 @@ static sd_rsp_type_t sd_invalid_state_for_cmd(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_invalid_mode_for_cmd(SDState *sd, SDRequest req)
 {
     qemu_log_mask(LOG_GUEST_ERROR, "%s: CMD%i in a wrong mode: %s (spec %s)\n",
-                  sd_proto(sd)->name, req.cmd, sd_mode_name(sd->mode),
+                  sd->proto->name, req.cmd, sd_mode_name(sd->mode),
                   sd_version_str(sd->spec_version));
 
     return sd_illegal;
@@ -1059,7 +1054,7 @@ static sd_rsp_type_t sd_invalid_mode_for_cmd(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_cmd_illegal(SDState *sd, SDRequest req)
 {
     qemu_log_mask(LOG_GUEST_ERROR, "%s: Unknown CMD%i for spec %s\n",
-                  sd_proto(sd)->name, req.cmd,
+                  sd->proto->name, req.cmd,
                   sd_version_str(sd->spec_version));
 
     return sd_illegal;
@@ -1070,7 +1065,7 @@ __attribute__((unused))
 static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
 {
     qemu_log_mask(LOG_UNIMP, "%s: CMD%i not implemented\n",
-                  sd_proto(sd)->name, req.cmd);
+                  sd->proto->name, req.cmd);
 
     return sd_illegal;
 }
@@ -1163,7 +1158,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
      * However there is no ACMD55, so we want to trace this particular case.
      */
     if (req.cmd != 55 || sd->expecting_acmd) {
-        trace_sdcard_normal_command(sd_proto(sd)->name,
+        trace_sdcard_normal_command(sd->proto->name,
                                     sd->last_cmd_name, req.cmd,
                                     req.arg, sd_state_name(sd->state));
     }
@@ -1182,8 +1177,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         return sd_illegal;
     }
 
-    if (sd_proto(sd)->cmd[req.cmd]) {
-        return sd_proto(sd)->cmd[req.cmd](sd, req);
+    if (sd->proto->cmd[req.cmd]) {
+        return sd->proto->cmd[req.cmd](sd, req);
     }
 
     switch (req.cmd) {
@@ -1629,12 +1624,12 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
                                     SDRequest req)
 {
     sd->last_cmd_name = sd_acmd_name(req.cmd);
-    trace_sdcard_app_command(sd_proto(sd)->name, sd->last_cmd_name,
+    trace_sdcard_app_command(sd->proto->name, sd->last_cmd_name,
                              req.cmd, req.arg, sd_state_name(sd->state));
     sd->card_status |= APP_CMD;
 
-    if (sd_proto(sd)->acmd[req.cmd]) {
-        return sd_proto(sd)->acmd[req.cmd](sd, req);
+    if (sd->proto->acmd[req.cmd]) {
+        return sd->proto->acmd[req.cmd](sd, req);
     }
 
     switch (req.cmd) {
@@ -1925,7 +1920,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
     if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION))
         return;
 
-    trace_sdcard_write_data(sd_proto(sd)->name,
+    trace_sdcard_write_data(sd->proto->name,
                             sd->last_cmd_name,
                             sd->current_cmd, sd->data_offset, value);
     switch (sd->current_cmd) {
@@ -2081,7 +2076,7 @@ uint8_t sd_read_byte(SDState *sd)
 
     io_len = (sd->ocr & (1 << 30)) ? 512 : sd->blk_len;
 
-    trace_sdcard_read_data(sd_proto(sd)->name,
+    trace_sdcard_read_data(sd->proto->name,
                            sd->last_cmd_name,
                            sd->current_cmd, sd->data_offset, io_len);
     switch (sd->current_cmd) {
@@ -2226,7 +2221,9 @@ static const SDProto sd_proto_sd = {
 static void sd_instance_init(Object *obj)
 {
     SDState *sd = SD_CARD(obj);
+    SDCardClass *sc = SD_CARD_GET_CLASS(sd);
 
+    sd->proto = sc->proto;
     sd->last_cmd_name = "UNSET";
     sd->enable = true;
     sd->ocr_power_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sd_ocr_powerup, sd);
-- 
2.41.0


