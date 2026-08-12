Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7D4C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAzq-0008Qi-1x; Wed, 12 Aug 2026 11:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wuAzo-0008QP-La
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:36:00 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wuAzk-0006Y3-KD
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:35:59 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so7354485e9.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786548953; x=1787153753; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=llRM815yFn9Nb+ooS7CcsPq7Vzh5IA/ViqDAb+/AELg=;
 b=L1WFBVGOYqIHppQEkmeUl9AI0hBQcRapCPxOuaQyrNpbV3qEnjdMuh3b+Vb9PPbYDm
 REc8Um13QTkEbdM1xI7fjxj9/tDdfjdeftRHckR/BDHKXKNBJeF+OT4Khok6cWXifcmf
 K51Dj/6PstR0K3s/c8DctKyqfoGs0ClMHK986kI1U11gRgQdtV0/0OJde2cw7vHt5nPb
 Bv5idKM7s3SfVw5WTsgEzVCqB/FpxyziWKVxh+5v4SD0gJyIq6l38EUp1kNnS2BEb0UI
 If7BUbWAlFV07bALL4futY/9uuUceGKeRyYLYZcFx0QOLzk+6BDlcHQCAY7kn8anSFXH
 ESHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786548953; x=1787153753;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=llRM815yFn9Nb+ooS7CcsPq7Vzh5IA/ViqDAb+/AELg=;
 b=a7WS2Yi5JifTwwWmQZtEofZeJj/TZB7H8HMmEkhsheZlxl4edLZsgQLAe1LzZjPNbl
 k9K/weSXtqqe1z/Xzf3IR0frdAP0TaT0851UWFQSjqtr/5MBjmajSuYYXKU12qoZHjxr
 Sj5VZflBoT1wGlIFiynrUo/JSMtEFx6mCbMzbG0VR5+s4OtDYDefvmj90l0BZCY40YJl
 yi2Q4OVin7b8JAt4rQgZsXQF6izaz0DLSyoH6PzmhnoEanBpkJvI9/AGv2EhKMDIpMjg
 37yNKhAngsc1xaZfLGvOhpBEy6SK5hvd2AQU8lvcrlk8pNDl3hi+bu/pd8cXUdheX5s4
 uopg==
X-Gm-Message-State: AOJu0Yx/NrGcYt+ol0i3FUd6X8bQAxrXumnpIvXsudYAwOIiirjWXx7l
 vCSUzgJ0mVM6d3oVB+zGgN43X3LyL0WQI9ku3M5TyA8vtP00fSi9MQK4F5lhpvqTwno=
X-Gm-Gg: AR+sD122vozi8eLUDP+ogEG9VBRPFBtr9YQiyw5z+ZmfcYjiMtLGeMfjA7q55VK2pNa
 zsSMOPNy/e9xyC2LS+gK+ECE6Z46u7gMocR2AIkA6T4R8Uk6v3T5P8Jywf6K3srnYDGIlo26psh
 WYe04n8k4L8ixzQdu8rVtWn43NBYhBFxxTHVF4PcZVAIP2jeVLa6yC0WS2hwKk2EAIl1NC9Khdb
 C8xfPj3EcyVC8RY3a9ck11anxDi8L8G0KvdjWNfF59E9Uhj0k/3iDta/1Xn+YumchzgEo+7+DgP
 OLPWZfh1DKTLyA8c77Nai6bKB7ggbyFcXFbY6RhwZjsrfEE6smfs7k3sEQiYazqBGy7kl6KLOXv
 oVUsnTsnqjdNvgPuc01OvD0ID1hMKLR38nkGgRcQYGvQN0AJg6uMaGzijhsLGdPQlTiMysB64Hy
 4dRGJ2E3EM5T7c+wQ5cM9uFqiWqrRgb/hP4CPRCbFg7Be5NpnwbQAB6jKF3eQO
X-Received: by 2002:a05:600c:8010:b0:490:e5c1:b8bf with SMTP id
 5b1f17b1804b1-4997c118946mr58566245e9.13.1786548952985; 
 Wed, 12 Aug 2026 08:35:52 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150bf5f1csm8971617f8f.8.2026.08.12.08.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:35:51 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5E2175F886;
 Wed, 12 Aug 2026 16:35:50 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Thomas Huth <thuth@redhat.com>,  Ilya
 Leoshkevich <iii@linux.ibm.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Helge Deller <deller@gmx.de>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v6 047/103] tests/tcg/arm: system tests
