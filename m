Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6428CD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt8E-00025W-51; Mon, 08 Apr 2024 13:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt8B-00025I-Kw
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:07 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt87-0003iK-Su
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:06 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5d8b519e438so3614117a12.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598602; x=1713203402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qu730y1a5bhHx8+lUgk6PRHwUAMG8x1kinVBmiKeHm0=;
 b=vI2pmm2TEE8vOsPc6lNg7hgoAgdjIBFo6JXJ90bgajS7PuYXi73T4axnj0C9NHVgdn
 /sPRaX39aubUzaU8D6C7OMtlvmjUJe48e8EZFg+CailJn8zB3STx666JwYZHF1/1lagQ
 K2Imze+1M2jiaO8IJvSNsZu74+8/6TETJoa6WGr8zbg4hxJtlYDb6PJBKKFiL9WwvSOK
 SMiYfUlqWuR0JetTYCQgfygGZ85C+GIRs3Typ88cLzJsN/flTM/JF2zhzWi9LBkMbOKl
 9Zl/5b1SOxheUIIEsLE0IZUZYE70JmSO4xf7WBMOHZdy3WwyZAqCQapaii/RQNGXSFAA
 IK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598602; x=1713203402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qu730y1a5bhHx8+lUgk6PRHwUAMG8x1kinVBmiKeHm0=;
 b=b7aIrhb0+/V1lrEwO7yqXp1g6bMpmW36eRn7mI7P1617DXtRNXmzlJi8Ds5BpjmHSq
 mwaSZjc2rMAwAl2UUqQxExzITjYsn/Q4/am9Xehf8GGNT8tnOblzOZgn64NumKZZfSRO
 XhkPfuStvjCkXWLR5IHg9sUNlpHHYYVlfOF4nGlOOcgn3T918p8lctV/4mjOPL2htiGF
 pYrUqkyPFjQ27gITEzPte8Xm5eIgdOuR2DkkNy3IFi1m70tWzRmk28KYJVkcR6g+T4ng
 UgVjMRldK8WCU0f+a/WZ/k+IJvFgICW1gM/hx2qZmXsRFd7Gq+OM2LoDynWadEgmR0Xe
 oFZg==
X-Gm-Message-State: AOJu0Yx595EMx82qBLCpHFpfyk5BXHDoPmYfi4cqNAC+TaGWAeduMQ97
 hRWcRInK98tqhJhPPu8+/hZKqZSE+/rvP0NaIhB3WgVChBpgr2RAjBCd51tT02IW0Mn4lBpf1ik
 v
X-Google-Smtp-Source: AGHT+IHFcIR8z+B7jJzXE6Jg8Ddatpwu59X/CvKq3s9JwUZxTDT/5HC+DXGEKysqKZyagcUdvdXDmA==
X-Received: by 2002:a17:90a:df15:b0:29f:ce37:50d8 with SMTP id
 gp21-20020a17090adf1500b0029fce3750d8mr6907984pjb.17.1712598602447; 
 Mon, 08 Apr 2024 10:50:02 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:50:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/35] target/arm: Use insn_start from DisasContextBase
Date: Mon,  8 Apr 2024 07:49:15 -1000
Message-Id: <20240408174929.862917-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

To keep the multiple update check, replace insn_start
with insn_start_updated.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h     | 12 ++++++------
 target/arm/tcg/translate-a64.c |  2 +-
 target/arm/tcg/translate.c     |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 93be745cf3..dc66ff2190 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -165,10 +165,10 @@ typedef struct DisasContext {
     uint8_t gm_blocksize;
     /* True if this page is guarded.  */
     bool guarded_page;
+    /* True if the current insn_start has been updated. */
+    bool insn_start_updated;
     /* Bottom two bits of XScale c15_cpar coprocessor access control reg */
     int c15_cpar;
-    /* TCG op of the current insn_start.  */
-    TCGOp *insn_start;
     /* Offset from VNCR_EL2 when FEAT_NV2 redirects this reg to memory */
     uint32_t nv2_redirect_offset;
 } DisasContext;
@@ -276,10 +276,10 @@ static inline void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
     syn &= ARM_INSN_START_WORD2_MASK;
     syn >>= ARM_INSN_START_WORD2_SHIFT;
 
-    /* We check and clear insn_start_idx to catch multiple updates.  */
-    assert(s->insn_start != NULL);
-    tcg_set_insn_start_param(s->insn_start, 2, syn);
-    s->insn_start = NULL;
+    /* Check for multiple updates.  */
+    assert(!s->insn_start_updated);
+    s->insn_start_updated = true;
+    tcg_set_insn_start_param(s->base.insn_start, 2, syn);
 }
 
 static inline int curr_insn_len(DisasContext *s)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 340265beb0..2666d52711 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -14179,7 +14179,7 @@ static void aarch64_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
         pc_arg &= ~TARGET_PAGE_MASK;
     }
     tcg_gen_insn_start(pc_arg, 0, 0);
-    dc->insn_start = tcg_last_op();
+    dc->insn_start_updated = false;
 }
 
 static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 69585e6003..dc49a8d806 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -9273,7 +9273,7 @@ static void arm_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
         condexec_bits = (dc->condexec_cond << 4) | (dc->condexec_mask >> 1);
     }
     tcg_gen_insn_start(pc_arg, condexec_bits, 0);
-    dc->insn_start = tcg_last_op();
+    dc->insn_start_updated = false;
 }
 
 static bool arm_check_kernelpage(DisasContext *dc)
-- 
2.34.1


