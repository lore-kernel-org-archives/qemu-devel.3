Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05E9E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQum-0002Tw-J6; Sat, 27 Dec 2025 04:48:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQuQ-0002FH-KS
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQuO-0006sv-S8
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ab87kf8/soKr7IkvZR1XjGAb5AA1aka9diU3WgRo9Vo=;
 b=QYX3NFm+XGxiTp0rK7NsOXXI4RtYKKViJKIDDLpqHITGTUJlAlGytjANEyiRWnU9bJVEaI
 It5qtuBZgAYl2rlAZF7pWYyepmutnBOdBmrN07G9K6QLnPdsKl+pMxNi0coKBxREiRUiRf
 hWONWMGs/hVSt/Qrf0hWq/br0qfdUlA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-fNG-059fN5aIFnK1z3WktQ-1; Sat, 27 Dec 2025 04:48:21 -0500
X-MC-Unique: fNG-059fN5aIFnK1z3WktQ-1
X-Mimecast-MFC-AGG-ID: fNG-059fN5aIFnK1z3WktQ_1766828900
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4779d8fd4ecso39606115e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828899; x=1767433699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ab87kf8/soKr7IkvZR1XjGAb5AA1aka9diU3WgRo9Vo=;
 b=KXymk2UR/Cdd2M2BV9vWJJZh64tSxs4QpdgbiuelueP5TwLQOSDhBdI3A4ESK6ub0m
 nxzdNfMVlmGyZyMG0TqvKd6I7tYZHtPAVHR+7NIMDJHx0HvRBGriDFxeUeUZlkRhYNsh
 JW+JXlYWkkLV9IKY063rooSIqELpSbALH44TBGlJoeATR0/AauVE/9OMKB/yxKlCjGOs
 Ebywx+vOxWUz35sNF9dAIaJVbvJw48fCSIeo6cKuramH1fJ/tG1pQiewJsuveRpGHRzv
 yfisi1yPfD9E5eBMG6XO1TXoS5W21zqzR7Zs0+kzs9p4gYuURh/bfWjz4TVH7lflc2bi
 MJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828899; x=1767433699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ab87kf8/soKr7IkvZR1XjGAb5AA1aka9diU3WgRo9Vo=;
 b=CxZxJ5oiMPMe2UMdsCy0LWPS8QCuh2jLqf9djiSjvLmyx5ifICThTe89ofX48WvyF7
 GLaN6muaBJghq5Y3PD7FFgplJ/Ti8buDsCO/c36i1RiePE3sB6ft04JWqyJ3kp1OPuAj
 hukUXrsk20iocslgAGnJvJpe584G6WlklOAR8XcvtkTQNIcndfPp56jEbHaeQK//0JZo
 SCMHDbLYptArOWcKOyHS9FyG0477jLNfNZWF/FUkd8KLBxlKGPY9XgNmyKwPye/8OYI/
 b9Ct59pOX2r4cWm0fCMk85kfd8Q8S9wv0CwQYYwgSwB+g4rAYuc5xg2xtH342lpqAMPc
 RJTQ==
X-Gm-Message-State: AOJu0YwknSCz6JNnIb453kYOeGsbsdJzvtvKVNzBdxhaJxX48RRbvHu4
 Zsj4m5vG+Q8blPJ+FSidPinNp4tf6DEigBKDIbhrSJwN0f/QYnhlrOYL57v7tdGN4lGx+SBLciz
 vErX5sgomvuT9329wQ4BcjAcO+fmfKrPkbPn5hFo5Z9Mpm0laHGWAZDChJe8bfDMOqzkPLGiPnt
 b8QDAXn4FraaAu5pri+GcPAqBoBtpe7NS1M1V1n3WJ
