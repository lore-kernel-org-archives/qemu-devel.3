Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3419ACD5BD0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 13:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTJvs-0003Wn-DI; Sat, 30 May 2026 09:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTJvq-0003WR-1n
 for qemu-devel@nongnu.org; Sat, 30 May 2026 09:40:54 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTJvn-0001ka-4P
 for qemu-devel@nongnu.org; Sat, 30 May 2026 09:40:53 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-367cbac9c37so8767217a91.2
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 06:40:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780148449; cv=none;
 d=google.com; s=arc-20240605;
 b=HuTMSTF4JnSMcHzxWULctUkvOHj5h3kj3eypOZEXKjO7Es8ydbn5wDPfd36tBIKGkS
 GAgtbVx8KBTAfNs/DQ/glctm/ikFWRCe4RWw1hHKH8CNnNgqmOZLkpG2fAQvIeK3PrS0
 wWNwdk8jmbl/y3BS5DWYPrPg2P4Ixn1iqgKbx/8rTtCyVfEX4KqBP7sK4+7HMfES+8sU
 oJ7uWS6Z0Vthg16yilQTPfEhysROx537FE3JIVXKevKM5YUuUl9ruv6VEMXnQGuY4pDS
 h5mTK+Tp/NxPMXcpwTVZkTTqce7i9K97ueoFrMC1/GTQL+ck0k+rQiWy97o2WZOmC+CL
 9gzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=deJawHKMx/iifZecP/L4VSAEmzsmI7R4Zj1KDnwYLaI=;
 fh=yW/FlwrVuroo6hzJ7k80gucgJHTlQ6qOhm5Wg56vJuk=;
 b=CnhPsq7U3tuPeLMWHj0bEd4gsSwZuafQ5h55YDowsNhMDZQIx8TWRb92mpfpKzF1hR
 +t9eAUQHJ19j5UPGxvb3xu8rE49avcp8exInunHUEmty4q5hvFoKFgZ38hBunBHgrFZo
 w2NEqopVUagSCVLczKHskahNTLRI28ZiZJLQuklObCSJYKby7SH9C1fIy5ZTQSyQk2m1
 CCGo9u6SMokum6rJd13i9Q+rV4evXw6HY1JNQQLEkkXcDoJJoEvAQODQ17URhT0owyVd
 +CBC1Y1RSuMU2UeEtmckAQfBmH4zs+x57fgRep/rzjL/WaffqyuS8DEUCAxaRkaDpw0N
 KVdA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1780148449; x=1780753249;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=deJawHKMx/iifZecP/L4VSAEmzsmI7R4Zj1KDnwYLaI=;
 b=mwuXTVsGWRuBciGkVLsFmV7S7Vs2xf5TGbNMzm+d61Y/FzIZRURLN7u9HNAHako/lE
 /F0hi0DZTc4tgFzoYaV+yPflY3eSVAnKm41a1AnbKTkna0WWUUF1NO4Se46X2fHYI8pG
 T0sv3sg+gKoEfs2c8jX6wl9xsDZLzEYGN3OlyQSxd/sSXBN4Imi/r+k54uznub4Sp4wf
 //ZtDBeRd4mWdSEHueeSZDAa6QooHKcY8tu4H+Sk6OGuk+wwaDDtVDbqsrkHc8vYBDr+
 NbF2R+o/L3DmbzOwtz+iqyshW+4knhzI/dOFba74Qe1HO8O7LVZHSuU8q5H8GMQL3BNB
 M8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780148449; x=1780753249;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=deJawHKMx/iifZecP/L4VSAEmzsmI7R4Zj1KDnwYLaI=;
 b=lMeBFGS9ml0gvU/s6K6G6YRnxjeRprddBfJEWKxKBSINjDqVKpQEzQkbo8/12w0eHt
 LvORZeUkSTBouTrPZGTGCSwivt6iU9S0Q7FoomWSA/aM3mnVQP764ULfXRe2gqQsrCJX
 pr2lQAd38G/EjECgIhcffb6NJjaQpKUr8WZdzgJOqDNJr2SRYOpiUFHQYYYjg0QeTfl+
 PplT9XQAWrsGx+rYrzXC9t8SrEk4FoxIKBP+mt8NvC6bTyDhgMUaPKehVFDM8xqPSeuJ
 rfKpETZ6j5a8MlVcf+T/lfZ8Qz9Uwxi3UOZoW5vUvMhs2K3Sl2aCORxMhdeaCiiribXY
 jkrA==
