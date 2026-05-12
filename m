Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7160CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuVc-0002AR-0O; Tue, 12 May 2026 17:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuV0-0001TO-CV; Tue, 12 May 2026 17:18:43 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuUs-0007nl-Bk; Tue, 12 May 2026 17:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619497; bh=/0ZbzGfGskioYwQBMDo73Gh48u/hAR/dwCyinBY+ttk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Omfbq5xezaoUX4pGX4VlWT5i0qj0ebGY0fxrecG/EjD3v2YakY3rJQ2/royr4q9ge
 9W59pM/k0ndsQ1op/OW/GbEAOIlKZ4ZVsb2fUJ0zseFLD7IMxjX7DrwpCDpQLYYanQ
 zREMfdeTiXgimuofT57l2nzP5J2sERVUEcdZTklY/7a+p7RlqS5qEH4X1uPkeTd3qV
 4HL2uxif6ac66DRM8uW9qaoDCDOxY6mlIxoO1l3afqT9gX6NBD7+ZpOsK09y7j+DjI
 K8iekfMOboGcYEI9g09m1aXWQzFx4Ex/slxXT6p5fczTt7+RPhPR/6hGohaRdHlTai
 apPk5qJIuokqQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 56FA81AA3D2;
 Tue, 12 May 2026 23:58:17 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 656D93ABD2A;
 Tue, 12 May 2026 23:58:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, rickgcn <rickgcn@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 07/58] hw: i386: vapic: restore IRQ polling for
 non-kernel irqchip backends
Date: Tue, 12 May 2026 23:57:28 +0300
Message-ID: <20260512205820.361821-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
References: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: rickgcn <rickgcn@gmail.com>

69dfc078 extended vAPIC handling for WHPX with user-mode irqchip, but it
also changed vapic_write() case 4 in a way that excludes TCG from
apic_poll_irq().

Before that change, IRQ polling happened whenever no in-kernel irqchip
was active. After the change, it only happened for KVM or WHPX with a
user-mode irqchip. Under TCG, both kvm_enabled() and whpx_enabled() are
false, so the poll never happens.

This regresses 32-bit Windows XP guests on a Windows host with
-machine pc-i440fx-10.0,accel=tcg, causing a STOP 0x0000000A during boot.

Fix it by making the decision depend on whether KVM or WHPX is using an
in-kernel irqchip, instead of whether either accelerator is enabled.

Fixes: 69dfc078a6f0 ("hw: i386: vapic: enable on WHPX with user-mode irqchip")

Signed-off-by: rickgcn <rickgcn@gmail.com>
Link: https://lore.kernel.org/r/20260418061429.16898-1-rickgcn@gmail.com
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit c906c2337058bd467e6ac0176c2966d1eeb6f8f5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index 41e5ca26df..1acb9f91b2 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -716,8 +716,7 @@ static void vapic_write(void *opaque, hwaddr addr, uint64_t data,
         break;
     default:
     case 4:
-        if ((kvm_enabled() && !kvm_irqchip_in_kernel())
-          || (whpx_enabled() && !whpx_irqchip_in_kernel())) {
+        if (!kvm_irqchip_in_kernel() && !whpx_irqchip_in_kernel()) {
             apic_poll_irq(cpu->apic_state);
         }
         break;
-- 
2.47.3


