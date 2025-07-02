Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA694C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwm1-0006n5-80; Wed, 02 Jul 2025 08:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjH-0004Hb-D0
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:28 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwj7-000234-VS
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:21 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-72c16e658f4so2265045a34.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459891; x=1752064691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZWAlJiBg1/vAA5C7Wnm8w8q1aX2v4P1yDX+CA5vmr1Y=;
 b=pPHJ3NAVQv4xT8kOPLbDuW/XCpR0SUXZzYwtdQsa/x3qv224r8COSr3pTRelQVCT1a
 8RnYgeodBFSFc8gMt6TDRFy+GLRZu/4a9bKyK+CeOG5zKy85O+Pz/yti1ldFEtghfBj7
 H578yOL1rOZMYFTsmoy4Y3VBVHAyirjsiqCRmI9JpCVJFuQ6Qdf8TWnG+FoeJbXC67s6
 XkYbwCTnGwaRKv1oeAd5F7Do4GlyJcGtyWu8M9jLIO1EOk1YWkEEKw1fXoyzeWUFJ1eT
 NpJNnBdFzHpbc/DXn77ZzSw7EIDFq9diHijNnl1c3+1DzQRfwNyCURnzzGpdLO9NL88a
 B+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459891; x=1752064691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZWAlJiBg1/vAA5C7Wnm8w8q1aX2v4P1yDX+CA5vmr1Y=;
 b=b/xwVHvXGYipIsexfGnfG1vEh3xkI72jd1A44heFdiXlw3E9k0Qch+KO0OsBQxM4/k
 9CZZuDSZxLlAkPhE4CnZEjYuP8e00bqnA9aIeatDD4qAb3lxylgwoIgcXszpMUCKuFjh
 6Xk6dEta26URqoQpwfEbR/v5cw/nsrai/kdY5Bgo6tI18QOEiDI8kygNs6Rs8Oa9l352
 6PiYpvxdFaYve32s7tBuqTRg3Koa0hvcUSktST23Gg7cRBeSvrrtLx1HLeK2tjTs5Cqw
 FP0/PhbaPrf20b9BurGviOwO3zNMP7EiSKpjmEu7tXcwoiAFvUIBXI4NdSK3P9H8twoT
 jb5Q==
X-Gm-Message-State: AOJu0YxnRRv6qkJ1Ni2BH6PhMlEeb//VTUhHR3YoluuF2b48P6zwTIRc
 hRzPO0gXGuykhiETIzJtHg46Rmzdx6KyoJNlasS60vDlW61IuzMHMbS1tTlJAB2cAANn9VKOd6Y
 0OfnCsCM=
X-Gm-Gg: ASbGncuQggCuQZR6Pkv1yKdzu83QzeSw+aa8u4Ho7BRUxa6FmOs/I8fDxJ5vzQcU/Gj
 niHdttNGywERErcNGq37DCEt6s7OyB3HLOiW2X6ZDerojWpouGRQY7q62M+wI5yuRK5b2sADMu1
 Zs6g47oO8RRngQo9CvH+88BCtfi67tHA5NGNxhun1uA6Jc3pXqkB637ZgJDVvH17EG+f+6pr94F
 Gmg4jxxCQZK8bCGoDN64Iof4RDTkpMcOT1ZzxDRcGC+FOscJZg1KOIRd4dgYaMZj3QSBUxJwLKg
 RuplC2tp0PGfIMIxYuSlbgy863M3KMfV1Y48zGJWyW7iTPZZY1ef70zr2JW+lWrkCtZPbQ==
X-Google-Smtp-Source: AGHT+IEmD4bGOSRqvBln9F2z7jv+YBbKz6QlSz3YYRpfzi37iKL/EGqeo5nx5e7e12xPbaSFrG8h1Q==
X-Received: by 2002:a05:6830:2c0a:b0:72b:98f8:5c82 with SMTP id
 46e09a7af769-73b4d1dc6aamr1721780a34.21.1751459890533; 
 Wed, 02 Jul 2025 05:38:10 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3843451fac.10.2025.07.02.05.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:38:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 46/97] target/arm: Implement SME2 FRINTN, FRINTP, FRINTM,
 FRINTA
Date: Wed,  2 Jul 2025 06:33:19 -0600
Message-ID: <20250702123410.761208-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
 target/arm/tcg/translate-sme.c | 9 +++++++++
 target/arm/tcg/sme.decode      | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index dce3b56de2..4fbc61ae27 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1375,3 +1375,12 @@ TRANS_FEAT(SCVTF, aa64_sme2, do_zz_fpst, a, 0,
            FPST_A64, gen_helper_sme2_scvtf)
 TRANS_FEAT(UCVTF, aa64_sme2, do_zz_fpst, a, 0,
            FPST_A64, gen_helper_sme2_ucvtf)
+
+TRANS_FEAT(FRINTN, aa64_sme2, do_zz_fpst, a, float_round_nearest_even,
+           FPST_A64, gen_helper_gvec_vrint_rm_s)
+TRANS_FEAT(FRINTP, aa64_sme2, do_zz_fpst, a, float_round_up,
+           FPST_A64, gen_helper_gvec_vrint_rm_s)
+TRANS_FEAT(FRINTM, aa64_sme2, do_zz_fpst, a, float_round_down,
+           FPST_A64, gen_helper_gvec_vrint_rm_s)
+TRANS_FEAT(FRINTA, aa64_sme2, do_zz_fpst, a, float_round_ties_away,
+           FPST_A64, gen_helper_gvec_vrint_rm_s)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 449d97bd28..9cc25622d4 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -751,3 +751,12 @@ SCVTF           11000001 001 00010 111000 ....0 ....0       @zz_2x2
 SCVTF           11000001 001 10010 111000 ...00 ...00       @zz_4x4
 UCVTF           11000001 001 00010 111000 ....1 ....0       @zz_2x2
 UCVTF           11000001 001 10010 111000 ...01 ...00       @zz_4x4
+
+FRINTN          11000001 101 01000 111000 ....0 ....0       @zz_2x2
+FRINTN          11000001 101 11000 111000 ...00 ...00       @zz_4x4
+FRINTP          11000001 101 01001 111000 ....0 ....0       @zz_2x2
+FRINTP          11000001 101 11001 111000 ...00 ...00       @zz_4x4
+FRINTM          11000001 101 01010 111000 ....0 ....0       @zz_2x2
+FRINTM          11000001 101 11010 111000 ...00 ...00       @zz_4x4
+FRINTA          11000001 101 01100 111000 ....0 ....0       @zz_2x2
+FRINTA          11000001 101 11100 111000 ...00 ...00       @zz_4x4
-- 
2.43.0


