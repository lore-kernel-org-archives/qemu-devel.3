Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11935C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 20:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC2QH-0006uM-KU; Mon, 05 May 2025 16:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Q8-0006o8-Je
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:12 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Q6-0000RZ-U1
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:12 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7403f3ece96so6434894b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 13:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746476889; x=1747081689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PzuW8adBEQ6Y8G4mfGa8N0GLrEoIeBeGx+gpNE1HJDY=;
 b=wzvQY8k3kukIKqFdBMgyMjN5YACSmaUj44kdC/X8WNjZWVyUtkSrklivbLs8ej/Xbh
 OvyOkmR88xJIQYWudpXDWleJsY/xj4+07e5qxLC6XGLJ4FkxRHQVansIAanyeUY1dqxy
 YDa4pkac7XJkMrQi/kmWaM6nopCyfYYQo7xsCXOKcYZW7cjEzB6tbEDoPyiNLk09lCSQ
 5wrn04Tvti7DEq0EHYTUCR7tslL30VIdvUyDtVkL79vpWQCO3uHCmbZ62neRk+No/fXX
 kBEwkmj4tkMngyTkFJNviDsHB/4isgYXgHo4oK5LPWRkslRfTGXFY1iF5QS/fD6zuyzR
 UF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746476889; x=1747081689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PzuW8adBEQ6Y8G4mfGa8N0GLrEoIeBeGx+gpNE1HJDY=;
 b=wQMWOZ6s99+Uzj3eCVMCLlIguMQIu/gu5yK+D10qdDziVwf0s5j9NYI+7a7KYveiKq
 Yu3IVqPjXMU7vyp5YZ2VjcV9uK+sPeAvACIAhgPpYfTV1RTR4i0PihvzmI7s7Da20KSg
 /Jdk1RvhXdd3pX7er9kBI+mS/OvrZIuI6r3c0iAAKp0BoI2X+tAhEm/B5LjuwmWk56KE
 UX1oQ2nH94MsSdalxxATwvYGHr4ACjmmSkB3KAU4qUyKaFem0jSLiQhpyD8j8lQINoAg
 swSl6D5LR2OVIxH4C5+s4JTNlAzgSiSQyHltqb0m29AXl5P3vcR5nOR3RBMdJOJRbOHF
 s78w==
X-Gm-Message-State: AOJu0YyDpZOSqghB16YK4lGBk1PF/QxNxn0zxJYnimVVtZMxlznaMm34
 D09YlhizdBJmIjRjVn8NwgOEquLpZkHltmDQ3PNa27jUesDXfhKAlIBuGkABoM15irOhlqhtwiO
 a
X-Gm-Gg: ASbGnctjetAya2xGDC6T0o8uCnfGo3HU8o4FL+D5TPwwRqyQsIf4sWhXWORUEXEnqDA
 wf8K1W7B/1FWRzpiJsDMm8knqSBkDplQ9huwsiADirtE6fmUOkhD6gGHAYrsC9ADu/SoKxEPqIc
 37ivkDifiAlQEujtxR3hQxMZnt7vh1XPvTtckE2JpbP6by6ET3ufyP3aDxAHq2g9Ht3p9uYeuqb
 AvSveD7PctFoj4NKKIXTD3om2GHx5gtaVFeiw0+x83TNz2gKa/Pa4bMXm/31iBLSknXNKr45lR/
 Ki6iFXbgS9XIpAEW7qXCs4M9AQWSBouxfN3/rH9h97X57pFR7Q7Fy3UIqqIEe1we82vk09pV93o
 =
X-Google-Smtp-Source: AGHT+IH5mgeEDNRkzzvtCSxPR5optwcAVSbT+ughAaQpU+nuvr5Qtv7WAgdTSnDKgQAV+QeIN+ABKw==
X-Received: by 2002:a05:6a21:6f87:b0:1f5:874c:c987 with SMTP id
 adf61e73a8af0-21180f5668fmr811301637.15.1746476889275; 
 Mon, 05 May 2025 13:28:09 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059021067sm7516485b3a.107.2025.05.05.13.28.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 13:28:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/20] tcg/optimize: Build and use o_bits in fold_sextract
Date: Mon,  5 May 2025 13:27:50 -0700
Message-ID: <20250505202751.3510517-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505202751.3510517-1-richard.henderson@linaro.org>
References: <20250505202751.3510517-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
 tcg/optimize.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 1040e67220..f36636ed02 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2681,7 +2681,7 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
 
 static bool fold_sextract(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask, s_mask, s_mask_old;
+    uint64_t z_mask, o_mask, s_mask, s_mask_old;
     TempOptInfo *t1 = arg_info(op->args[1]);
     int pos = op->args[2];
     int len = op->args[3];
@@ -2700,7 +2700,8 @@ static bool fold_sextract(OptContext *ctx, TCGOp *op)
     }
 
     z_mask = sextract64(t1->z_mask, pos, len);
-    return fold_masks_zs(ctx, op, z_mask, s_mask);
+    o_mask = sextract64(t1->o_mask, pos, len);
+    return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
 }
 
 static bool fold_shift(OptContext *ctx, TCGOp *op)
-- 
2.43.0


