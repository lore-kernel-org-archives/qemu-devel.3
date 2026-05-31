Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC5DCD6E51
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 04:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTXcW-00080U-0z; Sun, 31 May 2026 00:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTXcT-0007zi-Vt
 for qemu-devel@nongnu.org; Sun, 31 May 2026 00:17:50 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTXcR-0000aN-1l
 for qemu-devel@nongnu.org; Sun, 31 May 2026 00:17:49 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2c0c32f6ce1so1985145ad.2
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 21:17:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780201065; cv=none;
 d=google.com; s=arc-20240605;
 b=YwI3ex1uASTKSbIokbW4YF1xv87oMKwG52eVdFMGNqUt6cBoEoX3gxyyXAKtlfGzwg
 6Fm4fIrva+uf2P3vp+fqYTrGzmpTv/RaYIq6coljol7VRVK6CUV+0ovZKBHTk3Oupg65
 EuwsGuTZY+4aYpx9aSyowBnEKNlqrqGJVC6N0w47QFMDD61YOaKHogauR6bTY5Cj0bsV
 Hj298UpcUdmb05AarbFzBQbnmmgyRASz9h0VhswmqoT6JzRekGAFUQX7GXPwyohJsg/y
 OWjRQLjbviFyxcSD8pn6bH93X5r+BVSnwOtPSwqOZVFeFQTC8gdepjcJXtgmmFR1wcSL
 ak1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cXqsTprgXObfcLxjOmUbl2f1nulsHOqed3SRRmQDuHI=;
 fh=+DxRVnEC95Ptxk5HMfIFqaUwIao1HhLaAPFCgZPm1R4=;
 b=I3PFjRRcHf6wfvfpb3Y099J3xsF6ErmToSuDD3aH4RP+97W/deaR5AJLR8z0vV+Cuk
 vfjXG2APe9sm5n4/GtrQPCqiYI5Tahw25e2nL6GY2Un2MIxsfmtdriVCMbNkpyituGJt
 5BtysGXodRqXutdPi5JZFnY3pymUeum3UIkRJj72ar4uH/pYM93wuWKjzTR5sHlGLmWa
 /nFJwCFtlyzxYScfK7W/j0K3K1J+3noZKceelRZO6iBiOk6nH/lBIWWz9kIH5aBFAf+y
 RlNNzdlTaPYnbXpXE8LQCbJnPv/jmVWISwHg38oZxSqZj68wyti/+bNUhi3V+I1AVw+u
 dLCQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1780201065; x=1780805865;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cXqsTprgXObfcLxjOmUbl2f1nulsHOqed3SRRmQDuHI=;
 b=CaTpBbiC8lG7SfabXYEVfBTkHwCLKIci97quLfUDK9Cm0fRr+j9++KkaHULzNJTtnr
 WcNzjNq+VrIa2kQEv+zukApKCgCX5mnKIQnAWqEeDUCpahPVCN7dOlAA+SXHOsHZihvk
 y9oYi6jHbmu41sG2/KEPyfPh+bqnREebRg6BXZsYgKW4gXbAzS9MV4o5OGfW6YGpBhw2
 LUW02AB8eSJUu8OqXu+tFCyBhYiIX6p+JAkBbV4NOaRI5VhMHjiqs1h5iRkM5aFZu0J7
 SlbnF3ArvYawkxeRvXJxXi33RNWoFT2r/Jb2z6+azxpvnaoq8ckNAhZ312+Zm5sLvxdD
 Vnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780201065; x=1780805865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cXqsTprgXObfcLxjOmUbl2f1nulsHOqed3SRRmQDuHI=;
 b=sPHT1uhtnk8YbuMazHNbl5FFZIpjB8DYnvdqQoJIRIT7YFGGZbg9DLmoqFgZW1wd3D
 UUbhqfFWb9DGVKYfVLTqoDSdsLTTsdxwTanZXiQDO7s7MNVkzywXFk8JFTl2kNo8zqyI
 R9XQxHfvRnbUjjRKYJc9wHGeVrPLKbLxWG9D6+cB/SOUNUam01aKQAc/6Zer0/Wh/aY0
 e8e8bnMMeOIxW0uX4KOaNqj55k9njqKfDgZuSEGFeCYGdBVLSHMDm5XTP4nsanKQS4JY
 OIdzc7cOMpJyQ6rNhx7i5YYqktIgn/vVrAJ/KGGwkTS+QPq7eicRG6j4iRE4dxxG64EO
 g1rw==
