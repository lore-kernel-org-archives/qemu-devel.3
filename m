Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804A3E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1Mw-0007Sr-8y; Thu, 19 Feb 2026 05:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1Mj-0007MG-R4
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:37 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1Mf-000687-JW
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:37 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4836f363ad2so8324485e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497269; x=1772102069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lZndRA2RPmrGOufck7hN6hmXu4KN8EqE/xzqhFFCtkw=;
 b=pwZMRfC5vTSOSufDanikhY7wY3SivzDLM1R9Cp2VJCsdzzfrFBI9YhLvqYC6canS2o
 Tg5t3J8D58aC7dSd9E/zp17uZXtBfHOxzvzPdVyKsge6pAhi6qWoj/xE6Y5ME08bln9g
 bTZOl8vW9DJ37Yx5lapCNmSDl+M38HZ+6RtvR7dLarof3F3EJMXpuPU5T4il4//oiNde
 p8scam5csiuqB4YNEPT9wDOrub+MWAFKBctX1RY8da73sNeYWEsIBXp0PXjCKiDKdZle
 l+nD6cAc5VbR3ygkwu2fUTtPX84nkAQ6djv46BOxoEZPjPnoa3bXXaeKWIVh1HlyCpZz
 EfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497269; x=1772102069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lZndRA2RPmrGOufck7hN6hmXu4KN8EqE/xzqhFFCtkw=;
 b=S60QFj4iUu/wFOjb+xGsiiVki8zunw67wL4p5W7IgsKS5ueEEEcqjbpRpehA/vV4F6
 Em12GcHH4b1imz+XY4u9pLhVhKJ5NINT8heTgRKKB5ylgrsWEd2SB1pCAa3SNWbUIQzR
 xTk9qtGO4ldX77UjCYfO3CNbuKBLGRn6XIVAUtNvYycahAfIgZOsunGKsoD4KvVU499N
 3rikwatcwP5DzfxeYCE6t4b33OyWn8kg7ksaNga2cKSmfE/FkMytd7Z5whamKQd6dVz8
 pveJ7qlkJ303gJW5FFnAdzUSu3/oA3xVSJ/J4QmS57blBx4KsWtC+jBlJaNCvah3uN3D
 J79Q==
X-Gm-Message-State: AOJu0YwXzTDipASR7RjaZ9XWZDx44AUlzW46sdf+l1pQP6JfRDxdWq/U
 luwjynFtXwJHk857WFRJbnhbM/xE53GYKkEH6rtYoiK1AoSRKCISY3I9hHsrV8pdwObQwRoStdy
 TZjTn
X-Gm-Gg: AZuq6aKvZ0EyzG6SjDax2iCf57JsTzgund8VJMAIUjyGHHhW0czfjQW9UlhpgBx+bCd
 Ug2gHhyzT5lsIMiIY81tG48Q6D7bnMTYReaQr2e4FxE6plv8/jxy/V3R2w5+DlnuR+etwoseFUF
 PqXfYp0S/ZSX8n7QAssPpmGoLkOaaF9SRMWZ8+9tjcJaWwckt++L94YIvBy0uFdTDfb0KiW6/M2
 UsU7FJH95HnHdMjg+IkcX117/+HynYG8FDlQtS147OPDEDiE9aSuZ1igmD3f0KUjRdx2V//xIJm
 j6EaHYFvHo5ZWv4IZfQjDDmiNnFYO7OoBlr8QDN6NQWtghZbRj0VhTtz+1l3/SosDgFXtOJ1QyB
 F024bclDrfXkr2SJjH7K2S5d4IiuOzZIwa7/Ti2gxOPw02UZ3Ottygo/XCvfCktXcJ/tQTFGk9B
 ZzqUp56s/nJ+1kmKwyJGGnzSBDi1jcsHIsnywDlofCbtnn3Z++sWlLjHkFKhvWrwIxLr3391U4F
 9YXGwSnhtOoqyjimWjeIXjmFhxNauk=
X-Received: by 2002:a05:600c:314f:b0:483:6fe1:c057 with SMTP id
 5b1f17b1804b1-48373a3f3bcmr329895765e9.21.1771497269388; 
 Thu, 19 Feb 2026 02:34:29 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/32] tcg: move tcg_use_softmmu to tcg/tcg-internal.h
Date: Thu, 19 Feb 2026 10:33:58 +0000
Message-ID: <20260219103405.3793357-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

In next commit, we'll apply same helper pattern for base helpers
remaining.

Our new helper pattern always include helper-*-common.h, which ends up
including include/tcg/tcg.h, which contains one occurrence of
CONFIG_USER_ONLY.
Thus, common files not being duplicated between system and target
relying on helpers will fail to compile. Existing occurrences are:
- target/arm/tcg/arith_helper.c
- target/arm/tcg/crypto_helper.c

This occurrence of CONFIG_USER_ONLY is for defining variable
tcg_use_softmmu, and we rely on dead code elimination with it in various
tcg-target.c.inc.

Thus, move its definition to tcg/tcg-internal.h, so helpers can be
included by common files. Also, change it to a define, as it has fixed
values for now.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260219040150.2098396-8-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/tcg/tcg.h  | 6 ------
 tcg/tcg-internal.h | 6 ++++++
 tcg/tcg.c          | 4 ----
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 60942ce05c..45c7e118c3 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -445,12 +445,6 @@ static inline bool temp_readonly(TCGTemp *ts)
     return ts->kind >= TEMP_FIXED;
 }
 
-#ifdef CONFIG_USER_ONLY
-extern bool tcg_use_softmmu;
-#else
-#define tcg_use_softmmu  true
-#endif
-
 extern __thread TCGContext *tcg_ctx;
 extern const void *tcg_code_gen_epilogue;
 extern uintptr_t tcg_splitwx_diff;
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 2cbfb5d5ca..2615684612 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -34,6 +34,12 @@ extern TCGContext **tcg_ctxs;
 extern unsigned int tcg_cur_ctxs;
 extern unsigned int tcg_max_ctxs;
 
+#ifdef CONFIG_USER_ONLY
+#define tcg_use_softmmu false
+#else
+#define tcg_use_softmmu true
+#endif
+
 void tcg_region_init(size_t tb_size, int splitwx, unsigned max_threads);
 bool tcg_region_alloc(TCGContext *s);
 void tcg_region_initial_alloc(TCGContext *s);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index e7bf4dad4e..3111e1f426 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -236,10 +236,6 @@ static TCGAtomAlign atom_and_align_for_opc(TCGContext *s, MemOp opc,
                                            MemOp host_atom, bool allow_two_ops)
     __attribute__((unused));
 
-#ifdef CONFIG_USER_ONLY
-bool tcg_use_softmmu;
-#endif
-
 TCGContext tcg_init_ctx;
 __thread TCGContext *tcg_ctx;
 
-- 
2.43.0


