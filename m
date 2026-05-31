Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D84CD5BD1
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 04:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTXbK-0007Vx-TH; Sun, 31 May 2026 00:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTXbJ-0007Vo-7A
 for qemu-devel@nongnu.org; Sun, 31 May 2026 00:16:37 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTXbH-0000RH-AV
 for qemu-devel@nongnu.org; Sun, 31 May 2026 00:16:36 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2bf125989f2so18823175ad.3
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 21:16:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780200993; cv=none;
 d=google.com; s=arc-20240605;
 b=daYqT5tMoAojc5CIDAQJkiPCBSxU6IJQUpofpsjqx+wuv1w3TxE5MYWkHGnJtrepaf
 Z+b88d1kptt0er4vmwD74qXNBH3ypRDpcJqiKYINmVHcHJNnGxata78l/64qbmT/TMMa
 yPxjqUxkKW61AncJweQamJPe3RaInniNlIi7Y9AZhif5+3su2FEsSBc5KiuSHMeUl5KT
 H1AoDJRzX2FQbcQwohDAPmRs6ReTFeMvqaPr/p8HHIPoENN+rHFbqonh3WvTh6s+cWC/
 hjMFSiv3jhDQAzPuRSIThDm+w7pIrszqOlKnuqqQiCoVuHlvv44QaGD/bz70bZ5Gl5/G
 fSkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VbmmKLv12gufU3L19syLfJvZgLeCQYZiFLqX/vIBlC4=;
 fh=+DxRVnEC95Ptxk5HMfIFqaUwIao1HhLaAPFCgZPm1R4=;
 b=KV+DAI06iPG5QuUJAj3xNEi5hGiInTIXPSLojEwgo6//S4/NDagPT9uM+4qYEZbRzm
 G/8qKyaBS8TWnG4UOPqc4uF7bCA8TcEthnlGCzGo4Bc9aJYxbQwS50/rBbP9vM0Q0YF6
 ITaeEEXHsBF1Qd0nm3tmFSK1YbtKj5TPCqEkJmK7QG9Q6i7h8xQ7ry2wjztFFxDY9dIk
 NqN+Uca/pIW+XWUvdwjgOyro5TcRQ3pynA+Q2hNGOu7t1SOHa33kgIx1OtQTB9SvYP2g
 0PToJ0xM3nfhugmAjQ2N3vJcMMY2HpHB4vGsFpWa+mVn76cSFKFcMAy8l03CMw9stw9c
 wl+g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1780200993; x=1780805793;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VbmmKLv12gufU3L19syLfJvZgLeCQYZiFLqX/vIBlC4=;
 b=Z0swvKHzqtK6LZjUGs3rKvVWBVTtylygR5boULCXM4r6g8oSWgriDzXfbQWltvwRSB
 K5RsK3spOHvrq6upHceRpNV06A8Gamo9Q4plzhDpAiH4gFqpAiUCkx6HEr8ZK+Mg2DgY
 lC7GtJj5krCYO9sCfnq/M0MFIWxDAZVQ8g2pD3NFyaqpm+mgwlPwQJhpUYJAKG7zubRR
 UlMu46ZiAZfiyfOas+MP0S/1Ihn2Ubf43Yb4JE1tI0YJSpu6XGwtexqbdduolHbq2hPZ
 abzHApEk5ECgm1IFWQAK5+oBW7ssXnGO2gof0mB97M3cXSbssKX/LPV9g1QBgK6uGaul
 zoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780200993; x=1780805793;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VbmmKLv12gufU3L19syLfJvZgLeCQYZiFLqX/vIBlC4=;
 b=FrNRZebW5/NHvdxDejeK/MX1mXoAsL1LiAT1mq6uvLTGykuME5lOkKxM5qpGxH1DQe
 cPxxxEsRX/X7TNoawCL3jfTCv11xy+fEpnvFShwquAW7zy/MIXM50BCCKvNIlSuFA5/n
 Yy+1ap2DvXM0iPXmq6Apn1H/qt9zjltlaAgDRGz0PlunWomePdkuvuZqH4d8mHWuDQML
 SC+NDwKww9psSyP1cMtTu0NN8nkDATBknXKQgScx8roFbUqNUHW8nDHZYa92XqH72Hwr
 UA8/DQih9QunIwp/VPMp7angFDVBwPfajJ2YL4enMeM9Kjt9vtdXg/CuiSgk5t3gULFM
 Eo2Q==
