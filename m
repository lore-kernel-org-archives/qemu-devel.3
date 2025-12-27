Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A60FE8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQuC-00029q-14; Sat, 27 Dec 2025 04:48:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQuA-00029e-5o
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQu7-0006ql-Lt
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vSz4mh7XiAmt4x7C6Gw7+a5fT7FbsBUAI34WJrGmG+Q=;
 b=Vh2pphMQ1ov/9wctJqriFWua50Zpzn8cpIka2aPmygydD1wxx9G3HXjhtAkHKy/2Hai+2V
 538mAVKyMGRE/f3G+72GPJNJC1NwBKlBabouDWNU/k4yGGRlF0VGZRwii5Rvj7372LLxCZ
 uQjTAC+4NZUbMTY9ztQhSGlOvq2WuuQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-7jKYbtOpNf6EWoS7aLROmg-1; Sat, 27 Dec 2025 04:48:05 -0500
X-MC-Unique: 7jKYbtOpNf6EWoS7aLROmg-1
X-Mimecast-MFC-AGG-ID: 7jKYbtOpNf6EWoS7aLROmg_1766828884
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4325aa61c6bso2502543f8f.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828883; x=1767433683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vSz4mh7XiAmt4x7C6Gw7+a5fT7FbsBUAI34WJrGmG+Q=;
 b=j9/HeIFBarIMQya4fyzIshvhmgvd5mVpMRIc5iK7tyqjtPNT1cZ7CgCNECyOKRYvCm
 6VvWjypX9GD1XoFQxPBe/N8RB7DDVj7GXYH3EgkbkRJuEDXjnGdYOwJo4sUg0A27jLMW
 Ch5pFXb4/EXSzA7uXTLQjWDuQog9ODB7UikTNnQWsfPcFeIfyGFqupQmPpa5t/gQC4ul
 VwbwmTkXXIDAM1cxtH/oswMEUJgW8bBSUQy5dMfLoY1nVwk0yogMj62xzFM+ygC9gN+X
 HYLErCrDMoMqC1UeDekc4jREZEP0dCL9meEIxYzQXIYuef+eEMxH5tMUiYC+1xFM+5Xd
 578w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828883; x=1767433683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vSz4mh7XiAmt4x7C6Gw7+a5fT7FbsBUAI34WJrGmG+Q=;
 b=vghQuMJjbENanS27ZcvX3/4ymKbpymxUQ+HfvHenxQ3MBVNLNjLe9nsv+AYL3vjIyU
 1PIUdtYDwTM0xPaY6mFnRAaidUN6DcQnMFAYPttaVupmQ9Xjmk4qPYfq9rLulej2gAPZ
 5bZqXBdy7bunUfzCm60kfkPbG7tHAlwCTkHRfPbbQEqGCOcQU/+ABQUyn6HXHxSq6OID
 gTQWT75qwskqVJdt+qAkJS60/l5f2GCg0onuIJx/qCjRHeEDRTsWNPQt7fF0svmBJqko
 r9LQd20VOwb3U4nPIKKn3pm5Fs13qYq1lFSe/rClivPb729ICDvVqJcKg5+hvDLy54S4
 u73A==
X-Gm-Message-State: AOJu0YyGHLdgBb0UPBhWuwpbK3xQDCJNloiiVZByvG2+WZqnyGiYhf8V
 WxbWWpc2f+OFjAdgK/yVS+34CfFIrzGC6Wgg4IuP052oO2O/FyLEwfMDrEzlV/VZKBDl/KhUcYs
 TSHdx9gjLztuAWdP/cjm15tHiyWfoXQWMk4fiGrKLOeCxfsG+db0NL0UqbMhdCcsEco50Tz1M1A
 plfirPkyFPeL7RT3isYfiE9vvNbJjTYASwpIFF3ad2
X-Gm-Gg: AY/fxX4D1XzqkmnjFsoNsycvNXdqLCjLndGnOKMOVXuaD+D6aeqUcyyqs98MiAvS4Sq
 ZikghooeU3zZC9vLUVa5VTinsPLJooqDxP7xnwBFUg971mnNbGiQu4di7HzI6F3zMeM6Br5MYDt
 tgLRHaeOIVbbr5JX4v7x4k7Cpj6sIIEMamllP5tJ6tzouY+U7eM1F6ZlkcJzHGC+NiryOOMIBez
 WC91QQV8plcA0sgTw/qlbEmyW1wB4iFnwt9+FipOW/BMyvLBzbgKpEcqCVVZbDoTWCLlwA1d+0m
 9ZJiyiuxawpVXiKz9Xs1JsypxVFeyjS1rq0TfJ33NAKfKgLT6kCMVYuRjKTgeSiWzoIBC+IGRfT
 ewf8HWQSAMnz5vuEwH/jqjgJUezOsHDRRPKblUvzbVAwS2g9rtqTZ97tAv75MwI6sumDdI570Eb
 wHWfuCHz+VsrNSMb4=
