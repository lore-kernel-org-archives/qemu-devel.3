Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61A5C44536
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 11:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vitIW-00050r-5t; Thu, 22 Jan 2026 06:56:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vitI2-0004p1-QA
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:55:55 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vitI0-0004zg-SL
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:55:54 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4801bbbdb4aso13935205e9.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 03:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769082951; x=1769687751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A6oGl/jXKU2kaAGjfLnWtURe0DlEwbhNcb1dp4D+EUk=;
 b=yiIShRbrTKBaCJUoot0KgrmNFCgXx4NG7dpcd2wwbkkw/wwjnLwWA/nppUtbClxmKU
 7JZkN3/ZbO/kuDdiIhxYU/T3IRQey/DdHDdpwUPKdtD3gMQKonJZrrfxCrSfYLOuvFUQ
 U9YtMBU62JFgtuJ5dgLou9FdsYq/dEGTBPnVS4lLdJPO/+LIhJnBxXncuX2mF5jFrpLe
 nr9k3w/FrWtRiFjivqYqUE4avSQmwZQo0lX1X0nCa3XXJnR2tWyK/XjdIxMoCjVJfhHX
 jPm+bVGyNtDKKLA6z724A+klc6a2yB8/gnljV2mBxVu0AUVYR0/yowtIcGBEKr4I3Ta4
 ZRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769082951; x=1769687751;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A6oGl/jXKU2kaAGjfLnWtURe0DlEwbhNcb1dp4D+EUk=;
 b=GdY59j99mVoMleIFcFBhNxItVjnUq3md+AWHTJhXVwXBvCiG2r5X2hvM3ymDfX+FGu
 QqIh9SAFkqeE+glTZi3gnoDEhR08KpkSd6tH2FuCc1ZSJGqw9eQzwvxr89zVghzVWci7
 1/FAR7LBrZvdG617+Ar4FFCd8/hRMf0zk42lOGHHUKFtHnBm1dpqUSnsG5LvhfRGGIw9
 nvw7WmnywlaGegMRf9QV4S5pjgTGMH8IWIYyn9cRGaDTgYbuPVNtJK8fchJ/M6EMF395
 kisNN3P/9kP41nQjEqepgYV2Y2GBfnN5syE3QXnpSpO0PlWLpJsXCpLsTSh5SuctAP4o
 /R/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV1htXZJTZA7tvwmN26nvGM6xhx6TaxSAYiLhGfi9BPSGuqCI100q8Wo0W5lqQOB2el+H62ihFCAUT@nongnu.org
X-Gm-Message-State: AOJu0YwZTRAaIGkHe10UNVMKxY+M0uz91zuNSK09Zc7ujmTRnZUnE3lD
 Y6WmamvcdkNBLFKtmxELV2iOBEVtiodwdtH3nwQUMLjx3z5+rwW6Wlwle9aV0rzEw5A=
X-Gm-Gg: AZuq6aLUFUigXwEXLBoZDLtO+J8AqgW1zzHaB3905jcP/FhRzG1fYIJlBjmT7Nw/fKi
 kaMo18cLpsJG4NOUQj3wXpLZslo24S+tT5bqi2u8Pz+1FMsCQeka0MgdwCGj0iz3sQu/IlSjYyr
 Q5JOh2K+w3aPI6m3VrrLEZtjLtRqxqspvzPxbxdzHoPy7t7r0Dlp9Gsvbgo3zQg0RwPEdFTHORS
 44LKC9Ef4yEARLuoSY/cicN0OZzQfycf1C8BKzdbJA3i3xe42XOhjQ9Sn2CO9CfVFyvRNMgITZi
 wuFwl/YfaV/PzixkPZUj7mFXr3H4KVwEZdTwP//XqBR/iyUyY2/21zyMuKfLELu3eo8cJN6mwFK
 +7NmO8CRnzdUwC1hKAYYsy0XnRybImPrT9tXXe/CF7vj3DFn4WgFuJZqDh7ZSmQMLXk5/anqXp1
 N5Ng5Ot/d+UbW4
