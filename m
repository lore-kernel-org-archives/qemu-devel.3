Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A567FC28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 06:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trswQ-0004tC-7l; Tue, 11 Mar 2025 02:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trswN-0004sF-UR
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 02:18:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trswL-0004OR-GM
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 02:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741673887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pKruyLGEAdhe2ZrLpLjYenMpvH8OokIt1blkVZ8e3pk=;
 b=L1vUmP/M05nvhA4DS4UC+wCPwZwXBjLXLJtNQuDSeZprC0qTNnbQnZ5JNiMFHf3kcMax1h
 o1j4vlstHid5TOLEE+2vxGQFwGVX68FHtIJ7zyafFI5bYRGhJX8uYhby/n21bjX5lfxdnW
 Gosr++0UsMxz11VbZ7mRosJkI+8AJ1M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-VfrTIsL7OWqhcjsdS4dy4A-1; Tue, 11 Mar 2025 02:18:03 -0400
X-MC-Unique: VfrTIsL7OWqhcjsdS4dy4A-1
X-Mimecast-MFC-AGG-ID: VfrTIsL7OWqhcjsdS4dy4A_1741673882
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43ce245c5acso22805015e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 23:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741673882; x=1742278682;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pKruyLGEAdhe2ZrLpLjYenMpvH8OokIt1blkVZ8e3pk=;
 b=bwbsgnBm+OE9IiZncCbuyCWsNMYStOTiF1xSS5Uz/rQmCfygPPoZncdhrtb8Kygl9o
 lxxC90WV3P2xPP8wzHoawNVX1p9nXvFo/koeysRMnLmkvbi06Pv0KUvfWLf+N4I0ENdp
 H0EqoDr6npghupRrWFgSFc3dyrUz1ZWFZ690ezEzZlMd+oxugaiUIIC6Ikl2QYmTk4Un
 f4wlvdrsU5SRT8xD6jy3aOhNRnKXw6DWGql6vi9F1dI4gJN7e25OLPY2NqHKp+CGQNSm
 cpnhe1qOzGsKk7jtn5npKh4RS6gUXDwKn8H+iyi2H5TAUh+hSwLTcWLWF5QTHQluxrO7
 5Epw==
X-Gm-Message-State: AOJu0YxWAewtgvou7EBLAf9/J3RDpPiG/QtuEf+el1FOKZ6kwCoxvw2Z
 V7R0zXinvt4EFC+a5zMTyU3rGfx5fcLzw6+3vYBrvwoNsSG/SES9yBTvPGa3YDjhk7cKrDODhdZ
 BexJ8o5o4HaGBYd5iOgmpmppcFd12uLENS6FpMr4lHdFYAi6jP3lFiOLUbMmplcG/DQ3UquM4HS
 tdHc/v21uKyfh9RNJKHhvghrjlors=
X-Gm-Gg: ASbGnctfTYJSBChJbhrRgZsE+qFdzeoV3eWBlaurL4JGyUb4ARx29joHqZZqFAZgefJ
 /8sGD1CWl3k50t8z6FSmiCidTwDKEoLVjhAGbC4iCQquNoTLOvSs0O3LM8vo56NIshs8VVxx1BE
 E=
X-Received: by 2002:a05:600c:512a:b0:43d:609:b300 with SMTP id
 5b1f17b1804b1-43d0609b5eamr4772745e9.14.1741673882321; 
 Mon, 10 Mar 2025 23:18:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/pKlKDC7oT1dOLucKtILXDOcYmlyULvft+ZgvTRLBNFEcGF70CSRe2ZSgiqONjzO6m3Ua0uVbOgBe5WZecPc=
