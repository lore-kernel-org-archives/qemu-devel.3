Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6341DC71135
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 09:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjb4G-0004NY-LW; Thu, 29 Aug 2024 05:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sjb4F-0004N1-Ek
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 05:03:47 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sjb4D-0002Im-B3
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 05:03:47 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-371a13c7c80so975413f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 02:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724922223; x=1725527023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qY9rHgFADcSekzG8gGozAr5nUqGJWu1D+egkBm03DQ4=;
 b=ps0qedHaUohugOhRiOf/XmdqMFnPTtNmma3nBIn52x3rIMOjPQXxQMhCzBl8NjijCV
 J9lyqhljhpcHISge1veIRU5begYbiOyiHRps3u6NN7i/yL+Ogan5KRc8riAf7RJDb1Ql
 np65IcB58u37w+bmKafoy3THt7pa0L9hG1wC7f+Nl0qexfOJHN3P3xHfC432R5taxrmZ
 //4FZwjY7eYU4D9ZuywpasCLBptHWmaDnq9qglcHfSbmFJSCwp6V5m2GWvOCSbUc+mcf
 4dmrL1rZ6XrUPkoNw5gxUWhoaIoik5kLrINNcNm0nyUYPNnIkOmhRl2RsrArBWana6lm
 ezyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724922223; x=1725527023;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qY9rHgFADcSekzG8gGozAr5nUqGJWu1D+egkBm03DQ4=;
 b=rErMBBwOHIiiNAiIz16C96UrQz/zuvQTQgIG0W/3t2wKGKeRkTlKfVJJkY3o0tDLXO
 HmcmHPk2frKC5kJPY7UUSJg+O62xLXxNLQQVrGFxOcvmycdO/KPDQIa+bFC0gP9zlJZQ
 v8bwKVkes6DP4zWtEefZ8HyMnX8q9x86xx7hWcyD7o559adxAppCkMZLeafvUihjP04E
 JdeiiOo2zgvZlRySqfDSt9P2Izz4rcrYhtDSWIh/ZiFGNHjzidp8cPA/QQeMsKWt7UYx
 88EMbn63pXcj5Uoe0/tjl0NHk967lGSdkTHhPp8h71dpf+0yqBuCtaPs5mSEzex6Ysju
 siWQ==
X-Gm-Message-State: AOJu0Yy3iaPvaY4PlFuKN0mhsBTiwLaOEv0xUVp3aJsEPw+Fi+MGnsq8
 T27XdhCZ/+mzH2hcBLYrVvKE9zECcgx19U/460W0+tlSrRkVaIJka8ktRBx19E8=
X-Google-Smtp-Source: AGHT+IHpwANBFx4p/AyTMd5IYZUe6OWAEsZiqszokZ9Xx/vJsmk6Ko0JdPIJrzrFmqQ+17qKhCuHyQ==
X-Received: by 2002:adf:a458:0:b0:368:377a:e8bb with SMTP id
 ffacd0b85a97d-3749c24fee5mr929041f8f.28.1724922222137; 
 Thu, 29 Aug 2024 02:03:42 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba639d633sm43987255e9.19.2024.08.29.02.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 02:03:41 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5E5E75F790;
 Thu, 29 Aug 2024 10:03:40 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Alexandre Iooss <erdnaxe@crans.org>,  Zhao Liu
 <zhao1.liu@intel.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Yanan
 Wang <wangyanan55@huawei.com>,  Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Xingtao Yao
 <yaoxt.fnst@fujitsu.com>
Subject: Re: [PATCH v7 6/6] tests/tcg/multiarch: add test for plugin memory
 access
In-Reply-To: <20240724194708.1843704-7-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Wed, 24 Jul 2024 12:47:08 -0700")
References: <20240724194708.1843704-1-pierrick.bouvier@linaro.org>
 <20240724194708.1843704-7-pierrick.bouvier@linaro.org>
