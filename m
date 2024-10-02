Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8CBCF6D3C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 16:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw2LV-0000jN-Qj; Wed, 02 Oct 2024 12:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1sw2LT-0000ix-67
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 12:36:59 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1sw2LR-0006AZ-9L
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 12:36:58 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5e57b7cac4fso11695eaf.1
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 09:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727887016; x=1728491816; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SuDLSFmwpPOIcTxZtFXv/AMFbKOdXN3k4t3ZVlnmJ1M=;
 b=lrn9XPSNBMFrGUuVVkGBeCGHQOSJItm0LWT6IThq3AMGnRToJPaaSp7TYd7ApBgFOM
 24yoF7TQUbW3FMvXtogxfzl3v0Aij33FYsy0zdOiHxKz6rXitP9WKmexc0e2Adj6Nci0
 kKhAq1xEUbAFi9g67afoF3ehnEBrDl3TDCkhZ6xUfMouQ+YbfIC754OL5cYI7JDiNsKs
 WY+QGs/G2m5PYqmOOa8zNVVzZC5vPY8oBnjah99cw3IP46C71jUacfqyKczU3uC2EPkI
 aOJEssLmInou40yOeZns9GZLXGhCfQHwyyzJ6t4USYlIiznH9V+QFYe69v2O7Af7eId6
 Fqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727887016; x=1728491816;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SuDLSFmwpPOIcTxZtFXv/AMFbKOdXN3k4t3ZVlnmJ1M=;
 b=p9j90vugA2Qi2h6TWMQfEah6/I0OyQSzuENcSYDeN00iGGbhvUpFXGy5jbEW7hWLo5
 TEfK1EQTHbeaVbbDUtDOQHtndw2oFXS52do56xviUtC+zPhgj7ElgCxWYqRXRuEi7gBo
 luPIxPIaYbTNyeOmqKMvNhciX81V5O8s5tpsS/qi1+nhcw1vj7dv2BqdNza3UnW+hjQj
 0O1QTqF0NY/r6q2h1C785rJhFA2Z4xUFHqRKf2jiti659RATXrjRtN7KKbxnhk36U8aH
 AqrSwm/K4wPzwv8Ec1oGkRGP+n0fFcPNgtpq4iu2xeWuxfsFjBN9Hwlq4qhj55AxDtTJ
 a9Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd0QCEhKb/gGYsci+VbB6+AUahEwbDqxKHPxYPL9eg3KuPhjOwjy/k3dV7kFo8PJ12EW24tYU0M7rb@nongnu.org
X-Gm-Message-State: AOJu0YyZosHkaOPfVE2b+AY1kgdfML3n0jh8OmGEvJkHdnwpkEYR3BF2
 ce92Jj2iSwiUmiBl3ow61SRbGx41IAptpdBcbjttV2Y66EX76EmoYc9sL7QCBSAflqzCL8Qf1sE
 DH7nEULY5mkFYRN1hxIk9INvZNmA=
X-Google-Smtp-Source: AGHT+IE0MyFMUU/PqRjd2RrngaZ+73WHhdZ3H30VWKdCO29REPUXkVaMi0ZEnRSmpE4bE0JhJsbrEHgZ8+pUs7biX2I=
X-Received: by 2002:a05:6871:810:b0:287:16f4:1862 with SMTP id
 586e51a60fabf-28788a718e0mr2722686fac.17.1727887016016; Wed, 02 Oct 2024
 09:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
 <6109eea4230bb3aa7caf6deff526878231aa2136.camel@linux.ibm.com>
 <1251d17b-71f4-4630-b71f-990860bd9366@vivier.eu>
 <4d6c668781d12b8cd0c1fd18fbc4ef2abcf74806.camel@linux.ibm.com>
 <CAFUsyf++kWARZRJ0MriagYaoyJoJyKaHM09cQULiFECJ=bc4Uw@mail.gmail.com>
 <693ff38ebf2982d47cc419a406703e9e91dc79fd.camel@linux.ibm.com>
 <CAFUsyfKddfkryMX3Jn+2uDrteHDDgdzrQ3A4k5oXNpHq2FG_Gw@mail.gmail.com>
 <c2e3d873cee9d9548d632a5a27f4af06ce82bf88.camel@linux.ibm.com>
 <CAFUsyfL6pK_KTtcKVL9MkNBrMBivRfc-JPqhtY=DPgbCwKwjDg@mail.gmail.com>
 <f8f83b4498f6934ea54e2d764441d719c29bb23a.camel@linux.ibm.com>
