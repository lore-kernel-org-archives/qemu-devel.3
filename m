Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E6CC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMjz-0004AY-Ku; Tue, 03 Jun 2025 04:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMjN-0002In-R7
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:10:47 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMjK-0005lg-Tl
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:10:44 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a0ac853894so4976038f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 01:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748938241; x=1749543041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1GeEM9Ch9VEaUM7S3fIXujIMYq38Z5m15r1GdbDnYbA=;
 b=mRzQW3HsMGLV+xIHhv7ZtNcOZu+wjyMo8DlGam/yUDa98sAoymf84yeJp45hHGXdJC
 gmFFrxmqBI+A4ZbHW+4I7mo438Lt3Py/kP0u8b/MSyBlUoCiNjF6LYcDJa8LHrZbDfhc
 7xnBVEXo9ZriZ/MY3wL6qOt2zDzm2r47KHJ/8oH1qaKTKFymfHAamUqt6AV0+uUNefOC
 UKFkqQiv1y+LJPa6c50wQi3Z+0e7PRT5Vnt7K29JJGsQI86vicYUqC9VpXikpn8Pwkvv
 HUXcDBihUrvMrARAUBBsigJpgeow/FW3kJaPOoIEMaiqK2dTHD6VRGMMkxNkTYa0VoLj
 lqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748938241; x=1749543041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1GeEM9Ch9VEaUM7S3fIXujIMYq38Z5m15r1GdbDnYbA=;
 b=Uxr7ERC2sf2Az0H0RlLzs1EkWd3Q6YandXKMG1BMKFfGY3UqzEdRFQnNcyqeGT+ZLx
 nzleVSETIZEBYWkab/N+6AQrIwP8EOpykQoapzFDlj5xIaSoC0K+tctrBBhMNFehEmSk
 FZxkBCOPWvHo8DHSK1bt4u1BJfdNp7gLWQQLLv6ZRwANylBaXK/wIxmEvNlacDpNvqS9
 4PnBiOq0uEfDKxGcOlbXKKsa4t62toj4yk+0PDc2G/O2EWCKSaqreGYqwKlfZKRCSEZF
 nJpuwB4TyipxMqEqvcDG+ILY7bYBGj3Vs9LYgZbol6PpxjLaem3XN4LyxYxliJwZ4Ryg
 OUjQ==
X-Gm-Message-State: AOJu0YwJy7nHNlZVG8T/BdrkMOH0PHt4nOjVjiceV5X3Ha3Q0d3PoxKt
 liki5KPtD7K62EeK0EM+LjBgObsL1fdaOgOjiD8ASMUg2/ALu6MFhUk95HEi/cD2D2kJxoryuQr
 mAiHVREg=
X-Gm-Gg: ASbGncuDincweYrQDD/zbBEvTl8CgmnY2gph9RKA4x5XuDPm94yknamiV/5LEklx4EQ
 b8YaZO+/usmFFPaOAM7M3eMal2yhNDCxx26Fuoh6bdXIKdAumIQE1lK/cvOUl/8uA3NTETWFpoe
 B+ioozXlyb42HYCfsgcaDrANzNEGbVQSnP5MAtl2Rofl16WkD6NiLouFFmSuQsA1DUXre8hpnqF
 6rK6BoD5dIgTZf7xoaRAbkXd9FSQvW8e7KoEW5FQVhFfZ6N2P+Mf9fuwjJbmAH7E/JHZSAWC1D2
 eOo2SLKdotI1sCclbZ9Dh60Q74WZvYWM7TPNULekNz85mnSXeyTn4AiX92dXozyLpZmYNVxdZ+2
 FUhi1+A4VGcS3szSYVjUGu+s=
X-Google-Smtp-Source: AGHT+IGUs6X4fXsGhOjJywqcX7s03DfdaTtnbj+rIvHQbU6JoImPDRprvHJWs3EkMviHs7LB51KH1A==
X-Received: by 2002:adf:eacb:0:b0:3a4:ef36:1f4d with SMTP id
 ffacd0b85a97d-3a4fe391bc4mr6832825f8f.38.1748938241178; 
 Tue, 03 Jun 2025 01:10:41 -0700 (PDT)
Received: from stoup.lan (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009ff7asm17668852f8f.90.2025.06.03.01.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 01:10:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 13/27] tcg/optimize: Build and use o_bits in fold_bswap
Date: Tue,  3 Jun 2025 09:08:54 +0100
Message-ID: <20250603080908.559594-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603080908.559594-1-richard.henderson@linaro.org>
References: <20250603080908.559594-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
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


