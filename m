Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AE2E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9XZ-0007Nv-JC; Fri, 13 Dec 2024 12:33:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Wy-0006ty-Ux
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:51 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Wt-0001TI-Jh
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:48 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361f65ca01so19204775e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111162; x=1734715962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EBSmh2JvbG3lqDA5UwswMxC5/gv97mG/gQWeUl8yalg=;
 b=IbWKLbsw0O6A9QUm+2nnQt7nsWDP3FeLh3u7pkX5zF72PohGtgrl43UXgHoRpPTqs5
 Gt6nVZNiisLMtgfGPETiWFiYUHNBwRFyQ0X9qF82TiHEUfOXjgGJNeNcgf05WHZzPwxG
 uvcw7pOJzkS9ZfX09SgaqNcy5ygA7fZohxflxKt/B/1KY/5ivtL5doXwyu7Gq+I6G6JA
 i1U154/ocGwwzQNx9moRTL4qkINX9u5saqzagF1G/14DX6oZ32C20FZQeirqfiADQs+T
 WArwOe8GM9orlTKvbaKvYeImMqpnvwaXkZotXpJyI+CtHbR+9vIMKPTlmY1zgkzBwAAC
 MIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111162; x=1734715962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EBSmh2JvbG3lqDA5UwswMxC5/gv97mG/gQWeUl8yalg=;
 b=f4iovKPxlSBbrJa+HHrGkAuWt0EPuQKsj61SWWYHBksCgfZYN/w1G2jETd7c1x61UV
 8jPEwm/4XbUjIu6HFaPQOsvcikgP92q57ieQl2XrPcpUGaNNbeJdOYtZszV/Wog5Wjn2
 XZg2VJXxXTBRHuACqmNf9/hJdzjYaGhRqC6TjtnddcL873kE9id1wQljg042CxX39+jZ
 k0jb4psQ7ufLzRuwBzBdYmS3b1xY1ZTM5Sfseal9e10u2ZQzMwOj+J82x0NHDpIdM5jU
 gFTD0FNZozVAGeolxoiTyI8ps0uNi1lGIltsHIgl+7gtdiTrhqmvkt87odB6bdbgw/x+
 4FpQ==
X-Gm-Message-State: AOJu0YycBWut5EHBXUjMoW6X9qFdo9x+MXgz2dO6ziqSfuVzHnwW993h
 WK3hwQiMzpAr4WV7ZzfhKDmhWVlAyn4AEBu3xb4yCZ51ba1WlO6mifXegQ9qmw9Mmt+KiyWlW3J
 u
X-Gm-Gg: ASbGnctSaGho1opuNeC2ra9wSg2USEablP2mK86KqdrlNfRhF/7n1aNoruVBjbWJY7N
 4tv0RpHMQ2Sv39MZ0CC+heQlzMx5CIhnVHZ33b/lhIgFp4on3qbpDA1rRV284Xh3q8tmQFFDK9X
 do0jbRPQoHqbOuy/KshGJv2LQeGs2k3qFFTWqs1VyfYUkxmEvpcN6ZeMXYTGzS9vzgnH8FkGziZ
 tYxia8ZdbODDATf5FSSaN8s3yBDHUNzaiv/D/Kls4B4O8zYLqncllfHcPaLig==
X-Google-Smtp-Source: AGHT+IG8h8JWVgM+trYAuzkU25Fqg575hILrHUkSBS4Mu5e+5R7gT7NedFiKRkJ9HaGxgc0J6JnB/w==
X-Received: by 2002:a05:600c:4f86:b0:434:f9ad:7238 with SMTP id
 5b1f17b1804b1-4362aa9de1bmr25038005e9.22.1734111161723; 
 Fri, 13 Dec 2024 09:32:41 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.32.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:32:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/85] target/arm: Convert PAC[ID]*, AUT[ID]* to decodetree
Date: Fri, 13 Dec 2024 17:31:13 +0000
Message-Id: <20241213173229.3308926-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

This includes PACIA, PACIZA, PACIB, PACIZB, PACDA, PACDZA, PACDB,
PACDZB, AUTIA, AUTIZA, AUTIB, AUTIZB, AUTDA, AUTDZA, AUTDB, AUTDZB.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  13 +++
 target/arm/tcg/translate-a64.c | 173 +++++++++------------------------
 2 files changed, 58 insertions(+), 128 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 410eaa9333a..9083ac4ac30 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -699,6 +699,19 @@ REV64           1 10 11010110 00000 000011 ..... .....  @rr
 CLZ             . 10 11010110 00000 000100 ..... .....  @rr_sf
 CLS             . 10 11010110 00000 000101 ..... .....  @rr_sf
 
