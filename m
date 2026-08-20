Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16EDC5DF86
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5yx-0004i8-2D; Thu, 20 Aug 2026 12:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yq-0004On-JM
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yn-0005Y8-Uq
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=61P6vk3oEE4JHqQ8OG8SmOWu+7pk+rtqZm31zmMIl+c=;
 b=LiP7mZxOQbxTOlcLDXSYuSDl06RLxwEBr8h2uHXFd7jTDA4+VP6RiJ4KZu7xB4uWhD2kal
 Pa+9x89ITAE873NbGMbx7X7PWjRYnQ878V2HHEwkcFHDEf1lpsn4050TERhOr266lDIgaJ
 tBnjtzvmRSShLAQZ2CawAO5g0e7YC5c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-k1AKavqCM4GFyHGGD0VExA-1; Thu, 20 Aug 2026 12:50:52 -0400
X-MC-Unique: k1AKavqCM4GFyHGGD0VExA-1
X-Mimecast-MFC-AGG-ID: k1AKavqCM4GFyHGGD0VExA_1787244651
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493fa6e28a7so315595e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244651; x=1787849451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=61P6vk3oEE4JHqQ8OG8SmOWu+7pk+rtqZm31zmMIl+c=;
 b=XIprMvAJ3JJ/X+jEfRyAdmExPi6eTntf1tADzuylq8SMlPSYp4heNp1OwgHq7q8Tkp
 8kp6YTFsJISOtfj/G5w5WshQqSOcWiNvhS1KLkye/XzTNHNfqWMv4iDgLjSi1uVbAhq6
 A5RCi2GLjRh/9NdGnS0MDiyLJv6SNP8GpexhsloEgEGzJ79NQjNJcgOD6voHWVAapuHs
 ybcmLVG3887cAlQT2f5QY5VPL+A2W/8Evtdzw+wUrCeJQpFEBU/50DcE71ck9+7usjTR
 RFvSsmEzxlhXhI5QmYy3lCiyXJPoglEP0Ltq57pxYt5OR4rNU31ZruW5mNvqYjY+nOZs
 VY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244651; x=1787849451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=61P6vk3oEE4JHqQ8OG8SmOWu+7pk+rtqZm31zmMIl+c=;
 b=ky2FZOIkrwQWz+8Aei8ZpGMUsiAy1/QNb1ZZPk5aAQ6PoRhdEq3/1lZ+pQpHoO3WyA
 3B/xflOWYSagaf9Z+YdByRQ0eP22CwWEudWmfuf8A4xq84C66cs3rFfnIZRnHeq7gGqk
 V4xs/Ohsk5igrm9V2KmM0VdMhFpT1XgXvz9JVjmWm93NjbY9Tdl+iQowRPFyawT1XhBr
 W1+Bcus1HRJz0NmJLLAhBfSfNp8idNtN2k3qP6LO0kLfeo59XVhxe+EjrqYchoTWsCRn
 N5EhDsdeMAm87ApOKzvH38TA0nP9M5FP0BZ+1FGVr5hhUKnCJEzeIjbFsVzS7cQQl01S
 mIFQ==
X-Gm-Message-State: AOJu0YwVMBr/kdYnKMMO5gl8B4VjAq/Sd7aCV7Tz9P3cwqjXZ9n+K93b
 Ye/LbKucUQm7vTxX1zMXSp3B+TYoKdo9wIAbi2HzuGlwUPCn14uZ9pDIpcK1M+Mp0AlB3QxOAHq
 5rCUa2ms/TQRhLIMUt98HQHA3Srjx+KkzfiybieekNebwD57DeUFcL9qU3ooYZlB/uAeBDYsIx5
 zBoZ99OMEMmNk9zoMyBkY99IbpBP+vpF28I5VG78X6
X-Gm-Gg: AR+sD13D+QLWiVnU3jLFNjvN2JpVfn1l93K81oihrvmBe08/kALCO3meG29l5g9tc6H
 /62q1DqDMe87/RCbvGukf6sgaahEz6jGHjQVfha+7lvqhtrjBSfbmHb7twiF9FCyI/OB6DFY9FR
 Jv4mtR3lsuiaINgAHqltfj5PnStkGpUhqRcUcqhTbfXSrtpvwgm1RoRJaPpr99CceHET9/SID3g
 302QdPq/7K5arYAP9/LW7kgORpQDnlAvvVq0L67vS7Tj3yEcaYQJbcE1e9WJVcQaHob+bXinVY6
 ERSgOAMGaQs9ose7HCtiXfbQ/kQQzWcELbP3He56rNEom2nILq08UdbS3oSG5WKZ9rYhUslHV5r
 kjEFUbvem3rhuYmyovPleAF+m1/IGBc0lulys7t45uxFp7R7KllYnbtDY3NK4CA/m52zCFyi9Xg
 /w+bw=
