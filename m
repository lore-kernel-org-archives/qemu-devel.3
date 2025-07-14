Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C453C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHSL-0003TG-FV; Mon, 14 Jul 2025 07:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0k-0001bw-G3
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0i-00025T-Ft
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9rIviJJiNhAaxQAmva2XsGdE6gnXLnG6PRcuZmt/cGY=;
 b=VBt/Mw2JzB1nsfkRRWlIfCGlqEc6IvW+36Vw+MY3PyAhHUIJ+GgUTrT1AJ+Xa4aNdQo0IS
 p89jM/6YbKEBLdrTO1TpFzDPZFnkIYANg9nmfI7gNvAbSVYgTXXvr4Y13dhu16NOo5nLj5
 gD26EQmx5TVodw50rSk3lmEQF5lRZvE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-XC-OBO9ZNIS5O8aFJhmC5Q-1; Mon, 14 Jul 2025 07:06:14 -0400
X-MC-Unique: XC-OBO9ZNIS5O8aFJhmC5Q-1
X-Mimecast-MFC-AGG-ID: XC-OBO9ZNIS5O8aFJhmC5Q_1752491173
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-455ea9cb0beso21445455e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491172; x=1753095972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9rIviJJiNhAaxQAmva2XsGdE6gnXLnG6PRcuZmt/cGY=;
 b=H9M72ZRSI/zSUhZSssM68xO6aZ2mntXACsJ0b2rBJDuWqQQEo9fhKzs5ahwBr7MwEa
 /JSTV3XcDlHLLnUhZllwTZKcVBMqRaWKPefFF7XhCxn0ZQx3uPOjz0XZnp4ZX/OGumLf
 M/MISrbUpsmWkZ9sPaEixw2Ny47VodhnF49ylEkEkAsDZXsOgYuw/Fie7mefG5QNipZ/
 1Tlabd5a9YGsx9QBicXBfkOvWGiTT2lPKFaetag7kUnK4tAlWgKhlcuIyG5Ga5S+4XMM
 zF2C1cxK2M6tQMnsk2+qxmsobmSa2/uiFfWTAEdOddg8tlW13btDMZqmjcRk2qFdhf6i
 7VzQ==
X-Gm-Message-State: AOJu0YxevKTfIEjQ+Q8wSycdu8rCcaoblv/15iZfZUltBqESoYxuRChr
 sOZPgYG6S3Qq9vC8Nw4pJJ2CgVwkTi2OvMhMwpNY7mY7RQT6XnPfK/s/0Oyxav27ElC1M0pEB6/
 MHbiWRyCH0RPyxNvLhfre0dCoV6onaQFHiRZybGST9TBwqxg478J9fTV1/TGtlfmnLB92Nqeobh
 RuMTV8ntSWmkF+7ZxpTTSlhejMNCY6kgo56TNgn+7N
X-Gm-Gg: ASbGncvr1v4h9EHztbB/7Ff97cJ2xDTJejSIT+i/+vIi2fvj7G2QB3zROamCWZmHSJU
 QUdJwUSncPcE5PfnxQvldvwe1e6FBM5+CUEX/nsDR2ZzQgfesIu9nXEBkNpLVRqSsek0AB+vUaD
 LA7+9sNUvqI6ng0Hk8frvRm6uAftTlMgNo2pgC3VovdwmGBAHgTLuQxN2RIsfVKECpgb648GByA
 QSJydo4zdnQ55dT16iA8MA2u8dSpUR+ZeiusEpTQeCryUPrbFEc073NQMBRKQgu1REaS/WZwBcf
 XfZiY8dKF1lLU1GPk3z+psFjE6/DXtdsFHlbyPl+SGg=
X-Received: by 2002:a05:600c:1da7:b0:456:1b8b:b8c6 with SMTP id
 5b1f17b1804b1-4561b8bbbf3mr27417235e9.14.1752491171926; 
 Mon, 14 Jul 2025 04:06:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzZwsANSptTigDo6JPnjSG8BVa/qdPOxY9LPt6ZVFYEMHq48AF5379W2T4eUTYtBB3gPqnkQ==
