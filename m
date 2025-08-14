Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39D5CA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXeg-0004S5-NR; Thu, 14 Aug 2025 09:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXdr-0003KV-3M
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:05:16 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXdd-0005Mh-Iv
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:05:13 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-76e2eb2bf30so1017509b3a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176697; x=1755781497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tt9CH77Y2lUOxhrk+cP00hbiI8xUlvDa8YhAuow35VI=;
 b=z6ooratjjaxm9hXGq95v2TiIFGanP520S3BbAT00u67mDr/g3GmHir8s9t50kUvvWq
 VzIMTcjW09JinWWrk6Bmqe2kzDyOBz/kw6HFOetbrq/DXxbdGPeBn60iY17ufRAkM2WV
 FBxnDMIWTvfW9bgys5r+03ABHR2zghkVJTualWdoeY447T7PQlrvJpTxctnGtBASczn/
 JOFaOvNDRfiOvigN/nyoeo765A3Td4+DbGk1ZIl+Mrsoj1bddYjnLaz4Gm8xwtkOcH5G
 bO8y0V3L6CYOO7JZvynaSQ93mP2UN7qNqArjjNYFexp850FLJ9/UisxAj2IPKQ7bYvpT
 rawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176697; x=1755781497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tt9CH77Y2lUOxhrk+cP00hbiI8xUlvDa8YhAuow35VI=;
 b=sPc1aV2oeQ4hr0f2TdFqfe/Uf0HdlkzJWNE+8dRU9FFXpV5ic1V411as37PMYdehrL
 s3F8Y535SSnrpPfMocA2EX7Dwf22p5OGUUJF4BDZiLwqSGYTlul6kN2XBlKbXhBYljnt
 H1vA1+C2if5OmtIjKXvktx0bSZ9RWAkzFAktkMUL0laldW0ImIoVem1fUVpJ64iLPli4
 6F5qAzN60IBs9CvNco4beQw0EzTFCQxC4vnjI7XSLAPocDEKYu5WrRQtKSKSZ006gkON
 raDR03Fin3uqlon1ZFJ7wJGr9lFNt/98SYqEEGIqCGCVgXVyp+3bALQFKBeQSxU5HPT7
 s4FQ==
X-Gm-Message-State: AOJu0YxDmgBY8w0fD4K4JmLxYqurP/AggDi+nx92qShyv2o1Es8pejE0
 n03/8Im4QC1bRcvxFaTAog4Gmg8RHnaKAfQONoGzS5shv8+oFBdxCg+MT5PGUy7sjEzVEiwU097
 tlDfdH1k=
X-Gm-Gg: ASbGncuoWJGZoUyR1YgbV0IY/SQSj5ZD+nWJ6p3MhrxiI1J78aq7tQRv9kWbIkMvi6j
 uV1HE2p9cygih/vBImUXaYgmlQt3GYYYP16qEN18cT6EPWwAUsRDGb+GbzI08EFAZ4EEyv9Thgi
 XoBnoMssaNMGSlXyha3FDkG9slhscveDOE71FPj3+Aq43r2WxnJm7fQHgSc3lWl5fBeNSWm/HxN
 qOTgR6yoQCNrhqe4BZgNkWTA7SEouJgpPb72urdwtHWvh+sj843fcLDnMO44m/Jagfcw1fyifqI
 xRn7K4D/yPMgwP7yjcz5ZuNBHjuoh/OaOoB1GPz/sW35J2nyLC+Gi56/su4ol30n9WOhEhFZX5k
 1bOzRiB6F5jGn25yxdzbAHfHPOxz3YPpLvmYcszKCbQbNMZnDtGuIWqJ4zA==
X-Google-Smtp-Source: AGHT+IFF3LDU0qOuAe+2y8eIUHzWfGNqILuMpy4xGkgB+NBm4PJYVSxy8+MUFg+Lghu5QVdruWLIRQ==
X-Received: by 2002:a05:6a00:18a9:b0:74e:ab93:422b with SMTP id
 d2e1a72fcca58-76e2fa28175mr4807555b3a.4.1755176674310; 
 Thu, 14 Aug 2025 06:04:34 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f6fesm34480631b3a.26.2025.08.14.06.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:04:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 64/85] target/arm: Implement GCSSS1
Date: Thu, 14 Aug 2025 22:57:31 +1000
Message-ID: <20250814125752.164107-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 target/arm/tcg/translate-a64.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 392a0a264f..ee8b870e17 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -52,6 +52,7 @@ enum {
     ARM_CP_GCSPUSHX              = 0x000a,
     ARM_CP_GCSPOPX               = 0x000b,
     ARM_CP_GCSPOPCX              = 0x000c,
+    ARM_CP_GCSSS1                = 0x000d,
 
     /* Flag: reads produce resetvalue; writes ignored. */
     ARM_CP_CONST                 = 1 << 4,
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index 3236f607f3..51fc8298af 100644
--- a/target/arm/cpregs-gcs.c
+++ b/target/arm/cpregs-gcs.c
@@ -125,6 +125,9 @@ static const ARMCPRegInfo gcs_reginfo[] = {
     { .name = "GCSPOPM", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 7, .opc2 = 1,
       .access = PL0_R, .type = ARM_CP_GCSPOPM },
+    { .name = "GCSSS1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 7, .opc2 = 2,
+      .access = PL0_W, .type = ARM_CP_GCSSS1 },
     { .name = "GCSPUSHX", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 7, .opc2 = 4,
       .access = PL1_W, .accessfn = access_gcspushx, .fgt = FGT_NGCSEPP,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index e9a57bc077..d97d9bfcb7 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2635,6 +2635,31 @@ static void gen_gcspopx(DisasContext *s)
     tcg_gen_addi_i64(gcspr, addr, 8);
 }
 
+static void gen_gcsss1(DisasContext *s, int rt)
+{
+    TCGv_i64 gcspr = cpu_gcspr[s->current_el];
+    int mmuidx = core_gcs_mem_index(s->mmu_idx);
+    MemOp mop = finalize_memop(s, MO_64 | MO_ALIGN);
+    TCGv_i64 inptr = cpu_reg(s, rt);
+    TCGv_i64 cmp = tcg_temp_new_i64();
+    TCGv_i64 new = tcg_temp_new_i64();
+    TCGv_i64 old = tcg_temp_new_i64();
+    TCGLabel *fail_label =
+        delay_exception(s, EXCP_UDEF, syn_gcs_data_check(GCS_IT_GCSSS1, rt));
+
+    /* Compute the valid cap entry that the new stack must have. */
+    tcg_gen_deposit_i64(cmp, inptr, tcg_constant_i64(1), 0, 12);
+    /* Compute the in-progress cap entry for the old stack. */
+    tcg_gen_deposit_i64(new, gcspr, tcg_constant_i64(5), 0, 3);
+
+    /* Swap the valid cap the with the in-progress cap. */
+    tcg_gen_atomic_cmpxchg_i64(old, inptr, cmp, new, mmuidx, mop);
+    tcg_gen_brcond_i64(TCG_COND_NE, old, cmp, fail_label);
+
+    /* The new stack had a valid cap: change gcspr. */
+    tcg_gen_andi_i64(gcspr, inptr, ~7);
+}
+
 /* MRS - move from system register
  * MSR (register) - move to system register
  * SYS
@@ -2946,6 +2971,11 @@ static void handle_sys(DisasContext *s, bool isread,
             gen_gcspopx(s);
         }
         return;
+    case ARM_CP_GCSSS1:
+        if (s->gcs_en) {
+            gen_gcsss1(s, rt);
+        }
+        return;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


