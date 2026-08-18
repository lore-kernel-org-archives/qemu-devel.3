Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB41C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCe-0007Tg-OP; Tue, 18 Aug 2026 13:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCd-0007Sl-EB
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:19 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCb-0004kh-C3
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:19 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-8518d5ddaabso166599b3a.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072536; x=1787677336; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8mqh/eNsWz9ZiMCibf4a1NtHt1J/mT5D6YWhVmQF1HQ=;
 b=xVPJvhp16wUu7r4+RuWEoYifrW+pnYnQwKt6rxST3KRYjfxaz3xPrCKyJVUJmBo2UP
 pffyeXo5I4cG8cooSxQca77Q88hM8gtcy07WrtTyBOyePzNICz+j6QH2SpJsqMiJpHal
 vlIQSMDFe9MOXpnfdAzjONd4EdQ2kyscs/u6bhjEIL7dEbu17kq6UOEplN8ypY2fEoie
 MpzAR7VvfWq+bFiB9YGPYjr3HIiW+c6QN/SA+qyVfvh4cji8WSPiWceVUHtnbU1lqzmk
 4OZ3v++EMOSSWVH94GA1X0Uxqb5EDnYx8ANhMI0N3O8tB6aW7DyFVBpRN7t/vpMxFHMr
 ZuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072536; x=1787677336;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8mqh/eNsWz9ZiMCibf4a1NtHt1J/mT5D6YWhVmQF1HQ=;
 b=plTv7yJTEIwdqGeW8VknE5d16bvdnVcuWR/UZvoLe+ZFZLWVGrcipyWr7Icuit9pjs
 ke2DBz9QoG86cL0Gn32T+/S8utHGz7uHY0z3INKSgTEqHroQDEHzPcwredXvLCZNcOrV
 Uku9b+TCkQgsEynefRiJVtv283EIVDefdiZT88118/Y6q33B5ionXjLeUy722kLygLRd
 XwBaWtI/8vqJwNrnZ6hw7LrFLO9v0rnwAQMbtrJ/W9GiU2/qtkMyh29GzUsESjF0vwJn
 4nA1hO7IWhV0QhLrwKTluBuR2/Frw1mt3Z041EGI9l6wAf8iuDruP5prHEYZY7M4Svoe
 9ahg==
X-Gm-Message-State: AOJu0YyRXmZ6Fv0fWtWNImgvBR/Cre84NCzoqcm1atyU7dtdJR5zanBu
 h4N8jLkfQhflH12Lcae4wB2exLAKMzCT4hi1OVXJ+Uhm9t5nn2EQSQrwPLBfeFKsLDplYkSLVY9
 UKnPWRf0=
X-Gm-Gg: AR+sD129BeTcs0RhJaaI2jLBYujp7n0+kbq+vY9WdwFk82rBaiiRqKH06xIuYE2LVSl
 55ArG10dtTz7cc0Q9xDVh2vA0xHz9qQL3tgtIE8B0NmMZ0bs23wmFkzcIZH6iD4oWe0ArcTEFng
 8cB8Sgu/BLVUg81SYcYob07fC8ql5nL04stBMlRsVtCHR5o+mN1fEjFjFakakKYQgxdQ3zXxlGe
 Zgd/IzgwRE6k3/i6UR+dBuqiaDpaWTVr3Yiu5DGFwtgoVX8fdgjGX7qnlmALi5MZqBAZAHRuW9j
 LMSXgq2cghS4I3tjrODkJoXUUcPez86L8cpNSbDPlVAHHrpcwrJdnVUsJ0yStzhpBP6MLpuNdMd
 DMAE4V8gt604cTdNRLhhOO4hHJwWvPn7WBFSnKi9UtJAojdnEbq4AYUvsktqEzbMFxMEPv5B880
 NqBjgUndPz3eUSE+q9Dmwnuam4004tuvGygKoYgryTtbWsqY4B+TzB+iG9NfDM2J8JDcfAtMMzg
 hITREkry0rojCcsQtnylHscdgu2PDWwZ/o=
X-Received: by 2002:a05:6a00:4193:b0:848:5f4f:289d with SMTP id
 d2e1a72fcca58-84fde14ffdemr39295754b3a.4.1787072535898; 
 Tue, 18 Aug 2026 10:02:15 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 15/38] tcg/optimize: Handle revbit{8,32,64}
