Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06813E9B25A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 12:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vurFT-0005cI-UB; Tue, 24 Feb 2026 07:10:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vurF8-0005XJ-IM
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 07:10:23 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vurF4-0005rt-3T
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 07:10:20 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b8849dc12f6so783832666b.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 04:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771935016; x=1772539816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+zKxWgR6pOqdVvfJdi5Yp5BJuOETBq4A6TkE1pQ808I=;
 b=blpTHlCNM96fOM0K5b0H5oL8NwiFGlhj0xGKZwYfDmrPrAni5Q/hqRAY6iO2nkajBk
 0OEz7bNUqApiQHRSloax6wrxA3k7FiBx9fmo+f4bmorxcLx1ihNMT5iz1ViwKj6ttOjV
 0r/Uk/fozxI1zG9fOSIunr9TtJUunIDnjdRLmGCVOV5ZcB0ymmqbwplEf/SPsWwkq+3U
 JRCJvotHFsqJHVy5Ckg627iQt/wVbwT8LUq5xxRLHOMpZWqMeEhZv5qqfw6ux4Gc7lY5
 8X6GGlQE4tR3Rz3Jfpm3Dpe/CAKKNSXpufBTlp7CVLd1cVVdoTnIU4cQkRP0WK8+TOIy
 E+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771935016; x=1772539816;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+zKxWgR6pOqdVvfJdi5Yp5BJuOETBq4A6TkE1pQ808I=;
 b=gNx3V9FA7RPXdRRuwD68nXJbcBMc+yJKirP6hl46ZzSmaweBy3p6FXHEPOfVZnzdwG
 Rt16atZ6YPAC37y8Ma0qjHOJxfLC0SsWXLuV/b+RXMsNmV5P9UcTHM66j8dtXwwLD5ky
 xDDjEqpMLVbi1aUy19Ds/rSevOY7ZlODvV/uA0WHZpTexRmN9MlghKxXfwvcGcek8Co5
 HdpQ4ija8c3lHwRRhUUhs3tF6nrecWnoVDmDADlzXEtC+AEzVxh5rDSUK4xrj7EwFRRY
 q7g/W2NpWkCUtzCAb3BcFf/RoGu98LFYkRSt4SX8fB6hv7/JEu+XpRLXD3xAan2cN98D
 a6aA==
X-Gm-Message-State: AOJu0YyTdurqmqI2Q3Xl0M3FB+jPVI8/QZccdgplhVFwC8GhG0eHBhnY
 CZNYsnEWBd5DmaIhxJsDDPM817RD15/HtAjm6ssBHSjanBsUJbsRyov+Qb8K1aja5Wg=
X-Gm-Gg: ATEYQzx1/099Mt9uLf8AulGgzRZ1mvmPfyZuaG6LmcSvvQft/bEVdGT0QV5JHSunwco
 2+VjYDwyuKXnJZhSNx3NC8LG7mTrlJS8d3IctZ/HhPdFlCrX1iEy7yUscGkm7p4zjumf+eRlx3/
 MqhB5dhvIF/4/DLmxB2fRUnm0hzKuWVRqNzCgyoyHoObKThc9EYWpE09w6/kc5r20fI/1FnP+uO
 i4vSe1mqjxiJGMkc8L2sPQ68VQS3Qk2OIKnqPIgX8/8Sb6G4sCi8Epe7OgDOSrCHKKRbzQLqVdQ
 IbjmXuaQdKegH6ysm8ZoqsfqJjGb1wrfNcDHCeVeWPBjsDHVX6Xwwe0CsPtQWOqW5dKps0G2PyU
 pWisN8JZPnqCaoleuqe+Yuop6Y/RHvNIdE9ydQm2HDBM1V0YhJguWy7OsvxaR3ifxHfigf19jq7
 plESua/+B8h3PM5UE4yIo6mFE=
X-Received: by 2002:a17:907:94cc:b0:b88:31c1:c770 with SMTP id
 a640c23a62f3a-b9081922ec1mr660690066b.5.1771935015932; 
 Tue, 24 Feb 2026 04:10:15 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9084c5dcb2sm416472766b.6.2026.02.24.04.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 04:10:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8FE415F81D;
 Tue, 24 Feb 2026 12:10:14 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/8] arm: implement WFx[T] for aa64 (!!GenAI usage!!)
Date: Tue, 24 Feb 2026 12:10:06 +0000
Message-ID: <20260224121014.279248-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

*************************************************************************
** GenAI was used in the production of this series, it is not intended **
** for merging but an experiment to explore the capabilities of the    **
** current models and perhaps inform future discussions. There is no   **
** obligation to review this code.                                     **
*************************************************************************

