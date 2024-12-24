Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C15CE7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBAS-0003Hf-Rc; Tue, 24 Dec 2024 15:06:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBA7-0002q3-Cu
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:52 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBA5-0002bN-VG
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:51 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-216281bc30fso65719345ad.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070749; x=1735675549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lQGEeo180Fb11kHp4BmckzWOB9pBkkJv2EtGQzoK4ro=;
 b=ZH6XJrll+RXihC94LDnpleBZwZ3qCRiiBElFVLz1yVHpWZIHJ+iAkVQlcpyluGMKSM
 XBQvjWJJRCFGgZQ5fVLVPUUwhr2V/ML0cU6sPPSIH6ua/9oqZXEHH7KMGI5is2oJ0Uu2
 tkspb14X2lyQ7texRD0frOlYXTj7UJBomfJkEroBfwvLCHeRjaWL/rBUnUtg8RZX4jcR
 ciADGLmJOXSkCqqT2EuKjQNFjJkbM+lNgysXtVXUoTX8sC2qIm5Kik1PjWZ3gtpZl43h
 wdK/8FDB2/0JXj6QR8H6DX1ZnXxvMEM2xC0DqBqRooeniaDNF2mS1diJO7IxPyTNdzMI
 GU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070749; x=1735675549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lQGEeo180Fb11kHp4BmckzWOB9pBkkJv2EtGQzoK4ro=;
 b=Z3O50nFOywAghfXsykNjJWsObsZ4YBIgNIMg8ko2qZ5esLDmdZX4mSJ6TR8vVuKOjW
 oIL5X9ftXSH9G9ob0L5yixI2DnxM7xa0LjhFpFULmqlxZqfFlAn6MAhdZD3QS4bqNT3q
 783sHvKdsT9M+Uhs3qUyO9nfpEeKM8j6tJT8FC/folxO/7oNoEByaMJVt2Ukq0kjRKJv
 NQpIeuFRejJShq3sWqqpfJILyliXprEeHz0YdSvjEUr7XkF4Nlph70ntH77/gfw+eklH
 Bd+1UtDQ4at28PKzplFJuv90JSzEAYa+nNN7Lm0NKp+FQTVz3XnEfPzCm++/bVoM8W1v
 Ow/w==
X-Gm-Message-State: AOJu0YwSta8Sf1DpkjYxxCzH8eK3B7/8ZHA8bhE/xVSNTtm5H/cpGZ7/
 mV1ToDf3q/UmT4zxoIBIiEQovMGzQFDyx39hBAoTXbx8gU9aRCdamOZoBJY3PPKN8gw8WjiQbji
 bT10=
X-Gm-Gg: ASbGncv1SaGEQzXoYpLlHlACn1eBMof14bBcdwrYxlMF3i+YdcsHwzGgl+DYYNIQkRp
 tl0Zzyd8MMhJOYCQH+lJJMVLcs/R0nZV9EykypDkXRSYJYDg26kJoCsHLMd13cfl+dVJ8BTaml/
 6ZMCcOzagqFhDSpMiUQslbHl/MKUlA2q8hlM+TRyXE3xteF8x9D846NM4pSWmYKnLPY2Rh+s/1f
 zhIj7J1BQe90WmUZftOUnqN7VQwC1aUWFsxDOG9l1ScCKkas6lS1fmQ66fum1whYUqLV3hjwa7n
 fhbCR5GjVJAWqLKa2Ups5tcZOw==
X-Google-Smtp-Source: AGHT+IFPeoZpipi5ZuCoT9Rt2r+bXdkmgD028HYDIEqhHLjk78Kn9w78E0NrnpBsulejEa5Ga7yi5g==
X-Received: by 2002:a05:6a20:1596:b0:1db:e0d7:675c with SMTP id
 adf61e73a8af0-1e5e045a0b9mr30610557637.13.1735070748808; 
 Tue, 24 Dec 2024 12:05:48 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 28/72] tcg/optimize: Use fold_masks_z in fold_neg_no_const
Date: Tue, 24 Dec 2024 12:04:37 -0800
Message-ID: <20241224200521.310066-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Avoid the use of the OptContext slots.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 7fe5bd6012..fbaaece152 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2044,14 +2044,9 @@ static bool fold_neg_no_const(OptContext *ctx, TCGOp *op)
 {
     /* Set to 1 all bits to the left of the rightmost.  */
     uint64_t z_mask = arg_info(op->args[1])->z_mask;
-    ctx->z_mask = -(z_mask & -z_mask);
+    z_mask = -(z_mask & -z_mask);
 
-    /*
-     * Because of fold_sub_to_neg, we want to always return true,
-     * via finish_folding.
-     */
-    finish_folding(ctx, op);
-    return true;
+    return fold_masks_z(ctx, op, z_mask);
 }
 
 static bool fold_neg(OptContext *ctx, TCGOp *op)
-- 
2.43.0


