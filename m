Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE973D44C48
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 13:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgNoX-0002Q4-Jv; Thu, 15 Jan 2026 08:55:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vgNoW-0002Jd-4B
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 08:55:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vgNoU-0004t8-Gf
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 08:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768485301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=InwvqemBU+TpnuDo3ZeG64HYba9nU4Ii+HJslOk5QbM=;
 b=FaUabOM5wDaig4BJ62Wmpi+ZeSALlJXzlFmoxmzlEcH0Yi5/YqPT1x6yxvupNBy3kTCcc7
 k/oCFNl06CqCnKX42qP5P8DljLFR8HjEW5JVV5UsYWB6T16zCwaAJwkItyyyyDq2iZ5x4g
 6QOM/Ey6m5c3XsE0J8jbfN6Bsj9R3Ok=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-8HL6dx7cN_2Up0HA8X2NbA-1; Thu, 15 Jan 2026 08:55:00 -0500
X-MC-Unique: 8HL6dx7cN_2Up0HA8X2NbA-1
X-Mimecast-MFC-AGG-ID: 8HL6dx7cN_2Up0HA8X2NbA_1768485299
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47d3c9b8c56so10760165e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 05:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768485298; x=1769090098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=InwvqemBU+TpnuDo3ZeG64HYba9nU4Ii+HJslOk5QbM=;
 b=qSudPlxFRO4nXrN/paWB26yWIZzf5WDgA1lGr+aUsbGDas+fpGr5V9KGv5oF0OASt3
 KjtensNjvVjPR/ThoSgKMhoeeJND9W/zwrK3xETn4gVxo024bj/s4UlcE+FkZS+aQEog
 +SYrdrqTY3xy/sa7shk5Ezmo8X1GSUAMp25iKCrK5pcEaj2dUtOM/KM4YyH1r0NjGs2I
 MEssqgx0NsNbAo2NpACN2mSO4JiMMFSgNxfGN9hfTDNMS6tGgEfW1o/3JrQ9rYl88mEG
 +uFzJpmnhNuUNv6g6Gm3UNxQyHwPExCKqK8ycfXyt4eTtg/QTh7C25VR3RBbVovJfqLe
 uEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768485298; x=1769090098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=InwvqemBU+TpnuDo3ZeG64HYba9nU4Ii+HJslOk5QbM=;
 b=jdMbgzYtq4ncP4ei7HH0u9H7ZHneQuAzUl+T8moB2/Ag+5IN44TqA9uNNa6gWrPamV
 ojCk2I/iIi7kDVg96i4Z/7ztwYHYDGEORAoU4wFZqQr9y8uIr/LLrBvK3t6zU/WNjVdY
 zESVvke92xouTW1EDi5K9iGvOJ+aOEfRM8AvuLpkshresedG1+expFp1jaIb7ZG5zKgj
 O90dS77o2loVKk1l0tvqLgvgAhbyTujdcJ6G+NGuKkslmzpPS/ZrqeWGYVcXWd1jThi5
 sHJPPjY46wzXSGwLWW1iy3uS22v5Har6qCq6Nd5oayyEO5kadfPLBxmJlgdg0O2cKqmV
 0iaA==
X-Gm-Message-State: AOJu0YzW4lWg6ATih9OgvaCkVheKpYRDszP3ZaxL6hPMt1uiAYRfEdav
 Sp2mmvsLNsfH/Lscg6W7/i8ScMqAlLGQC+Jf67fNRqicTuOBhD4XSCEfvN4mrZeV4EgrJxErQc5
 6KJ3fvrBUHbj+OLu2QzUo0JNdsaap0ypKFh6dtJOEg+nSq/59K7eGoJblBmhKWJqxG5jFv1/w8J
 4v/3RHx1aFOPTyTCLCFzV3Go+9h3qOfua480WwqgvC
X-Gm-Gg: AY/fxX5l/h8T7p+9meAxudHitAzJXCaWABjt0fTx2MDpTiFVvsrnNduuMUaEGBn7yny
 034cUzDBnUzTjXTaixTWRMRFzMVkPcCz7M6+1tmj4l/6VDelNUogtiXIk29D7pFVPIGG1AKarN7
 2Xs25DFKJV9KWKuzM41QnMfKDvXdDBA/80IYm9jCdTR3XBa/Y9cc7//5RzVYmDTAVp3GGELsHBT
 l3dXJ0XmX8jnygpDlcG8Q1JcsOhyIP6ZJqrO5+heIjwiV2osaleHTgHXwJ25Cd319OtYcyI4LAU
 8nQUzPh0BxOSzK9hvkhmJgpR6A/55KmNMXz8euWyqHSVHHDa5osnR0T4Ohtbc+s4NyUUWdLnUXT
 i0tCjdnvDErkE5xhjPrZYqOCYJ4C3vDfRgf3ZKmV9bYXEz2ulgC+xMxMvd+9TpTDTGqChtGYUwr
 bf2VHfZ0eaXqNgDQ==
X-Received: by 2002:a05:600c:19d0:b0:480:1b65:b744 with SMTP id
 5b1f17b1804b1-4801b65b91bmr19570095e9.28.1768485298158; 
 Thu, 15 Jan 2026 05:54:58 -0800 (PST)
