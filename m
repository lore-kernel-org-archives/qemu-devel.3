Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07418D26D8F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 18:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veHXz-0006pi-E3; Fri, 09 Jan 2026 13:49:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veHXt-0006Og-Fr
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 13:49:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veHXn-00055w-Km
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 13:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767984545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5W6rDDnNUOZowWCBxJw3MuXo7XRbh2t0JTfxu187h4E=;
 b=bvNQhFgCyyjgZGQi03iy4UZDSkRYxvh1mZ7auw77TkMN7XBz/47CYkTpPuUPzV7QH3TS4s
 TaOhzbctAqegQrBQw0ebgm9emNP78eoQ/m21h67dSWjkWehxR/bCsUJed64gZL0PTFlhcL
 sNM17IN4LHCEacm1CJzRT2vOukculTc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-LW4FL8sFP5CJHeFH9ByPTg-1; Fri, 09 Jan 2026 13:49:04 -0500
X-MC-Unique: LW4FL8sFP5CJHeFH9ByPTg-1
X-Mimecast-MFC-AGG-ID: LW4FL8sFP5CJHeFH9ByPTg_1767984543
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430fcb6b2ebso2900754f8f.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 10:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767984543; x=1768589343; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5W6rDDnNUOZowWCBxJw3MuXo7XRbh2t0JTfxu187h4E=;
 b=tvJbIMieSFWtTXE7unHkfsBytCLQhKFuSYS9NSCt+A+Bwj/UdhD5Pork0yJ4i/euKA
 5ppxcFEQgjUQgGX/r/lF/j415E6dnZHGXHURN/Rrhn7nclq7DnH7s/kB7GtL3KOPapN9
 pCY81HqPXieV3BTeCrZZ+yo8eRfrzcCXQXlle+KHQ2WYS+h6ZzmoNqpNQILpAvnt0uHS
 LJzwpdF9C4LFEa3S6JV9ym4pJ29bVNE10myUTJbOIv7iZdPrXzMFO/72zjcFiJ1bk8L6
 M1fShDGXh9kjClPaaY6UXqJ0MZgrDI8aVfNthq9BVgjYy6gxuu8s0Wr/aeV33GHqZX0F
 oOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767984543; x=1768589343;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5W6rDDnNUOZowWCBxJw3MuXo7XRbh2t0JTfxu187h4E=;
 b=XodKPTKEwhBw4TEzWmrgR9z0X0079BT+WNGVJ0kYCfwU1K266TGHXqRFzllo3nGD5R
 vjLXBhaguBuU4COdbhdntFNmVFlUnoK7WPobxCTAYl1T2+GfATUbeQ8t2033WL2l3hkI
 8kvphFuszCjOru0/MPIIjATXNNkvI7X/4m5W2q/GIwGTz8Nyu6Xy6woulUsEqQUSZcH3
 0ja5PqHKmU1ABAdLbt6MFBop7DP1rqI1OPcvzzKh6nlcPTGzj3akGX8SnkRoN8x36uIK
 xVM8bzM8Xxz1zRA4NHID/QmgA/xUS8YU8sMMCT+BEV9MTLa8WRAE/Q4XOyLen95jHaQA
 gJ/g==
X-Gm-Message-State: AOJu0YzEkYBP/zkzqh+lGl0MnQFVeeBSm3jL3y/tNWMbfUYvzor4LahL
 a2RguYiHXwSGKORbM/u1KT9AKR2xmV3QkZ0nFRVBg9dWKt2DIfCUq3iqBoiT5QkqCG0PFJ9ZxNn
 DkxHKzKYecLyaS49/Nbiz0KGhsvrRjTCA4rMXYJ2fHejvt0Vg25LSsOgWkFg+k/O7Z2miuNaVSy
 1RpxY/dGknOQ3Wqo2UDP+aSDIk5g143GE=
X-Gm-Gg: AY/fxX7dgW8H9fYCf48Z6pTffgwzwuFD3xlcDvqespQJcU713ruMfhEBtez7sX/ZkDc
 6ahKhGDdbQ14IS5SaWZZtr4smPN6iz7rw1htRFARDTb2v/iCu10BaUQK8KfmAlC3csp65Pa0QzO
 tk1k2wlZ5f9hWqiGIjgMpem+PWud5/8FYvA/q4qLkSGoF14ABOK+CjmwZU/DvX8zwfUAFU4nJge
 Au4ORnABJbvLeYA30GseGLTdCB3jwZNQufFYLyNdlqYmX16N/tqscxwrUWqNvsvmcjfSw==
