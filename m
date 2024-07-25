Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65139C3DA7E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 10:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWvUE-0006cm-Uv; Thu, 25 Jul 2024 06:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sWvUD-0006We-6X
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 06:14:13 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sWvUB-0007C5-9E
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 06:14:12 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-595856e2336so1236444a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 03:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721902449; x=1722507249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oaVuSzjCd769g598xAbZ0xUurICMeyYA4zs1YaIXjaI=;
 b=VHrTxptSTMKcFTiZd2Jy7PXhz8HCjZUYiEPrDWZ59/Q+H9aeDt9odW9N4V07kW4huS
 w+x5eywhdgK/zDEXVVMYTSk1jGYpANElG5sNnpQOf2dH3EkJEufXiN0MfwApRjUXJNM+
 OsBgA2X5UrbyN6bdYtNhlGrWuDfQNh5Icg3LxPWN6RVeYUPhz2j+0QOmKsiGyGbkcMxt
 puEceJIhX2wVYyXFwWtyPI7NwSHLtm1lXx29jailGbR1ZIvGsUfH/EOZEi7RIhjfgt7B
 KNmvrkt4j/WI6IFOQmVRMIzOEs6mF+H1cfCmbwssDD4z/XZAYXx2fFov38ci/QkVyybk
 b3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721902449; x=1722507249;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oaVuSzjCd769g598xAbZ0xUurICMeyYA4zs1YaIXjaI=;
 b=L1JYTNS/H8VF+XuJ53NtG75XMAVo+EPI5AxDB2CyQO5og31LsGilam8Rgotf7oUSLy
 GZVr+bCZ+jFfqD72f8kRHjh9XbK7NbNMu6D8gECqIRjiJ7FZtK62GTSBJZgM3D1IKY1d
 +ZfNOz6dD6SBX9sNg15GSbXUpsXmAD/C+mjcaX+529XRK6WZQL2g/+2Iq2TH86KBsy8M
 F/9Up+bXP7Lt5hBP29BdqTVBRJIL+F/XCYUrySxrp1zwlyvPhWXF2hwhHmjqs9tkNLcq
 7H8QJbMIi9Im77P5/yLB4b1QLEVpyngvG9SRj9B+ZVuMryfe72yWZD7lhcFY9E2vbLZo
 ZJPg==
X-Gm-Message-State: AOJu0Yw3xswu5JSgUQS1nv9QelwOtXVfR+Kh98zhPBNPePaCJq6mr00o
 qqhyfYVJpXefV8+NUhnkOqA1uHW9+uRyC9absgJb4xn6NAK+S6wsSj507XtMatI=
X-Google-Smtp-Source: AGHT+IGSQ6GSyyMqRCAKFCMe5kXcCIATkdHc3vuSCWgu7gsNwKxK4W5fLXLf49jbbuDTxheYaT2Qpw==
X-Received: by 2002:a05:6402:27d4:b0:5a0:edfa:e5a9 with SMTP id
 4fb4d7f45d1cf-5ac141eb32emr2634705a12.12.1721902449237; 
 Thu, 25 Jul 2024 03:14:09 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac63b59cbbsm651758a12.47.2024.07.25.03.14.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 03:14:08 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8934B5F863;
 Thu, 25 Jul 2024 11:14:07 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9=20?=
 <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Beraldo Leal <bleal@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 0/2] gitlab: expose installed package info in build logs
In-Reply-To: <h6b6l.5yloo5aflex@linaro.org> (Manos Pitsidianakis's message of
 "Thu, 25 Jul 2024 12:42:18 +0300")
References: <20240724095505.33544-1-berrange@redhat.com>
 <h6b6l.5yloo5aflex@linaro.org>
Date: Thu, 25 Jul 2024 11:14:07 +0100
Message-ID: <87a5i5ok28.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Hello Daniel,
>
> On Wed, 24 Jul 2024 12:55, "Daniel P. Berrang=C3=A9" <berrange@redhat.com=
> wrote:
>>Many times we see a build job start failing, we wonder if the installed
>>packages have changed since the last passing build. We can rarely
>>diagnose this, however, since we only have the new container image, not
>>the old one.
>>
>
> APT allows you to specify to pin package versions when installing;
> wouldn't that help ensure our tests are deterministic?

Generally we want track the latest LTS version and usually the distros
are pretty good about being cautious about updates. I think the recent
case was because BSD's have a different policy about updating python.

IOW this is a nice to have for debugging but I don't think we want to
freeze the acceptable package set for any given install.

> Furthermore, a gitlab cron job pipeline can be set up to run every
> e.g. few months and inform of any updates so that we can manually bump
> them.
>
> Manos
>
>
>>The lcitool generated containers create a /packages.txt file whose
>>content is intended to be output in the build phase, so record the
>>packages associated with the build.
>>
>>This adds packages.txt to the manually written containers, and modifies
>>the build jobs to display this content. This will improve our future
>>debuggability of CI problems.
>>
>>Daniel P. Berrang=C3=A9 (2):
>>  gitlab: record installed packages in /packages.txt in containers
>>  gitlab: display /packages.txt in build jobs
>>
>> .gitlab-ci.d/buildtest-template.yml                      | 1 +
>> .gitlab-ci.d/crossbuild-template.yml                     | 2 ++
>> tests/docker/dockerfiles/debian-all-test-cross.docker    | 3 ++-
>> tests/docker/dockerfiles/debian-hexagon-cross.docker     | 3 ++-
>> tests/docker/dockerfiles/debian-legacy-test-cross.docker | 3 ++-
>> tests/docker/dockerfiles/debian-loongarch-cross.docker   | 3 ++-
>> tests/docker/dockerfiles/debian-tricore-cross.docker     | 3 ++-
>> tests/docker/dockerfiles/debian-xtensa-cross.docker      | 3 ++-
>> 8 files changed, 15 insertions(+), 6 deletions(-)
>>
>> -- 2.45.2
>>
>>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

