Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC19C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 09:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raub7-0004O1-1v; Fri, 16 Feb 2024 04:33:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1raub6-0004Na-9j
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 04:33:32 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1raub4-0000TG-EZ
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 04:33:32 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33d222fc113so108889f8f.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 01:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708076008; x=1708680808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cDwx8cHmUAprG0o8fmiY/9SFpfETsq44jX6E19jV6G8=;
 b=zCQiby2t+U5uInHDm2rBfRiKFlEm1QoIfZlt8s1svbds0XcndWy++FaYA/nT5BCNDT
 TrEJUWNRzXagGp5u+MMNIc8ozdXSmkRuhAKNwCtA1rdBf2STKFPZ6G5Er4qTXLMDVdgh
 5uGqMLVHm65dYdOODVPI/UD3fUI8Rb1W0PMQCybqDHrDXYwvTJdchLdei6RLxiv8cTZ5
 tCPPtLB2ndZfdZmu0hkWOsB1P0AAPdK+YPY2xM6/wgou1jbR12IJeYwKvfw/UITXCbVk
 xM8fdQPcAHKXr6t+1wxMfY3aQIk+TsPnQ5DVA2nECukCyDD/V5v4K8SNclqsh05vPvuq
 VqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708076008; x=1708680808;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cDwx8cHmUAprG0o8fmiY/9SFpfETsq44jX6E19jV6G8=;
 b=WbfbSYTH0kRzy7OVEVwNbI26u1ojbF6gfK5k8mkDRi8zqcdYb9P01hRbsAqYC73PCc
 4sC5k+ON8y75ZtqHq6KRW5BCZj0zV9cYuuNFHxpR64hJSauiIYuiFdagRZyT9v3oNZXW
 nIm+4kWSUF2XstZrSHeTEMwkb8EsdJp2kEd/3ETfQbbl7t2nWEa7AT6sRfEDroSIIEYM
 gTcma1DT/fMmngE7L9kt+oIfwAjZn3hzr1o7PmLb7uDfFf9ThRf7GOn2UivPhGWqbPu4
 rzvyrYla6zDVJ56uTcTIEGz/BOJUfNndIizK6NJ4oc0uipMSLdhNsEe51NkekRCuCkKT
 R8GQ==
X-Gm-Message-State: AOJu0Yx7NqAUHJEGO4soFqVI7dGY2mfeBn6i1VU/uYENORdolhXvulMB
 nXWJtjfV4gDJM7tswPEpYW6W2c6H5uJwJie6ZJR0uosYplvZ6lPW0utIO6H3hwc=
X-Google-Smtp-Source: AGHT+IGNxlvWwd06AUmS6AflFP/l3GkQSDBHnW42pQObJCJzQYQM98vXaCgzwaSajjepvjQf0wozkw==
X-Received: by 2002:adf:e945:0:b0:33b:5979:b92b with SMTP id
 m5-20020adfe945000000b0033b5979b92bmr3351212wrn.1.1708076008044; 
 Fri, 16 Feb 2024 01:33:28 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 f9-20020adff8c9000000b0033ce40eee9fsm1650930wrq.58.2024.02.16.01.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 01:33:26 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 30F535F7B1;
 Fri, 16 Feb 2024 09:33:26 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  amonakov@ispras.ru,  mmromanov@ispras.ru
Subject: Re: [RFC PATCH v4 10/10] util/bufferiszero: Add sve acceleration
 for aarch64
In-Reply-To: <20240215081449.848220-11-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 14 Feb 2024 22:14:49 -1000")
References: <20240215081449.848220-1-richard.henderson@linaro.org>
 <20240215081449.848220-11-richard.henderson@linaro.org>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Fri, 16 Feb 2024 09:33:26 +0000
Message-ID: <87frxs69eh.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>
> RFC because I've not benchmarked this on real hw, only run it
> through qemu for validation.

I think we have an a64fx is the TCWG lab you could probably run the
tests on if you want. Otherwise I might be able to spin up a Graviton
on AWS to run a measurement. Do we have a benchmark test to run?