+&pacaut         rd rn z
+@pacaut         . .. ........ ..... .. z:1 ... rn:5 rd:5  &pacaut
+
+PACIA           1 10 11010110 00001 00.000 ..... .....  @pacaut
+PACIB           1 10 11010110 00001 00.001 ..... .....  @pacaut
+PACDA           1 10 11010110 00001 00.010 ..... .....  @pacaut
+PACDB           1 10 11010110 00001 00.011 ..... .....  @pacaut
+
+AUTIA           1 10 11010110 00001 00.100 ..... .....  @pacaut
+AUTIB           1 10 11010110 00001 00.101 ..... .....  @pacaut
+AUTDA           1 10 11010110 00001 00.110 ..... .....  @pacaut
+AUTDB           1 10 11010110 00001 00.111 ..... .....  @pacaut
+
 # Logical (shifted reg)
 # Add/subtract (shifted reg)
 # Add/subtract (extended reg)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 552b45b4e25..852545dfcc2 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7764,6 +7764,35 @@ static void gen_cls32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
 TRANS(CLZ, gen_rr, a->rd, a->rn, a->sf ? gen_clz64 : gen_clz32)
 TRANS(CLS, gen_rr, a->rd, a->rn, a->sf ? tcg_gen_clrsb_i64 : gen_cls32)
 
+static bool gen_pacaut(DisasContext *s, arg_pacaut *a, NeonGenTwo64OpEnvFn fn)
+{
+    TCGv_i64 tcg_rd, tcg_rn;
+
+    if (a->z) {
+        if (a->rn != 31) {
+            return false;
+        }
+        tcg_rn = tcg_constant_i64(0);
+    } else {
+        tcg_rn = cpu_reg_sp(s, a->rn);
+    }
+    if (s->pauth_active) {
+        tcg_rd = cpu_reg(s, a->rd);
+        fn(tcg_rd, tcg_env, tcg_rd, tcg_rn);
+    }
+    return true;
+}
+
+TRANS_FEAT(PACIA, aa64_pauth, gen_pacaut, a, gen_helper_pacia)
+TRANS_FEAT(PACIB, aa64_pauth, gen_pacaut, a, gen_helper_pacib)
+TRANS_FEAT(PACDA, aa64_pauth, gen_pacaut, a, gen_helper_pacda)
+TRANS_FEAT(PACDB, aa64_pauth, gen_pacaut, a, gen_helper_pacdb)
+
+TRANS_FEAT(AUTIA, aa64_pauth, gen_pacaut, a, gen_helper_autia)
+TRANS_FEAT(AUTIB, aa64_pauth, gen_pacaut, a, gen_helper_autib)
+TRANS_FEAT(AUTDA, aa64_pauth, gen_pacaut, a, gen_helper_autda)
+TRANS_FEAT(AUTDB, aa64_pauth, gen_pacaut, a, gen_helper_autdb)
+
 /* Logical (shifted register)
  *   31  30 29 28       24 23   22 21  20  16 15    10 9    5 4    0
  * +----+-----+-----------+-------+---+------+--------+------+------+
@@ -8373,134 +8402,6 @@ static void disas_data_proc_1src(DisasContext *s, uint32_t insn)
 #define MAP(SF, O2, O1) ((SF) | (O1 << 1) | (O2 << 7))
 
     switch (MAP(sf, opcode2, opcode)) {
-    case MAP(1, 0x01, 0x00): /* PACIA */
-        if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_pacia(tcg_rd, tcg_env, tcg_rd, cpu_reg_sp(s, rn));
-        } else if (!dc_isar_feature(aa64_pauth, s)) {
-            goto do_unallocated;
-        }
-        break;
-    case MAP(1, 0x01, 0x01): /* PACIB */
-        if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_pacib(tcg_rd, tcg_env, tcg_rd, cpu_reg_sp(s, rn));
-        } else if (!dc_isar_feature(aa64_pauth, s)) {
-            goto do_unallocated;
-        }
-        break;
-    case MAP(1, 0x01, 0x02): /* PACDA */
-        if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_pacda(tcg_rd, tcg_env, tcg_rd, cpu_reg_sp(s, rn));
-        } else if (!dc_isar_feature(aa64_pauth, s)) {
-            goto do_unallocated;
-        }
-        break;
-    case MAP(1, 0x01, 0x03): /* PACDB */
-        if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_pacdb(tcg_rd, tcg_env, tcg_rd, cpu_reg_sp(s, rn));
-        } else if (!dc_isar_feature(aa64_pauth, s)) {
-            goto do_unallocated;
-        }
-        break;
-    case MAP(1, 0x01, 0x04): /* AUTIA */
-        if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_autia(tcg_rd, tcg_env, tcg_rd, cpu_reg_sp(s, rn));
-        } else if (!dc_isar_feature(aa64_pauth, s)) {
-            goto do_unallocated;
-        }
-        break;
-    case MAP(1, 0x01, 0x05): /* AUTIB */
-        if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_autib(tcg_rd, tcg_env, tcg_rd, cpu_reg_sp(s, rn));
-        } else if (!dc_isar_feature(aa64_pauth, s)) {
-            goto do_unallocated;
-        }
-        break;
-    case MAP(1, 0x01, 0x06): /* AUTDA */
-        if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_autda(tcg_rd, tcg_env, tcg_rd, cpu_reg_sp(s, rn));
-        } else if (!dc_isar_feature(aa64_pauth, s)) {
-            goto do_unallocated;
-        }
-        break;
-    case MAP(1, 0x01, 0x07): /* AUTDB */
-        if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_autdb(tcg_rd, tcg_env, tcg_rd, cpu_reg_sp(s, rn));
-        } else if (!dc_isar_feature(aa64_pauth, s)) {
-            goto do_unallocated;
-        }
-        break;
-    case MAP(1, 0x01, 0x08): /* PACIZA */
-        if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
-            goto do_unallocated;
-        } else if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_pacia(tcg_rd, tcg_env, tcg_rd, tcg_constant_i64(0));
-        }
-        break;
-    case MAP(1, 0x01, 0x09): /* PACIZB */
-        if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
-            goto do_unallocated;
-        } else if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_pacib(tcg_rd, tcg_env, tcg_rd, tcg_constant_i64(0));
-        }
-        break;
-    case MAP(1, 0x01, 0x0a): /* PACDZA */
-        if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
-            goto do_unallocated;
-        } else if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_pacda(tcg_rd, tcg_env, tcg_rd, tcg_constant_i64(0));
-        }
-        break;
-    case MAP(1, 0x01, 0x0b): /* PACDZB */
-        if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
-            goto do_unallocated;
-        } else if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_pacdb(tcg_rd, tcg_env, tcg_rd, tcg_constant_i64(0));
-        }
-        break;
-    case MAP(1, 0x01, 0x0c): /* AUTIZA */
-        if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
-            goto do_unallocated;
-        } else if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_autia(tcg_rd, tcg_env, tcg_rd, tcg_constant_i64(0));
-        }
-        break;
-    case MAP(1, 0x01, 0x0d): /* AUTIZB */
-        if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
-            goto do_unallocated;
-        } else if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_autib(tcg_rd, tcg_env, tcg_rd, tcg_constant_i64(0));
-        }
-        break;
-    case MAP(1, 0x01, 0x0e): /* AUTDZA */
-        if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
-            goto do_unallocated;
-        } else if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_autda(tcg_rd, tcg_env, tcg_rd, tcg_constant_i64(0));
-        }
-        break;
-    case MAP(1, 0x01, 0x0f): /* AUTDZB */
-        if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
-            goto do_unallocated;
-        } else if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_autdb(tcg_rd, tcg_env, tcg_rd, tcg_constant_i64(0));
-        }
-        break;
     case MAP(1, 0x01, 0x10): /* XPACI */
         if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
             goto do_unallocated;