In-Reply-To: <20260728044248.137626-48-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Mon, 27 Jul 2026 21:41:51 -0700")
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-48-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.3-pre5; emacs 30.1
Date: Wed, 12 Aug 2026 16:35:50 +0100
Message-ID: <878q6bz6zt.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  tests/tcg/arm/Makefile.softmmu-target | 80 ---------------------------
>  tests/tcg/arm/meson.build             |  2 +
>  tests/tcg/arm/system/meson.build      | 66 ++++++++++++++++++++++
>  3 files changed, 68 insertions(+), 80 deletions(-)
>  delete mode 100644 tests/tcg/arm/Makefile.softmmu-target
>  create mode 100644 tests/tcg/arm/system/meson.build
>
> diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefi=
le.softmmu-target
> deleted file mode 100644
> index b66074b0b43..00000000000
> --- a/tests/tcg/arm/Makefile.softmmu-target
> +++ /dev/null
> @@ -1,80 +0,0 @@
> -# -*- Mode: makefile -*-
> -#
> -# ARM SoftMMU tests - included from tests/tcg/Makefile
> -#
> -
> -ARM_SRC=3D$(SRC_PATH)/tests/tcg/arm/system
> -
> -# Set search path for all sources
> -VPATH 		+=3D $(ARM_SRC)
> -
> -# Specific Test Rules
> -
> -test-armv6m-undef: test-armv6m-undef.S
> -	$(CC) -mcpu=3Dcortex-m0 -mfloat-abi=3Dsoft \
> -		-Wl,--build-id=3Dnone -x assembler-with-cpp \
> -		$< -o $@ -nostdlib -static \
> -		-T $(ARM_SRC)/$@.ld
> -
> -run-test-armv6m-undef: QEMU_OPTS=3D-semihosting-config enable=3Don,targe=
t=3Dnative,chardev=3Doutput -M microbit -kernel
> -
> -ARM_TESTS+=3Dtest-armv6m-undef
> -
> -# These objects provide the basic boot code and helper functions for all=
 tests
