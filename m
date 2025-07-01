Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FCAC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSQ-0005V9-7S; Tue, 01 Jul 2025 13:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSG-0005RI-Gx
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:39 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSA-0003Ks-Aa
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:34 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a6cdc27438so3016749f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389644; x=1751994444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qVAzEalqJxujtmncmmPvxYDDmAvLtGutu9NBUWptPQA=;
 b=QA08r9Aisdh1F1vaib+3ukBHhOAxztldWecm8I8bI42XOmy9HCbT1DE/tIW51+g/kY
 7Tby5GxTh5N+fcXtNBa/fq7OzWyBgWMbFORkbLteyYrbJ0czy9fftZ8VSMBS5bYUAyVA
 IQlH5MnNsNAFGeJcm5d9B+JnihEe9T2oZfCsnf1yIvoItINb3hq884kOP9SH6AJIE9UF
 KqFqAN2AlO3cG4aPjEpIT+LBkXEsqEwhQTipLOZpxPSXlMTUMesKRRVOL2ZO4byOjjBF
 HZKpu+G4M3i/+Zsot18jVuOhcc53JL1AY9AayWlxDYrTRwMHnnSdtd8r9vfZZlBhjOVo
 czpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389644; x=1751994444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qVAzEalqJxujtmncmmPvxYDDmAvLtGutu9NBUWptPQA=;
 b=qWpPsd64GeEvThAwGYu/jlt0xN2E8r0sfnMMufZJ7mqwwV19WV9EpMB2C9xMmbysEk
 TXw8rjqJA+ceJ2K/VZ4Ki9F3eNsuDaQGswsj1CoEjiKe+RADlO6vOV0HqMT7o0U05JJl
 IuJe6gTxd/zXmlgXV16OAqR04yHPx4SlrDg++9WeRML8bR5S2tH5ary0qJOBCLYSOndR
 OW50U/IwZ0Qew/iIqPH3j8hsXKvs+lSVw+G+z6Q+NS7aD/1OcC7z3Ch0MJkyY0OJ3UeX
 D/AtOLWZ6XyEBkf1K1KG6QU4zN8Rev+q6NNsnGxKcIm+OFueyS+dc98PV6UZ5icIdZIH
 V25Q==
X-Gm-Message-State: AOJu0YxaBNfEdb0Dh2J+QPmFVZUEKQQBdPUd8o6dtOFi49i6Nbx1VCFS
 fheeQsf0U1Pj3pfaT3dvkDGnmg0s7P900ZMyIkrh1Vrzinbik/CZ7v6pU9dexmrpivwKBLbtQ1P
 sZQ9J
X-Gm-Gg: ASbGncsxt4qapF2dc91r1xVV2EVEfTBFdLq3w4oxoUBrImdL4YEblxT+4B2UUsmwVYo
 8QcHDZ0LhfUCysYZPTzIGUgSqpddDyUwzXWxtVgxKD+csEAtcx6ugjWdG6zzucvtFWELpSa+IMv
 9Inha3ZeOSeq1LJKPE87tFR/TybFdIjCcNK7EbgSfUCPxX7QW5N90bMMoCaxKunCfkhflBpLL+d
 NZQgrJvOxHntD47UcBsnLSNC1yGm9GMT9OGNaSOsKXMddSFL2Pp+iLB1Ch9jjOMsn4VJmNFwzKV
 NOkiWqlTbscaC7XH4AS0jP1FIxpd2rGOcGTRf4mt/5eO9NQw/WsCgWhOitOXCUm6s95f
X-Google-Smtp-Source: AGHT+IEg8T5mGcjdQ9YcXXleR92TI4j2iB9+NXY/sKR52wvGJCY+hXjOCMVpor/r4o64LcgyNFqyDw==
X-Received: by 2002:a05:6000:2188:b0:3a4:d79a:35a6 with SMTP id
 ffacd0b85a97d-3a8f482c094mr12665995f8f.14.1751389644508; 
 Tue, 01 Jul 2025 10:07:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/43] target/arm: Make RETA[AB] UNDEF when pauth is not
 implemented
Date: Tue,  1 Jul 2025 18:06:38 +0100
Message-ID: <20250701170720.4072660-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Solomon Tan <root@wjsota.com>

According to the Arm A-profile A64 Instruction Set Architecture,
RETA[AB] should be decoded as UNDEF if the pauth feature is not
implemented.

We got this right in the initial implementation, but accidentally
dropped the feature-check when we converted these insns to
decodetree.

Cc: qemu-stable@nongnu.org
Fixes: 0ebbe9021254f ("target/arm: Convert BRA[AB]Z, BLR[AB]Z, RETA[AB] to decodetree")
Signed-off-by: Solomon Tan <root@wjsota.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250616171549.59190-1-root@wjsota.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ac80f572a2d..d0719b5665f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1816,6 +1816,10 @@ static bool trans_RETA(DisasContext *s, arg_reta *a)
 {
     TCGv_i64 dst;
 
+    if (!dc_isar_feature(aa64_pauth, s)) {
+        return false;
+    }
+
     dst = auth_branch_target(s, cpu_reg(s, 30), cpu_X[31], !a->m);
     gen_a64_set_pc(s, dst);
     s->base.is_jmp = DISAS_JUMP;
-- 
2.43.0


