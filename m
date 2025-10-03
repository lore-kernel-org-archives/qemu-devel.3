Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74CACCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jLy-000813-5C; Fri, 03 Oct 2025 13:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jKp-00064p-17
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:12:48 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jJz-0007kt-Ac
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:12:45 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-76e4fc419a9so2460993b3a.0
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511508; x=1760116308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1v7olCkWws1ZZvjZPeAmCDU1NFVLs8DG/8MPqxgJ+QI=;
 b=PD62Zj9xWICQZsWMsJ2IoNN5nmDPunRdfimWMhHSBCSH7t9WC/Spp4Af8Evhp4C/DE
 aZFunlmeVxHxBZHj11vlk5YDMBdrS8cKvKO9SNCbInqzb1oVhiGxP3UlMdM5b3zXE63W
 1gk1Rgc4T9RjqtUzplqzVU+sCySexUl4HGCON9mJsyQiSZEdzQF72eV6nY9+Fw9IrJP4
 68d3EE5CERSchCeHl0z7PYBFplI/Rjtw8BijWcCDe7GuDs3+pHgybGSxCoNhs3eHlwDi
 6s5+I48pIBYzaZmd7XHOk0YSrNK5C9hf2tM1aNcQah7ooEwEroRWRqWB7a+tDvVPejE5
 8eBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511508; x=1760116308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1v7olCkWws1ZZvjZPeAmCDU1NFVLs8DG/8MPqxgJ+QI=;
 b=qNgjHmx/9zpz02smSAvA/lw+62SonmPFjGERIxD9ovdo2hVhRS91FqgqBvu3JF11oj
 4jvABSpBPTBwn7S1CXfGH/bu9ho+Alv0sFXuUACY9fMYYYSULsa+KZjfjDWufaYHYnao
 bCZyUTtrReYr0qOmCvBM2QJsDZf5Qj51p8Dsjl3YN+SRPQJQYIvOAv4gFq12/d37SRCA
 KrSwMNGUegaCKb+Md5DDJoDD20hAIILC1bkIX4ErQ7zgMg94xsraM92VZUA7xk4m2tBE
 53N/OGALp646tKMsOdEFAa2itQcVQzINebpxh7/XN/a1JmwKblGuyLY06/VBPKfHMVXA
 OGGQ==
X-Gm-Message-State: AOJu0YxgC2hEh5BWCtXU94vTEDuWqPToj/Ob9+GmzIfTkagrggXqfQzJ
 1yBAR6U1I6ZqmlUKDVNjmX3s2n5H6YecxqOSQi/c6GCvpaVfZcVz+dpXhF9YM1NHKEBN7QWgdpm
 YdXlzqzY=
X-Gm-Gg: ASbGncuefve8QtPMjNCY4p3+h1e33FCilmDJBbMfmNleAVLnHJGcbAqlWNUtTixxDTc
 PibX7qmh0RVwAc7/hsHyLE7byhSPEYHF8F1gUNfCkU4q1oA4XrN7kXErpvLPH9rFfJu+0kBhSXQ
 kcJ7cL7AH5DvvVY39NVT6u5jugudGJbRdf8WU/eB2Nz8svmI7VuYV+XqOymf5j1XWvAQ74pgMVa
 PjMUCgDTgl7ocXGw5AYpWG5aOUGXwpK4X3S08kK1IJ38ojGRNeCSLDCuLVxU/bXXdihtEjQnf6t
 yCIE11bc9UREw0eEt/BFBsu/qXHRY8jznrnLX31jD8q/r2EKIy4b0KxqRVOn0ZdZlxZWoCgJS33
 C84gCtFPt6m9gSvUZfOyIWK9WShyUVe0fZvDTjTfyzv40SqHgSOBljpRQ
X-Google-Smtp-Source: AGHT+IGTT/5kW/Rq0fjvxCC1qC8uObQ4JICqED+zWoyUVRDU1RgayKsoDI2Ifrn2o1H7bwzo+FUWgw==
X-Received: by 2002:a05:6a21:6d84:b0:2fb:62bb:e0e with SMTP id
 adf61e73a8af0-32b620b4a2cmr4316549637.32.1759511508315; 
 Fri, 03 Oct 2025 10:11:48 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b02053a51sm5418769b3a.46.2025.10.03.10.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:11:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 51/73] target/arm: Implement GCSPOPX
Date: Fri,  3 Oct 2025 10:07:38 -0700
Message-ID: <20251003170800.997167-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
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
index c918e3acfc..08f9b214e2 100644
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


