Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED364C5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 05:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwvcx-0003g6-9C; Thu, 20 Aug 2026 01:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wwvcr-0003eG-BV
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 01:47:41 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wwvcp-0005Aa-Iv
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 01:47:41 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so1725065a91.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 22:47:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787204857; cv=none;
 d=google.com; s=arc-20260327;
 b=UbPhREZV407672Y85U8Wdzu2r39Gmfl9AKRe58mTDpZcHd1oNoVBUX50R97VWUGKCB
 CxKkl+5KV6TxGEnD409LecWYXMXjMRPs+gulASsxSlF8GRl8Vg2m+WiodDRr4A0HMAt3
 hymVYKa4WbRfOvo1vwRVxqtWObYmg2uBEfZVO9ahTc/WnYId1u9Jl+PMosSBgLd073f6
 ia7ShdUh/K/K8O1IxD2aYGvN6B8m0lEWPG0z8XvScJfQdnq9txx9B/V7PBUKi7vXynRG
 2Y7IPkHO9/Z7kdDIqkVT6HavMhk/AgYXEdHn8lzpgBPmZnuKg7yQBFpqwmXBK+RonbfA
 PIEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2xLh0uFCjClhg+2rbJQ6BEQZeT5+S2r6VlVPybYx4O0=;
 fh=E29895X+iqR6jIfsM/7ZQNDcc1c5xVRzorsAbPEmkKU=;
 b=ixY2T/MvIwI3Gdqh9FarFtheN0MC3SQ8UKGbVMOY+LfgiVNj9vmx+ZBiNWtu0C7mvm
 QLMzxfiIJ73ys1btJN+NiMcZq3eFYLjuv2/G80N+nl6Lr1cKR/oe+l9Ko+QDlVvwg2VB
 7lX5B4mH4x8Ti8SpbTIdKwHMKamhI0sxQuHJqBEDmFioK1t/X9tpR2+FmQdgdhZ30C56
 ZZ4S7+H9jV2mbn+X+wrz5NrXU7MYL9yIej1q53NT7u0qebDgfPQtZf9G/gGgNXDN5ANZ
 F2xXQmTupTsSq3cXjiude/EszNo+v/JbvE9DxohEiqfYgY/wD/qU+CCfH4cKHPQptW2h
 AiEA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787204857; x=1787809657;
 darn=nongnu.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2xLh0uFCjClhg+2rbJQ6BEQZeT5+S2r6VlVPybYx4O0=;
 b=dPrpAHS9vC1zHN3KoOgu/2tkl08R0AUvcrpC6LArKoxVJoKr95ATp/Bdg54sYMzY3j
 Bb7J2hdtAChBQVwDLGANexmLhkKtH8BCVeit/BGP3AsDELv3nguS2/uKy7m39YY0FnHj
 44Ifymk4VMTocT8KSkeStlMII3oN2+HX6B2jzicjUnXVkf4+cD/j2vpvTbgsQpEl87PM
 vgrem6pDJdSD7JB/RhK5BQYrXkPUWdCuVzUSbf5u86MCMMTbrB09J2XXoAVtW5i+lmNt
 QFEVKQ+ebVhWCMAsQ48Qrld9Jg242lZfCgCYHCFR6rF3AOZs70mDscpVCOCA4BiWoxb6
 Tt9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787204857; x=1787809657;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2xLh0uFCjClhg+2rbJQ6BEQZeT5+S2r6VlVPybYx4O0=;
 b=dONVglYMF/XnDBRAKUhElbAlOJVJj0axnalrZHMGGkL2F9H9cDykrRHJcBa+CFumB3
 mLGLZWPhQVYxaVQdGA6QUe6fcBKea0m7V1kU3F5fdmKKFXM1ubTpk3UCRnndCzEXAUAS
 wetHMu+xmkIARXwDAwliPJadc700eOD3xEdBiXABtyQITqkmC/+6oSjiiFg7Z5Nb+Ccs
 9aox+zibPIMQLctStLVOx1yM7tS9I2hT+HWm178BgVMPcIT6pZJ5jEXu5JqvIT+TM2lu
 zgH7X8dkIXtXMSOxI7T5X9zD8ydig86hYEJy8wUc2349o42dM2HZwtQccBpAPFSsav+v
 8CAQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrAMu1sXU5u+ReMU3Qb2TZ4sHASC7UIeI2DW8m1q3Hl8Z87vp8GfSlZlFEa8Rn2g1rwR2k0uNt/+htX@nongnu.org
