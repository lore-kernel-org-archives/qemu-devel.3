Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8178DD3A66B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5nui-0004nO-NS; Tue, 29 Oct 2024 11:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5ns9-0000ok-Us
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:11:07 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5ns2-0007hq-FQ
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:11:05 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43152b79d25so51114605e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730214655; x=1730819455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MGJ4r5UnfAoORr2hiUvGBmjp7lq01tEi3+8nwdqcv5E=;
 b=k827zQvq3JglsVp4kn91oZlaoHApcUAzgXJUToal6dfQUTS+V3NNeO3JxvpKCUdvra
 n7UpiM+UsjctGTf7jU8ikeYor88EfCjdFWWByieLhzKQelCbTJhGH1UAiO3K8Ts6jWMe
 xmZ9hEYXXIIC4K3ucsW423OLz3buB57pyjYHeBieHsRR54sfmJ6JcguNcL0oxKcUdMXD
 0I9s7xo1AHSCT/2c84NHPk1y78+DOjsDLE9Wsd8jWhrl4ZbEZeUUvLr9hNPKN9HvuQxb
 JB6iqBeP1b+4YCx1pk/X5rdF/bOJ/GNt9m/6hYIEWRqBLTH798YYIXdQbyvVArJulqcG
 YGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730214655; x=1730819455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MGJ4r5UnfAoORr2hiUvGBmjp7lq01tEi3+8nwdqcv5E=;
 b=YiZ+1lKjaI2O5itucdOrfQij0v8rsvVJl7pkk0K1rk7+q5YNYnUScfEHbCRNb4Dkhz
 5oa6CJ+LPc4PjAvN1X6YTGqZdsUoC+YoxVdEyPHDIjV/r1BaOFzkxVP9PuzfSysclIly
 4QSO6OcprqQqGNj+qO1j7L+oRTIo+uxo2effvaLwWDcFzvO1KKHWbySfM8VRDuIbwONT
 tpJjLIXBH9Xc4OyZdzwqZe/MfYeEvRifMTGP71nJlexZCKfSljpo59PuyHuw0BJ4BMSA
 Wd4tD5ChpeoGXIIHZkzMOZWl5lEHDH59ZtTVFLWlQSNm8HZK5adxGgkam//h3HxJbMgk
 nNfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW78oZ5fS4nQaINpyLYKjewCSr1AIhs5Ie3rmPjg6FFmR2TS7fQ29JUXfUW+JI/FlnAKUK4Tvni1cAd@nongnu.org
X-Gm-Message-State: AOJu0Yz/BdFnI3u4B9WvN0qLKTkELzJAAtt+VlMztXXEyf5ZcyMEmSrS
 j80RCe8MVb9YcR/bZqx1VKgMe/IiXtvH1aiXDDfLKjcFEPYsQOm2reCIXORuzCI=
X-Google-Smtp-Source: AGHT+IHXiXAu7smIuST46V14s8IoEc2ghIv5mBMCl16u+0QdoPCTxsRyfwWjmq465IbOPsf4Os6trA==
X-Received: by 2002:a05:600c:1d15:b0:431:4a83:2d80 with SMTP id
 5b1f17b1804b1-4319ab94761mr104885775e9.0.1730214655203; 
 Tue, 29 Oct 2024 08:10:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4319360cc2esm146835865e9.44.2024.10.29.08.10.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 08:10:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PULL 10/18] docs/system/arm: Don't use wildcard '*-bmc' in doc titles
Date: Tue, 29 Oct 2024 15:10:40 +0000
Message-Id: <20241029151048.1047247-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029151048.1047247-1-peter.maydell@linaro.org>
References: <20241029151048.1047247-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

We have two Arm board doc files which both use '*-bmc' in their
documentation title. The result is that when you read the
table of contents in system/target-arm.html you don't know
which boards are covered by which file.

Expand out the board names entirely in the document titles.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-id: 20241018141332.942844-3-peter.maydell@linaro.org
---
 docs/system/arm/aspeed.rst  | 4 ++--
 docs/system/arm/nuvoton.rst | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index 6733ffd2b94..968ba88b997 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -1,5 +1,5 @@
-Aspeed family boards (``*-bmc``, ``ast2500-evb``, ``ast2600-evb``, ``ast2700-evb``)
-===================================================================================
+Aspeed family boards (``ast2500-evb``, ``ast2600-evb``, ``ast2700-evb``, ``bletchley-bmc``, ``fuji-bmc``, ``fby35-bmc``, ``fp5280g2-bmc``, ``g220a-bmc``, ``palmetto-bmc``, ``qcom-dc-scm-v1-bmc``, ``qcom-firework-bmc``, ``quanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bmc``, ``sonorapass-bmc``, ``supermicrox11-bmc``, ``tiogapass-bmc``, ``tacoma-bmc``, ``witherspoon-bmc``, ``yosemitev2-bmc``)
+========================================================================================================================================================================================================================================================================================================================================================================================================
 
 The QEMU Aspeed machines model BMCs of various OpenPOWER systems and
 Aspeed evaluation boards. They are based on different releases of the
diff --git a/docs/system/arm/nuvoton.rst b/docs/system/arm/nuvoton.rst
index 0424cae4b01..05059378e55 100644
--- a/docs/system/arm/nuvoton.rst
+++ b/docs/system/arm/nuvoton.rst
@@ -1,5 +1,5 @@
-Nuvoton iBMC boards (``*-bmc``, ``npcm750-evb``, ``quanta-gsj``)
-================================================================
+Nuvoton iBMC boards (``kudo-bmc``, ``mori-bmc``, ``npcm750-evb``, ``quanta-gbs-bmc``, ``quanta-gsj``)
+=====================================================================================================
 
 The `Nuvoton iBMC`_ chips (NPCM7xx) are a family of ARM-based SoCs that are
 designed to be used as Baseboard Management Controllers (BMCs) in various
-- 
2.34.1


