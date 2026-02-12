Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AEFEE3692
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvD-0005cX-Pe; Thu, 12 Feb 2026 09:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXv1-0005OM-87
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXux-00068k-MW
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BNVw9azJMhrqoIvHRfT5WOQ0fbhJsvRuSAkYrSswDgA=;
 b=AnTi/Pqo9rgo/MsgIEpZaHCwd1HQDhBLNpUarSKC/SEKTRNDhEXaqh1VNNU1NMw+/PlVkc
 Ap+zTb70Fxyt+WsGKeqnFuE9G21OUJh7POXj6FEEAFk4GbtgdeC6d3Bby4Xxk82/ABRBW9
 IYRJU8FKhl9anAso1gx37KMgJ1nId3o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-sDaBLJLJPyiQV86rH7lr_w-1; Thu, 12 Feb 2026 09:43:41 -0500
X-MC-Unique: sDaBLJLJPyiQV86rH7lr_w-1
X-Mimecast-MFC-AGG-ID: sDaBLJLJPyiQV86rH7lr_w_1770907420
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4836b7c302fso4826505e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907420; x=1771512220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BNVw9azJMhrqoIvHRfT5WOQ0fbhJsvRuSAkYrSswDgA=;
 b=B77kbc419vvSBqss/Ih2BX/v5gGw/R42W1V6qGhHmX4xEWL/CJVKHHmVcjQkey878M
 G/x/Zx3jwOtSShU0YpD//r2EMpgvJ4nS+JzC21lUu3+xTENGuQw3dGnWripfGwHKU+gM
 6aQBBTDNMnMT494+9gJWde08hinTY1sNufZrD3L3cGm6oYFU2HvNiuU/gaod6cwxJjGU
 nHQtPr8CduOvsIDnqXXPYLUbeq1VIpA443fCpIuF87K7Jzp5X48kLnGMUEDJouiNM3I8
 S9/0cDDc+9zSNEu47fOlDBBwa2NEYYxoEqaCOAWBZ4MWVuqy6ScXloGktryCOUB2dRR4
 A3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907420; x=1771512220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BNVw9azJMhrqoIvHRfT5WOQ0fbhJsvRuSAkYrSswDgA=;
 b=OHhtr8lGVQJfV39cup46DBrZcUlxosStNo0c9FGqj+L837PVNm0bTUKJnE5tB6bOVK
 GDyNOGoSb7AI+VU36iIi0B2KlImk0Wa32hRFGLZxr1Ox/Ej9YtKzeogG0a2IznWZjk1s
 QB3sTbr63asqnDw43kaXjEhT5HxvCd5RKqNpV29H3rE35gFJZCUx0/qt2I6i38sojpBj
 FoULqxWhCTSn2dw+/rR5Wj+tTNW6sNFbpg6/6dU61S50FhRkkqFG1V577+XjTQClbuS1
 ljLvlU5oUBcnBOrCPkABmD0TsakbpmO1Xn6R+u6/B0csrtq24AWBQZyIiFQ9i0ZDbYOJ
 RUCQ==
X-Gm-Message-State: AOJu0YwwfBMW1NQsG7ukY7KDxdlTre6sc0GKOcQvbWr3IktXvjYwau8m
 jSJR8tsdSky+lPUnKKu/5BP8/pMMO9n2Pv0BVxWX3C/Uh9wQNQOLAFkcv51AkSNWxSGwffy0R0w
 mpiR9Yf2UwSmsAe1fvGWddaWp4IESFm+HNcG833OP0AH5NirPH9Oe8QCEox7oH1q6yHSJhYqcGw
 zwh8MHiwiSsE/H/UZxkxRGoWolGd0cQTRqv5Y5z2VW
X-Gm-Gg: AZuq6aJcB1M5XaQCpSERbVrZikbL8YuhN64H9jLxzb5VRaqQiFFpTG0Vw1TaotBWD1e
 5WuThcojn72uO/EBGO0jC9UtNDvImU8i5PW6Qro82QKCuB8XYwc1D9FQiu7CamYB29JKvlpjHt3
 Dhvac2D5P978/ZmOelkcI+edCUTSbgfEHsO1MlYCg3eUKqLyqiLu0kVDvhO2CxKIuEQMhI1XXWu
 KsGuzQ0zLIba545e+yYaIBRz30Vg6w1YQIw4jY8/+cvHzUs69/N92ysu8XLFhWGD+5awDURf/Nn
 4YBSWpVq3hEjDPo9itftf9u+jNo1cGJPgy+Kw3tYwrDUBqjdiC71aN30DwDBTce3P4Gb7gDeGuJ
 G/5LLKo0bUeE1vEAHU297f51szg0LO3LpEckOC4XJgKCMVZYZ5l8t5dxkYwwYwG4FkvhcEl+By4
 yocEPb7pdf41IClEO0DX1YeiBLrYygALcz/5g+9nctQ9Qy3TNKV2I=