Date: Thu, 29 Aug 2024 10:03:40 +0100
Message-ID: <87jzfz3dlf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Add an explicit test to check expected memory values are read/written.
> 8,16,32 load/store are tested for all arch.
> 64,128 load/store are tested for aarch64/x64.
> atomic operations (8,16,32,64) are tested for x64 only.
>
> By default, atomic accesses are non atomic if a single cpu is running,
> so we force creation of a second one by creating a new thread first.
>
> load/store helpers code path can't be triggered easily in user mode (no
> softmmu), so we can't test it here.
>
> Output of test-plugin-mem-access.c is the list of expected patterns in
> plugin output. By reading stdout, we can compare to plugins output and
> have a multiarch test.
>
> Can be run with:
> make -C build/tests/tcg/$ARCH-linux-user run-plugin-test-plugin-mem-acces=
s-with-libmem.so
>
> Tested-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  tests/tcg/multiarch/test-plugin-mem-access.c  | 175 ++++++++++++++++++
>  tests/tcg/multiarch/Makefile.target           |   7 +
>  .../tcg/multiarch/check-plugin-mem-access.sh  |  30 +++
>  3 files changed, 212 insertions(+)
>  create mode 100644 tests/tcg/multiarch/test-plugin-mem-access.c
>  create mode 100755 tests/tcg/multiarch/check-plugin-mem-access.sh
>
> diff --git a/tests/tcg/multiarch/test-plugin-mem-access.c b/tests/tcg/mul=
tiarch/test-plugin-mem-access.c
> new file mode 100644
> index 00000000000..09d1fa22e35
> --- /dev/null
> +++ b/tests/tcg/multiarch/test-plugin-mem-access.c
> @@ -0,0 +1,175 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Check if we detect all memory accesses expected using plugin API.
> + * Used in conjunction with ./check-plugin-mem-access.sh check script.
> + * Output of this program is the list of patterns expected in plugin out=
put.
> + *
> + * 8,16,32 load/store are tested for all arch.
> + * 64,128 load/store are tested for aarch64/x64.
> + * atomic operations (8,16,32,64) are tested for x64 only.
> + */

It would be nice to build this for the softmmu path as well. I'm not
sure if this can be done with as single source or we need a second test.
I shall have a play.

