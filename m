Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79DCCF2567
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 07:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLcMN-0002wv-WC; Wed, 19 Nov 2025 02:12:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLcMK-0002s7-SO
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 02:12:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLcMI-00069f-Jk
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 02:12:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763536323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j0g7D6/3yS/O85kfT2Hpwo4f91Rket5EcDgLz15dako=;
 b=DCc/KTBJV1Vk7enOUu+/XfsXo49iluch3fHHCbYawqPQym21Qkc1SeUTyWEA4h3PyEy5Tp
 Ab2rTe/Dt6oVuTP30Zlw0yJlv8fjYp3pw6XmFR2QBrVR7uCzl6MACghRgVkl7QbXGeasHy
 0wlRGZNGxCffapicdnFOEppIOKY3jRA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-P-L0K247PB6Bc_7V1LhT_g-1; Wed, 19 Nov 2025 02:12:01 -0500
X-MC-Unique: P-L0K247PB6Bc_7V1LhT_g-1
X-Mimecast-MFC-AGG-ID: P-L0K247PB6Bc_7V1LhT_g_1763536320
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-429c76c8a1bso3805184f8f.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 23:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763536320; x=1764141120; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j0g7D6/3yS/O85kfT2Hpwo4f91Rket5EcDgLz15dako=;
 b=NBOYobMSEamV4z/NY0vrxQVmLGaVqDER6XzW2X//Q24VkI72mUqCYvHtFoPbY6YGdC
 KZ3l+M3EhpCSl+LRYXcUtSGxrVi8k0CO+CCKDliy83a0q3suCy73Uk9KTABzHVf62XpX
 VVO4OlyL2Wgrzo9yZETDPfy1ALvAvPx09Ay+zPhfi3mUETkyF+RDJCKP0yzISML0K9Y7
 G/k3F1ao9R1kLlmIhNKkmreai+LkyTdwZxkL1YgVdcy2HrA7EFGTnFxn6QuCCTMOYEpW
 r2OYOMGunIqkn20UFE3PrgH4FxHKq/hN532QWpJAgzXnmDOK4OuSdXgFJwnXl/Hi0vbM
 P+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763536320; x=1764141120;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j0g7D6/3yS/O85kfT2Hpwo4f91Rket5EcDgLz15dako=;
 b=PFmV+J6e/luvJK9xl2rlcBA9gwvRjWtoJwHw0j2CyGoDtFiA8qnj9uFedzvc52toLf
 gfZJQMjFXLucjPwLGu9p8/Kxq2l/6ZQ6haPqslo/0PMDyZ2jHFhkaTa8N0CI8O85I7Bh
 xdLmf6AY8kgFggk7u6p/dA3VnCCr/tBYnOenTqIXS1DcDdwcE2cWRAKhgVYOBpjrMSbD
 FtAqqdoKQrrLsOM7Wj/oyX2nzpwjVk3l8aPPuieesHKmyUMUHOtGD+p0y5u5gXYnxPL/
 jAtT1nq/OInqXSlTR7UjDPGjSsB4PlknGQ/U+dwiQBMmxtS9gNQ9q/gg1ejX1LDYYSJM
 mgHQ==
X-Gm-Message-State: AOJu0Yw5IfBFgIbAPprB4iXFaY9sU4irGluisjpfDc93Nfc6g/rOiT1E
 FRgnjxDuJw7Azy6K7BplplcrKvBsgyfe5inpVWiDq2BMz0vheDj9yC+cNbXDZnbO8p3nXje2Cch
 c58XSjektJFJC3toAJL1Ix/8JNB5s6KUZE8ozpwjxdZ6GQDtombX4j2J+JWzjwbgmv7mmrGBiM2
 WQmpOmOYo/wLWj5sMaJ0GwMWjP9BTi0E4=
X-Gm-Gg: ASbGncs33RjT0UqEQkfEJT9biL/VYK04HH5uSZmUd0TJzQpY7FGyiE+Vw09D55kiwPQ
 8xPfxK4RwBVgwM1ydXU/hwUPYZAPv3AdkFjMKEobcZpWhLGuoPeEXkt0WTB7757Mj9N1vT7F1Bk
 R2ccsbBWUVhm08bLGLZ1w7JnMER3/kdaaSua2NiUtIBnllXkBYGkR662fgPhucXaUWNDO1w/TU5
 RaCF+tJqhcBaatvlRtvLgm3HNiTLC63UhnvHtQ30sFII2Ic7yEgCi4qbXQ6Xm94msS7
X-Received: by 2002:adf:b613:0:b0:42b:3155:21da with SMTP id
 ffacd0b85a97d-42b5932a396mr14798206f8f.2.1763536320392; 
 Tue, 18 Nov 2025 23:12:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMJR/0ESTPUM0J3oxsLfH4+wBidqZZC8ABsmvndoSeEpK74VdtQzIci4+odzo4Cya2fYLfSir3m6yxGZflQpw=
X-Received: by 2002:adf:b613:0:b0:42b:3155:21da with SMTP id
 ffacd0b85a97d-42b5932a396mr14798186f8f.2.1763536319991; Tue, 18 Nov 2025
 23:11:59 -0800 (PST)
MIME-Version: 1.0
References: <20251118162513.730659-1-pbonzini@redhat.com>
 <670babe1-7742-4f74-8eb4-cdcfdd7fb7ff@linaro.org>
