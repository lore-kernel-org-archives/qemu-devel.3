Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2269EE8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQux-0003cW-1p; Sat, 27 Dec 2025 04:48:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQur-0002ym-9P
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQup-0006wX-ER
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mr0sHsjWlRUGVEaNrcZQI5hWjbJ7RlXggB2aVoEiszU=;
 b=LUsehdQu5YZW8fPHMpxWAcWx5v8gbYABwz14N3son584IRuUTcIgMScG3OXo04YjtbYNdH
 vS7wGEqjq8sofEMYMlJ2qqqznfIggoJqqCBHJ5f94voCbtaUD87pjb/J3vcAgF0PlTpapW
 z4YG1ZvBISHieVWcjTBHDtOoLfFPdO8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-nc2SwQuCNZy7ui7rpk7kRQ-1; Sat, 27 Dec 2025 04:48:49 -0500
X-MC-Unique: nc2SwQuCNZy7ui7rpk7kRQ-1
X-Mimecast-MFC-AGG-ID: nc2SwQuCNZy7ui7rpk7kRQ_1766828928
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477cf2230c8so78146995e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828927; x=1767433727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mr0sHsjWlRUGVEaNrcZQI5hWjbJ7RlXggB2aVoEiszU=;
 b=LP6Ie2KT5RSCK9aLmfXJEeDXaMWUJKzo4Bqq5s5zx4Tx2JW/65Egi1LozzquihmvHn
 NcRC332ECZjUOBMo7YxDXQlshBr+3ykmH/OM0kemf9kaEnFOwxMvLz1EysdCXlskOiwl
 I828rZ6tPhxtaWf8h85hB3uoX/WXOiKKXK+JGXCWm91Q4Tqg6Hlh+NeiZulEArvv0Ebq
 IAOxBibBhX6O65FOgMSUw5T4KbjZrKhCjb058mqdTnCLkOHW/HC4u4bUPwZnTmrITZ9X
 sM21Mk8URsq8Fzb5kGUJWyss1gtoYcBMYhdYKwHouiqd0r0G6EWXoaGzEkr76Gn4IWFG
 58TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828927; x=1767433727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mr0sHsjWlRUGVEaNrcZQI5hWjbJ7RlXggB2aVoEiszU=;
 b=e3gsGy7FSGlP0jFKnzLzSY7cE8tuupecNAIhGKGqDTqFmbYBdrVCyhr4Nl/I1JNUXI
 bEHbeSMju9hBfdActNfYdyr6P49CgkNZRacZgvLmzbeYWR4NCK4u/18EfK24Y+/7pghJ
 aZg7r0qoLQvOtCxg0L3hMJUHQj8Df/YMoqlrHYgdU9JscXGahlD0hJeSAVszl7f/UzIR
 bYNDHpNL4/DMjuRTFNlp/0mf3cdY64cvonWLA44N092oKS5cUUD2U+kwsEfiS9pARosi
 AB/i9JSwZLkW7B7RE7m7FOM8A24D7hUCH9gHonnBhaHfoDPL/9uZajW7gJx8+sZMiQBc
 tqKg==
X-Gm-Message-State: AOJu0Yxhmtht6w/0nrTl3RMH1Mac4ou7euGiXOZwFNU7TclWBFMYwDCL
 BLfgwXafNKUPSPhlcDsjKoSYRDQoE1ADPU3bzubGXv3m3RfL+MbWHSZm2xcY+oVtj7ARt+oS3xr
 zH4++MAAnESOj+iG5BcOWZONuTArI+XdcwYOpURMi6fwds03FO4+Wlu4PiyJJeH62TObCc7Fhy1
 BgB8a8T0U4L+0WF/Uprn8DxSh/EWo9YZfK91vmuuNU
