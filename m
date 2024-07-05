Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931FDC38150
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 22:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPr3R-0002F1-11; Fri, 05 Jul 2024 18:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr3O-00025Q-SF
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:05:18 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr3N-0007aE-Ac
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:05:18 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42565670e20so19377125e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 15:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720217114; x=1720821914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u+mjxHhy7ag9Jj4h5zPA6KSJtKNU8/EmUeNgyh9wt48=;
 b=r3Ff95cyFCCiApiPyd+18BKgKEAvhR1AkHoQCYvTknsavYsH2Mr9eci8PcE4wCGVe9
 gxcgvD23k3zM7fUvDAGxj98FUNn3rAmYFzkoMyXxZAGbNlJWPOAJxESNa5zysCbCRtNT
 zm9Nj7dPOmi82yD+rSUxRzvf4gfWIe2Ec9CrDxxFNoaAnnrx2+3OrgAUmOoaffi/8kgu
 4l0t+Qf+LkO/v/Z/bLT/F/uuQLAWnlHr49gJvP7roZdDH8zsJ7CpUUSQyWGMo1Co9cNa
 3TPJ3dWKad41P7kLEqha6w56BM7ek1FkiZQ7BJ+hV85tmLVH9tyby7UEJ2o41nalaDDF
 sr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720217114; x=1720821914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u+mjxHhy7ag9Jj4h5zPA6KSJtKNU8/EmUeNgyh9wt48=;
 b=j2yaI+M6r+g/A6gtUdu4rBoaHfBzmHs8Xm827wL1wz3X5ZwTWVT/JoXyi6vTJckstg
 wv5a1oe4SjOmzYWS54rPxh0224Cp4OX4SfH4BA674X8A/5Ph4NsceUbfdDkn4ys1nULV
 PCTGhFw/44Xo46E7qHJrBe/zuK3nrAIvybxxOztUivsf2x51e5mNmqAzO4GCx5kAZhgR
 uGMHZASw+GEEE+ekyYXbdFJla2fnxjCdgcYOAXgMrtajjcVPr5aUTZtKkfD4g1VClfeA
 tBoZ6NALr9Vqrm9LdH7gE9gFIjqraAWVoJxVBYvo1D9RhioL1VOdzOTddM5l0Z/o/LOK
 r5dA==
X-Gm-Message-State: AOJu0Yzjb2MV5CrnH9N18oKUt36RlpJlNSovEBtomGzSa7UVFzO6gQd5
 BuEmPOO6wst5ECT5S2wph6WlKcjK1+qdxKRKP9QwskYoYQV2w5UU35Zgtlsk5fKaCiIT8S0QQfa
 5
X-Google-Smtp-Source: AGHT+IG91ucEwuVgNZdYu3VrbPnkOP7RhTo9xWU15DZy8m1ePQbhROxtZlmB92K3b7ExC4pBcbO5eA==
X-Received: by 2002:a7b:cc87:0:b0:424:7895:dd45 with SMTP id
 5b1f17b1804b1-4264f2ae75fmr38669035e9.17.1720217114092; 
 Fri, 05 Jul 2024 15:05:14 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.163.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4265f84cd44sm1830465e9.18.2024.07.05.15.05.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jul 2024 15:05:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PULL 07/16] hw/sd/sdcard: Rename sd_cmd_SEND_OP_COND handler
Date: Sat,  6 Jul 2024 00:04:25 +0200
Message-ID: <20240705220435.15415-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240705220435.15415-1-philmd@linaro.org>
References: <20240705220435.15415-1-philmd@linaro.org>
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

The correct command name is 'SD SEND_OP_COND',
rename accordingly.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240703134356.85972-4-philmd@linaro.org>
---
 hw/sd/sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a08a452d81..8618c2bcf0 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1689,7 +1689,7 @@ static sd_rsp_type_t sd_acmd_SET_WR_BLK_ERASE_COUNT(SDState *sd, SDRequest req)
 }
 
 /* ACMD41 */
-static sd_rsp_type_t sd_acmd_SD_APP_OP_COND(SDState *sd, SDRequest req)
+static sd_rsp_type_t sd_cmd_SEND_OP_COND(SDState *sd, SDRequest req)
 {
     if (sd->state != sd_idle_state) {
         return sd_invalid_state_for_cmd(sd, req);
@@ -2392,7 +2392,7 @@ static const SDProto sd_proto_sd = {
         [13] = {8,  sd_adtc, "SD_STATUS", sd_acmd_SD_STATUS},
         [22] = {8,  sd_adtc, "SEND_NUM_WR_BLOCKS", sd_acmd_SEND_NUM_WR_BLOCKS},
         [23] = {8,  sd_ac,   "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
-        [41] = {8,  sd_bcr,  "SD_APP_OP_COND", sd_acmd_SD_APP_OP_COND},
+        [41] = {8,  sd_bcr,  "SEND_OP_COND", sd_cmd_SEND_OP_COND},
         [42] = {8,  sd_ac,   "SET_CLR_CARD_DETECT", sd_acmd_SET_CLR_CARD_DETECT},
         [51] = {8,  sd_adtc, "SEND_SCR", sd_acmd_SEND_SCR},
     },
-- 
2.41.0


