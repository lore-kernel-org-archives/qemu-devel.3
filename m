Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBF4CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 19:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lhi-0007uf-5h; Mon, 22 Sep 2025 14:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lg6-0005Cy-MJ
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:23 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfO-00050S-Fx
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:19 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b4f9d61e7deso3194182a12.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567213; x=1759172013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lV01EAejMZtOUVdGrh8FhpDGLA+CmMEq51hjadKy0iI=;
 b=ckPdObCBSVtwzn8RZIH7YYJrxr9fcO3+K5S3lZ305I9X5CFDwFIadQMYTN4p1Xlntt
 QqAJ2d5mCvQMC6wDmvUguQU375Gvan+loVsiyQQimO86P37uGFgBlagSFTp4cCua4MOO
 j5O7AmfI32pH9MUBVcIH8YEvxZIh8dY+2hxpeUez+3oIjFLUlEDlszTtp65wjqU2ugfC
 gJKRXtBQbufkE6QclKXMtxNSrOoDImLU3jzGHwtHOAVzBFT4yjx2ear0ZS5EH4OAY/5R
 ZqIACJ7VSTEtwTRf0jPGx8t+jj1jzHwkXDgZ7+bA0pMnZDrmMvIUr9jETE99QOXvdrRP
 C4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567213; x=1759172013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lV01EAejMZtOUVdGrh8FhpDGLA+CmMEq51hjadKy0iI=;
 b=PSUoi7hf8WjokaIcI3N0dqwl95CGF3/K1oqdpR69eXpE9FLNWqOZS34VgbD5uqugKZ
 ULWUiOVqJMubvT5lSeMIQPuho+wuCSe2LU6Jnpshi9JzxwDivr+X3S7+OPz4AJdHTQMj
 qiiCu8g0DU+/aP9BSVZQLMhRhlI/kBLiJf6SKOS5E5TOLvqJeWAEZslboLN5tPufilbl
 oY3cvvSpskZ8/xySlduUWKK/Cs6CxznVrVF6u0jgWXfFa6TRVSd2GhfzZRx86undPYeD
 +agcb0x2VZVqU/7LfLH4H1Xxws5+dXkGYMIqJi4LRTSNimmiUxbon9I9TF6B7/RNz6QM
 ZkUA==
X-Gm-Message-State: AOJu0YxWttKSMLmIXfdCx7AL5Jg94TAVLl7odvQo21S1XNPcSO6qDSAr
 WckwpPX+mdLknaCKmpXmzPylsTPAD8ZXSHg0RkQpmfwuoI0VgEru+MpoDtAoVdjA5OAIze/3/+A
 JUBoq
X-Gm-Gg: ASbGnctmT0bi/vunFguT2lo711mbrrTNX02RnjIJzY4lYR6hlXxcUnjixZpHyJbxbjM
 fzUlPrLQ/6rtwCJAl+xVI4BbWn/HbsZdsgA0UKPefRtS+7DavdnncamVZuBAb9tw8mWNj88FliG
 L93eVcuGdVk9+iTRJ0BM/oU3OYcQ2Dl58eSAReP2SEzdKisq+Ar+pRzIxZkE1mYExNzLdw2Vg78
 oZL4bfTPGSdPwYxm8R5Tr+NSJqxB/Iac+xDD1y9M7PvTeSAXRjlObYCtQCurZclitFXPRGrd0iG
 HnTXDfn+HWO2z/2cTNWrfs2j91WzRGGvZHRzdTgLD4irI5HEB6X7ZehrPNorUJPwv3rukWkIJ9y
 kCilRaiDECKTnOsJD1Dn8RxCC3EOW
X-Google-Smtp-Source: AGHT+IEpDmEToQ1+L5xmeMw9xV9VsFid0A5cTQZvLbC6YIXZnYlEPMA9Gc5twiztSWeSRLZ0KyGY5Q==
X-Received: by 2002:a17:902:d487:b0:269:96ee:17d3 with SMTP id
 d9443c01a7336-269ba523685mr157701145ad.51.1758567213071; 
 Mon, 22 Sep 2025 11:53:33 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698018a472sm138554795ad.58.2025.09.22.11.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:53:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 61/76] target/arm: Load gcs record for RET
Date: Mon, 22 Sep 2025 11:49:09 -0700
Message-ID: <20250922184924.2754205-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 529c5bef0c..462c61032b 100644
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