X-Gm-Gg: AY/fxX5huMYI2U/lFwFp6het4CPRDgf1Z7jIdbiioMwBEQb2NxLQMD7YWxVfKyaMfZw
 W2j+U2G3EUMBmGtKHAZF+ouqgpsuoH1xJkc8s4iTj7HGiCWuykN2d6fpc21ye/6/HN+BF63TL+A
 gnkLvp12ygs7cPh/pG/tegKa3arl7EMNnmd8f8CLZUPBx2QrekHjYJBFX8jaeZ2/KeiS4kUIKIt
 YEhpO395V679NoqI3B/TvFNrOrN98C26ZxzFVu1rZprtfurbabVAFaRlMgqv0NKak28b0nsfm0E
 E+mJWirbpzyhqqtZ0pGiz7XfMxuXSkhbYfft1b77XrM8bpVNIxECt2WkHgzDZEpo5fJ9da3HmAW
 ptjdxlWh7T0b+AdMb/YauaCNZrgo7C3vb7+KWP+P+cYObrAZBpZbjriePgTgL9FgNz0ZixkmNAC
 AT4vMfLIrN9DribJQ=
X-Received: by 2002:a05:600c:4f4a:b0:477:58:7cf4 with SMTP id
 5b1f17b1804b1-47d1953b79dmr319528285e9.4.1766828927391; 
 Sat, 27 Dec 2025 01:48:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IER/G+HyZn9l1auJUQiSz3CFkpizB/FYyg01dOBSfoW8yQgnTbi3JwCP8pGRJpXNG1yE7ZB+w==
X-Received: by 2002:a05:600c:4f4a:b0:477:58:7cf4 with SMTP id
 5b1f17b1804b1-47d1953b79dmr319527995e9.4.1766828926921; 
 Sat, 27 Dec 2025 01:48:46 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be27b749esm489734145e9.14.2025.12.27.01.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:48:46 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
Subject: [PULL 095/153] i386/cpu: Add APX EGPRs into xsave area
Date: Sat, 27 Dec 2025 10:47:00 +0100
Message-ID: <20251227094759.35658-21-pbonzini@redhat.com>
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

From: Zide Chen <zide.chen@intel.com>

APX feature bit is in CPUID_7_1_EDX[21], and APX has EGPR component with
index 19 in xstate area, EGPR component has 16 64bit regs. Add EGRP
component into xstate area.

