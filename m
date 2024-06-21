Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483B8C2BB85
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZIU-0005jK-CV; Fri, 21 Jun 2024 04:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZIT-0005j8-LH
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:07:01 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZIR-0008Qp-V0
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:07:01 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2ec50d4e46aso1168761fa.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 01:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718957218; x=1719562018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bU0wem6sZ7huq6N/EuEaJYYIPtKn/tCwdXKOteR3RBw=;
 b=qdFlEIBf1EOdYJrikiwG6axKT8Oq3zyRsWCC5sIaPWMIerANW7Vw0iSfggBhB9QzIz
 6ofGubggogFmhQASB85p3FyIGHdveYoYdPsRKnKa2gbiq1TMFOIAOmM8f4jUNHWsaxCr
 a0n1u6/uBh6yJwu+od007A34M0PuxfRyMSMYjAi5UbnI1vLLaVbPkMFH/IDbxQglelOv
 b8t+2GhZS7rSCJJMf8akueqUa3O1LO+DSkchSsOFjbtSlPQ4CsPEGdjVEmibtLP7LCiJ
 83iUIuOmXS7Vpdng3RyFT0xvq2IpsBrdKoydXu0ybM60+LNk3J7I9F3xNfbcOBPLjJg8
 OuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718957218; x=1719562018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bU0wem6sZ7huq6N/EuEaJYYIPtKn/tCwdXKOteR3RBw=;
 b=jkCkX5Ha01cNLKyvYQhL584c4egB/WeneB95sSFOPz8awqSitbGTqgCofoca40lxl6
 efEYVNsF/NamaxLaTivtd81V15eIpNpySDdaX5t9+ZgBBbV8vXf8Gw9bZqkWZr+0lB7s
 G1EGQkXXC67OE2sqGdpuWMngy6ah9BNAM6lcsHwKk+q9bKDp7Yv3mSLiRIMVOmefsa/q
 1eys884bCpbGL/H8O6UsqG75EXWv7Tjrla6sBGn0TrYLei7DQ4cBVoGqNk+DVFdXvyuF
 fWpsSUXFp+bVskoSjxX9mUIvDGdIqNWzgCQxnJYyxN942XWkwfmfRSoJ5vKUDe+akt1x
 l6zw==
X-Gm-Message-State: AOJu0YykUC8zqZozmYl1YPPxi7FI2xELMHNHFUMrJNSs6ZM4tE24faEU
 PfRmrPIoEONIRnHCjZsDgwxSTkNB2gEAMkpINi+VnXmft3gE4UID3G2j/5QTG8IoC4IbdYlGX3Y
 I
X-Google-Smtp-Source: AGHT+IEDx7ks0Bbwcet536NEuNgxMW89KRZaFDVd9rPc9ZQ9IFcBkQp3vRe9VWpXc9fAWtV1Uf/zLQ==
X-Received: by 2002:a2e:87d7:0:b0:2ec:4529:9690 with SMTP id
 38308e7fff4ca-2ec45299761mr26448331fa.3.1718957217896; 
 Fri, 21 Jun 2024 01:06:57 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.128.209])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42481910d5csm16921775e9.36.2024.06.21.01.06.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Jun 2024 01:06:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
Subject: [PATCH 10/23] hw/sd/sdcard: Track last command used to help logging
Date: Fri, 21 Jun 2024 10:05:41 +0200
Message-ID: <20240621080554.18986-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240621080554.18986-1-philmd@linaro.org>
References: <20240621080554.18986-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
---
 hw/sd/sd.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index e1f13e316a..4e378f7cf7 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -134,6 +134,7 @@ struct SDState {
     uint32_t pwd_len;
     uint8_t function_group[6];
     uint8_t current_cmd;
+    const char *last_cmd_name;
     /* True if we will handle the next command as an ACMD. Note that this does
      * *not* track the APP_CMD status bit!
      */
@@ -1095,12 +1096,13 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     uint32_t rca = 0x0000;
     uint64_t addr = (sd->ocr & (1 << 30)) ? (uint64_t) req.arg << 9 : req.arg;
 
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
 
@@ -1571,7 +1573,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_app_command(SDState *sd,
                                     SDRequest req)
 {
-    trace_sdcard_app_command(sd_proto(sd)->name, sd_acmd_name(req.cmd),
+    sd->last_cmd_name = sd_acmd_name(req.cmd);
+    trace_sdcard_app_command(sd_proto(sd)->name, sd->last_cmd_name,
                              req.cmd, req.arg, sd_state_name(sd->state));
     sd->card_status |= APP_CMD;
 
@@ -1863,7 +1866,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
         return;
 
     trace_sdcard_write_data(sd_proto(sd)->name,
-                            sd_acmd_name(sd->current_cmd),
+                            sd->last_cmd_name,
                             sd->current_cmd, value);
     switch (sd->current_cmd) {
     case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
@@ -2019,7 +2022,7 @@ uint8_t sd_read_byte(SDState *sd)
     io_len = (sd->ocr & (1 << 30)) ? 512 : sd->blk_len;
 
     trace_sdcard_read_data(sd_proto(sd)->name,
-                           sd_acmd_name(sd->current_cmd),
+                           sd->last_cmd_name,
                            sd->current_cmd, io_len);
     switch (sd->current_cmd) {
     case 6:  /* CMD6:   SWITCH_FUNCTION */
@@ -2163,6 +2166,7 @@ static void sd_instance_init(Object *obj)
 {
     SDState *sd = SD_CARD(obj);
 
+    sd->last_cmd_name = "UNSET";
     sd->enable = true;
     sd->ocr_power_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sd_ocr_powerup, sd);
 }
-- 
2.41.0


