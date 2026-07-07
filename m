Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EEAC43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 09:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh277-0005df-1Y; Tue, 07 Jul 2026 05:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wh275-0005dQ-H7
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:29:11 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wh273-0006OO-HU
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:29:11 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-493ba701891so31501875e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 02:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783416547; x=1784021347; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9SX8P8YQSX1RMvC4a4eo8SGvPo1kIPi7vjOe/8w9z2g=;
 b=FS5cfXtmDmAG0yhg/GHYROvj0s7/RR/EvRgrfenIL5jyPyBxO/nIoR1Ie5HW7dFMkj
 FgbI+KG2NlzZTaw1t63twgyQJyX9vj+1Ot56eVwY9rkg8OFpjgSG+dElelW8Z4XhE0U2
 hpCtke426bUyeFCJemQTE1fRz2If1VqxEnMLnet6TFqxlPb3pBLbD8ZuwSfqVUlOKaM5
 LEv2ydqFNmmYQex8wIOEwUR5iJwDhjvphGsENSrTsWF8r1ZAf8L2Osxqb4USYHrb2/+K
 CBX6GTk56AY1LCijhMWZO3kbHZjmu35lPCs9l6uAOz/1H6cK2B4AiGH+vaNReCLV18MO
 N4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783416547; x=1784021347;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9SX8P8YQSX1RMvC4a4eo8SGvPo1kIPi7vjOe/8w9z2g=;
 b=h3kxQUBlV/GS1PX2TZJ84CgCSUuIrsT4ntvOljKAhWoy8g6M439vTG1zMELvflwaAy
 MG0BhSpcWXiwUuWC37pZ7zy3pfCgtBm9t1jeksi5mYDvQcDlhBbNpqIzZAkcj2ZlPfE2
 JJcbg9+1bOFXpkCwtWx6AbNNCmPMDWExrz3J4uCe/B70ffhX0E7wmCCkcI6rWpB8ROp5
 jVkXKh2S7H+wCPSIFWL2AHgqZ8RqXhx1ANsPiFhfRYDAJzkTQhM2txzk60ML+dM3lzU8
 pNu5Yjt2CGJ5XRUyKZV4+mUrEFiLFDxjKh+Oh91kMhU5BdFip83u//w4OnxnlpYKPn/C
 j7nQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+jbNoNc+dN1kkyBa+6bsOswv+y3PhYeKW18JoBfjhXrDd3qPpXnrlTNEDbo4fgTaz8qir8Y53fA8M@nongnu.org
X-Gm-Message-State: AOJu0YxI32UdLvKQverDfZcnYvlGAlXJBvzWXuKunHkOuTX6tIRVwGrY
 7DlbT1Rz1z88EuMjK8FD6LRMigOxS3dXKnS1hjX6GlHGA4HZPE+sMW9gPT2Hq3Jl+QI=
X-Gm-Gg: AfdE7ckaIcZoe3gyKTYnMguIKF/Q1d5LpmihSoJLppA+eRrPdy6jSFwPTMwBcAR8D/H
 dDMS1rhfW8br62l90CQCBqNXawEW5sXZjiDIsyF4jNGuHn4q1J07cH2bByi2JnHFf1Yu5Gy6o9N
 71O90dcA06v/ybqAeiZoB0l7/6jjEjeRB8UElxHOnPP7GXs57xVn856nRU/hic5M7F71oZ6BhsE
 yPEN2OohW4IWAJ6l10HWdq9wod3ZPrkN7Ukpc6TQDhsvfBEoW4YPL1j3BAMrxYAej+akpK4eCF7
 Lht4BwH+XFRNiWke5r9nL/Y8b/9/g0OFk0TxeMjyJAVW7iDgfWBmkKDP8dbEfyBaY5A5Jao3wsi
 vaqvpDG7yA+GdrTJ8zWC67A0Qo8DFDmilOEDl74YHu3fhx5timyw+ur+xmg8BO9eP05xbcY7yNt
 o9fbGz0RGZBgr6
X-Received: by 2002:a05:600c:474a:b0:493:c062:a533 with SMTP id
 5b1f17b1804b1-493df0673f8mr51365415e9.17.1783416547383; 
 Tue, 07 Jul 2026 02:29:07 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f5b811sm65019365e9.13.2026.07.07.02.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 02:29:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 51B805F7E4;
 Tue, 07 Jul 2026 10:29:05 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  Michael Tokarev
 <mjt@tls.msk.ru>,  Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Subject: Re: docker-image-debian-all-test-cross errors
In-Reply-To: <5a2d7dfa-3e08-4f95-9f22-0c3573d51a62@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Mon, 6 Jul 2026 15:28:41 -0700")
References: <4b08f4e2-2274-409a-86d8-469c73e21579@linaro.org>
 <0403705b-9af4-4de1-8f66-c56befa5bae9@tls.msk.ru>
 <24d6a029-5f68-4314-820c-fb1786012fb4@ilande.co.uk>
 <87cxx0wm51.fsf@draig.linaro.org>
 <5a2d7dfa-3e08-4f95-9f22-0c3573d51a62@oss.qualcomm.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Tue, 07 Jul 2026 10:29:05 +0100
Message-ID: <87mrw3up0e.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 7/6/2026 1:35 AM, Alex Benn=C3=A9e wrote:
>> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
>>=20
>>> On 05/07/2026 10:07, Michael Tokarev wrote:
>>>
>>>> On 05.07.2026 00:20, Richard Henderson wrote:
>>>>> Has anyone else been seeing
>>>>>
>>>>> Error: Failed to fetch
>>>>> http://deb.debian.org/debian/pool/main/d/dpkg/ libdpkg-
>>>>> perl_1.22.21_all.deb=C2=A0 404=C2=A0 Not Found [IP: 151.101.22.132 80]
>>>> ...
>>>> dpkg (and all related packages) has been upgraded from 1.22.21 to
>>>> 1.22.22 version quite a while (on Mar-2026).=C2=A0 Initially debian tr=
ixie
>>>> had dpkg 1.22.21.
>>>> I wonder where it is getting the old version reference from?
>>>> Should the previous layer be refreshed to point to the current trixie
>>>> point release?
>>>> /mjt
>>>
>>> If that is the case then I think you can fix it by doing a manual
>>> update of the base image to pull in the latest update locally i.e.
>>> "docker pull docker.io/library/debian:13-slim" and then rebuilding the
>>> docker images once again?
>>=20
>> You can always trigger a local build:
>>=20
>>   make docker-image-all-test-cross NOCACHE=3D1
>>=20
>> it looks like the source tree build of images has been broken again as
>> UNCHECKED_GOALS isn't being honoured for me.
>>=20
>>>
>>>
>>> ATB,
>>>
>>> Mark.
>>=20
>
> The right fix is to modify our dockerfiles to always combine apt update
> and apt install, to avoid those kind of errors.

We do for the main part of the dependencies from lcitool. We then do a
second step for the cross compilers for which there are shenanigans to
deal with non-x86 arches before installing them.

But the original failure from perl should have been picked up by the
first bit.

>
> See this doc for more details:
> https://docs.docker.com/build/building/best-practices/#apt-get
>
> Regards,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

