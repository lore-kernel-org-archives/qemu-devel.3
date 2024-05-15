Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEDEC25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8O-0006vs-8F; Wed, 15 May 2024 05:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8E-00065n-Al
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:06 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8C-0001g6-H0
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:06 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-34f0e55787aso5222188f8f.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766062; x=1716370862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ut1tTRNwrZrLRbqcF7h53mi8stN5BjGNXrsWn90/1M=;
 b=zC0nhpyLcY6QCYvWnw/nxNQCQNigMlLYv3qtPXxPm34arjGJlvP1RtpXGFez3p2XCt
 hO25INMiNDUsEOMtVIz1aLNld5xMtqSwL6ffJUSI3r7/aRXF5bgm41x/Es2n2apz+qmP
 ZNtJD7ByRCbcbi/MDSO+19Wo8O5BbjeaklzuSQ3+KRP8+SFAF2F9C0mDxGRbLYjzubhl
 V+D8eIE4H2TIjc2PMv1ZpqllTlq4dq0+FvKYORQgHYTIuBpFaUn7BiRTaLn9FjTTy2SI
 +/X+rc29QHy+UsJEW3d60MIahr/pgjAhCz0exm73PfOyRKZhbxRPkKsuQ2hj61yqz5fj
 kPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766062; x=1716370862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ut1tTRNwrZrLRbqcF7h53mi8stN5BjGNXrsWn90/1M=;
 b=YahSXFGza5aO/sxBNsaT/QzQguH1JHyjMh9Ort082Ce1UnBLtRZkhY8pQ23/2FpNWT
 yydQmip/KvUV44e5EmKmDE2YqDjAVTJDLMaW5A5gA1l1+EdnvMtVeKYIoOwjhHpZcK6w
 Snbqj7uHwy+vifxdJWBPqKK2qTa5H+Yj+euknOzL2x/EPaFvpaZTkvrbB1+DVfXQPt6/
 khdtpPR10nvo0Y2KUTXmkNdOMMTf7OEonh82vyWEKMMrPIZhUM9+71frV/9f8x8zMTlf
 FLgOR0FTQuBLp+3h2C+uV2eOc9hmSCDm69lC53kzJ7y6DOn8cBLqfTJ6kGEpi8wb28JT
 vPPA==
X-Gm-Message-State: AOJu0YxNB97QkB7b3PQiTgWzJYmAk+WlEFIhmZoxlYgCx+DGcWv00r9f
 WXCsWSPFSX5H7UPyuNDpqb5NrjiuG2jT1n2SYuu5kNA4ODNonm4baKPJA/VomBObrkLqFuUib8i
 vwJw=
X-Google-Smtp-Source: AGHT+IHOTa5AUEuZsXHvBVRtMTvFaP6Xu1aTzaHlqlyvShwxnKpu6DOSLOUx4rGwdp/eikMGeQRgvA==
X-Received: by 2002:a05:6000:551:b0:34d:e598:b716 with SMTP id
 ffacd0b85a97d-3504aa62feamr11867378f8f.67.1715766062724; 
 Wed, 15 May 2024 02:41:02 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:41:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 24/43] target/hppa: Use TCG_COND_TST* in trans_bb_imm
Date: Wed, 15 May 2024 11:40:24 +0200
Message-Id: <20240515094043.82850-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
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

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 4e49bd2b67..af6be5100c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3516,18 +3516,12 @@ static bool trans_bb_sar(DisasContext *ctx, arg_bb_sar *a)
 
 static bool trans_bb_imm(DisasContext *ctx, arg_bb_imm *a)
 {
-    TCGv_i64 tmp, tcg_r;
     DisasCond cond;
-    int p;
+    int p = a->p | (a->d ? 0 : 32);
 
     nullify_over(ctx);
-
-    tmp = tcg_temp_new_i64();
-    tcg_r = load_gpr(ctx, a->r);
-    p = a->p | (a->d ? 0 : 32);
-    tcg_gen_shli_i64(tmp, tcg_r, p);
-
-    cond = cond_make_ti(a->c ? TCG_COND_GE : TCG_COND_LT, tmp, 0);
+    cond = cond_make_vi(a->c ? TCG_COND_TSTEQ : TCG_COND_TSTNE,
+                        load_gpr(ctx, a->r), 1ull << (63 - p));
     return do_cbranch(ctx, a->disp, a->n, &cond);
 }
 
-- 
2.34.1


