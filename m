Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 072A7C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm5c-0005os-1W; Wed, 24 Apr 2024 19:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5X-0005mz-SO
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:43 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5V-0003Rd-NT
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:43 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5d4d15ec7c5so331924a12.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001499; x=1714606299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=crVkl8Xc7vAuPRoqIm/BozgxHh6tNXHL1BuEpfh12ro=;
 b=IVTKfYAbajVatPQ60R8narnh5Rqyq+55ZW1pFf3B+cwRIjDa8/NV4HvFwZl9wvymfv
 GLVuFKYbjeLxoLrT2sgdSYHoXZFeB1uJL3aKc28hjETTyejRd6PfhF58lwohkybNcZpq
 hlzHu/tRbusG5eCQ9/1Smmt8X3DzvjYZ1HF45d/BdqQ1T2taw1uL+Hf8+JROLPcmAbZu
 P7egqP9fnHX15XD9hsaB16fAvisfpR3cWZGPuvIWurCNmjh8SVEK1kA/q50XQnMJsMV6
 WamScSfuwrt1x/Gwp1VR1m8OqyqYAI12+wj6WubNOU5e+9nRhrNX2o0t3X5pLdfP7jjC
 Aivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001499; x=1714606299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=crVkl8Xc7vAuPRoqIm/BozgxHh6tNXHL1BuEpfh12ro=;
 b=ry8U/Yh6+V5rcVuwsZIQvVIbp+OypWzUNroeLih0cZ//B5FCyjJmJc7GWK60dyvUqw
 HXUqkWxH5vLTVQSJkO2FETue6FvBOvvZtUIOSc+2PccjAZP1sODSi5csyLQZl31NVU+F
 wB5FYy63QWZiXr3mTr0noSaEijSGvCETSJAw2tnIVCIlob2RlNunl/qGUD48TNGZnVQb
 W+X2LBPA+JQbTl6Y1qshVIEjKOSx6xeDOJmKraZLBqM1PRScD+hyOAJZ+kuMST/ERNBT
 PdworTkmnqLPU8NoTyAEZ8+jVpQ0Qf8Oy4UL+d+U9Ej9kkX/I0fPZy2Z0pdpTJZCGpGg
 vR4Q==
X-Gm-Message-State: AOJu0YxuC6j/VkydVrPwCeN+GMKdx3yM29A8NaYro9b/hAp6Ke1NFyFk
 i4anOXOiPk36UolDkxpKnjAT4VPlLr54lsIferSWTsWbnz0S3lqTe3lnAu0QIzQuQSdp8nQ3FMJ
 E
X-Google-Smtp-Source: AGHT+IEz5e0Lb7lgaH+m38MzaL7rqmv7RJzjxPvhHzRVHL/0SQIt6O61qAo2ZkrWDnDNNU4CsGp6eg==
X-Received: by 2002:a17:90a:4d83:b0:2ab:e09e:fdf6 with SMTP id
 m3-20020a17090a4d8300b002abe09efdf6mr4112705pjh.47.1714001499204; 
 Wed, 24 Apr 2024 16:31:39 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.31.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:31:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/33] accel/tcg: Record when translator_fake_ldb is used
Date: Wed, 24 Apr 2024 16:31:05 -0700
Message-Id: <20240424233131.988727-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h | 3 ++-
 accel/tcg/translator.c    | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 974cc4f9c4..e92dfba035 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -72,8 +72,8 @@ typedef enum DisasJumpType {
  * @num_insns: Number of translated instructions (including current).
  * @max_insns: Maximum number of instructions to be translated in this TB.
  * @singlestep_enabled: "Hardware" single stepping enabled.
- * @saved_can_do_io: Known value of cpu->neg.can_do_io, or -1 for unknown.
  * @plugin_enabled: TCG plugin enabled in this TB.
+ * @fake_insn: True if translator_fake_ldb used.
  * @insn_start: The last op emitted by the insn_start hook,
  *              which is expected to be INDEX_op_insn_start.
  *
@@ -88,6 +88,7 @@ typedef struct DisasContextBase {
     int max_insns;
     bool singlestep_enabled;
     bool plugin_enabled;
+    bool fake_insn;
     struct TCGOp *insn_start;
     void *host_addr[2];
 
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index a3c246ea37..6863455ed9 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -129,6 +129,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     db->max_insns = *max_insns;
     db->singlestep_enabled = cflags & CF_SINGLE_STEP;
     db->insn_start = NULL;
+    db->fake_insn = false;
     db->host_addr[0] = host_pc;
     db->host_addr[1] = NULL;
     db->record_start = 0;
@@ -433,6 +434,7 @@ uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
 void translator_fake_ldb(DisasContextBase *db, vaddr pc, uint8_t insn8)
 {
     assert(pc >= db->pc_first);
+    db->fake_insn = true;
     record_save(db, pc, &insn8, sizeof(insn8));
     plugin_insn_append(pc, &insn8, sizeof(insn8));
 }
-- 
2.34.1


