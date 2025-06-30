Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB8DC83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGSG-0000l8-0r; Mon, 30 Jun 2025 11:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRs-0000Tn-8f
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:42 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRi-0008GA-RH
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:35 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-73a5c41a71aso2461650a34.0
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297361; x=1751902161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=788tqHhyAITG5SoOmv8flnFx3nYNFAFlF/1rpotTNJY=;
 b=P9RhtjTSKKubJunw+2YCpytnj8m4MkaOe8qZj4Klm8TEOA1lhwdkQIbuLb9q9quLV+
 oVq1sCrtrHzGXKbodT0+zEKamK6VQXP5MVTnNndk+nqfct+Pjt7IwE/ia2pWPxRwX/1Y
 XvWXLmJXiGZtOKp/txj8l18JgeYjoMoieQBZlveFGmE/YiOm67zm6oeUU62OTxW+TmgN
 VYbDDNuXD4T8y5/fc8t0o5y2taKW5jpKBb6x8ANL6Kvx+OxSHWleycrAGrpggts2/V8/
 U0vAklXHT80UM+uG3THL+L2hUSOKriYjslUNxf0h87t59QwEkDNPx7GAvscAU77G74u3
 x1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297361; x=1751902161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=788tqHhyAITG5SoOmv8flnFx3nYNFAFlF/1rpotTNJY=;
 b=uaTDwHrri/hNhcwntm8hNdqT0f18ks8XR3rrGROBqRFEaL09zsaq+1zNGlUA+EDHRG
 sHTQCUfNBgBhibmyxo2zv1vTR9nO7C2XfhTpB06681/X7waNWltcYYI8ysqua2dTClL0
 TweYOKAYsG1IJIrxqs0YGqypyDivxYBNZ3oe7lvrdFK+9KhlvVpL1XK4QpZcvBwEfdCt
 8ImFk7dhd2zyW003bih+E8fMoZW/u80GTzB8cz/L/B9Ev3mU1hQ1jNVA/NGVYKYPPi+R
 OPoPoTZIwmR4d65poczB5CxTnKKbjvnROwB4jRYYVO0Jp1s2L/ma2DfFS+L5hyX3k0+1
 w9Cg==
X-Gm-Message-State: AOJu0Yy9x/ANqGfe1j+uHQiNNVQgLd47MDhwnYcbiucTHmP4x1NTMaXp
 yQmwKrAgK7DCvDhMcBRCHrJunUXHKZieYErT8OeM2wyB/pnByn1C5Se5lUinS+9erNyVJsrDpqm
 +1oPg
X-Gm-Gg: ASbGncseebdTjDap0rIeYZ1IO6tKU+wniy+vkmbFhLf7TI0MgNUTRpc3IHVTa2AhKWa
 QENASTazsl1n+OjHIGTaTT8dw6ctDOzcaTF8jZt+g+GnXr9UEKB7+ZynA68Xdy7JijDPwDWKQqY
 ffv1oX4N2GCh3M3dw2YWODFFdWRfVAsZXNn/um/GFdHgXjeEKMpjF6UuXzEuqN4PUKDk0EFOeiJ
 qiN5JS3LMEJLuHCi6ERueIqArrFyOGRnBnEQGIaiAkRH6X53rehHN5vpSdtKlbdipD38L/Fgrs7
 P7rlpwVWeJUxMuErvn0FCQEA6otxcxwbsxZeaQ6+K4gRAZbwxpxdaxd+Et5oSzgqfE6Vug==
X-Google-Smtp-Source: AGHT+IHk+XU5Pe5e8bKcIyB6Uawsunh3RsQvYxRKTWMQ4hkVGjsf38ZB4Q7nArqHyxb/QHtKRZzwXQ==
X-Received: by 2002:a05:6830:6f89:b0:72b:9506:8db1 with SMTP id
 46e09a7af769-73afc53caf3mr8975605a34.4.1751297360953; 
 Mon, 30 Jun 2025 08:29:20 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb00c48asm1712478a34.27.2025.06.30.08.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:29:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 25/29] tcg/optimize: Simplify fold_andc constant checks
Date: Mon, 30 Jun 2025 09:28:51 -0600
Message-ID: <20250630152855.148018-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630152855.148018-1-richard.henderson@linaro.org>
References: <20250630152855.148018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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

If operand 2 is constant, then the computation of z_mask and a_mask
will produce the same results as the explicit check via fold_xi_to_i.
Shift the calls of fold_xx_to_i and fold_ix_to_not down below the
i2->is_const check.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index f3a2328fe4..8d14a38f9d 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1482,10 +1482,7 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
     uint64_t z_mask, o_mask, s_mask, a_mask;
     TempOptInfo *t1, *t2;
 
-    if (fold_const2(ctx, op) ||
-        fold_xx_to_i(ctx, op, 0) ||
-        fold_xi_to_x(ctx, op, 0) ||
-        fold_ix_to_not(ctx, op, -1)) {
+    if (fold_const2(ctx, op)) {
         return true;
     }
 
@@ -1510,6 +1507,10 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
         op->args[2] = arg_new_constant(ctx, ~ti_const_val(t2));
         return fold_and(ctx, op);
     }
+    if (fold_xx_to_i(ctx, op, 0) ||
+        fold_ix_to_not(ctx, op, -1)) {
+        return true;
+    }
 
     z_mask = t1->z_mask & ~t2->o_mask;
     o_mask = t1->o_mask & ~t2->z_mask;
-- 
2.43.0


