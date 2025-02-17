Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C4EC021AA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 12:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk0b4-0001gs-Sf; Mon, 17 Feb 2025 07:51:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk0aZ-0001bi-Eh
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 07:51:09 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk0aT-0002Eb-Ah
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 07:51:05 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43971025798so10033255e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 04:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739796658; x=1740401458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9ud18g85fOzOYfo/x43I9RD+IvZLBcjEbmt+1jX8zBw=;
 b=jKg5IILBsGj8+QMXYNQ1kKy8CRZo8EBGSCJiQlXTxoLN9szRvD4wtJcox0MGordiqT
 w36QB6j5dZxVx3ovSN2t7hR0o6SLwwwwt9spqrL3Omb+LkJK77lHoG/USiAm9oSGk+pU
 s4jTluc7uIiB1oVf7Z2ZIYa0yWdx0uWQmNm6lWzJLP/Wm7R3Yeo80rjSAkKCALu5qIw5
 M5hYabTpSHF5zxRETjfA6xOP3qgmANmnIv0Z20L/POiNaXn8C0S4iRtuHlc+kJdBp7SM
 9ehRlRPpuLvGaIoE2hWg/gw8hvTdb+UkmD2+V6NQM+Vn34I4E4SwB6BCVesKtoHZtbvd
 aFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739796658; x=1740401458;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9ud18g85fOzOYfo/x43I9RD+IvZLBcjEbmt+1jX8zBw=;
 b=eIh50jo7S6ouunbWM8uZptd3w+vC4/qjoKe1k0zmyEpbnb6IOG1tnlXcZXnVVG1yda
 rK20GpOBxKKpJ2SRpwyI+WWwBlyW7twt9NbpNp4ynQ2usYHBcIDDYBmuiR2x//ImV4jf
 fx88tqUGbobp9xtVV//6g7WVJ9ANGvFXRh1Dnywv3/rCHRAI4YDcO0xa/ymLnL+8Cbqp
 oasX+/EVxeucLKDumusumvopnz6qtEtPrW3mIk241kgkvikgNxRRJQw7eNrQ2Ak+FCor
 M2zE77cgSScnnnzxjJiEkby+mFHOro2xPUGtZDwxqKAKvXuV8YbnuJrX57/44fvuIMuA
 uwsw==
X-Gm-Message-State: AOJu0YxsNgf7OW7srKKQKi0zGgbHDdlrt1yhQJ8wSPuq+1oLE9lqKOwg
 RjCvyHs3hmNMCtiJwZP5zaHclGSZSixJPT5d3rqxttcQCv6M1a8LIrerJ7wuLwCvLr6HN56lxJa
 n
X-Gm-Gg: ASbGnctqsE+XDKe5lrFmnGHGDHgFZvFxYItB3sE2VYVOCacmSB4M5G8oCc7qL75KY/0
 HI/JHi/4252E7/rZ9go7fuSXybTPGocvi9uN0lvvUfdvDPIERnNxzKRzconSIB7fzMqZLyhl3/y
 AyWyGt13n0YPlxli4T93BPIcOOP2wvwMKeZDmIpkir1mrWKXzgVWVWJNSw7G2DZNd0P9YOvU/hc
 05c7y2G3Ab2OLJ83IpyzIZf97UfKmSQuNWbSZo4tT1Yf9mHjwBMe/BI1ljthBE1mXGaxE1N/k+x
 qVdtjYNWj9t6fRX5dU9PYg==
X-Google-Smtp-Source: AGHT+IFI5/nQQLrAQs+P+H1J91bTfvKcs6gdXbZzFtmbxOlji0ZT3OxH7AK6/yDmUyAiWq3jmEJ8pw==
X-Received: by 2002:a05:600c:4ecd:b0:434:a468:4a57 with SMTP id
 5b1f17b1804b1-4396e750885mr70858545e9.26.1739796658128; 
 Mon, 17 Feb 2025 04:50:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4398e84efb9sm3562455e9.10.2025.02.17.04.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 04:50:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 00/10] fpu: Remove remaining target ifdefs and build only once
Date: Mon, 17 Feb 2025 12:50:45 +0000
Message-ID: <20250217125055.160887-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

The work I needed to do to make various softfloat emulation behaviours
runtime-selectable for Arm FEAT_AFP has left the fpu code with very
few remaning target ifdefs. So this series turns the last remaning
ones into runtime behaviour choices and switches the fpu code into
"build once" rather than "build per target". The main driver of this
is that we're going to want to do this for the "multiple targets in
one binary" work.

The remaining fpu target ifdefs fall into two categories:

(1) floatx80 behaviours

Two QEMU targets implement floatx80: x86 and m68k. (PPC also has one
use in the xsrqpxp round-to-80-bit-precision operation, and the
Linux-user NWFPE emulation nominally supports it, but these are
minor.) x86 and m68k disagree about some of the corner cases of
floatx80 where the value has the explicit Integer bit wrongly set.  At
the moment the fpu code defaults to "floatx80 behaves like x86", with
TARGET_M68K ifdefs to get the other option.

The first six patches in this series remove those ifdefs, replacing
them with a floatx80_behaviour field in float_status which can have
various flags set to select the individual behaviours. The default is
"like x86", which allows us to set these only for m68k and not worry
about the minor "technically makes some use of floatx80" cases.

I do have a question about whether I've correctly understood what we
do (or don't do) for handling input pseudo-denormals, which we
currently do via the FloatFmt::m68k_denormal flag; see patch 6.  I'm
confident that the patch is correct, in the sense of not being a
behaviour change, but less sure about whether the TODO comment I've
added about existing incorrect handling is right.

(2) simple optimizations

A handful of the target ifdefs are making compile-time choices that
can trivially be pushed back to runtime by deleting the ifdef.
Patches 7-9 do these changes.

Then patch 10 can update the meson.build file to "build once".

Tested with 'make check-tcg' and 'make check-functional'; the
series is supposed to not have any behaviour changes.

thanks
-- PMM

Peter Maydell (10):
  fpu: Make targets specify floatx80 default Inf at runtime
  target/m68k: Avoid using floatx80_infinity global const
  target/i386: Avoid using floatx80_infinity global const
  fpu: Make targets specify whether floatx80 Inf can have Int bit clear
  fpu: Make floatx80 invalid encoding settable at runtime
  fpu: Move m68k_denormal fmt flag into floatx80_behaviour
  fpu: Always decide no_signaling_nans() at runtime
  fpu: Always decide snan_bit_is_one() at runtime
  fpu: Don't compile-time disable hardfloat for PPC targets
  fpu: Build only once

 include/fpu/softfloat-helpers.h | 12 +++++
 include/fpu/softfloat-types.h   | 42 +++++++++++++++
 include/fpu/softfloat.h         | 91 ++++++++++++++++++---------------
 fpu/softfloat.c                 | 23 +++------
 target/hppa/fpu_helper.c        |  1 +
 target/i386/tcg/fpu_helper.c    | 51 +++++++++---------
 target/m68k/cpu.c               | 35 +++++++++++++
 target/m68k/fpu_helper.c        |  2 +-
 target/m68k/softfloat.c         | 47 ++++++-----------
 target/sh4/cpu.c                |  1 +
 fpu/softfloat-parts.c.inc       | 20 ++++++--
 fpu/softfloat-specialize.c.inc  | 29 ++++-------
 fpu/meson.build                 |  2 +-
 13 files changed, 220 insertions(+), 136 deletions(-)

-- 
2.43.0


