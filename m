Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC7DE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 17:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOgkA-0000LK-2R; Fri, 20 Dec 2024 12:24:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tOgk2-0000KY-NG
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 12:24:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tOgk0-0002WN-3n
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 12:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734715481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7SZFYHWcUyoXZ/k7B4bx81Jb41WkHRjbR551pXy+h6g=;
 b=c/cHqjT8gIAJ5Z7InJFsXMi0vcb1DbH2GNkOPxVduTTxhUT43g8eFGGXBbyLJ+RLozSS/X
 zjCx5w+uHZWgrfZKn3Y0UIF5RE1BBA+nek4CIKpQdU7Y2m8wbaVEi2L2UGXWRHs9Q5mplt
 m62gg34C1lFy5aKG/cda2nlIeJk3AcU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-dvtvV0aGPP2nvhBsUCxMdw-1; Fri, 20 Dec 2024 12:24:40 -0500
X-MC-Unique: dvtvV0aGPP2nvhBsUCxMdw-1
X-Mimecast-MFC-AGG-ID: dvtvV0aGPP2nvhBsUCxMdw
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aa67f18cb95so259190266b.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 09:24:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734715479; x=1735320279;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7SZFYHWcUyoXZ/k7B4bx81Jb41WkHRjbR551pXy+h6g=;
 b=wrXcyWmpNwpyh7YoPadq0mzxueXydcmb3OyUbBGST2c0kQHL+AXIxDv0PRaK8z9MUV
 5u/HaBxr4HsR72RRyowQdbY9lipPzjavnUTRX4THR8+Sf4g9s7CnDdg0xlQ4b/BvXzjg
 PVNpcmnVJc9jMfb7impesPVt/LMatjmco8EgOYgLjytssJUvzmbBu83vic90Na3c42Bz
 xO4RQhdx4M+W4ShlOOsDxFrM2r60Rla6bkOW0yc5K86peYkz/Gw+F0ugI2oGYnbpG7W2
 +Ipisl6NLR1E2RLaedOHcu57KaMIoLVGpAJJmzafCX0r0z/kAzdr+pgNde8UqrOiVFZG
 iU0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD0BSNcxo7HJ2EiREaRC0HUng4CHI5LGFdEVKbrZY7lJBBpeEqp5/lk7uktt52NqGE+XfZIZ0VVYXK@nongnu.org
X-Gm-Message-State: AOJu0YzXA/1MGYv7YgzOsSvAcHIL5vWLnMLbn77YiE4TXvtZ2XweT6/l
 oNC2mXLLDE5t/Kzyz/f3Hm5Qog0FY4NQboSL/AWa1/AiJWJL4Nj/LO3Egp23PO060oo68TTeYEY
 6iOM7r6QdNj+K/bAQg3vn2/IGE6adfTapuj6ATrghLKWhXeyVK000Zfplz1ItZqpZKYdMz6uZaZ
 dwF1gZ8Y72hu6mjI6jtU67MWxi/gI=
X-Gm-Gg: ASbGnctbmjpxRcFMHHuOHE49X5OULmDLqsfiQ9pJKyOhmC2Rija7bXfvBJwl3EUecNU
 hN2ap64NqmB3G1Hq4OrXXM6GDdmUXSK4arKU=
X-Received: by 2002:a17:906:7311:b0:aab:75f1:e51f with SMTP id
 a640c23a62f3a-aac2ad84e3dmr342190366b.18.1734715478978; 
 Fri, 20 Dec 2024 09:24:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYc8z4SZ+gr7jsBPIlFhs3+4g6J0d2i4KNoT37tcUegiSGahiUG7UIrHptymkCw+KW0H7+5fj7+CDQhOPDvUo=
X-Received: by 2002:a17:906:7311:b0:aab:75f1:e51f with SMTP id
 a640c23a62f3a-aac2ad84e3dmr342188166b.18.1734715478670; Fri, 20 Dec 2024
 09:24:38 -0800 (PST)
MIME-Version: 1.0
References: <20241216114841.1025070-1-anisinha@redhat.com>
 <3b2e9941-e5a3-4981-adda-f5121bc98e9a@linaro.org>
 <CAK3XEhNVXZDD0i3pxpSgnogheyJO7dfQ4p0UdvhqU3DrFXJ_ZA@mail.gmail.com>
 <55f6dfe7-cadf-4942-81e8-18b15938c349@linaro.org>
 <CAK3XEhNN9EO75vgsdRboMZ7nwZbaL0eenSwSy-7Hze-ukyTZsQ@mail.gmail.com>
 <7c1a7e86-8996-43ab-aa07-6763387b2bc5@linaro.org>
 <CAK3XEhOZ50Co0hAS31KYyQA+mgwXSoGCxMu_vhZXmpP0RwT6Mw@mail.gmail.com>
 <CAK3XEhOAD1cueixs6w2ojvudOwz5YrTxzN4x_kgZTkg_EfFXsA@mail.gmail.com>
 <1bbf92cf-d9d0-421e-b674-fb216cb7216a@amazon.com>
 <CAK3XEhOmpQULP6xCetkrwHC_FzSMRs7LSsCyzeUpvqRkw-zkOA@mail.gmail.com>
