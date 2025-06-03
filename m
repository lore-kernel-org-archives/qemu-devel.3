Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413BEC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMkX-0007kT-UR; Tue, 03 Jun 2025 04:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMkS-0007SL-1r
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:11:53 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMkN-0005uE-7U
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:11:51 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so3957115f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 01:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748938304; x=1749543104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oDvLviD3nK7LgDkX1sD1R/tH/8Q82WUdE6uBnZ3E9wU=;
 b=sBJH8lHVGBwacKemxQjtFufIpS3GT181qHuYfwJ+FAQj2oLvYdOeCX6Vq98w5xtYwj
 1mfdFQikPhZIqlrwx3rKVnJGWcZnt+B2+/8JTU4L3iHBFy2qKgbYPrxsnF8TWpUl624A
 8ve1L7SK22LD6n+/PhWOcheoSHMMvAmk0Tzl1K1pEzuaxRj0Tjrjypcmqglvg6J0GHXQ
 8rHENp5qoS8UJgRGoDB6Ey5oPJO3/J9Yfk7kJqN/AsipZX/BxVGwnWxMMHot6Ii6j/GQ
 pDJ+0sOf8ZZavZk/XL2e9hBM/vlS3oXw3JgdI+lk0wHroUZO1WmExUFgwbjY8yfAOJef
 K2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748938304; x=1749543104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oDvLviD3nK7LgDkX1sD1R/tH/8Q82WUdE6uBnZ3E9wU=;
 b=i6+0nhxXTebUoogYHcFRmGK92wJYRCI+ECmbEbvuRAde7beKWaNpP7jFWKK5mYjnnf
 1xn4+V/gtkQBpM7GxI2IxxlYcxGTnmQhxxGs1+Jx8eZ7lTCkw7YbuVj2p6xzmKAO5W59
 ldt+GKDM/9TZIii/67aysrDnX33tSQJygin/wha4dJN65EELpzeYpG57BrIfywKeOiqD
 ZtlLuMAenfBlzosdeqCqDGr+w28tSt/QSX4NffV1ITOHMcWl3bPheK3sLOlFFqlyuZnX
 NufCLTs2HKy8DFAqUo6Cx5YBO1qGJwPUWgKc4EHb97sokOtvSeAHT3prtmeSB9w7CIMA
 Lrjg==
X-Gm-Message-State: AOJu0Yy5/2qs5XTycYmbM2Yog2VB43Qhuvfy3Xv5s/VqvAA6D8WRYhDI
 Ikbvvwen7uOxU9jxN3Zai988S6a19n49/R/dugtlIpEpuAXqZ0rSwccFeK34LLlMGsBdir+1od5
 k1iAIFlM=
X-Gm-Gg: ASbGnct70ah5R1fdvaTvYJ4K6UD1/SI3NJjl28BNmNmsTQQ+XHrRo7GwKphQg9/URrq
 XziGcXmMfcrumpvq5hz4juopdflXEb/aKQAIU86zy0NixkKbvyE8Z7JD5uKPkFUyyuTIPNwcg+V
 0FbuzSVe15CGYpkG7kXhsvMwptypz7pnos4PklCkQ3Wt7c5Vbh9RIuGSY4C5FkDmy/YQxKODfxK
 YIOG+YcdZxJcCb+SH/n1VC+Nl0wyrKvExggArbS+NvZzxGDrjls2JxuBIMcJhROKJYE0hS8K6Tw
 VW+8PiAuxDw5dpfTY1R125lrJDOTcS/MhwSNP63JllrZT15sy7gVrn4e/1feQF0AqFn0cxu1Dqk
 H0yZvdXMOpUF3
X-Google-Smtp-Source: AGHT+IG31Hf+39ofFOWmNgv6PWAgqHYV/SErOvFn7z9bvA7PKbY0mb1LNz+DeZDG2I2fejSqy4SDEg==
X-Received: by 2002:a05:6000:3108:b0:3a4:d685:3de7 with SMTP id
 ffacd0b85a97d-3a51417af94mr1144369f8f.8.1748938304271; 
 Tue, 03 Jun 2025 01:11:44 -0700 (PDT)
Received: from stoup.lan (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009ff7asm17668852f8f.90.2025.06.03.01.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 01:11:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 24/27] tcg/optimize: Simplify fold_and constant checks
Date: Tue,  3 Jun 2025 09:09:05 +0100
Message-ID: <20250603080908.559594-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603080908.559594-1-richard.henderson@linaro.org>
References: <20250603080908.559594-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

If operand 2 is constant, then the computation of z_mask
and a_mask will produce the same results as the explicit
checks via fold_xi_to_i and fold_xi_to_x.  Shift the call
of fold_xx_to_x down below the ti_is_const(t2) check.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 06ccf39d64..f3a2328fe4 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1434,10 +1434,7 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
     uint64_t z_mask, o_mask, s_mask, a_mask;
     TempOptInfo *t1, *t2;
 
-    if (fold_const2_commutative(ctx, op) ||
-        fold_xi_to_i(ctx, op, 0) ||
-        fold_xi_to_x(ctx, op, -1) ||
-        fold_xx_to_x(ctx, op)) {
+    if (fold_const2_commutative(ctx, op)) {
         return true;
     }
 
@@ -1473,6 +1470,8 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
                     op->args[3] = len;
                 }
             }
+        } else {
+            fold_xx_to_x(ctx, op);
         }
     }
     return true;
-- 
2.43.0


