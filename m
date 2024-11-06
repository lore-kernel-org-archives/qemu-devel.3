Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3C1D59F5B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 18:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8kXH-0006u6-Hq; Wed, 06 Nov 2024 13:13:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1t8kXF-0006ti-29
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:13:41 -0500
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1t8kXD-0008Fl-EU
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:13:40 -0500
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5ebc52deca0so34417eaf.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 10:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730916818; x=1731521618; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j+jFSWZIm5vjDa3MFBh/X7wuoN4A+dDxKPBCZ9XsL2w=;
 b=LAxebsCauCx8eN/rOfHgtwJnwl8PREu7ryEWRU0JJP7Rk1zhGs8kBwiE8LzG9Lr9IN
 Y02sYbDP8DEE1pd4plKLqs6t9EK5dmHJaS/nmUsb+khodsot71GO4G/r5n5nJQ4OGGEH
 uZyk5diTkYfPJvz8NoqzC999ezEm8xl6wr766NB7GJRGihI3KVNXvX9mxqDHY/05wAVj
 TtMigVm6FyWh+80wIIZCciFbfLYVGrQRFNjvdpTlXg3GHmx34iSoPVSUSnuFB27bPQvN
 gSVPakFhn+D0ccdOxwlTSzuyw/HrP2g8NwUE0BZYImKdtaMjG6IsKlirJoVAkQKdpHc0
 Qe2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730916818; x=1731521618;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j+jFSWZIm5vjDa3MFBh/X7wuoN4A+dDxKPBCZ9XsL2w=;
 b=HF28GYSXDXLf/hqzlofDyOXYEzJiIoail+xVHjFYO+/mb4aqQlpGokz2hW1Zmvc58v
 QpbYIYM3EVvrDAnvsEJnsWnkeyP+QbJKiCEfj7QL60tAjk3XBO/XTXl7sq6Jkx21xYrI
 4BXpAKp4smK0TqPCbbosqUykYGjqGIV5mBS9xsqq7n51U7HfKJkLBoXa/vDJy7iLrmle
 BTT7yqk2steTAT3TMaGbDE9PqDGIXOAJepcK3iFGHg9M4G9TWdhb7iCJX6beRPRbVQ/X
 AK5lPaWUINwI0IRkNI+btvC6Lmwg6tGz2IR7lMCP1SOVe4psYV0i8lP3DI46u4XVyGng
 e12g==
X-Gm-Message-State: AOJu0Yzfne7TepEf12f2NEbjEhcyGsFH+vf+p64a9arffvh03TOhS6TP
 vvFX3Gagg1mcjFIScF19WgJMoPxycYWzyGR6semk01DXNnwygjYxTKd8YWqHpHAe6k95xXsFpXa
 jqZARjnh7Rxd8IB81XmwlUEVucGEkea7lQqY=
X-Google-Smtp-Source: AGHT+IFnoT55fzvPeh0y3bniCsSJkX1kOvO4tJnWTw09/DFI5VaaTxw4uZfNDlxBS9rVIszJtOvA8PR6hjKTNE+pBr8=
X-Received: by 2002:a05:6820:1512:b0:5ee:56d:69f8 with SMTP id
 006d021491bc7-5ee056d7549mr10362919eaf.7.1730916818052; Wed, 06 Nov 2024
 10:13:38 -0800 (PST)
MIME-Version: 1.0
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
 <20241030141037.375897-1-goldstein.w.n@gmail.com>
 <000c9ef8-c610-4f2a-b191-04b84455d89c@linaro.org>
 <CAFUsyfKkmSid=LVTbG+WHZA_=MAGdf+TU5vGtNE1GGx8WDheOQ@mail.gmail.com>
 <CAFUsyfKfM-X_qGN4Dy8DhES7zRi66s6yVZ3+_KmNM4f2GhBG+Q@mail.gmail.com>
 <f21fe153-6239-4c93-bf60-994976a9dbea@linaro.org>
 <CAFUsyfLhPkSMrm50RAAvir2-WoRS4_jbtZf1WWR_WZvm=BOr6g@mail.gmail.com>
 <e63cd5f6-8387-4c39-98e4-5e1c180934bc@linaro.org>
 <CAFUsyf+8sJLX+qqzPEj1E1QPQpoP4n56uU5U9aksq8JEx_52gA@mail.gmail.com>
