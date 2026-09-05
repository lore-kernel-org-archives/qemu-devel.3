Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B58C79F82
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 00:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2eU8-0003vJ-VK; Fri, 04 Sep 2026 20:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1x2eU7-0003ue-9D
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 20:42:19 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1x2eU5-0000Ev-AU
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 20:42:19 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id A219880AA3;
 Sat, 05 Sep 2026 03:42:13 +0300 (MSK)
Received: from i101646577.yandex-team.ru (unknown [2a02:6bf:8080:11b::1:22])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id 7g79b72ad0U0-AsKqJkyf; Sat, 05 Sep 2026 03:42:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1788568933;
 bh=osJdLbs18BzXXDJuBf1vjeN7BoEwJBZGURyldnlUtLg=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=u27zFwnme9SjUorCCXo2N+mEP/PTo17P4G3wMsF/fuEqPXuwmyjvsrNP123OFuoPq
 P9ItRzCHaWX6bVM5JLHs2B1HeTgxXY37pE/jOC9Ouu64/Mba9SAqnM1bUIkiULk6+R
 EFnUCNMDpB+4Bg+MPO/R5RR9qjN5Y//CGnxLrIpQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 1/2] hw/intc/apic: don't drop irq line re-evaluation when
 LINT0 is masked
Date: Sat,  5 Sep 2026 03:41:51 +0300
Message-ID: <20260905004153.836866-2-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260905004153.836866-1-d-tatianin@yandex-team.ru>
References: <20260905004153.836866-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

apic_update_irq() wouldn't be called at all in case the guest set LINT0
as masked, which would prevent a previously asserted CPU_INTERRUPT_HARD
from an ExtINT source (like the legacy PIT) from getting cleared.

This would usually go unnoticed since masking the PIC while LINT0 is
still unmasked would clear said interrupt via pic_irq_request().

However, a guest that masks LINT0 first, and only then the PIC still
keeps CPU_INTERRUPT_HARD asserted, which then fires on its first sti.
Since APIC's IRR is empty, and the PIC is never even asked since LINT0
is masked, a -1 is returned from cpu_get_pic_interrupt(), which is then
propagated all the way to IDT dispatch, which fails the IDT limit check
against 0xFFFFFFFF (-1) and causes the guest to take a bogus #GP with an
error code of 0xFFFFFFFA (aka -1 * 8 | (1 << 1)).

This can be reproduced by simply booting via SeaBIOS, it leaves the PIT
running, LINT0 unmasked and configured as ExtINT, and PIT unmasked at
the PIC. A guest that then masks LINT0, and then the PIC, receives
the #GP mentioned above following its first sti instruction.

Fix this by calling apic_update_irq() unconditionally after a LINT0
write.

Fixes: a94820ddc3 ("apic: Reevaluate pending interrupts on LVT_LINT0 changes")
Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 hw/intc/apic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 0e8932005f..6fb941cc47 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -1007,7 +1007,8 @@ static int apic_register_write(APICCommonState *s, int index, uint64_t val)
             s->lvt[n] = val;
             if (n == APIC_LVT_TIMER) {
                 apic_timer_update(s, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
-            } else if (n == APIC_LVT_LINT0 && apic_check_pic(s)) {
+            } else if (n == APIC_LVT_LINT0) {
+                apic_check_pic(s);
                 apic_update_irq(s);
             }
         }
-- 
2.43.0


