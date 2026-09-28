Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906E9C9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 05:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB3pP-0004kf-Sz; Mon, 28 Sep 2026 01:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB3oq-00048g-1A
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 01:22:31 -0400
Received: from mail-dl2-x0e.google.com ([2607:f8b0:4864:38::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB3om-0007w1-3F
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 01:22:27 -0400
Received: by mail-dl2-x0e.google.com with SMTP id
 a92af1059eb24-1438cb9b3a3so1409425c88.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 22:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790572941; x=1791177741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pHUfebcALl+NSUvlVWHJuhBPOFBFdzvvL9KgudQ/rlU=;
 b=hQ321XUtkBeBQJBRymcvO6MAXlFUpHGwHWg7bJH3s7Mmgex15x2gfAoUVpMc/RY7OC
 VMZCLPYh/eAy1bW5zvdAKomo7Upgk0WI4LU1j408REY4qOuIZKeQYwy9XYnIN22laVKY
 d6piyI4b7ZhmeP4FnI6zZJWkulpqQnhK/kBD958n5Ur//uu8y1YAwh+QSZSig1LqhtlO
 03qLyxEse9LS1H1Y0o1rzNxxSy3ToqFliHti3XZLZMcPBh7c/cjSj4rR0XnfJ/LKeTz5
 o41UaQ507tZsm21gAKzB+p4P8jiIuI3FHm5cB8X3jnbb2zl1T45DmC7mCIl4h8H/m7N+
 V9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790572941; x=1791177741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pHUfebcALl+NSUvlVWHJuhBPOFBFdzvvL9KgudQ/rlU=;
 b=vGMBR+1Xzfch5QLRtHlmtSkhK5kUkCnEWjyn8DWi2shhgcss9rJloGf2SArpLn61nQ
 /utUNI9fiwZJSgzV0tiMYi4OuJSddiJQLlXkruljHbuFvR/8R/TwUsSOGeMbXtu6d04i
 gjwGMDGuJy0kyQHDVprd7KoyZWtSj9i3Lgm5MAOYNxlCy28TzlM4FGM/6vOVHnHeNdqy
 55Hw1X6al6qWO+HA87tXiW+0CkG8aEn7jnwEFuTgUoup6OY82Lja9Nu7/A7D7Jhfq1UY
 vZqZB+Bts3RdyRJXbi9EqLO665FQoRobO95OQJ2XcpcuC57pXJ8IewAAnEq6z1mMrjN/
 Nvxw==
X-Gm-Message-State: AFuF++nA3eewfBHzNXGB2wpHG0qZe+Ph7rOBXANt9rz8dQr9+OyU2X3+
 Rs609aNGUAJtP2bS5sanvcOD1oNdf7eqSxaMQwORO2QJNJzDb4KjSAx4PXMKmIdijlo=
X-Gm-Gg: AYBFou0eFFH+dwmiPsVuya/CBCIS5GrCszeDKprF5U6m0O4iyQwXOpCHm0GCmmL1NIB
 BM6kjwR7zco3mVUz29PxBEjvpho6Xf1TvVTTsMpcu4w+52bd9ix6zZM+vjdJRzG8asj6Jy9nXgc
 z/H3GpFBoz2u0wY+LLWD7OeuUZJB6ngK8An7TIUTTn1ysvKn5uEsyVGZodlP8AP7F9AXPGALCcB
 eedlJMyXFQk81QmWoo+Ofo87WxP/D1asdAHToNduhzDoB5Ob70GIBkOKfrZDBbIYxVj3bht/0w1
 o36khDvF0wuL+C33j+4eE72Lzhi84xYKh9UA+qqKTdpvI77OSYoMoK5Y0DnbwdlXOojvU6gbsGI
 DOC6gWFIs/7DjmmbDKpVFUg81aY7CtrtQV1hW/tAfO/ykVL4XIfia/yNMjjG1weG88nW6EeEUdU
 AQL0XShze1BSnui2vK4gvFrjjVIcPkI/22pbaEAMQzTbQGbD9yroNjrsvZYSZ+JsJDXE343RZT5
 ToKV+t+wO/lcrnmeXk1VJtJs8JzhiU=
X-Received: by 2002:a05:7022:1588:b0:147:5149:d108 with SMTP id
 a92af1059eb24-1475149db52mr8942727c88.43.1790572941343; 
 Sun, 27 Sep 2026 22:22:21 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-146bb6551d9sm14726248c88.9.2026.09.27.22.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 22:22:20 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Chao Liu <chao.liu@processmission.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Stafford Horne <shorne@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>, Glenn Miles <milesg@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Song Gao <17746591750@163.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Michael Rolnik <mrolnik@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org
Subject: [PATCH v2 10/24] target/microblaze: convert raise_exception to
 raise_excp
Date: Mon, 28 Sep 2026 13:20:36 +0800
Message-ID: <20260928052051.251-11-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260928052051.251-1-luoyonggang@gmail.com>
References: <20260928052051.251-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Translate through raise_excp after syncing PC. Drop TCG
raise_exception. Exit HW_EXCP and MMU through cpu_loop_exit_excp.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/microblaze/helper.c    |  3 +--
 target/microblaze/helper.h    |  2 --
 target/microblaze/op_helper.c | 22 ++++------------------
 target/microblaze/translate.c |  2 +-
 4 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 05a90f5ecb2..d092e916db4 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -146,8 +146,7 @@ bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     }
 
     /* TLB miss.  */
-    cs->exception_index = EXCP_MMU;
-    cpu_loop_exit_restore(cs, retaddr);
+    cpu_loop_exit_excp(cs, EXCP_MMU, retaddr);
 }
 
 void mb_cpu_do_interrupt(CPUState *cs)
diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index 1429c1727ef..ad9c22ed5b7 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -1,5 +1,3 @@
-DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
-
 DEF_HELPER_FLAGS_3(divs, TCG_CALL_NO_WG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(divu, TCG_CALL_NO_WG, i32, env, i32, i32)
 
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 3da0c68da39..f3dc42d5bdd 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -62,25 +62,14 @@ uint32_t helper_get(uint32_t id, uint32_t ctrl)
     return 0xdead0000 | id;
 }
 
-void helper_raise_exception(CPUMBState *env, uint32_t index)
-{
-    CPUState *cs = env_cpu(env);
-
-    cs->exception_index = index;
-    cpu_loop_exit(cs);
-}
-
 /* Raises ESR_EC_DIVZERO if exceptions are enabled.  */
 static void raise_divzero(CPUMBState *env, uint32_t esr, uintptr_t unwind_pc)
 {
     env->msr |= MSR_DZ;
 
     if ((env->msr & MSR_EE) && env_archcpu(env)->cfg.div_zero_exception) {
-        CPUState *cs = env_cpu(env);
-
         env->esr = esr;
-        cs->exception_index = EXCP_HW_EXCP;
-        cpu_loop_exit_restore(cs, unwind_pc);
+        cpu_loop_exit_excp(env_cpu(env), EXCP_HW_EXCP, unwind_pc);
     }
 }
 
@@ -123,8 +112,7 @@ static void raise_fpu_exception(CPUMBState *env, uintptr_t ra)
     CPUState *cs = env_cpu(env);
 
     env->esr = ESR_EC_FPU;
-    cs->exception_index = EXCP_HW_EXCP;
-    cpu_loop_exit_restore(cs, ra);
+    cpu_loop_exit_excp(cs, EXCP_HW_EXCP, ra);
 }
 
 static void update_fpu_flags(CPUMBState *env, int flags, uintptr_t ra)
@@ -390,8 +378,7 @@ void helper_stackprot(CPUMBState *env, uint32_t addr)
 
         env->ear = addr;
         env->esr = ESR_EC_STACKPROT;
-        cs->exception_index = EXCP_HW_EXCP;
-        cpu_loop_exit_restore(cs, GETPC());
+        cpu_loop_exit_excp(cs, EXCP_HW_EXCP, GETPC());
     }
 }
 
@@ -444,8 +431,7 @@ static void mb_transaction_failed_internal(CPUState *cs, hwaddr physaddr,
     if (take) {
         env->esr = esr;
         env->ear = addr;
-        cs->exception_index = EXCP_HW_EXCP;
-        cpu_loop_exit_restore(cs, retaddr);
+        cpu_loop_exit_excp(cs, EXCP_HW_EXCP, retaddr);
     }
 }
 
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 8b219afb5dd..9424208a04b 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -100,7 +100,7 @@ static void t_sync_flags(DisasContext *dc)
 
 static void gen_raise_exception(DisasContext *dc, uint32_t index)
 {
-    gen_helper_raise_exception(tcg_env, tcg_constant_i32(index));
+    gen_helper_raise_excp(tcg_env, tcg_constant_i32(index));
     dc->base.is_jmp = DISAS_NORETURN;
 }
 
-- 
2.52.0.windows.1


