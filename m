Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC71C982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 09:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7UjW-0005k4-IW; Fri, 18 Sep 2026 05:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7UjU-0005hp-28
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 05:18:12 -0400
Received: from mail-ed2-x26.google.com ([2a00:1450:4864:33::26])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7UjS-0001cu-8Y
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 05:18:11 -0400
Received: by mail-ed2-x26.google.com with SMTP id
 4fb4d7f45d1cf-6aa13e194easo800507a12.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 02:18:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789723089; cv=none;
 d=google.com; s=arc-20260327;
 b=lEu8yvqu8RXmJ0gdJc2ZZNd6UBYG8WK8E5oQ9dGuF8YDczKR5kVoukqwXCwpoJrkMh
 Sr15C9rkuRKE5QN+ZvYd2zP+wkd4/FztgLKyjpwQ4sul5k8RR0YhFjVIE3KXnY1EYBO+
 l+1ER5dt6UJ3t1dt8OgLpNFKVyQHu07SZHiuIOT7rE1hyilWUfwbFtyQD0v950oHEtgi
 r0XeJyWYVEFEC9sPFIWV7wd7Ca4aK4gGiTUN9WHfAEpUYIg4bsqjjUvrtBItrRDKki+d
 +xjUnrAvOzRihnKFKunNYVhlaWEfl+YrkEWP4XdHXTB5jbdRVdEySgIDikTwGd9sFixC
 4gug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cexpEaDGGB36NWj2P0w0cT6MqbxnZouittz5QFOj9fI=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=KqNdh/mNJW9LKUHI6DMOCF45/Kx0NPrmgULw5+5JojulzH3CpMm0yHglWtjt27IB4l
 xbDty1vWAuP2DsfCDOxT2xY1kgKKy5DzNxBSYIwgJS+ZHj1u5CfeMsduf9rJ3AQF7crC
 8/pDBYQeDsg0mOi7A5dBUYzpVEJsvGd26n9P6cEBnXOXc/gk1UgWGck4ODVNKHctWKIa
 jc6BP7YC3bkF+l6zkc1Aw4dx/++MR3Tvi4mv4gq+eLNFCbpFFkl+UuH4Td3ctaydP5eS
 6aUS4Tzy7BuyUfW2kSJ+HMrVg8ACRl9Q+C9U3Q0gK7/UC/JB8Li+hNnWQDQPGFz6PI30
 9WUw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789723089; x=1790327889; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cexpEaDGGB36NWj2P0w0cT6MqbxnZouittz5QFOj9fI=;
 b=aKpjHclytZtBipO19choaO3sys8dbGCkhxdh9rtkRJrmFkApQ/E12zMVNB7mJfL8eG
 gAsyiM9XkMFRog1n1Dfzb4hTXsMVOavnhCQzsdCMj52+Da1WUgUNKRoIfeAEBzwoNAcP
 bCMOnD75UzWVTomH3HyAru+6wm/QH537+Yf9oSAAkmYBz9MMT8liV+F7aQnWGD3qhmoM
 OYRH1wL3SNmW6HcxRRhodoZMmaa5TjIMWjU2Cbjj9EyRExxOHG8ugwLQuj6+dm8THG/1
 2mEsoeOd5J25rGkcmZAv/EeEpE7JzdYEeBEusZC+XA+JlPxRtm0ofLCFbI4eK7yE72fK
 ON5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789723089; x=1790327889;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cexpEaDGGB36NWj2P0w0cT6MqbxnZouittz5QFOj9fI=;
 b=krdRXZEa+2R7EjgGNY4lMCy6dIxRmRqY+FynGySamdeI7J7vfU8rwNTwol4ou9gEDQ
 bveWWmSJQbL9iOf/iktKRK8dKa6Kh2QNGJ0w44LgkVm9htq2adyIZDrWPz+2d8b/uuQx
 ud9b+PsV8DM9Z6QHt6T2MZkTz4imz3vXPlChzkg728VxpvS3cJRHUnpHmEkGjTeDoFEA
 dz6n+HGS6zHDILxJW8nA0K67y57tbuWidrZv4MXBF5V7O7vsPP6Nz2XlzIjpujtqK8wZ
 nPQ8E9LRh9WtNqKjJ98IkL8qZfZVGtM5fpIqUkRs9qKBVEES+/xNDA/pESb06Sw2VMBY
 pcvA==
