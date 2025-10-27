Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08D4CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDLQ4-0006gN-OH; Mon, 27 Oct 2025 07:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDLPt-0006bs-Rr
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:29:40 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDLPn-0002tC-P5
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:29:36 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-63bea08a326so6471338a12.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761564561; x=1762169361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6W1h9SPPhGdZNQbElgjYoxu13x/9GVYMR5jHwBwvdxM=;
 b=hlr3SzVrpYLOl1U8VgFHNNgemzOPaHBDq32tcQdhGKTmb8ElwiRGrE7U5A4qmKS8yn
 cCXjDUrV+IAdV/mSac1UM0b+Sn4lsIhCYaz1GCsTc1I8kcSy3oYHjDg0y5fGM+GMRp4c
 UiJjrI3fV/pSkkLF1/1+48eeAjA7jLHO3jG5OJ3pLqj20BvYzYIVeVYmenPA+Fm7bJSo
 Sn68nqpQ05mhiVc6N25v31t+EjtI0153gRWuqaOjGFdFnqLPTs/CWvojKtZS7nuiQcIf
 Oq8IpDu59HI67h4XXllDAOPfi778hRN25jTTJPyK/2F6enDGo4iU5VstvyhLKc5Rc159
 H1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761564561; x=1762169361;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6W1h9SPPhGdZNQbElgjYoxu13x/9GVYMR5jHwBwvdxM=;
 b=lQ81cCtC60rVrjkC1p8/TS2apZj6nwspjiLPlV92rxTz9ooyMW8WzfxFQH7JAGcQxL
 3zHLOyG5xjQjEd2pD4kIFRjQsbxCTa1Cd7pKwCpxWzTGvgbE1qPClDRriItZ9mMpXI9A
 92YMxqp3keB1Uza936vpsp1GFjrwt3Rc/liu0XPRfMNPckKFFcCbtYX+yyieOAkS0n/V
 HtONnvRqV4UtDDejHPqU5YJMiJE2VWHlmNuOepnXg2Bpc5wwB8fN/Fnos8SkiLcSkQEM
 6xBDi9yd+NUNSqkzcSifYg2rvpRtoltHeutLtzrahEihyTBhyg6i5pOosLrXYGjCCdYq
 tQOA==
X-Gm-Message-State: AOJu0YwUeGY6ABC3KuGdEBsEdmtZUDb6l8bBB9QLXOmo5pb7FoB/ZyzT
 2PvrVjwURnFFBM6paJYiwGZhuw1YXm4YMJvLT5PiSPVoG5jj2pj2ARwdCY/DmP+Qc4c=
X-Gm-Gg: ASbGncsUnGSVW+BbdHeW8xdqyk5poLPV8sTikxSKzI7gRW6Ea6I5A2aP+E3LmEHCl2h
 g1VqV12wCu/AWikYXfdLvgHatQsnNO5gVMEyTVo4+w2E7L88varAqmlDFV108kzzey9IM9lJvzN
 bh4K8DLn7xqdRgzcsaOLexe37miAz0+sApixdQJaKV/YOmDkdOveEaX0HajU8X+2xPd3cmYeGQD
 JBdSxCpI6llmmnvEYO422o4EbbB6po1VYh1w25XGOeUze6EuX8fwI6s0ebihtwxUf9x0UjNapRc
 knlVZwxiJMqSWUJYVp07+rVSxxLbmUE+K72+op0BsdlO2rRNXuweN+nBIuc5LhGrLbWzpzjFJK+
 a3K4tydmkyiLd7Sym3VuJVEzojf040rJQGrpmLjQGY5v00LuErlIszcPkskqY6PptLod3qOHLCj
 1l4OFwcEuCOWU=
