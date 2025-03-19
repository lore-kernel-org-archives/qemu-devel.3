Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B43C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 13:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tutlC-00058z-9v; Wed, 19 Mar 2025 09:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tutkM-0003ob-Ux
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:46:19 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tutkL-0004Jw-1C
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:46:14 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso32780645e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 06:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742391971; x=1742996771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=32mireliZ/dTP04oYHZ+DYdxeMqjsmJC3DhlT1EPop4=;
 b=D5uOYWQbgSLrxu6lXueZbRnA646xpJtAWS6eWmrEG54ZyC/SvkQ03o6gpD/kWFIYD9
 IwX8Dq7ZD5NQHmY0Q2uLVyqPEuJ/JWPIFRifhQiMeQZSb4+Zqp7M8ZjekyXW1umoGL4G
 cVKgSIj6ZRRnBvYXp7fAy2dNuOoZtaGeDlC9+4PqpH/6Ssdwh7ualAQPGaTxLw939jKM
 z3lnzapAsVHxp3KHQQaCXhIfZIpmh2NWvYvSrpikBB/++ytS0QoxYjTBeJ4PBNPlyYge
 ZCrAxnG6ho2IDB0lTzHq2EsUdxaHIz7uGQ2O9oerTav57m+ZM1JDoVdMBTX4NZos8EbR
 JqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742391971; x=1742996771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=32mireliZ/dTP04oYHZ+DYdxeMqjsmJC3DhlT1EPop4=;
 b=xB+ADuw92M4sTCCUHhGkWoKeCS9WbrFXoJkGWT1ZCkQ5b6zMeVr4bgFw5SAS5DM4BH
 9wXzBt7kSc9KfoA+XvvG05IXnGada9xkcg0FQFhyTd+dfv3Sok8HPXXxYajr6YFOxHac
 tYkpK7Pz37JOXcr+sOQ2YRJtWcN2qfZ3X5buBIw1S68RB7oDlwN4ubjh9Bch+1/3jsoE
 9ybM1dqsu/C+r5ds7VaaoyFkRl8GZVdM4uuGbSlyrvqDQsb8a6H0cKFNASsibu8nIGkX
 /UFF6Et49CQ2Jj5WGcsbVxB7zy62UZ3zPboUGebKezJZDDBTpf+dueHcPqcGJoAwFimm
 WY2A==
X-Gm-Message-State: AOJu0Yxj+pzsuZoJ8JCGInKNf9TK3VLi3PrOrpI55s9NmiWmU5LOXwyb
 mFz240Z16bP+M9Gb46sKdUX6kjv05ljdQF3uA8DNJKyVWUDNrTHw5teOIPxaPC710XLs5r8JoQB
 f
X-Gm-Gg: ASbGncvSuo5XixZ6F8v2mCCVdCg9Wb90DicBpf6G/ciAlruzfXXSv3bMRiZyubX7h9d
 KphVQJqscYZIG9bG4fly04iAtDcfVSNgl9OfgYHdkV4KaWeNhk2AlA0vZEC/xy3q6WzkAKgNyNa
 QJ67W3k0Tk2eiUF5CpLqTljBZaZhER+WD4+ceq9OsbI3NnLqIADDYGYfo2rJ0iWM2RAnXIEQ7Ui
 CIoBmVJAQYQOAlQQs+d/T64aYRRf/ShBl/rbIvz005rE2GWLXsk3voFGaTX/Lqi98RNGRpRnHWY
 8ENkq9XEfprH8u+ZAcfeM+PHfVPK02pEBD0g7P4PccUXFDie1+LHt2SJg5D+oBYFaRkwyggHpcN
 thSCKRPUBuP+/7yYmtK8=
X-Google-Smtp-Source: AGHT+IFzEqWCZZWPfFgIotp1OH3ucYkN3WVuP9zfofN+Mllp38MhkvTyRe8Phny4sWd19e4RX8yNbA==
X-Received: by 2002:a05:600c:3594:b0:43c:fb36:d296 with SMTP id
 5b1f17b1804b1-43d4383d0e7mr20984915e9.25.1742391971041; 
 Wed, 19 Mar 2025 06:46:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4863b4a7sm3162555e9.8.2025.03.19.06.46.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Mar 2025 06:46:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 12/12] tcg: Uninline tcg_gen_insn_start()
Date: Wed, 19 Mar 2025 14:45:06 +0100
Message-ID: <20250319134507.45045-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250319134507.45045-1-philmd@linaro.org>
References: <20250319134507.45045-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

tcg_gen_insn_start() is now common to all TCG frontends.
We don't need to keep it inlined, move it to tcg.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/tcg/tcg-op.h | 15 ---------------
 include/tcg/tcg.h    |  2 ++
 tcg/tcg.c            | 15 +++++++++++++++
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index cf177a1fd3b..470cb46225e 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -22,21 +22,6 @@
 # error
 #endif
 
-static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1, uint64_t a2)
-{
-    unsigned insn_start_words = tcg_ctx->insn_start_words;
-    TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
-                            insn_start_words * 64 / TCG_TARGET_REG_BITS);
-
-    tcg_set_insn_start_param(op, 0, pc);
-    if (insn_start_words > 1) {
-        tcg_set_insn_start_param(op, 1, a1);
-    }
-    if (insn_start_words > 2) {
-        tcg_set_insn_start_param(op, 2, a2);
-    }
-}
-
 #if TARGET_LONG_BITS == 32
 typedef TCGv_i32 TCGv;
 #define tcg_temp_new() tcg_temp_new_i32()
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 92a23e10218..d87d900bf81 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -609,6 +609,8 @@ static inline void tcg_set_insn_start_param(TCGOp *op, int arg, uint64_t v)
     }
 }
 
+void tcg_gen_insn_start(uint64_t pc, uint64_t a1, uint64_t a2);
+
 /* The last op that was emitted.  */
 static inline TCGOp *tcg_last_op(void)
 {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index e8950df2ad3..904f858e4dc 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3468,6 +3468,21 @@ TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *old_op,
     return new_op;
 }
 
+void tcg_gen_insn_start(uint64_t pc, uint64_t a1, uint64_t a2)
+{
+    unsigned insn_start_words = tcg_ctx->insn_start_words;
+    TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
+                            insn_start_words * 64 / TCG_TARGET_REG_BITS);
+
+    tcg_set_insn_start_param(op, 0, pc);
+    if (insn_start_words > 1) {
+        tcg_set_insn_start_param(op, 1, a1);
+    }
+    if (insn_start_words > 2) {
+        tcg_set_insn_start_param(op, 2, a2);
+    }
+}
+
 static void move_label_uses(TCGLabel *to, TCGLabel *from)
 {
     TCGLabelUse *u;
-- 
2.47.1


