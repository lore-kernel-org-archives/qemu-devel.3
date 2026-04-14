Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF5DF9D0D1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCeGS-0004B1-2S; Tue, 14 Apr 2026 09:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wCeGP-0004AN-Lc
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:57:13 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wCeGL-0001vW-RG
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:57:13 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-358ed696623so2461242a91.0
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 06:57:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776175028; cv=none;
 d=google.com; s=arc-20240605;
 b=QLogO74Mg1XkSCRMhMXGom3K3w+5SbfwzlbM/p4OP9DHDuHBIoqaes8XPGSAnos/3R
 vtOr1nOG7pHZqx4xlMxXqdhvweuBVCdhN8YTQjtTvLywjXKrtO3VGriogj0ke/FUmRSi
 mGLiHO58+MIHwOoxFEc6u2isfy46Go7yDYMGp2cPZoA7SzDCHf4QQmIegcR+eAKHKECw
 T3D2HsCzKtiTM8Mux/YSA+3V/dMVK2JHiMUUGT+eaU9ZSX7CX7zv0C89j9yJ/Bo1psgV
 rO/DtDnwFw8BYP2sphviqAWjaNPrRUxKSYN7qEijXAipdro9v6/uLCku1Yv5EdpkSlhQ
 m+TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RtBZyzbBkln5G4M6t9DIJpY3Su3ba/JxieaX6d73v9M=;
 fh=zLnaIXgodYFBfAy2HucWE6FDGaJ6z3LdlBRHxnJ8p2k=;
 b=gDlzYB7HkoSX3CV4lhd88cinTCLj1ITKvBRmFvyu9nHP87NqYtK8hx+eLbsM1Fvr6f
 +8PEv7WxGz1FOyJrfB+EuPuGQGRH0pUohZQlesaKD81x1oXymMmYMLcFv6FVllHN1Vu2
 +WiZZV7jzcJBz0kcTOmcqmSWYGmWYLsIv5Ra/Ktae5I1vy9Nv33lZtWAC5KYWKoldH71
 7FaI7JOilf+MXQzwS9OeYYw3DO2lBdce/80M/JqHbq7HJ9HFW0yZZc6QD4KM5XYVVptP
 zXqxz7WLXtb20cSm/stMtKmwomQ5LnqlSf6qMeXrak2H0U+6t7t6o1X+qByHqFroYmCS
 x1SQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1776175028; x=1776779828;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RtBZyzbBkln5G4M6t9DIJpY3Su3ba/JxieaX6d73v9M=;
 b=b4ID5/fU4dW8cGwGkaKWHwZblt+vnbBXer+L7IDCEx2H5CtR/Gyp/KPGs79E6kBCFl
 hFQtkrTOSUWvKK2zt/cGErJakGHLY4LY+b74EoNTpbpTNzk6K1MYKEr+v1opbo/w7lPB
 3sTOvwhEYY0cUcVNZyM83zAueVSxvLKi3ZW4L6IIrhSYJETGZ1mm8xKxgxpXpsQkxgYo
 ClGYrvIVc3uznLfxlLY6K/s487d0UMJmBmvsdBFlxRYWCJx+HgTHZvVbrBCkSEDvcq4y
 PvXZcwzbRISuYGTPUZkgxdPRZUin5GAypTVGg7WEkjCk3ss1mI8HXAt84puRh/ht3V64
 4Ibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776175028; x=1776779828;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RtBZyzbBkln5G4M6t9DIJpY3Su3ba/JxieaX6d73v9M=;
 b=AGZl5Y8KKzuORVcH2SjRifbZ0ryREIdc/NllWJpK63mXFt50YkrYqdGHmsv0t22S+Z
 C49Xpl/JpQaPBIjKr52YOztktNx3GndWj7qHOzTnePI4udCyx01kWHMddD4WknlgU3a/
 xZtiGqq2HHuyLxCPJGKRS8zWPRylDxx0MnG14dFo+rat3QLvkQT1ADw2hf7rQGDglHrx
 p62osw0hgl6OAghyReJv8l+ZJPldeV4wNkbtONaJob+exOJKEUh72uG0M8oRAXzinst2
 xGsmKqkknxBwf5tqitjxnBNyExRFr1kYI4tzme56apKj7py2yiNR9eV7KUXKgA5Olxmu
 ghvA==
