Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E25D26D7B
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 17:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veGW9-0001ip-QZ; Fri, 09 Jan 2026 12:43:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veGW2-0001gB-UY
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 12:43:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veGW0-0003I1-C4
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 12:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767980590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k8V2Lyb3OV+0Rd8HFWOqIJgtFyp69RlgU0QSLI8dExo=;
 b=hqIhRaiIZxJHFxXS4YK+MCpcmgyhxkV9HVHndMEP1oXMicVpUSi9nW3dEbyNaHMA7W0MWG
 fyLMJS9Y06KdffCWb0dosPmULIWJJ6Y//eL9Sif8jsiZW7t5gwbe9CcyDdnpiDGJJu4wit
 ljN/gFATu5dPGBW/WW7+KTS3hOiUTe4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-cxzx7J5uN7-E_CC6CixI5A-1; Fri, 09 Jan 2026 12:43:08 -0500
X-MC-Unique: cxzx7J5uN7-E_CC6CixI5A-1
X-Mimecast-MFC-AGG-ID: cxzx7J5uN7-E_CC6CixI5A_1767980587
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4775d110fabso43208045e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 09:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767980587; x=1768585387; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k8V2Lyb3OV+0Rd8HFWOqIJgtFyp69RlgU0QSLI8dExo=;
 b=sJ4unZsxOKLADfck041fiFG5Ijth090ny+kuAk/W8Ualjvozk8urmVLLAZeFSecYkO
 U63bmXcNo0h57Sz0QYMm0TMCCXlZ4zNTRtbdsjKql08A6U5IXqlzeAuz0DHbAU6RKUF8
 92sYHKE5Sh/nY+Ko1r+e0YA4BFqIAA9bt7oBLLhkoR12CFJoMKCAHsTlKdr3SRcp+qoH
 mzWIXObgqOxKHAdJRh0kSnL7sCiuEp2CikEicJfhUQ4ixH1A4XTV/SY0JXMxL1z4OJpT
 cMBZKz4sKVWlCXCeIZxY+IsnhLJZisgdD+4sr3h8Wfz7zFjnG338y6cm8thKlDMeC5Fl
 k3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767980587; x=1768585387;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k8V2Lyb3OV+0Rd8HFWOqIJgtFyp69RlgU0QSLI8dExo=;
 b=QY2DM/2HDYuxUGRiC2k2ldRFie93WyQgcH8Oc/gGLHe1LTJmH6kW1t64m0StabJq6x
 tyYl/qnTavnQMgOjp7rqCCE/81SONgR2nQNDWLqqVOUdfejLSPuqW/EXyX8EBlhOnw1z
 X/SM4s0kBLlL9dU8VgD+udn3VrnA+vD43xDlXOE7FVhSCiMNYsIs0DM9MoSkVLnA//iw
 ykZiF/YdpuanKMpaSBw3AX7NLxe4ksQjb68HE+UU/euRDD6GSKAkmR4L0FGWN4Vi+of/
 qZW46gNWpyoiLuuru3KNA1055h99akCoEbyaESC/nDdGC1SEpPJmYCWFprR4ypLtIN2h
 LdaA==
X-Gm-Message-State: AOJu0Yw+bPhlvv7Aum6cB78RiZ66+vIiu/d/KTrLxHDr50KyKnLEtr8P
 Ya8jnlrKav5FG1WWSqSf0/d6MWH7mN4CIKsuOh4qb5XbBjRHtACsucE0xPqfU9sPid6Q+CxoOIs
 EucCsTY9H4F3ZS+FqOgErsW88MFzzoHZrntl01zx/HMWevbDeWJZ27+jyse7ctANEKK0Ppupe5y
 fPFtakeGIelDS+T6ofuuqAeV6t6hQ3YbA=
X-Gm-Gg: AY/fxX66svPDL1nSY3w35ZOZnjioWLl+4adIIVvHQjWG2Ahww69JJVV5owVp7Goi8cy
 3qlZpEM3oawlz5R8GChCn1sTod4BJ6OP6m1eVWGa5SunZwP+JXTAMkm9y83Lxbhk2sJRqP39qUx
 vnLmz9Cg1dFRnkKyy8HO2cz2JcoVwftVxFBCO83WKsOy7MKQdQ8JRCSbJLYH13Pn3PmLalXKEnL
 rHVOYuVK1fwah9z7LF+6sq6lLuNj7apgmQd0fL/eq+EvHx2BVPRRm3DdkC7yOtftvIw5w==
