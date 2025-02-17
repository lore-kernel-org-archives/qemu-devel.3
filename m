Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301FCC021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjw5a-0002RQ-Ho; Mon, 17 Feb 2025 03:02:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tjw5W-0002M7-Pq
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:02:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tjw5U-0007x1-Fo
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:02:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739779362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tnm+/R+XX8YtKEWQxEeYF/5qkGreqiA2qlDDuSD2j1M=;
 b=Njo0HKWxxBqY+Qqp4GPWJ9iX4AryzKcguJNmzHcjSFN86bKTVC1VlVdjUWshvDeRTnml1i
 eAwr/jW4SYrfMhFM61XmvOwbx/MYEmD94qW+4dztpR/kpKAgRsYxF1Lewc68W03VJecByJ
 DxpBLzhqdYgxNOo9QanLHBkP1zsxAEk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-S6XFwxe8OdGBc2SLWMh53w-1; Mon, 17 Feb 2025 03:02:39 -0500
X-MC-Unique: S6XFwxe8OdGBc2SLWMh53w-1
X-Mimecast-MFC-AGG-ID: S6XFwxe8OdGBc2SLWMh53w_1739779358
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f443b4949so232725f8f.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:02:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739779357; x=1740384157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tnm+/R+XX8YtKEWQxEeYF/5qkGreqiA2qlDDuSD2j1M=;
 b=M3EM7eF1dEZdwXr4nvczT70svJ1k9wcYRTOV45kpULeFkg+GrKlW22KVQYKYT96WmU
 MJu5idY3fSsgLIwdU8gVlMUF0GSulMt9P+J3iuDG6zgKlriL0DN2+HysoLC6uuvV7pBu
 ZRBgvuYgfjQvJV/PGh39+TMNcttOxDbiSfdfSfzQbvxi3WtnxPL7m002EQWTEhbQPJa7
 Ds+j27pR+sqsvoAYmdI/FppiIWHE1FliaGBay/YnjvBhqQbDaY5cmegMOhuETDY77aWf
 em1unq71VxD1693uzolTcqnJgA6wtc7EHf5JhDVtuESZkCCEaJwebJ51FW6LDyXhws61
 o7Rg==
X-Gm-Message-State: AOJu0YxYA2jhlLbzwQjbFRNhLFQ52jor3qAkbOmN5cEvrvtlPfiU2oik
 +rp3xEF4HhHECV9irSXo5aS1seXqckk11EYahgQRoZS+s7f467UoaZO8zDKwCQTyazeA+192W02
 CBgM3iOIWddxzuziXg8Pm3w4aXVjdXIdGptkOAym0/brxsYqj5fmfeNjjCmB12RhyFZXHRkqxgj
 W6FraUBwsTakdj7cjXfTvDfKw67HjYZayItWGW6A==
X-Gm-Gg: ASbGnct+IcfgSjue+6JN8SOpSaXP1PucYZTXE7CCcfmEJnrO2R6u4+sPi0Hkaqp1Y6f
 uN7XllmFr+wj5I3Fd6SjTVMZeV0Kabo5NTreo//IYoA4SGu8i56dIdt/HDGWv++bI
X-Received: by 2002:a05:6000:1f87:b0:38d:e6b6:5096 with SMTP id
 ffacd0b85a97d-38f33f3d4bamr8516583f8f.15.1739779357169; 
 Mon, 17 Feb 2025 00:02:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECaLvR9L4JoTKKPKP/aqgq1a2UuikMMfo/k3ldWWoZC7nxDfvnvpWLfvlPoZ8X6TfCTX93zkjeUxZCOjvJx3E=
X-Received: by 2002:a05:6000:1f87:b0:38d:e6b6:5096 with SMTP id
 ffacd0b85a97d-38f33f3d4bamr8516549f8f.15.1739779356780; Mon, 17 Feb 2025
 00:02:36 -0800 (PST)
MIME-Version: 1.0
References: <20250216092853.4169458-1-pbonzini@redhat.com>
 <Z7LdS0JkMBqUugRZ@intel.com>
In-Reply-To: <Z7LdS0JkMBqUugRZ@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 17 Feb 2025 09:02:24 +0100
X-Gm-Features: AWEUYZkFiaIQpHDEJVvd1iHUQLHqoYRj5tN2wxdbYQhGJmyIE2EfcyHrcWYNTe4
Message-ID: <CABgObfanbj8bxibKOVfk3erKMx8o6_ar-X7OqEKhxnde3iyCNA@mail.gmail.com>
Subject: Re: [PATCH v2] hpet: do not overwrite properties on post_load
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000008c8d02062e51f23c"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--0000000000008c8d02062e51f23c
Content-Type: text/plain; charset="UTF-8"

