Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF14C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 18:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCNmU-0006at-A1; Wed, 29 May 2024 14:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCNmS-0006Zh-At
 for qemu-devel@nongnu.org; Wed, 29 May 2024 14:12:08 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCNmP-0006v8-4x
 for qemu-devel@nongnu.org; Wed, 29 May 2024 14:12:08 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-57a033c2e8eso20478a12.3
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 11:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717006323; x=1717611123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JKfuKxYZMtCyiFGKAW/HXBYYWxb55If/KdtPPMsmovc=;
 b=WO2LBASZxk1Vd6gYwcefUE5vlvQkerKnjTAvE/BfXCNNSCYWTZ2fVSuUsTU4kfB1w/
 hv4dl3syBFQ01BVHeV+I87NA+ICAQ8aDNdC6mJbUhQlkKoybHKzCkq6jnLEj90u/XVZk
 wxQtOX06rA/wWefiLjXAS+JX/an6K3txk3pPMfXZnN963x0hNIfamHGUQwDumF2AgAZy
 Pg6Hi80SnsB7Td0d9oZSe8r9PezY2JT79ijjq2s2ag5J3pLrOCjUdumHSt0PL2yHD0xn
 YvKNsg04fEfAuNgMrM/1qbzLkxTOwNGQHQ8Uo7ppp6yPThTeXfept0EYa8dGXM1VsKiR
 iPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717006323; x=1717611123;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JKfuKxYZMtCyiFGKAW/HXBYYWxb55If/KdtPPMsmovc=;
 b=szxaWBaXkACrb7l8qfX8T/epasBDWzxHw7UYNUN0JEEsgZF3EH25tJl9MTUgpWdzl+
 bEBaS1EamvjQImAopNc8bbt9WytY8AV7RIpso/7faaqjPQjP2fwILHIHUozx/nRSad/E
 fmeNLx4OG/UHPLSlAQSCPagwJ1K9CGxfuDu7UYMRQj80tNsfi7f4+uXfuvh4Gel5d6Cy
 y4m7+KlG9NdiWpuaDKdUeqbE0+I0NM2tSkh0eFhgYwbzC33WoG5Csw0hofJMhdPs/WXi
 p0H7PeXbFX4QMtLGCEA7Rg3nJaawDvNr8WdfAGNONVzPJz3onDTWhoinmbQW7EoUPqDa
 z49w==
X-Gm-Message-State: AOJu0YxHCgOYshXHcIYCmS/CyXYoOM/bJDaXUzlK53sYZBQMf3yt43Dm
 DZ1EafbW9qDsK/lxvw1tsOSqbmN1R7rBYL6jK97eT1gOJSMFYMWbrv4a8Kd6jm8=
X-Google-Smtp-Source: AGHT+IHggDZ1RY5VVsKNvnw6ycK96qXKgPVEl12of1HOWw7eZ8arB6M+7TypY0j1rMJ0U4n11DCAfg==
X-Received: by 2002:a50:aa84:0:b0:56d:c928:ad76 with SMTP id
 4fb4d7f45d1cf-57851a8daebmr10155675a12.26.1717006323191; 
 Wed, 29 May 2024 11:12:03 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-579d0d5aba4sm4758485a12.71.2024.05.29.11.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 11:12:02 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 092405F760;
 Wed, 29 May 2024 19:12:02 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,  John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Pavel Dovgalyuk
 <pavel.dovgaluk@ispras.ru>,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>,  Paolo Bonzini <pbonzini@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,  qemu-arm@nongnu.org,  Joel
 Stanley <joel@jms.id.au>,  Aurelien Jarno <aurelien@aurel32.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Marcin
 Juszkiewicz <marcin.juszkiewicz@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  qemu-s390x@nongnu.org,  Radoslaw Biernacki
 <rad@semihalf.com>
Subject: Re: [PATCH 07/10] tests/lcitool: bump to latest version
In-Reply-To: <8a71fea1-9446-458a-a30e-4b98ab75c410@redhat.com> (Thomas Huth's
 message of "Wed, 29 May 2024 19:23:15 +0200")
References: <20240529160934.982373-1-alex.bennee@linaro.org>
 <20240529160934.982373-8-alex.bennee@linaro.org>
 <8a71fea1-9446-458a-a30e-4b98ab75c410@redhat.com>
Date: Wed, 29 May 2024 19:12:01 +0100
Message-ID: <87cyp4ebda.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> On 29/05/2024 18.09, Alex Benn=C3=A9e wrote:
>> We have to simultaneously update a few bits on our side as lcitool has
>> already deprecated fedora-38, alpine-3.18 and centos-8-stream. However
>> there is no change to the package list yet.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Have you tried a CI run with these changes? I don't think this will
> work yet. There are various issues with Fedora 40 that we need to
> solve first. Some of them are addressed with patches in my pull
> request from today, but others need more work first:
>
> - Avocado v88 is broken on Fedora 40 due to the missing "imp" package.
>   I've got a pull request for lci-tool pending, but it is not merged yet:
>   https://gitlab.com/libvirt/libvirt-ci/-/merge_requests/489
>
> - The "clang-system" jobs are failing due to the new -fsanitize=3Dundefin=
ed
>   errors that it discovers. Question is whether we want to fix all of the=
m,
>   or whether we disable the error detection instead.
>
> - build-oss-fuzz job was failing, but that should get fixed with the
>   patches from my PR from today (thanks to Alexander Bulekov for the
>   patches)
>
> So unless I missed something, you've got to postpone this patch a
> little bit.

Ahh yes I see failures for:

  build-oss-fuzz
  clang-system

https://gitlab.com/stsquad/qemu/-/pipelines/1310569965/failures

>
>  Thomas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

