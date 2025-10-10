Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68B3CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CqZ-0007Tb-5C; Fri, 10 Oct 2025 09:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CqP-0007JX-Ja
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:38 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpS-00040g-UN
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:37 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3f1aff41e7eso1540018f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101594; x=1760706394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GcoYvQDFP8M035QlEV9JeRldEHEaoROzO6UVFvin6Ks=;
 b=fCwgEyHsUH7zB4i6k0SztIglCgHB7Yj1yC14BmZso1czcBFB3O8eOzvh7y1OFz3GOV
 2BzxshPGzCMIl8D//2jZ/0D/aqYpocJI88IF0WubpYx7tylGfo5eQjvBEOdN57hiu20g
 bj4SfrvV9IkR8/Ti1yjAKGr533GjK17YYVt85uQX1rYoQ9QV8iVmMkDxz1V3VjGyBiGd
 SyS4QG/UIA4IO6W71JV2m3vToXcXlIg9GZxBRkWvRqXAUTxNSiEwyqOwExAQ3eCFxqhj
 b3qDuf54tcL0h/LRPdFxDqoUiys2eKkIu5kv/fZMnvH6Km8F13OyEp+elvOZ9dyR1qNP
 wHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101594; x=1760706394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GcoYvQDFP8M035QlEV9JeRldEHEaoROzO6UVFvin6Ks=;
 b=XFe3WlxsKaQ3Oljv2Dp+2V3zl3MnYLZDcMqd+E3m67aOgbG53oAdskHUeQhHqM0H4i
 /m0NpeI1RCNpZiKdCMMD6efWG1Z4Gd8p+iNoN4ZoQQvLY1eEd7nNOOUdiIIxc4EFtphF
 acE3Z6SRQfc64eiAZ4lS9GKPpmNCJniU8VkF67+04Bcuyh9b3VybuYnCFo9wjWTwEi4L
 kYRHoUszLR4ppZQcU//G0ohtqBoozOXx9brQJxu4VB8i2xU3kxq5d5qUmqjzX+eZsIbJ
 Dpd8VOCU1SYJ51ERZgh86np7pOc4PogtZOG4BsdsRvTrKxNf7KQXDszrbecLIVPGHURF
 adUA==
X-Gm-Message-State: AOJu0YyrLv7jhmb3OVIAhWir9ChoRmuh/Czx+Yk+8bgUqDOrtwbSipUf
 1ozU9aNu2JBFFuk8zKr6y5NFAPYdJ0bSg3Dl8bsIvf+rUbFYpXDhX+eFMQn5BXUM6VGdohCYSJj
 ZPXp7
X-Gm-Gg: ASbGncsv+Knd8oUvaIIuA9ldpGX0M+cGEDVvhGxwXfAOctCTFcGk96CkMy7uUYE8CvT
 qROR+yOrQk9hAEUGbQOtNCkWegcYaiKwItwLDU7NOBJQd5/9WmNG5cVa2PS0TWrT6uo5bqD7paa
 XftE1uANM8OqxQV+WRpNDSC1GIQHyRhkHxnjMw9c3JrAWQvfLfVSM894OeJLMlPcd+VQraB2wgd
 3/+eyCZZ6S3iO8+9cZ70cj0Z7aULIjBJ5t+2P1hRfC84P7vK2tZ3w/mK4qKXnXzT6pPaaMIV64v
 HKVC+ezXP5GQGBcQVbSKsn6hlJqtAsOVyN31EoxQGHLgciFajWzB5Gl4uGOz3gYSSkvc5hVi77a
 5Aa6DWpZVXyzBJjksLomvKqR07oGVluwoSmPe3y6N//b83b6hd70IgLtAqmf8wA==
X-Google-Smtp-Source: AGHT+IHcj31yaBo2OCMXPzAXQXcp8pL/oQHnXHE12ifqh8INlm3gAJW4zc0hkPME+Tyr/lqV+AQ8Ig==
X-Received: by 2002:a05:6000:2c0e:b0:408:d453:e40c with SMTP id
 ffacd0b85a97d-4266726d9famr7080478f8f.25.1760101594362; 
 Fri, 10 Oct 2025 06:06:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 58/76] target/arm: Load gcs record for RET
Date: Fri, 10 Oct 2025 14:05:09 +0100
Message-ID: <20251010130527.3921602-59-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-59-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9c3de0cf717..dfd5b178317 100644
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


