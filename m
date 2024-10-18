Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C29D30011
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1nja-0000y5-Cp; Fri, 18 Oct 2024 10:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1njY-0000vm-3v
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:13:40 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1njW-0006xX-H7
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:13:39 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4314c452180so22244765e9.0
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 07:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729260817; x=1729865617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gAX28yWcBXDRA8GUHaWHj1wjFTUDruopzlW85DJp/k8=;
 b=BZEFjEsbM2VXR8Q+/P9ORzeTjPA7VqUjzG9iZdoH6nIhe0loS7fZNuSXfnzB3DYSZs
 IpqrFYDLTFhOlf3VcA2acM+ZdF8RWhohhaNp1tUR3qz201f1yUovfDLJgFIZ/UJ2kkff
 Jbkz19p5H/9UYf+XQSUxI/hFdi0g+I2uCsY5iQkSEj0dgxSaTdKSA48eAqGYlXBva+17
 nokWkuYoggIt9PEKNolERCvsquj+lP/8Yh5BwTo/w9q11SwIjaQErq5uRaW1YsZJgfIT
 fJMIkGg2E68lzCl0rsj1XBipGeYpCH6zKtwWC/TXaALEfTuHmyAcWBXFa/jEuAVT5Eel
 tB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729260817; x=1729865617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gAX28yWcBXDRA8GUHaWHj1wjFTUDruopzlW85DJp/k8=;
 b=WO2bwd/fmf8bzcGUVatyVQ6+wgWovrBjOxyUPvwc6NSnCpHz5tRNZNGgH/ed+nf5wI
 sf51ii0gswAom4hQoFxsm0bAsKFdvfzF+fa4EVB9jqAIRtk3nq57KcTvPVL7DD419onh
 UHI6oep/Euae8zf8Uz4W9rziODOp9dDEjW1/1FejUhwjCYRMy6MxZRPQy0yMCiGjVe3H
 dksnHq6kZF1awW1p+YJjBKNlWj5MtXjuUkX8ztubP4brh/2i64jb/juF7cfRJ1nbRM+h
 mhQLbsWhp3fnjuNRW4EvAYEAPpWrTQAVmIJ9i1u80sHDdlZU+BSluWMMVZSbyXFSti12
 qtQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnGORHQktNP4cPZiUzEB9JkCwUBErb04ah/4AgxN4HJhp1igOwZoBU6GnI5zJY55qO4PGUBwkNJ2eA@nongnu.org
X-Gm-Message-State: AOJu0Yw0dIjAOFemimaE9CzFnr2AqHJf/Mbx+mQz9cjAUFXpCoY7Pqqv
 eFVK0lNTBhtHNoNwX1/kEdYDWz9yza/WPNMmNFhSEuEmIrIpSvBeIZ3OmnTolBE=
X-Google-Smtp-Source: AGHT+IF1x79hdA58IFQH3WOi+bGHnWxAAQFRbDG3LNex0BH8LKndgN/YalNGRLZ8Q0QYf+QUPCti+Q==
X-Received: by 2002:a05:600c:4ecc:b0:431:416e:2603 with SMTP id
 5b1f17b1804b1-431586fc9b3mr47060115e9.3.1729260817068; 
 Fri, 18 Oct 2024 07:13:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ecf0ecd89sm2040086f8f.78.2024.10.18.07.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:13:36 -0700 (PDT)
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
Subject: [PATCH 4/7] docs/system/arm: Add placeholder doc for exynos4 boards
Date: Fri, 18 Oct 2024 15:13:29 +0100
Message-Id: <20241018141332.942844-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018141332.942844-1-peter.maydell@linaro.org>
References: <20241018141332.942844-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Add a placeholder doc for the exynos4 boards nuri and smdkc210.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                | 1 +
 docs/system/arm/exynos.rst | 9 +++++++++
 docs/system/target-arm.rst | 1 +
 3 files changed, 11 insertions(+)
 create mode 100644 docs/system/arm/exynos.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index dff8073c5bc..031b117a3a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -716,6 +716,7 @@ L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/*/exynos*
 F: include/hw/*/exynos*
+F: docs/system/arm/exynos.rst
 
 Calxeda Highbank
 M: Rob Herring <robh@kernel.org>
diff --git a/docs/system/arm/exynos.rst b/docs/system/arm/exynos.rst
new file mode 100644
index 00000000000..86894bc02b7
--- /dev/null
+++ b/docs/system/arm/exynos.rst
@@ -0,0 +1,9 @@
+Exynos4 boards (``nuri``, ``smdkc210``)
+=======================================
+
+These are machines which use the Samsung Exynos4210 SoC, which has Cortex-A9 CPUs.
+
+``nuri`` models the Samsung NURI board.
+
+``smdkc210`` models the Samsung SMDKC210 board.
+
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 9c01e66ffa9..a7f88c8f317 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -90,6 +90,7 @@ undocumented; you can get a complete list by running
    arm/digic
    arm/cubieboard
    arm/emcraft-sf2
+   arm/exynos
    arm/fby35
    arm/musicpal
    arm/kzm
-- 
2.34.1


