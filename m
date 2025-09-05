Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A0DCA0FED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 12:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuVQa-0006yk-W6; Fri, 05 Sep 2025 08:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uuVQV-0006yM-NX
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 08:20:26 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uuVQI-0002sW-Aj
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 08:20:19 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b042cc3954fso361214866b.0
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 05:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757074805; x=1757679605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CFAdBz0mdTM39QNq70/HPl+DWC+Lbo7IePJjR9UCsXQ=;
 b=QglhZyuAvEvmogQjFf22L/2SN5di7ZfgsThcsuY194oRmnOTI/5dqx58zeylLhp3Is
 jn9gvnOLc7B9Xva32Yq7akpdVx/WKUYnXrJVWas7jyHlYg8PPpVyAckWmWpQdxowGr6I
 7kIk07D+/S9e3Bbk/82qvKJmiCwUk1cVXOQSjJg6AtSYdha8B6OKZ9sw/nN6Z0Qq57HH
 99BPKLjENxBJqHyX/JZxE3tX4i4sClg/Bj4eAnPqALkE8v9YGHRr8NPS8nD+IOVOZasA
 UIY0O8CfepMGQisFhMyD9efPtirNrdPePPEM9wP8XB05OCM1/jr3ZLnG9S3/1TejJi66
 tL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757074805; x=1757679605;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CFAdBz0mdTM39QNq70/HPl+DWC+Lbo7IePJjR9UCsXQ=;
 b=vLcHb2uQ94CfIDQ6BihctDwrkD1Zyyyhahjh7EAX+rnFXrIyEpL8hTSd1g/yKaw1uF
 E8f0lzAsU5G41si5mubHsVx6Cz3Ki2e54/V+YxZhHtTVJUjUZsykEeaB1oJjAtqpC4PR
 J76LVp6JKoe1kDYtsM8xgD+td1TS/QQafnh4EzYwr3IjJYXJGM1GhLY/hxQY0JrCIAaL
 8HkyTE8h4DSqlhhWtkdJz9cssnLtif+1hykCxSrbQt7uT4VOFBob7pXKaiQrb6pXy9TL
 opfZA6iwZAqlS2O0oCLsmBU2QUur/syqqs+xBUKISSz0NyiqOOqvQAx9xmb+bOXovSa1
 767A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7vwvYxOPzowUDnhO8Xv9ULTYASg5MHG2zifsGNrYXkwCgPnSk9FK3qDPCNKnR3LGTLxxo420QIRAI@nongnu.org
X-Gm-Message-State: AOJu0YyqqAevscV9V6/sqh5z8zR07G0YHGvALQHn6QEXG7QSQMPEMiCm
 8Lgqta+U16N51Z3FUHzxkER2gtioCX6/5HYIZxuUrPteUFV6yVSnCDmB+aHNrAPKhoA=
X-Gm-Gg: ASbGncsTw/hyQHM01rnfB6n9+621oo62fTD8YQPflmmP9Rdv+3o7arY3hPS/uRw/YMq
 BcY8C/uHzVLOYFkaNW1P+FxJHvGbNcXfMABwKOYrWZlzRE3um5k69c5XuKm36E2iGzOAeYjur+f
 N6ukX1ZLuKAUh15w1hiZFCbeq/SgE7btBZWtGAGnJ5LC4Z2Vi5LlB1+GJnVon0hzaUPpXX9mXos
 73cl9bsCJAr5wg3L++IbfXWqqRjIytJHDic2mFARwy+kmGQodjGknrC8tbZmC44KahNYht9L8ro
 ZMpK9HG7VdKpupnymI+hIPAhkhuBHjcAM4lZ56DlzyFuitrTWv65boem6Rx3NiUgQjPQyfYxlGZ
 FlvFFTl58A47W1aDOr5R2U30=