X-Google-Smtp-Source: AGHT+IHc4AQ+JBp1nIR+qFc6zaSMMCKxCXNHdvmH5AUywdFfQvEaemqlQ53JZqExwuln1jX+kqK5fA==
X-Received: by 2002:a05:6402:4504:b0:634:ab34:ed40 with SMTP id
 4fb4d7f45d1cf-63c1f580cf2mr34932038a12.0.1761564559866; 
 Mon, 27 Oct 2025 04:29:19 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e7ef829dasm6061281a12.13.2025.10.27.04.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 04:29:19 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 406825F8CD;
 Mon, 27 Oct 2025 11:29:18 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,  Alexandre Iooss
 <erdnaxe@crans.org>,  Chinmay Rath <rathc@linux.ibm.com>,
 qemu-arm@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,  Nicholas
 Piggin <npiggin@gmail.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,  David
 Hildenbrand <david@redhat.com>,  qemu-ppc@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  qemu-s390x@nongnu.org,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>,  Helge Deller <deller@gmx.de>,  Stafford
 Horne <shorne@gmail.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Palmer Dabbelt <palmer@dabbelt.com>,  Alistair
 Francis <alistair.francis@wdc.com>,  Laurent Vivier <laurent@vivier.eu>,
 Weiwei Li <liwei1518@gmail.com>,  Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>,  Yoshinori Sato
 <yoshinori.sato@nifty.com>,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,  Thomas Huth
 <thuth@redhat.com>,  Max Filippov <jcmvbkbc@gmail.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>,
 Michael Rolnik <mrolnik@gmail.com>,  Song Gao <gaosong@loongson.cn>,
 qemu-riscv@nongnu.org,  Aleksandar Rikalo <arikalo@gmail.com>
Subject: Re: [PATCH 00/35] maintainer updates for 10.2 softfeeeze (ci,
 plugins, semihosting) pre-PR
In-Reply-To: <20251027110344.2289945-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?= message of "Mon, 27 Oct 2025 11:03:07 +0000")
References: <20251027110344.2289945-1-alex.bennee@linaro.org>
User-Agent: mu4e 1.12.14-dev2; emacs 30.1
Date: Mon, 27 Oct 2025 11:29:18 +0000
Message-ID: <87v7k0y44x.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Hi,
>
> This should be my final pull-request before softfreeze on the 4th of
> November. As I'll be travelling I intend to send it out by the end of
> the week.

This is of course the 10.2 softfreeze. I must be nostalgic ;-)

