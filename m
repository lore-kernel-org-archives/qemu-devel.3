Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C51C27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuM5-000638-Av; Wed, 05 Jun 2024 13:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuM3-0005z2-5J
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:19 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuM1-0003sF-9Y
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:18 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-6c53a315c6eso18105a12.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608196; x=1718212996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L7dwpgckxHbFk0O4eNsUAu8M+vkZg4wNv5sCDNFhbwg=;
 b=gzTMmcGJch3gMI7dZG4S9eHhrFYX36yFLOSJxzpQLhpCxy2i766SKwGmID6J36THtW
 SAfm0dLU2vsZra3090k+El9HdJ8XxbNmoG2cwBvvjDuL+IcaDxkRAzmx96WKxubhlCZt
 WK3v8qIRV+M50u+t2pK6N1FhKjEc8ojcIFbrShqBjOrPh3heHorJpyy/M4Qu9+qWNzZT
 HmlAcR0VN7SAfsBqvKhBouvgGAMvEW+xEQbJCWScCEJHQgAjutR7XzIj7xo49uL+fJgI
 0e/NeE0l2jvgDKa1Kj3EqPxzGn+UeVl3TGy0Gf6L7tfYxCoNXwT1PGt3I39HnysHPelo
 /j1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608196; x=1718212996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L7dwpgckxHbFk0O4eNsUAu8M+vkZg4wNv5sCDNFhbwg=;
 b=XYTQdGEwJn0q5Lro+Mjwd5TnnFsJgPOqj06IH51iQlDpzhJoWweOT66tqswNmoAo6d
 pyDN0zCYhTx+x9ome1vFb3scCnvydoC+pfHszXYzXq4CoX2hDS2+7vk2tClfcnjqzX/b
 LYqdmAwGlBgB7v+c+2y3fdJ9Nl/vVLKSU68UfCCYcO/u69sQ83kMYgTXYoO5+qrtfseA
 DJZfFlg++tAJkIAe2+Wbv0IV8SQPGHcIk3Vzg3qM1zngonKjSzTKEJ84DXVpqvvU9z4T
 JLsUR7D8LAghTgJN/+FgqUJgTb7WjZiw7RqDbu/UfJPuJkMTFm1vgaYIbXwyN5fPwkjV
 5qkQ==
X-Gm-Message-State: AOJu0YyjOl+4157WgPmA8a2GhvcFGRDc6ajqbSSiFLRAL22WCtVUlA2v
 eHN0p/5WTk5HC4Jqg57VkiiY7QrGyPnlsZvS+OXPQFKhQBLqdDcchhQkkV9jyz7ftqAYLZ0qZnc
 R
X-Google-Smtp-Source: AGHT+IE2LYwOgSqPFFJD1cxndz/rrFaXFIWd+XNtPSdpcyTxX2Dswq/Eg5FZ82Cuc+Yqu8cYmAIfwg==
X-Received: by 2002:a17:90a:a604:b0:2c2:53f9:56fd with SMTP id
 98e67ed59e1d1-2c284a97649mr1978272a91.16.1717608195704; 
 Wed, 05 Jun 2024 10:23:15 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:23:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/38] target/sparc: Implement LDXEFSR
Date: Wed,  5 Jun 2024 10:22:37 -0700
Message-Id: <20240605172253.356302-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
References: <20240605172253.356302-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  1 +
 target/sparc/insns.decode |  1 +
 target/sparc/fop_helper.c |  6 ++++++
 target/sparc/translate.c  | 11 +++++++++--
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 219f0e04c7..4ae97866af 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -40,6 +40,7 @@ DEF_HELPER_FLAGS_4(ld_asi, TCG_CALL_NO_WG, i64, env, tl, int, i32)
 DEF_HELPER_FLAGS_5(st_asi, TCG_CALL_NO_WG, void, env, tl, i64, int, i32)
 #endif
 DEF_HELPER_FLAGS_1(get_fsr, TCG_CALL_NO_WG_SE, tl, env)
+DEF_HELPER_FLAGS_2(set_fsr_nofcc, TCG_CALL_NO_RWG, void, env, i32)
 DEF_HELPER_FLAGS_2(set_fsr_nofcc_noftt, TCG_CALL_NO_RWG, void, env, i32)
 DEF_HELPER_FLAGS_2(fsqrts, TCG_CALL_NO_WG, f32, env, f32)
 DEF_HELPER_FLAGS_2(fsqrtd, TCG_CALL_NO_WG, f64, env, f64)
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index a5eefebfbc..fec055910e 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -589,6 +589,7 @@ STX         11 ..... 011110 ..... . .............          @r_r_i_asi # STXA
 LDF         11 ..... 100000 ..... . .............          @r_r_ri_na
 LDFSR       11 00000 100001 ..... . .............          @n_r_ri
 LDXFSR      11 00001 100001 ..... . .............          @n_r_ri
+LDXEFSR     11 00011 100001 ..... . .............          @n_r_ri
 LDQF        11 ..... 100010 ..... . .............          @q_r_ri_na
 LDDF        11 ..... 100011 ..... . .............          @d_r_ri_na
 
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 1b524c6d3c..0b30665b51 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -602,3 +602,9 @@ void helper_set_fsr_nofcc_noftt(CPUSPARCState *env, uint32_t fsr)
     env->fsr_cexc_ftt |= fsr & FSR_CEXC_MASK;
     set_fsr_nonsplit(env, fsr);
 }
+
+void helper_set_fsr_nofcc(CPUSPARCState *env, uint32_t fsr)
+{
+    env->fsr_cexc_ftt = fsr & (FSR_CEXC_MASK | FSR_FTT_MASK);
+    set_fsr_nonsplit(env, fsr);
+}
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index e144217347..c40992df96 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4458,7 +4458,7 @@ static bool trans_LDFSR(DisasContext *dc, arg_r_r_ri *a)
     return advance_pc(dc);
 }
 
-static bool trans_LDXFSR(DisasContext *dc, arg_r_r_ri *a)
+static bool do_ldxfsr(DisasContext *dc, arg_r_r_ri *a, bool entire)
 {
 #ifdef TARGET_SPARC64
     TCGv addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
@@ -4483,13 +4483,20 @@ static bool trans_LDXFSR(DisasContext *dc, arg_r_r_ri *a)
     tcg_gen_extract_i32(cpu_fcc[2], hi, FSR_FCC2_SHIFT - 32, 2);
     tcg_gen_extract_i32(cpu_fcc[3], hi, FSR_FCC3_SHIFT - 32, 2);
 
-    gen_helper_set_fsr_nofcc_noftt(tcg_env, lo);
+    if (entire) {
+        gen_helper_set_fsr_nofcc(tcg_env, lo);
+    } else {
+        gen_helper_set_fsr_nofcc_noftt(tcg_env, lo);
+    }
     return advance_pc(dc);
 #else
     return false;
 #endif
 }
 
+TRANS(LDXFSR, 64, do_ldxfsr, a, false)
+TRANS(LDXEFSR, VIS3B, do_ldxfsr, a, true)
+
 static bool do_stfsr(DisasContext *dc, arg_r_r_ri *a, MemOp mop)
 {
     TCGv addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
-- 
2.34.1


