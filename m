Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC494C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 07:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua8bQ-0001N0-50; Fri, 11 Jul 2025 03:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ua8bH-0001LJ-RJ
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 03:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ua8bE-00075M-D5
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 03:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752220513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=q6nTEsoCuSJ3UH4OjROxuNbEuTg0QB24XVyppadmgMI=;
 b=CT6H6hbL/tN2L1e7Xli8rM6RlKdKRAeYDHG1xsZP1CFtuPyZ2YpbUM1bx5T+AXMoetPqEE
 o7LL+00BQBZ3jVCIseFj+0zTa5Bl9pe6FlDxUg7ZDZO44xIjgtLDmkIeAMYL2GkOE9AeuH
 Q118hLlq/WV1LsdL0RxNbOsoyV6XrN0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-2Kn5U352MZ6P90ITIEhtmA-1; Fri, 11 Jul 2025 03:55:12 -0400
X-MC-Unique: 2Kn5U352MZ6P90ITIEhtmA-1
X-Mimecast-MFC-AGG-ID: 2Kn5U352MZ6P90ITIEhtmA_1752220511
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-454dee17a91so11259955e9.3
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 00:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752220511; x=1752825311;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q6nTEsoCuSJ3UH4OjROxuNbEuTg0QB24XVyppadmgMI=;
 b=E12e+xYiFQdTNTTmnl0subtAvgcPOIe6Xc5kRj/apktvs8onQuvTr+Ul9b3B0y3mBg
 ybQ0GwxzQhVO8fqoHyDuVuj+aYaqF2cpNU2lR+QxK1XO2oyJIDZhDYoxllo/AndWFc/N
 nuMW4408uVTMPjoX11/Okgi/Be6mZO48FK7AsF1uVHaDjIPQCMwmwuQ9OKP+k157JjHK
 g6/gYm/K8aHKmDAcyEwTGtucY16egdsKi13uKxOsoHXdtQ4NY50m+lJVn4lNRnRwAOdt
 oWPTB2/tOdg7BdvtPj2BovSBMYUaVlQRl+CKGSWBr+C0jcQKmA5vKpsW4IHhGzGXbWgd
 f55Q==
X-Gm-Message-State: AOJu0YyabXxQnInVzM+UurNn9xgUgFVe4YimXpHCns7tv1rRyAYfca3Z
 CoHYjnctNiiVeb15E1Ay6Rcg20k9S5INYzOXqdN6nw2o9UA3mWlvtG1S16FlRddNpGbbqoZdwUu
 PX2fzBmoFF73gbIfZ00kLxdJMWfGPa1m9SIQ2gEuPMoK/e6msgJKXumTU2G75TdDLBMWg2exyZU
 jtYOEKCQE+IllkO95D/RIpYfxp0d6kl/+RAK4u+qIN
X-Gm-Gg: ASbGncsk4xxsv8CVFOml3fHf9Aqbjr2qQSEVSV2TT084/Pg4IgP/4FBnNSHVcajU9OH
 R6g8xtuz63g4c+BVQ2kz9SeEOVrHPpRA30BiwF5dYjKNRIbhwq8Iqm6cJspN8qetMB0tQOua+EZ
 uukPTEB4IZo6alZg6qWyMFvh/SiGngMPhkK1Rj2N9PGJ8/0ea5rdbI4YorNKVoLmauywk/baQZm
 /yDntQdHVHbBDo6vk0ML/R1W5B7pNB1R00KfxKDm+FbqTsJvseaXQX8a1/oalJDPwZs83QoBmtv
 jVZD6HZPjyc0H4yDnO/c7Aj4vClt7XH6Xmop/sF66fzi
X-Received: by 2002:a05:6000:2507:b0:3a4:e1e1:7779 with SMTP id
 ffacd0b85a97d-3b5f18d98abmr2183459f8f.32.1752220510573; 
 Fri, 11 Jul 2025 00:55:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7SMlU6DFNSdl5drslXt+Sw4MwkiyXJTy6FzxBMapskd2ZNu0Y7ljS8X0Q/cIwA8BYcUU/zQ==
