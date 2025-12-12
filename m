Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF27D59D77
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 16:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU5Zx-00073R-RN; Fri, 12 Dec 2025 11:01:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vU5Zv-00072Y-4i
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 11:01:11 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vU5Zl-0005D9-KI
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 11:01:07 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-477b5e0323bso6339475e9.0
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 08:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765555258; x=1766160058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mUVGZsQCAC+5l1p+jDrAr76eaAw5UNU5hbxAfGIhxyI=;
 b=EbW7LtmouS7F0F46vDxNqQv/DMOdid94bPKviSRqPTle7oWMN/gYejt3LZDMvQLKfR
 EBG+r49jYJ7mJu4dLaEJCXjIsPEbCxjdQ9B0izc+KbhihajC6g/36w1qyFFXtGHdZsDO
 Nl0gVHOJK3Z9bOwfu/q0QYyOuiReBoRTAYv6xx29d4Od5bXzw2grsbYaFttsPTaHJS1U
 sXizlCphhCsWUKfkuWuSlbNy+sBJhFHwtdzanxjOcHb8xHIsWRomevd5UraQa05DnSxw
 vO7jXok2LtIKXfXarmj4ghxuizfob6eXLMIr30tNWwaSMIdJGRjUkbeH79fE+PncjlpC
 YRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765555258; x=1766160058;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mUVGZsQCAC+5l1p+jDrAr76eaAw5UNU5hbxAfGIhxyI=;
 b=JGUzJWsrBkuJc1uVN4BK6XcPzTmnxtPAsNQn3JBajGXMhFrowKJVpdIiZcu35RLuOl
 O0JJFjFhoSrPqIRQ8oNHyl0pvNuIsZlzRaQ51eCpauURGhrPNooOA7rs1gVHlyvAyIrB
 k5ry6udNh3IwgzIlAuMDGZeTurs0CHp4ythfHkI2zUW6fRrz61z6UEzD3K3J52JAlzP5
 XjrAG18XATi8aKzPCAUqsJikUjuV9E3XeKfPl5Z/KNjAQBzKni/wG401H2CXTZ7wsM+o
 9y54isdp3nZNNGsQGwvV9tjLlwZXAMkPHCTy4ef02NS9Qy01mVmRlAgrX4+tTt410X6h
 Sx2g==
X-Gm-Message-State: AOJu0YzaNESyNJIwPbNklkjIgQ/mWMlYlmAeiJNyV2BQtO1zVR5eOTlO
 rfh71ebUuZrI3WBiPkDEmecQnq6Fgsm0Jl8iMen/3ZF5rveSecq5jQGp7gglHFNFVjM=
X-Gm-Gg: AY/fxX4ZoWblWKnqhgCxWPoSg9KTsYJ3mKoDjbcUEa8hsdUz3tfwHBVNIzasPOwnUYc
 UbErvqwhIk+DlucgOJVKLGK1x0paOM7nX0aVkUrPTrUJVxyMbrQLQwAZjhjGAyHM5UlBvE26uZ3
 esfnvDDZyDUCByYe+/hngtK5A0TaoVF5jzqkVCHH8/UL7STCEQRIIkWJqZJgtFWYxr4/u0rNho7
 oAxEdiT+yLRZJel8K/0S6tsFIhGSl+cXeWtKtvNXQ3RNLZ1BBQEHLSEEtkfHBPUg5PtNB1+O3v5
 x3oDwXPvaUhlhP8AYHfuQQniLDAVGcVgOvfVXakUXkjaq0d24yQOb9sudysxK4whaZPhgsiHeuf
 nhWXSIJZX+TgtwXjTYcJQpR7DYFLhBWA2ITgv542X4VPUD99AIk8XZalDzDBHD58Kp0HxwabGly
 G8ZZqMxvMxSmA=
