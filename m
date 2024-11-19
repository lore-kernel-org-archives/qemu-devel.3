Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69206D44140
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 11:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDM5v-0001bX-4J; Tue, 19 Nov 2024 06:08:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tDM5i-0001Zn-Ot
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 06:08:20 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tDM5g-0007fs-NG
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 06:08:18 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4315f24a6bbso6536365e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 03:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732014494; x=1732619294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OA35qGKA1PYzW1hCJKI3KnfR1onBpi5o5r+SH8+tXqc=;
 b=EODDklE5h0GskRn2qvfh8oxKBh1/2jUBSG7svXf9UvQ2U2uwEijmb8e+CSW6ZpiCB0
 8BsrtqOSFFXQchEziKuKOq2PDEtSPwImgxKAaNTyohKoGe/066k/FgLDxPF/xstNhzlS
 SW3G4dZDIMwlzH3BcZibDGPLqD27RgD37EKOgB0gZblsqzhmehOVsicKUXQHVnKgk3Fw
 EeiHe5demYFwIscGXS2MQsImUNcS8yCyrygp/milPqkVQqeV7Z2CSEPtvvQFFKOmtjUc
 wmTqKoR4ex283aDED5IWYEZmabCvKZdrZCfUKSah5pjWbVYLk35ll7FpYlD+7w9QT0gN
 ANLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732014494; x=1732619294;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OA35qGKA1PYzW1hCJKI3KnfR1onBpi5o5r+SH8+tXqc=;
 b=ErvGY6oUblTtbiO2gdp40tboL5ItOQtNhfQbiJAdQJzaHKg4aWkj8F1FB/sgXkCq0N
 zx4Z3SC8sXGvxQmR5qAQG89rCU51KI6gcG1u9h34fheIH3OItFCSSAvo+Aft5+EUXAWc
 c+ZuAQKHs01cYB5vu0HhxsJjuQQdRIH00bMsPTPdnYqDhLHY6LCnS60cjgTicdD7o9jL
 x1CHtKPoJvHHdp8MzE8Z3KN8tvv6opS+SmcIaLnwaDqA/pOIiYxfA4BhifTrz3aHePun
 ARt04aGg3VFlgkZs3Zq9baBHMvUcV+xhZBzxJMMBCflm+QdG/WlA9oU3qsNCrjcavbZx
 95jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP8G0FOdIybPD0bb/uriJI2S5Qayxcz78iIkwlUihRjVYthDHO3glwjGMUHVRAl3mmHPG2BMC8+3dn@nongnu.org
X-Gm-Message-State: AOJu0YzOHezlRpGb7R7DUN8x65l6c550Hm0deD1pcYSXqm5s2sM+Qn93
 EHH/W+QnQsK/37OlMfY1Zj73OL9AC+rNRIzJVovezs+A8cGnv2nnmTZVgcAdLEU=
X-Google-Smtp-Source: AGHT+IEvWSu3BfW3W4izliFBePqCFdRYU6H342434LUMxGIcALTN7IweDb/pCbvZDJptP+Y3VjlEZA==
X-Received: by 2002:a05:600c:4e8b:b0:431:4f29:4a98 with SMTP id
 5b1f17b1804b1-432df77c605mr126318945e9.20.1732014494208; 
 Tue, 19 Nov 2024 03:08:14 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab788a2sm187715225e9.11.2024.11.19.03.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 03:08:13 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E380F5F769;
 Tue, 19 Nov 2024 11:08:12 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,  qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard
 Henderson
 <richard.henderson@linaro.org>,  Andrew Melnychenko <andrew@daynix.com>,
 Jason Wang <jasowang@redhat.com>,  Thomas Huth <thuth@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Fabiano Rosas
 <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,  Markus Armbruster
 <armbru@redhat.com>,  Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org,  Yuri Benditovich <yuri.benditovich@daynix.com>,
 manos.pitsidianakis@linaro.org,  qemu-block@nongnu.org,  Michael Roth
 <michael.roth@amd.com>,  Konstantin Kostiuk <kkostiuk@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Peter Xu <peterx@redhat.com>,
 gustavo.romero@linaro.org,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 4/7] docs/devel: add information on how to setup build
 environments
