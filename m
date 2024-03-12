Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A51C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk28E-0002nH-C9; Tue, 12 Mar 2024 09:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk280-0002gR-9M
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 09:25:14 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk27q-00007G-T7
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 09:25:11 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5684f95cc9bso4145047a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 06:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710249901; x=1710854701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E6v0SjKGn40ugNQxnVL3Ncx5nthaQ6xiT5d7dlvA7/4=;
 b=VL/TUtTJtAYz5+/l7ETZJxpQZzArMt0URMA3/MPiJsN2kekwfUTWABtMEmohz0O19X
 vaF2Jyima4BB/muAlhMXwLAKzrmL2mh7qbzD1JWlLpqWZAevYJ8uj72uuZ+j/a/AaRpQ
 XBNawIr9XBNznUQhCkVCN0WjvDkAEcNb9GWJ1wYImB8MS9y9BRDqsezch7ep+dTIt7Su
 bxOittSy9PFi9zHqpQUDXy5123GOg/mAtmCLdqdSEoTHFMndbETt6tqUN6+hC7Tsfcqk
 5B7oX6Z45NINFRWfbyWYZgRRFEK6ZKyMbtkbTV3TTSiEzoCzHR5A1Zkhxw9p7vhRnejq
 9tww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710249901; x=1710854701;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E6v0SjKGn40ugNQxnVL3Ncx5nthaQ6xiT5d7dlvA7/4=;
 b=BE3n9rwmY6aTuw8WDaCY6qaJbMDX8POCI6jcfYR6UQfJ7hmaqldWwbymxeFSy3NiME
 JGGz563e4QzP4UPGlLlzmKeDejQJfyiu0cbROdfLCUlPSwVBIMIgnunZUWCRCPa+jfMy
 encCxWODGZwaJFGX3p9oXWHxz5lgxps8mGe9P6NzrfW+8AqobBBj9JB3rEWgUVljZ4Z+
 1orvofrP41N30Cw8oZ1z06ErHjTz4iUEtB9WekK0gUTVVfNGHKK5OQoerj33ucRaTQX+
 kueJkWC3HfRyJG3LH7bhEY0x1owWDvvDMAPZ6K1+VYxBvDSne+7s0fwOuyUHMknloVVr
 HBNQ==
X-Gm-Message-State: AOJu0Yzw31P8eLxJ/0d+hYX7H2+nxMbR4+BH1eHG84x6dYQmxLnqzEuw
 lAiUdQb2Fns95yc9QluLUVeVl4cjz0Qs3BqFqbvnKv+lrKVi5GUdCOOwfN/3p4A=
X-Google-Smtp-Source: AGHT+IGJqs6aTOzTHm6S8575qWDi23vy4wyu8B0tWdY83RaEUZYiaszFT/znAXlprtSePdyPo7A2cA==
X-Received: by 2002:a50:d4de:0:b0:566:13f8:bcc with SMTP id
 e30-20020a50d4de000000b0056613f80bccmr8734751edj.0.1710249900613; 
 Tue, 12 Mar 2024 06:25:00 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ig2-20020a056402458200b005681444bdbcsm3956940edb.7.2024.03.12.06.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 06:25:00 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A239B5F7D9;
 Tue, 12 Mar 2024 13:24:59 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org,  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard
 Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Wainer
 dos Santos Moschetta <wainersm@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>,  Michael Tokarev <mjt@tls.msk.ru>, qemu-ppc@nongnu.org
Subject: Re: [PATCH v4 22/24] target/ppc: fix timebase register reset state
In-Reply-To: <20240311174026.2177152-23-npiggin@gmail.com> (Nicholas Piggin's
 message of "Tue, 12 Mar 2024 03:40:24 +1000")
References: <20240311174026.2177152-1-npiggin@gmail.com>
 <20240311174026.2177152-23-npiggin@gmail.com>
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Tue, 12 Mar 2024 13:24:59 +0000
Message-ID: <87cyrzpopg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Nicholas Piggin <npiggin@gmail.com> writes:

> (H)DEC and PURR get reset before icount does, which causes them to be
> skewed and not match the init state. This can cause replay to not
> match the recorded trace exactly. For DEC and HDEC this is usually not
> noticable since they tend to get programmed before affecting the
> target machine. PURR has been observed to cause replay bugs when
> running Linux.
>
> Fix this by resetting using a time of 0.
>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/ppc/ppc.c         | 11 ++++++++---
>  target/ppc/machine.c |  4 ++++
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index fadb8f5239..f22321779e 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -1112,16 +1112,21 @@ void cpu_ppc_tb_reset(CPUPPCState *env)
>          timer_del(tb_env->hdecr_timer);
>          ppc_set_irq(cpu, PPC_INTERRUPT_HDECR, 0);
>          tb_env->hdecr_next =3D 0;
> +        _cpu_ppc_store_hdecr(cpu, 0, 0, 0, 64);
>      }
>=20=20
>      /*
>       * There is a bug in Linux 2.4 kernels:
>       * if a decrementer exception is pending when it enables msr_ee at s=
tartup,
>       * it's not ready to handle it...
> +     *
> +     * On machine reset, in this is called before icount is reset, so
> +     * for icount-mode, setting TB registers using now=3Dqemu_clock_get_=
ns
> +     * results in them being skewed when icount does get reset. Use an
> +     * explicit 0 to get a consistent reset state.
>       */
> -    cpu_ppc_store_decr(env, -1);
> -    cpu_ppc_store_hdecr(env, -1);
> -    cpu_ppc_store_purr(env, 0x0000000000000000ULL);
> +    _cpu_ppc_store_decr(cpu, 0, 0, -1, 64);
> +    _cpu_ppc_store_purr(env, 0, 0);
>  }
>=20=20
>  void cpu_ppc_tb_free(CPUPPCState *env)
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index 203fe28e01..4c4294eafe 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -215,6 +215,8 @@ static int cpu_pre_save(void *opaque)
>           * it here.
>           */
>          env->spr[SPR_DECR] =3D cpu_ppc_load_decr(env);
> +        printf("cpu_ppc_pre_save  TB:0x%016lx\n", cpu_ppc_load_tbl(env));
> +        printf("cpu_ppc_pre_save DEC:0x%016lx\n",
>  cpu_ppc_load_decr(env));

I think this is left over debug, which btw needs proper types:

  ../../target/ppc/machine.c: In function =E2=80=98cpu_pre_save=E2=80=99:
  ../../target/ppc/machine.c:219:45: error: format =E2=80=98%lx=E2=80=99 ex=
pects argument of type =E2=80=98long unsigned int=E2=80=99, but argument 2 =
has type =E2=80=98target_ulong=E2=80=99 {aka =E2=80=98unsigned int=E2=80=99=
} [-Werror=3Dformat=3D]
    219 |         printf("cpu_ppc_pre_save DEC:0x%016lx\n", cpu_ppc_load_de=
cr(env));
        |                                        ~~~~~^     ~~~~~~~~~~~~~~~=
~~~~~~~
        |                                             |     |
        |                                             |     target_ulong {a=
ka unsigned int}
        |                                             long unsigned int
        |                                        %016x
  ../../target/ppc/machine.c: In function =E2=80=98cpu_post_load=E2=80=99:
  ../../target/ppc/machine.c:339:45: error: format =E2=80=98%lx=E2=80=99 ex=
pects argument of type =E2=80=98long unsigned int=E2=80=99, but argument 2 =
has type =E2=80=98target_ulong=E2=80=99 {aka =E2=80=98unsigned int=E2=80=99=
} [-Werror=3Dformat=3D]
    339 |         printf("cpu_ppc_post_ld  DEC:0x%016lx\n", cpu_ppc_load_de=
cr(env));
        |                                        ~~~~~^     ~~~~~~~~~~~~~~~=
~~~~~~~
        |                                             |     |
        |                                             |     target_ulong {a=
ka unsigned int}
        |                                             long unsigned int
        |                                        %016x
  cc1: all warnings being treated as errors

>      }
>=20=20
>      return 0;
> @@ -333,6 +335,8 @@ static int cpu_post_load(void *opaque, int version_id)
>           * triggered types (including HDEC) would need to carry more sta=
te.
>           */
>          cpu_ppc_store_decr(env, env->spr[SPR_DECR]);
> +        printf("cpu_ppc_post_ld   TB:0x%016lx\n", cpu_ppc_load_tbl(env));
> +        printf("cpu_ppc_post_ld  DEC:0x%016lx\n", cpu_ppc_load_decr(env)=
);
>          pmu_mmcr01_updated(env);
>      }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

