Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2D9E77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 08:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTdMX-0002bj-Jc; Fri, 03 Jan 2025 03:48:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin@zytor.com>) id 1tTdMU-0002am-LX
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 03:48:55 -0500
Received: from torg.zytor.com ([2607:7c80:54:3::138] helo=mail.zytor.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin@zytor.com>) id 1tTdMK-0007dy-2S
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 03:48:51 -0500
Received: from terminus.zytor.com (terminus.zytor.com
 [IPv6:2607:7c80:54:3:0:0:0:136]) (authenticated bits=0)
 by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5038mSAg1820053
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Fri, 3 Jan 2025 00:48:33 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5038mSAg1820053
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
 s=2024121701; t=1735894113;
 bh=BCyB+afis0o+SHjXEdqncBSF1CJCWKKrH5Ett7rxx08=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qkMSXwNbUTTrntCIxDP/SjdO0vcCD2SP32mIW0axWT3QfigNOZUgOI07J7tv9BbtU
 khzBHE20PCyRpJxTIdef4wKCyYUskf6XH29JyItt53nbIsAA1G9o59YnZ/EoJ5F+sC
 WSCnsGWwjHJHQnoeMPZ0s0UV3zldvYOsyJdEG8f0K7Robu6KvdJ66DvlvjVwfURQQO
 Sr/UiGE9VU9MmLAcF+n4iHkROUJOJozromUsVZLCKfm5PW2fdP+uBIhH0MsC9XydyG
 8QOTtDHfEX6rt2ixb0mcDcKyHWtW3bpDnVzaEGSu/SOfFz/84ZnwO/2Zb/JN9mxoZU
 NO1tOTMrcq0IQ==
From: "Xin Li (Intel)" <xin@zytor.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, xin3.li@intel.com
Subject: [PATCH v1 2/3] target/i386: Add a new CPU feature word for
 CPUID.7.1.ECX
Date: Fri,  3 Jan 2025 00:48:26 -0800
Message-ID: <20250103084827.1820007-3-xin@zytor.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103084827.1820007-1-xin@zytor.com>
References: <20250103084827.1820007-1-xin@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:7c80:54:3::138; envelope-from=xin@zytor.com;
 helo=mail.zytor.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The immediate form of MSR access instructions will use this new CPU
feature word.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 target/i386/cpu.c | 23 ++++++++++++++++++++++-
 target/i386/cpu.h |  1 +
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8a1223acb3..2fb05879c3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -894,6 +894,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 
 #define TCG_7_1_EAX_FEATURES (CPUID_7_1_EAX_FZRM | CPUID_7_1_EAX_FSRS | \
           CPUID_7_1_EAX_FSRC | CPUID_7_1_EAX_CMPCCXADD)
+#define TCG_7_1_ECX_FEATURES 0
 #define TCG_7_1_EDX_FEATURES 0
 #define TCG_7_2_EDX_FEATURES 0
 #define TCG_APM_FEATURES 0
@@ -1133,6 +1134,25 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .tcg_features = TCG_7_1_EAX_FEATURES,
     },
+    [FEAT_7_1_ECX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = {
+            .eax = 7,
+            .needs_ecx = true, .ecx = 1,
+            .reg = R_ECX,
+        },
+        .tcg_features = TCG_7_1_ECX_FEATURES,
+    },
     [FEAT_7_1_EDX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -6659,9 +6679,9 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *edx = env->features[FEAT_7_0_EDX]; /* Feature flags */
         } else if (count == 1) {
             *eax = env->features[FEAT_7_1_EAX];
+            *ecx = env->features[FEAT_7_1_ECX];
             *edx = env->features[FEAT_7_1_EDX];
             *ebx = 0;
-            *ecx = 0;
         } else if (count == 2) {
             *edx = env->features[FEAT_7_2_EDX];
             *eax = 0;
@@ -7563,6 +7583,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         x86_cpu_adjust_feat_level(cpu, FEAT_6_EAX);
         x86_cpu_adjust_feat_level(cpu, FEAT_7_0_ECX);
         x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EAX);
+        x86_cpu_adjust_feat_level(cpu, FEAT_7_1_ECX);
         x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EDX);
         x86_cpu_adjust_feat_level(cpu, FEAT_7_2_EDX);
         x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_EDX);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index dbd8f1ffc7..d23fa96549 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -667,6 +667,7 @@ typedef enum FeatureWord {
     FEAT_7_1_EDX,       /* CPUID[EAX=7,ECX=1].EDX */
     FEAT_7_2_EDX,       /* CPUID[EAX=7,ECX=2].EDX */
     FEAT_24_0_EBX,      /* CPUID[EAX=0x24,ECX=0].EBX */
+    FEAT_7_1_ECX,       /* CPUID[EAX=7,ECX=1].ECX */
     FEATURE_WORDS,
 } FeatureWord;
 
-- 
2.47.1