This order and layout of this series is a little unusual as I've
included patches for tooling which wouldn't normally be included. This
includes the PLAN.md which obviously wouldn't be something you keep in
the tree.

I've also included fixup patches where I cleaned up after the agent had a
go. I also have noted what tweaks I've made to the agent commits under
the ---. The patches with my s-o-b are pure human generated.

I decided to try this experiment when fixing the WFIT syndrome data
and could see a larger re-factoring would be needed to properly handle
the RN/RD fields of the ISS. In total I've spent about 6 hours (3
idly prompting the agent on a Sunday afternoon and 3 actually
debugging and following up on failures). The total API cost was about
£1.60 which means it didn't need to save much of my time to make it
worthwhile. The model used was gemini-3-flash-preview driven by Editor
Code Assistant (https://eca.dev) in my Emacs session.

My impression is it did help me get something working faster than if
I'd gone from scratch. Even though the agent failed to account for GIC
and page table device mapping it was helped that it was being driven
by someone with a fairly good understanding of QEMU's internals.
Rather than leaving it to figure out why it was seeing data aborts I
was able to quickly theorise the reason (no mapping) and direct it to
add the needed support. I suspect it would have taken me longer to get
through that bit myself because I would be digging into the
kvm-unit-test code or re-reading the page table format documentation.

When IRQs weren't firing feeding results of the test case with the
additional "-d trace:gic\*" debug output gave the model enough context
to figure out what it had missed in the setup.

Despite the plan it smooshed a lot of stuff into each commit which
make them not ideal for review.

From what I've seen in this example the potential for inadvertent
copyright infringement is fairly low. Certainly the TCG code was
following existing styles for QEMU code and the page table setup was a
straight evolution. I'm not sure if the gic initialisation code would
count as novel enough to be copyrightable anyway.

As a first draft I think it worked quite well. To actually turn it
into a proper series I would break the code apart into much more
discreet steps and include re-factor steps before functionality
changes. For example the addition of the rd field to the helper while
correct missed the fact the timeout from rd is also in the args. I
would have just pushed the reading of rd into the helper instead.

I think it might be worth going through those steps to make a "proper"
series and seeing how different a pure human series would make.
However having a working reference with tests will be pretty helpful.

Any thoughts?

Alex.

Alex Bennée (8):
  target/arm: set the correct TI bits for WFIT traps
  .eca: basic configuration for Editor Code Assistant
  AGENTS.md: add basic AGENTS.md for QEMU
  PLAN.md: add plan for the current work
  target/arm: extend WFX support for A-profile
  tests/tcg/aarch64: Add WFX instructions system test
  tests/tcg/aarch64: fixes for WFX instructions system test
  target/arm: fixes for WFx[T] support

 target/arm/syndrome.h                     |  24 ++++-
 target/arm/tcg/helper-defs.h              |   3 +-
 tests/tcg/aarch64/system/lib/gicv3.h      |  56 ++++++++++
 target/arm/tcg/a64.decode                 |   3 +-
 target/arm/cpu.c                          |   6 +-
 target/arm/tcg/op_helper.c                | 101 +++++++++++------
 target/arm/tcg/translate-a64.c            |  27 +++--
 target/arm/tcg/translate.c                |   4 +-
 tests/tcg/aarch64/system/lib/gicv3.c      |  77 +++++++++++++
 tests/tcg/aarch64/system/wfx.c            | 126 ++++++++++++++++++++++
 .eca/config.json                          |  43 ++++++++
 .eca/skills/checkpatch/SKILL.md           |   9 ++
 .eca/skills/gtags/SKILL.md                |   7 ++
 AGENTS.md                                 |  18 ++++
 PLAN.md                                   |  77 +++++++++++++
 tests/tcg/aarch64/Makefile.softmmu-target |  15 ++-
 tests/tcg/aarch64/system/boot.S           |  55 ++++++----
 17 files changed, 579 insertions(+), 72 deletions(-)
 create mode 100644 tests/tcg/aarch64/system/lib/gicv3.h
 create mode 100644 tests/tcg/aarch64/system/lib/gicv3.c
 create mode 100644 tests/tcg/aarch64/system/wfx.c
 create mode 100644 .eca/config.json
 create mode 100644 .eca/skills/checkpatch/SKILL.md
 create mode 100644 .eca/skills/gtags/SKILL.md
 create mode 100644 AGENTS.md
 create mode 100644 PLAN.md

-- 
2.47.3