X-Received: by 2002:a05:600c:4f12:b0:499:b682:12bb with SMTP id
 5b1f17b1804b1-499b82e8cb4mr5701305e9.1.1787244651485; 
 Thu, 20 Aug 2026 09:50:51 -0700 (PDT)
X-Received: by 2002:a05:600c:4f12:b0:499:b682:12bb with SMTP id
 5b1f17b1804b1-499b82e8cb4mr5700215e9.1.1787244651101; 
 Thu, 20 Aug 2026 09:50:51 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b2b0c295sm40686755e9.2.2026.08.20.09.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:50:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 17/53] accel/mshv: write synthetic MSRs after migration
Date: Thu, 20 Aug 2026 18:49:20 +0200
Message-ID: <20260820164957.1895963-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Write partition-wide synthetic MSRs. This ensures the hypercall page and
SynIC facilities are set up before vCPUs attempt to use it.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260710101534.664604-10-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/hyperv/hvgdk_mini.h |  3 +++
 include/system/mshv_int.h      |  1 +
 accel/mshv/mshv-all.c          | 15 +++++++++++++++
 target/i386/mshv/mshv-cpu.c    | 15 +++++++++++++++
 4 files changed, 34 insertions(+)

diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
index 0602a7c6cc6..a5527d49cf7 100644
--- a/include/hw/hyperv/hvgdk_mini.h
+++ b/include/hw/hyperv/hvgdk_mini.h
@@ -23,6 +23,9 @@
 #define HV_X64_MSR_APIC_FREQUENCY   0x40000023
 
 typedef enum hv_register_name {
+    /* VP Management Registers */
+    HV_REGISTER_INTERNAL_ACTIVITY_STATE = 0x00000004,
+
     /* Pending Interruption Register */
     HV_REGISTER_PENDING_INTERRUPTION = 0x00010002,
     HV_REGISTER_INTERRUPT_STATE      = 0x00010003,
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 063852115eb..cbfcb8611b4 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -98,6 +98,7 @@ int mshv_get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
                           size_t n_regs);
 int mshv_arch_store_vcpu_state(const CPUState *cpu);
 int mshv_arch_load_vcpu_state(CPUState *cpu);
+int mshv_arch_set_partition_msrs(const CPUState *cpu);
 void mshv_arch_init_vcpu(CPUState *cpu);
 void mshv_arch_destroy_vcpu(CPUState *cpu);
 void mshv_arch_amend_proc_features(
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 1516475f34f..1ca1d4b54ff 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -60,6 +60,20 @@ static int init_mshv(int *mshv_fd)
     return 0;
 }
 
+static int mshv_load_cleanup(void *opaque)
+{
+    int ret;
+
+    ret = mshv_arch_set_partition_msrs(first_cpu);
+    if (ret < 0) {
+        error_report("Failed to set partition MSRs: %s", strerror(-ret));
+        return -1;
+    }
+
+    return 0;
+}
+
+
 static int get_host_partition_property(int mshv_fd, uint32_t property_code,
                                        uint64_t *value)
 {
@@ -496,6 +510,7 @@ static int mshv_init_vcpu(CPUState *cpu)
 }
 
 static SaveVMHandlers savevm_mshv = {
+    .load_cleanup = mshv_load_cleanup,
 };
 
 static int mshv_init(AccelState *as, MachineState *ms)
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 86d64c67fb2..6bb3045752c 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1506,6 +1506,21 @@ int mshv_arch_store_vcpu_state(const CPUState *cpu)
     return 0;
 }
 
+int mshv_arch_set_partition_msrs(const CPUState *cpu)
+{
+    CPUX86State *env = &X86_CPU(cpu)->env;
+    struct hv_register_assoc assocs[] = {
+        { .name = HV_REGISTER_GUEST_OS_ID,
+          .value.reg64 = env->msr_hv_guest_os_id },
+        { .name = HV_REGISTER_REFERENCE_TSC,
+          .value.reg64 = env->msr_hv_tsc },
+        { .name = HV_X64_REGISTER_HYPERCALL,
+          .value.reg64 = env->msr_hv_hypercall },
+    };
+
+    return mshv_set_generic_regs(cpu, assocs, ARRAY_SIZE(assocs));
+}
+
 void mshv_arch_amend_proc_features(
     union hv_partition_synthetic_processor_features *features)
 {
-- 
2.55.0


