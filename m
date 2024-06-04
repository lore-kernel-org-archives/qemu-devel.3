Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB34C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEORc-0003Bb-UP; Tue, 04 Jun 2024 03:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEORc-0003BI-7o
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:18:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEORa-0005cX-LG
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717485533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3+poIGky4GSqhFlE6pkBG1pa6bXFWkqUUf8ylZXVgw0=;
 b=W20a+jufyofXBt+KDIkybKd/tsazj1Xlck8JMzJpo3jN2Eot6qBgfK+0mxhmBPabqzEd6+
 9oOe6C/sOg/teXeNl1A1b9LqpcYsjynb22lshNTQ7ovu/iTXWrC+GjAKwuup/nxpMiRFkD
 QjJLb1UoX40zDbL9MTlGPFRUWjPclJQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-ze5qarTvPYCinkPjVbE8hQ-1; Tue, 04 Jun 2024 03:18:49 -0400
X-MC-Unique: ze5qarTvPYCinkPjVbE8hQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-57a24dac048so2179637a12.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 00:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717485527; x=1718090327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3+poIGky4GSqhFlE6pkBG1pa6bXFWkqUUf8ylZXVgw0=;
 b=GciWqtLOkx9d2NFvXYZUfVdIwt2obuihHFa2BQ9GbcSQ0o/67Gf/N0rxRs1n0/xHsR
 PRhdnMvAb5cnNoBTbyeYxU3/97Q2tc5vSbNRxIxhBcRL64HCGoIz13cFaBhxd2nNQyaE
 tkyLkk2ZjQAumfoc9/vgRXx7EhH9H4oXWua7uEV+G7eGVOpgTMzDz6frHTx6FY+GI2gA
 uCMlnmR5+vvpFn2EdPmG5C1JeMd8GRzpVoTJh5MWprTRn9Tuv6ZZm3bqdvGFSor7llrT
 7uuaZ+8i3eoU6biqOV9jXddWrlGEuHQuIxqiY09/Wng36ps67/9je1PhsXXe63IKiqng
 FylQ==
X-Gm-Message-State: AOJu0YwXc2gh4+7E+Mgxiu6wrT0BKWRbEUljS6PmBrvPiFwt2/JB4rtY
 BzAOsn/XAjEd7ZWtjmcX6FUMYXtXAQxMmwkf4mE80OHgW1Ci8xwWZ5uySp8yoA2lTXBUaInf0ZO
 8cE4W0+XK78F8tMATRlJ7qclNgtRt8kNiNaqQv7BaGjW6gBI+R6KWKO869jgf86uO9ssAVSQ5Ct
 tQ8/pjYCIxkHrk1shDOYDTlkxxfn2drstEPYci
X-Received: by 2002:a50:ba89:0:b0:57a:321f:cc4f with SMTP id
 4fb4d7f45d1cf-57a3f55eb7emr7394309a12.19.1717485527376; 
 Tue, 04 Jun 2024 00:18:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDlyGHizdRw6inPRoPSe2Ub88yvUi1oKW9DNURVkz2VD/rdI026ySJVII7f+mRWqCng5ft2w==
X-Received: by 2002:a50:ba89:0:b0:57a:321f:cc4f with SMTP id
 4fb4d7f45d1cf-57a3f55eb7emr7394293a12.19.1717485526957; 
 Tue, 04 Jun 2024 00:18:46 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a790f1c95sm1565969a12.50.2024.06.04.00.18.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 00:18:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 03/11] target/i386: cleanup HLT helpers
Date: Tue,  4 Jun 2024 09:18:25 +0200
Message-ID: <20240604071833.962574-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604071833.962574-1-pbonzini@redhat.com>
References: <20240604071833.962574-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use decode.c's support for intercepts, doing the check in TCG-generated
code rather than the helper.  This is cleaner because it allows removing
the eip_addend argument to helper_hlt().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/helper.h                 |  2 +-
 target/i386/tcg/sysemu/misc_helper.c | 13 ++-----------
 target/i386/tcg/decode-new.c.inc     |  4 ++--
 target/i386/tcg/emit.c.inc           |  4 ++--
 4 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/target/i386/helper.h b/target/i386/helper.h
