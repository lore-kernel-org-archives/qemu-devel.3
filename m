Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92F9C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeOc-00085F-0J; Fri, 04 Jul 2025 07:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeND-0005M5-UU
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:14:35 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeNB-0004S3-I2
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:14:31 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-23c8a5053c2so2285455ad.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627668; x=1752232468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6LeQAAogdZ6utUWU8uZD20yEC9hkJc37e9nimWKPLx0=;
 b=kCJfBjNaW7DnUcznVJSlyQ1k7U6JLfuSVxo6vamiPtPybEH/KKKFAu3ZznGW/CtQev
 kx7agtkEUdH/ip2EV9O9LBEOiywhF8uhtnqDcP6RuHwOYogCHphdDlR6lXeL2taJvTgy
 M0zW3nuN11C0qvoYx66+FUeuuebCrwKCNnQ5w6+Q2ihreB7LGrxqqUpKePTtu4sD7jzO
 UfgYPJIYITq1uk6iqL56PRNN8ywVq+Y7YqdUO0JxoH/noojp83yhPB2QM5nTJC9or/Gy
 UKgpSfemV0tXJwdiFfUQKVaALxgISqQUIW8yznwYrEf6AY2k1m1jRpgv7FYDS820MzJS
 8S5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627668; x=1752232468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6LeQAAogdZ6utUWU8uZD20yEC9hkJc37e9nimWKPLx0=;
 b=AvwbmgRlTqmOP39ezeVAHnOVStruneEvSELEf8O4s6gUCXULZ5oS4+RWVd80OI2E43
 fk+gUIol0E59xmiuBA6spLSkDrqyQDgA6fiK9hRIqKkYR5mryvlIfATkKoDbfuBR7jBk
 wac/1mJV5xD3Fnt/IKhXyEea6gLbiv2N59LzWmUOVFn2zJXOlIOamOOP5k+lVI+TpEoA
 YMvdi12egre+n9L/2zuVJNs2opooHjFLCWAFUcZx/S2tR7P1WJ2201J0IRqE7FqPj+xG
 JiksM50+ICblnSGaAdNAYkgEHzuOyf8kZi1ey45whFmzW9fnhZKTjCukq3MyxM1NdAW7
 LmqQ==
X-Gm-Message-State: AOJu0YwnItwhCGEfaFhBvmh9fGuWatx2PRJXtcO40XLj8ZlMKUAVZ8bG
 kE0Q6EyHkVBTawhrpfdNDZAefgXWuQ8S7Qp57sNfjhOzM68W8OERZrThOdwBXw==
X-Gm-Gg: ASbGnctY1gJIBRIHzp8xSDwvXKKNkpqtle+Qnf5kyPkNvpKlASlghzNyGd2o/Ne++tb
 7VM2oie0cUwgisokZR31M6NAQOiI0MaGuHxzARmUFlzGyukmv3fMXPBJNxC+Er/Lp5/zVNb/hkF
 /tozxDkCEzHzJZrWJhZCDFB7wSi7HYc2O3ggCQQGflZWgo0stebzfkD/i69Lb9pwEk4zrls7gnh
 LNN95faUgeRZI31BFSCq2x+/57UZk6q0MiLqVyUzlLaAuVp574TfT5AKVfjMvJKBtjpGEBPLJ0I
 zneylRjYdG4aMA7akILDtlGqjdXYDdRf/FYRuzI76XdXaWVC6Rbw+k/ArX6Lj2I2qzeybt7IZ4s
 FzXFuAypUn5o1+j+nSyfDB75vTWBM9nUvkn0YNOyrMDwxgZw2vVaLhKyIrDShs1VBwS4=
X-Google-Smtp-Source: AGHT+IHgIhtJkgUSheu5mR9p8B+GF/abC0ifNtVn4z7tskl9K2HaIPavnUbm7fdqKF38JOIL65FrIA==
X-Received: by 2002:a17:903:faf:b0:236:9726:7264 with SMTP id
 d9443c01a7336-23c8609c053mr38721285ad.5.1751627667985; 
 Fri, 04 Jul 2025 04:14:27 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:14:27 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Vasilis Liaskovitis <vliaskovitis@suse.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 39/40] target/riscv: Add a property to set vill bit on reserved
 usage of vsetvli instruction
