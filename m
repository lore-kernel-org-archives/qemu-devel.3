Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BFE107BCF2
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2oCa-0001vC-IN; Wed, 18 Mar 2026 06:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oCK-0001bN-8v
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:32:24 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oCI-0002RX-8a
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:32:19 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4856cd3f1ffso6008265e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773829936; x=1774434736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0F4+3o4I9l18fj/6/8RkkCyZU1iNgv6pX2nauez16PY=;
 b=Z4Rzlmr79GoTuvA2SgVsrVlTRO+EM+/gwLMbxIQT5kv+kpy2SdPCGKobGQutvwSC5a
 rBSfZ9meE5PiBYmO3U73q/YLE7npuea0mFeN1gOWXZ2X2e74xlhK+kowfscx5Jdxe9KN
 wzdLg6yhzPpAbvHEo21fj45sj6DD3LaLVP5Odz7WidSVYEK8rxq9JuxQB8+HnJ0GJVqh
 4j92+09PO388A6uhfKIF3JIG7lQjWdMdaTzDaGCaOcll1voQR0xp7yVtntFiDqOh0lg/
 RtpORhMgeP6IN8KUBpOFZhfmxd5hBtpj3AD0+UbB/eYrzfNb8lUBsdJLWsehNcUx1DPE
 313g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773829936; x=1774434736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0F4+3o4I9l18fj/6/8RkkCyZU1iNgv6pX2nauez16PY=;
 b=gimvmy1bH1v6Y/gbO2B+Lw86UJTIRDrvZjePMTAcRxGFIoV49ziUQDImxNZmA7eN+O
 wp19t2WKYe96E8L0vOSh6LjWLTmgUTvswJVlg7SIHr3T2NqZ3lDRjr6p5cg0z0FOjV0Q
 l2qYp/01i+uYQmiK2ri8Pk5o3aK0K2EDklto6c4mExcqyhmjNMqcNZzSaFtHzZN/2hkt
 r8n0G9D+bbgQXprG/Ks4KfazdnI7c8nTjHOsUtWT+wSqvtD81teH3s31axkN9lLCk7ZL
 HEElyEoZ6Wt7UzLjLyEqpJJ1NP7YM2d0Wo8QJzIl+A9r6dFq1YIlQUCN8vPr1k8atO2/
 +qQQ==
X-Gm-Message-State: AOJu0YzqFhoVj+sE9u4MPGMKv0wI2eo9EOo1OAzt34y7zZXrX6bClESa
 2cYstcmCJZo3yt9g5GBGW8C+PG4vkh3XAOatvbGSM0Y1s295iqZaXKkJcYgEHvZd5uEAB80whYM
 q4/iJKIA=
X-Gm-Gg: ATEYQzxKe2Vy+6P5YtAJR9hzPvz7woZNvoFRwqEuMqI/Z4R7WJhsUbJBEkZd/BU8yZz
 bxX+2Om4+nejs/xIUG42F+xfw2EuTaCtY+EE/XNf03VyL0tlGT8b47JdgpFjva0oojuJhdtuwzM
 4nIcZQeg0YyZUFznSBf0ALfPkLEu+OKECjEhqoWsf/OerO2pxCn3YdZ6K6bm408CbAZ/WV4PFv2
 +8QK+OtyeAzeIrUB4OEbfJsYAjgKseehNSnQZ20X9QKlmmWS6+0X6rwZwOLNE34Huu9pWkwCLFO
 z2XwGkPmi3DjpZLiJoW2CJ7nP7mtwNOZ8xn9kBu2vHxQ3QLSd2Cn8MXEgeaizhc75jd/d8+6sq7
 wgAcTdBIYOe1pA2UiTItaJMFahFlWfChthjjodp/a97hdCT1/evMwHgAqJuBguPBvbm8BmoRNjV
 KBwUypqGaGQCWVGqJY5RljGPQcdy+/YFAST28JY2ViHV1EU2ZSQQNL7BmUTl/bD4qoPZVVfufE
