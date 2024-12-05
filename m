Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC59CE77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 11:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJA8F-0006kg-J3; Thu, 05 Dec 2024 06:34:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tJA83-0006cu-Jp
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 06:34:44 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tJA7z-0001Ux-QC
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 06:34:43 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-434a8640763so5644775e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 03:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733398478; x=1734003278;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oat7OCJWCfdBm5mhZDHTEYl/Lfob5ROZqf6G56QQQd4=;
 b=PJv49OBw3BXXXBqsbz6mawBPzdRmfYXTwRT3zsw1MTHA8AnaNF0uk83q0AdDUo9X4Y
 EzKYLUZ71TlnAbHA/v5hqOdDQbEQc3EI3HcoKodBFCN5hAe2S8cvUmBiqjnnIQmvwbEw
 OrwOOdFEhs+tX9NHzZ7yzuFkkW3RAKuknIko87waODIfB3N2skBJVP9G2Keago6A5xxU
 zbip6Wrmd9+w440S56o8Zs3nweP0rlm/eofVjbo3Yu7uMOaFLw4bSB18gJPsAJwqtIFE
 /gW/1sP666Dh/LXu2AJkLdUFk8qIMOA5qh+qUJR4ym5sKVlambQwfi/dMtHUqnFr6fZ6
 Wswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733398478; x=1734003278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oat7OCJWCfdBm5mhZDHTEYl/Lfob5ROZqf6G56QQQd4=;
 b=CcuGAa73RDcUdPODHJIqyjHfNE2e29QhSeQFi+bt0DKxgJLj5ADBgXYrv2RQEm2MA3
 U53d7c/1B6o55Mu1X855xWeGEkmhXfgT1BIJ5Toavl8J43ABdQTin9878Z6NQz9IU703
 YlZKbBhGst5aaz/FPKUq/lmRJxihH17IEvhcbiQ00VLwp+c+E2sI90gHC+/jfvT31BtH
 palBGlSdWenepnM3vTVt+7anIi2NLfy/bese70d1BU8mBTM64HHhbKwfQFb6AKJUffao
 /vbmyiNSlqMugvWAj3dFJ8weQ/+IJiY7RsaA0/rgvHPj/8AWA5WkH1wnyFUEKUFqtu8I
 y74g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZNafhq6KbTZIVGZpBC58WvY0XyTaPpQPWmQRVJSX4wdFxthrLlcATkANhCu/J2YJXExH+/fRZS8KS@nongnu.org
X-Gm-Message-State: AOJu0YyLYo4FwmTwOfeYep8DyCMGa565NDwDeCd4mPuAG6WwuUJqLcBH
 CpMnCNj54VZXbJUCQrz5gqMQoCm94huUlAkhlmExyfUqSNQ4xK49NZrfK98Pw+w=
X-Gm-Gg: ASbGncvcxuRHO1SVTGsxxXomr4heKDnS6Mi1tq+p3K+/0wbAhrRUehCtOcNSv9NMQUX
 QwE4TwjU1TA/sKE+jyF6WErWkSgnjsFx05fU9zpbZqbwm+z1bN+z3iIHTnv0Pw3WjRZCUFDaysG
 d2jOF9YGBJGJGH9eHoKSDCR1as0cuAJFKgSW/mmlaeGj7PsP8H+3KEy6YO3z7nBkCDF2HEkY5nO
 OlCBt5PKUsLmrQqQ4ZTixLUtYGPaSZ5K0lsWfsQN7Ei2/4yD3Oq7fRIYWHfjNKT+7i8n+IpE4v0
 i+W51Q==
X-Google-Smtp-Source: AGHT+IH8PagpTHJy+KiOQ9rmf9takuAZdL7TSJRMYxdAqy3J6fwwy9s2cjSNU6fJuvWkjFpZD3x1gw==
X-Received: by 2002:a05:600c:4f46:b0:42c:bae0:f05b with SMTP id
 5b1f17b1804b1-434d09b144cmr73368205e9.1.1733398478448; 
 Thu, 05 Dec 2024 03:34:38 -0800 (PST)
Received: from rkanwal-XPS-15-9520.ba.rivosinc.com ([137.59.223.84])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d527395csm57943255e9.17.2024.12.05.03.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 03:34:38 -0800 (PST)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, beeman@rivosinc.com,
 jason.chien@sifive.com, frank.chang@sifive.com,
 richard.henderson@linaro.org
Subject: [PATCH v5 5/7] target/riscv: Add CTR sctrclr instruction.
Date: Thu,  5 Dec 2024 16:34:10 +0500
Message-Id: <20241205-b4-ctr_upstream_v3-v5-5-60b993aa567d@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205-b4-ctr_upstream_v3-v5-0-60b993aa567d@rivosinc.com>
References: <20241205-b4-ctr_upstream_v3-v5-0-60b993aa567d@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

