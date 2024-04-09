Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F74C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 05:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru3dl-0003Ad-NL; Tue, 09 Apr 2024 01:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dj-00039t-J4
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:23 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dh-0005H9-WD
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:23 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6ecfeefe94cso2519148b3a.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 22:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712639000; x=1713243800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=n9BYI6TKWEdafNRUeJOtLO8qVCbGTQ3duCoyIptUdsw=;
 b=XRfAPaDyPLPUtLWx22HTpVkFvyaX36EqRJHHVIRtaF9GKxvcyog96WM4JC0PI7bNjL
 AO1IgsspI96Bj1ze3ayi3TAdYY9qst50GDgF51cAFDVyR4XbRftS/HDZ55bBlyHw9vtl
 6iIVly597Bvcc4ZVrUHyvZf74oWsNipymM/lUtUJZ/QhrPEcuQgJe8MLHa/7xqkRgoMk
 SJPKH6s60SW449EQlXjr37Rk3RQVT+0p5+XYeiDW9Q9Rl3FrTzn/yLshV5RP3xiRrigk
 8YBCwnMQoB/HzFQCpZX++BgemmMvPuGH82iHmaDhCy5gaCO5JhQy2ABXXA2XGldimTSg
 n72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712639000; x=1713243800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n9BYI6TKWEdafNRUeJOtLO8qVCbGTQ3duCoyIptUdsw=;
 b=TNc5cJ9dXF9kxl7i3waiq3sJUJbZ3TrjrQ3vQpxeFrPKdkaUfQ0Nv2ORG1xAL+33e/
 jEVR1QZ/zymNuRkfSVhRq6+awJp4oanMnJHKtXsJuxbv+v/4lu2GoCaL56K9sHFUYtUg
 d1rJ3ThCn1hjgqIF2/aSVGJM3DBG9heZjXVMmd9GHtm22APqDnnqvV2tbeujV2VjLX2C
 gxz1cnobp1fVpUPJjL2viZiWHhlsSU+fTY0eg1RleNiU1fEr90IM85abtSMLlUwhNNEC
 WKaPEHw/8A4+PPyFNW+BlVcq3srZ6viV2AkO0uY3X8WU1oEbYrxX47PAmraDzbdluvAL
 Noqw==
X-Gm-Message-State: AOJu0YzP3YOcaVCu2YVuzv3zLt6HS5BgnrC2rzXEKKmEQ7x7duhfQt6p
 HNVsnBXv4LiQ7HS0gP4tvgXVHeBCcgBnT5Ngh0PVyzIYwqK61BG0sZQ8F4M7yt5DKJG5X+s9s5h
 n
X-Google-Smtp-Source: AGHT+IHRuKRFwkhv/h13mlZD3DmiiMJlPks/FZeeET8FjYMd1SC1jXPj/ZvKPjneC6i35uskzeZRTA==
X-Received: by 2002:a05:6a00:4684:b0:6ed:e1c:1038 with SMTP id
 de4-20020a056a00468400b006ed0e1c1038mr1688454pfb.7.1712639000500; 
 Mon, 08 Apr 2024 22:03:20 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 z26-20020aa785da000000b006e64ddfa71asm7654894pfn.170.2024.04.08.22.03.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 22:03:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/28] target/i386: Split out do_xsave_chk
Date: Mon,  8 Apr 2024 19:02:46 -1000
Message-Id: <20240409050302.1523277-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409050302.1523277-1-richard.henderson@linaro.org>
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This path is not required by user-only, and can in fact
be shared between xsave and xrstor.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/fpu_helper.c | 51 +++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 883002dc22..11c60152de 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2674,16 +2674,6 @@ static void do_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm,
     X86Access ac;
     unsigned size;
 
-    /* The OS must have enabled XSAVE.  */
-    if (!(env->cr[4] & CR4_OSXSAVE_MASK)) {
-        raise_exception_ra(env, EXCP06_ILLOP, ra);
-    }
-
-    /* The operand must be 64 byte aligned.  */
-    if (ptr & 63) {
-        raise_exception_ra(env, EXCP0D_GPF, ra);
-    }
-
     /* Never save anything not enabled by XCR0.  */
     rfbm &= env->xcr0;
     opt &= rfbm;
@@ -2720,15 +2710,35 @@ static void do_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm,
     access_stq(&ac, ptr + XO(header.xstate_bv), new_bv);
 }
 
+static void do_xsave_chk(CPUX86State *env, target_ulong ptr, uintptr_t ra)
+{
+    /* The OS must have enabled XSAVE.  */
+    if (!(env->cr[4] & CR4_OSXSAVE_MASK)) {
+        raise_exception_ra(env, EXCP06_ILLOP, ra);
+    }
+
+    /* The operand must be 64 byte aligned.  */
+    if (ptr & 63) {
+        raise_exception_ra(env, EXCP0D_GPF, ra);
+    }
+}
+
 void helper_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 {
-    do_xsave(env, ptr, rfbm, get_xinuse(env), -1, GETPC());
+    uintptr_t ra = GETPC();
+
+    do_xsave_chk(env, ptr, ra);
+    do_xsave(env, ptr, rfbm, get_xinuse(env), -1, ra);
 }
 
 void helper_xsaveopt(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 {
-    uint64_t inuse = get_xinuse(env);
-    do_xsave(env, ptr, rfbm, inuse, inuse, GETPC());
+    uintptr_t ra = GETPC();
+    uint64_t inuse;
+
+    do_xsave_chk(env, ptr, ra);
+    inuse = get_xinuse(env);
+    do_xsave(env, ptr, rfbm, inuse, inuse, ra);
 }
 
 static void do_xrstor_fpu(X86Access *ac, target_ulong ptr)
@@ -2899,16 +2909,6 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
 
     rfbm &= env->xcr0;
 
-    /* The OS must have enabled XSAVE.  */
-    if (!(env->cr[4] & CR4_OSXSAVE_MASK)) {
-        raise_exception_ra(env, EXCP06_ILLOP, ra);
-    }
-
-    /* The operand must be 64 byte aligned.  */
-    if (ptr & 63) {
-        raise_exception_ra(env, EXCP0D_GPF, ra);
-    }
-
     size = sizeof(X86LegacyXSaveArea) + sizeof(X86XSaveHeader);
     access_prepare(&ac, env, ptr, size, MMU_DATA_LOAD, ra);
 
@@ -3003,7 +3003,10 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
 
 void helper_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 {
-    do_xrstor(env, ptr, rfbm, GETPC());
+    uintptr_t ra = GETPC();
+
+    do_xsave_chk(env, ptr, ra);
+    do_xrstor(env, ptr, rfbm, ra);
 }
 
 #if defined(CONFIG_USER_ONLY)
-- 
2.34.1