Note, APX re-uses the 128-byte XSAVE area that had been previously
allocated by MPX which has been deprecated on Intel processors, so check
whether APX and MPX are set at the same for Guest, if this case happens,
mask off them both to avoid conflict for xsave area.

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211070942.3612547-2-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 17 +++++++++++++++--
 target/i386/cpu.c | 25 +++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 33350602edd..05e297e6bb5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -604,6 +604,7 @@ typedef enum X86Seg {
 #define XSTATE_ARCH_LBR_BIT             15
 #define XSTATE_XTILE_CFG_BIT            17
 #define XSTATE_XTILE_DATA_BIT           18
+#define XSTATE_APX_BIT                  19
 
 #define XSTATE_FP_MASK                  (1ULL << XSTATE_FP_BIT)
 #define XSTATE_SSE_MASK                 (1ULL << XSTATE_SSE_BIT)
@@ -620,6 +621,7 @@ typedef enum X86Seg {
 #define XSTATE_ARCH_LBR_MASK            (1ULL << XSTATE_ARCH_LBR_BIT)
 #define XSTATE_XTILE_CFG_MASK           (1ULL << XSTATE_XTILE_CFG_BIT)
 #define XSTATE_XTILE_DATA_MASK          (1ULL << XSTATE_XTILE_DATA_BIT)
+#define XSTATE_APX_MASK                 (1ULL << XSTATE_APX_BIT)
 
 #define XSTATE_DYNAMIC_MASK             (XSTATE_XTILE_DATA_MASK)
 
@@ -636,7 +638,8 @@ typedef enum X86Seg {
                                  XSTATE_BNDCSR_MASK | XSTATE_OPMASK_MASK | \
                                  XSTATE_ZMM_Hi256_MASK | \
                                  XSTATE_Hi16_ZMM_MASK | XSTATE_PKRU_MASK | \
-                                 XSTATE_XTILE_CFG_MASK | XSTATE_XTILE_DATA_MASK)
+                                 XSTATE_XTILE_CFG_MASK | \
+                                 XSTATE_XTILE_DATA_MASK | XSTATE_APX_MASK)
 
 /* CPUID feature bits available in XSS */
 #define CPUID_XSTATE_XSS_MASK   (XSTATE_ARCH_LBR_MASK | XSTATE_CET_U_MASK | \
@@ -1039,6 +1042,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_7_1_EDX_PREFETCHITI       (1U << 14)
 /* Support for Advanced Vector Extensions 10 */
 #define CPUID_7_1_EDX_AVX10             (1U << 19)
+/* Support for Advanced Performance Extensions  */
+#define CPUID_7_1_EDX_APXF               (1U << 21)
 
 /* Indicate bit 7 of the IA32_SPEC_CTRL MSR is supported */
 #define CPUID_7_2_EDX_PSFD              (1U << 0)
@@ -1681,6 +1686,8 @@ typedef struct {
 
 #define ARCH_LBR_NR_ENTRIES 32
 
+#define EGPR_NUM  16
+
 /* CPU can't have 0xFFFFFFFF APIC ID, use that value to distinguish
  * that APIC ID hasn't been set yet
  */
@@ -1791,6 +1798,11 @@ typedef struct XSaveXTILEDATA {
     uint8_t xtiledata[8][1024];
 } XSaveXTILEDATA;
 
+/* Ext. save area 19: APX state */
+typedef struct XSaveAPX {
+    uint64_t egprs[EGPR_NUM];
+} XSaveAPX;
+
 QEMU_BUILD_BUG_ON(sizeof(XSaveAVX) != 0x100);
 QEMU_BUILD_BUG_ON(sizeof(XSaveBNDREG) != 0x40);
 QEMU_BUILD_BUG_ON(sizeof(XSaveBNDCSR) != 0x40);
@@ -1803,6 +1815,7 @@ QEMU_BUILD_BUG_ON(sizeof(XSaveCETS) != 0x18);
 QEMU_BUILD_BUG_ON(sizeof(XSaveArchLBR) != 0x328);
 QEMU_BUILD_BUG_ON(sizeof(XSaveXTILECFG) != 0x40);
 QEMU_BUILD_BUG_ON(sizeof(XSaveXTILEDATA) != 0x2000);
+QEMU_BUILD_BUG_ON(sizeof(XSaveAPX) != 0x80);
 
 typedef struct ExtSaveArea {
     uint32_t offset, size;
@@ -1817,7 +1830,7 @@ typedef struct ExtSaveArea {
     const FeatureMask features[2];
 } ExtSaveArea;
 
-#define XSAVE_STATE_AREA_COUNT (XSTATE_XTILE_DATA_BIT + 1)
+#define XSAVE_STATE_AREA_COUNT (XSTATE_APX_BIT + 1)
 
 extern ExtSaveArea x86_ext_save_areas[XSAVE_STATE_AREA_COUNT];
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a9f38f4020f..3c9ed7cd5f7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2111,6 +2111,12 @@ ExtSaveArea x86_ext_save_areas[XSAVE_STATE_AREA_COUNT] = {
             { FEAT_7_0_EDX,         CPUID_7_0_EDX_AMX_TILE },
         },
     },
+    [XSTATE_APX_BIT] = {
+        .size = sizeof(XSaveAPX),
+        .features = {
+            { FEAT_7_1_EDX,         CPUID_7_1_EDX_APXF },
+        },
+    },
 };
 
 uint32_t xsave_area_size(uint64_t mask, bool compacted)
@@ -9116,6 +9122,25 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         env->features[FEAT_KVM] = 0;
     }
 
+    /*
+     * Since Intel MPX had been previously deprecated, APX re-purposes the
+     * 128-byte XSAVE area that had been previously allocated by MPX (state
+     * component indices 3 and 4, making up a 128-byte area located at an
+     * offset of 960 bytes into an un-compacted XSAVE buffer), as a single
+     * state component housing 128-bytes of storage for EGPRs (8-bytes * 16
+     * registers).
+     *
+     * Check the conflict between MPX and APX before initializing xsave
+     * components.
+     */
+    if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_MPX) &&
+        (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_APXF)) {
+        mark_unavailable_features(cpu, FEAT_7_0_EBX, CPUID_7_0_EBX_MPX,
+            "this feature is conflict with APX");
+        mark_unavailable_features(cpu, FEAT_7_1_EDX, CPUID_7_1_EDX_APXF,
+            "this feature is conflict with MPX");
+    }
+
     x86_cpu_enable_xsave_components(cpu);
 
     /* CPUID[EAX=7,ECX=0].EBX always increased level automatically: */
-- 
2.52.0


