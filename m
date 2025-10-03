Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C615CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jM5-00087g-Ea; Fri, 03 Oct 2025 13:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jL4-0006dg-6x
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:13:02 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jK1-0007ml-2M
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:13:01 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-782023ca359so2524653b3a.2
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511511; x=1760116311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qNWWc9PYZg2oYaXEvoVmQ8tq5QwlzbwlgJ3smVZg6WM=;
 b=rhjVeji7SXjmb/peue0Rz0K7vIxqkNnLzO0VxhXb3Mil90Pl1e0us13tW/XnA2xR63
 CPZhv/vXWBKIMdtyM7JVVie+YdPVC8ba8ZL8gqiRMM/aa/grJ0hHC8aOrpFErb0PgxY9
 qRoFTw+LkHCC03hAjlSKWktTHE6WmUuXrUS5NbExEAoUH28WSpz30HTnUcmlGV1nbXnk
 O31pkKubfpJog/R0zRuouu3qrzdHJIaTY2lGqPXgnMMRHWM3aBxHNMSx8PNK7UoyceYp
 +N7uPbULUm3V6JiygfGU0RNSMjI89yzuwqEV9Tzal9O6IdF11dCzLxEQiDWhjKM2YYiH
 vvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511511; x=1760116311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qNWWc9PYZg2oYaXEvoVmQ8tq5QwlzbwlgJ3smVZg6WM=;
 b=lXxb7taZc+FMSS9Kov4J8uf4dJVjjr4mCGtlJGt1sgBbiYhxKofkwoM/+Vhs6WvWQB
 keaUC0v1iGwEzjuCdtiZaSfbRq4SOEqu2tenD8BKQE+YeWI6KRtDkz5ajyApFYUeQDU2
 tKwRnG6Q/k7WV7P7997I0/i6ATRZkeYcReNSlSqSjvh4nYomsAJMmKGLQsgTv4XqO37N
 poft+Hq1TR0hmbxGXXQ9bACvWfBs8jwBu14sQ/p7LMfo00FfRNkqDnY7whxWIVznr7AQ
 tp+sOWSb5smEfCv7ock0gdgt06oBVCOUUAFhMB5FtlWCt+dh2gOuIdHt3FpmV4i5B27M
 PkuA==
X-Gm-Message-State: AOJu0YzUQqPPvASHIW9wrC3Ec/TNuDnPUG6rqmxRkVtS0d60Rl8bQoP7
 j8R39NQIsJY1jo71vJYHFMjmlyeP9Jmwi6Bwu3XOxBqd4nPecEERVhIMq+asMabiKpeasnyDhtJ
 U/bPeGiU=
X-Gm-Gg: ASbGncsSvh5A3Iah1aPEAtL4BfBrW7O8ap7Co7Sr8ia8NaBY27ERucAZquhFSXNCIR3
 bdsIgd44Gy9s5b9CQs9umsKgv/Xfxbgqgl2r9F4U/NcFd4hDHYwfCfo/IcUiihOAHRk+B9fcus9
 PHggmEOkJiOVY9mvyiICfTgvGkJ2UFD2PHcYIGk+zbxo8E8quAzsYjL5dzy1QsNB8zY4gh04FSV
 ZxkiZF0mXolFdCQVSPv2r4lPqV/Qrxfe1uBFbfa070OBgA9iSmdKyeBRYH0egJaCLcrW7YmKO/I
 +IwE1+t2eTsn25dA4XbQ7+wITzMeUt90lmGcgw9gOo+U80Jo42HaMXErPg5d4r6F/5DEf4ac8Dv
 r58Q8DkDkkPXc4gCw0bkhFLwu3X0Gp743J+HXh4y+8UA0MwNu2pD9n4JE