X-Gm-Gg: AY/fxX5+3K1RymHlp61ihLUxm1OfkVhGPZGxLNoBxKZc7Z3k9ty8dT1N/FNrsdELGUV
 3B04MrmbjcYwcQ/fkDvxNtjyCA5aDBktHLv6PLs7iamjFb8NVEqq91KXNJDqjNEedZ5DnoOaX1W
 yyaBerzrOVplz1m9Zn0PI/mZ2lsGKnuVCg3DfvLqFEM6B9dZmMSoh1nhQHNWUd3Fp+Py6UzlbQf
 1MyH+fQv/p596MyH69V0tm2nrtC47rxlsi7SjZngDpSe//qzprFFmfcaBGsgJS4nvmqM6L7/VeU
 GW12MYG8ZJd4iIFe7GFZnrawGpNeAAvLPqv4Z58i40syZJqdHHeeAf0ErhAugoE8x5UX08nPf3t
 TLUNcfaXtufIfmQjFkYm4mPLRbXkDbUAjnUpDqP/GQM/K81e6lGYrUcbQ2VfIcracNo0XQsukEO
 ujL2+0xY24m4G1Paw=
X-Received: by 2002:a05:600c:46cf:b0:477:9e0c:f59 with SMTP id
 5b1f17b1804b1-47d18b833a6mr286743605e9.2.1766828899397; 
 Sat, 27 Dec 2025 01:48:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFui7U4OYk3thzB7qMF8H2eP0ks29W88lkkI1XYJXUowekmkwWFX2Dnpt3vuvg/El7iOl0TUQ==
X-Received: by 2002:a05:600c:46cf:b0:477:9e0c:f59 with SMTP id
 5b1f17b1804b1-47d18b833a6mr286743335e9.2.1766828898928; 
 Sat, 27 Dec 2025 01:48:18 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3964226sm209695655e9.0.2025.12.27.01.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:48:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Yang Weijiang <weijiang.yang@intel.com>, Chao Gao <chao.gao@intel.com>
Subject: [PULL 083/153] i386/cpu: Enable xsave support for CET states
Date: Sat, 27 Dec 2025 10:46:48 +0100
Message-ID: <20251227094759.35658-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Yang Weijiang <weijiang.yang@intel.com>

Add CET_U/S bits in xstate area and report support in xstate
feature mask.
MSR_XSS[bit 11] corresponds to CET user mode states.
MSR_XSS[bit 12] corresponds to CET supervisor mode states.