Il lun 17 feb 2025, 07:35 Zhao Liu <zhao1.liu@intel.com> ha scritto:

> > @@ -347,14 +330,13 @@ static const VMStateDescription vmstate_hpet = {
> >      .version_id = 2,
> >      .minimum_version_id = 1,
> >      .pre_save = hpet_pre_save,
> > -    .pre_load = hpet_pre_load,
> >      .post_load = hpet_post_load,
> >      .fields = (const VMStateField[]) {
> >          VMSTATE_UINT64(config, HPETState),
> >          VMSTATE_UINT64(isr, HPETState),
> >          VMSTATE_UINT64(hpet_counter, HPETState),
> > -        VMSTATE_UINT8_V(num_timers, HPETState, 2),
> > -        VMSTATE_VALIDATE("num_timers in range",
> hpet_validate_num_timers),
> > +        VMSTATE_UINT8_V(num_timers_save, HPETState, 2),
>
> This change is safe since it doesn't change the vmstate layout so that
> there's no need for bumping up the version.
>
> But I still have the question as the comment in v1 [*]. User doesn't
> have any way to modify the number of timers, why not just replace this
> vmstate field with "VMSTATE_UNUSED_V(2, 1)"?
>

Because I didn't want to bump the version; your suggestion is indeed
simpler but it would break migration to past versions of QEMU, which check
that num_timers is in range. VMSTATE_UNUSED would write a zero.

For Rust, I think it's easier to place the check in the post_load callback
BTW.

Paolo


Or do you think we should keep the status quo for the future use, even
> if these properties have not been modified yet?
>
> [*]: https://lore.kernel.org/qemu-devel/Z5Oq4LppNuN7N6NL@intel.com/
>
> > +        VMSTATE_VALIDATE("num_timers must match",
> hpet_validate_num_timers),
> >          VMSTATE_STRUCT_VARRAY_UINT8(timer, HPETState, num_timers, 0,
> >                                      vmstate_hpet_timer, HPETTimer),
> >          VMSTATE_END_OF_LIST()
> > --
> > 2.48.1
> >
> >
>
>

--0000000000008c8d02062e51f23c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il lun 17 feb 2025, 07:35 Zhao L=
iu &lt;<a href=3D"mailto:zhao1.liu@intel.com">zhao1.liu@intel.com</a>&gt; h=
a scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; =
@@ -347,14 +330,13 @@ static const VMStateDescription vmstate_hpet =3D {<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 .version_id =3D 2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .minimum_version_id =3D 1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .pre_save =3D hpet_pre_save,<br>
&gt; -=C2=A0 =C2=A0 .pre_load =3D hpet_pre_load,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .post_load =3D hpet_post_load,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .fields =3D (const VMStateField[]) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT64(config, HPETState),<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT64(isr, HPETState),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT64(hpet_counter, HPETSta=
te),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8_V(num_timers, HPETState, 2)=
,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_VALIDATE(&quot;num_timers in rang=
e&quot;, hpet_validate_num_timers),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8_V(num_timers_save, HPETStat=
e, 2),<br>
<br>
This change is safe since it doesn&#39;t change the vmstate layout so that<=
br>
there&#39;s no need for bumping up the version.<br>
<br>
But I still have the question as the comment in v1 [*]. User doesn&#39;t<br=
>
have any way to modify the number of timers, why not just replace this<br>
vmstate field with &quot;VMSTATE_UNUSED_V(2, 1)&quot;?<br></blockquote></di=
v></div><div dir=3D"auto"><br></div><div dir=3D"auto">Because I didn&#39;t =
want to bump the version; your suggestion is indeed simpler but it would br=
eak migration to past versions of QEMU, which check that num_timers is in r=
ange. VMSTATE_UNUSED would write a zero.</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">For Rust, I think it&#39;s easier to place the check in th=
e post_load callback BTW.</div><div dir=3D"auto"><br></div><div dir=3D"auto=
">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
Or do you think we should keep the status quo for the future use, even<br>
if these properties have not been modified yet?<br>
<br>
[*]: <a href=3D"https://lore.kernel.org/qemu-devel/Z5Oq4LppNuN7N6NL@intel.c=
om/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lore.kernel.or=
g/qemu-devel/Z5Oq4LppNuN7N6NL@intel.com/</a><br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_VALIDATE(&quot;num_timers must ma=
tch&quot;, hpet_validate_num_timers),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_STRUCT_VARRAY_UINT8(timer, H=
PETState, num_timers, 0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vmstate_hpet=
_timer, HPETTimer),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
&gt; -- <br>
&gt; 2.48.1<br>
&gt; <br>
&gt; <br>
<br>
</blockquote></div></div></div>

--0000000000008c8d02062e51f23c--