X-Received: by 2002:a05:600c:512a:b0:43d:609:b300 with SMTP id
 5b1f17b1804b1-43d0609b5eamr4772505e9.14.1741673881938; Mon, 10 Mar 2025
 23:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250218165757.554178-1-pbonzini@redhat.com>
 <20250218165757.554178-3-pbonzini@redhat.com>
 <CAKmqyKMdUONoXD69m3RH1PeoLLtL8qT-eXweVh9WHEZM5Feufg@mail.gmail.com>
 <ab9b6720-cb48-4b8f-9059-2856c78b5577@redhat.com>
 <CAKmqyKP4Fe1FHyW=fpxa47SDq=Tz2-7rAcjTxv8W2L9+q5-oCQ@mail.gmail.com>
 <CABgObfbVWoCwM7W0Mej_4FyfDLHagtun-ieHPpynsfO=s9M4=A@mail.gmail.com>
 <CAKmqyKPOdzB=yKzv2q3+Zn-MrpAuaPwbeZscvreT1=2CWebvTQ@mail.gmail.com>
In-Reply-To: <CAKmqyKPOdzB=yKzv2q3+Zn-MrpAuaPwbeZscvreT1=2CWebvTQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 11 Mar 2025 07:17:50 +0100
X-Gm-Features: AQ5f1JqS0ZgkqJV88X3McLfdn0zw6GjYIymh68rkVixvjXgVf2-qeblD6tK-BEk
Message-ID: <CABgObfY3wQUMPiUOQnU+GAv68rE2LtWhBTCrPupbF_NuxxhvhA@mail.gmail.com>
Subject: Re: [PATCH 2/7] target/riscv: env->misa_mxl is a constant
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: multipart/alternative; boundary="0000000000000c3dbc06300b0d12"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000000c3dbc06300b0d12
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 10 mar 2025, 23:18 Alistair Francis <alistair23@gmail.com> ha
scritto:

> On Tue, Mar 11, 2025 at 3:34=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
> >
> > On Fri, Mar 7, 2025 at 1:45=E2=80=AFAM Alistair Francis <alistair23@gma=
il.com>
> wrote:
> > > I'm not convinced that this is the thing that we should be checking
> > > for. If someone can corrupt the migration data for an attack there ar=
e
> > > better things to change then the MXL
> >
> > In principle you could have code that uses 2 << MXL to compute the
> > size of a memcpy, or something like that... never say never. :)
>
> But couldn't they also change the PC at that point and execute
> malicious code? Or MTVEC or anything else?
>

The point is exploiting the host, not the guest.

It just seems like this check doesn't actually provide any security.

In the future we will want to merge misa_mxl and misa_mxl_max and this
> patch just makes that a little bit harder, for no real gains that I
> can see.
>
> > Do you prefer turning all the priv_ver, vext_ver, misa_mxl,
> > misa_ext_mask fields into VMSTATE_UNUSED? That would also be okay.
>
> I think we do want to migrate them, they contain important information.
>

They are constant though, aren't they? Properties aren't migrated, they are
set on the command line of the destination.

I will drop the patch, but I think there's some work to do on the migration
of RISC-V CPU state.

Paolo