X-Gm-Message-State: AOJu0YxFgnj3I6ywRc6Un/aBKLUA8jIPqOOneWoobFgs0ZZRiVfnFrjV
 hRy8i9cj/XcykFi5vrtoEYJmx4o4Uk24qQuOvmiIbdg1dQ1cnb/GRW5c1G8jyOP1BPDN5CAOyHw
 Iq5MJE4E2WjPo+84ImfgWk0BukYxvtkdQa4MJh8SY7g==
X-Gm-Gg: Acq92OH29+kG0zInw3+kGWU3dF0+WNDI2zdADvVnk6UDRHfqDX1F36RxOEartCTpU1c
 z9Hf+iCQHDGWAk59O/+kuM8wSlkzxD702fAYCeKWxVFHKwJLc6tT+FKTyjCyBOm6YcxoPYyUmS+
 2eUuTVrx7FwAZdKK6hCkv53rJQwaVUcCy70hYqKYDp8tFDDknv66kbUGHNBz+HAkvY1NW8gKSDr
 QySsn+/D3cmTUHstU/1dbdn2Oz5ywheixLFEvUvmna3YUM5Th2Uff6ZR9COE7bsDX6/UDqKUtSO
 rHINmioJAJ7PQ1g5pisKDHAVpcsgM2lc94Elw+2x3y715hdBsHtwdi6iYA==
X-Received: by 2002:a17:902:ecc6:b0:2c0:cb90:1e07 with SMTP id
 d9443c01a7336-2c0cb902145mr8434675ad.11.1780200993363; Sat, 30 May 2026
 21:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260530211248.375318-1-richard.henderson@linaro.org>
 <20260530211248.375318-4-richard.henderson@linaro.org>
In-Reply-To: <20260530211248.375318-4-richard.henderson@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 30 May 2026 22:16:22 -0600
X-Gm-Features: AVHnY4JwfIznrne6otlELDmSmQ2XmPMmM3VrmG-trwq47z_TqDm-uHn5D72O8R0
Message-ID: <CANCZdfoJXsOVZN4RKek6Rm49fN08nVtjs1pQgyzKzQKif6jLmg@mail.gmail.com>
Subject: Re: [PATCH 03/13] linux-user: Drop hiaddr out-of-range check in
 probe_guest_base
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Content-Type: multipart/alternative; boundary="000000000000d6ac120653155711"
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

--000000000000d6ac120653155711
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 3:12=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> Since dropping 32-bit host support, a guest address cannot
> overflow a host pointer.  This means guest_hiaddr is unused
> for relocatable images, so don't pass guest_hiaddr as size.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c  | 26 +++++++-------------------
>  linux-user/flatload.c |  3 +--
>  2 files changed, 8 insertions(+), 21 deletions(-)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

I though there'd be a bsd-user change like this but I couldn't find it,
though I did find some code in bsd-user/main.c I may need to cleanup now
that 64-on-32 isn't a thing.

Warner


> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index fb774adf25..33565ad7be 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1092,20 +1092,11 @@ void probe_guest_base(const char *image_name,
> abi_ulong guest_loaddr,
>      uintptr_t align =3D MAX(SHMLBA, TARGET_PAGE_SIZE);
>
>      /* Sanity check the guest binary. */
> -    if (reserved_va) {
> -        if (guest_hiaddr > reserved_va) {
> -            error_report("%s: requires more than reserved virtual "
> -                         "address space (0x%" PRIx64 " > 0x%lx)",
> -                         image_name, (uint64_t)guest_hiaddr, reserved_va=
);
> -            exit(EXIT_FAILURE);
> -        }
> -    } else {
> -        if (guest_hiaddr !=3D (uintptr_t)guest_hiaddr) {
> -            error_report("%s: requires more virtual address space "
> -                         "than the host can provide (0x%" PRIx64 ")",
> -                         image_name, (uint64_t)guest_hiaddr + 1);
> -            exit(EXIT_FAILURE);
> -        }
> +    if (reserved_va && guest_hiaddr > reserved_va) {
> +        error_report("%s: requires more than reserved virtual "
> +                     "address space (0x%" PRIx64 " > 0x%lx)",
> +                     image_name, (uint64_t)guest_hiaddr, reserved_va);
> +        exit(EXIT_FAILURE);
>      }
>
>      if (have_guest_base) {
> @@ -1373,11 +1364,8 @@ static void load_elf_image(const char *image_name,
> const ImageSource *src,
>               */
>              probe_guest_base(image_name, range.lo, range.hi);
>          } else {
> -            /*
> -             * The binary is dynamic, but we still need to
> -             * select guest_base.  In this case we pass a size.
> -             */
> -            probe_guest_base(image_name, 0, range.hi - range.lo);
> +            /* The binary is dynamic; we still need to select guest_base=
.
> */
> +            probe_guest_base(image_name, 0, 0);
>
>              /*
>               * Avoid collision with the loader by providing a different
> diff --git a/linux-user/flatload.c b/linux-user/flatload.c
> index 4beb3ed1b9..8abdd2aef2 100644
> --- a/linux-user/flatload.c
> +++ b/linux-user/flatload.c
> @@ -261,8 +261,7 @@ static int load_flat_file(struct linux_binprm * bprm,
>      /*
>       * Allocate the address space.
>       */
> -    probe_guest_base(bprm->filename, 0,
> -                     text_len + data_len + extra + indx_len - 1);
> +    probe_guest_base(bprm->filename, 0, 0);
>
>      /*
>       * there are a couple of cases here,  the separate code/data
> --
> 2.43.0
>
>

--000000000000d6ac120653155711
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, May 30,=
 2026 at 3:12=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.he=
nderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Since dropping 32-bit host =
support, a guest address cannot<br>
overflow a host pointer.=C2=A0 This means guest_hiaddr is unused<br>
for relocatable images, so don&#39;t pass guest_hiaddr as size.<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0linux-user/elfload.c=C2=A0 | 26 +++++++-------------------<br>
=C2=A0linux-user/flatload.c |=C2=A0 3 +--<br>
=C2=A02 files changed, 8 insertions(+), 21 deletions(-)<br></blockquote><di=
v><br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.=
com">imp@bsdimp.com</a>&gt;</div><div><br></div><div>I though there&#39;d b=
e a bsd-user change like this but I couldn&#39;t find it, though I did find=
 some code in bsd-user/main.c I may need to cleanup now that 64-on-32 isn&#=
39;t a thing.</div><div><br></div><div>Warner</div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
diff --git a/linux-user/elfload.c b/linux-user/elfload.c<br>
index fb774adf25..33565ad7be 100644<br>
--- a/linux-user/elfload.c<br>
+++ b/linux-user/elfload.c<br>
@@ -1092,20 +1092,11 @@ void probe_guest_base(const char *image_name, abi_u=
long guest_loaddr,<br>
=C2=A0 =C2=A0 =C2=A0uintptr_t align =3D MAX(SHMLBA, TARGET_PAGE_SIZE);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Sanity check the guest binary. */<br>
-=C2=A0 =C2=A0 if (reserved_va) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (guest_hiaddr &gt; reserved_va) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s: requires =
more than reserved virtual &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;address space (0x%&quot; PRIx64 &quot; &gt; 0x%lx)&q=
uot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0image_name, (uint64_t)guest_hiaddr, reserved_va);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (guest_hiaddr !=3D (uintptr_t)guest_hiaddr)=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s: requires =
more virtual address space &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;than the host can provide (0x%&quot; PRIx64 &quot;)&=
quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0image_name, (uint64_t)guest_hiaddr + 1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (reserved_va &amp;&amp; guest_hiaddr &gt; reserved_va) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s: requires more than rese=
rved virtual &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;address space (0x%&quot; PRIx64 &quot; &gt; 0x%lx)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0image_name, (uint64_t)guest_hiaddr, reserved_va);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (have_guest_base) {<br>
@@ -1373,11 +1364,8 @@ static void load_elf_image(const char *image_name, c=
onst ImageSource *src,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0probe_guest_base(image_name=
, range.lo, range.hi);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The binary is dynamic, b=
ut we still need to<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* select guest_base.=C2=A0=
 In this case we pass a size.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 probe_guest_base(image_name, 0, =
range.hi - range.lo);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The binary is dynamic; we sti=
ll need to select guest_base. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 probe_guest_base(image_name, 0, =
0);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Avoid collision with the=
 loader by providing a different<br>
diff --git a/linux-user/flatload.c b/linux-user/flatload.c<br>
index 4beb3ed1b9..8abdd2aef2 100644<br>
--- a/linux-user/flatload.c<br>
+++ b/linux-user/flatload.c<br>
@@ -261,8 +261,7 @@ static int load_flat_file(struct linux_binprm * bprm,<b=
r>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * Allocate the address space.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 probe_guest_base(bprm-&gt;filename, 0,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0text_len + data_len + extra + indx_len - 1);<br>
+=C2=A0 =C2=A0 probe_guest_base(bprm-&gt;filename, 0, 0);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * there are a couple of cases here,=C2=A0 the separate=
 code/data<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--000000000000d6ac120653155711--

