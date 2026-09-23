Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BD6C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Tgn-0008JP-FY; Wed, 23 Sep 2026 16:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9TgB-0008BZ-Tl
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:35:04 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Tg9-00051U-81
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:34:59 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 d2e1a72fcca58-85469f20513so815991b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 13:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790195696; x=1790800496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iu9gCM+s0VdQe0NL+JCl/IZq6aTzQsY0y78oZAVciM8=;
 b=FVrIitesFuzMcM/fqWziMO0HNWRddcotfDZZ1Kx+bODmaNvPUTn2/71JhX3W0PSAQv
 Px5Z4/Nab1WAqwjZ/omuJvkv8+2YdCnUVFJMpXr+h3IMNqERUYke3SA0njTkwoT+epyi
 7AGSnrkig9ucKmZK94izFoIKR9n0Rd8M+mC4b8uBjiwWXG3gSXdCecTPzuvj7JHsQgkf
 kfLbf2EFloOZ7bU3hZ5L4eQxvm79rbKFyNrqCUsIEXiShTFZyutwAt+5GuK96Hse6oCs
 7rd5Vx9G234mfhvdbPUKyrZKqTgK+WEqqTthYdOc0q2zrOm+hZXjMVIjKDtd2NQGBawE
 Rayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790195696; x=1790800496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iu9gCM+s0VdQe0NL+JCl/IZq6aTzQsY0y78oZAVciM8=;
 b=IhRMXtmXv+4viDGfholYZBPNiHBNgf5er2XdTT9KbS3zjYUzckAqQ3KLi6EeRvQj1T
 ZDORsy3Gd6v5pHUi7ooTT4oo9WHQVFlfoGE+ynGVdSt2tOtMM9B5rVeNy+ffbri3sNxE
 Ry12QjsS0a+MkA/JJ94wHgvxyRQrMb92hXyu6C5jJ1FXYueJfc76gBvYzTsecJ+aulko
 seZihy/d2bLLnsZomul4ZxV1FAiPhbkrBMtm1/wycoHUPOFPDvyBHxwdb74BZwJmnW7V
 GA9y1qIMczxOKbID7QGA1tAakm3WV0jP1whrre/7G0NzqiH71+pZ3ObZyKNL+oyxluuk
 z5jg==
X-Gm-Message-State: AFuF++nD4YA4R5NLQNtN3ZRJrMUrsMsRnbYMsXlPo/CWZrcQ4HQowMD0
 B0iU5j9Q1rjVhn9W1E/rSazXcoFHfgzo1Se8mHrEQ8JaNkp8kmOr4v5aVBx830IXtJA+JpVJ/s9
 62oCE
X-Gm-Gg: AYBFou1QjhWfyhyXffS3Q+NjviM+SqssBmjNhweyaQe+akVgmRJ903VdWWMq4DSeWny
 KymEaV2CoGy1H8ZI6GT+yChvSwQAuy92OkAfN955KwJ7CiaAaCbJXvDJf14kjCcpkKEymVb+i+K
 X5V1Cj7Ki203XENpcy4DMiPnUKJdacUJDME67AGRTImpdTBDRIgo7DVY8+M8QjXghVSHYuCERQ+
 w9f3jXT18v2ktH0+05GeUKy5qTHXokHj9ejEYfwTZ2wqvzg7AwuFY1JSRjqr2JANQk9W4+X3FDb
 YP1NircdVnsV0PGdxW4CE/eiW3jQ2nNiZhwUdG5uhY012WV1EC9yAXtEQAlykCfv1hraXYig/qr
 JDgToaWzT//LIGuiMyhFXt6dAVWGUhXMhStMmLwYFMTPWM5N5xiTyVd0R5d0EOB6bikCvO2yc9/
 i/HXAwad8hcvpQCCe4b8f9yy9yRqd5sTDDXJMQxDfDI3dOc9pq9/hXFQ/SaXsmEHf2wVNM5500W
 eJgJ0ZJdj/Sy1DYYEy2bjo2fOmZrw==
X-Received: by 2002:a05:6a00:9084:b0:860:507d:503e with SMTP id
 d2e1a72fcca58-87e9956817cmr226726b3a.20.1790195695827; 
 Wed, 23 Sep 2026 13:34:55 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d3894211asm1678638b3a.36.2026.09.23.13.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:34:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Chou <max.chou@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PULL 14/16] tcg/riscv64: Set vtype before whole-register vector loads
Date: Wed, 23 Sep 2026 13:34:39 -0700
Message-ID: <20260923203441.31276-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923203441.31276-1-richard.henderson@linaro.org>
References: <20260923203441.31276-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

With vtype uninitialized, VILL might be set, leading to SIGILL.
Also, assert vtype initialized for whole-register stores and moves.

Fixes: f63e7089b4 ("tcg/riscv: Add basic support for vector")
Reported-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv64/tcg-target.c.inc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 2ce9d47a633..de9a3570b23 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -775,6 +775,7 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
     case TCG_TYPE_V64:
     case TCG_TYPE_V128:
     case TCG_TYPE_V256:
+        tcg_debug_assert(s->riscv_cur_type != TCG_TYPE_COUNT);
         {
             int lmul = type - riscv_lg2_vlenb;
             int nf = 1 << MAX(lmul, 0);
@@ -1014,6 +1015,10 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg arg,
             unsigned idx = type - riscv_lg2_vlenb;
 
             tcg_debug_assert(idx < ARRAY_SIZE(whole_reg_ld));
+            /* We must initialize vtype to something to avoid VILL. */
+            if (s->riscv_cur_type == TCG_TYPE_COUNT) {
+                set_vtype(s, type, MO_8);
+            }
             insn = whole_reg_ld[idx];
         } else {
             static const RISCVInsn unit_stride_ld[] = {
@@ -1046,6 +1051,7 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
     case TCG_TYPE_V64:
     case TCG_TYPE_V128:
     case TCG_TYPE_V256:
+        tcg_debug_assert(s->riscv_cur_type != TCG_TYPE_COUNT);
         if (type >= riscv_lg2_vlenb) {
             static const RISCVInsn whole_reg_st[] = {
                 OPC_VS1R_V, OPC_VS2R_V, OPC_VS4R_V, OPC_VS8R_V
-- 
2.53.0


