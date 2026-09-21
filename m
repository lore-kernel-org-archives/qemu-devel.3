Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6CEC982DA
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 01:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8SUc-0007BC-QO; Sun, 20 Sep 2026 21:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1x8SUb-0007Av-Fh
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 21:06:49 -0400
Received: from mail-pj2-x27.google.com ([2607:f8b0:4864:39::27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1x8SUZ-0002Vf-5f
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 21:06:49 -0400
Received: by mail-pj2-x27.google.com with SMTP id
 d9443c01a7336-2dd77300825so24953075ad.1
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2026 18:06:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789952805; cv=none;
 d=google.com; s=arc-20260327;
 b=SapQywReJ2FT11Uf5+8GoWPOKPQgfkFLqD3yJIPtGpI3jJ0wX3stXMTsaIJnO+ZkYt
 UqgeDqYvwCkUfuG5PT/Dw3WHeDwTZGgxHwkxFeY6iHd+Q203juTo3s5CBnDBjJzFXTEq
 +34IU8Kc6wsPn4M+DjBZRUsEYoegNvs8/v4a4fEhRx0vpYj8ERw25b2SPoyq6szseCv5
 1Vl4goyEQi1irNRJ8YsNei5jkJ6coDJnHs3j0i6P5jmVZcUhkz/tr5lcYAYOrlT+zAqh
 3bPCWd4/hSCQH8MS67MJMSQ2LQR43CE4EssA6qwvjns4QX4nifVSp49+egg9dN0KTJh9
 uF/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cEoYHzdgNFuBMRr7KUQaB/DWlpJmbPtPkJj5XT0wSRg=;
 fh=E1ru50n755oas5DAMbqnaFB/4fE99klEr75rzIED//M=;
 b=o59TfQW8L0/gO6dJwsJ7Be+e/OjUKfwh70xTgrrJFAYM3FxuPRKMIbj25nNpeNFIse
 ANReuMf8gWTNGKTvY0ovJ6VmcR5E9BbEAA+MFAJdqRWAwfDGVUe5stGzwZp2jpN4whMf
 RiJmO1wmaie1cjGxW7gCTticGhUrIQmrLM2/rTCrTNMiQAaHbMyLWqnhoOn1n1hlnecd
 xhGs8nea4BYXkB6eFJZ2LoYWhEkG/m/BxdyEf1wn04+6c0VBCqX4uPPa58z6WJDKrgOC
 L5OgeeWkzzXVDVuT/3kXK+Ia1ilXWPuwtuBMMy8Z7Hs7OBXYi3y4n9Mll8A6iXlt5FYn
 Ln2A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789952805; x=1790557605;
 darn=nongnu.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cEoYHzdgNFuBMRr7KUQaB/DWlpJmbPtPkJj5XT0wSRg=;
 b=WeCLic+LuE6CWrP8g2C0NwA2bZDxX/ckA1oahIIrHyqyDEFxLrz2S+3ziR59IOejgf
 giGcuT3Ju0i9W6h6lpjH04KM6l/DDk4GQcRmrQnS9T+vJzcJPzm9e/paZcAcFv3UP8FW
 L09p8GZTQdss3OwpjdpkL0J3TiJdDGkTwql+1zlPnYmHyeGycV385fWEt3j+wu2HRrih
 J53gMuLmo3EgmPfkebBe6RN4yclv45IYPKFfbowf7X6id+dMNlpTDiPBgN7RGIduXoaY
 whtEqqxazpElGwd8rYoIGofxg2vWA1nHTaPAPFu8RST+JNMrgqCIv8NRTgQ8lr4e+p6M
 EKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789952805; x=1790557605;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cEoYHzdgNFuBMRr7KUQaB/DWlpJmbPtPkJj5XT0wSRg=;
 b=Ewa2Go1I8EnYEsZU8/6a5F36Goq3oXblzIwI7heVGE6XlgpKfe67VtSB4i0AO8b2Yu
 9apUoFBqvfkYxYyn3sSpUnMeRZYvbWhbDFfo+n3CG1Njpf6ThNWNkZERiwEC79atd1ht
 /h2ZrXXjLX7DCZEcgC1H2lKvsFBBMs5Egmy8us3i/o7imQTMuqitLqLfwPeqkyd+NnYU
 ivwekxQ0X+JOxRByrpNIHN8x2LZyjuJKkGtpeaY18WPtuScHeXgvDWxJ4i6eZZkbLIDK
 gIYL6JL1vP6AVjEgZOQ1jHTzFTMB14JZjsV37coO7qeJiCAw2iaR8QiuWqu3+Ilmh33v
 1Arg==
X-Gm-Message-State: AFuF++kpYbEgoExwlxIxTf4uS3Fur2Y36tQDxopa8jKJhHT96g+NkCg4
 zN69DvzHkbw+48iH/1bg64hU6DmiGBh9xbzh+qxJGJWqWj+4lS+f0bMed5Ziaa85dm9o7fdECON
 KckCc1dn3FkwujRdrxsDE3X2H94T5NGeaHGXtLL9Sdw==
X-Gm-Gg: AYBFou0o5sj9deR2PweEnq4AL/LZVHL5lq4o78QRJR2Es1IN+23bTLEnioO4T6DrXS7
 /gXm8kEtziJKax7hLYBABXZuOhWkvKneZbM4yx5HXDmw3P9xCX3pWD9zKeogufexGw+9kxwWnBc
 /oBgsONyYHLrwvkYd5d7qrekRPsDFwV3pIrnGfhMdB5g3ziO7OAd1IlkFcj9ZJ75PLapDVQj4TA
 UMSAwUXUUZoRalJpEpzPS2/MU3/+9zovIebqB2omyqJBNStNSKshVKoMpBWVzVniR3uMgyz5uk/
 Q63g9iBTZNZupeBCvSYqODIGqtLFjXzWI+N/Pw9jYPzYhKBVAOI5a0Smswgg24DxIYjOub8bJoF
 pQHXdicF2Kg==
X-Received: by 2002:a17:903:b47:b0:2dd:ad73:c938 with SMTP id
 d9443c01a7336-2ddb1bae01fmr139690905ad.25.1789952804798; Sun, 20 Sep 2026
 18:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
 <20260919-misc-2025q4-v1-13-ebfa61049bd7@bsdimp.com>
 <8b9b62d0-2cc7-4438-ad60-4cfbb4088bc8@linaro.org>
In-Reply-To: <8b9b62d0-2cc7-4438-ad60-4cfbb4088bc8@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 20 Sep 2026 19:06:33 -0600
X-Gm-Features: AcwNN1Wkkhd-ks-AWbiyK_rym1jt6iZXuY9RVzLz4by6BN8BbVe3qSTLbXOqM40
Message-ID: <CANCZdfpQf-qUdnbeEjVGY6N_rbau+CHCUo881prL=ZyHtZc+Ug@mail.gmail.com>
Subject: Re: [PATCH 13/14] bsd-user: Fix non-PIE binaries
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Maksym Sobolyev <sobomax@sippysoft.com>
Content-Type: multipart/alternative; boundary="000000000000185346065bf3dd5e"
Received-SPF: none client-ip=2607:f8b0:4864:39::27;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj2-x27.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000185346065bf3dd5e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 4:33=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 9/19/26 19:20, Warner Losh wrote:
> > diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
> > index 295dad4643..eaa8676f5a 100644
> > --- a/bsd-user/elfload.c
> > +++ b/bsd-user/elfload.c
> > @@ -561,12 +561,14 @@ load_elf_sections(const struct elfhdr *hdr, struc=
t
> elf_phdr *phdr, int fd,
> >               elf_prot |=3D PROT_EXEC;
> >           }
> >
> > +        int flags =3D MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE;
> > +        if (rbase =3D=3D 0) {
> > +            flags |=3D MAP_EXCL;
> > +        }
> >           error =3D target_mmap(TARGET_ELF_PAGESTART(rbase +
> elf_ppnt->p_vaddr),
> >                               (elf_ppnt->p_filesz +
> >                                TARGET_ELF_PAGEOFFSET(elf_ppnt->p_vaddr)=
),
> > -                            elf_prot,
> > -                            (MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE),
> > -                            fd,
> > +                            elf_prot, flags, fd,
> This is wrong, or at least very not ideal.
>
> What's missing no the freebsd side is a probe for the entire address
> space for the guest program.
>

I believe I have those missing pieces in the next round. I'll pull them
forward into this round when I rework.

Warner


> >     /*
> >      * Reserve address space for all of this.
> >      *
> >      * In the case of ET_EXEC, we supply MAP_FIXED_NOREPLACE so that we
> get
> >      * exactly the address range that is required.  Without reserved_va=
,
> >      * the guest address space is not isolated.  We have attempted to
> avoid
> >      * conflict with the host program itself via probe_guest_base, but
> using
> >      * MAP_FIXED_NOREPLACE instead of MAP_FIXED provides an extra check=
.
> >      *
> >      * Otherwise this is ET_DYN, and we are searching for a location
> >      * that can hold the memory space required.  If the image is
> >      * pre-linked, LOAD_ADDR will be non-zero, and the kernel should
> >      * honor that address if it happens to be free.
> >      *
> >      * In both cases, we will overwrite pages in this range with mappin=
gs
> >      * from the executable.
> >      */
> >     reserve_size =3D range.hi - range.lo + 1;
> >     align_size =3D reserve_size;
> >
> >     if (ehdr->e_type !=3D ET_EXEC && align > qemu_real_host_page_size()=
) {
> >         align_size +=3D align - 1;
> >     }
> >
> >     load_addr =3D target_mmap(load_addr, align_size, PROT_NONE,
> >                             MAP_PRIVATE | MAP_ANON | MAP_NORESERVE |
> >                             (ehdr->e_type =3D=3D ET_EXEC ?
> MAP_FIXED_NOREPLACE : 0),
> >                             -1, 0);
>
> which handles ET_DYN properly, which is missing from the freebsd side
> entirely.  Afterward, elf sections are mapped onto this reserved range.
>
> I'll note that FreeBSD should be able to do better than Linux wrt the
> alignment handling here, since you have MAP_ALIGNED().  So long as
> guest_base is suitably aligned, anyway.
>
>
> r~
>
> r~
>

--000000000000185346065bf3dd5e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 20,=
 2026 at 4:33=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.he=
nderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">On 9/19/26 19:20, Warner Lo=
sh wrote:<br>
&gt; diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c<br>
&gt; index 295dad4643..eaa8676f5a 100644<br>
&gt; --- a/bsd-user/elfload.c<br>
&gt; +++ b/bsd-user/elfload.c<br>
&gt; @@ -561,12 +561,14 @@ load_elf_sections(const struct elfhdr *hdr, stru=
ct elf_phdr *phdr, int fd,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elf_prot |=3D PR=
OT_EXEC;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int flags =3D MAP_FIXED | MAP_PRIVATE | M=
AP_DENYWRITE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rbase =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flags |=3D MAP_EXCL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D target_mmap(TARGET_E=
LF_PAGESTART(rbase + elf_ppnt-&gt;p_vaddr),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(elf_ppnt-&gt;p_filesz +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TARGET_ELF_PAGEOFFSET(elf_ppnt-&g=
t;p_vaddr)),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elf_prot,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fd,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elf_prot, flags, fd,<br>
This is wrong, or at least very not ideal.<br>
<br>
What&#39;s missing no the freebsd side is a probe for the entire address <b=
r>
space for the guest program.<br></blockquote><div><br></div><div>I believe =
I have those missing pieces in the next round. I&#39;ll pull them</div><div=
>forward into this round when I rework.</div><div><br></div><div>Warner</di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * Reserve address space for all of this.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * In the case of ET_EXEC, we supply MAP_FIXED_NORE=
PLACE so that we get<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * exactly the address range that is required.=C2=
=A0 Without reserved_va,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * the guest address space is not isolated.=C2=A0 W=
e have attempted to avoid<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * conflict with the host program itself via probe_=
guest_base, but using<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * MAP_FIXED_NOREPLACE instead of MAP_FIXED provide=
s an extra check.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * Otherwise this is ET_DYN, and we are searching f=
or a location<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * that can hold the memory space required.=C2=A0 I=
f the image is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * pre-linked, LOAD_ADDR will be non-zero, and the =
kernel should<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * honor that address if it happens to be free.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * In both cases, we will overwrite pages in this r=
ange with mappings<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * from the executable.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0reserve_size =3D range.hi - range.lo + 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0align_size =3D reserve_size;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0if (ehdr-&gt;e_type !=3D ET_EXEC &amp;&amp; align &=
gt; qemu_real_host_page_size()) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0align_size +=3D align - 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0load_addr =3D target_mmap(load_addr, align_size, PR=
OT_NONE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MAP_PRIVATE | MAP_ANON | MAP_NORESERVE |<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(ehdr-&gt;e_type =3D=3D ET_EXEC ? MAP_FIX=
ED_NOREPLACE : 0),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-1, 0);<br>
<br>
which handles ET_DYN properly, which is missing from the freebsd side <br>
entirely.=C2=A0 Afterward, elf sections are mapped onto this reserved range=
.<br>
<br>
I&#39;ll note that FreeBSD should be able to do better than Linux wrt the <=
br>
alignment handling here, since you have MAP_ALIGNED().=C2=A0 So long as <br=
>
guest_base is suitably aligned, anyway.<br>
<br>
<br>
r~<br>
<br>
r~<br>
</blockquote></div></div>

--000000000000185346065bf3dd5e--

