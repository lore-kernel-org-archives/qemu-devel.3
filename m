Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB9DC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHEO-0007Cm-8m; Mon, 14 Jul 2025 07:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH11-0001in-5P
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0s-00026P-Rh
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GSC6MhPny2SkCa7TrS1WIVTnb/rmAA/k5Ngtv+6fNHE=;
 b=eK1po8i6QpcX18ckJLdPz4w4hSKQH6c20ghbFrUwOfGPAWAfupMu80IodAtOPXg0PXZXOS
 bRPKHRkKgBLR8ZxoIPTAAKwrxxrCAwbndv0N6hKn8ez7gbGEvg3FAfmaWwQrRhuV+2uN3X
 8P37UD7g/PNeaIeV76XKtY6019rB5bk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-ysrjcmqvO3e1xg46t3hN3Q-1; Mon, 14 Jul 2025 07:06:20 -0400
X-MC-Unique: ysrjcmqvO3e1xg46t3hN3Q-1
X-Mimecast-MFC-AGG-ID: ysrjcmqvO3e1xg46t3hN3Q_1752491178
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4561a196f70so4839705e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491177; x=1753095977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GSC6MhPny2SkCa7TrS1WIVTnb/rmAA/k5Ngtv+6fNHE=;
 b=FXNP6p7SEPuguEBYTgROouZh9BTyj4hYEQMmooNi2emRWCN8q+kUbR/6h+vFEPyOqI
 pwZvLlVhBI/SIBizr2ElzqK7TCL8ZPpBW207+leXOfuu4q6t8TCFD91g7nhdBwcNmjrV
 j0wd7VVNR8MDFi5aLvZaqjT41b3SXkhsB6ocJeU84HXShBOi1A38W0VqWnG8mJod4mfS
 irPPuKaMYNVmkPSJ2e3iW7ypaRp0cnKFMpp1Avu78J26GftyyKR8san5LuG6TGMGRZvN
 TuShi1InzS+LSTBYxaD0BCseD54BN+KSQGK/5s/xOWzuML9LWArh6LuppHlum2rDRar7
 nhYw==
X-Gm-Message-State: AOJu0Yx7yFkoQ4XZ9d1xJX9Wgo9bF2u7II0uajXojOG8n+9GyDc4QjaN
 R/yg6V9HdJ0zCL3QQbJf9Pz1jFxK85r1OgGE6m/eWNmrqkSwjU4oc4aXG0jUAezj6Az+m/LN/gp
 7luhmrNK3rIaUuk4FdwV2IMEID197dQuC+1lBn+Qf7KiiRjBhNJt2pSBkEV0XmGzYLYwxXZ1LVe
 1CU6jdn7L/hlFX5wGCGdOHhpyVdXxSHDtXtpFfRPgU
X-Gm-Gg: ASbGncuIIeDUFaAEA7l0PFBxh29gAoV9cnLORBZMGy/CFX4kC2qxsPOK7Jnr3HyxfBT
 UeIGQk3eF8tfiScbOIZw3TmGzI9GJBS4Tv2OVuJhdvT+6KPrJBRKyYn2V5pgSLCYgYAOu4d5Kr9
 cYy0lgn/DkW+aI4hZDB6mqXXOxdOUjLkIoIlKNpPvcATd0AkqI/ySdcxfJgvCrJ7yYiu8J03uGB
 qdcLGJvjGSGAem+iedqdIibdB3CIxgSkcWMcaS62pLS0ImDYpQ3FN99Gwb1kTHjs0pO8rySTv7k
 JbMc3awe1Zn2M9PySztXA1t8OFjx4/O21M9m3A9FDtI=
X-Received: by 2002:a05:600c:c0c1:b0:453:84a:8cf1 with SMTP id
 5b1f17b1804b1-45576aab8a3mr76235725e9.33.1752491177130; 
 Mon, 14 Jul 2025 04:06:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZhdZw6QvFPipKgiclRUgJCtpW3ES2Ctlo2UUOorliEWEfdM/2KvJu6PhJjAEec3UBxHNY7Q==
