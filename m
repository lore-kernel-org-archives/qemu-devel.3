Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019A8C54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtw1-0000t8-F9; Fri, 30 May 2025 03:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvz-0000ne-N1
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvx-0006s1-RQ
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=doRJyOV8AutyhhZgEY/vOvD1MJZqBWNu1U5QaUUdXKk=;
 b=DEovMjAmod+zjPxxK2Qegj0ha9WWLKp8aq5iSWMm9chkxA0MY9ngqtoVx6OWj9wDly7OPE
 /cS/tJmCZ2jqMNzlpmdz2ysrJnqor2r+5X1qrbnsvrYJIpfeP7a9WlLsd0j+2A5WbJFaOj
 Hr4RpI8X+tMDmtko8ExnIqu8WUOKPyE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-1tCYav-aMm-Wh8RQg5cQRg-1; Fri, 30 May 2025 03:13:39 -0400
X-MC-Unique: 1tCYav-aMm-Wh8RQg5cQRg-1
X-Mimecast-MFC-AGG-ID: 1tCYav-aMm-Wh8RQg5cQRg_1748589219
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ad89da57be0so148841166b.3
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589218; x=1749194018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=doRJyOV8AutyhhZgEY/vOvD1MJZqBWNu1U5QaUUdXKk=;
 b=GAT5i6PkXHrjtJZOgCZ+XLBSnNHjd9Q1tHTguu+ezX1Wtvqvq2VybxezU3ZexDfXs6
 0A3HVn5hfhN2clFP/1AQyHwAQtZdS70I8I8zD4EXHN0LA/F2PE4vy2+vXHnxtcseS4a3
 1JP0Wf7mvWDlOLg39Q/pArxpEprt5nbVJCslzZuWgL//KtKroT91lnzQR1jJUTf6lvE3
 LjMeXYE86ANuo3mwMMyxE+8O+EMjefmZqDNo9KdCzCpQZinK2C0ETwd85nlM/3Uur2IN
 o9wGiD4mJKf56+Ynq8u1lyz1LW3YIMVZmB/7zi8gYjdcWYxiSgsoJu7x//+SjaLO2BLX
 x7XA==
X-Gm-Message-State: AOJu0Yw3WmbONlAjfqSyk4noyduSCdfJ5cj8EUy8nVJTQ4o5cRxnuLFF
 9s3dircmvtf6l1fzEF6sD1evZh+HLa/WTMjH8pv0k9xFDl4mWquZXphEDfw+aBZJb4qM7kGolHt
 7lBQ0+Jmll45r1YAnui/RFcIkgIf8BcUUN9DrstNdojhalwt5gZNkyIOLpbpliddIqPYRNY81Nl
 ZqkcrehY17TRwkep4/1jrdbxyRUgLHQvOagxoZp9A3
X-Gm-Gg: ASbGnctfK6qJWpRNKQM1nJL8yF+IHt1zYUdU2nybCub6HrNlfogTBNT0aj/W+mL1SlP
 e5b0LQn6b+eESD6dJm4uMO5TQNpZr8AW7rMlixWro/YVnzD0rNkXW+ybeA24c/FM2wbgi4kK7/9
 5Vg6J22gQHwPllVOV5yamQTjia8huz2UUEy3CHdgQGJixo6/8IDpXNZn8+5fSqiTXFMoUYQAoVb
 sfmwz+a5yer2PDvtsBUi0fICILxQZl1cbTE9jJfmScfAPyjjvvSyLw+VGMoixQ36QtPhkPtvbng
 KWcMtQDaXqgPzg==
X-Received: by 2002:a17:907:7203:b0:ad5:8594:652e with SMTP id
 a640c23a62f3a-adb36ba4b75mr91480966b.35.1748589218007; 
 Fri, 30 May 2025 00:13:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPBgM0CZPRSGDRT9KDmcuHIIl6zmlTOavLAL/DvRI8Wzp43R8yGxdjJFomWlNypFVerQ8gZg==
