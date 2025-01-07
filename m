Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37692E77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4bh-0005Td-O0; Tue, 07 Jan 2025 03:06:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4ak-0000nf-Ro
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:36 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4ac-0003cp-Mp
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:34 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21636268e43so41743605ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237125; x=1736841925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0/9KaAVoF+sn7tZivpetUT1JwSnt9R7M/q7qCIEvmz8=;
 b=qtN9/ro/7BztXttS25TG6rYwdlAJxpid4GGndIB2PsR5ubfgGrUVvctLcuxd8I4Qjn
 qgwzOnYBcCW1sK6m+CgFApfdGKB4Q95bqTJSM2DxZfM1/GSGR8nILjGr0Bu5oWnhGpHC
 TG4PSLuJrCdy0U5vAW3PrTped1NeKgbltnsREjXv+0F0LnicQRx8yx+ZUUwfaaLPDQxw
 57cbfDDBrCZMYaqxquJ+Oyi/HQxxe7Sy1jSTJQjsZ6wdkqDx5QCT7nfSoAddwywzJpEA
 udDiDJNw1QdxTsXBFhxLgOfTahWSLZjAkgPVg9viKTsZCsWa4KHnQ0PHz1W18dX+eWwI
 krvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237125; x=1736841925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0/9KaAVoF+sn7tZivpetUT1JwSnt9R7M/q7qCIEvmz8=;
 b=EV5Xc/xM5bWPLWWp5szNbCjGZDJ08wM0B8Rp9fw/kKzylTHxouz5+j+jSnI/6ac0JF
 uHkvok8Oah3otHbsM5Ko/F5i0YItQltEcyNrNEXtyo5iROQQoy+MmkVUxwfDjO+QrJVc
 M3S8zujc3wxCe13d8hplvTHb+VobcvKGaEfD/5a+vMkXA30NtZXjHrxHB7CtlgrMTl9g
 AISzFj7VHhIg3Y8iogB79Y+hK3GYLq201aBEZpK4m4RBA6x8pO9eyXrnsed3joXB2F1S
 HZj4PskHKRyOpvQr/xIkZxP7hdLQzCXPHQmRFBzxyR3k0H4aj8M159ZgTIktKSHriljm
 9Pdw==
X-Gm-Message-State: AOJu0Yz/itQKHGMR7sNDSvodEFWJg4lReE243jCvTxDY4tp1Kka9Fue6
 SUm4U4vvK7yAspVEDE7ogRkLJTqVST/+vLjLz4AxXkdqat5YVVnI583rn1N5TPMdamPMNzwRuCW
 Q
X-Gm-Gg: ASbGnctVauBJlY+f7p1gnTiiVyWluk9Cu+DPsyfcsRZhN9ozj3ae1NfK7JOHSRXm5Bz
 5bCwKIwgQRKl6FlDfAX35kinoybZ4BAuc+zPHsSUjgAql+uHr/tNlo7i0p9FeQTbv2kut56MKcH
 sL3UTRyjTVhQyWrDP5XkqH3IV5J7gsHSSs9hyYQ0VC7pxsqbo6AdblnIwvJG/MI8mLa9ZDtmLyz
 tO/KbyRk1je+iUVr9j9Y9o7p25pnPegydr0KahlqT5qZSB/vx6BES4FqgLUoTRiA9aaiy6nvdOo
 wDb+oRH1982XFvFNfQ==
X-Google-Smtp-Source: AGHT+IE7KSDG7Cxre6F/IbMw9hBkcPvQHbeVqS/uFD8NTbZwpNBHFGvXBd0C/EdHep+fbbGnh77yog==
X-Received: by 2002:a05:6a00:35c3:b0:71e:13ac:d835 with SMTP id
 d2e1a72fcca58-72abde01ab3mr73609110b3a.11.1736237125455; 
 Tue, 07 Jan 2025 00:05:25 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 67/81] tcg/optimize: Fold eqv with immediate to xor
Date: Tue,  7 Jan 2025 00:00:58 -0800
Message-ID: <20250107080112.1175095-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
index 583c4363da..485efb1018 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1792,6 +1792,7 @@ static bool fold_dup2(OptContext *ctx, TCGOp *op)
 static bool fold_eqv(OptContext *ctx, TCGOp *op)
 {
     uint64_t s_mask;
+    TempOptInfo *t1, *t2;
 
     if (fold_const2_commutative(ctx, op) ||
         fold_xi_to_x(ctx, op, -1) ||
@@ -1799,8 +1800,28 @@ static bool fold_eqv(OptContext *ctx, TCGOp *op)
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


