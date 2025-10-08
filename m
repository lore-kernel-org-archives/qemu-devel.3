Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6861BCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cCz-0000vD-RN; Wed, 08 Oct 2025 18:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCq-0000Yr-1G
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:20 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCQ-0007Nk-0b
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:19 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-794f11334adso271829b3a.3
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960788; x=1760565588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=haWkr5zcG8B/3n1QyPkLOF9ZaZicyh1Td0H0H9j7CZE=;
 b=F/zNpplECFb7kGgL6YA62FwgS5VxlrwMR/OgJpXlkdN7tnQ1XSrtI2x2PQ5+ME3pel
 Oluv5+AKlp80xu/XiQ8V6bhsIPlY+K4L3tcH6sRO85Cca1nzhm8T8AGEouMY6TQKLkrX
 vmNGXYxxMSy5nYx+XpiwSKKERWspZH/P9rkHXbCKxaC7iC7q92cFEW0AGyacrQJ8LRax
 2WfCSwWDZUiO7iZOcPAoZJsbQ41vgR7SCYvk8fzTrOc7NxLcEw/DREvdJujVk99FdcEL
 AneqcRlxWCvoKoJp2SJd08lsRy1wti+xCogEEo0qumfFJJtOt+ZbC1B84FTjDDkcdJ/G
 u1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960788; x=1760565588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=haWkr5zcG8B/3n1QyPkLOF9ZaZicyh1Td0H0H9j7CZE=;
 b=oOswBEsCcMrWh3QLaWNmNnhsxgIHvmv7AyEnBGycbpyF4K9Ic64qARSsEesYnFBLTw
 H/GBaLmS9gUiR0rfQUG0tnX4FxnKNipLP/9WdTrvyvRqQmM3ZdyhhU8StWY2LNhXVXvd
 2ldQzA1QEgDiSGJJAEWL2lnEFC5qId/VnffRKf3VXQNvBMV0zpQ3gEo7KmD+EbDmUmAv
 ovnC7Wp/mXEEpJhQce45yuwCw0NJ3/TQR8Yk7uV/GeW92D2idOxK+GZmpm9jpmFmT1eM
 vmFlpRH2SLSQAQaAByTE816MY4OWdZpJ040JAGzrs3poRHmXbJjBfLnFgQcQCcIK24Hk
 86eg==
X-Gm-Message-State: AOJu0YyFR+foWPY58AKsLbgrKzLVddWMPIkcid0qgHHoHD1Zi3EMXkuh
 hjDPmO6Gx068hiyZV2SSx1z0af43MQ0R/fpqe9IoV1MoX/IKMrPzESzmIuHVQHc964NZ759osNN
 2/0fi/0M=
X-Gm-Gg: ASbGncscKlT8IxF2NKIYBDnCWiHmbhcVjusuQsWgDgVUYj0o8vsPM6oI8p82F5LJRqb
 X7ofK5mFOgmH5kAbPXbxE4LoTdq4iLSUcJ5ky24Dv2/VD2KXZn8CTaYsAVnWdjNsKobJfT5nUfi
 eLmKvEc4OKOIPLUjX6HLTXtD26G06r9Kx/njBM7YjlSDyQwTtB+7EKuXaPV1t3zXnCZb/H0PsOr
 TgAxb4wJaKZ/yJvS+iXTckf0pjKclcAJD7IRsisXlDEFYMyUdqZ4mtdAQA6lYzJVUu7U2vtIbiU
 xQtLuVbGfQBfbWPKUkEq3DSYMasVyNHSiWu+k4ABA5gUi+lfVqoz3ORzRT3fCALDcS+BFemKrTR
 ciVt3w3xszV/rnvIRoCshXYcygrr9klzcg9jNM4nV1b1KtRPztl7jf46P5J99XC5vSZM=
