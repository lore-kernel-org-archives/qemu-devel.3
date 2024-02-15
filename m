Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AF7C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafeR-00082t-Fc; Thu, 15 Feb 2024 12:36:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeI-0007xj-KM
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:50 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeF-0003ws-8q
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:50 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-411fc50e4e9so8886985e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018545; x=1708623345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pnWE++gx7MRP5kpOVN2tye4nGgQTNdzxPucfDmj9R2E=;
 b=ftyh7a5nU7N46CiArvyJfR2PB2okYBUCs9GQ6GsGHaotF4n730MEt1+bumJVPzRBJk
 0vGlcsBATOzINyH/PMSpd6z6mlWjwnfJRbQ5fwlttqD+FokAlHp/jMfPL3jrbB5YCe1h
 Rbdtqs53uyLKUT7Fe/FGo8kjDP2PhyMkP6ASntiLFzo4Jz30yfXDMYsXubftUPfUV9f6
 sjlgfRRjaaMGZzpPww61BKl/af4xi1pZglsiGasOp4sE8cTscDA2vGZUej3O96WPXH6j
 Le/zw1fWAloxh/Vln2+Qqoh0ipRQ59hTKkPtJU1iygjhxtkOB5/2vEfJZ1S+6ie78Wg3
 rkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018545; x=1708623345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pnWE++gx7MRP5kpOVN2tye4nGgQTNdzxPucfDmj9R2E=;
 b=i8f3s47TL0eNRMiGeiSg74lNIUJR1E17Cf9WLRcpKFWL3WYTJCiwqIXLEmxhV7W7ix
 Qyp427LvbcmsAA1lCfPSiVcvxBy1Fw6MlxPoFxNRlW3AhYAWGZP/KY8gB+kUqVUscVtr
 qP1MnMYm5qGGRi0pl/F8cvSPjBuejUWWDf23o7mqOfHZMBKwyal5ivsqwxUIQCFwQJkv
 Mrdda43u0H2FtCuw+P7qTQK06FzrV+tDRczbxVn2GXH/ibpNKT6xjhnUFfw15VUMjKIX
 cIgHgs2QvfGBAQQADE2F6klURjMqrXy9mc/Oz7c/Tggaj25gJvS1RMEpa5OonwrCDLPy
 hZ1A==
X-Gm-Message-State: AOJu0YzXJVhHcEXTkrB0l3mxSVTW4Asj3+invAcYckV0rsF3/6SQHuzG
 ZhzcBQuUab/nlUi3kyC1unq9g8ADl+qzjgfpJfzuu7TvH1P14upOkXDddEuDzTMz+EpWoxfW1XJ
 O
X-Google-Smtp-Source: AGHT+IFwisWHUbExawEftRMoNavhVo0j+o5jjmweFDb76UKsg9esbdVflLX9sNMQYJ4YX09lFpgPKQ==
X-Received: by 2002:adf:e741:0:b0:336:6a76:40cd with SMTP id
 c1-20020adfe741000000b003366a7640cdmr2071789wrn.62.1708018545593; 
 Thu, 15 Feb 2024 09:35:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/35] hw/arm/npcm7xx: Call qemu_configure_nic_device() for
 GMAC modules
Date: Thu, 15 Feb 2024 17:35:17 +0000
Message-Id: <20240215173538.2430599-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The patchset adding the GMAC ethernet to this SoC crossed in the
mail with the patchset cleaning up the NIC handling. When we
create the GMAC modules we must call qemu_configure_nic_device()
so that the user has the opportunity to use the -nic commandline
option to create a network backend and connect it to the GMACs.

Add the missing call.

Fixes: 21e5326a7c ("hw/arm: Add GMAC devices to NPCM7XX SoC")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Message-id: 20240206171231.396392-2-peter.maydell@linaro.org
---
 hw/arm/npcm7xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index ff3ecde9043..cc68b5d8f12 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -710,6 +710,7 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < ARRAY_SIZE(s->gmac); i++) {
         SysBusDevice *sbd = SYS_BUS_DEVICE(&s->gmac[i]);
 
+        qemu_configure_nic_device(DEVICE(sbd), false, NULL);
         /*
          * The device exists regardless of whether it's connected to a QEMU
          * netdev backend. So always instantiate it even if there is no
-- 
2.34.1


