Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C308AC87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLkK-0006pp-Mc; Sat, 02 Aug 2025 19:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLhi-0008R2-QN
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:31:55 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLhh-00056f-20
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:31:54 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-61585dfc8f8so1030194eaf.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177512; x=1754782312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zGaWh6qB/XNYeP5vG0YKYiWrjkJVNrqnpJ3x4KugETg=;
 b=JL23AYsHSmpbzDwC6HBVTjOfyy6MP6m3D9GVtsBTYUUBPZrfGU/8VD7yD4MtXc14zB
 emVQysWGrVQ87DQ2uaZS54YZ0gSQY96lBgeJ/WoKwMM3aPU7xVvDZl9uancIHIYKyq8Z
 RZKS6vVAVs02QCX/2Po8dNVjbNuHOPv3e/OduU2jH99IBZHNk/XO+OpUbN+R/jrylj0c
 cGqoL4XWui0+tGMuVv2vVZQZ/h0QQ8pZnK2UL2P7BuN5HWPTSlZNR8mV6Vlv7P7r4D3H
 jaPvpO0Hk/vGeYG0LoDXS9OkDixrlKiNAOebaarAczg+pBlaExfc2ilaYtxzUA6th8cQ
 xMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177512; x=1754782312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zGaWh6qB/XNYeP5vG0YKYiWrjkJVNrqnpJ3x4KugETg=;
 b=otJxYmKlNWqGIzqSraCy9KmUHQBiname2TFSx0kdOC2yv+7vY+GyDpJ2VRhEJMozWQ
 zi/LtYsX78dX9BxwV/VkVf62HK83aj09S4E1qK1BjxPTf5Nz/3VX238xH0ue3nBPf6du
 0O5lslnStxqEbjH+UQnHPsiPVAgMrmkSB5Q9hs2xqnAxiyZg3CmrvpFkKVFHBQs03V/6
 XsfJg9LqXU0+bOm4r4F3rEv+3IKbAAae2zAjbs4BJioa66Bp9ug//xlBSf01tQmg8Viy
 +9+mQBez1NtP3ENyPVtvzJKSIOJ58SXzeJ8+B2Wt5q+EoMDbb0kGvjkJXMOqSxxtlzeI
 tMDQ==
X-Gm-Message-State: AOJu0YwIeHnuCNGBtMMAKuNG3K1Qu/6IczzgzJfHZEW+CPQy9D0OkMX5
 QOiEFpmaKBWy05F93DE4RKob7xFauUm+Tk6O5w0b/3TIcw3aCsB8gAoIWPFbFMXhZ9vpdNIfX2a
 sZNVWnFA=
X-Gm-Gg: ASbGncuT+XQ5Fo0jcl5DjD+PpPIgU5Go3LAiw+eh25huj4SY0qTs47wqNquCFyoz3iz
 lmU4QXyfAsqi9pnR0YE85G/WhGjagzH4hhGs+01u/1fr1KXsEQuscgfmTu1kOcd+VkV4Bik+L2E
 Bv5jNr/ROCNfJQVdTOiw8X7/uaoaP6OCjPErsq7tc/FVBvTGepKGCf4sr6uB9fwtmaQDQPLtkej
 EaLoAQOAyYHFcJr4QuqOsTTFNItLFmocAkxhtotArY4ScLegBZU/+RWXHba2w/sTPmDvImVftek
 T/xHPA92OYedzSad1ZeI9Wm42TbySedSNh6mcZ0fiWROKtgQcGCU6GEMFocQM3d5gNVPoAAh7BD
 CBCnTHgU/yKGcj/zye3/g3DJXdDQcDdMkiNfJMsfegQtMgOaRBtW1
X-Google-Smtp-Source: AGHT+IEYragkG9sFyeueBHpelys0pg8+Y6YrfUjagcM1Me2m42UOdmWOFIzaoKnmJ7tpZtd4lURflw==
X-Received: by 2002:a05:6871:2881:b0:301:1218:60a0 with SMTP id
 586e51a60fabf-30b679a5575mr2751857fac.34.1754177511972; 
 Sat, 02 Aug 2025 16:31:51 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30b8e3c9b32sm71031fac.24.2025.08.02.16.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:31:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 23/85] target/arm: Expand syndrome parameter to
 raise_exception*
Date: Sun,  3 Aug 2025 09:28:51 +1000
Message-ID: <20250802232953.413294-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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

Prepare for raising exceptions with 64-bit syndromes.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h     | 6 +++---
 target/arm/tcg-stubs.c     | 2 +-
 target/arm/tcg/op_helper.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index f0e888ff93..fc82dd65e8 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -306,14 +306,14 @@ FIELD(CNTHCTL, CNTPMASK, 19, 1)
  * and never returns because we will longjump back up to the CPU main loop.
  */
 G_NORETURN void raise_exception(CPUARMState *env, uint32_t excp,
-                                uint32_t syndrome, uint32_t target_el);
+                                uint64_t syndrome, uint32_t target_el);
 
 /*
  * Similarly, but also use unwinding to restore cpu state.
  */
 G_NORETURN void raise_exception_ra(CPUARMState *env, uint32_t excp,
-                                      uint32_t syndrome, uint32_t target_el,
-                                      uintptr_t ra);
+                                   uint64_t syndrome, uint32_t target_el,
+                                   uintptr_t ra);
 
 /*
  * For AArch64, map a given EL to an index in the banked_spsr array.
diff --git a/target/arm/tcg-stubs.c b/target/arm/tcg-stubs.c
index aac99b2672..aeeede8066 100644
--- a/target/arm/tcg-stubs.c
+++ b/target/arm/tcg-stubs.c
@@ -16,7 +16,7 @@ void write_v7m_exception(CPUARMState *env, uint32_t new_exc)
     g_assert_not_reached();
 }
 
-void raise_exception_ra(CPUARMState *env, uint32_t excp, uint32_t syndrome,
+void raise_exception_ra(CPUARMState *env, uint32_t excp, uint64_t syndrome,
                         uint32_t target_el, uintptr_t ra)
 {
     g_assert_not_reached();
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 575e566280..46a3b911ec 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -46,7 +46,7 @@ int exception_target_el(CPUARMState *env)
 }
 
 void raise_exception(CPUARMState *env, uint32_t excp,
-                     uint32_t syndrome, uint32_t target_el)
+                     uint64_t syndrome, uint32_t target_el)
 {
     CPUState *cs = env_cpu(env);
 
@@ -70,7 +70,7 @@ void raise_exception(CPUARMState *env, uint32_t excp,
     cpu_loop_exit(cs);
 }
 
-void raise_exception_ra(CPUARMState *env, uint32_t excp, uint32_t syndrome,
+void raise_exception_ra(CPUARMState *env, uint32_t excp, uint64_t syndrome,
                         uint32_t target_el, uintptr_t ra)
 {
     CPUState *cs = env_cpu(env);
-- 
2.43.0


