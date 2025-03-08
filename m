Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E054C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 17:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqy1Z-0003F2-Sm; Sat, 08 Mar 2025 12:31:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1tqy1D-0002zA-DB
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 12:31:34 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1tqy19-0005Gb-Sb
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 12:31:23 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2feae794508so4489580a91.0
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 09:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1741455076; x=1742059876;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JnZnY+5w8KT5OaxlknQ+1yWSBIq7elRr4pilDDb6f9I=;
 b=lwjJDutmJtmWqQfqH3OIjC5RhdjgMhpg0TbMj+jNIQvb1tzd52KSnX/HqeA+sxNFvx
 873CMlgjGj9jPH6h01kVyfOI4QZJGqoNIpWEPKfuIvCbUuhNDnIKITel7YZFcrjxkuan
 y+N7gFSjN7s2aImWh5OHm+cRF5TqBH1FHv4ipkIX+weVDsNwThZJRWlZ6dp1VOEZDDIA
 8no0Kp+c6e0jJIXQpAvrAakvkaJP1By8gWbZDXKNSrlxjxtWBl9RHa3yiRcDwtPg7/M1
 YF+5YHoo36UfRxJ7tMV2th1m2tpLSgNbDo4lw+cFvpbnLauDeV/3a2XMhBNVqzoMJlGk
 Bg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741455076; x=1742059876;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JnZnY+5w8KT5OaxlknQ+1yWSBIq7elRr4pilDDb6f9I=;
 b=B10nXdObY6ZDv3x/eilV3qDkV7IzS8MKzOlEvZBYqZXgtj7i0f5xGYNVCnNQnogVEw
 QULqYsx3tCAR/UYC3Rbu2VQ+JIG8rePBSXDITwKDxPqn2Qp4hYTvGhOmF+S4NNeOn9i7
 qM0BXGeNdy6NnOXiAPoEys+mKKyruAjMavvlVE70nBpNmLFPBYK2O2RRhWBP6vQ5rN8H
 QcERaj1wqJjOn3Pk+KsQgTJydPMR3kBsr7gmheLJjB3obo7x6voC/u9wVEo7i8OvvXSY
 ZvuisSYeVQqSq1K/IM08Z4CxyYVFdxl6iXaj5/u+Wxz4jhoHpJ+9pv7IwKEYsA8FQ2i8
 +t6w==
X-Gm-Message-State: AOJu0YygzSgeco5Bn7+ncKNv5DpRbtkEfmgMQ85zrhfiScbJBEA52MDT
 ivRHd/WI8V0mYao5K9TY2syMXQgGEO7Tqn/vLv5eF6Vm3t/LIXwT65plOlMdlTURlwBCp9Ss2Qd
 xz/n4Yto8zhjtCv9gm+wapwa4Pqtmn3FXSR9zHA==
X-Gm-Gg: ASbGncvXP3KWuGNAuoFNsHOQ/tV2hL0woUGXc80Ob8TVpVrIaWqv11YH8sqfq0qmggM
 PPOwrC2B9y/4k4VQqgo10ElowwReNjl0pTcrDi7sgBSDMi0cGXePljI+eTiZAD7v8YgaZh/aWlw
 cy+y8EVu7zZ7u5ABa1RujlYr9rl2lFL/Fe/2jv
X-Google-Smtp-Source: AGHT+IHrESadKIvU7p2QoBtkuNxZUZNOw4KZi6sD5CbsIiyP/RRwp4SdyqyRzYF9JWoSGq3nAvy0rNM+MwqwEa7EkV8=
X-Received: by 2002:a17:90b:1d0a:b0:2ea:aa56:499 with SMTP id
 98e67ed59e1d1-2ff7ce4f019mr11669463a91.1.1741455074934; Sat, 08 Mar 2025
 09:31:14 -0800 (PST)
MIME-Version: 1.0
References: <20250308122842.76377-1-philmd@linaro.org>
 <20250308122842.76377-3-philmd@linaro.org>
In-Reply-To: <20250308122842.76377-3-philmd@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 8 Mar 2025 10:31:04 -0700
X-Gm-Features: AQ5f1JoNk52n0xkKJA0OuKT5_cb3oKxOnoonr0iTp12dX6huEVMevRdiTJuYdPc
Message-ID: <CANCZdfpwH=Y1JmK1Z2NCbo5YZOnzi9dQDPWntOO-wVu0i-C6mQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] bsd-user: Propagate alignment argument to
 mmap_find_vma()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, 
 Laurent Vivier <laurent@vivier.eu>, Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="0000000000002261ff062fd81b22"
