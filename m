Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B372C25B10
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 14:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3cVN-0005tq-6d; Sun, 05 May 2024 10:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1s3cVK-0005ss-Ix; Sun, 05 May 2024 10:06:14 -0400
Received: from zproxy3.enst.fr ([137.194.2.222])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1s3cVH-00085s-AP; Sun, 05 May 2024 10:06:12 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id D291FA06B6;
 Sun,  5 May 2024 16:06:05 +0200 (CEST)
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id qkhgwEMOKexZ; Sun,  5 May 2024 16:06:05 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 93747A071D;
 Sun,  5 May 2024 16:06:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy3.enst.fr 93747A071D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1714917965;
 bh=s6kUahatkuNBmbNzGf064R0ZxKZ/IMkQiTFLKObIBno=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=xe+B40NwoX++V3nQmKa2VCqSBg3OxO/yKIporHAVlUN2X0odXWlwd7l+y7gcE42uk
 Jk5DQ9H+PmlR1kpp4eyaC87JKHc2TyyL767Br2d7Eb2aYVKzXVb0dvFl43wPhiq7YI
 2jf/swhFnL2ruokxMqBlbJp1JB+zOCsrThSTD4PE=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id Q2In-kAoXJH5; Sun,  5 May 2024 16:06:05 +0200 (CEST)
Received: from inesv-Inspiron-3501.enst.fr (unknown
 [IPv6:2a04:8ec0:0:124::190c])
 by zproxy3.enst.fr (Postfix) with ESMTPSA id 9A5D4A06B6;
 Sun,  5 May 2024 16:06:04 +0200 (CEST)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/4] hw/gpio: Handle clock migration in STM32L4x5 gpios
Date: Sun,  5 May 2024 16:05:04 +0200
Message-ID: <20240505140556.373711-3-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240505140556.373711-1-ines.varhol@telecom-paris.fr>
References: <20240505140556.373711-1-ines.varhol@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.222;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy3.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 hw/gpio/stm32l4x5_gpio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/gpio/stm32l4x5_gpio.c b/hw/gpio/stm32l4x5_gpio.c
index 71bf5fddb2..14e6618d30 100644
--- a/hw/gpio/stm32l4x5_gpio.c
+++ b/hw/gpio/stm32l4x5_gpio.c
@@ -20,6 +20,7 @@
 #include "qemu/log.h"
 #include "hw/gpio/stm32l4x5_gpio.h"
 #include "hw/irq.h"
+#include "hw/clock.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "qapi/visitor.h"
@@ -441,6 +442,7 @@ static const VMStateDescription vmstate_stm32l4x5_gpi=
o =3D {
         VMSTATE_UINT32(ascr, Stm32l4x5GpioState),
         VMSTATE_UINT16(disconnected_pins, Stm32l4x5GpioState),
         VMSTATE_UINT16(pins_connected_high, Stm32l4x5GpioState),
+        VMSTATE_CLOCK(clk, Stm32l4x5GpioState),
         VMSTATE_END_OF_LIST()
     }
 };
--=20
2.43.2


