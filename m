Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20789C35FFF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 08:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvXSL-0008T8-Pm; Fri, 21 Mar 2025 04:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vliaskovitis@suse.com>)
 id 1tvXSI-0008PY-VU
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 04:10:15 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vliaskovitis@suse.com>)
 id 1tvXSG-0005nH-F8
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 04:10:14 -0400
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-3913958ebf2so1403720f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 01:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742544610; x=1743149410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cszmWm/scp7ymBE//ORDeeEGF35DrulxR1YbGtE14nI=;
 b=TiuLfdc+r4XI5eDhIH0surSI3rdQCNmu2BwRi/GPf7yYaqW/GHIB9Ve+rsyzrryPXv
 msgvwFJs5Au+a1d2CyYCPXaJEKO5nQaACtqpIhB/SfZ4PdeVIRQDcQg1dQcPULiloFGX
 5jgozIcWLXFBlOMp7UJYJ5JtqNgu16ga2EBB1WCwU+XuGVzhgl8IDd/kjFa7EDn6Yef0
 4o806dv+p/mBf2D8kVaOqRG1akURJlFhH1BlP/r67jT1QRrKVgTVDOi+tEGHmOlF4V7Z
 fzNgwNxCFM4M9T1uCdvURli8FkTfO2REOTdVDjw2pFXD73MFFYTPdV+Wk3INjGhffLm0
 SKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742544610; x=1743149410;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cszmWm/scp7ymBE//ORDeeEGF35DrulxR1YbGtE14nI=;
 b=L+dC4lcZ/sZPr3Rmk8grO+zJVl6E3fkrwWh9opW3FHqxPuXFQqyxRshwZgeXl72iaE
 oL/JZJpeFZnPGiS5tmEnCIHQkuGRY7gMXHt+Hgwiox2d8+C3E+nGUSgx9UUmj8an2XF6
 n5X4DVckBboZDf/uMw9GWzr0dIibZ5Li7WjpegZsEC1xc8dxWOONL3Hv8S1L4i9IAF4R
 GWVCfaidi1/hiy6YTLOVtEtisDPhwHYaasPnWOYjGLNtBQWLzt2b3Da5wshI0sFjX/db
 WlD0x/NZ8zKkWo5QCQCtb7O8sJ0EGfhTkkyqIIa42atb04ho2q0r4xcmabxSVVQ+bnJY
 yjKQ==
X-Gm-Message-State: AOJu0YwrOAe2om8jjLNoP4UJvfO41m3fZfv8+86d1fw98kQWFBSuGrm5
 v+xhf7s3pmzjfJuSSpr4N28icH+N6rkfL35Non8sZReOnMOsAeKBBbypOldYametEiJg6m9x7o6
 P3b80ow==
X-Gm-Gg: ASbGncvCj4TMoBcezwTXgwWU7cgYM/syW2GCZ0SdK7t4clwkBLvP19sQ0bJwBv2EnwH
 TNm1X5NcP/5sYV61dDPzJuWehZa7YgEeEPLszH4xPsa7TqRHazQqeXTFGNEcomwoLY8pLvUsanb
 cEPMGlDpjGGv+F5A24dLF7/KXU498TIgf89zbWu1H0L5IAbnVf13aeAcDQBRF/3lCQMNEJZUhmd
 cekbOJH+eh4qKeRzIAnUylm3GLkSgEJqVFA0haRjNuQie556b/wW+BdZrSK5cT3QG3x6Q0dIOO4
 r2nbmS219P1mB1mgknGJlZ7NaYjaTROgxAFOI6yYpUMC
X-Google-Smtp-Source: AGHT+IHmQkFUdmmXzdl5tSVLCyEEcoAZQBwBXAsE5GO0iCxben+XH52HtoAFUW4bdHQXldJn+MmVeQ==
X-Received: by 2002:a05:6000:1f87:b0:391:2ba9:4c59 with SMTP id
 ffacd0b85a97d-3997f93988amr2196992f8f.43.1742544609742; 
 Fri, 21 Mar 2025 01:10:09 -0700 (PDT)
