Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0ECC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1XE-0006mM-HK; Thu, 08 May 2025 09:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1XC-0006hz-3A
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:43:34 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1X9-0004sF-UT
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:43:33 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22e8e4423ecso9475235ad.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 06:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746711809; x=1747316609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pfVenGRAMwE+Z64hRHr90BeNRoYPJugExqalvrobNt0=;
 b=hulytKT1hPoVIjADKnGCtwnlbRUBYbFzdK0xK1GO4Of87SOThpj1m3e+lk/cHbM+NW
 GR18dhdjKZXAYczkNk0oMBtQKjtA7Rm+2bb1OhRVwlhv3O0O40jhdmifGyqi7WqnkSE0
 g5/vTb4+CpKDkiggTnwXYRdaCwXyM+LVh1m/52J5M8mSf+LFfvPI87cAaNp6L++4nNhE
 PuPotLdh11CW9HhuxNxNlscDbVV6G18ZTCbpO3rVSMw2YwU9wYJpVi7erdHOK+7SHw4C
 MeQlYXHNdXKa1KGqmaj1UjAdUzYFAC4kwflHVSyaPOoy8LbW556lBvl4puwQSkdsJMCl
 j7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746711809; x=1747316609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pfVenGRAMwE+Z64hRHr90BeNRoYPJugExqalvrobNt0=;
 b=xALFHbsAUZvz4yfzaaXSfs/XZ+HHkXZZ4M3SJBBHii6d740MiBsrI+YQk7O8+MPTfL
 wZqC+NaAqtEhUnN6JvnrCrD2nzyLfNprPz7CveHtXrUyeosmEH9TOkvj+wVUojNuxO6E
 U4Y4KlOb4WmPhtX9ZWaa9vYS1ya9aXKWyC4Qi7U5Gs4WH/HOR++frkoyAp9FN89KMIOr
 8YcHoDF0/4hyNqg020wp8VL367Fn5W9aLIN+abp9Tz8KJ7tR7XM1OMIAv0JO6AD7a79X
 r4e/5yjWDQewboi5RzPHHHPxvjZ7bnRSHkwdTnng7ye0sutoxgstqumfMii7oQKKgaL4
 MEgA==
X-Gm-Message-State: AOJu0YwU4UA5YiGL8o3+aUIfh/YH6BVSVo3IdA6YUgKgtAkw3LRDFo4g
 gao+CD/XiCoNMrrgLMFwjFqq2FHWq2ycOEHZ5f9eblbF2885UNj9IXCQ8YR2XEHQUJ1xfqK3DTw
 2C1cqJw==
X-Gm-Gg: ASbGncs8gX1gpQi9q2emFWQ2biVZ13BipYbMHn7ZqILzvWMA5i+XMSGDZzSY1XWQz4e
 pDbQcYHWBc06lOaCBxom/QO3gYEdMdVidXE+TMJy80PrmYN8Ge7XYPIeWO2/4Ms8T7IHmdh9YAF
 arP5oTNsjUAaa8H4/9VT+sJLObXCkvw9aqNJlep/ptanShwhPtnnBxHpKLP3uC0Jq5WBLmT4o0b
 VCOIjx971Y5q8onUWSovclAaVMbanWqAIl+hdmIwO3ZQGN4ZyVtJEXoK6f+keDs+ArlCJZfV8hF
 z9I286qsS68fDnfppxlQnSWtstpnAJF5BcedZGgWE9DJ23pv4Ds+ql2ijGYuCFuqpPveQ88Q0o/
 +ndac7S+LWCOAL2g=
X-Google-Smtp-Source: AGHT+IFUTjKWPVkUkd1NBRniOTZ1k0pEbrW8dI3RWonTdhC9W5HoKkZnRoLeVCQ+2VhsISUWKpmYUg==
X-Received: by 2002:a17:902:da84:b0:224:11fc:40c0 with SMTP id
 d9443c01a7336-22e85613e2amr56447695ad.11.1746711809443; 
 Thu, 08 May 2025 06:43:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e15228fa7sm111988195ad.181.2025.05.08.06.43.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 May 2025 06:43:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Helge Deller <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v4 20/27] target/i386/cpu: Remove CPUX86State::enable_l3_cache
 field
