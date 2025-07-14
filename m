Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAD4C83F21
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHVU-0007zC-3R; Mon, 14 Jul 2025 07:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH16-0001lS-IX
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH13-000280-Mn
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mqYPp6af6fKy8igTufJ+mf6axAEuMulVTGjst6+NyMw=;
 b=M++S5f2geyZTg5csbaWhDmtXRg56Frv5KcHgeHVAE3tuJP3vyAt0dEeQx/lbeUHJMVIval
 5fxh1vElaIUoJor7wZXvEdd3OM6b8fSB3+r1QRs7kVJGFnEg+00NtNSaxhX9OjiHzSM+TJ
 /vs8P9Hi3ubIN65f6uBi5C9gFackwbo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-Maf9GfTuOROBJy2lhpU0Lw-1; Mon, 14 Jul 2025 07:06:35 -0400
X-MC-Unique: Maf9GfTuOROBJy2lhpU0Lw-1
X-Mimecast-MFC-AGG-ID: Maf9GfTuOROBJy2lhpU0Lw_1752491194
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4edf5bb4dso2919889f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491194; x=1753095994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mqYPp6af6fKy8igTufJ+mf6axAEuMulVTGjst6+NyMw=;
 b=XcxHIlJJ6BEx+c3GeCf5nI2R7bxUufzQ6D2ew1dGmxj83j+yerYWoGGmdXxlY+r04B
 GqGHxex8vdOoSYUAK1a/WudeLeGgL0h/hkCuLb51Kao/2y++32nwEMcJYfmgCeSshtya
 Lqfx+yu8gM/EqElodyL04T54pfBOPixw+dIyBRjrS47m1+HZi11qEXjlmvepoG4cbtvC
 zTlEbM+Hhq2+4aZ2svSeIPpzxD4/YHvHIoJTEhRlrDtS+PiFkWIKbD5y5DB2alBSLSO/
 LMTH4fIx3K6OUHCJmEFCeqR7pWFAgAHNF+NWCZHNKJAi1EloVtpCi5Itu/GaGDwte1YD
 //Ng==
X-Gm-Message-State: AOJu0YwDnA4cudv/AQRyJJTjv+hXaji3ClIL6B9AAvtWFyafI7h3BwcM
 yXgq7bQ6Ok8HTdJZZgE75/m8EKizIZ9aa2naHpNT599lwetWfEJb4mv6VhKv10L0OQXM7rF5Hev
 8Nv5iU71soFK/0MPOXQCYoxWVwIBSuOJFXEUN31TmNtwaYlPW2RXzT7q58kFEJ9jCE19dasFXVk
 pLMQBcyKme6BXG2vkjJjl4cq92UG2aQ7zpUWZy9QpQ
X-Gm-Gg: ASbGncuJtB2bc894xx3OpjVYiPtp3DU9u7RLTxu4bsCivzXVzAOygE/oibyPNo9K88d
 4aeu3rse4PYaJOqF64yEg1Opfnixt5yMxNpWaOd6GLCnBX36U4105nSxvbofmiRDXIp5M56zG7e
 6Oyy2r7hVP2czOEeEcgB5Q74upqbfNjRQrpNP9RZM755M+fGDw0AyR43gjUsDZhtHV+lU4IDrPd
 M/c61dqfMoup8ZQe2kmRSvsC2eIdLtrD70j4sUoBhAe9fpgj+0tnrTVyzFB6vvdRi1RwaiORhmR
 OfG6EAYiZz8Yk3btEGUb49LKOQCRfrkMMp5yfLS+/Vs=
X-Received: by 2002:a05:6000:41e8:b0:3b5:e6f3:f825 with SMTP id
 ffacd0b85a97d-3b5f186de34mr9808038f8f.23.1752491193601; 
 Mon, 14 Jul 2025 04:06:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAS43AfjCQyI41YcYeiuJAyk6vQMJ3d0mgkk9leiLIxw1Q/8pzfli8C53UC2PqC5e5vjwJVw==
