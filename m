Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0755AC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 20:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whCry-0004LS-8j; Tue, 07 Jul 2026 16:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1whCrw-0004Km-9H
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 16:58:16 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1whCru-0003Su-9R
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 16:58:16 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2caea3f742bso563195ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783457892; x=1784062692; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TPnoIIQ77tGFpNtdPChFbA1LR5m7jgqx25r8AJyOYkM=;
 b=PYHl4X3Wsyq3AXsTeF0M5UEt57otv8TQZRZILifkW7osrUQodHIoSCc99bCvNExSJJ
 A+bNxLPxR9Q3QQmaJTyJL8nnu4GF+rAGt8l6RS68ThAqELeo7RXJucXW8B0Q9EQ9vK5w
 GydeI/rCBwZ1Ea67A4lB9k24d+tlDOoN7cPygHYmBCUay/clzsQvq0JwQ05Rs6NiI7jT
 GDtGkB4+s+/b23eydpa9Z6PUiZOLCIR38TiZTG8t47T+ZKmPWBbAA0U1tezp53l5nUpz
 DgAiY0bN4UYwRJamk1ItuHVFfhQTtz1Nwf2c4Gx+kAjKhS+CsCdn62cn8yrAxMDAZGBv
 YPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783457892; x=1784062692;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TPnoIIQ77tGFpNtdPChFbA1LR5m7jgqx25r8AJyOYkM=;
 b=i5EAQGcNztBl1Ca2GwzsSF63W6gyyXrbsCT78kR20YiATqE9AphoaO/ob+dqaQhtwa
 wwSg0iFACA67FYrlw2OKyC881lss4X8/Mq+ZPAhd3b0YHXmPwWjT1aKIkYvDHobdv6bM
 9FzWr8/IsGqE1jhkZ1vwRqP6QLvhTksRWuwn8BVw2mwXEgiQelYV1ttfrMbi1irHu2dj
 TOzCDXcHdzlJ7stltKGSEmsNq5dq8re4A3G/kF6+l0zGNfCbLo/BR1WoBN+anJdYSFGe
 7dTTnE8mqGGzdtDI3/T5aTlvnTWOcIznT+P+1mgaUiZoEVZR55QgPV5eJdAR+klMtOlI
 JAsg==
X-Gm-Message-State: AOJu0YzUOBg6anrNMmDAcWs0ypAdh6+atVvVCBRl0lhxE08gxEg3O/4v
 FjZM6bhfa4d2bFzlCKuT1tcdt3+RhG+DyFT62YKlO2A9o7a16XMktU1EzmRsQTJiuQiKWJFrp5X
 L/0cu
X-Gm-Gg: AfdE7cmQHZWiDcA0sfljEBtJk8Mpk73faEGGbUTuKroZSh8anwSlD6W6dR+/lsRNFi8
 l8ong882Occtp0cBN2Fz7Vea0j6QLkG5eOVZslZsRZjYZTOWxyV+kq65XhEFBIgMun4MQnlH76/
 vQpab0C1wR9M5bjxfel2i29RTwZFjLH35scpaYUKV0Out62wJiK39VAVxOGF6okcGKePACwjN/C
 7dzTh5tjjOruHcsILYOHvfEd/XQMrIXZWQ5Ngt2dU2+XHlDSgS7U81WsJK/oUUYHG4EMzsoJhSX
 3iFsLNQNIfsFzmqXbgKWWvOUfNIvCYDE1Sop6+MTltNdqK9HDc/ICYlkTEG6/jNraA6D8VmSqXq
 ef6kCPSxUzLP4q3QTfiTg2R1i6KGiaZAn1zERdpSsDHcTC79q1VGJqIAU3BTct+VMzcPMRomR5n
 u4vwwzlfi7qje1H+e+9jFLFVvRNIPEZj7uzncj/Cj1EEMGHaspxP9KU5VLgw==
X-Received: by 2002:a17:903:32cd:b0:2c9:a247:171 with SMTP id
 d9443c01a7336-2ccbe40de92mr63782275ad.1.1783457892201; 
 Tue, 07 Jul 2026 13:58:12 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bc2asm17980575ad.69.2026.07.07.13.58.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 13:58:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] tcg patch queue
Date: Tue,  7 Jul 2026 13:58:04 -0700
Message-ID: <20260707205810.303376-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

The following changes since commit 94826ec1370328375c3b6d1e80fdc94c8f46c348:

  Merge tag 'accel-20260706' of https://github.com/philmd/qemu into staging (2026-07-06 18:38:14 +0200)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20260707

for you to fetch changes up to c56ebd64b82aa4d4a4e2144abbf9568ef593b836:

  tcg/loongarch64: Fix cmp_vec with TCG_COND_NE (2026-07-07 11:16:05 -0700)

----------------------------------------------------------------
tcg/loongarch64: Fix cmp_vec with TCG_COND_NE
tcg/x86_64: declare MO_ATOM_WITHIN16 host atomicity support
accel/tcg: Make PageFlagsNodes' start and last immutable
accel/tcg: Use TLB_FORCE_SLOW not TLB_MMIO for user-only plugins

----------------------------------------------------------------
Andrew Jones (1):
      tcg/x86_64: declare MO_ATOM_WITHIN16 host atomicity support

Ilya Leoshkevich (3):
      accel/tcg: Make PageFlagsNodes' start and last immutable
      tests/tcg/multiarch: Improve mutator randomness
      Revert "tests/tcg: skip the vma-pthread test on CI"

Richard Henderson (2):
      accel/tcg: Use TLB_FORCE_SLOW not TLB_MMIO for user-only plugins
      tcg/loongarch64: Fix cmp_vec with TCG_COND_NE

 include/exec/tlb-flags.h            |  7 ++++---
 accel/tcg/user-exec.c               | 41 +++++++++++++++++++++----------------
 tests/tcg/multiarch/vma-pthread.c   |  3 ++-
 tcg/loongarch64/tcg-target.c.inc    | 39 +++++++++++++++++++++++++----------
 tcg/x86_64/tcg-target.c.inc         |  4 ++--
 tests/tcg/multiarch/Makefile.target |  9 --------
 6 files changed, 59 insertions(+), 44 deletions(-)

