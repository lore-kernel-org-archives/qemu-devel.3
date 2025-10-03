Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10C2CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jMD-0008O2-GD; Fri, 03 Oct 2025 13:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jL6-0006f4-LW
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:13:08 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jK4-0007n9-HI
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:13:03 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-781997d195aso1822893b3a.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511514; x=1760116314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r1JpGP0BQWN7RXZ3yq+jOGIXDfS/M6HeM3al8dI5nEQ=;
 b=drDzNyvdS+LWLXMOw8kAVaUEUUE4c+VLtVe9IcmqCJO3BYm1IMQvbhe23EjpTJVexj
 DZnbe6ontTpbFdvLvVMsPA66piWfUYRu6Yds/yK5IyRR3s/dmY0WnDdcohuJBgDhMfmL
 eluCRYZHLI/HktjoadNoImUep25xun9vEI9T3/4mDb3EPefiWqT4lmInbS4I3epsKEQa
 ZDyNrdEmKKJF/TYkl/SOGJsc+nlNZVnOWJ4cbjq64CvK5Xa9JVljnkK4oXVNXX1eTMiU
 XxCtMb2xVyetbhsVh7BnCK1DGiulafUJMjrki5XOpaFt0TsMf+QgdHpxH15Ce2Zogu0Q
 bdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511514; x=1760116314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r1JpGP0BQWN7RXZ3yq+jOGIXDfS/M6HeM3al8dI5nEQ=;
 b=U2PgnAevmTbZxNsrkxYLZ3ap0Eq1tKqnzA+ZuPxi3qeKJ7T0Su1pCafUT9594Y+GOB
 8Z0Yxg3YGA1H5d0VsvPLdF29qmap/Ntpov+pOf2x9H8uvBQit3nGBLaYhuF2QtQ5f9hK
 F+puELYf+ds8heUzIiNj5KNkO7oefhPhOgqFZ1BTP04+5TZeArSd47dMotdJK3XH3h++
 0gCJtwirXiNB5YJVn+ByaH9/MmuTYnQGikXPVX59u2IRkoPK8E/oU2+y/5x57PdDgJsb
 DIwhYp/p0gjpgMoJ2pX4H3oM0FBArHK/onDFdhVMkFJvi4SJbQ6u4pPkRa2YXWrcGorc
 AnsQ==
X-Gm-Message-State: AOJu0YxNJsL89YIP36wNTnC4P/Fyx1VTwqlOCNlcKmK3GhYZ3+R0rJwf
 tBpHg+lkOudvVjgV/5DFaXnGCBVp3h2C0zxDCdLWtP1JhesuYMR7ESu8rZba0gmUvnDia9QTg81
 su8jYSTs=
X-Gm-Gg: ASbGncvYzN1tIPfUg876c/dHn5pkomIkQAqZgHZkpRqXhJ9AwqGxdJMtKAGo+dRrtYz
 pxzaK6jIyRs2OmQr2LXJ4AvtSzmcnVXlpU8TPKRLFRafRcPj3ToH3lzSfaXgoavu5ZGGSNr1pRG
 1I5HA+xNMQLQfJtjb3ULM6CAAN787qdWQMAKO+7Lsf30T3Yr+lC+lTN0FutgKJhdr40FkNa5i/d
 72HWte68g4LjiznxwRxv98a6UXEq7XFp5eXM4NTMLdZ3WDZVYQ8hVrERAnt/wUFj+xR15fjTLAY
 oWGq9P7yZtn3XOkoROiswWtb3zyEZJ8pT/GejYSZoK85fgU+KHGwlCYTrMYDs9ccBzpllZkqouU
 lhENe53CDbVtH/vXaEgiyUS+iHE9FGwgPyENNADR9zsDs/1dK2+rj6VEg
X-Google-Smtp-Source: AGHT+IHn/M01Xi+Jzpp7JsS8hrA+ywh4oSGcZEB1Q7DD2SbZqkorhXLSEJTCLGhe0F8/j5UvaVpSLg==
X-Received: by 2002:a05:6a00:2eaa:b0:782:2f62:7059 with SMTP id
 d2e1a72fcca58-78c98cc35dcmr4606125b3a.22.1759511513997; 
 Fri, 03 Oct 2025 10:11:53 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b02053a51sm5418769b3a.46.2025.10.03.10.11.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:11:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 58/73] target/arm: Load gcs record for RET
Date: Fri,  3 Oct 2025 10:07:45 -0700
Message-ID: <20251003170800.997167-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
 target/arm/tcg/translate-a64.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 271c2c6084..6e51a0f6f2 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -444,6 +444,27 @@ static void gen_add_gcs_record(DisasContext *s, TCGv_i64 value)
     tcg_gen_mov_i64(gcspr, addr);
 }
 
+static void gen_load_check_gcs_record(DisasContext *s, TCGv_i64 target,
+                                      GCSInstructionType it, int rt)
+{
+    TCGv_i64 gcspr = cpu_gcspr[s->current_el];
+    int mmuidx = core_gcs_mem_index(s->mmu_idx);
+    MemOp mop = finalize_memop(s, MO_64 | MO_ALIGN);
+    TCGv_i64 rec_va = tcg_temp_new_i64();
+
+    tcg_gen_qemu_ld_i64(rec_va, clean_data_tbi(s, gcspr), mmuidx, mop);
+
+    if (s->gcs_rvcen) {
+        TCGLabel *fail_label =
+            delay_exception(s, EXCP_UDEF, syn_gcs_data_check(it, rt));
+
+        tcg_gen_brcond_i64(TCG_COND_NE, rec_va, target, fail_label);
+    }
+
+    gen_a64_set_pc(s, rec_va);
+    tcg_gen_addi_i64(gcspr, gcspr, 8);
+}
+
 typedef struct DisasCompare64 {
     TCGCond cond;
     TCGv_i64 value;
@@ -1798,7 +1819,13 @@ static bool trans_BLR(DisasContext *s, arg_r *a)
 
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


