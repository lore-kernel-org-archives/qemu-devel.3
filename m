Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAEAD690FA
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 10:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGbzU-0001uu-20; Thu, 28 Nov 2024 05:43:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzS-0001tC-6d
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:18 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzO-0000PF-JP
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:17 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-434a1833367so4046305e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 02:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732790593; x=1733395393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oYk4E/ewRoQTnBgSxniNQvwpaGZ6rvHTwiB73W6YXQM=;
 b=V5TYq7gjwis/2NKNQmArYXGRYm3wUwxZQTPbRTrP8TtUWr7WA3mS2nA1SSwpWKyELd
 4bF2zO2ypU9u1iLMWiOV7l9v3hK0LiPGoxK13pOfHBIhbrDryqFHTYX31c3s4kSdA0tM
 2/a+TdbssDDXi5J63cacnzO2oMijlrKXrf7p62KP6lCj0AtVAmBTredo3TkfWim5vfAH
 n/UVwhTRACw/6o2oSTLmVI6jMS3qsUx2tGtroFSORL7qxtJ1czIjN/jAY8f/Xf2cD03I
 6SUIF6iLqD6qMvT2VeN/aGsEGG6H5+xa9dANYzvh6OSG73Bi3quwOOSylXtNE3A5KU+F
 tvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732790593; x=1733395393;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oYk4E/ewRoQTnBgSxniNQvwpaGZ6rvHTwiB73W6YXQM=;
 b=oFsii/8dXNu4q/7JQ3gcUdJbG2RqDPiGVEYeho5TZbhk7UWMyewN+Z+YzUyaWb7Rvl
 Z19zIdThwmaxeamhgM/EDE4G6Ce9t0CI3CB2CqqF4MwHrSstbCdFbQf8NfLBQqqSYcJd
 2etHFb6UKcIVYpB45xhQuGrAbMjQuaAOIZ36vai+9gvkHP+F2Ujw/kfE2qUMreeUfupD
 1PEX5CIeWT5miPFdc9WYqb9hRCReVAQOMTtwSUjWYOHvQtlPMWAsWjkT2IYTNgUO1GWX
 yvUGLg1VaB+VsqGzjKbMABNoD4qIZEYG4ZrSDCYrlR56IEWl5Amif7bVckPr6LfYE5eR
 4ybw==
X-Gm-Message-State: AOJu0YwmTLq3KV01ilNGVwdGfXccirFU7TjhjkY0AXTZpzJ4AeqkIyeZ
 tO92pCEC8lOWNHvgXW5TUJDR2Kh8dxbW/4/Bi6L4QzZKFmh1wefKHtZpnSlJn+8v/5zHFzYN0RL
 l
X-Gm-Gg: ASbGncuA7CITB/Cnnb4eR9wErzZ9xXRt/OwjMbrk4qZpiqylc3GoLYUFAO/IxaRtbmc
 7OOB5o5eY0nhPFc2zCjy3TgoFMAWPx30dmV8/ijgVuE24n4q3I+WbHxNhbnYBkiQdmyBJXitKiD
 NxGyPfAl1t+6eyENYI0iBT7KGJkYSGrB4Xp8sDCGKaBeVflp+ttnXbis0S1Q7qslyngrfFL8odS
 C02WNJWA61AC4W+B9HkVdyKnmjveAPtGbbjFcbzAEF4lqpLWnUsAy0=
X-Google-Smtp-Source: AGHT+IFkuO7dI1m1sjtGwwDC6v8OH5tPS+P3BTWrlwOrTAYP6u2lYPXY+a46HLuX0BG285SHONUlDQ==
X-Received: by 2002:a05:600c:5123:b0:434:9dcb:2f84 with SMTP id
 5b1f17b1804b1-434afb8decdmr22239075e9.2.1732790592652; 
 Thu, 28 Nov 2024 02:43:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd68958sm1292959f8f.67.2024.11.28.02.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 02:43:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH for-10.0 00/25] fpu: Make pickNaNMulAdd behaviour runtime
 selected
Date: Thu, 28 Nov 2024 10:42:45 +0000
Message-Id: <20241128104310.3452934-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

This patchset does the same thing we already did for pickNaN() to
pickNaNMulAdd() -- it replaces the compile-time ifdef ladder that
selected target-specific NaN propagation behaviour with checking some
runtime selectable settings in the float_status.  The motivation is:
 * this will let us have multiple targets in one QEMU binary
 * the Arm FEAT_AFP architectural feature includes letting
   the guest select a NaN propagation rule at runtime
                 
