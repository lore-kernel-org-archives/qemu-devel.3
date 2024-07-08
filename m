Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6D0C3DA41
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 19:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQtpo-0006nJ-Fc; Mon, 08 Jul 2024 15:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sQtpm-0006mQ-4i
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 15:15:34 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sQtpd-0001od-OZ
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 15:15:33 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a77cb7c106dso405566066b.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 12:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720466122; x=1721070922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wcrptL04BKRflAvMf9sPZoMgfsdGkrjP7Nk2XAMTltA=;
 b=rOUTK2MAS+uRC5MbIiDSMynRzT7VD8cPoOgSW+z3l5HIMYgwEz7usns9jUQceraNyP
 soEiNR/DimgD34nGqEpOQNvOG2Qfhf2z2H1MrTM+N8jWa2WPtlg4j/zNEbw9LTrYjejo
 zLsfqjH0YtFxRfd2bl+28b9G+nLahXfOyfLzwy1LgW0s5ZIPHeL5RAYr6zZJUT1AufBJ
 jfUvksBAOo+I/TN/S2cDMp0atjuDWld7bkHNYtta0BjydT/6TVGQZTgQeKB0g6iXDc7x
 PCGmt4bujfWv7XTpHQBnSlEswwkxdv/7tghwigUaX2CWFGu7jpvbUNVdp+RLzTTUMVOI
 moiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720466122; x=1721070922;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wcrptL04BKRflAvMf9sPZoMgfsdGkrjP7Nk2XAMTltA=;
 b=IVQ6jEfSpdWV+5qlSbe+ubOxQ34z3XR16RH/gtx6X00a4bw6Sw7pcoa+b2BndbNziX
 7tG7RB/8gNe+w4Jh8lYyQjIWyQWbiXBoD3wA8vPrUewExdl61XAExysodUKb5zYqY/cj
 sl5/h5zy2XWoY8iYzAj20+kgJdLTce+gdGnUnPXw3RErndSZ823lzHvsBsiFSZ1HOeTX
 gwm809CGK7EZfI0yYWbvwRnXftfVHOofzIvSVKtto+HeEcHREFnWCPx8Tv19peXda9ct
 4qexu6gdWdvx9mOw+xbtijxJYzeabHjGj6YL5I4MA0JwNYTIwPIl1Z0HPPmruGlgaXgb
 cPvg==
X-Gm-Message-State: AOJu0YyEO55TNnrP6knfEb8oioGrd8LdakWftAsUDR7GXU1WAvwxIwp4
 /ZZUcnfiicpdrjRhS4U7FsuIpnP7IllTOhPFVjzQuOz351pdwYsxnPf281C7wj8=
X-Google-Smtp-Source: AGHT+IHMh0shNrzLOsUScCj2fpDO5pXDxRe/n/M0mfp/5OX/5fvGmgUPlEfe3tG6P15L0oHHc1YNBw==
X-Received: by 2002:a17:907:7e83:b0:a72:80b8:ba64 with SMTP id
 a640c23a62f3a-a780b6b20b0mr32472066b.25.1720466121870; 
 Mon, 08 Jul 2024 12:15:21 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a855eb9sm16667466b.151.2024.07.08.12.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 12:15:21 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 83A2D5F8CC;
 Mon,  8 Jul 2024 20:15:20 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Eduardo Habkost
 <eduardo@habkost.net>,  Yanan Wang <wangyanan55@huawei.com>,  Xingtao Yao
 <yaoxt.fnst@fujitsu.com>
Subject: Re: [PATCH v6 7/7] tests/tcg/x86_64: add test for plugin memory access
In-Reply-To: <20240706191335.878142-8-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Sat, 6 Jul 2024 12:13:35 -0700")
References: <20240706191335.878142-1-pierrick.bouvier@linaro.org>
 <20240706191335.878142-8-pierrick.bouvier@linaro.org>
