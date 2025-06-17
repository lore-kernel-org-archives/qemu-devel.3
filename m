Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFD1C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 22:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRf11-0005iB-8e; Tue, 17 Jun 2025 18:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRf0y-0005gl-Su
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 18:42:48 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRf0v-0007zh-U1
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 18:42:48 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45347d6cba3so8847365e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 15:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750200133; x=1750804933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y0mElMK197BB4r23E4/nQRXPfIXPay3Ny6bJDuERBiQ=;
 b=NdGZZBWKanHbZSc/23ZFq2i53D5mWyvjqfe6Rw7pIOB0/OuYW8GptQ33qgK/H8j0y/
 dp+OnF0adPFRog+N1CWJKoq0XsyXfEnhkoNTUY3TklGW+MsYmNY6Kevb9BJA6ALiWr8g
 lOtL/nQTPCgC1MByE0DeF+M9ZAcE/iksQemkMoWyC8Gf59N0TUBfqzY8f8Dcjbb6445G
 50fl4GK7c/9W6lKRC8U82Rc+B3/4H+szUGfa2G7FI8IbFnvjMTsr061yRqFYZN/D/Ebc
 8KnPZBLhQqgQ4ecuD1ty87FbFMV/bnJMZQtzMjeCIqXguKmpDM6YRC1dFTrjmPtOumkB
 uo9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750200133; x=1750804933;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y0mElMK197BB4r23E4/nQRXPfIXPay3Ny6bJDuERBiQ=;
 b=oYGmiXzrBU+6wW9ZfrLJu2UxweECLJYC23BfKdxfw+c56pSP7h7JSEQR8p/x+1hDnT
 LkuxBjuFUh4PbWylN6UVjv8rulvi9xAyM8YXclCsVgTytfs42ROpGHHc0DWcFFFI3UGD
 b7h+7v95hV+AosyTUnd2R5tEES1v1iPPJ9PeYK0ifuQL2FzhEf3Th693m4IHKs8J60nF
 ALKdPhto7hgf9ViNkQEATXAHR57k1x5crkdF+/gBC1XCNibvh1BWwtFTAYdd3Nuxv9QS
 e+WbZDfbqmwZl30Uux3TjNm3T1kHdCvS5ysDzpWg+QOAxSYFqxYWRWHgBAsE6EHJLvNY
 1GNw==
X-Gm-Message-State: AOJu0YwfTjKPa4gHbFSBj5UDTRgzKizbfL9/9vc9792fgTSEoNZYTT0d
 deqF/eBtAr6Gu4lPcBsNnhIsKgWOB/DeRRMfJVijK3Jciz5bcEeRVSy1yZbKlN9bkz0=
X-Gm-Gg: ASbGncvM6/8kujCFfzv3ybLUdDLnijXFpGdwayYL8OKU6Uarm2aHYFz3UtHpJvfoMBS
 2ZI63VtbNBQErUFG4XWQDRirRJOMgqBcIromGedzRf2JFLpyJsp0A2dOtpwiIGxBt/GW/SiymY0
 qUtoUK4Ah5TYkhkuYN3zdy4Uc6s99nilurUfCo+mkuevRg38UL8gp7nCpEsvYA4h7Xdru4Hr41a
 vCrRWXeJD4NIuDjlzw6q9MKPqTRyJcUhMnWlhRx5xjHM/FCZwvHKh5YnnWDV7RKNE0nKtlCzxuF
 GA8qT4H0cqN8J4mvVvDaJ4VNJk1MwmIDo/ofnWaCOrMUAOGcWgQdJ/7FAIlqBhZUiWay3zxkKA=
 =
X-Google-Smtp-Source: AGHT+IH3/pU7q4iFFjbW1OlqIflChXxJb6phRbWCijSJpxyStHWxJTnzvYOMyaSirxtu4WCynCcGRQ==
X-Received: by 2002:a05:600c:1c90:b0:450:d3b9:4ba4 with SMTP id
 5b1f17b1804b1-4533cadf6c4mr143842105e9.2.1750200133237; 
 Tue, 17 Jun 2025 15:42:13 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b08dfesm15366468f8f.60.2025.06.17.15.42.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 15:42:12 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 34E125F845;
 Tue, 17 Jun 2025 23:42:11 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Tanish Desai <tanishdesai37@gmail.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Llu=C3=ADs?= Vilanova
 <vilanova@ac.upc.edu>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Mads Ynddal <mads@ynddal.dk>,  Stefan
 Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 2/3] tracetool: introduce generate_unconditional
