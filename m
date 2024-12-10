Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0E3E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL25z-0004E1-AB; Tue, 10 Dec 2024 10:24:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL25x-0004DF-G7
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:17 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL25w-0008JE-3f
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:17 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3eb34c20667so1371653b6e.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844255; x=1734449055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zteI/mVwHb+YGRr0rE7ImI3elSxZb745PrjOakIAO0Y=;
 b=tDafcme4R5JJp41LhMPGdX9TXyZzTSDDl/3uMJ6qmAFIloWFiF/H5IxCAAXgkm7s0Y
 XhUaS3g1b4z0haoJLAxGnOniV81nU1y/3sIkNrM0Fyy80MamjLF/q03igxmL2M63pU54
 OlPgtipYrU1KKpSm5cCi9HnAOdbgwSgKpzByvBkzbuE1et4jDvsXZ+rI1uvAUZEk4w/z
 VPvyPagylWuCtXLYpaiCkCv3dGlgODMDHk6v2n1kQCL/+WKU8JrN+CURVm2PKp0M8kn7
 dYcAPrWqhEGS3mnbvXQ6MAmMG30KQIgLYew0K1Lop30kOqrEgQoBI3l7R82pzIvxWfyo
 QyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844255; x=1734449055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zteI/mVwHb+YGRr0rE7ImI3elSxZb745PrjOakIAO0Y=;
 b=MUD1gZd3FWO+MiFvRH/adl+8Ay9/+PoBmF8tYt5/fOH+XIOO2hmJ4qc/sIJXHFq3jH
 FILZDAFrG+hMs2/z3raCVPlUQikBXf9UarK486xW4Sud/6Y93+0MA8+c70Znt2Be90IL
 +0A1imvtK8xDJNqf1WXUqCOs1FsOVDycSbM+hFjKaqQv9MnwHNM8Bq4QoQoIB/nFxzZQ
 ZlHVNrFKcWCArST2h2iomv9TnlVqQLJmcS+kUPgR5JuDVo2qB2ZYPsHfa77+MIONLp/+
 3gv0iZ9QFwOuf+DzUilVGfvZFG8v4pD2kfma0zvQ3uYeNtlrCOL9mtiTwWMhbwIQqyZB
 gm5A==
X-Gm-Message-State: AOJu0Yzf9LGpaoKU8nromcyFi7+cOvcMePrw8lI2iC9lwQ6K7EcTaN/H
 HUZJlymwRt7v/99u7BKjlAMzsrdPtDRV4ac9QeBrIHrkeLaFCtrvcJPN9zR7rxANqxHH3H9xoIJ
 9S+ONxNWw
X-Gm-Gg: ASbGncs702NpE3R6oB/k9ekc6Jj8NKddyFUT931ySox5dxDc4nTR0joKpCImEVlHuqp
 Ud7YGXXFQnstEHJAxVFj+QG6HVFiryRQWYDgFVdk0DsfpCuEac0BpFg9vcyGgcdHpWGwd2VmbFm
 2Jxn7mT0bw1nZphJAloDvLgAXX95DVdUgZnaaG6uqQUP7mr+nD/MeLFKbbKIFxvnQHxfN2mGCiz
 Rzfzup9ANh8Q8o2vSpRHGg3zu+JyYvwfJW3rTOTI/MYWup7Q66t8EhUEiZOlA==
X-Google-Smtp-Source: AGHT+IHdAXFHb3ztrppIv1h67LHQ/MRW7+0BpW7btmGq3rov90UJ54HVdcddWPvP8x0fw/aEihSvQA==
X-Received: by 2002:a05:6808:148d:b0:3eb:4681:a895 with SMTP id
 5614622812f47-3eb4681acb2mr6984733b6e.7.1733844254877; 
 Tue, 10 Dec 2024 07:24:14 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/46] tcg/optimize: Use finish_folding in fold_addsub2
Date: Tue, 10 Dec 2024 09:23:20 -0600
Message-ID: <20241210152401.1823648-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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
 tcg/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 3f2f351bae..135b14974f 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1292,7 +1292,7 @@ static bool fold_addsub2(OptContext *ctx, TCGOp *op, bool add)
         op->args[4] = arg_new_constant(ctx, bl);
         op->args[5] = arg_new_constant(ctx, bh);
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_add2(OptContext *ctx, TCGOp *op)
-- 
2.43.0


