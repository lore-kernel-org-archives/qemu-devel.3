Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420F1E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQuO-0002C1-Ux; Sat, 27 Dec 2025 04:48:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQuH-0002Av-9j
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQuE-0006rw-NE
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PDttGNujX8XIoiK6An9iT+1WmFacRAyCzD2veP1fHPg=;
 b=K/4UPGc+5ztnjocSpQMrpOBbSW8N37HeLjYGNaVTFmP/2CcBU11hHlktUIJOZFvfI1YG67
 XP0Eq+v+OlqQobZ01f/VXmJvJ3lub1O6rCnd3doZDKhPq8Kl/tmY7Gbd2XN+90E+TTppJB
 vOp5GSBQsikUXnBR2r+Ta3sIbxOSYWk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-Jv1ztmSRO-uUXNaCyjnVoQ-1; Sat, 27 Dec 2025 04:48:12 -0500
X-MC-Unique: Jv1ztmSRO-uUXNaCyjnVoQ-1
X-Mimecast-MFC-AGG-ID: Jv1ztmSRO-uUXNaCyjnVoQ_1766828891
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477964c22e0so53325355e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828891; x=1767433691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PDttGNujX8XIoiK6An9iT+1WmFacRAyCzD2veP1fHPg=;
 b=rl06LkTSM03RwwJ2+ju2ggpC2nUWOqXy/3xSmjso6k2S4z3BbcW3k5R586+0AcrmjZ
 bffiMV7rbsViZuso8KgOVgN97n5sI5pobwOGPCQaYdtJQHHQgmufDIHY3fZpIX03hBgJ
 9bZNz+zVFq6yIsufMMzkhowpybPMeZtX3iyJy6gTmH7FpxasfCeOb0YuRFZBUYcVFEYv
 EWU1ho5bOd9eSmQvGLQbJIMWLNYDCH8wiRGB7I9lpY3PoN6N2Uro9RA6NwuvjkHJIKJH
 W/Mf5Kgde7aDlHVUNJLJlDVWn/0Y+hqM3VzO+zEyIZ9EOSaBZQv0ShnUEkFacX/YTl2Y
 iUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828891; x=1767433691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PDttGNujX8XIoiK6An9iT+1WmFacRAyCzD2veP1fHPg=;
 b=hjYl8wMvMIAgHtTi22jEFnFPfkegyeL1ZKPu3xSq+LmXjA124170KZpL9UnP4BeJxU
 h7M64pdAJRAHgO+gfBrpNB+WGvVFGhQn/0v2/8GgvF52m+6mVAA0oNzEnNibxCSl0ziA
 iTMpily2CX03Smv7Bjg57ql9J5I/gMXrGyH1tkkFkikXjGnUhu/FEVQvSt11EYKt++cQ
 0kN+5N2xwBjkGixQjg4BXUJhXujkaV5eynrxRQcPgKgs0o1xhB25GVtq7JXJcwwHghGg
 /7zL+N042gxb3Nj3r+5Tak2YqH0nO7ZRpytomspaxOAj4hubawa+rXsz97UM7Wpo+x5q
 QXVA==
X-Gm-Message-State: AOJu0YyNf768ZMYINzgS3PCQ5cGg6Sb6ctYcy2Ja/36mMRA+xisWU946
 sWZujAKmsMZmSSV3oruM5D+qWIGySr227s0ef6jbCZYEEKMVmoQgiyqVplXTbo0TCLDczi84NSg
 krUU8d+9yvYMaRD5m4DfhezmbpI74FGFMU2Z/BZooD06dW7h5d91SvvAJvQWTtOI4sVFgqw0/p7
 Hje6dF+Qzwmcek1bgJB70BlMdrdyAwoOSlryv4z9PW
X-Gm-Gg: AY/fxX5VY/iQxRm2I7BZZyrdDWrVuHwIyXi0Hwg3p6GZQEuAJvlzLjMB3YMSN3FcoZ0
 rCh38CcrIN8Cvdo1cAGVQRPRWkpFNMNorVmNxZu5Naw3rQKTApM2hj9i5foNSketperZEoCBRLO
 Fne9cMAlMqwvI0auBGq42cQzt4vOGVk7SkjRe4ibppa2YeN9NOU6D2fMa6LnzbheUmj/Sv9bNPT
 Wc4VkEvkc28vvf3Gl4gGaJXyW3W5eaM11CZ/yDE8TVthiJXRyhZB1vO+VE4H0J3MY+WqdA2QQH1
 IUe1UUvyrL4pRbeYGWGT5XN2yGRpjuDXHWkDzJ6/bFxPOgJ8m+edPac2WmLj2t95iSI87E+Nwy1
 UQRkzWXY/vXltfvCBaLn4pKIu/4A2Px3TtZheDCmrEeZeIQLObS3qUcd1B+YY53XTuchMX6I3AI
 VMfeUbQMWDHlaG1HI=
