Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFCDCD5BD1
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 04:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTXeW-00005F-Lj; Sun, 31 May 2026 00:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTXeU-0008WS-BO
 for qemu-devel@nongnu.org; Sun, 31 May 2026 00:19:54 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTXeR-0001HJ-LE
 for qemu-devel@nongnu.org; Sun, 31 May 2026 00:19:54 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2bf125989f2so18832955ad.3
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 21:19:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780201190; cv=none;
 d=google.com; s=arc-20240605;
 b=hS4PI3PjuT+C0p4YYcj8fg2msuRw3I4qHPkbeiFxrdIY6OZ+XCILhOdz6BGxkVNA6L
 o9afDOFJe3TAc7Q/4D3dBT4RfV4Femz8Npwq9TVNV/Qs2b2lipgF0XEWnkvKHIcfh6Gp
 1CH0j0JrM1MZQPJJ5WIzt58BxsgKBRtPBl9B1y2GWkoyl5nG/fS8pFK6UFdZZfc+L98B
 xEVWJ2YxMxj9jFyZBhpsO/fHbncVBPVaIuubbnr6EHrcdptsVlJl03whFMepPWXeLKS+
 Nwy8V4u6uN03N3YycU7Ov9P+abx4I/nI4fa0UWamup587U+u8zW1Ph+jIMqUuep0UxD6
 ZMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DCm+AnkEleNIh5wLp0+9XHWNp8aGj1wZuW3gZigvhMY=;
 fh=+DxRVnEC95Ptxk5HMfIFqaUwIao1HhLaAPFCgZPm1R4=;
 b=G7//XO8X3EzEj/eEzpHNzkXl9mBUhu4n1K0MxGXI7Yq75WMVO2v49QvDbG+kRP+xhI
 eY20FsIzFlSlFMYxt4HJYFLs+CI8rji5iCc0iEVev55igula9LMIGM5xQLP0YSCPLhGP
 dAiuRokmsBsfeu5uM1hUS6M+iSIIi9KHfhDdBIX3IKmW5RNIcTreVWJ5F+ZisBi44vlO
 L/19yAPVuAH/lYQOyqEBO10uBizIyzYAh8d1s7QNCNv+Vy5vovrwS1cXOVYheXS/WnrN
 f1ilXlwb2ugZppm1ng4vmVoBK908qbvVYHax7JKjhq7aOODyDTeNdOrbJ+1/fd/dvsq9
 6OlA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1780201190; x=1780805990;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DCm+AnkEleNIh5wLp0+9XHWNp8aGj1wZuW3gZigvhMY=;
 b=Vd8AiETTuFS7SPsQRk4dnRZkUQEccKHODlUeDujnBAP2IsElZcLp8Mkx05S+hf+LXk
 XOJwWqQ8FJU9K0bY/nzZhNshJ5zSziKx+DOyn5uojk2qG/p9XA6o/mPhsLdOh2TOkmy3
 bxbQK9tITjh2DXM7nQC4yHfoqRQlmydvg2tKZcbW/u4zDiwh9uxF6G4Se+ONzy0wMSm1
 wgbRAeIvu4cYt7CuVIv0YFMrAh90HbjC6yL9zNpt6MPpMvAUaTYKphOB2v3XDrQxM1x+
 QcytENo1GYGsfgud8PVCajUU1TkR9hdz2gKMYlCoLX/j5vbSj6ufMp/loAIOOYbSzNJK
 +4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780201190; x=1780805990;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DCm+AnkEleNIh5wLp0+9XHWNp8aGj1wZuW3gZigvhMY=;
 b=l9/u3gct1gwgLuWPPBC0Zn+sgPgLnaL1h00YpSA8P1JEXAGYVr4iqBLeyQUUMQkZ37
 vvATgatTwD6BSPqL4RZyZuFnHfJLO/+ronPv4d9TPJf7fGlyEKa2Vt/dmgB+maj3UfE4
 K/y2ZWU5NC4B5sitVxOG6g2nvosromswUBRKBh9V8cmNu7OnknZF8V+ddrHXTKYqrLNz
 jeA9cG0AHlOK6Y/sqBJAVLN6vkjKAn57WqBR6m2WzetXG2nQrceZ4EFmXzXdEu4G+MRk
 mGUSGFB2IUBQN3qTRgpZRyKx6Eyk/yx46FjDl0UEYfns2o0OtN5uZUyq7noijggqx/mC
 lLzw==
