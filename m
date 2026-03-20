Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D80F1098782
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ZYT-0002t1-Gq; Fri, 20 Mar 2026 09:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYQ-0002pp-CW
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:18 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYM-0005zY-Ao
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:17 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-667acaeae82so2864517a12.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774011972; x=1774616772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BYxNsUnUWDku4CbS5Fk6DlGhGC7YDF6uvijtHjUYiB4=;
 b=C/HRuckT9Xne7QyNzJ0/thxfbrsXAZb5uX5v7e6zbsNui11ydynpS+ShrL+OQ3PU/+
 r/CbVWB9yhvUHo23Bjpidoi3GpSvID+FLEnBnd4+6TZMQmxevAFnQu6VsirVT1AMDsJH
 OY5gpQ0BykWYA2wRnnFKEWJ8juk+BdOSPAmgwte8XvkVYtSAX8Qhovn6VUnY/fzmXpZv
 T/MFl6hrB3bLILi/ZoE2YcO7oKrbKBh/8P6nnNeLPdTiG4oqKOj707bMwTqMTFUZFbFG
 aq7pR3xruahs2XzRnBIlsc1bP7IhK6C2oWQvcamuRGSWuFe/SEojmBYZBR4t+P1Xf5iT
 T0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011972; x=1774616772;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BYxNsUnUWDku4CbS5Fk6DlGhGC7YDF6uvijtHjUYiB4=;
 b=r7i9upnmxxujLfprhiv+0wK4AuoT735qQHfBQFnWYYhea/AhNJMsUrXvG+fFNr2wPF
 2mPidHE/w3BzCWzRNXjQlXN/tCV0b0QDo6AS8Gju5MwanHJ7hY71E+Aum4FLfnen4PgW
 nsuyyvv5lTocNGzI+K1B+ZMihQ463lB/Lt8B0SGaVgnrSs+VhJzoBjvuP2kyz36l4Y/5
 pg9hBtqBdjM0s0XBAKcezxl5YAs1KGFemR8ybxp8sGfhYxbR98thsy+3hSa9KLZ8Re80
 lCOLl+/Aao0oK5ZPiWbNMO2zYcQFHUCbagKOSE14FSliUSExa6Ix92JVGjrNOw6cdYnr
 CkRg==
X-Gm-Message-State: AOJu0Yz+5M+FcbKktPX5K4Bz5xxa/zdMyGoYIElG3YbG4z3NFtaFHDxI
 a7cBat+KbyQ9O265SRHOa3XdFg3UKD2d35KnmMqMoz9xMg97x0jlCiu5BFgyqWbCyGk=
X-Gm-Gg: ATEYQzxpBeK+/qSf3RDN8YRBilVhigFT+/GRHgHeZksjqNa4p2RcSHnCzWiocoLfVre
 vyzgD7+hHFmj6n8KZ5fHKNqmPmwYsBwLnCkZUgVyFDxndqTYM2+6tSTdZ6RWQxmuuEcPu2ILH9o
 ii6JvzlB/Jh8eHIdpp0i+pBNyKThzAX4ISZqjSZYEzv2hwUvKPa4JWbSHvnbJ8TrzG+jbK9odLl
 pcbeCbXBm9pcivL9HtS/uWkslazvj5EycYpxLWMGHstgVwkTXkH2KyaC2qVoGiRA6V9trMhU5uJ
 dQosMwH+Qs7MeoFLbBypva8Xm9N7V12qHdw0Kw/XdhQEQRGmnkaRM3pOAkkhwqg/kSeAvBK0C/x
 GyrAkPeNXGQd5kBTFFNyXHGjx84yfPFfixHIPOAaa1eECzVEAy/1apggCtffX61u/zA1t50ABPu
 6sDz0NYqneqZQuf0fuxnpOe0Q=
X-Received: by 2002:a05:6402:4486:b0:663:10b9:42d2 with SMTP id
 4fb4d7f45d1cf-668c8f0396fmr2200235a12.3.1774011972299; 
 Fri, 20 Mar 2026 06:06:12 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-668d1cc8a17sm1340378a12.18.2026.03.20.06.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:06:11 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6F55B5F82D;
 Fri, 20 Mar 2026 13:06:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 00/35] target/arm: fully model WFxT instructions for
 A-profile
Date: Fri, 20 Mar 2026 13:05:31 +0000
Message-ID: <20260320130607.2071996-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

Note on AI usage. As an experiment I previously posted a series with
the help of Gemini. This series however is a ground up
re-implementation which takes some different approaches on modelling
the event stream. In particular rather than running multiple timers we
use the same wxft timer and just compute if the timeout or timer event
will come first.

The only bits that remain from the Gemini experiment are the tests at
the end of the series. I've split up the patches and audited the
boot.S changes but I've still to go through the mini-GIC library and
the test case itself.

Alex.

Alex Bennée (35):
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
  target/arm: remove event_register check from arm_cpu_has_work
  target/arm: redefine event stream fields
  target/arm: add gt_calc_next_event_stream
  target/arm: wrap event_register in a union
  target/arm: ensure aarch64 DISAS_WFE will exit
  target/arm: implements SEV/SEVL for all modes
  target/arm: implement global monitor events
  target/arm: enable event stream on WFE instructions
  target/arm: implement WFET
  tests/tcg: split stage 1 between devices and RAM
  tests/tcg: create a mini-gic3 library
  tests/tcg: add basic test for aarch64 wf[ie][t] insns

 target/arm/cpu.h                          |  21 +-
 target/arm/internals.h                    |  12 +-
 target/arm/syndrome.h                     | 587 ++++++++++++++++++----
 target/arm/tcg/helper-defs.h              |   3 +-
 tests/tcg/aarch64/system/lib/gicv3.h      |  56 +++
 target/arm/tcg/a32.decode                 |   5 +-
 target/arm/tcg/a64.decode                 |   5 +-
 target/arm/tcg/t16.decode                 |   4 +-
 target/arm/tcg/t32.decode                 |   4 +-
 hw/intc/armv7m_nvic.c                     |   2 +-
 target/arm/cpu.c                          |  11 +-
 target/arm/helper.c                       |  97 +++-
 target/arm/hvf/hvf.c                      |  14 +-
 target/arm/machine.c                      |   4 +-
 target/arm/tcg/debug.c                    |   2 +-
 target/arm/tcg/m_helper.c                 |   4 +-
 target/arm/tcg/op_helper.c                | 122 ++++-
 target/arm/tcg/tlb_helper.c               |   6 +-
 target/arm/tcg/translate-a64.c            |  60 ++-
 target/arm/tcg/translate.c                |  19 +-
 target/arm/tcg/vfp_helper.c               |   5 +-
 target/arm/whpx/whpx-all.c                |  13 +-
 tests/tcg/aarch64/system/lib/gicv3.c      |  77 +++
 tests/tcg/aarch64/system/wfx.c            | 126 +++++
 tests/tcg/aarch64/Makefile.softmmu-target |  15 +-
 tests/tcg/aarch64/system/boot.S           |  55 +-
 26 files changed, 1116 insertions(+), 213 deletions(-)
 create mode 100644 tests/tcg/aarch64/system/lib/gicv3.h
 create mode 100644 tests/tcg/aarch64/system/lib/gicv3.c
 create mode 100644 tests/tcg/aarch64/system/wfx.c

-- 
2.47.3


