Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A1EC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 16:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEAFo-00021E-6A; Mon, 03 Jun 2024 12:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sEAFh-000206-JJ
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 12:09:41 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sEAFd-0000Yz-Kq
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 12:09:40 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42108856c33so26756105e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 09:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717430975; x=1718035775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HODORKgU1EFXIaunqKu4Lfl93imSbojPrOim6zkduVg=;
 b=RvON31FF28fp+aOh+lPcBLs3URwdkmfj9/kuA6us7kY8PHlp/Q9MZc9gtuCYwUbfyz
 XRfzBfK0zjgFxZoZGuhuchnzY6nDFNeKxbZfmvwqI4eg08PYwAuFmu6k/NQE4TX8ILfy
 IAFTaxz9jx+hKrvqvceh1uEOESPKvTXCXIs1iAIQgmYdY0VVrEBdTcCDHp1EJdi7vJBP
 kzIdPfj50I5m7uXZc1jpfz8DDhy2o1SgrM197z86o06+4iMNTPx1w7m5tTNq96Oh/1lz
 5fvK/8GA71JpPW4k5/ayAxGSeLrgzPXZoWceFo3lAw4stvzsf9qBvO95HAOBd33p0bLm
 98GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717430975; x=1718035775;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HODORKgU1EFXIaunqKu4Lfl93imSbojPrOim6zkduVg=;
 b=DDqzcMaubSZwNHavL3kKBZSnnXsLcJ7WdTLYA0Z3K1AHjEKbfoQoLVJAi9yPgCKYjd
 K6oKy+tmRmI+mdM+LvrO85CGJ141Z6SQn5CAmXzDbmZ7evOlUxaDACAbJfCNwGTeswsU
 oWK0ww4cAWzSHPytH25VPSQRDcqOfxd7lBvYStx7KUHA03J7MGNoEXVKaFDC/Ss/pDsz
 Rh+fZ+ihXhNaw6VdHHOn7yHuU7Li347hCfICn3NLjUpT1I9ZY9voDO0D7tCIoL2xCXmB
 iNCzFEuZ5x3WJXismhZ+eShrSwLeEQa9Ge9m2ZdDd55KYJ4czPWXEo1wjFtIBiUHP5ww
 2WhA==
X-Gm-Message-State: AOJu0Yykfqgo/O8rqz6yuB/jqhQ5+3pt8jdRcKMcbhi1VnqgzVpERJhP
 vB1uj/IuUL4TgMYELUS9aj87Gkqaa8h/y0Bg9ydgfmpNUcWVF3dKViDrmwP0/b2hEBGN+tbvUgv
 L
X-Google-Smtp-Source: AGHT+IH1BPbR32cBOiPggxnZeD6z90NU0b429j3zoFxAR2hrKia+FxyYZbv9cHyKUyTOB7EqC3NAzQ==
X-Received: by 2002:a5d:5310:0:b0:34d:8d11:f8c0 with SMTP id
 ffacd0b85a97d-35e7c55a0e8mr112728f8f.18.1717430974915; 
 Mon, 03 Jun 2024 09:09:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd0649fb5sm8975858f8f.94.2024.06.03.09.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 09:09:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 0/3] cpu_exec_halt: make method mandatory
Date: Mon,  3 Jun 2024 17:09:30 +0100
Message-Id: <20240603160933.1141717-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patchset makes the TCGCPUOps::cpu_exec_halt method
mandatory, which is a cleanup that RTH asked for when we
were discussing my FEAT_WFxT series.

I'm not 100% convinced about this, because if we ever find we
need to change the cpu_exec_halt method so it's no longer the
exact same function signature as the has_work method then
we'll have to undo this change. But I don't feel very strongly
about it, and it does mean we can skip a runtime check for
whether the method exists.

We probably want patch 1 anyway; I didn't notice at the
time that M-profile has its own TCGCPUOps, and it's less
confusing if A and M both use the same arm_cpu_exec_halt().
(This isn't a bug in the FEAT_WFxT commit, though -- the
behaviour is the same.)

thanks
-- PMM

Peter Maydell (3):
  target/arm: Set arm_v7m_tcg_ops cpu_exec_halt to arm_cpu_exec_halt()
  target: Set TCGCPUOps::cpu_exec_halt to target's has_work
    implementation
  accel/tcg: Make TCGCPUOps::cpu_exec_halt mandatory

 include/hw/core/tcg-cpu-ops.h | 9 ++++++---
 target/arm/internals.h        | 3 +++
 target/riscv/internals.h      | 3 +++
 accel/tcg/cpu-exec.c          | 7 +------
 target/alpha/cpu.c            | 1 +
 target/arm/cpu.c              | 2 +-
 target/arm/tcg/cpu-v7m.c      | 1 +
 target/avr/cpu.c              | 1 +
 target/cris/cpu.c             | 2 ++
 target/hppa/cpu.c             | 1 +
 target/loongarch/cpu.c        | 1 +
 target/m68k/cpu.c             | 1 +
 target/microblaze/cpu.c       | 1 +
 target/mips/cpu.c             | 1 +
 target/openrisc/cpu.c         | 1 +
 target/ppc/cpu_init.c         | 2 ++
 target/riscv/cpu.c            | 2 +-
 target/riscv/tcg/tcg-cpu.c    | 2 ++
 target/rx/cpu.c               | 1 +
 target/s390x/cpu.c            | 1 +
 target/sh4/cpu.c              | 1 +
 target/sparc/cpu.c            | 1 +
 target/xtensa/cpu.c           | 1 +
 23 files changed, 35 insertions(+), 11 deletions(-)

-- 
2.34.1


