Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93F9C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:01:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIK0-0001YC-Kr; Fri, 10 Jul 2026 16:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIIK-0000m3-JS
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:58:00 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIIB-0001uf-0F
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:58:00 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-381507c9380so1024630a91.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783717069; x=1784321869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dhJDN2Uvwx4DiZ1THGmdkn4VOYJT0oPXA9HE61gRL3Y=;
 b=h/QdwWBgz0GVG6hqf/NW0x1h07nI+8ldm/WOz15+TzZrBhDk0bgPJjqQVO88KWgJFV
 gYwUfjb3vNrCdu2igWekmAjPwNlNsyjQjK9r1/nMqZnR0deyEPNPzOlr0AnthhED5ohF
 pmh8KQNUGqFDlbrvwrJfMeTqgz6IIUN6pf8i2TngOTaskDpmc71xIt5RDILGWgwLlW2W
 dSf4OrUB4EAIgRbyRVAs0L4MsTOUbfsL9PwEEniUrSelJirfgNKTCXS4riLRTYZ1v3Ry
 FgPiKCfXpfHU02+B9mNRKBZrpjJ0GkxttlpiKCuMPrYbQa7HeNSR9oz7PMS02ub3iWG+
 lyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783717069; x=1784321869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dhJDN2Uvwx4DiZ1THGmdkn4VOYJT0oPXA9HE61gRL3Y=;
 b=EQXa3RaY0FVlvasxtvATnNLMVUgBrLwlv9/WppKMfxL0lwJxv0JSvglfNYG0XUH6dt
 J9yZPioxcd8o8jZ/qsgO4T+PdkTUqyQN4K9U9VSRjk5hNqWTxWGVZzNl9kaX3WnlCVB0
 fTk8uBEIqrUz/fxg9VFRN3DiaJSsgLBmHMTWk44KrNtDP4YrYD29AF9SYxYA6DrIdks8
 /own59QjsKC94PCvVIRwbdY7vptb9m0hfJFkGxFU3xVyWKUdnk23TxTS8O+znZs4oghv
 7XVYmBkYeb/q92O1pr+pTgqhI/lkb5/Wcpo6jLXSW/bADTUSntGOLp41nssfLLwX2au0
 UE4A==
X-Gm-Message-State: AOJu0Yxw7rBy28UWfVC6RSh7jQc51ld4TfLkNjne7HPntOspL2Z+745i
 2SU/MymMAsMmdksXatCZSbVwy/96kQFPrGuA/vIGxgUrYtRL9Vq++sTfP+juXf2MKSZZ4aO5t7x
 qmwV8
X-Gm-Gg: AfdE7cmXiGEdfaKN4Yz7ltL6N4kNMWpXMH3iTV30Rq9oG5dms0qYR1arAA5stHoLCFU
 0oyOdQNc6F7i/tr5bR/Oq8uHmYvX7Bq263OIhvy87/0dergRJqkNkX1229JCtbnXB/4RtebU04B
 O57Z5F1iu2FQ+KqHyU++Ro0E+CCw947hDv5gE9b9GB6sroDV7wvvNctYZ6mVxvxASJTsAiHBF6X
 CkEsHZP1yT7KnGt0WLHhJwTkzV7rjiVmTh3Tp/047dN5xEHIKpHPGXKXJK+I3PeuROLlokueRZn
 qnpVjx6sMEl3SMoNKhMn9eJrRVbMOEet0vskmZFDV8GzBtRu0+YzsGHP0Wl4VBmvRZhuNk92YxS
 AgnCw0LJtdCyugE0mt6lzPgyLE/ISQnH8J8Zb1M69uXWwxAaP+Orlv92Z7jRqh3vJvW+0b2foCk
 316wT5iWfCeyFnccw6Bg==
X-Received: by 2002:a17:90a:e7cb:b0:37e:2505:cde9 with SMTP id
 98e67ed59e1d1-38dc75e6c75mr513578a91.13.1783717069354; 
 Fri, 10 Jul 2026 13:57:49 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a58792cdasm3256221a91.16.2026.07.10.13.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:57:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 45/51] accel/tcg: Move ALL_MMUIDX_BITS to hw/core/cpu.h
Date: Fri, 10 Jul 2026 13:53:55 -0700
Message-ID: <20260710205401.836304-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
 include/hw/core/cpu.h | 1 +
 accel/tcg/cputlb.c    | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index c4c86b8595..3d48bc81f2 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -197,6 +197,7 @@ struct CPUClass {
  * Current maximum is target/arm/.
  */
 #define NB_MMU_MODES 22
+#define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
 typedef uint32_t MMUIdxMap;
 
 /* Use a fully associative victim tlb of 8 entries. */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index e2911e3aac..695476eef1 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -91,8 +91,6 @@
  */
 QEMU_BUILD_BUG_ON(sizeof(vaddr) > sizeof(run_on_cpu_data));
 
-#define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
-
 static inline size_t tlb_n_entries(CPUTLBDescFast *fast)
 {
     return (fast->mask >> CPU_TLB_ENTRY_BITS) + 1;
-- 
2.43.0


