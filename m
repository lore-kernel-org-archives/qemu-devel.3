Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0327CC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZHo-00057C-La; Fri, 21 Jun 2024 04:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZHm-00056V-BQ
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:06:18 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZHk-0008Fw-Pb
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:06:18 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42172ed3487so13302575e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 01:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718957175; x=1719561975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pu4cWh3N72k6gRC8kFx27gDVkEmn2smaKl61IHZHwJg=;
 b=Ov4sQ7DMrQY8biM04HD4OZjf9Zecy6zEKusPFlAKSppX5DpswFUCLb8uNdQpf0k3Ib
 SLfnsJicF/qDABTSZ2drRU5fb9smhlAzZWzlmnL2Qa5acKA4xKOwMP6JaJefy54F9hxc
 2GO+fMe+ocxEMgOgZ0Tm2quAW1+1aXPz8DZCgufqOgiP6FRNgqr15X6KoMDrJ4zoJBpQ
 rzUDTVUHlI0S6Nz+wLBvqu4P+x7aMXXdhZKxA8ofKDv+QXGDMkaKktnV/COWHrOiVKwZ
 S5N/DbX5MnDcAgB0KJ7Mfq5PASBFtnQVOWGvvZ/Rxs7C+LgWoWfy1L077Jqzucq/+RzE
 SFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718957175; x=1719561975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pu4cWh3N72k6gRC8kFx27gDVkEmn2smaKl61IHZHwJg=;
 b=rsLB/St8KfO8DoGD2sG0Q+ntxKe6Z5Mlm6KB1YT8cUZuwqxfbfOYTIdwbiw5Oh6gGD
 VBiMPZpp1T+1gM0j1ImOG9KSSzksBee5BAPo6/ACriPjNpclv5chZXvoTFZaqRnCNxvV
 XLEwvDoTOoq/26FpIAp5Tp/S0VWM1cDEDjAAY8jCDcLas2KtKhm2WxEpQztU/2Z4cjSY
 EhAw4QbchdLs2fThtVfvnmX8mdyy4fPjPA+yipe8P8H4tEEyjtnCs7LaRWeF9j3gydex
 BeWvdNCF20OmAVj/OvDakZXmc2BBJK/oRAZju9QtAIXfSRSFMSh8/X3owA2YCeG+qpI6
 NGvQ==
X-Gm-Message-State: AOJu0YyYvVpwbI+XCDK+tL3+CDjksabKXYBiBX0ap1/7Z1ltJkf0HhEe
 isXpxMEuAdbI25tsYw1VyRlrXytpf5NbpbmxJNDY12EzKilXQc6CXL1XJOdM4jyk9jWWJ71MXZ5
 8
X-Google-Smtp-Source: AGHT+IHw9UIkgCZdS2jUur/imsKcxb6Fz2To7eE/eQyypDnA00AViuCKXyVoXeWAdWI9Ezd9IDJ64A==
X-Received: by 2002:a05:600c:1608:b0:421:8e64:5f23 with SMTP id
 5b1f17b1804b1-4247507a472mr51467355e9.5.1718957174775; 
 Fri, 21 Jun 2024 01:06:14 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.128.209])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d0beb08sm53830685e9.17.2024.06.21.01.06.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Jun 2024 01:06:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
Subject: [PATCH 03/23] hw/sd/sdcard: Fix typo in SEND_OP_COND command name
Date: Fri, 21 Jun 2024 10:05:34 +0200
Message-ID: <20240621080554.18986-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240621080554.18986-1-philmd@linaro.org>
References: <20240621080554.18986-1-philmd@linaro.org>
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

There is no SEND_OP_CMD but SEND_OP_COND.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c             | 6 +++---
 hw/sd/sdmmc-internal.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index addeb1940f..331cef5779 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1035,7 +1035,7 @@ static sd_rsp_type_t sd_cmd_GO_IDLE_STATE(SDState *sd, SDRequest req)
     return sd_is_spi(sd) ? sd_r1 : sd_r0;
 }
 
-static sd_rsp_type_t sd_cmd_SEND_OP_CMD(SDState *sd, SDRequest req)
+static sd_rsp_type_t spi_cmd_SEND_OP_COND(SDState *sd, SDRequest req)
 {
     sd->state = sd_transfer_state;
 
@@ -2149,7 +2149,7 @@ static const SDProto sd_proto_spi = {
     .name = "SPI",
     .cmd = {
         [0]         = sd_cmd_GO_IDLE_STATE,
-        [1]         = sd_cmd_SEND_OP_CMD,
+        [1]         = spi_cmd_SEND_OP_COND,
         [2 ... 4]   = sd_cmd_illegal,
         [5]         = sd_cmd_illegal,
         [7]         = sd_cmd_illegal,
@@ -2159,7 +2159,7 @@ static const SDProto sd_proto_spi = {
     },
     .acmd = {
         [6]         = sd_cmd_unimplemented,
-        [41]        = sd_cmd_SEND_OP_CMD,
+        [41]        = spi_cmd_SEND_OP_COND,
     },
 };
 
diff --git a/hw/sd/sdmmc-internal.c b/hw/sd/sdmmc-internal.c
index 8648a7808d..c1d5508ae6 100644
--- a/hw/sd/sdmmc-internal.c
+++ b/hw/sd/sdmmc-internal.c
@@ -14,7 +14,7 @@
 const char *sd_cmd_name(uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-         [0]    = "GO_IDLE_STATE",           [1]    = "SEND_OP_CMD",
+         [0]    = "GO_IDLE_STATE",           [1]    = "SEND_OP_COND",
          [2]    = "ALL_SEND_CID",            [3]    = "SEND_RELATIVE_ADDR",
          [4]    = "SET_DSR",                 [5]    = "IO_SEND_OP_COND",
          [6]    = "SWITCH_FUNC",             [7]    = "SELECT/DESELECT_CARD",
-- 
2.41.0


