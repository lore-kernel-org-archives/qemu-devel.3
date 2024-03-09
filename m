Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E61C54E49
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 04:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rioE0-0007f9-KO; Fri, 08 Mar 2024 23:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbagley@ventanamicro.com>)
 id 1rioDy-0007em-Fy
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 23:22:18 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbagley@ventanamicro.com>)
 id 1rioDu-0002eZ-M4
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 23:22:18 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5682360e095so2291120a12.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 20:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709958132; x=1710562932; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ukauAvE0gcdfAdFPsClnAXE9WkTyIBxUEpO22QT7Gnw=;
 b=i/KFvDCo+OyuFPXC2sSaJ2ux5NA+ZY1fVF43sMJvfR1sfajHRUPWupORfAW+3jN0RK
 k0DAdYeSYzrZk+EHiHuGYgBOTVETJRbmq4WyS1jOakfKSuhlzBa40nwZEPpZ2TKgV/Po
 i2cR3KAVOU736SD3paN9lxFtfysVAkKZgi3aFNMQyvuzxEjYPvLKRCB2maHq5Ct4kZZt
 fEjQ9pLsQsQxruYO1DFdWxGORA9Bbqhil/MRJO+1cR9DRHpd31SAvo3cfBW9GL8u3a00
 PopszK88LPx4iGZpSFQRRreN5mwgHydJTONWMF94O8LyG06bHUUOgz1ESeqIakJMWJ0B
 +n4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709958132; x=1710562932;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ukauAvE0gcdfAdFPsClnAXE9WkTyIBxUEpO22QT7Gnw=;
 b=VkEiNKthgtkZT9Qq9BzxElR6dWqbXJXqNgOIIWbe1SwxlXE825a71I2nkYEd8Gbu9a
 GtDT+oATWp707aJWqgYVO8LoP1XMcxjAVQyJTJjJdPVhfwAnDOWfXMEPy2tnjGrsqbRj
 W7dkD/ROQKQuQd5TK9Xt2W1VxPQRMJLWzA02l1sDg3/+0+819hj/5+x4PMfQInPRg6Xg
 duq+xxDBsC1Ecy1EwFnxf5Kbu11qM71yjdQDxrEJCIwvcKgwJEn+dCEmsBIYm2Z9KTDC
 y471ItujFEk1dW+bBD0Z1l63tvHsCekrol+K0of7Sdp21dmh3kVwINkwJ9TTgYHoNxBB
 8U+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwn0XS4S9+h26EDY2QctZs9oN1EWiHscN8tg5DOGLswd8Thfo747hQr5vVSuFMr7pL3raohjD6BOW+BYwwEIZA7+MxF8Q=
X-Gm-Message-State: AOJu0YzhpeIniIcgAu3UriBD6O3Z1Q7s8uCdfcbwZSsoFjLTdHGF0Uwj
 yAqMMyOgMQ/cgArseo2pac5jNy8ZZA2r2TFCihhjoxjzqxx5M40kHkOlPw2gU2YRD0KdpW8dpaQ
 xdU+3PMwvP1buGnNNXn9yD7006zosBetWsQ3hgQ==
X-Google-Smtp-Source: AGHT+IEa7vcYYy11Bk6ZkLO0Jq+Illm/Iog0xENW9nLdVjrGzvfVY07XzqqYoH3oj031aDdYwaAdrymI2S5R3Qv/nH8=
X-Received: by 2002:a50:d6de:0:b0:566:2e42:8c38 with SMTP id
 l30-20020a50d6de000000b005662e428c38mr649422edj.2.1709958132327; Fri, 08 Mar
 2024 20:22:12 -0800 (PST)
MIME-Version: 1.0
References: <20230810-c9e1f2783168b48bc07a1aa2@orel>
 <mhng-a6344a0c-8820-41b5-a015-b82b261b463d@palmer-ri-x1c9>
 <20230810-e160f9edae60ded9d2606b8b@orel>
 <20230811-bc15b48d336b79d9ec1f0936@orel>
 <20230811-52e2c90dc3b91e108eb5e4e8@orel>
 <CAARkPA-P1U7xyLpdx+XD1M3Ji2NUfTb+88+GKUk8R2aFsOCMRw@mail.gmail.com>
In-Reply-To: <CAARkPA-P1U7xyLpdx+XD1M3Ji2NUfTb+88+GKUk8R2aFsOCMRw@mail.gmail.com>
From: Richard Bagley <rbagley@ventanamicro.com>
Date: Fri, 8 Mar 2024 20:22:01 -0800
Message-ID: <CAARkPA-dOxOWsR0VS+S8p4fDmNR5X5Jjmo5pQTaurWLYsc9vsw@mail.gmail.com>
Subject: Re: [PATCH] disas/riscv: Further correction to LUI disassembly
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 Alistair Francis <Alistair.Francis@wdc.com>, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, 
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com
Content-Type: multipart/alternative; boundary="0000000000000f00bb061332a7ad"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=rbagley@ventanamicro.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--0000000000000f00bb061332a7ad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

