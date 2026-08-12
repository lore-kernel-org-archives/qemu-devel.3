Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FCAC5CFEB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHUa-0007Ls-BG; Wed, 12 Aug 2026 18:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUY-0007KW-Kz
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:10 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUT-0000zr-Hb
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:10 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-84867f07d63so107045b3a.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786573924; x=1787178724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6RUz6C0Ue74nBlLgIkSOBkYE1Df0XP1aeVHBqrZxGXE=;
 b=SA76rjKs9v+wdhH2bFHmFPemqCha8vAx1plQXi/seukx5fgL9bYtgvgzu27FpMeBb5
 l5YM6phqJqJ1NmD0tNd15HphnRLkVL2cK4wZNQc/bxs6z+w5gcu0R+Lx4g8eHmlOYtLH
 AGQSk0DGCp1WWzrDreRe7+Y66e2AByp08wBaDTFX1WFZwKmr39AhBxb2JE+0JOj1Dmm8
 /F+JTbmVVO7KxgwIvY1aXr3jvqANCFmRG+alO0EWo5YP1RiFyfKmSq8sE6buFXB+iY0w
 tGUyrc4dp0ZW4GIKAAT+ma6jYBRjX5xvtX1KvCRk2fqmO/JIaNFjrV9LW9R8FEUpEVb2
 H2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786573924; x=1787178724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6RUz6C0Ue74nBlLgIkSOBkYE1Df0XP1aeVHBqrZxGXE=;
 b=rbnpex3N2J5Kg7UeounCyVHLiS99G1U8IJtiowxv/xrSyb0QLttkLjwlOoQ40PjNhB
 WZaKHNsllavQ9YeU1xwprofWOMszd1vsTxvviDvBOkDyXCs45HN4rFPFgH1C4ClWC+yu
 sobcYev/cclXMo/qUM+WWps5kdvskFngiGq0/Txd0iEyFjAhAEeDvXQERwy0jNykuo6s
 qFpu6OEtRd7vzUeLN1p+0od8Act+1nnd+O90jPWtjAMIr+4X15QuJRPJw8+BGnubK/TL
 JdxXfC6+WIhQk5NBiK1SiNqnb6lGbAwAqSSkBPYRdYhlxuHfUScrSEHbtz8dt8meiowJ
 BgBQ==
X-Gm-Message-State: AOJu0YybdEqbCFYZILXMfgB68fC8tdRUQl7KONuqg2ulp25FS7j9v6WY
 9YnGeB4ByIVqKWwyakcFSpo0kXMPktWucYRi+yLlYhL3CbpgCRlb3bmlWg6cep7N+dVIsFWZhFQ
 e45Ch
X-Gm-Gg: AR+sD13GByxzOF9JpyaBCxYC4ETHnZNS/HSszKnlo5E2anjUHXCvTX1dTjwnQJdAlNL
 uaKClvc/uhYd+tUAzofCj6hwCCCUF+qc4/lBRn9x0GS3WMJh2QPRnercK3eEs/lqmH5wg0qf2qO
 mpFd80GwHTcROsYo11DQWY0LWw2QV2S5gZ+rwKuKZp2eowlXB+kPsX5tXSQarEk50CjMAYC+BYZ
 CaGJpToT8r/fuZ3wtasRtVHfOmGZJDArKe+jANuZCSyllKQWM3z3yXxfZqRQB0dCZC/SGAcGPnn
 HSfOsRM9at8d3Nh9LMgaU7XRISB8CpWi+od24Qcl/+3E3MzuHISHMSur/OesuEsJ7gsgX6mqSwm
 HNRBbvjc3RViBLP9uDMClfbDjXJ2SKdouaRRGOfX0n6jsq1LMlRNF7BGHWyItMo0ogETcNZGtKL
 866RWOkXGEoZbReRmC5LAZmW7hXUMzjQu68jZK/osNDrfRbAe7PFE4msHM1zwukf5GeprNYTRKt
 PHrZ77Jl8xdfBfHqaIO
X-Received: by 2002:a05:6a20:ce43:b0:3bf:49c8:f7b with SMTP id
 adf61e73a8af0-3cc5503993emr2442654637.13.1786573923656; 
 Wed, 12 Aug 2026 15:32:03 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721cb0bsm212031a12.26.2026.08.12.15.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:32:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 18/52] disas/riscv: Do not recognize c.{addw,
 subw} with rv32
Date: Wed, 12 Aug 2026 15:31:08 -0700
Message-ID: <20260812223142.349142-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

These code points are reserved with RV32.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 77347b557d..ddc2f73eae 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -3060,8 +3060,16 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 1: op = rv_op_c_xor; break;
                 case 2: op = rv_op_c_or; break;
                 case 3: op = rv_op_c_and; break;
-                case 4: op = rv_op_c_subw; break;
-                case 5: op = rv_op_c_addw; break;
+                case 4:
+                    if (isa != rv32) {
+                        op = rv_op_c_subw;
+                    }
+                    break;
+                case 5:
+                    if (isa != rv32) {
+                        op = rv_op_c_addw;
+                    }
+                    break;
                 case 6: op = rv_op_c_mul; break;
                 case 7:
                     switch ((inst >> 2) & 0b111) {
-- 
2.43.0