Received-SPF: none client-ip=2607:f8b0:4864:20::1032;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1032.google.com
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

--0000000000002261ff062fd81b22
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 8, 2025 at 5:28=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> Propagate the alignment to mmap_find_vma(), effectively
> embedding mmap_find_vma_aligned() within mmap_find_vma().
>
> Add a comment in do_bsd_shmat() to clarify alignment above
> page size is not required.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  bsd-user/bsd-mem.h |  4 +++-
>  bsd-user/qemu.h    |  2 +-
>  bsd-user/mmap.c    | 10 ++--------
>  3 files changed, 6 insertions(+), 10 deletions(-)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>


> diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
> index f5ec0de24ca..90ca0e33775 100644
> --- a/bsd-user/bsd-mem.h
> +++ b/bsd-user/bsd-mem.h
> @@ -370,9 +370,11 @@ static inline abi_long do_bsd_shmat(int shmid,
> abi_ulong shmaddr, int shmflg)
>          if (shmaddr) {
>              host_raddr =3D shmat(shmid, (void *)g2h_untagged(shmaddr),
> shmflg);
>          } else {
> +            abi_ulong alignment;
>              abi_ulong mmap_start;
>
> -            mmap_start =3D mmap_find_vma(0, shm_info.shm_segsz);
> +            alignment =3D 0; /* alignment above page size not required *=
/
> +            mmap_start =3D mmap_find_vma(0, shm_info.shm_segsz, alignmen=
t);
>

Why create a write-only variable that you just pass to this function? Is
this
a pattern used elsewhere and if so when?

It's fine, imho, like this, but it is a little odd so I wonder why you did
it like this.
There may be something I can learn.

Warner


>              if (mmap_start =3D=3D -1) {
>                  return -TARGET_ENOMEM;
> diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
> index 4e97c796318..0b3bd65b180 100644
> --- a/bsd-user/qemu.h
> +++ b/bsd-user/qemu.h
> @@ -242,7 +242,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong
> old_size,
>                         abi_ulong new_addr);
>  int target_msync(abi_ulong start, abi_ulong len, int flags);
>  extern abi_ulong mmap_next_start;
> -abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size);
> +abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong
> alignment);
>  void mmap_reserve(abi_ulong start, abi_ulong size);
>  void TSA_NO_TSA mmap_fork_start(void);
>  void TSA_NO_TSA mmap_fork_end(int child);
> diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
> index dfa6e728ab5..3f0df79c375 100644
> --- a/bsd-user/mmap.c
> +++ b/bsd-user/mmap.c
> @@ -275,8 +275,7 @@ static abi_ulong mmap_find_vma_reserved(abi_ulong
> start, abi_ulong size,
>   * It must be called with mmap_lock() held.
>   * Return -1 if error.
>   */
> -static abi_ulong mmap_find_vma_aligned(abi_ulong start, abi_ulong size,
> -                                       abi_ulong alignment)
> +abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong
> alignment)
>  {
>      void *ptr, *prev;
>      abi_ulong addr;
> @@ -395,11 +394,6 @@ static abi_ulong mmap_find_vma_aligned(abi_ulong
> start, abi_ulong size,
>      }
>  }
>
> -abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size)
> -{
> -    return mmap_find_vma_aligned(start, size, 0);
> -}
> -
>  /* NOTE: all the constants are the HOST ones */
>  abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
>                       int flags, int fd, off_t offset)
> @@ -494,7 +488,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len,
> int prot,
>          host_len =3D len + offset - host_offset;
>          host_len =3D HOST_PAGE_ALIGN(host_len);
>          alignment =3D (flags & MAP_ALIGNMENT_MASK) >> MAP_ALIGNMENT_SHIF=
T;
> -        start =3D mmap_find_vma_aligned(real_start, host_len, alignment)=
;
> +        start =3D mmap_find_vma(real_start, host_len, alignment);
>          if (start =3D=3D (abi_ulong)-1) {
>              errno =3D ENOMEM;
>              goto fail;
> --
> 2.47.1
>
>

--0000000000002261ff062fd81b22
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Mar 8, =
2025 at 5:28=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:p=
hilmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Propagate the alignment to mmap_find_vma=
(), effectively<br>
embedding mmap_find_vma_aligned() within mmap_find_vma().<br>
<br>
Add a comment in do_bsd_shmat() to clarify alignment above<br>
page size is not required.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-mem.h |=C2=A0 4 +++-<br>
=C2=A0bsd-user/qemu.h=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0bsd-user/mmap.c=C2=A0 =C2=A0 | 10 ++--------<br>
=C2=A03 files changed, 6 insertions(+), 10 deletions(-)<br></blockquote><di=
v><br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.=
com">imp@bsdimp.com</a>&gt;</div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h<br>
index f5ec0de24ca..90ca0e33775 100644<br>
--- a/bsd-user/bsd-mem.h<br>
+++ b/bsd-user/bsd-mem.h<br>
@@ -370,9 +370,11 @@ static inline abi_long do_bsd_shmat(int shmid, abi_ulo=
ng shmaddr, int shmflg)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (shmaddr) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host_raddr =3D shmat(shmid,=
 (void *)g2h_untagged(shmaddr), shmflg);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong alignment;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0abi_ulong mmap_start;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_start =3D mmap_find_vma(0, =
shm_info.shm_segsz);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 alignment =3D 0; /* alignment ab=
ove page size not required */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_start =3D mmap_find_vma(0, =
shm_info.shm_segsz, alignment);<br></blockquote><div><br></div><div>Why cre=
ate a write-only variable that you just pass to this function? Is this</div=
><div>a pattern used elsewhere and if so when?</div><div><br></div><div>It&=
#39;s fine, imho, like this, but it is a little odd so I wonder why you did=
 it like this.</div><div>There may be something I can learn.</div><div><br>=
</div><div>Warner</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mmap_start =3D=3D -1) {=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -TARGE=
T_ENOMEM;<br>
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h<br>
index 4e97c796318..0b3bd65b180 100644<br>
--- a/bsd-user/qemu.h<br>
+++ b/bsd-user/qemu.h<br>
@@ -242,7 +242,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong ol=
d_size,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 abi_ulong new_addr);<br>
=C2=A0int target_msync(abi_ulong start, abi_ulong len, int flags);<br>
=C2=A0extern abi_ulong mmap_next_start;<br>
-abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size);<br>
+abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong alignme=
nt);<br>
=C2=A0void mmap_reserve(abi_ulong start, abi_ulong size);<br>
=C2=A0void TSA_NO_TSA mmap_fork_start(void);<br>
=C2=A0void TSA_NO_TSA mmap_fork_end(int child);<br>
diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c<br>
index dfa6e728ab5..3f0df79c375 100644<br>
--- a/bsd-user/mmap.c<br>
+++ b/bsd-user/mmap.c<br>
@@ -275,8 +275,7 @@ static abi_ulong mmap_find_vma_reserved(abi_ulong start=
, abi_ulong size,<br>
=C2=A0 * It must be called with mmap_lock() held.<br>
=C2=A0 * Return -1 if error.<br>
=C2=A0 */<br>
-static abi_ulong mmap_find_vma_aligned(abi_ulong start, abi_ulong size,<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0abi_ulong=
 alignment)<br>
+abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong alignme=
nt)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0void *ptr, *prev;<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong addr;<br>
@@ -395,11 +394,6 @@ static abi_ulong mmap_find_vma_aligned(abi_ulong start=
, abi_ulong size,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size)<br>
-{<br>
-=C2=A0 =C2=A0 return mmap_find_vma_aligned(start, size, 0);<br>
-}<br>
-<br>
=C2=A0/* NOTE: all the constants are the HOST ones */<br>
=C2=A0abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 int flags, int fd, off_t offset)<br>
@@ -494,7 +488,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, in=
t prot,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host_len =3D len + offset - host_offset;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host_len =3D HOST_PAGE_ALIGN(host_len);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0alignment =3D (flags &amp; MAP_ALIGNMENT_=
MASK) &gt;&gt; MAP_ALIGNMENT_SHIFT;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 start =3D mmap_find_vma_aligned(real_start, ho=
st_len, alignment);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 start =3D mmap_find_vma(real_start, host_len, =
alignment);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (start =3D=3D (abi_ulong)-1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errno =3D ENOMEM;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
-- <br>
2.47.1<br>
<br>
</blockquote></div></div>

--0000000000002261ff062fd81b22--

