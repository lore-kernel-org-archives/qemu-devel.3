Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D74CCF9E4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 15:38:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stU5g-0007lN-Sl; Wed, 25 Sep 2024 11:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jusual@redhat.com>) id 1stU5d-0007Zd-8l
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:38:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jusual@redhat.com>) id 1stU5Z-0004I9-Nf
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:38:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727278680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ObYTbRHSwpKo/lff7oF/ipPXIuM9J3H215MZU6dkM8M=;
 b=DH+yPJdtdGz86RHWrdS3x4Gmc+9lXJP99zPVyzv6kILaRqepVBBxFo4plpPk4sqUsAuhOM
 09CyOMQnQ/Qb4montrsyLQE/KuMgqWArIh05mzfh15SphViVFQcy2yahd5Qju5pq2HG+XH
 ORB/im/OSFJkrtZmOSGtwhTJhyWhypw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-vniCtcX2OPKkisL1i03xag-1; Wed,
 25 Sep 2024 11:36:46 -0400
X-MC-Unique: vniCtcX2OPKkisL1i03xag-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B708818E6D22; Wed, 25 Sep 2024 15:36:44 +0000 (UTC)
Received: from tpx1cg9.redhat.com (unknown [10.22.8.79])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6A17519560AA; Wed, 25 Sep 2024 15:36:40 +0000 (UTC)
From: Julia Suvorova <jusual@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Julia Suvorova <jusual@redhat.com>
Subject: [PATCH 2/2] target/i386/kvm: Report which action failed in
 kvm_arch_put/get_registers
Date: Wed, 25 Sep 2024 17:36:23 +0200
Message-ID: <20240925153625.183600-3-jusual@redhat.com>
In-Reply-To: <20240925153625.183600-1-jusual@redhat.com>
References: <20240925153625.183600-1-jusual@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jusual@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

To help debug and triage future failure reports (akin to [1,2]) that
may occur during kvm_arch_put/get_registers, the error path of each
action is accompanied by unique error message.

[1] https://issues.redhat.com/browse/RHEL-7558
[2] https://issues.redhat.com/browse/RHEL-21761

Signed-off-by: Julia Suvorova <jusual@redhat.com>
---
 target/i386/kvm/kvm.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 039ed08825..7cdc87f855 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5133,6 +5133,7 @@ int kvm_arch_put_registers(CPUState *cpu, int level, Error **errp)
     if (level >= KVM_PUT_RESET_STATE) {
         ret = kvm_put_msr_feature_control(x86_cpu);
         if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to set feature control MSR");
             return ret;
         }
     }
@@ -5140,12 +5141,14 @@ int kvm_arch_put_registers(CPUState *cpu, int level, Error **errp)
     /* must be before kvm_put_nested_state so that EFER.SVME is set */
     ret = has_sregs2 ? kvm_put_sregs2(x86_cpu) : kvm_put_sregs(x86_cpu);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to set special registers");
         return ret;
     }
 
     if (level >= KVM_PUT_RESET_STATE) {
         ret = kvm_put_nested_state(x86_cpu);
         if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to set nested state");
             return ret;
         }
     }
@@ -5163,6 +5166,7 @@ int kvm_arch_put_registers(CPUState *cpu, int level, Error **errp)
     if (xen_mode == XEN_EMULATE && level == KVM_PUT_FULL_STATE) {
         ret = kvm_put_xen_state(cpu);
         if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to set Xen state");
             return ret;
         }
     }
@@ -5170,37 +5174,45 @@ int kvm_arch_put_registers(CPUState *cpu, int level, Error **errp)
 
     ret = kvm_getput_regs(x86_cpu, 1);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to set general purpose registers");
         return ret;
     }
     ret = kvm_put_xsave(x86_cpu);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to set XSAVE");
         return ret;
     }
     ret = kvm_put_xcrs(x86_cpu);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to set XCRs");
         return ret;
     }
     ret = kvm_put_msrs(x86_cpu, level);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to set MSRs");
         return ret;
     }
     ret = kvm_put_vcpu_events(x86_cpu, level);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to set vCPU events");
         return ret;
     }
     if (level >= KVM_PUT_RESET_STATE) {
         ret = kvm_put_mp_state(x86_cpu);
         if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to set MP state");
             return ret;
         }
     }
 
     ret = kvm_put_tscdeadline_msr(x86_cpu);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to set TSC deadline MSR");
         return ret;
     }
     ret = kvm_put_debugregs(x86_cpu);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to set debug registers");
         return ret;
     }
     return 0;
@@ -5215,6 +5227,7 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
 
     ret = kvm_get_vcpu_events(cpu);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to get vCPU events");
         goto out;
     }
     /*
@@ -5223,44 +5236,54 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
      */
     ret = kvm_get_mp_state(cpu);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to get MP state");
         goto out;
     }
     ret = kvm_getput_regs(cpu, 0);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to get general purpose registers");
         goto out;
     }
     ret = kvm_get_xsave(cpu);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to get XSAVE");
         goto out;
     }
     ret = kvm_get_xcrs(cpu);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to get XCRs");
         goto out;
     }
     ret = has_sregs2 ? kvm_get_sregs2(cpu) : kvm_get_sregs(cpu);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to get special registers");
         goto out;
     }
     ret = kvm_get_msrs(cpu);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to get MSRs");
         goto out;
     }
     ret = kvm_get_apic(cpu);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to get APIC");
         goto out;
     }
     ret = kvm_get_debugregs(cpu);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to get debug registers");
         goto out;
     }
     ret = kvm_get_nested_state(cpu);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to get nested state");
         goto out;
     }
 #ifdef CONFIG_XEN_EMU
     if (xen_mode == XEN_EMULATE) {
         ret = kvm_get_xen_state(cs);
         if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to get Xen state");
             goto out;
         }
     }
-- 
2.45.0


