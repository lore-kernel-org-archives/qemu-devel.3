Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FACC5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHXi-00012P-7T; Wed, 12 Aug 2026 18:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHXg-00011A-Pv
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:35:24 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHXf-0001oe-64
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:35:24 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2cc7e86e7aeso20578365ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786574122; x=1787178922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q7rP/XM/owlqnwOCNDD6Fk3HJHISzcNBKQfAsZY+VBU=;
 b=hhGCdUUCdAyv4VTd9UVgJTzH9i1YAK4QAxZK0WrqHu5RdO3bTtDgJB5PsgEmka/9KS
 JQzwkQQuXLxNTFDy2WzsdHJd2e4m5JU6g5uuBb/I/sETF7Lw5KDFclTYY6q/c6tIKGvH
 CS8ogd4iv1OUfWW/j9jOSisOcwfVTOXODnvS3KZCiBXx8/3drFInXbgNItW6+lFCo/ty
 tPUClpvSwleERuWUe4VsWZ11YUDeKt+hMhEjq5TDAyijMv5+QJv9uqtXYcTXKGygSUmf
 PRH2JCsWLb89c1ChL5uLlwFQQvTvqG09cn2pn0A2vyL6veJe3JJGDA+qVkDDAXPKSuUY
 4c8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786574122; x=1787178922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q7rP/XM/owlqnwOCNDD6Fk3HJHISzcNBKQfAsZY+VBU=;
 b=F+dhfjynofyJ22IE8yuF+a85mmW/ijopAt4tPaKSOQBYNlAZ3ZNucxFNKZcnFJ8OWl
 C1UV2tDIUZts6deuHuvuFEcnpUM3wDvhacXAt78EuWqStDJK11xHL3FUdF7D85x9JBI5
 9e7JJS8dWfPvOgYykCcpzQEgaIFOUgOCH3ISFBd/CJacoK9RIRhMiLuzXFpc349Mo+Cw
 GANDFfJqcr+Mxi5veq/3e3DnCi4HukBVHE5Yeqx7VN0Y3VOa+zWAbP5ZGqsLXQFNbGCL
 RzZDUBp0qas/dFM0IGppoheWHlkbiWAX6t82qOvSWAJLhnRGbymr92qqOuEVOEHcbi3n
 yPEg==
X-Gm-Message-State: AOJu0YzEBMkkJJVbJAe9MzN8nsGmuvhYSw+xjmKyanHfdqXrTk8f/mo9
 CZUzn1EW2xT8EYBaqcwnX/cWYGbh3tLp0tFCncJncd+tq/51gP0DvHLgPKPNKEF8nlGElzk0Vzi
 yyYWr
X-Gm-Gg: AR+sD13Fyi/91uaZ+LIgiJIKvoYn+EX1vx9CuIgNirp4ilbYnRIVra/2oXHguAwXUKA
 MeyOvwQW29qfauH7RGf/5a7O1gxLNvCGQ0p2FBfQ6Ezp7mJmHtc+e9wOeHaLNYZSTrwVIVR3BZD
 zgPdaAVdEG6+1iTK5ktVhyxJRh+Heq9JqZ34+RTi1s5zRUU2ssyHcc9eiH7NVvL3aOwJqkdG9pP
 Nb1tiJ+gR5NXoj5MH2RwS4DSScC8etMCQHmpejgHq38zD0H7DvN9A1gfWihw+udJZ4pnVMBj6g7
 kO3mcQ8KF4P815zlGMy6QJFK9FVqb61c1REcR6LanyRUgq0mBuW0owYufCgNByPf+wRW8Ai7sjz
 5puVe3s3MIf4sMg/agw5THHU5OSkCTVN7c0GvZFGykGlF78hqxG+c7aMuaamZ0F1VkZvoFDcFj0
 lGsO76mlSx04xAJcg6VPJA4SZQFVXYyRpwbIDPT3tWsenkhE7EvUphhRkbtMQcey2HHl9SrFDMB
 ih6Lxt04EvkGRCgFxpn
X-Received: by 2002:a17:90b:514c:b0:38d:ddc2:7ccb with SMTP id
 98e67ed59e1d1-3931dfd0897mr1815582a91.1.1786574121542; 
 Wed, 12 Aug 2026 15:35:21 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931f41cd2fsm464854a91.12.2026.08.12.15.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:35:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com, qemu-stable@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 40/52] disas/riscv: Fix typo in th.lbib format
Date: Wed, 12 Aug 2026 15:31:30 -0700
Message-ID: <20260812223142.349142-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

th.lbib should format the same as th.lbia, and the other
increment insns, with the address register in parenthesis.

Cc: qemu-stable@nongnu.org
Fixes: 318df7238b9 ("disas/riscv: Add support for XThead* instructions")
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv-xthead.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disas/riscv-xthead.c b/disas/riscv-xthead.c
index 428a6380e9..fbc96631fd 100644
--- a/disas/riscv-xthead.c
+++ b/disas/riscv-xthead.c
@@ -189,7 +189,7 @@ static const rv_opcode_data xthead_opcode_data[] = {
     { "th.mulsh", rv_codec_r, rv_fmt_rd_rs1_rs2 },
     /* XTheadMemIdx */
     { "th.lbia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
-    { "th.lbib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml },
+    { "th.lbib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
     { "th.lbuia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
     { "th.lbuib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
     { "th.lhia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
-- 
2.43.0