X-Received: by 2002:a17:907:7203:b0:ad5:8594:652e with SMTP id
 a640c23a62f3a-adb36ba4b75mr91472866b.35.1748589217250; 
 Fri, 30 May 2025 00:13:37 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5dd043c2sm275945466b.102.2025.05.30.00.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:13:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 19/77] kvm: Introduce kvm_arch_pre_create_vcpu()
Date: Fri, 30 May 2025 09:11:49 +0200
Message-ID: <20250530071250.2050910-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Introduce kvm_arch_pre_create_vcpu(), to perform arch-dependent
work prior to create any vcpu. This is for i386 TDX because it needs
call TDX_INIT_VM before creating any vcpu.

The specific implementation for i386 will be added in the future patch.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-8-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/kvm.h       | 1 +
 accel/kvm/kvm-all.c        | 5 +++++
 target/arm/kvm.c           | 5 +++++
 target/i386/kvm/kvm.c      | 5 +++++
 target/loongarch/kvm/kvm.c | 4 ++++
 target/mips/kvm.c          | 5 +++++
 target/ppc/kvm.c           | 5 +++++
 target/riscv/kvm/kvm-cpu.c | 5 +++++
 target/s390x/kvm/kvm.c     | 5 +++++
 9 files changed, 40 insertions(+)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index b690dda1370..62ec131d4d8 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -376,6 +376,7 @@ int kvm_arch_get_default_type(MachineState *ms);
 
 int kvm_arch_init(MachineState *ms, KVMState *s);
 
+int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp);
 int kvm_arch_init_vcpu(CPUState *cpu);
 int kvm_arch_destroy_vcpu(CPUState *cpu);
 
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 278a50690c9..42d239cf8f2 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -545,6 +545,11 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
 
     trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
 
+    ret = kvm_arch_pre_create_vcpu(cpu, errp);
+    if (ret < 0) {
+        goto err;
+    }
+
     ret = kvm_create_vcpu(cpu);
     if (ret < 0) {
         error_setg_errno(errp, -ret,
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index a2791aa866f..74fda8b8090 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1846,6 +1846,11 @@ static int kvm_arm_sve_set_vls(ARMCPU *cpu)
 
 #define ARM_CPU_ID_MPIDR       3, 0, 0, 0, 5
 
+int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
+{
+    return 0;
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     int ret;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 6d88495d476..446f0600d4e 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2051,6 +2051,11 @@ full:
     abort();
 }
 
+int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
+{
+    return 0;
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     struct {
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 1bda570482c..c66bdd5302a 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1071,7 +1071,11 @@ static int kvm_cpu_check_pv_features(CPUState *cs, Error **errp)
             env->pv_features |= BIT(KVM_FEATURE_VIRT_EXTIOI);
         }
     }
+    return 0;
+}
 
+int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
+{
     return 0;
 }
 
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index d67b7c1a8ec..ec53acb51a1 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -61,6 +61,11 @@ int kvm_arch_irqchip_create(KVMState *s)
     return 0;
 }
 
+int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
+{
+    return 0;
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     CPUMIPSState *env = cpu_env(cs);
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 8a957c3c7d4..015658049e6 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -479,6 +479,11 @@ static void kvmppc_hw_debug_points_init(CPUPPCState *cenv)
     }
 }
 
+int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
+{
+    return 0;
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index efb41fac53e..e1a04be20fe 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1472,6 +1472,11 @@ static int kvm_vcpu_enable_sbi_dbcn(RISCVCPU *cpu, CPUState *cs)
     return kvm_set_one_reg(cs, kvm_sbi_dbcn.kvm_reg_id, &reg);
 }
 
+int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
+{
+    return 0;
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     int ret = 0;
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 6cd2ebc5f1f..67d9a1977c0 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -398,6 +398,11 @@ unsigned long kvm_arch_vcpu_id(CPUState *cpu)
     return cpu->cpu_index;
 }
 
+int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
+{
+    return 0;
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     unsigned int max_cpus = MACHINE(qdev_get_machine())->smp.max_cpus;
-- 
2.49.0


