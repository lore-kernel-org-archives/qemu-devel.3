Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEC8CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXef-0004PD-65; Thu, 14 Aug 2025 09:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXdh-0003B7-Ik
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:05:08 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXdV-0005Ki-M0
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:05:05 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-76e2e8bb2e5so1141723b3a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176690; x=1755781490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NwFLvMHNhzDIJrx94b1vQDvIr7KcBJBJKmVw4Y9DgL4=;
 b=ZaQlrTwiWsw4lTVsidZQYkrhOCqqdp1RPcxsya2CF5XjcN5nqA2WqpPoLPSUfXNvDl
 qNj88DDkCBwet46oOSAwOrRmCGFNMKoIWuY7iGc58rRjY4a3JHk/a3eYtF0x9mDsceRl
 TSIiz1WL21GIPl9s31ZUxXXLm8vmARKg1Egq+DbXAurBZUnrMU3B00/jCkmCojjfSnmI
 NPP8ZXSTJXqHo1Fg4er3MFyDJyUlhcf+vLj1zTEIeKtHa8hImJeR53FPr0xZ8vpoHn4d
 mGm+DCmQbAYDHjxzyuHWWvq1J3UqMnzHjzT8b9mYQVoQkNbSUTW3CV2BSKjNv6zan2jM
 d7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176690; x=1755781490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NwFLvMHNhzDIJrx94b1vQDvIr7KcBJBJKmVw4Y9DgL4=;
 b=AMu/OSVQHg2zhREWyfkxExE2g9tpx90F5U4uaFi01ipGgZSSusZlXQBcul7Uipn86T
 lchMkP3C8HWnKXGN+8CZmjWYZrJBxIHbLqy1s3zXJeeWIqbKwicbhG7mjZazoZIlqsbL
 EWJh+iAjdYfJW9Ta3LEGNKPTWdUgyODUnb23duB/d3fCzKmmM6Xpc6wvy6CQQbihcHbi
 CANn0oLupHicUGMAWmsrHvaFyThZh1Fmq/sFNzyoIsebYihWyuVdN13Dx0nwOlmIu1R6
 i2PkXf+3aDKcCke31UUOB2f/25A1T24vqbqaYEfpG/wf8xFQJT8G4LBMeGG/WveE7++D
 fklQ==
X-Gm-Message-State: AOJu0Yw6rBKFJSB3+J1ghvfSRPgs8DxI/0PwwpIBlyccgTc3KtUsA7Or
 0z2GInGbJhRy1XEq9FAgLidSydMh/7d/CtBDUnBruWqeyxXZ/Q2vOTQgjg7ZSVLkx2hx05ybyPt
 pS2twzFU=
X-Gm-Gg: ASbGncusXl70rAu09YdyTRxXCVk5OWu/FtR3NiqEGiBUObFEwmv0e5uWSf4TfFIybUt
 M4orliRBxrCl9QiwGu38byVmUvsmYCRGhmJ9V2KtOUXafH9POA42HZHr3Rsu5X1EdqvD5+zz5G1
 RAZ4u6Mrc0ykIMOHUtn42pSU0OQOyhaAmnvzGcGxnn9hzHQWK3uA+lCqz/oG2S/kLkNnVhvRWgI
 IJcJh3pAdTPaIp4dypqdXs0nZZSX+M8ePjHvIqtW2fCfw+oTCZZ8d+Y5F05OW0PL4+AaCMILkQl
 EcbCKqnxV0P2jlUkn0UPGl0y+CRn15AMYNb9yjqOpSextb9ZU6DazQeRBS9KcbraO2YFdrDEDl/
 q03+CjdLkGmudeEoNblpO2qAhNVWpGCJTQ4B96iCz0xhNMf0=
X-Google-Smtp-Source: AGHT+IEMsaeUKqahWSMRkwpgjAW8BjqwbshIW41fTvHIvwye7pg2NrNtpcrS2rsMAnmA38qdrJUzeA==
X-Received: by 2002:a05:6a00:3992:b0:76b:ee57:9897 with SMTP id
 d2e1a72fcca58-76e2fd144aemr5014622b3a.14.1755176689688; 
 Thu, 14 Aug 2025 06:04:49 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f6fesm34480631b3a.26.2025.08.14.06.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:04:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 69/85] target/arm: Load gcs record for RET
Date: Thu, 14 Aug 2025 22:57:36 +1000
Message-ID: <20250814125752.164107-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
index 3a25a24047..e4a298d61d 100644
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


