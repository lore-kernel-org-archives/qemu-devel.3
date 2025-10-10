Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD23CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 20:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Jac-0000W0-UC; Fri, 10 Oct 2025 16:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7JaJ-0000PX-R2
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 16:19:29 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7JaD-0002l6-JG
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 16:19:27 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-77f67ba775aso3664259b3a.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 13:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760127559; x=1760732359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tH9GqwR+qr0m9WVewY/OnVPs0CJUBzEaBal5CzQgOi8=;
 b=uIedGAuQ7+swakgXdtCc1tqCX1HMQKXVV9qeflsv4cUXcWwvCEkG2Z7i1Vo0m/O5gq
 o/hKcoZSqIxDN6AnWOBrWi8SJmb+Tx25Wo8Kag28zqMClRzX1g5kWgIVMPbnoTNM7bxW
 LaQxNkv6vbq1aKteeiEc3zdp11e1kdCt5v1BdKOJA9X2HebpMcKIk0L6xd49uSo4SwCU
 1gMLbhwSei30zrjE0ZeMSgQrnPd8m7bCOgtRvMkyqbBckUDYEQiGmVHYe6drvzSUAtId
 s8PTgCQdfA3CZCnaq6LSip0Pu7fOuqYDkPt6nYpWqiHpVT44w9foblX0n+eZZfHGUxuq
 q6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760127559; x=1760732359;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tH9GqwR+qr0m9WVewY/OnVPs0CJUBzEaBal5CzQgOi8=;
 b=vmyT5mHxfUyEIXqXcpkYxSb7LnGkInjeQaedypohRc6WPZueA4kSAnjUu9xPZ/P/2Z
 fyeqBH2P8+mp8FPLO541euu/qaX1EP/3rc7CfQ7EnGfFk8+uyEORCVEO28+eixIdyBcY
 DwsWCF6hSQtNHR1/VDNVTireQBZto2kqffo1ug8/ICBFSq91+Wbk0NiN6YikEeVrUbsq
 LvL38NY2LJfAAK/ukXP/huZnSPg93B8NrW8bJ/75Uc1VXZFztBHPTiRtU5GQJ1w/CfaH
 Nb2uVF4bV9K5LmPx3LW8O3z0M81o0chSm2xzwuTM0C5hx0P12vhrS7WOmemQXan2UORH
 yV5g==
X-Gm-Message-State: AOJu0YyMpwcrCW+uWtVOnlAZPcsDVMx/UVAJvV27/+HAmOfecvHrDEGh
 D17L6NyVPf2EsSL9Bk2Gov6v6FOSV4npQbd1hoAVqvRYaXmxzxvtJ5/pxk/gpWsVduCpvLtWapA
 O160at4U=
X-Gm-Gg: ASbGncvfIlXisyZIAE52TiHYPUh8mJzKNOcx1CMK43LYtUclFj5XKiykJ9U6QbvDrTy
 mbgqmaxCShgLi1gl2YzAWwT//leeo61ey4HzPqVJyWaIrOjmqos0MbQLlIwX/dqCLu/bZ0E4Te+
 Nty9NOlDO7SXLf6H5ge1b5WPW36obaEbN4vhpQLnikoKCAQTYvJHnB1xBeBrgz/w2PhxTdLVvmv
 GqjvXyXBFn7aCQigsOYAAnSTb6fWkrYQS/y2aIgJyipeBhhV8u72ND8L8WsaSHBUNVlVkByT7FV
 HkDccE/udRQkTXTWEXYlxl1xJFMeSMwYqX0y9OD7izCfmk6wfDl0Yr2LqWVKF++iJlM6S3H6UMG
 /0rvr9YrLGSDfxi8ZFfkFZxxtImWirjBNc/AgFxMtGL4Ol3q9ur8=
X-Google-Smtp-Source: AGHT+IGOTOVjZAG8K0+s1NeTd0suJH6tP99jgKSyN0SMjU7U+x/YG/bYVmZEGdslamQ5yU35tOCpEg==
X-Received: by 2002:a05:6a20:12d6:b0:2b8:5f2d:9349 with SMTP id
 adf61e73a8af0-32da8453c08mr16744614637.41.1760127558953; 
 Fri, 10 Oct 2025 13:19:18 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992dd7ee5bsm3764830b3a.85.2025.10.10.13.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 13:19:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 0/7] target/arm: Implement FEAT_AIE
Date: Fri, 10 Oct 2025 13:19:10 -0700
Message-ID: <20251010201917.685716-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

This feature adds new registers so that we can support 16 attribute
indirection indexes.  It is a pre-requisite for FEAT_D128.


r~


Richard Henderson (7):
  target/arm: Add isar feature test for FEAT_AIE
  target/arm: Implement MAIR2_ELx and AMAIR2_ELx
  target/arm: Add AIE to ARMVAParameters
  target/arm: Drop trivial assert vs attrindx
  target/arm: Use el local indexing mair_el
  target/arm: Honor param.aie in get_phys_addr_lpae
  target/arm: Enable FEAT_AIE for -cpu max

 target/arm/cpregs.h           |  2 +
 target/arm/cpu-features.h     |  5 ++
 target/arm/cpu.h              |  5 +-
 target/arm/internals.h        |  1 +
 target/arm/helper.c           | 92 +++++++++++++++++++++++++++++++----
 target/arm/ptw.c              |  5 +-
 target/arm/tcg/cpu64.c        |  1 +
 docs/system/arm/emulation.rst |  1 +
 8 files changed, 100 insertions(+), 12 deletions(-)

-- 
2.43.0