>
> The CI changes are mostly cleanups for the ansible scripts. I've
> dropped the final testing/next patch which enables the ppc64le custom
> runner as I don't think I'll have time to debug that before the
> freeze.
>
> The plugin updates are already well reviewed and should make more
> richer plugins giving semantic info on the type of discontinuities you
> can see.
>
> There are a few other minor fixes including come missing CFI tags for
> some plugin callbacks and fixing the minimal -no-tcg build.
>
> The following still need review:
>
>   scripts/ci: modify gitlab runner deb setup
>   tests/lcitool: generate a yaml file for the ppc64le runner
>   scripts/ci: allow both Ubuntu or Debian to run upgrade
>   scripts/ci: move build-environment.yaml up a level
>   scripts/ci/setup: regenerate yaml
>   ci: clean-up remaining bits of armhf builds.
>
> Alex.
>
> Alex Benn=C3=A9e (8):
>   ci: clean-up remaining bits of armhf builds.
>   scripts/ci/setup: regenerate yaml
>   scripts/ci: move build-environment.yaml up a level
>   scripts/ci: allow both Ubuntu or Debian to run upgrade
>   tests/lcitool: generate a yaml file for the ppc64le runner
>   scripts/ci: modify gitlab runner deb setup
>   plugins/core: add missing QEMU_DISABLE_CFI annotations
>   configs: drop SBSA_REF from minimal specification
>
> Julian Ganz (25):
>   plugins: add types for callbacks related to certain discontinuities
>   plugins: add API for registering discontinuity callbacks
>   plugins: add hooks for new discontinuity related callbacks
>   contrib/plugins: add plugin showcasing new dicontinuity related API
>   target/alpha: call plugin trap callbacks
>   target/arm: call plugin trap callbacks
>   target/avr: call plugin trap callbacks
>   target/hppa: call plugin trap callbacks
>   target/i386: call plugin trap callbacks
>   target/loongarch: call plugin trap callbacks
>   target/m68k: call plugin trap callbacks
>   target/microblaze: call plugin trap callbacks
>   target/mips: call plugin trap callbacks
>   target/openrisc: call plugin trap callbacks
>   target/ppc: call plugin trap callbacks
>   target/riscv: call plugin trap callbacks
>   target/rx: call plugin trap callbacks
>   target/s390x: call plugin trap callbacks
>   target/sh4: call plugin trap callbacks
>   target/sparc: call plugin trap callbacks
>   target/tricore: call plugin trap callbacks
>   target/xtensa: call plugin trap callbacks
>   tests: add plugin asserting correctness of discon event's to_pc
>   tests: add test for double-traps on rv64
>   tests: add test with interrupted memory accesses on rv64
>
> Sean Anderson (2):
>   gdbstub: Fix %s formatting
>   semihosting: Fix GDB File-I/O FLEN
>
>  docs/about/emulation.rst                      |   8 +
>  docs/devel/testing/ci-jobs.rst.inc            |   7 -
>  configs/devices/aarch64-softmmu/minimal.mak   |   1 -
>  include/qemu/plugin-event.h                   |   3 +
>  include/qemu/plugin.h                         |  13 ++
>  include/qemu/qemu-plugin.h                    |  60 +++++
>  target/arm/internals.h                        |   1 +
>  contrib/plugins/traps.c                       |  83 +++++++
>  gdbstub/syscalls.c                            |   2 +-
>  plugins/core.c                                |  58 +++++
>  plugins/loader.c                              |   1 +
>  semihosting/arm-compat-semi.c                 |   5 +-
>  target/alpha/helper.c                         |  13 ++
>  target/arm/helper.c                           |  24 ++
>  target/arm/tcg/m_helper.c                     |   5 +
>  target/avr/helper.c                           |   3 +
>  target/hppa/int_helper.c                      |  17 ++
>  target/i386/tcg/excp_helper.c                 |   3 +
>  target/i386/tcg/seg_helper.c                  |   4 +
>  target/loongarch/tcg/tcg_cpu.c                |   4 +
>  target/m68k/op_helper.c                       |  22 ++
>  target/microblaze/helper.c                    |  10 +
>  target/mips/tcg/system/tlb_helper.c           |  11 +
>  target/openrisc/interrupt.c                   |  15 ++
>  target/ppc/excp_helper.c                      |  41 ++++
>  target/riscv/cpu_helper.c                     |   9 +
>  target/rx/helper.c                            |  12 +
>  target/s390x/tcg/excp_helper.c                |   8 +
>  target/sh4/helper.c                           |   4 +
>  target/sparc/int32_helper.c                   |   7 +
>  target/sparc/int64_helper.c                   |  10 +
>  target/tricore/op_helper.c                    |   5 +
>  target/xtensa/exc_helper.c                    |   6 +
>  target/xtensa/xtensa-semi.c                   |   3 +
>  tests/tcg/plugins/discons.c                   | 221 ++++++++++++++++++
>  .../custom-runners/ubuntu-24.04-aarch64.yml   |   2 -
>  contrib/plugins/meson.build                   |   2 +-
>  .../setup/{ubuntu =3D> }/build-environment.yml  |  32 +--
>  .../ci/setup/debian/debian-13-ppc64le.yaml    | 134 +++++++++++
>  scripts/ci/setup/gitlab-runner.yml            |   6 +-
>  .../ci/setup/ubuntu/ubuntu-2404-aarch64.yaml  |   4 +-
>  .../ci/setup/ubuntu/ubuntu-2404-s390x.yaml    |   4 +-
>  tests/lcitool/refresh                         |   1 +
>  tests/tcg/plugins/meson.build                 |   2 +-
>  tests/tcg/riscv64/Makefile.softmmu-target     |  12 +
>  tests/tcg/riscv64/doubletrap.S                |  73 ++++++
>  tests/tcg/riscv64/interruptedmemory.S         |  97 ++++++++
>  47 files changed, 1031 insertions(+), 37 deletions(-)
>  create mode 100644 contrib/plugins/traps.c
>  create mode 100644 tests/tcg/plugins/discons.c
>  rename scripts/ci/setup/{ubuntu =3D> }/build-environment.yml (63%)
>  create mode 100644 scripts/ci/setup/debian/debian-13-ppc64le.yaml
>  create mode 100644 tests/tcg/riscv64/doubletrap.S
>  create mode 100644 tests/tcg/riscv64/interruptedmemory.S

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

