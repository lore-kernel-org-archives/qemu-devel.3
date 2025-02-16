Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4421AC021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnmi-0005eN-Rs; Sun, 16 Feb 2025 18:10:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmR-0005X3-Cg
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:31 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmP-0005Ey-C5
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:30 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2210d92292eso30252225ad.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747428; x=1740352228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6XjUWPsCzB/zg9tkkwv/C9EVZ3N+WAko5Xk2ZrYZeQo=;
 b=BBiZ1mmiqJPPuHzgcHfhePcJhoQ8iuNabhmfPg6d2P/B4dF4p0RROhCij5q9f1zkTe
 NLh8y4oS8Uxak7ktxOM4wz5pjogXRFDNBGLojUdqMnM/OF/iKfebFGz1gzwDgcjx3E5g
 1E/Ywu/p0W9X8sihuw8DyMV3S3syNUeiu/XiVt5NAVomZu2kQr8w9SACo5Ub2O7UNz5B
 eTkZhsHCVAa4Z/QH1DFEAbKUSZrIWjqLz/mrfcNh8rpd2ccFL2RZCN13mrEqJeCn98wM
 cibnjZZPN2BkC2gpMZJADzqUtpUdToYRaVmiuYq/Pa209W5JqHww9ao7O89ISHSZaqu+
 n7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747428; x=1740352228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6XjUWPsCzB/zg9tkkwv/C9EVZ3N+WAko5Xk2ZrYZeQo=;
 b=u1vSXZmYYD9Wd6rb7JqpC53EvRDc5YzhaoO1er/ilDN5zU7JFtvliom0e9cQ36HDAA
 TcI18b9yb6raQZand2LuJKjCuusOz4UvxTKzBp32hT4Mqsy4gUN+KG7mjDw0Jp8slO6s
 ae5WCXOKHrgF15/LSDetAOSl7FIfmS870gjuRV0DkfM1olf8EyR6kbRxyae/ksYNJBqP
 mAsMU36EBerZXjq3r9wXJa7BNP1cg2RGtYTW5xFbwDHDhW+UTauT5a4IvAhbQi2Hmw1K
 Vr+IA0y3IZ86fev+owrKKa3gLbreFKWd8hWwRLonZrQv4FEu8dADEKZy/yvT5M/Gcum2
 Hr+A==
X-Gm-Message-State: AOJu0YxeXFF8LW5IYgVgUQFYe89A4fWysdMLdXdQSGq51Kq9YarhhKp6
 sl4JzAWXblAFFXGq+l4kNPFdlVmF7Ro4EJcJN8PDCuOSqFCRMDGZxbNa/dtJ6675be3U2uZp3iK
 t
X-Gm-Gg: ASbGnctj7kte2ngG1XxRQcJq3vk29Ivd/hTZt7O6kC7Jtlohu7p5Pfy9JlVlH3PmnG6
 +QBhvcsaC9jDEYji11FTBq6fNn6nM7YhSoOyDjxkokkn06S/Uj90ZV7yNEZzuNI9+Q3nQB40335
 33dy6alrECYMzRO6wuPco+ZVhPTef/juRhfwBhHJtOJACBkn6KQNSefLZTkOYgvzWMOtisET3Bf
 JoEobco85B+qd8zQY8bXv4oWNIDbG56n32spABe7iO0Lgkxm9wMhlXUSgLHh1Vz7/cEJbX/Q5/h
 XK6HjlTa/oqbfCFbpbHTFlL0f+9IkAwIYCzb9l+/tWA0SBY=
X-Google-Smtp-Source: AGHT+IHIn9iBKUVrPl3vu8vTIS49uv9h9BxJsiJM4m6eUDEsDczMReQcytSb6bskeimp0RVpAMrfeQ==
X-Received: by 2002:a17:903:174c:b0:21f:164d:93fe with SMTP id
 d9443c01a7336-221040e7162mr122032005ad.53.1739747428073; 
 Sun, 16 Feb 2025 15:10:28 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5596115sm60198415ad.258.2025.02.16.15.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:10:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 019/162] tcg/optimize: Fold eqv with immediate to xor
Date: Sun, 16 Feb 2025 15:07:48 -0800
Message-ID: <20250216231012.2808572-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
index a4dc88ae71..a49d51f0d7 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1795,6 +1795,7 @@ static bool fold_dup2(OptContext *ctx, TCGOp *op)
 static bool fold_eqv(OptContext *ctx, TCGOp *op)
 {
     uint64_t s_mask;
+    TempOptInfo *t1, *t2;
 
     if (fold_const2_commutative(ctx, op) ||
         fold_xi_to_x(ctx, op, -1) ||
@@ -1802,8 +1803,28 @@ static bool fold_eqv(OptContext *ctx, TCGOp *op)
         return true;
     }
 
-    s_mask = arg_info(op->args[1])->s_mask
-           & arg_info(op->args[2])->s_mask;
+    t2 = arg_info(op->args[2]);
+    if (ti_is_const(t2)) {
+        /* Fold eqv r,x,i to xor r,x,~i. */
+        switch (ctx->type) {
+        case TCG_TYPE_I32:
+        case TCG_TYPE_I64:
+            op->opc = INDEX_op_xor;
+            break;
+        case TCG_TYPE_V64:
+        case TCG_TYPE_V128:
+        case TCG_TYPE_V256:
+            op->opc = INDEX_op_xor_vec;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        op->args[2] = arg_new_constant(ctx, ~ti_const_val(t2));
+        return fold_xor(ctx, op);
+    }
+
+    t1 = arg_info(op->args[1]);
+    s_mask = t1->s_mask & t2->s_mask;
     return fold_masks_s(ctx, op, s_mask);
 }
 
-- 
2.43.0


