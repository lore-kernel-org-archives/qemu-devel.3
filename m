Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E819C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZIt-0007PL-Ow; Fri, 21 Jun 2024 04:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZIr-0007Fa-Rg
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:07:25 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZIp-0008U0-DE
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:07:25 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4218008c613so15603365e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 01:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718957241; x=1719562041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=udWWj272g9nUODajXENG5MjPbFRaI4fbT7wamp0YglI=;
 b=fFkYC12Qwzn4AFZL72k+EJ/gVAQ3uO2+NbxJG2gmy9WLZvFr+8f/TLq7Vb4h4zc0ay
 CUCX/IlKNUQMvjWXigY5EXdO/f/0izP/2FVTTJgWMo5FSJO3r9rL2FPLfSJN4pfeZ3KH
 n0c17iiffMc1Dlj7+z3osEHyNbJzabMmmuiJX97iYTuCcoJc9nE3+2ORNpmiTgLOYFUX
 7zKKR2uVyYmHFh7SSZZY+mPeMvb/Cc6qs9pVFz9SbzjlXWgNJHLJokUr7kRKymYpDbF3
 tVkfsTs+t7+T0D+ND6Qu+SXcBkvz8xPriG1sK4LoV1M/phICXJJ8GANZxcXzI6lEyMdK
 /m3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718957241; x=1719562041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=udWWj272g9nUODajXENG5MjPbFRaI4fbT7wamp0YglI=;
 b=OSp2/E2MSiZcaj4/jj7tK5tp6nnKGRd73CaSZL6E6W3qQ2STGTJPWvkD2h/b8VdD+2
 bcVYijzHzN99naeIeU5E7WraoTuNPGq86G5ex20n8nZLlNJfCF0rITfqbOt2CufyJ89D
 1pWIvrepO85bTaEggh89cTMLouZjX6+6tpfMmOfufoAU6NDLqkCDJh5Gy2P1jvFmbz5E
 pDQAJqRiwock1+Mt92zxRRtMm4DSuFoX2WB6twJ+EeHSN0y9vBgizMdWdJOxII7R7Rbj
 SgM4Vbz2W49lAIFEenkDtRor1O/xW7o8YkJ851Hoz/iADKc8oNu/TkhBMUFEhYKZNhVU
 HFow==
X-Gm-Message-State: AOJu0YyjdX+pu3em8+jMVViMf3TN4lTMkqJ+3/8tZtyLY9Hs/vzMbCf6
 87Br7N7hGq2RAhvmvonm2EChtsz+Y3z6OgOV+jyW0qCmBNnHAMtxFSX+elFlxOZDN6ZAk3UXbZS
 v
X-Google-Smtp-Source: AGHT+IFXanEhUXqVengTV9gDjzhJvsGEFQayGRw2kyH8U6xphhj8u5YxikBlrABG0zISHdO+NyLkHg==
X-Received: by 2002:a05:600c:1d17:b0:424:760d:75ce with SMTP id
 5b1f17b1804b1-424760d777fmr56755815e9.7.1718957241673; 
 Fri, 21 Jun 2024 01:07:21 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.128.209])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d21225fsm51975745e9.42.2024.06.21.01.07.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Jun 2024 01:07:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
Subject: [PATCH 14/23] hw/sd/sdcard: Factor sd_req_get_rca() method out
Date: Fri, 21 Jun 2024 10:05:45 +0200
Message-ID: <20240621080554.18986-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240621080554.18986-1-philmd@linaro.org>
References: <20240621080554.18986-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Extract sd_req_get_rca() so we can re-use it in various
SDProto handlers. Return a 16-bit value since RCA is 16-bit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 510784fc82..bc47ae36bc 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -471,6 +471,14 @@ static void sd_set_csd(SDState *sd, uint64_t size)
     sd->csd[15] = (sd_crc7(sd->csd, 15) << 1) | 1;
 }
 
+static uint16_t sd_req_get_rca(SDState *s, SDRequest req)
+{
+    if (sd_cmd_type[req.cmd] == sd_ac || sd_cmd_type[req.cmd] == sd_adtc) {
+        return req.arg >> 16;
+    }
+    return 0;
+}
+
 FIELD(CSR, AKE_SEQ_ERROR,               3,  1)
 FIELD(CSR, APP_CMD,                     5,  1)
 FIELD(CSR, FX_EVENT,                    6,  1)
@@ -1094,7 +1102,7 @@ static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
 
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
-    uint32_t rca = 0x0000;
+    uint16_t rca = sd_req_get_rca(sd, req);
     uint64_t addr = (sd->ocr & (1 << 30)) ? (uint64_t) req.arg << 9 : req.arg;
 
     sd->last_cmd_name = sd_cmd_name(req.cmd);
@@ -1110,11 +1118,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     /* Not interpreting this as an app command */
     sd->card_status &= ~APP_CMD;
 
-    if (sd_cmd_type[req.cmd] == sd_ac
-        || sd_cmd_type[req.cmd] == sd_adtc) {
-        rca = req.arg >> 16;
-    }
-
     /* CMD23 (set block count) must be immediately followed by CMD18 or CMD25
      * if not, its effects are cancelled */
     if (sd->multi_blk_cnt != 0 && !(req.cmd == 18 || req.cmd == 25)) {
-- 
2.41.0


