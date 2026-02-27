Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC28D1048922
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 23:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw7an-0005sA-0C; Fri, 27 Feb 2026 18:49:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vw7ak-0005r0-Kg
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 18:49:54 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vw7ai-0005TX-OR
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 18:49:54 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2ab46931cf1so25959285ad.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 15:49:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772236190; cv=none;
 d=google.com; s=arc-20240605;
 b=GPu2sjdiPTpQx/9XX4QsFifARJRArpTwTPk0t7wINGvUTF/Fds9x0nT3XZ4ANQBh+X
 kCkjlrkgs46HMzoBbQlsKgpnArrhhMQ7IVQVlV9mt+ZmX/ijvFy2/G/4gy5U55MqSmkk
 qmmj9lQGbEiT4dEJd9QWrn9FfZKxzkksJdg0J1FPXmyvD1ohvP1Qidm27P7vwtcVe4ii
 udryxBWZsAb1GLxuNePCKmB3ADn52C1cvvKJS+Pj/io+Fsj7I2BhhE3hvqbOoxRo0AyQ
 t40uoSKPmoYaa/NP/H3W2QcqPmLqJFRe1bc1dA8ppOzZJmSodt7rqg1OqNwJmWmT7Vz0
 eIag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=I18G0gkLLnuE8zi8+DCjG74ejZkzda312VrqU+b7VNs=;
 fh=A7r/QyaVUKHG5jLR4Qb4Q/xzyBEBy9edyZJ3ETayuec=;
 b=ayiD/JO950NvWfJZcHk7yTprbw/ASO+FqyJsuTHkT/ui66U9UW+J8J1no/URgTuAJu
 6hJd1tdvCB9Kd0iWE1IGqpacyIv5UOyVLIGuPjfYblNDRALsFESEYQ4vkBKy/PwZ2Sb8
 PbUq74bAXBkXGT+7EnYWDhMn6qFHWFvQ+5nxgD6GcM+lc/6HD4QjHogk5OotpVfOwH2N
 zUFoz7mxv9QnhPHke3YlsFb8OCFeLkrXxBghOKT5gRW73VepBb1SIedcLxvAEbMdqV0v
 cD5rerZE5O8slHwTHv9NjP+sjUmMY37QovU002Tgz0vBO0gQyM9/v9EIiQjnpRxjZwH1
 YjIw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772236190; x=1772840990;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I18G0gkLLnuE8zi8+DCjG74ejZkzda312VrqU+b7VNs=;
 b=k3pczkXgSHC44Y6q7Ah8pbd6xPGPWUJLZwM/c+L5F2hnCrsbydeMljGX6Xl7Z5kK4X
 ZwDbhOWfKIr3yHshRqGr9DiHgu23VjpWOUlElgBOfUEYoEsuL5Ls9ymgt/ARwR5N3Mpn
 xfyadApzOMADMof3oLQ3XXg+aWZNgKU9da/uIRQyHq+xP+K3suE86VTAQ32e62UIXf2p
 etEeaZIWAnkjFMn9xQNIqBYE2/dLi09ADUrBFTbwk6y0nRb41ioUSyA28o6L9vl1sWHF
 /SSNKEtI8eU92GOj04K1dJBhc9jfnJJZkAgYYIPf2upCHikLcmmJtJnfn2gIFmJcdA6J
 NSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772236190; x=1772840990;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I18G0gkLLnuE8zi8+DCjG74ejZkzda312VrqU+b7VNs=;
 b=G6pBXVyLbhJOaZkcKHwoDqSX623x8DcJgoSMbKvJqal3YOCOkzuOppLb99C9H8oP7P
 pdbfw5U2nHZCoPYM4UC22Qtn6rGq9+0gZzUpmWwCZ6rljYo86V3RMQzvOCkiEG5vUFjA
 L6TsBFzQED+dGuI0uegYNio3x9QXTh0MrogGJNwDZfZQgBSi+zSl/dIjy+1MoaQmg+Dp
 Dz4SHWwETlhS9iHjAOz6U3qWntkWcQEq7Z0szKW2Iha/wMlfzK3i2KBAODRZmkRVNxkN
 BfVtEdQfFAz6QEQ+pEBwIEMzhJsmTElRttuvBmeW9ZEiOWlrXgPe7km2AZR+1OEp//SO
 HShQ==
X-Gm-Message-State: AOJu0YyXUzSFXh4m9E4fs8zP4cXiyVW08+8bAx9vGylF1oCpJwOIq0ci
 kpKayh38rDnRymjhunWEOjybDLoeIfo2pSPyoyRTbOkpvkSQxhKMb5RViymSVT1KiHBa6OagEMl
 /DqSdnrjukpUjR6fuQ/1CsCqAvvCg0eNxUn0p/7CGKA==
X-Gm-Gg: ATEYQzzF1zxYmwNsF1pNMXvAHzlpVNqCqxuSsanpsqCI7RU4gCSoHApFzgePAajL80Y
 8ldkPlrBdR5wDG5xe8vf78cGlShuSuQEI770kg4mLOGbqjPBEooXDOjbfgRgWCLpTBOwmfT6pkG
 pTVpWitCLZqYu4xHgQdJxfRidECdXsHtfDp6jaIlIRRwW2NfMgownRxhIRaBuDM7iXIqnmh8Fmj
 HtbFUZkWiAbYGozpmb4k+vpw8YqaXew3teucuzKQOLksxYXm9Q1YaN39Gwy3IVFQJkB44ZUoQ5q
 KStoORU=
