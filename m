Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315BDC5DF88
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2RP-0008V8-Da; Thu, 20 Aug 2026 09:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wx2RN-0008UT-6a
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:04:17 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wx2RL-0006kg-Dj
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:04:16 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso2574925a91.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 06:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787231054; x=1787835854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pq/Xy8a92/t8aqkyQP4yLvUfAo1eSGhZVQ/Pjs1ehTs=;
 b=Qs/yRRR5hWZqbB/5kxINY+E3BuSDGBOdn+g5zVxpNXgdUPdBLnWkEwK+X7hbUQb2y6
 TGWgqYMTELxBL3wR3+Y5TbVflBykwlB1SSetyrOzk/VVmZC3qrxdFVT++z8PoEqskz+a
 s+qM2ElA82tNB9pkaSECc6VTE5PZEod+6js4ZJpwJ8lnXocceQtKviMDSeD3nBYMiJNj
 VmzzeCNZvANfH6rLL4xEa5T10Dvt1TA+mAKJABTQQmNtfBt8g0FtDFqNsN02945KrHZa
 r+z97XDSeM3DgwTB5hX0KcpIf5IUxd0HsVw4FrQYKOnOFBX278KXGtUJfjMLf1qXRHpI
 VOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787231054; x=1787835854;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pq/Xy8a92/t8aqkyQP4yLvUfAo1eSGhZVQ/Pjs1ehTs=;
 b=pN873U/KQ83sSzLG9rVrGKu0kcH5TUX6v92PPtY2xSbnOvaltAwgAeNPwa7XolyjFc
 N44i+g4N0a6wjMruQ5PUP6WlNJv5FnuKkvUXzTNkS65rcMxUoGNHhGVbzNwMWtz9SjoV
 ncNCVHMWmzuxOqhvxDgftqmMvT5LaNriIrwXzjK5NjPGeQKZqDaxca2Ru2RK+L4kwJvW
 /dz2kQYb7SVqEEJJn16pNZ4nZh2ygM1Q/YyHWU8Xtq3ew75Sm2TNMCcutBluxAbWVaoH
 gLtiLUq/oHlivFD7+z1xC1iZx7M+FbLHCSO73HtgafB3D+QdKZ1OipQsHxf537Cso9TA
 5pgQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro5i19o1ojDLOxWM8PsPyt7sHSToXwcRTcS6nkedVGfkuSE6J0GoHZwESrzhechMWJtuiNjfWjRrept@nongnu.org
X-Gm-Message-State: AFuF++mrPyGchccwFxCd6D8o4PQqeVu0vp/1Ug6F3CzL1vhbyCJ+ChR+
 e02k0wdGc740lECKCDl/79p7ORGjTW5XMWZkbXUhOA/Ja7M3jSEvR6uA
X-Gm-Gg: AR+sD13u25sXYcW/6mmwH1l0qlPTheQuPl2DfWUIV87lalPBLmT6NAVXORYPPU0x3rJ
 mxo10Rn/Z8jcv+zGg0p+EkWblxQWrCtMPpAl6ixrEdUA17tr9uAZc7aIRtKzoHNj/C80DrRNl+q
 uHwj263uP4PteUoD6i8knqyuJD7Uai5XGBWSGwjrJhBacTund/NjjvjAiYd3T8eY5V8ME4v/l3p
 68roMwHfEWnaOTuwM4+tPN9SyQmXrAZxJxwc1W2IaVQzmHjzaNudasCsFhQfQVLvMCbGjkbJxrj
 28tMwD1EVFXSU+4u/uPNRp25A/N5jGBMvRZu0uAz8j6NNCCsXf/JW/UuwMnt6vrqwhSV5HYAEPb
 QSk1jHqYojxp/kvq6FzlCOOpil3dOVPLRx5SxFuPURTyilJnM/ihQCUaMfjBZdCK3Ars0TT8TrR
 FRCTT8v6ZwVxQzYqdrC6GiU3Mjt6Byi7H9IxLGYOJKB3U8zi3/5D5FyAI6sQu8tnOoUY64eczSk
 YIw85s1vv1U71x9sZC7AUPe2bh1CHSZA3FvwReIjsSR3Zd3Ff7oO1dAy/U9ckYIOEZHClglPRDd
 IDktGZgwOvHzuDHzUICq3Q==
X-Received: by 2002:a17:90b:4a05:b0:37f:c22a:c188 with SMTP id
 98e67ed59e1d1-39580a80a65mr23947640a91.4.1787231053611; 
 Thu, 20 Aug 2026 06:04:13 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957faf6849sm6451915a91.10.2026.08.20.06.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 06:04:12 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 0/2] tests/tcg/riscv64: Add vector load and store tests
Date: Thu, 20 Aug 2026 22:32:19 +0930
Message-ID: <20260820130223.2762-1-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Richard, I was testing your riscv vector load/store series and
noticed there were some regressions with page crossing loads and stores.
We don't have any tests for that in the tree, so I wrote some.

The tests trigger assertions in linux-user for me:

  $ make -C build/tests/tcg/riscv64-linux-user run-test-rvv-ldst
  make: Entering directory 'build/tests/tcg/riscv64-linux-user'
    TEST    test-rvv-ldst on riscv64
  **
  ERROR:../accel/tcg/user-exec.c:810:probe_access: assertion failed: (-(addr | TARGET_PAGE_MASK) >= size)
  timeout: the monitored command dumped core
  Aborted
  make: *** [Makefile:223: run-test-rvv-ldst] Error 134
  make: Leaving directory 'build/tests/tcg/riscv64-linux-user'

I wrote the assembly one first before realising a C version would be
easy enough to do too. I'm not sure about using memcmp to check (in case
it's vectorised) so perhaps that's where the asm wins. I can tidy them
up and send the preferred version if we decide to put it in the tree.

Joel Stanley (2):
  tests/tcg/riscv64: Vector load test
  tests/tcg/riscv64: Add intrinsics version of test-rvv-ldst

 tests/tcg/riscv64/test-rvv-ldst-intrinsics.c |  66 ++++++++++
 tests/tcg/riscv64/Makefile.target            |  19 +++
 tests/tcg/riscv64/test-rvv-ldst.S            | 131 +++++++++++++++++++
 3 files changed, 216 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-rvv-ldst-intrinsics.c
 create mode 100644 tests/tcg/riscv64/test-rvv-ldst.S

-- 
2.53.0


