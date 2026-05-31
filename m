Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CE2CD5BD1
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 04:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTXW3-0006BC-OR; Sun, 31 May 2026 00:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTXW2-0006Ae-IK
 for qemu-devel@nongnu.org; Sun, 31 May 2026 00:11:10 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTXW0-0006Lp-G2
 for qemu-devel@nongnu.org; Sun, 31 May 2026 00:11:10 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-36bcbd7821fso846902a91.2
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 21:11:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780200667; cv=none;
 d=google.com; s=arc-20240605;
 b=V47UskFeMZxW7FkotHNDhTfSygRtrknu110sNocYFr4gWQLfY8C2vQRVoxK5hZLDFb
 3sIvN7xpfYJg3H8CIG5MOC5BqM9Z6yK/DguMM6mgf7kmz4ls8XoDfQD1L5tqWoXtmRIl
 tm0ll2SniDtbySNG8XU3dN4xGxla5ShXVveLKdA5B7O3I+F5vKvu7EVwY/mN8F/Z10XT
 zEPQcba3OX0+iEuLeS5aUqHhWrOEf9PVH7Gc7z8ZWGTQj7ccXUqJatuZKSywDaoifYSq
 jVzAwfjcTFgj3ltgLseq2lNY8Cna/VGheGnKBUi3xNotwBbcfRYgr3sOVP58Riqgnrwz
 msQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rBSKeC2mjnymwbcb7giR6OlsSEyc24yHmcU7wn9kZKM=;
 fh=+DxRVnEC95Ptxk5HMfIFqaUwIao1HhLaAPFCgZPm1R4=;
 b=iWHcECVzrLQo9PbtFip1sbJ+GZ1NQstXMD1Ps1P73JIVDubsxyxKi6Z8M1ISwZLlbZ
 e8yNSJzAGQ94PmePG4p36z7um5C0z28PFWI0XUGFVZZCT76SHl9VKcsj0PuYFBWG5Rri
 lwTO4PL/s8cIwVGjY98j7gCF1U+S/SSdmLJQ/3MaGi2O0VN6CtRvxF2x5WQ53yzyvU3Z
 XcNplfjE2RaVvFrI+fI4YW40Bt9j29LpVDAnDCX8cTGlvbj6iQfCHW0SO7ApvCIbJ8rD
 zKVHwWcx0k7lPe/uytjNtDewlELQ6xmFZ15Oi7+XtdBGGzYE4EIy6GxwYC9/QalRCmdD
 dEJQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1780200667; x=1780805467;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rBSKeC2mjnymwbcb7giR6OlsSEyc24yHmcU7wn9kZKM=;
 b=WM9YdTtk1Ncv478fq2VRYvl0CgZK5b1TOtxJoy/hB3CF19bIBdVQA7+wzEPWBn8kSu
 1d9ckJgnhIL1oNXRw/3JL3QzY5rKRNK9qWz+rTPM0nhhjdZS1X6vKKAqmiTqsNzOyshb
 K55ArR2MXfqRF5qPTpNi+Tuo3aYpbjoHflR7zBlNNPR32AXRli0FRx1kyi7O7ueB06uC
 FNAvGBQ5OrOx4azDGopc+QpG9CRq2gl4x/A2k/KNKjugEhAX0QrbuiKXXMSP2Ndxk7tc
 0KFAk+OdeRKPxWg23kKmuCXKKddWgXSHileXT/q2tu6POY7jalgN3IkA0lO7XoKMH5lG
 5k9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780200667; x=1780805467;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rBSKeC2mjnymwbcb7giR6OlsSEyc24yHmcU7wn9kZKM=;
 b=L09gqxEl3znoZaG/cSorNPOc2l9/fkyUJFqbwCdh07CgB6WCYmyT8pdADq9MnONide
 idGoZrDEm3NW5zAp/f55+5I1sAabdvXBBjOIn7gyYF8cKGA5FWcC/h7yIUEe5DpAYDYN
 pc1DvxWOi/6WVcSYGDSEflMcN94Jyby0DPq7HMj6KN6i15ua2mRuWmc7xAvYjLFqW3ER
 LWxYAh6dcYuM8fj8IduXWZA9g55JCgRga+85a8xEiBN106q1aQuP4LKRh8D5p24d2ocH
 kWFuWmGluSrmVVPBykk2d2+KyLc+fgQuV8v7I0PyImQIW6T4ElypgWnrg5DSybGH8cp3
 hwLQ==
X-Gm-Message-State: AOJu0YxKEc4O0s5mcsxss2fk4H47FrfuRELQjOnMLGF8+MoF4GOT4E3Q
 mW+8KzZzJXu67qHajgq2qp5gE62b+qr2ohbRNRpSD1ipA0K6Xk5yKbTZ/u9cIzskA9PVEDgRx8f
 o37FLdoLoLLaZJ+M+NPzTAui28zPLtHlNHiiv6P4btQ==
