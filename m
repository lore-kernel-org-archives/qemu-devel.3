Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A54EB26F5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 18:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpsPA-00079m-Hn; Tue, 10 Feb 2026 13:24:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vpsP8-00079L-Sc
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 13:24:06 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vpsP7-00056f-Cl
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 13:24:06 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b8850aa5b56so1027202766b.2
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 10:24:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770747843; cv=none;
 d=google.com; s=arc-20240605;
 b=EvT4EXFe09WuQm0JPR2EQWG8ANV1B3KjFsgls9Xxr2lo8u7h1uPyYIdYDdZu6HelQ6
 LvZBYNstHvt/sRcjloJAOOg/2zVTetmH+qmqJkVOR8AQYSDm+CksDXi7ELvxNcWZHbfZ
 gDSrRBVpFRiLMjjR9j9e4xB10nEEhbrC1K0J6eGaBiT0443BEjcNl5uvNLkY5e004OMD
 Kc1dSNygdHCWnUqsFRB3XrQmYG1/r8+Y6nMSyjVMAz/bWW0+hX85Mahpi2nbr6ycxaHf
 cHGEpjMvyP7Jk9sO+1xTszbYXmzeKpcMrbdloPXoz24PM4+NyPOfNkjpRakJS2LhMO84
 1yww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0M7oTZWJkuOieYOzSKqfudEsWoHb9YUNwH2QGu438y8=;
 fh=qjnseHyOcPSztwic8f3vU9LNzpXsVGNsgd16TtkD0/Q=;
 b=MPGEp/3oBtdV47y2Y+WmGZe6neqeT44v+UG8ojhaQ4dv3/6TRrJ4EGZoO9H07r8Tbx
 oYYpYQUBLM5o4xeNDNHhzjF6HhLeiZqWWENN/9BVMEfKgvJIWYs5Ag8yfJisO8CaTJgg
 dY/LEnEiw3U0WcT7LM1w23VPShXucj9Ql9seOG+r6RfGh2IVEwrFg8I1Wr2wYbbPzsIu
 xgTzWnN+D73ab9a3SFvOvbAibMXfMxXTUV30UMUFS4ptKWTclWoNhlbBBgrzPXE9klV5
 vyXLj7Mjm3CQAoj6OFzX1IabDyF0jCbPP/70Jd4Fa9aLP/5wGhtavYl9RoZvY1sAGxLw
 TUog==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770747843; x=1771352643; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0M7oTZWJkuOieYOzSKqfudEsWoHb9YUNwH2QGu438y8=;
 b=kogJ0zDVNbTihulEdqxQHfZdyn/rxZ/M7XDl9qmM2/dCeQ90FMh64PYyB0KasUA/GS
 7v7xOFnyoReVHJrNgZx/0QYKuTBdT5YJ4OQWpeEPX43ed0jBsYQLc92Qryn204O6zgst
 TtoprGL1ubcicq64XUx6qqYiQ5QN5OrttjyLcvEhP/6JRB6xcJ8endnwIkoUKyYcQgkO
 glbMDdxQUX/px7uQxk0GBqYGNaqlJs4hibUgecsOfxBI4qCYOLhPpD8BkVbBowHcKIe+
 C/gENVIEn4uEj+nTY4fKwE59q4MhpHwwCIDTwtL5kyg9PvS523k1VaYzvqRM+PCvo7JY
 vyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770747843; x=1771352643;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0M7oTZWJkuOieYOzSKqfudEsWoHb9YUNwH2QGu438y8=;
 b=vCBhVRVVSBoRpaEtA8MjoLdU/D/QGs4MCnEeWJiU1SUeQZ8pNRTDQzljGIYfsamaLm
 ZZtyK//YKL3HyhXNQsA0ItQJ8SXgPNuFDRc/Dwb2zBG4/QXhtpN16yhmt71KCWy1lIBU
 IX/dmgkM9fxev56MkCjcHU5l0Yq3gI3cW6oCwy0hHIg9exS6Iw8b9spDRGLwnKsUmV2b
 t70VbRpkQjYLpzNZC203iz6RXFLrrSaWOAl+EoB9IMq3D+To4Ga6iWkYU2B8HG0gWDe9
 yUVtsormqdIPg6PTByYQwq2mAXJ8+JOnNkhZSRZbK6VHnBmGr9+hVblnYHb5ffWIAIyU
 adYQ==
X-Gm-Message-State: AOJu0YzD/bmH59YB4OzAzp5E+Av8GeUwHMO5CTmGAUAonFMp+2AMV6h7
 1RlIUEFY5hYYYcKopgH2XL5qrPO4HGxXQvmxGvaoe5dX6yXI3sDjYkqLjtgDVqzZYGsy3DFd/2s
 VqmA/36QbIA+AWMDTLAPqRRNwaNhg5MJlAg==
