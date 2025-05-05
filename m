Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF9BC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 20:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC2QC-0006qG-CJ; Mon, 05 May 2025 16:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Q9-0006oj-Gf
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:13 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Q7-0000Rw-MF
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:13 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso44644795ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 13:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746476890; x=1747081690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KOt17JQNeTedx3lg3bvKkZN2IA0gQQiBK1NKxrnMp84=;
 b=yLUzUuJvsj3p4E6+iDw0dUfVqllc1d21bTGJmUFkICmaCZowsy42PePUkiYVXOy7pd
 Fhc0sSuoxFgKDuploaVwfTEs+6NN0DnTcc3HAqePLef5Pt8gcuObjzODFCTIsnRLfWGh
 tNMN8dyjWhzeLWTnu+40H7L/NKwGkmPnukMld+ITf4P6IBCIbUCHOZZi9pxskglmSrm9
 9/l0gGFJ92MTUsYo/ZQ1ozQ3V9aAR4DqVORZj5p9kG1fuqwWUQ42eTY5SpAgJFd84tc9
 oPkNfxt5XTACg0jEJHi9mfXi3mMADGTKWXaChsexio6DanKxuRMRY8uZgGxAVCxfuXIc
 lEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746476890; x=1747081690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KOt17JQNeTedx3lg3bvKkZN2IA0gQQiBK1NKxrnMp84=;
 b=Mr+fFz2lzb3b9zBmhwE3fv6Czin3Md/e1mo7h8vW0lsLflyHH+FVCOxAXAfG7xIKPM
 oYVM0psMHT+SVWUMSqUIwnmMPN4mW2X3h/qQLrkSzJ/ImyDRvxAVPP724hvcBXCIL9Em
 G5ZDpuPjz5mMvPQG9wXoKrFVsYWBtlLn+z6R20onhYNFNDzGWp2W3RTlJ+j4yo/4xlIX
 oGbmuMYReZr/dJBcUHe61ogqaIPI6FEwmvbKkX9tX6MPy6V8dXIPUv5S3OJ/DaHCNPd2
 mCsMPm6hyiaVZ2+WrxvUhFUIhuDFVzXjqENlZ4mG0G61gEBNYawT8aPnl06d6umrU/P3
 deTg==
X-Gm-Message-State: AOJu0YxvgKbIti7G4ryuyCpo6Q+9VJXU9MJKcPAWzg4D1OaUN1zSS1kz
 F/IVaBOVNUjiBLMUhbp2hD2Ce+MHIbibGnGrrNBjntbhzBHeBtj0xq6hdaBiC6k3LS+QazMMOq0
 e
X-Gm-Gg: ASbGncuhBfp5PYRcI9IVhIDgvRQShskwohTC0MXL7KQ1iUR3TWHy2PlzIoEe5quuISi
 Q/xHl30xe7N2vsZ1PpdfBEoVvYo4W9a+MxdIXBBxj8IX7/2DfCE/fUnAgP4VviZ0+hOR+ZL5BdA
 hilf6DYzSJyYI0xPpp/KAdxIZmHTDLMMxkozff4CGp8VMWJ53FUeI84CWS+dnhwCwiS/GgCEydh
 3Nxr+XHbJw1pf+oNdJFqKJ8vUwx6WvejM99TOZhHXMGTlQXtOHD2MDwvVHNkzJWAVPEHIFoxS0j
 XLyvSMOQobg/PicBWzvwyel5DBdSGZuVskNQE6aiKdBO31thX+BxhwTFL8L4QE+4qOAL3TOKEAv
 uiClMSOaj0Q==
X-Google-Smtp-Source: AGHT+IFQACvuioQop2gpEBab1hBMf69YrUVmDvSZQKHaUag27DlsdeELCgVViddTKRvRb5+lEoujog==
X-Received: by 2002:a17:902:e78f:b0:223:4d5e:7592 with SMTP id
 d9443c01a7336-22e328ad820mr10416175ad.21.1746476890057; 
 Mon, 05 May 2025 13:28:10 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059021067sm7516485b3a.107.2025.05.05.13.28.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 13:28:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 20/20] tcg/optimize: Build and use o_bits in fold_shift
Date: Mon,  5 May 2025 13:27:51 -0700
Message-ID: <20250505202751.3510517-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505202751.3510517-1-richard.henderson@linaro.org>
References: <20250505202751.3510517-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index f36636ed02..ab05206ee5 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2706,7 +2706,7 @@ static bool fold_sextract(OptContext *ctx, TCGOp *op)
 
 static bool fold_shift(OptContext *ctx, TCGOp *op)
 {
-    uint64_t s_mask, z_mask;
+    uint64_t s_mask, z_mask, o_mask;
     TempOptInfo *t1, *t2;
 
     if (fold_const2(ctx, op) ||
@@ -2719,14 +2719,16 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
     t2 = arg_info(op->args[2]);
     s_mask = t1->s_mask;
     z_mask = t1->z_mask;
+    o_mask = t1->o_mask;
 
     if (ti_is_const(t2)) {
         int sh = ti_const_val(t2);
 
         z_mask = do_constant_folding(op->opc, ctx->type, z_mask, sh);
+        o_mask = do_constant_folding(op->opc, ctx->type, o_mask, sh);
         s_mask = do_constant_folding(op->opc, ctx->type, s_mask, sh);
 
-        return fold_masks_zs(ctx, op, z_mask, s_mask);
+        return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
     }
 
     switch (op->opc) {
-- 
2.43.0


