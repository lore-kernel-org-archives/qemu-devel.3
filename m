Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CEAD69112
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 14:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGfOp-0004nk-Kp; Thu, 28 Nov 2024 09:21:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tGfOm-0004n8-V7
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 09:21:41 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tGfOk-00020b-42
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 09:21:40 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ffe28c12bdso5036431fa.1
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 06:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732803696; x=1733408496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mXzV769INCFEmjzCnLh8ZWhwThXu0Qb6bYCR7og3els=;
 b=SNLp+0SCyUwdHFBM2Yn5sm4s0dG91/B24ac2dBYjwZMJ4dKptdJjKqFeOE5tHwgZEA
 Si+AdMesufdKo3eWx7f4nVRgrt8aTGGfTITW1c3d4GxfCGlf7PCiwMaPZz+UNEOLdMsI
 nwV5cIuwcRr3UbFt+1Groz2RvlptBU3YljurZ5eku/Ce4t8fPUjtuGAr6vzg0Ki9dq4l
 QHwWCQjhI3IFMvQTH6Ll9l9WBQcArlLHqWkvtEhDnCUz+D9RO8IQqzaViSg06l+0/c70
 KI1sUSoHuQrZ84LwsEihIpG+OuHVXqzxqjm11RR2UA5SN+QXfhmorCusOtuA3LsV+R3q
 qYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732803696; x=1733408496;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mXzV769INCFEmjzCnLh8ZWhwThXu0Qb6bYCR7og3els=;
 b=GO6OYRZHioF5wmG1ayLPkOgfVeCybnP6mqCMzsyCNxG7SHitu6ahtaV8G0+05cq16z
 YrznUttBxINU7DtkTlMyRZITTd1Bm9r6UNYctZWIOW/LRCVJBypGaHUhrTD9EaJzBWu0
 771ZmJ0OMskThcXGNmSwGiUT2oYJt+4QYXsJ+RNOU2OEh8mxoesh+rJQCP/DpRwIjTMP
 uiuItiGYLtYdq7BOnk5s4fKSdTdwNOhigFm60Y9vgzgPMAFMQWP7e7OCsLeQKy9B+urv
 XUIpgpMugWjxQWq3OifFESH0VJvtXUPhkkIuEBG3Dxqy9y5iGsXNGqCOY4HKFPzLM83r
 n4Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgPiEixRdhoqWk3/YmwIMRQklLgczxJY+nCxwPeOcAhSkBPYRbrK0BVfqlQuMgDjWCk8nYaxeEtOCn@nongnu.org
X-Gm-Message-State: AOJu0YzkLMQpdLlLH1PV/JeTzBh816nFW8C2UnmzWm9r3T1bVQRAnuVd
 pboU/uKF7sBadyfiTFrPRTPqR5wV7T4SD9IcjwNtRWNQZgZHLTD9hZOpn6VFtiskdCaK3SgFs2G
 MKMo=
X-Gm-Gg: ASbGncsbSstpg2vwM6lstxoD1/zwZG7scC1t2VSGkQLmEoNO3ZFbI3NnTjpqKi75LHG
 DQuZODr+gzDTtRJAIQa5vFIRVsDfSs8V8y2HJ6eT8deBhKFjdSG44W84GWxZ3ERKmo4ljwDTo5R
 EXfXjCUktJJF4uu1oK1/hMtNuxyRhvb4WDuMk70Xw3HkvxCuViKKw/+cJ8ST8m3HuQJVgNZJuMN
 zW3eOccz1rFd/ssPUSmUykkduERMokzt4uo4UBmpbRByaKL
X-Google-Smtp-Source: AGHT+IE1chvEfPE9xvFUMqXcXN7mbIbvm6fb8lp25k/T4yvLW8pO0iJES+HnR7K9/ybhBo68eoc25g==
X-Received: by 2002:a2e:a99e:0:b0:2fb:5a7e:5046 with SMTP id
 38308e7fff4ca-2ffd5fff00emr39186901fa.9.1732803695856; 
 Thu, 28 Nov 2024 06:21:35 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d097ebb56esm766091a12.87.2024.11.28.06.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 06:21:35 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7AFD35F8AC;
 Thu, 28 Nov 2024 14:21:33 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yanfeng Liu <yfliu2008@qq.com>
