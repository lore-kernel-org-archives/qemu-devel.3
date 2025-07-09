Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD0AC83F09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 10:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZSOE-00080v-Om; Wed, 09 Jul 2025 06:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bp@alien8.de>) id 1uZSO4-0007oP-Dr
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 06:50:53 -0400
Received: from mail.alien8.de ([65.109.113.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bp@alien8.de>) id 1uZSO1-0007UL-O0
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 06:50:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 28B8040E0169; 
 Wed,  9 Jul 2025 10:50:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
 header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
 by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id JbiRzY-zr00U; Wed,  9 Jul 2025 10:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
 t=1752058219; bh=Rr4yjz5aprWpMDleYl3tXqKN6f3xZs0VAoyd+AnmIYU=;
 h=Date:From:To:Cc:Subject:From;
 b=XmKnBjobvilm2sZCbP6gEDO5QhSEsw0anZZjahrjQ31O6PhTuO6ZwM2dHfoMAF4tE
 E/X0BX+u91zrrXVlcQ5A87AepyDPdXbNdh7/kzs6fqH35jJzaZ0Gp5csvanJ6KdqFd
 qSVVKj0pwAAQKLZnb0uWUQrRxeSmmvG9SgbpLS/ArSa/RYNQVO4wqJnlvLyl2xwJzs
 AEM8EbpS+IlyPzXWHi7Vhqj5Fv1lAQk/KtqPO6TDKpx8Hv3G6D4CupzeXgDBiFUKZI
 Sym0ky9j0GOlwEy+L13B9tpuZGexmaCcBdCIyjPNHOMtIQPA2iM/8edgssc0AdaklC
 fU/DA4VWCAFVEBFu2Vwljlq+SVsj5q7odnwpQuJvXcDqQZU4B4raZoPjS8dh+1Whft
 TbZ5rLpUzCghNKQxxgYlrG6QjQ2wwNVgIohi9zCrBAjNLY+YV6UFirwV3aDzQltD6x
 dGe5y/PGrSni7ktYr3FkmE3+nKtC8DcJaHZQYVC55pHtUMdRbjp8j2tpQzb7c2TY4e
 mtyhFcSl99/zTORovScnXPE4/kPiUtNynnVwvaQgdepdKxFGCwi/LwGWOmbKS72V8z
 6N6Qt2TQmoAa3Bez448Fk6G3P9wiLc4K+81Ip+QQU5OtknyU4H+LWUFn6yERr32hp8
 Zsk7tdSa18JT17wF86slbbGw=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest
 SHA256) (No client certificate requested)
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0E13F40E0222;
 Wed,  9 Jul 2025 10:50:14 +0000 (UTC)
Date: Wed, 9 Jul 2025 12:49:56 +0200
From: "Borislav Petkov (AMD)" <bp@alien8.de>
To: qemu-devel@nongnu.org, Babu Moger <babu.moger@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] target/i386: Add TSA feature flags
Message-ID: <20250709104956.GAaG5JVO-74EF96hHO@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=65.109.113.108; envelope-from=bp@alien8.de;
 helo=mail.alien8.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi,

I *think* this is how it should be done but I might be forgetting something.
It seems to work in my testing here.

Babu, double-check me pls.

Thx.

---

Add CPUID leaf 0x8000_0021.ECX support and add the TSA CPUID flags.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 target/i386/cpu.c | 20 +++++++++++++++++++-
 target/i386/cpu.h |  3 +++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0d35e95430fe..b889de61ed9d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1274,7 +1274,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
             "no-nested-data-bp", "fs-gs-base-ns", "lfence-always-serializing", NULL,
-            NULL, NULL, "null-sel-clr-base", NULL,
+            NULL, "verw-clear", "null-sel-clr-base", NULL,
             "auto-ibrs", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
@@ -1308,6 +1308,22 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .tcg_features = 0,
         .unmigratable_flags = 0,
     },
+    [FEAT_8000_0021_ECX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            NULL, "tsa-sq-no", "tsa-l1-no", NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = { .eax = 0x80000021, .reg = R_ECX, },
+        .tcg_features = 0,
+        .unmigratable_flags = 0,
+    },
     [FEAT_XSAVE] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -5835,6 +5851,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_8000_0021_EAX] =
             CPUID_8000_0021_EAX_NO_NESTED_DATA_BP |
             CPUID_8000_0021_EAX_LFENCE_ALWAYS_SERIALIZING |
+            CPUID_8000_0021_EAX_VERW_CLEAR |
             CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE |
             CPUID_8000_0021_EAX_AUTO_IBRS,
         .features[FEAT_7_0_EBX] =
@@ -7934,6 +7951,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *eax = *ebx = *ecx = *edx = 0;
         *eax = env->features[FEAT_8000_0021_EAX];
         *ebx = env->features[FEAT_8000_0021_EBX];
+        *ecx = env->features[FEAT_8000_0021_ECX];
         break;
     default:
         /* reserved values: zero */
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 51e10139dfdf..8b2703f41b73 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -641,6 +641,7 @@ typedef enum FeatureWord {
     FEAT_8000_0008_EBX, /* CPUID[8000_0008].EBX */
     FEAT_8000_0021_EAX, /* CPUID[8000_0021].EAX */
     FEAT_8000_0021_EBX, /* CPUID[8000_0021].EBX */
+    FEAT_8000_0021_ECX, /* CPUID[8000_0021].ECX */
     FEAT_8000_0022_EAX, /* CPUID[8000_0022].EAX */
     FEAT_C000_0001_EDX, /* CPUID[C000_0001].EDX */
     FEAT_KVM,           /* CPUID[4000_0001].EAX (KVM_CPUID_FEATURES) */
@@ -1101,6 +1102,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_8000_0021_EAX_FS_GS_BASE_NS                (1U << 1)
 /* LFENCE is always serializing */
 #define CPUID_8000_0021_EAX_LFENCE_ALWAYS_SERIALIZING    (1U << 2)
+/* Memory form of VERW mitigates TSA */
+#define CPUID_8000_0021_EAX_VERW_CLEAR                   (1U << 5)
 /* Null Selector Clears Base */
 #define CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE            (1U << 6)
 /* Automatic IBRS */
-- 
2.43.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

