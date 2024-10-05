Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F346CF887E
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 15:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx6ah-000135-Q5; Sat, 05 Oct 2024 11:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sx6ah-00012x-3d
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 11:21:07 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sx6ae-0001tN-3G
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 11:21:06 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a993f6916daso56681966b.1
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 08:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728141661; x=1728746461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hPgYivma3MPUSXjHSgc2z4T9z+xiuUMOICwmw1bi3+s=;
 b=tuGUWNIZriS0XKWVRVEVYZX3HbR/96+WIvtMxDyUa8JZepS06lQez214uPyuI/K9Gh
 PxJ5krx/dd2WF91X8N5DXB9V6hHA7mYmqtuU3ujkbbFDlNTlYNbRPnkjsfKX2jAlDwL2
 MR5bWfJ8sHhkm6YiT23oVqNQdPxOLCkOk4qW3cBBAvrZ9epliavOW4VOIJWAaIkm/bEf
 U6QSms6/MZmMmiapMB7jR7lf/soBBs44S5k47dCjRUsKwLKiwWNaCTBHbgPcI8jZVl70
 scCusu0Zd33D8rWxd1YO5+joYfPf+YcsF9Wjkb96SNWViKGOJhy/0ubrsgw628lF2g7t
 mySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728141661; x=1728746461;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hPgYivma3MPUSXjHSgc2z4T9z+xiuUMOICwmw1bi3+s=;
 b=PMr6Lqtjmn28i/vLoTB4hAKWHSwS5BmTtyDhnOQvoxVE+eb0ZD4xmTUL7HvFPJSg6N
 u8HmVT/bpJq8WfCoPGxLf7Q+3M1koxuo53o4cDY9MXwQeq6xrWTU4SD8Ft7wu+iIHLb+
 wZyDYVVEUH3ylSV7S5c/2Ft4Al+hnGylmPIV/GYwmFEnL31bkU+kwfh6kgYTTy2tAsHa
 xbTI5h9tS3erqhvizBgWS6bhW4Ez7wJt3Q71RVU7ZDbNbCJAJap6wa0HpYd+VqTz7iVl
 RUXk0RQbGM9O50iS7LYk2gQ5Q5UZt1LSPLA0a5vujJYem9RsvNgYnZ0ghTZI5fecIH9g
 YzHw==
X-Gm-Message-State: AOJu0YxnANYOIzdmp4WelqqUkmGlPsklAx8qh8GsKG5UN0tw26VclDd+
 /kAJkrEYw/SQH3EWY+SZKaT2J3EorTFxiz45TR0BrD5YVdTqM1sUvgdCBR4FXt0=
X-Google-Smtp-Source: AGHT+IHwaNND9kHFI1nvZqUt8zn6lodCktdv44UBp25YI7FoORL9+USLHvY0OUktU9HtMJQ7WugU9Q==
X-Received: by 2002:a17:906:cada:b0:a86:9ba1:639e with SMTP id
 a640c23a62f3a-a991bd729a1mr577129366b.26.1728141661022; 
 Sat, 05 Oct 2024 08:21:01 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9936e62450sm112266266b.46.2024.10.05.08.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 08:21:00 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8FFF55F844;
 Sat,  5 Oct 2024 16:20:59 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] meson: fix machine option for x86_version
In-Reply-To: <20241004223715.1275428-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Fri, 4 Oct 2024 15:37:15 -0700")
References: <20241004223715.1275428-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Sat, 05 Oct 2024 16:20:59 +0100
Message-ID: <87ploe1spw.fsf@draig.linaro.org>
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> s/mbmi1/mbmi/
>
> When configuring with -Dx86_version >=3D 3, meson step works, but
> compilation fails because option -mbmi1 is unknown.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

