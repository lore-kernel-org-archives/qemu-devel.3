Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE52CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cCy-0000lP-I5; Wed, 08 Oct 2025 18:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCq-0000Z3-C4
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:20 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCQ-0007O4-5t
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:20 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-791c287c10dso285238b3a.1
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960790; x=1760565590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=drSty9Fd0kDDShwUBu49hZpX2v+dbl9T54JaBEZWELs=;
 b=N3gH4dP4EADrETg9FOmNa2l6B5ako75mK6zgGu1xmTJN4IboJTlwtXJvcaZWfPXD+G
 ZRjVRwlHWupDGPNhtXvEqXd4CklLeMHv3/BCITJjqAvC5amAlp827Fif4cM0/1SQ/km5
 ITDuimjZS41yQswAnhvlOREc1NHdoDKwvc6eazhmTJ4+G2/brlZZ9khAhZR/wDWoZch5
 Fj1qvksd/dtK16FRQDxMBK9T3jPCCXpgb9JO1GFutvDeILjUkUYrVlK8J9tyqnvOU3xz
 KNmrvgM1Z/x4+QCUSvf4SI1Sepzpt4r6cUxbcIjW7GR47/T4RCrW3/93XiJlECp2Dxbu
 l3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960790; x=1760565590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=drSty9Fd0kDDShwUBu49hZpX2v+dbl9T54JaBEZWELs=;
 b=oQCRSxXINH0bj8qEZ6Sgn1tq5OIGNxw0Ar4GpZgtDXsCHaDEePPp4/tipk9gnN8Lds
 l/8W3Zz1K79GSyWClHxCjV5KmvbKAAXx8iMptlCiCctLgEWlZALbuMe8lR+RoTtWlgtJ
 AxM16XLzqCUq95Mmt578TG4FzkE2p6Do5elWEMqTa4k//rLgRSclPDcqSMByngdkyBc4
 Y2UYxcDRVmrseiLR4Gs4PAOl/r8Gf7iCariDQOF3JUWcpx4QMzH5GTiyLxMnOuT12ySQ
 XThcsLjfCkBdCI/GoBe6iLPpfes489wUNdqMRVyjPyUYj90wiI6VHHxQ0K6cWT3K9kC5
 7Bpw==
X-Gm-Message-State: AOJu0YydgthK+KQt8luA/mQuuscSJ5BtgHRjIURTy9dCl4QVFMNmeBZs
 890OqFVHaEg9p0w7LCPB6U3UO5jCQYI8sxm6GolUm5YPeqKrmBCWO1xFtN/JUpxW8DIjBnu8R5t
 feA1b/NE=
X-Gm-Gg: ASbGnct44GqvAC7gyZWY5p0iE8HouZm3lyGHglHu0iYcsNVzOvYVMzMpwqv56kFwxFU
 aooybizt9wdK/rwaywHU8+dFzBA+NX/5DxAif5YfqPwaS5yMJbQJ6wpAJ4zKpmBBMwd4G7shjgH
 0SyvBvUCbtRhqHUobT+WIo0z8f4upSRiae0L+Ic1GNr75n5SI4Xb/RR0tW7con6+lSx+cgIR/ML
 xvoQOTiBbr9PBTRFJWdkauJf+OFle1P1oxw21foVYgd4fGshzJJEO+VnLEkvE8zcPbQiFqQWHln
 /z3k2LkgqJcCCE1mRb0EOUtqow/BFIrg7FSEHpkWIGA7FKzh8p2IQP0hroad1vbEUVzDcuB67Nx
 +hG2a2QNJ8c2GkNvO+PSNFPLjzFieaE8gErrDy66fyMEDULLWyzFA+fjP
X-Google-Smtp-Source: AGHT+IGAzCHjg1+/AMMxaRVEqx+e4PH270vFaxdjSh3A+c4tEv7/U3lB4gaI0BTbMuIDVApWw0pXCQ==
X-Received: by 2002:a05:6a00:886:b0:77f:449f:66b0 with SMTP id
 d2e1a72fcca58-793883dad54mr6441453b3a.32.1759960789970; 
 Wed, 08 Oct 2025 14:59:49 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-794e1fc9db6sm740724b3a.66.2025.10.08.14.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:59:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 54/73] target/arm: Implement GCSSS2
Date: Wed,  8 Oct 2025 14:55:54 -0700
Message-ID: <20251008215613.300150-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index 82ddf4e1dc..d58257be40 100644
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


