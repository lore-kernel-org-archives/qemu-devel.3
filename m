Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081D3C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 16:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfjNv-0004QE-Q8; Thu, 29 Feb 2024 11:35:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfjNt-0004Pv-QJ
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 11:35:50 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfjNq-0001iV-6n
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 11:35:49 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-412aec2505dso8029175e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 08:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709224544; x=1709829344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s8uTOQgKsA7bCx09AJjxg+5wg60RelH6pHrEr+OKszE=;
 b=ufzGg2xf9gvg2mhN+sLTypl7tEvpTmkBmsY00uzf1Dr+/cLPCixiIViHsoyEun6dOM
 dB2R59+4kgB1rzwOlQbrhrljhAFwMzGkiYu4C0O7iO9XbZp/5x5HS5jWBkM8710udKPr
 edV6z7N/ObN6gJ9IoDFmRcxYPBDqQ3Ar0oRzs4uZmPheyDk3JM86uIe607vRBHo3y5WJ
 KQE5IuCKvGdfbX/42n8UP7cFkrtm06NFyiV1zwMZumOQJuj/I16RJRt7sggfIW9AbbLF
 LhpQaZ9CGGtWIyQTZZJXGQqoLZnDGrjhYSOJqZXpIzh/BImhld64eYobnh0LkEc7G9/L
 iSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709224544; x=1709829344;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s8uTOQgKsA7bCx09AJjxg+5wg60RelH6pHrEr+OKszE=;
 b=a30ufH3kTkWJHCmgGeJGY4njed5Eo/j76e89M8Zm1wylh1XamleSDaFb9VVRCGTCS9
 KeUrxJPMeNMqy2PXz1Nx5M8fcVeoudvZgQ1Ilkv3cChXGCEnhhMt0IcNuLJen1QHg0Mk
 x9Z96KKlqndyx77CCWEEPTCGmW1Ui8tS+n3aKF79Orb7rJsfXEfbO3lM8CmPyViw4wFn
 Nb1BjNMEEIP1mF1OskKZMzSz8KyuR0EFvDQaas0K2SUsbea6wM5qPEDdp2cQKJdfZHyn
 a//4GnuLoqI1rX16RJymJdCNu2K37vzmzRQR/82+Y1gfk5DnxnQg0iUzRccB66LbpbX4
 1rvA==
X-Gm-Message-State: AOJu0YyWMjYRlm/Ks+Ms2VuCRwxk26Mf13O8TvWOzCEGqtUFCkQGgQ4J
 asSQf7nmCP0neN9U1MchzWeNM9WRbAGeZTnbP53QSGuc5L0Ks9NpfCYr/uQkGVc=
X-Google-Smtp-Source: AGHT+IGbu5/1ao23qYeGZ+wGdVY3nj8sImXjyo8qr18nnnBMKvjveqtcdI4Yxi7KdLdgrg6KzF+h2A==
X-Received: by 2002:a05:600c:5494:b0:411:c329:6515 with SMTP id
 iv20-20020a05600c549400b00411c3296515mr2041841wmb.24.1709224544237; 
 Thu, 29 Feb 2024 08:35:44 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m17-20020a056000009100b0033e17341ebesm655666wrx.117.2024.02.29.08.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 08:35:43 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1ACBB5F873;
 Thu, 29 Feb 2024 16:35:43 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicolas Eder <nicolas.eder@lauterbach.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "Christian Boenig" <christian.boenig@lauterbach.com>
