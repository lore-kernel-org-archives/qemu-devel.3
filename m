Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12647CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fDd-0005B2-A5; Tue, 14 Oct 2025 09:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fDa-00053V-B3
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:37:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fDX-0000yq-Ek
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760449048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2dTSUgN6s0KeJhRecE9yb8BWINQmHI2btxAHd/ryNlM=;
 b=CWoGHdZOGP9PvznGNpBNzeLhXEMsR8dAW2/F63ltmxLkND4SR7F1QdOhdz3bTvIYx/3H/3
 foexSgHotbOBycHWQC1X/YINAZ8KqkBYFVavuZ6yAkCHfCNPDzjeMTtkCkUB6j6U2q2nVc
 JkiFk4j1BwIdmeBJkunSKX40gyZI3+g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-ZAe6Z7VxO-uXwqy_FRKljw-1; Tue, 14 Oct 2025 09:37:27 -0400
X-MC-Unique: ZAe6Z7VxO-uXwqy_FRKljw-1
X-Mimecast-MFC-AGG-ID: ZAe6Z7VxO-uXwqy_FRKljw_1760449046
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3f3c118cbb3so5322091f8f.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760449045; x=1761053845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2dTSUgN6s0KeJhRecE9yb8BWINQmHI2btxAHd/ryNlM=;
 b=ELedXJUWTCU44wojWtkzTJZaSYQuz+PSUHkbSEtMiX/qU2AKRD5vf0P3uReQLFbNy2
 4c3WIJMnIZxY3dhAk5nmCU//XuqcWbXhTCjeWmlv5Oz2gwWiwMYX7SmKMmltrfhEI2NV
 DnXflo5p3h/9AyiUf12uLtBcEqg0jAV7LBoK58s6sQmTCZYzTbQwPQ38NEHuwuo5xjAe
 1cUw3eJxMCjtTaUmWoI9Kj3jFxl64/G/OmCwTaBOaYFMi1n5BPIHhnjFvWwszLYOsLXu
 Bcn6KWF+YdrXC/jZfjEBFhd2xmBIfaMyv3Y7lVRwovFnqyiaClhNpDcrWyGihHD+62ao
 pVZg==
X-Gm-Message-State: AOJu0YyM1WDY+V8Z2YuKoNDDOLv/0z4UC5eUyzh17Bb7OK79WVQCpJgI
 8WkRWmJkKZMmd7oTFEYy+j7ES04iEm3r2bXx+cTFOu1+l/zBP4zBrx0CW8/9qBV28tMewd1ECdC
 oWF1bLfOnA+iSPzHw1qLGXb7rmEM77r3hZB2mn/vNnM53eD+yD3HQsdV7BkdR01EPvEtBQP1BL0
 pyGPMkC0QGWzrr4kUo/zdAIzTk/c0y0Wc3eexsDnfy
X-Gm-Gg: ASbGnct4N3Ilbj8XUSHb4s6OdU+uBuItGFQLUbJGiVnzoXfBZibGtVmqDHCUcDtrPrM
 BMugMUq2GjKjqOa1bb32/fzqxQ1QG+0c+MNUcryg3AoIiVf5bVVD5xi0IBysb/jAbUMmisP0g1o
 9Ftq0l4JA4ZogKP+a74ZFowyrvWTzKmejYbjEbOaEiwrcsWC74+7nqPGQh/PCyWaerc108qSG4Z
 8Uq5hNd2v+karpkvFu9TXF19byfGZptty1IF8lgsdMcBYucQLDkAVWuGa8QzW2gdhzb18YJ8fMg
 rHELElDD+tTPRFMe8dV16fO1NuX1RDMJKiauuJn2qep2O3PIQLa7gX/kS4XKcZyj5H+/pQvVOBR
 vMpNs2neZtSkT+X4Qb7c56wbmkzKWojaTAzyGnF4E4cc=