X-Received: by 2002:a05:600c:1da7:b0:456:1b8b:b8c6 with SMTP id
 5b1f17b1804b1-4561b8bbbf3mr27416765e9.14.1752491171311; 
 Mon, 14 Jul 2025 04:06:11 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc2131sm11864434f8f.29.2025.07.14.04.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:06:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Yi Lai <yi1.lai@intel.com>
Subject: [PULL 47/77] i386/cpu: Mark CPUID[0x80000005] as reserved for Intel
Date: Mon, 14 Jul 2025 13:03:36 +0200
Message-ID: <20250714110406.117772-48-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
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

Per SDM, 0x80000005 leaf is reserved for Intel CPU, and its current
"assert" check blocks adding new cache model for non-AMD CPUs.

And please note, although Zhaoxin mostly follows Intel behavior,
this leaf is an exception [1].

So, with the compat property "x-vendor-cpuid-only-v2", for the machine
since v10.1, check the vendor and encode this leaf as all-0 only for
Intel CPU. In addition, drop lines_per_tag assertion in
encode_cache_cpuid80000005(), since Zhaoxin will use legacy Intel cache
model in this leaf - which doesn't have this field.

This fix also resolves 2 FIXMEs of legacy_l1d_cache_amd and
legacy_l1i_cache_amd:

/*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */

In addition, per AMD's APM, update the comment of CPUID[0x80000005].

[1]: https://lore.kernel.org/qemu-devel/fa16f7a8-4917-4731-9d9f-7d4c10977168@zhaoxin.com/

Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250711102143.1622339-9-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 630a40d72be..2abcb5acffc 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -499,7 +499,6 @@ static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
 static uint32_t encode_cache_cpuid80000005(CPUCacheInfo *cache)
 {
     assert(cache->size % 1024 == 0);
-    assert(cache->lines_per_tag > 0);
     assert(cache->associativity > 0);
     assert(cache->line_size > 0);
     return ((cache->size / 1024) << 24) | (cache->associativity << 16) |
@@ -657,7 +656,6 @@ static CPUCacheInfo legacy_l1d_cache = {
     .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
-/*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
 static CPUCacheInfo legacy_l1d_cache_amd = {
     .type = DATA_CACHE,
     .level = 1,
@@ -686,7 +684,6 @@ static CPUCacheInfo legacy_l1i_cache = {
     .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
-/*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
 static CPUCacheInfo legacy_l1i_cache_amd = {
     .type = INSTRUCTION_CACHE,
     .level = 1,
@@ -7884,11 +7881,17 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *edx = env->cpuid_model[(index - 0x80000002) * 4 + 3];
         break;
     case 0x80000005:
-        /* cache info (L1 cache) */
+        /* cache info (L1 cache/TLB Associativity Field) */
         if (cpu->cache_info_passthrough) {
             x86_cpu_get_cache_cpuid(index, 0, eax, ebx, ecx, edx);
             break;
         }
+
+        if (cpu->vendor_cpuid_only_v2 && IS_INTEL_CPU(env)) {
+            *eax = *ebx = *ecx = *edx = 0;
+            break;
+        }
+
         *eax = (L1_DTLB_2M_ASSOC << 24) | (L1_DTLB_2M_ENTRIES << 16) |
                (L1_ITLB_2M_ASSOC <<  8) | (L1_ITLB_2M_ENTRIES);
         *ebx = (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES << 16) |
@@ -9478,6 +9481,7 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
     DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
     DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
+    DEFINE_PROP_BOOL("x-vendor-cpuid-only-v2", X86CPU, vendor_cpuid_only_v2, true),
     DEFINE_PROP_BOOL("x-amd-topoext-features-only", X86CPU, amd_topoext_features_only, true),
     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
     DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
-- 
2.50.0


