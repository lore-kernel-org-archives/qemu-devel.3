Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD99CAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 05:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v20os-0004jf-KH; Fri, 26 Sep 2025 01:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v20oj-0004gt-Cw
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:16:26 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v20oX-0005zN-MU
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:16:23 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-26a0a694ea8so16197905ad.3
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 22:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758863766; x=1759468566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4fb5YIRAYuFTsi1a0hr4VCGRrcrYRivQ/A3VTdModZM=;
 b=H1D5Qc9JvYI1wXzgi98tPzCaQlT9z1dC9NJB24y4Eoo1W8vMZgrSPsHrtDZzCfXx6T
 k8eTZMJQ2dicAZvllx1KF9zBb5HbkqsNpWyYe8USRVaRTcxeSZDD70LyAHvvY68tHSe/
 3ZdjX73Mxg6nSKlTuaxI+m3a0nrejP3g/P4NUik6Dz6/KBQ3cwc1B6yoMzvwnsbaY2BM
 On+ued4siUEvUW0rsNBodqexADvuFwLUPdD6jV1CC2JVdeaXq230155y83IsFW09fyRa
 359ZgnY8K6rLBvwz7FX7FwJ/CqhiBdQQDxYLA6C448AgELOhBffqfPRED3b4YNR1vasg
 Nkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758863766; x=1759468566;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4fb5YIRAYuFTsi1a0hr4VCGRrcrYRivQ/A3VTdModZM=;
 b=Pz1p0Ew9D5xFNZw6E+kKaOWjf94KHk4L1BSc47PKu+vDmCsHvww/tGUuDyYNqm4L1u
 TQOk2NxCwuqf4Y9XZp4zS7O2pmREQo3lg21qAXBb0meaS2tpdlzcqXOoDTpSr7HgKJmY
 zczjLR0iNV1VLfMvxRlik2jzfQZSnDALepmeuoReCWLafVjcnA2vuSoO2ku4i4b6MX/r
 7/s6uMne5dOODY8hVoJqqEhLLAJZLuq9CJ5Yxyx10bMMRKDQ/21fIkBZdHkV1ybgDEd5
 phlltS+X1IM+2VnbcVSxa9gsa3blDzOi5HUILZJ4mK1rZisacJVvV/VscyBoWp9m8Zn8
 5UFg==
X-Gm-Message-State: AOJu0YyjpdkJYW4N4x+d01iUaj5ZGR05ucZETXPxApkiBxvdnbrbqb0R
 LCY9nvE0k3qVxfRm3ovAptk1xJmctQUn5seHLFNUsZSyku2LuqvEaAUH2JbJ6uOIEBDgX6HDsj0
 KYdcY
X-Gm-Gg: ASbGncs15R50r3yv0Gl4sTlfsGjAHbpqtFySbqT8sJwF9HgvbQgnZ8CgQa35B8kQEDM
 7FQFY6+ppWZz0H0FQ6/IcFOZCcprcMVNZONeYFwyW6ocZxYx2RL/RakfzUAg7NOCLb8UxuYqiUW
 XBEHFZM3+yYHnOd+qPTfJWjlvADKhNoLcWFhX/aEW2iyLIXtwkEZ+V7t4Gw3H+Mf8HQYE4K73EM
 mmCXFcqF7O6DcTGqKxG4ydMheOMr0dfPkXc9lx0ZCUnUQ4NLkNHlvLx4y1vejFZN9WJ1pYKDEkG
 lNfDxxmMRz5+yE1tKkyrTYuXfTHKOkXjuGunggvB24FqOLBPrKgY9Ai3qeCJw1w4xHuo1ECGUxX
 5MWVRhlN2tvpgQtSLulBdU4C1lEersHNZVz41wspAfuD/DOgRrhH72NfGnplifhqbPfXk
X-Google-Smtp-Source: AGHT+IHKLcCmfA0yDNi08yuMefjTyUq6RDVJb9VhJhU2LlmYZZ65jEDUGVo2ixtDZfuyMcV8C9RwpQ==
X-Received: by 2002:a17:903:1c9:b0:267:6649:ec17 with SMTP id
 d9443c01a7336-27ed49d1344mr62684425ad.23.1758863766549; 
 Thu, 25 Sep 2025 22:16:06 -0700 (PDT)
Received: from gromero0.. (189-47-45-49.dsl.telesp.net.br. [189.47.45.49])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed672a51fsm42160085ad.63.2025.09.25.22.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 22:16:06 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org, gustavo.romero@linaro.org,
 manos.pitsidianakis@linaro.org, peter.maydell@linaro.org
Subject: [PATCH v4 0/9] tests/functional: Adapt reverse_debugging to run w/o
 Avocado
Date: Fri, 26 Sep 2025 05:15:33 +0000
Message-Id: <20250926051542.104432-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62c.google.com
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

tests/functional: Adapt reverse_debugging to run w/o Avocado

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
- Installed pygdbmi only in check-functional step and using pip,
  so not from local wheels (thomas)
- Fixed GDB probe in configure by ensuring that the GDB passed to Meson
  supports all that arches in the target list
- Fixed error found by Alex when skipping the test, "name 'test' is not
  defined", by using the new decorator suggested by Daniel to skip the
  tests if QEMU_TEST_GDB env var is missing (alex, daniel)
- Moved GDB class into its own file under qemu_test, in gdb.py. (alex,
  daniel)
- Put subprocess and the drop of the data drainer changes in separate
  commits (used previous commits from Daniel for it) (alex, daniel)
- Put back /usr/bin/env python shebang into per arch test files (daniel)
- Added new method reverse_debugging_run() to separate test bootstrap
  from GDB test execution, also helping to get a better diff view
  (daniel)
- Made diffs better for reviewing by avoiding mixing text changes with
  changes in the code related to Avocado's removal (alex, daniel)


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

 configure                                     |  21 +++
 meson_options.txt                             |   2 +
 pythondeps.toml                               |   1 +
 scripts/meson-buildoptions.sh                 |   2 +
 tests/Makefile.include                        |   2 +-
 .../functional/aarch64/test_reverse_debug.py  |   9 +-
 tests/functional/meson.build                  |   6 +
 tests/functional/ppc64/test_reverse_debug.py  |  11 +-
 tests/functional/qemu_test/__init__.py        |   4 +-
 tests/functional/qemu_test/decorators.py      |  18 +++
 tests/functional/qemu_test/gdb.py             |  85 +++++++++++
 tests/functional/reverse_debugging.py         | 140 ++++++++----------
 tests/functional/x86_64/test_reverse_debug.py |  13 +-
 13 files changed, 216 insertions(+), 98 deletions(-)
 create mode 100644 tests/functional/qemu_test/gdb.py

-- 
2.34.1


