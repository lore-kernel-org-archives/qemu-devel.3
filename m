Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609B7E7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbY-00073t-PG; Thu, 02 Jan 2025 13:07:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbI-0006yg-1j
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:19 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbD-000594-La
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:13 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2163dc5155fso155960875ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841229; x=1736446029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vg7+1k12SCK3772zmTTBURMxu0QIKGQ2aPdqMP8kfMg=;
 b=CwcFAD/1oEDAFJpJEgVkNRXBLEibbS8fR5Ze9KNFQedpdeYBKJqf26hZdQKbWLp/N0
 cjYAl+EdPwjA+vWVF3ZlmDKUfNwxZycM4NarIZaB+TGhje+zkK6o8CQ+tZNexFt9tffi
 JWLr6B6sKl/tx01OkY2Aw78YN4d1ClI6PN0aZtqYMyvUXO4doEjKehD8E6FuCki8J4Gm
 A1pTwO1k0a5iMSNkN4EIjidV/mgzXIjdLZAKW3Sdd56q6jVO14yjWkj2rYws6PGOJTEb
 az0k6XoELR2Vsx/w+4r1/E3qthqVUH6GgyfzlLkgQpMc3c1v0WQZTD7nI2vjsxYZym5T
 InbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841229; x=1736446029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vg7+1k12SCK3772zmTTBURMxu0QIKGQ2aPdqMP8kfMg=;
 b=ANZnIm62udffMLz3oeBVYt0ln2ULkDQWnm3ILfdY4jVhvFN6EOouYHZm01gGFaRAj9
 +U7id732nAWso/4ev7i7GmyWXCqwWrHa0BV/UWlYpeQazSMn34JWE9UqlGb2tgPTy8GY
 iXhvt7cs7AD49ggyeGzmktLNoAu9CJt/+e9JsPN5FclWgLy5eLntTe03WZUB1Mat2e8C
 2Nl1gbOIockw3Qv5ZkaoPs2OqfIp4tkksPtGSTkS075MGbVLZv4qjRgsxRPjqaccSKEE
 XGfZlJSIgN3ekRmNkkozh9uZ3+mMIvWcu0AanswlgYuxGMKp/3UlMoCnWHyRm/gjU9it
 /msQ==
X-Gm-Message-State: AOJu0YzshCZtsT+fiIGGT8PGGRPnxcphrs4Okfobr84cxDt1l7RknfpA
 ks3opDslZHjaVFGrOMGcwuvQQkxEg0wdIhQsdReMAA5+wRm/Jfuuca1jO5/nJ7xwhxnpQqzIcyb
 1
X-Gm-Gg: ASbGncsbqBPET9Srnuw/wYpVqZ4XmSQBhZPXrCu77CMAIL/46kDXDAQ6PQwOpp/2703
 81Wi/Zq4gGBGszUc+uRidcTpGdQv/pcLKePMXvPqhMG9xh15vUmHF/XxfX8BwLYJGgSHYT3QVJM
 pdz8voo222JcbRTHl5gNccQG+nWc668ukGQoeFRJDLq7lOMRqO7mfwsvR1i97tsqX9hiPaAw/Qn
 eqA7teh3YxQMoouXPrDyaogYX/JB7iJVHlGPLvp2FO40yxV0+R9pAWLtGFz8w==
X-Google-Smtp-Source: AGHT+IGX01Otad5cgDRuC6BE8RJjVNTSYcTcR1nZCz8iDf13pjettbjmC7sJmD3S9qGh1X1xKK0b4g==
X-Received: by 2002:a05:6a00:39a3:b0:724:5815:62c1 with SMTP id
 d2e1a72fcca58-72abdeaacf1mr68405754b3a.19.1735841229546; 
 Thu, 02 Jan 2025 10:07:09 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/73] tcg: Move fallback tcg_can_emit_vec_op out of line
Date: Thu,  2 Jan 2025 10:05:58 -0800
Message-ID: <20250102180654.1420056-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Don't reference TCG_TARGET_MAYBE_vec in a public header.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h | 7 -------
 tcg/tcg.c         | 4 ++++
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 01605f30c7..a3bef9c280 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -1010,17 +1010,10 @@ extern tcg_prologue_fn *tcg_qemu_tb_exec;
 
 void tcg_register_jit(const void *buf, size_t buf_size);
 
-#if TCG_TARGET_MAYBE_vec
 /* Return zero if the tuple (opc, type, vece) is unsupportable;
    return > 0 if it is directly supportable;
    return < 0 if we must call tcg_expand_vec_op.  */
 int tcg_can_emit_vec_op(TCGOpcode, TCGType, unsigned);
-#else
-static inline int tcg_can_emit_vec_op(TCGOpcode o, TCGType t, unsigned ve)
-{
-    return 0;
-}
-#endif
 
 /* Expand the tuple (opc, type, vece) on the given arguments.  */
 void tcg_expand_vec_op(TCGOpcode, TCGType, unsigned, TCGArg, ...);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 38c3c03591..38f0ff60e9 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -179,6 +179,10 @@ static inline void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
 {
     g_assert_not_reached();
 }
+int tcg_can_emit_vec_op(TCGOpcode o, TCGType t, unsigned ve)
+{
+    return 0;
+}
 #endif
 static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg, TCGReg arg1,
                        intptr_t arg2);
-- 
2.43.0


