Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81ABCCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 14:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4gch-0004Gt-0M; Fri, 03 Oct 2025 10:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v4gcf-0004GN-5P
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 10:19:01 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v4gcP-0000K6-EC
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 10:18:58 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-27eceb38eb1so22530835ad.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 07:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759501110; x=1760105910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bteyki4gqEOG9+SiyuC+9idLWj7g31DDsgmYydJp5CY=;
 b=tnykFpiSwXRP6sLEJWzibYaSf4AQ1hoDZrW1AqlRbjglVVU5y/QyCNTCytb7k4aAPK
 2nvWPSVD3/MtCPWp/QdnTm9hCCv+MIVxRWJgefbvrtiopHNv0Cb+iMYv4qo2xu67zYPN
 0+bAX/hGuIaBJjM3ZB+zv8aeJ7Iwd05YCrayGFaBGPPaXrGyHZ+KKPEb5hNhUsX8Fb5o
 FFqplyLuGe7trEQYNfg6Ryk8XzKg+kmJRXDXsDJDqgLJhjg7pg2vCDSTdM2mVfPEEhMc
 z8P/R6IckxC8qCQqE25fhUYFODM0NPvcwsOTp6HmB+vwEEDtfW03NOdgWqzcnirsKTSm
 XtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759501110; x=1760105910;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bteyki4gqEOG9+SiyuC+9idLWj7g31DDsgmYydJp5CY=;
 b=H9rC626GKlewOWTY4tWTfJL/3gLzfS4pnP29QAPsvN5qBmYpuWXWxIQ358yFzalTxK
 Am+iVdH+oMfQ6Tkc8LAgfKrFxCNjSfBtrCKrf1mQm0qxGl4B6aQKU1p2NQRfdeS43tMw
 70/j16ymPPVouYc1gKw18LeD+APqafR5MkecCQ4e+BR/4O/3GmSfCWfu/WSyqtaraXgU
 koScz4naw7dpHPab2BspmCo5cc+e1IPOFluWmLPWGIgKEYT269Z0wmDy7diGUlgqaQ4l
 C5tdQEFbXOYYFSiDhdpcDoIEVbMWdPN0gZO+hwrmpUxwL1Uv3l2u06INvBswNzHJkUcB
 Pj5g==
X-Gm-Message-State: AOJu0YySpnu92y1ghAeogBgFcyTH/8Q0D7hOIXGSlfO64g1VC3kpWsNH
 luOIXfJQ27JQUlWAyGVstxGhF+qystgUSZ98OroJMoQUL9D6O6sTgEus/tvGb70w6B1KJ4JXF5r
 rkzL9
X-Gm-Gg: ASbGncvmrNYukpSZKy56dUXyKgaZX78yVfuifnz2pYE2iRANgAncyJmvWk581vChMdI
 LjtWt5n3vn64MAnbfJ/82uzm5uH+WJPpJv2hv307E6I1g3IObW0LX81iITMPR1o0LKCXljuj7Q9
 7/1von8Goa6wXhAq77hpRmNghOVQMZqsaUly8OdiwD5k827EPOlMgqJCGvw9cFnpnn03YKbnhgw
 trtoBPorg1beiHGwMRO7t1faj+6W9UMAS62nD+K3fuVqLhlD/7AHW6lMQiLQQTko80wz9mZOkS1
 xiW3Qc7SACA52QERP3vS4OH34BGYsEiZkk3rMVr7fpbmiSrO8LS4JPdLlZcSsKTg7KZGmw+cc5J
 cq9+pw6nbImRMYsj6vKnr+l+x6iYjlT4DbI85StFMFyQxVxtkyeImhjHyi7Haqmcz/7A=
X-Google-Smtp-Source: AGHT+IHhmEADcPeuDPlw/7d9Bny7t5qb4QWekpIzWL23qSoSKVKzBHaPrNKmzx0Dgt2T5DnGTHNmWg==
X-Received: by 2002:a17:903:9cc:b0:26b:3aab:f6bf with SMTP id
 d9443c01a7336-28e9a61ee0bmr50992985ad.42.1759501109974; 
 Fri, 03 Oct 2025 07:18:29 -0700 (PDT)
Received: from gromero0.. ([186.215.59.111]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1d5635sm51759645ad.102.2025.10.03.07.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 07:18:29 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v6 0/9] tests/functional: Adapt reverse_debugging to run w/o
 Avocado