In-Reply-To: <CAK3XEhOmpQULP6xCetkrwHC_FzSMRs7LSsCyzeUpvqRkw-zkOA@mail.gmail.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Fri, 20 Dec 2024 22:54:25 +0530
Message-ID: <CAK3XEhPFbj0NHi2-6ojjX6XYMW_h3zsbOX92r3VHNnO7dZHiEw@mail.gmail.com>
Subject: Re: [PATCH v2] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: Alexander Graf <graf@amazon.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffman <kraxel@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000e49d690629b6eb36"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
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

--000000000000e49d690629b6eb36
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Dec, 2024, 7:01 pm Ani Sinha, <anisinha@redhat.com> wrote:

> On Fri, Dec 20, 2024 at 5:03=E2=80=AFPM Alexander Graf <graf@amazon.com> =
wrote:
> >
> >
> > On 20.12.24 11:00, Ani Sinha wrote:
> > >>> Either add the I386 dependency or don't use PC_MACHINE, because on
> > >>> non-x86 targets PC_MACHINE(qdev_get_machine()) will crash.
> > >> Ah this is where we have a disconnect. I assumed that
> > >>> pcms =3D PC_MACHINE(m_obj)
> > >> would return NULL on non-x86.
> > >>
> > >> Seems a better way to do this (as is done in vga.c) is to use
> > >> object_dynamic_cast()
> > >> How about
> > >>
> > >> diff --git a/hw/misc/vmfwupdate.c b/hw/misc/vmfwupdate.c
> > >> index 0e90bd10e1..19d042b929 100644
> > >> --- a/hw/misc/vmfwupdate.c
> > >> +++ b/hw/misc/vmfwupdate.c
> > >> @@ -32,9 +32,11 @@ static inline VMFwUpdateState
> *vmfwupdate_find(void)
> > >>   static uint64_t get_max_fw_size(void)
> > >>   {
> > >>       Object *m_obj =3D qdev_get_machine();
> > >> -    PCMachineState *pcms =3D PC_MACHINE(m_obj);
> > >> +    MachineState *ms =3D MACHINE(m_obj);
> > >> +    PCMachineState *pcms;
> > >> -    if (pcms) {
> > >> +    if (object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE)) {
> > >> +        pcms =3D PC_MACHINE(m_obj);
> > >>           return pcms->max_fw_size;
> > >>       } else {
> > >>           return 0;
> > >>
> > > For the records, I tested this with arm and the following command lin=
e
> > > does not crash QEMU;
> > >
> > > ./qemu-system-arm -machine virt-9.2 -device vmfwupdate
> > >
> > > I have also added a separate functional test to exercise basic device
> > > creation which will be part of v5 when I send it out.
> >
> >
> > You are currently not implementing the reset logic required to actually
> > make vmfwupdate work.
>
> Yes that is correct and that is by design. The reset logic on CoCo
> depends on the larger piece of work on how to enable reset and
> re-instantiation of the VM without simply terminating. I did not want
> to wait until all those complicated bits were sorted out first. I
> wanted to make sure that the hypervisor/guest interface is put in
> place.
>
> That means technically, the device should not be
> > instantiable on *any* platform at the moment. For example with the
> > command line above you would advertise the capability to update firmwar=
e
> > in fw-cfg, but then not back it by functionality.
>
> OK so if we wanted to put this work peace meal in smaller chunks, can
> we have an additional capability bit that actually advertizes this
> functionality on certain machine types/platforms?
>

Note that having a capability bit also helps us to test each machine /
platforms separately as we roll this out. The capability will be disabled
for all platforms and machines initially and incrementally enabled for
those machines and platforms for which we have tested the feature to work.


> If QEMU were to merge
> > this patch, it would just create a broken device.
>
> Are you talking about CoCo or non-CoCo?
>

Maybe for non coco case which is a lot simpler, we can add the reset bits
as a part of this patchset.


>
> > Please make sure that the vmfwupdate device can only be instantiated on
> > machine types that it has full support for.
> >
> >
> > Alex
> >
> >
> >
> >
> > Amazon Web Services Development Center Germany GmbH
> > Krausenstr. 38
> > 10117 Berlin
> > Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> > Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> > Sitz: Berlin
> > Ust-ID: DE 365 538 597
>

--000000000000e49d690629b6eb36
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 20 Dec, 2024, 7:01 pm An=
i Sinha, &lt;<a href=3D"mailto:anisinha@redhat.com">anisinha@redhat.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Fri, Dec 20, 2024 at=
 5:03=E2=80=AFPM Alexander Graf &lt;<a href=3D"mailto:graf@amazon.com" targ=
et=3D"_blank" rel=3D"noreferrer">graf@amazon.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt; On 20.12.24 11:00, Ani Sinha wrote:<br>
&gt; &gt;&gt;&gt; Either add the I386 dependency or don&#39;t use PC_MACHIN=
E, because on<br>
&gt; &gt;&gt;&gt; non-x86 targets PC_MACHINE(qdev_get_machine()) will crash=
.<br>
&gt; &gt;&gt; Ah this is where we have a disconnect. I assumed that<br>
&gt; &gt;&gt;&gt; pcms =3D PC_MACHINE(m_obj)<br>
&gt; &gt;&gt; would return NULL on non-x86.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Seems a better way to do this (as is done in vga.c) is to use=
<br>
&gt; &gt;&gt; object_dynamic_cast()<br>
&gt; &gt;&gt; How about<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; diff --git a/hw/misc/vmfwupdate.c b/hw/misc/vmfwupdate.c<br>
&gt; &gt;&gt; index 0e90bd10e1..19d042b929 100644<br>
&gt; &gt;&gt; --- a/hw/misc/vmfwupdate.c<br>
&gt; &gt;&gt; +++ b/hw/misc/vmfwupdate.c<br>
&gt; &gt;&gt; @@ -32,9 +32,11 @@ static inline VMFwUpdateState *vmfwupdate_=
find(void)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0static uint64_t get_max_fw_size(void)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0{<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Object *m_obj =3D qdev_get_machine(=
);<br>
&gt; &gt;&gt; -=C2=A0 =C2=A0 PCMachineState *pcms =3D PC_MACHINE(m_obj);<br=
>
&gt; &gt;&gt; +=C2=A0 =C2=A0 MachineState *ms =3D MACHINE(m_obj);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 PCMachineState *pcms;<br>
&gt; &gt;&gt; -=C2=A0 =C2=A0 if (pcms) {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 if (object_dynamic_cast(OBJECT(ms), TYPE_X86_M=
ACHINE)) {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pcms =3D PC_MACHINE(m_obj);<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return pcms-&gt;max_f=
w_size;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt;&gt;<br>
&gt; &gt; For the records, I tested this with arm and the following command=
 line<br>
&gt; &gt; does not crash QEMU;<br>
&gt; &gt;<br>
&gt; &gt; ./qemu-system-arm -machine virt-9.2 -device vmfwupdate<br>
&gt; &gt;<br>
&gt; &gt; I have also added a separate functional test to exercise basic de=
vice<br>
&gt; &gt; creation which will be part of v5 when I send it out.<br>
&gt;<br>
&gt;<br>
&gt; You are currently not implementing the reset logic required to actuall=
y<br>
&gt; make vmfwupdate work.<br>
<br>
Yes that is correct and that is by design. The reset logic on CoCo<br>
depends on the larger piece of work on how to enable reset and<br>
re-instantiation of the VM without simply terminating. I did not want<br>
to wait until all those complicated bits were sorted out first. I<br>
wanted to make sure that the hypervisor/guest interface is put in<br>
place.<br>
<br>
That means technically, the device should not be<br>
&gt; instantiable on *any* platform at the moment. For example with the<br>
&gt; command line above you would advertise the capability to update firmwa=
re<br>
&gt; in fw-cfg, but then not back it by functionality.<br>
<br>
OK so if we wanted to put this work peace meal in smaller chunks, can<br>
we have an additional capability bit that actually advertizes this<br>
functionality on certain machine types/platforms?<br></blockquote></div></d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">Note that having a capabil=
ity bit also helps us to test each machine / platforms separately as we rol=
l this out. The capability will be disabled for all platforms and machines =
initially and incrementally enabled for those machines and platforms for wh=
ich we have tested the feature to work.</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<br>
If QEMU were to merge<br>
&gt; this patch, it would just create a broken device.<br>
<br>
Are you talking about CoCo or non-CoCo?<br></blockquote></div></div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Maybe for non coco case which is a l=
ot simpler, we can add the reset bits as a part of this patchset.</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div =
class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
&gt;<br>
&gt; Please make sure that the vmfwupdate device can only be instantiated o=
n<br>
&gt; machine types that it has full support for.<br>
&gt;<br>
&gt;<br>
&gt; Alex<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Amazon Web Services Development Center Germany GmbH<br>
&gt; Krausenstr. 38<br>
&gt; 10117 Berlin<br>
&gt; Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss<br>
&gt; Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B<br>
&gt; Sitz: Berlin<br>
&gt; Ust-ID: DE 365 538 597<br>
</blockquote></div></div></div>

--000000000000e49d690629b6eb36--