X-Received: by 2002:a05:600c:4f4a:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-48047087235mr49595895e9.11.1769082950567; 
 Thu, 22 Jan 2026 03:55:50 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804704b89bsm59759895e9.9.2026.01.22.03.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 03:55:49 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2184E5F7C3;
 Thu, 22 Jan 2026 11:55:49 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,  Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel
 <qemu-devel@nongnu.org>,  kvm <kvm@vger.kernel.org>,  Helge Deller
 <deller@gmx.de>,  Oliver Steffen <osteffen@redhat.com>,  Stefano
 Garzarella <sgarzare@redhat.com>,  Matias Ezequiel Vara Larsen
 <mvaralar@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  German Maglione
 <gmaglione@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,  =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>
Subject: Re: Call for GSoC internship project ideas
In-Reply-To: <aXH4PpkC4AtccsOE@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 22 Jan 2026 10:14:09 +0000")
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <CAJSP0QVQNExn01ipcu4KTQJrmnXGVmvFyKzXe5m9P3_jQwJ6cA@mail.gmail.com>
 <CAJSP0QW4bMO8-iYODO_6oaDn44efPeV6e00AfD5A42pQ9d+REQ@mail.gmail.com>
 <aXH4PpkC4AtccsOE@redhat.com>
User-Agent: mu4e 1.12.15; emacs 30.1
Date: Thu, 22 Jan 2026 11:55:49 +0000
Message-ID: <87ikctoo8q.fsf@draig.linaro.org>
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Jan 20, 2026 at 04:42:38PM -0500, Stefan Hajnoczi wrote:
>> Hi Marc-Andr=C3=A9,
>> I haven't seen discussion about the project ideas you posted, so I'll
>> try to kick it off here for the mkosi idea here.
>>=20
>> Thomas: Would you like to co-mentor the following project with
>> Marc-Andr=C3=A9? Also, do you have any concerns about the project idea f=
rom
>> the maintainer perspective?
>>=20
>> =3D=3D=3D Reproducible Test Image Building with mkosi =3D=3D=3D
>
>> This project proposes using mkosi to build minimal, reproducible test
>> images directly from distribution packages. mkosi is a tool for
>> building clean OS images from distribution packages, with excellent
>> support for Fedora and other distributions. It should be able to
>> produces deterministic outputs.
>
> Aside from what I mentioned already, the other issue I anticipate
> with mkosi is the mismatch between what hardware QEMU needs to be
> able to cover, vs what hardware the distros actually support.
>
> Fedora in particular is pretty narrow in its coverage. Debian is
> considerably broader.
>
> Neither will support all the QEMU targets, let alone all the
> machine types within the target.
>
>
> While there is value in testing a full blown OS image, IMHO,
> for most of what we need it is considerable overkill, and
> thus makes functional tests slower than they would otherwise
> need to be.
>
> IMHO, our baseline for functional testing images ought to be
> a Linux Kconfig recipe used to build a dedicate kernel, plus
> a busybox build for the target.
>
> This would let us create either a self contained initrd, or
> a tiny root disk, both of which would reliably boot in a
> barely more than a second or two, even under TCG.

This is why I've been building my iamges with buildroot. It provides for
a lean user-space with exactly what you want and it can create a
software BOM for the whole thing.

But it also allows me to bring in more complex things if I need to like
the vkmark tests for example.

> This would have a number of other benefits
>
>  * Not dependent on distros supporting the given QEMU
>    target and machine type. As long as a Linux port
>    exists and busybox compiles, we can test it
>=20=20
>  * Identical test image functionality for every single
>    target and machine type. No hodge-podge of different
>    3rd party guest OS.
>
>  * Stable forever, with all changes entirely under
>    our own control. No distro changes that arbitrarily
>    break our CI.
>
>  * Easier to debug when it breaks, since there would
>    be a small well defined set of logic running in
>    the guest userspace
>
>  * Fairly easy for QEMU to provide the complete and
>    corresponding source for any binary images, since
>    we've built it all from scratch
>
>  * Tiny & fast downloads of pre-built images.
>
>
> This would not eliminate the need for testing real OS images,
> but would significantly downgrade their importance.
>
> Functional tests could be in three groups - 'quick', as today,
> 'slow' the smoke tests with our miny kernel+busybox, 'thorough'
> the full OS images.
>
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

