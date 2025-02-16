Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237E4C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnmX-0005Zx-SJ; Sun, 16 Feb 2025 18:10:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmN-0005Vv-OT
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:28 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmL-0005Du-Tz
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:27 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-220c92c857aso58778895ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747424; x=1740352224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LroDn4/SjjeFJEX9RTqeH2747ENzfkgV16zYEGcxIMU=;
 b=Yoid/3QewmQpfTMW+xlPT7IjMcN1XWKHtXTnGWi6Di/R4ZaQvy8/qs2KUjeq9Fjw7B
 wwCTCESiSFPIcm0FIGJAZcMG7+9c/ugZis/6EBPW1VeMsR1MS2lmFj3txe2Czv7Is9Ib
 cyrMIoe7a32dMvXOi4PMjRTsTkXWO42prAFrWRF3sfQr6sZCy1tQKFL2NZx6miVDKlq5
 UMSeCj1KIVdEKmtPlkbWhLzn6KUK15HsIOWtQ38PYTvAghB2Uljl6vyz17f7QnlOESgQ
 0sP60btm0Hj64m7Ql6V1uDN/bhkf/gnT9K54ma598cTxudOu3urkaU2iEB0s2cbE/FEF
 xYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747424; x=1740352224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LroDn4/SjjeFJEX9RTqeH2747ENzfkgV16zYEGcxIMU=;
 b=Wt5gD5pmPVb4QKSUU1YaexQQCyzhjVlo/8d7nHpKtWTwY7KpcAZI3kv+7KJygbNiO4
 mxa2Za8QzqA4GfeGESZOMvRF10+EO9Q/hUo7rlsvv2/rpsQxGMnGqgD+42gsBqX6NIWO
 r/3HOU8pitMKiyUzKzCQKlWNq2ihKfLbh1MK4WxOkRxoVRytj9Ac/dpgrSuY35W1GSQ5
 E7p3z+hLLrSbwn8c8Qzx+qggVmS9JRxYoXzg60CAlRgqFlRB7Wz0jvjjg5/4jb3BE3lR
 aFYya7WkCsx4TM8kCkdT+eBvOphmT/IvkY+InVtXF7FWRHMJcbDwksdnkbJnB3oY69Nq
 3Akw==
X-Gm-Message-State: AOJu0YyNOlgsRf1+wjaVppbFdPRemUC4pCxn+9LVaC8eNLuIzt5O/YCp
 Clx2sU5+LUzfUs+dL1XL3p2tTkrFWPsZs8hxI/Jvs6k/nav9osv9T+Y46IPCmzIeBX5iSwxKg83
 0
X-Gm-Gg: ASbGncsYwNgAIdvXNovsf/R1yolxEQyNA0BkyeArTRqIBkUf0kGg5jDHdCVrO/kMpmk
 W2KIZwm/EZOlMAlasL8p9oN/C7/VATa8APpfvDHg3gs0m1OJM2Blr7tsWHh9qt6cs9fnDqd6v7v
 Oz9EwIvpidKL9QBTRxLeKfV3dyGtcovAGaClMBFETpxs/rcCbIuqyTYSK8x5dTVioUTfH6MAOLQ
 blPIuoZLZ+rKNESwKwEYuFv3zyZUt69SyB96WHuf5+V+k4bAd/yg9Dc3/fXsvywP+Bk+5bONHfx
 97rvZEI0DrXxyMM3tCcEa1qFpHf09ZjE0D3U/WbLIrN15RQ=
X-Google-Smtp-Source: AGHT+IGKJxvnpBHvtMT61+W1urfoqn1CLemR12WhrYThrgYEXCzUNriqcGSXR+6LT3/Jo1qMXr1qbQ==
X-Received: by 2002:a17:902:f60b:b0:21f:2e:4e4e with SMTP id
 d9443c01a7336-221043951bbmr103165165ad.5.1739747424474; 
 Sun, 16 Feb 2025 15:10:24 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5596115sm60198415ad.258.2025.02.16.15.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:10:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 014/162] tcg/optimize: Fold orc with immediate to or
Date: Sun, 16 Feb 2025 15:07:43 -0800
Message-ID: <20250216231012.2808572-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index d388c2b9ae..c75413c48c 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2131,6 +2131,7 @@ static bool fold_or(OptContext *ctx, TCGOp *op)
 static bool fold_orc(OptContext *ctx, TCGOp *op)
 {
     uint64_t s_mask;
+    TempOptInfo *t1, *t2;
 
     if (fold_const2(ctx, op) ||
         fold_xx_to_i(ctx, op, -1) ||
@@ -2139,8 +2140,28 @@ static bool fold_orc(OptContext *ctx, TCGOp *op)
         return true;
     }
 
-    s_mask = arg_info(op->args[1])->s_mask
-           & arg_info(op->args[2])->s_mask;
+    t2 = arg_info(op->args[2]);
+    if (ti_is_const(t2)) {
+        /* Fold orc r,x,i to or r,x,~i. */
+        switch (ctx->type) {
+        case TCG_TYPE_I32:
+        case TCG_TYPE_I64:
+            op->opc = INDEX_op_or;
+            break;
+        case TCG_TYPE_V64:
+        case TCG_TYPE_V128:
+        case TCG_TYPE_V256:
+            op->opc = INDEX_op_or_vec;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        op->args[2] = arg_new_constant(ctx, ~ti_const_val(t2));
+        return fold_or(ctx, op);
+    }
+
+    t1 = arg_info(op->args[1]);
+    s_mask = t1->s_mask & t2->s_mask;
     return fold_masks_s(ctx, op, s_mask);
 }
 
-- 
2.43.0


