Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F019FC44507
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whqds-00023J-Mh; Thu, 09 Jul 2026 11:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whqdq-00020F-4c; Thu, 09 Jul 2026 11:26:22 -0400
Received: from smtp2-g21.free.fr ([2a01:e0c:1:1599::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whqdo-0000mB-JO; Thu, 09 Jul 2026 11:26:21 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 7C0F52003DA;
 Thu,  9 Jul 2026 17:26:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783610777;
 bh=ZvoMNFhPOIqoWdapwM1+wBzJt+uj3U0af9XwMDsCb9U=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ZvNtyYxff9zVAI9LC/eCxLHyOrELzQu9yi/PLo6CrYIDVq0zAzPv1XAy+T/b9sZKX
 dBCVGFUC6c8AcH9HJ6tp9c4XDQyVJSymWYeKKqvp7VpuRnxIyZGV9kGL4SI8yLP6Bi
 GeP3mhfMKPI0iskRdtXhtZF2fm6NlUezY12tPR7jn5phq9OyoS3ovDW3Rbc9FtBePG
 uiOvUbEKjZ46dLjH3dpaWIMN73eBgPVMPi84V1V83daepNl7/UB5F2EuAwy4Du5Z3C
 9kNQlMvTn21m1y3Oyo2JfalFA0dpMwtjrI98hw3Uo9hp+yU4jcLpu0+8SoiUn1Wr1d
 AUKqbRksOYXmg==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 09 Jul 2026 17:23:44 +0200
Subject: [PATCH 06/29] hw/gpio: pca9552: use the Resettable interface
 instead of legacy reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-catalina-upgrade-v1-6-814575bc076b@free.fr>
References: <20260709-catalina-upgrade-v1-0-814575bc076b@free.fr>
In-Reply-To: <20260709-catalina-upgrade-v1-0-814575bc076b@free.fr>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Corey Minyard <cminyard@mvista.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610647; l=2391;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=ZvoMNFhPOIqoWdapwM1+wBzJt+uj3U0af9XwMDsCb9U=;
 b=tFBDctsGESxEam6gaguWNFYPfrIUdAgiiwbpV4pYBtgwIqlpDwHwK37ROmy1dt5+EzAxBg0bx
 xa4c1Pe/zBAAu75T8531aV5qUm4LP4Ps9pu+Bx1UgYUP3RbdRQmE4Zw
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=2a01:e0c:1:1599::11;
 envelope-from=emmanuel.blot@free.fr; helo=smtp2-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Convert the PCA9552 and PCA9535/PCA9555 reset handlers from the legacy
device reset hook to the Resettable interface: move each reset body into
a ResettableHoldPhase handler and register it through the class's
ResettableClass::phases.hold instead of device_class_set_legacy_reset().

No functional change.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/gpio/pca9552.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index 3b9b63eb17..66f699bf6a 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -406,9 +406,9 @@ static const VMStateDescription pca9552_vmstate = {
     }
 };
 
-static void pca9552_reset(DeviceState *dev)
+static void pca9552_reset_hold(Object *obj, ResetType type)
 {
-    PCA955xState *s = PCA955X(dev);
+    PCA955xState *s = PCA955X(obj);
 
     s->regs[PCA9552_PSC0] = 0xFF;
     s->regs[PCA9552_PWM0] = 0x80;
@@ -426,9 +426,9 @@ static void pca9552_reset(DeviceState *dev)
     s->len = 0;
 }
 
-static void pca9535_reset(DeviceState *dev)
+static void pca9535_reset_hold(Object *obj, ResetType type)
 {
-    PCA955xState *s = PCA955X(dev);
+    PCA955xState *s = PCA955X(obj);
 
     s->regs[PCA9535_INPUT0] = 0xFF;   /* All inputs high (pull-ups) */
     s->regs[PCA9535_INPUT1] = 0xFF;   /* All inputs high (pull-ups) */
@@ -514,9 +514,10 @@ static void pca955x_class_init(ObjectClass *klass, const void *data)
 static void pca9552_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
     PCA955xClass *pc = PCA955X_CLASS(oc);
 
-    device_class_set_legacy_reset(dc, pca9552_reset);
+    rc->phases.hold = pca9552_reset_hold;
     dc->vmsd = &pca9552_vmstate;
     pc->max_reg = PCA9552_LS3;
     pc->pin_count = 16;
@@ -526,9 +527,10 @@ static void pca9552_class_init(ObjectClass *oc, const void *data)
 static void pca95x5_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
     PCA955xClass *pc = PCA955X_CLASS(oc);
 
-    device_class_set_legacy_reset(dc, pca9535_reset);
+    rc->phases.hold = pca9535_reset_hold;
     dc->vmsd = &pca9552_vmstate;
     pc->max_reg = PCA9535_CONFIG1;
     pc->pin_count = 16;

-- 
2.50.1


