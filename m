Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363C8C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 05:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLyPh-00011Q-6x; Tue, 25 Jun 2024 01:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLyPf-00010z-Kw
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:08:15 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLyPd-0001V1-U8
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:08:15 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f6da06ba24so36814005ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 22:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719292092; x=1719896892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uuKRzX/CVCBtz4u0mZkWLcpWrMUD415m7eGI+pRHqts=;
 b=OII6b7yeCPvowH5p/UwQcV2q++/gVpEMNzuhhy5FP00JsutesEWS31z4HebAHpXfik
 G/QSKpibjcXdACQMqm6G7q01Peagwrp8Q69sdItXxg10g/+GzxkoGmgkrOpw+monp/CJ
 DZLFcnnL4YMsHqy0NG22khp2uCTrXGlKVbvLg+5l/iVa5rTxFRd69tOx1rzksV00tjKZ
 Zx2jwFEBFxXMWgn+w59UyESu7OV3lIEWg9ZqEc1tQWYXrxwuX3H8Vy2hCPXboU0EX0r2
 8A2WJ1ectvcqMzoewE+RUIG7wtC09bojm6RUGN4EfpeikCsRstzzMO9cUuW2DHx3JApC
 q7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719292092; x=1719896892;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uuKRzX/CVCBtz4u0mZkWLcpWrMUD415m7eGI+pRHqts=;
 b=rTtNHI1xSu51yP4GW2GD9pmO/pptnNRZvjrSRCYu8QeSIFPC8YC8O1aPLgD1x7x/6j
 LxVofKEX50C8GDvoYMrfkk8v9rt5gS9aKhJqQ1nwkWI2eKGmazpmVbdQnREynhA9XJi9
 +12CWIbUkm4hk/Udn6wkcfU5HVy5+7y9tgEUCL4PmzaZJnrQbNulodxf/cOLK/KGWShJ
 z9XVp1xcZOvzPNf5QzfspnLP+hoTpZG7coGPwqgmhbKBLpUKjXr81oT8+2ALs3YSZDDw
 lUg1UwHnxa/Zw0PFNw/Iv/78hxtgyYQTTsXA6LbRo4XigmN9fvYWhsy3MR7PtuRTV+KN
 r/ow==
X-Gm-Message-State: AOJu0YwjEgBigxotD5f0BQK2mXh/R9bBHTbO5DTdNs+ACv8EqkePKFDD
 qBASWicwjo7r1ZdZh+7KRMOCs6FcrapmaYrr29bNZHsPitTi6Qz75AquLAMwF+mj8HvlXeKReA0
 O
X-Google-Smtp-Source: AGHT+IHm6TOtzOBuYcM/HAKFo0+oChLUHA+7YhBBnw8JJwt5YYPgscHRoIHrqdus5dUO5CbbX5VW8A==
X-Received: by 2002:a17:902:e9cd:b0:1fa:bcb:3db9 with SMTP id
 d9443c01a7336-1fa23f60fdfmr51840165ad.31.1719292092195; 
 Mon, 24 Jun 2024 22:08:12 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9ebbc72e9sm70843865ad.296.2024.06.24.22.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 22:08:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 00/13] target/arm: AdvSIMD conversion, part 2
Date: Mon, 24 Jun 2024 22:07:57 -0700
Message-Id: <20240625050810.1475643-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Convert another hand-full of instructions, plus fixes
for two issues that are related.


r~


Richard Henderson (13):
  target/arm: Fix VCMLA Dd, Dn, Dm[idx]
  target/arm: Fix SQDMULH (by element) with Q=0
  target/arm: Fix FJCVTZS vs flush-to-zero
  target/arm: Convert SQRDMLAH, SQRDMLSH to decodetree
  target/arm: Convert SDOT, UDOT to decodetree
  target/arm: Convert SUDOT, USDOT to decodetree
  target/arm: Convert BFDOT to decodetree
  target/arm: Convert BFMLALB, BFMLALT to decodetree
  target/arm: Convert BFMMLA, SMMLA, UMMLA, USMMLA to decodetree
  target/arm: Add data argument to do_fp3_vector
  target/arm: Convert FCADD to decodetree
  target/arm: Convert FCMLA to decodetree
  target/arm: Delete dead code from disas_simd_indexed

 target/arm/helper.h               |  10 +
 target/arm/tcg/a64.decode         |  42 ++
 target/arm/tcg/translate-a64.c    | 811 +++++++++---------------------
 target/arm/tcg/vec_helper.c       | 100 +++-
 target/arm/vfp_helper.c           |  18 +-
 tests/tcg/aarch64/test-2375.c     |  20 +
 tests/tcg/aarch64/Makefile.target |   3 +-
 7 files changed, 422 insertions(+), 582 deletions(-)
 create mode 100644 tests/tcg/aarch64/test-2375.c

-- 
2.34.1


