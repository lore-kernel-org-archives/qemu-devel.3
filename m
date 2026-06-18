Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88ECCD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 20:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waJGG-0007K9-79; Thu, 18 Jun 2026 16:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1waJGD-0007J4-PQ
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 16:22:49 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1waJGB-0000dn-ED
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 16:22:49 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-36d98b68d68so870251a91.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 13:22:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781814165; cv=none;
 d=google.com; s=arc-20240605;
 b=VbvrzGUFJpmGnf0LC5YEKXAPGwi1xG2R71dV74o5HmhX3GuRfbuz0hhB3JGxhclX/M
 LQ1H2x7KBtahPpEZT+eb3Bgp6R/VRPUwweOYrJUD7vwYocDALye7IiImPoT1kMyk/yoh
 7+4rCN1subBjSHN6fO4GoI0mZZLuOHR7NYRrkCkGD8oA6yo2X4xZ74LRQNGCGP4Yvy/p
 MCcsuQ4s48f2pANN8cv7KtI1HBnUOCKLXK9o6gxp0Q9hmSDZcXUwvhgUjulxVgMGVCM3
 pcnaZiBc+YSTh2wqtb/KDxb3NaI6oChIG/XNL9sn0jtboIdTOAP/ymUFgQLvIuVFspfl
 oxwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UfNuH5pJVizuzKvyZGBlvIKwaqygf6p+GwN+r09o/os=;
 fh=WHHJyMq/rBQXPpelCo1tKk6BX4mpcsLXFtKgbYR63yI=;
 b=YwPwGrB8+lwQybOX4K7rk+4wb1Bp3P/ERWgEV9j4/auDa2H+Ln1ReLG76wTondXqop
 dG9XXipMTD4qFiqg/xJeU5chSgh/0tBJF7ui2/n4J0GKKvAZaxq2lbVUiq5/q1VpWVm2
 XrTOXFrc+j7FNR8NE/EfBR6BmFKxJ6XAzppXKTXENgsn8qWCcnNJEFlidQrly/4a24aG
 lsPGQC42TPZuLBSyaJ9ImL1J0E9dOD6TZLQYPsoVxP6iXakj7qvFo1vWhQZbz3PzrPEL
 CroJ+sqbneg4v2HXP54D7hi87FmmHI1oRR6j03W1yFZhLzER4D6+JziPR8stIhw7eZ24
 IoOw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1781814165; x=1782418965;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UfNuH5pJVizuzKvyZGBlvIKwaqygf6p+GwN+r09o/os=;
 b=sWnxkj2TsKcVK1UIfPkYK04HUHsESoLuU+ETV5Iaj/Pfb6DFuKwJYrGH2qNF7es+24
 5d1fft7qFL4AZ3hJC3an078eFQyFO+hNaDIZOgbUuDyQ3D6++5Kp1881vJbwRikkjIdA
 7bh3PPC9nEVVfv1YHV2bkPU+0O2c4YmWEXnO95Z5ReSn+nFYk4Ite09DHdih79aCY4nW
 52ezGg1M2oi4ywVA8S/qK6c1OaM9Gjg4/v7sA9seKO9fPbuE9Csrk2PcR+pXfCgNKLMo
 QvYo9zKGVR+jRgLEx4K7b8wsPBBHPegEKhY6MPFqHoiJl/J/zoqZNYTw10UAc/ZRPXtv
 hSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781814165; x=1782418965;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UfNuH5pJVizuzKvyZGBlvIKwaqygf6p+GwN+r09o/os=;
 b=hw2xzjqf8RxsAPqN0z6P1isC5hHYEbD55NubrQ8Z9qrl7Nkp93ji1rqxhlMrJ5AAXm
 uxUF2ULpZS62erAwkM9fp6wQ7JtcTnSQ2mC3JjIcic0nmMluXbTc6ZXOCqXeUfltrCYJ
 P2AjPKLXryg8QBRWRBb4sASYfvG4eVwqzSXjhjjEFPRavDWlJUo+/kmktOYzsggTVdG8
 lw/VYTTusKEsmzbxC3uMyqeJwN4ZMsemhAdo4z3CMxqoE+1eVx9SRYrWKqnfYCLHb4kG
 yTNoZAf4pmEN33VE2JbAsW+Uvo6m689xExxOos3PdD23cYWyv3YiNg041WzY2a1rpRt8
 ZdEQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9qQusjUNdIRsLZZdrZ9O8Z7xfVGPOvgFmTkcd5nlxhIlhVy9RAf//Y9Ds6G/26gK7jTREyjLifC8aS@nongnu.org
X-Gm-Message-State: AOJu0Yw01003HuuLVjkZ9liZzKOxEN3YOLrNxQJawwRnQzIiuXU6XHs7
 T09Qm03tFqggnKMItFKtxlhIJoDofmQsVuuewaWDtJJpnJ57pRiYmymH3/gr+522a2PrjfMD2+M
 H6PGIq7vH8EJl5FXmkI2yP0A61nV2+fVrNCnQkp5Syg==
