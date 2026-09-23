Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340A5C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Qq9-0000Rj-SR; Wed, 23 Sep 2026 13:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9QoP-0006yB-Uq
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:31:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9QoM-0003mN-42
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790184671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F3LJcrFsY6gDI05Rg2w/j7BQ0U1fMQIzC7scyP9KnJQ=;
 b=JvY5j43sUqp0NuM/3nL/1uylvg+6z/wojKu5uNjfArBxCH4Wr+1tRZQqsfGQzMPkStxuDD
 DN4gNESdF/cDvlaqbM5MZ+mloCWXMDRax0S68k7e+kMj6q6+RNWge/H0b6s2lE/4FtHuri
 LWPxCVzi5O4K+1r9mCjGbuI2YSL0B14=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-obfeThjvN0qo-C7Aj0ihPQ-1; Wed, 23 Sep 2026 13:31:10 -0400
X-MC-Unique: obfeThjvN0qo-C7Aj0ihPQ-1
X-Mimecast-MFC-AGG-ID: obfeThjvN0qo-C7Aj0ihPQ_1790184669
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49cf4cc2125so5528925e9.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790184669; x=1790789469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F3LJcrFsY6gDI05Rg2w/j7BQ0U1fMQIzC7scyP9KnJQ=;
 b=AgjTrJF52du9Nwd74/pAQDhhRtj/3LLwXZfEVbrAoKqDB/bhdu5JvgaAvUYTDIbT9a
 EOQp8Sj3qAuTXnF90/58YsF64L38fF4lLaAGNdz533u8LaFYR2VnR/jIsyH3SBfhcPSt
 fq+D+muXU5zmih0/Hzc4x7U73VlR5/JmfGyorrw+COrLkjgn0ZUz6GfXyWSZc+OJvM73
 c2/uM1cmoZO7TlQvRUPuzwGst9xcFn2zFOr1FTKFboX0if9Hg9VVMxS/qJM6cQ7ZQCE2
 75hhLu0yA5ggZMcpVyyvYWu4wvyvheNsO7GgjPu9W64ap3AYkIWKsqAx1VWaIdtxsIsM
 /lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790184669; x=1790789469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F3LJcrFsY6gDI05Rg2w/j7BQ0U1fMQIzC7scyP9KnJQ=;
 b=HNC0+2K6Y+MHONsd11xbUX2KbqR62MZTTQeZohjKwHM6y4I/sfaQf7V/bpycW+fhnZ
 rABBnwbjp8Qb4J9BaGMKV3QhctUlmSlX72UVG+DRGgvzm83FvRBRDA5MFvCsLNO3FyxN
 0tCsvxz6lepYhYGPw2SPdJBHDmz0re3eelcvAkno6GLJJoBK2kLOOKL5lnFlEECroYX8
 HHAs+JtFqx/u9YD3OznE13c4Zek9L+uHNaVYst+Vj6qa2WzZGf7e1epDDgcUqMao5SrG
 75mSoqQWuDNnS+QVb/G0nFHnclcYwmsXSEAcXKau2YgUtKlFA7S6CVkJJQjE2VeU25BV
 Vyjg==
X-Gm-Message-State: AFuF++m8gFi6+Rt6ydSzT3Qhc3kw8I39QdIc5YK39fekb/QIVRcumHN9
 oOpAsXR5rEkXarJmnEpEo+y1lwCTzJTZHvA5b4es7GFzIgqigTxax4ie8IG1qT2fZ14XmqTHr+H
 wb/zVgWFg8yYEO0ZH1TDFllsmeWSuXxWB8PF3RC8c7rkNgW8y6i2dmgY4NhCHgFkA7OsTBFZSB8
 iRscp3d4Uka5q2u9VjS/EA/cC4hE7Fb2CGS8cgzax9
X-Gm-Gg: AYBFou26pQRb6Kylyh9LJ0soavyKABrj1Fxitf8Bt06FhqAgdX8JfPrL+MFGo/2QiED
 NBLXN5p8By8ew6Y6QtLt+n4ymeJcX8rRSXcZIpGyQX0xE/u4hlizWIvY9NOqrOjGmAu/snCVXKC
 Xp2sXAkMhu74sSSy9POTtUdRFVp6ZNJeXNr+SpdzK1u0GG0TKaIVT/8vqBg8ZrgwY17cDlwXKwe
 QNpb6ujhYUq95nalAy1CmPpI9DwPhiYDmNfKDb1lrYNnpPikfqYXywv3nHVeZzSwByzUHEf7KuW
 5LoL88bd36/xDO13s8CbRGa5LoXIxc1q4OySwTba67dAH2vNcTRRdmLN5qhE2GaiDX70FouQOq6
 yTcTyPUFjJ07uEuNZSyfge6HbsCtuiEhCCpZQzgDXjg9oSJJ+jQU47JAAmyJ9nGsoHIt2jZ5TzG
 wUkpcj
X-Received: by 2002:a05:600c:4ece:b0:49e:6050:9fbe with SMTP id
 5b1f17b1804b1-49fdece7b76mr52890495e9.15.1790184668932; 
 Wed, 23 Sep 2026 10:31:08 -0700 (PDT)
X-Received: by 2002:a05:600c:4ece:b0:49e:6050:9fbe with SMTP id
 5b1f17b1804b1-49fdece7b76mr52889935e9.15.1790184668326; 
 Wed, 23 Sep 2026 10:31:08 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5bae53dsm1954355e9.4.2026.09.23.10.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 10:31:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: chang.seok.bae@intel.com,
	zhao1.liu@intel.com