index 8f291a5f66f..c244dbb4812 100644
--- a/target/i386/helper.h
+++ b/target/i386/helper.h
@@ -90,7 +90,7 @@ DEF_HELPER_2(vmsave, void, env, int)
 DEF_HELPER_1(stgi, void, env)
 DEF_HELPER_1(clgi, void, env)
 DEF_HELPER_FLAGS_2(flush_page, TCG_CALL_NO_RWG, void, env, tl)
-DEF_HELPER_FLAGS_2(hlt, TCG_CALL_NO_WG, noreturn, env, int)
+DEF_HELPER_FLAGS_1(hlt, TCG_CALL_NO_WG, noreturn, env)
 DEF_HELPER_FLAGS_2(monitor, TCG_CALL_NO_WG, void, env, tl)
 DEF_HELPER_FLAGS_2(mwait, TCG_CALL_NO_WG, noreturn, env, int)
 DEF_HELPER_1(rdmsr, void, env)
diff --git a/target/i386/tcg/sysemu/misc_helper.c b/target/i386/tcg/sysemu/misc_helper.c
index edb7c3d8940..e41c88346cb 100644
--- a/target/i386/tcg/sysemu/misc_helper.c
+++ b/target/i386/tcg/sysemu/misc_helper.c
@@ -516,8 +516,7 @@ void helper_flush_page(CPUX86State *env, target_ulong addr)
     tlb_flush_page(env_cpu(env), addr);
 }
 
-static G_NORETURN
-void do_hlt(CPUX86State *env)
+G_NORETURN void helper_hlt(CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
 
@@ -527,14 +526,6 @@ void do_hlt(CPUX86State *env)
     cpu_loop_exit(cs);
 }
 
-G_NORETURN void helper_hlt(CPUX86State *env, int next_eip_addend)
-{
-    cpu_svm_check_intercept_param(env, SVM_EXIT_HLT, 0, GETPC());
-    env->eip += next_eip_addend;
-
-    do_hlt(env);
-}
-
 void helper_monitor(CPUX86State *env, target_ulong ptr)
 {
     if ((uint32_t)env->regs[R_ECX] != 0) {
@@ -558,6 +549,6 @@ G_NORETURN void helper_mwait(CPUX86State *env, int next_eip_addend)
     if (cs->cpu_index != 0 || CPU_NEXT(cs) != NULL) {
         do_pause(env);
     } else {
-        do_hlt(env);
+        helper_hlt(env);
     }
 }
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 0ff0866e8f3..376d2bdabe1 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1496,7 +1496,7 @@ static const X86OpEntry opcodes_root[256] = {
     [0xE7] = X86_OP_ENTRYrr(OUT,   0,v, I_unsigned,b), /* AX/EAX */
 
     [0xF1] = X86_OP_ENTRY0(INT1,   svm(ICEBP)),
-    [0xF4] = X86_OP_ENTRY0(HLT,    chk(cpl0)),
+    [0xF4] = X86_OP_ENTRY0(HLT,    chk(cpl0) svm(HLT)),
     [0xF5] = X86_OP_ENTRY0(CMC),
     [0xF6] = X86_OP_GROUP1(group3, E,b),
     [0xF7] = X86_OP_GROUP1(group3, E,v),
@@ -2539,7 +2539,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
 
     /*
      * Checks that result in #GP or VMEXIT come second.  Intercepts are
-     * generally checked after non-memory exceptions (i.e. before all
+     * generally checked after non-memory exceptions (i.e. after all
      * exceptions if there is no memory operand).  Exceptions are
      * vm86 checks (INTn, IRET, PUSHF/POPF), RSM and XSETBV (!).
      *
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 36127d99943..2e94e8ec56f 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1638,8 +1638,8 @@ static void gen_HLT(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
 #ifdef CONFIG_SYSTEM_ONLY
     gen_update_cc_op(s);
-    gen_update_eip_cur(s);
-    gen_helper_hlt(tcg_env, cur_insn_len_i32(s));
+    gen_update_eip_next(s);
+    gen_helper_hlt(tcg_env);
     s->base.is_jmp = DISAS_NORETURN;
 #endif
 }
-- 
2.45.1