X-Received: by 2002:a05:6000:200c:b0:432:88c2:edb6 with SMTP id
 ffacd0b85a97d-43288c2ee05mr1376438f8f.2.1766828883551; 
 Sat, 27 Dec 2025 01:48:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvLOTVoRp4qSL+k2jn2WYEN0FUCvbRBBZLPIYcM+7drxHvtSveqnmgx2dTWZn2GStnKtPV1Q==
X-Received: by 2002:a05:6000:200c:b0:432:88c2:edb6 with SMTP id
 ffacd0b85a97d-43288c2ee05mr1376416f8f.2.1766828883058; 
 Sat, 27 Dec 2025 01:48:03 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa08d9sm50885173f8f.30.2025.12.27.01.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:48:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 076/153] i386/cpu: Make ExtSaveArea store an array of
 dependencies
Date: Sat, 27 Dec 2025 10:46:41 +0100
Message-ID: <20251227094759.35658-2-pbonzini@redhat.com>
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

Some XSAVE components depend on multiple features. For example, Opmask/
ZMM_Hi256/Hi16_ZMM depend on avx512f OR avx10, and for CET (which will
be supported later), cet_u/cet_s will depend on shstk OR ibt.

Although previously there's the special check for the dependencies of
AVX512F OR AVX10 on their respective XSAVE components (in
cpuid_has_xsave_feature()), to make the code more general and avoid
adding more special cases, make ExtSaveArea store a features array
instead of a single feature, so that it can describe multiple
dependencies.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211060801.3600039-5-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h |  9 +++++-
 target/i386/cpu.c | 78 ++++++++++++++++++++++++++++++++++-------------
 2 files changed, 65 insertions(+), 22 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index a183394eca7..3d74afc5a8e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1769,9 +1769,16 @@ QEMU_BUILD_BUG_ON(sizeof(XSaveXTILECFG) != 0x40);
 QEMU_BUILD_BUG_ON(sizeof(XSaveXTILEDATA) != 0x2000);
 
 typedef struct ExtSaveArea {
-    uint32_t feature, bits;
     uint32_t offset, size;
     uint32_t ecx;
+    /*
+     * The dependencies in the array work as OR relationships, which
+     * means having just one of those features is enough.
+     *
+     * At most two features are sharing the same xsave area.
+     * Number of features can be adjusted if necessary.
+     */
+    const FeatureMask features[2];
 } ExtSaveArea;
 
 #define XSAVE_STATE_AREA_COUNT (XSTATE_XTILE_DATA_BIT + 1)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index de4e5c57746..367396a216e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2020,53 +2020,77 @@ static const X86RegisterInfo32 x86_reg_info_32[CPU_NB_REGS32] = {
 ExtSaveArea x86_ext_save_areas[XSAVE_STATE_AREA_COUNT] = {
     [XSTATE_FP_BIT] = {
         /* x87 FP state component is always enabled if XSAVE is supported */
-        .feature = FEAT_1_ECX, .bits = CPUID_EXT_XSAVE,
         .size = sizeof(X86LegacyXSaveArea) + sizeof(X86XSaveHeader),
+        .features = {
+            { FEAT_1_ECX,           CPUID_EXT_XSAVE },
+        },
     },
     [XSTATE_SSE_BIT] = {
         /* SSE state component is always enabled if XSAVE is supported */
-        .feature = FEAT_1_ECX, .bits = CPUID_EXT_XSAVE,
         .size = sizeof(X86LegacyXSaveArea) + sizeof(X86XSaveHeader),
+        .features = {
+            { FEAT_1_ECX,           CPUID_EXT_XSAVE },
+        },
     },
     [XSTATE_YMM_BIT] = {
-        .feature = FEAT_1_ECX, .bits = CPUID_EXT_AVX,
         .size = sizeof(XSaveAVX),
+        .features = {
+            { FEAT_1_ECX,           CPUID_EXT_AVX },
+        },
     },
     [XSTATE_BNDREGS_BIT] = {
-        .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_MPX,
         .size = sizeof(XSaveBNDREG),
+        .features = {
+            { FEAT_7_0_EBX,         CPUID_7_0_EBX_MPX },
+        },
     },
     [XSTATE_BNDCSR_BIT] = {
-        .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_MPX,
         .size = sizeof(XSaveBNDCSR),
+        .features = {
+            { FEAT_7_0_EBX,         CPUID_7_0_EBX_MPX },
+        },
     },
     [XSTATE_OPMASK_BIT] = {
-        .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_AVX512F,
         .size = sizeof(XSaveOpmask),
+        .features = {
+            { FEAT_7_0_EBX,         CPUID_7_0_EBX_AVX512F },
+        },
     },
     [XSTATE_ZMM_Hi256_BIT] = {
-        .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_AVX512F,
         .size = sizeof(XSaveZMM_Hi256),
+        .features = {
+            { FEAT_7_0_EBX,         CPUID_7_0_EBX_AVX512F },
+        },
     },
     [XSTATE_Hi16_ZMM_BIT] = {
-        .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_AVX512F,
         .size = sizeof(XSaveHi16_ZMM),
+        .features = {
+            { FEAT_7_0_EBX,         CPUID_7_0_EBX_AVX512F },
+        },
     },
     [XSTATE_PKRU_BIT] = {
-        .feature = FEAT_7_0_ECX, .bits = CPUID_7_0_ECX_PKU,
         .size = sizeof(XSavePKRU),
+        .features = {
+            { FEAT_7_0_ECX,         CPUID_7_0_ECX_PKU },
+        },
     },
     [XSTATE_ARCH_LBR_BIT] = {
-        .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_ARCH_LBR,
         .size = sizeof(XSaveArchLBR),
+        .features = {
+            { FEAT_7_0_EDX,         CPUID_7_0_EDX_ARCH_LBR },
+        },
     },
     [XSTATE_XTILE_CFG_BIT] = {
-        .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_AMX_TILE,
         .size = sizeof(XSaveXTILECFG),
+        .features = {
+            { FEAT_7_0_EDX,         CPUID_7_0_EDX_AMX_TILE },
+        },
     },
     [XSTATE_XTILE_DATA_BIT] = {
-        .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_AMX_TILE,
         .size = sizeof(XSaveXTILEDATA),
+        .features = {
+            { FEAT_7_0_EDX,         CPUID_7_0_EDX_AMX_TILE },
+        },
     },
 };
 
