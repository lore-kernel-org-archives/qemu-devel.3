Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C533C79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4DtB-0008Dr-QO; Wed, 09 Sep 2026 04:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x4DtA-0008Da-An
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 04:42:40 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x4Dt8-0003I6-Ov
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 04:42:40 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2d91ded8174so45570675ad.1
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 01:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1788943357; x=1789548157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BOfIqWgA7pka2B6DQz96MF5Lg2ukOaH404VNm1FKDGA=;
 b=NxUvi3KxqGP/qk/25AGxAGahEO1X1imdQbLhFGV5BCsD5MDg7Pg5S8wJVjijEv+JeQ
 eO0Uqen9xguN8cnNoVDZw8xoSFVNEgOiCQzZ3EoQgpPnzVicQzaGa3CzaGGwYOmc6QHj
 ihF3m8R28fVjUa/rp0NiZsBJcJTA2s5QXX6yvehkLzSrC1o6cn10+9/bVruZT6uJOg8t
 rNIiXkoecWvSuWmjOJBYkh6IzOU7DwzSWuCDljPtRljIpeQvXpaaM2+BveqIpVao3GrX
 NoOH4Qd6b9rOmDaipxecNG64vFIuvNXUC0Nk2DjA0wDB4Qstn6Z6qu4P3FrNaqVqQDfR
 45Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788943357; x=1789548157;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BOfIqWgA7pka2B6DQz96MF5Lg2ukOaH404VNm1FKDGA=;
 b=AOThBJVQReG9W832Bw1RGk9ZUI2CKx20e+Sr9Pz3u4KXq/+1b1cpW3q4H8wzOaQSvH
 /4SPwmhiiuCgU/7JsJNJvsNoVwcSaxyqIdDsQXiZ5saCDODYsmDqTq1yes7Rz/hLyVSq
 3F47SqA3ERbFTlk087mjoZvzwdjn6CQyE3TPFNeQ9NgP0IMsWSlaEaI5wBE4yeBC3Iyk
 lLwvDDUHAxeEYr/o3+J+ApbZLy6ZiMQwSPQCxZvrNCCNk7BfawvSqeh/aWUsX21bSM9U
 JkiElc2GljSWz0fDecoGJtG4Gin8S9rbuZPtNt4FNZT3IoGpfQOQKjS3Kyh9805cyomv
 Hzbg==
X-Gm-Message-State: AFuF++mqcNinbaH8Bwgg7+VdFdCyowZhRYFoAgE79MPuUAdqUnOjOc0K
 5LwQnPBijJFstJplZHFW6q3fwTcT5n/E57pqqw0mRJmHBz6KgAwJhfqoYpIfq65wHvfbRhGnLAx
 dUXpeGRnxgKTYw9ljvqDls2QHVfZ/E2z8QH9syYJvHUb4+vk80G4zCReW/Wzv+bb3m+ftjut5TU
 99EEcOYJvpKrzU0iuNtA3Nv9+UxlwxS8RHYFhM9XlYdg==
X-Gm-Gg: AYBFou0gCmaRHfAgCatVZiDlvtp2+gdv5xdsTSSrwVmbvxVy0uVltUKB7Zx1Z4AqKBL
 WkvXgjMXKbjHQ8SdZEnqDvYeG1hr442CYGYnT5kDehqBo+fdJTeTMxKJDM8IfqB/C44Nq98Rhe3
 i3+IdgQ3wuRJenmMDxuSjpHUjqhYnWHYJi3g4UFLRxzeWh4s7xmzbtfpg5aMy9QdIGRPn6RMtLX
 fjVPB5/X/Nc8g7K/9ZZGJSYP6nuAapzmxehK0RtW1hBcSGbEcQdKxnRPB+CJ1qiX4beC5oWz4qO
 L2glVN3x3Z84EEdXe+2fLAmnpacSZEyBUN8cr69fI7Tf48TCluJswpntato5FzfecNNCfZNOHYq
 qRkvHa3ABBKKgh+llfZyoqABb4ovSXsX9jSNSKlRCYHCjiueeEkhNfPtFFoBvq/4rgrilKnRLpR
 zWEA8IRvR8eBR73jMihBR2WgdkmZ8zz6EImtdgKcYjq+T46OYS4e6T4NcgMXF8kWxaLmY2nnLvq
 7BjfDGCfFJJRjHQ2FrE0i+uX8v2Ow1Jre3+UE1yenDzS5iABeeWFJhM4HKdlbShns7mUHIbyg==
X-Received: by 2002:a17:903:3848:b0:2d9:56dd:f804 with SMTP id
 d9443c01a7336-2db125f00c7mr505328805ad.13.1788943356430; 
 Wed, 09 Sep 2026 01:42:36 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db56c2a1f1sm38328225ad.78.2026.09.09.01.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:42:35 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, richard.henderson@linaro.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH 0/6] tests/tcg/riscv64: Add system mode rvv ld/st tests
Date: Wed,  9 Sep 2026 16:41:47 +0800
Message-ID: <20260909084154.223529-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x632.google.com
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

Hi Richard,

This patchset adds several rvv load/store tests with PMP permission
settings, as we discussed during your v1 submission.

While building the tests, I noticed that pmp_hart_has_privs has a scope
issue that yields unexpected results. This affects both the vector
fault-only-first load and vector unit-stride ld/st instructions.
I therefore attempted to correct pmp_hart_has_privs and
vext_ldst_us_notail, adding matching tests.

Hope these system mode tests and fixes can help you.

PS: I tried applying v2
<20260821040404.268123-1-richard.henderson@linaro.org> to the master and
riscv-to-apply.next branches, but both conflicted.

Thanks,
rnax

Based-on: <20260821040404.268123-1-richard.henderson@linaro.org>

Max Chou (6):
  target/riscv: Match PMP entries lying inside the checked range
  target/riscv: rvv: Probe unit-stride accesses by the first element
  tests/tcg/riscv64: Add vector masked fault-only-first PMP test
  tests/tcg/riscv64: Add vector unit-stride PMP test
  tests/tcg/riscv64: Add vector fault-only-first page probe test
  tests/tcg/riscv64: Add vector segment PMP region spanning test

 target/riscv/tcg/pmp.c                    |  31 +--
 target/riscv/tcg/vector_helper.c          |  45 +++-
 tests/tcg/riscv64/Makefile.softmmu-target |  38 +++
 tests/tcg/riscv64/rvv-ldst.inc            |  91 +++++++
 tests/tcg/riscv64/test-rvv-ldst-ff-page.S |  83 +++++++
 tests/tcg/riscv64/test-rvv-ldst-ff-pmp.S  | 259 ++++++++++++++++++++
 tests/tcg/riscv64/test-rvv-ldst-seg-pmp.S | 141 +++++++++++
 tests/tcg/riscv64/test-rvv-ldst-us-pmp.S  | 281 ++++++++++++++++++++++
 8 files changed, 943 insertions(+), 26 deletions(-)
 create mode 100644 tests/tcg/riscv64/rvv-ldst.inc
 create mode 100644 tests/tcg/riscv64/test-rvv-ldst-ff-page.S
 create mode 100644 tests/tcg/riscv64/test-rvv-ldst-ff-pmp.S
 create mode 100644 tests/tcg/riscv64/test-rvv-ldst-seg-pmp.S
 create mode 100644 tests/tcg/riscv64/test-rvv-ldst-us-pmp.S

-- 
2.43.0