Subject: Re: [PATCH v5 04/18] gdbstub: DebugClass added to system mode.
In-Reply-To: <20231220162555.19545-5-nicolas.eder@lauterbach.com> (Nicolas
 Eder's message of "Wed, 20 Dec 2023 17:25:41 +0100")
References: <20231220162555.19545-1-nicolas.eder@lauterbach.com>
 <20231220162555.19545-5-nicolas.eder@lauterbach.com>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Thu, 29 Feb 2024 16:35:43 +0000
Message-ID: <8734tb8bz4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Nicolas Eder <nicolas.eder@lauterbach.com> writes:

> This class is used to abstract debug features between different debuggers
> ---
>  debug/common/debug.c     | 33 +++++++++++++++++++++++++++++++++
>  debug/common/meson.build |  1 +
>  debug/gdbstub/system.c   | 18 ++++++++++++++++++
>  debug/meson.build        |  1 +
>  include/hw/boards.h      |  1 +
>  include/qemu/debug.h     | 20 ++++++++++++++++++++
>  include/qemu/typedefs.h  |  2 ++
>  system/cpus.c            |  9 ++++++++-
>  8 files changed, 84 insertions(+), 1 deletion(-)
>
> diff --git a/debug/common/debug.c b/debug/common/debug.c
> index c24aaf1202..476c969c98 100644
> --- a/debug/common/debug.c
> +++ b/debug/common/debug.c
> @@ -16,3 +16,36 @@
>   *
>   * SPDX-License-Identifier: LGPL-2.0+
>   */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/debug.h"
> +#include "qom/object_interfaces.h"
> +
> +static void debug_instance_init(Object *obj)
> +{
> +}
> +
> +static void debug_finalize(Object *obj)
> +{
> +}
> +
> +static void debug_class_init(ObjectClass *oc, void *data)
> +{
> +}
> +
> +static const TypeInfo debug_info =3D {
> +    .name =3D TYPE_DEBUG,
> +    .parent =3D TYPE_OBJECT,
> +    .instance_size =3D sizeof(DebugState),
> +    .instance_init =3D debug_instance_init,
> +    .instance_finalize =3D debug_finalize,
> +    .class_size =3D sizeof(DebugClass),
> +    .class_init =3D debug_class_init
> +};
> +
> +static void debug_register_types(void)
> +{
> +    type_register_static(&debug_info);
> +}

You shouldn't need empty functions if you are not using them. Moreover
you should use the inheritance feature and have something like:

static void gdb_debug_class_init(ObjectClass *klass, void *data)
{
    DebugClass *dc =3D DEBUG_CLASS(klass);
    dc->set_stop_cpu =3D gdb_set_stop_cpu;
};

static const TypeInfo debug_info[] =3D {
    {
        .name =3D TYPE_DEBUG,
        .parent =3D TYPE_OBJECT,
        .instance_size =3D sizeof(DebugState),
        .class_size =3D sizeof(DebugClass),
        .abstract =3D true,
    },
    {
        .name =3D TYPE_GDB_DEBUG,
        .parent =3D TYPE_DEBUG,
        .class_init =3D gdb_debug_class_init,
    },
};

DEFINE_TYPES(debug_info)


> +
<snip>
>=20=20
> +/**
> + * gdb_init_debug_class() - initialize gdb-specific DebugClass
> + */
> +static void gdb_init_debug_class(void)
> +{
> +    Object *obj;
> +    obj =3D object_new(TYPE_DEBUG);
> +    DebugState *ds =3D DEBUG(obj);
> +    DebugClass *dc =3D DEBUG_GET_CLASS(ds);
> +    dc->set_stop_cpu =3D gdb_set_stop_cpu;

This should be part of the class init above

> +    MachineState *ms =3D MACHINE(qdev_get_machine());
> +    ms->debug_state =3D ds;
> +}
>          }
>      } else {
> -        gdb_set_stop_cpu(cpu);
> +        MachineState *ms =3D MACHINE(qdev_get_machine());
> +        DebugState *ds =3D ms->debug_state;
> +        DebugClass *dc =3D DEBUG_GET_CLASS(ds);
> +
> +        if (dc->set_stop_cpu) {
> +            dc->set_stop_cpu(cpu);
> +        }

If there is no explicit state perhaps we should just save the class
rather than the instance.

>          qemu_system_debug_request();
>          cpu->stopped =3D true;
>      }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

