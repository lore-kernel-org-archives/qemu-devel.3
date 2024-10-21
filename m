Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E3FD0E6CA
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 08:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2njF-0003Wb-CT; Mon, 21 Oct 2024 04:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t2njD-0003WQ-UL
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 04:25:27 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t2njB-0004OF-1j
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 04:25:27 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-539f72c8fc1so4634219e87.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 01:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729499123; x=1730103923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mtB0qdb5DZEIa1M3QuxfxxzFok0KPJEPD/RCnIposk4=;
 b=qGdrZ8wB6kMwgVjmcTncOSbN3+CoWhRibExsosCHoQ3v/2IUv5jkvnGcf5SckH5sZi
 NRLX0d5vTEfptdj0h8nyB+nNd/bTnqzQqh22yQuQcmQMHsvsQFw05XVFJTP4Qo6XjzF1
 E6yvMB54pjsLweHPi9m8VCMAUKcBENUpEv2HjZ6AIdUyeRxmq+ValA5kuxJ2mxDa6t+2
 UwIG2epcuBgLoZ+9e5qU9Qha7v63NKGOGTDa39L+edg9b6ufXsgvrrJjsJGQWtQcG/aG
 jmjU6Pizc97LSyRueqPO8JsvjwAnqpWHT6LJ08P+YBt++zmyBndib5++nPDbLqotbtv+
 sOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729499123; x=1730103923;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mtB0qdb5DZEIa1M3QuxfxxzFok0KPJEPD/RCnIposk4=;
 b=VbMW8IHZ5CpFlalzHIJ1oKjJY9v56pso64ykLXiI9nE07BPT+l9xePjNqodCnjgWy7
 ophCPmEQAaWvyy1T31/7/ywVqiJ0WG6zoxEnYIxqwc9xxNeeTZBqmiyy+Bk/J2OeidLv
 1yg+oHCY3lED0WRPKaGNyq3FPkr2XZ/8ezQ/iwMq+NiVUDIWbJMBgTWnqPqRnz4grzkD
 b9asq5vB4y4v9G2OPfoxxEspLUuoIDNJgvPbOYNzBuGj2eGJRxYZTK5l+ssAN++mkqQe
 slSN5G4j0Nkk8peaOpUvzNO12vyspXjPwe2JK0eBoJWqRyeBh1daXd6NnqT6U70y4sYV
 GV0A==
X-Gm-Message-State: AOJu0YwJddmWmnjaY0QktCy+LhHFNt+wR4hQLNrLotpM+OE57gTIjgEU
 cvXuzIFCSnqrG+y1notLObytkpu3GzvcyU0/1MKTV5Uf2XXXmwD3gtZq7oG+6DU=
X-Google-Smtp-Source: AGHT+IEJRER8kG8Hmunfr7ZLx0gLAKXR6JRzg70CgP3JWe/WBx9T6cvww8Xm61V+/FqYeL/uI47bxg==
X-Received: by 2002:a05:6512:3985:b0:539:e6bf:ca97 with SMTP id
 2adb3069b0e04-53a15229ce8mr4756476e87.32.1729499123017; 
 Mon, 21 Oct 2024 01:25:23 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb6696b682sm1665627a12.15.2024.10.21.01.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 01:25:22 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7FAB95F8B9;
 Mon, 21 Oct 2024 09:25:21 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Thomas Huth
 <thuth@redhat.com>
Subject: Re: [PATCH] dockerfiles: fix default targets for
 debian-loongarch-cross
In-Reply-To: <20241020213759.2168248-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Sun, 20 Oct 2024 14:37:59 -0700")
References: <20241020213759.2168248-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Mon, 21 Oct 2024 09:25:21 +0100
Message-ID: <87fropq2vi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x135.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> fix system target name, and remove --disable-system (which deactivates
> system target).
>
> Found using: make docker-test-build@debian-loongarch-cross V=3D1
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  tests/docker/dockerfiles/debian-loongarch-cross.docker | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/docker/dockerfiles/debian-loongarch-cross.docker b/tes=
ts/docker/dockerfiles/debian-loongarch-cross.docker
> index 79eab5621ef..538ab534902 100644
> --- a/tests/docker/dockerfiles/debian-loongarch-cross.docker
> +++ b/tests/docker/dockerfiles/debian-loongarch-cross.docker
> @@ -43,8 +43,8 @@ RUN curl -#SL https://github.com/loongson/build-tools/r=
eleases/download/2023.08.
>  ENV PATH $PATH:/opt/cross-tools/bin
>  ENV LD_LIBRARY_PATH /opt/cross-tools/lib:/opt/cross-tools/loongarch64-un=
known-linux-gnu/lib:$LD_LIBRARY_PATH
>=20=20
> -ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
> -ENV DEF_TARGET_LIST loongarch64-linux-user,loongarch-softmmu
> +ENV QEMU_CONFIGURE_OPTS --disable-docs --disable-tools
> +ENV DEF_TARGET_LIST loongarch64-linux-user,loongarch64-softmmu
>  ENV MAKE /usr/bin/make
>=20=20
>  # As a final step configure the user (if env is defined)

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

