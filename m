Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F8EBC7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 16:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSeMW-0007VA-9U; Fri, 20 Jun 2025 12:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uSeMU-0007Ug-AX
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:13:06 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uSeMS-00057l-7A
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:13:06 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-addda47ebeaso421334166b.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 09:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750435982; x=1751040782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vlxQvYQj4KNS63YM6P4C6yGM9UmqpnjPZU3GL9RFLlA=;
 b=HUbguWJRq/Ng9JjEpAt8lEvICObMs09gAP25b9XTyxxiqtPnbZtowJxSMPIOoh1FCH
 3H0w26UNVVEbcPQI26ClCQYh/gA8Iahq2HiKBc545xqShK1A1V9829sp+yEq7/G9wrTX
 mEwTl7dsNg5Yq3yaVdooE4GAXRzaZVz+CK+Ycshc2lyqahGskEBAMt0ewG+k9dJypvWX
 XRfrXNPJD9t74h2CZo0Br2W8gYhWaJut3n9YEMt5CPirPrvVR60vAt9KMo/HPgsLFVit
 xFzcnrtlJar0xOZL7gRydeth5FhjNlT/NGc+4pSKmTBZz7tm/xTyAZHlfOLLCcFQUI4l
 Q1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750435982; x=1751040782;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vlxQvYQj4KNS63YM6P4C6yGM9UmqpnjPZU3GL9RFLlA=;
 b=eYrAUlYOVZAbVrTjH7PJ3doDBFB0eX8il5Ws+XNveMB6yaFwnSkwvt2CG/HycENHrN
 nasbh/8GRE8kXmP41pCsNIxdjEL2dw4zAW4Dy7be/qxNQO9H5KcU+Y42u/n4adQae/36
 VDlEMDvt+ICw/3snhnBonBExsFhwYc12VrvlNfHhLd/xRUAmCeAKEa5Is8gSo1w4ZE6Z
 /MVOEKivkEPraIS50tmoCUfVFXs9NF3BDl928ZNOqlC+Gl9TE+dkJzLM0zHfnLEnuQFR
 yL5UQOB1+jbmTElS//YJ+JfkzdswUyvdIGmPW3SSmHvluGJ5KjSoRW1PxmsxF0ruHl1Y
 MR0w==
X-Gm-Message-State: AOJu0Yxf2SpCK7WnNef3TK49t5zib8bz3ne5WjXaeB3dwtLMNNuxsg/R
 Yt2GOU0Hvl85kb0ow5tJzi8BiTUDevucKFEDdlDvKxxcV0z0IrK+DpF9zIWhcH1V3OE=
X-Gm-Gg: ASbGncuOFB5CtjPC6M6O0sMh2kbreccjjIQhglJsk2liJxxixLZuqqkGFgVkHhZwDV7
 crRhF82ODtJt2r4RNPhTrXJin15q66tNZDF4b2Uk/fm8f07ACPqw10OvW9aFGcEv/llYBj8twXZ
 FZGuh/NlpDPMKbYVeN7bGCtUzm5YQAtgGHZfppHY8fUgwdNXApAnMyGqcvl4MN4c36pHrtiM7k3
 Ch5thIJ6HtTOsdRkqmAiyBYrNiK615GK6fNHnBFCfWt2qYiuIfaDkMoNdU9PVR7fyTJKGffZc2V
 3WPZz6I8IU3aaMA8ftfaourHEAbCxY7oZQFPHsGDSFQ+jhKm2CZ3B4/n9rqeqio=
X-Google-Smtp-Source: AGHT+IE1V+CDSgndQKiRbtN3vq/VwdPodSLF3Ykx0oERp/mSQteTYHbFEFhUctECwgYbOkp2dnWmNA==
X-Received: by 2002:a17:907:1c10:b0:ad8:a935:b8fe with SMTP id
 a640c23a62f3a-ae057bc442amr345688566b.46.1750435982373; 
 Fri, 20 Jun 2025 09:13:02 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae0541b6894sm182625566b.111.2025.06.20.09.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 09:13:00 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AFC825F876;
 Fri, 20 Jun 2025 17:12:59 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Tanish Desai <tanishdesai37@gmail.com>
