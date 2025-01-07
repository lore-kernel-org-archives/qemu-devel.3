Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EAEE77199
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4ar-00013U-4d; Tue, 07 Jan 2025 03:05:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4ab-0000Yi-Nz
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:27 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aR-0003PK-R0
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:21 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21631789fcdso162841455ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237114; x=1736841914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uQPN0tQwnd4k5tLXDa4Y6zgvvZBkCwb0Lgy7Bg/M9fI=;
 b=SnYBzpfaTyjBjnN4GPU6PWlNDGe0Aco1TKthX3Hs4YiX7brSi6rM531pfgUEkYV8pm
 pv/FjF9dwJQ+AzhYTAZrBc6b7SHou3rVsE1Mj+tQwATDrssZBEW6FpbFE/J+Xx9J0Ysz
 MXS2kr0RllVJ7IM+kUFXz1l+yPJbL8wv8I9tOsR8SRUClwXGLFmodfDYjUErIHcmwGcO
 TCLzu79zR0g3nN5Ch2GX/QekaF4anS0NYeU1ZSjKWK9cicOJcvOpg+kjTRCcreuYKgwq
 pVCdUqKtDHcF9WQdJ2PMEhQqZLie5H1YUJxwqG8Z1M3bvCTX5AKYzweItcN6dIQqrehL
 zTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237114; x=1736841914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uQPN0tQwnd4k5tLXDa4Y6zgvvZBkCwb0Lgy7Bg/M9fI=;
 b=FqbomK8a1+oGLh0139N7IIU2ps00vxKczSp0K49kZ+TNzdvNTQ55r/Ki5n4uKT7VUB
 7uq911qn42Z64H9K94U5oGrPtoAluHbRqdL9bHp9KV/N0doSPmAnZRNdHEyTgaubTQd5
 26eXGX/Ufn5TF/FBIGzNAM+is2yw3i15cawX8G5w48YxcQw7GMhQXBmHtml4XJH1hGBO
 DO9f7I+1GdRPRkCPv38oL0dDkcO4VAeeT9ducjpBnAL2fggYhU8xY0GOAcmQz3In7E0v
 e7j6Y7t5WEwvHNgh6QLrEA4HZhvJQCAgYD+d6VV5j5gXD5vjhMkvnIB5w0PBqoKlf5QN
 h/1w==
X-Gm-Message-State: AOJu0Yxm1PtPxWwlt0XnyLP7palOxzeUd8a9cJtytbasShjqEqS2J4rQ
 zWUfUbY3QOIDLJtBTmZjfDGjmXPCW9gXsrn+b0eEQ4hcI5gifw6UMIbK6UPWXbQKJa6NrdKcDwj
 g
X-Gm-Gg: ASbGnctfPvySetk5YeZvJ9dE39KbCvR/vei44ReTbuzYufvt9jelmVOklChBtTl8SNv
 oKppwuPohhUcQXLDlpmMOlL1jf5EKq8tHH6E9RZdfCEAsfo+dfdlcUnuv2IItZZasKbDGEuHdIV
 5LOF8SQkVLho1G3fYKoFexKEWOZECiprLjXuxbmCY0JNLx2JSWFIsO0s+27iQbj6IG6j41bquzu
 YsptS1axM4+kUQp72KG+g9phbkqhEf6OAcve7BSz99nEw+fCVa3401S1qURnRLGKEb9rYp6k95h
 685gv4A1knMVKTi8hg==
X-Google-Smtp-Source: AGHT+IFmdma5bxz327Z8tyleKL4YgVdLkebqVvFGzTZZrmvLOgNEJrStc09n/a+coZjZcuIoOu8ZBQ==
X-Received: by 2002:a05:6300:6681:b0:1e1:a48f:1212 with SMTP id
 adf61e73a8af0-1e73746a7e2mr3708629637.4.1736237114295; 
 Tue, 07 Jan 2025 00:05:14 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 56/81] tcg/optimize: Fold andc with immediate to and
Date: Tue,  7 Jan 2025 00:00:47 -0800
Message-ID: <20250107080112.1175095-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
 tcg/optimize.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 79af2c312a..1dd7b0e0bc 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1328,6 +1328,25 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
     t2 = arg_info(op->args[2]);
     z_mask = t1->z_mask;
 
+    if (ti_is_const(t2)) {
+        /* Fold andc r,x,i to and r,x,~i. */
+        switch (ctx->type) {
+        case TCG_TYPE_I32:
+        case TCG_TYPE_I64:
+            op->opc = INDEX_op_and;
+            break;
+        case TCG_TYPE_V64:
+        case TCG_TYPE_V128:
+        case TCG_TYPE_V256:
+            op->opc = INDEX_op_and_vec;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        op->args[2] = arg_new_constant(ctx, ~ti_const_val(t2));
+        return fold_and(ctx, op);
+    }
+
     /*
      * Known-zeros does not imply known-ones.  Therefore unless
      * arg2 is constant, we can't infer anything from it.
-- 
2.43.0


