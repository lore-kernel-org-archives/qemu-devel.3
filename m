Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CDDD59F5A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8kDV-00040v-ND; Wed, 06 Nov 2024 12:53:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1t8kDU-0003yr-2u
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:53:16 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1t8kDS-0002cL-LM
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:53:15 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5edfe8c17c4so24702eaf.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 09:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730915593; x=1731520393; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6PiCNtf8A5FwHORTBrgGd0kboaXapNH3Eh5+IkThw3k=;
 b=f+hqkB7niJWiuJX9+t5g6rMNqxyZ18iCvvzK4dEu3cjgeNbWx/7kIrE7p2CixwseSF
 63U232V3pCHbBXpMXs3ZAa+ZaRRDrriZVJBtlQfRklNXNwX5hSlnqay2t7kGA15+6f1U
 2ID1OR+ATVpGrh49NrWhPjv4b7sCxHDdJkLu9KMUoyG/5y4SM5NbSAZvLjUIlmiNHvWJ
 G+figkx45X9gQv+eTujN1z9p8s53lWjeVJRwwSLtvv/rz8z2K/D4i/ElN6TAKCTuL0SD
 Ia7W1uSyHFnWI3ck95H8DA0A5PfrorWnoeeP5eQc6KRhAnqHlL7QEY9Tob3Tj0HcNLxi
 YgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730915593; x=1731520393;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6PiCNtf8A5FwHORTBrgGd0kboaXapNH3Eh5+IkThw3k=;
 b=hQU5+lwVmg2Hs5O937/lRWUMQDN/j7JebdudN+IU1h7BpsQnexmMwxJ9UYmPtfJqbb
 U8tZSVy2MnfzL1bhX1J/rA9Mrod7/N2a35KOczxTaKzJzpPg8TA2nTvwXqXzmInq0DRz
 DZ97zmhvxO9d+VrH61oHb7oIbl1r87xGtoTKR5WTEwNJXrivMtLyyCu+PfxlUY7JRpCU
 ME3d11WTcCQQl5CqNVcNMbbjxkKmR09xpYT9kaO5yUZeITB220dj5XR8yXG3qWigFh/0
 /qHFI/+AzKLv2MubIJPvJTJcWEboTIDCZ3ds0jz05WIVLAMiutR3RRY8paUevPMM9/6l
 dMmw==
X-Gm-Message-State: AOJu0Yz+PXj8Goy5QD5eFoIRPwCfcoNZVikbIboIKFPMB5GK9moeqPP2
 PxSP7eOv+8HmlgG6I2waPtGY7atSWMg+WYtD3Hbcmy7jmEbwsIIJdLbBUbCc/1xPkCzA7VNQNlw
 7iwPy5v8uClgQKSGjig9JvLFFAv8=
X-Google-Smtp-Source: AGHT+IGjhK15rC3Xpv80r2kF31tBP+R/WWzohfNl5LO+7DUqzSuQJmz3AqkdQWf5Zs42R8/+N0Pk3yy1ZZDdLWzsZWo=
X-Received: by 2002:a05:6820:1c93:b0:5e7:caf5:ae03 with SMTP id
 006d021491bc7-5ede631771amr14160593eaf.2.1730915593447; Wed, 06 Nov 2024
 09:53:13 -0800 (PST)
MIME-Version: 1.0
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
 <20241030141037.375897-1-goldstein.w.n@gmail.com>
 <000c9ef8-c610-4f2a-b191-04b84455d89c@linaro.org>
 <CAFUsyfKkmSid=LVTbG+WHZA_=MAGdf+TU5vGtNE1GGx8WDheOQ@mail.gmail.com>
 <CAFUsyfKfM-X_qGN4Dy8DhES7zRi66s6yVZ3+_KmNM4f2GhBG+Q@mail.gmail.com>
 <f21fe153-6239-4c93-bf60-994976a9dbea@linaro.org>
 <CAFUsyfLhPkSMrm50RAAvir2-WoRS4_jbtZf1WWR_WZvm=BOr6g@mail.gmail.com>
 <e63cd5f6-8387-4c39-98e4-5e1c180934bc@linaro.org>
In-Reply-To: <e63cd5f6-8387-4c39-98e4-5e1c180934bc@linaro.org>
From: Noah Goldstein <goldstein.w.n@gmail.com>
Date: Wed, 6 Nov 2024 11:53:01 -0600
Message-ID: <CAFUsyf+8sJLX+qqzPEj1E1QPQpoP4n56uU5U9aksq8JEx_52gA@mail.gmail.com>
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

On Wed, Nov 6, 2024 at 11:26=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/6/24 17:03, Noah Goldstein wrote:
> > On Wed, Nov 6, 2024 at 3:38=E2=80=AFAM Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> On 11/5/24 23:54, Noah Goldstein wrote:
> >>>>> You still need to handle is_proc_myself, for the guest binary.
> >>>
> >>> Would this by handled by basically do:
> >>>
> >>> ```
> >>> if (is_proc_myself(p, "exe")) {
> >>>           exe =3D exec_path;
> >>>           if (through_qemu)
> >>>               argp[argp_offset] =3D exec_path;
> >>> }
> >>> ```
> >>> Or am I missing something?
> >>
> >> Something like that, yes.
> >>
> >>>>> I wonder if those two cases are related.  Do we need to also add an=
 argument so that we
> >>>>> can pass the executable to the next qemu via file descriptor?  I.e.=
 execvat becomes
> >>>>>
> >>>>>        f =3D openat()
> >>>>>        execv(qemu, "-execfd", f)
> >>>>>
> >>>>> and is_proc_myself uses execfd, which we already have open.
> >>>
> >>> How does passing a fd from one process to another work?
> >> As long as the fd is not marked O_CLOEXEC, it stays open in the new pr=
ocess.  Providing
> >> the number via command-line, or whatever, is sufficient for the new pr=
ocess to know what
> >> is going on.
> >
> > Err I guess I was thinking its a bit weird having an option that is
> > only really applicable
> > if qemu is a child process. I.e the `-execfd` argument is not usable
> > from commandline.
>
> qemu-foo -execfd 3 3< /some/file
>
> Or perhaps opened via other tooling.
>
> >> I now realize this is necessary for the AT_EMPTY_PATH flag, where we o=
nly have the file
> >> descriptor.
> >
> > We could also do something along the lines of:
> >
> > ```
> > fd =3D openat(dirfd, exe);
> > char new_exe[PATH_MAX];
> > char fd_path[PATH_MAX];
> > sprintf(fd_path, "/proc/self/fd/%d", fd);
> > readlink(fd_path, new_exe, PATH_MAX);
>
> Reading the link doesn't always work.
> Reading or passing the link means AT_SYMLINK_NOFOLLOW isn't honored.

Okay, fair enough, I will get started on adding `-execfd`
>
>
> r~

