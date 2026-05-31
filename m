Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B040CD5BD1
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 04:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTXWq-0006bH-BY; Sun, 31 May 2026 00:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTXWn-0006af-VK
 for qemu-devel@nongnu.org; Sun, 31 May 2026 00:11:58 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTXWl-0006er-SS
 for qemu-devel@nongnu.org; Sun, 31 May 2026 00:11:57 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-36b903567fdso2807836a91.1
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 21:11:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780200714; cv=none;
 d=google.com; s=arc-20240605;
 b=CbH5dnIlQGUb7V0i6sRjQ31S+cpOWahVuLf7r9aPKEhrfXuJ/I9n00kfDRq/NTjZP3
 Aj8HJS9IlVzFdG9tW1aQTix5CUK+p+5a5UW6dLYv7u0BtuTVE73z+AICxEgl2sOH3TLP
 HsDskWkydU7s42iurCeSmLlJVuuhxOYAoWhjGguWk/HBcmdf2QEHVkl12gfhe4IdB0XN
 tMAeXZxPuL1zeJX1Y52xkJj7Tg4f1Il4a3/hj8FcyM4Ol4o2UnpKOwt/QDXvzVm94NcP
 pZh5qf3TJ4ojBkl4+wJn0U13c6qa4dzzlCbMacfC+c3Qu2G1velH92TZwwwAbuz9vk+U
 sOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/0fpWwcEywueB0o+WLyHrf/0yZFoyIMoErxz7clMFe8=;
 fh=+DxRVnEC95Ptxk5HMfIFqaUwIao1HhLaAPFCgZPm1R4=;
 b=RYB0x3Gh/asb2kXb7FqyvvtLCxSsdp0S88wqznVhIzJwjxta8L58GmzrPpoHPw4ioa
 2CNQ94/qYaFhDlamhow6i0gc7wgbiumVlaMTCANJCUp21NhQKkZAmn0FwTQepBVGx9mW
 xMr48+0xS0WRAs6PxSpiSoYl/bR2HelaVbtZW4hzNnZgnzPvWABK/HA/jr7St6OjGZal
 Ago+oen8bEqqWCNKbolWwhyex1A07v4Jl0hsfCtSZ89xQO8xQoz1CD/upUzJp2qlSRBN
 gicch+2cIMmMQOUuOb2wBRXK0X7xwg5H/J+RXlEcDjmiH1Ug0WP37lvUoVDpt2TxEoML
 53BA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1780200714; x=1780805514;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/0fpWwcEywueB0o+WLyHrf/0yZFoyIMoErxz7clMFe8=;
 b=k+QA9xdYkd4O+Jsu5FHkBiJc4RPcNBeCTJ4LqODzqFR6UyktfTJkOPWxAvGgmNZ/Xa
 baOIAbpBPBGRptPgWHi2X31pgIbWYoTa1saDrtGK9OQ67DpwD5q9Kj9QE8KBAO7oJiUU
 cPgBBMcbvdflag+oqcweRiZxt1P8PjNXMZ5Dy3PLFxRwsmX8JJeZaC/HuHJGcifyn2ze
 N/pnx+M8zXcTVzmpK3rLtrL4KOg2reeecCqozNlZVJChZDoqXv5uki1QWiQwg2CLMAZc
 lp0vPAmGJdDLlPON3zPIcBU0238hSq2DvKstxh/Oh423PNJozP9yNoF2iIKiRLWSQudk
 l0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780200714; x=1780805514;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/0fpWwcEywueB0o+WLyHrf/0yZFoyIMoErxz7clMFe8=;
 b=m3hVUDtGGSzBSAz6jX1eyyV/UeyF9IDkewljzjSaWyXZMm5hW/QbDS6e69HTprgqNw
 gKHfbPeXAJAhLqNqkKJ8+htFff6f38Gm6yIBdTvJZOoeAKrhIDufQOllvh1nOpcxD2JC
 o+Yo4yGAaHvZU9LyXGsY6UjXRwVAQ93PmwGIvtQTM8Etja+cO4s73ocyEy+5HGYyOqBG
 ghikbNRQ56OPfZ/rGSmfUo/DoKvuI+mLsLe5f/0cAdE6aXcxw2o1FkXcxyM0FV16v2Pp
 56bctF4HJa5IGaNw+QKroTm9nkHQe3nsvN6+YxvKcfeYNcJjfWveMdXiZmeu3mgz8OK1
 a1IA==
