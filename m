Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2C1606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=CUXUf7Qh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWoyb-0003RG-FO; Fri, 27 Nov 2026 00:58:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWoyM-0003IZ-27; Fri, 27 Nov 2026 00:58:15 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWoyK-0007zH-BT; Fri, 27 Nov 2026 00:58:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758877; bh=NCzU3Opytvw+FiRtdqPUwgtMZk8PjGMfNnxr2VGSZ54=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CUXUf7QhsZgg2aUo7GmdUy/Bvg40XnxwLizheQv6GhaNrysVh1kt2la9hgCNWR0nH
 JtoLUoKBsP5pzzteONCvhjkyGdEuM7yNv+6nQbuny2P88SnAUAi1XUVK6c8FRNr/S6
 cIniSVPeZcCTVSBwKaBLIZJ1m/q8Ly1W1obhTjXOK/T67UIIVKc6mqRBMaEKKwo5+T
 PrcW/QVjIkbAU2h4IzGIvctMso/tcZYQGqTauMC27SJjvj6yJnKXQnnMIplaBu/Bkn
 /E/zA95r91XjnND/Yg8Sz2DoUnQ64jP3myRdnU0kMySSFRT3wrKtuEJsqh9MCp4QXB
 E7H8RFYP/RZSA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B6BDF1EA2EE;
 Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B481D469929;
 Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9C2AACF25E; Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 100/140] target/i386/kvm: fix latched INIT lost in
 kvm_put_vcpu_events()
Date: Fri, 27 Nov 2026 08:53:26 +0300
Message-ID: <20261127055421.39015-41-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
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
(Mjt: context fixup across v10.1.0-428-g602d5ebba26b
 "treewide: clear bits of cs->interrupt_request with cpu_reset_interrupt()")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 98e99374e74..75263fd4115 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5069,8 +5069,9 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
             /* As soon as these are moved to the kernel, remove them
              * from cs->interrupt_request.
              */
-            events.smi.pending = cs->interrupt_request & CPU_INTERRUPT_SMI;
-            events.smi.latched_init = cs->interrupt_request & CPU_INTERRUPT_INIT;
+            events.smi.pending = !!(cs->interrupt_request & CPU_INTERRUPT_SMI);
+            events.smi.latched_init =
+                !!(cs->interrupt_request & CPU_INTERRUPT_INIT);
             cs->interrupt_request &= ~(CPU_INTERRUPT_INIT | CPU_INTERRUPT_SMI);
         } else {
             /* Keep these in cs->interrupt_request.  */
-- 
2.47.3


