Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5494FCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lfx-00050U-M7; Mon, 22 Sep 2025 14:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfX-00044P-4q
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:53:47 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfD-0004yP-0j
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:53:46 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b55517e74e3so1361945a12.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567204; x=1759172004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KT3njcGs3vlqxz+Aow0s8BlO+cvKAJjqrO8q+9uXab8=;
 b=DDgZh9wrDbwWFozu/+amIkiUQw7D+zpuO0mpBwPmXJMIWJyMehxXILD4YAGn27UG7s
 v73nriBqgQ5tXia2aYmIUipnU74OQpTE/ATNx4lbRjWmUBlgbu9A7n1BYAmLZhTDd5e5
 AeyBobKM1CNP/RYNPKVFZEHgnPuZ1SfbgaJWgtnJEic3gK9SUNKhg+8ijXVbrr/JPsWk
 5sHNmIBwWPbA8yCsJ3mOM9sMVziHvZo6Giw94gsHANS/0oPVjkJFy43gGPt+pVqk//rB
 YJS5fGeCqS+2XKaqa1wvNqnc/EI255B/j3lKYv31cKXYR4xCsdmdl1tQhO3AvmNErkLQ
 HKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567204; x=1759172004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KT3njcGs3vlqxz+Aow0s8BlO+cvKAJjqrO8q+9uXab8=;
 b=JVNe2HibKSYVVGjpkxNh2voXdD9k22n+3iXcJsEUTLRb82USqM86fZSe5lvToUnHCw
 CDn9XM3wyrV8mhdRf/pbtR02fPen8pfbdFRHEfFh5e25Cf6MPnzXFzd7yWN9LZ7GA9fh
 0jYWtngIqhV0YQYo0ZMdbdHd29UlftpOeGNhnEXKrXvNnXOidRlUs8wd5fYWOBRR2OVf
 xbe9S2po1aYmJaCaWYKbNL+9/lwp4AhRyNjxAUlJz+vGEnnzgLwJEfZTF0OPhA6ZEMfw
 uNFWz0Jc8kxpg0QZZ1kdHPZNshLq1blvsDxHJ9BugzuipS/L5Dsuby7J5uoS6V4SBggS
 FTrw==
X-Gm-Message-State: AOJu0YzekB+FVCwd/htBZKUX5lYPFXmbCFg+Q4VHH/BAEz4MKvaUohiT
 uaxu+F5kJ7zmW0jyHguUj9SMjvV0WALGWcq5//dIvBBlviCE2WJ7yZQiE38LRXELDs9a2LVT+5H
 B5MNC
X-Gm-Gg: ASbGnctXzJKEr5PjTK5KcCRePYI693MG/slw2DTlexMR6Z/xmVLVE0FOkZq/AUjRGRF
 7L8yACndGyCX6C21/lOinUfuW3c+I3qOupIvUCjpnRY/PyVA7qHph9zJ7cE0jhfqFwoyvI5iVjE
 bv7b1Ri1PsLDQdNpVvPJB8/Wh4+IX9quCAbQcOIZpBjLVbFu9uS2yxm8ypISapw1/eEfNCnE7xd
 OOsAMmNvdKym4ojfXfJ3YX7tZbUT/9hnnRcEXMR48zmOGsWt/FmZ4Btuus0hJ2wPtE5e3AwgvsB
 PrY5LbhDqdEmwMfo+GplxGPjqvUdqXYdioWz6pDYfqZFq9V0ZtHbTNH6aNIQMgQubSl4sG/9mix
 Qfix/2YQiIBgTORGJ5IWj9rxX7zco
X-Google-Smtp-Source: AGHT+IHj8n8IItN0eTMc7vp39f1NJ0fYhpL3F7oia4f6F21zcFsXwWHfljHADvwuyM0xrZpybIogxQ==
X-Received: by 2002:a17:903:b48:b0:24b:e55:334 with SMTP id
 d9443c01a7336-269ba3ec96cmr146371725ad.8.1758567203575; 
 Mon, 22 Sep 2025 11:53:23 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698018a472sm138554795ad.58.2025.09.22.11.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:53:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 52/76] target/arm: Implement GCSPOPM
Date: Mon, 22 Sep 2025 11:49:00 -0700
Message-ID: <20250922184924.2754205-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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
index e2af10c075..c52b02b003 100644
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