X-Received: by 2002:a05:6000:2507:b0:3a4:e1e1:7779 with SMTP id
 ffacd0b85a97d-3b5f18d98abmr2183424f8f.32.1752220510116; 
 Fri, 11 Jul 2025 00:55:10 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.202.169])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1741sm3840056f8f.18.2025.07.11.00.55.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 00:55:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH] target/i386: merge host_cpu_instance_init() and
 host_cpu_max_instance_init()
Date: Fri, 11 Jul 2025 09:55:06 +0200
Message-ID: <20250711075507.451540-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
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

Simplify the accelerators' cpu_instance_init callbacks by doing all
host-cpu setup in a single function.

Based-on: <20250711000603.438312-1-pbonzini@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/host-cpu.c    | 28 ++++++++++++++--------------
 target/i386/hvf/hvf-cpu.c |  2 --
 target/i386/kvm/kvm-cpu.c |  2 --
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
index 7512567298b..3399edc1ad0 100644
--- a/target/i386/host-cpu.c
+++ b/target/i386/host-cpu.c
@@ -132,27 +132,27 @@ void host_cpu_instance_init(X86CPU *cpu)
 {
     X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
 
-    if (xcc->model) {
-        char vendor[CPUID_VENDOR_SZ + 1];
-
-        host_cpu_vendor_fms(vendor, NULL, NULL, NULL);
-        object_property_set_str(OBJECT(cpu), "vendor", vendor, &error_abort);
-    }
-}
-
-void host_cpu_max_instance_init(X86CPU *cpu)
-{
     char vendor[CPUID_VENDOR_SZ + 1] = { 0 };
     char model_id[CPUID_MODEL_ID_SZ + 1] = { 0 };
     int family, model, stepping;
 
+    /*
+     * setting vendor applies to both max/host and builtin_x86_defs CPU.
+     * FIXME: this probably should warn or should be skipped if vendors do
+     * not match, because family numbers are incompatible between Intel and AMD.
+     */
+    host_cpu_vendor_fms(vendor, &family, &model, &stepping);
+    object_property_set_str(OBJECT(cpu), "vendor", vendor, &error_abort);
+
+    if (!xcc->max_features) {
+        return;
+    }
+
+    host_cpu_fill_model_id(model_id);
+
     /* Use max host physical address bits if -cpu max option is applied */
     object_property_set_bool(OBJECT(cpu), "host-phys-bits", true, &error_abort);
 
-    host_cpu_vendor_fms(vendor, &family, &model, &stepping);
-    host_cpu_fill_model_id(model_id);
-
-    object_property_set_str(OBJECT(cpu), "vendor", vendor, &error_abort);
     object_property_set_int(OBJECT(cpu), "family", family, &error_abort);
     object_property_set_int(OBJECT(cpu), "model", model, &error_abort);
     object_property_set_int(OBJECT(cpu), "stepping", stepping,
diff --git a/target/i386/hvf/hvf-cpu.c b/target/i386/hvf/hvf-cpu.c
index 2b991f2fc8e..94ee096ecf7 100644
--- a/target/i386/hvf/hvf-cpu.c
+++ b/target/i386/hvf/hvf-cpu.c
@@ -21,8 +21,6 @@ static void hvf_cpu_max_instance_init(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
 
-    host_cpu_max_instance_init(cpu);
-
     env->cpuid_min_level =
         hvf_get_supported_cpuid(0x0, 0, R_EAX);
     env->cpuid_min_xlevel =
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 6fed353548e..a99b8764644 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -109,8 +109,6 @@ static void kvm_cpu_max_instance_init(X86CPU *cpu)
     CPUX86State *env = &cpu->env;
     KVMState *s = kvm_state;
 
-    host_cpu_max_instance_init(cpu);
-
     object_property_set_bool(OBJECT(cpu), "pmu", true, &error_abort);
 
     if (lmce_supported()) {
-- 
2.50.0