X-Gm-Message-State: AFuF++nKXwT9Yed98J48KhhNzwiNfoi5gK+rJURKFaHcx0hpOuE9kRgs
 6emsAtIofrTLLUrHEtG5NY89JBZ3QdQIY5sONJzB/owbcXm0EAAEgYEnnLDskJrMRKA/2tayZKt
 urpyaq8WMirTZw7dRmYwHiCDoXwWupkAcIljd8/O8Yg==
X-Gm-Gg: AYBFou15C4aPBX8lKmGJpPdm+Im6DWBn3oBvDaBQM60cmdJjjoZktXotvtjMrz3Trr9
 HBwZw0fpnm9JhDfD0LcdNWTPcry/w0EAkv99F5WUb/nIgEpY8dpI0YTlm167njwr6WtacVwztQ6
 pUss4bFycGP8feXfYeZfJfLP3IkVG15Sb5xh9uhhfe/UBbygtwN6vMfOzOrjqn+Pncuo75fep9g
 nbO0UyRYso6402gttHHzD6nbFhLW7JH+DKyssQJGuzO4iYRZCtHXb4yhk+vjEdnRiDmhYSDBxV7
 RiGXL14M9b+1AoJYyMFhPvTUSc+tolllRd0D6sRGHA/pBUELzLZ2HehIROBYoxc7XQ==
X-Received: by 2002:a05:6402:24dc:b0:6a7:ee56:8156 with SMTP id
 4fb4d7f45d1cf-6aa579ad808mr627209a12.36.1789723088507; Fri, 18 Sep 2026
 02:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260918004225.827-1-luoyonggang@gmail.com>
 <20260918004225.827-4-luoyonggang@gmail.com>
 <724e2043-fbd3-4c1d-85b3-a2e6056b9ec8@linaro.org>
 <CAE2XoE8X8cAS0CsQ52pgBXsrbND14bL03SehRnx64tCGSOxrWw@mail.gmail.com>
 <975a89d3-3614-494e-bdc4-3d892658f095@linaro.org>
In-Reply-To: <975a89d3-3614-494e-bdc4-3d892658f095@linaro.org>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 18 Sep 2026 17:17:52 +0800
X-Gm-Features: AcwNN1VPAOtFQGt39bUNUXlAfMC664jutReThqDuSTP16jy6xd6XWfznJ443UG4
Message-ID: <CAE2XoE8HqY3XH-myj1Y-w4g9FM1mbzFXU+cf-3pkYeV8-quRog@mail.gmail.com>
Subject: Re: [PATCH 03/21] accel/tcg: add helper raise_excp
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000efd5cc065bbe607a"
Received-SPF: pass client-ip=2a00:1450:4864:33::26;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x26.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000efd5cc065bbe607a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 4:09=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:
>
> On 9/17/26 18:06, Yonggang Luo wrote:
> >  > (1) Put the comment before the implementation, not the header.
> >  > That avoids whatever you're concerned about vs patch 2.
> >
> > Indeed I tried, and I found basically all tcg's gen_ function have no
> > comment(detect by the auto-tools),
> > and it's parameter arg0 arg1 arg2 that can not understand at all; and
> > can not link to the impl
> > helper_* that defined as HELPEP(X) that makes me reading the tcg code
> > very hard.
>
> Ah, new-fangled tooling.  Something I don't use.

I

>
> To me, the only thing that's interesting is the implementation.
> That is, helper_foo.  The wrapper, gen_helper_foo is not interesting.
>
> Since I don't use it, I'm not sure what to suggest.  Putting big block
> comments in what are essentially templates does not make much sense.
> Is there something the tooling can use to cross-reference the "real" code=
?

Using `clangd` can do that, any IDE along with clangd  e Language Server
Protocol (LSP)  will work with that.

>
> >  > (2) Don't pass an extra argument that changes behavior like this.
> >  > Better to have two separate functions, each doing one thing.
> >
> > how about gen_helper_raise_excp and gen_helper_raise_excp_restore
>
> Sure.
>
> >  > (3) Maybe better to place the functions in cpu-exec-common.c, so tha=
t
> >  > the compiler can see all the definitions at once.
> >
> > Do you mean do not use  DEF_HELPER_FLAGS_3 at all?
> Absolutely not.  I meant put helper_raise_excp* in cpu-exec-common.c
> instead of tcg-runtime.c.