X-Received: by 2002:a05:6000:41e8:b0:3b5:e6f3:f825 with SMTP id
 ffacd0b85a97d-3b5f186de34mr9808008f8f.23.1752491193082; 
 Mon, 14 Jul 2025 04:06:33 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45614aeba29sm43571045e9.11.2025.07.14.04.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:06:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Yi Lai <yi1.lai@intel.com>
Subject: [PULL 56/77] i386/cpu: Select legacy cache model based on vendor in
 CPUID 0x8000001D
Date: Mon, 14 Jul 2025 13:03:45 +0200
Message-ID: <20250714110406.117772-57-pbonzini@redhat.com>
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
X86CPUState, set legacy cache model based on vendor in the CPUID
0x8000001D leaf. For AMD CPU, select legacy AMD cache model (in
cache_info_amd) as the default cache model like before, otherwise,
select legacy Intel cache model (in cache_info_cpuid4).

In fact, for Intel (and Zhaoxin) CPU, this change is safe because the
extended CPUID level supported by Intel is up to 0x80000008. So Intel
Guest doesn't have this 0x8000001D leaf.

Although someone could bump "xlevel" up to 0x8000001D for Intel Guest,
it's meaningless and this is undefined behavior. This leaf should be
considered reserved, but the SDM does not explicitly state this. So,
there's no need to specifically use vendor_cpuid_only_v2 to fix
anything, as it doesn't even qualify as a fix since nothing is
currently broken.

Therefore, it is acceptable to select the default legacy cache model
based on the vendor.

For the CPUID 0x8000001D leaf, in X86CPUState, a unified cache_info is
enough. It only needs to be initialized and configured with the
corresponding legacy cache model based on the vendor.

Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250711102143.1622339-18-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b557fd01c02..5b969743bcc 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8080,7 +8080,22 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *edx = 0;
         }
         break;
-    case 0x8000001D:
+    case 0x8000001D: {
+        const CPUCaches *caches;
+
+        /*
+         * FIXME: Temporarily select cache info model here based on
+         * vendor, and merge these 2 cache info models later.
+         *
+         * Intel doesn't support this leaf so that Intel Guests don't
+         * have this leaf. This change is harmless to Intel CPUs.
+         */
+        if (IS_AMD_CPU(env)) {
+            caches = &env->cache_info_amd;
+        } else {
+            caches = &env->cache_info_cpuid4;
+        }
+
         *eax = 0;
         if (cpu->cache_info_passthrough) {
             x86_cpu_get_cache_cpuid(index, count, eax, ebx, ecx, edx);
@@ -8088,19 +8103,19 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         switch (count) {
         case 0: /* L1 dcache info */
-            encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache,
+            encode_cache_cpuid8000001d(caches->l1d_cache,
                                        topo_info, eax, ebx, ecx, edx);
             break;
         case 1: /* L1 icache info */
-            encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cache,
+            encode_cache_cpuid8000001d(caches->l1i_cache,
                                        topo_info, eax, ebx, ecx, edx);
             break;
         case 2: /* L2 cache info */
-            encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache,
+            encode_cache_cpuid8000001d(caches->l2_cache,
                                        topo_info, eax, ebx, ecx, edx);
             break;
         case 3: /* L3 cache info */
-            encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache,
+            encode_cache_cpuid8000001d(caches->l3_cache,
                                        topo_info, eax, ebx, ecx, edx);
             break;
         default: /* end of info */
@@ -8111,6 +8126,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *edx &= CACHE_NO_INVD_SHARING | CACHE_INCLUSIVE;
         }
         break;
+    }
     case 0x8000001E:
         if (cpu->core_id <= 255) {
             encode_topo_cpuid8000001e(cpu, topo_info, eax, ebx, ecx, edx);
-- 
2.50.0


