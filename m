Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09882E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 15:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVYQT-0001EL-Rk; Wed, 08 Jan 2025 10:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVYQR-0001Dt-H5
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 10:56:55 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVYQP-0006xC-B3
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 10:56:55 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa679ad4265so192722866b.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 07:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736351811; x=1736956611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XvXjlPQQ1jG/s5ajlks+vVKFnI4PG7SstHgS9Vzb4tM=;
 b=VeAhxmCeh9CyBUK0kccb8NQcNy83bzhKIVon1mnqrQQCHpoIyi28a2xUYQr3h+ZBz8
 ypX+M7O+NwI+gAQOSKh9CLVhiAKU8s4fYjAm7MkeZVVFvb8dyu8d11ANSHBnazEwo6v+
 pQvwY2gOMQx3VGAJ1v5ECvqld4pxCgmhC0tXMLgXYIBYUhfIEav0kBZEXhDSfGAAgMB3
 7srvhQd1mrn0Euy3nnwgCcpVdbqy4AkJs37LqHEVd67T0PxTn1u3gW/92+hWkDk40RZT
 eWEbunrK+YH2syJ2FMzUVMI+LQNkMadCWmgp0kXZmROGIRsvOfNcE3Bla+W9nGNre0t3
 EM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736351811; x=1736956611;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XvXjlPQQ1jG/s5ajlks+vVKFnI4PG7SstHgS9Vzb4tM=;
 b=OB6e9VtFVfO9167y/jpiH3kvMJs36Pjj0xc4bPvUfFv2fAZ48FbAeIA/SB+0W2vtZk
 im/o2mItNwLAAg+5k7HwFnWpRDjLLqBKYIj8QAIJthQjL+X7wkO3BsSqG34ipSYsug2q
 5CfVE8feYrQLBdepK9l9Ns1+FGyDHiCIB94SsELa04hrwWbWoWOHWcVVdvBtz5UJQGrZ
 cMk0U+MFGUULSKJB/PWl3/b0fviTeZvDLAEA77u+jJgrVeUKjpFAK8AsMZgiwwpapBXE
 hPf8Uwy8OIhc6Kjj0iFzFMP7VFK/h04VC0qdDXZ5mYCVp8zEU9ArWjXqLln6U53QA8sT
 HQVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk5W7/+TsOqu5QrCmVxTCjF7lncJVrkCrsJisBbmH98hZupCqhBbxgu5xKUO6Lpjb/VBhSInivChvq@nongnu.org
X-Gm-Message-State: AOJu0YxN5yQonN0TJpAM7CiHOxBDNnVtvbYXHZIT529pS5eq/vGZqiod
 zWa0tyNdqBvwvdCA0FBk9OIJBeCUC0P5MGEhfmJoXJOiCOHKop7dBggFxerFl7o=
X-Gm-Gg: ASbGncsF5VxQ/Kj0U2pY4mjljqmUEHLeHcjg+nv8QQFi5qBnumTljc5Xp/IB8t/Ng/D
 8kF9bATfqWPekF46Phn3bbgQzPR2I9Sh/4NL+FZGBF4P8+kDoSoEe8+u9VDd7nReWCNTB7c3wD1
 L7PIOv/Uz7L1xNBCk3MaCTLGGUcUc2hBDntAv0Y/X0E5RKm7964ilbtRWFqrpV0TzuLQZXXesmm
 yaybrJF+A5Tah5FrzXC0nSWcDMTdNnAkBzyuiauwFO0Qg0OLDaelJ0=
X-Google-Smtp-Source: AGHT+IFNvUGJKdy3k6H0oVQSqDfPxUOugTBpV/JZCB+Alg7AjASBkrj4R0ui+7COtvrxuGmLbu/SMw==
X-Received: by 2002:a17:907:2da3:b0:aa6:bcc2:3f02 with SMTP id
 a640c23a62f3a-ab2a7eb8595mr296633266b.29.1736351811042; 
 Wed, 08 Jan 2025 07:56:51 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0efe4c1dsm2533382066b.109.2025.01.08.07.56.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 07:56:50 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 97A895F8AC;
 Wed,  8 Jan 2025 15:56:49 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH 00/18] Stop all qemu-cpu threads on a breakpoint
In-Reply-To: <20240923162208.90745-1-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Mon, 23 Sep 2024 18:12:55 +0200")
References: <20240923162208.90745-1-iii@linux.ibm.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 08 Jan 2025 15:56:49 +0000
Message-ID: <87bjwhb8ou.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> Hi,
>
> On reporting a breakpoint in a non-non-stop mode, GDB remotes must stop
> all threads. Currently qemu-user doesn't do that, breaking the
> debugging session for at least two reasons: concurrent access to the
> GDB socket, and an assertion within GDB [1].
>
> This series fixes this by importing pause_all_vcpus() from qemu-system.
> This in turn requires introducing BQL and a few stubs to qemu-user.

Is there a conclusion to this design choice? I'd like to avoid bringing
in a bunch of system-mode infrastructure if the existing exclusive code
would work. For that I'll defer to the linux-user maintainer or Richard
who knows the code better than I do.