Thanks, now I know how to go next,

void HELPER(raise_excp)(CPUArchState *env, uint32_t exception)
{
    cpu_loop_exit_excp(env_cpu(env), exception, 0);
}

or

void helper_raise_excp(CPUArchState *env, uint32_t exception)
{
    cpu_loop_exit_excp(env_cpu(env), exception, 0);
}


which I should use? I'll prefer  HELPER(raise_excp)

>
>
> r~



--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000efd5cc065bbe607a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br><br>On Fri, Sep 18, =
2026 at 4:09=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.hen=
derson@linaro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt; w=
rote:<br>&gt;<br>&gt; On 9/17/26 18:06, Yonggang Luo wrote:<br>&gt; &gt; =
=C2=A0&gt; (1) Put the comment before the implementation, not the header.<b=
r>&gt; &gt; =C2=A0&gt; That avoids whatever you&#39;re concerned about vs p=
atch 2.<br>&gt; &gt;<br>&gt; &gt; Indeed I tried, and I found basically all=
 tcg&#39;s gen_ function have no<br>&gt; &gt; comment(detect by the auto-to=
ols),<br>&gt; &gt; and it&#39;s parameter arg0 arg1 arg2 that can not under=
stand at all; and<br>&gt; &gt; can not link to the impl<br>&gt; &gt; helper=
_* that defined as HELPEP(X) that makes me reading the tcg code<br>&gt; &gt=
; very hard.<br>&gt;<br>&gt; Ah, new-fangled tooling.=C2=A0 Something I don=
&#39;t use.<br><br>I<br><br>&gt;<br>&gt; To me, the only thing that&#39;s i=
nteresting is the implementation.<br>&gt; That is, helper_foo.=C2=A0 The wr=
apper, gen_helper_foo is not interesting.<br>&gt;<br>&gt; Since I don&#39;t=
 use it, I&#39;m not sure what to suggest.=C2=A0 Putting big block<br>&gt; =
comments in what are essentially templates does not make much sense.<br>&gt=
; Is there something the tooling can use to cross-reference the &quot;real&=
quot; code?<br><br>Using `clangd` can do that, any IDE along with clangd =
=C2=A0e Language Server Protocol (LSP) =C2=A0will work with that.<br><br>&g=
t;<br>&gt; &gt; =C2=A0&gt; (2) Don&#39;t pass an extra argument that change=
s behavior like this.<br>&gt; &gt; =C2=A0&gt; Better to have two separate f=
unctions, each doing one thing.<br>&gt; &gt;<br>&gt; &gt; how about gen_hel=
per_raise_excp and gen_helper_raise_excp_restore<br>&gt;<br>&gt; Sure.<br>&=
gt;<br>&gt; &gt; =C2=A0&gt; (3) Maybe better to place the functions in cpu-=
exec-common.c, so that<br>&gt; &gt; =C2=A0&gt; the compiler can see all the=
 definitions at once.<br>&gt; &gt;<br>&gt; &gt; Do you mean do not use =C2=
=A0DEF_HELPER_FLAGS_3 at all?<br>&gt; Absolutely not.=C2=A0 I meant put hel=
per_raise_excp* in cpu-exec-common.c<br>&gt; instead of tcg-runtime.c.<br><=
br>Thanks, now I know how to go next,=C2=A0</div><div dir=3D"ltr"><br>void =
HELPER(raise_excp)(CPUArchState *env, uint32_t exception)<br>{<br>=C2=A0 =
=C2=A0 cpu_loop_exit_excp(env_cpu(env), exception, 0);<br>}<br><br>or<br><b=
r>void helper_raise_excp(CPUArchState *env, uint32_t exception)<div>{</div>=
=C2=A0 =C2=A0 cpu_loop_exit_excp(env_cpu(env), exception, 0);<br><div>}<br>=
<br><br>which I should use? I&#39;ll prefer=C2=A0

HELPER(raise_excp)<br><br>&gt;<br>&gt;<br>&gt; r~<br><br><br><br>--<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=
=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</di=
v></div>
</div>
</div>

--000000000000efd5cc065bbe607a--

