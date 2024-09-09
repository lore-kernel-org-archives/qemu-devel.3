Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FA1ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 18:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sninJ-0003vM-RX; Mon, 09 Sep 2024 14:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sninI-0003jD-EM
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 14:07:20 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sninG-0001wj-8q
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 14:07:20 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-718d962ad64so3141489b3a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 11:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725905237; x=1726510037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K5QfoW0VwajlTQd3ELmUEuobbsHpYmua9JmMsJd9x1U=;
 b=xhVWo18AbbAe4y00+4ZdWfoYUEE1QQeGW5Y7EOtax6xOoUY/5RoI73LSdZ+AGaC4gf
 TVexuCeTSokLMnq+GGfUD8OaGQ+HYB4KgVRJlydmZLFAvOKuYzYl/0a+8P0BmBcaIrsT
 EKLQmFA13AGLU2IZOH4I6d73AMH+vphgP2qoGQzjfLvyNqc2kzjGANFFSTb6sHRIwO+2
 n0HewXIbvuASucY4OQIDep8jQ/OLS4SVscq7WUYts8P1o0e4UtZHeOFRK/EJDjQeHNR5
 Q4wdC8CsDVDjRf5mLm1D7Q3WT2P+JMVn1x3DbZhwqRr5hwWOiaLcNwO4qOz88AZqT1cr
 FKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725905237; x=1726510037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K5QfoW0VwajlTQd3ELmUEuobbsHpYmua9JmMsJd9x1U=;
 b=a+Fnzjs8vo3xY+tLJnSLPhyqu58OxDXgo1KUuZ3Am4qaWAMhKphBrBxDI6TBY6p7fZ
 nOOu+REN+RxLEPSjYngt3qpG6t5wXBpF8PIx5fm8kFm1KeMJb/NhmrhPUIk86K+o9rQe
 7AduD8lybpIEiczxrZcbnP8ywQN+m1979v3W7dBy+j/6Yp7dN9S4sXgDfdkA41OUXLkf
 K1J/RlHZAhEvW4pXRECwTsm9ttQr88TIbHQ7K1LpRn0cKh+S1aTxxBqUAUCAhEtvPBGE
 igff4D1W70RPQFzF5euLRsMqwYQ27UsyvHsB0l2AUQHArOxhcSeAzcE/LRmAzqogxpf2
 UhJQ==
X-Gm-Message-State: AOJu0YwvBKrTtwsSBULGTe0sk9AQvRlSAEO3N1A7cVVkPam/SUOxw4ZC
 rKSXRjs75W1dH3HgZBezm7La+c7llLy/LuMsmbyNosaXNL7N01PAfuaBuFfpOaXnKOV33zUjIB3
 +
X-Google-Smtp-Source: AGHT+IFZ+++RZnyC73zGY5x8eYgcCbkH3dUP9WNDvLJNfFW++4MZKnixY9HpWFryJn8bO/BzIP92xg==
X-Received: by 2002:a05:6a00:914c:b0:70d:2892:402b with SMTP id
 d2e1a72fcca58-718d5e0f22cmr15600522b3a.7.1725905236673; 
 Mon, 09 Sep 2024 11:07:16 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc84efsm25431b3a.8.2024.09.09.11.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 11:07:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	chauser@pullman.com
Subject: [PATCH v4 3/5] target/sparc: Add FSR_QNE to tb_flags
Date: Mon,  9 Sep 2024 11:07:10 -0700
Message-ID: <20240909180712.651651-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909180712.651651-1-richard.henderson@linaro.org>
References: <20240909180712.651651-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
 target/sparc/cpu.h       |  8 +++++++-
 target/sparc/translate.c | 10 +++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 9f2bc44722..f517e5a383 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -744,6 +744,7 @@ trap_state* cpu_tsptr(CPUSPARCState* env);
 #define TB_FLAG_AM_ENABLED   (1 << 5)
 #define TB_FLAG_SUPER        (1 << 6)
 #define TB_FLAG_HYPER        (1 << 7)
+#define TB_FLAG_FSR_QNE      (1 << 8)
 #define TB_FLAG_ASI_SHIFT    24
 
 static inline void cpu_get_tb_cpu_state(CPUSPARCState *env, vaddr *pc,
@@ -775,7 +776,12 @@ static inline void cpu_get_tb_cpu_state(CPUSPARCState *env, vaddr *pc,
     if (env->psref) {
         flags |= TB_FLAG_FPU_ENABLED;
     }
-#endif
+#ifndef CONFIG_USER_ONLY
+    if (env->fsr_qne) {
+        flags |= TB_FLAG_FSR_QNE;
+    }
+#endif /* !CONFIG_USER_ONLY */
+#endif /* TARGET_SPARC64 */
     *pflags = flags;
 }
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index c803e8d1ba..eb0158a11d 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -185,6 +185,8 @@ typedef struct DisasContext {
     bool supervisor;
 #ifdef TARGET_SPARC64
     bool hypervisor;
+#else
+    bool fsr_qne;
 #endif
 #endif
 
@@ -5596,13 +5598,15 @@ static void sparc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     dc->address_mask_32bit = tb_am_enabled(dc->base.tb->flags);
 #ifndef CONFIG_USER_ONLY
     dc->supervisor = (dc->base.tb->flags & TB_FLAG_SUPER) != 0;
+# ifdef TARGET_SPARC64
+    dc->hypervisor = (dc->base.tb->flags & TB_FLAG_HYPER) != 0;
+# else
+    dc->fsr_qne = (dc->base.tb->flags & TB_FLAG_FSR_QNE) != 0;
+# endif
 #endif
 #ifdef TARGET_SPARC64
     dc->fprs_dirty = 0;
     dc->asi = (dc->base.tb->flags >> TB_FLAG_ASI_SHIFT) & 0xff;
-#ifndef CONFIG_USER_ONLY
-    dc->hypervisor = (dc->base.tb->flags & TB_FLAG_HYPER) != 0;
-#endif
 #endif
     /*
      * if we reach a page boundary, we stop generation so that the
-- 
2.43.0


