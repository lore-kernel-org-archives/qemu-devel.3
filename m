Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4E1C87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 17:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujLWB-0008Ln-6g; Tue, 05 Aug 2025 13:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujLW2-0008Ei-Ql
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 13:32:02 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujLVy-0004sl-P4
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 13:31:58 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3b78a034f17so4090917f8f.2
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 10:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754415112; x=1755019912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nyJb13ApUF6CgkPoqne7lt0/hxjnBW7a66LB5bEyxpQ=;
 b=kI2geFed/kIxgR+q1CjGX1hDL8rIWCKwK4kSGC/qFUaNfMINQYKMTroVacmM6IOAWz
 KjyNjaW5v1VYf2LyBV/iJvzyzIiIPIAfhkcX7zNqmuEl6p9m4pSlw1Stjk8jm2u5dmBr
 JxxPqLp/igBT/yBjLSNMQvmR+VYLLepIliX18u984Eye8Z37293TtYxOE6rKtnmyXrQa
 WF23JYbKNYtLm+1xmZB9mxdl6gwNT2sNWRcgw1YLJ96t8Blh8sAODHDDoYyTHdf9b1oS
 5kCG3XrM2gNAhFDbvaFw+7/eJK2wvfYnEbqqgv1gsvY3r+7+PJ6n8TKX89cyC2l4Ql0/
 CvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754415112; x=1755019912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nyJb13ApUF6CgkPoqne7lt0/hxjnBW7a66LB5bEyxpQ=;
 b=cCnPxkv8Ilm8J0Zr5SpVmX8ManDwGpQAOPB3FvCl1a5X9z7S5RLOSKphBUMs2+RDNp
 qCxjgBTy0Nn5pwZsnVPYlXeWE6pTptLYxispnv+N6pE29oBdICqOWcL361q7xILgL35e
 C2jF19XqQBRGGvIYlZ2sXf4ZAN1NAIjwoNsjNP9RK5A4XgwDPrRH+EIveWJ4dmRl6KR4
 BSmUxv7enLdF+ecSpvw3uKCFosf2JqfktSZLHg6ZETsTqUKWaVDO+0i0CJZs6JSmHc1d
 UXGwo0Hvo9e/s/dWOCFDp/Rpu+WPxkmE7sSMHzmz/DSIiW4AZqeMWeBPkq9rP+Z4FVru
 XZdw==
X-Gm-Message-State: AOJu0YxSW5ykVeqYIJAmjTQCt4d2La0/B3ypUbAeEaDsZLD38K4lQ2el
 t4UDUT89v81GoiJRnvtBm0KyocygcwTdOHcevJCWCr63ac2DorJK6EPevuUddB6kuWS4C8DZ0EI
 bQigb
X-Gm-Gg: ASbGncsQ5RFHnAydFVARGvc7omK1c4srF5+4Y862Mw4oDZCopdOGwHEw+ii5AS7opL/
 Lfz0DnhZNk9rkxvHSRX6UfdJkdTrhttQ6qayoCQoR65/+uswsysW5UiKVPiIT9oaVEx51ViOXrB
 EHHaGwVpb1V5ZCqSsd5YWmb+qjmT+yc2g1lTeM4fGp9uo/MmlPFDH9jFjKQb30yRVEo1DAIS6Gb
 /qgQ9x88OsqsOiTKAStKm5fP90ik2p72jIzRNtr2eUpwDLCZ0qR2WSjCPkEgPSVtdZKzedkclqd
 Ctzr25FXdxzesC3hRX3ZBHAleGMmOhdpJ4ywW+LjlRM4SA+KXsNF+CH4AIrRo6CmuCx5+r00/g8
 ExAOarIZfjP/kd3YTe/EoNjY6XrTPj4pcz479HBC/ymCrjSkM6G9/4B4vNLocvHtqpJ8ZBJOa