Date: Fri,  4 Jul 2025 21:12:06 +1000
Message-ID: <20250704111207.591994-40-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Vasilis Liaskovitis <vliaskovitis@suse.com>

Usage of vsetvli instruction is reserved if VLMAX is changed when vsetvli rs1
and rd arguments are x0.

In this case, if the new property is true, only the vill bit will be set.

See https://github.com/riscv/riscv-isa-manual/blob/main/src/v-st-ext.adoc#avl-encoding
According to the spec, the above use cases are reserved, and
"Implementations may set vill in either case."

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2422
Signed-off-by: Vasilis Liaskovitis <vliaskovitis@suse.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250618213542.22873-1-vliaskovitis@suse.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   |  2 +-
 target/riscv/cpu_cfg_fields.h.inc       |  1 +
 target/riscv/cpu.c                      |  1 +
 target/riscv/vector_helper.c            | 12 +++++++++++-
 target/riscv/insn_trans/trans_rvv.c.inc |  4 ++--
 5 files changed, 16 insertions(+), 4 deletions(-)

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
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 33c4f9bac8..98ceb7b340 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -114,6 +114,7 @@ BOOL_FIELD(ext_supm)
 BOOL_FIELD(rvv_ta_all_1s)
 BOOL_FIELD(rvv_ma_all_1s)
 BOOL_FIELD(rvv_vl_half_avl)
+BOOL_FIELD(rvv_vsetvl_x0_vill)
 /* Named features  */
 BOOL_FIELD(ext_svade)
 BOOL_FIELD(ext_zic64b)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e3f8ecef68..6f1d0618f1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2632,6 +2632,7 @@ static const Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("rvv_ta_all_1s", RISCVCPU, cfg.rvv_ta_all_1s, false),
     DEFINE_PROP_BOOL("rvv_ma_all_1s", RISCVCPU, cfg.rvv_ma_all_1s, false),
     DEFINE_PROP_BOOL("rvv_vl_half_avl", RISCVCPU, cfg.rvv_vl_half_avl, false),
+    DEFINE_PROP_BOOL("rvv_vsetvl_x0_vill", RISCVCPU, cfg.rvv_vsetvl_x0_vill, false),
 
     /*
      * write_misa() is marked as experimental for now so mark
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 5dc1c10012..b41c29da0b 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -35,7 +35,7 @@
 #include <math.h>
 
 target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
-                            target_ulong s2)
+                            target_ulong s2, target_ulong x0)
 {
     int vlmax, vl;
     RISCVCPU *cpu = env_archcpu(env);
@@ -83,6 +83,16 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     } else {
         vl = vlmax;
     }
+
+    if (cpu->cfg.rvv_vsetvl_x0_vill && x0 && (env->vl != vl)) {
+        /* only set vill bit. */
+        env->vill = 1;
+        env->vtype = 0;
+        env->vl = 0;
+        env->vstart = 0;
+        return 0;
+    }
+
     env->vl = vl;
     env->vtype = s2;
     env->vstart = 0;
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 4cd030c7eb..610bf9ff30 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -202,7 +202,7 @@ static bool do_vsetvl(DisasContext *s, int rd, int rs1, TCGv s2)
         s1 = get_gpr(s, rs1, EXT_ZERO);
     }
 
-    gen_helper_vsetvl(dst, tcg_env, s1, s2);
+    gen_helper_vsetvl(dst, tcg_env, s1, s2, tcg_constant_tl((int) (rd == 0 && rs1 == 0)));
     gen_set_gpr(s, rd, dst);
     finalize_rvv_inst(s);
 
@@ -222,7 +222,7 @@ static bool do_vsetivli(DisasContext *s, int rd, TCGv s1, TCGv s2)
 
     dst = dest_gpr(s, rd);
 
-    gen_helper_vsetvl(dst, tcg_env, s1, s2);
+    gen_helper_vsetvl(dst, tcg_env, s1, s2, tcg_constant_tl(0));
     gen_set_gpr(s, rd, dst);
     finalize_rvv_inst(s);
     gen_update_pc(s, s->cur_insn_len);
-- 
2.50.0