X-Gm-Message-State: AOJu0YymN31ZpecvjOytPQ2ERVhohauYE63IjE8WPaEyb9O4oux4HWZU
 6xTXvHybX2TT5ssbyJ63jOilOoEg/wXrmXBfBI12SqIFMGc98EmuUjkXrFkq20yudyPYtdQQusH
 q0IM+zfWPGJ56CbCS2VVab/mEDkM1VFqPIPFpOeJqAg==
X-Gm-Gg: Acq92OFEkTwwD3hmolFAYR1j0MEARBBWlMfoFAc5Yf747x/otI747a1fjoneTCjEStp
 y6iROHIfRCSURiCXRz0ZZjwjAyFzZ0n24CyP/2Q8ty6EOfzr78JGRS4niNJp7F/cKXPljaUxcY6
 8Z/qo/Xwd3ilHyGQtbg+FkU1jM7bNsqgBuzNNJptBUOMORmaeKaVAmURBLfl67L81U2h/se1Zzi
 mfZQQ1YK2Q0Xhuh9/KeLdHWC56k5SdaoCH3QAKC7rVdM0JPC3gKWGeRg8CTXhnrdrcUQ5K/SiyI
 kpD/j6nUNAFd2CHGTRUzhvCFKEHaXbp7+0/n8c99PsFuj4qlkxfjD/wGSg==
X-Received: by 2002:a17:903:2405:b0:2ba:6ffa:bded with SMTP id
 d9443c01a7336-2bf3688d16emr69076855ad.37.1780201190062; Sat, 30 May 2026
 21:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260530211248.375318-1-richard.henderson@linaro.org>
 <20260530211248.375318-6-richard.henderson@linaro.org>
In-Reply-To: <20260530211248.375318-6-richard.henderson@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 30 May 2026 22:19:38 -0600
X-Gm-Features: AVHnY4IHKVn3Ez7JkM9QYQpuLddBRd-qo0oxL2CO1LijErr5bsZXcpO8WH5MMr8
Message-ID: <CANCZdfoWMi3JFMxhq9TGV_GcUy5fQ+f3RgzQrdcyG7gSJr3_tQ@mail.gmail.com>
Subject: Re: [PATCH 05/13] linux-user: Use PGBRange for commpage
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Content-Type: multipart/alternative; boundary="000000000000900cac06531563c3"
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x631.google.com
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

--000000000000900cac06531563c3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 3:12=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> This simplifies check for no commpage to a NULL pointer
> check, rather than reserved values for LO_COMMPAGE and
> HI_COMMPAGE.
>
> Unify {LO,HI}_COMMPAGE into a single COMMPAGE define.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/arm/target_elf.h  |  2 +-
>  linux-user/hppa/target_elf.h |  2 +-
>  linux-user/arm/elfload.c     |  2 +-
>  linux-user/elfload.c         | 64 ++++++++++++++----------------------
>  linux-user/hppa/elfload.c    |  4 +--
>  5 files changed, 30 insertions(+), 44 deletions(-)
>

Acked-by: Warner Losh <imp@bsdimp.com>

(I think that's what I should do when it looks good, but I don't understand
COMMPAGE to know if everything is right or not)