Date: Fri,  3 Oct 2025 14:18:11 +0000
Message-Id: <20251003141820.85278-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62a.google.com
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

The goal of this series is to remove Avocado as a dependency for running
the reverse_debugging functional test.

After several rounds of discussions about v1 and v2, and experiments
done by Daniel and Thomas (thanks for all the experiments and comments
so far), I've taken a new approach and moved away from using a runner
for GDB. The changes, I believe, are much simpler now.

This new series uses GDB's machine interface (MI) via the pygdbmi module
(thanks Manos and Peter for the inputs). pygdbmi provides a controller
to start GDB and communicate with it through MI, so there is no longer a
risk of version clashes between libpython in GDB and Python modules in
the pyvenv, as it could, in theory, happen when GDB executes the test
script via -x option.

Also, as Daniel pointed out, the overall test output is pretty bad and
currently does not allow one to easily follow the sequence of GDB
commands used in the test. I took this opportunity to improve the output
and it now prints the sequence in a format that can be copied and pasted
directly into GDB.

The TAP protocol is respected, and Meson correctly displays GDB's test
output in testlog-thorough.txt.

Because the pygdbmi "shim" is so thin, I had to write a trivial GDB
class around it to easily capture and print the payloads returned by its
write() method. The GDB class allows clean, single-line commands to be
used in the tests through method chaining, making them easier to follow,
for example:

pc = gdb.cli("print $pc").get_add()

The test is kept “skipped” for aarch64, ppc64, and x86_64, so it is
necessary to set QEMU_TEST_FLAKY_TESTS=1 in the test environment to
effectively run the test on these archs.

On aarch64, the test is flaky, but there is a fix that I’ve tested while
writing this series [0] that resolves it. On ppc64 and x86_64, the test
always fails: on ppc64, GDB gets a bogus PC, and on x86_64, the last
part of the test (reverse-continue) does not hit the last executed PC
(as it should happen) but instead jumps to the beginning of the code
(first PC in forward order).

Thus, to effectively run the reverse_debugging test on aarch64:

$ export QEMU_TEST_FLAKY_TESTS=1
$ make check-functional

or:
$ make check-functional-aarch64

or even, to run only the reverse_debug test after 'make check-functional':
$ ./pyvenv/bin/meson test --verbose --no-rebuild -t 1 --setup thorough --suite func-thorough func-aarch64-reverse_debug


Cheers,
Gustavo

v1:
https://patchew.org/QEMU/20250819143916.4138035-1-gustavo.romero@linaro.org/

v2:
https://patchew.org/QEMU/20250904154640.52687-1-gustavo.romero@linaro.org/

v3:
https://patchew.org/QEMU/20250922054351.14289-1-gustavo.romero@linaro.org/

v4:
https://patchew.org/QEMU/20250926051542.104432-1-gustavo.romero@linaro.org/

v5:
https://patchew.org/QEMU/20251002020432.54443-1-gustavo.romero@linaro.org/

v6:
- Fixed skipping test when no GDB is installed in the test environment


Daniel P. Berrangé (2):
  tests/functional: replace avocado process with subprocess
  tests/functional: drop datadrainer class in reverse debugging

Gustavo Romero (7):
  tests/functional: Re-activate the check-venv target
  python: Install pygdbmi in meson's venv
  tests/functional: Provide GDB to the functional tests
  tests/functional: Add GDB class
  tests/functional: Add decorator to skip test on missing env vars
  tests/functional: Adapt reverse_debugging to run w/o Avocado
  tests/functional: Adapt arches to reverse_debugging w/o Avocado

 configure                                     |   2 +
 meson_options.txt                             |   2 +
 pythondeps.toml                               |   1 +
 scripts/meson-buildoptions.sh                 |   2 +
 tests/Makefile.include                        |   4 +-
 .../functional/aarch64/test_reverse_debug.py  |  11 +-
 tests/functional/meson.build                  |   6 +
 tests/functional/ppc64/test_reverse_debug.py  |  15 +-
 tests/functional/qemu_test/__init__.py        |   4 +-
 tests/functional/qemu_test/decorators.py      |  18 +++
 tests/functional/qemu_test/gdb.py             |  88 ++++++++++
 tests/functional/reverse_debugging.py         | 151 +++++++++---------
 tests/functional/x86_64/test_reverse_debug.py |  15 +-
 13 files changed, 218 insertions(+), 101 deletions(-)
 create mode 100644 tests/functional/qemu_test/gdb.py

-- 
2.34.1


