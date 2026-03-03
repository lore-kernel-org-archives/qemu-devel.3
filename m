Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F23EEB3649
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 01:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxEFs-0000G0-C2; Mon, 02 Mar 2026 20:08:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vxEFq-0000FZ-NF
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:08:54 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vxEFp-00072S-4p
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:08:54 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c70bfef17a4so3077353a12.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 17:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772500132; x=1773104932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jULhy8lhH1tb2E9Kn0FQkgiY88soUrfUiGllYAB4CY0=;
 b=bdvUqmOQlWGcY5o2KTQRgpXWb3ZB1ZKLMJ7heJLHHws5j1OKYVF38HfOBfnwf20tmT
 bwsLgIkgiiWs9Jpzn8N1ikfRpbALdTKp7zQY1C3GFl/p7JBHhtev8CtkF9JaEH87Biyg
 Ac59mGMpIVKKo8BbfanRNANgsNfCk77iverXT0dRQ+OfArqo3BIizR7dYymt/v4IrLpq
 60rC9ACMOWYSI5d0UH71w2CL6kRlLiavsPkYbMwXcrb84v4WGcVg67PMEMTI/HGcRqUR
 uJ1GIaz/b+9gXZE5CwbUJtPFc7WG68O+A6LpjyqFv/tkuxcpOWv+RU8yecDul3BvxVwd
 jFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772500132; x=1773104932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jULhy8lhH1tb2E9Kn0FQkgiY88soUrfUiGllYAB4CY0=;
 b=IryHlsU6GxJ5d+491y9VwfjarADbgX9WWIPy7z26Zt/Wr74KYIdJlEiAMCLEBSTocS
 +cwC5zCEAfEwav2jFDr5/OMGay/U9QB8hpc0DdVuIU2uIsYg6SHonUXYpnso90sultUD
 dFjgqvXPDCynMfZCXDreacKjqyObKdUi0yEjc9SlVT6djPqMl+hZtTstZScEAK5fBDCl
 kCQ4FURELTf2Hyi6TxuU1NNgcLGG/jlkWVf0KHPhDYuf5O+Y0B5mdu+riYJb/SbmTQ/I
 /4BoKgAZrzVpSH3yX8CVisDVKY/RJS3wipsw9+fOUJRXijmGwINjWJQhBWFlREU/7W+J
 eYVA==
X-Gm-Message-State: AOJu0YzQMJ+TPWGinqPTJxRimJPk1MEGB/9Ns09EhQNCAf6tZe3ixIYg
 Kn/x7mbCvUbxdHALeIzKaHIzb8QzqUCELc4ed7lzkVXfotMEU7ys69xzos9yX+QheUv2T9RSfE6
 SoRb0KjE=
X-Gm-Gg: ATEYQzzCb4kod6lg//Zes0qevyEmC3ssBCx4trZpQjS/8SwnxC1XYCEIl7bwg2TnIat
 fgrNTcYiDMTl1k3DzlxLxgdkF6Pn/L9EnCUs5qofXPV+uCnF4C2ZZes3SUS6e1dZRm6DDrWXuhq
 P3g8ijR6R0nP3B4rky/7x+cKHEcal9z0+sCq96C5XntPLAm+CG3i0I+7EhzFgas3MTjY/aCE1TL
 AQc5uKzDtwjixFyMZUxOB4xrLBH+9olN9tPC6HuiJZdTp56tPxPQgBPrSQgMMms3Maou2lq8mB6
 /dGKZD2P3qiRzFLB9U7SN96d77of4KJewllDuwCFBdQ+RRV6w5T/W9fsaObE0txcKqAXz1rdg7h
 9VkZKBlQUgUuoPE9OxqD0mI+gXYUtt6+FNDMmWHxy57a8Chf7MYLv5TCdsUdPI5f31wyvtx7KRC
 g4963YlaXKRY4fqiaY/iLgu5IcgmJ9oA==
X-Received: by 2002:a05:6a21:170b:b0:394:76a7:1cf1 with SMTP id
 adf61e73a8af0-395c3a0c99cmr13657978637.3.1772500131436; 
 Mon, 02 Mar 2026 17:08:51 -0800 (PST)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739d94de6sm14484988b3a.24.2026.03.02.17.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 17:08:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	jim.macarthur@linaro.org
Subject: [PATCH v3 5/7] tcg: Add tcg_op_imm_match
Date: Tue,  3 Mar 2026 12:08:30 +1100
Message-ID: <20260303010833.1115741-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303010833.1115741-1-richard.henderson@linaro.org>
References: <20260303010833.1115741-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

From: Paolo Bonzini <pbonzini@redhat.com>

Create a function to test whether the second operand of a
binary operation allows a given immediate.

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[rth: Split out from a larger patch; keep the declaration internal.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-internal.h |  5 +++++
 tcg/tcg.c          | 21 +++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 2615684612..c0997ab224 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -100,4 +100,9 @@ TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op,
 TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *op,
                            TCGOpcode, TCGType, unsigned nargs);
 
+/*
+ * For a binary opcode OP, return true if the second input operand allows IMM.
+ */
+bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
+
 #endif /* TCG_INTERNAL_H */
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 3111e1f426..2ca44766f6 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3387,11 +3387,9 @@ static void process_constraint_sets(void)
     }
 }
 
-static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
+static const TCGArgConstraint *op_args_ct(TCGOpcode opc, TCGType type,
+                                          unsigned flags)
 {
-    TCGOpcode opc = op->opc;
-    TCGType type = TCGOP_TYPE(op);
-    unsigned flags = TCGOP_FLAGS(op);
     const TCGOpDef *def = &tcg_op_defs[opc];
     const TCGOutOp *outop = all_outop[opc];
     TCGConstraintSetIndex con_set;
@@ -3418,6 +3416,21 @@ static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
     return all_cts[con_set];
 }
 
+static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
+{
+    return op_args_ct(op->opc, TCGOP_TYPE(op), TCGOP_FLAGS(op));
+}
+
+bool tcg_op_imm_match(TCGOpcode opc, TCGType type, tcg_target_ulong imm)
+{
+    const TCGArgConstraint *args_ct = op_args_ct(opc, type, 0);
+    const TCGOpDef *def = &tcg_op_defs[opc];
+
+    tcg_debug_assert(def->nb_oargs == 1);
+    tcg_debug_assert(def->nb_iargs == 2);
+    return tcg_target_const_match(imm, args_ct[2].ct, type, 0, 0);
+}
+
 static void remove_label_use(TCGOp *op, int idx)
 {
     TCGLabel *label = arg_label(op->args[idx]);
-- 
2.43.0


