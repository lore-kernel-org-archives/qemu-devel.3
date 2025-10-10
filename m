Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA3CCCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CqK-0007FS-Lk; Fri, 10 Oct 2025 09:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CqI-0007E0-LO
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:30 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpQ-0003zn-8a
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:30 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3f0134ccc0cso1506354f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101589; x=1760706389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4xCJOHcUdwbyJ66aphNgzIZdHSQb/CEteUrd1NlzKBg=;
 b=ZILkD56zJtqNPdoQ7hrz+PBTcSY6clj/KSD+wtJdbgwbmnjN+KVPAr5Nd9GbM27lmT
 eyN+mTslq2BQam8LfKNm1on8bMr46I7j0u5dosg3UEVnmVYqtgMIggj+FTzYrB3mVbWB
 zg7vDG0iVzpnlkJ3tfHz2j7X/wkPVjjrICJpAW7m5HrPmaxbKBT9hM5IkTmUhNLOq5gF
 aC/vVGsYeb8gAdzvRqv88WQxoX3z9JCsHuNZae7ulGTC6Jf4G7cvJvwxOdbnsCOetteb
 Dz5rI8NWMTqqLsxEa5hbs7V4eWkoygrm1FTD3mZnrQPuWn/DaZmK7z5kXiENDHk+k5mW
 aHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101589; x=1760706389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4xCJOHcUdwbyJ66aphNgzIZdHSQb/CEteUrd1NlzKBg=;
 b=qnv9DSrRxz0Wjm6wRk8FUsrhowQWfoi3UGIGxE6aw8CDebdv6f3uDNWoMuVHmkc/sJ
 2WUHEe12HhHkQX1ieNHU9ROUTfAupT3hqEEERiCV01QdZd8GUy2OhGdSIOLt+9xzodaK
 53eWgHhZY/guEbHWQ+Q0AtSxLP3byWYlMSkl0QyakaLqt0EYMpB9tssMF1Sm6bV+v0yG
 I/lnj7MsAvzLeRqKg1IMtbF/Fw1ZGaNWkbMwRyDa8dy/vX8ujCzSFMMOpl/D/aZoUYrZ
 yzruwDX5a+hFpsXool6jnvSRV+iEDbr/9Bxc8wG2h6zV4ObHOhf1OasBd6qbkKSpy34y
 +SGw==
X-Gm-Message-State: AOJu0YxIZAv5+MmebuEOVpLl0iyYIGVLXhivqW1lt00fL3qdW7DSGB1T
 lka/fSzoLZ/sqvrGML36P3L1cglaJCQUF4YsNGxgZZjlMP0lq2fElBVUkCYprR3Z9+rR9rQwUF8
 +MfL4
X-Gm-Gg: ASbGnctHSv0o6zT6LT6q9Ufc3xzzMhrkAyaUgSFHCnA8T/hKHQf3W2f4YvjgL13QgIf
 xhB5rgbusKEjvTdZ70sexSgm4HIzpLZkAyDCPkB2eq5Z3H/RAVRydpJu01oP/bIggZZmhUHzQYy
 IoY5qFGeFpiE8sK+lB3aXtJ4bCJ9e6EE9a+urQgYCYq16PTqNrRy+JQQevjDVeEGq9EuN81gTMl
 FlZu9HCE3vF4FwIiFs3p5t4P3l2wMSDY7tzAvtoQzNXDLEZ73nwg3J5IFJMLqvskCvi3BCdp0+G
 TeKvh/4BnVYJkLBCfkKeom8fEI8bVyNvYPC0hJWEnvgygsW8Ojk5BRhdr0R2nAAlXEx1G8DQJmD
 6iP4ngKcLtYOLsWR/8VCJQaFPK+xk/3vkLZh1t+pIPOSx4BnZBgFpi6bG5lvwCw==
X-Google-Smtp-Source: AGHT+IE22qerwgrpsGHx7CuPOqHkeZPzZV3zP7u/bYNC/iXpPLTKP9gGLNgx/QmZ32iXB4CWeIMXxQ==
X-Received: by 2002:a05:6000:2504:b0:3eb:d906:e553 with SMTP id
 ffacd0b85a97d-4266e8e61dfmr7605993f8f.55.1760101589468; 
 Fri, 10 Oct 2025 06:06:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 53/76] target/arm: Implement GCSSS1
Date: Fri, 10 Oct 2025 14:05:04 +0100
Message-ID: <20251010130527.3921602-54-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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
Message-id: 20251008215613.300150-54-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h            |  1 +
 target/arm/cpregs-gcs.c        |  3 +++
 target/arm/tcg/translate-a64.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 6d9145109fe..e7e7050880c 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -53,6 +53,7 @@ enum {
     ARM_CP_GCSPUSHX              = 0x000a,
     ARM_CP_GCSPOPX               = 0x000b,
     ARM_CP_GCSPOPCX              = 0x000c,
+    ARM_CP_GCSSS1                = 0x000d,
 
     /* Flag: reads produce resetvalue; writes ignored. */
     ARM_CP_CONST                 = 1 << 4,
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index 3795bf7f363..eda5c498d73 100644
--- a/target/arm/cpregs-gcs.c
+++ b/target/arm/cpregs-gcs.c
@@ -129,6 +129,9 @@ static const ARMCPRegInfo gcs_reginfo[] = {
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
index bb8ffba5868..82ddf4e1dc5 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2643,6 +2643,31 @@ static void gen_gcspopx(DisasContext *s)
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
 /*
  * Look up @key, returning the cpreg, which must exist.
  * Additionally, the new cpreg must also be accessible.
@@ -2984,6 +3009,11 @@ static void handle_sys(DisasContext *s, bool isread,
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


