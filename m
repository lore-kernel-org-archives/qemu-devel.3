Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035F4D0EE19
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 18:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szK9g-0005pI-PQ; Fri, 11 Oct 2024 14:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1szK9e-0005ol-IR
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 14:14:22 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1szK9c-0003EM-Ro
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 14:14:22 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-27d0e994ae3so1111838fac.3
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 11:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728670459; x=1729275259; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L4O3LWabg15STyQXYpP/TLRokT3+tDXwcYmsZ+S5u5M=;
 b=XgXDK57xHLKE8yBnkuSnfBp8T90/oqcniHIaMo/dMwPBc63tzzrjUhuvOK2rS8/OVH
 wU+g2TQ3Ih+RaDrBJPDK7NhmT51rKcb7CFpivaQzcPaHdOIsFuGIQvDRb+Ju+n3nypDp
 1ZIM9TyHdDQDqxND2WB+qjT4y+CWFTJPv1YRkkHuCfQIdjXIuMKO8UpfVgDaa4VmFBtk
 i7AeiRrfk9xiFSr3q2VFmmL38orUwg87vhdA3id8MR8vIU4E+Gyv6oZu/KrhWwZI7Jmy
 gGOYdnFeqZxThUfBpxCoaAQ1IFrohtybJ/OOUPJnUKxILI8OKoAUhsQlfOahOuGg/Kw5
 ldJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728670459; x=1729275259;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L4O3LWabg15STyQXYpP/TLRokT3+tDXwcYmsZ+S5u5M=;
 b=pMVOugmRzdxQAIO4u8jp9BT+4rJoGMKvbaU9rBkFTgfR7zw5aqF5eEmR52YsFVG2Io
 141ITEgq51PX9OBqBoH7aDR0p+Zzdtca0NDcrSZkaz1Imclkyl6K2uEKLlCuK+q1yZDo
 KK9yzgz7Sh2lIzafBbcWVS7iTWRAuJKSYWxBraEqxxR36OVcF0rz9M5SRHgeYf6OYCzM
 s5lsAHraAi350cVQ2E5Q23saoF3bXaa8roUuiZHRqmBNUImUIAgCf+nKvjZvNU3rdYci
 WqMWxPEcBAKevwfaJzZ2q/JrfEQ5kYVwtTNReS7vp82oXbQS0urlhs3O3Y0G2fJkBYm9
 EfLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCzap4cNuxJMLKS6jIKDZvvHEGH2AYuFsz8cI2sMH6aDVSOTFneQdqDY8tErP8WnH7XiBuJXdftEYg@nongnu.org
X-Gm-Message-State: AOJu0YwckvX75kmM9Bpl+7fRV7uCtVQdFwpgLaUV/g79+SnPcm1r8DQ9
 EfNs4KWBGjw0egMoyfovx7eWUhorlrqhR4X7r94D1+nG5yRYwDDFXqOjLUvqie9i4hyob+GDr0X
 rc6GlOFEw0kQUFRIfqO5l40gmA/Y=
X-Google-Smtp-Source: AGHT+IFd44ffgzW7GaS8tj9hCmmDrCXvA0mPVV5wkpQxYDgBYD0KzzPZqCASJFg3XqFnXzrXfQhLbAWJt9B27lpgTVs=
X-Received: by 2002:a05:6870:b69b:b0:270:172c:32ae with SMTP id
 586e51a60fabf-28887477218mr370305fac.32.1728670458613; Fri, 11 Oct 2024
 11:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
 <6109eea4230bb3aa7caf6deff526878231aa2136.camel@linux.ibm.com>
 <CAFUsyf+wYJVQHFaJZZ2mE0e3MRXMoQsr+-vk3T0qU3LYd3Dujw@mail.gmail.com>
 <731d741bb01c8157a076a3614d20732a3ea448db.camel@linux.ibm.com>
 <CAFUsyfKhLpZF1RvwVK06jud6ArPEcG7M61cKNoQVWXLRgNaaog@mail.gmail.com>
In-Reply-To: <CAFUsyfKhLpZF1RvwVK06jud6ArPEcG7M61cKNoQVWXLRgNaaog@mail.gmail.com>
From: Noah Goldstein <goldstein.w.n@gmail.com>
Date: Fri, 11 Oct 2024 13:14:07 -0500
Message-ID: <CAFUsyfKgw_DAfowOoFxUpHOR+Jw6hH9oV5JGNXKe0Ph=miRFxw@mail.gmail.com>
Subject: Re: [PATCH v1] linux-user: Add option to run `execve`d programs
 through QEMU
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: laurent@vivier.eu, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=goldstein.w.n@gmail.com; helo=mail-oa1-x2c.google.com
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

On Wed, Oct 2, 2024 at 11:42=E2=80=AFAM Noah Goldstein <goldstein.w.n@gmail=
.com> wrote:
>
> On Wed, Oct 2, 2024 at 11:39=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.c=
om> wrote:
> >
> > On Wed, 2024-10-02 at 09:05 -0500, Noah Goldstein wrote:
> > > On Wed, Oct 2, 2024 at 3:08=E2=80=AFAM Ilya Leoshkevich <iii@linux.ib=
m.com>
> > > wrote:
> > > >
> > > > On Fri, 2024-08-30 at 15:36 -0700, Noah Goldstein wrote:
> > > > > The new option '-qemu-children' makes it so that on `execve` the
> > > > > child
> > > > > process will be launch by the same `qemu` executable that is
> > > > > currently
> > > > > running along with its current commandline arguments.
> > > > >
> > > > > The motivation for the change is to make it so that plugins
> > > > > running
> > > > > through `qemu` can continue to run on children.  Why not just
> > > > > `binfmt`?: Plugins can be desirable regardless of
> > > > > system/architecture
> > > > > emulation, and can sometimes be useful for elf files that can run
> > > > > natively. Enabling `binfmt` for all natively runnable elf files
> > > > > may
> > > > > not be desirable.
> > > >
> > > > Another reason to have this is that one may not have root
> > > > permissions
> > > > to configure binfmt-misc.
> > > >
> > > +1
> > >
> > > > There was a similar patch posted to the mailing list some years
> > > > back,
> > > > which I used to cherry-pick when I needed this. I'm not sure what
> > > > happened to that discussion though.
> > >
> > > Yes(ish):
> > > https://patchwork.ozlabs.org/project/qemu-devel/patch/1455515507-2687=
7-1-git-send-email-petrosagg@resin.io/
> >
> > Thanks for finding this! Don't we need the shebang handling here as
> > well?
> >
> I don't think so. In this case we aren't making it so execve can point to
> some arbitrary impl, just that we propagate the current running qemu
> env.
>

ping
> > Laurent, do you per chance know why was it not accepted back
> > then?Unfortunately I cannot find any discussion associated with v3 or
> > v4
> > [1]. There were some concerns regarding v1 [2], but from what I can see
> > they all were addressed.
> >
> > [1]
> > https://patchew.org/QEMU/20200730160106.16613-1-rj.bcjesus@gmail.com/
> > [2]
> > https://patchwork.kernel.org/project/qemu-devel/patch/1453091602-21843-=
1-git-send-email-petrosagg@gmail.com/

