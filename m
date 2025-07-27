Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8177C87FCC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwRK-0001GC-P8; Sun, 27 Jul 2025 04:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPY-0002ah-BB
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:12 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPW-0004ni-9p
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:12 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b31c84b8052so3968082a12.1
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603629; x=1754208429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TwK1FVcwYdH/CTb2jXjKNg3tUOpLN2LCnFxikA/29X8=;
 b=E1Y/hRM73oGdumchGai2uIk2k5OHbWdPv8wI+Ru0ACbRWrI3v819FkJKUM5Pe0kid/
 F/QLZzSImHRbnSOUQg6kmWnSMIHaUprVso+IzpkrW2ew6XEKj75P+Y8cqbFDjI4eJB9V
 j0RhP3fvHegdWfcKtJs2G1B0Y4LNrdevoDfPFtGblJyDpfM8rft80uOuBZTFX4vDdiXl
 NfW+0BLuevpnnHyewrnzE1F82DPfQIMxxfB7PS/4Mz7UM4pgeeQC+cLeBLvKazU/SS9v
 hanvjCwCjRKSqElgm7qvEMRrBKSyBTb6TVQysg1EfOpcYZIdNLv1emTXktM1KGdVWJ8F
 Mg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603629; x=1754208429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TwK1FVcwYdH/CTb2jXjKNg3tUOpLN2LCnFxikA/29X8=;
 b=TAxIJ1Mhagcl151k6ux32PpZLnbHUDXQGmUJGQiDd57mKWf83VTZbBgcKgx5bcZT8r
 whdjXuZXaMXAmruFnAXf4eEtnyVuBTMFVGyAy3g7HK3z9LtTix4+MK1Ugs/HNbxePFvT
 7a47DmOJWg16jor9VkA2ojRJ2N/zzwur/+EQWsXV1tfHuadz2+kIYAST2kRH6mxbmRYN
 Fj1LzmWszhVKhozW/CXkwz9GqxMfJCU4URw3erEoniJhW8o1XPCCWbXJuLDgwzLLiBMN
 xvFWQeZZlzmiGfNoDBZdqa6d0xq+BL1KmCpTGfM5JOLuOLB+OP7wjRBMqNrijJ/OFoSl
 1T6A==
X-Gm-Message-State: AOJu0YwKykABd04GDekEQ3YfgmGyknTcvj1cPevOfd/fRNpzFeF/e272
 HwETBOGGa/bDorkco7YS9iPKOBSUKv9EzAp0JfOPbVffbL8PvrpRCFeqXZqmhV1NuT6pIVC2eB/
 AbrMY
X-Gm-Gg: ASbGncufQ4M5yGgaYRnT2i8eFEiMUmzf0NMvMaTeG0A6Wx+r3F3mhyuAAAUjqDjzbmP
 q5dJ2m1tXD06ZJ8/+OO4acTNwk3S4qZL2VjsTL0K+RgAx1HlFB4+dJ1F88LyDhh64D2FWJrTLoa
 qHaRMFh5PG/DoFWTt9StT5rkUTcWd5WqwwKneeKpJAOr4VFIcBHQZa/w2VyHVCTz2GVQka9UMoR
 qOiwwEd5cGiG6ihodqc0HzkGMRjR97NNguff+aayBfi6ggkUbhr4VFY+PzOVLcuX4DTRbM6sMJQ
 AD5B0QL4h5+Ts5PCX/0IrdZaBPnT8k0PazTA5GEoKIk2vwqtf2y3FfJnUcCh0yDSflh2oHZTVLx
 NhW1+a2h3QIS0bZ6wZysMNH0Gl1r+veACFkXcMuOeA2NcmJDwTJ6GPNS3WjdS7r9qEUx3qsjvcp
 /QFdNVOjsaAw==