X-Received: by 2002:a05:6000:258a:b0:431:1ae:a3be with SMTP id
 ffacd0b85a97d-432c36280damr12506119f8f.3.1767984542691; 
 Fri, 09 Jan 2026 10:49:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDJ93d/BRXNlPoHPM4HC++qcO9S/vM64yrDJ3uyv2cd6+E+hK25BGpCgr1OkoXt/vYmstW1hxSOYDYK3gyVbU=
X-Received: by 2002:a05:6000:258a:b0:431:1ae:a3be with SMTP id
 ffacd0b85a97d-432c36280damr12506103f8f.3.1767984542298; Fri, 09 Jan 2026
 10:49:02 -0800 (PST)
MIME-Version: 1.0
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-15-pierrick.bouvier@linaro.org>
 <5883ace8-ec8c-4632-9761-615462582254@redhat.com>
 <13d81894-53c2-4fda-86da-c9ec484c6ef3@linaro.org>
 <CABgObfb916FeNESDjOhkGx9wqNXqwovWDVx1breg6E8vF9QYvg@mail.gmail.com>
 <7e742b47-7c7c-4d96-9462-2d98d678a62f@linaro.org>
In-Reply-To: <7e742b47-7c7c-4d96-9462-2d98d678a62f@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 9 Jan 2026 19:48:51 +0100
X-Gm-Features: AZwV_QgwNxybiNYqYtcxx9h226dnR3cWk8On071wwp_4HX7cM41tU20s8khRt5E
Message-ID: <CABgObfY=ayc6vmDGJ-CKUgRYKC5APFrf502-OPgQDTud5n4-3Q@mail.gmail.com>
Subject: Re: [PATCH 14/29] include/tcg/tcg-op.h: introduce TARGET_ADDRESS_BITS
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Jim MacArthur <jim.macarthur@linaro.org>, Anton Johansson <anjo@rev.ng>
Content-Type: multipart/alternative; boundary="0000000000009cc9270647f8fac6"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000009cc9270647f8fac6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il ven 9 gen 2026, 19:35 Pierrick Bouvier <pierrick.bouvier@linaro.org> ha
scritto:

> > The problem is that dropping target_long in CPUState would be
> > inefficient. For example i386 registers occupy 32 bytes vs. 256 for
> > x86_64. So I would like to keep 32-bit registers for the 32-bit single-
> > target binary.
> >
>
> I agree, and that's why the current solution is not the final word on
> this question. My position on the single binary is that runtime
> compromises can be acceptable on our translation path (since it's not
> where we spend most of our time anyway), but definitely not on code
> generated by tcg, which has to be optimal.
>

I think it's not that absolute for dual-size targets. For x86 I would be
okay if the i386 target used essentially the x86-64 CPUState and frontend
when compiled as part of the single binary, despite the extra space used by
registers. The only difference would be that the  64-bit CPU models are not
available (or their long-mode feature flag is masked) and therefore
entering 64-bit mode is not possible.

Anyhow, it's all food for later thought. But it explains why my first idea
was to isolate TARGET_LONG_BITS and yours was to abstract it.

Paolo


