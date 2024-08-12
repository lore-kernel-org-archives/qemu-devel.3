Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8490DC52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 02:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdLGv-0004cx-Mm; Sun, 11 Aug 2024 22:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdLGu-0004Xt-Df
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 22:59:00 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdLGs-0003j9-R0
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 22:59:00 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-710cad5778fso3177657b3a.3
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 19:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723431537; x=1724036337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pjjxaw7LIZTt8dz5CemMFoHd+/gcNlB7CUIggpOtFAI=;
 b=iM5OFsY5VRRpEut3JJpQHSUuo9coM8JBMP9b5fDD6rhvqpWG9gPPZt36Dqg1XzHe6s
 4nWY00i8F8nBxcSHt2CBGPKWIFy4u18++ZAs+n7/tXspH6McOR/xzY+Qhxt2+CSTkFwu
 Y+v0HrJjkbBg3vdJle4jCV6o5iCzqcyNlvWkBKhzf7LEe1INcZgoW9W8RnmIEwHEGlfb
 fQgWZ3mP78NdzM98Te3RITVix5w6gwbyhhDzkNinjfIJgAW57a0eeBWhdUOKMFiIdHIZ
 oK0eSTTubmwS0zLXg7YhBLtQDJq+OyavQ0qonDvW1XwBzw0iG9fyBVM3yAz9n7MCNi9y
 +81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723431537; x=1724036337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pjjxaw7LIZTt8dz5CemMFoHd+/gcNlB7CUIggpOtFAI=;
 b=m99MhcJhmVlZm+X7lbgpGzVvnEBGBzpH75lmzu2Deth7EDmZxpC0qHIVJkbtYtZEFs
 KnsDEEfM5tXR9t/Y0QZtPW1fqw5EY7e03yAZlwbeaUfqxWrtEbgb9vW4HvtcklGZ2j/j
 JQwvGdlrABPvUuPaFjzYPMAcaIoOrKryEi9V59pRLStkdwBLdYjTbQ47U+OT4PmVzHCt
 3t8kdK6uyJrCqpGpDZLAwDFZLkQXssCn0wDtBFA7FC1HXjAkpUmbOEmcyAqpDz342hpq
 /JWmrt4ZiHqJ9LeQYWWwG7eJFzNuE/WoJedcORnJsP9Al55IxIWH25Yqdx/o5IAfBqCi
 uvRg==
X-Gm-Message-State: AOJu0YwReLyU75YXgt+fbTxCrhaWkRH18jGWsgK6Gc5TXu0emUNsi2Eq
 AZMqttaDszE6dc0Da3sb/ExW3QagxDHhgRLby9xKWAS7+D9leo7CfE7gwJJBD7EmJvodKnDtr8k
 IBjo=
X-Google-Smtp-Source: AGHT+IHKNm8zrygOUgyHLXNQPv+XO/rn4bOYa4w/tzofzuX9wa/w+x66j6AxgAF7k6Pa/S9dJsLIGA==
X-Received: by 2002:a05:6a00:17a9:b0:70d:22b5:5420 with SMTP id
 d2e1a72fcca58-710dc75f7f8mr12238672b3a.15.1723431537429; 
 Sun, 11 Aug 2024 19:58:57 -0700 (PDT)
Received: from stoup.. ([203.30.4.111]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e5a43b49sm2984841b3a.100.2024.08.11.19.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 19:58:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH 3/3] target/i386: Assert MMX and XMM registers in range
Date: Mon, 12 Aug 2024 12:58:44 +1000
Message-ID: <20240812025844.58956-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812025844.58956-1-richard.henderson@linaro.org>
References: <20240812025844.58956-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The mmx assert would fire without the fix for #2495.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/emit.c.inc | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 016dce8146..747ff71b33 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -33,8 +33,13 @@
 #define TCG_TARGET_extract_tl_valid     TCG_TARGET_extract_i32_valid
 #endif
 
+#define MMX_OFFSET(reg)
+  ({ assert((reg) >= 0 && (reg) <= 7);         \
+     offsetof(CPUX86State, fpregs[reg].mmx); })
 
-#define ZMM_OFFSET(reg) offsetof(CPUX86State, xmm_regs[reg])
+#define ZMM_OFFSET(reg)                        \
+  ({ assert((reg) >= 0 && (reg) <= 15);        \
+     offsetof(CPUX86State, xmm_regs[reg]); })
 
 typedef void (*SSEFunc_i_ep)(TCGv_i32 val, TCGv_ptr env, TCGv_ptr reg);
 typedef void (*SSEFunc_l_ep)(TCGv_i64 val, TCGv_ptr env, TCGv_ptr reg);
@@ -168,7 +173,7 @@ static int vector_elem_offset(X86DecodedOp *op, MemOp ot, int n)
 static void compute_mmx_offset(X86DecodedOp *op)
 {
     if (!op->has_ea) {
-        op->offset = offsetof(CPUX86State, fpregs[op->n].mmx) + mmx_offset(op->ot);
+        op->offset = MMX_OFFSET(op->n) + mmx_offset(op->ot);
     } else {
         op->offset = offsetof(CPUX86State, mmx_t0) + mmx_offset(op->ot);
     }
-- 
2.43.0


