Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A61C87FCC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwMU-0000Bo-VA; Sun, 27 Jul 2025 04:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLs-0005Jq-Bk
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:26 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLq-000477-8S
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:23 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-24014cd385bso1420415ad.0
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603401; x=1754208201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZV74/jk180skCcP64aNSwWKDejXWoEgBfJ7ZrJzLYQs=;
 b=zJuxPc42cZv3cXbeL1tcPTFk3NX1ZSSOYVijbLmH3ng8OICHYJnZ6QgbyKu2sl6EmN
 MxPaIIGYE37ooY/ZaLXi8sQPnFMCJjx8T/LHErPedBs/uOkxrL9VDBYs/s6sAd3MtDRY
 F5TbdrihPYPYT9+/fh81zDbseTijHttLt07ElfeCTOSXOOb2AFHX4qfwELhE1ks8xySx
 tuebPW8qLlytAe13bdaLaYCRK8MYZW80UJzA07zTHZ+h4FSpv4qdE9dEh1WQCsBddyoN
 Y2ANllhmqX5XCk8S9s8XTFe5oPTYBC2dzlLP7xizwapCHhizhnFy0/Otuy0+Ey4rW/VG
 x+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603401; x=1754208201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZV74/jk180skCcP64aNSwWKDejXWoEgBfJ7ZrJzLYQs=;
 b=YTKS0BohmkJJrS4jmkhnzrB/0tnPThmDv4/8iKA8NEuIyq473oSvhuyL4L65dx3/rR
 4zHRdaEwmlJeaFY8sWSOwNKvqRhMluvrtgQl+FXnotRxNjH43n0CY2omS0kQCuMUeKRI
 C3uJInaiM5cYYZOeZOLrou4rX1hdD6Plm6I7rIIiHPGgVuOmQWVGC4fOSTtHGuuxmTWC
 +l7QBKkxgRNbqY2M1X6zfl4+3SuqkE1VYW1f6SZPd5YP+4QcLBCjuoA6FGe1qQLy58Nv
 kOJb6rl2irl29JvZL2mZXTL1OkmHDaFBMcLRrYw4kYT88gN8ystn7m/miyYtChR+7b8M
 TG2g==
X-Gm-Message-State: AOJu0Yz88sq53NAkl0gAldIWyEJ6DL3Cn5jqBSD9gaFG5fptwYCF9hXe
 AUjqcyikd09lTYV/USzAJ6CbYAijrOE7dq0zMGNmcDSw46W9oGlb79oFTIhme1a9BPwXPaLpTwc
 Iu0qA
X-Gm-Gg: ASbGncvLNKlSglfGvQ7w3EJnAuGXAGzxtA9S2bOiYCB4XaC5tn1DKxMmCpLR1B1ADTg
 8Er0J3YdvIlIOfdspS8DXhk1R/JIP5h5cw7wWwuJUWM8CzboHEf59Ei38kqqDQ9Na6/zQ4djDtx
 ckxJTjGgslLS+kD5ZL6Em5qLuCho5NydNT5NYms/eQwIMQhIIeEAJ4apy0ScZQbkdO2Yl7MtQvg
 0tV4e907oz4XO2Myngx92lxPZDx3GXHFpWq4N/2VBHJZnCfUL3mdKlj2h27N9u0OKTan0bt2ekf
 YZy0+7S8Rb4EMs0K3SHFgFZ8gDAvtgOXCAALA/2m7YqU42RxaobNfsADlNBFyp258RC7OHBC6e/
 NonTj1CglAUkpq7GAajuILCu9ilEdIl7V03ILBeaAJ50eEu/FfCEnmiu/+o/KrvXNWk4kspiiTz
 My5I6nn6HunxqzRNtHOip8
X-Google-Smtp-Source: AGHT+IF8szVz0tmnKhIlULobTD/BqkVWwZSRDel+zMsmDzGILYrcF7VbnskPCmgMAIsQawLb5hTLrA==
X-Received: by 2002:a17:902:ef07:b0:235:cb94:1399 with SMTP id
 d9443c01a7336-23fb309bfe3mr107953615ad.6.1753603400931; 
 Sun, 27 Jul 2025 01:03:20 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe333efesm30016415ad.65.2025.07.27.01.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:03:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 20/82] target/arm: Expand syndrome parameter to
 raise_exception*
Date: Sat, 26 Jul 2025 22:01:52 -1000
Message-ID: <20250727080254.83840-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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


