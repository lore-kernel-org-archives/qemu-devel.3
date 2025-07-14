Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66935C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:37:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHTs-00064Z-Ms; Mon, 14 Jul 2025 07:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH13-0001jQ-4G
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0w-00026p-Ti
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zy/rmBu1Zl2DYymVok3Ga20+R2U49w13+p4AzvdswRk=;
 b=MTOVKqYt9O9pb7BQppoDmwUFcZ5F4C9aKsNYvlSoosPUFgK6USuJh5vEqCoGOVSMJCtKvr
 6akvh9wd9HbQRLCp3+vlhfeyo8lYBQUwsEJO5ehEt2lDBUel6v6a9F6K/UOGypPztzow30
 dELzD+ODKh9ie5pxLiapYuoPmT5kPmE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-v8F6pjCWMe-rWPwJi6b4Jw-1; Mon, 14 Jul 2025 07:06:26 -0400
X-MC-Unique: v8F6pjCWMe-rWPwJi6b4Jw-1
X-Mimecast-MFC-AGG-ID: v8F6pjCWMe-rWPwJi6b4Jw_1752491184
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4edf5bb4dso2919763f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491184; x=1753095984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zy/rmBu1Zl2DYymVok3Ga20+R2U49w13+p4AzvdswRk=;
 b=rrzrfatNxCfEoJqLrwieDhe7jbLr6PkxIxsVXS2yA/itnpwgHmy3AKnbWB0mP+5jml
 dzGTP5bPw40Z5QrPSspo8t6rKyO6KsZN5M4Lkj1pUag7pdJdA4ZuIZoISaQ2pEyFZU4Q
 GO2Aloz738pR1V+T2NQCRquJGQbiubUVvQVK76PPvz/9eVseNpFwHx04a0pg961/wb01
 49JSD1rVTnjC2sBPMeR89t/FfCzElHZZDLFKWHhAIHdMBamgonZECyqpIVvvfP41E7jj
 j4jcDU2nOwK566cSuvU6BtNsZT6nDL8/VvzUs6FKNSrje9SEYLwZXNpWc5qghRSww7Kf
 S/IQ==
X-Gm-Message-State: AOJu0YzxFH52IksVygnqQ6AdFtoXjj1NOVG4kJ8xxIxF1YQjPtdbbzTh
 EGdFT2SUE3LUHoZ5lTswZtV6tNthAeDhBbKopl2kpVdhOTwrR//fWFjqQdQKAI02xoMAO/H7Z4D
 RPV5O2rC7+Ld6OwoQPTvuJrIJ6lgGY9VJ6Rh6DeaP/k3BcMNF4Tqtr0gQxBmErvdbyy7TDI1nSV
 myyYO5Ml+Wdm2HgohhXTHyvrfrJwYTGNxC6/IK6NNf
X-Gm-Gg: ASbGncuecM/vXbXFwwyf35zsg3LH7joxnH7BM4fMOVcRvVI1RrstUEPDO1NDr4nFSMO
 /m3CLSfKpcz9tLOfWFEqHHJyT6vepyjAnar/D5rMrfpzg59PA4Jfs/EYZMmKDsb14xd9ZNRJzOA
 LBxvciNeDrAPCyGgxJz6poclCNstLX2ePl+K25dE3bznoN0QUtZjxtx4/cVShZ+F2FEIa02Ehgu
 8SyjjCgnw7Z/+4rvssTBukMbhYa8dguiBaafUyC+2CUq7j78L59vlVTE4UaHsbyfr/Ma0/Q8ArR
 i9b0u5fZkjHnT/Yl5fk4t9Yya/1O59pqo9OuAO//JNU=
X-Received: by 2002:a05:6000:2b11:b0:3a4:f7e6:2b29 with SMTP id
 ffacd0b85a97d-3b5f185662bmr8115527f8f.5.1752491183485; 
 Mon, 14 Jul 2025 04:06:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZVjOhWl6Ty64CM1n53fSbm8DsA392JN0N4GDOUPtbcH/vULYnhaZwbpfvYOGE1IDOGpLqaw==
