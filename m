Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A766EEC2A2
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 22:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vueI2-0000MQ-3b; Mon, 23 Feb 2026 17:20:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1vueI0-0000M7-CK
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 17:20:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1vueHy-0006cs-By
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 17:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771885225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DrxxrqBVYKc8B0xIp7sy3PR0C7uqzmLMHDNVqq2QdHs=;
 b=dX4v+PWZvPLQXPVBFbx623iWG2Yqv9Ry0cHb9YEwElygyFQ96kbQrlt1znJKAgG3nuPWkg
 8fIvIhvoh3sWnmbSq1rp1rdZlKg86bsd39Tb7yqJcmTX/M1T05f9XfKL83gGz5VyAvGFtS
 DBwfONnNr1yWQNlfsmP7rjJKrIBkD58=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-PWs3y4LPOO2ON-HM__iNVg-1; Mon,
 23 Feb 2026 17:19:12 -0500
X-MC-Unique: PWs3y4LPOO2ON-HM__iNVg-1
X-Mimecast-MFC-AGG-ID: PWs3y4LPOO2ON-HM__iNVg_1771885151
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D36E1956094; Mon, 23 Feb 2026 22:19:11 +0000 (UTC)
Received: from intellaptop.lan (unknown [10.22.65.168])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 834771955F43; Mon, 23 Feb 2026 22:19:09 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH] accel/kvm: Don't clear pending #SMI in kvm_get_vcpu_events
Date: Mon, 23 Feb 2026 17:19:08 -0500
Message-ID: <20260223221908.361456-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The kvm_get_vcpu_events propogates the state of the pending smi
from the kernel to the cpu->interrupt_request, with the intention
of having un up to date migration state.

Later the opposite is done, the kvm_put_vcpu_events restores the state
of the pending #SMI from the 'cs->interrupt_request'

The only problem is that kvm_get_vcpu_events also resets the SMI
in cpu->interrupt_request when there is no pending #SMI indicated by the kernel,
and that is wrong as the SMI might be still raised by qemu.

While at it, also fix a similar but more theoretical bug with regard to a
latched #INIT while in SMM.

A simple reproducer for this bug is to read an EFI variable in a loop
from within a guest, while at the same time run 'info registers' on
the qemu HMP monitor.

The reads will, once in a while, fail with an 'Invalid argument' error.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 target/i386/kvm/kvm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 9f1a4d4cbb26..bed7768c28d7 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5502,8 +5502,6 @@ static int kvm_get_vcpu_events(X86CPU *cpu)
         }
         if (events.smi.pending) {
             cpu_interrupt(CPU(cpu), CPU_INTERRUPT_SMI);
-        } else {
-            cpu_reset_interrupt(CPU(cpu), CPU_INTERRUPT_SMI);
         }
         if (events.smi.smm_inside_nmi) {
             env->hflags2 |= HF2_SMM_INSIDE_NMI_MASK;
@@ -5512,8 +5510,6 @@ static int kvm_get_vcpu_events(X86CPU *cpu)
         }
         if (events.smi.latched_init) {
             cpu_interrupt(CPU(cpu), CPU_INTERRUPT_INIT);
-        } else {
-            cpu_reset_interrupt(CPU(cpu), CPU_INTERRUPT_INIT);
         }
     }
 
-- 
2.49.0