X-Received: by 2002:a05:6000:2891:b0:432:8651:4070 with SMTP id
 ffacd0b85a97d-432c3760e09mr12687722f8f.10.1767980587419; 
 Fri, 09 Jan 2026 09:43:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEliQ450K3NcepqOIPhqVr64YC0PVkX3nrYR2ZQf8l8oyg3pvothnd4qbHQOZPbH1PAWSMm2/qxR6sXlQdwNUc=
X-Received: by 2002:a05:6000:2891:b0:432:8651:4070 with SMTP id
 ffacd0b85a97d-432c3760e09mr12687701f8f.10.1767980587012; Fri, 09 Jan 2026
 09:43:07 -0800 (PST)
MIME-Version: 1.0
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-15-pierrick.bouvier@linaro.org>
 <5883ace8-ec8c-4632-9761-615462582254@redhat.com>
 <13d81894-53c2-4fda-86da-c9ec484c6ef3@linaro.org>
In-Reply-To: <13d81894-53c2-4fda-86da-c9ec484c6ef3@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 9 Jan 2026 18:42:56 +0100
X-Gm-Features: AZwV_QiJrdvrwW9EGYFY0W7GR1SPlslHaABjRxl4sdmrCVV9eDQVfpvsuoUcFQQ
Message-ID: <CABgObfb916FeNESDjOhkGx9wqNXqwovWDVx1breg6E8vF9QYvg@mail.gmail.com>
Subject: Re: [PATCH 14/29] include/tcg/tcg-op.h: introduce TARGET_ADDRESS_BITS
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Jim MacArthur <jim.macarthur@linaro.org>, Anton Johansson <anjo@rev.ng>
Content-Type: multipart/alternative; boundary="000000000000dbe41b0647f80e8c"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000dbe41b0647f80e8c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il ven 9 gen 2026, 17:21 Pierrick Bouvier <pierrick.bouvier@linaro.org> ha
scritto:

> > For them, the death of target_long/target_ulong is not really possible,
> > because they will have to reinvent include/exec/target_long.h for their
> > CPUStates.
> >
>
> At this time, I don't have a simple solution to provide to workaround
> this. As long as compilation units are duplicated, you will have
> duplicated symbols for any extern symbol, thus preventing to link the
> final qemu-system binary. So duplication has to be eliminated, one way
> or another. And multiple type definitions is a barrier for this.
>

Yes, the idea is that if the "single binary" will include both i386 and
x86_64 targets, they will both use the TARGET_LONG_BITS=3D=3D64 version (us=
ing
it also for the 32-bit target) of CPUState, of the TCG frontend and
helpers, etc.

IOW the single binary could build a third copy of target/i386, or reuse the
x86_64-softmmu one.

By making all files for an architecture "common", TARGET_LONG_BITS is
> eliminated by design, since it's a poisoned identifier.
>

Good point.

> include/exec/target_long32.h
> > ----------------------------
> > #ifndef TARGET_LONG_BITS
> > #define TARGET_LONG_BITS 32
> > #endif
> > #define TARGET_ADDRESS_BITS 32
> > #define TARGET_LONG_SIZE 4
> > typedef int32_t target_long;
> > typedef uint32_t target_ulong;
> > #define TARGET_FMT_lx "%08x"
> > #define TARGET_FMT_ld "%d"
> > #define TARGET_FMT_lu "%u"
> > #define MO_TL MO_32
> >
> > include/exec/target_long64.h
> > ----------------------------
> > #ifndef TARGET_LONG_BITS
> > #define TARGET_LONG_BITS 64
> > #endif
> > #define TARGET_ADDRESS_BITS 64
> > #define TARGET_LONG_SIZE 8
> > typedef int64_t target_long;
> > typedef uint64_t target_ulong;
> > #define TARGET_FMT_lx "%016" PRIx64
> > #define TARGET_FMT_ld "%" PRId64
> > #define TARGET_FMT_lu "%" PRIu64
> > #define MO_TL MO_64
> >
> > ... and use them in include/exec/target_long.h:
> >
> > include/exec/target_long.h:
> > #ifndef TARGET_LONG_BITS
> > #error TARGET_LONG_BITS not defined
> > #elif TARGET_LONG_BITS =3D=3D 32
> > #include "exec/target_long32.h"
> > #elif TARGET_LONG_BITS =3D=3D 64
> > #include "exec/target_long64.h"
> > #endif
> >
> > Then the single-size targets can replace TARGET_LONG_BITS with:
> > - a "#define TCG_ADDRESS_BITS" in their translate.c
> > - a #include "exec/target_longNN.h" in their cpu.h.
> >
> > Dual-size targets, instead, can add to their cpu.h an initial stanza
> > like this:
> >
> > #ifdef TARGET_I386
> > #include "exec/target_long32.h"
> > #else
> > #include "exec/target_long64.h" // x86_64 or single binary
> > #endif
> >
> > and keep using target_long.
> >
>
> I'm not sure what we gain from this header mechanics, wouldn't that be
> better to eradicate TARGET_LONG_BITS completely instead?
>

