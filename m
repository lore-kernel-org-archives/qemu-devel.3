Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BE4E87821
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 12:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnFxO-0004bJ-Ha; Tue, 03 Feb 2026 07:56:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vnFxL-0004ZF-BP
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:56:35 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vnFxH-0003xW-Rq
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:56:35 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-81f47610542so3167541b3a.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 04:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770123390; x=1770728190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lcK80jG/X5VuM79ngQBj6iyhfGVjrts3Z8T+AQD0IgY=;
 b=J1nVm5SjJNfPiVQnZ/P/ZIu3BmoL7/92DLRKYXIs2aMeQWPlmu9GVtik/60zkaNxi8
 ksXAJHwpLtIQYPSA5YSoDkmAZ6PJQ0nww+39tmHgQXJuCLJnkuq1mu2use4KVvb2ObuV
 w0PFABbmHjER5uSaXsevFr+xiTnhLmzXMr2I+9h8Rc0S7HLxqRPDyxjBcC0osTxDf8Ef
 I+7NVIMNYIySdBJ48ruiGS2fYdI5NMhlk2SosK2weI05muBP40J8hDmeZsGFPfei6Za6
 S2LMuXz3viIquAT7Q8LDVnHWxPNCzAp5QUcc4lB8Z1aZuG92Nr8IR/2sh1gZUosHFDz9
 FGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770123390; x=1770728190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lcK80jG/X5VuM79ngQBj6iyhfGVjrts3Z8T+AQD0IgY=;
 b=KksrKJ3IIcFLlIs01Pf1d0B+50HIbpg+ik640eHVjpb1HQe1Sv2ObRnGl4C6/RpyDn
 YSK71Pk5XlRKuIBcmwggl6pmQxNYVigqDLww6P1GkNX+5kKC93caSuYPQJFM7sZ0yKTR
 2NmdK1PHkq4INu43UBUSFFgqNXGy0/dKmYlHn2SquLfTtW+sGyVAGRQJ5KEfWkjNl2Gg
 bBptAIFYXrL4AQ6RubHNyJSNCiZWn9nAgRASBv/h1MsNzsX+/kzGK3yY2NeyfQCdCOmo
 hJizqC1g5InJl/vdhieDP6wQ7mrtoNHco79Yg2h8qVTjVYN5iH2TzgrKvv7yieX5H5ER
 Jijw==
X-Gm-Message-State: AOJu0YxzYCrouCMQM98U4jbSqPhFaGdBuivzvo+Fi3K8L4HlfjCN4phP
 4mznRgz4o1W5WiGKL8l+r6jOgFMELwWBXG8nJfzIrNRo9SAeUkQSBHDg
X-Gm-Gg: AZuq6aKV/mgWWqHthB6seMOnaOMkMCgnxNSzTKdAxjX/U7FJIyOp+gLTkskomRfziIS
 5+z8MRe1eckOmWm3tv/z0bvDFC7sGDCebGrb9RIDjuGFkTDdICQBBNcW/LhjLt29njViueJr3n9
 ncj7sobXTp/D/xG4VdAji+yho72uhiVlJUM9oiusNWDUdg6rMGlGQSb58vg2oyoXf0PcyRlVc9+
 OAGymNjdu/7MUCCoSaNz0RzB+YrprU8QF5Oout1+/IeK3272S6XbyPrt2FvbBh2lcG49Ar58brE
 seKjiNz3Kned3/AydTxHtMoGLafFijv/5xP27QGlIsfqGl+9Uug75ruz0fdIBcN1XuPya3T5cb0
 c4iQMJnabhYgPmgpjUX4wlD+rhEaTMK2VlMgBzqWURPseJj1dldSW2X1qfZiPrYYl0h0w4TjntF
 04NgqQ7GPX49yIl4prPj3xS8ms0Xfyx/gSRu/wrZQSmhpz+RK4DNebZ8pl
X-Received: by 2002:a05:6a21:8982:b0:393:8fc:529d with SMTP id
 adf61e73a8af0-39308fc8335mr7893192637.73.1770123390349; 
 Tue, 03 Feb 2026 04:56:30 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([183.195.22.5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c642aaf1308sm18214796a12.30.2026.02.03.04.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 04:56:29 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com, devel@lists.libvirt.org,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [RFC PATCH v5 5/7] target/riscv: add sdext enter Debug Mode on ebreak
Date: Tue,  3 Feb 2026 20:56:04 +0800
Message-ID: <51568c0052c65c37d2903c6fe32098356de217ec.1770104280.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1770104280.git.chao.liu.zevorn@gmail.com>
References: <cover.1770104280.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pf1-x442.google.com
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

RISC-V Debug Specification:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

Route EBREAK via helper_sdext_ebreak. If Sdext is enabled and the
matching dcsr.ebreak* bit is set, enter Debug Mode with cause=ebreak
and stop with EXCP_DEBUG. Otherwise keep the normal breakpoint trap.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/helper.h                         |  1 +
 .../riscv/insn_trans/trans_privileged.c.inc   |  6 ++++
 target/riscv/op_helper.c                      | 34 +++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 6140b6340d..acff73051b 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -141,6 +141,7 @@ DEF_HELPER_1(tlb_flush_all, void, env)
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
index 99736bbebb..b6417b4b0b 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -470,6 +470,40 @@ target_ulong helper_dret(CPURISCVState *env)
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