X-Gm-Message-State: AOJu0Yw6eUvqY7rsWo7bfhEESaY7getBS59nzu2tPbmIXL4JpuwdstvN
 xz85Szk2/1NXsreWUYok5JQJxrVnN30z+SSqS50NVM/A+fPS+ekL/G5gu7vq03L0zfhXmiYKOdP
 FnZRIbmDSrMu2mFHOcZDOVDnbxrNs64Wm0bqzA6cbvA==
X-Gm-Gg: Acq92OEhskR+litmRtU8Gkl/KLxgRJwdezVcAeutasPZz4DpKFFXXNJIU0ULrO+9HzJ
 tjSFPm2JGjWdP/3o+eW9Bqwtlizug6hkGNj4bjdPi/nGK7OBWy8Fz7dTUagtLVLwtopjjbsrZ7a
 OoI0RIgsr/JTkyJHVO1qYvM6WwScBAQ3jERNHjMSimDhbz2bpjVYWgsGP51bhdirIm0lU+YsEpQ
 UV4HL7Hk4A4eCSPzKYm1sF8X9uhKm/1WciSMoNE2fsQJGMqbfuHWZlJvS+YwUmMbzrB8xYi4T7r
 +tXNTgOw5LGFz2r/IgFEUf9HXsndTdcCdoGmuukHqdgpEJmN
X-Received: by 2002:a17:90b:3d84:b0:369:7421:75cf with SMTP id
 98e67ed59e1d1-36c501eb0a7mr3656534a91.16.1780148448830; Sat, 30 May 2026
 06:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260530062816.59206-1-guobin@linux.alibaba.com>
In-Reply-To: <20260530062816.59206-1-guobin@linux.alibaba.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 30 May 2026 07:40:37 -0600
X-Gm-Features: AVHnY4KyoFCgEnWiyvrua-IvlNT6DF0tvbYnLn2JCJErai_LborbivIeAvn60pg
Message-ID: <CANCZdfpWDH=5JBjbKO9-3ihb0xtSOjoFvEkQLwsKSDrdLveEaQ@mail.gmail.com>
Subject: Re: [PATCH v2] util/cutils: drop qemu_strnlen() in favor of strnlen()
To: Bin Guo <guobin@linux.alibaba.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kyle Evans <kevans@freebsd.org>, 
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f0b43b0653091b25"
Received-SPF: none client-ip=2607:f8b0:4864:20::1034;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1034.google.com
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

--000000000000f0b43b0653091b25
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026, 12:28=E2=80=AFAM Bin Guo <guobin@linux.alibaba.com> w=
rote:

> There are only three call sites, and strnlen() is available on all
> supported platforms (POSIX.1-2008, Windows via UCRT, MinGW).  Remove
> the hand-rolled wrapper and use the standard function directly.
>
> While here, align bsd-user/uaccess.c to use size_t for max_len/len,
> matching linux-user/uaccess.c and eliminating a signed/unsigned mismatch.
>
> Also remove the stale qemu_strnlen() entry from docs/devel/style.rst.
>
> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>  bsd-user/uaccess.c    |  4 ++--
>  docs/devel/style.rst  |  1 -
>  include/qemu/cutils.h | 17 +----------------
>  linux-user/uaccess.c  |  2 +-
>  util/cutils.c         | 15 +--------------
>  5 files changed, 5 insertions(+), 34 deletions(-)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

Normally not a fan of while I'm here fixes, but this one is correct and too
small to split out.

Warner