X-Received: by 2002:a05:600c:1d10:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-486f4421c84mr41737495e9.5.1773829936151; 
 Wed, 18 Mar 2026 03:32:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f5e1ab8esm12510945e9.35.2026.03.18.03.32.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Mar 2026 03:32:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>, 
 Vijai Kumar K <vijai@behindbytes.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH-for-11.1 07/16] target/riscv: Factor tiny ldn() helper in
 gdbstub
Date: Wed, 18 Mar 2026 11:31:12 +0100
Message-ID: <20260318103122.97244-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318103122.97244-1-philmd@linaro.org>
References: <20260318103122.97244-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

In preparation of having this helper handle CPU runtime
endianness changes, factor the ldn() helper out.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/gdbstub.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 6a5b7a82fd4..be42566bcc8 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -47,6 +47,11 @@ static const struct TypeSize vec_lanes[] = {
     { "uint8", "bytes", 8, 'b' },
 };
 
+static uint64_t ldn(CPURISCVState *env, uint8_t *mem_buf, size_t regsz)
+{
+    return ldn_p(mem_buf, regsz);
+}
+
 int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
@@ -84,15 +89,15 @@ int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 
     switch (mcc->def->misa_mxl_max) {
     case MXL_RV32:
-        tmp = (int32_t)ldl_p(mem_buf);
+        tmp = (int32_t)ldn(env, mem_buf, 4);
         length = 4;
         break;
     case MXL_RV64:
     case MXL_RV128:
         if (env->xl < MXL_RV64) {
-            tmp = (int32_t)ldq_p(mem_buf);
+            tmp = (int32_t)ldn(env, mem_buf, 8);
         } else {
-            tmp = ldq_p(mem_buf);
+            tmp = ldn(env, mem_buf, 8);
         }
         length = 8;
         break;
@@ -130,7 +135,7 @@ static int riscv_gdb_set_fpu(CPUState *cs, uint8_t *mem_buf, int n)
     CPURISCVState *env = &cpu->env;
 
     if (n < 32) {
-        env->fpr[n] = ldq_p(mem_buf); /* always 64-bit */
+        env->fpr[n] = ldn(env, mem_buf, 8); /* always 64-bit */
         return sizeof(uint64_t);
     }
     return 0;
@@ -162,7 +167,7 @@ static int riscv_gdb_set_vector(CPUState *cs, uint8_t *mem_buf, int n)
     if (n < 32) {
         int i;
         for (i = 0; i < vlenb; i += 8) {
-            env->vreg[(n * vlenb + i) / 8] = ldq_p(mem_buf + i);
+            env->vreg[(n * vlenb + i) / 8] = ldn(env, mem_buf + i, 8);
         }
         return vlenb;
     }
@@ -194,7 +199,7 @@ static int riscv_gdb_set_csr(CPUState *cs, uint8_t *mem_buf, int n)
     const unsigned regsz = riscv_cpu_is_32bit(cpu) ? 4 : 8;
 
     if (n < CSR_TABLE_SIZE) {
-        uint64_t val = ldn_p(mem_buf, regsz);
+        uint64_t val = ldn(env, mem_buf, regsz);
         int result;
 
         result = riscv_csrrw_debug(env, n, NULL, val, -1);
@@ -230,8 +235,7 @@ static int riscv_gdb_set_virtual(CPUState *cs, uint8_t *mem_buf, int n)
         const unsigned regsz = riscv_cpu_is_32bit(cpu) ? 4 : 8;
 #ifndef CONFIG_USER_ONLY
         CPURISCVState *env = &cpu->env;
-
-        target_ulong new_priv = ldn_p(mem_buf, regsz) & 0x3;
+        uint64_t new_priv = ldn(env, mem_buf, regsz) & 0x3;
         bool new_virt = 0;
 
         if (new_priv == PRV_RESERVED) {
@@ -239,7 +243,7 @@ static int riscv_gdb_set_virtual(CPUState *cs, uint8_t *mem_buf, int n)
         }
 
         if (new_priv != PRV_M) {
-            new_virt = (ldn_p(mem_buf, regsz) & BIT(2)) >> 2;
+            new_virt = (ldn(env, mem_buf, regsz) & BIT(2)) >> 2;
         }
 
         if (riscv_has_ext(env, RVH) && new_virt != env->virt_enabled) {
-- 
2.53.0


