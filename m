Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDB2CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xChWy-0004nN-Hh; Fri, 02 Oct 2026 13:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChS6-0005ur-Dz
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:53:47 -0400
Received: from mail-dy2-x0e.google.com ([2607:f8b0:4864:36::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChS2-0007ng-A2
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:53:46 -0400
Received: by mail-dy2-x0e.google.com with SMTP id
 5a478bee46e88-3428f70d7e7so4560816eec.3
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 10:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790963618; x=1791568418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3djPD4lrHihRA2K/7/0xbymzaT+DB/5oE6KY6UCln9k=;
 b=EQ8ebtFwuJuYt4OZht3NJ7eNBlDcPW80r7tog4jrv10Z0N7efMsVtfbHQvaG7vpMWa
 mti59e5MsLmyuVY12cI2S9Vi1t9YG4kQ6dom7mOsfuDALjkwUkHtbp2hbg67HldZzX6/
 85taTbamY1TCqiWv1bz3vWNIbeiwdtnBwiq1Dh2EKr+21Gc0TY4cbaLANS0i8DIeGn3E
 ezUfe3veHAaVs5k3d9GH76GJ+ZV+U0LRTETaGnPoe+zEM9lXeckOg3kFqiFRhE3YKW8j
 dGi6mG0N6qoEKxFsOkYIfF5dCJviXBfofnfJVr5MWvvOdQfUCM6sAJZo7n+7kg5PnTTf
 uoiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790963618; x=1791568418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3djPD4lrHihRA2K/7/0xbymzaT+DB/5oE6KY6UCln9k=;
 b=PoqGZDX9lrgqkPXtWazv8qk+Ygs1EF5jgIv275m+ljwzTHVq/HJ0/VN9KFVISErBUj
 bt0ZQ7h9RlYg7m2jUQXLSbPZY2QFeHEud/xDhQPmSWtxjP5gqWGyfLA2n8ubtiOGzsA7
 fxLtveYbBblLYvYe9AOEtt+7qN6s2UT4LivTTjiD0umID0iWP0YVIGGRtlg2fwTS2a9a
 rXO/rfXEXT8ykRYJoemZ0bGJSrd9VjSGs7zQqX9b5Cmf4sx7tDW2BAP4yvqFDPTS8pre
 5x1F5w7iiXTpTrqq/I1LUhfd8aiTcYwinGdr7jjtTaG0DsWVCB3Gvthte25gByr/TDkl
 FLxw==
X-Gm-Message-State: AFq9FYJT1EgB4UNopec9ARISyHgej39bYhwjU3ib/3R0oVYXgTVsL+L5
 pV7oYS0AljXW5Yuuhi+waa+Mok6f9qypnalaWMXhM/ebYlpV9EGLY+iLVQesxXz4Zb0=
X-Gm-Gg: AYBFou0Sgrq9uGVczydveMQc8AaUkA1BwmjUbf9vJoev+7LkK17LBdKPCYVrZ7h/QrY
 KG5hr63qya7H6VgWzALDIqhtTVeh+TpCI+diMNl0dVXIqKdwoJSH/KA0rV2C45YW4VPbiZVlbiM
 bk3dpbiyo2rV6RDsKyINzNnfxWWLd1LVDWRRG9QJRNB5neiuyKoSxwgfbhQIvT14IPu1iGRJ/LU
 I+sdA1gzBTKO94kC986zW6k3gdzqbRnuYJg6iV7maWqT1fKYjrJO7KsrQnFIP3Skm8s8GFpcGpy
 dpV653mmi+/WHXK60H/U44CieKDhI28fTHq8TIG1UQAOMLmd2gksljk82Ql2Byl4EhST7VOaGPy
 c/V6NWVSvRb4vLhoduC97KwOrmB9KgD82ky+tj9qkEm9H8dS1suDKFffbNFOAaiRWVTFW9sj68D
 lGON0quVT2Jbo2OomGzPmbn+9NBb2btHbJF3LtIsMM5HhUQl91ZZ7lqqWEn13IJG6keQVHCy6+4
 7MuzzbkhGL6/SAoOXOuAfALsrAISvs=
X-Received: by 2002:a05:7300:c00e:10b0:34e:f85d:63fc with SMTP id
 5a478bee46e88-34f219bf1e3mr4350001eec.39.1790963618351; 
 Fri, 02 Oct 2026 10:53:38 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34f14f9f2afsm18027361eec.18.2026.10.02.10.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 10:53:37 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>, Song Gao <17746591750@163.com>,
 qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-s390x@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Rolnik <mrolnik@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Helge Deller <deller@gmx.de>, Chinmay Rath <rathc@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Glenn Miles <milesg@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 22/27] target/arm: convert exception_internal to raise_excp
Date: Sat,  3 Oct 2026 01:50:30 +0800
Message-ID: <20261002175037.1747-23-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20261002175037.1747-1-luoyonggang@gmail.com>
References: <20261002175037.1747-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use the shared raise_excp helper for exception_internal and adapt zero-PC
C exception exits to cpu_raise_excp(). Preserve ARM-specific exception
helpers that carry additional state.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/arm/tcg/helper-defs.h |  1 -
 target/arm/tcg/m_helper.c    |  3 ++-
 target/arm/tcg/op_helper.c   | 33 ++++++---------------------------
 target/arm/tcg/translate.c   |  2 +-
 4 files changed, 9 insertions(+), 30 deletions(-)

diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index 269ac515065..14ef3120373 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -45,7 +45,6 @@ DEF_HELPER_FLAGS_2(usad8, TCG_CALL_NO_RWG_SE, i32, i32, i32)
 
 DEF_HELPER_FLAGS_3(sel_flags, TCG_CALL_NO_RWG_SE,
                    i32, i32, i32, i32)
-DEF_HELPER_2(exception_internal, noreturn, env, i32)
 DEF_HELPER_3(exception_with_syndrome, noreturn, env, i32, i32)
 DEF_HELPER_4(exception_with_syndrome_el, noreturn, env, i32, i32, i32)
 DEF_HELPER_2(exception_bkpt_insn, noreturn, env, i32)
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 65dcf97adef..9c21df772ab 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -18,6 +18,7 @@
 #include "exec/page-protection.h"
 #ifdef CONFIG_TCG
 #include "accel/tcg/cpu-ldst-common.h"
+#include "accel/tcg/cpu-loop.h"
 #include "semihosting/common-semi.h"
 #endif
 #if !defined(CONFIG_USER_ONLY)
@@ -575,7 +576,7 @@ void HELPER(v7m_bxns)(CPUARMState *env, uint32_t dest)
          */
         env->regs[15] = dest & ~1;
         env->thumb = dest & 1;
-        HELPER(exception_internal)(env, EXCP_EXCEPTION_EXIT);
+        cpu_raise_excp(env_cpu(env), EXCP_EXCEPTION_EXIT);
         /* notreached */
     }
 
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index af56eff9f18..522c309fa39 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -64,10 +64,9 @@ void raise_exception(CPUARMState *env, uint32_t excp,
     }
 
     assert(!excp_is_internal(excp));