Date: Tue, 18 Aug 2026 10:01:32 -0700
Message-ID: <20260818170155.1907006-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

These are nearly identical to bswap, so reuse fold_bswap.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 77 +++++++++++++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 32 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index d12babad88..facf4c1e0f 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -534,6 +534,20 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
     case INDEX_op_bswap64:
         return bswap64(x);
 
+    case INDEX_op_revbit8:
+        /* Note the host-utils.h revbit8 operates on uint8_t. */
+        if (type == TCG_TYPE_I32) {
+            return bswap32(revbit32(x));
+        }
+        return bswap64(revbit64(x));
+
+    case INDEX_op_revbit32:
+        x = revbit32(x);
+        return y & TCG_BSWAP_OS ? (int32_t)x : x;
+
+    case INDEX_op_revbit64:
+        return revbit64(x);
+
     case INDEX_op_ext_i32_i64:
         return (int32_t)x;
 
@@ -1483,7 +1497,26 @@ static bool fold_bswap(OptContext *ctx, TCGOp *op)
 {
     uint64_t z_mask, o_mask, s_mask;
     TempOptInfo *t1 = arg_info(op->args[1]);
-    int flags = op->args[2];
+    int flags = 0;
+
+    switch (op->opc) {
+    case INDEX_op_bswap16:
+        flags = op->args[2];
+        s_mask = INT16_MIN;
+        break;
+    case INDEX_op_bswap32:
+    case INDEX_op_revbit32:
+        flags = op->args[2];
+        s_mask = INT32_MIN;
+        break;
+    case INDEX_op_bswap64:
+    case INDEX_op_revbit8:
+    case INDEX_op_revbit64:
+        s_mask = 0;
+        break;
+    default:
+        g_assert_not_reached();
+    }
 
     if (ti_is_const(t1)) {
         return tcg_opt_gen_movi(ctx, op, op->args[0],
@@ -1491,39 +1524,16 @@ static bool fold_bswap(OptContext *ctx, TCGOp *op)
                                                     ti_const_val(t1), flags));
     }
 
-    z_mask = t1->z_mask;
-    o_mask = t1->o_mask;
-    s_mask = 0;
+    z_mask = do_constant_folding(op->opc, ctx->type, t1->z_mask, flags);
+    o_mask = do_constant_folding(op->opc, ctx->type, t1->o_mask, flags);
 
-    switch (op->opc) {
-    case INDEX_op_bswap16:
-        z_mask = bswap16(z_mask);
-        o_mask = bswap16(o_mask);
-        if (flags & TCG_BSWAP_OS) {
-            z_mask = (int16_t)z_mask;
-            o_mask = (int16_t)o_mask;
-            s_mask = INT16_MIN;
-        } else if (!(flags & TCG_BSWAP_OZ)) {
-            z_mask |= MAKE_64BIT_MASK(16, 48);
+    if (flags & TCG_BSWAP_OS) {
+        /* s_mask set */
+    } else {
+        if (!(flags & TCG_BSWAP_OZ)) {
+            z_mask |= s_mask << 1;
         }
-        break;
-    case INDEX_op_bswap32:
-        z_mask = bswap32(z_mask);
-        o_mask = bswap32(o_mask);
-        if (flags & TCG_BSWAP_OS) {
-            z_mask = (int32_t)z_mask;
-            o_mask = (int32_t)o_mask;
-            s_mask = INT32_MIN;
-        } else if (!(flags & TCG_BSWAP_OZ)) {
-            z_mask |= MAKE_64BIT_MASK(32, 32);
-        }
-        break;
-    case INDEX_op_bswap64:
-        z_mask = bswap64(z_mask);
-        o_mask = bswap64(o_mask);
-        break;
-    default:
-        g_assert_not_reached();
+        s_mask = 0;
     }
 
     return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
@@ -3104,6 +3114,9 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_bswap16:
         case INDEX_op_bswap32:
         case INDEX_op_bswap64:
+        case INDEX_op_revbit8:
+        case INDEX_op_revbit32:
+        case INDEX_op_revbit64:
             done = fold_bswap(&ctx, op);
             break;
         case INDEX_op_clz:
-- 
2.43.0


