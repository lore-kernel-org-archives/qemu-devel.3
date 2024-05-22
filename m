Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABABC25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 20:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9slM-0005HP-02; Wed, 22 May 2024 16:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1s9slK-0005Ee-5Q; Wed, 22 May 2024 16:40:38 -0400
Received: from zproxy4.enst.fr ([137.194.2.223])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1s9slH-0003CN-7Y; Wed, 22 May 2024 16:40:37 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 2157320639;
 Wed, 22 May 2024 22:40:31 +0200 (CEST)
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id z9rJ3zX0qkH1; Wed, 22 May 2024 22:40:30 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 7F6202051F;
 Wed, 22 May 2024 22:40:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy4.enst.fr 7F6202051F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1716410430;
 bh=+tvBKMu0XXeF5GQuHi/fty3M0h+oQiCaDstZEhKD8F4=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=n62QhYoSfJFeSwGZHsiwa2BMI7AOVIh3AMfAc5/OXbucFSX/xsyS4pw9/rX76LBu+
 QeB4twHZt2ihLwK4BLo1kNR045btABKVuhMMZkvPXfGaP+DmCWmhs/cNxt7rPEijBu
 hX6aO3T7X9EEpTahnMssn/Lg1lTdiSE/eJAOuGBI=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id IbB4yQ1ReITk; Wed, 22 May 2024 22:40:30 +0200 (CEST)
Received: from inesv-Inspiron-3501.enst.fr (unknown
 [IPv6:2a04:8ec0:0:124::190c])
 by zproxy4.enst.fr (Postfix) with ESMTPSA id E297620528;
 Wed, 22 May 2024 22:40:29 +0200 (CEST)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 2/3] hw/misc: In STM32L4x5 EXTI,
 handle direct and configurable interrupts
Date: Wed, 22 May 2024 22:39:39 +0200
Message-ID: <20240522204020.203905-3-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240522204020.203905-1-ines.varhol@telecom-paris.fr>
References: <20240522204020.203905-1-ines.varhol@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.223;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy4.enst.fr
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

The previous implementation for EXTI interrupts only handled
"configurable" interrupts, like those originating from STM32L4x5 SYSCFG
(the only device currently connected to the EXTI up until now).

In order to connect STM32L4x5 USART to the EXTI, this commit adds
handling for direct interrupts (interrupts without configurable edge).

The implementation of configurable interrupts (interrupts supporting
edge selection) was incorrectly expecting alternating input levels :
this commits adds a new status field `irq_levels` to actually detect
edges.

Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 include/hw/misc/stm32l4x5_exti.h |  2 ++
 hw/misc/stm32l4x5_exti.c         | 25 ++++++++++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/hw/misc/stm32l4x5_exti.h b/include/hw/misc/stm32l4x5=
_exti.h
index 82f75a2417..62f79362f2 100644
--- a/include/hw/misc/stm32l4x5_exti.h
+++ b/include/hw/misc/stm32l4x5_exti.h
@@ -45,6 +45,8 @@ struct Stm32l4x5ExtiState {
     uint32_t swier[EXTI_NUM_REGISTER];
     uint32_t pr[EXTI_NUM_REGISTER];
=20
+    /* used for edge detection */
+    uint32_t irq_levels[EXTI_NUM_REGISTER];
     qemu_irq irq[EXTI_NUM_LINES];
 };
=20
diff --git a/hw/misc/stm32l4x5_exti.c b/hw/misc/stm32l4x5_exti.c
index eebefc6cd3..bdc3dc10d6 100644
--- a/hw/misc/stm32l4x5_exti.c
+++ b/hw/misc/stm32l4x5_exti.c
@@ -87,6 +87,7 @@ static void stm32l4x5_exti_reset_hold(Object *obj, Rese=
tType type)
         s->ftsr[bank] =3D 0x00000000;
         s->swier[bank] =3D 0x00000000;
         s->pr[bank] =3D 0x00000000;
+        s->irq_levels[bank] =3D 0x00000000;
     }
 }
=20
@@ -106,17 +107,30 @@ static void stm32l4x5_exti_set_irq(void *opaque, in=
t irq, int level)
         return;
     }
=20
+    /* In case of a direct line interrupt */
+    if (extract32(exti_romask[bank], irq, 1)) {
+        qemu_set_irq(s->irq[oirq], level);
+        return;
+    }
+
+    /* In case of a configurable interrupt */
     if (((1 << irq) & s->rtsr[bank]) && level) {
         /* Rising Edge */
-        s->pr[bank] |=3D 1 << irq;
-        qemu_irq_pulse(s->irq[oirq]);
+        if (!extract32(s->irq_levels[bank], irq, 1)) {
+            s->pr[bank] |=3D 1 << irq;
+            qemu_irq_pulse(s->irq[oirq]);
+        }
+        s->irq_levels[bank] |=3D 1 << irq;
     } else if (((1 << irq) & s->ftsr[bank]) && !level) {
         /* Falling Edge */
-        s->pr[bank] |=3D 1 << irq;
-        qemu_irq_pulse(s->irq[oirq]);
+        if (extract32(s->irq_levels[bank], irq, 1)) {
+            s->pr[bank] |=3D 1 << irq;
+            qemu_irq_pulse(s->irq[oirq]);
+        }
+        s->irq_levels[bank] &=3D ~(1 << irq);
     }
     /*
-     * In the following situations :
+     * In the following situations (for configurable interrupts) :
      * - falling edge but rising trigger selected
      * - rising edge but falling trigger selected
      * - no trigger selected
@@ -262,6 +276,7 @@ static const VMStateDescription vmstate_stm32l4x5_ext=
i =3D {
         VMSTATE_UINT32_ARRAY(ftsr, Stm32l4x5ExtiState, EXTI_NUM_REGISTER=
),
         VMSTATE_UINT32_ARRAY(swier, Stm32l4x5ExtiState, EXTI_NUM_REGISTE=
R),
         VMSTATE_UINT32_ARRAY(pr, Stm32l4x5ExtiState, EXTI_NUM_REGISTER),
+        VMSTATE_UINT32_ARRAY(irq_levels, Stm32l4x5ExtiState, EXTI_NUM_RE=
GISTER),
         VMSTATE_END_OF_LIST()
     }
 };
--=20
2.43.2


