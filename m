Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0F4C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 21:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEydk-0001mC-FJ; Wed, 05 Jun 2024 17:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEydj-0001lI-4b
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:57:51 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEydh-0003rV-DC
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:57:50 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6ff6fe215c6so235915b3a.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 14:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717624668; x=1718229468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jd2ISjYQWsrbk5WgCP4+tpczbqrOBDh2pjdAAZ3A5n0=;
 b=N7ykA1uPaEUrbp73sXw8wmOOvqFAKpTgu8xu2vxRVHRSZqDRzh3+XdsEbA9O+bM3oA
 7gMGlN/DTRma0sM680GhAo8nEgR88aZe3vzrtC/FzO0YBuu7iGPdXtcB2vuTEXyfTchU
 jVOkgIEXW783Le+k7LjWV5rHy1gWRedA6Q48esHfrc0naUICYRcr9WMfnpPCkYQM4/VZ
 kuF1UESuMAWNnNKgmJec1fGBYtWsaM27fv5rZGHjRaFc0R12bGSQdNcDPt2WB8ZcCQoJ
 ywSARYIULZo25WEfPE1yJ1rd3aOG6a0M42MZ7M7vvc6il93GzWYC5tsbHmv/gA+mk2zR
 yjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717624668; x=1718229468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jd2ISjYQWsrbk5WgCP4+tpczbqrOBDh2pjdAAZ3A5n0=;
 b=pGhh/H695njxZYOoz48ZMD5OIOK+plQHiO9cOCuYkhy2I1KbzoRt2FGaLgbRCtdhmG
 1Z0ujRddiD8JU/TAHpqwFuv9E7mO7zzdGHShsUvEJrUiXMNb4orbb2ZjrRuaZp9KI8ih
 PPpTYBFJCU1/PzvzxbCLqrTYaiizLofmT9UNJIFXOz1zs/JslQ9df8taU1hC55KYTRpz
 XX088LNzGEEso72WlXcxqzN5XuFXJh6uxiB8MWigUC5uDwNRlQ1Qeuyz5Pe56eoJLlYn
 7lif5Tg6d1AOz3YkJoO9/RzvCgbqTT6JNeXa1KAOkfqSHU4Je/Soma1DlZsiSF++fStR
 V57w==
X-Gm-Message-State: AOJu0Yw7+x2Mcw4Rbg4Io/HjM7ptgTBHpCd7IkmVlL3B9rvrtiU12pss
 UY/PF1d/u5XOjIpSFj2Atz+QRkVmn8sL2STIGu/IkPcsj1sb4lfnQawrNj4u3hfjLx5U57SXFa4
 N
X-Google-Smtp-Source: AGHT+IEVhq+t+UGBaxBkZiYbrYyzboXhtsnCZUcdE/sNU+MjbnImO7Jt8FIbe1quoDXOrxoHuLt7FQ==
X-Received: by 2002:a05:6a21:27a8:b0:1b0:3301:337e with SMTP id
 adf61e73a8af0-1b2b7629136mr3491595637.59.1717624667989; 
 Wed, 05 Jun 2024 14:57:47 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242b2ff9dsm9091509b3a.212.2024.06.05.14.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 14:57:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 07/10] target/s390x: Use gen_psw_addr_disp in op_sam
Date: Wed,  5 Jun 2024 14:57:36 -0700
Message-Id: <20240605215739.4758-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605215739.4758-1-richard.henderson@linaro.org>
References: <20240605215739.4758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Complicated because we may now require a runtime jump.

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 39 +++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 0f0688424f..bce9a0aeb0 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -3805,7 +3805,7 @@ static DisasJumpType op_sacf(DisasContext *s, DisasOps *o)
 static DisasJumpType op_sam(DisasContext *s, DisasOps *o)
 {
     int sam = s->insn->data;
-    TCGv_i64 tsam;
+    TCGLabel *fault = NULL;
     uint64_t mask;
 
     switch (sam) {
@@ -3820,20 +3820,35 @@ static DisasJumpType op_sam(DisasContext *s, DisasOps *o)
         break;
     }
 
-    /* Bizarre but true, we check the address of the current insn for the
-       specification exception, not the next to be executed.  Thus the PoO
-       documents that Bad Things Happen two bytes before the end.  */
-    if (s->base.pc_next & ~mask) {
-        gen_program_exception(s, PGM_SPECIFICATION);
-        return DISAS_NORETURN;
-    }
-    s->pc_tmp &= mask;
+    /*
+     * Bizarre but true, we check the address of the current insn for the
+     * specification exception, not the next to be executed.  Thus the PoO
+     * documents that Bad Things Happen two bytes before the end.
+     */
+    if (mask != -1) {
+        TCGv_i64 t = tcg_temp_new_i64();
+        fault = gen_new_label();
 
-    tsam = tcg_constant_i64(sam);
-    tcg_gen_deposit_i64(psw_mask, psw_mask, tsam, 31, 2);
+        gen_psw_addr_disp(s, t, 0);
+        tcg_gen_andi_i64(t, t, ~mask);
+        tcg_gen_brcondi_i64(TCG_COND_NE, t, 0, fault);
+    }
+
+    update_cc_op(s);
+
+    tcg_gen_deposit_i64(psw_mask, psw_mask, tcg_constant_i64(sam), 31, 2);
+
+    gen_psw_addr_disp(s, psw_addr, s->ilen);
+    tcg_gen_andi_i64(psw_addr, psw_addr, mask);
 
     /* Always exit the TB, since we (may have) changed execution mode.  */
-    return DISAS_TOO_MANY;
+    tcg_gen_lookup_and_goto_ptr();
+
+    if (mask != -1) {
+        gen_set_label(fault);
+        gen_program_exception(s, PGM_SPECIFICATION);
+    }
+    return DISAS_NORETURN;
 }
 
 static DisasJumpType op_sar(DisasContext *s, DisasOps *o)
-- 
2.34.1