Subject: [PATCH 17/17] target/i386/tcg: mark APX as supported
Date: Wed, 23 Sep 2026 19:30:21 +0200
Message-ID: <20260923173021.317809-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923173021.317809-1-pbonzini@redhat.com>
References: <20260923173021.317809-1-pbonzini@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Finally allow TCG to set the CPUID bit for the APXF feature.  The effect
of APX is about 0.5% larger binaries and about 1% less TCG ops.
QEMU seems to produce about 1% *more* assembly instructions, because
the optimizer could already produce roughly the same ops as NDD or
NF instructions, and the new PUSH2/POP2 instructions include a stack
alignment check that isn't there in non-APX code.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/targets/x86_64-bsd-user.mak   |  2 +-
 configs/targets/x86_64-linux-user.mak |  2 +-
 target/i386/cpu.c                     | 34 ++++++++++++++++++++++++---
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/configs/targets/x86_64-bsd-user.mak b/configs/targets/x86_64-bsd-user.mak
index d754186347f..26b7cfad4e2 100644
--- a/configs/targets/x86_64-bsd-user.mak
+++ b/configs/targets/x86_64-bsd-user.mak
@@ -1,4 +1,4 @@
 TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
-TARGET_XML_FILES= i386-64bit.xml
+TARGET_XML_FILES= i386-64bit.xml i386-64bit-apx.xml
 TARGET_LONG_BITS=64
diff --git a/configs/targets/x86_64-linux-user.mak b/configs/targets/x86_64-linux-user.mak
index 7f9527fd1de..cad68746bdb 100644
--- a/configs/targets/x86_64-linux-user.mak
+++ b/configs/targets/x86_64-linux-user.mak
@@ -2,5 +2,5 @@ TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
 TARGET_SYSTBL_ABI=common,64
 TARGET_SYSTBL=syscall_64.tbl
-TARGET_XML_FILES= i386-64bit.xml i386-64bit-linux.xml
+TARGET_XML_FILES= i386-64bit.xml i386-64bit-linux.xml i386-64bit-apx.xml
 TARGET_LONG_BITS=64
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b6ad69d5047..62cce7d3105 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1005,7 +1005,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_7_1_EAX_FEATURES (CPUID_7_1_EAX_FZRM | CPUID_7_1_EAX_FSRS | \
           CPUID_7_1_EAX_FSRC | CPUID_7_1_EAX_CMPCCXADD)
 #define TCG_7_1_ECX_FEATURES 0
-#define TCG_7_1_EDX_FEATURES 0
+#define TCG_7_1_EDX_FEATURES CPUID_7_1_EDX_APXF
 #define TCG_7_2_EDX_FEATURES 0
 #define TCG_APM_FEATURES 0
 #define TCG_6_EAX_FEATURES CPUID_6_EAX_ARAT
@@ -1017,7 +1017,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_SGX_12_0_EBX_FEATURES 0
 #define TCG_SGX_12_1_EAX_FEATURES 0
 #define TCG_24_0_EBX_FEATURES 0
-#define TCG_29_0_EBX_FEATURES 0
+#define TCG_29_0_EBX_FEATURES CPUID_29_0_EBX_APX_NCI_NDD_NF
 #define TCG_1E_1_EAX_FEATURES 0
 #define TCG_24_1_ECX_FEATURES 0
 
@@ -1554,7 +1554,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .tcg_features = XSTATE_FP_MASK | XSTATE_SSE_MASK |
             XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
-            XSTATE_PKRU_MASK,
+            XSTATE_PKRU_MASK | XSTATE_APX_MASK,
         .migratable_flags = XSTATE_FP_MASK | XSTATE_SSE_MASK |
             XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
             XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK | XSTATE_Hi16_ZMM_MASK |
@@ -9722,9 +9722,37 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
      * inside x86_cpu_parse_featurestr() too.
      */
     if (xcc->max_features) {
+        /*
+         * TCG supports both MPX and APX.  Since they they cannot be enabled together,
+         * disable one---prefer APX if none was chosen explicitly.
+         */
+        uint64_t feat7_1_edx = env->user_features[FEAT_7_1_EDX] & CPUID_7_1_EDX_APXF
+            ? env->features[FEAT_7_1_EDX]
+            : x86_cpu_get_supported_feature_word(cpu, FEAT_7_1_EDX);
+        uint64_t feat7_0_ebx = env->user_features[FEAT_7_0_EBX] & CPUID_7_0_EBX_MPX
+            ? env->features[FEAT_7_0_EBX]
+            : x86_cpu_get_supported_feature_word(cpu, FEAT_7_0_EBX);
+
+        bool apx = feat7_1_edx & CPUID_7_1_EDX_APXF;
+        bool mpx = feat7_0_ebx & CPUID_7_0_EBX_MPX;
+        if (apx && mpx) {
+            if (env->user_features[FEAT_7_1_EDX] & CPUID_7_1_EDX_APXF
+                || !(env->user_features[FEAT_7_0_EBX] & CPUID_7_0_EBX_MPX)) {
+                mpx = false;
+            } else {
+                apx = false;
+            }
+        }
+
         for (w = 0; w < FEATURE_WORDS; w++) {
             /* Override only features that weren't set explicitly by the user.  */
             uint64_t no_autoenable_flags = env->user_features[w] | feature_word_info[w].no_autoenable_flags;
+            if (w == FEAT_7_1_EDX && mpx) {
+                no_autoenable_flags |= CPUID_7_1_EDX_APXF;
+            }
+            if (w == FEAT_7_0_EBX && apx) {
+                no_autoenable_flags |= CPUID_7_0_EBX_MPX;
+            }
 
             env->features[w] |= x86_cpu_get_supported_feature_word(cpu, w) & ~no_autoenable_flags;
         }
-- 
2.55.0