X-Received: by 2002:a05:600c:19d0:b0:480:1b65:b744 with SMTP id
 5b1f17b1804b1-4801b65b91bmr19569785e9.28.1768485297701; 
 Thu, 15 Jan 2026 05:54:57 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434a4cf4140sm6293855f8f.0.2026.01.15.05.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 05:54:55 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 1/2] tcg: target-dependent lowering of extract to shr/and
Date: Thu, 15 Jan 2026 14:54:52 +0100
Message-ID: <20260115135453.140870-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115135453.140870-1-pbonzini@redhat.com>
References: <20260115135453.140870-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Instead of assuming only small immediates are available for AND,
consult the backend in order to decide between SHL/SHR and SHR/AND.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/tcg/tcg.h |  2 ++
 tcg/tcg-op.c      | 30 ++++++++++++++----------------
 tcg/tcg.c         | 23 +++++++++++++++++++----
 3 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index a6d9aa50d47..6ca5bf7f67b 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -795,6 +795,8 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags);
  */
 bool tcg_op_deposit_valid(TCGType type, unsigned ofs, unsigned len);
 
+bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
+
 void tcg_gen_call0(void *func, TCGHelperInfo *, TCGTemp *ret);
 void tcg_gen_call1(void *func, TCGHelperInfo *, TCGTemp *ret, TCGTemp *);
 void tcg_gen_call2(void *func, TCGHelperInfo *, TCGTemp *ret,
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ab7b409be61..ccf66382623 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -995,18 +995,17 @@ void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
         return;
     }
 
-    /* ??? Ideally we'd know what values are available for immediate AND.
-       Assume that 8 bits are available, plus the special case of 16,
-       so that we get ext8u, ext16u.  */
-    switch (len) {
-    case 1 ... 8: case 16:
+    /*
+     * Use TCG_TARGET_extract_valid to check for 8- and 16-bit extension
+     * opcodes, which tcg_gen_andi_i32 can produce.
+     */
+    if (TCG_TARGET_extract_valid(TCG_TYPE_I32, 0, len) ||
+        tcg_op_imm_match(INDEX_op_and, TCG_TYPE_I32, (1u << len) - 1)) {
         tcg_gen_shri_i32(ret, arg, ofs);
         tcg_gen_andi_i32(ret, ret, (1u << len) - 1);
-        break;
-    default:
+    } else {
         tcg_gen_shli_i32(ret, arg, 32 - len - ofs);
         tcg_gen_shri_i32(ret, ret, 32 - len);
-        break;
     }
 }
 
@@ -2690,18 +2689,17 @@ void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
         return;
     }
 
-    /* ??? Ideally we'd know what values are available for immediate AND.
-       Assume that 8 bits are available, plus the special cases of 16 and 32,
-       so that we get ext8u, ext16u, and ext32u.  */
-    switch (len) {
-    case 1 ... 8: case 16: case 32:
+    /*
+     * Use TCG_TARGET_extract_valid to check for 8-, 16- and 32-bit extension
+     * opcodes, which tcg_gen_andi_i64 can produce.
+     */
+    if (TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, len) ||
+        tcg_op_imm_match(INDEX_op_and, TCG_TYPE_I64, (1ull << len) - 1)) {
         tcg_gen_shri_i64(ret, arg, ofs);
         tcg_gen_andi_i64(ret, ret, (1ull << len) - 1);
-        break;
-    default:
+    } else {
         tcg_gen_shli_i64(ret, arg, 64 - len - ofs);
         tcg_gen_shri_i64(ret, ret, 64 - len);
-        break;
     }
 }
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index fbf09f5c826..79ca49154a2 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3509,11 +3509,8 @@ static void process_constraint_sets(void)
     }
 }
 
-static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
+static const TCGArgConstraint *op_args_ct(TCGOpcode opc, TCGType type, unsigned flags)
 {
-    TCGOpcode opc = op->opc;
-    TCGType type = TCGOP_TYPE(op);
-    unsigned flags = TCGOP_FLAGS(op);
     const TCGOpDef *def = &tcg_op_defs[opc];
     const TCGOutOp *outop = all_outop[opc];
     TCGConstraintSetIndex con_set;
@@ -3540,6 +3537,24 @@ static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
     return all_cts[con_set];
 }
 
+static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
+{
+    return op_args_ct(op->opc, TCGOP_TYPE(op), TCGOP_FLAGS(op));
+}
+
+/* Return true if the backend can efficiently handle IMM as an immediate
+   for OP.  */
+bool tcg_op_imm_match(TCGOpcode opc, TCGType type, tcg_target_ulong imm)
+{
+    const TCGOpDef * const def = &tcg_op_defs[opc];
+    const TCGArgConstraint *args_ct = op_args_ct(opc, type, 0);
+
+    tcg_debug_assert(def->nb_iargs == 2);
+    return tcg_target_const_match(
+        imm, args_ct[def->nb_oargs + 2].ct,
+        type, 0, 0);
+}
+
 static void remove_label_use(TCGOp *op, int idx)
 {
     TCGLabel *label = arg_label(op->args[idx]);
-- 
2.52.0


