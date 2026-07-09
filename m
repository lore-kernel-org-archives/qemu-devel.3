Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CE1C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 16:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whrVw-000819-Q4; Thu, 09 Jul 2026 12:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whrVv-00080x-QH
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:22:15 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whrVs-0000Wl-JJ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:22:15 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-493ed9d8c5cso5179565e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 09:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783614131; x=1784218931; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cMSelEAvBABYdfDbYd6PhsFsqMQ+mIIuvqexnLbB+iQ=;
 b=hVicLUVW9vzZjYrANomKqNIf9Nul3WBVVpUyDPuaBIvFIhIcxdQJrzgAS+cPXfZRci
 FDwYJozTKAQo7p8/r7w76TO1axYxuNgpVKiyYF//hfQ+ce72kpUs2UGohnL/Ki9VThRa
 ym8I9tys7MU9pchMk3NYMIirVqRm0Z+TVTYp53cc3BHsuqT84P+n0ap9JyRPXBlB7+y5
 Cfs33AJrQ42AOMm8AJ90Ubl+QF0RhahaXZACQUA+dqjXCkpmSEy57IBuhuRsScRUfj5O
 LZ/gOo6e8Y0BRJavcfHlFfD8HPxZjqceVJzZlwI22bImdolYVfOkDNtFWNXoOQCTtYPW
 xcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783614131; x=1784218931;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cMSelEAvBABYdfDbYd6PhsFsqMQ+mIIuvqexnLbB+iQ=;
 b=g0JblTaWyj8Axhw+4QEk+fSKCHEkf8R2YWZ/GJamCr6R2d7rLVI5VeYPzUd3VTSui0
 qAH/oBlSsLpYwrWd42NnHdnsDYzYkQ+C4OcV9qA0Hy4l9hildU6/2i22B8W4sjZ1SQ18
 ufC0JbqMm4xk6ULKVgRG9Lf+NmarhlMWwHz3vTUfQ3frXR4Dn2HgDo8B/KOZ2DyPlUvP
 VQfqnhNOaoRzLZJCvC00DHDu69WfRM5Ey0Q7rKr4rRSPriPdpo0Og4TC7d95zQdBszs8
 epsrnb9lYFIm/eqq5e4whSdTw591KyWhXaN5N5wnIEzviINbthIDasjd3Mr3s0cdmfMs
 IDYA==
X-Gm-Message-State: AOJu0Yxps7xxnNpx6V9Lrwm2Ltpn3Koysp+Croq14EnRlna5jhYuKSiH
 5EWrEY0/icALG0Xtudwn4AowVVOgBPVU7Eft4PSxO3kdmW3Dxk6YvIhY9KQlLpAAW5SE0ANw2NF
 pnkj6qU4=
X-Gm-Gg: AfdE7cmpjNxBMAPKoL1zIwYyJuxs3ctxjXUThC+FpEbffBgLv1VUProrJzAijo9e8qa
 vl3uZqiEXncmMq5xhtyKPWb2+hNK4gGOry1x8U/elnd5ygM97BW5k5hJd7U+fHvWltOHy89lcY3
 ZuSC1VT+Qy/FmH0T4VK9wUvl7rIimVNbl5t4PamFVEfmaYyxAmsI24VogfhRLliM9rontRAynhZ
 iMz6YIptec7iM8/GIJ0jcLvIZqVuM3yDjYKpdKTYieA7sOPdY8RGoWuMSfc/+1aTZdrPaPG/b+z
 ECbjrJY5oIRHBzKSTBPc2ECmn1nhTzkFvNI8Ax60P+O/xV8oA12OIChBrb88f6sAfQOTQXx1bZb
 rnPVsFBLJetdgoV2S9CtBvZnZyj2bRtiPa0e9y7o5HShetx6wYu/d6DYDcJx1rndeq4XhuFkFg3
 PNldbvFOlXd5kE
