Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD167F9EDC5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 12:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFX4d-0005wf-Qq; Wed, 22 Apr 2026 08:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFX4b-0005uE-MJ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:52:57 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFX4Y-0005RM-Rh
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:52:57 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43d7e23defbso3445790f8f.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 05:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776862373; x=1777467173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ktzBmtKkhkyE1Vd0Grjue/ltXPVNaT34cCAvQG/xXlU=;
 b=BJcCFO4csYvBkXLdHyLZPb176nfTBmMra+vD3NcJHSz04Nnks+lxGlfCaJmHAinhFs
 48lg4fxYv5P+e6LtSEtR8sGLpXKQ7ZwGu7/R/zXsbIcVAfQ+FC6d6QzGQbd2YXfIS779
 iwmoRG2b+cN9emAouy2boZuTrqHDKZJbluy/K5pNW2nUFlF4YwXPt2EmLp05BmS3exrl
 5nCOPiYlnV3rB864oEl8kb/RajmUPuZWleEUf6j6LC+A9dJgLszzLlyJ1SgQM5u/vCv9
 ueFaS8TwakEy5Zz0NH+M6OQZPjvDMD+73ozxCZyY+JouyeJjCObegRSN+kuoDYDSBSQS
 UFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776862373; x=1777467173;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ktzBmtKkhkyE1Vd0Grjue/ltXPVNaT34cCAvQG/xXlU=;
 b=OvyxZWnuvUBkSKAu6IdJXZ+FC5poI2yti3t03mWiLJRIYxDzLhnmGAOMnJGvIRdGgu
 BcOO1DYhmA7+YFSQbHxGJtZA+amVxlAO5xSBc1hNYRWU6BmJBCEFWe4QwExVLsoA4Hcw
 Zshi3obfr4BrlMeUQyuGapU0F0BCjL9syvtDEnPFFBQVoIZIpKZzDMuxxYv+3skHTQ30
 9vVAPo6p2+JLwUDA+zlr1v8Spv3m0VB7gcT18Bz6HICmPFuRhLL+DQGjewLZQ3G5lbwx
 9am7plEkcUWR7liOB58R+Fosvz4cho0dCt/ncV2kZWN+C4j0vDugZJ5hpPywUYgKnTOS
 Md9g==
X-Gm-Message-State: AOJu0YzGndkRVvl3YsBOj74fQSBBqjAjgJjDpV5G/Jtfj1wmMT7OzA4I
 13jYvkvbGsYRvr5AKTUDuurEkgdA9csDMBO61dZCbhlvVRBm8Q7Nq1HSHXT66X0D9sM=
X-Gm-Gg: AeBDiesx+Y4KW0jCwKYdtHvyVZELOxkca4Ca0MLeiRas8732aH+VN/bjanBjT7dSYL6
 kFmIPeEdBbJL3nfK0ddiaN197ZN63LjWxqi9d+ptNlQMr77w4P7YzP4Ly7ZqNHVAh+5yhTXy2je
 en+W0h5e/1wXyzLEXVA8+IQxcegHJwOuxDMxTwJ4hB/eAi2qyljRbKf9+Y4lbxkSkJQMi91Emjs
 hxNaV5+AT4a2GCZuLQ1ALroKbyyz1mpma6KVuX0SqGje9M9/fYc4NzWtYbKnAxM0vt8/fIqRqsL
 f1ZU7ev8rE4W3qFkd09X3IvuBMLwPhNDamvl0rWibliWYETIYVS5sYA1B0thFvXW9aTONalJtaF
 PsVxibXLZ9i3XEh7fL/07Xaq7q15rcXMKvr2mxiPseYpRTvqWydyta+0LQVC5tOkIwj0qbeOEOb
 7tWnwQ/SCEHxj7M63xA2phYXAx2KT3hrpCCA==
X-Received: by 2002:a5d:4b81:0:b0:43f:e721:76ca with SMTP id
 ffacd0b85a97d-43fe7217864mr20097852f8f.45.1776862372992; 
 Wed, 22 Apr 2026 05:52:52 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb1405sm45127565f8f.4.2026.04.22.05.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 05:52:51 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EE4F35F93F;
 Wed, 22 Apr 2026 13:52:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 00/32] target/arm: fully model WFxT instructions for
 A-profile
