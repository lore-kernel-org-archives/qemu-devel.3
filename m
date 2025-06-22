Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92133C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 13:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTKIs-0005a5-W8; Sun, 22 Jun 2025 09:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1uTJum-0002WE-6G
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 08:35:17 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1uTJuh-0007nq-W5
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 08:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zamaudio.com;
 s=protonmail; t=1750595705; x=1750854905;
 bh=v80er9m3aqYundIhzd3eulAhE74whECdgdz/q2Kqci0=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=ZimmrM2lkwMyWFzYyjjVGbfOh55gUTTTlBEfjvZMHIloTA0+hQuod+upz79bRNF0A
 2l62N4VuBTrOAj2Zj+ELRbpwkZfnFZMGG+f8mg8cPwS/9iZGcJ6G72HbcLtmMvHH7t
 wQJfzmF9mmmoKtV/OpX4fbjnz66si50BvpWJMtbCxpoKD3oj3aFTEK1PlCU9HzrhzG
 kk/KLuXlBlO1E241NsezeSXueJKFORV1LotG2yPQec6LH8KysoRukxMvvOyAtiOt2O
 ygDIB0r0fauQ76GXCruXZSVhNLtPXfNQTgPw88jxx4ZYdu8V407bpiJGWSWiMKRare
 dhYHzkxfa85GQ==
Date: Sun, 22 Jun 2025 12:35:02 +0000
To: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
From: Damien Zammit <damien@zamaudio.com>
Subject: [PATCH] hw/i386/pc_piix.c: Add IRQs 14,15 as MADT overrides
Message-ID: <20250622123401.211412-1-damien@zamaudio.com>
Feedback-ID: 43209410:user:proton
X-Pm-Message-ID: b7effeb76110a7e125a0014000b4ad66d6e2ea75
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=51.77.79.158; envelope-from=damien@zamaudio.com;
 helo=mail-0201.mail-europe.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 22 Jun 2025 08:59:50 -0400
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

When PIIX3 IDE is used, these two interrupts are
active-low level-triggered but are not set as MADT overrides.
Since the default for legacy interrupts is on rising edge,
these two extra MADT isa irq overrides are needed.

Signed-off-by: Damien Zammit <damien@zamaudio.com>
---
 hw/i386/pc_piix.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ea7572e783..7320563890 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -181,6 +181,11 @@ static void pc_init1(MachineState *machine, const char=
 *pci_type)
         }
     }
=20
+    /* Add IRQ 14,15 to MADT overrides for PIIX3 IDE */
+    if (pcmc->pci_enabled) {
+        x86ms->pci_irq_mask |=3D (1<<14) | (1<<15);
+    }
+
     pc_machine_init_sgx_epc(pcms);
     x86_cpus_init(x86ms, pcmc->default_cpu_version);
=20
--=20
2.30.2