X-Gm-Gg: AfdE7cmA2MYZY7kCipDPlnebIgNoxZYQA+cNUhwJ5d6nUcIJB7NqQUXrQZ+MmBjrYmH
 no2jI0NKnOL0P3WMD6RaNhQopajl2nAM83QwuYQXqPKXbNJ17+r1R3UV7FvQxOdZRO5vsxhwv8P
 mkUT5OizeiNcUD1MgtZdlEjpClz7ruuY388DhZ3uSVvL+WlQVm7xEtMliE+ICngN1UaCpUhGKpU
 OYg3fNFvRaoD6XzI/PZp1LbpAOS92ypwaUPe1GI54u3C5cg1xFETbrDg0DvydO1znFda2J4cb4=
X-Received: by 2002:a17:90b:2692:b0:372:b4a1:21d8 with SMTP id
 98e67ed59e1d1-37d15de28a7mr1260503a91.13.1781814165236; Thu, 18 Jun 2026
 13:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260618195520.589907-1-richard.henderson@linaro.org>
 <20260618195520.589907-13-richard.henderson@linaro.org>
 <7d9acb4e-d1da-45da-a42a-60340d0dfb58@oss.qualcomm.com>
In-Reply-To: <7d9acb4e-d1da-45da-a42a-60340d0dfb58@oss.qualcomm.com>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 18 Jun 2026 16:22:34 -0400
X-Gm-Features: AVVi8Ccjxw7m5BksqB1MVTplva6qyKph8jBfVcwn3nwEzDAyG8JQCrOvw-UXOGk
Message-ID: <CANCZdfpW9JNemJVDXEt2+h_XDfBv8wFDR68GNf0xkxzZHn9Aow@mail.gmail.com>
Subject: Re: [PATCH v3 12/13] bsd-user: Use probe_guest_base
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000005ffe3906548cf037"
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

--0000000000005ffe3906548cf037
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 4:12=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <
philmd@oss.qualcomm.com> wrote:

> On 18/6/26 21:55, Richard Henderson wrote:
> > Merge the PT_LOAD loop with the PT_INTERP loop, as the XXX
> > comment suggests.  Pass the probed range to probe_guest_base.
> >
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >   bsd-user/elfload.c | 37 +++++++++++++++++++------------------
> >   bsd-user/main.c    | 39 ++++-----------------------------------
> >   2 files changed, 23 insertions(+), 53 deletions(-)
>
>
> > +    /* Ensure that mmap_next_start is within range. */
> > +    if (reserved_va && reserved_va <=3D mmap_next_start) {
> > +        mmap_next_start =3D ((reserved_va / 4 * 3)
>
> Is that ROUND_DOWN(reserved_va, 4)?
>
> > +                           & TARGET_PAGE_MASK & qemu_host_page_mask);
> >       }
>
> Rest LGTM AFAICT :)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
>

Same comment

Reviewed-by: Warner Losh <imp@bsdimp.com>

--0000000000005ffe3906548cf037
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 18,=
 2026 at 4:12=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:=
philmd@oss.qualcomm.com">philmd@oss.qualcomm.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">On 18/6/26 21:55, Richard H=
enderson wrote:<br>
&gt; Merge the PT_LOAD loop with the PT_INTERP loop, as the XXX<br>
&gt; comment suggests.=C2=A0 Pass the probed range to probe_guest_base.<br>
&gt; <br>
&gt; Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henders=
on@linaro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/elfload.c | 37 +++++++++++++++++++---------------=
---<br>
&gt;=C2=A0 =C2=A0bsd-user/main.c=C2=A0 =C2=A0 | 39 ++++--------------------=
---------------<br>
&gt;=C2=A0 =C2=A02 files changed, 23 insertions(+), 53 deletions(-)<br>
<br>
<br>
&gt; +=C2=A0 =C2=A0 /* Ensure that mmap_next_start is within range. */<br>
&gt; +=C2=A0 =C2=A0 if (reserved_va &amp;&amp; reserved_va &lt;=3D mmap_nex=
t_start) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_next_start =3D ((reserved_va / 4 * 3=
)<br>
<br>
Is that ROUND_DOWN(reserved_va, 4)?<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp; TARGET_PAGE_MASK &amp; qemu_host_page_mas=
k);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
Rest LGTM AFAICT :)<br>
<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@oss.q=
ualcomm.com" target=3D"_blank">philmd@oss.qualcomm.com</a>&gt;<br></blockqu=
ote><div><br></div><div>Same comment</div><div><br></div><div>Reviewed-by: =
Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.com</a>&gt;</d=
iv><div><br></div></div></div>

--0000000000005ffe3906548cf037--