-    cs->exception_index = excp;
     env->exception.syndrome = syndrome;
     env->exception.target_el = target_el;
-    cpu_loop_exit(cs);
+    cpu_raise_excp(cs, excp);
 }
 
 void raise_exception_ra(CPUARMState *env, uint32_t excp, uint64_t syndrome,
@@ -399,9 +398,8 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
     }
 
     qatomic_set(&env->halt_reason, HALT_WFI);
-    cs->exception_index = EXCP_HLT;
     cs->halted = 1;
-    cpu_loop_exit(cs);
+    cpu_raise_excp(cs, EXCP_HLT);
 #endif
 }
 
@@ -462,9 +460,8 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
         timer_mod(cpu->wfxt_timer, nexttick);
     }
     qatomic_set(&env->halt_reason, HALT_WFI);
-    cs->exception_index = EXCP_HLT;
     cs->halted = 1;
-    cpu_loop_exit(cs);
+    cpu_raise_excp(cs, EXCP_HLT);
 #endif
 }
 
@@ -631,9 +628,8 @@ void HELPER(wfe)(CPUARMState *env, uint32_t insn_len)
     }
 
     qatomic_set(&env->halt_reason, HALT_WFE);
-    cs->exception_index = EXCP_HLT;
     cs->halted = 1;
-    cpu_loop_exit(cs);
+    cpu_raise_excp(cs, EXCP_HLT);
 #endif
 }
 
@@ -726,9 +722,8 @@ void HELPER(wfet)(CPUARMState *env, uint32_t rd)
     }
 
     qatomic_set(&env->halt_reason, HALT_WFE);
-    cs->exception_index = EXCP_HLT;
     cs->halted = 1;
-    cpu_loop_exit(cs);
+    cpu_raise_excp(cs, EXCP_HLT);
 #endif
 }
 
@@ -740,23 +735,7 @@ void HELPER(yield)(CPUARMState *env)
      * that the guest is currently busy-looping. Yield control back to the
      * top level loop so that a more deserving VCPU has a chance to run.
      */
-    cs->exception_index = EXCP_YIELD;
-    cpu_loop_exit(cs);
-}
-
-/* Raise an internal-to-QEMU exception. This is limited to only
- * those EXCP values which are special cases for QEMU to interrupt
- * execution and not to be used for exceptions which are passed to
- * the guest (those must all have syndrome information and thus should
- * use exception_with_syndrome*).
- */
-void HELPER(exception_internal)(CPUARMState *env, uint32_t excp)
-{
-    CPUState *cs = env_cpu(env);
-
-    assert(excp_is_internal(excp));
-    cs->exception_index = excp;
-    cpu_loop_exit(cs);
+    cpu_raise_excp(cs, EXCP_YIELD);
 }
 
 /* Raise an exception with the specified syndrome register value */
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 6983153ffc6..ad73813fe53 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -379,7 +379,7 @@ static void gen_rebuild_hflags(DisasContext *s, bool new_el)
 void gen_exception_internal(int excp)
 {
     assert(excp_is_internal(excp));
-    gen_helper_exception_internal(tcg_env, tcg_constant_i32(excp));
+    gen_helper_raise_excp(tcg_env, tcg_constant_i32(excp));
 }
 
 static void gen_singlestep_exception(DisasContext *s)
-- 
2.52.0.windows.1