Received: from localhost ([149.107.36.212])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3997f9e674fsm1641760f8f.80.2025.03.21.01.10.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 01:10:09 -0700 (PDT)
From: Vasilis Liaskovitis <vliaskovitis@suse.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: alistair.francis@wdc.com, ajones@ventanamicro.com, liu@linux.alibaba.com,
 philmd@linaro.org, Vasilis Liaskovitis <vliaskovitis@suse.com>
Subject: [RFC PATCH] target/riscv: set vill bit if VLMAX is changed when
 vsetvli rs1 and rd arguments are x0
Date: Fri, 21 Mar 2025 09:10:06 +0100
Message-ID: <20250321081006.7041-1-vliaskovitis@suse.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=vliaskovitis@suse.com; helo=mail-wr1-x442.google.com
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

Also set the vill bit if vill was 1 beforehand.

See https://github.com/riscv/riscv-isa-manual/blob/main/src/v-st-ext.adoc#avl-encoding
According to the spec, the above use cases are reserved, and
"Implementations may set vill in either case."

There is probably a more elegant way to handle this.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2422
Signed-off-by: Vasilis Liaskovitis <vliaskovitis@suse.com>
---
 target/riscv/helper.h                   | 2 +-
 target/riscv/insn_trans/trans_rvv.c.inc | 4 ++--
 target/riscv/vector_helper.c            | 9 ++++++++-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 85d73e492d..f712b1c368 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -159,7 +159,7 @@ DEF_HELPER_FLAGS_3(hyp_hsv_d, TCG_CALL_NO_WG, void, env, tl, tl)
 #endif
 
 /* Vector functions */
-DEF_HELPER_3(vsetvl, tl, env, tl, tl)
+DEF_HELPER_4(vsetvl, tl, env, tl, tl, tl)
 DEF_HELPER_5(vle8_v, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vle16_v, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vle32_v, void, ptr, ptr, tl, env, i32)
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index b9883a5d32..29428ed221 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -179,7 +179,7 @@ static bool do_vsetvl(DisasContext *s, int rd, int rs1, TCGv s2)
         s1 = get_gpr(s, rs1, EXT_ZERO);
     }
 
-    gen_helper_vsetvl(dst, tcg_env, s1, s2);
+    gen_helper_vsetvl(dst, tcg_env, s1, s2, tcg_constant_tl((int) (rd == 0 && rs1 == 0)));
     gen_set_gpr(s, rd, dst);
     finalize_rvv_inst(s);
 
@@ -199,7 +199,7 @@ static bool do_vsetivli(DisasContext *s, int rd, TCGv s1, TCGv s2)
 
     dst = dest_gpr(s, rd);
 
-    gen_helper_vsetvl(dst, tcg_env, s1, s2);
+    gen_helper_vsetvl(dst, tcg_env, s1, s2, tcg_constant_tl(0));
     gen_set_gpr(s, rd, dst);
     finalize_rvv_inst(s);
     gen_update_pc(s, s->cur_insn_len);
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 7773df6a7c..b2302ba2b0 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -32,7 +32,7 @@
 #include <math.h>
 
 target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
-                            target_ulong s2)
+                            target_ulong s2, target_ulong immutable)
 {
     int vlmax, vl;
     RISCVCPU *cpu = env_archcpu(env);
@@ -80,6 +80,13 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     } else {
         vl = vlmax;
     }
+    if (immutable && (env->vl != vl || env->vill)) {
+        /* only set vill bit and vtype, not vl. */
+        env->vill = 1;
+        env->vtype = s2;
+        env->vstart = 0;
+        return 0;
+    }
     env->vl = vl;
     env->vtype = s2;
     env->vstart = 0;
-- 
2.46.0


