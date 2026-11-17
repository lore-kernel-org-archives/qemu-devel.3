Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA41606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G48ud81k
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTJNs-0006Zw-Rj; Tue, 17 Nov 2026 08:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTJNr-0006ZE-Jt
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:38:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTJNp-00036b-TC
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:38:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794922681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LTwhbN2nqT3khoZUJPypm+ot7xzNDpu1k7s2VFipAQU=;
 b=G48ud81kHTmn07PG4Mk4x8k016w8RMX4Z0Aks1uqx7DezWBdjVM1qA/PYy/oMpNN/a4hP+
 3ROKF30Dns+ITlp5+Pc7atLTExieoc/G0f+HcXboWrSU6czl08u132vHX2mZ+5ASwnaBBZ
 N7cqcLRkeca8Og8qbtjLzJ8vFA+5owQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-LzFL9IlqOFuMuljlhdWQGA-1; Tue,
 17 Nov 2026 08:37:59 -0500
X-MC-Unique: LzFL9IlqOFuMuljlhdWQGA-1
X-Mimecast-MFC-AGG-ID: LzFL9IlqOFuMuljlhdWQGA_1794922679
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2D951800367; Tue, 17 Nov 2026 13:37:58 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 08BA941F; Tue, 17 Nov 2026 13:37:57 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Dongli Zhang <dongli.zhang@oracle.com>
Subject: [PULL 05/15] target/i386/kvm: set VM ioctl KVM_SET_TSC_KHZ to
 maintain TSC synchronization
Date: Tue, 17 Nov 2026 14:37:40 +0100
Message-ID: <20261117133750.322253-6-pbonzini@redhat.com>
In-Reply-To: <20261117133750.322253-1-pbonzini@redhat.com>
References: <20261117133750.322253-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Dongli Zhang <dongli.zhang@oracle.com>

When the guest and host use different TSC frequencies - specifically when
"tsc-frequency" is configured - the guest TSC becomes unsynchronized after
additional vCPUs are added.

Suppose the host TSC frequency is 2596.102 MHz. Here are steps to
reproduce:

Create the QEMU instance with a different TSC frequency 2596.100 MHz.

-cpu host,tsc-frequency=2596100000 \
-smp 2,maxcpus=8 \

After the guest VM has booted, add two additional vCPUs.

(qemu) device_add host-x86_64-cpu,id=core2,socket-id=0,core-id=2,thread-id=0
(qemu) device_add host-x86_64-cpu,id=core3,socket-id=0,core-id=3,thread-id=0

The guest TSC becomes unsynchronized. The vCPUs end up with different TSC
offsets.

host# cat /sys/kernel/debug/kvm/167789-11/vcpu0/tsc-offset
-345550695701016
host# cat /sys/kernel/debug/kvm/167789-11/vcpu1/tsc-offset
-345550695701016
host# cat /sys/kernel/debug/kvm/167789-11/vcpu2/tsc-offset
-345700146347894
host# cat /sys/kernel/debug/kvm/167789-11/vcpu3/tsc-offset
-345700945993728

This issue occurs because KVM synchronizes the guest TSC twice for each
newly added vCPU. In other words, kvm_synchronize_tsc() is invoked twice
per vCPU by KVM.

During the first synchronization, kvm->arch.default_tsc_khz is used. During
the second synchronization, the TSC frequency configured by QEMU is used.
Because different TSC frequencies are used during these two synchronization
steps, the guest TSC becomes unsynchronized in KVM.

Linux kernel commit ffbb61d09fc5 ("KVM: x86: Accept KVM_[GS]ET_TSC_KHZ as
a VM ioctl.") introduced support in KVM to help mitigate this issue. QEMU
should add corresponding support to address the problem on its side.

Always issue the VM ioctl KVM_SET_TSC_KHZ before creating any vCPUs, so
that the default TSC frequency is set correctly for all subsequently
created vCPUs.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Link: https://lore.kernel.org/r/20260210202041.153736-1-dongli.zhang@oracle.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 2d533d4262b..76528f1123f 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2064,6 +2064,9 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
     int ret;
 
     if (first) {
+        X86CPU *x86cpu = X86_CPU(cpu);
+        CPUX86State *env = &x86cpu->env;
+
         first = false;
 
         /*
@@ -2085,6 +2088,17 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
                 return ret;
             }
         }
+
+        if (!is_tdx_vm() && env->tsc_khz &&
+            kvm_check_extension(kvm_state, KVM_CAP_VM_TSC_CONTROL)) {
+            ret = kvm_vm_ioctl(kvm_state, KVM_SET_TSC_KHZ, env->tsc_khz);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret,
+                           "Unable to set TSC frequency to %"PRId64" kHz",
+                           env->tsc_khz);
+                return ret;
+            }
+        }
     }
 
     if (is_tdx_vm()) {
-- 
2.56.0