X-Received: by 2002:a05:600c:848d:b0:479:35e7:a0e3 with SMTP id
 5b1f17b1804b1-48365716033mr43890335e9.30.1770907419890; 
 Thu, 12 Feb 2026 06:43:39 -0800 (PST)
X-Received: by 2002:a05:600c:848d:b0:479:35e7:a0e3 with SMTP id
 5b1f17b1804b1-48365716033mr43889675e9.30.1770907419296; 
 Thu, 12 Feb 2026 06:43:39 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e15bsm103388505e9.13.2026.02.12.06.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:43:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 23/41] target/i386/cpu: Remove
 CPUX86State::full_cpuid_auto_level field
Date: Thu, 12 Feb 2026 15:42:25 +0100
Message-ID: <20260212144244.22579-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The CPUX86State::full_cpuid_auto_level boolean was only
disabled for the pc-q35-2.7 and pc-i440fx-2.7 machines,
which got removed. Being now always %true, we can remove
it and simplify x86_cpu_expand_features().

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260108033051.777361-23-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h |   3 --
 target/i386/cpu.c | 117 ++++++++++++++++++++++------------------------
 2 files changed, 57 insertions(+), 63 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index da5161fc1a5..f2be42d7f65 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2425,9 +2425,6 @@ struct ArchCPU {
     /* Force to enable cpuid 0x1f */
     bool force_cpuid_0x1f;
 
-    /* Enable auto level-increase for all CPUID leaves */
-    bool full_cpuid_auto_level;
-
     /*
      * Compatibility bits for old machine types (PC machine v6.0 and older).
      * Only advertise CPUID leaves defined by the vendor.
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0a7b884528e..201c5d5c210 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9508,74 +9508,72 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
 
     /* CPUID[EAX=7,ECX=0].EBX always increased level automatically: */
     x86_cpu_adjust_feat_level(cpu, FEAT_7_0_EBX);
-    if (cpu->full_cpuid_auto_level) {
-        x86_cpu_adjust_feat_level(cpu, FEAT_1_EDX);
-        x86_cpu_adjust_feat_level(cpu, FEAT_1_ECX);
-        x86_cpu_adjust_feat_level(cpu, FEAT_6_EAX);
-        x86_cpu_adjust_feat_level(cpu, FEAT_7_0_ECX);
-        x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EAX);
-        x86_cpu_adjust_feat_level(cpu, FEAT_7_1_ECX);
-        x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EDX);
-        x86_cpu_adjust_feat_level(cpu, FEAT_7_2_EDX);
-        x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_EDX);
-        x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_ECX);
-        x86_cpu_adjust_feat_level(cpu, FEAT_8000_0007_EDX);
-        x86_cpu_adjust_feat_level(cpu, FEAT_8000_0008_EBX);
-        x86_cpu_adjust_feat_level(cpu, FEAT_C000_0001_EDX);
-        x86_cpu_adjust_feat_level(cpu, FEAT_SVM);
-        x86_cpu_adjust_feat_level(cpu, FEAT_XSAVE);
+    x86_cpu_adjust_feat_level(cpu, FEAT_1_EDX);
+    x86_cpu_adjust_feat_level(cpu, FEAT_1_ECX);
+    x86_cpu_adjust_feat_level(cpu, FEAT_6_EAX);
+    x86_cpu_adjust_feat_level(cpu, FEAT_7_0_ECX);
+    x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EAX);
+    x86_cpu_adjust_feat_level(cpu, FEAT_7_1_ECX);
+    x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EDX);
+    x86_cpu_adjust_feat_level(cpu, FEAT_7_2_EDX);
+    x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_EDX);
+    x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_ECX);
+    x86_cpu_adjust_feat_level(cpu, FEAT_8000_0007_EDX);
+    x86_cpu_adjust_feat_level(cpu, FEAT_8000_0008_EBX);
+    x86_cpu_adjust_feat_level(cpu, FEAT_C000_0001_EDX);
+    x86_cpu_adjust_feat_level(cpu, FEAT_SVM);
+    x86_cpu_adjust_feat_level(cpu, FEAT_XSAVE);
 