> Alistair
>
> >
> > I would also add a check for misa_ext against misa_ext_mask and
> > riscv_cpu_validate_set_extensions().
> >
> > Paolo
> >
> > > Alistair
> > >
> > > >
> > > > Paolo
> > > >
> > > > > Alistair
> > > > >
> > > > >> would have a snowball effect on, for example, the valid VM modes=
.
> > > > >>
> > > > >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > > >> ---
> > > > >>   target/riscv/machine.c | 13 +++++++++++++
> > > > >>   1 file changed, 13 insertions(+)
> > > > >>
> > > > >> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> > > > >> index d8445244ab2..c3d8e7c4005 100644
> > > > >> --- a/target/riscv/machine.c
> > > > >> +++ b/target/riscv/machine.c
> > > > >> @@ -375,6 +375,18 @@ static const VMStateDescription vmstate_ssp
> =3D {
> > > > >>       }
> > > > >>   };
> > > > >>
> > > > >> +static bool riscv_validate_misa_mxl(void *opaque, int version_i=
d)
> > > > >> +{
> > > > >> +    RISCVCPU *cpu =3D RISCV_CPU(opaque);
> > > > >> +    CPURISCVState *env =3D &cpu->env;
> > > > >> +    RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(cpu);
> > > > >> +    uint32_t misa_mxl_saved =3D env->misa_mxl;
> > > > >> +
> > > > >> +    /* Preserve misa_mxl even if the migration stream corrupted
> it  */
> > > > >> +    env->misa_mxl =3D mcc->misa_mxl_max;
> > > > >> +    return misa_mxl_saved =3D=3D mcc->misa_mxl_max;
> > > > >> +}
> > > > >> +
> > > > >>   const VMStateDescription vmstate_riscv_cpu =3D {
> > > > >>       .name =3D "cpu",
> > > > >>       .version_id =3D 10,
> > > > >> @@ -394,6 +406,7 @@ const VMStateDescription vmstate_riscv_cpu =
=3D {
> > > > >>           VMSTATE_UINTTL(env.priv_ver, RISCVCPU),
> > > > >>           VMSTATE_UINTTL(env.vext_ver, RISCVCPU),
> > > > >>           VMSTATE_UINT32(env.misa_mxl, RISCVCPU),
> > > > >> +        VMSTATE_VALIDATE("MXL must match",
> riscv_validate_misa_mxl),
> > > > >>           VMSTATE_UINT32(env.misa_ext, RISCVCPU),
> > > > >>           VMSTATE_UNUSED(4),
> > > > >>           VMSTATE_UINT32(env.misa_ext_mask, RISCVCPU),
> > > > >> --
> > > > >> 2.48.1
> > > > >>
> > > > >>
> > > > >
> > > > >
> > > >
> > >
> >
>
>

--0000000000000c3dbc06300b0d12
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il lun 10 mar 2025, 23:18 Alista=
ir Francis &lt;<a href=3D"mailto:alistair23@gmail.com">alistair23@gmail.com=
</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">On Tue, Mar 11, 2025 at 3:34=E2=80=AFAM Paolo Bonzini &lt;<a href=3D"m=
ailto:pbonzini@redhat.com" target=3D"_blank" rel=3D"noreferrer">pbonzini@re=
dhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Fri, Mar 7, 2025 at 1:45=E2=80=AFAM Alistair Francis &lt;<a href=3D=
"mailto:alistair23@gmail.com" target=3D"_blank" rel=3D"noreferrer">alistair=
23@gmail.com</a>&gt; wrote:<br>
&gt; &gt; I&#39;m not convinced that this is the thing that we should be ch=
ecking<br>
&gt; &gt; for. If someone can corrupt the migration data for an attack ther=
e are<br>
&gt; &gt; better things to change then the MXL<br>
&gt;<br>
&gt; In principle you could have code that uses 2 &lt;&lt; MXL to compute t=
he<br>
&gt; size of a memcpy, or something like that... never say never. :)<br>
<br>
But couldn&#39;t they also change the PC at that point and execute<br>
malicious code? Or MTVEC or anything else?<br></blockquote></div></div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">The point is exploiting the host,=
 not the guest.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
It just seems like this check doesn&#39;t actually provide any security.</b=
lockquote></div></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quo=
te_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
In the future we will want to merge misa_mxl and misa_mxl_max and this<br>
patch just makes that a little bit harder, for no real gains that I<br>
can see.<br><br>
&gt; Do you prefer turning all the priv_ver, vext_ver, misa_mxl,<br>
&gt; misa_ext_mask fields into VMSTATE_UNUSED? That would also be okay.<br>
<br>
I think we do want to migrate them, they contain important information.<br>=
</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">They=
 are constant though, aren&#39;t they? Properties aren&#39;t migrated, they=
 are set on the command line of the destination.</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">I will drop the patch, but I think there&#39;s som=
e work to do on the migration of RISC-V CPU state.</div><div dir=3D"auto"><=
br></div><div dir=3D"auto">Paolo=C2=A0</div><div dir=3D"auto"><br></div><di=
v dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
<br>
Alistair<br>
<br>
&gt;<br>
&gt; I would also add a check for misa_ext against misa_ext_mask and<br>
&gt; riscv_cpu_validate_set_extensions().<br>
&gt;<br>
&gt; Paolo<br>
&gt;<br>
&gt; &gt; Alistair<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Paolo<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Alistair<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;&gt; would have a snowball effect on, for example, the v=
alid VM modes.<br>
&gt; &gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:=
pbonzini@redhat.com" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.c=
om</a>&gt;<br>
&gt; &gt; &gt; &gt;&gt; ---<br>
&gt; &gt; &gt; &gt;&gt;=C2=A0 =C2=A0target/riscv/machine.c | 13 +++++++++++=
++<br>
&gt; &gt; &gt; &gt;&gt;=C2=A0 =C2=A01 file changed, 13 insertions(+)<br>
&gt; &gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt; diff --git a/target/riscv/machine.c b/target/riscv/=
machine.c<br>
&gt; &gt; &gt; &gt;&gt; index d8445244ab2..c3d8e7c4005 100644<br>
&gt; &gt; &gt; &gt;&gt; --- a/target/riscv/machine.c<br>
&gt; &gt; &gt; &gt;&gt; +++ b/target/riscv/machine.c<br>
&gt; &gt; &gt; &gt;&gt; @@ -375,6 +375,18 @@ static const VMStateDescriptio=
n vmstate_ssp =3D {<br>
&gt; &gt; &gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; &gt;&gt;=C2=A0 =C2=A0};<br>
&gt; &gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt; +static bool riscv_validate_misa_mxl(void *opaque, =
int version_id)<br>
&gt; &gt; &gt; &gt;&gt; +{<br>
&gt; &gt; &gt; &gt;&gt; +=C2=A0 =C2=A0 RISCVCPU *cpu =3D RISCV_CPU(opaque);=
<br>
&gt; &gt; &gt; &gt;&gt; +=C2=A0 =C2=A0 CPURISCVState *env =3D &amp;cpu-&gt;=
env;<br>
&gt; &gt; &gt; &gt;&gt; +=C2=A0 =C2=A0 RISCVCPUClass *mcc =3D RISCV_CPU_GET=
_CLASS(cpu);<br>
&gt; &gt; &gt; &gt;&gt; +=C2=A0 =C2=A0 uint32_t misa_mxl_saved =3D env-&gt;=
misa_mxl;<br>
&gt; &gt; &gt; &gt;&gt; +<br>
&gt; &gt; &gt; &gt;&gt; +=C2=A0 =C2=A0 /* Preserve misa_mxl even if the mig=
ration stream corrupted it=C2=A0 */<br>
&gt; &gt; &gt; &gt;&gt; +=C2=A0 =C2=A0 env-&gt;misa_mxl =3D mcc-&gt;misa_mx=
l_max;<br>
&gt; &gt; &gt; &gt;&gt; +=C2=A0 =C2=A0 return misa_mxl_saved =3D=3D mcc-&gt=
;misa_mxl_max;<br>
&gt; &gt; &gt; &gt;&gt; +}<br>
&gt; &gt; &gt; &gt;&gt; +<br>
&gt; &gt; &gt; &gt;&gt;=C2=A0 =C2=A0const VMStateDescription vmstate_riscv_=
cpu =3D {<br>
&gt; &gt; &gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D &quot;cpu&quot;=
,<br>
&gt; &gt; &gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.version_id =3D 10,<br>
&gt; &gt; &gt; &gt;&gt; @@ -394,6 +406,7 @@ const VMStateDescription vmstat=
e_riscv_cpu =3D {<br>
&gt; &gt; &gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UIN=
TTL(env.priv_ver, RISCVCPU),<br>
&gt; &gt; &gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UIN=
TTL(env.vext_ver, RISCVCPU),<br>
&gt; &gt; &gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UIN=
T32(env.misa_mxl, RISCVCPU),<br>
&gt; &gt; &gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_VALIDATE(&quot=
;MXL must match&quot;, riscv_validate_misa_mxl),<br>
&gt; &gt; &gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UIN=
T32(env.misa_ext, RISCVCPU),<br>
&gt; &gt; &gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UNU=
SED(4),<br>
&gt; &gt; &gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UIN=
T32(env.misa_ext_mask, RISCVCPU),<br>
&gt; &gt; &gt; &gt;&gt; --<br>
&gt; &gt; &gt; &gt;&gt; 2.48.1<br>
&gt; &gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
<br>
</blockquote></div></div></div>

--0000000000000c3dbc06300b0d12--


