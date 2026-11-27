Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0068606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=MIEOFQd/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp8D-0006li-CX; Fri, 27 Nov 2026 01:08:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp7H-00068D-68; Fri, 27 Nov 2026 01:07:30 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp7F-0004SB-6N; Fri, 27 Nov 2026 01:07:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759048; bh=a2ckOXfPPiN5nUU/k7aJk0gUws1gG56TCRzGI47Wdfg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MIEOFQd/M1en6QRgIza67LB+HxmD1ZMfsHsVn6Qd3DzmQH04VrlH7x1NyptLtHBCe
 vig7Kk/dmjzooNSJ7p8ImrWRFMrfqEts3fp5ytbU2d9huG1d55aN34PoWKXUz35RHe
 tuCJVEjWh3lSo6uU45ub1vSzRQKXTb9XG/+kyaM+rhulGFyTmzeP7JIFTHr9Nxa29Q
 0XqyOtYtg4XS5u46OOidwLGfO1V3DI05LG183/ICSMfyV0fd66OQ9twFrHXDMpIEU5
 49Xu7vC3Gqac6Q3DYj2Le6WGy2BAMkFVN4TPLYwc+Z9v5QsT/+A8NENqtveyvvWjKA
 yjZei29jFLbrg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0E5601EA363;
 Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0C03246998E;
 Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id EE1F4CF314; Fri, 27 Nov 2026 08:57:27 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Dongli Zhang <dongli.zhang@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 113/152] target/i386/kvm: set VM ioctl
 KVM_SET_TSC_KHZ to maintain TSC synchronization
Date: Fri, 27 Nov 2026 08:54:11 +0300
Message-ID: <20261127055709.39630-50-mjt@tls.msk.ru>
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
(cherry picked from commit b8619010fc9c01b0ea8505748322d3c40b3d8ae2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 0f69987bc26..6c852299718 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2062,6 +2062,9 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
     int ret;
 
     if (first) {
+        X86CPU *x86cpu = X86_CPU(cpu);
+        CPUX86State *env = &x86cpu->env;
+
         first = false;
 
         /*
@@ -2083,6 +2086,17 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
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
2.47.3


