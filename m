Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5272BCD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 18:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ7pS-0005Df-Os; Thu, 21 May 2026 14:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ7pM-000526-Tt
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:09:00 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ7pL-0002sR-4O
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:09:00 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso75921795e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 11:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779386937; x=1779991737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hTMtQIl81FhHhQ92f8dO1f1utzKZ2skRlj6T2ncqBcs=;
 b=zciE1MpnrnjL1QdZFIj2r4ED5EgIiLVZwLeUgzhTsTIfWBTnsBCMl3sOc0NxMKNS6Z
 Up51b8WQbbehaOuVXKuyRccX6kyx5/zqHsXX6f2aJ0hK8DwdbHSPayige411HupBruCf
 rP9BZ4G6qZjtwxy46sQVMlfYxKk8VkxJykjqf9m3u7Bo+O7oHwHR08ViwV38YViORJ3q
 K5ZbZFOFbFYJouN740Z6awbmaS+vfqcfqcPbDDwjz0CEU5pwVDreAEOjudzgk519CS7R
 MIHDmMH1Gq8OHgqYzDIG8XSqj4/Ut8C5zyP6Z0GEfMamD2RGVeEa4DVQlZFjCEte5SZt
 vMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386937; x=1779991737;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hTMtQIl81FhHhQ92f8dO1f1utzKZ2skRlj6T2ncqBcs=;
 b=XrLbhjkckVF57ofQ84fa8a3rPjKpOlmpgzly1CGhb7WmnUaJgHoW6+J1+K7n12aYjb
 yhPqEtk4PYOUsKreVhkl7Z9H867zLOJmpu9aB/mDIreGBNj9aMz8pfdAhHIiQT9Z/N+X
 ZfVHgQzLOdVXeJqWBjsjb/6+inlAb9iUYLLFvXBM5USZxmyPgSkYXi9wB/uUJ73QDHO7
 TVaIdsv/QHTjtEw2PJ1woWAXRgJ8VWmP8Qvf7ujzZJti7+beODJso0EzHYlC080seIii
 ATt0lUvUU0g3T6cHZvIqwC7EWxsZkfjJ/hloT4vwEcqszl2Ki+hzrEPxFGrefwdiK6e3
 s8hQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WVJyRVpcXbUHgvwie7B0VZApkZ9G/YD7EozNSmjsdJDaWAnQY3tK3OiRGe+iVS33G7spQNJy9QX2N@nongnu.org
X-Gm-Message-State: AOJu0YwUf++0h7Xzs+2dEC/D7OresecxwOqv2Bx/q+aFsypiBNbIjYNR
 slcxrps/iRhKxd/wOUg3Sga8MCzxcxEMprnfHT2y4BdZl5h88vQfaN/FKeJi1mVcpro=
X-Gm-Gg: Acq92OH3Ar0gi75RGr6kxEoOzSDemWli9N6jdNSBLB0wXZBla1hg1iXbKn7Yye/pPJ+
 /rpNgKVdl1ZWVuCnlCAcTBOuBNbxYWv4Mo57BFA2Ub9hSi/DEqv7UE2q5gag6eL8ip2TirT9cb7
 dCxvqLFDMN9EoizsJ5XuK6rPb+W28K1r7GKw3tkMbaGpgqBbeiurjzle0pCJAyUOg/r/yFgwkh6
 7G6HQCtj+xUq6EcqdUgw0wFk/dBoFxn/3hDsoyX0WRrSYJHZbRP8MmKtQpuvCXVYP0xgsvJ/cYq
 F1czhcRzFTwoVNnFRq1GFdPmKH3kRryCgzqb5H9LNYT0y3T7oQIOrh1sjnCv9lwFcgJ1WYNMqUm
 Fd22Nq9BeM3yFCLCXzNeLwtmdJv3hawa/lt/FJ/8EjkUy76F2DsQY7ZFAokUmO2DHpGZwz/Ku8m
 3gZtITj1+pGonsK2T2AdyjjvV3QmUHl8kQnKU8dnGfGtyAb7btt9Now85LBPk0CruWoPgwYkH/L
 Pi1sRXpyeWajQ1n4R3i0NIy3oSZyrk=
X-Received: by 2002:a05:600c:a414:b0:48f:e518:d110 with SMTP id
 5b1f17b1804b1-490360ebc07mr46826345e9.32.1779386936634; 
 Thu, 21 May 2026 11:08:56 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490417499f3sm2298025e9.5.2026.05.21.11.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:08:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] target/arm: SME BFCVT,
 BFCVTN have "Alternate BFloat16 behaviors"
Date: Thu, 21 May 2026 19:08:54 +0100
Message-ID: <20260521180854.1744788-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

The Arm ARM A1.5.10 notes that some instructions have "Alternate
Bfloat16 behaviors" when FPCR.AH == 1.  We implement these using the
FPST_AH and FPST_AH_F16 fp_status words.  The list includes the SME
BFVCT (single-precision to BFloat16) and BFCVTN, but we forgot to
make those use FPST_AH_F16 when we implemented them. (We get the
ASIMD and SVE insns on the list right.)

Add the missing logic to select the right FPST.

Cc: qemu-stable@nongnu.org
Fixes: 465d36db0e1 ("target/arm: Implement SME2 BFCVT, BFCVTN, FCVT, FCVTN")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
(There will be a minor conflict with the rename of BFCVT to
BFCVT_hs in RTH's FP8 series.)
---
 target/arm/tcg/translate-sme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 08254b088e..8e56dedaa3 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1419,9 +1419,9 @@ static bool do_zz_fpst(DisasContext *s, arg_zz_n *a, int data,
 }
 
 TRANS_FEAT(BFCVT, aa64_sme2, do_zz_fpst, a, 0,
-           FPST_A64, gen_helper_sme2_bfcvt)
+           s->fpcr_ah ? FPST_AH : FPST_A64, gen_helper_sme2_bfcvt)
 TRANS_FEAT(BFCVTN, aa64_sme2, do_zz_fpst, a, 0,
-           FPST_A64, gen_helper_sme2_bfcvtn)
+           s->fpcr_ah ? FPST_AH : FPST_A64, gen_helper_sme2_bfcvtn)
 TRANS_FEAT(FCVT_n, aa64_sme2, do_zz_fpst, a, 0,
            FPST_A64, gen_helper_sme2_fcvt_n)
 TRANS_FEAT(FCVTN, aa64_sme2, do_zz_fpst, a, 0,
-- 
2.43.0


