Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A48CA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXeJ-0003zD-Rr; Thu, 14 Aug 2025 09:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXd8-0002Ui-Pe
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:04:31 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXd2-0005Dr-Vb
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:04:30 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-76e2e8aff06so852064b3a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176663; x=1755781463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H4rbUlUKYWvRUhhOgTP67UqV9qz36nhYWL7wMK2fUqY=;
 b=XtU7emsDWx7sXgryjV40aeb3ngzunZ1ucBQBPG9FusL5R3y3yeN6Q+8shxQVlIPOGm
 Ck8U1bqeQrwZjKL40Nqn/7PODLeRDPpdUW/3i6kIURmWAHQPtUA/e5/O9p4YTFXSYVec
 BUr2J29pzy/mP8C5ddc2wxRbK1LE92mmPeCMjBMg/J4uGhil8pgB2VcOGjY6sWEz/MGy
 ITKraGSgyrwmQ7f7d0nfRdPPKiS/iK9vEpIR8P96WAajuw2hEtI6OskjyU0JOYXAcEP2
 uhiBQVzP77bHXe4e0MgILrXL0MId9KzXEsCh/QwQkEWeylRPXkyQdJ3g8HZlg+Ywxuif
 HsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176663; x=1755781463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H4rbUlUKYWvRUhhOgTP67UqV9qz36nhYWL7wMK2fUqY=;
 b=Af0X4R+zgljPtQkQqhvu2FcexdPTR8Hd/AvXvKXVn4MLDWZtdIDIttUgBgJ0lsFBpT
 smCrDxsWVk6Rd57W4Iw49C6lIHHGV0IYF7lAAJ9SAfJVz/p2DFJ/bzi1mzZ6DwLYKHr5
 HKTFMkA+95neLhM+fj68/X/5jhm/D7yHV3V/qTdFH7iGHc1Fzu9O0Lj0/h27/iUQi0bE
 hGFYjg+JArA2fXOe4WkYoh6m2GftzUQibiKbuZtKvE8o0W3veDbc2fcd9W/VDLrJKYNf
 oYt0AYuvgq9Ph+tHzBK8x9NGj3V+RHvwV3ufXH51l1TWFodznjO3r6na+XRZcbHNkCk2
 oMug==
X-Gm-Message-State: AOJu0Yw+i00uiomuC8sBjomD8BBrg10rGATvWIKZcK0sPHhGaVC6SZXO
 W7jgySvz9vROSfX/2kTnRpR2iXqkBoshXqA0qUtfIL8dpRR48g+o4gJnbYBHmMTVkbqj521ta3B
 D/BiCiFQ=
X-Gm-Gg: ASbGncsL3Q2WJy1hB0xwCLE8vpji7Z+Y8c9PspZCjGFn4dXlhTB/Z5D4Hlq/0wKFPPv
 bNBCYJH6enyTcOs/E+ljJYx0PXtpm/3YzrnFYKG8oSEzxY9s8lrx5VIRb/dgfiPPSGSnKjKDw+v
 sNgI9pU/FryPyiAKsdsk5+OKMS68o7/2MqClS6NY/kchZWOp0mkgti/Aa7DG94UxejvOe6gDoHW
 24K9ngJxA/KFhlvj0ZQZRil0IH9rEKkRCoLr/mXkzs0/t5D9h1+DpIQGTSY19fJkl6c/9fMvr0+
 9hbzY46vck9vXNilLArztDAf6IRL4EH9cgwTonjXBHTJOR0BgD5SMTdHRmwaCtJDSLF2iVjsWwG
 YGgZh++IFfVWrh0/ZjoZycaPquQZL4+X1WX3r7W6EesUKHPM=
X-Google-Smtp-Source: AGHT+IG82eVdxhvJDWfj+yKrVbDMSXMaWE/VqfREe8j26gIqenmAqPc04llcRhKA0bWTcAlwZLVo1Q==
X-Received: by 2002:aa7:88c5:0:b0:76a:d724:d6fe with SMTP id
 d2e1a72fcca58-76e2fcecb8emr4497737b3a.11.1755176662376; 
 Thu, 14 Aug 2025 06:04:22 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f6fesm34480631b3a.26.2025.08.14.06.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:04:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 60/85] target/arm: Implement GCSPOPM
Date: Thu, 14 Aug 2025 22:57:27 +1000
Message-ID: <20250814125752.164107-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
 target/arm/tcg/translate-a64.c | 24 ++++++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 93358e6123..9b19520346 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -48,6 +48,7 @@ enum {
     ARM_CP_DC_GZVA               = 0x0007,
     /* Special: gcs instructions */
     ARM_CP_GCSPUSHM              = 0x0008,
+    ARM_CP_GCSPOPM               = 0x0009,
 
     /* Flag: reads produce resetvalue; writes ignored. */
     ARM_CP_CONST                 = 1 << 4,
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index d17c17dcb7..fdefb2e17a 100644
--- a/target/arm/cpregs-gcs.c
+++ b/target/arm/cpregs-gcs.c
@@ -96,6 +96,9 @@ static const ARMCPRegInfo gcs_reginfo[] = {
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 7, .opc2 = 0,
       .access = PL0_W, .accessfn = access_gcspushm,
       .fgt = FGT_NGCSPUSHM_EL1, .type = ARM_CP_GCSPUSHM },
+    { .name = "GCSPOPM", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 7, .opc2 = 1,
+      .access = PL0_R, .type = ARM_CP_GCSPOPM },
 };
 
 void define_gcs_cpregs(ARMCPU *cpu)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 39b91eac6d..e0dddbdc25 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2513,6 +2513,24 @@ static void gen_sysreg_undef(DisasContext *s, bool isread,
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
 /* MRS - move from system register
  * MSR (register) - move to system register
  * SYS
@@ -2794,6 +2812,12 @@ static void handle_sys(DisasContext *s, bool isread,
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