CTR extension adds a new instruction sctrclr to quickly
clear the recorded entries buffer.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 target/riscv/cpu.h                             |  1 +
 target/riscv/cpu_helper.c                      |  7 +++++++
 target/riscv/helper.h                          |  1 +
 target/riscv/insn32.decode                     |  1 +
 target/riscv/insn_trans/trans_privileged.c.inc | 11 ++++++++++
 target/riscv/op_helper.c                       | 29 ++++++++++++++++++++++++++
 6 files changed, 50 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f39ca48d37332c4e5907ca87040de420f78df2e4..85ca2bfe435d0c9d245f2690fe3bde3e076d3b2f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -613,6 +613,7 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en);
 
 void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
     enum CTRType type, target_ulong prev_priv, bool prev_virt);
+void riscv_ctr_clear(CPURISCVState *env);
 
 void riscv_translate_init(void);
 G_NORETURN void riscv_raise_exception(CPURISCVState *env,
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index dbdad4e29d7de0713f7530c46e9fab03d3c459a4..b1130180710b0e01e8ebe33f0974edd8d5abe56d 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -783,6 +783,13 @@ static void riscv_ctr_freeze(CPURISCVState *env, uint64_t freeze_mask,
     }
 }
 
+void riscv_ctr_clear(CPURISCVState *env)
+{
+    memset(env->ctr_src, 0x0, sizeof(env->ctr_src));
+    memset(env->ctr_dst, 0x0, sizeof(env->ctr_dst));
+    memset(env->ctr_data, 0x0, sizeof(env->ctr_data));
+}
+
 static uint64_t riscv_ctr_priv_to_mask(target_ulong priv, bool virt)
 {
     switch (priv) {
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 820ddccf92ab07cbe80ae03b3d2d2ccc4f8e4765..011ee628f81333e30cfa7a375788e546965e4b30 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -131,6 +131,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(sret, tl, env)
 DEF_HELPER_1(mret, tl, env)
+DEF_HELPER_1(ctr_clear, void, env)
 DEF_HELPER_1(wfi, void, env)
 DEF_HELPER_1(wrs_nto, void, env)
 DEF_HELPER_1(tlb_flush, void, env)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index a2b4c0ddd47ad9464b4b180fb19e6a3b64dbe4e5..8188113bcc90482733f676227858829bac5c5462 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -114,6 +114,7 @@
 # *** Privileged Instructions ***
 ecall       000000000000     00000 000 00000 1110011
 ebreak      000000000001     00000 000 00000 1110011
+sctrclr     000100000100     00000 000 00000 1110011
 uret        0000000    00010 00000 000 00000 1110011
 sret        0001000    00010 00000 000 00000 1110011
 mret        0011000    00010 00000 000 00000 1110011
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index b19d692c22dc74c41df72dae99448c37a0216980..a67088d25bade5cb3be62647e411045894bffe33 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -69,6 +69,17 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
     return true;
 }
 
+static bool trans_sctrclr(DisasContext *ctx, arg_sctrclr *a)
+{
+#ifndef CONFIG_USER_ONLY
+    if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
+        gen_helper_ctr_clear(tcg_env);
+        return true;
+    }
+#endif
+    return false;
+}
+
 static bool trans_uret(DisasContext *ctx, arg_uret *a)
 {
     return false;
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 0684a27bfdb72f6fc5945f30500c2e3a95e85e2f..e7301ee8ca2e3145396a274126e591921b6d9e01 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -389,6 +389,35 @@ void helper_ctr_add_entry(CPURISCVState *env, target_ulong src,
                         env->priv, env->virt_enabled);
 }
 
+void helper_ctr_clear(CPURISCVState *env)
+{
+    /*
+     * It's safe to call smstateen_acc_ok() for umode access regardless of the
+     * state of bit 54 (CTR bit in case of m/hstateen) of sstateen. If the bit
+     * is zero, smstateen_acc_ok() will return the correct exception code and
+     * if it's one, smstateen_acc_ok() will return RISCV_EXCP_NONE. In that
+     * scenario the U-mode check below will handle that case.
+     */
+    RISCVException ret = smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);
+    if (ret != RISCV_EXCP_NONE) {
+        riscv_raise_exception(env, ret, GETPC());
+    }
+
+    if (env->priv == PRV_U) {
+        /*
+         * One corner case is when sctrclr is executed from VU-mode and
+         * mstateen.CTR = 0, in which case we are supposed to raise
+         * RISCV_EXCP_ILLEGAL_INST. This case is already handled in
+         * smstateen_acc_ok().
+         */
+        uint32_t excep = env->virt_enabled ? RISCV_EXCP_VIRT_INSTRUCTION_FAULT :
+            RISCV_EXCP_ILLEGAL_INST;
+        riscv_raise_exception(env, excep, GETPC());
+    }
+
+    riscv_ctr_clear(env);
+}
+
 void helper_wfi(CPURISCVState *env)
 {
     CPUState *cs = env_cpu(env);

-- 
2.34.1


