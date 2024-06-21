Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D91C2BB85
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZIJ-0005do-Tv; Fri, 21 Jun 2024 04:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZIH-0005Vc-R4
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:06:49 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZIF-0008Kb-L2
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:06:49 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2ec50a5e230so1567201fa.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 01:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718957205; x=1719562005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YQaHBopgwSjXudC8k46XwyUf5aDsciZs6MaYovNVcw4=;
 b=mXPUmOmDtmSfLqeFq53zrSLbHowcI3hZHkqQyVcZ29wboFKUz8p00P6cWI0KDcPnqH
 Hq1Ep8sDbjFineYi/ld50+HUpH1nRE09PGYFTNnOOBLIaitUwjyr7YiACELZhnS0H/lV
 MoHXU5GekmZuFCooFEmrus4WupHeBtg4eN2YLiP3dr9H46amo2j2jcE2++ZWN0MonEHj
 oc2cAZlrA9VytREER94o0tQCoDazN51iAwYQCzqpl1E3m4Rn87WueHQgBOkRyd7H3EvZ
 Qmi17xp1pkKDo/orcLF17L7zUz38JDT6waSE/KL2t29Z0EMoeQd6nCeeoiSzf/f0Ld2o
 LVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718957205; x=1719562005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YQaHBopgwSjXudC8k46XwyUf5aDsciZs6MaYovNVcw4=;
 b=fRbF4KlOAHYiT1Fw7x7azNza6mbwyYz2W1JsqpfMPYg9aBeBry3PItO4nT1KBB+Cx1
 GgusGSGCvOlsRhGkJrr6stuorCio3Pb4F2EEinRWH80kwRTA2tjIK6ISN4asn8DiK5jA
 jSxi+bhu4H0EVeZ6RJd6y8E0u7iGPRftELrDQPSzhSQJfdvlXeOtiXcLQ7AZg9iStcAY
 vqa7V4QzPCpqXyGyTAsCpEzXQngM3zsRpCCiMKkOdHEydsR5Al7rvkcB64+xlQeR4mPm
 ctw8QiSlf8c0pOPoc9boI+svqQ9djgKPmDPXQ13wTHzXNGq8uxg14g1zRQovkwC75oll
 DJTQ==
X-Gm-Message-State: AOJu0Yw02FW7ZUcsC2pDwgMfJqY1x9E5Uo7h0L6GQ+0tw7x8vqKlkxQj
 ahv8BGJYJ1AsfL3CaP/HK3YqSI/LePsvHCbJuvMoI/XJAtw7fn3adwGflPwXxjPC/+yycmzFr3z
 1
X-Google-Smtp-Source: AGHT+IHC36reLkPQEaKj3Cld22JOWPAHwya+F/z+KxieWbZiqTLfC59sBHN/1YungtgqqTyw03hiDA==
X-Received: by 2002:a2e:8701:0:b0:2ec:f68:51de with SMTP id
 38308e7fff4ca-2ec3cffc8c5mr49170631fa.47.1718957205286; 
 Fri, 21 Jun 2024 01:06:45 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.128.209])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424817a8ec8sm16809315e9.11.2024.06.21.01.06.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Jun 2024 01:06:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
Subject: [PATCH 08/23] hw/sd/sdcard: Remove explicit entries for illegal
 commands
Date: Fri, 21 Jun 2024 10:05:39 +0200
Message-ID: <20240621080554.18986-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240621080554.18986-1-philmd@linaro.org>
References: <20240621080554.18986-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

NULL handler is already handled as illegal, no need to
duplicate (that keeps this array simpler to maintain).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index e9af834a8c..30239b28bc 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2146,12 +2146,6 @@ static const SDProto sd_proto_spi = {
     .cmd = {
         [0]         = sd_cmd_GO_IDLE_STATE,
         [1]         = spi_cmd_SEND_OP_COND,
-        [2 ... 4]   = sd_cmd_illegal,
-        [5]         = sd_cmd_illegal,
-        [7]         = sd_cmd_illegal,
-        [15]        = sd_cmd_illegal,
-        [26]        = sd_cmd_illegal,
-        [52 ... 54] = sd_cmd_illegal,
     },
     .acmd = {
         [41]        = spi_cmd_SEND_OP_COND,
@@ -2162,15 +2156,10 @@ static const SDProto sd_proto_sd = {
     .name = "SD",
     .cmd = {
         [0]         = sd_cmd_GO_IDLE_STATE,
-        [1]         = sd_cmd_illegal,
         [2]         = sd_cmd_ALL_SEND_CID,
         [3]         = sd_cmd_SEND_RELATIVE_ADDR,
-        [5]         = sd_cmd_illegal,
         [19]        = sd_cmd_SEND_TUNING_BLOCK,
         [23]        = sd_cmd_SET_BLOCK_COUNT,
-        [52 ... 54] = sd_cmd_illegal,
-        [58]        = sd_cmd_illegal,
-        [59]        = sd_cmd_illegal,
     },
 };
 
-- 
2.41.0