X-Gm-Gg: Acq92OEqsfhDYweT+p8rC981sMnQr0jcnrsSuOkofBA3usWIjR8Y2O0pYVpLkzRvgVt
 Z8tplZWkjMUbFFic+21JHSjo68z3CR2kG1KiCOVh5X2d+E2U3d6M6/vTED7n66ybAKchxHqaXJN
 1Yv3f0awJRbvi6krh+VnlFGmyN3JAS7/DfguQXoy4JUr/4HNncBYiIGXQnoH2Aqenmjuq2CDSw6
 AOvAoVk8CBIOTBE0biydhxoRdf51DkmtRvI62lnxR5r5nC7gG8c4q5dcgaK+Pi2XfeNSHSJMErh
 NuvvUFZLlFHjqPvw+bgfIzY/+BhHAsPVtBGvY07/dbzJF8M=
X-Received: by 2002:a17:90b:5704:b0:36b:71e6:3e01 with SMTP id
 98e67ed59e1d1-36c501e108cmr5417101a91.16.1780200666660; Sat, 30 May 2026
 21:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260530211248.375318-1-richard.henderson@linaro.org>
 <20260530211248.375318-2-richard.henderson@linaro.org>
In-Reply-To: <20260530211248.375318-2-richard.henderson@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 30 May 2026 22:10:55 -0600
X-Gm-Features: AVHnY4K73rIyFXRdr8iz1VkpxYnudxlImCVynONN3YxE3VNVZQZwzBKag5xC0mE
Message-ID: <CANCZdfrCybo5xi0O4J9Av4RRP7e-0hDR7+ZKAhVS2oS7OAFoHg@mail.gmail.com>
Subject: Re: [PATCH 01/13] linux-user: Introduce PGBRange
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Content-Type: multipart/alternative; boundary="0000000000005d945a0653154492"
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

--0000000000005d945a0653154492
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 3:12=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> Create a structure to hold a beginning/end range for guest virtual
> addresses, for use by probe_guest_base.  Use vaddr for clarity.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/user-internals.h |  5 +++++
>  linux-user/elfload.c        | 36 ++++++++++++++++++------------------
>  2 files changed, 23 insertions(+), 18 deletions(-)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

This mechanical change looks good to me, and I didn't see any mistakes in
the array to struct conversion.


> diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
> index 21daf422b7..73b0109e9c 100644
> --- a/linux-user/user-internals.h
> +++ b/linux-user/user-internals.h
> @@ -75,6 +75,11 @@ void clone_fork_end(bool child);
>  void fork_start(void);
>  void fork_end(pid_t pid);
>
> +typedef struct PGBRange {
> +    vaddr lo;
> +    vaddr hi;
> +} PGBRange;
> +
>  /**
>   * probe_guest_base:
>   * @image_name: the executable being loaded
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 0e757787d2..e1e1ee4674 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -828,15 +828,15 @@ static int pgb_try_mmap_skip_brk(uintptr_t addr,
> uintptr_t addr_last,
>   */
>
>  typedef struct PGBAddrs {
> -    uintptr_t bounds[3][2]; /* start/last pairs */
> +    PGBRange bounds[3];
>      int nbounds;
>  } PGBAddrs;
>
>  static bool pgb_try_mmap_set(const PGBAddrs *ga, uintptr_t base,
> uintptr_t brk)
>  {
>      for (int i =3D ga->nbounds - 1; i >=3D 0; --i) {
> -        if (pgb_try_mmap_skip_brk(ga->bounds[i][0] + base,
> -                                  ga->bounds[i][1] + base,
> +        if (pgb_try_mmap_skip_brk(ga->bounds[i].lo + base,
> +                                  ga->bounds[i].hi + base,
>                                    brk, i =3D=3D 0 && reserved_va) <=3D 0=
) {
>              return false;
>          }
> @@ -875,26 +875,26 @@ static bool pgb_addr_set(PGBAddrs *ga, abi_ulong
> guest_loaddr,
>      n =3D 0;
>
>      if (reserved_va) {
> -        ga->bounds[n][0] =3D try_identity ? mmap_min_addr : 0;
> -        ga->bounds[n][1] =3D reserved_va;
> +        ga->bounds[n].lo =3D try_identity ? mmap_min_addr : 0;
> +        ga->bounds[n].hi =3D reserved_va;
>          n++;
>          /* LO_COMMPAGE and NULL handled by reserving from 0. */
>      } else {
>          /* Add any LO_COMMPAGE or NULL page. */
>          if (LO_COMMPAGE !=3D -1) {
> -            ga->bounds[n][0] =3D 0;
> -            ga->bounds[n][1] =3D LO_COMMPAGE + TARGET_PAGE_SIZE - 1;
> +            ga->bounds[n].lo =3D 0;
> +            ga->bounds[n].hi =3D LO_COMMPAGE + TARGET_PAGE_SIZE - 1;
>              n++;
>          } else if (!try_identity) {
> -            ga->bounds[n][0] =3D 0;
> -            ga->bounds[n][1] =3D TARGET_PAGE_SIZE - 1;
> +            ga->bounds[n].lo =3D 0;
> +            ga->bounds[n].hi =3D TARGET_PAGE_SIZE - 1;
>              n++;
>          }
>
>          /* Add the guest image for ET_EXEC. */
>          if (guest_loaddr) {
> -            ga->bounds[n][0] =3D guest_loaddr;
> -            ga->bounds[n][1] =3D guest_hiaddr;
> +            ga->bounds[n].lo =3D guest_loaddr;
> +            ga->bounds[n].hi =3D guest_hiaddr;
>              n++;
>          }
>      }
> @@ -909,8 +909,8 @@ static bool pgb_addr_set(PGBAddrs *ga, abi_ulong
> guest_loaddr,
>
>      /* Add any HI_COMMPAGE not covered by reserved_va. */
>      if (reserved_va < HI_COMMPAGE) {
> -        ga->bounds[n][0] =3D HI_COMMPAGE & qemu_real_host_page_mask();
> -        ga->bounds[n][1] =3D HI_COMMPAGE + TARGET_PAGE_SIZE - 1;
> +        ga->bounds[n].lo =3D HI_COMMPAGE & qemu_real_host_page_mask();
> +        ga->bounds[n].hi =3D HI_COMMPAGE + TARGET_PAGE_SIZE - 1;
>          n++;
>      }
>
> @@ -976,8 +976,8 @@ static uintptr_t pgb_try_itree(const PGBAddrs *ga,
> uintptr_t base,
>                                 IntervalTreeRoot *root)
>  {
>      for (int i =3D ga->nbounds - 1; i >=3D 0; --i) {
> -        uintptr_t s =3D base + ga->bounds[i][0];
> -        uintptr_t l =3D base + ga->bounds[i][1];
> +        uintptr_t s =3D base + ga->bounds[i].lo;
> +        uintptr_t l =3D base + ga->bounds[i].hi;
>          IntervalTreeNode *n;
>
>          if (l < s) {
> @@ -1076,9 +1076,9 @@ static void pgb_dynamic(const char *image_name,
> uintptr_t guest_loaddr,
>                       "guest address mapping requirements", image_name);
>
>          for (int i =3D 0; i < ga.nbounds; ++i) {
> -            error_printf("  %0*" PRIx64 "-%0*" PRIx64 "\n",
> -                         w, (uint64_t)ga.bounds[i][0],
> -                         w, (uint64_t)ga.bounds[i][1]);
> +            error_printf("  %0*" VADDR_PRIx "-%0*" VADDR_PRIx "\n",
> +                         w, ga.bounds[i].lo,
> +                         w, ga.bounds[i].hi);
>          }
>          exit(EXIT_FAILURE);
>      }
> --
> 2.43.0
>
>

--0000000000005d945a0653154492
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, May 30,=
 2026 at 3:12=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.he=
nderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Create a structure to hold =
a beginning/end range for guest virtual<br>
addresses, for use by probe_guest_base.=C2=A0 Use vaddr for clarity.<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0linux-user/user-internals.h |=C2=A0 5 +++++<br>
=C2=A0linux-user/elfload.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 36 ++++++++++++++++=
++------------------<br>
=C2=A02 files changed, 23 insertions(+), 18 deletions(-)<br></blockquote><d=
iv><br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp=
.com">imp@bsdimp.com</a>&gt;</div><div><br></div><div>This mechanical chang=
e looks good to me, and I didn&#39;t see any mistakes in the array to struc=
t conversion.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h<br>
index 21daf422b7..73b0109e9c 100644<br>
--- a/linux-user/user-internals.h<br>
+++ b/linux-user/user-internals.h<br>
@@ -75,6 +75,11 @@ void clone_fork_end(bool child);<br>
=C2=A0void fork_start(void);<br>
=C2=A0void fork_end(pid_t pid);<br>
<br>
+typedef struct PGBRange {<br>
+=C2=A0 =C2=A0 vaddr lo;<br>
+=C2=A0 =C2=A0 vaddr hi;<br>
+} PGBRange;<br>
+<br>
=C2=A0/**<br>
=C2=A0 * probe_guest_base:<br>
=C2=A0 * @image_name: the executable being loaded<br>
diff --git a/linux-user/elfload.c b/linux-user/elfload.c<br>
index 0e757787d2..e1e1ee4674 100644<br>
--- a/linux-user/elfload.c<br>
+++ b/linux-user/elfload.c<br>
@@ -828,15 +828,15 @@ static int pgb_try_mmap_skip_brk(uintptr_t addr, uint=
ptr_t addr_last,<br>
=C2=A0 */<br>
<br>
=C2=A0typedef struct PGBAddrs {<br>
-=C2=A0 =C2=A0 uintptr_t bounds[3][2]; /* start/last pairs */<br>
+=C2=A0 =C2=A0 PGBRange bounds[3];<br>
=C2=A0 =C2=A0 =C2=A0int nbounds;<br>
=C2=A0} PGBAddrs;<br>
<br>
=C2=A0static bool pgb_try_mmap_set(const PGBAddrs *ga, uintptr_t base, uint=
ptr_t brk)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0for (int i =3D ga-&gt;nbounds - 1; i &gt;=3D 0; --i) {<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pgb_try_mmap_skip_brk(ga-&gt;bounds[i][0] =
+ base,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[i][1] + base,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pgb_try_mmap_skip_brk(ga-&gt;bounds[i].lo =
+ base,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[i].hi + base,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0brk, i =3D=3D 0 &amp;&a=
mp; reserved_va) &lt;=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -875,26 +875,26 @@ static bool pgb_addr_set(PGBAddrs *ga, abi_ulong gues=
t_loaddr,<br>
=C2=A0 =C2=A0 =C2=A0n =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (reserved_va) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n][0] =3D try_identity ? mmap_mi=
n_addr : 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n][1] =3D reserved_va;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n].lo =3D try_identity ? mmap_mi=
n_addr : 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n].hi =3D reserved_va;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n++;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* LO_COMMPAGE and NULL handled by reserv=
ing from 0. */<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Add any LO_COMMPAGE or NULL page. */<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (LO_COMMPAGE !=3D -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n][0] =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n][1] =3D LO_COMMP=
AGE + TARGET_PAGE_SIZE - 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n].lo =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n].hi =3D LO_COMMP=
AGE + TARGET_PAGE_SIZE - 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n++;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (!try_identity) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n][0] =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n][1] =3D TARGET_P=
AGE_SIZE - 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n].lo =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n].hi =3D TARGET_P=
AGE_SIZE - 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n++;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Add the guest image for ET_EXEC. */<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (guest_loaddr) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n][0] =3D guest_lo=
addr;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n][1] =3D guest_hi=
addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n].lo =3D guest_lo=
addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n].hi =3D guest_hi=
addr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n++;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -909,8 +909,8 @@ static bool pgb_addr_set(PGBAddrs *ga, abi_ulong guest_=
loaddr,<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Add any HI_COMMPAGE not covered by reserved_va. */<b=
r>
=C2=A0 =C2=A0 =C2=A0if (reserved_va &lt; HI_COMMPAGE) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n][0] =3D HI_COMMPAGE &amp; qemu=
_real_host_page_mask();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n][1] =3D HI_COMMPAGE + TARGET_P=
AGE_SIZE - 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n].lo =3D HI_COMMPAGE &amp; qemu=
_real_host_page_mask();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n].hi =3D HI_COMMPAGE + TARGET_P=
AGE_SIZE - 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n++;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -976,8 +976,8 @@ static uintptr_t pgb_try_itree(const PGBAddrs *ga, uint=
ptr_t base,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IntervalTreeRoot *root)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0for (int i =3D ga-&gt;nbounds - 1; i &gt;=3D 0; --i) {<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 uintptr_t s =3D base + ga-&gt;bounds[i][0];<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 uintptr_t l =3D base + ga-&gt;bounds[i][1];<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uintptr_t s =3D base + ga-&gt;bounds[i].lo;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uintptr_t l =3D base + ga-&gt;bounds[i].hi;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IntervalTreeNode *n;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (l &lt; s) {<br>
@@ -1076,9 +1076,9 @@ static void pgb_dynamic(const char *image_name, uintp=
tr_t guest_loaddr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;guest address mapping requirements&quot;, image_name);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (int i =3D 0; i &lt; ga.nbounds; ++i)=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_printf(&quot;=C2=A0 %0*&qu=
ot; PRIx64 &quot;-%0*&quot; PRIx64 &quot;\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0w, (uint64_t)ga.bounds[i][0],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0w, (uint64_t)ga.bounds[i][1]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_printf(&quot;=C2=A0 %0*&qu=
ot; VADDR_PRIx &quot;-%0*&quot; VADDR_PRIx &quot;\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0w, ga.bounds[i].lo,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0w, ga.bounds[i].hi);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(EXIT_FAILURE);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--0000000000005d945a0653154492--