X-Gm-Message-State: AOJu0YxW34QhoV+IB2cPxv9YI0aRja8b9VXhEr2tiYika1Cx5U4r5fwq
 RHhqvMGWku0bHTwFdAGRFV2JdrWqvB6rNUTH25cLeebHJ8CsLW85uh2/yMhiTanUreQ1xYfK+yn
 1gAac0rtbRwcPGAhkWoYmWYA57YOXbY1/wUK/MlR6v+2ZjFYkZ441
X-Gm-Gg: Acq92OFhJdLTQMIm29ElFq074tKFeVBhojW71HNv7z/RmBU7+7/Bv9X7SdzfD786nvd
 1to6iJTNv/tuRIBgInXIWtBDeO2H8Vznk5GAQGMvzVuvcTR7+a1hiQ5RMHLRRT7qCfCZ1qWHJLT
 +CmjEvMnXvUU9W/ThIsssWQUtXErA9pAk+cxpe+3Cs9wQ6gCKlhAoh1RCcUJqPdSNFEL0okbTD8
 Oy3h7RA2pXGUntlG4iYtbsnpvYURtcxxUa7CJpnhGRDG4AP4kN/r7FlmF+URidGiFrS6/9GI8tc
 V6fw+0k+yyixVkLIoYCeECu+Ka2kxcG5cdbaUX5EPGPC4k4=
X-Received: by 2002:a17:90a:d604:b0:369:69f8:ad6b with SMTP id
 98e67ed59e1d1-36c2eb88bd7mr5216339a91.0.1780200714534; Sat, 30 May 2026
 21:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260530211248.375318-1-richard.henderson@linaro.org>
 <20260530211248.375318-3-richard.henderson@linaro.org>
In-Reply-To: <20260530211248.375318-3-richard.henderson@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 30 May 2026 22:11:43 -0600
X-Gm-Features: AVHnY4Lsp-WnZq9U5_HQvBSvEnnmkVNSrkZ1kaZd3H2wOeMJgrpkeyStyZQsMqg
Message-ID: <CANCZdfrsov9RFOwc+UN7_cuPBFkKB8io6YrWpsPMM_VacpbPHw@mail.gmail.com>
Subject: Re: [PATCH 02/13] linux-user: Use PGBRange in load_elf_image
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Content-Type: multipart/alternative; boundary="000000000000380f9806531547b8"
Received-SPF: none client-ip=2607:f8b0:4864:20::1029;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1029.google.com
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

--000000000000380f9806531547b8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 3:12=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> Collect into range instead of loaddr+hiaddr.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>


> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index e1e1ee4674..fb774adf25 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1278,7 +1278,8 @@ static void load_elf_image(const char *image_name,
> const ImageSource *src,
>                             char **pinterp_name)
>  {
>      g_autofree struct elf_phdr *phdr =3D NULL;
> -    abi_ulong load_addr, load_bias, loaddr, hiaddr, error, align;
> +    PGBRange range =3D { -1, 0 };
> +    abi_ulong load_addr, load_bias, error, align;
>      size_t reserve_size, align_size;
>      int i, prot_exec;
>      Error *err =3D NULL;
> @@ -1318,19 +1319,18 @@ static void load_elf_image(const char *image_name=
,
> const ImageSource *src,
>       * Find the maximum size of the image and allocate an appropriate
>       * amount of memory to handle that.  Locate the interpreter, if any.
>       */
> -    loaddr =3D -1, hiaddr =3D 0;
>      align =3D 0;
>      info->exec_stack =3D EXSTACK_DEFAULT;
>      for (i =3D 0; i < ehdr->e_phnum; ++i) {
>          struct elf_phdr *eppnt =3D phdr + i;
>          if (eppnt->p_type =3D=3D PT_LOAD) {
>              abi_ulong a =3D eppnt->p_vaddr & TARGET_PAGE_MASK;
> -            if (a < loaddr) {
> -                loaddr =3D a;
> +            if (a < range.lo) {
> +                range.lo =3D a;
>              }
>              a =3D eppnt->p_vaddr + eppnt->p_memsz - 1;
> -            if (a > hiaddr) {
> -                hiaddr =3D a;
> +            if (a > range.hi) {
> +                range.hi =3D a;
>              }
>              ++info->nsegs;
>              align |=3D eppnt->p_align;
> @@ -1361,7 +1361,7 @@ static void load_elf_image(const char *image_name,
> const ImageSource *src,
>          }
>      }
>
> -    load_addr =3D loaddr;
> +    load_addr =3D range.lo;
>
>      align =3D pow2ceil(align);
>
> @@ -1371,13 +1371,13 @@ static void load_elf_image(const char *image_name=
,
> const ImageSource *src,
>               * Make sure that the low address does not conflict with
>               * MMAP_MIN_ADDR or the QEMU application itself.
>               */
> -            probe_guest_base(image_name, loaddr, hiaddr);
> +            probe_guest_base(image_name, range.lo, range.hi);
>          } else {
>              /*
>               * The binary is dynamic, but we still need to
>               * select guest_base.  In this case we pass a size.
>               */
> -            probe_guest_base(image_name, 0, hiaddr - loaddr);
> +            probe_guest_base(image_name, 0, range.hi - range.lo);
>
>              /*
>               * Avoid collision with the loader by providing a different
> @@ -1414,7 +1414,7 @@ static void load_elf_image(const char *image_name,
> const ImageSource *src,
>       * In both cases, we will overwrite pages in this range with mapping=
s
>       * from the executable.
>       */
> -    reserve_size =3D (size_t)hiaddr - loaddr + 1;
> +    reserve_size =3D range.hi - range.lo + 1;
>      align_size =3D reserve_size;
>
>      if (ehdr->e_type !=3D ET_EXEC && align > qemu_real_host_page_size())=
 {
> @@ -1443,7 +1443,7 @@ static void load_elf_image(const char *image_name,
> const ImageSource *src,
>          load_addr =3D align_addr;
>      }
>
> -    load_bias =3D load_addr - loaddr;
> +    load_bias =3D load_addr - range.lo;
>
>      if (elf_is_fdpic(ehdr)) {
>          struct elf32_fdpic_loadseg *loadsegs =3D info->loadsegs =3D
> @@ -1474,7 +1474,7 @@ static void load_elf_image(const char *image_name,
> const ImageSource *src,
>      info->start_data =3D -1;
>      info->end_data =3D 0;
>      /* Usual start for brk is after all sections of the main executable.
> */
> -    info->brk =3D TARGET_PAGE_ALIGN(hiaddr + load_bias);
> +    info->brk =3D TARGET_PAGE_ALIGN(range.hi + load_bias);
>      info->elf_flags =3D ehdr->e_flags;
>  #ifdef TARGET_MIPS
>      info->use_k0_tls =3D (ehdr->e_flags & EF_MIPS_MACH) =3D=3D
> EF_MIPS_MACH_OCTEON;
> --
> 2.43.0
>
>

--000000000000380f9806531547b8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, May 30,=
 2026 at 3:12=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.he=
nderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Collect into range instead =
of loaddr+hiaddr.<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0linux-user/elfload.c | 24 ++++++++++++------------<br>
=C2=A01 file changed, 12 insertions(+), 12 deletions(-)<br></blockquote><di=
v><br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.=
com">imp@bsdimp.com</a>&gt;</div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
diff --git a/linux-user/elfload.c b/linux-user/elfload.c<br>
index e1e1ee4674..fb774adf25 100644<br>
--- a/linux-user/elfload.c<br>
+++ b/linux-user/elfload.c<br>
@@ -1278,7 +1278,8 @@ static void load_elf_image(const char *image_name, co=
nst ImageSource *src,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 char **pinterp_name)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0g_autofree struct elf_phdr *phdr =3D NULL;<br>
-=C2=A0 =C2=A0 abi_ulong load_addr, load_bias, loaddr, hiaddr, error, align=
;<br>
+=C2=A0 =C2=A0 PGBRange range =3D { -1, 0 };<br>
+=C2=A0 =C2=A0 abi_ulong load_addr, load_bias, error, align;<br>
=C2=A0 =C2=A0 =C2=A0size_t reserve_size, align_size;<br>
=C2=A0 =C2=A0 =C2=A0int i, prot_exec;<br>
=C2=A0 =C2=A0 =C2=A0Error *err =3D NULL;<br>
@@ -1318,19 +1319,18 @@ static void load_elf_image(const char *image_name, =
const ImageSource *src,<br>
=C2=A0 =C2=A0 =C2=A0 * Find the maximum size of the image and allocate an a=
ppropriate<br>
=C2=A0 =C2=A0 =C2=A0 * amount of memory to handle that.=C2=A0 Locate the in=
terpreter, if any.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 loaddr =3D -1, hiaddr =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0align =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0info-&gt;exec_stack =3D EXSTACK_DEFAULT;<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; ehdr-&gt;e_phnum; ++i) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct elf_phdr *eppnt =3D phdr + i;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (eppnt-&gt;p_type =3D=3D PT_LOAD) {<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0abi_ulong a =3D eppnt-&gt;p=
_vaddr &amp; TARGET_PAGE_MASK;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (a &lt; loaddr) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 loaddr =3D a;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (a &lt; range.lo) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 range.lo =3D a;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a =3D eppnt-&gt;p_vaddr + e=
ppnt-&gt;p_memsz - 1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (a &gt; hiaddr) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hiaddr =3D a;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (a &gt; range.hi) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 range.hi =3D a;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0++info-&gt;nsegs;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0align |=3D eppnt-&gt;p_alig=
n;<br>
@@ -1361,7 +1361,7 @@ static void load_elf_image(const char *image_name, co=
nst ImageSource *src,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 load_addr =3D loaddr;<br>
+=C2=A0 =C2=A0 load_addr =3D range.lo;<br>
<br>
=C2=A0 =C2=A0 =C2=A0align =3D pow2ceil(align);<br>
<br>
@@ -1371,13 +1371,13 @@ static void load_elf_image(const char *image_name, =
const ImageSource *src,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Make sure that the low a=
ddress does not conflict with<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * MMAP_MIN_ADDR or the QEM=
U application itself.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 probe_guest_base(image_name, loa=
ddr, hiaddr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 probe_guest_base(image_name, ran=
ge.lo, range.hi);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The binary is dynamic, b=
ut we still need to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * select guest_base.=C2=A0=
 In this case we pass a size.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 probe_guest_base(image_name, 0, =
hiaddr - loaddr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 probe_guest_base(image_name, 0, =
range.hi - range.lo);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Avoid collision with the=
 loader by providing a different<br>
@@ -1414,7 +1414,7 @@ static void load_elf_image(const char *image_name, co=
nst ImageSource *src,<br>
=C2=A0 =C2=A0 =C2=A0 * In both cases, we will overwrite pages in this range=
 with mappings<br>
=C2=A0 =C2=A0 =C2=A0 * from the executable.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 reserve_size =3D (size_t)hiaddr - loaddr + 1;<br>
+=C2=A0 =C2=A0 reserve_size =3D range.hi - range.lo + 1;<br>
=C2=A0 =C2=A0 =C2=A0align_size =3D reserve_size;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (ehdr-&gt;e_type !=3D ET_EXEC &amp;&amp; align &gt; =
qemu_real_host_page_size()) {<br>
@@ -1443,7 +1443,7 @@ static void load_elf_image(const char *image_name, co=
nst ImageSource *src,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0load_addr =3D align_addr;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 load_bias =3D load_addr - loaddr;<br>
+=C2=A0 =C2=A0 load_bias =3D load_addr - range.lo;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (elf_is_fdpic(ehdr)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct elf32_fdpic_loadseg *loadsegs =3D =
info-&gt;loadsegs =3D<br>
@@ -1474,7 +1474,7 @@ static void load_elf_image(const char *image_name, co=
nst ImageSource *src,<br>
=C2=A0 =C2=A0 =C2=A0info-&gt;start_data =3D -1;<br>
=C2=A0 =C2=A0 =C2=A0info-&gt;end_data =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0/* Usual start for brk is after all sections of the mai=
n executable. */<br>
-=C2=A0 =C2=A0 info-&gt;brk =3D TARGET_PAGE_ALIGN(hiaddr + load_bias);<br>
+=C2=A0 =C2=A0 info-&gt;brk =3D TARGET_PAGE_ALIGN(range.hi + load_bias);<br=
>
=C2=A0 =C2=A0 =C2=A0info-&gt;elf_flags =3D ehdr-&gt;e_flags;<br>
=C2=A0#ifdef TARGET_MIPS<br>
=C2=A0 =C2=A0 =C2=A0info-&gt;use_k0_tls =3D (ehdr-&gt;e_flags &amp; EF_MIPS=
_MACH) =3D=3D EF_MIPS_MACH_OCTEON;<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--000000000000380f9806531547b8--