In-Reply-To: <20250616201222.6416-3-tanishdesai37@gmail.com> (Tanish Desai's
 message of "Mon, 16 Jun 2025 20:12:21 +0000")
References: <20250616201222.6416-1-tanishdesai37@gmail.com>
 <20250616201222.6416-3-tanishdesai37@gmail.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Tue, 17 Jun 2025 23:42:11 +0100
Message-ID: <87zfe6t2gs.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

> This patch separates the generation logic of trace_foo() for the UST and =
DTrace backends from other backends.
> The motivation is to remove the unnecessary if (true) in the _no_check fu=
nction, as UST and DTrace do not require a trace_event_get_state check with=
out introducing a seperate function it is very difficult to generate code w=
hich keeps them out of unified if condition.
> With this separation, we can safely move the trace_event_get_state check =
into trace_foo for the other backends only, keeping UST/DTrace generation p=
aths clean.
> A new generate_h_unconditional function has been introduced for UST
> and DTrace. It behaves similarly to generate_h, but is defined only in
> UST and DTrace backends. This ensures that generate_h is used by the
> other backends, while UST/DTrace selectively use
> generate_h_unconditional.

Please fix the word wrap on the commit at 78 chars.

>
> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> ---
>  scripts/tracetool/backend/__init__.py |  3 +++
>  scripts/tracetool/backend/dtrace.py   |  3 ++-
>  scripts/tracetool/backend/ust.py      |  2 +-
>  scripts/tracetool/format/h.py         | 10 +++++++---
>  4 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/tracetool/backend/__init__.py b/scripts/tracetool/ba=
ckend/__init__.py
> index 7bfcc86cc5..c4456a5efd 100644
> --- a/scripts/tracetool/backend/__init__.py
> +++ b/scripts/tracetool/backend/__init__.py
> @@ -118,6 +118,9 @@ def generate_begin(self, events, group):
>      def generate(self, event, group):
>          self._run_function("generate_%s", event, group)
>=20=20
> +    def generate_unconditional(self, event, group):
> +        self._run_function("generate_%s_unconditional", event, group)
> +=20=20=20=20
>      def generate_backend_dstate(self, event, group):
>          self._run_function("generate_%s_backend_dstate", event, group)
>=20=20
> diff --git a/scripts/tracetool/backend/dtrace.py b/scripts/tracetool/back=
end/dtrace.py
> index e17edc9b9d..171b7e09ed 100644
> --- a/scripts/tracetool/backend/dtrace.py
> +++ b/scripts/tracetool/backend/dtrace.py
> @@ -61,7 +61,8 @@ def generate_h_begin(events, group):
>              '#endif',
>              uppername=3De.name.upper())
>=20=20
> -def generate_h(event, group):
> +

stray newline

> +def generate_h_unconditional(event, group):
>      out('    QEMU_%(uppername)s(%(argnames)s);',
>          uppername=3Devent.name.upper(),
>          argnames=3D", ".join(event.args.names()))
> diff --git a/scripts/tracetool/backend/ust.py b/scripts/tracetool/backend=
/ust.py
> index c857516f21..1564b490ec 100644
> --- a/scripts/tracetool/backend/ust.py
> +++ b/scripts/tracetool/backend/ust.py
> @@ -30,7 +30,7 @@ def generate_h_begin(events, group):
>          '')
>=20=20
>=20=20
> -def generate_h(event, group):
> +def generate_h_unconditional(event, group):
>      argnames =3D ", ".join(event.args.names())
>      if len(event.args) > 0:
>          argnames =3D ", " + argnames
> diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
> index ea126b07ea..89d54b9aff 100644
> --- a/scripts/tracetool/format/h.py
> +++ b/scripts/tracetool/format/h.py
> @@ -76,13 +76,17 @@ def generate(events, backend, group):
>          out('',
>              'static inline void %(api)s(%(args)s)',
>              '{',
> -            '    if (%(cond)s) {',
> +            api=3De.api(),
> +            args=3De.args)
> +=20=20=20=20=20=20=20=20
> +        if "disable" not in e.properties:
> +            backend.generate_unconditional(e, group)
> +
> +        out('    if (%(cond)s) {',
>              '        %(api_nocheck)s(%(names)s);',
>              '    }',
>              '}',
> -            api=3De.api(),
>              api_nocheck=3De.api(e.QEMU_TRACE_NOCHECK),
> -            args=3De.args,
>              names=3D", ".join(e.args.names()),
>              cond=3Dcond)

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