In-Reply-To: <ZzxZRwXAIlMt6SNA@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 19 Nov 2024 09:24:23 +0000")
References: <20241118172357.475281-1-pierrick.bouvier@linaro.org>
 <20241118172357.475281-5-pierrick.bouvier@linaro.org>
 <ZzxZRwXAIlMt6SNA@redhat.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 19 Nov 2024 11:08:12 +0000
Message-ID: <87mshvqy5f.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Nov 18, 2024 at 09:23:54AM -0800, Pierrick Bouvier wrote:
>> MacOS and Linux are straightforward, but Windows needs a bit more
>> details.
>>=20
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>  docs/about/build-platforms.rst   |   4 +-
>>  docs/devel/build-environment.rst | 114 +++++++++++++++++++++++++++++++
>>  docs/devel/index-build.rst       |   1 +
>>  3 files changed, 118 insertions(+), 1 deletion(-)
>>  create mode 100644 docs/devel/build-environment.rst
>>=20
<snip>
>> +Fedora
>> +++++++
>> +
>> +::
>> +
>> +    sudo dnf update && sudo dnf builddep qemu
>> +
>> +Debian/Ubuntu
>> ++++++++++++++
>> +
>> +You first need to enable `Sources List <https://wiki.debian.org/Sources=
List>`_.
>> +Then, use apt to install dependencies:
>> +
>> +::
>> +
>> +    sudo apt update && sudo apt build-dep qemu
>> +
>> +MacOS
>> +-----
>> +
>> +You first need to install `Homebrew <https://brew.sh/>`_. Then, use it =
to
>> +install dependencies:
>> +
>> +::
>> +
>> +    brew update && brew install $(brew deps --include-build qemu)
>
>
> The downside in recommending the 'build dep' approach is that it misses
> out on deps that have been newly introduced in qemu.git, since whatever
> old version of QEMU the distros are shipping.  It also misses deps for
> any features the distro vendor has decided to exclude.
>
> Can we put a caveat describing this limitation at the top, so that users
> have pointer if things don't quite go the way we expected.

At a recent QEMU workshop I presented I pointed to lcitool as a way to
list the minimal dependencies QEMU needs:

  ./tests/lcitool/libvirt-ci/bin/lcitool variables -f yaml debian-12 ./test=
s/lcitool/projects/qemu-minimal.yml

It wouldn't be the hardest thing to extend lcitool to generate a pkg
install line instead of a list. Although I notice it fails with the full
set of dependancies:

  =E2=9C=97  ./tests/lcitool/libvirt-ci/bin/lcitool -d tests/lcitool variab=
les -f shell debian-12 ./tests/lcitool/projects/qemu.yml
  Package generic name resolution error: Package libcbor not present in map=
pings

I note there is already an "install" action but I'm wary of what it does.

>
>> +
>> +Windows
>> +-------
>> +
>> +You first need to install `MSYS2 <https://www.msys2.org/>`_.
>> +MSYS2 offers `different environments <https://www.msys2.org/docs/enviro=
nments/>`_.
>> +x86_64 environments are based on GCC, while aarch64 is based on Clang.
>> +
>> +We recommend to use MINGW64 for windows-x86_64 and CLANGARM64 for windo=
ws-aarch64
>> +(only available on windows-aarch64 hosts).
>
> Does CLANGARM64 really work with QEMU ?   We go out of our way to actively
> block the use of CLang for Windows because of its lack of support for
> 'gcc_struct' attributes, so I would have expected it to fail
>
>> +
>> +Then, you can open a windows shell, and enter msys2 env using:
>> +
>> +::
>> +
>> +    c:/msys64/msys2_shell.cmd -defterm -here -no-start -mingw64
>> +    # Replace -ucrt64 by -clangarm64 or -ucrt64 for other environments.
>> +
>> +MSYS2 package manager does not offer a built-in way to install build
>> +dependencies. You can start with this list of packages using pacman:
>> +
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

