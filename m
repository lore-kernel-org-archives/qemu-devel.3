Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7945FCA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 18:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xChYr-0006pV-Eq; Fri, 02 Oct 2026 14:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChSd-0006Ow-JH
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:54:32 -0400
Received: from mail-dy2-x0d.google.com ([2607:f8b0:4864:36::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChSX-0007rT-7y
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:54:19 -0400
Received: by mail-dy2-x0d.google.com with SMTP id
 5a478bee46e88-34b6f8b8113so1815280eec.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 10:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790963642; x=1791568442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EakiUp5Er8KTxWGtVN1gjNJevoTRcpm4tzLgGCRbVLs=;
 b=I+VUBRDxPJHu8iBsKoL8zmPPnKRLa2BReZp1pSdN0uz8bnwqG6CL+t82W2VnAxqUoM
 83xseJ4uNLphCWaFBWo921VSp7bn/AMyQc9PwVcXJGohOIH2OMguhAjILEotAlRDXC3a
 FTTWq4bcAy5BO9DtXWigAQCSV45e2hE4JLZeTyiQZBi+pCThIzTIR6q4P+3xJVAeoYOJ
 218T/cbQpeHl1uEFg+ITtaAoQ+aS6hOjNePfzLcEeZN9iAxf/p1bQDkqOkpWxqr3M7h5
 JcMU/0PDupKhpBYfbwb1/DakcD2E4r3lI5GXpAero+PeZPtbDOVbPCQx+fQ2xkoXWLfJ
 9ZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790963642; x=1791568442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EakiUp5Er8KTxWGtVN1gjNJevoTRcpm4tzLgGCRbVLs=;
 b=TpGKmowKs7oe9eNqI0rRVQWQDPcHsTFVyGTMQYiD/KpRa6HQWCRPguEF+L5BqxHZhv
 Oc4OQvjA1QMVR/ZXQrEFoSxbWsaC0uwsEAr2qGb3On75871fwnvz7vdQ/1EI5yaJ0r8R
 pT6YCPPQ1Z+yRkwzvvbRvbUe78fhzwc+6kT7r1JTHPBZ3mHO+q8H0vbsbXtShWRIynO5
 Rhz+ZzyAONItduNI9swfF9heFTcsO7cZwr/utu1/aOg1fRoYIk5MDAzyVdrWPc8E05a4
 G1k9Xp4wRxTml7J4wnw6g0AfzYLv7nnzLNbTOB0+v3ltSUu+4KY2AZKFarNr5oW4+bkH
 IqDw==
X-Gm-Message-State: AFq9FYIBYDBnN0uLeXdzjgZvb1PV4OFV9nQ94RZi1I8Hupg5nEqCV2k8
 O4BtVMlciknlpYS638phxWISjNTk3DG/ULD9UXKPTceOFT0HhYH3n4WSySoEclf/zQY=
X-Gm-Gg: AYBFou3nLPtJ2OgupusspBOgStX9e8dj7VfX6IcE2ciMGeNX55wqeziwhwYgUhTQ7S5
 ZvuuohCGma2JycQYhKblentX6EbWq6g+2LB1eJBxH6OlbbUuhkNlKAtsIEr+eOzo9VgvIBFfelw
 14TfxLfEgtkVJVKGWnVvhZymUM34fulxVYtM6MblwsUFHqk9dR12tBKQ2aNeK1m/iyPHcrE2wCf
 n9L65SxynPvBPbGv/gst/ou2RRxqjHKSE5Qm4kj7+oRyvjG9r9dTd+PgQ4XjTuEaRNfrG7ILtHW
 QyB2aSBodfR+o3PzL9o50G7wnJvM78MqxtH0xJh+Zo5rneRAvhZjOqhKX516u+1J+pTyE29eC2S
 EvYwbeydhkCFujTIoR9kZDTmzy+HCwXleT7jUgq1SBJX+tzU3naoXd/IyaLRxDdgkGNfGflDm1n
 Hhyab4A3zXE5WZDOPszjzRbUTx9s2VNI/JxcX6cSw/p0fvkTgsj7UsD6ouUFQ3Tnay3eH/cJHSi
 6oJcYD3EI+5P84ObUdpAQgoD0m4jEw=
X-Received: by 2002:a05:693c:65c5:b0:33c:43c:f3dd with SMTP id
 5a478bee46e88-34f2196cd67mr3188654eec.11.1790963641539; 
 Fri, 02 Oct 2026 10:54:01 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34f14f9f2afsm18027361eec.18.2026.10.02.10.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 10:54:00 -0700 (PDT)
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
Subject: [PATCH v3 25/27] target/mips: use shared TCG exception helpers
Date: Sat,  3 Oct 2026 01:50:33 +0800
Message-ID: <20261002175037.1747-26-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20261002175037.1747-1-luoyonggang@gmail.com>
References: <20261002175037.1747-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::d;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Generate exceptions with gen_helper_raise_excp() and
gen_helper_raise_excp_restore(), storing error_code in CPUMIPSState
before raising. Route do_raise_exception_err() through
cpu_raise_excp_restore() to preserve guest-state restoration.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/mips/cpu.h           |  2 +-
 target/mips/helper.h        |  4 ----
 target/mips/tcg/exception.c | 20 +-------------------
 target/mips/tcg/translate.c |  9 ++++++---
 4 files changed, 8 insertions(+), 27 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 32549791a18..b6bb9028ecf 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1141,7 +1141,7 @@ typedef struct CPUArchState {
     TCState tcs[MIPS_SHADOW_SET_MAX];
     CPUMIPSFPUContext fpus[MIPS_FPU_MAX];
     /* QEMU */
-    int error_code;
+    int32_t error_code;
 #define EXCP_TLB_NOMATCH   0x1
 #define EXCP_INST_NOTAVAIL 0x2 /* No valid instruction word for BadInstr */
     uint32_t hflags;    /* CPU State */
diff --git a/target/mips/helper.h b/target/mips/helper.h
index 779b87101db..83a6dd0b3c4 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -1,7 +1,3 @@
-DEF_HELPER_3(raise_exception_err, noreturn, env, i32, int)
-DEF_HELPER_2(raise_exception, noreturn, env, i32)
-DEF_HELPER_1(raise_exception_debug, noreturn, env)
-
 #ifdef TARGET_MIPS64
 DEF_HELPER_4(sdl, void, env, tl, tl, int)
 DEF_HELPER_4(sdr, void, env, tl, tl, int)
diff --git a/target/mips/tcg/exception.c b/target/mips/tcg/exception.c
index 514880ccba8..20705192988 100644
--- a/target/mips/tcg/exception.c
+++ b/target/mips/tcg/exception.c
@@ -44,22 +44,6 @@ target_ulong exception_resume_pc(CPUMIPSState *env)
     return bad_pc;
 }
 
-void helper_raise_exception_err(CPUMIPSState *env, uint32_t exception,
-                                int error_code)
-{
-    do_raise_exception_err(env, exception, error_code, 0);
-}
-
-void helper_raise_exception(CPUMIPSState *env, uint32_t exception)
-{
-    do_raise_exception(env, exception, GETPC());
-}
-
-void helper_raise_exception_debug(CPUMIPSState *env)
-{
-    do_raise_exception(env, EXCP_DEBUG, 0);
-}
-
 void helper_wait(CPUMIPSState *env)
 {
     CPUState *cs = env_cpu(env);
@@ -140,8 +124,6 @@ void do_raise_exception_err(CPUMIPSState *env, uint32_t exception,
     qemu_log_mask(CPU_LOG_INT, "%s: %d (%s) %d\n",
                   __func__, exception, mips_exception_name(exception),
                   error_code);
-    cs->exception_index = exception;
     env->error_code = error_code;
-
-    cpu_loop_exit_restore(cs, pc);
+    cpu_raise_excp_restore(cs, exception, pc);
 }
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 936f8c4eddc..81c4301f625 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1316,14 +1316,17 @@ static inline void restore_cpu_state(CPUMIPSState *env, DisasContext *ctx)
 void generate_exception_err(DisasContext *ctx, int excp, int err)
 {
     save_cpu_state(ctx, 1);
-    gen_helper_raise_exception_err(tcg_env, tcg_constant_i32(excp),
-                                   tcg_constant_i32(err));
+    tcg_gen_st_i32(tcg_constant_i32(err), tcg_env,
+                   offsetof(CPUMIPSState, error_code));
+    gen_helper_raise_excp(tcg_env, tcg_constant_i32(excp));
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
 void generate_exception(DisasContext *ctx, int excp)
 {
-    gen_helper_raise_exception(tcg_env, tcg_constant_i32(excp));
+    tcg_gen_st_i32(tcg_constant_i32(0), tcg_env,
+                   offsetof(CPUMIPSState, error_code));
+    gen_helper_raise_excp_restore(tcg_env, tcg_constant_i32(excp));
 }
 
 void generate_exception_end(DisasContext *ctx, int excp)
-- 
2.52.0.windows.1


