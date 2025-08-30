Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF85CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usODx-00067M-TD; Sat, 30 Aug 2025 12:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQv-0007Ke-SP
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:26 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQr-0004th-O2
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:24 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b4c5467617dso2551297a12.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532829; x=1757137629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vbFeQV0K1TVc88E0Uc3H4R+W+/5rMHvP3/tlvF/jUrs=;
 b=Dh2jXL3EWhMyt58mHr9q2THwyHuGUZUEp+kLcBJw3TIWtexPFcE98MVvlIpRFaN+vG
 VsUsheKBbZ1M0eWEKxHtLp7kNkK5DABO54/9YOGm8T7w655J6YawKlCL8wDwYEpoZLWk
 T6xrFn30jKK1qI6d/ugUnevc1FWnZoWecJh3CHyWPv4Sht4GkrRiWiHv7OybWXmSgBwI
 NNrqmHKOR1wx6jrprsagH+kfX4pWyOqZF+HPw98JniEHbcdVz/8k7kgFPMOMUXBwBtzb
 PbllBE6wf+ieiGxNcuCDljdaGFJyaDM2+zGschV9xBfhAGdMb3ZjTZnM7Mlk+/Tsazsv
 WFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532829; x=1757137629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vbFeQV0K1TVc88E0Uc3H4R+W+/5rMHvP3/tlvF/jUrs=;
 b=XNUkI8QVMqcpPJmGMuYfYFjvn2ZFPK4BrRyBGSWAXX76dI6EdjSs8Mkbm0PN0VF28T
 6vGSkRZC/pbOWKrLLgSAwJWFjTAYEa3sJrcksB6lBIlUBvevyb8rJNou5o1W1MBHiK1z
 GZpaoZDZS1+G2LNKpr3C5ziN1KnPVsldHmyN+hoXC65vf+2fxJde330RhRAvVSsvfHUe
 ZhrYhga/jOUV4pM0H2EkT1rwoZFe40bsGAVwnrzPtA1XTPl7E4sJ6iNBUdoOgYnLJZSu
 9L7SAlgp66GgR4RxQLXuuyAqF/1B7Op64i9w696vawKESVaFtEgHjcDCwNtueoUUPHHa
 oZyg==
X-Gm-Message-State: AOJu0YwdTcDbRIpPLn5t9gsfLO4EBF7E8+MFykdKrs3tFZCpAFwgaHLK
 njTXQ+jSdpSrLmUlR3dDPZdcpUMbSI0HRHVtw4/3BH8p5IEnTlxkMZdpnB5wB3CaQfwdCNhOr56
 Dng0jAAg=
X-Gm-Gg: ASbGnctdb/e7D+uryW+qudJnQ0JSk5l+XXRQBfILXVOPv/Cg1tgnASmO0W3qhiB35L3
 zSmJXff6aAUuccQB96oqsJcl2rq7UzL0KvJIlDsqBMVD6geKMmhz5URlx1+CW6miBqWS69EpfQy
 BcR8zM45ZhuceAoyTWwXSH3IEvq7HdEqxErVeoNOXS8kwlZ+MXFREJtjPNKwxE/UY0LIT8cdaeO
 Lev0l1pXptu4tWx1BYICYUnBOr4vkiyJOqKOc/6UwuQZHgJWGZtTUedNQ8hAo+nTXCBh8Py2mJ3
 tjtKtm0p86yhQIW0uSjs1JIk/Z19XJynPFtgq7PmKliVz3AwHMib2iltbBFCZP3tcYk1vZDrNTl
 8E/LDrtvOys+nnzBeYR7Pr0vRDRcyE+L9ZUEtfVSjW57vjpl8a+mAHGj1R7QDzQk=
X-Google-Smtp-Source: AGHT+IFsFgdW+AfxCRB4F1bk4XXD3cxzPDTbz56XnarM9qc+JqIBtiEQ1Iy+TfCEhTuWiy0j0V4DKg==
X-Received: by 2002:a17:903:283:b0:249:2cef:1cfe with SMTP id
 d9443c01a7336-24944880455mr15356135ad.6.1756532829351; 
 Fri, 29 Aug 2025 22:47:09 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:47:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 54/84] target/arm: Introduce delay_exception{_el}
Date: Sat, 30 Aug 2025 15:40:58 +1000
Message-ID: <20250830054128.448363-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