X-Received: by 2002:a05:600c:c1c8:10b0:493:c3c9:218c with SMTP id
 5b1f17b1804b1-493e68cebf6mr64158115e9.30.1783614130655; 
 Thu, 09 Jul 2026 09:22:10 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0a55be4sm48288175f8f.31.2026.07.09.09.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 09:22:09 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 019E35F82D;
 Thu, 09 Jul 2026 17:22:09 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,  Ilya Leoshkevich
 <iii@linux.ibm.com>,  Brian Cain <brian.cain@oss.qualcomm.com>,  Gustavo
 Romero <gustavo.romero@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,  Helge Deller
 <deller@gmx.de>,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 00/91] tests/tcg: run tests with meson
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Mon, 6 Jul 2026 15:32:12 -0700")
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Thu, 09 Jul 2026 17:22:08 +0100
Message-ID: <87wlv4qgjz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> This series replaces TCG tests makefiles with meson, with the
> goal of having something more readable and maintainable in the long term.
> Also it closes the gap that tcg tests had with the rest of tests, by inte=
grating
> them with meson directly.
>
> It covers all existing tests for all architectures, including
> user/system/multiarch-user/multiarch-system. It implements all requiremen=
ts
> listed on original thread [1].
>
> [1] https://lore.kernel.org/qemu-devel/87wlwfsay4.fsf@draig.linaro.org/
>
> We also have for free:
> - correct and complete dependencies for any test, including:
>   scripts, c.inc, headers, reference files and binaries/plugins.
> - catch test declaration issues at configure time vs test time.
> - proper data types for variables instead of string expansion with make.
>
> Series first introduce the meson machinery needed in tests/tcg/meson.buil=
d, step
> by step. Then it adds support for all existing archs. Finally, we remove
> Makefiles and configure bits.
>
> Usage:
>
> ```
> make check-tcg
> make check-tcg-aarch64-linux-user
> make check-tcg-aarch64-softmmu
>
> make tcg-tests

Can these be built via ninja?

Also I noticed docs/devel/testing/main.rst needs updating for the new
world. It would be nice to add a simple example of adding a new test if
you can.

>
> ninja clean
> ./pyvenv/bin/meson test aarch64-softmmu-asid2 --verbose
> ```
>
> A few items were left for further work (out of scope for this series):
> - xtensaeb: didn't find how to cross compile for this architecture with w=
hat we
>   have now in container debian-xtensa-cross. Tips are welcome.
> - tricore: implemented but reverted as all tests seem to hang. To be
>   investigated.
> - riscv64/interruptedmemory.S is hanging. To be investigated.
> - i386/test-i386-fprem.c is deactivated for now. It's broken (output does=
 not
>   match bare metal result) and is the slowest test we have. To be refacto=
red and
>   fixed.
>
> v3
> --
>
> - add all architectures
> - reduce number of plugins tests (only add one test for each plugin from
>   multiarch pool)
> - add depends for executable - allow to depend on a custom target for gen=
erated
>   headers (x86_64 mmx, avx)
> - add new tests added since last version for aarch64 (mte + gpc)
> - refactor series to keep all arch files at end
> - add docker host architecture selection
>
> v2
> --
>
> - s/mispell/misspell
> - moved comment about why we remove 'lib' prefix for plugins
> - if user declare a wrong entry in a dictionary, list possible keys
> - build tests by default (with 'all' target), as long as cross compiler is
>   natively installed, to avoid triggering a container build.
> - reword some comments based on reviewers feedback
> - always declare all tests and avoid "per config" errors (no 'if' in arch=
 files)
