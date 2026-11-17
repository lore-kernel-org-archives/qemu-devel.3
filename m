Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17262606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JmUbtudK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTJNu-0006bW-Vf; Tue, 17 Nov 2026 08:38:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTJNs-0006Zm-CB
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:38:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTJNq-00036z-Qw
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794922682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PAqdlDBUK3KF7IPQrCnLZnJHYSzmn5xulUU2OWyh1gE=;
 b=JmUbtudKoStFfBHOajwe8z+aRgFWlK0XRckd8SXYpg/RjjwdyDAqUc5wL5riDjmHxjrJkp
 cLCL94Bjb+AUBT3q7wELFkOJC/xSJ8WZpDpSdtzZVL8ys9hs8EXTgGwTvYoMgiMdd9+R3l
 3Pz3lhTgPvYmImqGRVAlUrYx5QSMKMo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-Gy9hgFDgNlW92Qq_XgYlxg-1; Tue,
 17 Nov 2026 08:37:58 -0500
X-MC-Unique: Gy9hgFDgNlW92Qq_XgYlxg-1
X-Mimecast-MFC-AGG-ID: Gy9hgFDgNlW92Qq_XgYlxg_1794922678
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 799711800546; Tue, 17 Nov 2026 13:37:57 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 362E841F; Tue, 17 Nov 2026 13:37:56 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>,
	qemu-stable@nongnu.org
Subject: [PULL 04/15] target/i386/kvm: fix latched INIT lost in
 kvm_put_vcpu_events()
Date: Tue, 17 Nov 2026 14:37:39 +0100
Message-ID: <20261117133750.322253-5-pbonzini@redhat.com>
In-Reply-To: <20261117133750.322253-1-pbonzini@redhat.com>
References: <20261117133750.322253-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
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
---
 target/i386/kvm/kvm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e29ecaba575..2d533d4262b 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5514,8 +5514,9 @@ static int kvm_put_vcpu_events(X86CPU *cpu, KvmPutState level)
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
2.56.0