Add infrastructure to raise an exception out of line.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h     | 20 +++++++++++++
 target/arm/tcg/translate-a64.c |  2 ++
 target/arm/tcg/translate.c     | 53 ++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 1479f5bf74..a40cbd4479 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -21,9 +21,25 @@ typedef struct DisasLabel {
     target_ulong pc_save;
 } DisasLabel;
 
+/*
+ * Emit an exception call out of line.
+ */
+typedef struct DisasDelayException {
+    struct DisasDelayException *next;
+    TCGLabel *lab;
+    target_long pc_curr;
+    target_long pc_save;
+    int condexec_mask;
+    int condexec_cond;
+    uint32_t excp;
+    uint32_t syn;
+    uint32_t target_el;
+} DisasDelayException;
+
 typedef struct DisasContext {
     DisasContextBase base;
     const ARMISARegisters *isar;
+    DisasDelayException *delay_excp_list;
 
     /* The address of the current instruction being translated. */
     target_ulong pc_curr;
@@ -365,6 +381,10 @@ void gen_exception_insn_el(DisasContext *s, target_long pc_diff, int excp,
                            uint32_t syn, uint32_t target_el);
 void gen_exception_insn(DisasContext *s, target_long pc_diff,
                         int excp, uint32_t syn);
+TCGLabel *delay_exception_el(DisasContext *s, int excp,
+                             uint32_t syn, uint32_t target_el);
+TCGLabel *delay_exception(DisasContext *s, int excp, uint32_t syn);
+void emit_delayed_exceptions(DisasContext *s);
 
 /* Return state of Alternate Half-precision flag, caller frees result */
 static inline TCGv_i32 get_ahp_flag(void)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ca1633540f..1175d37c87 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10562,6 +10562,8 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             break;
         }
     }
+
+    emit_delayed_exceptions(dc);
 }
 
 const TranslatorOps aarch64_translator_ops = {
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index f7d6d8ce19..c4dd3a747c 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -1090,6 +1090,57 @@ void gen_exception_insn(DisasContext *s, target_long pc_diff,
     s->base.is_jmp = DISAS_NORETURN;
 }
 
+TCGLabel *delay_exception_el(DisasContext *s, int excp,
+                             uint32_t syn, uint32_t target_el)
+{
+    /* Use tcg_malloc for automatic release on longjmp out of translation. */
+    DisasDelayException *e = tcg_malloc(sizeof(DisasDelayException));
+
+    memset(e, 0, sizeof(*e));
+
+    /* Save enough of the current state to satisfy gen_exception_insn. */
+    e->pc_curr = s->pc_curr;
+    e->pc_save = s->pc_save;
+    if (!s->aarch64) {
+        e->condexec_cond = s->condexec_cond;
+        e->condexec_mask = s->condexec_mask;
+    }
+
+    e->excp = excp;
+    e->syn = syn;
+    e->target_el = target_el;
+
+    e->next = s->delay_excp_list;
+    s->delay_excp_list = e;
+
+    e->lab = gen_new_label();
+    return e->lab;
+}
+
+TCGLabel *delay_exception(DisasContext *s, int excp, uint32_t syn)
+{
+    return delay_exception_el(s, excp, syn, 0);
+}
+
+void emit_delayed_exceptions(DisasContext *s)
+{
+    for (DisasDelayException *e = s->delay_excp_list; e ; e = e->next) {
+        gen_set_label(e->lab);
+
+        /* Restore the insn state to satisfy gen_exception_insn. */
+        s->pc_curr = e->pc_curr;
+        s->pc_save = e->pc_save;
+        s->condexec_cond = e->condexec_cond;
+        s->condexec_mask = e->condexec_mask;
+
+        if (e->target_el) {
+            gen_exception_insn_el(s, 0, e->excp, e->syn, e->target_el);
+        } else {
+            gen_exception_insn(s, 0, e->excp, e->syn);
+        }
+    }
+}
+
 static void gen_exception_bkpt_insn(DisasContext *s, uint32_t syn)
 {
     gen_set_condexec(s);
@@ -8107,6 +8158,8 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             gen_goto_tb(dc, 1, curr_insn_len(dc));
         }
     }
+
+    emit_delayed_exceptions(dc);
 }
 
 static const TranslatorOps arm_translator_ops = {
-- 
2.43.0