In-Reply-To: <CAFUsyf+8sJLX+qqzPEj1E1QPQpoP4n56uU5U9aksq8JEx_52gA@mail.gmail.com>
From: Noah Goldstein <goldstein.w.n@gmail.com>
Date: Wed, 6 Nov 2024 12:13:27 -0600
Message-ID: <CAFUsyf+xVXamR+5gtu62vFXjYScrJu0Arvhk62QXYa359UCHsg@mail.gmail.com>
Subject: Re: linux-user: Add option to run `execve`d programs through QEMU
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, iii@linux.ibm.com, laurent@vivier.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=goldstein.w.n@gmail.com; helo=mail-oo1-xc29.google.com
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

On Wed, Nov 6, 2024 at 11:53=E2=80=AFAM Noah Goldstein <goldstein.w.n@gmail=
.com> wrote:
>
> On Wed, Nov 6, 2024 at 11:26=E2=80=AFAM Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 11/6/24 17:03, Noah Goldstein wrote:
> > > On Wed, Nov 6, 2024 at 3:38=E2=80=AFAM Richard Henderson
> > > <richard.henderson@linaro.org> wrote:
> > >>
> > >> On 11/5/24 23:54, Noah Goldstein wrote:
> > >>>>> You still need to handle is_proc_myself, for the guest binary.
> > >>>
> > >>> Would this by handled by basically do:
> > >>>
> > >>> ```
> > >>> if (is_proc_myself(p, "exe")) {
> > >>>           exe =3D exec_path;
> > >>>           if (through_qemu)
> > >>>               argp[argp_offset] =3D exec_path;
> > >>> }
> > >>> ```
> > >>> Or am I missing something?
> > >>
> > >> Something like that, yes.
> > >>
> > >>>>> I wonder if those two cases are related.  Do we need to also add =
an argument so that we
> > >>>>> can pass the executable to the next qemu via file descriptor?  I.=
e. execvat becomes
> > >>>>>
> > >>>>>        f =3D openat()
> > >>>>>        execv(qemu, "-execfd", f)
> > >>>>>
> > >>>>> and is_proc_myself uses execfd, which we already have open.
> > >>>
> > >>> How does passing a fd from one process to another work?
> > >> As long as the fd is not marked O_CLOEXEC, it stays open in the new =
process.  Providing
> > >> the number via command-line, or whatever, is sufficient for the new =
process to know what
> > >> is going on.
> > >
> > > Err I guess I was thinking its a bit weird having an option that is
> > > only really applicable
> > > if qemu is a child process. I.e the `-execfd` argument is not usable
> > > from commandline.
> >
> > qemu-foo -execfd 3 3< /some/file
> >
> > Or perhaps opened via other tooling.
> >
> > >> I now realize this is necessary for the AT_EMPTY_PATH flag, where we=
 only have the file
> > >> descriptor.
> > >
> > > We could also do something along the lines of:
> > >
> > > ```
> > > fd =3D openat(dirfd, exe);
> > > char new_exe[PATH_MAX];
> > > char fd_path[PATH_MAX];
> > > sprintf(fd_path, "/proc/self/fd/%d", fd);
> > > readlink(fd_path, new_exe, PATH_MAX);
> >
> > Reading the link doesn't always work.
> > Reading or passing the link means AT_SYMLINK_NOFOLLOW isn't honored.
>
> Okay, fair enough, I will get started on adding `-execfd`

Question about impl regarding handling of `-execfd` with/without a program =
name.

1) `-execfd` + program name ie: `qemu -execfd <some_fd> ls -a`.
2) `-execfd` without program name i.e: `qemu -execfd <some_fd> -a`.

Do you want to allow both of these? If you want to allow (1), what should
we use for `argv[0]`/`exec_path`. The program pass ("ls") or
`readlink(<some_fd>)`?