The problem is that dropping target_long in CPUState would be inefficient.
For example i386 registers occupy 32 bytes vs. 256 for x86_64. So I would
like to keep 32-bit registers for the 32-bit single-target binary.

Compared to the current mechanism, it decouples the choice of
TARGET_LONG_BITS from configs/targets/ and makes it possible for target/*/
to pick its preferred length when built for the single binary.

But anyway this was just a brain dump=E2=80=94we are in sync for what is ne=
eded for
this series.

With Philippe, we introduced target-info.h, to precisely find this
> information at runtime, with target_long_bits().
> As well, as you can see in codebase, target_long_bits() is not used in
> many places, and especially, it's not needed anywhere in target/arm. So
> it does not seem needed to keep it alive.
>

I agree that target_long_bits() should be needed almost nowhere (maybe it's
needed for VMSTATE_UINTTL migration but not much else) because ideally all
use of target_long/ulong would really be confined to target/ and not be in
common code.

It could be called like an x86_ulong, but it would have to be redone almost
the same across all the dual-size targets, hence it's easier to keep the
current name and provide a common mechanism.

Thanks,

Paolo

Thanks for the feedback,
> Pierrick
>
>

--000000000000dbe41b0647f80e8c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 9 gen 2026, 17:21 Pierrick Bouvier &lt;<a href=
=3D"mailto:pierrick.bouvier@linaro.org" target=3D"_blank" rel=3D"noreferrer=
">pierrick.bouvier@linaro.org</a>&gt; ha scritto:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">&gt; For them, the death of target_long/t=
arget_ulong is not really possible,<br>
&gt; because they will have to reinvent include/exec/target_long.h for thei=
r<br>
&gt; CPUStates.<br>
&gt;<br>
<br>
At this time, I don&#39;t have a simple solution to provide to workaround <=
br>
this. As long as compilation units are duplicated, you will have <br>
duplicated symbols for any extern symbol, thus preventing to link the <br>
final qemu-system binary. So duplication has to be eliminated, one way <br>
or another. And multiple type definitions is a barrier for this.<br></block=
quote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yes, the id=
ea is that if the &quot;single binary&quot; will include both i386 and x86_=
64 targets, they will both use the TARGET_LONG_BITS=3D=3D64 version (using =
it also for the 32-bit target) of CPUState, of the TCG frontend and helpers=
, etc.</div><div dir=3D"auto"><br></div><div dir=3D"auto">IOW the single bi=
nary could build a third copy of target/i386, or reuse the x86_64-softmmu o=
ne.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_=
quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">By making all file=
s for an architecture &quot;common&quot;, TARGET_LONG_BITS is <br>
eliminated by design, since it&#39;s a poisoned identifier.<br></blockquote=
></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Good point.</div=
><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
&gt; include/exec/target_long32.h<br>
&gt; ----------------------------<br>
&gt; #ifndef TARGET_LONG_BITS<br>
&gt; #define TARGET_LONG_BITS 32<br>
&gt; #endif<br>
&gt; #define TARGET_ADDRESS_BITS 32<br>
&gt; #define TARGET_LONG_SIZE 4<br>
&gt; typedef int32_t target_long;<br>
&gt; typedef uint32_t target_ulong;<br>
&gt; #define TARGET_FMT_lx &quot;%08x&quot;<br>
&gt; #define TARGET_FMT_ld &quot;%d&quot;<br>
&gt; #define TARGET_FMT_lu &quot;%u&quot;<br>
&gt; #define MO_TL MO_32<br>
&gt; <br>
&gt; include/exec/target_long64.h<br>
&gt; ----------------------------<br>
&gt; #ifndef TARGET_LONG_BITS<br>
&gt; #define TARGET_LONG_BITS 64<br>
&gt; #endif<br>
&gt; #define TARGET_ADDRESS_BITS 64<br>
&gt; #define TARGET_LONG_SIZE 8<br>
&gt; typedef int64_t target_long;<br>
&gt; typedef uint64_t target_ulong;<br>
&gt; #define TARGET_FMT_lx &quot;%016&quot; PRIx64<br>
&gt; #define TARGET_FMT_ld &quot;%&quot; PRId64<br>
&gt; #define TARGET_FMT_lu &quot;%&quot; PRIu64<br>
&gt; #define MO_TL MO_64<br>
&gt; <br>
&gt; ... and use them in include/exec/target_long.h:<br>
&gt; <br>
&gt; include/exec/target_long.h:<br>
&gt; #ifndef TARGET_LONG_BITS<br>
&gt; #error TARGET_LONG_BITS not defined<br>
&gt; #elif TARGET_LONG_BITS =3D=3D 32<br>
&gt; #include &quot;exec/target_long32.h&quot;<br>
&gt; #elif TARGET_LONG_BITS =3D=3D 64<br>
&gt; #include &quot;exec/target_long64.h&quot;<br>
&gt; #endif<br>
&gt; <br>
&gt; Then the single-size targets can replace TARGET_LONG_BITS with:<br>
&gt; - a &quot;#define TCG_ADDRESS_BITS&quot; in their translate.c<br>
&gt; - a #include &quot;exec/target_longNN.h&quot; in their cpu.h.<br>
&gt; <br>
&gt; Dual-size targets, instead, can add to their cpu.h an initial stanza<b=
r>
&gt; like this:<br>
&gt; <br>
&gt; #ifdef TARGET_I386<br>
&gt; #include &quot;exec/target_long32.h&quot;<br>
&gt; #else<br>
&gt; #include &quot;exec/target_long64.h&quot; // x86_64 or single binary<b=
r>
&gt; #endif<br>
&gt; <br>
&gt; and keep using target_long.<br>
&gt;<br>
<br>
I&#39;m not sure what we gain from this header mechanics, wouldn&#39;t that=
 be <br>
better to eradicate TARGET_LONG_BITS completely instead?<br></blockquote></=
div></div><div dir=3D"auto"><br></div><div dir=3D"auto">The problem is that=
 dropping target_long in CPUState would be inefficient. For example i386 re=
gisters occupy 32 bytes vs. 256 for x86_64. So I would like to keep 32-bit =
registers for the 32-bit single-target binary.</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">Compared to the current mechanism, it decouples the =
choice of TARGET_LONG_BITS from configs/targets/ and makes it possible for =
target/*/ to pick its preferred length when built for the single binary.</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">But anyway this was just a=
 brain dump=E2=80=94we are in sync for what is needed for this series.</div=
><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
With Philippe, we introduced target-info.h, to precisely find this <br>
information at runtime, with target_long_bits().<br>
As well, as you can see in codebase, target_long_bits() is not used in <br>
many places, and especially, it&#39;s not needed anywhere in target/arm. So=
 <br>
it does not seem needed to keep it alive.<br></blockquote></div></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">I agree that target_long_bits() sh=
ould be needed almost nowhere (maybe it&#39;s needed for VMSTATE_UINTTL mig=
ration but not much else) because ideally all use of target_long/ulong woul=
d really be confined to target/ and not be in common code.</div><div dir=3D=
"auto"><br></div><div dir=3D"auto">It could be called like an x86_ulong, bu=
t it would have to be redone almost the same across all the dual-size targe=
ts, hence it&#39;s easier to keep the current name and provide a common mec=
hanism.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks,</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">Paolo=C2=A0</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
Thanks for the feedback,<br>
Pierrick<br>
<br>
</blockquote></div></div></div>

--000000000000dbe41b0647f80e8c--


