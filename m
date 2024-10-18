Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CE5D3000F
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1njb-0000yP-Oq; Fri, 18 Oct 2024 10:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1njZ-0000x2-Kh
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:13:41 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1njX-0006yE-QC
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:13:41 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4314fa33a35so21462345e9.1
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 07:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729260818; x=1729865618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=quF+uJRumwJtdROayPVjONeUFJ/tj9KRPQQ2lXyyT3U=;
 b=rDRb8lpKxv+H33sB+R3UmUk+1E1bz8PYRWmk5NrAnRWgieCEcdBvYTcnBQzNfoS/bh
 ZoJ9qdtmPU5TdnHARHzny2/9w/sWAWs2CfUmqzcjeXKiDCGFedeVx1IFi3Qwfwmt7HTz
 cyftjB6EBgrqTg67hqPEXDYVgReBC//ttJjmvgtXVCrpXyY1dyu4/S9zraP415xbWq3F
 ejH0Ajrou/GVPZF0gDuXl9kLSjQTsQvthp39CSUiCic13I8t4Jk8C1yarFWlW29qhawF
 GOLwk+/W4cr9SUAecCuSys1bEPI1QVQqlUt17w1ZKuRNmxvWgMCQCgrTW/tgdiVV+Czn
 i7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729260818; x=1729865618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=quF+uJRumwJtdROayPVjONeUFJ/tj9KRPQQ2lXyyT3U=;
 b=Zr7v2mB8pyUWwaayOLETp3A9EPzFpWPEVyEO4tY2O09ty/63p8PjzcvmG04mgtA5y9
 i67APpXihLaLrC5mmkfiawcp66BnZ+SLG7+ToTZNWyIUnB9ZgHENR9OtOVSjB36qWn2l
 zfuuXG9W3KMrZEduv+5b+7VdQAx1t6S0zakn37pMH+r20k/BxUAcFNQfGglGMUBNclPo
 po8chRE5/4sTdBA4AFDgSu2qPdRdSd3IEum5Ji4oaNKfrUPrNk3okaSkkXNdj0LDB+g9
 tzwx0sM/5Xbz1nqCsR5KJsUxlHIa3W9Xf1+bye3CDE1oUuaYhV0hZ5/EB2CfKD9xGiqR
 006A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX99n2vgEEWPSSmFnbqD8PYCY6gTpJcug5rIEv3ZXu0/jnFJ7XPWcMOQeQl1p/nHWIRv/SnPGVYUIEf@nongnu.org
X-Gm-Message-State: AOJu0YwWvK16brNRINEQ+mq8jvZgNnXiB3poNd8XM1FW7G8hk5LoTOEa
 r1SLeZIjPVTSsy/iWehoZ4skegoT17RFKFmqQmhsnpP9RXwzomlmlpvx2YkLTkU=
X-Google-Smtp-Source: AGHT+IGfEWp8+522pUK623v9sU5CUUEYA7S+3C3k2C/8OwdcFBQGKN7dEQnYWD9f7yeSwUUB1CLIgQ==
X-Received: by 2002:a5d:6b85:0:b0:37d:39aa:b9f4 with SMTP id
 ffacd0b85a97d-37eab6ee783mr1841212f8f.26.1729260818251; 
 Fri, 18 Oct 2024 07:13:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ecf0ecd89sm2040086f8f.78.2024.10.18.07.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:13:38 -0700 (PDT)
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
Subject: [PATCH 6/7] docs/system/arm: Add placeholder docs for mcimx6ul-evk
 and mcimx7d-sabre
Date: Fri, 18 Oct 2024 15:13:31 +0100
Message-Id: <20241018141332.942844-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018141332.942844-1-peter.maydell@linaro.org>
References: <20241018141332.942844-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Add placeholder docs for the mcimx6ul-evk and mcimx7d-sabre boards.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                       | 2 ++
 docs/system/arm/mcimx6ul-evk.rst  | 5 +++++
 docs/system/arm/mcimx7d-sabre.rst | 5 +++++
 docs/system/target-arm.rst        | 2 ++
 4 files changed, 14 insertions(+)
 create mode 100644 docs/system/arm/mcimx6ul-evk.rst
 create mode 100644 docs/system/arm/mcimx7d-sabre.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c3325628c9..2866737261b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -791,6 +791,7 @@ F: hw/arm/fsl-imx6ul.c
 F: hw/misc/imx6ul_ccm.c
 F: include/hw/arm/fsl-imx6ul.h
 F: include/hw/misc/imx6ul_ccm.h
+F: docs/system/arm/mcimx6ul-evk.rst
 
 MCIMX7D SABRE / i.MX7
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -804,6 +805,7 @@ F: include/hw/arm/fsl-imx7.h
 F: include/hw/misc/imx7_*.h
 F: hw/pci-host/designware.c
 F: include/hw/pci-host/designware.h
+F: docs/system/arm/mcimx7d-sabre.rst
 
 MPS2 / MPS3
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/docs/system/arm/mcimx6ul-evk.rst b/docs/system/arm/mcimx6ul-evk.rst
new file mode 100644
index 00000000000..8871138ab3e
--- /dev/null
+++ b/docs/system/arm/mcimx6ul-evk.rst
@@ -0,0 +1,5 @@
+NXP MCIMX6UL-EVK (``mcimx6ul-evk``)
+===================================
+
+The ``mcimx6ul-evk`` machine models the NXP i.MX6UltraLite Evaluation Kit
+MCIMX6UL-EVK development board. It has a single Cortex-A7 CPU.
diff --git a/docs/system/arm/mcimx7d-sabre.rst b/docs/system/arm/mcimx7d-sabre.rst
new file mode 100644
index 00000000000..c5d35af1d44
--- /dev/null
+++ b/docs/system/arm/mcimx7d-sabre.rst
@@ -0,0 +1,5 @@
+NXP MCIMX7D Sabre (``mcimx7d-sabre``)
+=====================================
+
+The ``mcimx7d-sabre`` machine models the NXP SABRE Board MCIMX7SABRE,
+based an an i.MX7Dual SoC.
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index ace36d1b17d..1f806cf4a46 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -97,6 +97,8 @@ undocumented; you can get a complete list by running
    arm/nrf
    arm/nuvoton
    arm/imx25-pdk
+   arm/mcimx6ul-evk
+   arm/mcimx7d-sabre
    arm/orangepi
    arm/raspi
    arm/collie
-- 
2.34.1


