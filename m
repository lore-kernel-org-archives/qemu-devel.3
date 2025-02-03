Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41404C02194
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 13:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tewvy-0004Pg-KZ; Mon, 03 Feb 2025 08:56:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tewvp-0004PF-Vu
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 08:56:10 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tewvo-0004mP-85
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 08:56:09 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aaee2c5ee6eso764228866b.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 05:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738590966; x=1739195766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L9sjNa607SSLDzSLSQsZL31ngAZKnnASEOFnpnoXo6E=;
 b=eol+blMvFFlVot+Pxcmiqy7Ij4JbjUs0GqzOESujjaCq6Pcv2/XzthvmxXvQn1V3OB
 DoabtmI+IewlW2BxkgyJncEjcaMZ6xGWMlB0vhGhyrdV68GHfCYGHPe5Ek6+CxyoRBUk
 iRDcxkWZO0QWd6Pc3sVPFIjfz3dWub5rdGSeo+UlXzpbE9dHWMPvxz4Q/4VFFDAW7WUl
 Na1mYfCaBCzpuMGYnyQnL1IuLC7tLnZeoR1SyBaRyaEEaau7S4A8bRVP0urJ9zTbT0Ph
 p8PnEQtEnE6I02muHhIVfD+9xoIOIs/RkUAg9FdO3A5uBPSrnGuzyclsgOHvc5EALrRM
 PtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738590966; x=1739195766;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L9sjNa607SSLDzSLSQsZL31ngAZKnnASEOFnpnoXo6E=;
 b=lwqHu45It/Geo3i0/8BE7hSQt/cC84Z5JMjfZ+NBKy26HgNiu6rMfrrOQUqM34QO8q
 rtmCADb1eD9UEQeheBMmk8VXG9FuYsgOsbPNx97XDEz7rQgLzj89jRGfTO3Q81QvRp02
 +RO/tMMmyxz/xKGS5BsTpBwdrRYYQI57r3aX9UunFLb9GAeiCc/D+cs2hReOUwFZNT5M
 +080QCImKa5txyev5QJ1pzt++pKPx9jZFm5defWrQl4O6nnN9t5qXVkAH1fm4gbylGAH
 tjdd1UTFVKlqIUKplpR1sEikfESOdwRzuBGTQ14xb8BiAor57BRb9pPVQKVEZ1PYurZ2
 k05Q==
X-Gm-Message-State: AOJu0YxwUBWmHzxhFzLrJkdCjAroA7uQ3GHJK+h5TP1fXovr3Ey1QXm0
 i35haFtjFKg9T5vTRAzjWiApBxObZXoi7wOqmvjCMuOvWdXe9d7v9GEkwtch2e4=
X-Gm-Gg: ASbGncvyR8shvBDLyHYu4PHlXUam4CI2pU3Tt2o8uLG9UWgvkfGZ/GkHFHwZzxR0xM4
 qpyWedOXN0b/jMZz+ZF3Kos7vb/xLmWCzDvwe21HITwxZvkUu/h8shV4GXS/bbLX79mEBdKUePB
 KdkDnUXLQdMUBbMtQgFZaQByN7ijRldmB5wXEplqn+lkuQDNqfpAU3QqtuZGXEDUXS9xXkLt+As
 WCaI25kFztN2t2GlYGJIwzILz9N6uAX2yv35R107gXBm5xMk6CSOkafsvW3mPLMI+JHxezmVpxs
 Wv3zz1gvuX/E06cpRw==
X-Google-Smtp-Source: AGHT+IEEhUDVNO+7JvXACbtIQByxGVJQBZ8UCdsdzA9RogUi13WneahnuIoXvcKo+hPk6TnPzvjLqg==
X-Received: by 2002:a17:907:6ea8:b0:ab3:47cc:a7dc with SMTP id
 a640c23a62f3a-ab6cfce7330mr2270608266b.22.1738590966319; 
 Mon, 03 Feb 2025 05:56:06 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e4a320c6sm753858666b.155.2025.02.03.05.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 05:56:05 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E98C85F8BF;
 Mon,  3 Feb 2025 13:56:04 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,
 mark.cave-ayland@ilande.co.uk,  berrange@redhat.com,  philmd@linaro.org,
 thuth@redhat.com
Subject: Re: [PATCH v2 13/14] meson: Deprecate 32-bit host support
In-Reply-To: <20250203031821.741477-14-richard.henderson@linaro.org> (Richard
 Henderson's message of "Sun, 2 Feb 2025 19:18:20 -0800")
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-14-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 03 Feb 2025 13:56:04 +0000
Message-ID: <87ikprcetn.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> We deprecated i686 system mode support for qemu 8.0.  However, to
> make real cleanups to TCG we need to deprecate all 32-bit hosts.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  docs/about/deprecated.rst | 7 +++++++
>  meson.build               | 6 ++----
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 4a3c302962..7c61d0ba16 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -204,6 +204,13 @@ is going to be so much slower it wouldn't make sense=
 for any serious
>  instrumentation. Due to implementation differences there will also be
>  anomalies in things like memory instrumentation.
>=20=20
> +32-bit host operating systems (since 10.0)
> +''''''''''''''''''''''''''''''''''''''''''
> +
> +Keeping 32-bit host support alive is a substantial burden for the
> +QEMU project.  Thus QEMU will in future drop the support for all
> +32-bit host systems.
> +
>  System emulator CPUs
>  --------------------
>=20=20
> diff --git a/meson.build b/meson.build
> index 866b8ce477..0dae54da0d 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4833,14 +4833,12 @@ if host_arch =3D=3D 'unknown'
>      message('configure has succeeded and you can continue to build, but')
>      message('QEMU will use a slow interpreter to emulate the target CPU.=
')
>    endif
> -elif host_arch =3D=3D 'mips'
> +elif host_long_bits < 64
>    message()
>    warning('DEPRECATED HOST CPU')
>    message()
>    message('Support for CPU host architecture ' + cpu + ' is going to
> be')

 Support for 32 bit host architecture...?

> -  message('dropped as soon as the QEMU project stops supporting Debian 1=
2')
> -  message('("Bookworm"). Going forward, the QEMU project will not guaran=
tee')
> -  message('that QEMU will compile or work on this host CPU.')
> +  message('dropped in a future QEMU release.')
>  endif
>=20=20
>  if not supported_oses.contains(host_os)

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

