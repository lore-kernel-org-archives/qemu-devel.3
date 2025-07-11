Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3792FC83F1D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 00:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua1Hb-0006Ij-3u; Thu, 10 Jul 2025 20:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ua1HW-0006Hh-FK
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 20:06:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ua1HU-0007TQ-5I
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 20:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752192380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=//ztGsaJ7DQrecGOPsh/70M30GSKzk0qLUsRrObxqwU=;
 b=UW2E2IXJ7+7IBS503zyQmqB9+HEOORJZXq1mX3tYZiXpEjc7fPTtFiBHfWQ910ozIiAk+6
 weZpiqcZTEUDGtaQ4XiHn8Gv8j16LToHLzHjFXD+mNu7ejC/71euvIisw/pH3oi9zGA81B
 k13KV0LjThbwRJwwrvj1OTXRWdu1Ty8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-YoKRe1UGOkebmOz5ztW1Yw-1; Thu, 10 Jul 2025 20:06:19 -0400
X-MC-Unique: YoKRe1UGOkebmOz5ztW1Yw-1
X-Mimecast-MFC-AGG-ID: YoKRe1UGOkebmOz5ztW1Yw_1752192378
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-454e25b2b83so3154755e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 17:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752192376; x=1752797176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=//ztGsaJ7DQrecGOPsh/70M30GSKzk0qLUsRrObxqwU=;
 b=WoXnhbHod/YN6cSqiFX+P42vL5BH7dfiKv9MmRTacTQ0/3X/yqHu2kDNHdc5CXbC08
 3shtOIbxlsnoIEBP/OOqLGf73Iv3laQZGTy9bn0fjQ64HJmGqZKqZqNHzvxDju+CQhOm
 FYQqd2TfJY5Q85SGt74RUf4D/ujaF0gMCh2kIFGtbUfzsLWhQ1ybbAARFWLcFtMI9EfH
 E3BJO/HgiILc/aeLFO96nv6nPFRynmzxZCKwuuCkhHcRyzOJSD3JmEvImXFMRhgghBag
 2WXmYsXKCY06NMgfBQqSKTKc2jOK5SXUALUHMM4VFcX/ZqO7oJV+8PFDVCzgBJda4lt1
 yEBA==
X-Gm-Message-State: AOJu0YyOrdjaJpgSlmf21+rFsKI/sLEtUdkKkH22tdSsQIKYzHIyPjcX
 oe3E9kcY3qGd7EM4m6Y5t5onHvy7DVbWLcT+o2WjzTvhrpigOH3GaMdPTVobC6plSI6FXSqA3qf
 wl4S/7s9gBctKyytdKJi2Bsx1stW+jrvYW3O7mkUK1sCQJ6Lcy7KZmgKRjOh73yqkLWmDV0PfdO
 uXZOV3i82ZP3RTYObMGUIB87ToM+zHwOAeafBLQgrd
X-Gm-Gg: ASbGncsPF/nyyzux8H7nnDgwUYYKESuCxbFfzw2rN8QMLWzM2THSlo3kSS1RebYTgKb
 gIfXjdhUTmpXGCloVXKdbd340LeXZ6Vt77FyNAkDUYmp87rbotNCFWvlYu/xIy9k9Grfkud2RqC
 fhuRKtu80/7HQyTUQgzocRNGLRzQGsd5JQyk27XpjDlx6RykVQaqz98rMmcylGKvKw6H0gbAhGU
 Xhmmu0yzYBxAMVpTaEW8d5L2+N8t819yrYuIS9w5vtcdfcIDyRYKTK2jO7eRDmIfeFzJMEdu7kI
 Ff7hg8B9tctXRG28qjDhuiVeOYUhfb20MxTkXW7ffDh3
X-Received: by 2002:a05:600c:4444:b0:453:6ca:16b1 with SMTP id
 5b1f17b1804b1-454ec2726c9mr5489275e9.26.1752192376236; 
 Thu, 10 Jul 2025 17:06:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+/T1OnB8IvOBYkpp76pElaF0Nz3/XEzCi3Q0BfqeJntjn+ksixk15n+UWeqJzBUAhHjIEtQ==
X-Received: by 2002:a05:600c:4444:b0:453:6ca:16b1 with SMTP id
 5b1f17b1804b1-454ec2726c9mr5489065e9.26.1752192375680; 
 Thu, 10 Jul 2025 17:06:15 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.202.169])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e269a0sm2989574f8f.86.2025.07.10.17.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 17:06:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	zhao1.liu@intel.com
