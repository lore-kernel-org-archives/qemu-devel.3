Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167CFFB3CFF
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 10:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w79qE-0000k7-3G; Mon, 30 Mar 2026 06:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w79qC-0000jY-8l
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 06:27:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w79qA-00059K-1U
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 06:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774866444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lB9g6cJ7pvXEd5gsj3fSShep0Cl+KV1Ov+pWZ8yNjPM=;
 b=QYAtiMBZVAFT1HHgAgHrfq8iY0WVjx4ifbTyJdG3jXHFhKoPCr2IsJlW4iSeRg1RGO4ldT
 OqU0EEQDKrk2qktweauIDO4XAbxZX/RB80XqfB/Uynr78qcSYpBbWdUK9+uUwHVWMPHzzR
 Bj3RiDBJhNlpig7dFQiFDHroIHQo6Ww=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-NwZ8AoVLOryHuTAa_DZxYA-1; Mon, 30 Mar 2026 06:27:22 -0400
X-MC-Unique: NwZ8AoVLOryHuTAa_DZxYA-1
X-Mimecast-MFC-AGG-ID: NwZ8AoVLOryHuTAa_DZxYA_1774866441
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b630b4d8d52so2750861a12.3
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 03:27:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774866441; cv=none;
 d=google.com; s=arc-20240605;
 b=KH7N6cnDnwWBOAjVp0W2cs/GdVf/2XlwclI/429H+gdEs9ag2JMrJyJyYuvOXDkLeQ
 MxLO0fL+LLeITMNcJdpqtjCo/qTDPYD5/a2AM6EJvFdTRBQ09wJcPgP6GZfe0FXmyJki
 JkgwkSVa71dg5mlo9+6NrdoTgvUoswDR04FPU1XzbV4dXdrd3MT+/fUAol5CbJbHy63E
 A6RPCf2UmrQWKNdSs7hRvbiTsGckOeYS7SY1keazJGDnxfS/jAeRHZqk47MTpJ5Qcyfx
 yMWCnqxgxPG6iLjCPkfhqNf1Xz45LSz2/I3t9rcvGdMbSdbMYsvXxQ/Z+IOXXqFT5wnR
 2z9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lB9g6cJ7pvXEd5gsj3fSShep0Cl+KV1Ov+pWZ8yNjPM=;
 fh=EOstN047P43BMWYiYfNjXAFqxVDAuquNnj26iYRON0Q=;
 b=BvMCDUzJ6iS5IlAoj6EFKve7BjBSCEAwdoB+7LH2PGMrtdsjqjfiFUpAcdI3HUt95Q
 97gSDoLBSj6U9m2tT32cXdaWi2TvV1Z9FMs4H6f+aYfBmwe8pR1jL/McU0sDatD++t3W
 ORpEA+xUF4+NCenFKxbPd/SFsObIeHUj43HLpIoK8aHaZqWHmr++/qlUkmfLYU43v+Jy
 /ewWMQ5xaIBGOc+Rl3sc4gyzIInSMn2qX3sOOqeTQtybparoTwEaDJnYs4NOQL6OEGJE
 YItHQEGP1nhSc5yTXJnotNLwmGvTDln7+GRawFQaG6/Gq9v6ybkSRwenCpR5MXjZa8Kg
 nA0Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774866441; x=1775471241; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lB9g6cJ7pvXEd5gsj3fSShep0Cl+KV1Ov+pWZ8yNjPM=;
 b=Sa115RA/6/Qa6pFGBbvGPyq8jHJ3539sinjFKe1PKw2jJE0A6JHYJEARddgqXeOpaY
 xPdb9Iuza5hcXo2/kUzW0Jct5w8Gx8rmg6PNBnwQH3cYHStgFnzwwAagy7zCmtfsYcK0
 I0fVXBtJfs+HT74qS+h+/coOuS7YB/Th8ItnKQeq1Sb45aZqUg8c2djQHziybvmoA7fM
 4ZVaOGJzqUK8kG8WxFcSeJF43rkkNRq7HvUA9Z4VLhlohf6ZYaW92D8OHoXUDjPQ1wrc
 0FGkmLCG9epPJwO41jTqK4ZtiMVhXXU7957XM0LRZihGguQl2aUvKIniwu+MD3P9OfFB
 /9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774866441; x=1775471241;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lB9g6cJ7pvXEd5gsj3fSShep0Cl+KV1Ov+pWZ8yNjPM=;
 b=Xupo2fK5uC3zDzLe/BsRyqWzV3uYy/qqGa7tiOPwS6g0hOhLdcBTAqxKxpuPyp5/Q/
 1BU4aoNjswleE5K9jwu5KLAqMzCPX6+2olSv+s4xfDX3t4dY869UXPR0qt4veE9hvlHn
 xHFHo3oPM8rPUg6+rHw0snssmTxmCzOsF32L2EZTvXi8Ge9zBJ23fqukOS/sFmSc5Exl
 IDeuMmPcEqu/Pqsp5k+sG2oxW7jLB0UrU7qOdB1JZynTeDgPc7665ML0BEslA1QlKVnn
 ahcYcpqlanbukxnVAacucQo7ATtYFzcvenGcoOjgIjkg3ALjzIDtn3uRYlW6gG/aviOu
 1QhQ==
