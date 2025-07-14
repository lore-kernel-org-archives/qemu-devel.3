Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6171AC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHTX-0004k3-1j; Mon, 14 Jul 2025 07:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH13-0001jr-Rf
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH10-000270-06
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9RKbmpC/gOn3zgkmmw8UDFJXa21Fgwk+M1UraeNcusE=;
 b=DIuCo4Xh2zkvFDk9eRFrSstLz55y2DZVY6KevGdAKAgajBySxvT55s9TEF0yo/oM2QUWRV
 1hrrZogWyaFUWQPX5OJ7h+CmpYYO4b/oycU5bmsp+XzsklWM2PqGASzXo5O7RUJS6dw7z6
 FcwVJF+kX8vxA87eGgSQ/Bx8qm8miIY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-2E-jUCQRP-yDtKMHbiqL0g-1; Mon, 14 Jul 2025 07:06:27 -0400
X-MC-Unique: 2E-jUCQRP-yDtKMHbiqL0g-1
X-Mimecast-MFC-AGG-ID: 2E-jUCQRP-yDtKMHbiqL0g_1752491187
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-453a5d50b81so30312945e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491185; x=1753095985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9RKbmpC/gOn3zgkmmw8UDFJXa21Fgwk+M1UraeNcusE=;
 b=nrzMaRZyFh9GFBk3daAOC/SBdwIU81aMp3pThHtqZoHGh+b/EllnwLkMgw2paf8zR1
 pn1YhfnxQweww4IGI3wVHpnl19zg4opIdIFi8mm2twM2o5vAffN7OxpESiQTpqa8Xk1Q
 YeJlvnyzzvQBrjqyiavelIRmsTArK+Nynj+91CcrCS/hgY9R1MUA1JlxkqIAefhYXZaV
 YNmEkdWzCEuxcKwjZZFxS3MfdJNyD+zh7pZN4AQmiPBzhLDp5LPwTpP7oYmg1/xZnY5x
 apa9KzILSPT2wntV9KUK4bWd++Y6DbM+Zggt//UlIgj0mSQEMH2/P8P/tdi6HMUrjnZ8
 980A==
X-Gm-Message-State: AOJu0YyPOvuWaOMLqvIgLgVTfA9Ggf35YKRYknlDvHWZoNWxq5kHhMaA
 iH2biRq7+wlfjgt0/bHpc/ewDlVKC6SamgH6IW9e8uah4mdJs4XGqd5nlJKRYTDdTZ5+VhR/iti
 jMXdk0/OULFsnJET8zaM/vZbrRAjk6GZQkfvD5VDha5w2WdGtqEtBcLVIHRHX6cxI9/CmlBK1lZ
 sMiM4Q4S0Er1R2uQvSI5zpNGOzUOEVPfGKAeySe5ZN
X-Gm-Gg: ASbGncvt5B15uD8P0WiOky8eKPPQ1VAuo2/EfvDl5zcB6PztMil0ZNk/Qy9GBX4qR28
 esUtj4oD8Y3Qr+M0cjQfu8wJaS85HG2Q6AZMsVtBqN7veMDNq3K1vcuW7SZ6bjEHQHVd61v7vJz
 svtCUcrDkYGWmt827SGTC+ehGWvkDLfJnuehL1+7t4+rjCrh79HN6cHTMY3vHBOGhNJrY/4TEIT
 l2RmR4wp2wzRIw+m8bXdLKjFl4J/ak03fMF1/ugz4rb4Q9E/bPzMrExCnInvD6eB/MEqdsZxriq
 HhpoCAOZ+AjldF7ACaZLYt09MqNrBvRu2qQ+XC0pVk4=
X-Received: by 2002:a05:600c:a301:b0:454:ad94:4b3d with SMTP id
 5b1f17b1804b1-4551743756fmr75433605e9.1.1752491184905; 
 Mon, 14 Jul 2025 04:06:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZ3Yu8ukdstTmrmSVwJFqdHwzIfCPOc9kA4bIc0zDw/XmxENxA4Vb9RdwbPn5A/JltZxvlQA==
X-Received: by 2002:a05:600c:a301:b0:454:ad94:4b3d with SMTP id
 5b1f17b1804b1-4551743756fmr75433295e9.1.1752491184343; 
 Mon, 14 Jul 2025 04:06:24 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b6039bdea0sm3216118f8f.65.2025.07.14.04.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:06:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Yi Lai <yi1.lai@intel.com>
Subject: [PULL 53/77] i386/cpu: Select legacy cache model based on vendor in
 CPUID 0x4
