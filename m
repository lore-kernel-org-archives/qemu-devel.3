Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472C6ECD6C1
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 16:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqD1d-0002aA-U7; Wed, 11 Feb 2026 11:25:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vqD1a-0002Zg-2o
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 11:25:10 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vqD1Y-0002Q2-Jp
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 11:25:09 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b8845cb580bso898970866b.3
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 08:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770827107; x=1771431907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cITEBpNoeI4Fz1kFqFSiFskD7+nx2QjEUa19kz0YsgM=;
 b=STXWGgUHtd84MtjjOf81N/mAHrBw2nuW6QkwKLSlvipDZVCBh/XxFQU+wOxbYDqAyF
 8bapQGTDS6BjnrATBI6AY8C9v5bT9wZ/jIGUg8o5WzrSsgjzpMa6zvOwVBHcA/HO2wH4
 DJL3P5C7o9HuSclQOj3vHNs5rsI+0AlGTsI4TH2RkdWvccVGD4KkjNNTTozZfocrlvyt
 Q9q+2nYcFhdaFx1iC0y4OzNyyAHY66tDkMP6x+h4hkkFpSHRbT0cY3RJTd4hTmMQlavz
 kXSTbO0HYyBx2RX2ZB3uncpCscUHOzctTlRoKa1+aQ+YWNqLET131SayimzGtZxxxvUf
 GWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770827107; x=1771431907;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cITEBpNoeI4Fz1kFqFSiFskD7+nx2QjEUa19kz0YsgM=;
 b=F4b/J7n6rvZ+sIV6uKGZRo4Z3Gdm0bDS6cavThatKBt8BqZzSzSJ61GXzZgHVd2mQT
 jemXE1pVcFXxpR8xuOK/m0TOdmjHdfXWeNOLCQHEZWmEU3R9iW9kCIyQUI9lgixBOop/
 C+XE2xjobD3gFfUcLZSNk3wMpBi1H3oIBRUVnenhhIPQ1lYoHZteRV4Ufzb7PEdMtQi5
 3MrRYu1yJqmUGYQeRZFoiC+KTFjSRFLyD4xtFmZ62imn1Zf3dK94F1ZBRUeP+Rq2jR8F
 p24Vx6whx4Vyd13hAGgZU7GLY/E1MaRqExuKc7VxnYJEc39gO/MiEtIuaBH+PRtl4ziq
 RiMQ==
X-Gm-Message-State: AOJu0Yxzz2k2lcZHpnYabhOLFuXUr/64RxQNRijJBqCxIJnygrdIGGwu
 I8gAE6f74Xt4gnOcirCad+9Q447NQja+tNWZkA+nm9j2lSlwVtLZjCeg7aTQiSL8EGE=
X-Gm-Gg: AZuq6aJMntQKmIxi5eAzDBSlo4busu5uBfuVYvPrXG2NPfqSChDwSqNAGaJVk0oI81+
 9O8cTUcysq2bp0AweB3k+OEDQ/I7jlw+E54UswfidK99WH2ug/GKaKt+vz0fY4Z74Qy6mzLZK8m
 PtDb6ChD6EuYNrZeHwjPtoiDkhS7Khr7yUZyCT0gZewy74BYAMPIJT3nXfpZvwvFe/b16fdKzpq
 +oHBXt60S0G9IL4kgYJHrd7JMHHx1hrrHQcMJwOzUWS/GkCwfSXDLLS+3svnvSmaJq05ASdwFva
 fb0EaJysF+pKbg2F+X5wX0Uyfbj2EGl0WFimnlIz3UPz60BucwUSshmnUBoYnv1YtmkVd/g1YyL
 VptTkiadUl5pecM8qxKG/CHnF5IzkM6deGDA/1VVpB88/d32NjdqTSmRZXmQGU0Lz20nMAe1+jw
 Onk2OGwA7recijPAum79yOAxZ7i6iFZxeB9Q==
X-Received: by 2002:a17:907:2d24:b0:b8e:7e21:132c with SMTP id
 a640c23a62f3a-b8f6aed3c27mr180657066b.59.1770827106782; 
 Wed, 11 Feb 2026 08:25:06 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65a3cf506c8sm887111a12.32.2026.02.11.08.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 08:25:06 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 70A475FC4E;
 Wed, 11 Feb 2026 16:25:05 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH] docs/devel: fix bash-ism warning for configure
In-Reply-To: <20260114101525.4039244-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?= message of "Wed, 14 Jan 2026 10:15:25 +0000")
References: <20260114101525.4039244-1-alex.bennee@linaro.org>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Wed, 11 Feb 2026 16:25:05 +0000
Message-ID: <87bjhvnt7i.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Hopefully this makes the meaning clearer.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  docs/devel/build-system.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
> index b9797a374c7..35c77343914 100644
> --- a/docs/devel/build-system.rst
> +++ b/docs/devel/build-system.rst
> @@ -66,7 +66,7 @@ Modifying ``configure``
>  ``configure`` is a shell script; it uses ``#!/bin/sh`` and therefore
>  should be compatible with any POSIX shell. It is important to avoid
>  using bash-isms to avoid breaking development platforms where bash is
> -the primary host.
> +not the default shell implementation.
>=20=20
>  The configure script provides a variety of functions to help writing
>  portable shell code and providing consistent behavior across architectur=
es

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