Date: Thu,  8 May 2025 15:35:43 +0200
Message-ID: <20250508133550.81391-21-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250508133550.81391-1-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The CPUX86State::enable_l3_cache boolean was only disabled
for the pc-q35-2.7 and pc-i440fx-2.7 machines, which got
removed.  Being now always %true, we can remove it and simplify
cpu_x86_cpuid() and encode_cache_cpuid80000006().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.h |  6 ------
 target/i386/cpu.c | 39 +++++++++++++--------------------------
 2 files changed, 13 insertions(+), 32 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b5cbd91c156..62239b0a562 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2219,12 +2219,6 @@ struct ArchCPU {
      */
     bool enable_lmce;
 
-    /* Compatibility bits for old machine types.
-     * If true present virtual l3 cache for VM, the vcpus in the same virtual
-     * socket share an virtual l3 cache.
-     */
-    bool enable_l3_cache;
-
     /* Compatibility bits for old machine types.
      * If true present L1 cache as per-thread, not per-core.
      */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6b9a1f2251a..4be174ea9c7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -468,17 +468,13 @@ static void encode_cache_cpuid80000006(CPUCacheInfo *l2,
            (AMD_ENC_ASSOC(l2->associativity) << 12) |
            (l2->lines_per_tag << 8) | (l2->line_size);
 
-    if (l3) {
-        assert(l3->size % (512 * 1024) == 0);
-        assert(l3->associativity > 0);
-        assert(l3->lines_per_tag > 0);
-        assert(l3->line_size > 0);
-        *edx = ((l3->size / (512 * 1024)) << 18) |
-               (AMD_ENC_ASSOC(l3->associativity) << 12) |
-               (l3->lines_per_tag << 8) | (l3->line_size);
-    } else {
-        *edx = 0;
-    }
+    assert(l3->size % (512 * 1024) == 0);
+    assert(l3->associativity > 0);
+    assert(l3->lines_per_tag > 0);
+    assert(l3->line_size > 0);
+    *edx = ((l3->size / (512 * 1024)) << 18) |
+           (AMD_ENC_ASSOC(l3->associativity) << 12) |
+           (l3->lines_per_tag << 8) | (l3->line_size);
 }
 
 /* Encode cache info for CPUID[8000001D] */
@@ -6849,11 +6845,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         *eax = 1; /* Number of CPUID[EAX=2] calls required */
         *ebx = 0;
-        if (!cpu->enable_l3_cache) {
-            *ecx = 0;
-        } else {
-            *ecx = cpuid2_cache_descriptor(env->cache_info_cpuid2.l3_cache);
-        }
+        *ecx = cpuid2_cache_descriptor(env->cache_info_cpuid2.l3_cache);
         *edx = (cpuid2_cache_descriptor(env->cache_info_cpuid2.l1d_cache) << 16) |
                (cpuid2_cache_descriptor(env->cache_info_cpuid2.l1i_cache) <<  8) |
                (cpuid2_cache_descriptor(env->cache_info_cpuid2.l2_cache));
@@ -6907,13 +6899,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                                     eax, ebx, ecx, edx);
                 break;
             case 3: /* L3 cache info */
-                if (cpu->enable_l3_cache) {
-                    encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
-                                        topo_info,
-                                        eax, ebx, ecx, edx);
-                    break;
-                }
-                /* fall through */
+                encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
+                                    topo_info,
+                                    eax, ebx, ecx, edx);
+                break;
             default: /* end of info */
                 *eax = *ebx = *ecx = *edx = 0;
                 break;
@@ -7284,8 +7273,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                (AMD_ENC_ASSOC(L2_ITLB_4K_ASSOC) << 12) |
                (L2_ITLB_4K_ENTRIES);
         encode_cache_cpuid80000006(env->cache_info_amd.l2_cache,
-                                   cpu->enable_l3_cache ?
-                                   env->cache_info_amd.l3_cache : NULL,
+                                   env->cache_info_amd.l3_cache,
                                    ecx, edx);
         break;
     case 0x80000007:
@@ -8821,7 +8809,6 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
     DEFINE_PROP_BOOL("x-amd-topoext-features-only", X86CPU, amd_topoext_features_only, true),
     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
-    DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
     DEFINE_PROP_BOOL("kvm-pv-enforce-cpuid", X86CPU, kvm_pv_enforce_cpuid,
                      false),
     DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
-- 
2.47.1