X-Google-Smtp-Source: AGHT+IFKBkWQ7DLS1juk8iMrxAD5cv9eoGTzVhLdwEtRRMXOxfm6B0NPQHJVPRgCi3TtL3Mih6RgLQ==
X-Received: by 2002:a05:600c:6208:b0:46f:a2ba:581f with SMTP id
 5b1f17b1804b1-47a8f2c9fa3mr29093235e9.16.1765555258168; 
 Fri, 12 Dec 2025 08:00:58 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f4f424bsm38294935e9.10.2025.12.12.08.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 08:00:57 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BE9595F82E;
 Fri, 12 Dec 2025 16:00:55 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ziyang Zhang <functioner@sjtu.edu.cn>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,  Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Zhengwei Qi <qizhwei@sjtu.edu.cn>,  Yun
 Wang <yunwang94@sjtu.edu.cn>,  Mingyuan Xia <xiamy@ultrarisc.com>,
 Kailiang Xu <xukl2019@sjtu.edu.cn>
Subject: Re: [PATCH v2 2/2] tcg tests: add a test to verify the syscall
 filter plugin API
In-Reply-To: <20251212141541.1792111-3-functioner@sjtu.edu.cn> (Ziyang Zhang's
 message of "Fri, 12 Dec 2025 22:15:41 +0800")
References: <20251212141541.1792111-1-functioner@sjtu.edu.cn>
 <20251212141541.1792111-3-functioner@sjtu.edu.cn>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Fri, 12 Dec 2025 16:00:55 +0000
Message-ID: <87ldj7sn9k.fsf@draig.linaro.org>
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

Ziyang Zhang <functioner@sjtu.edu.cn> writes:

> Register a syscall filter callback in tests/tcg/plugins/sycall.c,
> returns a specific value for a magic system call number, and check
> it in tests/tcg/multiarch/test-plugin-syscall-filter.c.
>
> Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
> Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
> ---
>  tests/tcg/multiarch/Makefile.target           |  4 +++-
>  .../multiarch/test-plugin-syscall-filter.c    | 20 +++++++++++++++++++
>  tests/tcg/plugins/syscall.c                   | 15 ++++++++++++++
>  3 files changed, 38 insertions(+), 1 deletion(-)
>  create mode 100644 tests/tcg/multiarch/test-plugin-syscall-filter.c
>
> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Ma=
kefile.target
> index f5b4d2b813..4005e3a8a9 100644
> --- a/tests/tcg/multiarch/Makefile.target
> +++ b/tests/tcg/multiarch/Makefile.target
> @@ -202,8 +202,10 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
>  	CHECK_PLUGIN_OUTPUT_COMMAND=3D \
>  	$(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
>  	$(QEMU) $<
> +run-plugin-test-plugin-syscall-filter-with-libsyscall.so:
>=20=20
> -EXTRA_RUNS_WITH_PLUGIN +=3D run-plugin-test-plugin-mem-access-with-libme=
m.so
> +EXTRA_RUNS_WITH_PLUGIN +=3D run-plugin-test-plugin-mem-access-with-libme=
m.so \
> +			   			  run-plugin-test-plugin-syscall-filter-with-libsyscall.so
>  endif
>=20=20
>  # Update TESTS
> diff --git a/tests/tcg/multiarch/test-plugin-syscall-filter.c b/tests/tcg=
/multiarch/test-plugin-syscall-filter.c
> new file mode 100644
> index 0000000000..cc694e0a71
> --- /dev/null
> +++ b/tests/tcg/multiarch/test-plugin-syscall-filter.c
> @@ -0,0 +1,20 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This test attempts to execute a magic syscall. The syscall test plugin
> + * should intercept this and returns an expected value.
> + */
> +
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +int main(int argc, char *argv[]) {
> +    long ret =3D syscall(0x66CCFF);
> +    if (ret !=3D 0xFFCC66) {
> +        perror("ERROR: syscall returned unexpected value!!!");
> +        return EXIT_FAILURE;
> +    }
> +    return EXIT_SUCCESS;
> +}

  This breaks some arches:

  (gdb) r
  Starting program: /home/alex/lsrc/qemu.git/builds/sanitisers/qemu-arm -pl=
ugin tests/tcg/plugins/libsyscall.so -d plugin ./tests/tcg/arm-linux-user/t=
est-plugin-syscall-filter
  [New Thread 0x7ffff37ff6c0 (LWP 63692)]=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  qemu: uncaught target signal 4 (Illegal instruction) - core dumped
  syscall no.  calls  errors
  45           5      0
  338          1      1
  256          1      0
  191          1      0
  398          1      1
  125          1      0
  384          1      0
  332          1      0

  Thread 1 "qemu-arm" received signal SIGILL, Illegal instruction.
  Download failed: Invalid argument.  Continuing without source file ./nptl=
/../sysdeps/unix/sysv/linux/x86_64/syscall_cancel.S.
  __syscall_cancel_arch () at ../sysdeps/unix/sysv/linux/x86_64/syscall_can=
cel.S:56
  warning: 56     ../sysdeps/unix/sysv/linux/x86_64/syscall_cancel.S: No su=
ch file or directory
  (gdb) bt
  #0  __syscall_cancel_arch () at ../sysdeps/unix/sysv/linux/x86_64/syscall=
_cancel.S:56
  #1  0x00007ffff6a51668 in __internal_syscall_cancel (a1=3D<optimized out>=
, a2=3Da2@entry=3D8, a3=3Da3@entry=3D0, a4=3Da4@entry=3D0, a5=3Da5@entry=3D=
0, a6=3Da6@entry=3D0, nr=3D130)
      at ./nptl/cancellation.c:49
  #2  0x00007ffff6a516ad in __syscall_cancel (a1=3D<optimized out>, a2=3Da2=