X-Received: by 2002:a05:600c:6749:b0:471:665:e688 with SMTP id
 5b1f17b1804b1-47d18be89d5mr355272485e9.17.1766828890704; 
 Sat, 27 Dec 2025 01:48:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEy+YraYlQ4MrXFWSbixYhgiAVFEO+SZKARZzE6WmBX0m8dkllavEt62zDHysJK0IjL4fFHuw==
X-Received: by 2002:a05:600c:6749:b0:471:665:e688 with SMTP id
 5b1f17b1804b1-47d18be89d5mr355272145e9.17.1766828890078; 
 Sat, 27 Dec 2025 01:48:10 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d1936d220sm474344535e9.8.2025.12.27.01.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:48:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 079/153] i386/cpu: Reorganize dependency check for arch lbr
 state
Date: Sat, 27 Dec 2025 10:46:44 +0100
Message-ID: <20251227094759.35658-5-pbonzini@redhat.com>
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

The arch lbr state has 2 dependencies:
 * Arch lbr feature bit (CPUID 0x7.0x0:EDX[bit 19]):

   This bit also depends on pmu property. Mask it off if pmu is disabled
   in x86_cpu_expand_features(), so that it is not needed to repeatedly
   check whether this bit is set as well as pmu is enabled.

   Note this doesn't need compat option, since even KVM hasn't support
   arch lbr yet.

   The supported xstate is constructed based such dependency in
   cpuid_has_xsave_feature(), so if pmu is disabled and arch lbr bit is
   masked off, then arch lbr state won't be included in supported
   xstates.

   Thus it's safe to drop the check on arch lbr bit in CPUID 0xD
   encoding.

 * XSAVES feature bit (CPUID 0xD.0x1.EAX[bit 3]):

   Arch lbr state is a supervisor state, which requires the XSAVES
   feature support. Enumerate supported supervisor state based on XSAVES
   feature bit in x86_cpu_enable_xsave_components().

   Then it's safe to drop the check on XSAVES feature support during
   CPUID 0XD encoding.

Suggested-by: Zide Chen <zide.chen@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211060801.3600039-8-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f4c0ae533d0..b53467eb997 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8179,20 +8179,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ebx = xsave_area_size(xstate, true);
             *ecx = env->features[FEAT_XSAVE_XSS_LO];
             *edx = env->features[FEAT_XSAVE_XSS_HI];
-            if (kvm_enabled() && cpu->enable_pmu &&
-                (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR) &&
-                (*eax & CPUID_XSAVE_XSAVES)) {
-                *ecx |= XSTATE_ARCH_LBR_MASK;
-            } else {
-                *ecx &= ~XSTATE_ARCH_LBR_MASK;
-            }
-        } else if (count == 0xf && cpu->enable_pmu
-                   && (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
-            const ExtSaveArea *esa = &x86_ext_save_areas[count];
-
-            *eax = esa->size;
-            *ebx = esa->offset;
-            *ecx = esa->ecx;
         } else if (count < ARRAY_SIZE(x86_ext_save_areas)) {
             const ExtSaveArea *esa = &x86_ext_save_areas[count];
 
@@ -8910,6 +8896,12 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
 
     mask = 0;
     for (i = 0; i < ARRAY_SIZE(x86_ext_save_areas); i++) {
+        /* Skip supervisor states if XSAVES is not supported. */
+        if (CPUID_XSTATE_XSS_MASK & (1 << i) &&
+            !(env->features[FEAT_XSAVE] & CPUID_XSAVE_XSAVES)) {
+            continue;
+        }
+
         const ExtSaveArea *esa = &x86_ext_save_areas[i];
         if (cpuid_has_xsave_feature(env, esa)) {
             mask |= (1ULL << i);
@@ -9027,11 +9019,13 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         }
     }
 
-    if (!cpu->pdcm_on_even_without_pmu) {
+    if (!cpu->enable_pmu) {
         /* PDCM is fixed1 bit for TDX */
-        if (!cpu->enable_pmu && !is_tdx_vm()) {
+        if (!cpu->pdcm_on_even_without_pmu && !is_tdx_vm()) {
             env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
         }
+
+        env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_LBR;
     }
 
     for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
-- 
2.52.0