X-Gm-Gg: AZuq6aIvgY1gUpJm7KAfxcvhXUDmBg2d6OajxmiJl25N8/K2ussORlJZXd9blNhVYXA
 YyuD4Pb7/U3gySL0OMkCNjNJXuDae+GJh6UTAk2jcE8E9a3azzhcnVvtCTHILMAIy4W82FbXC2h
 R6f1S6sl1JT9TDCw3xEZxKtaZx6KkeCx5MIj3Cls5kD1O1bfhK694rmFUuFzDY0NOovfQfgRt1y
 sKO6XxB6tcvdEMPpxGtyPs3nCkgY7Mhn0HHfAQCpN/jGmWWxXxkIOryG7y4KGBlvWEfX2Ef32B+
 wHnOXw==
X-Received: by 2002:a17:907:702:b0:b8e:3877:d1bc with SMTP id
 a640c23a62f3a-b8f543d8abbmr195561566b.16.1770747842945; Tue, 10 Feb 2026
 10:24:02 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <CAJSP0QVQNExn01ipcu4KTQJrmnXGVmvFyKzXe5m9P3_jQwJ6cA@mail.gmail.com>
 <CAJSP0QW4bMO8-iYODO_6oaDn44efPeV6e00AfD5A42pQ9d+REQ@mail.gmail.com>
 <aXH4PpkC4AtccsOE@redhat.com>
 <CAMxuvaw04pDNzHyw5+Qcv_KfrhDTiyp+MNxpECp+HfTa5iLOGw@mail.gmail.com>
 <aXH-TlzxZ1gDvPH2@redhat.com>
 <CAFEAcA_u6QUhs+6-cyYm_qttsDiV2zHbsc-_FbTb8QzWXk6+tw@mail.gmail.com>
 <aXICpFZuNM9GG4Kv@redhat.com>
 <CAMxuvawgOvQbwoyCzFBLw++JqR0vFbVUhbv1AJWU6VqK1MM_Og@mail.gmail.com>
 <82f74c82-c572-4ab9-b527-11ea287056d1@linaro.org>
 <CAJ+F1CJtrv9YgDbiekVmDD2yT+6nUe39nLwLsKxvFOtMc1kUGA@mail.gmail.com>
 <CAJSP0QUCQ8LkHEPNPb75XZmo46xxvP3uA373fzAZTwn=bo_bdg@mail.gmail.com>
 <f7a90238-f33d-430d-acd2-d8cd9ec275fe@gmx.de>
 <CAJSP0QVbvRxZXjbfoegu+NA=0hX3N9pSeG7Stx_jpqo1Mgwd0w@mail.gmail.com>
 <93c80b9e-7eb9-45f2-bdd7-a769e2935ba1@gmx.de>
In-Reply-To: <93c80b9e-7eb9-45f2-bdd7-a769e2935ba1@gmx.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 10 Feb 2026 13:23:50 -0500
X-Gm-Features: AZwV_Qi_7xlxmwzLrs5RgHL_lj8NC_QGbevZJ8QG5mDBF0rGZDjR_a7M1Wp669Y
Message-ID: <CAJSP0QU7TJ5Y2gAy=ipk4=7hrqejifJJ8YcDz2LsbiQbWL5Kig@mail.gmail.com>
Subject: Re: Call for GSoC internship project ideas
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Feb 10, 2026 at 12:45=E2=80=AFPM Helge Deller <deller@gmx.de> wrote=
:
>
> On 1/27/26 15:18, Stefan Hajnoczi wrote:
> > You are welcome to add the MPE project idea if you want to mentor it
> > this summer. It's okay if you are still waiting on responses from
> > people you are in touch with. Now that QEMU has at least 4 project
> > ideas I can go ahead and submit the GSoC org application and you can
> > still add your idea later.
>
> Is there still time (before the 19th) ?
>
> Instead of MPE, I wonder if there was at any time the idea to
> add a SCSI TAPE emulation? I mean, not a pass-through driver,
> but something which emulates a real drive, or at least the basic
> SCSI TAPE commands. Maybe by utilizing the tape library from
> the SIMH project?

Hi Helge,
You can still propose an idea before February 19th.

The Linux scsi_debug driver has support for emulating a tape device,
so that may already be usable with QEMU but I'm not sure.

If you have a use case for SCSI tape emulation in QEMU then it sounds
like something that would fit GSoC.

Stefan

