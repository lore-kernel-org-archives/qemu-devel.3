Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5C4CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waYuo-0003w5-8a; Fri, 19 Jun 2026 09:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1waYum-0003ty-G1
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:05:44 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1waYuj-0003Ow-9V
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:05:44 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-45ef56d9b67so1741106f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 06:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781874339; x=1782479139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HGWeuLURh979C1kGzuFu7ruukGHfTBgJCcmQRq0kZac=;
 b=GUCviYgRfN8qkWJCSCRJXEwpahGyI6G4Z0c0aTzFCaAqjLjgHcZ1myubbZIF+zdxqq
 6RWXAGlH5Yf8KujONRUX2aZjbTVXyb+GKkeCiWugNfmWCfZT+Ff3uVwT11LAoangYYpq
 9l8fy71xfoE+HW4UL3QkooC4v+Q3VcrfDwhCOcw/hJFXNm2ZSNLIsFu40XWknBylVKmS
 p7AlK+0XnmdBtdEqQuIpp9mguNAaSZgsapducOZ9zHX2p4rPUW9g4AWqRGSobsn8ynFm
 B1t5sJCUx1Qe7yGAXv673JIf/eNQQhSGG23DCc1VrnPMFV4/8W/wHraRnjOCgExae739
 ou8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781874339; x=1782479139;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HGWeuLURh979C1kGzuFu7ruukGHfTBgJCcmQRq0kZac=;
 b=IcAkhMbsT23eJ8AndDuEz5i2VbcyICVVvxCaS16oW17o4JiOqZP6EraXcyuOq7rZlw
 EuAEpASblAtvBfC8gJkrU15/MLusVxnzVidS3FWvsEpti1Hbaep5+Rmr5lqZbW6Ja9gL
 gPeqrUZmDKSgu9dAekJd5uHRyAb7VCxQdnZ04hlfv+FguLn6OqCKV2wtZ0gqIxiflFi3
 4MYRQIuJp4r3wIAY9MWmcWB/LITUoqx7bj2HpW1V64/zCCR3b7DontqYBwfMrAHnyLnM
 habrKgP7nXdEC/hxxEVu5dAiNRzAyBJpR880q6qQNtwdXyE6xRwm+LcPzD5GUfZj8TRL
 semw==
X-Gm-Message-State: AOJu0Yw42oARAW8bs5SG1tnC24dNeM6RXktUmCZEH+WgGCG7DvKPHkXw
 VRSV8Rlm6mbKf+fBBTj3dh3NJFJeHlhYjKN5axG68iEq6Q+rTyVbn/F0iUYHUqiFmGo=
X-Gm-Gg: AfdE7cnc1OmGLslZgiz1IKM+U3u8m5ovD5e3QeklGYBlLKeoc0CwIMc14GCs4UE0etP
 nNEeMOKcE2xqJB3XWHB/WQHlHaeTClqFrmEmxcabRc6YF+Hn3oolLQ7SGxPz6xNRxK/3wDKaAkY
 Dw0pdD5KRJ55hLMEfKBFj8TIonT7y/deybGiD+sxEfBGR/EPsp3xiJHqqAKPn+8t395QIfQ4G2d
 5JL1FUNZsw0KmQ9yrJWxmqWIqd0Fw5iMlgSIL/J7dZPHfmE+5iC0JmIYR30W9tcx2uKlBj+H2Rl
 jhSslSs7RvJkxusO8OYkq4aUgSANkxOpndJaxJE+k3jj71mzJXAvPLC+H7MNLqOMnnEBpHf1pot
 LyYn480dYe2Wvmn/2iQ78zS5x00XPZkPQ5tTuaHBe+Xk5xIXxsctcKk1hw2/CW4xYEepF2uatLJ
 aYn6a71DcOuiHP
X-Received: by 2002:a05:6000:4e:b0:461:a161:8101 with SMTP id
 ffacd0b85a97d-46500439771mr4937397f8f.11.1781874339376; 
 Fri, 19 Jun 2026 06:05:39 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46508a0546fsm7800409f8f.2.2026.06.19.06.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 06:05:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 418715F7FA;
 Fri, 19 Jun 2026 14:05:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 Troy Lee <leetroy@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Kane Chen <kane_chen@aspeedtech.com>, Tyrone Ting <kfting@nuvoton.com>,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v8 0/7] target/arm: fully model WFxT instructions for A-profile
Date: Fri, 19 Jun 2026 14:05:29 +0100
Message-ID: <20260619130537.820184-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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
 target/arm/cpu.c                            |  26 +-
 target/arm/tcg/op_helper.c                  | 252 ++++++++++++++++++--
 target/arm/tcg/translate-a64.c              |  42 ++--
 target/arm/tcg/translate.c                  |  34 +--
 tests/functional/arm/test_aspeed_anacapa.py |   4 +-
 14 files changed, 331 insertions(+), 73 deletions(-)

-- 
2.47.3