Cc: qemu-riscv@nongnu.org,  qemu-devel@nongnu.org,  alistair.francis@wdc.com
Subject: Re: [PATCH v2] riscv/gdb: add virt mode debug interface
In-Reply-To: <tencent_B52B1EB0A504D6F690B6E6F3FD3AC9BCDC09@qq.com> (Yanfeng
 Liu's message of "Thu, 28 Nov 2024 15:21:27 +0800")
References: <tencent_B52B1EB0A504D6F690B6E6F3FD3AC9BCDC09@qq.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 28 Nov 2024 14:21:33 +0000
Message-ID: <8734jbh21e.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x233.google.com
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

Yanfeng Liu <yfliu2008@qq.com> writes:

> This adds `virt` virtual register on debug interface so that users
> can access current virtualization mode for debugging purposes.
>
> Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
> ---
>  gdb-xml/riscv-32bit-virtual.xml |  1 +
>  gdb-xml/riscv-64bit-virtual.xml |  1 +
>  target/riscv/gdbstub.c          | 18 ++++++++++++------
>  3 files changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/gdb-xml/riscv-32bit-virtual.xml b/gdb-xml/riscv-32bit-virtua=
l.xml
> index 905f1c555d..d44b6ca2dc 100644
> --- a/gdb-xml/riscv-32bit-virtual.xml
> +++ b/gdb-xml/riscv-32bit-virtual.xml
> @@ -8,4 +8,5 @@
>  <!DOCTYPE feature SYSTEM "gdb-target.dtd">
>  <feature name=3D"org.gnu.gdb.riscv.virtual">
>    <reg name=3D"priv" bitsize=3D"32"/>
> +  <reg name=3D"virt" bitsize=3D"32"/>
>  </feature>
> diff --git a/gdb-xml/riscv-64bit-virtual.xml b/gdb-xml/riscv-64bit-virtua=
l.xml
> index 62d86c237b..7c9b63d5b6 100644
> --- a/gdb-xml/riscv-64bit-virtual.xml
> +++ b/gdb-xml/riscv-64bit-virtual.xml
> @@ -8,4 +8,5 @@
>  <!DOCTYPE feature SYSTEM "gdb-target.dtd">
>  <feature name=3D"org.gnu.gdb.riscv.virtual">
>    <reg name=3D"priv" bitsize=3D"64"/>
> +  <reg name=3D"virt" bitsize=3D"64"/>
>  </feature>

I assume these are mirrored in gdb not a QEMU only extension?

> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index c07df972f1..7399003e04 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -206,14 +206,14 @@ static int riscv_gdb_set_csr(CPUState *cs, uint8_t =
*mem_buf, int n)
>=20=20
>  static int riscv_gdb_get_virtual(CPUState *cs, GByteArray *buf, int n)
>  {
> -    if (n =3D=3D 0) {
> +    if (n >=3D 0 && n <=3D 1) {
>  #ifdef CONFIG_USER_ONLY
>          return gdb_get_regl(buf, 0);
>  #else
>          RISCVCPU *cpu =3D RISCV_CPU(cs);
>          CPURISCVState *env =3D &cpu->env;
>=20=20
> -        return gdb_get_regl(buf, env->priv);
> +        return gdb_get_regl(buf, n ? env->virt_enabled : env->priv);

The range checking of n and ternary op are a bit magical here. Whats
wrong with a good old fashioned switch/case statement?

>  #endif
>      }
>      return 0;
> @@ -221,14 +221,20 @@ static int riscv_gdb_get_virtual(CPUState *cs, GByt=
eArray *buf, int n)
>=20=20
>  static int riscv_gdb_set_virtual(CPUState *cs, uint8_t *mem_buf, int n)
>  {
> -    if (n =3D=3D 0) {
> +    if (n >=3D 0 && n <=3D 1) {
>  #ifndef CONFIG_USER_ONLY
>          RISCVCPU *cpu =3D RISCV_CPU(cs);
>          CPURISCVState *env =3D &cpu->env;
>=20=20
> -        env->priv =3D ldtul_p(mem_buf) & 0x3;
> -        if (env->priv =3D=3D PRV_RESERVED) {
> -            env->priv =3D PRV_S;
> +        if (n =3D=3D 0) {
> +            env->priv =3D ldtul_p(mem_buf) & 0x3;
> +            if (env->priv =3D=3D PRV_RESERVED) {
> +                env->priv =3D PRV_S;
> +            }
> +        } else {
> +            if (env->priv !=3D PRV_M) {
> +                env->virt_enabled =3D ldtul_p(mem_buf) & 0x1;
> +            }

ditto here.

>          }
>  #endif
>          return sizeof(target_ulong);

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

