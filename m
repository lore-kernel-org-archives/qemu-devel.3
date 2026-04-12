Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683AAF3ED67
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 02:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBkS7-0004FP-PN; Sat, 11 Apr 2026 22:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wBkS6-0004F7-NC
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 22:21:34 -0400
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wBkS3-00006i-8q
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 22:21:34 -0400
Received: by mail-qv1-xf43.google.com with SMTP id
 6a1803df08f44-8a05c388b27so52959136d6.3
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 19:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775960490; x=1776565290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FdBL5bIRSTgxNZUleWGlM4V/8XxdsxNqxbGWbaqEPcw=;
 b=AcVIGl+C5T39M+GJ7hHVAfQ9yLufeOgOfTEjSXIfkYieoEKITpu/LETPBDK5Bu1BWp
 O625shArxw1wQGH0EyiAJ+l9SPG/z4CEOkgyMwGzUL515DMbvtpo7b0+/oP0+5dmp44s
 lvYTTj9XmmJnILFj2fFxT07oSTOCS9v5DQdSIPDwccnJ4lsNj9QV6wzPdgEhCtRfk/MN
 f5Ig3On3klk8hGqvwNUBdUlwaN5ngMPo7T9Cq4JXJbUYtc3Odus6j5mXKz2SfjFUKI3r
 7vOI93WyOsGLru/rp5SrhtQv+Fn1oaL4ZzuP1230SoxgpXP8RWoOuFKV/fo3AG4nXkKd
 0wBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775960490; x=1776565290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FdBL5bIRSTgxNZUleWGlM4V/8XxdsxNqxbGWbaqEPcw=;
 b=P4OHCE1dw2BteuFzr1DjDP8HeTCZnaU9m/6LIFtIsomt7CyXfDupqiHx3ksbvHNpCF
 kiwLzvmQBq+Mqbz5owKGkrG6s1YM/Rb14xo5qDx4hQvZsuCNTIJtMP60o7tYJTP+tjKJ
 R0W8lFhhuNUKQshKbxX4+uCstFbAdzdsGvN5y3EguIylIMzL0Ci7goLHIHABoe4X4BlR
 9gQN45UDUbilbpqD+VFxCOpbOSRzWzoMUp9jYWyQeEJMFKqQimzCK3e34CjxbPCruht0
 n/449OQsd8hdtSTzkE9nLmcEF4h76tgshaocVzNhAT9W2nIPiC5XmxdbKRQh9HTt63p6
 vc3w==
X-Gm-Message-State: AOJu0Yyr3pbjABHr94L2JpCgtQ7XjT4qBq50sTH9f66LnMokUoxbxmMC
 q+XLRmr3gEy/3isKSWjGPerxiMsv9NnJ1rBIz6fWq1XCrZOGyb2lsXpU
X-Gm-Gg: AeBDiev0podVrd/i8SSeGiiCjZWeiNWzxSgZY0OElpbSizwgho5QzIk0XN/+5D5c3La
 qICR2mkU9It0mH6pfFrsOgcrlOvfWHBYI0bcM2gB9lhdc8OwO9b6JLbkXJU1h5dRfjmnGXLXfjb
 aPs7IizaxGddei9+nWrLkGRLUlEgbLqr+kfTXldlBlaqgRNMti6g8abq/lItY7VI9NcTxNcFUrZ
 TCvPddIlpP9mcBVgDI/DncaRvi4IpYZD3oTVSbIJS1UbV+3tyZBI0XRcy/RJC1/BPxCZ0AmOqyg
 xZS+S2yh61tZNK9pUyjvrMn/2791x3MsuHBXhfBBbEke0Aw7g2ZNVjCd2KdNg5SPoBJDdS5Nh4q
 yHoZwqADx31RaTTQYXhohz267sW6EMLNmbGIpjdcG5qzkkVPPDmMTiDW6atCTjGegB2xn9wHSvc
 EE9p+TocjFlnn+Z5dZC8naVTRc54yBVEtXILXxgHnYWhFAhsS9GrN3GBJUduohqQKi81XnQXJ7l
 /AF2Jc=
