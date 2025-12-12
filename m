Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD37D49222
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 12:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU2S7-00040v-Ta; Fri, 12 Dec 2025 07:40:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vU2Rs-0003w1-3B
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 07:40:41 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vU2Rm-0005H5-U9
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 07:40:38 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47a80d4a065so8549365e9.2
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 04:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765543231; x=1766148031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ofzAwNa3ajONt/OlP7ItwqDaT40fRVcX80GC9rin4w=;
 b=gJH/Fh9mfhLti4L6rVTsGrWJxHfwK/f3UU2cw7PsQx4qSJyHPB/sQanp6fHVhf38E3
 0j6AeZjBKNSTEWgnYEx6K/bx+ggF1RmSlhTVG5QfP3RBgjR24FQxwOFn2LLWNkx4BvvN
 T2GQE0ZJutW4cqMOGGTd83J9meAiMYyiHZ2rFghajbuHrThKOSvEWAH9ewsRDjg6frBX
 UTKGJxLRQZCBv/2FYE/YBkasRNqhH7i/z3DOYw/ezJtm6gBWOmSVSTZDAQxRA33YfkYs
 R4eJS0y7XKlDvi782RJU9s9itckcal+FZlJOP9qT9ZDIw1O8hAfoYJfmUCZbqEaz5IGh
 Jn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765543231; x=1766148031;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7ofzAwNa3ajONt/OlP7ItwqDaT40fRVcX80GC9rin4w=;
 b=gKXQf9Ue7N5nm2YxX8gqmMp+8YFPVOsAwzjnT9UaUTMYL+BcF2wZzE74PxxHbBS8UE
 JbcikAIeWQSLFPLUJCps0bTmbjcOW+j9o98ku8zRchyI2Y61YFAlABYQanL93pz5Fk49
 lggwAskhywaBvT0s0BYbJdARimxZ8Ggcz+7NzRoUKj7cVrMRGwv/YdwFBjTX/4RvDz+h
 5LjKX4t0bUVMFGthPgjj2BSqKgnUmYZPFY3pljvYbw0RAGeDQwOQ8TES/XgdddU/qumL
 aZu9FSkw98P/Fs6ssXdyu3He2pn+9FxbHcyaNg7r4t0vVj4yh6GviW1227Z8qgY7+8x1
 NhMA==
X-Gm-Message-State: AOJu0YzgYdl50zli1MCpIfcONJal5J3qT3T24LcWfsA3lMBYXpNMBKvT
 WfE/ydTtxMv2vzEaU8OOZCtn2LcgpIUarjZnAM/x5ZK0tLBzlIeOtVMzxavbUdhC7ME=
X-Gm-Gg: AY/fxX5WcHV9PChpvF5or8W2CdMDvh96Wkgseq9xk0XBRcMbMxGK3sSWsCiFgr3MBl6
 hNSAEO3Kl+8H5cjkxMKPNHuuc4LiTH6ipxskVNNGtn1X8LcneXvvYfy9ui7jQtxNsokzLfZdez1
 YrgBMCCbFgktOhWXs9REqyYovA5ISqlpxklBTfyUDn1aIEzOTkNR1NslJHGkUU1WcrA37aJfMP4
 6yz3YIOjpB1gIa9CP6jUQY1d6ukXJN1hQFF5D9g8E1nZMtguNr2VMzFIzZzYu6OHGU7A/jYeYg7
 inL+6cv8gVXwSnzil6oHYlwptD76ec57TS8q5kd0qYs4cM6zuJ9m9oagozyTSEJtCpCKV6qb2O6
 x8lHLz97Rd+CBoHxZ8NmAKxNedMJ9Hec8+knVRL48Wgk51J4+8IsbL67MyIWFQmpYIx9FDDW5J0
 IY8q5jqIQchyw=
X-Google-Smtp-Source: AGHT+IGx4a+2oBvYihjc0ZW0d9NgDTOt2Nz1m/WxGXVQQfJ2rY0cPEs6jB87tgmJIoVuTOO78Ya2AA==
X-Received: by 2002:a05:600c:4451:b0:477:7b16:5f9f with SMTP id
 5b1f17b1804b1-47a8f9145c1mr18573185e9.31.1765543231026; 
 Fri, 12 Dec 2025 04:40:31 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f71576csm11265595e9.18.2025.12.12.04.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 04:40:30 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4EE9F5F82E;
 Fri, 12 Dec 2025 12:40:29 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org,  laurent@vivier.eu,  imp@bsdimp.com,
 berrange@redhat.com
