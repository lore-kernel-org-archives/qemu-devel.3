Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887C1C87FD3
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLso-0005Tv-Da; Sat, 02 Aug 2025 19:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLo8-0005kx-Tq
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:38:33 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLo6-0006NK-VQ
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:38:32 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-741ad8d0c15so190980a34.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177909; x=1754782709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JAfp6bTpWJ7rWG/lC4sI7VzgGDIC3qOJcK2xhfFXPGU=;
 b=IeLBOXNGfXRp+riNmbIckADC8Wh2xQYBZV3JBFPboDmYdGIjje6Q8TqrRiwrXhUywQ
 Pjx227MC+0yJEsznm0qhpe6JdNepi2cYYc4LNiffJ+RY7ZRc5yHvtofkWyKC8B8Ro0my
 EAZoRUJJe/TRr3kEImw0KslFGEBZqgI4Oy17gakWBZqgLlm2/5aHlGAWnb9dAmq5Onta
 Okh19zPN6Ll0f7WCRGwe/jfrZM3Kp5USe+VjN8M1EF4Gn8DXPo5Lvwrobu3gRhza/kHu
 /onyHqEnLghHQDIgtZzfKTJB6+/JgxySMZL8YJOUFInv6kOuy17GJtL07RUEztzm8aJE
 Xz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177909; x=1754782709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JAfp6bTpWJ7rWG/lC4sI7VzgGDIC3qOJcK2xhfFXPGU=;
 b=gtdpcql0ko/L2pn7BFvtmA0qt0tz8wKn9eOyM0/aHxJ9eyMysBJdt/uiYwTHg+CqCC
 ISBdg2nl8r44Kg8s7cOXj8CBZrAJYjxVNgz4Zb568OdjeUxfYE5o5ziqaoHVan0AFELM
 COxyePxRgJ+Ilts5qo2TCFnrsQ/eRbdyEHYVejaYnz0R+WHFJ2BCC/gz/2XLTvRBIwDt
 32ktArLob4FP7T74APrk3/PwMOEBtxdfjnjAm/MoyoZbIzJy/YNJ8VYmHsU8wok28rh2
 qpjOS4AWXMNSuwaHtijIucqR9ORaQynZCsrZfKvzx+/wNFNwxtJh17HyMhZaSqLLRnEM
 ubaA==
X-Gm-Message-State: AOJu0YxsXRqDd5zl9ZjwjhDOufTBun34H7W2UtexxEo/FjRImPSytvDC
 EDB9dT+9/UvyFE8eibTl8Inxheh9ENTlkX4Ftkru2Rdsp8onTKtmYLo+T1Ikk97pp1+z+MqnVT7
 frTn06uA=
X-Gm-Gg: ASbGnctdqZPdgR8MShN/B4OfYENpGvbm3CsRvwJxPyPr0Cs4QKJs/2CGWg/8+BedDSr
 UP/lg+TiSciw63A2uPF/IgpCqZD5hzHiTguUmf9xPAPwNDo0+Yq8qhsTLzR8VQJPPEtQjCAsI44
 j1xTfwYx6X6z9Y+beWZd1AhNYo1SXzHuKfjLq//adoPpI8awn+ruzGCFpeESLWmb0oQoxCJV0Rm
 tNKmEgp09BUzv0kTxl8TuXCoJ/S0C6BfxQugxxf3MnF6zAMxyOzPVsjnh0tNVwEves7Rl84nALh
 6U9NA+2PVB5L2Gz5Q95tk29G2FRSB+xRKeb98nsL8WKo4GJ17Vp54z8G3x1qNVO1Ah+asfazZGP
 C+b9FWQKzFUHi/r1kmJJYdlw1Zjx+sRiWjE8YukgTZ0kg4Vwm3+6u
X-Google-Smtp-Source: AGHT+IGU8l7PHTZZiEYGKKhmQE6ypxNwY2CwLsUSaftUThFPLqs90JjUliDHkLStKZI6DE+kLJcFBQ==
X-Received: by 2002:a05:6830:920:b0:73c:bb23:3d38 with SMTP id
 46e09a7af769-7419d27ff95mr2720129a34.20.1754177909608; 
 Sat, 02 Aug 2025 16:38:29 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741a71dc78asm380409a34.30.2025.08.02.16.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:38:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 69/85] target/arm: Load gcs record for RET
Date: Sun,  3 Aug 2025 09:29:37 +1000
Message-ID: <20250802232953.413294-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index a945fd3b33..49e17548c1 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -433,6 +433,30 @@ static void gen_add_gcs_record(DisasContext *s, TCGv_i64 value)
     tcg_gen_st_i64(addr, tcg_env, sp_off);
 }
 
+static void gen_load_check_gcs_record(DisasContext *s, TCGv_i64 target,
+                                      GCSInstructionType it, int rt)
+{
+    int sp_off = offsetof(CPUARMState, cp15.gcspr_el[s->current_el]);
+    int mmuidx = core_gcs_mem_index(s->mmu_idx);
+    MemOp mop = finalize_memop(s, MO_64 | MO_ALIGN);
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 rec_va = tcg_temp_new_i64();
+
+    tcg_gen_ld_i64(addr, tcg_env, sp_off);
+    tcg_gen_qemu_ld_i64(rec_va, clean_data_tbi(s, addr), mmuidx, mop);
+
+    if (s->gcs_rvcen) {
+        TCGLabel *fail_label =
+            delay_exception(s, EXCP_UDEF, syn_gcs_data_check(it, rt));
+
+        tcg_gen_brcond_i64(TCG_COND_NE, rec_va, target, fail_label);
+    }
+
+    gen_a64_set_pc(s, rec_va);
+    tcg_gen_addi_i64(addr, addr, 8);
+    tcg_gen_st_i64(addr, tcg_env, sp_off);
+}
+
 typedef struct DisasCompare64 {
     TCGCond cond;
     TCGv_i64 value;
@@ -1787,7 +1811,13 @@ static bool trans_BLR(DisasContext *s, arg_r *a)
 
 static bool trans_RET(DisasContext *s, arg_r *a)
 {
-    gen_a64_set_pc(s, cpu_reg(s, a->rn));
+    TCGv_i64 target = cpu_reg(s, a->rn);
+
+    if (s->gcs_en) {
+        gen_load_check_gcs_record(s, target, GCS_IT_RET_nPauth, a->rn);
+    } else {
+        gen_a64_set_pc(s, target);
+    }
     s->base.is_jmp = DISAS_JUMP;
     return true;
 }
-- 
2.43.0


