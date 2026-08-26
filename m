Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43EF3C61DC4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz9Jh-000825-EX; Wed, 26 Aug 2026 04:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ewanhai-oc@zhaoxin.com>)
 id 1wz9Je-00080v-P8
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:49:02 -0400
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ewanhai-oc@zhaoxin.com>) id 1wz9Jc-0001ZT-IL
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:49:02 -0400
Received: from zhaoxin.com (unknown [127.0.0.1])
 by mx1.zhaoxin.com (MTA) with ESMTP id 4hVJGQ6cdCzcYn0c;
 Wed, 26 Aug 2026 16:48:46 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.208.166])
 by mx1.zhaoxin.com (MTA) with ESMTP id 4hVJGQ4GZwzcYn0Y;
 Wed, 26 Aug 2026 16:48:46 +0800 (CST)
Received: from ewan-server.tailb932da.ts.net (ewan-server.tailb932da.ts.net
 [10.28.24.2])
 by zhaoxin.com (8.30) with ESMTPb7ffbebd428b1f166471ea09aacd50d3
 Wed, 26 Aug 2026 16:48:45 +0800
X-Eyou-Smtpauth: ewanhai-oc@zhaoxin.com
X-Eyou-EnvelopeSender: ewanhai-oc@zhaoxin.com
X-Eyou-From: Ewan Hai <ewanhai-oc@zhaoxin.com>
From: "=?UTF-8?B?RXdhbiBIYWktb2M=?=" <ewanhai-oc@zhaoxin.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, ewanhai@zhaoxin.com,
 cobechen@zhaoxin.com, Ewan Hai <ewanhai-oc@zhaoxin.com>
Subject: [PATCH v4 2/4] target/i386: Add Zhaoxin cryptographic CPUID features
Date: Wed, 26 Aug 2026 16:48:36 +0800
Message-Id: <20260826084838.2107629-3-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826084838.2107629-1-ewanhai-oc@zhaoxin.com>
References: <20260826084838.2107629-1-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Eyou-Sender: <ewanhai-oc@zhaoxin.com>
Received-SPF: pass client-ip=210.0.225.12; envelope-from=ewanhai-oc@zhaoxin.com;
 helo=mx1.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FROM_EXCESS_BASE64=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add QEMU feature names and masks for the SM2, CCS, RNG2, PHE2 and RSA
feature pairs in CPUID 0xC0000001 EDX. The matching KVM support exposes
these bits through KVM_GET_SUPPORTED_CPUID.

TCG does not currently implement these instructions. Keep
TCG_EXT4_FEATURES at zero so QEMU filters the bits from realized TCG
CPUs.

Link: https://lore.kernel.org/all/20260610023512.3690734-1-ewanhai-oc@zhaoxin.com/
Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
---
 target/i386/cpu.c | 10 +++++-----
 target/i386/cpu.h | 20 ++++++++++++++++++++
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5408d851d1..1107d1243c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1120,14 +1120,14 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_C000_0001_EDX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-            NULL, NULL, "xstore", "xstore-en",
-            NULL, NULL, "xcrypt", "xcrypt-en",
+            "sm2", "sm2-en", "xstore", "xstore-en",
+            "ccs", "ccs-en", "xcrypt", "xcrypt-en",
             "ace2", "ace2-en", "phe", "phe-en",
             "pmm", "pmm-en", NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, "rng2", "rng2-en",
+            NULL, "phe2", "phe2-en", "rsa",
+            "rsa-en", NULL, NULL, NULL,
         },
         .cpuid = { .eax = 0xC0000001, .reg = R_EDX, },
         .tcg_features = TCG_EXT4_FEATURES,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 641f3ee5c2..60327688f4 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1243,10 +1243,18 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 /* CPUID[0x80000007].EDX flags: */
 #define CPUID_APM_INVTSC       (1U << 8)
 
+/* SM2 algorithm */
+#define CPUID_C000_0001_EDX_SM2                (1U << 0)
+/* SM2 enabled */
+#define CPUID_C000_0001_EDX_SM2_EN             (1U << 1)
 /* "rng" RNG present (xstore) */
 #define CPUID_C000_0001_EDX_XSTORE             (1U << 2)
 /* "rng_en" RNG enabled */
 #define CPUID_C000_0001_EDX_XSTORE_EN          (1U << 3)
+/* SM3 and SM4 algorithms */
+#define CPUID_C000_0001_EDX_CCS                (1U << 4)
+/* CCS enabled */
+#define CPUID_C000_0001_EDX_CCS_EN             (1U << 5)
 /* "ace" on-CPU crypto (xcrypt) */
 #define CPUID_C000_0001_EDX_XCRYPT             (1U << 6)
 /* "ace_en" on-CPU crypto enabled */
@@ -1263,6 +1271,18 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_C000_0001_EDX_PMM                (1U << 12)
 /* PMM enabled */
 #define CPUID_C000_0001_EDX_PMM_EN             (1U << 13)
+/* Random Number Generator v2 */
+#define CPUID_C000_0001_EDX_RNG2               (1U << 22)
+/* RNG2 enabled */
+#define CPUID_C000_0001_EDX_RNG2_EN            (1U << 23)
+/* PadLock Hash Engine v2 */
+#define CPUID_C000_0001_EDX_PHE2               (1U << 25)
+/* PHE2 enabled */
+#define CPUID_C000_0001_EDX_PHE2_EN            (1U << 26)
+/* Big-number arithmetic */
+#define CPUID_C000_0001_EDX_RSA                (1U << 27)
+/* RSA enabled */
+#define CPUID_C000_0001_EDX_RSA_EN             (1U << 28)
 
 #define CPUID_VENDOR_SZ     12
 #define CPUID_MODEL_ID_SZ   48
-- 
2.34.1



