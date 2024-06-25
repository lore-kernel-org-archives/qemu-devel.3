Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B1BC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 05:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLz96-000341-RW; Tue, 25 Jun 2024 01:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLz94-0002wc-B6
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:55:10 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLz91-0001vk-Vy
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:55:10 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-35f06861ae6so3994464f8f.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 22:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719294905; x=1719899705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rEDUclqNQG81lYieISPwXKSAxhsKsmBHUM+5O9kJWv4=;
 b=Njinapm9RlueUbmV1cpGwt2JFT/J5NyDZxbDLynDAU4K0d2/df4vxkMlNSAJSzoPZ+
 PgC2Ikt7GnHEZ5I8IiUfLI4TTP8JlxirT7hFRfkFVwmk0WbZqExS5vPWFUvwpTk73ERn
 h1Nji7B7srKSx5Cru0uBYVdTQd4RdZAlcl9+IS598qbxdtDHlGXF3ZfCbSIZmrq1BcLA
 P2EtmiTUJ26JqgezuuOBI6ePGFOOumPDh9woPMBw18UBZ30UqZkzBFVZM78uwiPYbQWs
 8WG4QMlaiu8zUkZKI8r1tGKnAHf4aBkdHc+VSNqCIVkQPvXV3bj68e2HnD7VZWqrok5Y
 t0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719294905; x=1719899705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rEDUclqNQG81lYieISPwXKSAxhsKsmBHUM+5O9kJWv4=;
 b=pbb0df6xmFS93h5sQJHpFc7mA3ZomgG9QburJ0xabvW9UtzYGg4WoZY326o0wHSkQe
 oB5c1PF3PDr+CKTvVJg/3iWbGMsNZCbI46UaT7ghyfWQbxoPhwj1U5A2NLvc57fpsfzV
 wMQRNQMlVl0MKmYYT2anojUKuF2fUEA/5Keegelo4+vd4iyTrndo86b9/Zm6sxrelgrv
 twslqdbtOF7FvTkXS+YFoRA5MhCQRwE2wxBNeNc954iY2r9MwHjn9Uq4tTuElK7rLHQL
 kNUtlrCHWTneetTK0fHY7NuoWOCSVCuSPQJzBiama6GAPwSbB1wu2WPvTfzrSOjB1Laa
 M9SQ==
X-Gm-Message-State: AOJu0YxfwAY7/qPYzTuL+h/BEOSZXkbet9e5VovpC6qlOXh18w0ZytO5
 uhmNZ7VVGo+weAWNFIofXdY8O/FGKDLzO64B/XdqBYOWfYxExQjYdhgyaxfC+XiwLQRnsW2h5pJ
 1
X-Google-Smtp-Source: AGHT+IGA5w17y7EplleBEtnMBka1o1erlsC/vBQ8Ti2+86XQ5ej/pIKoM/SVNouJ5xtrTajwrGMMHg==
X-Received: by 2002:adf:e806:0:b0:35f:1161:e1a3 with SMTP id
 ffacd0b85a97d-366e94db399mr4136006f8f.5.1719294905408; 
 Mon, 24 Jun 2024 22:55:05 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d208b4asm196304145e9.29.2024.06.24.22.55.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 22:55:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 12/12] hw/sd/sdcard: Add direct reference to SDProto in
 SDState
Date: Tue, 25 Jun 2024 07:53:53 +0200
Message-ID: <20240625055354.23273-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625055354.23273-1-philmd@linaro.org>
References: <20240625055354.23273-1-philmd@linaro.org>
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

Keep direct reference to SDProto in SDState,
remove then unnecessary sd_proto().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 3b885ba8a0..6685fba4bb 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -117,6 +117,8 @@ struct SDState {
     uint8_t spec_version;
     BlockBackend *blk;
 
+    const SDProto *proto;
+
     /* Runtime changeables */
 
     uint32_t mode;    /* current card mode, one of SDCardModes */
@@ -155,18 +157,11 @@ struct SDState {
 
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
@@ -1035,7 +1030,7 @@ static bool address_in_range(SDState *sd, const char *desc,
 static sd_rsp_type_t sd_invalid_state_for_cmd(SDState *sd, SDRequest req)
 {
     qemu_log_mask(LOG_GUEST_ERROR, "%s: CMD%i in a wrong state: %s (spec %s)\n",
-                  sd_proto(sd)->name, req.cmd, sd_state_name(sd->state),
+                  sd->proto->name, req.cmd, sd_state_name(sd->state),
                   sd_version_str(sd->spec_version));
 
     return sd_illegal;
@@ -1044,7 +1039,7 @@ static sd_rsp_type_t sd_invalid_state_for_cmd(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_invalid_mode_for_cmd(SDState *sd, SDRequest req)
 {
     qemu_log_mask(LOG_GUEST_ERROR, "%s: CMD%i in a wrong mode: %s (spec %s)\n",
-                  sd_proto(sd)->name, req.cmd, sd_mode_name(sd->mode),
+                  sd->proto->name, req.cmd, sd_mode_name(sd->mode),
                   sd_version_str(sd->spec_version));
 
     return sd_illegal;
@@ -1053,7 +1048,7 @@ static sd_rsp_type_t sd_invalid_mode_for_cmd(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_cmd_illegal(SDState *sd, SDRequest req)
 {
     qemu_log_mask(LOG_GUEST_ERROR, "%s: Unknown CMD%i for spec %s\n",
-                  sd_proto(sd)->name, req.cmd,
+                  sd->proto->name, req.cmd,
                   sd_version_str(sd->spec_version));
 
     return sd_illegal;
@@ -1064,7 +1059,7 @@ __attribute__((unused))
 static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
 {
     qemu_log_mask(LOG_UNIMP, "%s: CMD%i not implemented\n",
-                  sd_proto(sd)->name, req.cmd);
+                  sd->proto->name, req.cmd);
 
     return sd_illegal;
 }
@@ -1157,7 +1152,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
      * However there is no ACMD55, so we want to trace this particular case.
      */
     if (req.cmd != 55 || sd->expecting_acmd) {
-        trace_sdcard_normal_command(sd_proto(sd)->name,
+        trace_sdcard_normal_command(sd->proto->name,
                                     sd->last_cmd_name, req.cmd,
                                     req.arg, sd_state_name(sd->state));
     }
@@ -1176,8 +1171,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         return sd_illegal;
     }
 
-    if (sd_proto(sd)->cmd[req.cmd]) {
-        return sd_proto(sd)->cmd[req.cmd](sd, req);
+    if (sd->proto->cmd[req.cmd]) {
+        return sd->proto->cmd[req.cmd](sd, req);
     }
 
     switch (req.cmd) {
@@ -1623,12 +1618,12 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
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
@@ -1919,7 +1914,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
     if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION))
         return;
 
-    trace_sdcard_write_data(sd_proto(sd)->name,
+    trace_sdcard_write_data(sd->proto->name,
                             sd->last_cmd_name,
                             sd->current_cmd, sd->data_offset, value);
     switch (sd->current_cmd) {
@@ -2074,7 +2069,7 @@ uint8_t sd_read_byte(SDState *sd)
 
     io_len = (sd->ocr & (1 << 30)) ? 512 : sd->blk_len;
 
-    trace_sdcard_read_data(sd_proto(sd)->name,
+    trace_sdcard_read_data(sd->proto->name,
                            sd->last_cmd_name,
                            sd->current_cmd, sd->data_offset, io_len);
     switch (sd->current_cmd) {
@@ -2218,7 +2213,9 @@ static const SDProto sd_proto_sd = {
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