X-Google-Smtp-Source: AGHT+IEeLuzQl52CTHjDdoBx4d9QRhOHbNmN6OlqWkVR2r99uIol0oPs23E6puV5KWO22GWJe38pOg==
X-Received: by 2002:a05:6a20:7d86:b0:2d4:5667:8da1 with SMTP id
 adf61e73a8af0-32b61f7f659mr5094543637.25.1759511510958; 
 Fri, 03 Oct 2025 10:11:50 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b02053a51sm5418769b3a.46.2025.10.03.10.11.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:11:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 54/73] target/arm: Implement GCSSS2
Date: Fri,  3 Oct 2025 10:07:41 -0700
Message-ID: <20251003170800.997167-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
 target/arm/cpregs.h            |  1 +
 target/arm/cpregs-gcs.c        |  3 +++
 target/arm/tcg/translate-a64.c | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index e7e7050880..732c07506d 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -54,6 +54,7 @@ enum {
     ARM_CP_GCSPOPX               = 0x000b,
     ARM_CP_GCSPOPCX              = 0x000c,
     ARM_CP_GCSSS1                = 0x000d,
+    ARM_CP_GCSSS2                = 0x000e,
 
     /* Flag: reads produce resetvalue; writes ignored. */
     ARM_CP_CONST                 = 1 << 4,
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index eda5c498d7..1ed52a211a 100644
--- a/target/arm/cpregs-gcs.c
+++ b/target/arm/cpregs-gcs.c
@@ -132,6 +132,9 @@ static const ARMCPRegInfo gcs_reginfo[] = {
     { .name = "GCSSS1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 7, .opc2 = 2,
       .access = PL0_W, .type = ARM_CP_GCSSS1 },
+    { .name = "GCSSS2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 7, .opc2 = 3,
+      .access = PL0_R, .type = ARM_CP_GCSSS2 },
     { .name = "GCSPUSHX", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 7, .opc2 = 4,
       .access = PL1_W, .accessfn = access_gcspushx, .fgt = FGT_NGCSEPP,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index b0831938ea..0fefb1301c 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2668,6 +2668,35 @@ static void gen_gcsss1(DisasContext *s, int rt)
     tcg_gen_andi_i64(gcspr, inptr, ~7);
 }
 
+static void gen_gcsss2(DisasContext *s, int rt)
+{
+    TCGv_i64 gcspr = cpu_gcspr[s->current_el];
+    int mmuidx = core_gcs_mem_index(s->mmu_idx);
+    MemOp mop = finalize_memop(s, MO_64 | MO_ALIGN);
+    TCGv_i64 outptr = tcg_temp_new_i64();
+    TCGv_i64 tmp = tcg_temp_new_i64();
+    TCGLabel *fail_label =
+        delay_exception(s, EXCP_UDEF, syn_gcs_data_check(GCS_IT_GCSSS2, rt));
+
+    /* Validate that the new stack has an in-progress cap. */
+    tcg_gen_qemu_ld_i64(outptr, gcspr, mmuidx, mop);
+    tcg_gen_andi_i64(tmp, outptr, 7);
+    tcg_gen_brcondi_i64(TCG_COND_NE, tmp, 5, fail_label);
+
+    /* Push a valid cap to the old stack. */
+    tcg_gen_andi_i64(outptr, outptr, ~7);
+    tcg_gen_addi_i64(outptr, outptr, -8);
+    tcg_gen_deposit_i64(tmp, outptr, tcg_constant_i64(1), 0, 12);
+    tcg_gen_qemu_st_i64(tmp, outptr, mmuidx, mop);
+    tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
+
+    /* Pop the in-progress cap from the new stack. */
+    tcg_gen_addi_i64(gcspr, gcspr, 8);
+
+    /* Return a pointer to the old stack cap. */
+    tcg_gen_mov_i64(cpu_reg(s, rt), outptr);
+}
+
 /*
  * Look up @key, returning the cpreg, which must exist.
  * Additionally, the new cpreg must also be accessible.
@@ -3014,6 +3043,11 @@ static void handle_sys(DisasContext *s, bool isread,
             gen_gcsss1(s, rt);
         }
         return;
+    case ARM_CP_GCSSS2:
+        if (s->gcs_en) {
+            gen_gcsss2(s, rt);
+        }
+        return;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