X-Received: by 2002:a05:6000:2b11:b0:3a4:f7e6:2b29 with SMTP id
 ffacd0b85a97d-3b5f185662bmr8115498f8f.5.1752491182887; 
 Mon, 14 Jul 2025 04:06:22 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd17b7sm12125014f8f.11.2025.07.14.04.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:06:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Yi Lai <yi1.lai@intel.com>
Subject: [PULL 52/77] i386/cpu: Select legacy cache model based on vendor in
 CPUID 0x2
Date: Mon, 14 Jul 2025 13:03:41 +0200
Message-ID: <20250714110406.117772-53-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

As preparation for merging cache_info_cpuid4 and cache_info_amd in
X86CPUState, set legacy cache model based on vendor in the CPUID 0x2
leaf. For AMD CPU, select legacy AMD cache model (in cache_info_amd) as
the default cache model, otherwise, select legacy Intel cache model (in
cache_info_cpuid4) as before.

To ensure compatibility is not broken, add an enable_legacy_vendor_cache
flag based on x-vendor-only-v2 to indicate cases where the legacy cache
model should be used regardless of the vendor. For CPUID 0x2 leaf,
enable_legacy_vendor_cache flag indicates to pick legacy Intel cache
model, which is for compatibility with the behavior of PC machine v10.0
and older.

The following explains how current vendor-based default legacy cache
model ensures correctness without breaking compatibility.

* For the PC machine v6.0 and older, vendor_cpuid_only=false, and
  vendor_cpuid_only_v2=false.

  - If the named CPU model has its own cache model, and doesn't use
    legacy cache model (legacy_cache=false), then cache_info_cpuid4 and
    cache_info_amd are same, so 0x2 leaf uses its own cache model
    regardless of the vendor.

  - For max/host/named CPU (without its own cache model), then the flag
    enable_legacy_vendor_cache is true, they will use legacy Intel cache
    model just like their previous behavior.

* For the PC machine v10.0 and older (to v6.1), vendor_cpuid_only=true,
  and vendor_cpuid_only_v2=false.

  - If the named CPU model has its own cache model (legacy_cache=false),
    then cache_info_cpuid4 & cache_info_amd both equal to its own cache
    model, so it uses its own cache model in 0x2 leaf regardless of the
    vendor. Only AMD CPUs have all-0 leaf due to vendor_cpuid_only=true,
    and this is exactly the behavior of these old machines.

  - For max/host/named CPU (without its own cache model), then the flag
    enable_legacy_vendor_cache is true, they will use legacy Intel cache
    model. Similarly, only AMD CPUs have all-0 leaf, and this is exactly
    the behavior of these old machines.

* For the PC machine v10.1 and newer, vendor_cpuid_only=true, and
  vendor_cpuid_only_v2=true.

  - If the named CPU model has its own cache model (legacy_cache=false),
    then cache_info_cpuid4 & cache_info_amd both equal to its own cache
    model, so it uses its own cache model in 0x2 leaf regardless of the
    vendor. And AMD CPUs have all-0 leaf. Nothing will change.

  - For max/host/named CPU (without its own cache model), then the flag
    enable_legacy_vendor_cache is false, the legacy cache model is
    selected based on vendor.

    For AMD CPU, it will use legacy AMD cache but still get all-0 leaf
    due to vendor_cpuid_only=true.

    For non-AMD (Intel/Zhaoxin) CPU, it will use legacy Intel cache as
    expected.

    Here, selecting the legacy cache model based on the vendor does not
    change the previous (before the change)  behavior.

Therefore, the above analysis proves that, with the help of the flag
enable_legacy_vendor_cache, it is acceptable to select the default
legacy cache model based on the vendor.

