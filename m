Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C90E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:06:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4XZ-0000mb-NY; Tue, 07 Jan 2025 03:02:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wh-0000CN-Ip
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:25 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wg-0002tF-0t
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:23 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ee50ffcf14so19718545a91.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236881; x=1736841681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jm7X5Cd1DQkuGxOq931a7BLIyMxhj/A/1YGJ9hf47Kk=;
 b=Z5fIzzdu3WPDWNx9YNLScZqbcVAKvb+jmrcxl1vDtuOvtntY71WQuvgTkrU1wJxh18
 R0PLG1YISsqUKdynfjUGuw2frqXB5F51WQwLqyEpH+M/8VnbDzMu6rDiowPUKbFUMtK4
 61ZybVV0QXCy8lS30R2Wu+DqshG+PYjNQRFb9pD2GxwHUBHuW4jU4xjNPgZWSEBtYOZ8
 +oaDkxPMfkQdhpgzm2P9iHGbQeLMyVdfgj9qaNPQZHMk6r3BidZvtwc26WAMHEDOcJjU
 KEbTNppf8RJzyi/GBf/r0+3I8xeNW9aknJVLLUnBl/9G2foKz+QAjAtXFHdVJglQsswQ
 D8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236881; x=1736841681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jm7X5Cd1DQkuGxOq931a7BLIyMxhj/A/1YGJ9hf47Kk=;
 b=ZPkHGbyYS75MpHrRNVxT+jMf4BIcOvGEfj8V2yu3PGIL04Q1HprZAy/O3O+3aM88df
 OCKAWfBcWjDroXoLWv0vWaPZuvuenFpWRzySw4RPb7BhvuvYSv1ozhpoEEZ0V9lZrT+d
 862hdD+t0NGgLqPrdZzJprPttwXz5O/+MzkYIJ+BZLH3vBzxTLTZjs3c0c42LTPszm2M
 VcfUDz9OKQJ95m6f8n4kI6q9nxpD37XRmICcx/HJ/GiFHsAx0Wok7zNBIIOktgKbr+n6
 BfQ+qlnghbu6GkyM6FDn5WEX8mlPeSzZ5nGmZlTniw4pJg3hE9R3NVASibOF/Qpl7JWq
 ifXA==
X-Gm-Message-State: AOJu0Yytp4E1GEVDSCtzdLUUelBeK732qi3MayISEr1Al6BdyQh5y8Kl
 eHa8Eq6LOyY6EVakOXHFLwKZ1IHRu8gOzNBb3rOKF2EB2hYJT4awQWSLI+MioOy51OeKn54enZ/
 Q
X-Gm-Gg: ASbGnctRHG/yb+LOnxhzR03Ri6iDmQeHrQ2nYvlDS/91bTWtlGVMyhjHU36nTvPjKFO
 sGNwzdsp4fLeezF94DFcXPr4moYssYp+Gq2PQu8hFY8/FC08BxT7gYFAXBE2HexG61ve2ykd3Q9
 FSv+kFi9UuuaKWbdaCawddKRmNpb+c9JzsOMx+dYhntxXvpqOQ7gd31sq3afP45INSES8peGO53
 QBsh/XPjrQfDU3+QVaEFI2PA0BtcAvSCJv59EKYWNIhRNNdZzZHLh44bA20zoXZg++T+TAILhCi
 SxDtaE8A95ndpCpDrg==
X-Google-Smtp-Source: AGHT+IFBs/TJT5sARSqRqX6ggeSF6bCuxcUTa1gTikRo73Kzhfd7t11vRyRMRGNZuamfJ1y0FqkoaA==
X-Received: by 2002:a17:90b:2f08:b0:2ee:5c9b:35c0 with SMTP id
 98e67ed59e1d1-2f53cc0026amr3377849a91.9.1736236880696; 
 Tue, 07 Jan 2025 00:01:20 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 06/81] tcg: Add type and flags arguments to tcg_op_supported
Date: Mon,  6 Jan 2025 23:59:57 -0800
Message-ID: <20250107080112.1175095-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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
 include/tcg/tcg.h |  7 ++++++-
 tcg/tcg.c         | 11 +++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index e80b1f6efc..0fc9a94007 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -834,7 +834,12 @@ typedef struct TCGTargetOpDef {
     const char *args_ct_str[TCG_MAX_OP_ARGS];
 } TCGTargetOpDef;
 
-bool tcg_op_supported(TCGOpcode op);
+/*
+ * tcg_op_supported:
+ * Query if @op, for @type and @flags, is supported by the host
+ * on which we are currently executing.
+ */
+bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags);
 
 void tcg_gen_call0(void *func, TCGHelperInfo *, TCGTemp *ret);
 void tcg_gen_call1(void *func, TCGHelperInfo *, TCGTemp *ret, TCGTemp *);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index f2bbff8079..43293ca255 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1931,9 +1931,11 @@ TCGTemp *tcgv_i32_temp(TCGv_i32 v)
 }
 #endif /* CONFIG_DEBUG_TCG */
 
-/* Return true if OP may appear in the opcode stream.
-   Test the runtime variable that controls each opcode.  */
-bool tcg_op_supported(TCGOpcode op)
+/*
+ * Return true if OP may appear in the opcode stream with TYPE.
+ * Test the runtime variable that controls each opcode.
+ */
+bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
 {
     const bool have_vec
         = TCG_TARGET_HAS_v64 | TCG_TARGET_HAS_v128 | TCG_TARGET_HAS_v256;
@@ -6243,7 +6245,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
             /* fall through */
         default:
             /* Sanity check that we've not introduced any unhandled opcodes. */
-            tcg_debug_assert(tcg_op_supported(opc));
+            tcg_debug_assert(tcg_op_supported(opc, TCGOP_TYPE(op),
+                                              TCGOP_FLAGS(op)));
             /* Note: in order to speed up the code, it would be much
                faster to have specialized register allocator functions for
                some common argument patterns */
-- 
2.43.0


