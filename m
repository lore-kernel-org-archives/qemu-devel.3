Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5387CFA45F
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 19:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3hNB-0001cc-P1; Wed, 23 Oct 2024 15:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3hN0-0001R7-1x
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 15:50:14 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3hMy-0002w4-Da
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 15:50:13 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a9acafdb745so43109666b.0
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 12:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729713011; x=1730317811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TO68iZnepJw334fPSI7Z4+EQd9QOE9ii+8YTx70Fn+Q=;
 b=N12evC9jvCgzgOOaMeYy7fkJEGaPezGjkwTVHk0+Bquwn8ZG+XAnPqwdiFtCkIMFH5
 1/fz0M+2C2wLqZwH9hBKCeQLfQwmNgx3L9WE/NS5yKgigxw6geDzFxxVBH7LJxKnFLB0
 ukn9DPQY9GwrRPhj6IFeSyX+T7GxmyzhfRu9vt+rkNJuHV9MG7EQjTJahJ9VQ6/5yVfc
 KhXurQiCOsLKZTfAYMxxKpAWehVN7O4R35ap/Dey5ed0K102EWAl5d5bB72vO2v9E/84
 GCbR3aiCgKtsJq0QeoowQOkczvtX9ktqU0GFasfzdB/lqhJpHzVgXoGWym1idKm/a9iz
 O0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729713011; x=1730317811;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TO68iZnepJw334fPSI7Z4+EQd9QOE9ii+8YTx70Fn+Q=;
 b=G7R07jGyekskB9NFtv7twaMM5Mk8FwDajrfcU8ONmrnvoiXTQSiGAFpY4STxizyCYR
 6i8IEipr5HvCv21Ifde05Cm8VqDlief4r83DvhuAWzpYeGLfywLvi0IdrFyT+7PfWoSb
 OMRHv/XbTbqdXyVtRwEKwME9qeCSyM6H3/1yvEU3qarLOlDtmKJ5T3YP9Un+BQ91r9zB
 /jLJ5NNMPvESIaKZqgzxnXG3gIQN2Hueanzr8t0+Ux7iIDA0FTMk36r0PwzvxIwwqGWP
 HueAJbPTsV8UC3F+SFfURDkiNcIvAF4Tdy2jbRlBqycvPKWsHyVT7vT4IeZIihk6zx8j
 a1QQ==
X-Gm-Message-State: AOJu0Yy8fGBDIdBi0i3gOFw2xP73sHe73JI1qZtG1EFWKQSD+2Y9sbcH
 sFVmocClNmfFyrwNnH88zTc/kahfQ2+CK/ZMPUpnDes5DZQtR+EXv99vGsfFi38=
X-Google-Smtp-Source: AGHT+IGSKqpaDX1qOVzHrqyI3vRqdvg6fchDJQJa1VT4vKWcdq3SGhKuCvbpadn51tS+AhCMcbvomw==
X-Received: by 2002:a17:906:24ca:b0:a9a:c57f:964b with SMTP id
 a640c23a62f3a-a9ac57f9c6dmr221059566b.8.1729713010808; 
 Wed, 23 Oct 2024 12:50:10 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a9159a1a6sm514900366b.204.2024.10.23.12.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 12:50:10 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 65AAC5F897;
 Wed, 23 Oct 2024 20:50:09 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Stefan Weil <sw@weilnetz.de>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Jason Wang
 <jasowang@redhat.com>
Subject: Re: [PATCH] tap-win32: fix format-truncation warning
In-Reply-To: <20241023183009.1041419-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Wed, 23 Oct 2024 11:30:09 -0700")
References: <20241023183009.1041419-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Wed, 23 Oct 2024 20:50:09 +0100
Message-ID: <875xpilhu6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

> Simply increase destination buffer size so truncation can't happen.
>
> "cc" "-m64" "-Ilibcommon.a.p" "-Isubprojects/dtc/libfdt"
> "-I../subprojects/dtc/libfdt"
> "-ID:/a/_temp/msys64/mingw64/include/pixman-1"
> "-ID:/a/_temp/msys64/mingw64/include/glib-2.0"
> "-ID:/a/_temp/msys64/mingw64/lib/glib-2.0/include"
> "-ID:/a/_temp/msys64/mingw64/include/ncursesw"
> "-fdiagnostics-color=3Dauto" "-Wall" "-Winvalid-pch" "-Werror"
> "-std=3Dgnu11" "-O2" "-g" "-fstack-protector-strong" "-Wempty-body"
> "-Wendif-labels" "-Wexpansion-to-defined" "-Wformat-security"
> "-Wformat-y2k" "-Wignored-qualifiers" "-Wimplicit-fallthrough=3D2"
> "-Winit-self" "-Wmissing-format-attribute" "-Wmissing-prototypes"
> "-Wnested-externs" "-Wold-style-declaration" "-Wold-style-definition"
> "-Wredundant-decls" "-Wshadow=3Dlocal" "-Wstrict-prototypes"
> "-Wtype-limits" "-Wundef" "-Wvla" "-Wwrite-strings"
> "-Wno-missing-include-dirs" "-Wno-psabi" "-Wno-shift-negative-value"
> "-iquote" "." "-iquote" "D:/a/qemu/qemu" "-iquote"
> "D:/a/qemu/qemu/include" "-iquote"
> "D:/a/qemu/qemu/host/include/x86_64" "-iquote"
> "D:/a/qemu/qemu/host/include/generic" "-iq
> ../net/tap-win32.c: In function 'tap_win32_open':
> ../net/tap-win32.c:343:19: error: '%s' directive output may be truncated =
writing up to 255 bytes into a region of size 176 [-Werror=3Dformat-truncat=
ion=3D]
>   343 |              "%s\\%s\\Connection",
>       |                   ^~
>   344 |              NETWORK_CONNECTIONS_KEY, enum_name);
>       |                                       ~~~~~~~~~
> In function 'get_device_guid',
>     inlined from 'tap_win32_open' at ../net/tap-win32.c:616:10:
> ../net/tap-win32.c:341:9: note: 'snprintf' output between 92 and 347
> bytes into a destination of size 256

Is the compiler min/max maxing what UCS-16 or UTF-8 might pack into that st=
ring?
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  net/tap-win32.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/tap-win32.c b/net/tap-win32.c
> index 7edbd716337..4a4625af2b2 100644
> --- a/net/tap-win32.c
> +++ b/net/tap-win32.c
> @@ -214,7 +214,7 @@ static int is_tap_win32_dev(const char *guid)
>=20=20
>      for (;;) {
>          char enum_name[256];
> -        char unit_string[256];
> +        char unit_string[512];

If this isn't perf sensitive code lets just get rid of this stack
allocation and be done with some autofree'd g_strdup_printfs?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