@@ -8530,6 +8431,22 @@ static void disas_data_proc_1src(DisasContext *s, uint32_t insn)
     case MAP(1, 0x00, 0x04):
     case MAP(0, 0x00, 0x05): /* CLS */
     case MAP(1, 0x00, 0x05):
+    case MAP(1, 0x01, 0x00): /* PACIA */
+    case MAP(1, 0x01, 0x01): /* PACIB */
+    case MAP(1, 0x01, 0x02): /* PACDA */
+    case MAP(1, 0x01, 0x03): /* PACDB */
+    case MAP(1, 0x01, 0x04): /* AUTIA */
+    case MAP(1, 0x01, 0x05): /* AUTIB */
+    case MAP(1, 0x01, 0x06): /* AUTDA */
+    case MAP(1, 0x01, 0x07): /* AUTDB */
+    case MAP(1, 0x01, 0x08): /* PACIZA */
+    case MAP(1, 0x01, 0x09): /* PACIZB */
+    case MAP(1, 0x01, 0x0a): /* PACDZA */
+    case MAP(1, 0x01, 0x0b): /* PACDZB */
+    case MAP(1, 0x01, 0x0c): /* AUTIZA */
+    case MAP(1, 0x01, 0x0d): /* AUTIZB */
+    case MAP(1, 0x01, 0x0e): /* AUTDZA */
+    case MAP(1, 0x01, 0x0f): /* AUTDZB */
         unallocated_encoding(s);
         break;
     }
-- 
2.34.1


