Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1930BD1CDBD
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 09:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Amd-0000uw-N8; Tue, 22 Oct 2024 05:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t3Ama-0000uI-DO
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 05:02:29 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t3AmY-0004TZ-12
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 05:02:28 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c9c28c1ecbso6927925a12.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 02:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729587744; x=1730192544; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7tTWx9ugJgzJqnwAtz8LpY+0OW2pWh6nV1QiYhM+dF8=;
 b=IQVltUgv6WyQC7OBYryuwXWK1ssB6C/uxUIs1DJ1KWxS2HPVJ6BLiVaO8jILhtO2Sx
 zmQWUZlEE9SRtWjpkpbkvsT3CIcvVPcPIHcqczv1U2bN+I3LiNQmMiz/IDEsvt3HnrEd
 p7w/hKWG9yj5vZ/7lxyZGU+xMjeWlaQTL7kTZmRWGs+OnoQSoK/JnE/twwhyIImdLGFS
 WOKJjTqW7YSIqe6PLciJHdJky/mVPB/cNgXE+Kkk3BiO/8SC7E2LzkjV8w1eg2XEO9p3
 +Cj7rL0uEKpEzp/ujdyCuE6KloiAnTthw1YoxK5SQQwtbrD72565KJHZTLXzrsCDRJMS
 fufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729587744; x=1730192544;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7tTWx9ugJgzJqnwAtz8LpY+0OW2pWh6nV1QiYhM+dF8=;
 b=jp438jx8/R+1+IhMUvjQQkZofN7kwWYZrCtmbh8RmsIpLDDqN1cG60A6U5LZL8ECxl
 P4UQzbY1QAzZ2vq8G5zQWU4omPOZCDndbI0ymX5O6cbjjwcqm4jO1gDQtKJ4IRcxWE08
 xlFqDRF5HeBfypVLO4dHPkANkkADjVYnru0PaLwoojmgxgSdDVidfYrtJRXYj7k8fua6
 rVH19vutwENSvwIdTh4d/1wG9LomO9JRYhhgIVKf7OEB5pxen62VaNlthTrGvKqNEWAa
 eT99zhqtxcUL+oVG/SRwjT9N5zLy164OdnGDHphd9YRhtRgiJxc/MrHtp0xxak2mKdue
 6F0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgA1cOotV+i1DcsnXh/Uaus7HsjtvSlMRHXNnKKiRlcMWLe4yNrf+GtwnHMtcN0QU4DRM/fxXVl2a3@nongnu.org
X-Gm-Message-State: AOJu0YwvlwZvjbQfSNEipTdBRdQV0JjRkJ2uLj4BKspaudu7rUzQNmep
 xYf8doii/9jMGGgvCVyl5nffhY+YNhwpXwKgcxeifM3uzxOXntiZPHLxamnHSnp3wMmBgW/v7kp
 lJgXQR2LdkD2wLNM69RdHcGl42MUYWpjhqUw6BQ==
X-Google-Smtp-Source: AGHT+IES8eV0YS8BaftoAU3kXbcBTgs/naqMEm69e3ud86+pmIqgBLx3o2sDwvRoNFrQWjnhRhjh8ZkWq1H2VDVxP9s=
X-Received: by 2002:a05:6402:27cf:b0:5c2:6311:8478 with SMTP id
 4fb4d7f45d1cf-5ca0af92c5dmr10618583a12.25.1729587744456; Tue, 22 Oct 2024
 02:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20241017163247.711244-1-peter.maydell@linaro.org>
 <20241017163247.711244-2-peter.maydell@linaro.org>
 <977b5038-fa06-46d4-946d-f60135ecf106@linaro.org>
 <ZxdO57heifGyI4lw@redhat.com>
In-Reply-To: <ZxdO57heifGyI4lw@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Oct 2024 10:02:12 +0100
Message-ID: <CAFEAcA9G_VjeUSgGW4b_WihkJ18JtO=a=VFYsrhgL=FYxd4dpg@mail.gmail.com>
Subject: Re: [PATCH 1/2] tests/functional: Add a functional test for the
 collie board
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Guenter Roeck <linux@roeck-us.net>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Tue, 22 Oct 2024 at 08:09, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Tue, Oct 22, 2024 at 01:11:31AM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > On 17/10/24 13:32, Peter Maydell wrote:
> > > Add a functional test for the collie board that uses the kernel and
> > > rootfs provided by Guenter Roeck in the linux-test-downloads repo:
> > >   https://github.com/groeck/linux-test-downloads/
> > >
> > > This just boots Linux with a userspace that immediately reboots
> > > the board, so we wait for the reboot log line.
> > >
> > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > > ---
> > >   MAINTAINERS                         |  1 +
> > >   tests/functional/meson.build        |  1 +
> > >   tests/functional/test_arm_collie.py | 31 ++++++++++++++++++++++++++=
+++
> > >   3 files changed, 33 insertions(+)
> > >   create mode 100755 tests/functional/test_arm_collie.py
> >
> >
> > > +class CollieTest(LinuxKernelTest):
> > > +
> > > +    ASSET_ZIMAGE =3D Asset(
> > > +        'https://github.com/groeck/linux-test-downloads/raw/225223f2=
ad7d637b34426810bf6c3b727b76a718/collie/zImage',
> > > +        '10ace8abf9e0875ef8a83b8829cc3b5b50bc6d7bc3ca29f19f49f5673a4=
3c13b')
> > > +
> > > +    ASSET_ROOTFS =3D Asset(
> > > +        'https://github.com/groeck/linux-test-downloads/raw/225223f2=
ad7d637b34426810bf6c3b727b76a718/collie/rootfs-sa110.cpio',
> > > +        '89ccaaa5c6b33331887047e1618ffe81b0f55909173944347d5d2426f3b=
cc1f2')
> >
> > Should we wrap these lines to comply with checkpatch.pl?
>
> While we have some line wrapped URLs in the tests already, IMHO they are
> pretty awful to look at. I think we should make URLs be an exception to
> line wrapping rules, provided the URL is the /only/ thing on the line.

Our style guide already says
"If wrapping the line at 80 columns is obviously less readable and more
 awkward, prefer not to wrap it"
and that's the principle under which I chose not to wrap these.

(I think of this as analogous to George Orwell's "Break any
of these rules sooner than say anything outright barbarous"
rule for writing English...)

-- PMM

