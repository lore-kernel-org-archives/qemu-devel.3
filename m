Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89AFCE8FDDA
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQxE-0003ma-Gt; Sat, 27 Dec 2025 04:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQxD-0003il-5z
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQxB-0007TL-3I
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n1F1HkDukR+wivvRioDvk1EBDQ43e9rqantGbZSklj4=;
 b=YuVH4aRuupa6/yp6YHUkSn6GoSwJ+alDFXPgcdVB2SYfvObxMNQR97d5CJEKn2b52jHM7P
 xtgNwvNq8KteG8tQRswxTC3uo4kRuSgocUYe4R3FyItXgwS2JeIyyyDPQn3qTsTjHPrIBm
 kLFuo2UD6f0m5JO5Xuy6tlJvA20u/MA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-ZyF5mJCHPNm8IuISKRz8yA-1; Sat, 27 Dec 2025 04:51:15 -0500
X-MC-Unique: ZyF5mJCHPNm8IuISKRz8yA-1
X-Mimecast-MFC-AGG-ID: ZyF5mJCHPNm8IuISKRz8yA_1766829074
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42fd46385c0so4267402f8f.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829073; x=1767433873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n1F1HkDukR+wivvRioDvk1EBDQ43e9rqantGbZSklj4=;
 b=FIa/Ds4c2ka0GjQrsooiBZxojGmOLjsAw2/dQx6R6jhYbSyNu+tnV/Ce8qUJ0cKWxY
 9OalSGWNYfZHAiuGqaejYey1zQOVog77X0N2ej0SlnoRdbzAg08THDI1v0ahtdImNDD2
 so+vGoUkDxW+nFbyrCcMHxRY5EIe8QNisUAsvTPBBFdAKF7YSmGRxKtumgNYQa/Y4vdA
 bM1IoxuFLmgVR4KUcTNUU/Vpx2Z5kYkvXwokQLBZUV+XcavXW6+k3tsM2Qv7cAXXmONT
 zqq4z3ryxA5HnqUwCLjpXHrnq1IIZUU4v9bzkrnr/4MdnngJF3lle58Vws8ib2GkYWWi
 ZkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829073; x=1767433873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n1F1HkDukR+wivvRioDvk1EBDQ43e9rqantGbZSklj4=;
 b=J70xc7ehO8xtc1P47zMdxD+WNaNiHZJMfLaB/HL64J1PyeoIkHcrzr6nl08Cic32nF
 ckv176eQ7TGoCQJzyTx3cQ4OYFxyL4PZraQsu+c2JVQd7y59AQPwtQxrjx9q1/L2gt+e
 aqgwEM1E7mCz+4T9a4WPuUfecuisgyld0mryaozPcNehWzaZgiDO6GalN7QOqbf+R8ea
 u3U7Fy0zZAg2ZF9oktQ81rwOHhaBVhNQVcdpqswN+w2typ3g3UD+PrzJu9eyQciUSBW7
 GG4OkZ3HBKie26kcFPqqYsmKS8sFSAaRPlN723EeO3wEB06p0JmLrlyQfXZb2Eq4Epcj
 n7XA==
X-Gm-Message-State: AOJu0YzDqLcSyCZrhSiCa2IIRCa8X7diaNlDUyo3XcY7MNZcpjflRHrY
 VAqGEZj0peusxOjgiH1zy5zSdBf8294Bndlv2l3eIDuXvyYd+aGSw3VMfjyV5MSE7XmITT4iI1N
 suUrbPtUhP1tnWq+oH2thdUxm1gupvr4fJd7Z22Qp0LeUKk5tcgo3JYSSe1xJPb+h6RF9LSLDr/
 c7oxgTLxO6h5RfvIrEIp0SQQjP+LT13IytLuDDEWrP
X-Gm-Gg: AY/fxX7c5wsmMArCpdxrhlv5HibUrMIfjg5vj6FHlPsToUoiv2gYotbqJrzXpG2HBOh
 OuAMuMMSF07u1f7YqkYRO4nHuYDcofkmw1N33HWqZlaGCIUvDs8NSyTwZv0v1Y2aWNOHmEN1+0e
 QiSt6GSAp48H9HN7sVGvOklCq+eEIaQsShvPvPasYGD8NyOdqb1Hsrecdv1NQfL0X+2GmwQYaax
 dVXgy4KAZhGmkXfQB424XSfymvigMoA5pgCdNrw8xK8kb4jInvBZ+YWbwywzAWwN08BuQeY2eHY
 S+R/Kcx0wtPoHTsPRn5hLZIfDTGGgUZ1EGiuYoxkZzO0o+8NUFjAJ1zGjQvQyw2s9dxpEoA4SUm
 qHWGcIps9qrnYwk1cvImLoip2Bd4d7aXVQmUybGoqWLFB8Z/sVy+jWvHErvrqnPz37wdtQsaP1C
 75JYgivawE3XnnngY=
