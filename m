Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC12C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr1w-00041V-33; Fri, 17 Jan 2025 13:25:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1r-0003vr-6o
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:11 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1p-0007qp-Fd
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:10 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-216281bc30fso57582635ad.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138308; x=1737743108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Va9p08X93j/jzeWcLncWLYR0nY5/Q2/Ig5KLzRua/5s=;
 b=IVc8dmjSDb3up//lOkzIi16taE4VCM7a4USzE4oRdyrBCL3xFBySh8QZMAq0jeE58P
 7/Tc3c7lSNp2GSTuZ/zIV3oW0zQcAs35gp3M6TLy5x7DHLycG/FUTQ5Ap97XtJCgakEq
 3LsP0fnxEUj0X8sFiI1PJ6g5mGt94WnghLjuHH9dZ8bvxMzEX4l/lZU23FrqN7N6Z8Us
 gqwRSvDHL/vy1A0cMvSE9xznr+4PghId6N3Ud4VtAmXqzU2TX7FZSlRnPePs+kW7p9kY
 Mstw0bUFSAs/riGLUwhGo7WE4dmccxMgUJn0UZ+jOnLts6WcHsFc963vPyo0to0mWevk
 TsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138308; x=1737743108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Va9p08X93j/jzeWcLncWLYR0nY5/Q2/Ig5KLzRua/5s=;
 b=GZKumb8L6b1eW3rDTZWF/IYI5cAEgx/08wlil0YHRr14adVgZqbgpCN8sPU0E04OKY
 EldVRCcldddOHT0Rtrm8TwGN+Z6tzHJNh8X2pBElesEuIklXR8C5Kiz3aA2ZiL9I+Qep
 1YwCMJbKn10lA2v1QMgzMpoyqa0ngYYWVFqeFC+CR4QVgCUN5tzq8QIu1pCmxyveuU3w
 WQBIid8/JKOgghBG/FCyGmbY4xVb1QCo3XmubGJVjBWK0hzk1fXcTu70J7bPZylnmA7c
 paaZwGaRzjlh6o5UhtL99IpbaeKf86+xRZBtlvqmEkblhHNsl5z9HkmEcAKFxoJfUOCd
 +9/A==
X-Gm-Message-State: AOJu0YysiyLIjPrxcFdzKAYxH/qVPQaYQEj5on7r0fOschoSYmHj8s+N
 UUHHmqhlEDZQIwSzav0q+Ym50vGjPeVa2kHFcpULmJ2RT2zoculJ4/GGA9+P5cKX0jRzHOKAi0M
 K
X-Gm-Gg: ASbGncvUGeJN8Ov7cnph0OkA6s6WfkkJuW42HNwKRewhjYQfXEr6j4qsjbpFG3vU4J8
 qthaRR1qA+sIDmzjPOb2PSAcjDc3atcBUovH+h0ZqujtcM82WMnJhCqwo9x343NZqd4hkyfVnUQ
 kxgEdHHJIhyJ65DS78Z9A2iACzE+wKhJiVFlr2Ep90bcC8lAKQdtbakNrBtoIC19gV+FXF7GD6S
 TEoJqrjJSKDe6ywcq+6eNw1ciQoOF1mZB9CH/GBVV3G5C9UlWzMNohoBe1MdElMP/k2T17ZUtnI
 JFWVN++qFCQLzVE=
X-Google-Smtp-Source: AGHT+IGBo7FEjNXLXI4JxkXEtrpeBjsE/PS+yQIDqgGCz8g3EemOlSvZCTLJ1vxLzpXTe11OBChutw==
X-Received: by 2002:a17:902:d492:b0:216:1543:195e with SMTP id
 d9443c01a7336-21c3553b227mr58921525ad.5.1737138306908; 
 Fri, 17 Jan 2025 10:25:06 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/68] target/i386: Use tcg_op_deposit_valid
Date: Fri, 17 Jan 2025 10:24:01 -0800
Message-ID: <20250117182456.2077110-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Avoid direct usage of TCG_TARGET_deposit_*_valid.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/emit.c.inc | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index ab416627b7..a2b940a5c3 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -25,10 +25,8 @@
  */
 #ifdef TARGET_X86_64
 #define TCG_TARGET_HAS_extract2_tl      TCG_TARGET_HAS_extract2_i64
-#define TCG_TARGET_deposit_tl_valid     TCG_TARGET_deposit_i64_valid
 #else
 #define TCG_TARGET_HAS_extract2_tl      TCG_TARGET_HAS_extract2_i32
-#define TCG_TARGET_deposit_tl_valid     TCG_TARGET_deposit_i32_valid
 #endif
 
 #define MMX_OFFSET(reg)                        \
@@ -3449,7 +3447,7 @@ static void gen_RCL(DisasContext *s, X86DecodedInsn *decode)
     }
 
     /* Compute high part, including incoming carry.  */
-    if (!have_1bit_cin || TCG_TARGET_deposit_tl_valid(1, TARGET_LONG_BITS - 1)) {
+    if (!have_1bit_cin || tcg_op_deposit_valid(TCG_TYPE_TL, 1, TARGET_LONG_BITS - 1)) {
         /* high = (T0 << 1) | cin */
         TCGv cin = have_1bit_cin ? decode->cc_dst : decode->cc_src;
         tcg_gen_deposit_tl(high, cin, s->T0, 1, TARGET_LONG_BITS - 1);
@@ -3501,7 +3499,7 @@ static void gen_RCR(DisasContext *s, X86DecodedInsn *decode)
     }
 
     /* Save incoming carry into high, it will be shifted later.  */
-    if (!have_1bit_cin || TCG_TARGET_deposit_tl_valid(1, TARGET_LONG_BITS - 1)) {
+    if (!have_1bit_cin || tcg_op_deposit_valid(TCG_TYPE_TL, 1, TARGET_LONG_BITS - 1)) {
         TCGv cin = have_1bit_cin ? decode->cc_dst : decode->cc_src;
         tcg_gen_deposit_tl(high, cin, s->T0, 1, TARGET_LONG_BITS - 1);
     } else {
-- 
2.43.0


