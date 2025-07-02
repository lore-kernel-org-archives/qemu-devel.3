Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0943CC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwm8-0007IW-Qb; Wed, 02 Jul 2025 08:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjV-0004Lc-Lv
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:39 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjK-00027a-Qq
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:32 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2ea08399ec8so3839859fac.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459905; x=1752064705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DUhF1s+4qjdmZFO/C6HZ9kpoz631UTmeeXLwnW20ScI=;
 b=JwsSINWTe0YTI5RdY3Xs6m81CrMJkYT/MRbwmZJ8uRqTsMXbbZi7F2dCPtwBywCpDz
 CqNjArrkJtP7NEdGpHuIrDVbuIgKX313SaiQH/hjP6acK1mbIPtVDzoBQRHTyOO4A5G9
 agbm6HXCIASdsQ9UqS8Ez0U1OEgjGKxSQ6TxJ7p+bMgxx+htPIEf0HMA2fHlzQHSyvUA
 rwmwXHQ8N7crob0yVLno+2QQECCCJLoDtXkEvXXdYclBXz8B19an+Wl8jZxK2k24XEf/
 HRJC7IX5LmsvmZwE6AE+o1nOihf3WY12kQ8wrYKcy3Yr6DT5qNp67uvbLRZyJAslMbz0
 nSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459905; x=1752064705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DUhF1s+4qjdmZFO/C6HZ9kpoz631UTmeeXLwnW20ScI=;
 b=vmlulhbrKakpQMu0sJ5TJe8dWNFtzl/nrp+AHkVM18IpYdqWCxYuW43QkxVl/23UhT
 1dnn3JpvBbU0tuAUFmieQsMsqvtvPKIL7VCuweewAlFrb28zqmw+cp008R0FyFLR9fXT
 weLzixxtCT0xygoLxUAEFbsVo6zr4CpP38umqyzwmPJRJt4zZhd49Bnzxpj6V85pB4XF
 RNDc9J+02kmmBi9oxj6VaCWQvRVpnFrFb0IVj9882L9raqX4yJ7OURZyUSwoCXeRTC6X
 zbSd+dPLmJvGHmBj5xNsSdCnzjipgrA+M+0JvKnsSCOQSmjQs6YdtbjfSVMP3riG2lgO
 hAYw==
X-Gm-Message-State: AOJu0YyOKaovXGeeIyYO56+XBSBFbYfv5V+JuqZmUK+tIJV7q5ne7U2W
 1j/E8+S36e1rb5QainK58PjCYKFJiSJF8bdJBqBGnz8uWXuILI+YqJZkg4LQD04/1rKH+fWJwS0
 REqpYs3k=
X-Gm-Gg: ASbGncvforSPouuQ7ZbMSe7A/7lZ0u+F9mrNNRf6+emKofZ/MwSWgS5vosajBBMyNto
 MdWLGEyn0nuZiKzLl1BSiPBDJgOlb6aYBqOq28G6EMRg1voiw4G7vqSJneE6dfAY6asZXyf/UzG
 ZLwG4pfjZK6Tw3dRQGj9Mr7NRW1t/H/pt5s/pVc4/+bNg4pg/dJ/r8IK+ut8ASj4yYa40F1P6xc
 Qos0XN396onLZEsQaLY20kEdo7R8+JglQ8/Y0y94GvjcMAUXHtIUxbDUwnM54aWCjHi7MjqKHTD
 an4t0JiAI2jwTLVffRab4p5pBFs1MlNHCsOo2NyBSbp7lL2XAuBGUQjXoBC9AAeAOWxzpg==
X-Google-Smtp-Source: AGHT+IGVjwJhCdHLSJQt6zBTSOxltrNQeHxhZvO+15Bpwv+m0qfgriryHqntqY2ngt+23FURjO6RVA==
X-Received: by 2002:a05:6870:5a4:b0:2eb:87a9:7fc5 with SMTP id
 586e51a60fabf-2f5a8cb4ac2mr1715507fac.16.1751459904778; 
 Wed, 02 Jul 2025 05:38:24 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3843451fac.10.2025.07.02.05.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:38:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 57/97] target/arm: Enable SCLAMP, UCLAMP for SVE2p1
Date: Wed,  2 Jul 2025 06:33:30 -0600
Message-ID: <20250702123410.761208-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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

These instructions are present in both SME(1) and SVE2.1 extensions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index ac4dc7db46..ff70bf27b0 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7375,7 +7375,7 @@ static void gen_sclamp(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
     tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &ops[vece]);
 }
 
-TRANS_FEAT(SCLAMP, aa64_sme, gen_gvec_fn_arg_zzzz, gen_sclamp, a)
+TRANS_FEAT(SCLAMP, aa64_sme_or_sve2p1, gen_gvec_fn_arg_zzzz, gen_sclamp, a)
 
 static void gen_uclamp_i32(TCGv_i32 d, TCGv_i32 n, TCGv_i32 m, TCGv_i32 a)
 {
@@ -7426,7 +7426,7 @@ static void gen_uclamp(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
     tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &ops[vece]);
 }
 
-TRANS_FEAT(UCLAMP, aa64_sme, gen_gvec_fn_arg_zzzz, gen_uclamp, a)
+TRANS_FEAT(UCLAMP, aa64_sme_or_sve2p1, gen_gvec_fn_arg_zzzz, gen_uclamp, a)
 
 TRANS_FEAT(SQCVTN_sh, aa64_sme2_or_sve2p1, gen_gvec_ool_zz,
            gen_helper_sme2_sqcvtn_sh, a->rd, a->rn, 0)
-- 
2.43.0