X-Google-Smtp-Source: AGHT+IGgJf4iX7TGZ0pdNeyA6L4moN6D8vKdRfTaaddgbdhHaTax3qRrU2mE0QDFcJ0OVX4CrOK6VA==
X-Received: by 2002:a17:903:2312:b0:23d:dd63:2cce with SMTP id
 d9443c01a7336-23fb317b00dmr96704455ad.40.1753603628859; 
 Sun, 27 Jul 2025 01:07:08 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24011d5bcbesm3908065ad.10.2025.07.27.01.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:07:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 59/82] target/arm: Implement GCSPOPX
Date: Sat, 26 Jul 2025 22:02:31 -1000
Message-ID: <20250727080254.83840-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h            |  1 +
 target/arm/cpregs-gcs.c        |  3 +++
 target/arm/tcg/translate-a64.c | 37 ++++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 3d76afd20b..084ea00e51 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -50,6 +50,7 @@ enum {
     ARM_CP_GCSPUSHM              = 0x0008,
     ARM_CP_GCSPOPM               = 0x0009,
     ARM_CP_GCSPUSHX              = 0x000a,
+    ARM_CP_GCSPOPX               = 0x000b,
 
     /* Flag: reads produce resetvalue; writes ignored. */
     ARM_CP_CONST                 = 1 << 4,
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index 6f25543426..2bdd41c796 100644
--- a/target/arm/cpregs-gcs.c
+++ b/target/arm/cpregs-gcs.c
@@ -105,6 +105,9 @@ static const ARMCPRegInfo gcs_reginfo[] = {
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 7, .opc2 = 4,
       .access = PL1_W, .accessfn = access_gcspushx, .fgt = FGT_NGCSEPP,
       .type = ARM_CP_GCSPUSHX },
+    { .name = "GCSPOPX", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 7, .opc2 = 6,
+      .access = PL1_W, .type = ARM_CP_GCSPOPX },
 };
 
 void define_gcs_cpregs(ARMCPU *cpu)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 732d65f54e..773ed3044d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2555,6 +2555,35 @@ static void gen_gcspushx(DisasContext *s)
     clear_pstate_bits(PSTATE_EXLOCK);
 }
 
+static void gen_gcspopx(DisasContext *s)
+{
+    int sp_off = offsetof(CPUARMState, cp15.gcspr_el[s->current_el]);
+    int mmuidx = core_gcs_mem_index(s->mmu_idx);
+    MemOp mop = finalize_memop(s, MO_64 | MO_ALIGN);
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 tmp = tcg_temp_new_i64();
+    TCGLabel *fail_label =
+        delay_exception(s, EXCP_UDEF, syn_gcs_data_check(GCS_IT_GCSPOPX, 31));
+
+    /* The value at top-of-stack must be an exception token. */
+    tcg_gen_ld_i64(addr, tcg_env, sp_off);
+    tcg_gen_qemu_ld_i64(tmp, addr, mmuidx, mop);
+    tcg_gen_brcondi_i64(TCG_COND_NE, tmp, 0b1001, fail_label);
+
+    /*
+     * The other three values in the exception return record
+     * are ignored, but are loaded anyway to raise faults.
+     */
+    tcg_gen_addi_i64(addr, addr, 8);
+    tcg_gen_qemu_ld_i64(tmp, addr, mmuidx, mop);
+    tcg_gen_addi_i64(addr, addr, 8);
+    tcg_gen_qemu_ld_i64(tmp, addr, mmuidx, mop);
+    tcg_gen_addi_i64(addr, addr, 8);
+    tcg_gen_qemu_ld_i64(tmp, addr, mmuidx, mop);
+    tcg_gen_addi_i64(addr, addr, 8);
+    tcg_gen_st_i64(addr, tcg_env, sp_off);
+}
+
 /* MRS - move from system register
  * MSR (register) - move to system register
  * SYS
@@ -2850,6 +2879,14 @@ static void handle_sys(DisasContext *s, bool isread,
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