-        /* Intel Processor Trace requires CPUID[0x14] */
-        if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT)) {
-            if (cpu->intel_pt_auto_level) {
-                x86_cpu_adjust_level(cpu, &cpu->env.cpuid_min_level, 0x14);
-            } else if (cpu->env.cpuid_min_level < 0x14) {
-                mark_unavailable_features(cpu, FEAT_7_0_EBX,
-                    CPUID_7_0_EBX_INTEL_PT,
-                    "Intel PT need CPUID leaf 0x14, please set by \"-cpu ...,intel-pt=on,min-level=0x14\"");
-            }
+    /* Intel Processor Trace requires CPUID[0x14] */
+    if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT)) {
+        if (cpu->intel_pt_auto_level) {
+            x86_cpu_adjust_level(cpu, &cpu->env.cpuid_min_level, 0x14);
+        } else if (cpu->env.cpuid_min_level < 0x14) {
+            mark_unavailable_features(cpu, FEAT_7_0_EBX,
+                CPUID_7_0_EBX_INTEL_PT,
+                "Intel PT need CPUID leaf 0x14, please set by \"-cpu ...,intel-pt=on,min-level=0x14\"");
         }
+    }
 
-        /*
-         * Intel CPU topology with multi-dies support requires CPUID[0x1F].
-         * For AMD Rome/Milan, cpuid level is 0x10, and guest OS should detect
-         * extended toplogy by leaf 0xB. Only adjust it for Intel CPU, unless
-         * cpu->vendor_cpuid_only has been unset for compatibility with older
-         * machine types.
-         */
-        if (x86_has_cpuid_0x1f(cpu) &&
-            (IS_INTEL_CPU(env) || !cpu->vendor_cpuid_only)) {
-            x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x1F);
-        }
+    /*
+     * Intel CPU topology with multi-dies support requires CPUID[0x1F].
+     * For AMD Rome/Milan, cpuid level is 0x10, and guest OS should detect
+     * extended toplogy by leaf 0xB. Only adjust it for Intel CPU, unless
+     * cpu->vendor_cpuid_only has been unset for compatibility with older
+     * machine types.
+     */
+    if (x86_has_cpuid_0x1f(cpu) &&
+        (IS_INTEL_CPU(env) || !cpu->vendor_cpuid_only)) {
+        x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x1F);
+    }
 
-        /* Advanced Vector Extensions 10 (AVX10) requires CPUID[0x24] */
-        if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) {
-            x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x24);
-        }
+    /* Advanced Vector Extensions 10 (AVX10) requires CPUID[0x24] */
+    if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) {
+        x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x24);
+    }
 
-        /* Advanced Performance Extensions (APX) requires CPUID[0x29] */
-        if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_APXF) {
-            x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x29);
-        }
+    /* Advanced Performance Extensions (APX) requires CPUID[0x29] */
+    if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_APXF) {
+        x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x29);
+    }
 
-        /* SVM requires CPUID[0x8000000A] */
-        if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
-            x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000000A);
-        }
+    /* SVM requires CPUID[0x8000000A] */
+    if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
+        x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000000A);
+    }
 
-        /* SEV requires CPUID[0x8000001F] */
-        if (sev_enabled()) {
-            x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000001F);
-        }
+    /* SEV requires CPUID[0x8000001F] */
+    if (sev_enabled()) {
+        x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000001F);
+    }
 
-        if (env->features[FEAT_8000_0021_EAX]) {
-            x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x80000021);
-        }
+    if (env->features[FEAT_8000_0021_EAX]) {
+        x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x80000021);
+    }
 
-        /* SGX requires CPUID[0x12] for EPC enumeration */
-        if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_SGX) {
-            x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x12);
-        }
+    /* SGX requires CPUID[0x12] for EPC enumeration */
+    if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_SGX) {
+        x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x12);
     }
 
     /* Set cpuid_*level* based on cpuid_min_*level, if not explicitly set */
@@ -10520,7 +10518,6 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_UINT32("min-xlevel", X86CPU, env.cpuid_min_xlevel, 0),
     DEFINE_PROP_UINT32("min-xlevel2", X86CPU, env.cpuid_min_xlevel2, 0),
     DEFINE_PROP_UINT64("ucode-rev", X86CPU, ucode_rev, 0),
-    DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_level, true),
     DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
     DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
     DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
-- 
2.52.0


