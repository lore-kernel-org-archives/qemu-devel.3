Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FCBC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTn8H-0002WH-Nx; Tue, 16 Jul 2024 14:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTn8F-0002Nq-KX
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:42:35 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTn8D-0007O3-Th
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:42:35 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42793fc0a6dso40012845e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 11:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721155352; x=1721760152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I6ZYXjZ35vpvV2u+NeAW2X7raSm2BD4OmCcWt2JDsuc=;
 b=xrA9UdzArwhEwgeN1HOtavrWyivZ5QUawsEkyvOHI33mHxWEYJ/tL3bPI5PjG/CL0W
 3thljz3/hKFOw/QQW1cBlc6qoLmxZU8PHPCE2uyKc9/DZqnyxNF4nGZRPh5QbKFlT5sU
 KGR/5lwXXZTehl3F4D09Y8hXHA81/dv84Vg4d57oFOk6pphi3MLsiGQIQ2vkKO6wPugG
 CYaPCnAPLgK7lo1Q73/2i9R7DfZMS4oNcCJfcyw8wXKmbKCTHz1GNrcZPb9ChdI83L5W
 NudkvpgYpHa7pw7kfU3Oe+P04SeoQR+UjIQ0bHZZw3o5mk1npl1mHENHRU3UGtPLjxjg
 Rf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721155352; x=1721760152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I6ZYXjZ35vpvV2u+NeAW2X7raSm2BD4OmCcWt2JDsuc=;
 b=JK3+B50U7SzErH1IUeB77tCyzPFWnanPrMbptTJ1Yge5igjY1Zy6Kgkq1LLLvPLq/i
 tQeSUDj574sZ2nirtq7QFcv6HNNJyhoa1FZK4TWFKqEjoMemnaTSmoxwNYK41JbanQQp
 d/z7dSEe5d+M7lvOf5KTfZXW5G3bSNUziNUpuzRP/bxm2iH9U/czsW92lMYBG1MMoA6k
 bVyBtxlant2FCpwMOINgjGAFyOWZlb249XScnkecXWa8ZC7NE1VVLYhQJkDKr3fWEyNB
 iaTcoIpD78WEN6dg+ZazUYcAnydEw6/ibjE5Z1Be8z52T/ZtYOwg1fgirTkQhntEt5M/
 PADA==
X-Gm-Message-State: AOJu0Yzb/Ita0ygWf1HXxBsmigHkvsEBAGzqlisB8e1PVi2GCDzGeeqh
 9V+OjSmKXLUJnWEHeI9u3nVRv4mnVBYaS/1iVp1c0tDNpDYA6RCYvk3+ud6BVD3YnYrTZ1wDFg6
 GRqKRvg==
X-Google-Smtp-Source: AGHT+IE7q9cPlKfXZ3dpxH23bEYXAL4mB7DfDKChCUrn+8REZFiJwxv7wlrA47VPYSQi8/8xBQr3Lw==
X-Received: by 2002:a05:600c:474f:b0:427:9dad:e6ac with SMTP id
 5b1f17b1804b1-427ba6b1200mr21414755e9.34.1721155352363; 
 Tue, 16 Jul 2024 11:42:32 -0700 (PDT)
Received: from localhost.localdomain ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680db0ee46sm9695377f8f.114.2024.07.16.11.42.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jul 2024 11:42:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/11] hw/sd/sdcard: Implement eMMC sleep state (CMD5)
Date: Tue, 16 Jul 2024 20:41:40 +0200
Message-ID: <20240716184144.42463-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240716184144.42463-1-philmd@linaro.org>
References: <20240716184144.42463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

From: Luc Michel <luc.michel@amd.com>

The JEDEC standards specifies a sleep state where the eMMC won't
answer any command appart from RESET and WAKEUP and go to low power
state.  Implement this state and the corresponding command number 5.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240712162719.88165-8-philmd@linaro.org>
---
 hw/sd/sd.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a90612af58..d98952a12f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1236,8 +1236,19 @@ static sd_rsp_type_t sd_cmd_to_sendingdata(SDState *sd, SDRequest req,
 /* CMD0 */
 static sd_rsp_type_t sd_cmd_GO_IDLE_STATE(SDState *sd, SDRequest req)
 {
-    sd->state = sd_idle_state;
-    sd_reset(DEVICE(sd));
+    if (sd->state == sd_sleep_state) {
+        switch (req.arg) {
+        case 0x00000000:
+        case 0xf0f0f0f0:
+            break;
+        default:
+            return sd_r0;
+        }
+    }
+    if (sd->state != sd_inactive_state) {
+        sd->state = sd_idle_state;
+        sd_reset(DEVICE(sd));
+    }
 
     return sd_is_spi(sd) ? sd_r1 : sd_r0;
 }
@@ -1294,6 +1305,30 @@ static sd_rsp_type_t emmc_cmd_SET_RELATIVE_ADDR(SDState *sd, SDRequest req)
     }
 }
 
+/* CMD5 */
+static sd_rsp_type_t emmc_cmd_sleep_awake(SDState *sd, SDRequest req)
+{
+    bool do_sleep = extract32(req.arg, 15, 1);
+
+    switch (sd->state) {
+    case sd_sleep_state:
+        if (!do_sleep) {
+            /* Awake */
+            sd->state = sd_standby_state;
+        }
+        return sd_r1b;
+
+    case sd_standby_state:
+        if (do_sleep) {
+            sd->state = sd_sleep_state;
+        }
+        return sd_r1b;
+
+    default:
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+}
+
 /* CMD6 */
 static sd_rsp_type_t sd_cmd_SWITCH_FUNCTION(SDState *sd, SDRequest req)
 {
@@ -1696,6 +1731,7 @@ static sd_rsp_type_t sd_cmd_APP_CMD(SDState *sd, SDRequest req)
     case sd_ready_state:
     case sd_identification_state:
     case sd_inactive_state:
+    case sd_sleep_state:
         return sd_invalid_state_for_cmd(sd, req);
     case sd_idle_state:
         if (!sd_is_spi(sd) && sd_req_get_rca(sd, req) != 0x0000) {
@@ -2018,6 +2054,12 @@ int sd_do_command(SDState *sd, SDRequest *req,
         req->cmd &= 0x3f;
     }
 
+    if (sd->state == sd_sleep_state && req->cmd) {
+        qemu_log_mask(LOG_GUEST_ERROR, "SD: Card is sleeping\n");
+        rtype = sd_r0;
+        goto send_response;
+    }
+
     if (sd->card_status & CARD_IS_LOCKED) {
         if (!cmd_valid_while_locked(sd, req->cmd)) {
             sd->card_status |= ILLEGAL_COMMAND;
@@ -2467,6 +2509,7 @@ static const SDProto sd_proto_emmc = {
         [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
         [3]  = {0,  sd_ac,   "SET_RELATIVE_ADDR", emmc_cmd_SET_RELATIVE_ADDR},
         [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
+        [5]  = {0,  sd_ac,   "SLEEP/AWAKE", emmc_cmd_sleep_awake},
         [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
         [9]  = {0,  sd_ac,   "SEND_CSD", sd_cmd_SEND_CSD},
         [10] = {0,  sd_ac,   "SEND_CID", sd_cmd_SEND_CID},
-- 
2.41.0