post-nack, one further comment:

One could argue that this change also aligns QEMU with supporting tools (as
Andrew observed), and it makes sense to merge this change into QEMU until
those tools update to supporting signed decimal numbers with immediates.

As it is, both GNU assembler and the LLVM integrated assembler (or llvm-mc)
throws an error with examples such as
auipc s0, -17

On the other hand, I have only seen this problem with the output of the
COLLECT plug-in, not (as yet) with QEMU execution proper.
If the problem is confined to COLLECT, perhaps the argument for aligning
with other tools is not as strong.

In the meantime, I have adjusted my change locally to include AUIPC, and
written a substantive, and I hope, clear commit description.
If you would like me to resubmit a patch with this updated change, please
let me know.



On Thu, Mar 7, 2024 at 4:08=E2=80=AFPM Richard Bagley <rbagley@ventanamicro=
.com>
wrote:

> NACK
>
> We have established that the change is a workaround for a bug in
> the assembler.
> I withdraw the merge request.
>
> Thank you for this careful review.
>
> On Fri, Aug 11, 2023 at 4:55=E2=80=AFAM Andrew Jones <ajones@ventanamicro=
.com>
> wrote:
>
>> On Fri, Aug 11, 2023 at 10:25:52AM +0200, Andrew Jones wrote:
>> > On Thu, Aug 10, 2023 at 06:27:50PM +0200, Andrew Jones wrote:
>> > > On Thu, Aug 10, 2023 at 09:12:42AM -0700, Palmer Dabbelt wrote:
>> > > > On Thu, 10 Aug 2023 08:31:46 PDT (-0700), ajones@ventanamicro.com
>> wrote:
>> > > > > On Mon, Jul 31, 2023 at 11:33:20AM -0700, Richard Bagley wrote:
>> > > > > > The recent commit 36df75a0a9 corrected one aspect of LUI
>> disassembly
>> > > > > > by recovering the immediate argument from the result of LUI
>> with a
>> > > > > > shift right by 12. However, the shift right will left-fill wit=
h
>> the
>> > > > > > sign. By applying a mask we recover an unsigned representation
>> of the
>> > > > > > 20-bit field (which includes a sign bit).
>> > > > > >
>> > > > > > Example:
>> > > > > > 0xfffff000 >> 12 =3D 0xffffffff
>> > > > > > 0xfffff000 >> 12 & 0xfffff =3D 0x000fffff
>> > > > > >
>> > > > > > Fixes: 36df75a0a9 ("riscv/disas: Fix disas output of upper
>> immediates")
>> > > > > > Signed-off-by: Richard Bagley <rbagley@ventanamicro.com>
>> > > > > > ---
>> > > > > >  disas/riscv.c | 9 ++++++---
>> > > > > >  1 file changed, 6 insertions(+), 3 deletions(-)
>> > > > > >
>> > > > > > diff --git a/disas/riscv.c b/disas/riscv.c
>> > > > > > index 4023e3fc65..690eb4a1ac 100644
>> > > > > > --- a/disas/riscv.c
>> > > > > > +++ b/disas/riscv.c
>> > > > > > @@ -4723,9 +4723,12 @@ static void format_inst(char *buf,
>> size_t buflen, size_t tab, rv_decode *dec)
>> > > > > >              break;
>> > > > > >          case 'U':
>> > > > > >              fmt++;
>> > > > > > -            snprintf(tmp, sizeof(tmp), "%d", dec->imm >> 12);
>> > > > > > -            append(buf, tmp, buflen);
>> > > > > > -            if (*fmt =3D=3D 'o') {
>> > > > > > +            if (*fmt =3D=3D 'i') {
>> > > > > > +                snprintf(tmp, sizeof(tmp), "%d", dec->imm >>
>> 12 & 0xfffff);
>> > > > >
>> > > > > Why are we correcting LUI's output, but still outputting
>> sign-extended
>> > > > > values for AUIPC?
>> > > > >
>> > > > > We can't assemble 'auipc a1, 0xffffffff' or 'auipc a1, -1'
>> without getting
>> > > > >
>> > > > >  Error: lui expression not in range 0..1048575
>> > > > >
>> > > > > (and additionally for 0xffffffff)
>> > > > >
>> > > > >  Error: value of 00000ffffffff000 too large for field of 4 bytes
>> at 0000000000000000
>> > > > >
>> > > > > either.
>> > > > >
>> > > > > (I see that the assembler's error messages state 'lui', but I wa=
s
>> trying
>> > > > > 'auipc'.)
>> > > > >
>> > > > > I'm using as from gnu binutils 2.40.0.20230214.
>> > > > >
>> > > > > (And, FWIW, I agree with Richard Henderson that these
>> instructions should
>> > > > > accept negative values.)
>> > > >
>> > > > I'm kind of lost here, and you saying binutils rejects this
>> syntax?  If
>> > > > that's the case it's probably just an oversight, can you file a bu=
g
>> in
>> > > > binutils land so folks can see?
>> > >
>> > > Will do.
>> > >
>> >
>> > https://sourceware.org/bugzilla/show_bug.cgi?id=3D30746
>> >
>>
>> But, to try to bring this thread back to the patch under review. While t=
he
>> binutils BZ may address our preferred way of providing immediates to the
>> assembler, this patch is trying to make QEMU's output consistent with
>> objdump. Since objdump always outputs long immediate values as hex, then
>> it doesn't need to care about negative signs. QEMU seems to prefer
>> decimal, though, and so does llvm-objdump, which outputs values for thes=
e
>> instructions in the range 0..1048575. So, I guess this patch is making
>> QEMU consistent with llvm-objdump.
>>
>> Back to making suggestions for this patch...
>>
>> 1. The commit message should probably say something along the lines of
>>    what I just wrote in the preceding paragraph to better explain the
>>    motivation.
>>
>> 2. Unless I'm missing something, then this patch should also address
>>    AUIPC.
>>
>> Thanks,
>> drew
>>
>

--0000000000000f00bb061332a7ad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">post-nack, one further comment:<br><br>One could argue tha=
t this change also aligns QEMU with supporting tools (as Andrew observed), =
and it makes sense to merge this change into QEMU until those tools update =
to supporting signed decimal numbers with immediates. <br><br>As it is, bot=
h GNU assembler and the LLVM integrated assembler (or llvm-mc) throws an er=
ror with examples such as=C2=A0<br>auipc s0, -17<br><br>On the other hand, =
I have only seen this problem with the output of the COLLECT plug-in, not (=
as yet) with QEMU execution proper.<br>If the problem is confined to COLLEC=
T, perhaps the argument for aligning with other tools is not as strong.<br>=
<br>In the meantime, I have adjusted my change locally to include AUIPC, an=
d written a substantive, and I hope, clear commit description.<br>If you wo=
uld like me to resubmit a patch with this updated change, please let me kno=
w.<br><br><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, Mar 7, 2024 at 4:08=E2=80=AFPM Richard Bagley &lt;<=
a href=3D"mailto:rbagley@ventanamicro.com">rbagley@ventanamicro.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr">NACK<br><br>We have established that the change is a workaround fo=
r a=C2=A0bug in the=C2=A0assembler.<br>I withdraw the=C2=A0merge request.<b=
r><br>Thank=C2=A0you for this careful review.</div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 11, 2023 at 4:55=
=E2=80=AFAM Andrew Jones &lt;<a href=3D"mailto:ajones@ventanamicro.com" tar=
get=3D"_blank">ajones@ventanamicro.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">On Fri, Aug 11, 2023 at 10:25:52AM +0=
200, Andrew Jones wrote:<br>
&gt; On Thu, Aug 10, 2023 at 06:27:50PM +0200, Andrew Jones wrote:<br>
&gt; &gt; On Thu, Aug 10, 2023 at 09:12:42AM -0700, Palmer Dabbelt wrote:<b=
r>
&gt; &gt; &gt; On Thu, 10 Aug 2023 08:31:46 PDT (-0700), <a href=3D"mailto:=
ajones@ventanamicro.com" target=3D"_blank">ajones@ventanamicro.com</a> wrot=
e:<br>
&gt; &gt; &gt; &gt; On Mon, Jul 31, 2023 at 11:33:20AM -0700, Richard Bagle=
y wrote:<br>
&gt; &gt; &gt; &gt; &gt; The recent commit 36df75a0a9 corrected one aspect =
of LUI disassembly<br>
&gt; &gt; &gt; &gt; &gt; by recovering the immediate argument from the resu=
lt of LUI with a<br>
&gt; &gt; &gt; &gt; &gt; shift right by 12. However, the shift right will l=
eft-fill with the<br>
&gt; &gt; &gt; &gt; &gt; sign. By applying a mask we recover an unsigned re=
presentation of the<br>
&gt; &gt; &gt; &gt; &gt; 20-bit field (which includes a sign bit).<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; Example:<br>
&gt; &gt; &gt; &gt; &gt; 0xfffff000 &gt;&gt; 12 =3D 0xffffffff<br>
&gt; &gt; &gt; &gt; &gt; 0xfffff000 &gt;&gt; 12 &amp; 0xfffff =3D 0x000ffff=
f<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; Fixes: 36df75a0a9 (&quot;riscv/disas: Fix disas ou=
tput of upper immediates&quot;)<br>
&gt; &gt; &gt; &gt; &gt; Signed-off-by: Richard Bagley &lt;<a href=3D"mailt=
o:rbagley@ventanamicro.com" target=3D"_blank">rbagley@ventanamicro.com</a>&=
gt;<br>
&gt; &gt; &gt; &gt; &gt; ---<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 disas/riscv.c | 9 ++++++---<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 1 file changed, 6 insertions(+), 3 deletions=
(-)<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; diff --git a/disas/riscv.c b/disas/riscv.c<br>
&gt; &gt; &gt; &gt; &gt; index 4023e3fc65..690eb4a1ac 100644<br>
&gt; &gt; &gt; &gt; &gt; --- a/disas/riscv.c<br>
&gt; &gt; &gt; &gt; &gt; +++ b/disas/riscv.c<br>
&gt; &gt; &gt; &gt; &gt; @@ -4723,9 +4723,12 @@ static void format_inst(cha=
r *buf, size_t buflen, size_t tab, rv_decode *dec)<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 br=
eak;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;U&#39;=
:<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fm=
t++;<br>
&gt; &gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snprint=
f(tmp, sizeof(tmp), &quot;%d&quot;, dec-&gt;imm &gt;&gt; 12);<br>
&gt; &gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 append(=
buf, tmp, buflen);<br>
&gt; &gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*fm=
t =3D=3D &#39;o&#39;) {<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*fm=
t =3D=3D &#39;i&#39;) {<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 snprintf(tmp, sizeof(tmp), &quot;%d&quot;, dec-&gt;imm &gt;&gt; 12 &=
amp; 0xfffff);<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Why are we correcting LUI&#39;s output, but still outpu=
tting sign-extended<br>
&gt; &gt; &gt; &gt; values for AUIPC?<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; We can&#39;t assemble &#39;auipc a1, 0xffffffff&#39; or=
 &#39;auipc a1, -1&#39; without getting<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt;=C2=A0 Error: lui expression not in range 0..1048575<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; (and additionally for 0xffffffff)<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt;=C2=A0 Error: value of 00000ffffffff000 too large for fi=
eld of 4 bytes at 0000000000000000<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; either.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; (I see that the assembler&#39;s error messages state &#=
39;lui&#39;, but I was trying<br>
&gt; &gt; &gt; &gt; &#39;auipc&#39;.)<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; I&#39;m using as from gnu binutils 2.40.0.20230214.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; (And, FWIW, I agree with Richard Henderson that these i=
nstructions should<br>
&gt; &gt; &gt; &gt; accept negative values.)<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; I&#39;m kind of lost here, and you saying binutils rejects t=
his syntax?=C2=A0 If<br>
&gt; &gt; &gt; that&#39;s the case it&#39;s probably just an oversight, can=
 you file a bug in<br>
&gt; &gt; &gt; binutils land so folks can see?<br>
&gt; &gt; <br>
&gt; &gt; Will do.<br>
&gt; &gt;<br>
&gt; <br>
&gt; <a href=3D"https://sourceware.org/bugzilla/show_bug.cgi?id=3D30746" re=
l=3D"noreferrer" target=3D"_blank">https://sourceware.org/bugzilla/show_bug=
.cgi?id=3D30746</a><br>
&gt;<br>
<br>
But, to try to bring this thread back to the patch under review. While the<=
br>
binutils BZ may address our preferred way of providing immediates to the<br=
>
assembler, this patch is trying to make QEMU&#39;s output consistent with<b=
r>
objdump. Since objdump always outputs long immediate values as hex, then<br=
>
it doesn&#39;t need to care about negative signs. QEMU seems to prefer<br>
decimal, though, and so does llvm-objdump, which outputs values for these<b=
r>
instructions in the range 0..1048575. So, I guess this patch is making<br>
QEMU consistent with llvm-objdump.<br>
<br>
Back to making suggestions for this patch...<br>
<br>
1. The commit message should probably say something along the lines of<br>
=C2=A0 =C2=A0what I just wrote in the preceding paragraph to better explain=
 the<br>
=C2=A0 =C2=A0motivation.<br>
<br>
2. Unless I&#39;m missing something, then this patch should also address<br=
>
=C2=A0 =C2=A0AUIPC.<br>
<br>
Thanks,<br>
drew<br>
</blockquote></div>
</blockquote></div>

--0000000000000f00bb061332a7ad--