X-Google-Smtp-Source: AGHT+IFUoG8nmSQ8vrvXqn3p1yUZVrRADG7UJeQceFZJhuigs3UZPjE3PKPrYVufJ08qdyYpoZCcOw==
X-Received: by 2002:a05:6a00:23d4:b0:77f:3ceb:92bb with SMTP id
 d2e1a72fcca58-793858fb3b6mr6000776b3a.8.1759960788189; 
 Wed, 08 Oct 2025 14:59:48 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-794e1fc9db6sm740724b3a.66.2025.10.08.14.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:59:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 51/73] target/arm: Implement GCSPOPX
Date: Wed,  8 Oct 2025 14:55:51 -0700
Message-ID: <20251008215613.300150-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
 target/arm/cpregs.h            |  1 +
 target/arm/cpregs-gcs.c        |  3 +++
 target/arm/tcg/translate-a64.c | 35 ++++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 909916b7fd..ccf45fd136 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -51,6 +51,7 @@ enum {
     ARM_CP_GCSPUSHM              = 0x0008,
     ARM_CP_GCSPOPM               = 0x0009,
     ARM_CP_GCSPUSHX              = 0x000a,
+    ARM_CP_GCSPOPX               = 0x000b,
 
     /* Flag: reads produce resetvalue; writes ignored. */
     ARM_CP_CONST                 = 1 << 4,
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index e6c7025d02..5b5b895a09 100644
--- a/target/arm/cpregs-gcs.c
+++ b/target/arm/cpregs-gcs.c
@@ -120,6 +120,9 @@ static const ARMCPRegInfo gcs_reginfo[] = {
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 7, .opc2 = 4,
       .access = PL1_W, .accessfn = access_gcspushx, .fgt = FGT_NGCSEPP,
       .type = ARM_CP_GCSPUSHX },
+    { .name = "GCSPOPX", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 7, .opc2 = 6,
+      .access = PL1_W, .type = ARM_CP_GCSPOPX },
 };
 
 void define_gcs_cpregs(ARMCPU *cpu)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 0df1916d28..72b912a605 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2568,6 +2568,33 @@ static void gen_gcspushx(DisasContext *s)
     clear_pstate_bits(PSTATE_EXLOCK);
 }
 
+static void gen_gcspopx(DisasContext *s)
+{
+    TCGv_i64 gcspr = cpu_gcspr[s->current_el];
+    int mmuidx = core_gcs_mem_index(s->mmu_idx);
+    MemOp mop = finalize_memop(s, MO_64 | MO_ALIGN);
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 tmp = tcg_temp_new_i64();
+    TCGLabel *fail_label =
+        delay_exception(s, EXCP_UDEF, syn_gcs_data_check(GCS_IT_GCSPOPX, 31));
+
+    /* The value at top-of-stack must be an exception token. */
+    tcg_gen_qemu_ld_i64(tmp, gcspr, mmuidx, mop);
+    tcg_gen_brcondi_i64(TCG_COND_NE, tmp, 0b1001, fail_label);
+
+    /*
+     * The other three values in the exception return record
+     * are ignored, but are loaded anyway to raise faults.
+     */
+    tcg_gen_addi_i64(addr, gcspr, 8);
+    tcg_gen_qemu_ld_i64(tmp, addr, mmuidx, mop);
+    tcg_gen_addi_i64(addr, addr, 8);
+    tcg_gen_qemu_ld_i64(tmp, addr, mmuidx, mop);
+    tcg_gen_addi_i64(addr, addr, 8);
+    tcg_gen_qemu_ld_i64(tmp, addr, mmuidx, mop);
+    tcg_gen_addi_i64(gcspr, addr, 8);
+}
+
 /*
  * Look up @key, returning the cpreg, which must exist.
  * Additionally, the new cpreg must also be accessible.
@@ -2893,6 +2920,14 @@ static void handle_sys(DisasContext *s, bool isread,
             gen_gcspushx(s);
         }
         return;
+    case ARM_CP_GCSPOPX:
+        /* Choose the CONSTRAINED UNPREDICTABLE for UNDEF. */
+        if (rt != 31) {
+            unallocated_encoding(s);
+        } else if (s->gcs_en) {
+            gen_gcspopx(s);
+        }
+        return;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