X-Google-Smtp-Source: AGHT+IFxhPw1C4EaM2WRXR38iNdDbrsPPv+WYXwo9islqjuMwXaHY6QZdx6mTgNI1wMXzsDg59F1rQ==
X-Received: by 2002:a05:6000:2912:b0:3b8:d32e:9231 with SMTP id
 ffacd0b85a97d-3b8d94ba936mr9946361f8f.29.1754415111715; 
 Tue, 05 Aug 2025 10:31:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e586eef8sm12038175e9.21.2025.08.05.10.31.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Aug 2025 10:31:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org, qemu-block@nongnu.org
Subject: [PULL 03/13] hw/sd/sdbus: Provide buffer size to sdbus_do_command()
Date: Tue,  5 Aug 2025 19:31:24 +0200
Message-ID: <20250805173135.38045-4-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250805173135.38045-1-philmd@linaro.org>
References: <20250805173135.38045-1-philmd@linaro.org>
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

We provide to sdbus_do_command() a pointer to a buffer to be
filled with a varying number of bytes. By not providing the
buffer size, the callee can not check the buffer is big enough.
Pass the buffer size as argument to follow good practices.

sdbus_do_command() doesn't return any error, only the size filled
in the buffer. Convert the returned type to unsigned and remove
the few unreachable lines in callers.