X-Gm-Message-State: AFuF++m5ca7sCWHx17d4bLnvKFzZtNzbYPPEHqjsLO67GyTl2eL1wM7e
 pAFcVvgnbirGzyMmztmpIPPepAxMuKZI9tR/z5sFrOiKmOor5MIya2kKhqzgbNh6hHZSdLQsrE+
 mT6ypnJR7kMcyTMBMX92btBhVWZbIqirgrY1EF4FeHQ==
X-Gm-Gg: AR+sD11XcBzweDz9croLAhy0Cy8/Odx+5BlpOqQAYi0gYoH/qEu6JQBdPgRRK9YU9u3
 Z+Nye4fb/mdGFErI7XjKmvoPmvy9A3PlWj2W+C80rEJKO/gIT9H68/dI5l54Od4N5SP3hiBBxaI
 zOKnf/Oeps1K9TvxRm1S4jUXmdL2X+rA0dFWk5RkZnguRZo8Yy0eOn8CRfgrakEYrxcKa1VY362
 cSCXz3plGbd4b74XF1KGjbIzewb+svU2ZzoWu/HwLhBu89de8IdpJe5EUQq05KBAWYSfESOJhGm
 DO7wX/2kgod8N6h75UCczW3JYFcF5yVR1/iaAijn30PXPI0QtYKeszXhgq9TrZK+8edmoBtdgJ2
 031o=
X-Received: by 2002:a17:90b:4b8b:b0:38f:efed:5448 with SMTP id
 98e67ed59e1d1-395812aa117mr18024528a91.8.1787204857123; Wed, 19 Aug 2026
 22:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260818172012.3052821-1-peterx@redhat.com>
 <20260818172012.3052821-6-peterx@redhat.com>
 <50d978ae-485b-4790-a2b0-fc78051de565@linaro.org>
In-Reply-To: <50d978ae-485b-4790-a2b0-fc78051de565@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 19 Aug 2026 23:47:25 -0600
X-Gm-Features: AcwNN1VF2mdbeRMOTwcEvk3xgT5ZkJFXfM8iGx_1ffFGoRX8wZ8IToJdLeumvRQ
Message-ID: <CANCZdfr792uu9e-1--YihnFwkc9oHVS7+=LS8LNUgw_9QjJ+jA@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] bsd-user: Remove 32bit host support in
 thunk_convert|print()
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Xu <peterx@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: multipart/alternative; boundary="000000000000a669d40659740e26"
Received-SPF: none client-ip=2607:f8b0:4864:20::102a;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x102a.google.com
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

--000000000000a669d40659740e26
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026, 1:48=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/18/26 10:20, Peter Xu wrote:
> > QEMU has switched to 64bit-only hosts for all system/user emulations.
> >
> > Signed-off-by: Peter Xu<peterx@redhat.com>
> > ---
> >   bsd-user/thunk.c | 47 +++--------------------------------------------
> >   1 file changed, 3 insertions(+), 44 deletions(-)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>


Reviewed-by: Warner Losh <imp@bsdimp.com>


r~
>
>

--000000000000a669d40659740e26
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 19, 2026, 1:48=E2=80=
=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org"=
>richard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">On 8/18/26 10:20, Peter Xu wrote:<br>
&gt; QEMU has switched to 64bit-only hosts for all system/user emulations.<=
br>
&gt; <br>
&gt; Signed-off-by: Peter Xu&lt;<a href=3D"mailto:peterx@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">peterx@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/thunk.c | 47 +++---------------------------------=
-----------<br>
&gt;=C2=A0 =C2=A01 file changed, 3 insertions(+), 44 deletions(-)<br>
<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank" rel=3D"noreferrer">richard.henderson@linaro.org</=
a>&gt;<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto"><br></div><div dir=3D"auto">Reviewed-by: Warner Losh &lt;<a href=3D"m=
ailto:imp@bsdimp.com">imp@bsdimp.com</a>&gt;</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote =
gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
r~<br>
<br>
</blockquote></div></div></div>

--000000000000a669d40659740e26--