X-Gm-Message-State: AOJu0Ywn4E8T04zNHTJbz2YoQN0mPyMNFr4uj2OpC8Y78qqF1c8LDWJc
 zN6vtLfjGcJoQlAUEpz0PJ1HD90oS3vmpRHko3k1/5zdUmE+cT7yMVuoIuMK0467w9N65Ko3zn3
 g6sWPbQ92ORacMySUIysj2DS7FQtHAKWwckSTrSBgWA==
X-Gm-Gg: AeBDieutcWb8U2DaBeD9j5u42znTyyXSn0j3MjWThcA9je+w4qCKlec0Kst9uoC+Sm4
 CdPxf3tRB8OJF+1goudWu5KPESjZKzimjksJjEoC58RX80ntDeWKXuoqiOi9h5skLLAXllKvthG
 KP5JCjFJCaj4gJRbaackBGysmHMBpGzoZKtpRv5jq2JdAza/UxUCoqJB4RXEDy148LUBD/ICfFu
 ZtRLgUK+b2I9hWBWWPvqA/1X8GGjvDld2JZZQJh5JS2q4DleE3F3YL9tO2mE4jBy9yptzkMpYLT
 +/+Da92pLVsggvphzpotharWgTeDaoH5u8/iNA==
X-Received: by 2002:a17:90a:c883:b0:35e:5ae3:298a with SMTP id
 98e67ed59e1d1-35e5ae32a85mr10066239a91.18.1776175027797; Tue, 14 Apr 2026
 06:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260413-syscall-nr-v1-0-f70408d042ea@bsdimp.com>
 <20260413-syscall-nr-v1-3-f70408d042ea@bsdimp.com>
 <ad33MUkefoZY1X44@redhat.com>
In-Reply-To: <ad33MUkefoZY1X44@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 14 Apr 2026 07:56:55 -0600
X-Gm-Features: AQROBzABPqdnCgGqPknplscbAj8RwI0GWImXJyLoNT5zucX6nm5d2JCtukVwMl4
Message-ID: <CANCZdfpyr9pzJoKCN6AKtnH+cZRRme3HYvWbCX5L1CCpSFv6Bg@mail.gmail.com>
Subject: Re: [PATCH 3/5] bsd-user: Conditionally use old system calls
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000976998064f6bf95f"
Received-SPF: none client-ip=2607:f8b0:4864:20::1031;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000976998064f6bf95f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 2:13=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Mon, Apr 13, 2026 at 09:31:45AM -0600, Warner Losh wrote:
> > sbrk and sstk have been deprecated in FreeBSD for a while now, only
> > support them if the version of FreeBSD we're compiling on does. They've
> > returned not supported for a while anyway, so no net change.
>
> What versions of FreeBSD still have these syscalls ?
>

None. They were marked OBSOL in 4.4BSD. I don't even know why
there was code to implement them in the first place.

In fact, digging deeper, 4.3-Reno returns not supported. 4.3-Tahoe had
them stubbed out as blank (no error, but did nothing), like 4.3BSD and
4.2BSD did before it. It wasn't in 4.1BSD.


> Per out policy we only aim to support the 2 most recent major
> versions of distros:
>
>   https://www.qemu.org/docs/master/about/build-platforms.html
>
> So for FreeBSD that means 14.x and 15.x series are all that you
> need to retain code support for. Any code for older versions
> can be entirely dropped at any convenient time.
>

True. I'll do that since it is clearly an echo of the past of what might
have been, that never, ever was. I just #ifdef'd them because I wasn't
sure, but now I am...

Warner