X-Received: by 2002:a05:600c:35d1:b0:479:2f95:5179 with SMTP id
 5b1f17b1804b1-47d1954a165mr326559955e9.15.1766829072671; 
 Sat, 27 Dec 2025 01:51:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgb70Q01MYg55cs9CHh+PyisjLCGWxvtQFRs+opIO9eqt6gTcv5fHqyezkFGRyMig0qYcDXg==
X-Received: by 2002:a05:600c:35d1:b0:479:2f95:5179 with SMTP id
 5b1f17b1804b1-47d1954a165mr326559615e9.15.1766829072216; 
 Sat, 27 Dec 2025 01:51:12 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be395d9cfsm199760545e9.0.2025.12.27.01.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:51:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
Subject: [PULL 138/153] i386/cpu: Add support for AVX10_VNNI_INT in CPUID
 enumeration
Date: Sat, 27 Dec 2025 10:47:43 +0100
Message-ID: <20251227094759.35658-64-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

AVX10_VNNI_INT (0x24.0x1.ECX[bit 2]) is a discrete feature bit
introduced on Intel Diamond Rapids, which enumerates the support for
EVEX VPDP* instructions for INT8/INT16 [*].

Although Intel AVX10.2 has already included new VPDP* INT8/INT16 VNNI
instructions, a bit - AVX10_VNNI_INT - is still be separated. Relevant
new instructions can be checked by either CPUID AVX10.2 OR
AVX10_VNNI_INT (e.g., VPDPBSSD).

Support CPUID 0x24.0x1 subleaf with AVX10_VNNI_INT enumeration for
Guest.

[*]: Intel Advanced Vector Extensions 10.2 Architecture Specification
     (rev 5.0).

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251215073743.4055227-4-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h |  4 ++++
 target/i386/cpu.c | 29 ++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7b002962e23..653f14e516c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -712,6 +712,7 @@ typedef enum FeatureWord {
     FEAT_24_0_EBX,      /* CPUID[EAX=0x24,ECX=0].EBX */
     FEAT_29_0_EBX,      /* CPUID[EAX=0x29,ECX=0].EBX */
     FEAT_1E_1_EAX,      /* CPUID[EAX=0x1E,ECX=1].EAX */
+    FEAT_24_1_ECX,      /* CPUID[EAX=0x24,ECX=0].ECX */
     FEATURE_WORDS,
 } FeatureWord;
 
@@ -1113,6 +1114,9 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
                                          CPUID_24_0_EBX_AVX10_256 | \
                                          CPUID_24_0_EBX_AVX10_512)
 
+/* AVX10_VNNI_INT instruction */
+#define CPUID_24_1_ECX_AVX10_VNNI_INT         (1U << 2)
+
 /*
  * New Conditional Instructions (NCIs), explicit New Data Destination (NDD)
  * controls, and explicit Flags Suppression (NF) controls for select sets of
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1246a9af4a3..e0d75d170fa 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1038,6 +1038,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_24_0_EBX_FEATURES 0
 #define TCG_29_0_EBX_FEATURES 0
 #define TCG_1E_1_EAX_FEATURES 0
+#define TCG_24_1_ECX_FEATURES 0
 
 #if defined CONFIG_USER_ONLY
 #define CPUID_8000_0008_EBX_KERNEL_FEATURES (CPUID_8000_0008_EBX_IBPB | \
@@ -1385,6 +1386,18 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .tcg_features = TCG_29_0_EBX_FEATURES,
     },
+    [FEAT_24_1_ECX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            [2] = "avx10-vnni-int",
+        },
+        .cpuid = {
+            .eax = 0x24,
+            .needs_ecx = true, .ecx = 1,
+            .reg = R_ECX,
+        },
+        .tcg_features = TCG_24_1_ECX_FEATURES,
+    },
     [FEAT_8000_0007_EDX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -2041,6 +2054,11 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_7_1_EDX,             CPUID_7_1_EDX_APXF },
         .to = { FEAT_29_0_EBX,              ~0ull },
     },
+
+    {
+        .from = { FEAT_7_1_EDX,             CPUID_7_1_EDX_AVX10 },
+        .to = { FEAT_24_1_ECX,              ~0ull },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
@@ -8457,8 +8475,17 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *ebx = 0;
         *ecx = 0;
         *edx = 0;
-        if ((env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) && count == 0) {
+
+        if (!(env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10)) {
+            break;
+        }
+        if (count == 0) {
+            uint32_t unused;
+            x86_cpu_get_supported_cpuid(0x1E, 0, eax, &unused,
+                                        &unused, &unused);
             *ebx = env->features[FEAT_24_0_EBX] | env->avx10_version;
+        } else if (count == 1) {
+            *ecx = env->features[FEAT_24_1_ECX];
         }
         break;
     }
-- 
2.52.0


