Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB79E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 11:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVrBr-0003j3-6h; Thu, 09 Jan 2025 06:59:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVrBp-0003ic-70
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:59:05 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVrBn-0002md-Ee
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:59:04 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aa6b4cc7270so139123166b.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 03:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736423942; x=1737028742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SdqfNWOoLrDAfp/WTM7Cud+NM9d+8ICRdauFTCj2afA=;
 b=RBBAnbeHEPB1a3RZPc1wte50MGVsG3LnViBCgVQ+5xj3JVv4+4sZhy3PlnAyAzMgiC
 I09a+gcFOLL0RlPBElrguigTkqVHzIkuZHRoT//yHvJSVTN063X3d3JRisc2RJNoH/AR
 yi/I2oNgpJZr0qqWNYxgMAcjlJ6RQsm4HUl2rulNKFf4u4u/zoBt1mlWE0f7Xkmv9zd4
 AgSfwrBoRYaja8qU74CppvAymLlsiDHK3IrRmHyrj4K51ey9Qu+CWw2WZblsh/QUaIJU
 whNEZWbc7RRzbkwms2A78cpeDDcUS0HLa0VLlgvQ8vIUimdKJ3Oq/UDi9yjcr6N4izQA
 Q0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736423942; x=1737028742;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SdqfNWOoLrDAfp/WTM7Cud+NM9d+8ICRdauFTCj2afA=;
 b=wW62RIDthYscIcFeNHwLN5XiU+FoRGrROyUE2UvN62uQDa5YS7WuNRQ9gyz/mRg+M0
 KxLdOCrjwOVDnIRzNUPrC6tCnJlR/kTrakSl3sVhOss8EDsGCTk+5tMQ7PXbu/Ajl65+
 4cgbnFbmV1JH/ipUoEB2Je6wOjVLfWTzcU8waGqAUzQ0yoUXYQsS70jSJW0XuagKAR/v
 XkjvANmkfmXDTSb3KdUpG59b6gDkHFOpksh/BZQMsfhE3DUO3ARvwIsS3UJnb2W6E+7f
 qCqDIsWwUbm9QcE3Y8mfyFim9sIhMN5TuFxPG5Lg3roG8Yx4TGCqgDI5gqBBoJaXWaJc
 n1Gg==
X-Gm-Message-State: AOJu0YwKoiik8AEv3sh3mWSxvk8KmMe/m3SjeS4g92296xULn45tjkTu
 J5Bd+ZRK5DRy8M0XCPfe4LxafSvsdRog3kkk2tgzKISD/Ds+qxuPMijQPdwqRb3ndBg4VOutJmZ
 xF0g=
X-Gm-Gg: ASbGnctxcrm4vkImQ4SwNgRPekQgaAl1OyF4x8as8k43boF48LjQehcXu7XvX8gqH1m
 LL9oJkikRcfVJNA8wQvhJThuNS68W4jj6Drny3bu9vq+rWfDZZpJiGn9eNJaoW1lyfL2CYY3h2q
 MVEVgc0mWtTdgYb14131PtZ11ifQSKeafrqY9Udvib/xK/nqXyBuiMfd2fCPuen5cp9amd6NeLP
 Y/w1KWveNhKikjBFOWyKDjS+ACFNE42finvhQ5jnQ8SffsbyTXfYao=
X-Google-Smtp-Source: AGHT+IEJ7K1ydve4w1QaDWx+cI84sh5iXFkbR6xda5qYq/1vs/s2JoF1/OVWWUROHgOGYkklJ31G4w==
X-Received: by 2002:a05:6402:26cf:b0:5d4:55e:f99e with SMTP id
 4fb4d7f45d1cf-5d972e1d7dfmr15235024a12.18.1736423941510; 
 Thu, 09 Jan 2025 03:59:01 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c90d81c4sm65671766b.64.2025.01.09.03.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 03:59:00 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C4CB55F87E;
 Thu,  9 Jan 2025 11:58:59 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "demin.han" <demin.han@starfivetech.com>