Date: Mon, 14 Jul 2025 13:03:42 +0200
Message-ID: <20250714110406.117772-54-pbonzini@redhat.com>
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
X86CPUState, set legacy cache model based on vendor in the CPUID 0x4
leaf. For AMD CPU, select legacy AMD cache model (in cache_info_amd) as
the default cache model, otherwise, select legacy Intel cache model (in
cache_info_cpuid4) as before.

To ensure compatibility is not broken, add an enable_legacy_vendor_cache
flag based on x-vendor-only-v2 to indicate cases where the legacy cache
model should be used regardless of the vendor. For CPUID 0x4 leaf,
enable_legacy_vendor_cache flag indicates to pick legacy Intel cache
model, which is for compatibility with the behavior of PC machine v10.0
and older.

The following explains how current vendor-based default legacy cache
model ensures correctness without breaking compatibility.

* For the PC machine v6.0 and older, vendor_cpuid_only=false, and
  vendor_cpuid_only_v2=false.

  - If the named CPU model has its own cache model, and doesn't use
    legacy cache model (legacy_cache=false), then cache_info_cpuid4 and
    cache_info_amd are same, so 0x4 leaf uses its own cache model
    regardless of the vendor.

  - For max/host/named CPU (without its own cache model), then the flag
    enable_legacy_vendor_cache is true, they will use legacy Intel cache
    model just like their previous behavior.

* For the PC machine v10.0 and older (to v6.1), vendor_cpuid_only=true,
  and vendor_cpuid_only_v2=false.

  - If the named CPU model has its own cache model (legacy_cache=false),
    then cache_info_cpuid4 & cache_info_amd both equal to its own cache
    model, so it uses its own cache model in 0x4 leaf regardless of the
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
    model, so it uses its own cache model in 0x4 leaf regardless of the
    vendor. And AMD CPUs have all-0 leaf. Nothing will change.

  - For max/host/named CPU (without its own cache model), then the flag
    enable_legacy_vendor_cache is false, the legacy cache model is
    selected based on vendor.

    For AMD CPU, it will use legacy AMD cache but still get all-0 leaf
    due to vendor_cpuid_only=true.

    For non-AMD (Intel/Zhaoxin) CPU, it will use legacy Intel cache as
    expected.

    Here, selecting the legacy cache model based on the vendor does not
    change the previous (before the change) behavior.

Therefore, the above analysis proves that, with the help of the flag
enable_legacy_vendor_cache, it is acceptable to select the default
legacy cache model based on the vendor.

For the CPUID 0x4 leaf, in X86CPUState, a unified cache_info is enough.
It only needs to be initialized and configured with the corresponding
legacy cache model based on the vendor.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250711102143.1622339-15-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ca856030773..565eaf0071c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7507,7 +7507,35 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         encode_cache_cpuid2(cpu, caches, eax, ebx, ecx, edx);
         break;
     }
-    case 4:
+    case 4: {
+        const CPUCaches *caches;
+
+        if (env->enable_legacy_vendor_cache) {
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
         /* cache info: needed for Core compatibility */
         if (cpu->cache_info_passthrough) {
             x86_cpu_get_cache_cpuid(index, count, eax, ebx, ecx, edx);
@@ -7535,30 +7563,26 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
 
             switch (count) {
             case 0: /* L1 dcache info */
-                encode_cache_cpuid4(env->cache_info_cpuid4.l1d_cache,
-                                    topo_info,
+                encode_cache_cpuid4(caches->l1d_cache, topo_info,
                                     eax, ebx, ecx, edx);
                 if (!cpu->l1_cache_per_core) {
                     *eax &= ~MAKE_64BIT_MASK(14, 12);
                 }
                 break;
             case 1: /* L1 icache info */
-                encode_cache_cpuid4(env->cache_info_cpuid4.l1i_cache,
-                                    topo_info,
+                encode_cache_cpuid4(caches->l1i_cache, topo_info,
                                     eax, ebx, ecx, edx);
                 if (!cpu->l1_cache_per_core) {
                     *eax &= ~MAKE_64BIT_MASK(14, 12);
                 }
                 break;
             case 2: /* L2 cache info */
-                encode_cache_cpuid4(env->cache_info_cpuid4.l2_cache,
-                                    topo_info,
+                encode_cache_cpuid4(caches->l2_cache, topo_info,
                                     eax, ebx, ecx, edx);
                 break;
             case 3: /* L3 cache info */
                 if (cpu->enable_l3_cache) {
-                    encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
-                                        topo_info,
+                    encode_cache_cpuid4(caches->l3_cache, topo_info,
                                         eax, ebx, ecx, edx);
                     break;
                 }
@@ -7569,6 +7593,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             }
         }
         break;
+    }
     case 5:
         /* MONITOR/MWAIT Leaf */
         *eax = cpu->mwait.eax; /* Smallest monitor-line size in bytes */
-- 
2.50.0


