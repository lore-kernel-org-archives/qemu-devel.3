Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E387C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 04:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wteXE-0005Qa-KX; Tue, 11 Aug 2026 00:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wteXC-0005Oh-1A
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:56:18 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wteXA-0002ms-BZ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:56:17 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-381b831d535so3409175a91.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786424175; x=1787028975; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ev9v9NYJ4vbn0DhbzQatapOzyNZLJE1tMPMuC7v7BeE=;
 b=DlqIMFuPoJ/N6aDoq2z/TgG2qPHRaLAnSu431nVAt4Nx7gYmuMi/OxZB4hod9N0Gx9
 Ph01z+3Ad8GDWTol+ynIQhf2irIRHxI1FIv0BqGlhwy73mB3IBekeqTrRTOhE6+qqeSd
 UoWg8mWl3zGeYzJpxfMzrTsWVxdKPT0oEi/C67rsx7NzCFWVEB8YjLj6EGg3FcXG7yws
 qeNtlSv73jVvZSQss9q+gu60lnl9nNNt79qz5gdkGPPxi8BUdwI6wIsX/yxNKG9q4TYp
 NRU2MPms8gh1F4fMxBPg/eysaTpzrJCfuRb3yeque9XsjX/qKKhXH07UtBnLOngIhe/x
 gjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786424175; x=1787028975;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ev9v9NYJ4vbn0DhbzQatapOzyNZLJE1tMPMuC7v7BeE=;
 b=HagGf49GtKi9b0cm9C6WlQrQWJ+GwwttvQrpPUxdPsTn2t2Pc19jiBVAbhOzoNqMnD
 IxgqcruFO6xnf/38zclDeq9dg0P+MlI4okgGG+hflY667zFR/r+72+1Z/CVgRAiD9fFQ
 5OfeId2BG7DkezzRzVB7GImIMpWW4q0OaWoagSJEVP/meHPR1Alm5Cg1ndZY8368glBf
 1kw1k2UggYV0FCrUz5bDN90OmsreLCj1Bqcb33P6clegbv1ApAB15jzMpKSetdmAswO8
 +nqXQT2KOBggzO+K0139zVTYwrZSwhwgtpcviv0ZuEJZcuzPYDPU0xN+S7y5t4nL99o3
 ZZIQ==
X-Gm-Message-State: AOJu0Yz9OctO8V9vCb1X4Qes0iFck+zey0ePf22nCE+wsSp9RuXwF8F1
 ZziIPsGi9/D9Stiw2b10rdbyvPF0hsmJeCziHjja2wf02g5qx6kZbRsWZRnaUPi6RtshCys1GBA
 nXaab
X-Gm-Gg: AR+sD13wSfxTzBmC2CL5FSWg6CGzpiVrhFMhcBQ2SKRXGLMJHrAfP7m2BFGyaer24nL
 Pd3AEtfQr/il+UPInLdZFKEl2cpXZfgLkRbwzScdvUW9+YCWt2u+LIpVA+Q2ic6rmHE7RiV1cWO
 51gSmq78u7MiiaKeYgiY3I5JYYebP6EyX8sOACWSfIK2eIszXjis0akTCHEsw37QXGv6YiJTIuu
 VtSMjObQAGitjwAEailI50iivCzC7AmyvfsrAY27+w/3BsSPt83PlsPZiEHnLlIo6qYNIiAuMgV
 zMFakWqNLxZ7STMMl683Y07G+widumUiSI72lxlrd0UOFBcp01J0GJr+L7jxzArTr/3XFdKH00I
 BgBwj6/FLXheLIYXYrzbalNPINp55BtSnmJFq8QRJ/DGJ1vqPj+0T5m0lmboksoxq1v2uAF7rSK
 gr49jTWKYmuFJE44jXSsRyx2fsPcnNF2MhXd7yA82oBfmmoOOo6/0gl6FIVfjkVERlqkbklXYAc
 vHeyBZ3oIRuv5nUNA/Y
X-Received: by 2002:a17:90b:3c0b:b0:38e:64b0:8bce with SMTP id
 98e67ed59e1d1-392ec6a7c45mr728517a91.20.1786424175087; 
 Mon, 10 Aug 2026 21:56:15 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392ee3084d0sm156818a91.8.2026.08.10.21.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 21:56:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 09/16] tcg/optimize: Handle revbit{8,32,64}
Date: Mon, 10 Aug 2026 21:55:58 -0700
Message-ID: <20260811045605.1246543-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811045605.1246543-1-richard.henderson@linaro.org>
References: <20260811045605.1246543-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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
index fcdef25bee..2960c0f3b7 100644
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
@@ -3095,6 +3105,9 @@ void tcg_optimize(TCGContext *s)
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


