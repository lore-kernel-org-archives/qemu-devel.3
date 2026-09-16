Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4876DC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 11:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6nou-0006Zm-Ae; Wed, 16 Sep 2026 07:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6nos-0006Ze-Jv
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 07:28:54 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6nor-0000db-2m
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 07:28:54 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b965f447cso7174165e9.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 04:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789558131; x=1790162931; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=r+TbMKsqCv4o4KmHQTuvDDj2hNt8/u7hIWMeRF+sdlw=;
 b=OXRnJIdY28Pe7WV2IBN+r8DGSVt3c1zcUlKAxaVeAS4mEx8vIH9COBJT3Hp3kOR/qu
 wSa4mvMfyoE/GieSVAwQDE6YO/MuAQgvFC6pC1NAUFVpAk1xLdScJKQCX+YOGNhus1Iz
 MOlXe+ydE2UqwIihkOQylHcKBIm2JxNz3wUEF76YY95u/0AwKs3jOGSvSdieWBy6a1+3
 S7ZARy271pvLa9Y9L1sts/lArWmYvv+q70YNJyR1FVNZVc24TWcp8X48Pnh4wgcO4ZO+
 B9cWk/bKCAwMTPzZ8hXxOD0ESe2RcF53IPZ44rBI8dVduV56WTWr1e7zmAJxp/MMuFpc
 YVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789558131; x=1790162931;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r+TbMKsqCv4o4KmHQTuvDDj2hNt8/u7hIWMeRF+sdlw=;
 b=rceFacOOxRCoVCwO1fQbSBh/IDZIMNEPJZE1JwxRAdOq80v3epo6Xn77BQpt+I4VXG
 2pCe4JplpWUeGfV5tEdtfBIBLzrZEEAURix/8Cp9cAguek7wJ+YIJsjXL72WynE6Zd/B
 GqVrmFM1uu4vYB7xZRbYMrY6EPe4pWQXnzkR3SvTGWSX59zN1Cv6h7ZwI+YbBMOyXxbN
 TKQ3tHdNoR4nXmhWajJvpJpZj+zQyfr8ebifRf11kLYs1j85pYqgp78ImK3shDMSuLWB
 uW/G5r7Yi5C4f3tX+wzHkCxgBQsVyIwGapl2vAdORIhqcDRj4H8deniqpLa3t9ZPmN0H
 9VOA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9yAxOe4onyYuLOSYqlrg+SOyDP5B790aKTz1rffk11bWeIRTajkMQkzg+GgvUBqws5zfMbrfXPSve@nongnu.org
X-Gm-Message-State: AFuF++msx4C6vZHeDHA4eGMlFTnRBx19h2tbyOtWL6qm+BxRW4rwKYP1
 bWKVso8nvakUWtrpmbf6JCpDGawyOreff2ioRsgmXYc3WsScclLArH7sj8m2Xt9W6Ec=
X-Gm-Gg: AYBFou2tJFcSD8hQNHcd27tiq+AHT7TLI53W2KUFA9hbQsUDq8CdgbBQ/dQTyvasdfs
 GIOe094FMWENKb3fDmBynVwxpOkPR1t4UI0yIU2dzVc1SVXp3qdefqHGmcSzpKapp4RpZ7wtm3p
 9ucJxfF1jh+9/Sguf2jwvs5QFJ7TKezyngrou7U1+9XNE/O9onkcfSxm7AXZat6Yf2NoV80Wx31
 8xq4TqombtLY0B2zsC7ZH8nB6GeiFJVe3R6viUcRIeA5LQeDhXAJTYbv56t9L3U0TxR4J1P0tix
 +3f43pw1aVW0LIIZz4zH3ED1+yQro3S/pWol8rm5pbyNQJ9oJS/XqdICjc8q/jpVaNkCF/6TrZZ
 9jWgNA+d72kn/OCJm238o+IlxFKoNmTqIGOwd+FdhSAr122ris1UsArmmbe6r1Sr8X0K4o23CgD
 s7bQErbw8prZNhr+VaMy0oQRa89rtEV09EdNW1PzhM8YiUASUESwm4cSjhFpC4MSsO1G8iSq8=
X-Received: by 2002:a05:600c:a00e:b0:49c:fa20:cc07 with SMTP id
 5b1f17b1804b1-49eb7336c57mr27420175e9.30.1789558130885; 
 Wed, 16 Sep 2026 04:28:50 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83fca34asm62137345e9.1.2026.09.16.04.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 04:28:50 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1A9895F8A6;
 Wed, 16 Sep 2026 12:28:49 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/tcg: Fix building outside of the source tree
In-Reply-To: <20260915110855.491985-1-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Tue, 15 Sep 2026 13:08:41 +0200")
References: <20260915110855.491985-1-iii@linux.ibm.com>
User-Agent: mu4e 1.14.4-pre3; emacs 30.1
Date: Wed, 16 Sep 2026 12:28:49 +0100
Message-ID: <87ik45a0zy.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> Running TCG tests from a build directory that is outside of the source
> tree fails with:
>
>     [...]/qemu/tests/tcg/multiarch/libs/float_helpers.c:228:1: fatal erro=
r: opening dependency file tests/tcg/s390x-linux-user-float_convs.d: No suc=
h file or directory
>
> This is because the build directory is not mounted into the container.
> Add this mount. Do not bother with preventing overlapping mounts, they
> are harmless.
>
> Fixes: 27939ad414ca ("tests/tcg/meson.build: introduce cc_dockerfile and =
cc_docker_host_arch")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

