Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8258DD59F52
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8jRo-0003IR-ID; Wed, 06 Nov 2024 12:04:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1t8jRl-0003I4-Qo
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:03:58 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1t8jRj-0003iK-F6
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:03:56 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5ebbed44918so7366eaf.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 09:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730912634; x=1731517434; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SrlTSMIZ2qz0+SnMFh6332aJUF2orVgNPQ4/3nRHnKQ=;
 b=eNb4VDarqddzPYPLh56KqUhai2FY6/sRID524v9tLX08DvLHCyk5hYP895vlZCjwZa
 R9m80mp5nEKCKNefmemyOXEcEY3qPmmJS+L2Tu9laWh1tH5B2hkz+YRYyobpB2c6YgIL
 GypMzf0+cZUTkoHGUb7fTwz2BHAT6IB+vfvWB20Op0kJsaLJe3d2Bdm+dEZSjnaZ831F
 n/qD4nKMoSKtJRrqiushZPRlmZdTE8NHpQlZcYSUtNaoQJ2klR8wMJokm+9Hpnh54WD5
 VHZfCzYkbcz1Nm81JydX7CwS/Nv861/h4JZL7o2zmsYwzxQe2M+wrtVjR4sJYrB4Bv35
 VGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730912634; x=1731517434;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SrlTSMIZ2qz0+SnMFh6332aJUF2orVgNPQ4/3nRHnKQ=;
 b=OLfvjnsG9LquJfauuwdka7VIKjWXzczM/V23vlSFN8Um/dHQ3O4CzsKzVWB7mFvAly
 71Elpxju8Bzs5mqHS69fYfHt5dvkDB0t4nfzG0oowDugswOG6zHMoQksLvQMe2in7NhY
 f2cctTxz/CX76nAU1Lvn8UDaVc9rSWiXZGhCQntlXcLRbS5cNf84+olY4FBOPCXRtqPP
 R0N2blqC08SykZxOIc6cYVCz5mos/7E2cUnIQzM0zR5hX3gO+4UTejkpBDnk3KxUf0nR
 fkAQjVo/rnPO1F5sWgfunsc1TXUFhm570/cCBj9ntduza3xCBhFLwkBrQZh8RPZvLXxt
 hxFw==
X-Gm-Message-State: AOJu0Yyp+JcYJNoDjmjiXvJNee7u13mVEiI6qXvdKMiu6pILpLrWPKbt
 Kn/sMwECF2H74nmKxTi8u0DKNNNx6u2tPN2JcPd03pcy4cqhqkvFRFrcVG004fOKIsLmtKpdYFE
 EJdDajYI4veuBfRuhlyXPIp4GjOI=
X-Google-Smtp-Source: AGHT+IF4ULyp79vHVKCnErKv56EEY5QVIufh8Ke1sg0D3rMX8CtOxwRhNA+gmwstqP74U8S1qR63Ecd80bsVQnOgObs=
X-Received: by 2002:a05:6820:541:b0:5e1:cd24:c19c with SMTP id
 006d021491bc7-5ec5e9adae1mr19801452eaf.0.1730912633794; Wed, 06 Nov 2024
 09:03:53 -0800 (PST)
MIME-Version: 1.0
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
 <20241030141037.375897-1-goldstein.w.n@gmail.com>
 <000c9ef8-c610-4f2a-b191-04b84455d89c@linaro.org>
 <CAFUsyfKkmSid=LVTbG+WHZA_=MAGdf+TU5vGtNE1GGx8WDheOQ@mail.gmail.com>
 <CAFUsyfKfM-X_qGN4Dy8DhES7zRi66s6yVZ3+_KmNM4f2GhBG+Q@mail.gmail.com>
 <f21fe153-6239-4c93-bf60-994976a9dbea@linaro.org>
In-Reply-To: <f21fe153-6239-4c93-bf60-994976a9dbea@linaro.org>
From: Noah Goldstein <goldstein.w.n@gmail.com>
Date: Wed, 6 Nov 2024 11:03:41 -0600
Message-ID: <CAFUsyfLhPkSMrm50RAAvir2-WoRS4_jbtZf1WWR_WZvm=BOr6g@mail.gmail.com>
Subject: Re: linux-user: Add option to run `execve`d programs through QEMU
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, iii@linux.ibm.com, laurent@vivier.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=goldstein.w.n@gmail.com; helo=mail-oo1-xc2a.google.com
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

On Wed, Nov 6, 2024 at 3:38=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/5/24 23:54, Noah Goldstein wrote:
> >>> You still need to handle is_proc_myself, for the guest binary.
> >
> > Would this by handled by basically do:
> >
> > ```
> > if (is_proc_myself(p, "exe")) {
> >          exe =3D exec_path;
> >          if (through_qemu)
> >              argp[argp_offset] =3D exec_path;
> > }
> > ```
> > Or am I missing something?
>
> Something like that, yes.
>
> >>> I wonder if those two cases are related.  Do we need to also add an a=
rgument so that we
> >>> can pass the executable to the next qemu via file descriptor?  I.e. e=
xecvat becomes
> >>>
> >>>       f =3D openat()
> >>>       execv(qemu, "-execfd", f)
> >>>
> >>> and is_proc_myself uses execfd, which we already have open.
> >
> > How does passing a fd from one process to another work?
> As long as the fd is not marked O_CLOEXEC, it stays open in the new proce=
ss.  Providing
> the number via command-line, or whatever, is sufficient for the new proce=
ss to know what
> is going on.

Err I guess I was thinking its a bit weird having an option that is
only really applicable
if qemu is a child process. I.e the `-execfd` argument is not usable
from commandline.

>
> I now realize this is necessary for the AT_EMPTY_PATH flag, where we only=
 have the file
> descriptor.

We could also do something along the lines of:

```
fd =3D openat(dirfd, exe);
char new_exe[PATH_MAX];
char fd_path[PATH_MAX];
sprintf(fd_path, "/proc/self/fd/%d", fd);
readlink(fd_path, new_exe, PATH_MAX);
exe =3D new_exe;
```
>
>
> r~

