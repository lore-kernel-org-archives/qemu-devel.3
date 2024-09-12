Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CB2EE644A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socPv-00028B-IR; Thu, 12 Sep 2024 01:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1socPo-0001kj-UI
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:49 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1socPm-00031i-VC
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:48 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2d8b96c18f0so471397a91.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726119045; x=1726723845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UiB/B0HBQEMZJrJaUv8xnnERBGFR1KfLn2YlSKLbxxc=;
 b=kk78ZFKln8mfYVGkjEGlg89E8C90VOk/fj8bS5X7sPt4XPaTgY6HqJQ1IagQdsOgm/
 l5hOzO54kLT0Qy1eRV6wPoszzD9+qWTYPpuSoid6TWb7/u1wo9wXEd8WmFeTLjSqQQ9P
 mGsiOAO2O4X1fL0tR8YQ8L8fgNICNtkHyP6nziRWLVxwmzU5MNliWqiaOLVBx69gSaLt
 cAjNDYanzLoAEL6Ox7V9/SbGZeYbaHXiYDPgaDPfChrbqwujtsYJRTHm9q1eGhjArPff
 kU66JwRya+g3xHlR6n8E5tpVt9gNHXzn1hxJCvQOJa9tEBPnNTxYWEzmGbvuA/6TtKrD
 A3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119045; x=1726723845;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UiB/B0HBQEMZJrJaUv8xnnERBGFR1KfLn2YlSKLbxxc=;
 b=mZAODzqyGhPl5bcAiluOG8T+Cqo5yIqnBRHUGj+qzA00bu9haY4xZ/7czyuDCYwGcg
 ATKvANGKE6EvxCSU+04YKJDvE0yrZ+f+ziu1oQwBYswMxnPJCEsNmS5XqxUgqfx3yZEF
 oY5BW/9VNvRL/TjnaKS6K8RcR1qV4VdyaCoc5QXEbE9FwnAIdpAiVU132/nH6rhKy3Rr
 WemnyaWjKxIpVNfYnazUT8zF5bS5tuK1E5amg8zHSyyHUnk+tEy77Zk9dvsdQe+k0XwD
 Cr1YRp6FKSoSWZP35COA+RHUomk1HCApMjxOvcH9aIVI161h+ChIgfvcnbqBdoNREbjM
 AFOw==
X-Gm-Message-State: AOJu0YzerAwaa0LVjkwDpRSrdkEVxQCAKWXu0tG1ZQLj2QA5RhHtPzQE
 xXaVFoC7mgOoEm7Wbc72cSNibIjHFAuyn1eJRaYtmmF4Gs3NI8JHt6gg3IvFDuieFZfvWhx4+CY
 Q
X-Google-Smtp-Source: AGHT+IEJ8FB5fBJhunOOntuumvhiHc5p6OBQHpQ1BvQQbs7EjiOpFhkvDGRxUPh4D0bzW2olgej6Sg==
X-Received: by 2002:a17:90a:a118:b0:2d8:9506:5dfd with SMTP id
 98e67ed59e1d1-2dba0065973mr2056737a91.35.1726119044827; 
 Wed, 11 Sep 2024 22:30:44 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076afe9e1dsm7513155ad.236.2024.09.11.22.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:30:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 0/5] target/sparc patch queue
Date: Wed, 11 Sep 2024 22:30:38 -0700
Message-ID: <20240912053043.1131626-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

The following changes since commit a4eb31c678400472de0b4915b9154a7c20d8332f:

  Merge tag 'pull-testing-gdbstub-oct-100924-1' of https://gitlab.com/stsquad/qemu into staging (2024-09-11 13:17:29 +0100)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-sparc-20240911

for you to fetch changes up to d2a0c3a7f7740a3d563c8c3ef1fffcc87a36213d:

  target/sparc: Add gen_trap_if_nofpu_fpexception (2024-09-11 19:54:55 -0700)

----------------------------------------------------------------
target/sparc: Implement single entry FP Queue

----------------------------------------------------------------
Carl Hauser (2):
      target/sparc: Add FQ and FSR.QNE
      target/sparc: Populate sparc32 FQ when raising fp exception

Richard Henderson (3):
      target/sparc: Add FSR_QNE to tb_flags
      target/sparc: Implement STDFQ
      target/sparc: Add gen_trap_if_nofpu_fpexception

 target/sparc/cpu.h          |  30 ++++++++++-
 target/sparc/fop_helper.c   |   4 ++
 target/sparc/int32_helper.c |  40 ++++++++------
 target/sparc/machine.c      |  25 +++++++++
 target/sparc/translate.c    | 128 ++++++++++++++++++++++++++++++++------------
 target/sparc/insns.decode   |   2 +-
 6 files changed, 178 insertions(+), 51 deletions(-)