This allow to check for possible overflow in sd_do_command().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250804133406.17456-4-philmd@linaro.org>
---
 include/hw/sd/sd.h       | 23 +++++++++++++++++++++--
 hw/sd/allwinner-sdhost.c |  7 ++-----
 hw/sd/bcm2835_sdhost.c   |  7 ++-----
 hw/sd/core.c             |  5 +++--
 hw/sd/omap_mmc.c         |  5 +++--
 hw/sd/pl181.c            |  6 ++----
 hw/sd/sd.c               |  6 ++++--
 hw/sd/sdhci.c            |  6 +++---
 hw/sd/ssi-sd.c           | 12 +++++++-----
 9 files changed, 47 insertions(+), 30 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index d6bad175131..55d363f58fb 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -96,7 +96,17 @@ struct SDCardClass {
     DeviceClass parent_class;
     /*< public >*/
 
-    int (*do_command)(SDState *sd, SDRequest *req, uint8_t *response);
+    /**
+     * Process a SD command request.
+     * @sd: card
+     * @req: command request
+     * @resp: buffer to receive the command response
+     * @respsz: size of @resp buffer
+     *
+     * Return: size of the response
+     */
+    size_t (*do_command)(SDState *sd, SDRequest *req,
+                         uint8_t *resp, size_t respsz);
     /**
      * Write a byte to a SD card.
      * @sd: card
@@ -153,7 +163,16 @@ struct SDBusClass {
 void sdbus_set_voltage(SDBus *sdbus, uint16_t millivolts);
 uint8_t sdbus_get_dat_lines(SDBus *sdbus);
 bool sdbus_get_cmd_line(SDBus *sdbus);
-int sdbus_do_command(SDBus *sd, SDRequest *req, uint8_t *response);
+/**
+ * sdbus_do_command: Process a SD command request
+ * @sd: card
+ * @req: command request
+ * @resp: buffer to receive the command response
+ * @respsz: size of @resp buffer
+ *
+ * Return: size of the response
+ */
+size_t sdbus_do_command(SDBus *sd, SDRequest *req, uint8_t *resp, size_t respsz);
 /**
  * Write a byte to a SD bus.
  * @sd: bus
diff --git a/hw/sd/allwinner-sdhost.c b/hw/sd/allwinner-sdhost.c
index b31da5c399c..9d61b372e70 100644
--- a/hw/sd/allwinner-sdhost.c
+++ b/hw/sd/allwinner-sdhost.c
@@ -233,7 +233,7 @@ static void allwinner_sdhost_send_command(AwSdHostState *s)
 {
     SDRequest request;
     uint8_t resp[16];
-    int rlen;
+    size_t rlen;
 
     /* Auto clear load flag */
     s->command &= ~SD_CMDR_LOAD;
@@ -246,10 +246,7 @@ static void allwinner_sdhost_send_command(AwSdHostState *s)
         request.arg = s->command_arg;
 
         /* Send request to SD bus */
-        rlen = sdbus_do_command(&s->sdbus, &request, resp);
-        if (rlen < 0) {
-            goto error;
-        }
+        rlen = sdbus_do_command(&s->sdbus, &request, resp, sizeof(resp));
 
         /* If the command has a response, store it in the response registers */
         if ((s->command & SD_CMDR_RESPONSE)) {
diff --git a/hw/sd/bcm2835_sdhost.c b/hw/sd/bcm2835_sdhost.c
index 29debdf59e4..f7cef7bb1cd 100644
--- a/hw/sd/bcm2835_sdhost.c
+++ b/hw/sd/bcm2835_sdhost.c
@@ -113,15 +113,12 @@ static void bcm2835_sdhost_send_command(BCM2835SDHostState *s)
 {
     SDRequest request;
     uint8_t rsp[16];
-    int rlen;
+    size_t rlen;
 
     request.cmd = s->cmd & SDCMD_CMD_MASK;
     request.arg = s->cmdarg;
 
-    rlen = sdbus_do_command(&s->sdbus, &request, rsp);
-    if (rlen < 0) {
-        goto error;
-    }
+    rlen = sdbus_do_command(&s->sdbus, &request, rsp, sizeof(rsp));
     if (!(s->cmd & SDCMD_NO_RESPONSE)) {
         if (rlen == 0 || (rlen == 4 && (s->cmd & SDCMD_LONG_RESPONSE))) {
             goto error;
diff --git a/hw/sd/core.c b/hw/sd/core.c
index 4b30218b520..d3c9017445e 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -90,7 +90,8 @@ void sdbus_set_voltage(SDBus *sdbus, uint16_t millivolts)
     }
 }
 
-int sdbus_do_command(SDBus *sdbus, SDRequest *req, uint8_t *response)
+size_t sdbus_do_command(SDBus *sdbus, SDRequest *req,
+                        uint8_t *resp, size_t respsz)
 {
     SDState *card = get_card(sdbus);
 
@@ -98,7 +99,7 @@ int sdbus_do_command(SDBus *sdbus, SDRequest *req, uint8_t *response)
     if (card) {
         SDCardClass *sc = SDMMC_COMMON_GET_CLASS(card);
 
-        return sc->do_command(card, req, response);
+        return sc->do_command(card, req, resp, respsz);
     }
 
     return 0;
diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index b7648d41cc5..5a1d25defaa 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -130,7 +130,8 @@ static void omap_mmc_command(OMAPMMCState *host, int cmd, int dir,
                              sd_rsp_type_t resptype, int init)
 {
     uint32_t rspstatus, mask;
-    int rsplen, timeout;
+    size_t rsplen;
+    int timeout;
     SDRequest request;
     uint8_t response[16];
 
@@ -157,7 +158,7 @@ static void omap_mmc_command(OMAPMMCState *host, int cmd, int dir,
     request.arg = host->arg;
     request.crc = 0; /* FIXME */
 
-    rsplen = sdbus_do_command(&host->sdbus, &request, response);
+    rsplen = sdbus_do_command(&host->sdbus, &request, response, sizeof(response));
 
     /* TODO: validate CRCs */
     switch (resptype) {
diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index b8fc9f86f13..5d56ead4d91 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -173,14 +173,12 @@ static void pl181_do_command(PL181State *s)
 {
     SDRequest request;
     uint8_t response[16];
-    int rlen;
+    size_t rlen;
 
     request.cmd = s->cmd & PL181_CMD_INDEX;
     request.arg = s->cmdarg;
     trace_pl181_command_send(request.cmd, request.arg);
-    rlen = sdbus_do_command(&s->sdbus, &request, response);
-    if (rlen < 0)
-        goto error;
+    rlen = sdbus_do_command(&s->sdbus, &request, response, sizeof(response));
     if (s->cmd & PL181_CMD_RESPONSE) {
         if (rlen == 0 || (rlen == 4 && (s->cmd & PL181_CMD_LONGRESP)))
             goto error;
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 76ce54664f2..069107a2e70 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2166,8 +2166,9 @@ static bool cmd_valid_while_locked(SDState *sd, unsigned cmd)
     return cmd_class == 0 || cmd_class == 7;
 }
 
-static int sd_do_command(SDState *sd, SDRequest *req,
-                         uint8_t *response) {
+static size_t sd_do_command(SDState *sd, SDRequest *req,
+                            uint8_t *response, size_t respsz)
+{
     int last_state;
     sd_rsp_type_t rtype;
     int rsplen;
@@ -2231,6 +2232,7 @@ static int sd_do_command(SDState *sd, SDRequest *req,
 
 send_response:
     rsplen = sd_response_size(sd, rtype);
+    assert(rsplen <= respsz);
 
     switch (rtype) {
     case sd_r1:
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 226ff133ff9..3c897e54b72 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -337,7 +337,7 @@ static void sdhci_send_command(SDHCIState *s)
 {
     SDRequest request;
     uint8_t response[16];
-    int rlen;
+    size_t rlen;
     bool timeout = false;
 
     s->errintsts = 0;
@@ -346,7 +346,7 @@ static void sdhci_send_command(SDHCIState *s)
     request.arg = s->argument;
 
     trace_sdhci_send_command(request.cmd, request.arg);
-    rlen = sdbus_do_command(&s->sdbus, &request, response);
+    rlen = sdbus_do_command(&s->sdbus, &request, response, sizeof(response));
 
     if (s->cmdreg & SDHC_CMD_RESPONSE) {
         if (rlen == 4) {
@@ -400,7 +400,7 @@ static void sdhci_end_transfer(SDHCIState *s)
         request.cmd = 0x0C;
         request.arg = 0;
         trace_sdhci_end_transfer(request.cmd, request.arg);
-        sdbus_do_command(&s->sdbus, &request, response);
+        sdbus_do_command(&s->sdbus, &request, response, sizeof(response));
         /* Auto CMD12 response goes to the upper Response register */
         s->rspreg[3] = ldl_be_p(response);
     }
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 6c90a86ab41..3025f8f15f4 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -146,8 +146,9 @@ static uint32_t ssi_sd_transfer(SSIPeripheral *dev, uint32_t val)
             /* manually issue cmd12 to stop the transfer */
             request.cmd = 12;
             request.arg = 0;
-            s->arglen = sdbus_do_command(&s->sdbus, &request, longresp);
-            if (s->arglen <= 0) {
+            s->arglen = sdbus_do_command(&s->sdbus, &request,
+                                         longresp, sizeof(longresp));
+            if (s->arglen == 0) {
                 s->arglen = 1;
                 /* a zero value indicates the card is busy */
                 s->response[0] = 0;
@@ -171,8 +172,9 @@ static uint32_t ssi_sd_transfer(SSIPeripheral *dev, uint32_t val)
             request.cmd = s->cmd;
             request.arg = ldl_be_p(s->cmdarg);
             DPRINTF("CMD%d arg 0x%08x\n", s->cmd, request.arg);
-            s->arglen = sdbus_do_command(&s->sdbus, &request, longresp);
-            if (s->arglen <= 0) {
+            s->arglen = sdbus_do_command(&s->sdbus, &request,
+                                         longresp, sizeof(longresp));
+            if (s->arglen == 0) {
                 s->arglen = 1;
                 s->response[0] = 4;
                 DPRINTF("SD command failed\n");
@@ -333,7 +335,7 @@ static int ssi_sd_post_load(void *opaque, int version_id)
         return -EINVAL;
     }
     if (s->mode == SSI_SD_CMDARG &&
-        (s->arglen < 0 || s->arglen >= ARRAY_SIZE(s->cmdarg))) {
+        (s->arglen >= ARRAY_SIZE(s->cmdarg))) {
         return -EINVAL;
     }
     if (s->mode == SSI_SD_RESPONSE &&
-- 
2.49.0