> - move compiler feature and gdb version checks directly in tests/tcg/meso=
n.build
> - add support for cross containers
> - add top target 'tcg-tests' to rebuild all tests
>
> Pierrick Bouvier (91):
>   tests/tcg/multiarch/system/memory.c: remove unused variable
>   tests/tcg/multiarch/plugin/check-plugin-output.sh: take test output as
>     input
>   tests/tcg/multiarch/plugin: rename check-plugin-output to
>     regex-compare
>   tests/tcg: introduce meson.build
>   tests/tcg/meson.build: introduce exe_name
>   tests/tcg/meson.build: introduce test_name
>   tests/tcg/meson.build: introduce cflags
>   tests/tcg/meson.build: introduce qemu_args
>   tests/tcg/meson.build: introduce env_var
>   tests/tcg/plugins: build list of test_plugins
>   tests/tcg/meson.build: introduce plugin_test
>   tests/tcg/meson.build: test gdb support and introduce gdb_arch
>   tests/tcg/meson.build: introduce gdb_test
>   tests/tcg/meson.build: add default flag for testing compiler support
>   tests/tcg/meson.build: introduce wrapper
>   tests/tcg/meson.build: introduce expected_output
>   tests/tcg/meson.build: add wrapper run_and_check_forbidden_output
>   tests/tcg/meson.build: add wrapper run_with_input
>   tests/tcg/meson.build: add wrapper record_replay
>   tests/tcg/meson.build: add wrapper check_plugin_output
>   tests/tcg/meson.build: add logic to skip tests
>   tests/tcg/meson.build: introduce cc_feat and cc_feat_cflags
>   tests/tcg/meson.build: introduce gdb_feat and gdb_feat_version
>   tests/tcg/meson.build: move gdb_arch support check
>   tests/tcg/meson.build: let test infrastructure detect compiler
>   tests/docker/docker.py: return error code if probe fails
>   tests/docker/docker.py: remove "Image is up to date" info
>   tests/tcg/meson.build: introduce cc_dockerfile and cc_docker_arch
>   tests/tcg/meson.build: introduce depends
>   tests/tcg/meson.build: add top-level 'tcg-tests' target
>   tests/tcg/multiarch: declare user tests
>   tests/tcg/multiarch: declare system tests
>   tests/tcg/meson.build: add generic plugin tests
>   tests/tcg/aarch64: user tests
>   tests/tcg/aarch64/system/gpc-test.c: remove unused variables
>   tests/tcg/aarch64: system tests
>   tests/tcg/aarch64_be: user tests
>   tests/tcg/alpha: add float reference files
>   tests/tcg/alpha: user tests
>   tests/tcg/alpha: system tests
>   tests/tcg/arm: user tests
>   tests/tcg/arm: system tests
>   tests/tcg/hexagon/overflow.c: add missing include
>   tests/tcg/hexagon: user tests
>   tests/tcg/multiarch/sha1.c: fix big endian implementation
>   tests/tcg/hppa: add float reference files
>   tests/tcg/hppa: user tests
>   tests/tcg/i386: add missing float reference files
>   tests/tcg/i386: user tests
>   tests/tcg/i386: system tests
>   tests/tcg/loongarch64: user tests
>   tests/tcg/loongarch64: system tests
>   tests/tcg/m68k: add float reference files
>   tests/tcg/m68k: user tests
>   scripts/probe-gdb-support.py: add mapping for mips architecture
>   tests/tcg/mips: add float reference files
>   test/tcg/mips: user tests
>   tests/tcg/mips64: add float reference files
>   tests/tcg/mips64: user tests
>   tests/tcg/mips64el: add float reference files
>   tests/tcg/mips64el: user tests
>   tests/docker/dockerfiles/debian-all-test-cross.docker: add or1k
>     toolchain
>   tests/tcg/or1k/test_addic.c: remove unused variables
>   tests/tcg/or1k/test_muli.c: remove set but unused variable
>   tests/tcg/or1k: add float reference files
>   plugins/api.c: identify or1k pc register and mark it as read only
>   tests/tcg/or1k: user tests
>   tests/tcg/ppc64: add float reference files
>   tests/tcg/ppc64: remove dependency on qemu/compiler.h
>   tests/tcg/ppc64: user tests
>   tests/tcg/ppc64le: add missing float reference file
>   tests/tcg/ppc64le: user tests
>   tests/tcg/riscv64: add float reference files
>   tests/tcg/riscv64: user tests
>   tests/tcg/riscv64: system tests
>   tests/tcg/s390x/head64.S: declare _exit symbol after main
>   tests/tcg/s390x: add float reference files
>   tests/tcg/s390x: user tests
>   tests/tcg/s390x: system tests
>   tests/tcg/sh4: add float reference files
>   tests/tcg/sh4: user tests
>   tests/tcg/tricore: system tests
>   Revert "tests/tcg/tricore: system tests"
>   tests/tcg/x86_64: add missing float reference file
>   tests/tcg/x86_64: user tests
>   tests/tcg/x86_64: system tests
>   tests/tcg/xtensa/crt.S: align .text section
>   tests/tcg/xtensa: system tests
>   tests: remove tcg tests machinery
>   tests/tcg: remove Makefiles
>   configure: remove --cross-cc* options
>
>  configure                                     | 473 ---------
>  docs/devel/testing/main.rst                   |  22 +-
>  plugins/api.c                                 |   2 +
>  scripts/probe-gdb-support.py                  |   1 +
>  tests/Makefile.include                        |  68 +-
>  tests/docker/docker.py                        |   4 +-
>  .../dockerfiles/debian-all-test-cross.docker  |  16 +-
>  tests/lcitool/refresh                         | 107 +-
>  tests/meson.build                             |   2 +-
>  tests/tcg/Makefile.target                     | 281 -----
>  tests/tcg/aarch64/Makefile.softmmu-target     | 147 ---
>  tests/tcg/aarch64/Makefile.target             | 198 ----
>  tests/tcg/aarch64/meson.build                 | 195 ++++
>  tests/tcg/aarch64/system/gpc-test.c           |   5 -
>  tests/tcg/aarch64/system/meson.build          | 108 ++
>  tests/tcg/aarch64_be/Makefile.target          |  17 -
>  tests/tcg/aarch64_be/meson.build              |  22 +
>  tests/tcg/alpha/Makefile.softmmu-target       |  34 -
>  tests/tcg/alpha/Makefile.target               |  18 -
>  tests/tcg/alpha/float_convd.ref               | 988 ++++++++++++++++++
>  tests/tcg/alpha/float_convs.ref               | 748 +++++++++++++
>  tests/tcg/alpha/float_madds.ref               | 768 ++++++++++++++
>  tests/tcg/alpha/meson.build                   |  55 +
>  tests/tcg/alpha/system/meson.build            |  46 +
>  tests/tcg/arm/Makefile.softmmu-target         |  80 --
>  tests/tcg/arm/Makefile.target                 |  87 --
>  tests/tcg/arm/meson.build                     |  80 ++
>  tests/tcg/arm/system/meson.build              |  66 ++
>  tests/tcg/hexagon/Makefile.target             | 146 ---
>  tests/tcg/hexagon/meson.build                 | 111 ++
>  tests/tcg/hexagon/overflow.c                  |   1 +
>  tests/tcg/hppa/Makefile.target                |  14 -
>  tests/tcg/hppa/float_convd.ref                | 988 ++++++++++++++++++
>  tests/tcg/hppa/float_convs.ref                | 748 +++++++++++++
>  tests/tcg/hppa/float_madds.ref                | 768 ++++++++++++++
>  tests/tcg/hppa/meson.build                    |  22 +
>  tests/tcg/i386/Makefile.softmmu-target        |  37 -
>  tests/tcg/i386/Makefile.target                | 102 --
>  tests/tcg/i386/float_convd.conf               | 988 ------------------
>  tests/tcg/i386/float_convd.ref                | 988 ++++++++++++++++++
>  tests/tcg/i386/float_madds.ref                | 768 ++++++++++++++
>  tests/tcg/i386/meson.build                    |  58 +
>  tests/tcg/i386/system/meson.build             |  48 +
>  tests/tcg/loongarch64/Makefile.softmmu-target |  33 -
>  tests/tcg/loongarch64/Makefile.target         |  20 -
>  tests/tcg/loongarch64/meson.build             |  32 +
>  tests/tcg/loongarch64/system/meson.build      |  47 +
>  tests/tcg/m68k/Makefile.target                |   7 -
>  tests/tcg/m68k/float_convd.ref                | 988 ++++++++++++++++++
>  tests/tcg/m68k/float_convs.ref                | 748 +++++++++++++
>  tests/tcg/m68k/float_madds.ref                | 768 ++++++++++++++
>  tests/tcg/m68k/meson.build                    |  23 +
>  tests/tcg/meson.build                         | 447 ++++++++
>  tests/tcg/minilib/Makefile.target             |  21 -
>  tests/tcg/mips/Makefile.target                |  19 -
>  tests/tcg/mips/float_convd.ref                | 988 ++++++++++++++++++
>  tests/tcg/mips/float_convs.ref                | 748 +++++++++++++
>  tests/tcg/mips/float_madds.ref                | 768 ++++++++++++++
>  tests/tcg/mips/meson.build                    |  25 +
>  tests/tcg/mips/user/ase/dsp/Makefile          | 184 ----
>  tests/tcg/mips/user/isa/mips64r6/crc/Makefile |  40 -
>  tests/tcg/mips/user/isa/r5900/Makefile        |  32 -
>  tests/tcg/mips64/Makefile.target              |  20 -
>  tests/tcg/mips64/float_convd.ref              | 988 ++++++++++++++++++
>  tests/tcg/mips64/float_convs.ref              | 748 +++++++++++++
>  tests/tcg/mips64/float_madds.ref              | 768 ++++++++++++++
>  tests/tcg/mips64/meson.build                  |  27 +
>  tests/tcg/mips64el/Makefile.target            |   8 -
>  tests/tcg/mips64el/float_convd.ref            | 988 ++++++++++++++++++
>  tests/tcg/mips64el/float_convs.ref            | 748 +++++++++++++
>  tests/tcg/mips64el/float_madds.ref            | 768 ++++++++++++++
>  tests/tcg/mips64el/meson.build                |  14 +
>  tests/tcg/multiarch/Makefile.target           | 233 -----
>  tests/tcg/multiarch/meson.build               | 149 +++
>  .../multiarch/plugin/check-plugin-output.sh   |  36 -
>  tests/tcg/multiarch/plugin/regex-compare.sh   |  28 +
>  tests/tcg/multiarch/sha1.c                    |   4 +-
>  tests/tcg/multiarch/sha1.ref                  |   1 +
>  .../multiarch/system/Makefile.softmmu-target  |  81 --
>  tests/tcg/multiarch/system/memory.c           |   3 +-
>  tests/tcg/multiarch/system/meson.build        |  53 +
>  tests/tcg/or1k/Makefile                       |  71 --
>  tests/tcg/or1k/float_convd.ref                | 247 +++++
>  tests/tcg/or1k/float_convs.ref                | 187 ++++
>  tests/tcg/or1k/float_madds.ref                | 192 ++++
>  tests/tcg/or1k/meson.build                    |  72 ++
>  tests/tcg/or1k/test_addic.c                   |   2 +-
>  tests/tcg/or1k/test_muli.c                    |   5 +-
>  tests/tcg/plugins/meson.build                 |  11 +-
>  tests/tcg/ppc64/Makefile.target               |  63 --
>  tests/tcg/ppc64/float_convd.ref               | 988 ++++++++++++++++++
>  tests/tcg/ppc64/float_convs.ref               | 748 +++++++++++++
>  tests/tcg/ppc64/float_madds.ref               | 768 ++++++++++++++
>  tests/tcg/ppc64/meson.build                   |  56 +
>  tests/tcg/ppc64/vector.c                      |  11 +-
>  tests/tcg/ppc64/vsx_f2i_nan.c                 |   7 +-
>  tests/tcg/ppc64le/Makefile.target             |   7 -
>  tests/tcg/ppc64le/float_convd.ref             | 988 ++++++++++++++++++
>  tests/tcg/ppc64le/meson.build                 |  14 +
>  tests/tcg/riscv64/Makefile.softmmu-target     |  45 -
>  tests/tcg/riscv64/Makefile.target             |  20 -
>  tests/tcg/riscv64/float_convd.ref             | 988 ++++++++++++++++++
>  tests/tcg/riscv64/float_convs.ref             | 748 +++++++++++++
>  tests/tcg/riscv64/float_madds.ref             | 768 ++++++++++++++
>  tests/tcg/riscv64/meson.build                 |  38 +
>  tests/tcg/riscv64/system/meson.build          |  38 +
>  tests/tcg/s390x/Makefile.softmmu-target       |  57 -
>  tests/tcg/s390x/Makefile.target               | 127 ---
>  tests/tcg/s390x/float_convd.ref               | 988 ++++++++++++++++++
>  tests/tcg/s390x/float_convs.ref               | 748 +++++++++++++
>  tests/tcg/s390x/float_madds.ref               | 768 ++++++++++++++
>  tests/tcg/s390x/head64.S                      |   2 +
>  tests/tcg/s390x/meson.build                   | 140 +++
>  tests/tcg/s390x/system/meson.build            |  92 ++
>  tests/tcg/scripts/check_plugin_output.sh      |  25 +
>  tests/tcg/scripts/record_replay.sh            |  16 +
>  .../scripts/run_and_check_forbidden_output.sh |  19 +
>  tests/tcg/scripts/run_and_diff.sh             |  15 +
>  tests/tcg/scripts/run_with_input.sh           |  12 +
>  tests/tcg/sh4/Makefile.target                 |  18 -
>  tests/tcg/sh4/float_convd.ref                 | 494 +++++++++
>  tests/tcg/sh4/float_convs.ref                 | 374 +++++++
>  tests/tcg/sh4/float_madds.ref                 | 384 +++++++
>  tests/tcg/sh4/meson.build                     |  25 +
>  tests/tcg/tricore/Makefile.softmmu-target     |  53 -
>  tests/tcg/x86_64/Makefile.softmmu-target      |  44 -
>  tests/tcg/x86_64/Makefile.target              |  40 -
>  tests/tcg/x86_64/float_madds.ref              | 768 ++++++++++++++
>  tests/tcg/x86_64/meson.build                  |  83 ++
>  tests/tcg/x86_64/system/meson.build           |  62 ++
>  tests/tcg/xtensa/Makefile.softmmu-target      |  46 -
>  tests/tcg/xtensa/crt.S                        |   1 +
>  tests/tcg/xtensa/meson.build                  |  89 ++
>  tests/tcg/xtensaeb/Makefile.softmmu-target    |   5 -
>  134 files changed, 30491 insertions(+), 4114 deletions(-)
>  delete mode 100644 tests/tcg/Makefile.target
>  delete mode 100644 tests/tcg/aarch64/Makefile.softmmu-target
>  delete mode 100644 tests/tcg/aarch64/Makefile.target
>  create mode 100644 tests/tcg/aarch64/meson.build
>  create mode 100644 tests/tcg/aarch64/system/meson.build
>  delete mode 100644 tests/tcg/aarch64_be/Makefile.target
>  create mode 100644 tests/tcg/aarch64_be/meson.build
>  delete mode 100644 tests/tcg/alpha/Makefile.softmmu-target
>  delete mode 100644 tests/tcg/alpha/Makefile.target
>  create mode 100644 tests/tcg/alpha/float_convd.ref
>  create mode 100644 tests/tcg/alpha/float_convs.ref
>  create mode 100644 tests/tcg/alpha/float_madds.ref
>  create mode 100644 tests/tcg/alpha/meson.build
>  create mode 100644 tests/tcg/alpha/system/meson.build
>  delete mode 100644 tests/tcg/arm/Makefile.softmmu-target
>  delete mode 100644 tests/tcg/arm/Makefile.target
>  create mode 100644 tests/tcg/arm/meson.build
>  create mode 100644 tests/tcg/arm/system/meson.build
>  delete mode 100644 tests/tcg/hexagon/Makefile.target
>  create mode 100644 tests/tcg/hexagon/meson.build
>  delete mode 100644 tests/tcg/hppa/Makefile.target
>  create mode 100644 tests/tcg/hppa/float_convd.ref
>  create mode 100644 tests/tcg/hppa/float_convs.ref
>  create mode 100644 tests/tcg/hppa/float_madds.ref
>  create mode 100644 tests/tcg/hppa/meson.build
>  delete mode 100644 tests/tcg/i386/Makefile.softmmu-target
>  delete mode 100644 tests/tcg/i386/Makefile.target
>  delete mode 100644 tests/tcg/i386/float_convd.conf
>  create mode 100644 tests/tcg/i386/float_convd.ref
>  create mode 100644 tests/tcg/i386/float_madds.ref
>  create mode 100644 tests/tcg/i386/meson.build
>  create mode 100644 tests/tcg/i386/system/meson.build
>  delete mode 100644 tests/tcg/loongarch64/Makefile.softmmu-target
>  delete mode 100644 tests/tcg/loongarch64/Makefile.target
>  create mode 100644 tests/tcg/loongarch64/meson.build
>  create mode 100644 tests/tcg/loongarch64/system/meson.build
>  delete mode 100644 tests/tcg/m68k/Makefile.target
>  create mode 100644 tests/tcg/m68k/float_convd.ref
>  create mode 100644 tests/tcg/m68k/float_convs.ref
>  create mode 100644 tests/tcg/m68k/float_madds.ref
>  create mode 100644 tests/tcg/m68k/meson.build
>  create mode 100644 tests/tcg/meson.build
>  delete mode 100644 tests/tcg/minilib/Makefile.target
>  delete mode 100644 tests/tcg/mips/Makefile.target
>  create mode 100644 tests/tcg/mips/float_convd.ref
>  create mode 100644 tests/tcg/mips/float_convs.ref
>  create mode 100644 tests/tcg/mips/float_madds.ref
>  create mode 100644 tests/tcg/mips/meson.build
>  delete mode 100644 tests/tcg/mips/user/ase/dsp/Makefile
>  delete mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/Makefile
>  delete mode 100644 tests/tcg/mips/user/isa/r5900/Makefile
>  delete mode 100644 tests/tcg/mips64/Makefile.target
>  create mode 100644 tests/tcg/mips64/float_convd.ref
>  create mode 100644 tests/tcg/mips64/float_convs.ref
>  create mode 100644 tests/tcg/mips64/float_madds.ref
>  create mode 100644 tests/tcg/mips64/meson.build
>  delete mode 100644 tests/tcg/mips64el/Makefile.target
>  create mode 100644 tests/tcg/mips64el/float_convd.ref
>  create mode 100644 tests/tcg/mips64el/float_convs.ref
>  create mode 100644 tests/tcg/mips64el/float_madds.ref
>  create mode 100644 tests/tcg/mips64el/meson.build
>  delete mode 100644 tests/tcg/multiarch/Makefile.target
>  create mode 100644 tests/tcg/multiarch/meson.build
>  delete mode 100755 tests/tcg/multiarch/plugin/check-plugin-output.sh
>  create mode 100755 tests/tcg/multiarch/plugin/regex-compare.sh
>  create mode 100644 tests/tcg/multiarch/sha1.ref
>  delete mode 100644 tests/tcg/multiarch/system/Makefile.softmmu-target
>  create mode 100644 tests/tcg/multiarch/system/meson.build
>  delete mode 100644 tests/tcg/or1k/Makefile
>  create mode 100644 tests/tcg/or1k/float_convd.ref
>  create mode 100644 tests/tcg/or1k/float_convs.ref
>  create mode 100644 tests/tcg/or1k/float_madds.ref
>  create mode 100644 tests/tcg/or1k/meson.build
>  delete mode 100644 tests/tcg/ppc64/Makefile.target
>  create mode 100644 tests/tcg/ppc64/float_convd.ref
>  create mode 100644 tests/tcg/ppc64/float_convs.ref
>  create mode 100644 tests/tcg/ppc64/float_madds.ref
>  create mode 100644 tests/tcg/ppc64/meson.build
>  delete mode 100644 tests/tcg/ppc64le/Makefile.target
>  create mode 100644 tests/tcg/ppc64le/float_convd.ref
>  create mode 100644 tests/tcg/ppc64le/meson.build
>  delete mode 100644 tests/tcg/riscv64/Makefile.softmmu-target
>  delete mode 100644 tests/tcg/riscv64/Makefile.target
>  create mode 100644 tests/tcg/riscv64/float_convd.ref
>  create mode 100644 tests/tcg/riscv64/float_convs.ref
>  create mode 100644 tests/tcg/riscv64/float_madds.ref
>  create mode 100644 tests/tcg/riscv64/meson.build
>  create mode 100644 tests/tcg/riscv64/system/meson.build
>  delete mode 100644 tests/tcg/s390x/Makefile.softmmu-target
>  delete mode 100644 tests/tcg/s390x/Makefile.target
>  create mode 100644 tests/tcg/s390x/float_convd.ref
>  create mode 100644 tests/tcg/s390x/float_convs.ref
>  create mode 100644 tests/tcg/s390x/float_madds.ref
>  create mode 100644 tests/tcg/s390x/meson.build
>  create mode 100644 tests/tcg/s390x/system/meson.build
>  create mode 100755 tests/tcg/scripts/check_plugin_output.sh
>  create mode 100755 tests/tcg/scripts/record_replay.sh
>  create mode 100755 tests/tcg/scripts/run_and_check_forbidden_output.sh
>  create mode 100755 tests/tcg/scripts/run_and_diff.sh
>  create mode 100755 tests/tcg/scripts/run_with_input.sh
>  delete mode 100644 tests/tcg/sh4/Makefile.target
>  create mode 100644 tests/tcg/sh4/float_convd.ref
>  create mode 100644 tests/tcg/sh4/float_convs.ref
>  create mode 100644 tests/tcg/sh4/float_madds.ref
>  create mode 100644 tests/tcg/sh4/meson.build
>  delete mode 100644 tests/tcg/tricore/Makefile.softmmu-target
>  delete mode 100644 tests/tcg/x86_64/Makefile.softmmu-target
>  delete mode 100644 tests/tcg/x86_64/Makefile.target
>  create mode 100644 tests/tcg/x86_64/float_madds.ref
>  create mode 100644 tests/tcg/x86_64/meson.build
>  create mode 100644 tests/tcg/x86_64/system/meson.build
>  delete mode 100644 tests/tcg/xtensa/Makefile.softmmu-target
>  create mode 100644 tests/tcg/xtensa/meson.build
>  delete mode 100644 tests/tcg/xtensaeb/Makefile.softmmu-target

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

