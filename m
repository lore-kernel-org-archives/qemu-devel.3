Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AC4C3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtyn-0005lF-W7; Fri, 30 May 2025 03:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxM-0003Ur-Du
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxK-0007Cy-8W
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U7M87aC0AY1SYkZv1rKx3sSxTQzGh6ckfYlzcvYgk4I=;
 b=PN2jMUygRwgBaSEpDkwtEPfLNm3wP4FF2CwXQFEAUIVQnT8YSvqFtGMC+WSYLwJpIO3W6X
 y5YXltP++idWR7pawe4uGd6a1eKtFM/F2rl9jDVXFMk24DDwLHsLVVkRwTVgWjwssdRl6J
 WSPuFSxlhfBiW6b+wit9pURLGY6Y7tc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-OJrGX2VgPp65i-wtMNcbpQ-1; Fri, 30 May 2025 03:15:04 -0400
X-MC-Unique: OJrGX2VgPp65i-wtMNcbpQ-1
X-Mimecast-MFC-AGG-ID: OJrGX2VgPp65i-wtMNcbpQ_1748589303
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ad88ac202c0so142542066b.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589302; x=1749194102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U7M87aC0AY1SYkZv1rKx3sSxTQzGh6ckfYlzcvYgk4I=;
 b=QdJXQQThq21YGus51OPjvOzFT8VQ80GSiYzj/LLRnT9+QaBCBsKMm6DPTI6XGQ7od4
 a2yf9mTikEYC6x2RJsNgFsLhsCC825TR/a0ZI4MwPioV+1vjg4B6R8LdRuYQcq+JFeoj
 wLtpXJw/ugMx969KKiXLEYqyCFgscHR4/VA/rZDIPkGlk4hbpgGjiUW8VHTXd64HUAz1
 6ztfMLT4w65saBezqqOM10TqQUWOpaylXZPl76siz9sdV6EJZlWZSbdhkqwrAtk5C1ty
 P9S6TIKJOud1Z7WPD72gUydcDY2+NFkoccnZL9ISQLoHUcGoBrU6VRB2Nv6jYCZGKmiB
 L3hg==
X-Gm-Message-State: AOJu0Yy3m1j1OcuROV/FLKfLp3rhirN4fbtmvFGwIGb3eu7jnqwGJWH3
 gJI2rKTythrT6SjeeBvpBKvvUAc6MipSexGYpAsLnHIX2xlrEbzp3LTNm/a5vNOBzCf6oK3ZL0L
 NN9Uj55PnruksqwDsjZz97zFDzidmZctJ6aeJ/z9VVXhSCzboQyka8Db1nRMTpaTK6zOPTa1cHR
 T3wvzMuHZG2QMDfepHp5lP3BTtXRxhyL1sqvQx5atQ
X-Gm-Gg: ASbGncv5U6QdC+K1CiNxtnJDZuRkJa2diuzfqc8HwKs97CVm5X+crO8hr5KBeC2VX3v
 stjyTUYlAo7/kbjZh/qBTzJWZYR2escr3HLY3Dob8ilkQ52wMV+QuOZhrJe2WBY1VTcaIuWImbW
 Pc45m6UpIaBRieDh+XwA9FJutUVxwZR7iGjmswUg4Ny8a2XmlKp+66J+G4k6p07qFqsXIsb5M4Y
 O0BDe3cy8z0SVEJiXU7r9xupHPfYCALXgJ1pM1a5XcKt/V5fwMG2UG5q+Cjy+gF+Hc2kMGltYwC
 QES5OgfZD6UJwA==
X-Received: by 2002:a17:907:7e8a:b0:adb:2f9b:e16f with SMTP id
 a640c23a62f3a-adb3295e9a5mr214291366b.16.1748589302264; 
 Fri, 30 May 2025 00:15:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxDAd/Mj5U434BVHo5LDlKzTjfnahRzB3HpbbqXCFdlqza4INEOV3h9Y4xFqXhmsTEMMDwbQ==
X-Received: by 2002:a17:907:7e8a:b0:adb:2f9b:e16f with SMTP id
 a640c23a62f3a-adb3295e9a5mr214288566b.16.1748589301796; 
 Fri, 30 May 2025 00:15:01 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada6ad6ac07sm278294566b.177.2025.05.30.00.15.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:15:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 52/77] i386/tdx: Only configure MSR_IA32_UCODE_REV in
 kvm_init_msrs() for TDs
Date: Fri, 30 May 2025 09:12:22 +0200
Message-ID: <20250530071250.2050910-53-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

For TDs, only MSR_IA32_UCODE_REV in kvm_init_msrs() can be configured
by VMM, while the features enumerated/controlled by other MSRs except
MSR_IA32_UCODE_REV in kvm_init_msrs() are not under control of VMM.

Only configure MSR_IA32_UCODE_REV for TDs.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-41-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 4fc37cc370d..90a0dac4a1e 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3864,32 +3864,34 @@ static void kvm_init_msrs(X86CPU *cpu)
     CPUX86State *env = &cpu->env;
 
     kvm_msr_buf_reset(cpu);
-    if (has_msr_arch_capabs) {
-        kvm_msr_entry_add(cpu, MSR_IA32_ARCH_CAPABILITIES,
-                          env->features[FEAT_ARCH_CAPABILITIES]);
-    }
 
-    if (has_msr_core_capabs) {
-        kvm_msr_entry_add(cpu, MSR_IA32_CORE_CAPABILITY,
-                          env->features[FEAT_CORE_CAPABILITY]);
-    }
+    if (!is_tdx_vm()) {
+        if (has_msr_arch_capabs) {
+            kvm_msr_entry_add(cpu, MSR_IA32_ARCH_CAPABILITIES,
+                                env->features[FEAT_ARCH_CAPABILITIES]);
+        }
 
-    if (has_msr_perf_capabs && cpu->enable_pmu) {
-        kvm_msr_entry_add_perf(cpu, env->features);
+        if (has_msr_core_capabs) {
+            kvm_msr_entry_add(cpu, MSR_IA32_CORE_CAPABILITY,
+                                env->features[FEAT_CORE_CAPABILITY]);
+        }
+
+        if (has_msr_perf_capabs && cpu->enable_pmu) {
+            kvm_msr_entry_add_perf(cpu, env->features);
+        }
+
+        /*
+         * Older kernels do not include VMX MSRs in KVM_GET_MSR_INDEX_LIST, but
+         * all kernels with MSR features should have them.
+         */
+        if (kvm_feature_msrs && cpu_has_vmx(env)) {
+            kvm_msr_entry_add_vmx(cpu, env->features);
+        }
     }
 
     if (has_msr_ucode_rev) {
         kvm_msr_entry_add(cpu, MSR_IA32_UCODE_REV, cpu->ucode_rev);
     }
-
-    /*
-     * Older kernels do not include VMX MSRs in KVM_GET_MSR_INDEX_LIST, but
-     * all kernels with MSR features should have them.
-     */
-    if (kvm_feature_msrs && cpu_has_vmx(env)) {
-        kvm_msr_entry_add_vmx(cpu, env->features);
-    }
-
     assert(kvm_buf_set_msrs(cpu) == 0);
 }
 
-- 
2.49.0