X-Received: by 2002:a05:6214:cc8:b0:8a1:fb3:5a37 with SMTP id
 6a1803df08f44-8ac86160012mr143676646d6.9.1775960490342; 
 Sat, 11 Apr 2026 19:21:30 -0700 (PDT)
Received: from ZEVORN-PC.bbrouter ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8aca05592ecsm15455576d6.29.2026.04.11.19.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 19:21:30 -0700 (PDT)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Cc: qemu-devel@nongnu.org, tangtao1634@phytium.com.cn, devel@lists.libvirt.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v6 5/7] target/riscv: add sdext enter Debug Mode on ebreak
Date: Sun, 12 Apr 2026 10:20:22 +0800
Message-ID: <f257db26a7123c201917bf657d1d147e7cc63965.1775959096.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775959096.git.chao.liu.zevorn@gmail.com>
References: <cover.1775959096.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f43;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qv1-xf43.google.com
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

RISC-V Debug Specification:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

Route EBREAK via helper_sdext_ebreak. If Sdext is enabled and the
matching dcsr.ebreak* bit is set, enter Debug Mode with cause=ebreak
and stop with EXCP_DEBUG. Otherwise keep the normal breakpoint trap.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 target/riscv/helper.h                         |  1 +
 .../riscv/insn_trans/trans_privileged.c.inc   |  6 ++++
 target/riscv/op_helper.c                      | 34 +++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index c8e76eb116..9538e816f0 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -143,6 +143,7 @@ DEF_HELPER_1(tlb_flush_all, void, env)
 DEF_HELPER_4(ctr_add_entry, void, env, tl, tl, tl)
 /* Native Debug */
 DEF_HELPER_1(itrigger_match, void, env)
+DEF_HELPER_2(sdext_ebreak, void, env, tl)
 #endif
 
 /* Hypervisor functions */
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index f8641b1977..84f0c77513 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -68,9 +68,15 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
     if (pre == 0x01f01013 && ebreak == 0x00100073 && post == 0x40705013) {
         generate_exception(ctx, RISCV_EXCP_SEMIHOST);
     } else {
+#ifndef CONFIG_USER_ONLY
+        gen_update_pc(ctx, 0);
+        gen_helper_sdext_ebreak(tcg_env, tcg_constant_tl(ebreak_addr));
+        ctx->base.is_jmp = DISAS_NORETURN;
+#else
         tcg_gen_st_tl(tcg_constant_tl(ebreak_addr), tcg_env,
                       offsetof(CPURISCVState, badaddr));
         generate_exception(ctx, RISCV_EXCP_BREAKPOINT);
+#endif
     }
     return true;
 }
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index ce68ee5959..58d47b88c1 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -456,6 +456,40 @@ target_ulong helper_dret(CPURISCVState *env)
 #endif
 }
 
+void helper_sdext_ebreak(CPURISCVState *env, target_ulong pc)
+{
+    CPUState *cs = env_cpu(env);
+    bool enter_debug = false;
+
+    if (riscv_cpu_cfg(env)->ext_sdext && !env->debug_mode) {
+        if (env->virt_enabled) {
+            if (env->priv == PRV_S) {
+                enter_debug = env->dcsr & DCSR_EBREAKVS;
+            } else if (env->priv == PRV_U) {
+                enter_debug = env->dcsr & DCSR_EBREAKVU;
+            }
+        } else {
+            if (env->priv == PRV_M) {
+                enter_debug = env->dcsr & DCSR_EBREAKM;
+            } else if (env->priv == PRV_S) {
+                enter_debug = env->dcsr & DCSR_EBREAKS;
+            } else if (env->priv == PRV_U) {
+                enter_debug = env->dcsr & DCSR_EBREAKU;
+            }
+        }
+    }
+
+    env->badaddr = pc;
+
+    if (enter_debug) {
+        riscv_cpu_enter_debug_mode(env, pc, DCSR_CAUSE_EBREAK);
+        cs->exception_index = EXCP_DEBUG;
+        cpu_loop_exit_restore(cs, GETPC());
+    }
+
+    riscv_raise_exception(env, RISCV_EXCP_BREAKPOINT, GETPC());
+}
+
 target_ulong helper_mnret(CPURISCVState *env)
 {
     target_ulong retpc = env->mnepc;
-- 
2.53.0