> -CRT_OBJS=3Dboot.o
> -
> -ARM_TEST_SRCS=3D$(wildcard $(ARM_SRC)/*.c)
> -ARM_TESTS+=3D$(patsubst $(ARM_SRC)/%.c, %, $(ARM_TEST_SRCS))
> -
> -CRT_PATH=3D$(ARM_SRC)
> -LINK_SCRIPT=3D$(ARM_SRC)/kernel.ld
> -LDFLAGS=3D-Wl,-T$(LINK_SCRIPT)
> -CFLAGS+=3D-nostdlib -ggdb -O0 $(MINILIB_INC)
> -LDFLAGS+=3D-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
> -
> -# building head blobs
> -.PRECIOUS: $(CRT_OBJS)
> -
> -%.o: $(ARM_SRC)/%.S
> -	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -Wa,--noexecstack=
 -c $< -o $@
> -
> -# Build and link the tests
> -%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
> -	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
> -
> -memory: CFLAGS+=3D-DCHECK_UNALIGNED=3D0
> -
> -# Running
> -QEMU_BASE_MACHINE=3D-M virt -cpu max -display none
> -QEMU_OPTS+=3D$(QEMU_BASE_MACHINE) -semihosting-config enable=3Don,target=
=3Dnative,chardev=3Doutput -kernel
> -
> -# console test is manual only
> -QEMU_SEMIHOST=3D-serial none -chardev stdio,mux=3Don,id=3Dstdio0 -semiho=
sting-config enable=3Don,chardev=3Dstdio0 -mon chardev=3Dstdio0,mode=3Dread=
line
> -run-semiconsole: QEMU_OPTS=3D$(QEMU_BASE_MACHINE) $(QEMU_SEMIHOST)  -ker=
nel
> -run-semiconsole: semiconsole
> -	$(call skip-test, $<, "MANUAL ONLY")
> -	$(if $(V),@printf "  %-7s %s %s\n" "TO RUN" $(notdir $(QEMU)) "$(QEMU_O=
PTS) $<")
> -run-plugin-semiconsole-with-%: semiconsole
> -	$(call skip-test, $<, "MANUAL ONLY")
> -
> -# Simple Record/Replay Test
> -.PHONY: memory-record
> -run-memory-record: memory-record memory
> -	$(call run-test, $<, \
> -	  $(QEMU) -monitor none -display none \
> -		  -chardev file$(COMMA)path=3D$<.out$(COMMA)id=3Doutput \
> -		  -icount shift=3D5$(COMMA)rr=3Drecord$(COMMA)rrfile=3Drecord.bin \
> -		  $(QEMU_OPTS) memory)
> -
> -.PHONY: memory-replay
> -run-memory-replay: memory-replay run-memory-record
> -	$(call run-test, $<, \
> -	  $(QEMU) -monitor none -display none \
> -		  -chardev file$(COMMA)path=3D$<.out$(COMMA)id=3Doutput \
> -		  -icount shift=3D5$(COMMA)rr=3Dreplay$(COMMA)rrfile=3Drecord.bin \
> -		  $(QEMU_OPTS) memory)
> -
> -EXTRA_RUNS+=3Drun-memory-replay
> -
> -TESTS +=3D $(ARM_TESTS) $(MULTIARCH_TESTS)
> -EXTRA_RUNS+=3D$(MULTIARCH_RUNS)
> diff --git a/tests/tcg/arm/meson.build b/tests/tcg/arm/meson.build
> index 08a863699fb..1b491cea026 100644
> --- a/tests/tcg/arm/meson.build
> +++ b/tests/tcg/arm/meson.build
> @@ -2,6 +2,8 @@ cc =3D 'arm-linux-gnueabihf-gcc'
>  cc_dockerfile =3D 'debian-all-test-cross'
>  cc_docker_host_arch =3D ['aarch64', 'x86_64']
>=20=20
> +subdir('system')
> +
>  tests =3D []
>=20=20
>  # Multi arch tests
> diff --git a/tests/tcg/arm/system/meson.build b/tests/tcg/arm/system/meso=
n.build
> new file mode 100644
> index 00000000000..d507cf980f6
> --- /dev/null
> +++ b/tests/tcg/arm/system/meson.build
> @@ -0,0 +1,66 @@
> +tests =3D []
> +
> +minilib_dir =3D meson.current_source_dir() / '..' / '..' / 'minilib'
> +minilib_printf =3D files(minilib_dir / 'printf.c')[0]
> +link_script =3D files('kernel.ld')[0]
> +boot =3D files('boot.S')[0]
> +cflags =3D ['-nostdlib',
> +          '-Wa,--noexecstack',
> +          '-I', minilib_dir, minilib_printf, boot,
> +          '-Wl,-T', link_script,
> +          '-lgcc']

Needs to be:

   cflags =3D ['-march=3Darmv7-a+fp',=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20
           '-ffreestanding',=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20
           '-nostdlib',
           ...
=20=20=20=20=20=20=20=20=20=20=20

> +qemu_base_args =3D ['-display', 'none',
> +                  '-semihosting-config', 'enable=3Don',
> +                  '-kernel']
> +qemu_def_args =3D ['-M', 'virt', '-cpu', 'max', qemu_base_args]
> +
> +# Multi arch tests
> +multi_src =3D []
> +foreach t: tcg_tests['multiarch-softmmu']['tests']
> +  foreach src, setup: t
> +    new_cflags =3D cflags
> +    if fs.stem(src) =3D=3D 'memory'
> +      new_cflags +=3D '-DCHECK_UNALIGNED=3D0'
> +    endif
> +    if src not in multi_src
> +      setup +=3D {'cflags': [new_cflags]}
> +      multi_src +=3D src
> +    endif
> +    tests +=3D {src: setup + {'qemu_args': qemu_def_args}}
> +  endforeach
> +endforeach
> +
> +tests +=3D {
> +  'test-armv6m-undef.S': {
> +    'cflags': ['-mcpu=3Dcortex-m0', '-mfloat-abi=3Dsoft', '-nostdlib',
> +               '-T', files('test-armv6m-undef.ld')],
> +    'qemu_args': ['-M', 'microbit', qemu_base_args],
> +  },
> +  'semiconsole.c': {
> +    'cflags': cflags,
> +    'qemu_args': ['-serial', 'none', '-chardev', 'stdio,mux=3Don,id=3Dst=
dio0',
> +                  '-semihosting-config', 'enable=3Don,chardev=3Dstdio0',
> +                  '-mon', 'chardev=3Dstdio0,mode=3Dreadline',
> +                  qemu_def_args],
> +    'wrapper': [prog_run_with_input, 'X']
> +  },
> +  '../../multiarch/system/memory.c': {
> +    'test_name': 'memory-record-replay',
> +    'qemu_args': qemu_def_args,
> +    'wrapper': [prog_record_replay],
> +  },
> +}
> +
> +if 'qemu-system-arm' in emulators
> +  tcg_tests +=3D {
> +    'arm-softmmu': {
> +      'cc': cc,
> +      'cc_dockerfile': cc_dockerfile,
> +      'cc_docker_host_arch': cc_docker_host_arch,
> +      'folder': 'arm/system',
> +      'gdb_arch': 'arm',
> +      'qemu': emulators['qemu-system-arm'],
> +      'tests': tests,
> +    }
> +  }
> +endif

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