CET Shadow Stack(SHSTK) and Indirect Branch Tracking(IBT) features
are enumerated via CPUID.(EAX=07H,ECX=0H):ECX[7] and EDX[20]
respectively, two features share the same state bits in XSS, so
if either of the features is enabled, set CET_U and CET_S bits
together.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
Co-developed-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211060801.3600039-12-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 26 +++++++++++++++++++++++++-
 target/i386/cpu.c | 14 ++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 3d74afc5a8e..bc3296a3c6f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -589,6 +589,8 @@ typedef enum X86Seg {
 #define XSTATE_Hi16_ZMM_BIT             7
 #define XSTATE_PT_BIT                   8
 #define XSTATE_PKRU_BIT                 9
+#define XSTATE_CET_U_BIT                11
+#define XSTATE_CET_S_BIT                12
 #define XSTATE_ARCH_LBR_BIT             15
 #define XSTATE_XTILE_CFG_BIT            17
 #define XSTATE_XTILE_DATA_BIT           18
@@ -603,6 +605,8 @@ typedef enum X86Seg {
 #define XSTATE_Hi16_ZMM_MASK            (1ULL << XSTATE_Hi16_ZMM_BIT)
 #define XSTATE_PT_MASK                  (1ULL << XSTATE_PT_BIT)
 #define XSTATE_PKRU_MASK                (1ULL << XSTATE_PKRU_BIT)
+#define XSTATE_CET_U_MASK               (1ULL << XSTATE_CET_U_BIT)
+#define XSTATE_CET_S_MASK               (1ULL << XSTATE_CET_S_BIT)
 #define XSTATE_ARCH_LBR_MASK            (1ULL << XSTATE_ARCH_LBR_BIT)
 #define XSTATE_XTILE_CFG_MASK           (1ULL << XSTATE_XTILE_CFG_BIT)
 #define XSTATE_XTILE_DATA_MASK          (1ULL << XSTATE_XTILE_DATA_BIT)
@@ -625,7 +629,8 @@ typedef enum X86Seg {
                                  XSTATE_XTILE_CFG_MASK | XSTATE_XTILE_DATA_MASK)
 
 /* CPUID feature bits available in XSS */
-#define CPUID_XSTATE_XSS_MASK    (XSTATE_ARCH_LBR_MASK)
+#define CPUID_XSTATE_XSS_MASK   (XSTATE_ARCH_LBR_MASK | XSTATE_CET_U_MASK | \
+                                 XSTATE_CET_S_MASK)
 
 #define CPUID_XSTATE_MASK       (CPUID_XSTATE_XCR0_MASK | CPUID_XSTATE_XSS_MASK)
 
@@ -904,6 +909,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_7_0_ECX_WAITPKG           (1U << 5)
 /* Additional AVX-512 Vector Byte Manipulation Instruction */
 #define CPUID_7_0_ECX_AVX512_VBMI2      (1U << 6)
+/* Control-flow enforcement technology: shadow stack */
+#define CPUID_7_0_ECX_CET_SHSTK         (1U << 7)
 /* Galois Field New Instructions */
 #define CPUID_7_0_ECX_GFNI              (1U << 8)
 /* Vector AES Instructions */
@@ -951,6 +958,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_7_0_EDX_TSX_LDTRK         (1U << 16)
 /* Architectural LBRs */
 #define CPUID_7_0_EDX_ARCH_LBR          (1U << 19)
+/* Control-flow enforcement technology: indirect branch tracking */
+#define CPUID_7_0_EDX_CET_IBT           (1U << 20)
 /* AMX_BF16 instruction */
 #define CPUID_7_0_EDX_AMX_BF16          (1U << 22)
 /* AVX512_FP16 instruction */
@@ -1737,6 +1746,19 @@ typedef struct XSavePKRU {
     uint32_t padding;
 } XSavePKRU;
 
+/* Ext. save area 11: CET_U state */
+typedef struct XSaveCETU {
+    uint64_t u_cet;
+    uint64_t pl3_ssp;
+} XSaveCETU;
+
+/* Ext. save area 12: CET_S state */
+typedef struct XSaveCETS {
+    uint64_t pl0_ssp;
+    uint64_t pl1_ssp;
+    uint64_t pl2_ssp;
+} XSaveCETS;
+
 /* Ext. save area 15: Arch LBR state */
 typedef struct XSaveArchLBR {
     uint64_t lbr_ctl;
@@ -1764,6 +1786,8 @@ QEMU_BUILD_BUG_ON(sizeof(XSaveOpmask) != 0x40);
 QEMU_BUILD_BUG_ON(sizeof(XSaveZMM_Hi256) != 0x200);
 QEMU_BUILD_BUG_ON(sizeof(XSaveHi16_ZMM) != 0x400);
 QEMU_BUILD_BUG_ON(sizeof(XSavePKRU) != 0x8);
+QEMU_BUILD_BUG_ON(sizeof(XSaveCETU) != 0x10);
+QEMU_BUILD_BUG_ON(sizeof(XSaveCETS) != 0x18);
 QEMU_BUILD_BUG_ON(sizeof(XSaveArchLBR) != 0x328);
 QEMU_BUILD_BUG_ON(sizeof(XSaveXTILECFG) != 0x40);
 QEMU_BUILD_BUG_ON(sizeof(XSaveXTILEDATA) != 0x2000);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8c00a3ad4df..b1bbb099f33 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2078,6 +2078,20 @@ ExtSaveArea x86_ext_save_areas[XSAVE_STATE_AREA_COUNT] = {
             { FEAT_7_0_ECX,         CPUID_7_0_ECX_PKU },
         },
     },
+    [XSTATE_CET_U_BIT] = {
+        .size = sizeof(XSaveCETU),
+        .features = {
+            { FEAT_7_0_ECX,         CPUID_7_0_ECX_CET_SHSTK },
+            { FEAT_7_0_EDX,         CPUID_7_0_EDX_CET_IBT },
+        },
+    },
+    [XSTATE_CET_S_BIT] = {
+        .size = sizeof(XSaveCETS),
+        .features = {
+            { FEAT_7_0_ECX,         CPUID_7_0_ECX_CET_SHSTK },
+            { FEAT_7_0_EDX,         CPUID_7_0_EDX_CET_IBT },
+        },
+    },
     [XSTATE_ARCH_LBR_BIT] = {
         .size = sizeof(XSaveArchLBR),
         .features = {
-- 
2.52.0


