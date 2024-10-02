Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6CCCF6D3D
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 16:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw2Qy-000340-Iz; Wed, 02 Oct 2024 12:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1sw2Qj-0002zM-2w
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 12:42:27 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1sw2Qc-00074j-8z
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 12:42:24 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3e039666812so40783b6e.1
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 09:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727887334; x=1728492134; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zHz4JqY/9NsIwQGby2TkCJeUxTR+2lqPHPLqSUFl3+s=;
 b=cInIt4AKJ1gsIiUDrQvaH+th6tYEwDd5Auu0XTEKa7Icv2WgYed6LVaGKBBq1rekHM
 jf/63JcGEKVkIXNO4hz8u62yVdgy+bGLg4bA9dFXkyuIOEQb+cY8njCdisA4PKGtd+q9
 nyaWcBt91jXoEoOW8PItTI7r+BnalV9pPxu/f5Iq6dRsUKP13dK8/Y6aUYCK7o73lDO8
 6GXDQxjO/iN2ibt9H/KzRO+Ct634R2GGIoZcls1FfaVAaYCf28nc0LqULK+RQ346jijI
 PdczCfotoTD4RTq0UvNQdv8xnJ0JE+OLlMmPJCBch1fiP54nBvz2PNEpAeuEiPos+TkB
 dUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727887334; x=1728492134;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zHz4JqY/9NsIwQGby2TkCJeUxTR+2lqPHPLqSUFl3+s=;
 b=v4UEPahLD7er+X4HeS5Tfstsvy4JpF/ZUAcHF1MLv+jfcxiWpe6amodTtdmEnIX8wZ
 jmZ71FHHmxY+KB0BzhPIXX1hDh70LHsY4c1//d6gNC1RpjetZFCQtqydym5oHH0Fsnvm
 qcuwCwfINZH281FOA4BQJf3WpedpzKawwLeTfXb3Qo+h/sSXV0RBpiAz0Rgq/7aJaiEe
 h8/OPW7zuJV8C54iIw8hQfUpI6tsLZZscILynf1ihicfBcBLgvnAX4LdshaoZKhVWFtq
 VXiAhXdaAu2jfeje47h/oA4zV+H2ngUO+fI2QWTnjPF2uUngANpPkgUK6MWAhqi1DVsP
 RWwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHbtO4jiQQbNOwdSgG11LwD3u3dcahiVykx0xIBybbTBWyBTepOGOjEw6xBNfk8otNEczUew3oVOSI@nongnu.org
X-Gm-Message-State: AOJu0YxPGWi2mJPmVNDyXyKwiE1ZHpFKkXkExE4IFtqreEyWgSbC+tCb
 CqZiGNaqTLvSLsqdymSEQaF0fbPmaCfG0WsEZ1oj8E972vwKaWa+ljFgghDCMFWcT5iMLx8ttPr
 df1tTB9P/I2gMKY5dbmv4fdOxicqUbU1D
X-Google-Smtp-Source: AGHT+IH00fTz9bx01fYjFGL6S+z7JF1+GP1wn1F8yNj7OL7Xw1Flq7rqRBgaRA9UvkWe29ioQhqRAqnnC2lHj1PNBtA=
X-Received: by 2002:a05:6871:810:b0:287:16f4:1862 with SMTP id
 586e51a60fabf-28788a718e0mr2735101fac.17.1727887334417; Wed, 02 Oct 2024
 09:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
 <6109eea4230bb3aa7caf6deff526878231aa2136.camel@linux.ibm.com>
 <CAFUsyf+wYJVQHFaJZZ2mE0e3MRXMoQsr+-vk3T0qU3LYd3Dujw@mail.gmail.com>
 <731d741bb01c8157a076a3614d20732a3ea448db.camel@linux.ibm.com>
In-Reply-To: <731d741bb01c8157a076a3614d20732a3ea448db.camel@linux.ibm.com>
From: Noah Goldstein <goldstein.w.n@gmail.com>
Date: Wed, 2 Oct 2024 11:42:03 -0500
Message-ID: <CAFUsyfKhLpZF1RvwVK06jud6ArPEcG7M61cKNoQVWXLRgNaaog@mail.gmail.com>
Subject: Re: [PATCH v1] linux-user: Add option to run `execve`d programs
 through QEMU
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: laurent@vivier.eu, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=goldstein.w.n@gmail.com; helo=mail-oi1-x22a.google.com
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

On Wed, Oct 2, 2024 at 11:39=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> On Wed, 2024-10-02 at 09:05 -0500, Noah Goldstein wrote:
> > On Wed, Oct 2, 2024 at 3:08=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.=
com>
> > wrote:
> > >
> > > On Fri, 2024-08-30 at 15:36 -0700, Noah Goldstein wrote:
> > > > The new option '-qemu-children' makes it so that on `execve` the
> > > > child
> > > > process will be launch by the same `qemu` executable that is
> > > > currently
> > > > running along with its current commandline arguments.
> > > >
> > > > The motivation for the change is to make it so that plugins
> > > > running
> > > > through `qemu` can continue to run on children.  Why not just
> > > > `binfmt`?: Plugins can be desirable regardless of
> > > > system/architecture
> > > > emulation, and can sometimes be useful for elf files that can run
> > > > natively. Enabling `binfmt` for all natively runnable elf files
> > > > may
> > > > not be desirable.
> > >
> > > Another reason to have this is that one may not have root
> > > permissions
> > > to configure binfmt-misc.
> > >
> > +1
> >
> > > There was a similar patch posted to the mailing list some years
> > > back,
> > > which I used to cherry-pick when I needed this. I'm not sure what
> > > happened to that discussion though.
> >
> > Yes(ish):
> > https://patchwork.ozlabs.org/project/qemu-devel/patch/1455515507-26877-=
1-git-send-email-petrosagg@resin.io/
>
> Thanks for finding this! Don't we need the shebang handling here as
> well?
>
I don't think so. In this case we aren't making it so execve can point to
some arbitrary impl, just that we propagate the current running qemu
env.

> Laurent, do you per chance know why was it not accepted back
> then?Unfortunately I cannot find any discussion associated with v3 or
> v4
> [1]. There were some concerns regarding v1 [2], but from what I can see
> they all were addressed.
>
> [1]
> https://patchew.org/QEMU/20200730160106.16613-1-rj.bcjesus@gmail.com/
> [2]
> https://patchwork.kernel.org/project/qemu-devel/patch/1453091602-21843-1-=
git-send-email-petrosagg@gmail.com/

