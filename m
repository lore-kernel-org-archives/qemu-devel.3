Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF217CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 14:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoNV5-0007Lf-Av; Tue, 19 Aug 2025 10:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uoNV4-0007LQ-3E
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 10:39:46 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uoNV2-0007r4-Cl
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 10:39:45 -0400
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-76e563b25c4so1835491b3a.0
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 07:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755614382; x=1756219182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HPEfj/wzsoNYio8S7SRrHlFpuN1xItsEVgaWBosMrFE=;
 b=B3+sUUqononp9nHCSjr+ezgc+LJTpp3qDZjMiZIRHfdIgvAHBdOicSUhbnxr2/rXXw
 3jLAYfjQ993gspy7lhnWcre5OXANCDMPaBIzk9nONokCYVEfbEgQAtlo/KEtRUoffAUS
 /9vB2crl+TaY6/1MZOL5lVW5wGie3fzTvSypUfr2SA20oV62Ey6cvKsrsuatlVgixQSS
 hWnOoXITE7L7YKhNoMIiN7JQYH+k+Gvy2OJyYjK6TuQzpHKoxcbq/5uaKIiJNNwH0J6T
 4GYOglb4eja1Jr5/a0OuoDrS55lAhHqpXGfS9W8ydp2KH8wX52fcaoAA0iUxIn98pezL
 m5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755614382; x=1756219182;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HPEfj/wzsoNYio8S7SRrHlFpuN1xItsEVgaWBosMrFE=;
 b=XDNCc7j/RJJ4iVInZqp6DuGcts9jYkgCDgX0YE0BATwHhrrDPBFMByvCRVCS8CQH/X
 GQak+nF6lGz+34uHTExZWVpINd0aBwCVHwRq/HJTgBkoLF3Qe1sGEYnyAbbwy1wa+IeU
 0NRwZQFlLumSWp/kj2Pl4zHQiY8Ja00Jss+NppGposEJidPXae55C54f71bxMBjk9RCe
 BJJfpnOKmjhPld0ilNrzIjolLKme7h+sV1h3UXVXWLV2sGPWkCYD66emX8hrNAe2psc7
 rwXPBT14Dn0O4ATEwv+MUexFDpjyIRk/JMziKkGvEQZ3Mklf4Q8VTmHoAxCDUKUXUFfJ
 D40A==
X-Gm-Message-State: AOJu0YwxnUZiDRQwUTGLJF1ZCcx6UI9/MuwqUXsTz25s/Av1IcLUL0oL
 XAjkw/I/UI+ovOjGeoJ8gphgdXql5996uqrKFRkMnfYHD1/9klEi2QcOEnwyu4A8WeGUZevuvoX
 7mR1DFeZ70Q==
X-Gm-Gg: ASbGncsnY1AwJ9rCcWfbHqlwoAqXBgBhnpRCpQO+pb1ETxPQIo43YB0AOXiwJJT0Lbg
 Ys+4u+JDvVZdI25feJiPKCGjc5vjHXO3JZHx6g6HQomtP+gEZ0YK/M6NV25Ws7HQmaeJWKwWIlQ
 7IUQFiBfaNrGVi41dAePl7JRCZaZlA0tvquZ5dko3/IKHRkuzSzyZr1593bm8gvIheT6tCBscvS
 /O1RW/obEC/3tB5q9fc9yDRG64Mfni9e9k6quRYHF2BRygBwW6xiXNozdr7WOk8a84gJdzSwa1O
 7Ha77jJcsIV1MuPFIM2SOw9SJHaUap26x2XZ2H6l0PvSkuaDdR7GO48RfuiNaDYUxF8ReSr74HO
 Ias24eI1oDqcRBFsm001WLAxcNHloxeIzRiES7JPHASk9Kp81m7LUIFUSWQ==
X-Google-Smtp-Source: AGHT+IEP7RW4zw2I0e8d55L1ucIxjw6KOFYWrYQ2w9SOQkZns7vc0nLGZveOI60DzUdjg5yP889hCQ==
X-Received: by 2002:a05:6a00:2d15:b0:76c:c48f:d7ab with SMTP id
 d2e1a72fcca58-76e80ecd8eemr3518154b3a.13.1755614382061; 
 Tue, 19 Aug 2025 07:39:42 -0700 (PDT)
Received: from gromero0.. (201-1-50-181.dsl.telesp.net.br. [201.1.50.181])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76e7d0d98dfsm2769781b3a.17.2025.08.19.07.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 07:39:41 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	alex.bennee@linaro.org,
	thuth@redhat.com
Cc: qemu-arm@nongnu.org,
	1844144@gmail.com,
	gustavo.romero@linaro.org
Subject: [PATCH 0/4] tests/functional: Adapt reverse_debugging to run w/o
 Avocado
Date: Tue, 19 Aug 2025 14:39:12 +0000
Message-Id: <20250819143916.4138035-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x442.google.com
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

The goal of this series is to remove Avocado as a dependency for running
the reverse_debugging functional test.

This test, the last one I’m aware of that relies on Avocado, requires it
because of the need for GDB to test reverse stepping and continue.

In this series, we leveraged the run-test.py script used in the
check-tcg tests, making it a GDB runner capable of calling a test script
without spawning any VMs. In this configuration, the test script can
manage the VMs and also import gdb from the test script, making the
Python GDB API available inside the functional test.

The test is kept “skipped” for aarch64, ppc64, and x86_64, so it is
necessary to set QEMU_TEST_FLAKY_TESTS=1 in the test environment to
effectively run the test on these archs.

On aarch64, the test is flaky, but there is a fix that I’ve tested while
writing this series [0] that resolves it. On ppc64 and x86_64, the test
always fails: on ppc64, GDB gets a bogus PC, and on x86_64, the last
part of the test (reverse-continue) does not hit the last executed PC
(as it should) but instead jumps to the beginning of the code (fist PC
in forward order).

Thus, to run the reverse_debugging test effectively on aarch64:

$ export QEMU_TEST_FLAKY_TESTS=1
$ make check-functional 

Cheers,
Gustavo

[0] https://gitlab.com/qemu-project/qemu/-/issues/2921

Gustavo Romero (4):
  tests/guest-debug: Make QEMU optional in run-test.py
  tests/functional: Support tests that require a runner
  tests/functional: Mark main in QemuBaseTest class as a static method
  tests/functional: Adapt reverse_debugging to run w/o Avocado

 meson.build                                   |   4 +
 tests/functional/meson.build                  |  77 ++++++++-
 tests/functional/qemu_test/testcase.py        |   1 +
 tests/functional/reverse_debugging.py         | 158 +++++++++---------
 .../functional/test_aarch64_reverse_debug.py  |  19 +--
 tests/functional/test_ppc64_reverse_debug.py  |  17 +-
 tests/functional/test_x86_64_reverse_debug.py |  21 +--
 tests/guest-debug/run-test.py                 |  81 +++++----
 8 files changed, 223 insertions(+), 155 deletions(-)

-- 
2.34.1


