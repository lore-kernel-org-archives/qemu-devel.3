Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F95C87FD3
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 00:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLrV-0003uk-NR; Sat, 02 Aug 2025 19:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLnm-0005H9-97
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:38:10 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLnk-0006BP-Jp
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:38:09 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-741518e14d4so938312a34.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177887; x=1754782687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kLrPSxlaNo5aIzGG0k94HX9nSYOrYMBFtOF/2lNnhCA=;
 b=ILuH8adg/YsYV5GhLJA3MSheigYaEPmbvlSd+cVLXAQhqCHy5VPicTMemOwKP1yPGE
 4ahQCF5fnbY61epahJjJ3LdtFNxiolSw0TKXpmx/s0JI/Z4DBuU0LoIZrTRyJ4GtkAGt
 0m314dlfqp0Ja03uNN9loevL0u2b+/ow9lBVsZkKi0hMUc3QysiwobUiLEv/z64kk0rI
 9JrhaoIxw5NIf6c2ooqAKbNNB9Oq/8SDwgbP8qiWc2AVMJK/26JKLS+MVJ/M4bbO9lra
 Uohx/gYc99U0wwiHBGNqPP6kms51JY7sd0Rp9AxDAHWjjoh+CA+901WEso+Yw/F6I7mm
 Z20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177887; x=1754782687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kLrPSxlaNo5aIzGG0k94HX9nSYOrYMBFtOF/2lNnhCA=;
 b=rIBOoYcnynflgj8i3k+MmX7ye48048WpFS/f9eSJX0XUMfez7zUM7aV3qUQYUJAeFO
 SJlNbLd+lh4lwZjlgY0mfUey212R2b+VpzKVfply2sdYh5sa4vkRBM5FDG6Ss1s7TQ+u
 y9ILdhbdXVBylslaXyFJ14rP+7K4YbiCOpTmyjd9PJRLVsDaO1QKWJ0uzxCrAOAUmGFH
 f+kJZt36MUNJ++xZ2QKVuSGdaIUjVpsLZfdltoGHO4Kzp8rrJtCPSuoEUeZS8SCxWiMo
 uPwGt3UXOdhoLPaxKH+guF/pMhEyB2hlV5fs8CgN+UIavO14qV0uOkKHHbGU8W2dhx7F
 7xJg==
X-Gm-Message-State: AOJu0YyM8gZ8xbN9TMAUUl9O7y3jzhxm6/f4G57M0snJj/sSIjvfK0kn
 8HvO7fKJKDkmsqRIFqHi+XedOQrRwyNa+loEG5sfJxHzJfE+M6mRCIUsH1McypGl9vT8s3hnXkt
 oIAS5sb0=
X-Gm-Gg: ASbGnctJpb6VbO6FwREI7GPJVXOmuyzTg3z/po9h809efd/zSByaeEOZUyABR/zcZxM
 Hd7EardrKPdASoOUi87z4npW97wYcaVF+vBKbX7x5WHeDdU6OYhagOy7kD8apfwEuV+oiGeMcMR
 kCY6II0Jo1y5kYFznofknksz9gYzVFzuIuF+ODppp303SHtFxt2lKK0lcn71PDSiH7m8bJe7EcT
 jzfiLiALBg33z0awzssZax6pdMaHf+mLtZ46Ct3vPVXVekK2ATv9y9REdSqx7ipkHmU5kXcDgCp
 NN7togkl51umJc6+3H0/dmSf4EngPQwzg7R57H7PO0Uw9J9qBqYn389CDg3BRgfQ/2Ragb60pYn
 GmiDvi9NpIPjnfxqaYsgzB7irW5lMCOxYRBLqgUQsPWGLDSpMD/im
X-Google-Smtp-Source: AGHT+IGnrfl3K6zV+Yw+dxhNPFIQUBnuSuKgH/rMi0VWR4j3eufc+T7fHM6sVaAuIIMAtQF0XhEMaw==
X-Received: by 2002:a05:6830:369b:b0:73e:9ee1:3d86 with SMTP id
 46e09a7af769-7419d0941e4mr1994164a34.3.1754177887362; 
 Sat, 02 Aug 2025 16:38:07 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741a71dc78asm380409a34.30.2025.08.02.16.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:38:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 64/85] target/arm: Implement GCSSS1
Date: Sun,  3 Aug 2025 09:29:32 +1000
Message-ID: <20250802232953.413294-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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
 target/arm/tcg/translate-a64.c | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+)

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
index ab53a4314f..bdafc60786 100644
--- a/target/arm/cpregs-gcs.c
+++ b/target/arm/cpregs-gcs.c
@@ -114,6 +114,9 @@ static const ARMCPRegInfo gcs_reginfo[] = {
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
index af91b7f95f..e4c7801740 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2634,6 +2634,33 @@ static void gen_gcspopx(DisasContext *s)
     tcg_gen_st_i64(addr, tcg_env, sp_off);
 }
 
+static void gen_gcsss1(DisasContext *s, int rt)
+{
+    int sp_off = offsetof(CPUARMState, cp15.gcspr_el[s->current_el]);
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
+    tcg_gen_ld_i64(new, tcg_env, sp_off);
+    tcg_gen_deposit_i64(cmp, inptr, tcg_constant_i64(1), 0, 12);
+    /* Compute the in-progress cap entry for the old stack. */
+    tcg_gen_deposit_i64(new, new, tcg_constant_i64(5), 0, 3);
+
+    /* Swap the valid cap the with the in-progress cap. */
+    tcg_gen_atomic_cmpxchg_i64(old, inptr, cmp, new, mmuidx, mop);
+    tcg_gen_brcond_i64(TCG_COND_NE, old, cmp, fail_label);
+
+    /* The new stack had a valid cap: change gcspr. */
+    tcg_gen_andi_i64(new, inptr, ~7);
+    tcg_gen_st_i64(new, tcg_env, sp_off);
+}
+
 /* MRS - move from system register
  * MSR (register) - move to system register
  * SYS
@@ -2945,6 +2972,11 @@ static void handle_sys(DisasContext *s, bool isread,
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