Date: Mon, 08 Jul 2024 20:15:20 +0100
Message-ID: <87zfqrsnjr.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Add an explicit test to check expected memory values are read/written.
> For sizes 8, 16, 32, 64 and 128, we generate a load/store operation.
> For size 8 -> 64, we generate an atomic __sync_val_compare_and_swap too.
> For 128bits memory access, we rely on SSE2 instructions.
>
> By default, atomic accesses are non atomic if a single cpu is running,
> so we force creation of a second one by creating a new thread first.
>
> load/store helpers code path can't be triggered easily in user mode (no
> softmmu), so we can't test it here.
>
> Can be run with:
> make -C build/tests/tcg/x86_64-linux-user run-plugin-test-plugin-mem-acce=
ss-with-libmem.so
>
> Tested-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  tests/tcg/x86_64/test-plugin-mem-access.c   | 89 +++++++++++++++++++++
>  tests/tcg/x86_64/Makefile.target            |  7 ++
>  tests/tcg/x86_64/check-plugin-mem-access.sh | 48 +++++++++++
>  3 files changed, 144 insertions(+)
>  create mode 100644 tests/tcg/x86_64/test-plugin-mem-access.c
>  create mode 100755 tests/tcg/x86_64/check-plugin-mem-access.sh
>
> diff --git a/tests/tcg/x86_64/test-plugin-mem-access.c b/tests/tcg/x86_64=
/test-plugin-mem-access.c
> new file mode 100644
> index 00000000000..7fdd6a55829
> --- /dev/null
> +++ b/tests/tcg/x86_64/test-plugin-mem-access.c
> @@ -0,0 +1,89 @@
> +#include <emmintrin.h>
> +#include <pthread.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +
> +static void *data;
> +
> +#define DEFINE_STORE(name, type, value) \
> +static void store_##name(void)          \
> +{                                       \
> +    *((type *)data) =3D value;            \
> +}
> +
> +#define DEFINE_ATOMIC_OP(name, type, value)                 \
> +static void atomic_op_##name(void)                          \
> +{                                                           \
> +    *((type *)data) =3D 0x42;                                 \
> +    __sync_val_compare_and_swap((type *)data, 0x42, value); \

Should we exercise the other compare and swap ops? Do they all come
through the same rwm path?

> +}
> +
> +#define DEFINE_LOAD(name, type)                         \
> +static void load_##name(void)                           \
> +{                                                       \
> +    register type var asm("eax") =3D *((type *) data);    \
> +    (void)var;                                          \

This is a bit weird. It's the only inline asm needed that makes this a
non-multiarch test. Why?

> +}
> +
> +DEFINE_STORE(u8, uint8_t, 0xf1)
> +DEFINE_ATOMIC_OP(u8, uint8_t, 0xf1)
> +DEFINE_LOAD(u8, uint8_t)
> +DEFINE_STORE(u16, uint16_t, 0xf123)
> +DEFINE_ATOMIC_OP(u16, uint16_t, 0xf123)
> +DEFINE_LOAD(u16, uint16_t)
> +DEFINE_STORE(u32, uint32_t, 0xff112233)
> +DEFINE_ATOMIC_OP(u32, uint32_t, 0xff112233)
> +DEFINE_LOAD(u32, uint32_t)
> +DEFINE_STORE(u64, uint64_t, 0xf123456789abcdef)
> +DEFINE_ATOMIC_OP(u64, uint64_t, 0xf123456789abcdef)
> +DEFINE_LOAD(u64, uint64_t)
> +
> +static void store_u128(void)
> +{
> +    _mm_store_si128(data, _mm_set_epi32(0xf1223344, 0x55667788,
> +                                        0xf1234567, 0x89abcdef));
> +}
> +
> +static void load_u128(void)
> +{
> +    __m128i var =3D _mm_load_si128(data);
> +    (void)var;
> +}
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
> +    data =3D malloc(sizeof(__m128i));
> +    atomic_op_u8();
> +    store_u8();
> +    load_u8();
> +
> +    atomic_op_u16();
> +    store_u16();
> +    load_u16();
> +
> +    atomic_op_u32();
> +    store_u32();
> +    load_u32();
> +
> +    atomic_op_u64();
> +    store_u64();
> +    load_u64();
> +
> +    store_u128();
> +    load_u128();
> +
> +    free(data);
> +}
> diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile=
.target
> index eda9bd7396c..3edc29b924d 100644
> --- a/tests/tcg/x86_64/Makefile.target
> +++ b/tests/tcg/x86_64/Makefile.target
> @@ -16,6 +16,7 @@ X86_64_TESTS +=3D noexec
>  X86_64_TESTS +=3D cmpxchg
>  X86_64_TESTS +=3D adox
>  X86_64_TESTS +=3D test-1648
> +PLUGINS_TESTS +=3D test-plugin-mem-access
>  TESTS=3D$(MULTIARCH_TESTS) $(X86_64_TESTS) test-x86_64
>  else
>  TESTS=3D$(MULTIARCH_TESTS)
> @@ -26,6 +27,12 @@ adox: CFLAGS=3D-O2
>  run-test-i386-ssse3: QEMU_OPTS +=3D -cpu max
>  run-plugin-test-i386-ssse3-%: QEMU_OPTS +=3D -cpu max
>=20=20
> +run-plugin-test-plugin-mem-access-with-libmem.so: \
> +	PLUGIN_ARGS=3D$(COMMA)print-accesses=3Dtrue
> +run-plugin-test-plugin-mem-access-with-libmem.so: \
> +	CHECK_PLUGIN_OUTPUT_COMMAND=3D \
> +	$(SRC_PATH)/tests/tcg/x86_64/check-plugin-mem-access.sh
> +
>  test-x86_64: LDFLAGS+=3D-lm -lc
>  test-x86_64: test-i386.c test-i386.h test-i386-shift.h test-i386-muldiv.h
>  	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
> diff --git a/tests/tcg/x86_64/check-plugin-mem-access.sh b/tests/tcg/x86_=
64/check-plugin-mem-access.sh
> new file mode 100755
> index 00000000000..163f1cfad34
> --- /dev/null
> +++ b/tests/tcg/x86_64/check-plugin-mem-access.sh
> @@ -0,0 +1,48 @@
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
> +    cat << EOF
> +,store_u8,.*,8,store,0xf1
> +,atomic_op_u8,.*,8,load,0x42
> +,atomic_op_u8,.*,8,store,0xf1
> +,load_u8,.*,8,load,0xf1
> +,store_u16,.*,16,store,0xf123
> +,atomic_op_u16,.*,16,load,0x0042
> +,atomic_op_u16,.*,16,store,0xf123
> +,load_u16,.*,16,load,0xf123
> +,store_u32,.*,32,store,0xff112233
> +,atomic_op_u32,.*,32,load,0x00000042
> +,atomic_op_u32,.*,32,store,0xff112233
> +,load_u32,.*,32,load,0xff112233
> +,store_u64,.*,64,store,0xf123456789abcdef
> +,atomic_op_u64,.*,64,load,0x0000000000000042
> +,atomic_op_u64,.*,64,store,0xf123456789abcdef
> +,load_u64,.*,64,load,0xf123456789abcdef
> +,store_u128,.*,128,store,0xf122334455667788f123456789abcdef
> +,load_u128,.*,128,load,0xf122334455667788f123456789abcdef
> +EOF
> +}
> +
> +expected | while read line; do
> +    check "$plugin_out" "$line"
> +done

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