>
> ---
>  host/include/aarch64/host/cpuinfo.h |  1 +
>  util/bufferiszero.c                 | 49 +++++++++++++++++++++++++++++
>  util/cpuinfo-aarch64.c              |  1 +
>  meson.build                         | 13 ++++++++
>  4 files changed, 64 insertions(+)
>
> diff --git a/host/include/aarch64/host/cpuinfo.h b/host/include/aarch64/h=
ost/cpuinfo.h
> index fe671534e4..b4b816cd07 100644
> --- a/host/include/aarch64/host/cpuinfo.h
> +++ b/host/include/aarch64/host/cpuinfo.h
> @@ -12,6 +12,7 @@
>  #define CPUINFO_AES             (1u << 3)
>  #define CPUINFO_PMULL           (1u << 4)
>  #define CPUINFO_BTI             (1u << 5)
> +#define CPUINFO_SVE             (1u << 6)
>=20=20
>  /* Initialized with a constructor. */
>  extern unsigned cpuinfo;
> diff --git a/util/bufferiszero.c b/util/bufferiszero.c
> index 2809b09225..af64c9c224 100644
> --- a/util/bufferiszero.c
> +++ b/util/bufferiszero.c
> @@ -270,13 +270,62 @@ static bool buffer_is_zero_simd(const void *buf, si=
ze_t len)
>      return vaddvq_u32(vceqzq_u32(t0)) =3D=3D -4;
>  }
>=20=20
> +#ifdef CONFIG_SVE_OPT
> +#include <arm_sve.h>
> +
> +#ifndef __ARM_FEATURE_SVE
> +__attribute__((target("+sve")))
> +#endif
> +static bool buffer_is_zero_sve(const void *buf, size_t len)
> +{
> +    svbool_t p, t =3D svptrue_b8();
> +    size_t i, n;
> +
> +    /*
> +     * For the first vector, align to 16 -- reading 1 to 256 bytes.
> +     * Note this routine is only called with len >=3D 256, which is the
> +     * architectural maximum vector length: the first vector always fits.
> +     */
> +    i =3D 0;
> +    n =3D QEMU_ALIGN_PTR_DOWN(buf + svcntb(), 16) - buf;
> +    p =3D svwhilelt_b8(i, n);
> +
> +    do {
> +        svuint8_t d =3D svld1_u8(p, buf + i);
> +
> +        p =3D svcmpne_n_u8(t, d, 0);
> +        if (unlikely(svptest_any(t, p))) {
> +            return false;
> +        }
> +        i +=3D n;
> +        n =3D svcntb();
> +        p =3D svwhilelt_b8(i, len);
> +    } while (svptest_any(t, p));
> +
> +    return true;
> +}
> +#endif /* CONFIG_SVE_OPT */
> +
>  static biz_accel_fn const accel_table[] =3D {
>      buffer_is_zero_int_ge256,
>      buffer_is_zero_simd,
> +#ifdef CONFIG_SVE_OPT
> +    buffer_is_zero_sve,
> +#endif
>  };
>=20=20
> +#ifdef CONFIG_SVE_OPT
> +static unsigned accel_index;
> +static void __attribute__((constructor)) init_accel(void)
> +{
> +    accel_index =3D (cpuinfo & CPUINFO_SVE ? 2 : 1);
> +    buffer_is_zero_accel =3D accel_table[accel_index];
> +}
> +#define INIT_ACCEL NULL
> +#else
>  static unsigned accel_index =3D 1;
>  #define INIT_ACCEL buffer_is_zero_simd
> +#endif /* CONFIG_SVE_OPT */
>=20=20
>  bool test_buffer_is_zero_next_accel(void)
>  {
> diff --git a/util/cpuinfo-aarch64.c b/util/cpuinfo-aarch64.c
> index 4c8a005715..a1e22ea66e 100644
> --- a/util/cpuinfo-aarch64.c
> +++ b/util/cpuinfo-aarch64.c
> @@ -61,6 +61,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>      info |=3D (hwcap & HWCAP_USCAT ? CPUINFO_LSE2 : 0);
>      info |=3D (hwcap & HWCAP_AES ? CPUINFO_AES : 0);
>      info |=3D (hwcap & HWCAP_PMULL ? CPUINFO_PMULL : 0);
> +    info |=3D (hwcap & HWCAP_SVE ? CPUINFO_SVE : 0);
>=20=20
>      unsigned long hwcap2 =3D qemu_getauxval(AT_HWCAP2);
>      info |=3D (hwcap2 & HWCAP2_BTI ? CPUINFO_BTI : 0);
> diff --git a/meson.build b/meson.build
> index c1dc83e4c0..89a8241bc0 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2822,6 +2822,18 @@ config_host_data.set('CONFIG_ARM_AES_BUILTIN', cc.=
compiles('''
>      void foo(uint8x16_t *p) { *p =3D vaesmcq_u8(*p); }
>    '''))
>=20=20
> +config_host_data.set('CONFIG_SVE_OPT', cc.compiles('''
> +    #include <arm_sve.h>
> +    #ifndef __ARM_FEATURE_SVE
> +    __attribute__((target("+sve")))
> +    #endif
> +    void foo(void *p) {
> +        svbool_t t =3D svptrue_b8();
> +        svuint8_t d =3D svld1_u8(t, p);
> +        svptest_any(t, svcmpne_n_u8(t, d, 0));
> +    }
> +  '''))
> +
>  have_pvrdma =3D get_option('pvrdma') \
>    .require(rdma.found(), error_message: 'PVRDMA requires OpenFabrics lib=
raries') \
>    .require(cc.compiles(gnu_source_prefix + '''
> @@ -4232,6 +4244,7 @@ summary_info +=3D {'memory allocator':  get_option(=
'malloc')}
>  summary_info +=3D {'avx2 optimization': config_host_data.get('CONFIG_AVX=
2_OPT')}
>  summary_info +=3D {'avx512bw optimization': config_host_data.get('CONFIG=
_AVX512BW_OPT')}
>  summary_info +=3D {'avx512f optimization': config_host_data.get('CONFIG_=
AVX512F_OPT')}
> +summary_info +=3D {'sve optimization': config_host_data.get('CONFIG_SVE_=
OPT')}
>  summary_info +=3D {'gcov':              get_option('b_coverage')}
>  summary_info +=3D {'thread sanitizer':  get_option('tsan')}
>  summary_info +=3D {'CFI support':       get_option('cfi')}

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

