Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C391C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafeL-0007ya-06; Thu, 15 Feb 2024 12:35:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeF-0007wP-Lx
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:49 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeD-0003vf-GR
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:47 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33aea66a31cso641253f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018544; x=1708623344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o1sWdlUMwdMJSSPG+YO8BBCGMSEyFoB8Knca3/0gbTE=;
 b=BU9BXm/bw+NdnSXRz/nr78o8FbUX5cFxVizMipI6nzDzH5Ei0Z6LeeY5omi8dbQuTT
 kojwMAvB/g2wSWv5Ik+OJ36iBA3ElElr6K9HFsU8/IGZN4bBFGcrxKwt38s0q83DSpnK
 9OlmlrMCBEx3+WcW/lFcBNFrTCfZumqxXIa6DLi5zN+XHzhcLDhkZXMWXhY2obYlvNRu
 lX98+VGPo3JABD4nY6sKC1UIoMrT9w23YLuWpkNjt6lehKCOw7QqOlVif/pkwa/dKg/K
 QsBSUG/f3VeuwKq9B9CO+Gd8V8jaumZ/6OR++gn3KVujdsSYSaXSXuRtwjONORMRJGNc
 TDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018544; x=1708623344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o1sWdlUMwdMJSSPG+YO8BBCGMSEyFoB8Knca3/0gbTE=;
 b=BAUv9iVdoB+8xgg3RyeQem3x0gk1nKb8knEoRtdZ33YCSuc/QdqFFqCQNwW7zZOV8P
 szkDRytsEVAegSBniaLigTGruBFeQu9h9OYJr5sNlDIkOVqJUGZ3xmAen4FPsOejyyew
 Y/lqLkzHIVWIvThejJfKYgdXdHWFxuu9gi7iEaMVmNfljRo3WhCrmXB19R9IIH8C4Okt
 CcisvRb2RkH0VDnO0bFclwMGh93wRwxcE8MUYNSEw7feR4073jCl0RLkpaAvjez7uSR0
 h+REDV/6pycY5Vo852OfSw2ePin/1+4QbLmjkX7w5Pd27inkZeq4sAIRc4oknEvFA+8E
 dfWg==
X-Gm-Message-State: AOJu0YxumA8R31gHg3P3BpwmZaMvPpRvkqSOZaS6HowTZuFSHwmiqB1f
 3nN+/LVhsJ3D5rhkcj+oVRUGE0RyTlzzT5Z4NaLS6j+l49FPeFAS4IfuyeqcE/dM+vB0BpZjLSd
 m
X-Google-Smtp-Source: AGHT+IHPEnXdALj4k6LwZAcZNfISks+wFGtzVxViYOfV3Srw2P7YM1ImtShRK+2vkkDRvcazDpDdgA==
X-Received: by 2002:adf:f8d1:0:b0:33b:2100:3a44 with SMTP id
 f17-20020adff8d1000000b0033b21003a44mr2020622wrq.39.1708018543874; 
 Thu, 15 Feb 2024 09:35:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/35] tests/qtest/meson.build: Don't include qtests_npcm7xx in
 qtests_aarch64
Date: Thu, 15 Feb 2024 17:35:13 +0000
Message-Id: <20240215173538.2430599-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

We deliberately don't include qtests_npcm7xx in qtests_aarch64,
because we already get the coverage of those tests via qtests_arm,
and we don't want to use extra CI minutes testing them twice.

In commit 327b680877b79c4b we added it to qtests_aarch64; revert
that change.

Fixes: 327b680877b79c4b ("tests/qtest: Creating qtest for GMAC Module")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240206163043.315535-1-peter.maydell@linaro.org
---
 tests/qtest/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 39557d5ecbb..663338ae124 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -231,7 +231,6 @@ qtests_aarch64 = \
   (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test'] : []) +  \
   (config_all_accel.has_key('CONFIG_TCG') and                                            \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_NPCM7XX') ? qtests_npcm7xx : []) + \
   ['arm-cpu-features',
    'numa-test',
    'boot-serial-test',
-- 
2.34.1