X-Received: by 2002:a17:903:2342:b0:2a0:c92e:a378 with SMTP id
 d9443c01a7336-2ae2b6500b8mr44209095ad.7.1772236190644; Fri, 27 Feb 2026
 15:49:50 -0800 (PST)
MIME-Version: 1.0
References: <20260228-abyss-mmap-relocation-v1-0-c8ec0476894b@astrafall.org>
 <20260228-abyss-mmap-relocation-v1-2-c8ec0476894b@astrafall.org>
In-Reply-To: <20260228-abyss-mmap-relocation-v1-2-c8ec0476894b@astrafall.org>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 27 Feb 2026 16:49:39 -0700
X-Gm-Features: AaiRm50QU_ONtNu-ucMYSZnUebwrfsTd8DenIEmQlDQkkuOkWJ86wbnd8Uvuy_U
Message-ID: <CANCZdfpKfuP-yxAh42HEi_7ft6kPD_2HR0q28kj6VHNSu5hfWg@mail.gmail.com>
Subject: Re: [PATCH 2/4] bsd-user: Deal with mmap where start > reserved_va
To: Bingwu Zhang <xtex@envs.net>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Alex_R=C3=B8nne_Petersen?= <alex@alexrp.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Bingwu Zhang <xtex@astrafall.org>
Content-Type: multipart/alternative; boundary="0000000000009a0967064bd6e4e2"
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x62a.google.com
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

--0000000000009a0967064bd6e4e2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 9:47=E2=80=AFAM Bingwu Zhang <xtex@envs.net> wrote:

> From: Bingwu Zhang <xtex@astrafall.org>
>
> Fixes: f12294b5bd21 ("bsd-user: Use page_find_range_empty for
> mmap_find_vma_reserved")
> Signed-off-by: Bingwu Zhang <xtex@astrafall.org>
> ---
>  bsd-user/mmap.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

Have you run FreeBSD binaries with this?

Warner


> diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
> index 24ba1728eb55..fe77eceb4856 100644
> --- a/bsd-user/mmap.c
> +++ b/bsd-user/mmap.c
> @@ -258,12 +258,14 @@ abi_ulong mmap_next_start =3D TASK_UNMAPPED_BASE;
>  static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size,
>                                          abi_ulong alignment)
>  {
> -    abi_ulong ret;
> +    abi_ulong ret =3D -1;
>
> -    ret =3D page_find_range_empty(start, reserved_va, size, alignment);
> +    if (start <=3D reserved_va) {
> +        ret =3D page_find_range_empty(start, reserved_va, size, alignmen=
t);
> +    }
>      if (ret =3D=3D -1 && start > TARGET_PAGE_SIZE) {
>          /* Restart at the beginning of the address space. */
> -        ret =3D page_find_range_empty(TARGET_PAGE_SIZE, start - 1,
> +        ret =3D page_find_range_empty(TARGET_PAGE_SIZE, MIN(start - 1,
> reserved_va),
>                                      size, alignment);
>      }
>
>
> --
> 2.52.0
>
>

--0000000000009a0967064bd6e4e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 27,=
 2026 at 9:47=E2=80=AFAM Bingwu Zhang &lt;<a href=3D"mailto:xtex@envs.net">=
xtex@envs.net</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">From: Bingwu Zhang &lt;<a href=3D"mailto:xtex@astrafall.org" t=
arget=3D"_blank">xtex@astrafall.org</a>&gt;<br>
<br>
Fixes: f12294b5bd21 (&quot;bsd-user: Use page_find_range_empty for mmap_fin=
d_vma_reserved&quot;)<br>
Signed-off-by: Bingwu Zhang &lt;<a href=3D"mailto:xtex@astrafall.org" targe=
t=3D"_blank">xtex@astrafall.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/mmap.c | 8 +++++---<br>
=C2=A01 file changed, 5 insertions(+), 3 deletions(-)<br></blockquote><div>=
<br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.co=
m">imp@bsdimp.com</a>&gt;</div><div><br></div><div>Have you run FreeBSD bin=
aries with this?</div><div><br></div><div>Warner</div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c<br>
index 24ba1728eb55..fe77eceb4856 100644<br>
--- a/bsd-user/mmap.c<br>
+++ b/bsd-user/mmap.c<br>
@@ -258,12 +258,14 @@ abi_ulong mmap_next_start =3D TASK_UNMAPPED_BASE;<br>
=C2=A0static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong si=
ze,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ab=
i_ulong alignment)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 abi_ulong ret;<br>
+=C2=A0 =C2=A0 abi_ulong ret =3D -1;<br>
<br>
-=C2=A0 =C2=A0 ret =3D page_find_range_empty(start, reserved_va, size, alig=
nment);<br>
+=C2=A0 =C2=A0 if (start &lt;=3D reserved_va) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D page_find_range_empty(start, reserved_=
va, size, alignment);<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0if (ret =3D=3D -1 &amp;&amp; start &gt; TARGET_PAGE_SIZ=
E) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Restart at the beginning of the addres=
s space. */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D page_find_range_empty(TARGET_PAGE_SIZE=
, start - 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D page_find_range_empty(TARGET_PAGE_SIZE=
, MIN(start - 1, reserved_va),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size, alignment)=
;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
<br>
-- <br>
2.52.0<br>
<br>
</blockquote></div></div>

--0000000000009a0967064bd6e4e2--

