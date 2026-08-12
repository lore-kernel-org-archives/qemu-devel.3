Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3C2C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHUv-0007f0-H3; Wed, 12 Aug 2026 18:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUj-0007WG-8z
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:21 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUg-00017o-0g
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:20 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-8487b7b3fc8so1724567b3a.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786573936; x=1787178736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ESOH/T2TcAfFYuXGLNTkhmv7CIu2QKJrGhscHmXo9TY=;
 b=BJrqleyypyMR7RpReEEWlDOSzE9KbUBJFZhmNpmdv19yqONko5ZHI1CCh6fTsoGuNW
 Y4VzF5zjQX5FpxUDCEIJDnjp8ku8XsMeZwrKAxAG+Y+17JJz41jwM5xHMUD99zgbSubk
 3kYgxk590U76r7XlxifH68i5IVXOQtX+Boj+hGUpl2oNn3OTDH8AaebFwMnucFIHM270
 A1iYqdpbrtoQDj8TMNwmlaovZxqPVKyprEuHUfeWScLszUSdDR6BZJ/0g0c+VCtEXzkA
 tWx8J9fFFkgwC66FuwDCu/rWz1oA450YerIqbhGcNBZNY0io4Fy75Mbn6fdCb7UUN9S9
 6nkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786573936; x=1787178736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ESOH/T2TcAfFYuXGLNTkhmv7CIu2QKJrGhscHmXo9TY=;
 b=UasGjeoMz7xE6VxIeejgM/SKZbv0hTBe15nUHXVPqLl85UgYBLx3duPPaxJT3KwabM
 lLGh7PgDPqOrPXlg1YIl34He0cYa/b40d7NlPUa/3rEdmMVFvNK1cygNzKzOHr/Armb3
 jO7/gsvq3410/aH6QXNvqQuBl3M411QSwCguOqmmTVusmNjCm/Cmq5pSTuryRcfvXjjE
 Hi9fGpQkQpcl9bAC7ZLHxNaYTV5r495nQ2PPiuUAJ3g9hm58EqnWvLnmXp0rbetmUCwa
 paxKlRkOs8YQ6itzivoqGBH6PYEY8qyYWhZDTuBiZ4SP8+Hpl95AZg+C5IhBtukK3wIa
 akQg==
X-Gm-Message-State: AOJu0YwFBczXWJY8SYJXsdHRZ8eO4ujaE0es9243MaHdAhr44VyLc/GH
 jia0hrSQhOdd5sk7wDAU9XLEy+7Js6Gi92zmHwc7UHaontX1K5HON+WCg0/s/p/V/DgBT1x1XD3
 lodqj
X-Gm-Gg: AR+sD11xKuSBgMG0w/0sRYMKHJyCm6RiSFWiTcpE13nxJXvjVaE8KYmgDWRwEYK+4Pg
 cnGHnBHinJuyB8/sCRK+Zr31AuCVCuI8j1xyEX+J22Gzu0Q6l+UJ/vDaRtiLpSugQ8/vU9F5Em/
 E/jQKvnzkr2xBrZnENF17q2HKNY/XfdOxN2wFyg0BDMbv6VJ4tVEztQnQ0uXtRvCnmvZpbI2Lv6
 Op0KMQbKaYE7C39ydz1PUZRJW1aV5SOxbaiuQ154FR7X6snZMR7uUS4PIuOSskVnZgePIplKmzc
 EjvSFF6wyiubHn/z2wtrB1w9CAPfvogCyUeVdkYz2gW67t/5mga0sgDo2JJ4V425avFKgrMVFQH
 ZbUx6LnDKGMVi1D3pBK85YX5uA5fbxlG2eyggxyhBXy6OWUlaOzU5UdB0OUPZpAliQmrPSBQbAL
 FobS/b6mcDGcrT93eeAT0S9/J3LFQKZPiYsEVf7FYgo9YDGdv5w/zrFXrAas6Cszc2FupBc5lfO
 mN/HtD7f1hzXqWlkC5H
X-Received: by 2002:a05:6a00:8009:b0:845:ebbf:e7be with SMTP id
 d2e1a72fcca58-84fc75d601emr1215864b3a.23.1786573936253; 
 Wed, 12 Aug 2026 15:32:16 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721cb0bsm212031a12.26.2026.08.12.15.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:32:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 33/52] disas/riscv: Simplify some insn decompressions
Date: Wed, 12 Aug 2026 15:31:23 -0700
Message-ID: <20260812223142.349142-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Route "c.j" to "j" instead of "jal", etc.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index dedd925077..342e2db3cc 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1848,15 +1848,15 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "c.and", rv_codec_cs, NULL, DECOMP(rv_op_and) },
     { "c.subw", rv_codec_cs, NULL, DECOMP(rv_op_subw) },
     { "c.addw", rv_codec_cs, NULL, DECOMP(rv_op_addw) },
-    { "c.j", rv_codec_cj, NULL, DECOMP(rv_op_jal) },
-    { "c.beqz", rv_codec_cb, NULL, DECOMP(rv_op_beq) },
-    { "c.bnez", rv_codec_cb, NULL, DECOMP(rv_op_bne) },
+    { "c.j", rv_codec_cj, NULL, DECOMP(rv_op_j) },
+    { "c.beqz", rv_codec_cb, NULL, DECOMP(rv_op_beqz) },
+    { "c.bnez", rv_codec_cb, NULL, DECOMP(rv_op_bnez) },
     { "c.slli", rv_codec_ci_sh6, NULL, DECOMP(rv_op_slli) },
     { "c.fldsp", rv_codec_ci_ldsp, NULL, DECOMP(rv_op_fld) },
     { "c.lwsp", rv_codec_ci_lwsp, NULL, DECOMP(rv_op_lw) },
     { "c.flwsp", rv_codec_ci_lwsp, NULL, DECOMP(rv_op_flw) },
-    { "c.jr", rv_codec_cr_jr, NULL, DECOMP(rv_op_jalr) },
-    { "c.mv", rv_codec_cr_mv, NULL, DECOMP(rv_op_addi) },
+    { "c.jr", rv_codec_cr_jr, NULL, DECOMP(rv_op_jr) },
+    { "c.mv", rv_codec_cr_mv, NULL, DECOMP(rv_op_mv) },
     { "c.ebreak", rv_codec_ci_none, NULL, DECOMP(rv_op_ebreak) },
     { "c.jalr", rv_codec_cr_jalr, NULL, DECOMP(rv_op_jalr) },
     { "c.add", rv_codec_cr, NULL, DECOMP(rv_op_add) },
-- 
2.43.0