Cc: qemu-devel@nongnu.org,  erdnaxe@crans.org,  ma.mandourr@gmail.com,
 pierrick.bouvier@linaro.org
Subject: Re: [PATCH] plugins: add plugin API to get args passed to binary
In-Reply-To: <20241101090032.1413255-1-demin.han@starfivetech.com> (demin
 han's message of "Fri, 1 Nov 2024 17:00:32 +0800")
References: <20241101090032.1413255-1-demin.han@starfivetech.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 09 Jan 2025 11:58:59 +0000
Message-ID: <87v7uo8ags.fsf@draig.linaro.org>
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

"demin.han" <demin.han@starfivetech.com> writes:

> Why we need args?
> When plugin outputs log files, only binary path can't distinguish multiple
> runs if the binary passed with different args.
> This is bad for CI using plugin.

New APIs should come with an example use case for testing. However for
this use case why isn't the plugin using getpid() or gettid() a suitable
solution?

Some additional comments bellow...

> Signed-off-by: demin.han <demin.han@starfivetech.com>
> ---
>  include/qemu/qemu-plugin.h   | 11 +++++++++++
>  plugins/api.c                | 16 ++++++++++++++++
>  plugins/qemu-plugins.symbols |  1 +
>  3 files changed, 28 insertions(+)
>
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 622c9a0232..daf75c9f5a 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -837,6 +837,17 @@ bool qemu_plugin_bool_parse(const char *name, const =
char *val, bool *ret);
>  QEMU_PLUGIN_API
>  const char *qemu_plugin_path_to_binary(void);
>=20=20
> +/**
> + * qemu_plugin_argv_to_binary() - argv to binary file being executed
> + *
> + * Return a string array representing the argv to the binary. For user-m=
ode
> + * this is the main executable's argv. For system emulation we currently
> + * return NULL.

Maybe more explicit:

qemu_plugin_get_user_argv() and be clear it is user mode only.

Although I suspect a qemu_plugin_get_user_env() might be a more useful
helper depending on the use case.

> The user should g_free() the string array once no longer
> + * needed.
> + */
> +QEMU_PLUGIN_API
> +const char **qemu_plugin_argv_to_binary(void);
> +
>  /**
>   * qemu_plugin_start_code() - returns start of text segment
>   *
> diff --git a/plugins/api.c b/plugins/api.c
> index 24ea64e2de..fa2735db03 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -485,6 +485,22 @@ const char *qemu_plugin_path_to_binary(void)
>      return path;
>  }
>=20=20
> +const char **qemu_plugin_argv_to_binary(void)
> +{
> +    const char **argv =3D NULL;
> +#ifdef CONFIG_USER_ONLY
> +    int i, argc;
> +    TaskState *ts =3D get_task_state(current_cpu);
> +    argc =3D ts->bprm->argc;
> +    argv =3D g_malloc(sizeof(char *) * (argc + 1));

 argv =3D g_new0(char *, argc + 1);

> +    for (i =3D 0; i < argc; ++i) {
> +        argv[i] =3D g_strdup(ts->bprm->argv[i]);
> +    }
> +    argv[argc] =3D NULL;

Allows you to drop this as well.

> +#endif
> +    return argv;
> +}
> +
>  uint64_t qemu_plugin_start_code(void)
>  {
>      uint64_t start =3D 0;
> diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
> index 032661f9ea..532582effe 100644
> --- a/plugins/qemu-plugins.symbols
> +++ b/plugins/qemu-plugins.symbols
> @@ -1,4 +1,5 @@
>  {
> +  qemu_plugin_argv_to_binary;
>    qemu_plugin_bool_parse;
>    qemu_plugin_end_code;
>    qemu_plugin_entry_code;

You can drop the symbols now we autogenerate them.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

