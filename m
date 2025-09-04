Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCADCA1013
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 15:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuCBb-0004rJ-1b; Thu, 04 Sep 2025 11:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uuCBF-0004kX-Pt
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 11:47:26 -0400
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uuCB4-0008EI-12
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 11:47:21 -0400
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-5448c576e3bso501465e0c.3
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 08:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757000821; x=1757605621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yOnn6Do8LsxgzKBiy5sUOxzwN39PLAw+R39zZvac568=;
 b=sfNhacjAkBkw8hiSysSVUhPmR9eBU/qHN2ECHjbTwkHS1sH56BwHliBuHAhKRZZ/AD
 QxrN6Y3ut8cn71GF3DYM0Flvn14BEZ8AP26p8JuO0j1ez6bMGw0gfI4+ahMCEG0+fQkj
 n5QNXB3Qkma9MsHZPRyMx4SEVKNxsglRJmQHngp87cPF1uC9l25O/H0OYMmORYXTiS+G
 3LY3Fc5jNn5UJeICTFSm7NLvH39+KQLhvWxI8RBJVgpdvVkANJ7qPPVrTrnFkSSITdep
 LeZEmT11zaMlRx3iJUJ0PSFyBLrvfBqnOh0pRY4dPC8oDlknG/GTf1CSoT3trY6vFSof
 0I7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757000821; x=1757605621;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yOnn6Do8LsxgzKBiy5sUOxzwN39PLAw+R39zZvac568=;
 b=lrkvvIaNYMvYBKFoDK8JKdwuKbLKpUabPF4EvLia+xWhhvjpxLnwAN4fZyWGcS5Lbt
 diiM9/kuv+QeJr40aTGAxohfDMidtC2yb3QtnaSL4GseFa9dkOn7U30ZXmUtCASTGDxk
 qZuBbBxgkFItToj/4r/6i8bD1qZVn/Yl5eLEd7dWn6t0hsYhrJwvBNURysgl15IxPmXI
 pxK6AymozvB480cOys3B4+YiiXF/XZoFW5C0MT7NBjK8GnEiHAfz+pHxTKrg/5RNdteX
 AIhkNkYTu52nti2K1dU0fuQMzE/ZbErheUHCUEXlqgCFLFiZmW6DkUAlnw232rfw9omZ
 Bw0g==
X-Gm-Message-State: AOJu0YzVeCKnx6DxiIbUvkC1GJwA8iR9iMMJcrPdvyjM0+nz5eMSQsJZ
 40vZ5lXNoGFVCPUlcFdDbkBUxaWAAbH3qgaFFQjtgiZTFPuS22vGW/YMy9hXwQayPRiFnJXz4+j
 a18fZMKF7TQ==
X-Gm-Gg: ASbGncvd+yo4Ews+5eHVB/PewHkpRgGwEK+gpIMBW3NEMB5CteMyhn7tiHSmrFjExnq
 Ngp+3c9NbAAvRlrz0C4ZLAYnVZhsTQpxbAwW7ntALRM+8FjdqhTrB747pVFY9Vt5jIjt8VsxZsL
 3j354V+9c7TH6we28kz8I0SnxTFc9TCX+lOyrE6u75+DzuIAgY1xtSwG0XmFe8XdfxckRmZafKk
 2GxRJ2sECtPZzWqKu9PPZ1hJbK1zif89woEt5XnizCyqVWTKsj28/C8nwxy2eezcYObxr5EX3Lh
 kYfWQNocDJGWcUffAeDZqscoVC9OgEYqyppH1KJVjtIhu+XWCD2xCSEp/l2ZEPC6HSgtuthxQKw
 DN0XWbQGL3ukJRM/+qGpzkNY+b85b
X-Google-Smtp-Source: AGHT+IHftDoYZXHsuXOj2+6WgECV2XuLyqyUT95Yi8tEyi96bcM5933K9sC7GJPAkA7ArYel1kbXJg==
X-Received: by 2002:a05:6122:1350:b0:544:9414:105f with SMTP id
 71dfb90a1353d-544a018f69fmr5941514e0c.2.1757000820705; 
 Thu, 04 Sep 2025 08:47:00 -0700 (PDT)
Received: from gromero0.. ([186.215.58.133]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-544a666da0csm6497022e0c.28.2025.09.04.08.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 08:47:00 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org,
	1844144@gmail.com,
	gustavo.romero@linaro.org
Subject: [PATCH v2 0/5] tests/functional: Adapt reverse_debugging to run w/o
 Avocado
Date: Thu,  4 Sep 2025 15:46:35 +0000
Message-Id: <20250904154640.52687-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vk1-xa36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
because of the need for GDB to test reverse stepping, continue, etc.

In this series, we leveraged the run-test.py script used in the
check-tcg tests, making it a GDB runner capable of calling a test script
without spawning any VMs. In this configuration, the test scripts can
manage the VM and also import gdb, making the GDB Python API inside the
functional test scripts.

A --quiet option has been added to run-test.py so it doesn't print the
command line used to execute GDB to the stdout. This ensures that users
don't get confused about how to re-run the tests. One can re-run the
test simply by copying and pasting the command line shown by Meson when
V=1 is passed:

$ make -j check-functional V=1

or, alternatively, once the test run completes, the exact command found
in the 'command:' field of the build/meson-logs/testlog-thorough.txt
file generated by Meson. Both methods provide the correct environment
variables required to run the test, such as the proper $PYTHONPATH.

The test is kept “skipped” for aarch64, ppc64, and x86_64, so it is
necessary to set QEMU_TEST_FLAKY_TESTS=1 in the test environment to
effectively run the test on these archs.

On aarch64, the test is flaky, but there is a fix that I’ve tested while
writing this series [0] that resolves it. On ppc64 and x86_64, the test
always fails: on ppc64, GDB gets a bogus PC, and on x86_64, the last
part of the test (reverse-continue) does not hit the last executed PC
(as it should) but instead jumps to the beginning of the code (first PC
in forward order).

Thus, to effectively run the reverse_debugging test on aarch64:

$ export QEMU_TEST_FLAKY_TESTS=1
$ make check-functional


Cheers,
Gustavo

v2:
- Rebased on top of master, which split tests in tests/functional/<arch>
- No abrupt exit from GDB since it will throw an exception in recent GDB versions 
- Fixed report of passed/failed/skipped to Meson
- Improved detection of the GDB in meson.build by using GDB probed by ./configure
- Separate run-test.py changes to ease reviewing  
- Added --quiet option to run-test.py


Gustavo Romero (5):
  tests/guest-debug: Make QEMU optional in run-test.py
  tests/guest-debug: Format comments
  tests/guest-debug: Add quiet option to run-tests.py
  tests/functional: Support tests that require a runner
  tests/functional: Adapt reverse_debugging to run w/o Avocado

 configure                                     |   2 +
 meson.build                                   |   4 +
 meson_options.txt                             |   2 +
 scripts/meson-buildoptions.sh                 |   2 +
 tests/functional/aarch64/meson.build          |   7 +-
 .../functional/aarch64/test_reverse_debug.py  |  15 +-
 tests/functional/meson.build                  |  65 +++++++
 tests/functional/ppc64/meson.build            |   7 +-
 tests/functional/ppc64/test_reverse_debug.py  |  17 +-
 tests/functional/reverse_debugging.py         | 175 +++++++++---------
 tests/functional/x86_64/meson.build           |   7 +-
 tests/functional/x86_64/test_reverse_debug.py |  21 +--
 tests/guest-debug/run-test.py                 |  86 +++++----
 13 files changed, 253 insertions(+), 157 deletions(-)

-- 
2.34.1


