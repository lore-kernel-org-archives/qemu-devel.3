Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3103C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 13:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE7mc-0007K7-00; Mon, 03 Jun 2024 09:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sE7mY-0007Ih-Q3
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 09:31:27 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sE7mV-00015P-Iw
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 09:31:25 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-57a4ce82f30so2069906a12.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 06:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717421476; x=1718026276; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ZCVT82nhfwXqrAaiCBiAvu4YxaTxST48DeF5/boYwA=;
 b=yTJaC8hJPR9k1VsJhgUe5nl9YSZg06yGL+XhQNTX0jQx620cARU0hI5639Irl+wxcs
 nY1ym8lk/TyP3QXG6pehQpZnGLj2YM8/FkRnY9H3XRYE4YxRnhcAVHuZ7nE+CDevjPjv
 V4eEbBb151qrXm15dxCANB4ENxotoR1gHIpR1YHcg7B9ShALz8zwNn+6GRYCpVLxjpYH
 JG5HRp8m9uN7Grfbhfbg7jcsRvAwgty5ii8m3OCoP0nz8mu84BLawcWAXol/h0gOiXCu
 WVE2+rgLXeE7vyGs4cxGFpjANR/cknco0kH3IFBU4lsNb5XqiGimHhtZsEDU0i5d01vM
 q1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717421476; x=1718026276;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ZCVT82nhfwXqrAaiCBiAvu4YxaTxST48DeF5/boYwA=;
 b=DQp5ZY1bKJkZrgPK95zDjPj0j+Md0lSojw9zAE1uY7lK0vu7LqD72uB20nlxYYse0P
 hnrpUQ+jeJUO83iNZzRU7sb8X/srliCXjb87ypLcdfrAtBblF3U77pA6O5GJtGZ2+M2I
 vQGi9tHrJ5ri4BCBSOyjnhcwc279wEFMokhSx+XHDviz2XntAsydakw46QYeJCHRDqkP
 yGDey+OsCUcuNiNGjSh7ChWuKm4qzjCWPIKH0wcvXoASBWE5Gi0CXblgztwK6Bxnc83h
 sHy4PxQ/xgNyB+4q6NYJOKvoXd8NpWMzDRjXgVszkHlQibmE1YaPxkbc3N44/3Z1ooT7
 tN9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXT7YTUqcZPRzduehpFhSK8gq+VqFJqEkMSVREjMlwWS4N3T3RIldMsArYcwgf64RL+oAca9rzqjI4O7Qbs7NPfrjltODA=
X-Gm-Message-State: AOJu0Yzg/guX/mVczZUCNjn15XWrF04iXvpZsmsO5e12+o/FwaO3OZrS
 BL7WgVwUY4SevZh5sSAy5qSQas0g5aC7hFnNvAQSqIIyb3Bz5SgseNZXIFIlHQ+s6b+FvJnQSHl
 OdIOf8lyYOQ+rvB432zfzferhNDuXM6bNby9xYpIkuRYDzqMu
X-Google-Smtp-Source: AGHT+IGOgaZnIfPUyQgiePo29oQKElJu8/o2eWA3Y5XnZygalhWlufN0xHcDgYsl0k96SCu4RGicK9zRY1mwtkcyDGA=
X-Received: by 2002:a50:9e05:0:b0:57a:2400:3a56 with SMTP id
 4fb4d7f45d1cf-57a3651f208mr6279249a12.23.1717421475733; Mon, 03 Jun 2024
 06:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240531175153.2716309-1-tavip@google.com>
 <CAFEAcA_zPR=gd95tkhi8cXaZMf+M2OO2WpF=ZfO1vKhsO9=1cA@mail.gmail.com>
 <Zl29b8osUIBUICSm@redhat.com>
In-Reply-To: <Zl29b8osUIBUICSm@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Jun 2024 14:31:04 +0100
Message-ID: <CAFEAcA-EGC4WyRDCq7QtxyuVgy-q25AejJ03Mb4O6caLOOGF-Q@mail.gmail.com>
Subject: Re: [PATCH] chardev: add path option for pty backend
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Octavian Purdila <tavip@google.com>, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, 
 eblake@redhat.com, armbru@redhat.com, Paulo Neves <ptsneves@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 3 Jun 2024 at 13:56, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Mon, Jun 03, 2024 at 01:23:00PM +0100, Peter Maydell wrote:
> > On Fri, 31 May 2024 at 22:21, Octavian Purdila <tavip@google.com> wrote=
:
> > >
> > > Add path option to the pty char backend which will create a symbolic
> > > link to the given path that points to the allocated PTY.
> > >
> > > Based on patch from Paulo Neves:
> > >
> > > https://patchew.org/QEMU/1548509635-15776-1-git-send-email-ptsneves@g=
mail.com/
> > >
> > > Tested with the following invocations that the link is created and
> > > removed when qemu stops:
> > >
> > >   qemu-system-x86_64 -nodefaults -mon chardev=3Dcompat_monitor \
> > >   -chardev pty,path=3Dtest,id=3Dcompat_monitor0
> > >
> > >   qemu-system-x86_64 -nodefaults -monitor pty:test
> > >
> > > Also tested that when a link path is not passed invocations still wor=
k, e.g.:
> > >
> > >   qemu-system-x86_64 -monitor pty
> >
> > Could we have some justification here for why the new
> > functionality is useful, please? (e.g. what new use cases
> > it permits).
>
> The PTY paths are dynamically allocated so you can't predict them
> as an app launching QEMU. You need to connect to the monitor and
> interogate QEMU to find the path. So supporting a symlink simplifies
> usage.
>
> This was explained in the original patches' commit message, and
> that description should have been kept.

Sounds good. We could add that to the documentation also:

> > >      ``pty`` is not available on Windows hosts.
> > >
> > > +    ``path`` specifies the symbolic link path to be created that
> > > +    points to the pty device.
> >
> > I think we could usefully make this a little less terse. Perhaps
> >    If ``path`` is specified, QEMU will create a symbolic link at
> >    that location which points to the new PTY device.
> > ?

       This allows you to avoid having to make a query via the QMP
       or HMP monitor to find out what the new PTY device path is.

thanks
-- PMM