> diff --git a/linux-user/arm/target_elf.h b/linux-user/arm/target_elf.h
> index 12cdc8e5a7..531b486bf9 100644
> --- a/linux-user/arm/target_elf.h
> +++ b/linux-user/arm/target_elf.h
> @@ -20,7 +20,7 @@
>  #define HAVE_ELF_CORE_DUMP      1
>  #define HAVE_VDSO_IMAGE_INFO    1
>
> -#define HI_COMMPAGE             ((intptr_t)0xffff0f00u)
> +#define COMMPAGE                ((intptr_t)0xffff0f00u)
>
>  /*
>   * See linux kernel: arch/arm/include/asm/elf.h, where
> diff --git a/linux-user/hppa/target_elf.h b/linux-user/hppa/target_elf.h
> index e1c5033242..22547b1437 100644
> --- a/linux-user/hppa/target_elf.h
> +++ b/linux-user/hppa/target_elf.h
> @@ -34,7 +34,7 @@ typedef struct target_elf_gregset_t {
>      abi_ulong pad[16];     /* pad to 80 elements                 [64..79=
]
> */
>  } target_elf_gregset_t;
>
> -#define LO_COMMPAGE             0
> +#define COMMPAGE                0
>  #define STACK_GROWS_DOWN        0
>  #define STACK_ALIGNMENT         64
>  #define VDSO_HEADER             "vdso.c.inc"
> diff --git a/linux-user/arm/elfload.c b/linux-user/arm/elfload.c
> index fef61022a3..3c2ccf289c 100644
> --- a/linux-user/arm/elfload.c
> +++ b/linux-user/arm/elfload.c
> @@ -219,7 +219,7 @@ bool init_guest_commpage(void)
>          return true;
>      }
>
> -    commpage =3D HI_COMMPAGE & -host_page_size;
> +    commpage =3D COMMPAGE & -host_page_size;
>      want =3D g2h_untagged(commpage);
>      addr =3D mmap(want, host_page_size, PROT_READ | PROT_WRITE,
>                  MAP_ANONYMOUS | MAP_PRIVATE |
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 10a826e658..5a30cebcc3 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -757,17 +757,9 @@ static abi_ulong create_elf_tables(abi_ulong p, int
> argc, int envc,
>      return sp;
>  }
>
> -#if defined(HI_COMMPAGE)
> -#define LO_COMMPAGE -1
> -#elif defined(LO_COMMPAGE)
> -#define HI_COMMPAGE 0
> -#else
> -#define HI_COMMPAGE 0
> -#define LO_COMMPAGE -1
> -#ifndef HAVE_GUEST_COMMPAGE
> +#if !defined(COMMPAGE) && !defined(HAVE_GUEST_COMMPAGE)
>  bool init_guest_commpage(void) { return true; }
>  #endif
> -#endif
>
>  /**
>   * pgb_try_mmap:
> @@ -853,7 +845,7 @@ static bool pgb_try_mmap_set(const PGBAddrs *ga,
> uintptr_t base, uintptr_t brk)
>   * Fill in @ga with the image, COMMPAGE and NULL page.
>   */
>  static bool pgb_addr_set(PGBAddrs *ga, const PGBRange *image_range,
> -                         bool try_identity)
> +                         const PGBRange *commpage_range, bool
> try_identity)
>  {
>      int n;
>
> @@ -862,7 +854,7 @@ static bool pgb_addr_set(PGBAddrs *ga, const PGBRange
> *image_range,
>       * we may not be able to use the identity map.
>       */
>      if (try_identity) {
> -        if (LO_COMMPAGE !=3D -1 && LO_COMMPAGE < mmap_min_addr) {
> +        if (commpage_range && commpage_range->lo < mmap_min_addr) {
>              return false;
>          }
>          if (image_range && image_range->lo < mmap_min_addr) {
> @@ -877,14 +869,10 @@ static bool pgb_addr_set(PGBAddrs *ga, const
> PGBRange *image_range,
>          ga->bounds[n].lo =3D try_identity ? mmap_min_addr : 0;
>          ga->bounds[n].hi =3D reserved_va;
>          n++;
> -        /* LO_COMMPAGE and NULL handled by reserving from 0. */
> +        /* Low COMMPAGE and NULL handled by reserving from 0. */
>      } else {
> -        /* Add any LO_COMMPAGE or NULL page. */
> -        if (LO_COMMPAGE !=3D -1) {
> -            ga->bounds[n].lo =3D 0;
> -            ga->bounds[n].hi =3D LO_COMMPAGE + TARGET_PAGE_SIZE - 1;
> -            n++;
> -        } else if (!try_identity) {
> +        /* Add any low COMMPAGE or NULL page. */
> +        if (!try_identity || (commpage_range && commpage_range->lo =3D=
=3D 0))
> {
>              ga->bounds[n].lo =3D 0;
>              ga->bounds[n].hi =3D TARGET_PAGE_SIZE - 1;
>              n++;
> @@ -896,23 +884,13 @@ static bool pgb_addr_set(PGBAddrs *ga, const
> PGBRange *image_range,
>          }
>      }
>
> -    /*
> -     * Temporarily disable
> -     *   "comparison is always false due to limited range of data type"
> -     * due to comparison between unsigned and (possible) 0.
> -     */
> -#pragma GCC diagnostic push
> -#pragma GCC diagnostic ignored "-Wtype-limits"
> -
> -    /* Add any HI_COMMPAGE not covered by reserved_va. */
> -    if (reserved_va < HI_COMMPAGE) {
> -        ga->bounds[n].lo =3D HI_COMMPAGE & qemu_real_host_page_mask();
> -        ga->bounds[n].hi =3D HI_COMMPAGE + TARGET_PAGE_SIZE - 1;
> +    /* Add any high COMMPAGE not covered by reserved_va. */
> +    if (commpage_range && reserved_va < commpage_range->hi) {
> +        ga->bounds[n].lo =3D commpage_range->lo &
> qemu_real_host_page_mask();
> +        ga->bounds[n].hi =3D commpage_range->hi;
>          n++;
>      }
>
> -#pragma GCC diagnostic pop
> -
>      ga->nbounds =3D n;
>      return true;
>  }
> @@ -926,7 +904,7 @@ static void pgb_fail_in_use(const char *image_name)
>  }
>
>  static void pgb_fixed(const char *image_name, const PGBRange *image_rang=
e,
> -                      uintptr_t align)
> +                      const PGBRange *commpage_range, uintptr_t align)
>  {
>      PGBAddrs ga;
>      uintptr_t brk =3D (uintptr_t)sbrk(0);
> @@ -938,7 +916,7 @@ static void pgb_fixed(const char *image_name, const
> PGBRange *image_range,
>          exit(EXIT_FAILURE);
>      }
>
> -    if (!pgb_addr_set(&ga, image_range, !guest_base)
> +    if (!pgb_addr_set(&ga, image_range, commpage_range, !guest_base)
>          || !pgb_try_mmap_set(&ga, guest_base, brk)) {
>          pgb_fail_in_use(image_name);
>      }
> @@ -1024,14 +1002,14 @@ static uintptr_t pgb_find_itree(const PGBAddrs
> *ga, IntervalTreeRoot *root,
>  }
>
>  static void pgb_dynamic(const char *image_name, const PGBRange
> *image_range,
> -                        uintptr_t align)
> +                        const PGBRange *commpage_range, uintptr_t align)
>  {
>      IntervalTreeRoot *root;
>      uintptr_t brk, ret;
>      PGBAddrs ga;
>
>      /* Try the identity map first. */
> -    if (pgb_addr_set(&ga, image_range, true)) {
> +    if (pgb_addr_set(&ga, image_range, commpage_range, true)) {
>          brk =3D (uintptr_t)sbrk(0);
>          if (pgb_try_mmap_set(&ga, 0, brk)) {
>              guest_base =3D 0;
> @@ -1043,7 +1021,7 @@ static void pgb_dynamic(const char *image_name,
> const PGBRange *image_range,
>       * Rebuild the address set for non-identity map.
>       * This differs in the mapping of the guest NULL page.
>       */
> -    pgb_addr_set(&ga, image_range, false);
> +    pgb_addr_set(&ga, image_range, commpage_range, false);
>
>      root =3D read_self_maps();
>
> @@ -1084,6 +1062,14 @@ static void pgb_dynamic(const char *image_name,
> const PGBRange *image_range,
>
>  void probe_guest_base(const char *image_name, const PGBRange *image_rang=
e)
>  {
> +#ifdef COMMPAGE
> +    const PGBRange * const commpage_range =3D &(PGBRange){
> +        COMMPAGE, COMMPAGE + TARGET_PAGE_SIZE - 1
> +    };
> +#else
> +    const PGBRange * const commpage_range =3D NULL;
> +#endif
> +
>      /* In order to use host shmat, we must be able to honor SHMLBA.  */
>      uintptr_t align =3D MAX(SHMLBA, TARGET_PAGE_SIZE);
>
> @@ -1096,9 +1082,9 @@ void probe_guest_base(const char *image_name, const
> PGBRange *image_range)
>      }
>
>      if (have_guest_base) {
> -        pgb_fixed(image_name, image_range, align);
> +        pgb_fixed(image_name, image_range, commpage_range, align);
>      } else {
> -        pgb_dynamic(image_name, image_range, align);
> +        pgb_dynamic(image_name, image_range, commpage_range, align);
>      }
>
>      /* Reserve and initialize the commpage. */
> diff --git a/linux-user/hppa/elfload.c b/linux-user/hppa/elfload.c
> index 3354e1b840..3bfe93ada8 100644
> --- a/linux-user/hppa/elfload.c
> +++ b/linux-user/hppa/elfload.c
> @@ -35,7 +35,7 @@ bool init_guest_commpage(void)
>      if (!reserved_va) {
>          void *want, *addr;
>
> -        want =3D g2h_untagged(LO_COMMPAGE);
> +        want =3D g2h_untagged(COMMPAGE);
>          addr =3D mmap(want, TARGET_PAGE_SIZE, PROT_NONE,
>                      MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED_NOREPLACE,
> -1, 0);
>          if (addr =3D=3D MAP_FAILED) {
> @@ -54,7 +54,7 @@ bool init_guest_commpage(void)
>       * and implement syscalls.  Here, simply mark the page executable.
>       * Special case the entry points during translation (see
> do_page_zero).
>       */
> -    page_set_flags(LO_COMMPAGE, LO_COMMPAGE | ~TARGET_PAGE_MASK,
> +    page_set_flags(COMMPAGE, COMMPAGE | ~TARGET_PAGE_MASK,
>                     PAGE_EXEC | PAGE_VALID, PAGE_VALID);
>      return true;
>  }
> --
> 2.43.0
>
>

--000000000000900cac06531563c3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, May 30,=
 2026 at 3:12=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.he=
nderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">This simplifies check for n=
o commpage to a NULL pointer<br>
check, rather than reserved values for LO_COMMPAGE and<br>
HI_COMMPAGE.<br>
<br>
Unify {LO,HI}_COMMPAGE into a single COMMPAGE define.<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0linux-user/arm/target_elf.h=C2=A0 |=C2=A0 2 +-<br>
=C2=A0linux-user/hppa/target_elf.h |=C2=A0 2 +-<br>
=C2=A0linux-user/arm/elfload.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0linux-user/elfload.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 64 ++++++++++=
++++----------------------<br>
=C2=A0linux-user/hppa/elfload.c=C2=A0 =C2=A0 |=C2=A0 4 +--<br>
=C2=A05 files changed, 30 insertions(+), 44 deletions(-)<br></blockquote><d=
iv><br></div><div>Acked-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.co=
m">imp@bsdimp.com</a>&gt;</div><div><br></div><div>(I think that&#39;s what=
 I should do when it looks good, but I don&#39;t understand COMMPAGE to kno=
w if everything is right or not)</div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
diff --git a/linux-user/arm/target_elf.h b/linux-user/arm/target_elf.h<br>
index 12cdc8e5a7..531b486bf9 100644<br>
--- a/linux-user/arm/target_elf.h<br>
+++ b/linux-user/arm/target_elf.h<br>
@@ -20,7 +20,7 @@<br>
=C2=A0#define HAVE_ELF_CORE_DUMP=C2=A0 =C2=A0 =C2=A0 1<br>
=C2=A0#define HAVE_VDSO_IMAGE_INFO=C2=A0 =C2=A0 1<br>
<br>
-#define HI_COMMPAGE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((intpt=
r_t)0xffff0f00u)<br>
+#define COMMPAGE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((=
intptr_t)0xffff0f00u)<br>
<br>
=C2=A0/*<br>
=C2=A0 * See linux kernel: arch/arm/include/asm/elf.h, where<br>
diff --git a/linux-user/hppa/target_elf.h b/linux-user/hppa/target_elf.h<br=
>
index e1c5033242..22547b1437 100644<br>
--- a/linux-user/hppa/target_elf.h<br>
+++ b/linux-user/hppa/target_elf.h<br>
@@ -34,7 +34,7 @@ typedef struct target_elf_gregset_t {<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong pad[16];=C2=A0 =C2=A0 =C2=A0/* pad to 80 elem=
ents=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[64..79] =
*/<br>
=C2=A0} target_elf_gregset_t;<br>
<br>
-#define LO_COMMPAGE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
+#define COMMPAGE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<=
br>
=C2=A0#define STACK_GROWS_DOWN=C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
=C2=A0#define STACK_ALIGNMENT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A064<br>
=C2=A0#define VDSO_HEADER=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&q=
uot;vdso.c.inc&quot;<br>
diff --git a/linux-user/arm/elfload.c b/linux-user/arm/elfload.c<br>
index fef61022a3..3c2ccf289c 100644<br>
--- a/linux-user/arm/elfload.c<br>
+++ b/linux-user/arm/elfload.c<br>
@@ -219,7 +219,7 @@ bool init_guest_commpage(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 commpage =3D HI_COMMPAGE &amp; -host_page_size;<br>
+=C2=A0 =C2=A0 commpage =3D COMMPAGE &amp; -host_page_size;<br>
=C2=A0 =C2=A0 =C2=A0want =3D g2h_untagged(commpage);<br>
=C2=A0 =C2=A0 =C2=A0addr =3D mmap(want, host_page_size, PROT_READ | PROT_WR=
ITE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MAP_ANONYMOUS=
 | MAP_PRIVATE |<br>
diff --git a/linux-user/elfload.c b/linux-user/elfload.c<br>
index 10a826e658..5a30cebcc3 100644<br>
--- a/linux-user/elfload.c<br>
+++ b/linux-user/elfload.c<br>
@@ -757,17 +757,9 @@ static abi_ulong create_elf_tables(abi_ulong p, int ar=
gc, int envc,<br>
=C2=A0 =C2=A0 =C2=A0return sp;<br>
=C2=A0}<br>
<br>
-#if defined(HI_COMMPAGE)<br>
-#define LO_COMMPAGE -1<br>
-#elif defined(LO_COMMPAGE)<br>
-#define HI_COMMPAGE 0<br>
-#else<br>
-#define HI_COMMPAGE 0<br>
-#define LO_COMMPAGE -1<br>
-#ifndef HAVE_GUEST_COMMPAGE<br>
+#if !defined(COMMPAGE) &amp;&amp; !defined(HAVE_GUEST_COMMPAGE)<br>
=C2=A0bool init_guest_commpage(void) { return true; }<br>
=C2=A0#endif<br>
-#endif<br>
<br>
=C2=A0/**<br>
=C2=A0 * pgb_try_mmap:<br>
@@ -853,7 +845,7 @@ static bool pgb_try_mmap_set(const PGBAddrs *ga, uintpt=
r_t base, uintptr_t brk)<br>
=C2=A0 * Fill in @ga with the image, COMMPAGE and NULL page.<br>
=C2=A0 */<br>
=C2=A0static bool pgb_addr_set(PGBAddrs *ga, const PGBRange *image_range,<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0bool try_identity)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0const PGBRange *commpage_range, bool try_identity)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int n;<br>
<br>
@@ -862,7 +854,7 @@ static bool pgb_addr_set(PGBAddrs *ga, const PGBRange *=
image_range,<br>
=C2=A0 =C2=A0 =C2=A0 * we may not be able to use the identity map.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0if (try_identity) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (LO_COMMPAGE !=3D -1 &amp;&amp; LO_COMMPAGE=
 &lt; mmap_min_addr) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (commpage_range &amp;&amp; commpage_range-&=
gt;lo &lt; mmap_min_addr) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (image_range &amp;&amp; image_range-&g=
t;lo &lt; mmap_min_addr) {<br>
@@ -877,14 +869,10 @@ static bool pgb_addr_set(PGBAddrs *ga, const PGBRange=
 *image_range,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ga-&gt;bounds[n].lo =3D try_identity ? mm=
ap_min_addr : 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ga-&gt;bounds[n].hi =3D reserved_va;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* LO_COMMPAGE and NULL handled by reserving f=
rom 0. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Low COMMPAGE and NULL handled by reserving =
from 0. */<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add any LO_COMMPAGE or NULL page. */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (LO_COMMPAGE !=3D -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n].lo =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n].hi =3D LO_COMMP=
AGE + TARGET_PAGE_SIZE - 1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (!try_identity) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add any low COMMPAGE or NULL page. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!try_identity || (commpage_range &amp;&amp=
; commpage_range-&gt;lo =3D=3D 0)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ga-&gt;bounds[n].lo =3D 0;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ga-&gt;bounds[n].hi =3D TAR=
GET_PAGE_SIZE - 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n++;<br>
@@ -896,23 +884,13 @@ static bool pgb_addr_set(PGBAddrs *ga, const PGBRange=
 *image_range,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0* Temporarily disable<br>
-=C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0&quot;comparison is always false due to =
limited range of data type&quot;<br>
-=C2=A0 =C2=A0 =C2=A0* due to comparison between unsigned and (possible) 0.=
<br>
-=C2=A0 =C2=A0 =C2=A0*/<br>
-#pragma GCC diagnostic push<br>
-#pragma GCC diagnostic ignored &quot;-Wtype-limits&quot;<br>
-<br>
-=C2=A0 =C2=A0 /* Add any HI_COMMPAGE not covered by reserved_va. */<br>
-=C2=A0 =C2=A0 if (reserved_va &lt; HI_COMMPAGE) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n].lo =3D HI_COMMPAGE &amp; qemu=
_real_host_page_mask();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n].hi =3D HI_COMMPAGE + TARGET_P=
AGE_SIZE - 1;<br>
+=C2=A0 =C2=A0 /* Add any high COMMPAGE not covered by reserved_va. */<br>
+=C2=A0 =C2=A0 if (commpage_range &amp;&amp; reserved_va &lt; commpage_rang=
e-&gt;hi) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n].lo =3D commpage_range-&gt;lo =
&amp; qemu_real_host_page_mask();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n].hi =3D commpage_range-&gt;hi;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n++;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-#pragma GCC diagnostic pop<br>
-<br>
=C2=A0 =C2=A0 =C2=A0ga-&gt;nbounds =3D n;<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
@@ -926,7 +904,7 @@ static void pgb_fail_in_use(const char *image_name)<br>
=C2=A0}<br>
<br>
=C2=A0static void pgb_fixed(const char *image_name, const PGBRange *image_r=
ange,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uintptr_t align)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 const PGBRange *commpage_range, uintptr_t align)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0PGBAddrs ga;<br>
=C2=A0 =C2=A0 =C2=A0uintptr_t brk =3D (uintptr_t)sbrk(0);<br>
@@ -938,7 +916,7 @@ static void pgb_fixed(const char *image_name, const PGB=
Range *image_range,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(EXIT_FAILURE);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (!pgb_addr_set(&amp;ga, image_range, !guest_base)<br>
+=C2=A0 =C2=A0 if (!pgb_addr_set(&amp;ga, image_range, commpage_range, !gue=
st_base)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|| !pgb_try_mmap_set(&amp;ga, guest_base,=
 brk)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pgb_fail_in_use(image_name);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -1024,14 +1002,14 @@ static uintptr_t pgb_find_itree(const PGBAddrs *ga,=
 IntervalTreeRoot *root,<br>
=C2=A0}<br>
<br>
=C2=A0static void pgb_dynamic(const char *image_name, const PGBRange *image=
_range,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 uintptr_t align)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 const PGBRange *commpage_range, uintptr_t align)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0IntervalTreeRoot *root;<br>
=C2=A0 =C2=A0 =C2=A0uintptr_t brk, ret;<br>
=C2=A0 =C2=A0 =C2=A0PGBAddrs ga;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Try the identity map first. */<br>
-=C2=A0 =C2=A0 if (pgb_addr_set(&amp;ga, image_range, true)) {<br>
+=C2=A0 =C2=A0 if (pgb_addr_set(&amp;ga, image_range, commpage_range, true)=
) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0brk =3D (uintptr_t)sbrk(0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pgb_try_mmap_set(&amp;ga, 0, brk)) {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0guest_base =3D 0;<br>
@@ -1043,7 +1021,7 @@ static void pgb_dynamic(const char *image_name, const=
 PGBRange *image_range,<br>
=C2=A0 =C2=A0 =C2=A0 * Rebuild the address set for non-identity map.<br>
=C2=A0 =C2=A0 =C2=A0 * This differs in the mapping of the guest NULL page.<=
br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 pgb_addr_set(&amp;ga, image_range, false);<br>
+=C2=A0 =C2=A0 pgb_addr_set(&amp;ga, image_range, commpage_range, false);<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0root =3D read_self_maps();<br>
<br>
@@ -1084,6 +1062,14 @@ static void pgb_dynamic(const char *image_name, cons=
t PGBRange *image_range,<br>
<br>
=C2=A0void probe_guest_base(const char *image_name, const PGBRange *image_r=
ange)<br>
=C2=A0{<br>
+#ifdef COMMPAGE<br>
+=C2=A0 =C2=A0 const PGBRange * const commpage_range =3D &amp;(PGBRange){<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 COMMPAGE, COMMPAGE + TARGET_PAGE_SIZE - 1<br>
+=C2=A0 =C2=A0 };<br>
+#else<br>
+=C2=A0 =C2=A0 const PGBRange * const commpage_range =3D NULL;<br>
+#endif<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/* In order to use host shmat, we must be able to honor=
 SHMLBA.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0uintptr_t align =3D MAX(SHMLBA, TARGET_PAGE_SIZE);<br>
<br>
@@ -1096,9 +1082,9 @@ void probe_guest_base(const char *image_name, const P=
GBRange *image_range)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (have_guest_base) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pgb_fixed(image_name, image_range, align);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pgb_fixed(image_name, image_range, commpage_ra=
nge, align);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pgb_dynamic(image_name, image_range, align);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pgb_dynamic(image_name, image_range, commpage_=
range, align);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Reserve and initialize the commpage. */<br>
diff --git a/linux-user/hppa/elfload.c b/linux-user/hppa/elfload.c<br>
index 3354e1b840..3bfe93ada8 100644<br>
--- a/linux-user/hppa/elfload.c<br>
+++ b/linux-user/hppa/elfload.c<br>
@@ -35,7 +35,7 @@ bool init_guest_commpage(void)<br>
=C2=A0 =C2=A0 =C2=A0if (!reserved_va) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *want, *addr;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 want =3D g2h_untagged(LO_COMMPAGE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 want =3D g2h_untagged(COMMPAGE);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr =3D mmap(want, TARGET_PAGE_SIZE, PRO=
T_NONE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED_NOREPLACE, -1, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (addr =3D=3D MAP_FAILED) {<br>
@@ -54,7 +54,7 @@ bool init_guest_commpage(void)<br>
=C2=A0 =C2=A0 =C2=A0 * and implement syscalls.=C2=A0 Here, simply mark the =
page executable.<br>
=C2=A0 =C2=A0 =C2=A0 * Special case the entry points during translation (se=
e do_page_zero).<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 page_set_flags(LO_COMMPAGE, LO_COMMPAGE | ~TARGET_PAGE_MASK,=
<br>
+=C2=A0 =C2=A0 page_set_flags(COMMPAGE, COMMPAGE | ~TARGET_PAGE_MASK,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PAGE_=
EXEC | PAGE_VALID, PAGE_VALID);<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--000000000000900cac06531563c3--