I could certainly harvest the early clean-up patches to keep the delta
low while the details are worked out. Is there going to be a v2?

>
> Best regards,
> Ilya
>
> [1] https://gitlab.com/qemu-project/qemu/-/issues/2465
>
> Ilya Leoshkevich (18):
>   gdbstub: Make gdb_get_char() static
>   gdbstub: Move phy_memory_mode to GDBSystemState
>   gdbstub: Move gdb_syscall_mode to GDBSyscallState
>   gdbstub: Factor out gdb_try_stop()
>   accel/tcg: Factor out cpu_exec_user()
>   qemu-thread: Introduce QEMU_MUTEX_INITIALIZER
>   qemu-thread: Introduce QEMU_COND_INITIALIZER
>   replay: Add replay_mutex_{lock,unlock}() stubs for qemu-user
>   qemu-timer: Provide qemu_clock_enable() stub for qemu-user
>   cpu: Use BQL in qemu-user
>   accel/tcg: Unify user implementations of qemu_cpu_kick()
>   cpu: Track CPUs executing syscalls
>   cpu: Implement cpu_thread_is_idle() for qemu-user
>   cpu: Introduce cpu_is_paused()
>   cpu: Set current_cpu early in qemu-user
>   cpu: Allow pausing and resuming CPUs in qemu-user
>   gdbstub: Pause all CPUs before sending stop replies
>   tests/tcg: Stress test thread breakpoints
>
>  accel/tcg/user-exec-stub.c                    |   4 -
>  accel/tcg/user-exec.c                         |  55 ++++++
>  bsd-user/aarch64/target_arch_cpu.h            |   6 +-
>  bsd-user/arm/target_arch_cpu.h                |   5 +-
>  bsd-user/freebsd/os-syscall.c                 |  10 +
>  bsd-user/i386/target_arch_cpu.h               |   5 +-
>  bsd-user/main.c                               |   8 +-
>  bsd-user/x86_64/target_arch_cpu.h             |   5 +-
>  cpu-common.c                                  | 179 ++++++++++++++++++
>  gdbstub/gdbstub.c                             |  17 +-
>  gdbstub/internals.h                           |   4 +-
>  gdbstub/syscalls.c                            |  20 +-
>  gdbstub/system.c                              |  18 +-
>  gdbstub/user.c                                |  28 ++-
>  include/exec/cpu-common.h                     |  15 ++
>  include/exec/replay-core.h                    |  13 ++
>  include/hw/core/cpu.h                         |   1 +
>  include/qemu/thread-posix.h                   |   8 +
>  include/qemu/thread-win32.h                   |   8 +
>  include/sysemu/cpus.h                         |   6 -
>  include/sysemu/replay.h                       |  13 --
>  linux-user/aarch64/cpu_loop.c                 |   5 +-
>  linux-user/alpha/cpu_loop.c                   |   5 +-
>  linux-user/arm/cpu_loop.c                     |   5 +-
>  linux-user/hexagon/cpu_loop.c                 |   5 +-
>  linux-user/hppa/cpu_loop.c                    |   5 +-
>  linux-user/i386/cpu_loop.c                    |   5 +-
>  linux-user/loongarch64/cpu_loop.c             |   5 +-
>  linux-user/m68k/cpu_loop.c                    |   5 +-
>  linux-user/main.c                             |   9 +-
>  linux-user/microblaze/cpu_loop.c              |   5 +-
>  linux-user/mips/cpu_loop.c                    |   5 +-
>  linux-user/openrisc/cpu_loop.c                |   5 +-
>  linux-user/ppc/cpu_loop.c                     |   5 +-
>  linux-user/riscv/cpu_loop.c                   |   5 +-
>  linux-user/s390x/cpu_loop.c                   |   5 +-
>  linux-user/sh4/cpu_loop.c                     |   5 +-
>  linux-user/sparc/cpu_loop.c                   |   5 +-
>  linux-user/syscall.c                          |  12 ++
>  linux-user/xtensa/cpu_loop.c                  |   5 +-
>  replay/stubs-system.c                         |   8 +
>  stubs/meson.build                             |   8 +
>  stubs/qemu-timer.c                            |   6 +
>  stubs/replay-mutex.c                          |  10 +
>  stubs/replay-tools.c                          |   8 -
>  system/cpus.c                                 | 172 +----------------
>  tests/tcg/multiarch/Makefile.target           |  13 +-
>  .../gdbstub/test-thread-breakpoint-stress.py  |  28 +++
>  .../tcg/multiarch/thread-breakpoint-stress.c  |  92 +++++++++
>  49 files changed, 552 insertions(+), 327 deletions(-)
>  create mode 100644 stubs/qemu-timer.c
>  create mode 100644 stubs/replay-mutex.c
>  create mode 100644 tests/tcg/multiarch/gdbstub/test-thread-breakpoint-st=
ress.py
>  create mode 100644 tests/tcg/multiarch/thread-breakpoint-stress.c

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

