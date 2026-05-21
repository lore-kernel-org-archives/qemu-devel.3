Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB10CD343F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 06:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPwi6-0002sp-Cb; Thu, 21 May 2026 02:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wPwi4-0002s2-HO
 for qemu-devel@nongnu.org; Thu, 21 May 2026 02:16:44 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wPwi2-0001h3-JA
 for qemu-devel@nongnu.org; Thu, 21 May 2026 02:16:44 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-44a74032ff8so4132351f8f.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 23:16:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779344200; cv=none;
 d=google.com; s=arc-20240605;
 b=BLs+Hy2pdjDWQ6/3/XRM8y4ukgHWxMvzmY1Zbi50piCjN+yyH0bZhqs5Iya0an5v5+
 2m2fVYYWh5x2VDKpYe8BYn6wE1M6mFV2PxaC3phXw5v9D2zFLnwabxS9ISVZgGEN/qZK
 uYPZpvz22faOedcOaL3S/MZhZS0Kjaao3+MmB8WEgyZkpUuwiwziNfN0qVqgani2BJpp
 9DNFThmilVyxr3LH5lPbW/oWizC1iRG/D2dy4FE+QYSynR9kemSR5tO2eB1Z9lHexuee
 ZmXqnmRxNeuaKeFiBpP7GKidRUh1PVblE3p/CfrNeZXbv2cISQ8ywSei+evE3ICOSoj9
 CcMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xCW2QbZkF/buzzDehUSbjndJzrt8lL8gjibjwvCEoqY=;
 fh=Ba/qm4exNFDxgeP9MRz3vEjb/O12SIXQm3J7PX48XOY=;
 b=HQD6czcRWcvM8tfP+YdXu25HXZ+AH0Ik5D3bD0iZCX9DQ3IMm6bZvq+sa8l/lBIyxy
 hxoo7pK6EpYuwzv+ksPl/ljnGPsxZFL1AF8al7C6t+7OdXSMG+Sp5WPNpPcfnS21WdQk
 SlnxVpTNMZHwSPtxjkURB2CDv6S45pztIZM12lfRHUkypJQbDT62fhq6oxbAZZFsNNMH
 bi7LwGexOhD062YIPG6VniWGpu2yYHEAdCIn3ECBHCGohWpusizMIy6ruQ3V3YlWYmtx
 ua4YfagIUQqgi34R4DvKynihXDpUHRG4YigN5VoD152ZHmnyAxrvBlvUE/AJ0vYWaYtA
 /Vww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779344200; x=1779949000; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xCW2QbZkF/buzzDehUSbjndJzrt8lL8gjibjwvCEoqY=;
 b=qCUb7vXh8MxRn19+Xk5nuZH+SVChN93RZVE1DdtatxrX+NVfBlekZM3fKAw3KIITDH
 4y/cseC/w1YvGAEY0/pMbryfWNistYl6ebBuyPP0yRTL634S+d77FlhYPgMY/XM3aGYF
 ZCdbuBR5w1gLgv0xNcN4Ii0Fd8kalpAj4iWsD41psIgz2CelwNaHGk3oeEkEzr1+x0eb
 WxvF5+AVV3WFrr+XhW9VKJqIIExNG1LHGU23cWKjSgfDjTPmzG6LkJ6DLNrOcEF7lLgA
 hjOT81eZZ4xnjTS1jvoBRlTOt4O61Ki/1ytal4I+sfObDFkMEa4SpZQXS/l+KZ1h1s2+
 Ykbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779344200; x=1779949000;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xCW2QbZkF/buzzDehUSbjndJzrt8lL8gjibjwvCEoqY=;
 b=EVtc3xtVOh2xPt6x5Ny47pdAEQKMT0KDvLIh/xNsCVfJte39jMd1Gs3uTsMIZ7EJAr
 lCHFaRnirRWg8JJrvOYClJdwFMLv0ptd0HFod4mFFnb7sKyz1/BSPV0j8nqU7Z7QcwsM
 Ehlzg/egoQihUHqoZbSqC3dpkVZ5MSSOzqkdcpz5WDBits+z02OywslSluYU2Hot0tvX
 7mydXca6DsA9hzT6g3bCknlckEDzO7rQ4L2ogdaprsbroTcgajhn66TsxWhyh3BSrM6i
 ncfgYKfnf1Plp3q+9nSn9f86b35JEkke7BUsGjbnboCj0aAE5z2BKb/MV6f4kLupxPpu
 NzIQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9r/U5kM0bmeinn8YQ20oFQOvnb1NVQK92lpUZLQq0viNq9FM2IhxIHUuTzwWeMJkuKQ3SfGcC+K1NC@nongnu.org
X-Gm-Message-State: AOJu0Yx6hvBKJbhfmiDnS/+K0HO7URBNB/ZzLTuRqAcgDg5GRjC5xMDf
 J2qRBX2dxHz9zIRhJKDd8r9l5mMQIs8pjXzXTRb/JgSLotDUn6HgaiGKHg7cIwnoKWIb3LZBULx
 lYHf1DK59onSoctDXMdKjtLHSk4eIInrXg+J0E1xoLQ==