@entry=3D8, a3=3Da3@entry=3D0, a4=3Da4@entry=3D0, a5=3Da5@entry=3D0, a6=3Da=
6@entry=3D0, nr=3D130)
      at ./nptl/cancellation.c:75
  #3  0x00007ffff6a0207d in __GI___sigsuspend (set=3D<optimized out>) at ..=
/sysdeps/unix/sysv/linux/sigsuspend.c:26
  #4  0x0000555555a49b80 in die_with_signal (host_sig=3D4) at ../../linux-u=
ser/signal.c:807
  #5  0x0000555555a49ed0 in dump_core_and_abort (env=3D0x532000004300, targ=
et_sig=3D4) at ../../linux-user/signal.c:847
  #6  0x0000555555a4c969 in handle_pending_signal (cpu_env=3D0x532000004300=
, sig=3D4, k=3D0x5250000029d0) at ../../linux-user/signal.c:1306
  #7  0x0000555555a4d0e5 in process_pending_signals (cpu_env=3D0x5320000043=
00) at ../../linux-user/signal.c:1386
  #8  0x0000555555873930 in cpu_loop (env=3D0x532000004300) at ../../linux-=
user/arm/cpu_loop.c:479
  #9  0x0000555555a3eca7 in main (argc=3D6, argv=3D0x7fffffffe588, envp=3D0=
x7fffffffe5c0) at ../../linux-user/main.c:1035
  (gdb)=20

> \ No newline at end of file
> diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
> index 42801f5c86..1323e18bc0 100644
> --- a/tests/tcg/plugins/syscall.c
> +++ b/tests/tcg/plugins/syscall.c
> @@ -170,6 +170,20 @@ static void vcpu_syscall_ret(qemu_plugin_id_t id, un=
signed int vcpu_idx,
>      }
>  }
>=20=20
> +static bool vcpu_syscall_filter(qemu_plugin_id_t id, unsigned int vcpu_i=
ndex,
> +                                int64_t num, uint64_t a1, uint64_t a2,
> +                                uint64_t a3, uint64_t a4, uint64_t a5,
> +                                uint64_t a6, uint64_t a7, uint64_t a8,
> +                                uint64_t *ret)
> +{
> +    if (num =3D=3D 0x66CCFF) {
> +        *ret =3D 0xFFCC66;
> +        qemu_plugin_outs("syscall 0x66CCFF filtered, ret=3D0xFFCC66\n");
> +        return true;
> +    }
> +    return false;
> +}
> +
>  static void print_entry(gpointer val, gpointer user_data)
>  {
>      SyscallStats *entry =3D (SyscallStats *) val;
> @@ -255,6 +269,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugi=
n_id_t id,
>=20=20
>      qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall);
>      qemu_plugin_register_vcpu_syscall_ret_cb(id, vcpu_syscall_ret);
> +    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter);
>      qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>      return 0;
>  }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

