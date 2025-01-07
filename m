Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B84E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4b7-0002HC-F4; Tue, 07 Jan 2025 03:05:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4af-0000fo-5a
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:31 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aY-0003Qa-9E
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:28 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2156e078563so192293715ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237120; x=1736841920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C0KgZymbeIKjXHvxpXV9E7eb7+jFfsh6E+cmm227Et0=;
 b=jUGyL2NYRcIEPsXKHpKhD4Wq11sqbFLAoeEY6gEb5N4a8Ii6OolVrsLVAi+QZ5ksOT
 rxN9ZR9JzGrQpkt8JjRKEDYjdIaXEOnj1xgesVBYnuNZgEJbDsqJ+6Lhj3vN3U6Jh9G5
 GuU46lUTG7+pd64WjaBGY6lpcfW71A7Mb8OyJHYWL/tRGtyV/FGXEAQbJ2152JJGy55V
 Qk76gZ22gi5CRFKR89N195sL/JDttDNlavcKtJydCrjD2BSE7jsg+hc9rS/NRKYN0WdX
 zLZpYRsFlEFnQntWv7dPQADp6ATS6Mr1xwyMIDZ29zWR0snJtuBxrhJBf50bayh3/k8O
 NrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237120; x=1736841920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C0KgZymbeIKjXHvxpXV9E7eb7+jFfsh6E+cmm227Et0=;
 b=drbE3JlQE50otUC3liYz7Guu/aP+j/cjGR0GCIeQATBU74fhg/EjFd0BHdxIYwIQ7d
 YMQpxAw4T7fKKt/7c4jLYClk+yPpGyUZToBUzwK6wVBchJL3BAKWZxRsjmRwWFdoRy+Z
 H5gYZXh7MPpIAtXqe8YJiXdYGkodSrEnJa7RjVMyMOO6hQ/EZNMjZsw6eHa11C6Mqwv4
 5tYZ3f1KLSooGKGAlSRJxcSHapQG97RCszK+S4mzifXLu9skNCMbdKSZ5GX0+foRmQzF
 DUTYDreLPN1UOsnv5mQIbIwN3vrzCOGsVFs/Sdmw3hvbKN2ATWSPKXUQcS3kiis7G8FN
 GIGw==
X-Gm-Message-State: AOJu0YxB3BwOPiTcEQ6LWrlRq+0r4EMnfeMby7JHDGpJ7ArDcWfPs83b
 TYuaWxXl0JWPLJjMhQYVIj4/hAsqtTh6PsuG0dmOgkxC2t6KmQEKDREQWeCM7CoB48YM+sffVcS
 z
X-Gm-Gg: ASbGncvXLrV/K0Q2TjN3ecVCUHbjTMinaRMUYhGLzg5zjwzF7gK5seqX7PZveBdjL5v
 2DlUD5ILTVbvjFj4V4b0wHI0qSOMQ8chO1EMi0dsmQW3QyUBTrqyvYpPPJVfv078vBHJc1N3zVQ
 ToGeQyiq/7Ftn5RWvyZ4wOT2m2sXBB/KyP1NG3DU0xwjvvFKb1QwdFcNME1df1AJcXVsJjshksa
 5HU4Po/nfZvieCsGMyDw0+AuTAaCa3Sz6ipYzYV4ycJHAqJymDJ/JW/nkielQYZBYNkHaFSsdNt
 u/aCd8XVsL/Z12TjvA==
X-Google-Smtp-Source: AGHT+IGgibAovvANuMBGDtiV1rYXlO9mkYjLetuxbWU6x41HQ1TowuC7ntMsPq4L53pVj4epzQZj4w==
X-Received: by 2002:a05:6a00:6c89:b0:725:ef4b:de21 with SMTP id
 d2e1a72fcca58-72abdeaa169mr88650701b3a.20.1736237120227; 
 Tue, 07 Jan 2025 00:05:20 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 62/81] tcg/optimize: Fold orc with immediate to or
Date: Tue,  7 Jan 2025 00:00:53 -0800
Message-ID: <20250107080112.1175095-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
 tcg/optimize.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index b84bdb989e..b0e7457eb0 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2128,6 +2128,7 @@ static bool fold_or(OptContext *ctx, TCGOp *op)
 static bool fold_orc(OptContext *ctx, TCGOp *op)
 {
     uint64_t s_mask;
+    TempOptInfo *t1, *t2;
 
     if (fold_const2(ctx, op) ||
         fold_xx_to_i(ctx, op, -1) ||
@@ -2136,8 +2137,28 @@ static bool fold_orc(OptContext *ctx, TCGOp *op)
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


