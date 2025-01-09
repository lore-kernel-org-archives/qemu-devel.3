Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BDDE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 12:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVrFx-0004dD-GG; Thu, 09 Jan 2025 07:03:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVrFw-0004cQ-1o
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 07:03:20 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVrFu-0003Je-HC
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 07:03:19 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aab6fa3e20eso160744866b.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 04:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736424197; x=1737028997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TctM9tPlNSHj1T8mh1Qrv+3PKR9QCM9/IuTpKZPwInk=;
 b=g8lIzJycQrsfPSt+BpoCuA1+kayAIX51y5ZgAsvI0OG+L26V0iWqE9Gm8+4Uwds6Y/
 x88BWOBnWwXGHTFhlORDp9vQOm/dcdw+xf8NSPEG5W2zPJR76EN1uO6Nw+xVaI7qBEis
 qqb5zU8RDEQqxzKx7m060xgW0ONb3/MbM9oiercgIWXnjlfjx5FdfzQOHVXYZEXgVXjP
 hfKwYrnIp+45G+xiuhrByKjwyhtqFC6o6pHod0WChxIpdNZvTUXsB0+8KqnhjYdt5FwD
 p4MDQLTFoFrPDcgkSYaw63o0QF3lKXOHlrYgTvO+NtbJbYrqiGiBJzay6tu/IqMCy2+r
 BwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736424197; x=1737028997;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TctM9tPlNSHj1T8mh1Qrv+3PKR9QCM9/IuTpKZPwInk=;
 b=FxY6r6yqhoGS8CmjFNWb0yBqWIDIj4qEN5Du8+N+dpfETi6Cx2mcnNETegA+WzUK/m
 stbn3+R5jSyWWDXQYwOOoBrW2CowFyuWZ2wVuNGdQDj2gzHKPIqn3TebUXxn2f/qgfnt
 k6AkQKu1MQdip3G9PYWUgSp0sLQ98J7bo30SM1ZOo0bh5F+LCnyBLQII+f+oYYQjvEJU
 ewJ87T1Hr9qOqRqtQRk4b1iTMUAwoQn57z1qEZ4tk4neDBVvViD/CJHLVOLJoPeHmtfF
 fS2q7DbGP5O5uS8fDe/wGUvwLoujll7dI6c2T+Fj4zYCcrHLoDnyyhiecLT0weBHsLPK
 heiw==
X-Gm-Message-State: AOJu0YyvU5SiyYaU8lp7XXGxsA/cXVFAn8245HUrAjR5BVLTkN27uFc2
 zmoigmeFBKM6HnVW9j9HcpF87F+THvjZsffUMV1AeEokDY+CZsCPyoGEHmjni1o=
X-Gm-Gg: ASbGncvy3GoKXR3RsFIcqutglRPlJXpCXoYPwy1e7pcFLwOrcRXA8mlMIzCUbudFpbV
 HgZlqgsHDiydLN6aV2Zeg5iodYQAZtxq5+KQrnjmf4ILWPYhG3T6RGscG3tbBAQ2WmhuD4xlWtZ
 SM6IVgOkBC0y2Q9JMIU2daUlizP66wsDXvCvmTH6Tf4dT3X+7dgSpstc+2chGT1gMpqs4srdHCq
 ggnCHHWoTazVX9niKJFUjNUji99lV13rZmpWcTOT+N8ixIIgsK1vpk=
X-Google-Smtp-Source: AGHT+IETd2jD9Fo6dG5ZpsgcI6UirtjdZPwMdndcVO7QEyg932HIWQ1ldPXZ4gQ5s55dIzWVmxSStg==
X-Received: by 2002:a17:906:7956:b0:aac:43e:ffa5 with SMTP id
 a640c23a62f3a-ab2ab6c493bmr500544466b.15.1736424196512; 
 Thu, 09 Jan 2025 04:03:16 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95b72ddsm64578766b.163.2025.01.09.04.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 04:03:15 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 52F8D5F87E;
 Thu,  9 Jan 2025 12:03:14 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Rowan Hart <rowanbhart@gmail.com>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Eduardo Habkost <eduardo@habkost.net>,
 Alexandre Iooss <erdnaxe@crans.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 1/3] Expose gdb_write_register function to consumers
 of gdbstub
In-Reply-To: <20241206102605.961658-2-rowanbhart@gmail.com> (Rowan Hart's
 message of "Fri, 6 Dec 2024 02:26:02 -0800")
References: <20241206102605.961658-1-rowanbhart@gmail.com>
 <20241206102605.961658-2-rowanbhart@gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 09 Jan 2025 12:03:14 +0000
Message-ID: <87plkw8a9p.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
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

Rowan Hart <rowanbhart@gmail.com> writes:

> From: novafacing <rowanbhart@gmail.com>

You need to include Signed-of-by tags for anything to get accepted.

>
> ---
>  gdbstub/gdbstub.c      |  2 +-
>  include/exec/gdbstub.h | 14 ++++++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index b1def7e71d..7d87a3324c 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -536,7 +536,7 @@ int gdb_read_register(CPUState *cpu, GByteArray *buf,=
 int reg)
>      return 0;
>  }
>=20=20
> -static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
> +int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
>  {
>      CPUClass *cc =3D CPU_GET_CLASS(cpu);
>      GDBRegisterState *r;
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index d73f424f56..584ed73fc9 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -118,6 +118,20 @@ const GDBFeature *gdb_find_static_feature(const char=
 *xmlname);
>   */
>  int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
>=20=20
> +/**
> + * gdb_write_register() - Write a register associated with a CPU.
> + * @cpu: The CPU associated with the register.
> + * @buf: The buffer that the register contents will be set to.
> + * @reg: The register's number returned by gdb_find_feature_register().
> + *
> + * The size of @buf must be at least the size of the register being
> + * written.
> + *
> + * Return: The number of written bytes, or 0 if an error occurred (for
> + * example, an unknown register was provided).
> + */
> +int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg);
> +
>  /**
>   * typedef GDBRegDesc - a register description from gdbstub
>   */

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

