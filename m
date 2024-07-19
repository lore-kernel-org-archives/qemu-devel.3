Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A273C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 00:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUbh5-0004WE-K3; Thu, 18 Jul 2024 20:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUbh3-0004Sk-PX
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 20:41:53 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUbh2-0000kP-8c
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 20:41:53 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7163489149eso1129864a12.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 17:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721349710; x=1721954510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mfdkg0f9WK61DhKA38BVyDibXDaU0jASfJzlIaEhlco=;
 b=tjz31AsSyDebu/17/l5YWv7NcWQKIeijeM7QXp/C86t6d4eGvv1pJ1a2KLyqoD57Zp
 BN+8mAdq5p2pH3xFueDvA3DFZtzgDbbho5nRpNVoGROkWQs5Cfn76nSbMwqismPzDU4T
 KmHtwIb2DprKbGhsalScW3InAwjFbT5zArPzhSBqlftppHZ7cxbX77XcJhG95SkwNywS
 rnpf5g4wpKf1RfK9CQirXntJw49mCNxvZiJQ9UqsqIsVLr1FFmwil31NBY3TgSqxgKFC
 rR0zo0n3Ez4F0cipiGrmxArKnNqryZtNagLVvyjaMjcaz7PXj5Eq64QLD1vHW0vTR3dm
 a0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721349710; x=1721954510;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mfdkg0f9WK61DhKA38BVyDibXDaU0jASfJzlIaEhlco=;
 b=O1sv4JPabuPQ0ncO/TT7IFX3empnft0KYeHpmv++YMNcrhnjCpa0Mhdm5S4Rp3WmQ4
 AHvrZrz4tDt2wx2TXrad7r+jEB4ikqD/CDYSykfNx0t7eZpBnw10bdrN68AKf3/qQNy+
 ACCORVAnWtwGKjEpm5IftZWpmOG4IL9D+j7y9n0XhQDukPvBgWxK1MggjQzatB6Bn0Ya
 hSGjjpxyxDoXi6h/5GD7UYvywBM73xpzO92SkYEICbVz1scigMnJG6X4Vpnadf7UXt9m
 8dALIE63VTp7rVv9Izj++A8lD+LQNEeESIGocwC6Ir1pnPr7XM69L3+oW1uP0UcTM3VQ
 4Yrg==
X-Gm-Message-State: AOJu0Yyd6p68lcoM44n+PTt7SIhfVe+hU0WAndzmCCcqVQehq34xgpwn
 QhaEP0IDz7GMIFCpqYMTvl7v0neggqS2CRT/3mR5IG1bNW2XIfVoSfNeP9qSBLPgkSV3eRMGhwk
 8Qcoqpg==
X-Google-Smtp-Source: AGHT+IGGAsuW6m8BP8oCYajcV0JhRuZMN5pXY+LhjplmN9QkLKaNZiPJoMYPVppARapHXOokH/q3RA==
X-Received: by 2002:a05:6a20:9191:b0:1be:c43c:e1cc with SMTP id
 adf61e73a8af0-1c3fdcc000fmr9547602637.10.1721349710123; 
 Thu, 18 Jul 2024 17:41:50 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-79db9fc3559sm173015a12.80.2024.07.18.17.41.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 17:41:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: gustavo.romero@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH] tests/tcg/aarch64: Fix test-mte.py
Date: Fri, 19 Jul 2024 10:41:43 +1000
Message-ID: <20240719004143.1319260-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Python 3.12 warns:

  TEST    gdbstub MTE support on aarch64
/home/rth/qemu/src/tests/tcg/aarch64/gdbstub/test-mte.py:21: SyntaxWarning: invalid escape sequence '\('
  PATTERN_0 = "Memory tags for address 0x[0-9a-f]+ match \(0x[0-9a-f]+\)."

Double up the \ to pass one through to the pattern.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/gdbstub/test-mte.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/aarch64/gdbstub/test-mte.py b/tests/tcg/aarch64/gdbstub/test-mte.py
index 2db0663c1a..66f9c25f8a 100644
--- a/tests/tcg/aarch64/gdbstub/test-mte.py
+++ b/tests/tcg/aarch64/gdbstub/test-mte.py
@@ -18,7 +18,7 @@
 from test_gdbstub import main, report
 
 
-PATTERN_0 = "Memory tags for address 0x[0-9a-f]+ match \(0x[0-9a-f]+\)."
+PATTERN_0 = "Memory tags for address 0x[0-9a-f]+ match \\(0x[0-9a-f]+\\)."
 PATTERN_1 = ".*(0x[0-9a-f]+)"
 
 
-- 
2.43.0