For the CPUID 0x2 leaf, in X86CPUState, a unified cache_info is enough.
It only needs to be initialized and configured with the corresponding
legacy cache model based on the vendor.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250711102143.1622339-14-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h |  1 +
 target/i386/cpu.c | 47 +++++++++++++++++++++++++++++++++++++----------
 2 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index d88481ba8ec..20499a82a54 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2079,6 +2079,7 @@ typedef struct CPUArchState {
      */
     CPUCaches cache_info_cpuid4, cache_info_amd;
     bool enable_legacy_cpuid2_cache;
+    bool enable_legacy_vendor_cache;
 
     /* MTRRs */
     uint64_t mtrr_fixed[11];
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 92d21ce64c3..ca856030773 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -250,23 +250,17 @@ static const CPUCaches legacy_intel_cpuid2_cache_info;
 
 /* Encode cache info for CPUID[2] */
 static void encode_cache_cpuid2(X86CPU *cpu,
+                                const CPUCaches *caches,
                                 uint32_t *eax, uint32_t *ebx,
                                 uint32_t *ecx, uint32_t *edx)
 {
     CPUX86State *env = &cpu->env;
-    const CPUCaches *caches;
     int l1d, l1i, l2, l3;
     bool unmatched = false;
 
     *eax = 1; /* Number of CPUID[EAX=2] calls required */
     *ebx = *ecx = *edx = 0;
 
-    if (env->enable_legacy_cpuid2_cache) {
-        caches = &legacy_intel_cpuid2_cache_info;
-    } else {
-        caches = &env->cache_info_cpuid4;
-    }
-
     l1d = cpuid2_cache_descriptor(caches->l1d_cache, &unmatched);
     l1i = cpuid2_cache_descriptor(caches->l1i_cache, &unmatched);
     l2 = cpuid2_cache_descriptor(caches->l2_cache, &unmatched);
@@ -7472,8 +7466,37 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ebx |= threads_per_pkg << 16;
         }
         break;
-    case 2:
-        /* cache info: needed for Pentium Pro compatibility */
+    case 2: { /* cache info: needed for Pentium Pro compatibility */
+        const CPUCaches *caches;
+
+        if (env->enable_legacy_cpuid2_cache) {
+            caches = &legacy_intel_cpuid2_cache_info;
+        } else if (env->enable_legacy_vendor_cache) {
+            caches = &legacy_intel_cache_info;
+        } else {
+            /*
+             * FIXME: Temporarily select cache info model here based on
+             * vendor, and merge these 2 cache info models later.
+             *
+             * This condition covers the following cases (with
+             * enable_legacy_vendor_cache=false):
+             *  - When CPU model has its own cache model and doesn't use legacy
+             *    cache model (legacy_model=off). Then cache_info_amd and
+             *    cache_info_cpuid4 are the same.
+             *
+             *  - For v10.1 and newer machines, when CPU model uses legacy cache
+             *    model. Non-AMD CPUs use cache_info_cpuid4 like before and AMD
+             *    CPU will use cache_info_amd. But this doesn't matter for AMD
+             *    CPU, because this leaf encodes all-0 for AMD whatever its cache
+             *    model is.
+             */
+            if (IS_AMD_CPU(env)) {
+                caches = &env->cache_info_amd;
+            } else {
+                caches = &env->cache_info_cpuid4;
+            }
+        }
+
         if (cpu->cache_info_passthrough) {
             x86_cpu_get_cache_cpuid(index, 0, eax, ebx, ecx, edx);
             break;
@@ -7481,8 +7504,9 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *eax = *ebx = *ecx = *edx = 0;
             break;
         }
-        encode_cache_cpuid2(cpu, eax, ebx, ecx, edx);
+        encode_cache_cpuid2(cpu, caches, eax, ebx, ecx, edx);
         break;
+    }
     case 4:
         /* cache info: needed for Core compatibility */
         if (cpu->cache_info_passthrough) {
@@ -8988,6 +9012,9 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
             env->enable_legacy_cpuid2_cache = true;
         }
 
+        if (!cpu->vendor_cpuid_only_v2) {
+            env->enable_legacy_vendor_cache = true;
+        }
         env->cache_info_cpuid4 = legacy_intel_cache_info;
         env->cache_info_amd = legacy_amd_cache_info;
     }
-- 
2.50.0


