Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B592ECCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MzD-0005ku-Uq; Thu, 16 Oct 2025 08:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9My0-0004pZ-Uh
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:20:25 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mxl-00009N-0H
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:20:24 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e47cca387so8358515e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617199; x=1761221999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L9OU5RAgwYJOyn0/MHG4gHCREARvoJ9Vu/F7kecjiqs=;
 b=o4xeO9zyN8NXLvkJilx2g7GAzGOE+CBuf+R/ZMkQ/QCqKDjU4OcAVlguZGHhkj/PLZ
 11hzukjrmXN0yhS2WNVpxB+Ja/DkKYNtIOdCGNJ3MVybrCdKDlQ/TRQ6qBIsSv01b7vG
 nD0UbALNvDz3j5Y002LD4e2ifbG6/CIeCxrdLs8UHhCLn02M1BT6f+r9gfNWE1+f4uB5
 HkvevZharA0iYZ6CN4yPj6LA6MlAURxyOvS093smlXQbOWKg2IZ0ezPP8Jxxn/JcQ7tj
 qm2D8Rd3gqUllhnHh6mLxDRSvH4b/30M5yKULyqT/j3aIWZ61XcUFzEzpz4+Kt7C3NbQ
 CxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617199; x=1761221999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L9OU5RAgwYJOyn0/MHG4gHCREARvoJ9Vu/F7kecjiqs=;
 b=U06wASI4ETTp8nOwvOfmI12NjbQx0QCQ8boj2x6xqgJZa0vI8tFcL8b4oC1c/q0HG4
 TAJv6lBsf5S+FAg/6HPFjXtl0jXXe3LxaA6HoY9x9k+oay82bOyLNfGpQCb+WasGV3K5
 zeviMsoQZAgWicXog4XsLkXG9PTE3lWNhPvwNyN7N5nX/uQGxbjjKqq+JP3y0VE72cq+
 eWKi63gZdZMtyyJ7cM3H6LgBA6wg6z0aHsGeC/8r7C8Y1+DUc/qIa7urDZ7HDayeI+w0
 zsRGemaN2wibD4EhFj1m/OL+vAh9OfeYHAdf7bnDZ8VgdcijbUnXu5Ixlp21Po4cRQtx
 Y+BA==
X-Gm-Message-State: AOJu0Yx2bLVB3kXMAB/BtfLUVZV9yFHUnkDKFU4LXf8YgoYnFXwHaqFc
 PuGo3v2cq7BSiJtLEgUkXv+sf6V3M7uwl/VheIffD5ftE2kken3bNg5IjBr2gd7IQ+goEFvClfF
 iGTdrLCE=
X-Gm-Gg: ASbGnctKLdZV50BshGBaxugVylEIkV2uyJxxzjDT9+I/fJjReORmUphiuBzs9utt9SB
 6F/y1zy4d3ZZrrklueOuRk356q5sI6g8PdYD/gGHm+tQBiHROHKPNXFe+KZBmn1WmLLJDKS8SXj
 IQBXkHGrlsriepStKXnftwoEjsZs8dQjwlprhLgCQz2Waol9s29Ci7WARfSCaH09orEbcmX4EHA
 AkmltHnHFIDrnHMn7E6YKCw1XSICsL77J5qRYF3a/8/LfFvsEJiEuoxPoE/jQfUKMaCZ2xNuBS+
 sUWkRbd7ARuvsJNOO7ySG3GdgWCSEq5Y5PCn4a+8+eN2WrH0I11r+cjJhZenYErpouIwJmwm9F+
 Bl6WxJBdaKOdnIjNgT96hTNuT40NVNGG3Byr5bdPrZlnVVoqD0ZUdoobJExvhAP6RRwJivGUkgn
 aV5YqpjcQbpSl62lV5knRmXCShLwlm81iUipr4dkxaQJg7KvfkfAW7zQ==
X-Google-Smtp-Source: AGHT+IEkrp/Llv7TH2PcIvZQT2o0o+OTlDdJMGMPSfT8pveQjIMebyGGJIOs2tysjNjlE8ZQsKVX5A==
X-Received: by 2002:a05:600c:8206:b0:46c:d476:52f3 with SMTP id
 5b1f17b1804b1-46fa9b021abmr209314785e9.26.1760617198747; 
 Thu, 16 Oct 2025 05:19:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47114423862sm23873995e9.1.2025.10.16.05.19.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:19:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 57/75] target/sh4: Remove target_ulong use in gen_goto_tb()
Date: Thu, 16 Oct 2025 14:15:13 +0200
Message-ID: <20251016121532.14042-58-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

translator_use_goto_tb() expects a vaddr type since commit
b1c09220b4c ("accel/tcg: Replace target_ulong with vaddr in
translator_*()").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20251008064814.90520-7-philmd@linaro.org>
---
 target/sh4/translate.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 137b75a4fb2..b3ae0a3814c 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -223,7 +223,7 @@ static inline bool use_exit_tb(DisasContext *ctx)
     return (ctx->tbflags & TB_FLAG_GUSA_EXCLUSIVE) != 0;
 }
 
-static bool use_goto_tb(DisasContext *ctx, target_ulong dest)
+static bool use_goto_tb(DisasContext *ctx, vaddr dest)
 {
     if (use_exit_tb(ctx)) {
         return false;
@@ -231,8 +231,7 @@ static bool use_goto_tb(DisasContext *ctx, target_ulong dest)
     return translator_use_goto_tb(&ctx->base, dest);
 }
 
-static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx,
-                        target_ulong dest)
+static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx, vaddr dest)
 {
     if (use_goto_tb(ctx, dest)) {
         tcg_gen_goto_tb(tb_slot_idx);
@@ -268,7 +267,7 @@ static void gen_jump(DisasContext * ctx)
 }
 
 /* Immediate conditional jump (bt or bf) */
-static void gen_conditional_jump(DisasContext *ctx, target_ulong dest,
+static void gen_conditional_jump(DisasContext *ctx, vaddr dest,
                                  bool jump_if_true)
 {
     TCGLabel *l1 = gen_new_label();
-- 
2.51.0


