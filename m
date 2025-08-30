Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10935CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 18:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNwU-0000uG-IV; Sat, 30 Aug 2025 11:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEMO-00064P-8Y
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:42:44 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEML-0004DS-2q
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:42:43 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-32753ef4e33so2086672a91.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532559; x=1757137359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xz6K6b/NcWzA9krG2jmDsuQPjPRc6na7yx50YdzA0DA=;
 b=y5DFKxF34yNCy9+vhF0ESHnd1b9RSHknGMjYd9Rp1Hlw7Yp2TFLYYwzOvLKMIQrrrF
 S9iPvduUCb4yst0YPm6FaHa74le2rB/6HgI+V9VRhVq63wHifT6meHwxlgE2q+59z/i/
 uoGJF7rk3QpUIUrtMpvthV+gLF7l7c8PweK5yLzp3feyMcRGdoMqBJ4f0OR6cvDwISCW
 8xP6lhKVcuuMJrJP1W8JwpYJUuR1Nt12GAu9JwBKR8Spg2KpYmvQ5slvca0QHqPTu1x3
 bSi5KyLq/Ox1y60o0IdWMlDRW4EY8XPeJiHQJv60w1VTE3mDchNCaBIjpAGUqvKAJwzO
 IhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532559; x=1757137359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xz6K6b/NcWzA9krG2jmDsuQPjPRc6na7yx50YdzA0DA=;
 b=K6bA8KiQ/jVEGXLiCCzKIb4/fLWYUJrJOZHebGnhOnJwW09At7iyytOwyeVg3tzVMZ
 YGohs5cFm1N41f0lZcXJRqcr2JVeUHQPBg8r3zQ5qc84Mc/UA1IXruWUnhpLkpOG+BMv
 F1JnZWAGLzgk/qrLC28t7hEtIYRK4ngCs623n1u76wV5Gl1UeCUvbPh/P2kC85QvnQiO
 rCJ5nepJvDWTc7YHX2MlPwhSl6ENU9e/M5kOu7xk8t0uImkByFZbaZwiXUJ7cHKMLoRh
 StEtnTF3/MCxtB2qm8BUVxSK0DhGwazARMTT1jXoyH65IOYu6L7PTJKswRAlon3bTK7K
 VrVA==
X-Gm-Message-State: AOJu0YwhoxygOalcAm3JXLX48o3UGrMcPULBTsN8OfCQ0GZdlEtnoMw5
 8kGjQ2bS4b+e+tqIDNiCUNnosKos/Ucwd/GbwDc2lzbsb6I1gP6GWGMukUwF62ZLXkI9lp8DoJn
 vcSFhONM=
X-Gm-Gg: ASbGncuq1oJvfqKj3TyuKzZNfZF4rEVCujqriVaqbnijLo3Qs8qsJlIy0KjK7p1XRaA
 om9/t4mDD6085CcZ/mbsODyKhBsknsujCh9Y0CneNSbTPJJLcasI2eiPXj0c7MJ223oMQ/BkRy7
 oxn2tgK2UBirBzieJUBVwPwJp6S27t6XuZ/W2f6i8qguOWot3Eh98XPy7i9GrC+XASM6NsoDrmx
 7fT4xpU/fZX8v1jfB1Ty2DDw1AqxTfWETZbEtiyScrwfEpNS62mbgbF8vsigpvBSyuHgQJlqj1C
 iQTijT9KcZIlsvKqmtQd68y9O2PdN0tPEpAT+sR5TRPO4uYETkkeRk3AvuiWTMZnpnsRwGUJI9U
 aqLE9j/RpYht+RRJjqXOJVw/e5APKI0+ABru1xlBG2nYwKwoRhGLvgFnOg4DD
X-Google-Smtp-Source: AGHT+IGp1d6tKuN68ik3Wq98bpIlgM+VF7udjIuvf5QfIvYOgn/sSV4Axha9PfYLjXuK0ITh0YoBgw==
X-Received: by 2002:a17:90b:4e88:b0:327:e9f4:4dd8 with SMTP id
 98e67ed59e1d1-3281543831dmr1902032a91.10.1756532559244; 
 Fri, 29 Aug 2025 22:42:39 -0700 (PDT)
Received: from stoup.. (122-150-204-48.dyn.ip.vocus.au. [122.150.204.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4d96829a66sm2435905a12.6.2025.08.29.22.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:42:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 23/84] target/arm: Expand syndrome parameter to
 raise_exception*
Date: Sat, 30 Aug 2025 15:40:27 +1000
Message-ID: <20250830054128.448363-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
index 285b338aeb..1d60a4ff7d 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -304,14 +304,14 @@ FIELD(CNTHCTL, CNTPMASK, 19, 1)
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