Cc: qemu-devel@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Mads
 Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH v2 1/3] tracetool: removed the unused vcpu property
In-Reply-To: <20250620143720.3143-2-tanishdesai37@gmail.com> (Tanish Desai's
 message of "Fri, 20 Jun 2025 14:37:18 +0000")
References: <20250620143720.3143-1-tanishdesai37@gmail.com>
 <20250620143720.3143-2-tanishdesai37@gmail.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Fri, 20 Jun 2025 17:12:59 +0100
Message-ID: <87jz56s86s.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Tanish Desai <tanishdesai37@gmail.com> writes:

> The vcpu property is no longer used in these backends. Removing it avoids
> unnecessary checks and simplifies the code generation for these trace
> backends.
>
> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>

I think you forgot to collect the r-b tags from v1, see:

  https://qemu.readthedocs.io/en/master/devel/submitting-a-patch.html#prope=
r-use-of-reviewed-by-tags-can-aid-review

> ---
>  scripts/tracetool/__init__.py       | 6 +++---
>  scripts/tracetool/backend/log.py    | 6 +-----
>  scripts/tracetool/backend/simple.py | 6 +-----
>  scripts/tracetool/backend/syslog.py | 6 +-----
>  4 files changed, 6 insertions(+), 18 deletions(-)
>
> diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
> index bc03238c0f..e86c898a1e 100644
> --- a/scripts/tracetool/__init__.py
> +++ b/scripts/tracetool/__init__.py
> @@ -216,9 +216,9 @@ class Event(object):
>                        r"\s*"
>                        r"(?:(?:(?P<fmt_trans>\".+),)?\s*(?P<fmt>\".+))?"
>                        r"\s*")
> -
> -    _VALID_PROPS =3D set(["disable", "vcpu"])
> -
> +=20=20=20=20
> +    _VALID_PROPS =3D set(["disable"])
> +=20=20=20=20
>      def __init__(self, name, props, fmt, args, lineno, filename, orig=3D=
None,
>                   event_trans=3DNone, event_exec=3DNone):
>          """
> diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend=
/log.py
> index de27b7e62e..f24acad74c 100644
> --- a/scripts/tracetool/backend/log.py
> +++ b/scripts/tracetool/backend/log.py
> @@ -31,11 +31,7 @@ def generate_h(event, group):
>      if len(event.args) > 0:
>          argnames =3D ", " + argnames
>=20=20
> -    if "vcpu" in event.properties:
> -        # already checked on the generic format code
> -        cond =3D "true"
> -    else:
> -        cond =3D "trace_event_get_state(%s)" % ("TRACE_" + event.name.up=
per())
> +    cond =3D "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper(=
))
>=20=20
>      out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
>          '        if (message_with_timestamp) {',
> diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/back=
end/simple.py
> index 2688d4b64b..7c84c06b20 100644
> --- a/scripts/tracetool/backend/simple.py
> +++ b/scripts/tracetool/backend/simple.py
> @@ -37,11 +37,7 @@ def generate_h_begin(events, group):
>=20=20
>  def generate_h(event, group):
>      event_id =3D 'TRACE_' + event.name.upper()
> -    if "vcpu" in event.properties:
> -        # already checked on the generic format code
> -        cond =3D "true"
> -    else:
> -        cond =3D "trace_event_get_state(%s)" % event_id
> +    cond =3D "trace_event_get_state(%s)" % event_id
>      out('    if (%(cond)s) {',
>          '        _simple_%(api)s(%(args)s);',
>          '    }',
> diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/back=
end/syslog.py
> index 012970f6cc..6fdc1142fb 100644
> --- a/scripts/tracetool/backend/syslog.py
> +++ b/scripts/tracetool/backend/syslog.py
> @@ -30,11 +30,7 @@ def generate_h(event, group):
>      if len(event.args) > 0:
>          argnames =3D ", " + argnames
>=20=20
> -    if "vcpu" in event.properties:
> -        # already checked on the generic format code
> -        cond =3D "true"
> -    else:
> -        cond =3D "trace_event_get_state(%s)" % ("TRACE_" + event.name.up=
per())
> +    cond =3D "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper(=
))
>=20=20
>      out('    if (%(cond)s) {',
>          '#line %(event_lineno)d "%(event_filename)s"',

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

