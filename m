Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C369C25B5F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 10:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s66Jr-0003yt-UI; Sun, 12 May 2024 06:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1s66Jn-0003wD-0y; Sun, 12 May 2024 06:20:35 -0400
Received: from zproxy1.enst.fr ([137.194.2.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1s66Jj-0007PC-1Q; Sun, 12 May 2024 06:20:34 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id B2E45C060A;
 Sun, 12 May 2024 12:20:23 +0200 (CEST)
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id gXQMykHXqdho; Sun, 12 May 2024 12:20:23 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id 6ACE5C056A;
 Sun, 12 May 2024 12:20:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy1.enst.fr 6ACE5C056A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1715509223;
 bh=oWGP6GZO0jOOBWiuu/NNsXQkGkqWrfm8ixMDn68Enbc=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=zLuZ+Ip57rCxuGTCWXEojG23D4HEUYysrHIMBgev6Hb9Swz4P1D6Ymh511Y3H4Ctt
 hUUGb3rAVW8uM2rEqslWXCCkRfwe0xn5TfaBvh1En0rpmFnQBxbs7/Ftdcy5kn+fNr
 wTj1cOnMaoJBPPF8SF76pofulxnVWcOs3A3qIPh0=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id TcoAfFZy0J72; Sun, 12 May 2024 12:20:23 +0200 (CEST)
Received: from inesv-Inspiron-3501.enst.fr (unknown
 [IPv6:2a04:8ec0:0:124::190c])
 by zproxy1.enst.fr (Postfix) with ESMTPSA id B5A14C05C1;
 Sun, 12 May 2024 12:20:21 +0200 (CEST)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
Subject: [PATCH 2/3] hw/misc: In STM32L4x5 EXTI, handle direct line interrupts
Date: Sun, 12 May 2024 12:19:41 +0200
Message-ID: <20240512102013.211127-3-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240512102013.211127-1-ines.varhol@telecom-paris.fr>
References: <20240512102013.211127-1-ines.varhol@telecom-paris.fr>
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

The previous implementation for EXTI interrupts only handled
"configurable" interrupts, like those originating from STM32L4x5 SYSCFG
(the only device currently connected to the EXTI up until now).
In order to connect STM32L4x5 USART to the EXTI, this commit adds
handling for direct interrupts (interrupts without configurable edge),
as well as a comment that will be useful to connect other devices to the
EXTI.

Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 hw/misc/stm32l4x5_exti.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/hw/misc/stm32l4x5_exti.c b/hw/misc/stm32l4x5_exti.c
index eebefc6cd3..1817bbdad2 100644
--- a/hw/misc/stm32l4x5_exti.c
+++ b/hw/misc/stm32l4x5_exti.c
@@ -106,6 +106,27 @@ static void stm32l4x5_exti_set_irq(void *opaque, int=
 irq, int level)
         return;
     }
=20
+    /* In case of a direct line interrupt */
+    if (extract32(exti_romask[bank], irq, 1)) {
+        if (level) {
+            qemu_irq_raise(s->irq[oirq]);
+        } else {
+            qemu_irq_lower(s->irq[oirq]);
+        }
+        return;
+    }
+
+    /*
+     * In case of a configurable interrupt
+     *
+     * Note that while the real EXTI uses edge detection to tell
+     * apart a line rising (the level changes from 0 to 1) and a line
+     * staying high (the level was 1 and is set to 1), the current
+     * implementation relies on the fact that this handler will only
+     * be called when there's a level change. That means that the
+     * devices creating a configurable interrupt (like STM32L4x5 GPIO)
+     * have to set their IRQs only on a change.
+     */
     if (((1 << irq) & s->rtsr[bank]) && level) {
         /* Rising Edge */
         s->pr[bank] |=3D 1 << irq;
@@ -116,7 +137,7 @@ static void stm32l4x5_exti_set_irq(void *opaque, int =
irq, int level)
         qemu_irq_pulse(s->irq[oirq]);
     }
     /*
-     * In the following situations :
+     * In the following situations (for configurable interrupts) :
      * - falling edge but rising trigger selected
      * - rising edge but falling trigger selected
      * - no trigger selected
--=20
2.43.2


