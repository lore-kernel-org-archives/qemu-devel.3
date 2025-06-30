Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0604C8302B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGS8-0000cb-Dj; Mon, 30 Jun 2025 11:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRh-0000SA-8H
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:25 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRW-0008DO-El
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:21 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-73a44512c8aso998048a34.0
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297349; x=1751902149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jitYedPynmCQ1Qys4MAPCF+b+h++9TRiJKtdi+1sPEg=;
 b=s7HVG1aM4qlpjWMoEix5gjwiuA8V6M2LReM50bgH9jr80mUi0pelqge8jLsgtwnRE7
 JS33GBk7IGPOZjQM7Pn766XoacJDstP45mdrD6UGja9zMIHeYuBsGu8F2aN37Q+kmr4F
 u53nxBMTxvYJsp8jGn6Mvd570bgEe9QBcetWpld04ajnLiTqmw6rI3kfogwX769h6lrn
 AIcvDxO19VUksrYwv60Vmhad9GlfinxqI+NLLHVvzrXA0AI4I0NcvHF4dZfiztXU5894
 /g27ZAH/IxsfAPdPmlwKcfIrSf1AMX1lzTCt/aoHEyqxsoezD1SYB6JPMQe350q6FqWW
 Cz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297349; x=1751902149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jitYedPynmCQ1Qys4MAPCF+b+h++9TRiJKtdi+1sPEg=;
 b=LLZU4GPmtktfIqqx+VO3qQ3bm4t8ib4Q20VIc13sxGrptZywUEjWX9kjF41vTgsmJk
 pCsHk5Wv/LDA9x2cW7C8FqENimuGzQd0Vi+usn60jHgg7w3Xoi5BdOQ0NMKp8f0fuiY+
 erBfKnx5TE5XHShLd/J+oAxUugFh44IioXuGYc+uuQz+sY1Z1scH0Tw2hEdeU6VOV4f1
 bEkat+2aAdvvNeN02lk+m5kEqYp0deXqtnqAROciamQhgMe7Cwe2ILPcvCY0xBYM4ERA
 nhUcrrkuZ0V2fa87ISSPmUjezed+R/sguraJ2FtNJvO/bCxu9W/UJY8etkmhWyVQr1Ok
 k0TA==
X-Gm-Message-State: AOJu0Yx53eQTq/kMIUBf6WTOb+jvm2bGnzWX/Fa1r0musXFcDM4q4yog
 bjvL4ymnIbUdHf2efordoErNJsAbWWMZYMJrkPP0VzAm4BwXFkAdRJPr5+hxRaaqZZjG9KhPWQ1
 ih9hD
X-Gm-Gg: ASbGncurS+Aw13t7qWH3wVF3YEfZi/fJ6sBcwGkRMoBZ4wlySk8Qiu/EpzZc2lmJarR
 AbdiNZm1NCbriB+fI2IOKUowGnL44MIbq6nYmWy/2o2cpFYPFhwiyNVM4UxBK0wELtN7zaiu3zN
 VIXrswwl4yZ8ctgz8jbo4ZL2RDqUQ7DslTFvG+dFxtGXOG19VIAlM2Gwc+VTL6BkAVg+dyPjEIQ
 NUfmpOkGXy64DJpGnFOYmkam4du+fUUDX+2LCsLnziPq6OaQO12kzEyS6el3MQut6UQkF/tICwn
 g4Eiyl+F8lIFyC5/e0UzBbYgSD0aMBs3yo9mpygTuCkQ09YBrCG3GaJs7g0QXELLlFsgicdV6n3
 Fj4dC
X-Google-Smtp-Source: AGHT+IEOhN/NbmGQfDtYJu9U4ZhRkQDTRiXHAHc7wRfEk6Nsp/RPFnocN/LQ7j8ClIxqAT/Ba0QrLw==
X-Received: by 2002:a05:6830:b85:b0:73a:96e5:1997 with SMTP id
 46e09a7af769-73afc53af71mr8754141a34.7.1751297348713; 
 Mon, 30 Jun 2025 08:29:08 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb00c48asm1712478a34.27.2025.06.30.08.29.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:29:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 13/29] tcg/optimize: Build and use o_bits in fold_bswap
Date: Mon, 30 Jun 2025 09:28:39 -0600
Message-ID: <20250630152855.148018-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630152855.148018-1-richard.henderson@linaro.org>
References: <20250630152855.148018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 49 ++++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 572d314578..c9c53f796f 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1671,53 +1671,52 @@ static bool fold_brcond2(OptContext *ctx, TCGOp *op)
 
 static bool fold_bswap(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask, s_mask, sign;
+    uint64_t z_mask, o_mask, s_mask;
     TempOptInfo *t1 = arg_info(op->args[1]);
+    int flags = op->args[2];
 
     if (ti_is_const(t1)) {
         return tcg_opt_gen_movi(ctx, op, op->args[0],
                                 do_constant_folding(op->opc, ctx->type,
-                                                    ti_const_val(t1),
-                                                    op->args[2]));
+                                                    ti_const_val(t1), flags));
     }
 
     z_mask = t1->z_mask;
+    o_mask = t1->o_mask;
+    s_mask = 0;
+
     switch (op->opc) {
     case INDEX_op_bswap16:
         z_mask = bswap16(z_mask);
-        sign = INT16_MIN;
+        o_mask = bswap16(o_mask);
+        if (flags & TCG_BSWAP_OS) {
+            z_mask = (int16_t)z_mask;
+            o_mask = (int16_t)o_mask;
+            s_mask = INT16_MIN;
+        } else if (!(flags & TCG_BSWAP_OZ)) {
+            z_mask |= MAKE_64BIT_MASK(16, 48);
+        }
         break;
     case INDEX_op_bswap32:
         z_mask = bswap32(z_mask);
-        sign = INT32_MIN;
+        o_mask = bswap32(o_mask);
+        if (flags & TCG_BSWAP_OS) {
+            z_mask = (int32_t)z_mask;
+            o_mask = (int32_t)o_mask;
+            s_mask = INT32_MIN;
+        } else if (!(flags & TCG_BSWAP_OZ)) {
+            z_mask |= MAKE_64BIT_MASK(32, 32);
+        }
         break;
     case INDEX_op_bswap64:
         z_mask = bswap64(z_mask);
-        sign = INT64_MIN;
+        o_mask = bswap64(o_mask);
         break;
     default:
         g_assert_not_reached();
     }
 
-    s_mask = 0;
-    switch (op->args[2] & (TCG_BSWAP_OZ | TCG_BSWAP_OS)) {
-    case TCG_BSWAP_OZ:
-        break;
-    case TCG_BSWAP_OS:
-        /* If the sign bit may be 1, force all the bits above to 1. */
-        if (z_mask & sign) {
-            z_mask |= sign;
-        }
-        /* The value and therefore s_mask is explicitly sign-extended. */
-        s_mask = sign;
-        break;
-    default:
-        /* The high bits are undefined: force all bits above the sign to 1. */
-        z_mask |= sign << 1;
-        break;
-    }
-
-    return fold_masks_zs(ctx, op, z_mask, s_mask);
+    return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
 }
 
 static bool fold_call(OptContext *ctx, TCGOp *op)
-- 
2.43.0