Subject: [PATCH 1/4] target/i386: move max_features to class
Date: Fri, 11 Jul 2025 02:06:00 +0200
Message-ID: <20250711000603.438312-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711000603.438312-1-pbonzini@redhat.com>
References: <20250711000603.438312-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

max_features is always set to true for instances created by -cpu max or
-cpu host; it's always false for other classes.  Therefore it can be
turned into a field in the X86CPUClass.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h         | 2 +-
 target/i386/cpu.c         | 5 +++--
 target/i386/hvf/hvf-cpu.c | 3 ++-
 target/i386/kvm/kvm-cpu.c | 5 +++--
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 51e10139dfd..be3ae6d546e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2196,7 +2196,6 @@ struct ArchCPU {
     bool expose_tcg;
     bool migratable;
     bool migrate_smi_count;
-    bool max_features; /* Enable all supported features automatically */
     uint32_t apic_id;
 
     /* Enables publishing of TSC increment and Local APIC bus frequencies to
@@ -2349,6 +2348,7 @@ struct X86CPUClass {
      */
     const X86CPUModel *model;
 
+    bool max_features; /* Enable all supported features automatically */
     bool host_cpuid_required;
     int ordering;
     bool migration_safe;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0d35e95430f..624cebc3ff7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6187,6 +6187,7 @@ static void max_x86_cpu_class_init(ObjectClass *oc, const void *data)
 
     xcc->ordering = 9;
 
+    xcc->max_features = true;
     xcc->model_description =
         "Enables all features supported by the accelerator in the current host";
 
@@ -6201,7 +6202,6 @@ static void max_x86_cpu_initfn(Object *obj)
     /* We can't fill the features array here because we don't know yet if
      * "migratable" is true or false.
      */
-    cpu->max_features = true;
     object_property_set_bool(OBJECT(cpu), "pmu", true, &error_abort);
 
     /*
@@ -8282,6 +8282,7 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
  */
 void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
 {
+    X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
     CPUX86State *env = &cpu->env;
     FeatureWord w;
     int i;
@@ -8306,7 +8307,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
      * plus_features & minus_features to global properties
      * inside x86_cpu_parse_featurestr() too.
      */
-    if (cpu->max_features) {
+    if (xcc->max_features) {
         for (w = 0; w < FEATURE_WORDS; w++) {
             /* Override only features that weren't set explicitly
              * by the user.
diff --git a/target/i386/hvf/hvf-cpu.c b/target/i386/hvf/hvf-cpu.c
index dfdda701268..2b991f2fc8e 100644
--- a/target/i386/hvf/hvf-cpu.c
+++ b/target/i386/hvf/hvf-cpu.c
@@ -61,13 +61,14 @@ static void hvf_cpu_xsave_init(void)
 static void hvf_cpu_instance_init(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
+    X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
 
     host_cpu_instance_init(cpu);
 
     /* Special cases not set in the X86CPUDefinition structs: */
     /* TODO: in-kernel irqchip for hvf */
 
-    if (cpu->max_features) {
+    if (xcc->max_features) {
         hvf_cpu_max_instance_init(cpu);
     }
 
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 16bde4de01e..0fb88a239d4 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -41,6 +41,7 @@ static void kvm_set_guest_phys_bits(CPUState *cs)
 static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
 {
     X86CPU *cpu = X86_CPU(cs);
+    X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
     CPUX86State *env = &cpu->env;
     bool ret;
 
@@ -63,7 +64,7 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
      *   check/update ucode_rev, phys_bits, guest_phys_bits, mwait
      *   cpu_common_realizefn() (via xcc->parent_realize)
      */
-    if (cpu->max_features) {
+    if (xcc->max_features) {
         if (enable_cpu_pm) {
             if (kvm_has_waitpkg()) {
                 env->features[FEAT_7_0_ECX] |= CPUID_7_0_ECX_WAITPKG;
@@ -216,7 +217,7 @@ static void kvm_cpu_instance_init(CPUState *cs)
         x86_cpu_apply_props(cpu, kvm_default_props);
     }
 
-    if (cpu->max_features) {
+    if (xcc->max_features) {
         kvm_cpu_max_instance_init(cpu);
     }
 
-- 
2.50.0


