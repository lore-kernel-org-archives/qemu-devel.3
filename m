Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7894EC531CC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 03:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn6Js-0004MP-UX; Thu, 23 Jul 2026 23:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wn6Jr-0004J2-N5
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 23:11:27 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wn6Jq-0000S3-78
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 23:11:27 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-8423f236418so1074286b3a.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 20:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784862685; x=1785467485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AJ2YiPu10FgyWz+OKrkByknO/JUWbmXrsd9mU7Z2N4w=;
 b=D4V7umvquNJIr+Fe+MPpknStWR7XFpoIesmW7mCqhafwAl26YHlOx/8NZtUozmhUHY
 MRQb+UylWVwItPs1d0H+fffycd9TbW9JbKtYE+uNHNj445M2/0mxnCmUJu9UrH5gqUNv
 vX2CkJY2Md7jGAEIazQs5fmdxzQ3GaIjIxQyfv/oXDqH+RhI8zYw5xtJnIJfgvUFm/Q+
 z/uzsd/6LNI8TgcSnUQyQk/hBqwyKZssvSHAEcA2cFeLcg/eSoH0ghAKZRD4yzGf/Z9O
 yt+dStBOXiqurfmAvLaLtDarLaAo27c3AxUNUp3rYOhZrjaTDTrda1DDIp0KwykhX0OD
 Gmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784862685; x=1785467485;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AJ2YiPu10FgyWz+OKrkByknO/JUWbmXrsd9mU7Z2N4w=;
 b=Ftlk8Cc7mh8R9b5I3q3rlOPwAQqZfO1rwTjPiBCEEzKOo3Aw9CYWMGg2TZRpsPp0PB
 R+JEDuwv4Iy3r033d0Xm0aySRziWwoEtdcjwYmishTIT/+Y2n6I5/KJp+VUpjrTMYRB9
 HCIf4fZM6vh8mPmd7kZfdniUd3ZX20mDngadRCO8ugvH3Zte/tsCFXKBKhM9VbhS/JKC
 JDu9jFprFDru3A5k1KXUODIfifhtGiE52ooaquHVkNYC57VRo82m1I5bmhe3eXYWRB4z
 iLnpcfsQX7mHqZcFijX5Z5i9BkmhHx/ihBAMDd6Byko8g5bvqXsNfGcv6x2Srm9OIyPE
 K9Pw==
X-Gm-Message-State: AOJu0YwhJjkbbhFv2BzdCekTEB1f371wF/mNjmTiY3zG1RJRFCr3PM1D
 w8LGPPH1Ur1WgMZyUlOk7ST4Vj9Eh62kfLBWDX7eWgyefKX0b6/fqtRI6cPbRX62NpyYyKNQrND
 5sp6T
X-Gm-Gg: AR+sD1231OZc9Jz3oL6zquomX6rXzQsdaccWvxNnFJgWXysfenaCqA5oBGpDCIw3LC3
 sqK/OOdslb0+96kvCiKH07rXMTD2hwILik8fdJO9jTAh3+eq9BpI3eSz8w5xTMat75d59JGtXnX
 20JlKZfzb5d3UzWvMkIahm/hj+X7B/aymJsmHFTY2Zj/alefZrYxaFerGfW9rITsdBElZMqS+VY
 dqGgx1iPGnsG1pxFkDe00eX3YG4ybyRc+qdGURbhIHpOU3Zlzhtk7C3k3PR7TKIOg62MSTjDZxW
 9HhiLrZZPjWasymLBm66SkCCw6uCPrKWW4YwkrMiH8wO0VbKcF5suHSzs7k8R6f3BXVGNEJ4Xj5
 ggLmLK+526VBQyyhGpI0mkKaIIpLwHr8lNNNvd0+ILvDv9Deou9DGrnZCJ9MNTFDe2M1LMFRWlF
 AgJfA3TrW2Xn0YneFPccdD+f897LNWeK5eIw==
X-Received: by 2002:a05:6a00:3e15:b0:845:d274:c024 with SMTP id
 d2e1a72fcca58-84e2bbc45d6mr6374815b3a.61.1784862684671; 
 Thu, 23 Jul 2026 20:11:24 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbb8f0d872bsm3617697a12.7.2026.07.23.20.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 20:11:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 0/6] target/arm: Implement FEAT_IDTE3
Date: Thu, 23 Jul 2026 20:11:17 -0700
Message-ID: <20260724031123.76597-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
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

Based-on: 20260724030616.76180-1-richard.henderson@linaro.org
("[PATCH 0/6] target/arm: Implement FEAT_FGWTE3")

Not logically related to FEAT_FGWTE3, only patch context.

Allow firmware to hide or modify ID registers exposing features
to the hypervisor and operating system.


r~


Richard Henderson (6):
  target/arm: Rename isar_feature_aa64_idst
  target/arm: Enable writes to SCR_EL3.TID{3,5}
  target/arm: Implement HCR_EL2.TID3 trap on undefined TID3 registers
  target/arm: Implement SCR_EL3.TID3
  target/arm: Implement SCR_EL3.TID5
  target/arm: Enable FEAT_IDTE3 for -cpu max

 target/arm/cpregs.h            |  8 +++++++
 target/arm/cpu-features.h      |  7 ++++++-
 target/arm/cpu.h               |  2 ++
 target/arm/tcg/helper-defs.h   |  1 +
 target/arm/helper.c            | 38 ++++++++++++++++++++++++++++++----
 target/arm/tcg/cpu64.c         |  2 +-
 target/arm/tcg/op_helper.c     | 23 +++++++++++++++++++-
 target/arm/tcg/translate-a64.c | 12 +++++++++--
 target/arm/tcg/translate.c     |  8 +++++++
 docs/system/arm/emulation.rst  |  1 +
 10 files changed, 93 insertions(+), 9 deletions(-)

-- 
2.43.0


