Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC217CEACE7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfuI-0005Ho-0z; Tue, 01 Oct 2024 12:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuG-0005HR-7l
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:24 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuE-0005zv-H2
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:23 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42cafda818aso55224525e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800761; x=1728405561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LdewmOBAwoVdcFyu1aHfJ+8cNnKepnGghfhYw3U2XmQ=;
 b=QsWlN5CndcaPZKhuHkknol/n58EL2XIAzt2oObg1nYFqRKPiRHnGCR3F2Wv5mCUJU/
 Vmrjlfs0PpigYdGfGVTCa5oL2SLzg7T55BWTyXvy9tO96JynTmwMfMufWTB/UB/UdE3Y
 ziqPbRavtkFeHJ7RDNjvCXIEvB4B6x0oBmY7GRTP0lFppngKrT1Ti57qa+61Yt2Y9/SW
 mE6xoTifKxzk5+GAw6IIOYRcbemuJRzxWoQkPW/kYkRkO3H0zRXEaTG322kSWvQe7JbU
 rSoeZTM5guFKZvZJDT3scJtGcmoMIanmxSWWtBfkYzfXt8MhryilAMKyHlj1gcbRfGpw
 5TUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800761; x=1728405561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LdewmOBAwoVdcFyu1aHfJ+8cNnKepnGghfhYw3U2XmQ=;
 b=fEKfzcc6z0wizffQ+VWqR+PJ3GVJyK4JfRfq1efgfjrNZcIjVrVGH162aJ8JpOJnhx
 n5cfNhceOVyPpFtgGxTKOjlq8yeTGyGoc+VQOlHXSEH0YllTx6dgje2gdHlkMTMreY/9
 OG5ijmI7naa0PDgf90cQ4NwaonoRPlrbR/fhqSH6l2R031XygJsd6nE5pd/xK4OFU3gw
 ngWnbhlTPzuvWZihec491PXUEwGIZnXSkUKwAn6wsfrBzMdHtixnyqnd8F3S7TyeaLat
 RkvXpaCItATyNRCmWpDh+v1twlDgHjpNBdp8WU7ZmJVwDhOygED+OTu/CsJmikQNsK/W
 +MYg==
X-Gm-Message-State: AOJu0YyG9bmB4h/5QIEFqfNx12ppgNnRHPcqCtDqvZhEXTbt/A9FUyW3
 ipxW50GLOgkYEHfMiJgIq5ZPEVUMmoUc57tLAbvus65hXTw5PHRlwXf3qhv1bPZTJGFn3MKRPig
 R
X-Google-Smtp-Source: AGHT+IFYBPKv9JxcMT77XbPufR4glfUm3bSP5w9QYwTdkj/l887UsKKBKe7WmO5e3N0yEsBjn2qUjw==
X-Received: by 2002:a05:600c:3b8b:b0:42c:cdcf:2fef with SMTP id
 5b1f17b1804b1-42f777c09cdmr958395e9.15.1727800760573; 
 Tue, 01 Oct 2024 09:39:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/54] MAINTAINERS: Update STM32L4x5 and B-L475E-IOT01A
 maintainers
Date: Tue,  1 Oct 2024 17:38:25 +0100
Message-Id: <20241001163918.1275441-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
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

From: Inès Varhol <ines.varhol@telecom-paris.fr>

It has been a learning experience to contribute to QEMU for our
end-of-studies project. For a few months now, Arnaud and I aren't
actively involved anymore as we lack time and access to the hardware.
Therefore it's high time to update the maintainers file: from now on,
Samuel Tardieu who is behind the project will be taking up the role of
maintainer.

This commit updates maintainers and the list of files, and places the
two devices in alphabetical order.

Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
Message-id: 20240921104751.43671-1-ines.varhol@telecom-paris.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 62f5255f409..7113abeea5c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -706,6 +706,14 @@ F: include/hw/timer/armv7m_systick.h
 F: include/hw/misc/armv7m_ras.h
 F: tests/qtest/test-arm-mptimer.c
 
+B-L475E-IOT01A IoT Node
+M: Samuel Tardieu <sam@rfc1149.net>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/b-l475e-iot01a.c
+F: hw/display/dm163.c
+F: tests/qtest/dm163-test.c
+
 Exynos
 M: Igor Mitsyanko <i.mitsyanko@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -991,6 +999,19 @@ F: include/hw/input/gamepad.h
 F: include/hw/timer/stellaris-gptm.h
 F: docs/system/arm/stellaris.rst
 
+STM32L4x5 SoC Family
+M: Samuel Tardieu <sam@rfc1149.net>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/stm32l4x5_soc.c
+F: hw/char/stm32l4x5_usart.c
+F: hw/misc/stm32l4x5_exti.c
+F: hw/misc/stm32l4x5_syscfg.c
+F: hw/misc/stm32l4x5_rcc.c
+F: hw/gpio/stm32l4x5_gpio.c
+F: include/hw/*/stm32l4x5_*.h
+F: tests/qtest/stm32l4x5*
+
 STM32VLDISCOVERY
 M: Alexandre Iooss <erdnaxe@crans.org>
 L: qemu-arm@nongnu.org
@@ -1118,26 +1139,6 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/olimex-stm32-h405.c
 
-STM32L4x5 SoC Family
-M: Arnaud Minier <arnaud.minier@telecom-paris.fr>
-M: Inès Varhol <ines.varhol@telecom-paris.fr>
-L: qemu-arm@nongnu.org
-S: Maintained
-F: hw/arm/stm32l4x5_soc.c
-F: hw/char/stm32l4x5_usart.c
-F: hw/misc/stm32l4x5_exti.c
-F: hw/misc/stm32l4x5_syscfg.c
-F: hw/misc/stm32l4x5_rcc.c
-F: hw/gpio/stm32l4x5_gpio.c
-F: include/hw/*/stm32l4x5_*.h
-
-B-L475E-IOT01A IoT Node
-M: Arnaud Minier <arnaud.minier@telecom-paris.fr>
-M: Inès Varhol <ines.varhol@telecom-paris.fr>
-L: qemu-arm@nongnu.org
-S: Maintained
-F: hw/arm/b-l475e-iot01a.c
-
 SmartFusion2
 M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
-- 
2.34.1


