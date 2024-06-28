Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6CAC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5eM-0001K3-5b; Fri, 28 Jun 2024 03:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5dt-0000cz-Hn
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:03:35 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5dp-0006k4-QL
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:03:32 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-36743abace4so847240f8f.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558208; x=1720163008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zk4YjB9lQI2zLem86by0CBqxXy4bvU8ycOt1g+Y0WQQ=;
 b=GqfC6Bku+LvwCck3GyfEwZ/DmqcSGf55z6AtBhEQFttvTfvW3J1g5uE+a58StfINnU
 pvhziLw93zLEvPzz59l16OWK8wKVOfTsV159WtpO7KZ2ZovfgCuy3yRNpOCO31/FGJlj
 fEtA/umO2L2vpzTDXBfbfkDcjhKpt86Jp48HJQDkHblVoC89cy3E0p9StvoJmzjBPbnZ
 B0cFBjJYhst/FYHsmJ9/LQYn5qsj9C6KjTAstSsuEpLryrNIaOPKCsNKKPA1nVfZC63S
 y5/F+TFYEkou6rDc0k/ed6JnKW59Cxv1tCzWIotbw8tcRUsGrfZlay0cFr/rRsCcIzur
 GCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558208; x=1720163008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zk4YjB9lQI2zLem86by0CBqxXy4bvU8ycOt1g+Y0WQQ=;
 b=XnD7aHhQDtLkARzIpDhE/YAEo26dUU6DAg+AIOfZ/uovB2BnK2y2aw1uPj58ndjjkF
 yYYh2uu3sLKA6C4loIx5Gx8ymHREVbswbAfETDDbEZpUcKX3SeVgi4krHhRDoCHquyRb
 gv4xB/E6m8hAtAio7IYomSz2yATIcGkmE1lxdieo+lBwkGz7O2U4ZfXMCVHy0Ahq8EmS
 sZGfPNAa0tHkLn/4Wia8AhTSZk1JoV4z8T3vIDs8SZkpQp63moGKO6rWMfqDGgkHXW+E
 MQZEfiOIjqiKvNhE2VuGsIhA9jLHlpZ6qAW7DCJqHYc0ku1zp54VU2vV1cp0PioYNS2O
 /A9w==
X-Gm-Message-State: AOJu0Yy+o6oOFQ/Sez0lLELFWCwfuasTGud4hWYgLdr235jv3gVPNPno
 Z6yDC/I2wRRBOFaEXGaf3zdzUS91zsXUspvlxhM22dkFHLKzsFyOXfoYRKtj9GAF+qg24Yun+hP
 i4kM=
X-Google-Smtp-Source: AGHT+IEF7iuADXOIcQcXnGsfrSOOSIFB6AVppqs35sKpwQMJVZWPHk5De11+i0qPjuhZup3OZqVe2Q==
X-Received: by 2002:a5d:5f4d:0:b0:366:e45b:9fae with SMTP id
 ffacd0b85a97d-36760a6aadbmr744534f8f.6.1719558207789; 
 Fri, 28 Jun 2024 00:03:27 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e16a8sm1326385f8f.64.2024.06.28.00.03.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:03:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 13/98] hw/sd/sdcard: Add direct reference to SDProto in
 SDState
Date: Fri, 28 Jun 2024 09:00:49 +0200
Message-ID: <20240628070216.92609-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Keep direct reference to SDProto in SDState,
remove then unnecessary sd_proto().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
---
 hw/sd/sd.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 8f441e418c..aaa50ab2c5 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -116,6 +116,8 @@ struct SDState {
     uint8_t spec_version;
     BlockBackend *blk;
 
+    const SDProto *proto;
+
     /* Runtime changeables */
 
     uint32_t mode;    /* current card mode, one of SDCardModes */
@@ -154,18 +156,11 @@ struct SDState {
 
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
@@ -1044,7 +1039,7 @@ static bool address_in_range(SDState *sd, const char *desc,
 static sd_rsp_type_t sd_invalid_state_for_cmd(SDState *sd, SDRequest req)
 {
     qemu_log_mask(LOG_GUEST_ERROR, "%s: CMD%i in a wrong state: %s (spec %s)\n",
-                  sd_proto(sd)->name, req.cmd, sd_state_name(sd->state),
+                  sd->proto->name, req.cmd, sd_state_name(sd->state),
                   sd_version_str(sd->spec_version));
 
     return sd_illegal;
@@ -1053,7 +1048,7 @@ static sd_rsp_type_t sd_invalid_state_for_cmd(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_invalid_mode_for_cmd(SDState *sd, SDRequest req)
 {
     qemu_log_mask(LOG_GUEST_ERROR, "%s: CMD%i in a wrong mode: %s (spec %s)\n",
-                  sd_proto(sd)->name, req.cmd, sd_mode_name(sd->mode),
+                  sd->proto->name, req.cmd, sd_mode_name(sd->mode),
                   sd_version_str(sd->spec_version));
 
     return sd_illegal;
@@ -1062,7 +1057,7 @@ static sd_rsp_type_t sd_invalid_mode_for_cmd(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_cmd_illegal(SDState *sd, SDRequest req)
 {
     qemu_log_mask(LOG_GUEST_ERROR, "%s: Unknown CMD%i for spec %s\n",
-                  sd_proto(sd)->name, req.cmd,
+                  sd->proto->name, req.cmd,
                   sd_version_str(sd->spec_version));
 
     return sd_illegal;
@@ -1073,7 +1068,7 @@ __attribute__((unused))
 static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
 {
     qemu_log_mask(LOG_UNIMP, "%s: CMD%i not implemented\n",
-                  sd_proto(sd)->name, req.cmd);
+                  sd->proto->name, req.cmd);
 
     return sd_illegal;
 }
@@ -1166,7 +1161,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
      * However there is no ACMD55, so we want to trace this particular case.
      */
     if (req.cmd != 55 || sd->expecting_acmd) {
-        trace_sdcard_normal_command(sd_proto(sd)->name,
+        trace_sdcard_normal_command(sd->proto->name,
                                     sd->last_cmd_name, req.cmd,
                                     req.arg, sd_state_name(sd->state));
     }
@@ -1185,8 +1180,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         return sd_illegal;
     }
 
-    if (sd_proto(sd)->cmd[req.cmd]) {
-        return sd_proto(sd)->cmd[req.cmd](sd, req);
+    if (sd->proto->cmd[req.cmd]) {
+        return sd->proto->cmd[req.cmd](sd, req);
     }
 
     switch (req.cmd) {
@@ -1632,12 +1627,12 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
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
@@ -1928,7 +1923,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
     if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION))
         return;
 
-    trace_sdcard_write_data(sd_proto(sd)->name,
+    trace_sdcard_write_data(sd->proto->name,
                             sd->last_cmd_name,
                             sd->current_cmd, sd->data_offset, value);
     switch (sd->current_cmd) {
@@ -2083,7 +2078,7 @@ uint8_t sd_read_byte(SDState *sd)
 
     io_len = (sd->ocr & (1 << 30)) ? 512 : sd->blk_len;
 
-    trace_sdcard_read_data(sd_proto(sd)->name,
+    trace_sdcard_read_data(sd->proto->name,
                            sd->last_cmd_name,
                            sd->current_cmd, sd->data_offset, io_len);
     switch (sd->current_cmd) {
@@ -2227,7 +2222,9 @@ static const SDProto sd_proto_sd = {
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