X-Google-Smtp-Source: AGHT+IGtQ0Q4cNU0xkIEGh/1kwDQlDewC48AzYQ9cmazzXE0LqjCX3jVoeIZvYKH6iYQfb3v1FAU3Q==
X-Received: by 2002:a17:907:7b8f:b0:aff:1719:a477 with SMTP id
 a640c23a62f3a-b01d973dd35mr2484676066b.31.1757074804896; 
 Fri, 05 Sep 2025 05:20:04 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-621421b9debsm1473495a12.34.2025.09.05.05.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 05:20:04 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 251D25F879;
 Fri, 05 Sep 2025 13:20:03 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Julian Ganz <neither@nut.email>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v6 00/25] tcg-plugins: add hooks for discontinuities
In-Reply-To: <a1c2d356-e664-2632-002f-d0b9bea06e1e@eik.bme.hu> (BALATON
 Zoltan's message of "Fri, 5 Sep 2025 13:38:56 +0200 (CEST)")
References: <cover.1757018626.git.neither@nut.email>
 <a1c2d356-e664-2632-002f-d0b9bea06e1e@eik.bme.hu>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 05 Sep 2025 13:20:03 +0100
Message-ID: <87frd1w0p8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Thu, 4 Sep 2025, Julian Ganz wrote:
>> Some analysis greatly benefits, or depends on, information about
>> certain types of dicontinuities such as interrupts. For example, we may
>> need to handle the execution of a new translation block differently if
>> it is not the result of normal program flow but of an interrupt.
>>
>> Even with the existing interfaces, it is more or less possible to
>> discern these situations, e.g. as done by the cflow plugin. However,
>> this process poses a considerable overhead to the core analysis one may
>> intend to perform.
>
> I'd rather have overhead in the plugin than in interrupt and exception
> handling on every target unless this can be completely disabled
> somehow when not needed to not pose any overhead on interrupt handling
> in the guest.

If you build with --disable-plugins the compiler should dead code away
all the plugin hooks. But in general the overhead from unused plugins is
in the noise.

> Have you done any testing on how much overhead this adds
> to interrupt heavy guest workloads? At least for PPC these are already
> much slower than real CPU so I'd like it to get faster not slower.

I have a vague memory that this is due to ppc running the interrupt
handling code more often than it should. But I forget the details.

Are there any functional tests that exhibit this slow IRQ handling
behaviour?

>
> Regards,
> BALATON Zoltan
>
>> These changes introduce a generic and easy-to-use interface for plugin
>> authors in the form of a callback for discontinuities. Patch 1 defines
>> an enumeration of some trap-related discontinuities including somewhat
>> narrow definitions of the discontinuity evetns and a callback type.
>> Patch 2 defines the callback registration function. Patch 3 adds some
>> hooks for triggering the callbacks. Patch 4 adds an example plugin
>> showcasing the new API.
>>
>> Patches 5 through 22 call the hooks for all architectures but hexagon,
>> mapping architecture specific events to the three categories defined in
>> patch 1. We don't plan to add hooks for hexagon since despite having
>> exceptions apparently doesn't have any discontinuities associated with
>> them.
>>
>> Patch 23 supplies a test plugin asserting some behavior of the plugin
>> API w.r.t. the PCs reported by the new API. Finally, patches 24 and 25
>> add new tests for riscv which serve as test-cases for the test plugin.
>>
>> Sidenote: I'm likely doing something wrong for one architecture or
>> the other. These patches are untested for most of them.
>>
>> Richard Henderson proposed streamlining interrupts and exceptions for
>> all targets and calling the hooks from a higher level rather than in
>> each target code. However, there are a few obstacled and I decided to
>> not do this as part of this series.
>>
>> Since v5:
>>  - The internal function plugin_vcpu_cb__discon now takes the
>>    qemu_plugin_event as a parameter instead of determining the event
>>    from the discon type.
>>  - Fixed computation of the last PC for ARM platforms.
>>  - Code mapping ARM exception index to discon type is now shared
>>    between m- and a-profile.
>>  - Fixed mapping of interrupt number to discon type for HPPA platforms.
>>  - Removed exception hook for some internal events for Motorola 68000.
>>  - Call hook for unaligned access exceptions on MicroBlaze platforms.
>>  - Prevented calling of exception hooks for resets on OpenRISC.
>>  - Made the discon test plugin compare hardware addesses transpated
>>    with qemu_plugin_translate_vaddr when comparing addresses. Before
>>    we'd use a crude bitmask.
>>
>> Since v4:
>>  - Fixed a typo in the documentation of the
>>    qemu_plugin_vcpu_discon_cb_t function type (pointed out by Pierrick
>>    Bouvier)
>>  - Fixed a reference in the documentation of the
>>    qemu_plugin_vcpu_discon_cb_t function type
>>  - Added hooks for SuperH and TriCore targets
>>  - Fixed typos in commit messages (pointed out by Daniel Henrique
>>    Barboza)
>>
>> Since v3 (RFC):
>>  - Switched to shifting 1 notation for qemu_plugin_discon_type values
>>    (as requested by Pierrick Bouvier)
>>  - Added missing documentation of function parameters of function
>>    pointer type qemu_plugin_vcpu_discon_cb_t
>>  - Added missing documentation of function parameters of
>>    qemu_plugin_register_vcpu_discon_cb
>>  - Eliminated "to" argument from hooks called from target specific
>>    code, i.e. qemu_plugin_vcpu_interrupt_cb and friends, determine "to"
>>    address using CPUClass::get_pc
>>  - Replaced comment declaring switch-case unreachable with
>>    g_assert_not_reached()
>>  - Call qemu_plugin_register_vcpu_discon_cb with QEMU_PLUGIN_DISCON_ALL
>>    rather than QEMU_PLUGIN_DISCON_TRAPS in "traps" example plugin
>>  - Take max_vcpus from qemu_info_t in "traps" example plugin, don't
>>    determine it based on VCPU activation
>>  - Added a description of the "traps" example plugin (as requested by
>>    Pierrick Bouvier)
>>  - Added section for the "traps" example plugin in documentation's
>>    "Emulation" chapter
>>  - Fixed messed-up switch-case in alpha_cpu_do_interrupt
>>  - Added hooks for PA-RISC, x86, loongarch, Motorola 68000, MicroBlaze,
>>    OpenRISC, Power PC, Renesas Xtreme, IBM System/390 and xtensa
>>    targets.
>>  - Made "discon" test plugin check PCs in vcpu_discon callback (as
>>    requested by Pierrick Bouvier)
>>  - Added parameter to "discon" test plugin for controlling which
>>    address bits are compared to cope with TBs being used under
>>    different virtual addresses
>>  - Added parameter to "discon" test plugin for printing a full
>>    instruction trace for debugging purposes
>>  - Made "discon" test plugin abort by default on address mismatches
>>  - Added test-cases for RISC-V
>>
>> Since v2 (tcg-plugins: add hooks for interrupts, exceptions and traps):
>>  - Switched from traps as core concept to more generic discontinuities
>>  - Switched from semihosting to hostcall as term for emulated traps
>>  - Added enumeration of events and dedicated callback type
>>  - Make callback receive event type as well as origin and target PC
>>    (as requested by Pierrick Bouvier)
>>  - Combined registration functions for different traps into a single
>>    one for all types of discontinuities (as requested by Pierrick
>>    Bouvier)
>>  - Migrated records in example plugin from fully pre-allocated to a
>>    scoreboard (as suggested by Pierrick Bouvier)
>>  - Handle PSCI calls as hostcall (as pointed out by Peter Maydell)
>>  - Added hooks for ARM Cortex M arches (as pointed out by Peter
>>    Maydell)
>>  - Added hooks for Alpha targets
>>  - Added hooks for MIPS targets
>>  - Added a plugin for testing some of the interface behaviour
>>
>> Since v1:
>>  - Split the one callback into multiple callbacks
>>  - Added a target-agnostic definition of the relevant event(s)
>>  - Call hooks from architecture-code rather than accel/tcg/cpu-exec.c
>>  - Added a plugin showcasing API usage
>>
>> Julian Ganz (25):
>>  plugins: add types for callbacks related to certain discontinuities
>>  plugins: add API for registering discontinuity callbacks
>>  plugins: add hooks for new discontinuity related callbacks
>>  contrib/plugins: add plugin showcasing new dicontinuity related API
>>  target/alpha: call plugin trap callbacks
>>  target/arm: call plugin trap callbacks
>>  target/avr: call plugin trap callbacks
>>  target/hppa: call plugin trap callbacks
>>  target/i386: call plugin trap callbacks
>>  target/loongarch: call plugin trap callbacks
>>  target/m68k: call plugin trap callbacks
>>  target/microblaze: call plugin trap callbacks
>>  target/mips: call plugin trap callbacks
>>  target/openrisc: call plugin trap callbacks
>>  target/ppc: call plugin trap callbacks
>>  target/riscv: call plugin trap callbacks
>>  target/rx: call plugin trap callbacks
>>  target/s390x: call plugin trap callbacks
>>  target/sh4: call plugin trap callbacks
>>  target/sparc: call plugin trap callbacks
>>  target/tricore: call plugin trap callbacks
>>  target/xtensa: call plugin trap callbacks
>>  tests: add plugin asserting correctness of discon event's to_pc
>>  tests: add test for double-traps on rv64
>>  tests: add test with interrupted memory accesses on rv64
>>
>> contrib/plugins/meson.build               |   3 +-
>> contrib/plugins/traps.c                   |  84 +++++++++
>> docs/about/emulation.rst                  |   8 +
>> include/qemu/plugin-event.h               |   3 +
>> include/qemu/plugin.h                     |  13 ++
>> include/qemu/qemu-plugin.h                |  60 +++++++
>> plugins/core.c                            |  57 ++++++
>> target/alpha/helper.c                     |  13 ++
>> target/arm/helper.c                       |  24 +++
>> target/arm/internals.h                    |   1 +
>> target/arm/tcg/m_helper.c                 |   5 +
>> target/avr/helper.c                       |   3 +
>> target/hppa/int_helper.c                  |  44 +++++
>> target/i386/tcg/excp_helper.c             |   3 +
>> target/i386/tcg/seg_helper.c              |   4 +
>> target/loongarch/cpu.c                    |   4 +
>> target/m68k/op_helper.c                   |  22 +++
>> target/microblaze/helper.c                |  10 ++
>> target/mips/tcg/system/tlb_helper.c       |  11 ++
>> target/openrisc/interrupt.c               |  15 ++
>> target/ppc/excp_helper.c                  |  41 +++++
>> target/riscv/cpu_helper.c                 |   9 +
>> target/rx/helper.c                        |  12 ++
>> target/s390x/tcg/excp_helper.c            |   8 +
>> target/sh4/helper.c                       |   4 +
>> target/sparc/int32_helper.c               |   7 +
>> target/sparc/int64_helper.c               |  10 ++
>> target/tricore/op_helper.c                |   5 +
>> target/xtensa/exc_helper.c                |   6 +
>> tests/tcg/plugins/discons.c               | 210 ++++++++++++++++++++++
>> tests/tcg/plugins/meson.build             |   2 +-
>> tests/tcg/riscv64/Makefile.softmmu-target |  12 ++
>> tests/tcg/riscv64/doubletrap.S            |  73 ++++++++
>> tests/tcg/riscv64/interruptedmemory.S     |  67 +++++++
>> 34 files changed, 851 insertions(+), 2 deletions(-)
>> create mode 100644 contrib/plugins/traps.c
>> create mode 100644 tests/tcg/plugins/discons.c
>> create mode 100644 tests/tcg/riscv64/doubletrap.S
>> create mode 100644 tests/tcg/riscv64/interruptedmemory.S
>>
>>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