Subject: Re: [RFC PATCH v2 2/2] tests/tcg: add test for qemu_plugin_set_pc API
In-Reply-To: <0b65f1ca-c960-4d9a-9029-23974218da80@epfl.ch> (Florian
 Hofhammer's message of "Mon, 6 Oct 2025 15:23:18 +0200")
References: <e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b@epfl.ch>
 <0b65f1ca-c960-4d9a-9029-23974218da80@epfl.ch>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Fri, 12 Dec 2025 12:40:29 +0000
Message-ID: <877burub42.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Florian Hofhammer <florian.hofhammer@epfl.ch> writes:

> The test executes a non-existent syscall, which the syscall plugin
> intercepts and redirects to a clean exit.
> Due to architecture-specific quirks, the Makefile requires setting
> specific compiler and linker flags for some architectures.
>
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
> ---
>  tests/tcg/multiarch/Makefile.target           | 42 +++++++++++++++++++
>  .../tcg/multiarch/test-plugin-skip-syscalls.c | 26 ++++++++++++
>  tests/tcg/plugins/syscall.c                   |  6 +++
>  3 files changed, 74 insertions(+)
>  create mode 100644 tests/tcg/multiarch/test-plugin-skip-syscalls.c
>
> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Ma=
kefile.target
> index f5b4d2b813..7df3da2aba 100644
> --- a/tests/tcg/multiarch/Makefile.target
> +++ b/tests/tcg/multiarch/Makefile.target
> @@ -204,6 +204,48 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
>  	$(QEMU) $<
>=20=20
>  EXTRA_RUNS_WITH_PLUGIN +=3D run-plugin-test-plugin-mem-access-with-libme=
m.so
> +
> +# Test plugin control flow redirection by skipping system calls
> +ifeq ($(TARGET),arm-linux-user)
> +# Require emitting arm32 instructions, otherwise the vCPU might accident=
ally
> +# try to execute Thumb instructions in arm32 mode after qemu_plugin_set_=
pc()
> +test-plugin-skip-syscalls: CFLAGS+=3D-marm
> +endif
> +ifneq ($(filter mips64%-linux-user,$(TARGET)),)
> +# Require no ABI calls to avoid $t9-relative .got address calculation
> +test-plugin-skip-syscalls: CFLAGS+=3D-mno-abicalls -fno-pie
> +test-plugin-skip-syscalls: LDFLAGS+=3D-no-pie
> +endif
> +ifneq ($(filter mips%-linux-user,\
> +	   $(filter-out mips64%-linux-user,\
> +	   $(TARGET))),)
> +# qemu-mips(el) returns ENOSYS without triggering syscall plugin callbac=
ks
> +run-plugin-test-plugin-skip-syscalls-with-libsyscall.so:
> +	$(call skip-test, $<, "qemu-mips(el) does not execute invalid syscalls")
> +endif
> +ifeq ($(TARGET),sparc64-linux-user)
> +# The defined addresses for the binary are not aligned correctly for spa=
rc64
> +# but adjusting them breaks other architectures, so just skip it on spar=
c64.
> +run-plugin-test-plugin-skip-syscalls-with-libsyscall.so:
> +	$(call skip-test, $<, "qemu-sparc64 does not allow mapping at our given=
 fixed address")
> +endif
> +ifeq ($(TARGET),hexagon-linux-user)
> +# hexagon uses clang/lld which does not support -Ttext-segment but GNU l=
d does
> +# not generally support --image-base.
> +test-plugin-skip-syscalls: LDFLAGS+=3D-Wl,--image-base=3D0x40000
> +else
> +test-plugin-skip-syscalls: LDFLAGS+=3D-Wl,-Ttext-segment=3D0x40000
> +endif
> +test-plugin-skip-syscalls: LDFLAGS+=3D-Wl,--section-start,.redirect=3D0x=
20000
> +run-plugin-test-plugin-skip-syscalls-with-libsyscall.so:

All these arch specific hacks should be moved to the arch specific
makefiles. We do this for example for the sha1 alt builds.

> +
> +EXTRA_RUNS_WITH_PLUGIN +=3D run-plugin-test-plugin-skip-syscalls-with-li=
bsyscall.so
> +
> +else # CONFIG_PLUGIN=3Dn
> +# Do not build the syscall skipping test if it's not tested with a plugin
> +# because it will simply return an error and fail the test.
> +MULTIARCH_TESTS :=3D $(filter-out "test-plugin-skip-syscalls", $(MULTIAR=
CH_TESTS))
> +

rather than filtering it out lets move it into a subdir (plugin-tests?)
and conditionally include it like we do with linux above?

>  endif
>=20=20
>  # Update TESTS
> diff --git a/tests/tcg/multiarch/test-plugin-skip-syscalls.c b/tests/tcg/=
multiarch/test-plugin-skip-syscalls.c
> new file mode 100644
> index 0000000000..1f5cbc3851
> --- /dev/null
> +++ b/tests/tcg/multiarch/test-plugin-skip-syscalls.c
> @@ -0,0 +1,26 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This test attempts to execute an invalid syscall. The syscall test pl=
ugin
> + * should intercept this.
> + */
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +void exit_success(void) __attribute__((section(".redirect"), noinline,
> +                                       noreturn, used));
> +
> +void exit_success(void) {
> +    _exit(EXIT_SUCCESS);
> +}
> +
> +int main(int argc, char *argv[]) {
> +    long ret =3D syscall(0xc0deUL);
> +    if (ret !=3D 0L) {
> +        perror("");
> +    }
> +    /* We should never get here */
> +    return EXIT_FAILURE;
> +}
> diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
> index 42801f5c86..c5bac2d928 100644
> --- a/tests/tcg/plugins/syscall.c
> +++ b/tests/tcg/plugins/syscall.c
> @@ -148,6 +148,12 @@ static void vcpu_syscall(qemu_plugin_id_t id, unsign=
ed int vcpu_index,
>              fprintf(stderr, "Error reading memory from vaddr %"PRIu64"\n=
", a2);
>          }
>      }
> +
> +    if (num =3D=3D 0xc0deUL) {
> +        /* Special syscall to test the control flow redirection function=
ality. */
> +        qemu_plugin_outs("Marker syscall detected, jump to clean exit\n"=
);
> +        qemu_plugin_set_pc(0x20000);
> +    }
>  }
>=20=20
>  static void vcpu_syscall_ret(qemu_plugin_id_t id, unsigned int vcpu_idx,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

