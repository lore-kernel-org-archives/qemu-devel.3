Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F4DC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 19:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Q1y-0008Cd-3d; Tue, 07 May 2024 14:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1s4Q1v-0008BM-VG; Tue, 07 May 2024 14:59:11 -0400
Received: from zproxy1.enst.fr ([137.194.2.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1s4Q1t-0006AL-KZ; Tue, 07 May 2024 14:59:11 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id 5A52FC0D41;
 Tue,  7 May 2024 20:59:05 +0200 (CEST)
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id Ya_-fyY7R5nH; Tue,  7 May 2024 20:59:05 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id 17814C0D05;
 Tue,  7 May 2024 20:59:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy1.enst.fr 17814C0D05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1715108345;
 bh=QnpJKaskVydt3M9JeeJ+YmrTlVQ6dW0qxexbTyP/ZYg=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=XgKLuwJbF0eNnKSiouecPoGnjcnrnpsPvWzNBZCCJgENbNcuyeBS2BJTVIT6mFu7/
 mPHMS75c5WaEvTRkKfUJgV+ybRA5zak5GZtFMd6ZeeMWX4O20Lsg2VmV9ljcQGZoh8
 eELRGOUVEkpeYKJNuDmv3UBA3qjRWBx7H9HMT7SI=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id f9IRu4IZ5MYc; Tue,  7 May 2024 20:59:05 +0200 (CEST)
Received: from inesv-Inspiron-3501.enst.fr (unknown
 [IPv6:2a04:8ec0:0:124::190c])
 by zproxy1.enst.fr (Postfix) with ESMTPSA id 1D8AFC0D30;
 Tue,  7 May 2024 20:59:04 +0200 (CEST)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/4] hw/gpio: Handle clock migration in STM32L4x5 gpios
Date: Tue,  7 May 2024 20:55:39 +0200
Message-ID: <20240507185854.34572-3-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240507185854.34572-1-ines.varhol@telecom-paris.fr>
References: <20240507185854.34572-1-ines.varhol@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.220;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy1.enst.fr
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

STM32L4x5 GPIO wasn't migrating its clock.

Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 hw/gpio/stm32l4x5_gpio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/gpio/stm32l4x5_gpio.c b/hw/gpio/stm32l4x5_gpio.c
index 71bf5fddb2..30d8d6cba4 100644
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
@@ -426,8 +427,8 @@ static void stm32l4x5_gpio_realize(DeviceState *dev, =
Error **errp)
=20
 static const VMStateDescription vmstate_stm32l4x5_gpio =3D {
     .name =3D TYPE_STM32L4X5_GPIO,
-    .version_id =3D 1,
-    .minimum_version_id =3D 1,
+    .version_id =3D 2,
+    .minimum_version_id =3D 2,
     .fields =3D (VMStateField[]){
         VMSTATE_UINT32(moder, Stm32l4x5GpioState),
         VMSTATE_UINT32(otyper, Stm32l4x5GpioState),
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