The current ifdef ladder merges two different kinds of
implementation-specific behaviour:
 * handling of the (inf * zero) + NaN special case
 * selection of a NaN to propagate when more than one input is a NaN

The refactoring splits these out into two different settings, because
what a target chose for one of them isn't correlated with its
choice on the other one.

Mostly this series is not intended to have any guest visible behaviour
changes. There is one exception: the "default implementation" at the
bottom of the old ifdef ladder did not raise Invalid for the (0 * inf)
+ NaN case. This is definitely not correct, and basically any targets
using that part of the ifdef ladder had a bug because they didn't
implement their actual correct behaviour. The architectures using the
default case are i386, hppa, sh4 and tricore, and they will now raise
the Invalid exception in this case. (I checked the architecture manuals
for those architectures and they all say it should raise Invalid.)
Fixing this bug in the first patch means we don't need to have runtime
selection of a behaviour that's not actually what these targets do.
(It also means we can reorder the code to avoid calling pickNaNMulAdd()
for any target which sets default_nan_mode, as we do for pickNaN().)

The rest of the patchset is structured like the pickNaN() refactoring
-- introduce the runtime selection field in the float_status word, but
leave the ifdef ladder in place as fallback, then convert each target
one at at time.  We do the info-zero-nan setting first, then the NaN
propagation order setting.

Finally, once we're done we can remove the use_first_nan field, which
was an Xtensa-specific way to select the NaN propagation rules at
runtime.

Tested with 'make check-functional' and 'make check-avocado'
and 'make check-tcg'.

thanks
-- PMM

Peter Maydell (25):
  fpu: handle raising Invalid for infzero in pick_nan_muladd
  fpu: Check for default_nan_mode before calling pickNaNMulAdd
  softfloat: Allow runtime choice of inf * 0 + NaN result
  tests/fp: Explicitly set inf-zero-nan rule
  target/arm: Set FloatInfZeroNaNRule explicitly
  target/s390: Set FloatInfZeroNaNRule explicitly
  target/ppc: Set FloatInfZeroNaNRule explicitly
  target/mips: Set FloatInfZeroNaNRule explicitly
  target/sparc: Set FloatInfZeroNaNRule explicitly
  target/xtensa: Set FloatInfZeroNaNRule explicitly
  target/x86: Set FloatInfZeroNaNRule explicitly
  target/loongarch: Set FloatInfZeroNaNRule explicitly
  target/hppa: Set FloatInfZeroNaNRule explicitly
  softfloat: Allow runtime choice of NaN propagation for muladd
  tests/fp: Explicitly set 3-NaN propagation rule
  target/arm: Set Float3NaNPropRule explicitly
  target/loongarch: Set Float3NaNPropRule explicitly
  target/ppc: Set Float3NaNPropRule explicitly
  target/s390x: Set Float3NaNPropRule explicitly
  target/sparc: Set Float3NaNPropRule explicitly
  target/mips: Set Float3NaNPropRule explicitly
  target/xtensa: Set Float3NaNPropRule explicitly
  target/i386: Set Float3NaNPropRule explicitly
  target/hppa: Set Float3NaNPropRule explicitly
  fpu: Remove use_first_nan field from float_status

 include/fpu/softfloat-helpers.h   |  27 +++-
 include/fpu/softfloat-types.h     |  61 ++++++++-
 target/mips/fpu_helper.h          |  13 ++
 target/arm/cpu.c                  |   8 ++
 target/hppa/fpu_helper.c          |  10 ++
 target/i386/tcg/fpu_helper.c      |   9 ++
 target/loongarch/tcg/fpu_helper.c |   6 +
 target/mips/msa.c                 |   7 +
 target/ppc/cpu_init.c             |  15 +++
 target/s390x/cpu.c                |   3 +
 target/sparc/cpu.c                |   4 +
 target/xtensa/cpu.c               |   2 +
 target/xtensa/fpu_helper.c        |   3 +-
 tests/fp/fp-bench.c               |   6 +
 tests/fp/fp-test.c                |   6 +
 fpu/softfloat-parts.c.inc         |  19 ++-
 fpu/softfloat-specialize.c.inc    | 206 ++++++++----------------------
 17 files changed, 236 insertions(+), 169 deletions(-)

-- 
2.34.1