X-Gm-Message-State: AOJu0YyUWkgxng1KMBUmzZXJoLAepzwyhPaAoD0e9k7VZh8zxivQDkxu
 xgme6SqrUGqncg3mJY9XLG4LzeZkdsA8SsnqJl33Alhslc+zYz7LbWGeM2WvDxVFlR0ViFtfkVh
 benMxryy8294hDRLghlebpjEXjapJyuhTtcc5rQu+FggALYB+CykwnioZSNcbBhWWxUsVTblez0
 TQDDq+SyucLv9tdqi7jKyIIgfVKQb7kuo=
X-Gm-Gg: ATEYQzzvQIk0JKBDM3SlV+OyKT2kiZN4eWKBdlTRrJU24Ye0iikZJqbs+bv2aS8bBc3
 ghsbWw4UNNCtANlZU3AoXgZmS+cA8aXREZu+1ev3a2kYaQMYxDjFv5Rqbsp4bJOqzCJ/f001e14
 W9q+xVFxgy4Vl7RsofJfOnc4lH3kWQud6V2mmkNMNWhJAwA3mGiBA270W45Si0ucE7cRAmAAh18
 GIxgdCAKJ3Bsq5xOr780EtJmWFufx9hgnpYVwwdVKd4k2YSywmBLh3efvBGXKhB0D2DFxRK0rQD
 /bj61jWGBREMYwRaLprYGJI=
X-Received: by 2002:a05:6a21:113:b0:398:80a5:8bf4 with SMTP id
 adf61e73a8af0-39c87823bccmr13472806637.10.1774866441505; 
 Mon, 30 Mar 2026 03:27:21 -0700 (PDT)
X-Received: by 2002:a05:6a21:113:b0:398:80a5:8bf4 with SMTP id
 adf61e73a8af0-39c87823bccmr13472784637.10.1774866440966; Mon, 30 Mar 2026
 03:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <DB8P190MB07142E1BA8DEEA8B2E41D5B2DB57A@DB8P190MB0714.EURP190.PROD.OUTLOOK.COM>
 <CAMxuvaygbUf3eS+r-6=dxiZfHp5KrD7_QLhhnTf7KHfxU+CjPw@mail.gmail.com>
In-Reply-To: <CAMxuvaygbUf3eS+r-6=dxiZfHp5KrD7_QLhhnTf7KHfxU+CjPw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 30 Mar 2026 14:27:09 +0400
X-Gm-Features: AQROBzBNyjPAdGEqD_ruMYwM9kU5jOxAxvzenOWmIN1Sox-zfFDp-sJdCeqEcTw
Message-ID: <CAMxuvax+1omtWMs964yg1ZgFrHn_f2JP98540hY8uPfD-HF8Mg@mail.gmail.com>
Subject: Re: [PATCH] tests: don't build audio tests when no audio drivers are
 enabled
To: Anton Kuchin <antonkuchin@nebius.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, NB-Core Team <NB-CoreTeam@nebius.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Mon, Mar 30, 2026 at 2:12=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi
>
> On Fri, Mar 27, 2026 at 8:46=E2=80=AFPM Anton Kuchin <antonkuchin@nebius.=
com> wrote:
> >
> > When there are no audio drivers configure fails with "ERROR: Command
> > cannot have '@INPUT@', since no input files were specified".
> >
>
> thanks for the report
>
> > Fixes: 3220b38a8d ("tests: start manual audio backend test")
> > Signed-off-by: Anton Kuchin <antonkuchin@nebius.com>
> > ---
> >  tests/audio/meson.build | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/audio/meson.build b/tests/audio/meson.build
> > index 84754bde22..322755b880 100644
> > --- a/tests/audio/meson.build
> > +++ b/tests/audio/meson.build
> > @@ -1,6 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0-or-later
> >
> > -if not have_system
> > +if not have_system or audio_modinfo_files.length() =3D=3D 0
>
> audio_modinfo_files is only populated and used when modules are
> enabled though, so this should only be checked in this case

Could you check if this is good enough and resend:
-if not have_system or audio_modinfo_files.length() =3D=3D 0
+if not have_system
   subdir_done()
 endif

 modinfo_dep =3D not_found
-if enable_modules
+if enable_modules and audio_modinfo_files.length() !=3D 0
     modinfo_src =3D custom_target('modinfo.c',
                                 output: 'modinfo.c',
                                 input: audio_modinfo_files,