> >
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> >  bsd-user/bsd-mem.h            | 2 ++
> >  bsd-user/freebsd/os-syscall.c | 4 ++++
> >  bsd-user/freebsd/strace.list  | 4 ++++
> >  3 files changed, 10 insertions(+)
> >
> > diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
> > index a118e57260..a20b703053 100644
> > --- a/bsd-user/bsd-mem.h
> > +++ b/bsd-user/bsd-mem.h
> > @@ -440,6 +440,7 @@ static inline abi_long do_bsd_vadvise(void)
> >      return -TARGET_EINVAL;
> >  }
> >
> > +#ifdef TARGET_FREEBSD_NR_sbrk
> >  static inline abi_long do_bsd_sbrk(void)
> >  {
> >      /* see sys_sbrk() in vm_mmap.c */
> > @@ -451,5 +452,6 @@ static inline abi_long do_bsd_sstk(void)
> >      /* see sys_sstk() in vm_mmap.c */
> >      return -TARGET_EOPNOTSUPP;
> >  }
> > +#endif
> >
> >  #endif /* BSD_USER_BSD_MEM_H */
> > diff --git a/bsd-user/freebsd/os-syscall.c
> b/bsd-user/freebsd/os-syscall.c
> > index 85e5db19a3..ff6cbfc481 100644
> > --- a/bsd-user/freebsd/os-syscall.c
> > +++ b/bsd-user/freebsd/os-syscall.c
> > @@ -918,13 +918,17 @@ static abi_long freebsd_syscall(void *cpu_env, in=
t
> num, abi_long arg1,
> >          ret =3D do_bsd_vadvise();
> >          break;
> >
> > +#ifdef TARGET_FREEBSD_NR_sbrk
> >      case TARGET_FREEBSD_NR_sbrk:
> >          ret =3D do_bsd_sbrk();
> >          break;
> > +#endif
> >
> > +#ifdef TARGET_FREEBSD_NR_sstk
> >      case TARGET_FREEBSD_NR_sstk:
> >          ret =3D do_bsd_sstk();
> >          break;
> > +#endif
> >
> >          /*
> >           * Misc
> > diff --git a/bsd-user/freebsd/strace.list b/bsd-user/freebsd/strace.lis=
t
> > index 275d2dbe27..d7f61f480e 100644
> > --- a/bsd-user/freebsd/strace.list
> > +++ b/bsd-user/freebsd/strace.list
> > @@ -194,7 +194,9 @@
> >  { TARGET_FREEBSD_NR_rfork, "rfork", NULL, NULL, NULL },
> >  { TARGET_FREEBSD_NR_rmdir, "rmdir", NULL, NULL, NULL },
> >  { TARGET_FREEBSD_NR_rtprio_thread, "rtprio_thread", "%s(%d, %d, %p)",
> NULL, NULL },
> > +#ifdef TARGET_FREEBSD_NR_sbrk
> >  { TARGET_FREEBSD_NR_sbrk, "sbrk", NULL, NULL, NULL },
> > +#endif
> >  { TARGET_FREEBSD_NR_sched_get_priority_max, "sched_get_priority_max",
> NULL, NULL, NULL },
> >  { TARGET_FREEBSD_NR_sched_get_priority_min, "sched_get_priority_min",
> NULL, NULL, NULL },
> >  { TARGET_FREEBSD_NR_sched_yield, "sched_yield", NULL, NULL, NULL },
> > @@ -234,7 +236,9 @@
> >  { TARGET_FREEBSD_NR_sigsuspend, "sigsuspend", NULL, NULL, NULL },
> >  { TARGET_FREEBSD_NR_socket, "socket", "%s(%d,%d,%d)", NULL, NULL },
> >  { TARGET_FREEBSD_NR_socketpair, "socketpair", NULL, NULL, NULL },
> > +#ifdef TARGET_FREEBSD_NR_sstk
> >  { TARGET_FREEBSD_NR_sstk, "sstk", NULL, NULL, NULL },
> > +#endif
> >  { TARGET_FREEBSD_NR_freebsd11_stat, "freebsd11_stat", "%s(\"%s\",%p)",
> NULL, NULL },
> >  { TARGET_FREEBSD_NR_freebsd11_statfs, "freebsd11_statfs",
> "%s(\"%s\",%p)", NULL, NULL },
> >  { TARGET_FREEBSD_NR_symlink, "symlink", "%s(\"%s\",\"%s\")", NULL, NUL=
L
> },
> >
> > --
> > 2.52.0
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

--000000000000976998064f6bf95f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 14,=
 2026 at 2:13=E2=80=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berr=
ange@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Mon, Apr 13, 2026 at 09:31:45AM -060=
0, Warner Losh wrote:<br>
&gt; sbrk and sstk have been deprecated in FreeBSD for a while now, only<br=
>
&gt; support them if the version of FreeBSD we&#39;re compiling on does. Th=
ey&#39;ve<br>
&gt; returned not supported for a while anyway, so no net change.<br>
<br>
What versions of FreeBSD still have these syscalls ?<br></blockquote><div><=
br></div><div>None. They were marked OBSOL in 4.4BSD. I don&#39;t even know=
 why</div><div>there was code to implement them in the first place.</div><d=
iv><br></div><div>In fact, digging deeper, 4.3-Reno returns not supported. =
4.3-Tahoe had</div><div>them stubbed out as blank (no error, but did nothin=
g), like 4.3BSD and</div><div>4.2BSD did before it. It wasn&#39;t in 4.1BSD=
.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Per out policy we only aim to support the 2 most recent major<br>
versions of distros:<br>
<br>
=C2=A0 <a href=3D"https://www.qemu.org/docs/master/about/build-platforms.ht=
ml" rel=3D"noreferrer" target=3D"_blank">https://www.qemu.org/docs/master/a=
bout/build-platforms.html</a><br>
<br>
So for FreeBSD that means 14.x and 15.x series are all that you<br>
need to retain code support for. Any code for older versions<br>
can be entirely dropped at any convenient time.<br></blockquote><div><br></=
div><div>True. I&#39;ll do that since it is clearly an echo of the past of =
what might</div><div>have been, that never, ever was. I just #ifdef&#39;d t=
hem because I wasn&#39;t</div><div>sure, but now I am...</div><div><br></di=
v><div>Warner</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
&gt; <br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 bsd-user/bsd-mem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 =
++<br>
&gt;=C2=A0 bsd-user/freebsd/os-syscall.c | 4 ++++<br>
&gt;=C2=A0 bsd-user/freebsd/strace.list=C2=A0 | 4 ++++<br>
&gt;=C2=A0 3 files changed, 10 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h<br>
&gt; index a118e57260..a20b703053 100644<br>
&gt; --- a/bsd-user/bsd-mem.h<br>
&gt; +++ b/bsd-user/bsd-mem.h<br>
&gt; @@ -440,6 +440,7 @@ static inline abi_long do_bsd_vadvise(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return -TARGET_EINVAL;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +#ifdef TARGET_FREEBSD_NR_sbrk<br>
&gt;=C2=A0 static inline abi_long do_bsd_sbrk(void)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* see sys_sbrk() in vm_mmap.c */<br>
&gt; @@ -451,5 +452,6 @@ static inline abi_long do_bsd_sstk(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* see sys_sstk() in vm_mmap.c */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return -TARGET_EOPNOTSUPP;<br>
&gt;=C2=A0 }<br>
&gt; +#endif<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #endif /* BSD_USER_BSD_MEM_H */<br>
&gt; diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-sysca=
ll.c<br>
&gt; index 85e5db19a3..ff6cbfc481 100644<br>
&gt; --- a/bsd-user/freebsd/os-syscall.c<br>
&gt; +++ b/bsd-user/freebsd/os-syscall.c<br>
&gt; @@ -918,13 +918,17 @@ static abi_long freebsd_syscall(void *cpu_env, i=
nt num, abi_long arg1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_bsd_vadvise();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 <br>
&gt; +#ifdef TARGET_FREEBSD_NR_sbrk<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case TARGET_FREEBSD_NR_sbrk:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_bsd_sbrk();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +#endif<br>
&gt;=C2=A0 <br>
&gt; +#ifdef TARGET_FREEBSD_NR_sstk<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case TARGET_FREEBSD_NR_sstk:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_bsd_sstk();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +#endif<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Misc<br>
&gt; diff --git a/bsd-user/freebsd/strace.list b/bsd-user/freebsd/strace.li=
st<br>
&gt; index 275d2dbe27..d7f61f480e 100644<br>
&gt; --- a/bsd-user/freebsd/strace.list<br>
&gt; +++ b/bsd-user/freebsd/strace.list<br>
&gt; @@ -194,7 +194,9 @@<br>
&gt;=C2=A0 { TARGET_FREEBSD_NR_rfork, &quot;rfork&quot;, NULL, NULL, NULL }=
,<br>
&gt;=C2=A0 { TARGET_FREEBSD_NR_rmdir, &quot;rmdir&quot;, NULL, NULL, NULL }=
,<br>
&gt;=C2=A0 { TARGET_FREEBSD_NR_rtprio_thread, &quot;rtprio_thread&quot;, &q=
uot;%s(%d, %d, %p)&quot;, NULL, NULL },<br>
&gt; +#ifdef TARGET_FREEBSD_NR_sbrk<br>
&gt;=C2=A0 { TARGET_FREEBSD_NR_sbrk, &quot;sbrk&quot;, NULL, NULL, NULL },<=
br>
&gt; +#endif<br>
&gt;=C2=A0 { TARGET_FREEBSD_NR_sched_get_priority_max, &quot;sched_get_prio=
rity_max&quot;, NULL, NULL, NULL },<br>
&gt;=C2=A0 { TARGET_FREEBSD_NR_sched_get_priority_min, &quot;sched_get_prio=
rity_min&quot;, NULL, NULL, NULL },<br>
&gt;=C2=A0 { TARGET_FREEBSD_NR_sched_yield, &quot;sched_yield&quot;, NULL, =
NULL, NULL },<br>
&gt; @@ -234,7 +236,9 @@<br>
&gt;=C2=A0 { TARGET_FREEBSD_NR_sigsuspend, &quot;sigsuspend&quot;, NULL, NU=
LL, NULL },<br>
&gt;=C2=A0 { TARGET_FREEBSD_NR_socket, &quot;socket&quot;, &quot;%s(%d,%d,%=
d)&quot;, NULL, NULL },<br>
&gt;=C2=A0 { TARGET_FREEBSD_NR_socketpair, &quot;socketpair&quot;, NULL, NU=
LL, NULL },<br>
&gt; +#ifdef TARGET_FREEBSD_NR_sstk<br>
&gt;=C2=A0 { TARGET_FREEBSD_NR_sstk, &quot;sstk&quot;, NULL, NULL, NULL },<=
br>
&gt; +#endif<br>
&gt;=C2=A0 { TARGET_FREEBSD_NR_freebsd11_stat, &quot;freebsd11_stat&quot;, =
&quot;%s(\&quot;%s\&quot;,%p)&quot;, NULL, NULL },<br>
&gt;=C2=A0 { TARGET_FREEBSD_NR_freebsd11_statfs, &quot;freebsd11_statfs&quo=
t;, &quot;%s(\&quot;%s\&quot;,%p)&quot;, NULL, NULL },<br>
&gt;=C2=A0 { TARGET_FREEBSD_NR_symlink, &quot;symlink&quot;, &quot;%s(\&quo=
t;%s\&quot;,\&quot;%s\&quot;)&quot;, NULL, NULL },<br>
&gt; <br>
&gt; -- <br>
&gt; 2.52.0<br>
&gt; <br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0~~=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 <a href=3D"https://hachyderm.io/@berrange" rel=3D"noreferrer" target=3D=
"_blank">https://hachyderm.io/@berrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 <a href=3D"https://entangle-photo.org" rel=3D"noreferrer"=
 target=3D"_blank">https://entangle-photo.org</a> :|<br>
|: <a href=3D"https://pixelfed.art/berrange" rel=3D"noreferrer" target=3D"_=
blank">https://pixelfed.art/berrange</a>=C2=A0 =C2=A0~~=C2=A0 =C2=A0 <a hre=
f=3D"https://fstop138.berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://fstop138.berrange.com</a> :|<br>
<br>
</blockquote></div></div>

--000000000000976998064f6bf95f--