diff --git a/bsd-user/uaccess.c b/bsd-user/uaccess.c
> index 89163257f4..7ad4b580f4 100644
> --- a/bsd-user/uaccess.c
> +++ b/bsd-user/uaccess.c
> @@ -43,7 +43,7 @@ abi_long target_strlen(abi_ulong guest_addr1)
>  {
>      uint8_t *ptr;
>      abi_ulong guest_addr;
> -    int max_len, len;
> +    size_t max_len, len;
>
>      guest_addr =3D guest_addr1;
>      for (;;) {
> @@ -51,7 +51,7 @@ abi_long target_strlen(abi_ulong guest_addr1)
>          ptr =3D lock_user(VERIFY_READ, guest_addr, max_len, 1);
>          if (!ptr)
>              return -TARGET_EFAULT;
> -        len =3D qemu_strnlen((const char *)ptr, max_len);
> +        len =3D strnlen((const char *)ptr, max_len);
>          unlock_user(ptr, guest_addr, 0);
>          guest_addr +=3D len;
>          /* we don't allow wrapping or integer overflow */
> diff --git a/docs/devel/style.rst b/docs/devel/style.rst
> index d025933808..0b854ae042 100644
> --- a/docs/devel/style.rst
> +++ b/docs/devel/style.rst
> @@ -519,7 +519,6 @@ QEMU provides other useful string functions:
>
>      int strstart(const char *str, const char *val, const char **ptr)
>      int stristart(const char *str, const char *val, const char **ptr)
> -    int qemu_strnlen(const char *s, int max_len)
>
>  There are also replacement character processing macros for isxyz and
> toxyz,
>  so instead of e.g. isalnum you should use qemu_isalnum.
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index 36c68ce86c..d249f22676 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -101,22 +101,7 @@ int strstart(const char *str, const char *val, const
> char **ptr);
>   *          false otherwise.
>   */
>  int stristart(const char *str, const char *val, const char **ptr);
> -/**
> - * qemu_strnlen:
> - * @s: string
> - * @max_len: maximum number of bytes in @s to scan
> - *
> - * Return the length of the string @s, like strlen(), but do not
> - * examine more than @max_len bytes of the memory pointed to by @s.
> - * If no NUL terminator is found within @max_len bytes, then return
> - * @max_len instead.
> - *
> - * This function has the same behaviour as the POSIX strnlen()
> - * function.
> - *
> - * Returns: length of @s in bytes, or @max_len, whichever is smaller.
> - */
> -int qemu_strnlen(const char *s, int max_len);
> +
>  /**
>   * qemu_strsep:
>   * @input: pointer to string to parse
> diff --git a/linux-user/uaccess.c b/linux-user/uaccess.c
> index 27e841e651..f9bd713edd 100644
> --- a/linux-user/uaccess.c
> +++ b/linux-user/uaccess.c
> @@ -99,7 +99,7 @@ ssize_t target_strlen(abi_ulong guest_addr1)
>          ptr =3D lock_user(VERIFY_READ, guest_addr, max_len, 1);
>          if (!ptr)
>              return -TARGET_EFAULT;
> -        len =3D qemu_strnlen((const char *)ptr, max_len);
> +        len =3D strnlen((const char *)ptr, max_len);
>          unlock_user(ptr, guest_addr, 0);
>          guest_addr +=3D len;
>          /* we don't allow wrapping or integer overflow */
> diff --git a/util/cutils.c b/util/cutils.c
> index 9803f11a59..f39a97e509 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -54,7 +54,7 @@
>
>  void strpadcpy(char *buf, int buf_size, const char *str, char pad)
>  {
> -    int len =3D qemu_strnlen(str, buf_size);
> +    size_t len =3D strnlen(str, buf_size);
>      memcpy(buf, str, len);
>      memset(buf + len, pad, buf_size - len);
>  }
> @@ -118,19 +118,6 @@ int stristart(const char *str, const char *val, cons=
t
> char **ptr)
>      return 1;
>  }
>
> -/* XXX: use host strnlen if available ? */
> -int qemu_strnlen(const char *s, int max_len)
> -{
> -    int i;
> -
> -    for(i =3D 0; i < max_len; i++) {
> -        if (s[i] =3D=3D '\0') {
> -            break;
> -        }
> -    }
> -    return i;
> -}
> -
>  char *qemu_strsep(char **input, const char *delim)
>  {
>      char *result =3D *input;
> --
> 2.50.1 (Apple Git-155)
>
>

--000000000000f0b43b0653091b25
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, May 30, 2026, 12:28=E2=
=80=AFAM Bin Guo &lt;<a href=3D"mailto:guobin@linux.alibaba.com">guobin@lin=
ux.alibaba.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">There=
 are only three call sites, and strnlen() is available on all<br>
supported platforms (POSIX.1-2008, Windows via UCRT, MinGW).=C2=A0 Remove<b=
r>
the hand-rolled wrapper and use the standard function directly.<br>
<br>
While here, align bsd-user/uaccess.c to use size_t for max_len/len,<br>
matching linux-user/uaccess.c and eliminating a signed/unsigned mismatch.<b=
r>
<br>
Also remove the stale qemu_strnlen() entry from docs/devel/style.rst.<br>
<br>
Suggested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lina=
ro.org" target=3D"_blank" rel=3D"noreferrer">philmd@linaro.org</a>&gt;<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank" rel=3D"noreferrer">philmd@linaro.org</a>&gt;<br>
Signed-off-by: Bin Guo &lt;<a href=3D"mailto:guobin@linux.alibaba.com" targ=
et=3D"_blank" rel=3D"noreferrer">guobin@linux.alibaba.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/uaccess.c=C2=A0 =C2=A0 |=C2=A0 4 ++--<br>
=C2=A0docs/devel/style.rst=C2=A0 |=C2=A0 1 -<br>
=C2=A0include/qemu/cutils.h | 17 +----------------<br>
=C2=A0linux-user/uaccess.c=C2=A0 |=C2=A0 2 +-<br>
=C2=A0util/cutils.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 15 +--------------<b=
r>
=C2=A05 files changed, 5 insertions(+), 34 deletions(-)<br></blockquote></d=
iv></div><div dir=3D"auto"><br></div><div dir=3D"auto">Reviewed-by: Warner =
Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.com</a>&gt;</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">Normally not a fan of while I&#39=
;m here fixes, but this one is correct and too small to split out.</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">Warner</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container">=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
diff --git a/bsd-user/uaccess.c b/bsd-user/uaccess.c<br>
index 89163257f4..7ad4b580f4 100644<br>
--- a/bsd-user/uaccess.c<br>
+++ b/bsd-user/uaccess.c<br>
@@ -43,7 +43,7 @@ abi_long target_strlen(abi_ulong guest_addr1)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint8_t *ptr;<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong guest_addr;<br>
-=C2=A0 =C2=A0 int max_len, len;<br>
+=C2=A0 =C2=A0 size_t max_len, len;<br>
<br>
=C2=A0 =C2=A0 =C2=A0guest_addr =3D guest_addr1;<br>
=C2=A0 =C2=A0 =C2=A0for (;;) {<br>
@@ -51,7 +51,7 @@ abi_long target_strlen(abi_ulong guest_addr1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ptr =3D lock_user(VERIFY_READ, guest_addr=
, max_len, 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ptr)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -TARGET_EFAULT;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D qemu_strnlen((const char *)ptr, max_le=
n);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D strnlen((const char *)ptr, max_len);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unlock_user(ptr, guest_addr, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0guest_addr +=3D len;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* we don&#39;t allow wrapping or integer=
 overflow */<br>
diff --git a/docs/devel/style.rst b/docs/devel/style.rst<br>
index d025933808..0b854ae042 100644<br>
--- a/docs/devel/style.rst<br>
+++ b/docs/devel/style.rst<br>
@@ -519,7 +519,6 @@ QEMU provides other useful string functions:<br>
<br>
=C2=A0 =C2=A0 =C2=A0int strstart(const char *str, const char *val, const ch=
ar **ptr)<br>
=C2=A0 =C2=A0 =C2=A0int stristart(const char *str, const char *val, const c=
har **ptr)<br>
-=C2=A0 =C2=A0 int qemu_strnlen(const char *s, int max_len)<br>
<br>
=C2=A0There are also replacement character processing macros for isxyz and =
toxyz,<br>
=C2=A0so instead of e.g. isalnum you should use qemu_isalnum.<br>
diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h<br>
index 36c68ce86c..d249f22676 100644<br>
--- a/include/qemu/cutils.h<br>
+++ b/include/qemu/cutils.h<br>
@@ -101,22 +101,7 @@ int strstart(const char *str, const char *val, const c=
har **ptr);<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 false otherwise.<br>
=C2=A0 */<br>
=C2=A0int stristart(const char *str, const char *val, const char **ptr);<br=
>
-/**<br>
- * qemu_strnlen:<br>
- * @s: string<br>
- * @max_len: maximum number of bytes in @s to scan<br>
- *<br>
- * Return the length of the string @s, like strlen(), but do not<br>
- * examine more than @max_len bytes of the memory pointed to by @s.<br>
- * If no NUL terminator is found within @max_len bytes, then return<br>
- * @max_len instead.<br>
- *<br>
- * This function has the same behaviour as the POSIX strnlen()<br>
- * function.<br>
- *<br>
- * Returns: length of @s in bytes, or @max_len, whichever is smaller.<br>
- */<br>
-int qemu_strnlen(const char *s, int max_len);<br>
+<br>
=C2=A0/**<br>
=C2=A0 * qemu_strsep:<br>
=C2=A0 * @input: pointer to string to parse<br>
diff --git a/linux-user/uaccess.c b/linux-user/uaccess.c<br>
index 27e841e651..f9bd713edd 100644<br>
--- a/linux-user/uaccess.c<br>
+++ b/linux-user/uaccess.c<br>
@@ -99,7 +99,7 @@ ssize_t target_strlen(abi_ulong guest_addr1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ptr =3D lock_user(VERIFY_READ, guest_addr=
, max_len, 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ptr)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -TARGET_EFAULT;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D qemu_strnlen((const char *)ptr, max_le=
n);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D strnlen((const char *)ptr, max_len);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unlock_user(ptr, guest_addr, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0guest_addr +=3D len;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* we don&#39;t allow wrapping or integer=
 overflow */<br>
diff --git a/util/cutils.c b/util/cutils.c<br>
index 9803f11a59..f39a97e509 100644<br>
--- a/util/cutils.c<br>
+++ b/util/cutils.c<br>
@@ -54,7 +54,7 @@<br>
<br>
=C2=A0void strpadcpy(char *buf, int buf_size, const char *str, char pad)<br=
>
=C2=A0{<br>
-=C2=A0 =C2=A0 int len =3D qemu_strnlen(str, buf_size);<br>
+=C2=A0 =C2=A0 size_t len =3D strnlen(str, buf_size);<br>
=C2=A0 =C2=A0 =C2=A0memcpy(buf, str, len);<br>
=C2=A0 =C2=A0 =C2=A0memset(buf + len, pad, buf_size - len);<br>
=C2=A0}<br>
@@ -118,19 +118,6 @@ int stristart(const char *str, const char *val, const =
char **ptr)<br>
=C2=A0 =C2=A0 =C2=A0return 1;<br>
=C2=A0}<br>
<br>
-/* XXX: use host strnlen if available ? */<br>
-int qemu_strnlen(const char *s, int max_len)<br>
-{<br>
-=C2=A0 =C2=A0 int i;<br>
-<br>
-=C2=A0 =C2=A0 for(i =3D 0; i &lt; max_len; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s[i] =3D=3D &#39;\0&#39;) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 return i;<br>
-}<br>
-<br>
=C2=A0char *qemu_strsep(char **input, const char *delim)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0char *result =3D *input;<br>
-- <br>
2.50.1 (Apple Git-155)<br>
<br>
</blockquote></div></div></div>

--000000000000f0b43b0653091b25--