In-Reply-To: <f8f83b4498f6934ea54e2d764441d719c29bb23a.camel@linux.ibm.com>
From: Noah Goldstein <goldstein.w.n@gmail.com>
Date: Wed, 2 Oct 2024 11:36:45 -0500
Message-ID: <CAFUsyf+cK7SjjvTcQJVPzBHHZwoRGWjVfLhHPT9nzY6jsvd0RA@mail.gmail.com>
Subject: Re: [PATCH v1] linux-user: Add option to run `execve`d programs
 through QEMU
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=goldstein.w.n@gmail.com; helo=mail-oo1-xc2c.google.com
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

On Wed, Oct 2, 2024 at 11:35=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> On Wed, 2024-10-02 at 11:24 -0500, Noah Goldstein wrote:
> > On Wed, Oct 2, 2024 at 11:14=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm=
.com>
> > wrote:
> > >
> > > On Wed, 2024-10-02 at 10:10 -0500, Noah Goldstein wrote:
> > > > On Wed, Oct 2, 2024 at 9:53=E2=80=AFAM Ilya Leoshkevich
> > > > <iii@linux.ibm.com>
> > > > wrote:
> > > > >
> > > > > On Wed, 2024-10-02 at 09:44 -0500, Noah Goldstein wrote:
> > > > > > On Wed, Oct 2, 2024 at 9:38=E2=80=AFAM Ilya Leoshkevich
> > > > > > <iii@linux.ibm.com>
> > > > > > wrote:
> > > > > > >
> > > > > > > On Wed, 2024-10-02 at 16:08 +0200, Laurent Vivier wrote:
> > > > > > > > Le 02/10/2024 =C3=A0 10:08, Ilya Leoshkevich a =C3=A9crit :
> > > > > > > > > On Fri, 2024-08-30 at 15:36 -0700, Noah Goldstein
> > > > > > > > > wrote:
> > > > > > > > > > The new option '-qemu-children' makes it so that on
> > > > > > > > > > `execve`
> > > > > > > > > > the
> > > > > > > > > > child
> > > > > > > > > > process will be launch by the same `qemu` executable
> > > > > > > > > > that
> > > > > > > > > > is
> > > > > > > > > > currently
> > > > > > > > > > running along with its current commandline arguments.
> > > > > > > > > >
> > > > > > > > > > The motivation for the change is to make it so that
> > > > > > > > > > plugins
> > > > > > > > > > running
> > > > > > > > > > through `qemu` can continue to run on children.  Why
> > > > > > > > > > not
> > > > > > > > > > just
> > > > > > > > > > `binfmt`?: Plugins can be desirable regardless of
> > > > > > > > > > system/architecture
> > > > > > > > > > emulation, and can sometimes be useful for elf files
> > > > > > > > > > that
> > > > > > > > > > can
> > > > > > > > > > run
> > > > > > > > > > natively. Enabling `binfmt` for all natively runnable
> > > > > > > > > > elf
> > > > > > > > > > files
> > > > > > > > > > may
> > > > > > > > > > not be desirable.
> > > > > > > > >
> > > > > > > > > Another reason to have this is that one may not have
> > > > > > > > > root
> > > > > > > > > permissions
> > > > > > > > > to configure binfmt-misc.
> > > > > > > >
> > > > > > > > A little note on that: binfmt_misc is now part of the
> > > > > > > > user
> > > > > > > > namespace
> > > > > > > > (since linux v6.7), so you can
> > > > > > > > configure binfmt_misc as a non root user in a given
> > > > > > > > namepace.
> > > > > > > >
> > > > > > > > There is helper to use it with unshare from util-linux,
> > > > > > > > you
> > > > > > > > can
> > > > > > > > do
> > > > > > > > things like that:
> > > > > > > >
> > > > > > > >    With 'F' flag, load the interpreter from the initial
> > > > > > > > namespace:
> > > > > > > >
> > > > > > > >      $ /bin/qemu-m68k-static --version
> > > > > > > >      qemu-m68k version 8.2.2 (qemu-8.2.2-1.fc40)
> > > > > > > >      Copyright (c) 2003-2023 Fabrice Bellard and the QEMU
> > > > > > > > Project
> > > > > > > > developers
> > > > > > > >      $ unshare --map-root-user --fork --pid
> > > > > > > > --load-interp=3D":qemu-
> > > > > > > > m68k:M::\\x7fELF\\x01\\x02\\x01\\x00\\x00\\x00\\x00\\x00\
> > > > > > > > \x00
> > > > > > > > \\x0
> > > > > > > > 0\\x
> > > > > > > > 00\\x00\\x00\\x02\\x00\\x04:\\xff\\xff\\xff\\xff\\xff\\xf
> > > > > > > > f\\x
> > > > > > > > fe\\
> > > > > > > > x00\
> > > > > > > > \xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xfe\\xff\\x
> > > > > > > > ff:/
> > > > > > > > bin/
> > > > > > > > qemu
> > > > > > > > -m68k-static:OCF"
> > > > > > > > --root=3Dchroot/m68k/sid
> > > > > > > >      # QEMU_VERSION=3D ls
> > > > > > > >      qemu-m68k version 8.2.2 (qemu-8.2.2-1.fc40)
> > > > > > > >      Copyright (c) 2003-2023 Fabrice Bellard and the QEMU
> > > > > > > > Project
> > > > > > > > developers
> > > > > > > >      # /qemu-m68k  --version
> > > > > > > >      qemu-m68k version 8.0.50 (v8.0.0-340-gb1cff5e2da95)
> > > > > > > >      Copyright (c) 2003-2022 Fabrice Bellard and the QEMU
> > > > > > > > Project
> > > > > > > > developers
> > > > > > > >
> > > > > > > >    Without 'F' flag, from inside the namespace:
> > > > > > > >
> > > > > > > >      $ unshare --map-root-user --fork --pid
> > > > > > > > --load-interp=3D":qemu-
> > > > > > > > m68k:M::\\x7fELF\\x01\\x02\\x01\\x00\\x00\\x00\\x00\\x00\
> > > > > > > > \x00
> > > > > > > > \\x0
> > > > > > > > 0\\x
> > > > > > > > 00\\x00\\x00\\x02\\x00\\x04:\\xff\\xff\\xff\\xff\\xff\\xf
> > > > > > > > f\\x
> > > > > > > > fe\\
> > > > > > > > x00\
> > > > > > > > \xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xfe\\xff\\x
> > > > > > > > ff:/
> > > > > > > > qemu
> > > > > > > > -
> > > > > > > > m68k:OC"
> > > > > > > > --root=3Dchroot/m68k/sid
> > > > > > > >      # QEMU_VERSION=3D ls
> > > > > > > >      qemu-m68k version 8.0.50 (v8.0.0-340-gb1cff5e2da95)
> > > > > > > >      Copyright (c) 2003-2022 Fabrice Bellard and the QEMU
> > > > > > > > Project
> > > > > > > > developers
> > > > > > > >      # /qemu-m68k  --version
> > > > > > > >      qemu-m68k version 8.0.50 (v8.0.0-340-gb1cff5e2da95)
> > > > > > > >      Copyright (c) 2003-2022 Fabrice Bellard and the QEMU
> > > > > > > > Project
> > > > > > > > developers
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > > Laurent
> > > > > > > >
> > > > > > >
> > > > > > > Thanks for posting this, I wasn't aware of this feature and
> > > > > > > it
> > > > > > > looks
> > > > > > > really useful.
> > > > > > >
> > > > > > > IIUC it also resolves the main problem this patch is
> > > > > > > dealing
> > > > > > > with:
> > > > > >
> > > > > > I might misunderstand, but I don't think it does in the sense
> > > > > > that it still might not be desirable to use the same qemu
> > > > > > flags
> > > > > > for the entire class of executables.
> > > > > >
> > > > > > I.e the original motivating case was wanting to attach
> > > > > > some plugins to a process and its children and AFAICT
> > > > > > binfmt still doesn't give that level of control.
> > > > >
> > > > > I think if you start a process in a user namespace, which has a
> > > > > binfmt_misc handler for a certain class of binaries, then this
> > > > > handler
> > > > > will affect only this process and its children, and not the
> > > > > rest of
> > > > > the
> > > > > system.
> > > >
> > > > It won't also affect other binaries in the user namespace?
> > >
> > > It would, but you should be able to create a user namespace just
> > > for your program. It should also be possible to nest user
> > > namespaces.
> >
> > Okay fair enough. Still pro this patch as an easier means
> > but guess it loses any necessity.
> >
> > To be clear, are you rejecting?
>
> No, personally I still find it useful, because the systems with old
> kernels will be around for quite some time.

:)

>
> > > > > > >   Enabling `binfmt` for all natively runnable elf files may
> > > > > > >   not be desirable.
>