> In the first version of this series, I defined TCGv as an opaque type
> (i.e. not typedef to i32 or i64), and wrote wrappers for tcg_gen_* ops
> that were casting it to appropriate type and called the i32 or i64
> variants based on current context. After talking with Richard, I
> understood it was not useful for target/arm, since code has been cleanly
> splitted between 32/64 bits, so dropped it for the TCG_ADDRESS_BITS
> approach.
>
> That said, I still think the opaque type + wrapper approach has its
> place for some architectures. It could be used for code where rewriting
> is too complicated, and still allow to generate efficient code. The
> downside is that we need some boilerplate in headers to generate this,
> but it's not something a macro can't help to deal with.
>
> > Compared to the current mechanism, it decouples the choice of
> > TARGET_LONG_BITS from configs/targets/ and makes it possible for target=
/
> > */ to pick its preferred length when built for the single binary.
> >
> > But anyway this was just a brain dump=E2=80=94we are in sync for what i=
s needed
> > for this series.
> >
> >     With Philippe, we introduced target-info.h, to precisely find this
> >     information at runtime, with target_long_bits().
> >     As well, as you can see in codebase, target_long_bits() is not used
> in
> >     many places, and especially, it's not needed anywhere in target/arm=
.
> So
> >     it does not seem needed to keep it alive.
> >
> >
> > I agree that target_long_bits() should be needed almost nowhere (maybe
> > it's needed for VMSTATE_UINTTL migration but not much else) because
> > ideally all use of target_long/ulong would really be confined to target=
/
> > and not be in common code.
> >
> > It could be called like an x86_ulong, but it would have to be redone
> > almost the same across all the dual-size targets, hence it's easier to
> > keep the current name and provide a common mechanism.
> >
> > Thanks,
> >
> > Paolo
> >
> >     Thanks for the feedback,
> >     Pierrick
> >
>
>

--0000000000009cc9270647f8fac6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 9 gen 2026, 19:35 Pierric=
k Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@linaro.org">pierrick.bouvi=
er@linaro.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">&gt; The problem is that dropping target_long in CPUState=
 would be <br>
&gt; inefficient. For example i386 registers occupy 32 bytes vs. 256 for <b=
r>
&gt; x86_64. So I would like to keep 32-bit registers for the 32-bit single=
- <br>
&gt; target binary.<br>
&gt;<br>
<br>
I agree, and that&#39;s why the current solution is not the final word on <=
br>
this question. My position on the single binary is that runtime <br>
compromises can be acceptable on our translation path (since it&#39;s not <=
br>
where we spend most of our time anyway), but definitely not on code <br>
generated by tcg, which has to be optimal.<br></blockquote></div></div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">I think it&#39;s not that absolut=
e for dual-size targets. For x86 I would be okay if the i386 target used es=
sentially the x86-64 CPUState and frontend when compiled as part of the sin=
gle binary, despite the extra space used by registers. The only difference =
would be that the=C2=A0 64-bit CPU models are not available (or their long-=
mode feature flag is masked) and therefore entering 64-bit mode is not poss=
ible.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Anyhow, it&#39;s a=
ll food for later thought. But it explains why my first idea was to isolate=
 TARGET_LONG_BITS and yours was to abstract it.</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"=
auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
<br>
In the first version of this series, I defined TCGv as an opaque type <br>
(i.e. not typedef to i32 or i64), and wrote wrappers for tcg_gen_* ops <br>
that were casting it to appropriate type and called the i32 or i64 <br>
variants based on current context. After talking with Richard, I <br>
understood it was not useful for target/arm, since code has been cleanly <b=
r>
splitted between 32/64 bits, so dropped it for the TCG_ADDRESS_BITS <br>
approach.<br>
<br>
That said, I still think the opaque type + wrapper approach has its <br>
place for some architectures. It could be used for code where rewriting <br=
>
is too complicated, and still allow to generate efficient code. The <br>
downside is that we need some boilerplate in headers to generate this, <br>
but it&#39;s not something a macro can&#39;t help to deal with.<br>
<br>
&gt; Compared to the current mechanism, it decouples the choice of <br>
&gt; TARGET_LONG_BITS from configs/targets/ and makes it possible for targe=
t/ <br>
&gt; */ to pick its preferred length when built for the single binary.<br>
&gt; <br>
&gt; But anyway this was just a brain dump=E2=80=94we are in sync for what =
is needed <br>
&gt; for this series.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0With Philippe, we introduced target-info.h, to prec=
isely find this<br>
&gt;=C2=A0 =C2=A0 =C2=A0information at runtime, with target_long_bits().<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0As well, as you can see in codebase, target_long_bi=
ts() is not used in<br>
&gt;=C2=A0 =C2=A0 =C2=A0many places, and especially, it&#39;s not needed an=
ywhere in target/arm. So<br>
&gt;=C2=A0 =C2=A0 =C2=A0it does not seem needed to keep it alive.<br>
&gt; <br>
&gt; <br>
&gt; I agree that target_long_bits() should be needed almost nowhere (maybe=
 <br>
&gt; it&#39;s needed for VMSTATE_UINTTL migration but not much else) becaus=
e <br>
&gt; ideally all use of target_long/ulong would really be confined to targe=
t/ <br>
&gt; and not be in common code.<br>
&gt; <br>
&gt; It could be called like an x86_ulong, but it would have to be redone <=
br>
&gt; almost the same across all the dual-size targets, hence it&#39;s easie=
r to <br>
&gt; keep the current name and provide a common mechanism.<br>
&gt; <br>
&gt; Thanks,<br>
&gt; <br>
&gt; Paolo<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Thanks for the feedback,<br>
&gt;=C2=A0 =C2=A0 =C2=A0Pierrick<br>
&gt; <br>
<br>
</blockquote></div></div></div>

--0000000000009cc9270647f8fac6--


