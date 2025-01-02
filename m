Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10883E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPba-00074b-Sx; Thu, 02 Jan 2025 13:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbB-0006xC-DG
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:11 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPb5-00057a-FG
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:06 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21675fd60feso209292135ad.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841221; x=1736446021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HnxKDoHJjYsHLEyyikcOQtCAq3zFQRM3tX30iJVsB10=;
 b=UHREynFw4ztfehPgQ8+EIhZfkoQgKIPsE7RGVDpCoqz/yP+UtBU7ckx8bnaUEKe14G
 ji5MTNPN63qibv5WxOBxJ/q4J8eJh+YcQM/jQ9xNL96dUL/BnyEZf4rHZeRvnWLQ7sAG
 CtWp06JcuXgYbuUAHVZhp48kKsicsc7YqFOCQjmaa/XIKGjniDs33cJmEn3d05UmiCzp
 aLzJluNRcMzjyhq4N65ChnpQ9JuQasAW5JgjlzFzxYE4vZvL+NVpNzEO8IADyuzvq4u3
 dLYPZYL1WaaEw+WScYWs+idF4x7p/dRDI0XoASYOeheoSjRHD2vsj9+h8wEaD0pz8NPg
 iH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841221; x=1736446021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HnxKDoHJjYsHLEyyikcOQtCAq3zFQRM3tX30iJVsB10=;
 b=V+o7oKvF1muRM+qYnpH8/bTD7cdTFiMHfEYxznRuMNUGuNyg9vGcFsV2VLmKVxfGxK
 i0NYW+Dbe5/hN53Mk882yvbKdCqSbhA06MDrPAga7nJU0FDD5q3oBs0+aLDrKZtshw5S
 hl559bdYHS9dXSzT4RcX3dZo7YKGGJUOcWkDPtKJJAHsIlzcYkoIwA7JcyXd8zuzNyzW
 Rj+8H6HHalXNOTWFLFrsTIHo60iAM9mSwAf6HYLdRF7IRq1jtDHgY00XJok75WQ6ok7/
 +6LTFBL5m6CJzL1dBU3J7VMPKEOe+6dvLPFm4gGr+sIa88UFplpQ32GKHlKiBbIRNaqU
 pBIA==
X-Gm-Message-State: AOJu0Yz8TjRgdIpwnvZzEZkHAy4dSzFLqlD2mA/riBuf403bICXcwoqT
 0Y8/4SV/pG/76GZUxhEnboy1MM2GNsEvHcf0STd39R+3+K5KJMO5iyeTCdo4YCkxDbuBGSi1n1m
 6
X-Gm-Gg: ASbGncsXAXE34xNxJ+pYuGbdEaZAUFprCZJ7T7Jg+DUiSAO8UrmZcS7keKDOaKNXmtl
 Cs3fuIQiLLqbGjjikmoNFZnmBXtqijzzroWmwBFe35rhVnAdMUbAn3336ejZyWYLf6NgDJcXiF3
 NEJ+wkDaHSk5XvZbCfk9nO/pZFEb2dK70wH6iNRnuyuaJfCTk9oAhnWvASlEtGzdBdQZJCQqZMe
 3ljPb0/vezdauonyUxvUI7QYa+rHK3nXYlyWXpRnoIEKfss6lFcG5t8C8NAdg==
X-Google-Smtp-Source: AGHT+IEaoryOA2D3LndZs5e6vVAnadhYw7HwX1OX7KSyFWbZqDmx/HdW9Et0zsYg+Ii6GZdDTFP0GQ==
X-Received: by 2002:a05:6a21:e96:b0:1e1:a5be:299f with SMTP id
 adf61e73a8af0-1e5e082f930mr75076682637.43.1735841221425; 
 Thu, 02 Jan 2025 10:07:01 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/73] tcg: Add TCGType argument to tcg_op_supported
Date: Thu,  2 Jan 2025 10:05:47 -0800
Message-ID: <20250102180654.1420056-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
 include/tcg/tcg.h |  2 +-
 tcg/tcg.c         | 10 ++++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 467de19f58..d8591d6c9e 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -830,7 +830,7 @@ typedef struct TCGTargetOpDef {
     const char *args_ct_str[TCG_MAX_OP_ARGS];
 } TCGTargetOpDef;
 
-bool tcg_op_supported(TCGOpcode op);
+bool tcg_op_supported(TCGOpcode op, TCGType type);
 
 void tcg_gen_call0(void *func, TCGHelperInfo *, TCGTemp *ret);
 void tcg_gen_call1(void *func, TCGHelperInfo *, TCGTemp *ret, TCGTemp *);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 8c76b876b5..3a0ad03fd5 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1947,9 +1947,11 @@ TCGTemp *tcgv_i32_temp(TCGv_i32 v)
 }
 #endif /* CONFIG_DEBUG_TCG */
 
-/* Return true if OP may appear in the opcode stream.
-   Test the runtime variable that controls each opcode.  */
-bool tcg_op_supported(TCGOpcode op)
+/*
+ * Return true if OP may appear in the opcode stream with TYPE.
+ * Test the runtime variable that controls each opcode.
+ */
+bool tcg_op_supported(TCGOpcode op, TCGType type)
 {
     const bool have_vec
         = TCG_TARGET_HAS_v64 | TCG_TARGET_HAS_v128 | TCG_TARGET_HAS_v256;
@@ -6259,7 +6261,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
             /* fall through */
         default:
             /* Sanity check that we've not introduced any unhandled opcodes. */
-            tcg_debug_assert(tcg_op_supported(opc));
+            tcg_debug_assert(tcg_op_supported(opc, op->type));
             /* Note: in order to speed up the code, it would be much
                faster to have specialized register allocator functions for
                some common argument patterns */
-- 
2.43.0


