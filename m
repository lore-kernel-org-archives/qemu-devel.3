Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9A2C30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 13:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP0Hj-0003JB-9k; Wed, 03 Jul 2024 09:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sP0HX-0003CE-Fj
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 09:44:28 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sP0HT-0005II-Ra
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 09:44:23 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-425624255f3so4533755e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 06:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720014257; x=1720619057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WFpYqp5rjxfqoVFNkV5ty1wgXIJxNR0gcKtNPqFEsXw=;
 b=wXAHU5Bfjvbyb9JCSPgSBajX1Vv3SjRV4nPwiPl4dTZNHoNw5Jy9leJ4HVDwF4F/qT
 IugLQ7goMSmFZz1tk8w9Pdhu4WqYOK449KdqgOsQkFr2fFl0FMd8azSXtNqJxeXU0uTJ
 sh6+PdYP8LaAOd6op6/UygesdD/IoWmhmsSTKtUv+4bAv3hwXtrUKipEELjjWE15uM5h
 nbBbkoxfbvEoropONc+NbRXQUm2NV74ePazBJhUz2GDGJnCdnDERsfnsKsHEM8z0A3sK
 gzTfRsF0F46r4m+kiYt03TZCXTE15aj/Ze8Upt0jz12Sa+nnRcYsahuI/rIetCLnelvS
 QXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720014257; x=1720619057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WFpYqp5rjxfqoVFNkV5ty1wgXIJxNR0gcKtNPqFEsXw=;
 b=FPFWhSPEX1WqLiLWByXWNpzGhJDAAY1V0uyjZ/7U5N7qHVpK8Mo4wRtFWSk6eN/mSn
 aU6feksgWNscMM1Hr8lZgYlxLkypt+9FFe3noi1hXXkqwTWuK5ggsJ0aIRZAWcqHt9P9
 npOkpnx58XcA+nkslWfQy1xcOVuHQaWPYSYPX9xd2gLQXJfORYV79K1ISS1DPHHxIArM
 2u1tdXOdJBemxD3x+QFeeS4bp+OYz1W46vISPdC0/XDxweHQ4OxKBLVgqWCG7EqWptwB
 cTSrHmwvYLA2kthewdvWW0aiAW4dAyIN4XGCNpgO0Bl2QjIdxSyKSvRi5wRPZ1Pun0sr
 umsw==
X-Gm-Message-State: AOJu0YyBT5axLWO7geILjltmkZZ1lEZRXSynVk2nN9DIjZiHSYwXtLSA
 jjhvj74q7aPvk0LBQ2Siwc49v5oqX+zarJtNtLssKbSszT/94u2ED4vSZ3iEi9o4dqBNzXQVrG5
 U
X-Google-Smtp-Source: AGHT+IGB5fmbUyZ+e5pPcvXLTDHFRu7TNmlSd13DWNwN+iBDo+r53vjByqIwAqEtvJTTPMXsTKIqFw==
X-Received: by 2002:a05:600c:6c8a:b0:424:8be4:f2c with SMTP id
 5b1f17b1804b1-426408e507cmr18181915e9.2.1720014257141; 
 Wed, 03 Jul 2024 06:44:17 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09a828sm242059345e9.37.2024.07.03.06.44.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Jul 2024 06:44:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Luc Michel <luc.michel@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-block@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v46 3/5] hw/sd/sdcard: Rename sd_cmd_SEND_OP_COND handler
Date: Wed,  3 Jul 2024 15:43:54 +0200
Message-ID: <20240703134356.85972-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240703134356.85972-1-philmd@linaro.org>
References: <20240703134356.85972-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

The correct command name is 'SD SEND_OP_COND',
rename accordingly.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 04e8fdb262..10f2764a53 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1701,7 +1701,7 @@ static sd_rsp_type_t sd_acmd_SET_WR_BLK_ERASE_COUNT(SDState *sd, SDRequest req)
 }
 
 /* ACMD41 */
-static sd_rsp_type_t sd_acmd_SD_APP_OP_COND(SDState *sd, SDRequest req)
+static sd_rsp_type_t sd_cmd_SEND_OP_COND(SDState *sd, SDRequest req)
 {
     if (sd->state != sd_idle_state) {
         return sd_invalid_state_for_cmd(sd, req);
@@ -2378,7 +2378,7 @@ static const SDProto sd_proto_sd = {
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