X-Gm-Message-State: AOJu0YwTxFkEXsjq5MBZSjY3RLFPa0txWPXMPC59QHx1E8RJUJz28e6B
 ELTaC5A3F3puCtRiKEybrftz6+9d6vUDubd9EtL+xXGfD4nV1znhXNqd4tR/SLOBDPG5jIgZ5EW
 GX9ROllIsdmou4KhfEE8X+t8zve0XrdVQYXy1VgOdbqv7WOO3N7HR
X-Gm-Gg: Acq92OGTtpfd+XaPeyE+1nWG/2Dfvz3BMH/+XNB4RIFtf0eEni5iH/8qgL0Bn38BOP9
 KHURjvgIyfQL98Wh+bqp8uOf4Nav1D/JT5JOLR7g+36iAHGi1CjeWUyqtxkSQsDGz2DbmmAe1HR
 9grssYNBdT2QiA3sgAwSFxz0MljhuH7pp07uI5m6mGLEq7BsGvdMzBJI0B4QY4hWNFVO5JLzamm
 p234fkkhizgVYo64ScSO6r6b1DzX0a3X9YREPOvSO900Ja3unIdlfvrE10ANFKd0X9waEXVnn1+
 eQjno60/47O/zn8iXoKm8p+i+jqnHPeLC/ddN/SZisHJog8=
X-Received: by 2002:a17:903:3c46:b0:2bf:3309:ecd4 with SMTP id
 d9443c01a7336-2bf367cd979mr75076175ad.12.1780201065446; Sat, 30 May 2026
 21:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260530211248.375318-1-richard.henderson@linaro.org>
 <20260530211248.375318-5-richard.henderson@linaro.org>
In-Reply-To: <20260530211248.375318-5-richard.henderson@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 30 May 2026 22:17:34 -0600
X-Gm-Features: AVHnY4IeguzNYnnmcTClJMpmy7g_NRIDXzWxX8T3oqApeHZvMpmY7JR0PEYEKxE
Message-ID: <CANCZdfqb2o1a+q-cVta3JJUaHA0UnutBkx7Be53YZz0tkdJCEQ@mail.gmail.com>
Subject: Re: [PATCH 04/13] linux-user: Pass image_range to probe_guest_base
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Content-Type: multipart/alternative; boundary="000000000000228f200653155c63"
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

--000000000000228f200653155c63
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 3:12=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> Pass a PGBRange structure instead of separate guest_loaddr
> and guest_hiaddr parameters.  This allows NULL to indicate
> that the image is relocatable, so that image_range->lo =3D=3D 0
> is a valid fixed setting.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/1890
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/user-internals.h | 13 ++++-------
>  linux-user/elfload.c        | 46 +++++++++++++++++--------------------
>  linux-user/flatload.c       |  2 +-
>  3 files changed, 27 insertions(+), 34 deletions(-)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

I may have to look into a similar cleanup in bsd-user once the upstreaming
backlog is done.

Warner


> diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
> index 73b0109e9c..3f41d3f33c 100644
> --- a/linux-user/user-internals.h
> +++ b/linux-user/user-internals.h
> @@ -83,24 +83,21 @@ typedef struct PGBRange {
>  /**
>   * probe_guest_base:
>   * @image_name: the executable being loaded
> - * @loaddr: the lowest fixed address within the executable
> - * @hiaddr: the highest fixed address within the executable
> + * @image_range: the fixed addresses within the executable
>   *
>   * Creates the initial guest address space in the host memory space.
>   *
> - * If @loaddr =3D=3D 0, then no address in the executable is fixed, i.e.
> - * it is fully relocatable.  In that case @hiaddr is the size of the
> - * executable minus one.
> + * If @image_range is NULL, then no address in the executable is fixed,
> + * i.e. it is fully relocatable.
>   *
>   * This function will not return if a valid value for guest_base
>   * cannot be chosen.  On return, the executable loader can expect
>   *
> - *    target_mmap(loaddr, hiaddr - loaddr + 1, ...)
> + *    target_mmap(i->lo, i->hi - i->lo + 1, ...)
>   *
>   * to succeed.
>   */
> -void probe_guest_base(const char *image_name,
> -                      abi_ulong loaddr, abi_ulong hiaddr);
> +void probe_guest_base(const char *image_name, const PGBRange
> *image_range);
>
>  /* syscall.c */
>  int host_to_target_waitstatus(int status);
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 33565ad7be..10a826e658 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -847,14 +847,13 @@ static bool pgb_try_mmap_set(const PGBAddrs *ga,
> uintptr_t base, uintptr_t brk)
>  /**
>   * pgb_addr_set:
>   * @ga: output set of guest addrs
> - * @guest_loaddr: guest image low address
> - * @guest_loaddr: guest image high address
> + * @image_range: fixed guest image addresses
>   * @identity: create for identity mapping
>   *
>   * Fill in @ga with the image, COMMPAGE and NULL page.
>   */
> -static bool pgb_addr_set(PGBAddrs *ga, abi_ulong guest_loaddr,
> -                         abi_ulong guest_hiaddr, bool try_identity)
> +static bool pgb_addr_set(PGBAddrs *ga, const PGBRange *image_range,
> +                         bool try_identity)
>  {
>      int n;
>
> @@ -866,7 +865,7 @@ static bool pgb_addr_set(PGBAddrs *ga, abi_ulong
> guest_loaddr,
>          if (LO_COMMPAGE !=3D -1 && LO_COMMPAGE < mmap_min_addr) {
>              return false;
>          }
> -        if (guest_loaddr !=3D 0 && guest_loaddr < mmap_min_addr) {
> +        if (image_range && image_range->lo < mmap_min_addr) {
>              return false;
>          }
>      }
> @@ -892,10 +891,8 @@ static bool pgb_addr_set(PGBAddrs *ga, abi_ulong
> guest_loaddr,
>          }
>
>          /* Add the guest image for ET_EXEC. */
> -        if (guest_loaddr) {
> -            ga->bounds[n].lo =3D guest_loaddr;
> -            ga->bounds[n].hi =3D guest_hiaddr;
> -            n++;
> +        if (image_range) {
> +            ga->bounds[n++] =3D *image_range;
>          }
>      }
>
> @@ -928,8 +925,8 @@ static void pgb_fail_in_use(const char *image_name)
>      exit(EXIT_FAILURE);
>  }
>
> -static void pgb_fixed(const char *image_name, uintptr_t guest_loaddr,
> -                      uintptr_t guest_hiaddr, uintptr_t align)
> +static void pgb_fixed(const char *image_name, const PGBRange *image_rang=
e,
> +                      uintptr_t align)
>  {
>      PGBAddrs ga;
>      uintptr_t brk =3D (uintptr_t)sbrk(0);
> @@ -941,7 +938,7 @@ static void pgb_fixed(const char *image_name,
> uintptr_t guest_loaddr,
>          exit(EXIT_FAILURE);
>      }
>
> -    if (!pgb_addr_set(&ga, guest_loaddr, guest_hiaddr, !guest_base)
> +    if (!pgb_addr_set(&ga, image_range, !guest_base)
>          || !pgb_try_mmap_set(&ga, guest_base, brk)) {
>          pgb_fail_in_use(image_name);
>      }
> @@ -1026,15 +1023,15 @@ static uintptr_t pgb_find_itree(const PGBAddrs
> *ga, IntervalTreeRoot *root,
>      return pgb_try_mmap_set(ga, base, brk) ? base : -1;
>  }
>
> -static void pgb_dynamic(const char *image_name, uintptr_t guest_loaddr,
> -                        uintptr_t guest_hiaddr, uintptr_t align)
> +static void pgb_dynamic(const char *image_name, const PGBRange
> *image_range,
> +                        uintptr_t align)
>  {
>      IntervalTreeRoot *root;
>      uintptr_t brk, ret;
>      PGBAddrs ga;
>
>      /* Try the identity map first. */
> -    if (pgb_addr_set(&ga, guest_loaddr, guest_hiaddr, true)) {
> +    if (pgb_addr_set(&ga, image_range, true)) {
>          brk =3D (uintptr_t)sbrk(0);
>          if (pgb_try_mmap_set(&ga, 0, brk)) {
>              guest_base =3D 0;
> @@ -1046,7 +1043,7 @@ static void pgb_dynamic(const char *image_name,
> uintptr_t guest_loaddr,
>       * Rebuild the address set for non-identity map.
>       * This differs in the mapping of the guest NULL page.
>       */
> -    pgb_addr_set(&ga, guest_loaddr, guest_hiaddr, false);
> +    pgb_addr_set(&ga, image_range, false);
>
>      root =3D read_self_maps();
>
> @@ -1085,24 +1082,23 @@ static void pgb_dynamic(const char *image_name,
> uintptr_t guest_loaddr,
>      guest_base =3D ret;
>  }
>
> -void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
> -                      abi_ulong guest_hiaddr)
> +void probe_guest_base(const char *image_name, const PGBRange *image_rang=
e)
>  {
>      /* In order to use host shmat, we must be able to honor SHMLBA.  */
>      uintptr_t align =3D MAX(SHMLBA, TARGET_PAGE_SIZE);
>
>      /* Sanity check the guest binary. */
> -    if (reserved_va && guest_hiaddr > reserved_va) {
> +    if (reserved_va && image_range && image_range->hi > reserved_va) {
>          error_report("%s: requires more than reserved virtual "
> -                     "address space (0x%" PRIx64 " > 0x%lx)",
> -                     image_name, (uint64_t)guest_hiaddr, reserved_va);
> +                     "address space (0x%" VADDR_PRIx " > 0x%lx)",
> +                     image_name, image_range->hi, reserved_va);
>          exit(EXIT_FAILURE);
>      }
>
>      if (have_guest_base) {
> -        pgb_fixed(image_name, guest_loaddr, guest_hiaddr, align);
> +        pgb_fixed(image_name, image_range, align);
>      } else {
> -        pgb_dynamic(image_name, guest_loaddr, guest_hiaddr, align);
> +        pgb_dynamic(image_name, image_range, align);
>      }
>
>      /* Reserve and initialize the commpage. */
> @@ -1362,10 +1358,10 @@ static void load_elf_image(const char *image_name=
,
> const ImageSource *src,
>               * Make sure that the low address does not conflict with
>               * MMAP_MIN_ADDR or the QEMU application itself.
>               */
> -            probe_guest_base(image_name, range.lo, range.hi);
> +            probe_guest_base(image_name, &range);
>          } else {
>              /* The binary is dynamic; we still need to select guest_base=
.
> */
> -            probe_guest_base(image_name, 0, 0);
> +            probe_guest_base(image_name, NULL);
>
>              /*
>               * Avoid collision with the loader by providing a different
> diff --git a/linux-user/flatload.c b/linux-user/flatload.c
> index 8abdd2aef2..45d69040c6 100644
> --- a/linux-user/flatload.c
> +++ b/linux-user/flatload.c
> @@ -261,7 +261,7 @@ static int load_flat_file(struct linux_binprm * bprm,
>      /*
>       * Allocate the address space.
>       */
> -    probe_guest_base(bprm->filename, 0, 0);
> +    probe_guest_base(bprm->filename, NULL);
>
>      /*
>       * there are a couple of cases here,  the separate code/data
> --
> 2.43.0
>
>

--000000000000228f200653155c63
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, May 30,=
 2026 at 3:12=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.he=
nderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Pass a PGBRange structure i=
nstead of separate guest_loaddr<br>
and guest_hiaddr parameters.=C2=A0 This allows NULL to indicate<br>
that the image is relocatable, so that image_range-&gt;lo =3D=3D 0<br>
is a valid fixed setting.<br>
<br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/work_items/1890=
" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu=
/-/work_items/1890</a><br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0linux-user/user-internals.h | 13 ++++-------<br>
=C2=A0linux-user/elfload.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 46 ++++++++++++++++=
+--------------------<br>
=C2=A0linux-user/flatload.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A03 files changed, 27 insertions(+), 34 deletions(-)<br></blockquote><d=
iv><br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp=
.com">imp@bsdimp.com</a>&gt;</div><div><br></div><div>I may have to look in=
to a similar cleanup in bsd-user once the upstreaming backlog is done.</div=
><div><br></div><div>Warner</div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h<br>
index 73b0109e9c..3f41d3f33c 100644<br>
--- a/linux-user/user-internals.h<br>
+++ b/linux-user/user-internals.h<br>
@@ -83,24 +83,21 @@ typedef struct PGBRange {<br>
=C2=A0/**<br>
=C2=A0 * probe_guest_base:<br>
=C2=A0 * @image_name: the executable being loaded<br>
- * @loaddr: the lowest fixed address within the executable<br>
- * @hiaddr: the highest fixed address within the executable<br>
+ * @image_range: the fixed addresses within the executable<br>
=C2=A0 *<br>
=C2=A0 * Creates the initial guest address space in the host memory space.<=
br>
=C2=A0 *<br>
- * If @loaddr =3D=3D 0, then no address in the executable is fixed, i.e.<b=
r>
- * it is fully relocatable.=C2=A0 In that case @hiaddr is the size of the<=
br>
- * executable minus one.<br>
+ * If @image_range is NULL, then no address in the executable is fixed,<br=
>
+ * i.e. it is fully relocatable.<br>
=C2=A0 *<br>
=C2=A0 * This function will not return if a valid value for guest_base<br>
=C2=A0 * cannot be chosen.=C2=A0 On return, the executable loader can expec=
t<br>
=C2=A0 *<br>
- *=C2=A0 =C2=A0 target_mmap(loaddr, hiaddr - loaddr + 1, ...)<br>
+ *=C2=A0 =C2=A0 target_mmap(i-&gt;lo, i-&gt;hi - i-&gt;lo + 1, ...)<br>
=C2=A0 *<br>
=C2=A0 * to succeed.<br>
=C2=A0 */<br>
-void probe_guest_base(const char *image_name,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 abi_ulong loaddr, abi_ulong hiaddr);<br>
+void probe_guest_base(const char *image_name, const PGBRange *image_range)=
;<br>
<br>
=C2=A0/* syscall.c */<br>
=C2=A0int host_to_target_waitstatus(int status);<br>
diff --git a/linux-user/elfload.c b/linux-user/elfload.c<br>
index 33565ad7be..10a826e658 100644<br>
--- a/linux-user/elfload.c<br>
+++ b/linux-user/elfload.c<br>
@@ -847,14 +847,13 @@ static bool pgb_try_mmap_set(const PGBAddrs *ga, uint=
ptr_t base, uintptr_t brk)<br>
=C2=A0/**<br>
=C2=A0 * pgb_addr_set:<br>
=C2=A0 * @ga: output set of guest addrs<br>
- * @guest_loaddr: guest image low address<br>
- * @guest_loaddr: guest image high address<br>
+ * @image_range: fixed guest image addresses<br>
=C2=A0 * @identity: create for identity mapping<br>
=C2=A0 *<br>
=C2=A0 * Fill in @ga with the image, COMMPAGE and NULL page.<br>
=C2=A0 */<br>
-static bool pgb_addr_set(PGBAddrs *ga, abi_ulong guest_loaddr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0abi_ulong guest_hiaddr, bool try_identity)<br>
+static bool pgb_addr_set(PGBAddrs *ga, const PGBRange *image_range,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0bool try_identity)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int n;<br>
<br>
@@ -866,7 +865,7 @@ static bool pgb_addr_set(PGBAddrs *ga, abi_ulong guest_=
loaddr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (LO_COMMPAGE !=3D -1 &amp;&amp; LO_COM=
MPAGE &lt; mmap_min_addr) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (guest_loaddr !=3D 0 &amp;&amp; guest_loadd=
r &lt; mmap_min_addr) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (image_range &amp;&amp; image_range-&gt;lo =
&lt; mmap_min_addr) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -892,10 +891,8 @@ static bool pgb_addr_set(PGBAddrs *ga, abi_ulong guest=
_loaddr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Add the guest image for ET_EXEC. */<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (guest_loaddr) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n].lo =3D guest_lo=
addr;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n].hi =3D guest_hi=
addr;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (image_range) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n++] =3D *image_ra=
nge;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -928,8 +925,8 @@ static void pgb_fail_in_use(const char *image_name)<br>
=C2=A0 =C2=A0 =C2=A0exit(EXIT_FAILURE);<br>
=C2=A0}<br>
<br>
-static void pgb_fixed(const char *image_name, uintptr_t guest_loaddr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uintptr_t guest_hiaddr, uintptr_t align)<br>
+static void pgb_fixed(const char *image_name, const PGBRange *image_range,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uintptr_t align)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0PGBAddrs ga;<br>
=C2=A0 =C2=A0 =C2=A0uintptr_t brk =3D (uintptr_t)sbrk(0);<br>
@@ -941,7 +938,7 @@ static void pgb_fixed(const char *image_name, uintptr_t=
 guest_loaddr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(EXIT_FAILURE);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (!pgb_addr_set(&amp;ga, guest_loaddr, guest_hiaddr, !gues=
t_base)<br>
+=C2=A0 =C2=A0 if (!pgb_addr_set(&amp;ga, image_range, !guest_base)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|| !pgb_try_mmap_set(&amp;ga, guest_base,=
 brk)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pgb_fail_in_use(image_name);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -1026,15 +1023,15 @@ static uintptr_t pgb_find_itree(const PGBAddrs *ga,=
 IntervalTreeRoot *root,<br>
=C2=A0 =C2=A0 =C2=A0return pgb_try_mmap_set(ga, base, brk) ? base : -1;<br>
=C2=A0}<br>
<br>
-static void pgb_dynamic(const char *image_name, uintptr_t guest_loaddr,<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 uintptr_t guest_hiaddr, uintptr_t align)<br>
+static void pgb_dynamic(const char *image_name, const PGBRange *image_rang=
e,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 uintptr_t align)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0IntervalTreeRoot *root;<br>
=C2=A0 =C2=A0 =C2=A0uintptr_t brk, ret;<br>
=C2=A0 =C2=A0 =C2=A0PGBAddrs ga;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Try the identity map first. */<br>
-=C2=A0 =C2=A0 if (pgb_addr_set(&amp;ga, guest_loaddr, guest_hiaddr, true))=
 {<br>
+=C2=A0 =C2=A0 if (pgb_addr_set(&amp;ga, image_range, true)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0brk =3D (uintptr_t)sbrk(0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pgb_try_mmap_set(&amp;ga, 0, brk)) {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0guest_base =3D 0;<br>
@@ -1046,7 +1043,7 @@ static void pgb_dynamic(const char *image_name, uintp=
tr_t guest_loaddr,<br>
=C2=A0 =C2=A0 =C2=A0 * Rebuild the address set for non-identity map.<br>
=C2=A0 =C2=A0 =C2=A0 * This differs in the mapping of the guest NULL page.<=
br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 pgb_addr_set(&amp;ga, guest_loaddr, guest_hiaddr, false);<br=
>
+=C2=A0 =C2=A0 pgb_addr_set(&amp;ga, image_range, false);<br>
<br>
=C2=A0 =C2=A0 =C2=A0root =3D read_self_maps();<br>
<br>
@@ -1085,24 +1082,23 @@ static void pgb_dynamic(const char *image_name, uin=
tptr_t guest_loaddr,<br>
=C2=A0 =C2=A0 =C2=A0guest_base =3D ret;<br>
=C2=A0}<br>
<br>
-void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 abi_ulong guest_hiaddr)<br>
+void probe_guest_base(const char *image_name, const PGBRange *image_range)=
<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0/* In order to use host shmat, we must be able to honor=
 SHMLBA.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0uintptr_t align =3D MAX(SHMLBA, TARGET_PAGE_SIZE);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Sanity check the guest binary. */<br>
-=C2=A0 =C2=A0 if (reserved_va &amp;&amp; guest_hiaddr &gt; reserved_va) {<=
br>
+=C2=A0 =C2=A0 if (reserved_va &amp;&amp; image_range &amp;&amp; image_rang=
e-&gt;hi &gt; reserved_va) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;%s: requires more than=
 reserved virtual &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;address space (0x%&quot; PRIx64 &quot; &gt; 0x%lx)&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0image_name, (uint64_t)guest_hiaddr, reserved_va);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;address space (0x%&quot; VADDR_PRIx &quot; &gt; 0x%lx)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0image_name, image_range-&gt;hi, reserved_va);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(EXIT_FAILURE);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (have_guest_base) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pgb_fixed(image_name, guest_loaddr, guest_hiad=
dr, align);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pgb_fixed(image_name, image_range, align);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pgb_dynamic(image_name, guest_loaddr, guest_hi=
addr, align);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pgb_dynamic(image_name, image_range, align);<b=
r>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Reserve and initialize the commpage. */<br>
@@ -1362,10 +1358,10 @@ static void load_elf_image(const char *image_name, =
const ImageSource *src,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Make sure that the low a=
ddress does not conflict with<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * MMAP_MIN_ADDR or the QEM=
U application itself.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 probe_guest_base(image_name, ran=
ge.lo, range.hi);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 probe_guest_base(image_name, &am=
p;range);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* The binary is dynamic; w=
e still need to select guest_base. */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 probe_guest_base(image_name, 0, =
0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 probe_guest_base(image_name, NUL=
L);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Avoid collision with the=
 loader by providing a different<br>
diff --git a/linux-user/flatload.c b/linux-user/flatload.c<br>
index 8abdd2aef2..45d69040c6 100644<br>
--- a/linux-user/flatload.c<br>
+++ b/linux-user/flatload.c<br>
@@ -261,7 +261,7 @@ static int load_flat_file(struct linux_binprm * bprm,<b=
r>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * Allocate the address space.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 probe_guest_base(bprm-&gt;filename, 0, 0);<br>
+=C2=A0 =C2=A0 probe_guest_base(bprm-&gt;filename, NULL);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * there are a couple of cases here,=C2=A0 the separate=
 code/data<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--000000000000228f200653155c63--

