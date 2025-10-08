Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B2DCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cCt-0000e9-G9; Wed, 08 Oct 2025 18:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCh-0000Ek-RC
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:11 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCM-0007NC-30
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:08 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7835321bc98so324715b3a.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960787; x=1760565587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/sp+p9+6kla5uie9MLF/yMa42L1f1nYNPqV9lKH1gMo=;
 b=KQxOt357q9hfYlMAPjtTPneHJiTr0U0xMCJXaufs8F8NVy6qU851YGa/9BDKvBk41A
 o9vG8tP3mcS352SmeqqzugV1wn94r0Q3IkUWNyX11akzG+zJb4PASAo/r/uxEsWs8dKF
 3+MRxRarGNNGQVjXuVkKs92yW4ovXR/U9DBzhbIK1/0Oft2qJ9DzQK/eKG5hJM0U+xzH
 77fROee0CRIOI+fNtZK/0j8DR2THZFOxsepoIHPOKBkszyEU7ZvcwyvOA1kxmXPiFVx8
 a5Eqp1nM29v9opeT21+h9bEx1cLUePwMOkCwXbsah14SacvBQuKE9jE8YGxhfNZU9mbd
 IJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960787; x=1760565587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/sp+p9+6kla5uie9MLF/yMa42L1f1nYNPqV9lKH1gMo=;
 b=aDKQyusiCa0O6nKDsr4TOEJDHOpzdmZdSgpVH2/+74vKR6TUJYBpGD9md41nbmc0VI
 ay5EUB5mc5YEKbfdLRwsGLpvBuWRkssLUn7ndJTWLLg/tgpvevGGbK8HiW3FSDEA8EZl
 gIIJa0yaonu9jMG0Frwhm6FgvnN20ipjGAgB64RZNfp3XFtCPK2UkjQhQu39vR5e3VWl
 nI7L10V0RMm5A3MzulEjvvdxywBDR1c10SfH1vtouTpem+m7Wb4dhJZbkwKGqUyH7883
 nyzkWi0faJje++1QEgyBpXM0pLplySDYPlI/9nOByMCTEW2KuZXa13pBpVfykDpbuUt/
 7tzg==
X-Gm-Message-State: AOJu0YzPq8ecP2CeiaKJqDJ9bln6KvnQVeZk42PvIAZJFJiR6AL1yZPW
 vvf1JmztuEEuXEe8/lYy4+asOQIj2re5pZmtextBYHZxphzyP4w7HMtgJuNbR2eoa9r92CxhS7C
 yz5d0kCo=
X-Gm-Gg: ASbGncuLmwTuBh0hw/Q37Ew8Qa707zOg+88PxF92L15XqHg743jF/db6UDiiUsVYAVK
 S8FaUM+HLJfNmb0eSPJaiGQQ4IuKXWhRs2/mYo+quWW7XgxjnDEyAZmiSUu5aZ21sLzvHJqGmCO
 nybCMHTu8PPX03tOCxru7OUqstmNhS3ynjyxVGPOY06HRxWx0rTHEYNOjQvFCw8U9xJMInduuBz
 hDQ1YlzUCChnNnwhrc1+r+PmnbPHiCttZsOCfgsly7gDPQIwnFdvTD3HdUINNhHDJNeVjnWzAlI
 /CyJlhX3g+SU/iDLb7L57KNr7Ol4D9lxi+atvDMaRXUzFJ7jc5oRh8pRdRxUnI/ec/8K2Ykak7Q
 3BcA2Saas97ds9HwttKvw8ExL0S9gdnQdCwQTJUHGTMtzhYz7bQ8TJEOx
X-Google-Smtp-Source: AGHT+IEbCKvEP5QYdzBpJlGsnk6cSig0au1/J50EOJ96qkCFQCjDQESG602ZyCcn7sbmhh4Y4vZKLA==
X-Received: by 2002:a05:6a20:3d93:b0:2f6:ec69:d448 with SMTP id
 adf61e73a8af0-32da83e389bmr6762886637.31.1759960786760; 
 Wed, 08 Oct 2025 14:59:46 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-794e1fc9db6sm740724b3a.66.2025.10.08.14.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:59:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 49/73] target/arm: Implement GCSPOPM
Date: Wed,  8 Oct 2025 14:55:49 -0700
Message-ID: <20251008215613.300150-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
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
 target/arm/cpregs.h            |  1 +
 target/arm/cpregs-gcs.c        |  3 +++
 target/arm/tcg/translate-a64.c | 24 ++++++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index d22ae383cd..81d8f0e32b 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -49,6 +49,7 @@ enum {
     ARM_CP_DC_GZVA               = 0x0007,
     /* Special: gcs instructions */
     ARM_CP_GCSPUSHM              = 0x0008,
+    ARM_CP_GCSPOPM               = 0x0009,
 
     /* Flag: reads produce resetvalue; writes ignored. */
     ARM_CP_CONST                 = 1 << 4,
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index cc5a0b86e4..15d383b2a4 100644
--- a/target/arm/cpregs-gcs.c
+++ b/target/arm/cpregs-gcs.c
@@ -100,6 +100,9 @@ static const ARMCPRegInfo gcs_reginfo[] = {
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 7, .opc2 = 0,
       .access = PL0_W, .accessfn = access_gcspushm,
       .fgt = FGT_NGCSPUSHM_EL1, .type = ARM_CP_GCSPUSHM },
+    { .name = "GCSPOPM", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 7, .opc2 = 1,
+      .access = PL0_R, .type = ARM_CP_GCSPOPM },
 };
 
 void define_gcs_cpregs(ARMCPU *cpu)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 625563d95b..7783273cc1 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2521,6 +2521,24 @@ static void gen_sysreg_undef(DisasContext *s, bool isread,
     gen_exception_insn(s, 0, EXCP_UDEF, syndrome);
 }
 
+static void gen_gcspopm(DisasContext *s, int rt)
+{
+    TCGv_i64 gcspr = cpu_gcspr[s->current_el];
+    int mmuidx = core_gcs_mem_index(s->mmu_idx);
+    MemOp mop = finalize_memop(s, MO_64 | MO_ALIGN);
+    TCGv_i64 value = tcg_temp_new_i64();
+    TCGLabel *fail_label =
+        delay_exception(s, EXCP_UDEF, syn_gcs_data_check(GCS_IT_GCSPOPM, rt));
+
+    /* The value at top-of-stack must have low 2 bits clear. */
+    tcg_gen_qemu_ld_i64(value, clean_data_tbi(s, gcspr), mmuidx, mop);
+    tcg_gen_brcondi_i64(TCG_COND_TSTNE, value, 3, fail_label);
+
+    /* Complete the pop and return the value. */
+    tcg_gen_addi_i64(gcspr, gcspr, 8);
+    tcg_gen_mov_i64(cpu_reg(s, rt), value);
+}
+
 /*
  * Look up @key, returning the cpreg, which must exist.
  * Additionally, the new cpreg must also be accessible.
@@ -2832,6 +2850,12 @@ static void handle_sys(DisasContext *s, bool isread,
             gen_add_gcs_record(s, cpu_reg(s, rt));
         }
         return;
+    case ARM_CP_GCSPOPM:
+        /* Note that X[rt] is unchanged if !GCSEnabled. */
+        if (s->gcs_en) {
+            gen_gcspopm(s, rt);
+        }
+        return;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