Date: Wed, 22 Apr 2026 13:52:17 +0100
Message-ID: <20260422125250.1303100-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This series fully models the behaviour of WFxT instructions. We
already had support for WFE for M-profile but we left off A-profile as
it has more potential sources of wake-ups. The main one is the event
stream which includes events from significant bits of the timer
ticking over.

The series starts with some refactoring of the syndrome register
helpers to use registerfields. We then expand the WFIT trap handling
to report the register used. We then implement the event stream events
for SEV, global monitor and the timer related ones before enabling WFE
for A-profile and then finally WFET.

Note on AI usage. As an experiment I previously posted an RFC series
with the help of Gemini. This series however is a ground up
re-implementation which takes some different approaches on modelling
the event stream. In particular rather than running multiple timers we
use the same wxft timer and just compute if the timeout or timer event
will come first.

v2
  - I've kept the tests separate, see:

    Message-ID: <20260417164328.1009132-1-alex.bennee@linaro.org>
    Date: Fri, 17 Apr 2026 17:43:20 +0100
    Subject: [PATCH 0/7] tests/tcg: more capabilities for aarch64-softmmu tests
    From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

  - tweaks to global monitor behaviour
  - STLR/STL will also trigger events to avoid deadlocks
  - see under the --- in the patches for details

v3
  - fixed the WFE exception handling

Alex.

Alex Bennée (32):
  target/arm: migrate basic syndrome helpers to registerfields
  target/arm: migrate system/cp trap syndromes to registerfields
  target/arm: migrate FP/SIMD trap syndromes to registerfields
  target/arm: migrate eret trap syndromes to registerfields
  target/arm: migrate SME trap syndromes to registerfields
  target/arm: migrate PAC trap syndromes to registerfields
  target/arm: migrate BTI trap syndromes to registerfields
  target/arm: migrate BXJ trap syndromes to registerfields
  target/arm: migrate Granule Protection traps to registerfields
  target/arm: migrate fault syndromes to registerfields
  target/arm: migrate debug syndromes to registerfields
  target/arm: migrate wfx syndromes to registerfields
  target/arm: migrate gcs syndromes to registerfields
  target/arm: migrate memory op syndromes to registerfields
  target/arm: migrate check_hcr_el2_trap to use syndrome helper
  target/arm: use syndrome helpers in arm_cpu_do_interrupt_aarch32_hyp
  target/arm: use syndrome helpers to set SAME_EL EC bit
  target/arm: make whpx use syndrome helpers for decode
  target/arm: make hvf use syndrome helpers for decode
  target/arm: use syndrome helpers in merge_syn_data_abort
  target/arm: use syndrome helpers to query VNCR bit
  target/arm: remove old syndrome defines
  target/arm: report register in WFIT syndromes
  target/arm: teach arm_cpu_has_work about halting reasons
  target/arm: redefine event stream fields
  target/arm: ensure aarch64 DISAS_WFE will exit
  target/arm: implements SEV/SEVL for all modes
  target/arm: hoist event broadcast code into a helper
  target/arm: implement global monitor events
  target/arm: enable event stream on WFE instructions
  target/arm: handle the WFE trap case
  target/arm: implement WFET

 target/arm/cpu.h               |  27 ++
 target/arm/internals.h         |  31 +-
 target/arm/syndrome.h          | 595 +++++++++++++++++++++++++++------
 target/arm/tcg/helper-defs.h   |   5 +-
 target/arm/tcg/translate.h     |  32 ++
 target/arm/tcg/a32.decode      |   5 +-
 target/arm/tcg/a64.decode      |   5 +-
 target/arm/tcg/t16.decode      |   4 +-
 target/arm/tcg/t32.decode      |   4 +-
 target/arm/arm-powerctl.c      |   4 +-
 target/arm/cpu.c               |  53 ++-
 target/arm/helper.c            |  12 +-
 target/arm/hvf/hvf.c           |  14 +-
 target/arm/kvm.c               |   5 +-
 target/arm/machine.c           |   2 +-
 target/arm/tcg/debug.c         |   2 +-
 target/arm/tcg/op_helper.c     | 231 +++++++++++--
 target/arm/tcg/tlb_helper.c    |   6 +-
 target/arm/tcg/translate-a64.c |  60 +++-
 target/arm/tcg/translate.c     |  35 +-
 target/arm/tcg/vfp_helper.c    |   5 +-
 target/arm/whpx/whpx-all.c     |  13 +-
 22 files changed, 946 insertions(+), 204 deletions(-)

-- 
2.47.3