@@ -7131,16 +7155,24 @@ static inline void feat2prop(char *s)
 static const char *x86_cpu_feature_name(FeatureWord w, int bitnr)
 {
     const char *name;
-    /* XSAVE components are automatically enabled by other features,
+    /*
+     * XSAVE components are automatically enabled by other features,
      * so return the original feature name instead
      */
     if (w == FEAT_XSAVE_XCR0_LO || w == FEAT_XSAVE_XCR0_HI) {
         int comp = (w == FEAT_XSAVE_XCR0_HI) ? bitnr + 32 : bitnr;
 
-        if (comp < ARRAY_SIZE(x86_ext_save_areas) &&
-            x86_ext_save_areas[comp].bits) {
-            w = x86_ext_save_areas[comp].feature;
-            bitnr = ctz32(x86_ext_save_areas[comp].bits);
+        if (comp < ARRAY_SIZE(x86_ext_save_areas)) {
+            /*
+             * Present the first feature as the default.
+             * FIXME: select and present the one which is actually enabled
+             * among multiple dependencies.
+             */
+            const FeatureMask *fm = &x86_ext_save_areas[comp].features[0];
+            if (fm->mask) {
+                w = fm->index;
+                bitnr = ctz32(fm->mask);
+            }
         }
     }
 
@@ -8610,11 +8642,15 @@ static bool cpuid_has_xsave_feature(CPUX86State *env, const ExtSaveArea *esa)
         return false;
     }
 
-    if (env->features[esa->feature] & esa->bits) {
-        return true;
+    for (int i = 0; i < ARRAY_SIZE(esa->features); i++) {
+        if (env->features[esa->features[i].index] & esa->features[i].mask) {
+            return true;
+        }
     }
-    if (esa->feature == FEAT_7_0_EBX && esa->bits == CPUID_7_0_EBX_AVX512F
-        && (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10)) {
+
+    if (esa->features[0].index == FEAT_7_0_EBX &&
+        esa->features[0].mask == CPUID_7_0_EBX_AVX512F &&
+        (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10)) {
         return true;
     }
 
-- 
2.52.0


