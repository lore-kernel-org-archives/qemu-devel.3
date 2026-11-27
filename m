Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4226F606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=P//8IHw7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp8u-0000uG-6O; Fri, 27 Nov 2026 01:09:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp6o-00058y-9c; Fri, 27 Nov 2026 01:06:58 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp6l-0002Oo-PE; Fri, 27 Nov 2026 01:06:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759047; bh=Ez2CW6uCN6iN1XpPgp3r5vbp4s8CSdLpim/6tZINQRo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=P//8IHw7L3V3vt3N2gM734M+DKhSlSe5zF1i4EAkW/dJQuWIM8tTSjXpPMnbG7uRM
 z07YxfDwvmRE2H9FruxULdgwkMSAYi9/fa9zQPXEfGTIrVwM9V+LnYd1Y2slfQDxbZ
 oArcf1n8x8k2i5jRJC1y0+GjoEjmnLCABk45mWnCVykVXRkQzo+WsaDHmVUnC/NXea
 iNrMmXdE3Jj61QnSUFsvnq7BPFtS70idlxQ0n7PvV6ZxJZkRqv4RMhhYdgTz/7HBh9
 mfeeqTcToaFkHNpi1xowZGgGudPnWbNbmBihdmRR7sgNdgp9U2vhN0m/Ei3q+4U7bO
 Ze5RrHUKWBinA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EC3B81EA35E;
 Fri, 27 Nov 2026 08:57:27 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EA03F469989;
 Fri, 27 Nov 2026 08:57:27 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id DF6F0CF30A; Fri, 27 Nov 2026 08:57:27 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 108/152] target/i386/kvm: fix latched INIT lost in
 kvm_put_vcpu_events()
Date: Fri, 27 Nov 2026 08:54:06 +0300
Message-ID: <20261127055709.39630-45-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Denis V. Lunev" <den@openvz.org>

CPU_INTERRUPT_INIT is 0x0400, while kvm_vcpu_events.smi.latched_init
is a __u8. The assignment truncates the masked value to 0, so every
KVM_SET_VCPU_EVENTS tells KVM to clear an INIT it has latched for a
vCPU in SMM. smi.pending survives only because CPU_INTERRUPT_SMI is
0x0040; normalize both with !! like the neighbouring fields.

Fixes: fc12d72e1082 ("target-i386: add support for SMBASE MSR and SMIs")
Cc: qemu-stable@nongnu.org
Signed-off-by: Denis V. Lunev <den@openvz.org>
Link: https://lore.kernel.org/r/20261103181702.832779-1-den@openvz.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit d348cc1e52c8da211b7293b1e1a45cdf2a97b25a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 644c45fb0a0..0f69987bc26 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5511,8 +5511,9 @@ static int kvm_put_vcpu_events(X86CPU *cpu, KvmPutState level)
             /* As soon as these are moved to the kernel, remove them
              * from cs->interrupt_request.
              */
-            events.smi.pending = cs->interrupt_request & CPU_INTERRUPT_SMI;
-            events.smi.latched_init = cs->interrupt_request & CPU_INTERRUPT_INIT;
+            events.smi.pending = !!(cs->interrupt_request & CPU_INTERRUPT_SMI);
+            events.smi.latched_init =
+                !!(cs->interrupt_request & CPU_INTERRUPT_INIT);
             cpu_reset_interrupt(cs, CPU_INTERRUPT_INIT | CPU_INTERRUPT_SMI);
         } else {
             /* Keep these in cs->interrupt_request.  */
-- 
2.47.3


