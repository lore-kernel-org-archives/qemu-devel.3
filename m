Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F05CDB47C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 10:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcKtF-00035D-Lx; Wed, 24 Jun 2026 06:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcKsi-0002Xj-Md
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:31:00 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcKsf-0007gQ-Cc
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:30:56 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49222fb062bso9004555e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 03:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782297051; x=1782901851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4foWnUUsHoQzNgijWabhWw8cNCRzvy2qg6qho+Kaiqs=;
 b=jcjHjekwTNRlJfyv9kt0wKt7Ojjh9kmZEOIDoCzhghr8FRIShg//zJse2o4TwHIvKu
 HCtVXWLICgD4C17OF6FDkEqkzvu8cTHDpOse9+71px1/2oV4iyhPYX4NfGGG/8ORdmC6
 7K6oWlbI2e9z9GHh2AYlWq6BSNEfEDdyqRhnlIcd0w+EBlRIDQsjU56nb/Xy1INjLjHt
 OlTWB/Tg5FFGkPr9qEF0gPWteFWiJctiHwiwftOqEXotJDkbl4O0laY3uRLRFreIjPEr
 KeWncvv8ePgkJgrRc8+oaTViJ7hepSICAi2aXklfRhFnE6ft3O0uXHr71wz/R96vG6Np
 AbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782297051; x=1782901851;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4foWnUUsHoQzNgijWabhWw8cNCRzvy2qg6qho+Kaiqs=;
 b=ixoLQyD1s+nibqZNb9YDlJ+NSmnqcroVflj7ozQgfZRHqsxFdGKTySpI4RmSVEmCE8
 Nl/X4IVn3sTjr8oWonG23kNldg4nCzJBafGRtyaT70M176RRjwLQITSVTfeN1wfeZaK2
 bDcchb0Jume+STOnSNFoJ6VOnUn5t9r1+63fxnf8b445ZTcCt9dSywGgwbL+ml3a4CUI
 lESq66RUqC3K5Q9niHD5mHciRh2DCsyxT6+wDDtNouQjTadh6Vv4B1vzSqvZj/acUTl1
 1T8M+dhP834YdADguoF59AP49oukWpaOuMGauPVO87uweM9Wa4jCd9REyrteWIk1Nwgh
 bJsQ==
X-Gm-Message-State: AOJu0Yyqazxndkq2GSJQS66hMfsU1PGER4apuP/mma56F40smBHDuOCy
 kBPfv/27ggRf8FNODPbV2KiEKS74YmBWAVg8l+3RvdxQEcw9j0qs6CP5R2rK5qoKBRo=
X-Gm-Gg: AfdE7clJgEeqyQRIaNGUn5IdMgBe9M3ChMfmRQZ3H2UUT7URpq7GDEcSWO8u8eo/uIk
 I7l69c53xXJ2jgBKDHUx4XtIWJBFlCXXyJYardgGyizmo71jmbTtChg0KPwha19i/ivusvN8F+C
 vQXqIz1dJ/xU/c0YvOxkRtny7MrwLFqq0H3j638djcHI9qg78MD0hJR/E5V6in5CjR59iQcFpk5
 tK/uRDpIVBVET0E+bDqL3C+Jk03qZrD1Hh6QEDh2xFescpChtSeXuUSYHGuggxKBzl+XplYwTuh
 nbZueAyORQUwVy9dK8AZ6yap59BSyjj1FlrZSGXpCw/jfM1yNxPnQFBFRsO0o1XodDTIoLFxwbB
 v1OXQsK+kitF+ThXXboylY9D+E14rtFYj43RAvOpk3kBYIAVh/+FuiYYNrsVWE2X3QfgiXWzx23
 B3ubRn2m38xcbW
X-Received: by 2002:a05:600c:6097:b0:492:4a56:68fa with SMTP id
 5b1f17b1804b1-49260872e27mr37291705e9.24.1782297051210; 
 Wed, 24 Jun 2026 03:30:51 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492494496d8sm360072015e9.9.2026.06.24.03.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 03:30:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B262C5F803;
 Wed, 24 Jun 2026 11:30:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Troy Lee <leetroy@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v9 0/7] target/arm: fully model WFxT instructions for A-profile
Date: Wed, 24 Jun 2026 11:30:42 +0100
Message-ID: <20260624103049.884930-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

The refactoring from the previous iterations of the patch have now
been merged.

I've dropped trying to fully model the global monitor in favour of
taking advantage of the architectural flexibility to have an IMPDEF
event wake up for any reason. We treat the setting of exclusive_addr
as such a reason because it indicates the current vCPU is in a ldstx
exclusive region and we don't want the guest to deadlock. This does mean
the system won't sleep on WFE enabled locks but people shouldn't be
relying on QEMU to model real world sleep patterns anyway given the
efficiency of emulation compared to real HW.

I've written a test case using kvm-unit-tests:

  Message-ID: <20260527111822.1563679-1-alex.bennee@linaro.org>
  Date: Wed, 27 May 2026 12:18:21 +0100
  Subject: [kvm-unit-tests PATCH v2] arm: add wfx test case
  From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The only remaining unreviewed patch is:

  target/arm: ensure we create the wxft_timer for all modes

v9
  - add more r-b's
  - only test arm_feature(env, ARM_FEATURE_V6K)

v8
  - Fixed quanta-gsj model SEV errata failure
  - Update the aspeed_anacapa test case
  - Ensure wake up events for V6K/V7 and plain V8
  - merged trap with implementation

v7
  - more r-b's
  - extended comment for typo fix
v6
  - add typo fix
  - addressed rth's comments

v5
  - addressed rth's comments
  - all but one patch now reviewed

v4
  - precursor refactor patches now merged
  - dropped global monitor emulation
  - addressed other comments
  - tested with check-tcg and kvm-unit-test wfx tests

v3
  - fixed the WFE exception handling

v2
  - I've kept the tests separate, see:

    Message-ID: <20260417164328.1009132-1-alex.bennee@linaro.org>
    Date: Fri, 17 Apr 2026 17:43:20 +0100
    Subject: [PATCH 0/7] tests/tcg: more capabilities for aarch64-softmmu tests
    From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

  - tweaks to global monitor behaviour
  - STLR/STL will also trigger events to avoid deadlocks
  - see under the --- in the patches for details

Alex.

Alex Bennée (7):
  hw/arm: use cortex-a9 mpcore base for CBAR on npcm7xx machines
  tests/functional: update anacapa-bmc image
  target/arm: do not clear halting reason in has_work helper
  target/arm: ensure we create the wxft_timer for all modes
  target/arm: implements SEV/SEVL for all modes
  target/arm: enable WFE sleeping for A-profile
  target/arm: implement WFET

 include/hw/core/sysemu-cpu-ops.h            |   3 +
 target/arm/cpu.h                            |   2 +-
 target/arm/tcg/helper-defs.h                |   3 +-
 target/arm/tcg/translate.h                  |  18 ++
 target/arm/tcg/a32.decode                   |   5 +-
 target/arm/tcg/a64.decode                   |   5 +-
 target/arm/tcg/t16.decode                   |   4 +-
 target/arm/tcg/t32.decode                   |   4 +-
 hw/arm/npcm7xx.c                            |   2 +-
 target/arm/cpu.c                            |  23 +-
 target/arm/tcg/op_helper.c                  | 252 ++++++++++++++++++--
 target/arm/tcg/translate-a64.c              |  42 ++--
 target/arm/tcg/translate.c                  |  34 +--
 tests/functional/arm/test_aspeed_anacapa.py |   4 +-
 14 files changed, 328 insertions(+), 73 deletions(-)

-- 
2.47.3


