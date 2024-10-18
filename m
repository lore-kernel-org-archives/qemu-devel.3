Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D14D3000F
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1njZ-0000wy-Os; Fri, 18 Oct 2024 10:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1njX-0000vU-Pb
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:13:39 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1njV-0006x7-8B
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:13:39 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-37d4ba20075so1626595f8f.0
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 07:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729260816; x=1729865616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gtbif3E88e+6/TwfMyavJ5V/o1ksnebzcTF5I6GLPpQ=;
 b=Cuw3XJLYjawlZIRLk1fjtDO8bEIQUb8Nc7mMtnJBwfWddIkpswqrgY6mkAxwRZwjle
 Q9oebyK5hkciDWvY/IujKu9beJGLSTnqUnPHFi0NIBsg6Kq4y88VDmKMRPGVG4Ra7Qus
 ZGmGhpZZCFXnlwqkeE3nCY9UxsM+rPA6z84bwLFsJrRXYIl0vy3WtuJGUYbQNc9/9G4U
 cMShIb+KV9BS+sMNZtl7dFC28UKh7GceKS8ysPvOmkhBNsEaGATWxytRHz+6zKo40Ryh
 tMtIEGd6S6RTGwgo/cE9GoaP5MqZPlaPW9WNIghJdYgib6T9zmcARgmzQcQsYL0xgIPJ
 E3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729260816; x=1729865616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gtbif3E88e+6/TwfMyavJ5V/o1ksnebzcTF5I6GLPpQ=;
 b=pQZHn9yZal0g0HiCuENkFAUC3NVxDtoFG7W4RTt49YuwXs5WsoKdJ9usWIta4eknDy
 NCdzrzf8qQRja9QEUFhd1zQ72/GWXZMK00m15v41HnXdO3RDGCzqg2CsOJAU6hfdVFC5
 lSDfkHtRbyqWncKXGP9qcc6ZGCxjaJVgjEkqk5ihG3ZAMBjOi3Jra3/JirNW1NavXqt4
 uwEn90llqmw+0hK8iJhxGfu/SefuKwtTVUsaBJ81+HF14aym8pSh8b+I7OxSOMUKzsS2
 92zGya0sqA01/CxSg1kyOXk8e/4h5G337B0flg/hW84aBoKlGBMTM9BDHS1QYS4slWXa
 yUrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDRSB/k24z9Q3l1Xgy41A8lFxN2b+faw8F668ufrET840vUV4rTw+F+34GWwXD/sjDhvl9LeWmsQTH@nongnu.org
X-Gm-Message-State: AOJu0YzP89dvQBPpJ7lNYyxoS+jwl8SkW59pjcv8dH5I8CnRnfUIZbv6
 bRUIp7YQlYsE1cn1bQiA498X57RQ9bR5oCLuG/9lMeYJOag1527Dj/ZNsrYo7m8=
X-Google-Smtp-Source: AGHT+IEp+yNVBYg3tGX4pdAvqXy3w7NIVwZmWbVHONAoL1AVUK9Xb0IcINT7gaGzECaX+G4AFBD7WA==
X-Received: by 2002:adf:f587:0:b0:37d:4afe:8c98 with SMTP id
 ffacd0b85a97d-37ea219836emr2093995f8f.26.1729260815779; 
 Fri, 18 Oct 2024 07:13:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ecf0ecd89sm2040086f8f.78.2024.10.18.07.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:13:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 2/7] docs/system/arm: Don't use wildcard '*-bmc' in doc titles
Date: Fri, 18 Oct 2024 15:13:27 +0100
Message-Id: <20241018141332.942844-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018141332.942844-1-peter.maydell@linaro.org>
References: <20241018141332.942844-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

We have two Arm board doc files which both use '*-bmc' in their
documentation title. The result is that when you read the
table of contents in system/target-arm.html you don't know
which boards are covered by which file.

Expand out the board names entirely in the document titles.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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


