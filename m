Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF5FC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 13:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt4uK-0005Cf-C0; Fri, 14 Mar 2025 09:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4uE-00059i-EZ
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:54 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4uC-00016Z-HC
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:54 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so1207567f8f.0
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 06:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741958210; x=1742563010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Wd7g6oeMHVWi/J7kwV0qC+uPDbfRdDe//+DBMn4lERc=;
 b=t7cYPOAZc1via6kdm3pt7LfcgLWYxh+OL1DaaK+JnMhDQ6udHS7BtXH/k7QtnrwfId
 1X9+qijkivWzGtHi5qf/w/5KkPVQ49h9GM5Fme0EVPN2MtE7qd7t4+cgfkTR8DVIHjef
 tQk1uqupqTgdUOU/Lcd5zvqkFCAk8jpdtsaE+LgFgXfjpi/KTm6WiPxlFfEcTe7FLWQR
 WuqbRMEDHKSOfY3kEh9F086XlqJAzgrEW/rUHArr7F2TcKLlLnUW3Ae7TUMr90EQ2qSj
 Wp1Assigp2v9n/vG9sUDPGSUmQiwl3bQRPCnbnQFVICWU5xO/xHtMQK1BNSpWhPo8bL1
 XUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741958210; x=1742563010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wd7g6oeMHVWi/J7kwV0qC+uPDbfRdDe//+DBMn4lERc=;
 b=VME6nrxsYY5X2SNLxpJDvlbWN6mayUP1LsXoI3Gu6N7Inghhcjx3A0pV/xvjjtcXz4
 sbI6LMtSZR7pdd2P/mK2d4am849o7eYFq2eA+r8r4Bifg0Hjmk/88vrT10FgW9xZhwFR
 1BxGU99Ew2modQiXTFM7eTUzj0knILzOHEBDM/nFw4/6QPzvzW8Jb+rhfFxSwnQYSqun
 bhuPPa7r8pEk/iYdpwCtHiX8vmbFw5yTEEgNENjYH9nnXrq48hMGU84QFIZm0HPaGtIv
 20ilGUF2elHj3g74VPvKieLVxrdwTwsIJxVHUQ6K/fpLQ8H1x5vNumBRSJBo+WyvVhGI
 ZvjQ==
X-Gm-Message-State: AOJu0Yz9Vgz621pt+FHUgnP/Lu0VJpxufia4WaE6VieIA5/Jtu7DOKSO
 JxVOSyC6vvdJVyDwp2HEfnN5fe3QTbugDP7g3tpMxWNkvnUZKPaerXgG9ylqn6vEpOAHU2aoOeo
 K
X-Gm-Gg: ASbGnct4MgXSewMmRac8S0B0LTGdZE/asu4JoTbbc7S/9C9VpNrKEhxNKML7T8yDH8V
 kQZD4gKri0YSpSlCK68VWpbndDhVbOC1E5L09tG900SoMhLFqsPnZKPCtpuIOXvuMn6PtUylzk+
 BJdsjSagPlMeRgK87R20+dOZZIUJwn1OH+U6twE2yP00vcCFQPaMD60owzbJzYONvhF1p7PwI+X
 hJ20Bmcfio5RZvZKLmwKr0xUAYVTlggK3C1qDQey1iD5zlz20snT58JkBaq3cERRQfrxPw6GUsI
 eg0MdCUEiXEN0vv4Be1PYWddw3Z+NpU2BA/N8v9GK+uVSonrjt0=
X-Google-Smtp-Source: AGHT+IEX/v11GVvYXvFmylNLNB/QeH8nE/HfhOiYpLFrHIukur9VVoRgQ4+T7SquKRiuerBztcS2PA==
X-Received: by 2002:a05:6000:1a87:b0:390:f0ff:2c1c with SMTP id
 ffacd0b85a97d-3971e96b183mr2735769f8f.18.1741958210578; 
 Fri, 14 Mar 2025 06:16:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7eb93csm5437923f8f.86.2025.03.14.06.16.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 06:16:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/17] MAINTAINERS: Fix status for Arm boards I "maintain"
Date: Fri, 14 Mar 2025 13:16:31 +0000
Message-ID: <20250314131637.371866-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314131637.371866-1-peter.maydell@linaro.org>
References: <20250314131637.371866-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

I'm down as the only listed maintainer for quite a lot of Arm SoC and
board types.  In some cases this is only as the "maintainer of last
resort" and I'm not in practice doing anything beyond patch review
and the odd bit of tidyup.

Move these entries in MAINTAINERS from "Maintained" to "Odd Fixes",
to better represent reality.  Entries for other boards and SoCs where
I do more actively care (or where there is a listed co-maintainer)
remain as they are.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250307152838.3226398-1-peter.maydell@linaro.org
---
 MAINTAINERS | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 31b395fdfad..8f470a1c9b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -786,7 +786,7 @@ F: docs/system/arm/kzm.rst
 Integrator CP
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/arm/integratorcp.c
 F: hw/misc/arm_integrator_debug.c
 F: include/hw/misc/arm_integrator_debug.h
@@ -867,7 +867,7 @@ F: docs/system/arm/mps2.rst
 Musca
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/arm/musca.c
 F: docs/system/arm/musca.rst
 
@@ -915,7 +915,7 @@ F: tests/functional/test_aarch64_raspi4.py
 Real View
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/arm/realview*
 F: hw/cpu/realview_mpcore.c
 F: hw/intc/realview_gic.c
@@ -965,7 +965,7 @@ F: tests/functional/test_arm_collie.py
 Stellaris
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/*/stellaris*
 F: hw/display/ssd03*
 F: include/hw/input/gamepad.h
@@ -995,7 +995,7 @@ F: docs/system/arm/stm32.rst
 Versatile Express
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/arm/vexpress.c
 F: hw/display/sii9022.c
 F: docs/system/arm/vexpress.rst
@@ -1004,7 +1004,7 @@ F: tests/functional/test_arm_vexpress.py
 Versatile PB
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/*/versatile*
 F: hw/i2c/arm_sbcon_i2c.c
 F: include/hw/i2c/arm_sbcon_i2c.h
@@ -2003,7 +2003,7 @@ F: include/hw/hyperv/vmbus*.h
 OMAP
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/*/omap*
 F: include/hw/arm/omap.h
 F: docs/system/arm/sx1.rst
-- 
2.43.0