In-Reply-To: <670babe1-7742-4f74-8eb4-cdcfdd7fb7ff@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Nov 2025 08:11:48 +0100
X-Gm-Features: AWmQ_bm8iv05saFZQabC2muHLPT7Y9aN8XajSDOxC3_B0ANsswjSmQSQLdNDEW8
Message-ID: <CABgObfaJkAG=P4PiRxQr8fL2tut6X7iBum+yVfkhX4tcE1nQMQ@mail.gmail.com>
Subject: Re: [PATCH] replay: add tracing events
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000e6e1d70643ed4bf5"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000e6e1d70643ed4bf5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 19 nov 2025, 06:44 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> h=
a
scritto:

> On 18/11/25 17:25, Paolo Bonzini wrote:
> > The replay subsystem does not have any way to see what's going on and
> > how the replay events interleave with other things happening in QEMU.
> >
> > Add trace events to improve debuggability; to avoid having too many
> > events reimplement all functions in terms of (non-traced)
> > replay_getc and replay_putc and add a single trace event for each
> > datum that is extracted or written.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   meson.build              |  1 +
> >   replay/trace.h           |  1 +
> >   replay/replay-internal.c | 70 ++++++++++++++++++++++++++++++---------=
-
> >   replay/trace-events      | 12 +++++++
> >   4 files changed, 67 insertions(+), 17 deletions(-)
> >   create mode 100644 replay/trace.h
> >   create mode 100644 replay/trace-events
>
>
> >   void replay_put_dword(uint32_t dword)
> >   {
> > -    replay_put_word(dword >> 16);
> > -    replay_put_word(dword);
> > +    int i;
> > +
> > +    trace_replay_put_dword(dword);
> > +    for (i =3D 24; i >=3D 0; i -=3D 8) {
>
> Matter of taste, this looks more natural to me:
>
>         for (i =3D 32; i > 0; i -=3D 8) {
>

But ">> (i - 8)" is uglier... Or you have to put i -=3D 8 in the loop body.

Paolo


> > +        replay_putc(dword >> i);
> > +    }
> >   }
> >
> >   void replay_put_qword(int64_t qword)
> >   {
> > -    replay_put_dword(qword >> 32);
> > -    replay_put_dword(qword);
> > +    int i;
> > +
> > +    trace_replay_put_qword(qword);
> > +    for (i =3D 56; i >=3D 0; i -=3D 8) {
>
> Ditto, etc.
>
> > +        replay_putc(qword >> i);
> > +    }
> >   }
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> Also, still taste, I'd have used trace_replay_{put,get}{8,16,32,64} ;)
>
>

--000000000000e6e1d70643ed4bf5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 19 nov 2025, 06:44 Philip=
pe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linar=
o.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On 18/11/25 17:25, Paolo Bonzini wrote:<br>
&gt; The replay subsystem does not have any way to see what&#39;s going on =
and<br>
&gt; how the replay events interleave with other things happening in QEMU.<=
br>
&gt; <br>
&gt; Add trace events to improve debuggability; to avoid having too many<br=
>
&gt; events reimplement all functions in terms of (non-traced)<br>
&gt; replay_getc and replay_putc and add a single trace event for each<br>
&gt; datum that is extracted or written.<br>
&gt; <br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0replay/trace.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0replay/replay-internal.c | 70 ++++++++++++++++++++++++++++=
++----------<br>
&gt;=C2=A0 =C2=A0replay/trace-events=C2=A0 =C2=A0 =C2=A0 | 12 +++++++<br>
&gt;=C2=A0 =C2=A04 files changed, 67 insertions(+), 17 deletions(-)<br>
&gt;=C2=A0 =C2=A0create mode 100644 replay/trace.h<br>
&gt;=C2=A0 =C2=A0create mode 100644 replay/trace-events<br>
<br>
<br>
&gt;=C2=A0 =C2=A0void replay_put_dword(uint32_t dword)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 replay_put_word(dword &gt;&gt; 16);<br>
&gt; -=C2=A0 =C2=A0 replay_put_word(dword);<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_replay_put_dword(dword);<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 24; i &gt;=3D 0; i -=3D 8) {<br>
<br>
Matter of taste, this looks more natural to me:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 32; i &gt; 0; i -=3D 8) {<br></block=
quote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">But &quot;&=
gt;&gt; (i - 8)&quot; is uglier... Or you have to put i -=3D 8 in the loop =
body.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div di=
r=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quot=
e_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 replay_putc(dword &gt;&gt; i);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0void replay_put_qword(int64_t qword)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 replay_put_dword(qword &gt;&gt; 32);<br>
&gt; -=C2=A0 =C2=A0 replay_put_dword(qword);<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_replay_put_qword(qword);<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 56; i &gt;=3D 0; i -=3D 8) {<br>
<br>
Ditto, etc.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 replay_putc(qword &gt;&gt; i);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0}<br>
<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank" rel=3D"noreferrer">philmd@linaro.org</a>&gt;<br>
<br>
Also, still taste, I&#39;d have used trace_replay_{put,get}{8,16,32,64} ;)<=
br>
<br>
</blockquote></div></div></div>

--000000000000e6e1d70643ed4bf5--