> +
> +#include <pthread.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#if defined(__x86_64__)
> +#include <emmintrin.h>
> +#elif defined(__aarch64__)
> +#include <arm_neon.h>
> +#endif /* __x86_64__ */
> +
> +static void *data;
> +
> +/* ,store_u8,.*,8,store,0xf1 */
> +#define PRINT_EXPECTED(function, type, value, action)                 \
> +do {                                                                  \
> +    printf(",%s,.*,%d,%s,%s\n",                                       \
> +           #function, (int) sizeof(type) * 8, action, value);         \
> +}                                                                     \
> +while (0)
> +
> +#define DEFINE_STORE(name, type, value)                  \
> +                                                         \
> +static void print_expected_store_##name(void)            \
> +{                                                        \
> +    PRINT_EXPECTED(store_##name, type, #value, "store"); \
> +}                                                        \
> +                                                         \
> +static void store_##name(void)                           \
> +{                                                        \
> +    *((type *)data) =3D value;                             \
> +    print_expected_store_##name();                       \
> +}
> +
> +#define DEFINE_ATOMIC_OP(name, type, value)                    \
> +                                                               \
> +static void print_expected_atomic_op_##name(void)              \
> +{                                                              \
> +    PRINT_EXPECTED(atomic_op_##name, type, "0x0*42", "load");  \
> +    PRINT_EXPECTED(atomic_op_##name, type, #value, "store");   \
> +}                                                              \
> +                                                               \
> +static void atomic_op_##name(void)                             \
> +{                                                              \
> +    *((type *)data) =3D 0x42;                                    \
> +    __sync_val_compare_and_swap((type *)data, 0x42, value);    \
> +    print_expected_atomic_op_##name();                         \
> +}
> +
> +#define DEFINE_LOAD(name, type, value)                  \
> +                                                        \
> +static void print_expected_load_##name(void)            \
> +{                                                       \
> +    PRINT_EXPECTED(load_##name, type, #value, "load");  \
> +}                                                       \
> +                                                        \
> +static void load_##name(void)                           \
> +{                                                       \
> +    type src =3D *((type *) data);                        \
> +    type dest =3D src;                                    \
> +    (void)src, (void)dest;                              \
> +    print_expected_load_##name();                       \
> +}
> +
> +DEFINE_STORE(u8, uint8_t, 0xf1)
> +DEFINE_LOAD(u8, uint8_t, 0xf1)
> +DEFINE_STORE(u16, uint16_t, 0xf123)
> +DEFINE_LOAD(u16, uint16_t, 0xf123)
> +DEFINE_STORE(u32, uint32_t, 0xff112233)
> +DEFINE_LOAD(u32, uint32_t, 0xff112233)
> +
> +#if defined(__x86_64__) || defined(__aarch64__)
> +DEFINE_STORE(u64, uint64_t, 0xf123456789abcdef)
> +DEFINE_LOAD(u64, uint64_t, 0xf123456789abcdef)
> +
> +static void print_expected_store_u128(void)
> +{
> +    PRINT_EXPECTED(store_u128, __int128,
> +                   "0xf122334455667788f123456789abcdef", "store");
> +}
> +
> +static void store_u128(void)
> +{
> +#ifdef __x86_64__
> +    _mm_store_si128(data, _mm_set_epi32(0xf1223344, 0x55667788,
> +                                        0xf1234567, 0x89abcdef));
> +#else
> +    const uint32_t init[4] =3D {0x89abcdef, 0xf1234567, 0x55667788, 0xf1=
223344};
> +    uint32x4_t vec =3D vld1q_u32(init);
> +    vst1q_u32(data, vec);
> +#endif /* __x86_64__ */
> +    print_expected_store_u128();
> +}
> +
> +static void print_expected_load_u128(void)
> +{
> +    PRINT_EXPECTED(load_u128, __int128,
> +                   "0xf122334455667788f123456789abcdef", "load");
> +}
> +
> +static void load_u128(void)
> +{
> +#ifdef __x86_64__
> +    __m128i var =3D _mm_load_si128(data);
> +#else
> +    uint32x4_t var =3D vld1q_u32(data);
> +#endif
> +    (void) var;
> +    print_expected_load_u128();
> +}
> +#endif /* __x86_64__ || __aarch64__ */
> +
> +#if defined(__x86_64__)
> +DEFINE_ATOMIC_OP(u8, uint8_t, 0xf1)
> +DEFINE_ATOMIC_OP(u16, uint16_t, 0xf123)
> +DEFINE_ATOMIC_OP(u32, uint32_t, 0xff112233)
> +DEFINE_ATOMIC_OP(u64, uint64_t, 0xf123456789abcdef)
> +#endif /* __x86_64__ */
> +
> +static void *f(void *p)
> +{
> +    return NULL;
> +}
> +
> +int main(void)
> +{
> +    /*
> +     * We force creation of a second thread to enable cpu flag CF_PARALL=
EL.
> +     * This will generate atomic operations when needed.
> +     */
> +    pthread_t thread;
> +    pthread_create(&thread, NULL, &f, NULL);
> +    pthread_join(thread, NULL);
> +
> +    /* allocate storage up to 128 bits */
> +    data =3D malloc(16);
> +
> +    store_u8();
> +    load_u8();
> +
> +    store_u16();
> +    load_u16();
> +
> +    store_u32();
> +    load_u32();
> +
> +#if defined(__x86_64__) || defined(__aarch64__)
> +    store_u64();
> +    load_u64();
> +
> +    store_u128();
> +    load_u128();
> +#endif /* __x86_64__ || __aarch64__ */
> +
> +#if defined(__x86_64__)
> +    atomic_op_u8();
> +    atomic_op_u16();
> +    atomic_op_u32();
> +    atomic_op_u64();
> +#endif /* __x86_64__ */
> +
> +    free(data);
> +}
> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Ma=
kefile.target
> index 5e3391ec9d2..d90cbd3e521 100644
> --- a/tests/tcg/multiarch/Makefile.target
> +++ b/tests/tcg/multiarch/Makefile.target
> @@ -170,5 +170,12 @@ run-plugin-semiconsole-with-%:
>  TESTS +=3D semihosting semiconsole
>  endif
>=20=20
> +# Test plugin memory access instrumentation
> +run-plugin-test-plugin-mem-access-with-libmem.so: \
> +	PLUGIN_ARGS=3D$(COMMA)print-accesses=3Dtrue
> +run-plugin-test-plugin-mem-access-with-libmem.so: \
> +	CHECK_PLUGIN_OUTPUT_COMMAND=3D \
> +	$(SRC_PATH)/tests/tcg/multiarch/check-plugin-mem-access.sh
> +
>  # Update TESTS
>  TESTS +=3D $(MULTIARCH_TESTS)
> diff --git a/tests/tcg/multiarch/check-plugin-mem-access.sh b/tests/tcg/m=
ultiarch/check-plugin-mem-access.sh
> new file mode 100755
> index 00000000000..909606943bb
> --- /dev/null
> +++ b/tests/tcg/multiarch/check-plugin-mem-access.sh
> @@ -0,0 +1,30 @@
> +#!/usr/bin/env bash
> +
> +set -euo pipefail
> +
> +die()
> +{
> +    echo "$@" 1>&2
> +    exit 1
> +}
> +
> +check()
> +{
> +    file=3D$1
> +    pattern=3D$2
> +    grep "$pattern" "$file" > /dev/null || die "\"$pattern\" not found i=
n $file"
> +}
> +
> +[ $# -eq 1 ] || die "usage: plugin_out_file"
> +
> +plugin_out=3D$1
> +
> +expected()
> +{
> +    ./test-plugin-mem-access ||
> +        die "running test-plugin-mem-access executable failed"

I'm confused by this. We seem to be running the test again and this is
going to fail if binfmt_misc isn't setup (which we don't assume for
running the TCG tests).

> +}
> +
> +expected | while read line; do
> +    check "$plugin_out" "$line"
> +done

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