X-Received: by 2002:a05:600c:c0c1:b0:453:84a:8cf1 with SMTP id
 5b1f17b1804b1-45576aab8a3mr76235485e9.33.1752491176571; 
 Mon, 14 Jul 2025 04:06:16 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45613c2d84dsm45545515e9.5.2025.07.14.04.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:06:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Yi Lai <yi1.lai@intel.com>
Subject: [PULL 49/77] i386/cpu: Fix CPUID[0x80000006] for Intel CPU
Date: Mon, 14 Jul 2025 13:03:38 +0200
Message-ID: <20250714110406.117772-50-pbonzini@redhat.com>
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

Per SDM, Intel supports CPUID[0x80000006]. But only L2 information is
encoded in ECX (note that L2 associativity field encodings rules
consistent with AMD are used), all other fields are reserved.

Therefore, make the following changes to CPUID[0x80000006]:
 * Check the vendor in CPUID[0x80000006] and just encode L2 to ECX for
   Intel.
 * Drop the lines_per_tag assertion, since AMD supports this field but
   Intel doesn't. And this field can be easily checked via cpuid tool
   in Guest.
 * Apply the encoding change of Intel for Zhaoxin as well [1].

This fix also resolves the FIXME of legacy_l2_cache_amd:

/*FIXME: CPUID leaf 0x80000006 is inconsistent with leaves 2 & 4 */

In addition, per AMD's APM, update the comment of CPUID[0x80000006].

[1]: https://lore.kernel.org/qemu-devel/c522ebb5-04d5-49c6-9ad8-d755b8998988@zhaoxin.com/

Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250711102143.1622339-11-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8a97272b4a4..6a0e8592bbe 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -531,16 +531,15 @@ static void encode_cache_cpuid80000006(CPUCacheInfo *l2,
 {
     assert(l2->size % 1024 == 0);
     assert(l2->associativity > 0);
-    assert(l2->lines_per_tag > 0);
     assert(l2->line_size > 0);
     *ecx = ((l2->size / 1024) << 16) |
            (X86_ENC_ASSOC(l2->associativity) << 12) |
            (l2->lines_per_tag << 8) | (l2->line_size);
 
+    /* For Intel, EDX is reserved. */
     if (l3) {
         assert(l3->size % (512 * 1024) == 0);
         assert(l3->associativity > 0);
-        assert(l3->lines_per_tag > 0);
         assert(l3->line_size > 0);
         *edx = ((l3->size / (512 * 1024)) << 18) |
                (X86_ENC_ASSOC(l3->associativity) << 12) |
@@ -712,7 +711,6 @@ static CPUCacheInfo legacy_l2_cache = {
     .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
-/*FIXME: CPUID leaf 0x80000006 is inconsistent with leaves 2 & 4 */
 static CPUCacheInfo legacy_l2_cache_amd = {
     .type = UNIFIED_CACHE,
     .level = 2,
@@ -7900,11 +7898,20 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *edx = encode_cache_cpuid80000005(env->cache_info_amd.l1i_cache);
         break;
     case 0x80000006:
-        /* cache info (L2 cache) */
+        /* cache info (L2 cache/TLB/L3 cache) */
         if (cpu->cache_info_passthrough) {
             x86_cpu_get_cache_cpuid(index, 0, eax, ebx, ecx, edx);
             break;
         }
+
+        if (cpu->vendor_cpuid_only_v2 &&
+            (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
+            *eax = *ebx = 0;
+            encode_cache_cpuid80000006(env->cache_info_cpuid4.l2_cache,
+                                       NULL, ecx, edx);
+            break;
+        }
+
         *eax = (X86_ENC_ASSOC(L2_DTLB_2M_ASSOC) << 28) |
                (L2_DTLB_2M_ENTRIES << 16) |
                (X86_ENC_ASSOC(L2_ITLB_2M_ASSOC) << 12) |
@@ -7913,6 +7920,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                (L2_DTLB_4K_ENTRIES << 16) |
                (X86_ENC_ASSOC(L2_ITLB_4K_ASSOC) << 12) |
                (L2_ITLB_4K_ENTRIES);
+
         encode_cache_cpuid80000006(env->cache_info_amd.l2_cache,
                                    cpu->enable_l3_cache ?
                                    env->cache_info_amd.l3_cache : NULL,
-- 
2.50.0


