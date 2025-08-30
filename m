Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952E6CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNyL-00062X-3o; Sat, 30 Aug 2025 11:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usERA-0007OO-46
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:44 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usER7-0004yQ-Bt
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:39 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-248e3ef1641so17134785ad.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532856; x=1757137656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bTDxsYCgOOY4AQ9WMuAsrWuHfULMfhqIx78Righ9ppA=;
 b=LXDib6Y0HcDpu0SVUa1R2BmINj1Jvbp3Swbym2Zzav/3jl8lUx0JO5LzDUqRzjiBd+
 /FbXINDJjbBNxCQ1VmGkHXYleL+sRclRV/8VfFqo+e3PqZOHLilQGTtxwAZnYNi/qqmI
 K6YIy/J1V+42CdyGFIDDhcD8/KzJWRSpFYw19DbakZtiz00/gGr+/R7uOCT4ZfOQ+x1a
 L2d1ObS2DKPNPxsONrILb9axVBW7obMZJ+kB7ZsbnBFaFrOSNI4lVGS578T0X5E27HiB
 5c69k+aMm399ABR/80y49wZ3q6KhT1A9Clbp//McqrfCMGyzDMfHYhsMQqCu9bguqcIu
 Ejdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532856; x=1757137656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bTDxsYCgOOY4AQ9WMuAsrWuHfULMfhqIx78Righ9ppA=;
 b=K62sP2GPwtpDfomiXAXIM12hgeFgFANKm+Unk2UsZBZq0xtSt7Dc/5Sl81j5tKlzEk
 i11zDe/XHHjhpDZRq0ZC8ob9Ph7euu6ondYNFD7ns5BDI/yb74BJKICDUGANNTbi/Q0m
 4/Mxt/E+RRSoet5d8xg2ktX9GoWl5EkvpculNS/4YXaT6fda67kTWw6f1KjicDTQ5KVo
 rHMxmcNTyUG8RuG+jKdC65OR55V23jQ0c7kkagXobYMZCtpe+2KVbOGdSp7mlNuQ8thH
 H88WliaSo66oyJuJIL/SrafdZ4pZwYMxWmt2+Gj7qFLHXaGJln8ODCRKMlo7BsxCnfVS
 +XOQ==
X-Gm-Message-State: AOJu0YwsR1Rikf3HrKMHpf+77PHqK6Ql9/qL9jD7D6SbWyBVFJBIQxE9
 mJO2ko2DNebBTCuD3gZjknJo0U+Yi0+izhglWf3NgMvL5S5Yk9+AfSIMA+oDqZYDuGUQwrSp76R
 c2dm04Fg=
X-Gm-Gg: ASbGncspk5PScgID6i1Lo7PU6VMjLufi5lh/rAAVvUFU2VzwU5L+nW7JqzODsSkk640
 ZCYlBPuODre1401dd9duXm9q2aEJ0l6SBFEsXYxIzNAyVaG7SRSAz1Sunar7gm7tZ9eU5s4KnUx
 Fnj+FZKOh8RJZ9LZA6sh8V0Silltm+8BVLXF/E7+GXBfQ3KRfhts1y5GlSu0vSWaGtPqgHlU+nO
 HNbvZXjEOeQGW1mbQOHlxLdRS+/CHGu8uEjuhVyOL2jy1gwGEj4qiv5h7j5JPFQZJCdI3Vtncuz
 JuVW+IiHW41dINQwuoRJAhQbTbCMrxG2+EA6mn9W5Aca1oGuqYsUYaoVIXlazj1DFX2OICudDER
 bDgzRWjYwhsVRIdZ+kFau2zo/GZl8T+7D0uUtWUU4okuUllNmsZfnCzr5v8ko6d+ICM7J4DrSNA
 ==
X-Google-Smtp-Source: AGHT+IGgtSILQQye5u6qfrHsW0PqBufvMgQVP8vFh1guA1yltmwCc3+ERwp8A0EEIAyH8XsmqHNebQ==
X-Received: by 2002:a17:902:f64c:b0:248:fc2d:3a2a with SMTP id
 d9443c01a7336-24944b6cf13mr14527625ad.56.1756532855967; 
 Fri, 29 Aug 2025 22:47:35 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:47:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 64/84] target/arm: Implement GCSSS1
Date: Sat, 30 Aug 2025 15:41:08 +1000
Message-ID: <20250830054128.448363-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
index 193c199a2e..e0ce2bd0a3 100644
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