X-Gm-Gg: Acq92OGLFkDOPuaBr7lhOLMMLWRD9IRkWcrv6HE2y2p/cIHr2ssR42VxDYjygTunFaZ
 6jXUrM+qs2YejH9QMbdHRBcjXciyG0bdoBo1n1S9VDqcVqGKoDRRJ0c7SPr/vQrJw1rdhMfJMFj
 DsS2n6ZoIuDIK2f1XwhGt0TkODujA/ocDTMFZIpiMeMCsevwEIsCk7FyzQNuvSf3TmK2/QXb3i3
 gskzQmrmK6XGxgJdPo5YNylEJVIlEz7L7uH7LGjx+AgppUy+eeh3NH/3f5KpiQpWM/HFxsB8V+e
 /dOeo4qyFJ3zHsdlX9TO/r9q5A1Emw8X2s/cFwVpVzHTE/ZqMGcn1qhiZ+re
X-Received: by 2002:a5d:5d87:0:b0:45d:77f4:1ac2 with SMTP id
 ffacd0b85a97d-45ea349c70bmr2189626f8f.0.1779344200464; Wed, 20 May 2026
 23:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221017182005.43015-1-philmd@linaro.org>
 <87pmeohtj1.fsf@pond.sub.org>
 <3104a00e-4c13-4bf7-95a0-1f2840bec50d@linaro.org>
 <5de52cde-3872-4b5f-acbf-28ca300b7724@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <5de52cde-3872-4b5f-acbf-28ca300b7724@rsg.ci.i.u-tokyo.ac.jp>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 21 May 2026 09:16:14 +0300
X-Gm-Features: AVHnY4LJSbBsmeidd5ESpAogcBv1ev7WDmHZxPGKvenQ3KNTVW7S5iyCd24a5_Y
Message-ID: <CAAjaMXYCt=3G4yzNNtGWa1gSDW=kCRtXO4TQt41hN-N32DnBJA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Replace my amsat.org email address
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Thomas Huth <huth@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

On Thu, May 21, 2026 at 7:41=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/05/21 4:37, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 19/10/22 14:44, Markus Armbruster wrote:
> >> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
> >>
> >>> The amsat.org domain is having issues with DMARC / SPF / DKIM:
> >>> https://lore.kernel.org/qemu-devel/
> >>> CAMVc7JUy5NeEN0q=3D4zfZvn_rppgqn9wicV1z=3DTsLuHKS3RY3Sw@mail.gmail.co=
m/
> >>>
> >>> Consolidate all of my MAINTAINERS entries on my work address.
> >>>
> >>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >>> ---
> >>>   .mailmap    |  4 +++-
> >>>   MAINTAINERS | 62 ++++++++++++++++++++++++++------------------------=
---
> >>>   2 files changed, 34 insertions(+), 32 deletions(-)
> >>>
> >>> diff --git a/.mailmap b/.mailmap
> >>> index 1f7319b70b..35dddbe27b 100644
> >>> --- a/.mailmap
> >>> +++ b/.mailmap
> >>> @@ -70,7 +70,9 @@ Paul Burton <paulburton@kernel.org>
> >>> <paul.burton@mips.com>
> >>>   Paul Burton <paulburton@kernel.org> <paul.burton@imgtec.com>
> >>>   Paul Burton <paulburton@kernel.org> <paul@archlinuxmips.org>
> >>>   Paul Burton <paulburton@kernel.org> <pburton@wavecomp.com>
> >>> -Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> <philmd@redhat.com>
> >>> +Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> <f4bug@amsat.org>
> >>> +Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> <philmd@redhat.com>
> >>
> >> I think this retroactively credits all your contributions to Linaro.
> >> Intentional?
> >
> > Certainly not intentional. I was seeing this as a git limitation, but
> > Alex pointed to me we are doing an invalid use of git-mailmap, since
> > it is described as:
> >
> >    ... the file .mailmap [...] is used to map author and committer
> >    names and email addresses to canonical real names and email addresse=
s.
> >
> > so more for typos, not developers changing email addresses. So our
> > "replace old addresses by a more recent one" section might not be
> > the best use. I think it was useful for the get_maintainer.pl fallback
> > option: when a file is not cover in MAINTAINERS then the script look
> > at git history. If all files are well covered, then we shouldn't need
> > this fallback anymore, nor this .mailmap translation.
>
> Git's own .mailmap contains multiple "replace old addresses by a more
> recent one" entries. For example, the latest commit for that file is
> exactly for that purpose:
> https://github.com/git/git/commit/4aa72ea1f64e8ddcd1865c76b24591c0916c0b5=
d
>
> The situation looks same for .mailmap of Linux kernel too:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/.mailmap?id=3D1bb54043ff309795c90ccadd8a6e6b13ac40ec4e
>
> My understanding is that Git's handling of .mailmap is designed to find
> out email addresses to be used to reach out. For example, someone may
> git-blame and find I wrote some buggy commit, and ask me to review a fix
> for it; in that case it is nicer if git-blame displays my latest contact
> point (@rsg.ci.i.u-tokyo.ac.jp) instead of one for my previous employer
> (@daynix.com), even though I authored the commit for Daynix.
>

This is my understanding as well, it's not for employer attribution,
it's for name change and/or email change.

People who wish to use git log for employer attribution reasons must
use --no-mailmap. The original commit author in the tree does not go
away!

> >
> >>
> >>> +Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> <philmd@fungible.com=
>
> >>>   Stefan Brankovic <stefan.brankovic@syrmia.com>
> >>> <stefan.brankovic@rt-rk.com.com>
> >>>   Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
> >>
> >> [...]
> >>
> >
>
>

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

