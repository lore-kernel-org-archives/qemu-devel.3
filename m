Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B39C47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 19:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUWuX-0008IG-SO; Mon, 29 Jan 2024 14:03:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1rUWuW-0008HG-3A
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 14:03:12 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1rUWuT-0007U4-QA
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 14:03:11 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-55a8fd60af0so3126438a12.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 11:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1706554987; x=1707159787;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=spxDilCyk18HJso01XnsACRO6cxQeQZiG91gxxRoQ8k=;
 b=F1qxmDMF1k1609S+eELCU1/dwvjfsuZBgX9OHHyp1uvyfpzWlBNTZz0DLJvjMBQjIY
 RW44vprXQddimzcTKuB+wrTx0WaqLHj324NKdOLy3P0kKoI2zzN4ENAyj3can+zfZR4h
 EhHsbJk9HFyYax+8JVUXbzVx/KbjwK6iQjHtj/Hsaxcp23WgDcJ01kDJtPChrbTKsgIf
 FDg0i77T5NlYtted/ue2iro1IT7w7hVR7D7BZa5yXaooochJpX1dr542zuJRuL7ba03o
 dRSMDYgdZHRJnibBCmgRpKwXSwDLCp4EnFY9cjoU7kENuCaeUAvmgb/8dY/WbWld1DV3
 /R2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706554987; x=1707159787;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=spxDilCyk18HJso01XnsACRO6cxQeQZiG91gxxRoQ8k=;
 b=F8qzAxyBSDHtC65L4mWCWzu8on2p+8+oUowGEcWaR3os1+9dyRquENKKdJX9SlbKkS
 euS5n7rDKbUu1lBXk3eawlK6uHoT6etN9NB6FjziuPag+fss7PwNn3CrVOAf9hBSSXWY
 WHAZ2kKMY3uMc3YSZpfAKmX7f6a/8psD+L30KMtbtuumciDjC+NBvDda7NAaTbSahRFM
 xezG9e70yr9DDRYd95PHQO0L7m5qwWNw60Z+rxti/EsqZYlD7WMu8TZH40tjsesad6r0
 ohnBpet9QGT9PJKXMqA56PGiFXV/gUqbxV8BGv+EhvXBpmbYwIZdggqo+oneXyHldNMq
 4AoA==
X-Gm-Message-State: AOJu0YyTBz/cqq/SHTnoB9rGnJ6B2XLacu89gtNEqMep4rEddlTHlEDs
 Zjdypb1kKSbiccjGEFr5j3jVf9XqUON6YjkScEAp02/tf/H/GS7PPI5ReAxlhHqZM7eJ3ItaYm1
 V2lLIa8K9S55tWXaDjq8KJ/a+ubO9c5InbCJRvw==
X-Google-Smtp-Source: AGHT+IHsR+ZhQNvHTBWAOj86rNT9JTszVwJdoBQYl40m+agN7fDYYmP6wVVgHqA3RlBA1iaF9r2mECmPal1of3jTIh4=
X-Received: by 2002:a05:6402:b12:b0:55e:b231:7bc1 with SMTP id
 bm18-20020a0564020b1200b0055eb2317bc1mr4269839edb.23.1706554986953; Mon, 29
 Jan 2024 11:03:06 -0800 (PST)
MIME-Version: 1.0
References: <20240125200731.2633-1-iii@linux.ibm.com>
In-Reply-To: <20240125200731.2633-1-iii@linux.ibm.com>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 29 Jan 2024 12:02:55 -0700
Message-ID: <CANCZdfrNt+HPsbDNkMO2UgUvjKq-Dkvi7FJvYUe7MXgrVtsM3w@mail.gmail.com>
Subject: Re: [PATCH] {linux,bsd}-user: Fail mmap() if size doesn't fit into
 host's size_t
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, 
 Kyle Evans <kevans@freebsd.org>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000c98d5506101a4bf0"
Received-SPF: none client-ip=2a00:1450:4864:20::529;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000c98d5506101a4bf0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 1:07=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:

> s390x's branch-relative-long test fails with the following error
> message on 32-bit hosts:
>
>     qemu-s390x: ../accel/tcg/user-exec.c:493: page_set_flags: Assertion
> `last <=3D GUEST_ADDR_MAX' failed.
>
> The root cause is that the size passed to mmap() by this test does not
> fit into 32 bits and gets truncated. Since there is no chance for such
> mmap() to succeed, detect this condition and fail the mmap() right away.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  bsd-user/mmap.c   | 4 ++++
>  linux-user/mmap.c | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
> index 3ef11b28079..5dc327d0ad3 100644
> --- a/bsd-user/mmap.c
> +++ b/bsd-user/mmap.c
> @@ -256,6 +256,10 @@ static abi_ulong mmap_find_vma_aligned(abi_ulong
> start, abi_ulong size,
>
>      size =3D HOST_PAGE_ALIGN(size);
>
> +    if (size !=3D (size_t)size) {
> +        return (abi_ulong)(-1);
> +    }
> +
>      if (reserved_va) {
>          return mmap_find_vma_reserved(start, size,
>              (alignment !=3D 0 ? 1 << alignment :
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

Seems good to me..  I can queue it to this month's landing code, unless
Richard beats me to it.

Warner

--000000000000c98d5506101a4bf0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 25, 2024 at 1:07=E2=80=AF=
PM Ilya Leoshkevich &lt;<a href=3D"mailto:iii@linux.ibm.com">iii@linux.ibm.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">s390x&#39;s branch-relative-long test fails with the following error<br>
message on 32-bit hosts:<br>
<br>
=C2=A0 =C2=A0 qemu-s390x: ../accel/tcg/user-exec.c:493: page_set_flags: Ass=
ertion `last &lt;=3D GUEST_ADDR_MAX&#39; failed.<br>
<br>
The root cause is that the size passed to mmap() by this test does not<br>
fit into 32 bits and gets truncated. Since there is no chance for such<br>
mmap() to succeed, detect this condition and fail the mmap() right away.<br=
>
<br>
Signed-off-by: Ilya Leoshkevich &lt;<a href=3D"mailto:iii@linux.ibm.com" ta=
rget=3D"_blank">iii@linux.ibm.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/mmap.c=C2=A0 =C2=A0| 4 ++++<br>
=C2=A0linux-user/mmap.c | 4 ++++<br>
=C2=A02 files changed, 8 insertions(+)<br>
<br>
diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c<br>
index 3ef11b28079..5dc327d0ad3 100644<br>
--- a/bsd-user/mmap.c<br>
+++ b/bsd-user/mmap.c<br>
@@ -256,6 +256,10 @@ static abi_ulong mmap_find_vma_aligned(abi_ulong start=
, abi_ulong size,<br>
<br>
=C2=A0 =C2=A0 =C2=A0size =3D HOST_PAGE_ALIGN(size);<br>
<br>
+=C2=A0 =C2=A0 if (size !=3D (size_t)size) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (abi_ulong)(-1);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (reserved_va) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return mmap_find_vma_reserved(start, size=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(alignment !=3D 0 ? 1 &lt;&=
lt; alignment :<br></blockquote><div><br></div><div>Reviewed-by: Warner Los=
h &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.com</a>&gt;</div><div><b=
r></div><div>Seems good to me..=C2=A0 I can queue it to this month&#39;s la=
nding code, unless Richard beats me to it.</div><div><br></div><div>Warner=
=C2=A0</div></div></div>

--000000000000c98d5506101a4bf0--