X-Received: by 2002:a05:6000:4301:b0:3d8:3eca:a978 with SMTP id
 ffacd0b85a97d-4266726d56emr13886053f8f.21.1760449045309; 
 Tue, 14 Oct 2025 06:37:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0SVpkY2U+zhsIzEUgJ96Q+xlYML5tmtcgU3ycYAC2h/ax0YTcD4wgsXLc+v+AV67Yl718Bg==
X-Received: by 2002:a05:6000:4301:b0:3d8:3eca:a978 with SMTP id
 ffacd0b85a97d-4266726d56emr13886035f8f.21.1760449044869; 
 Tue, 14 Oct 2025 06:37:24 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e10e8sm23711721f8f.39.2025.10.14.06.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 06:37:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 05/28] target/i386: Add TSA attack variants TSA-SQ and TSA-L1
Date: Tue, 14 Oct 2025 15:36:50 +0200
Message-ID: <20251014133713.1103695-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014133540.1103268-1-pbonzini@redhat.com>
References: <20251014133540.1103268-1-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Babu Moger <babu.moger@amd.com>

Transient Scheduler Attacks (TSA) are new speculative side channel attacks
related to the execution timing of instructions under specific
microarchitectural conditions. In some cases, an attacker may be able to
use this timing information to infer data from other contexts, resulting in
information leakage.

AMD has identified two sub-variants two variants of TSA.
CPUID Fn8000_0021 ECX[1] (TSA_SQ_NO).
	If this bit is 1, the CPU is not vulnerable to TSA-SQ.

CPUID Fn8000_0021 ECX[2] (TSA_L1_NO).
	If this bit is 1, the CPU is not vulnerable to TSA-L1.

Add the new feature word FEAT_8000_0021_ECX and corresponding bits to
detect TSA variants.

Link: https://www.amd.com/content/dam/amd/en/documents/resources/bulletin/technical-guidance-for-mitigating-transient-scheduler-attacks.pdf
Co-developed-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/12881b2c03fa351316057ddc5f39c011074b4549.1752176771.git.babu.moger@amd.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h |  6 ++++++
 target/i386/cpu.c | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8b7c173838e..f74f13534e7 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -643,6 +643,7 @@ typedef enum FeatureWord {
     FEAT_8000_0008_EBX, /* CPUID[8000_0008].EBX */
     FEAT_8000_0021_EAX, /* CPUID[8000_0021].EAX */
     FEAT_8000_0021_EBX, /* CPUID[8000_0021].EBX */
+    FEAT_8000_0021_ECX, /* CPUID[8000_0021].ECX */
     FEAT_8000_0022_EAX, /* CPUID[8000_0022].EAX */
     FEAT_C000_0001_EDX, /* CPUID[C000_0001].EDX */
     FEAT_KVM,           /* CPUID[4000_0001].EAX (KVM_CPUID_FEATURES) */
@@ -1126,6 +1127,11 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
  */
 #define CPUID_8000_0021_EBX_RAPSIZE    (8U << 16)
 
+/* CPU is not vulnerable TSA SA-SQ attack */
+#define CPUID_8000_0021_ECX_TSA_SQ_NO  (1U << 1)
+/* CPU is not vulnerable TSA SA-L1 attack */
+#define CPUID_8000_0021_ECX_TSA_L1_NO  (1U << 2)
+
 /* Performance Monitoring Version 2 */
 #define CPUID_8000_0022_EAX_PERFMON_V2  (1U << 0)
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ab18de894e4..339881b40f8 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1415,6 +1415,22 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
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
     [FEAT_8000_0022_EAX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -8526,6 +8542,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *eax = *ebx = *ecx = *edx = 0;
         *eax = env->features[FEAT_8000_0021_EAX];
         *ebx = env->features[FEAT_8000_0021_EBX];
+        *ecx = env->features[FEAT_8000_0021_ECX];
         break;
     case 0x80000022:
         *eax = *ebx = *ecx = *edx = 0;
-- 
2.51.0


