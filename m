Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39EDE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJFT-0001n9-1u; Thu, 19 Dec 2024 11:19:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tOJ7b-00019L-Ua
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 11:11:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tOJ7Z-0002Dx-SH
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 11:11:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734624687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5aCKQJn47pZoOqjbwNQP/+ZODduT+Av6fDu2vld8O1c=;
 b=WXhXVdzsIrPVdr+0oAA0H4TLsG+0pbL5ZKgKCh3iRpPcEULcW36BAkjhdLiOC4zru3gzdf
 8pWUzXMTZR63SPUgV01hezRM6iHR68mkKU5Z/CGZ8Lpiv3OzSTZyMGOebDN8vDjQvunRcq
 5J6kzxLXRM7TXXU6YVYS7WaUpWA0hAA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-k495fk0SOqihoadKZ_AxTA-1; Thu, 19 Dec 2024 11:11:25 -0500
X-MC-Unique: k495fk0SOqihoadKZ_AxTA-1
X-Mimecast-MFC-AGG-ID: k495fk0SOqihoadKZ_AxTA
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aa683e90dd3so84175366b.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 08:11:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734624684; x=1735229484;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5aCKQJn47pZoOqjbwNQP/+ZODduT+Av6fDu2vld8O1c=;
 b=m8FFGw74em5SzCJXI5TqnnCXv88lAPnO7Qn1PMGqr/l4tHKioqOn0uyYZeheBQ8X0b
 D4yEl5lcaNaMDq2/ykhBUE+G+Z8igoRgSyYQ3gedyOVg1p1QSua0GJJCi69oTB7CmOYS
 KWuN1d9qIUwT48gnabu7uKTmlOtb7ryY7gV1yrX4/mSkMc8n/cyKC1YrfLnoXqC8h5SR
 Sx3s9L36cggsQI0cWzQtKcPYDnxvntN8gBjp7+3y8yuUcP7Ak6rCqEyZcA5UJxuHXgxO
 BGbVv2dEXn7SnZmNIxZuHWP49cei9Urxih4BLkSP+J7tgS5A073MMoV/4fPUAxqy1yTB
 y3VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7OGcXtc7eA+IvR+T+P9NT/U7ilvf/Kry+vQwgxTqFDv5EX68WZMEOxc+10/Bn67+JpaHYGK/YNgC7@nongnu.org
X-Gm-Message-State: AOJu0YyON/XFYrHCoFCFsHllUf8PsTAA6XgqAKg+EmgAvMtNpH6GZquB
 bWK81W5clEDjAD5kE3RRVV6/rTyOmvI9dxyMUg5qQ4AUEKbIft+yNKAElziFbu2cguM51H9nJSQ
 KrYFVp+hdsRn0Tl5VGV6RnxMzpB4Uelyg+3R736eCGNbRNLJ0wkQphwLKkw8qGmA4xpBBusLOdc
 9YRBbXj3sXDkWGUyNh/8zG+ZZqYEA=
X-Gm-Gg: ASbGncs27z0+UVQpWX1JzconslNGbLp0lQh6Yn861Qwc9cLmoiKqxCp4/ZGM0UafslS
 d4Iiz8LGXxSGNOl+rsnTmuJIvk+see3/elurQ+eM=
X-Received: by 2002:a17:906:308c:b0:aa6:86d1:c3fe with SMTP id
 a640c23a62f3a-aabf471fca4mr709840966b.4.1734624684412; 
 Thu, 19 Dec 2024 08:11:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3aI/uDE3v4e0Mi03CYE80B8YUcAeMQ0k0yUrltl5X998eVSs7zUY4FmyyU5dRfwt+4A/hNJUlW5zxtFupP64=
X-Received: by 2002:a17:906:308c:b0:aa6:86d1:c3fe with SMTP id
 a640c23a62f3a-aabf471fca4mr709836966b.4.1734624683944; Thu, 19 Dec 2024
 08:11:23 -0800 (PST)
MIME-Version: 1.0
References: <20241216114841.1025070-1-anisinha@redhat.com>
 <61096f4d-7b5f-48fd-9840-caf058db2201@linaro.org>
 <2933CCF9-F9D6-46D1-9658-07B85104011D@redhat.com>
 <6eed1b13-f41a-4590-8254-dbfb1f9c7a5b@linaro.org>
 <CAMxuvawa3G_G4DvSNdF_y2anTtte0ayVaANsvo9Gh_TKP3bEbA@mail.gmail.com>
 <CAK3XEhPu1mg3KWWDViw0bSQHq=+wxmB0ZDu=Yf7-Z2889sW=yg@mail.gmail.com>
 <3cdc20da-2b66-4488-a073-7225b6e5d83b@linaro.org>
In-Reply-To: <3cdc20da-2b66-4488-a073-7225b6e5d83b@linaro.org>
From: Ani Sinha <anisinha@redhat.com>
Date: Thu, 19 Dec 2024 21:41:11 +0530
Message-ID: <CAK3XEhNph5YcuGRWr5zCpTFzo3wMtosEs6jODMtkO3wqxCn7ig@mail.gmail.com>
Subject: Re: [PATCH v2] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Alexander Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Daniel Berrange <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001b0f1b0629a1c80a"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

--0000000000001b0f1b0629a1c80a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Dec, 2024, 9:16 pm Philippe Mathieu-Daud=C3=A9, <philmd@linaro.o=
rg>
wrote:

> On 19/12/24 15:07, Ani Sinha wrote:
> > On Thu, Dec 19, 2024 at 6:25=E2=80=AFPM Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@redhat.com> wrote:
> >>
> >> Hi
> >>
> >> On Thu, Dec 19, 2024 at 2:03=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
> >> <philmd@linaro.org> wrote:
> >>>>>> +static const TypeInfo vmfwupdate_device_info =3D {
> >>>>>> +    .name          =3D TYPE_VMFWUPDATE,
> >>>>>> +    .parent        =3D TYPE_DEVICE,
> >>>>>
> >>>>> What is the qdev API used here? Why not use a plain object?
> >>>>
> >>>> I wrote this taking vmcoreinfo device as starting point. I will leav=
e
> this as is for now unless anyone has strong opinions.
> >>>
> >>> We shouldn't blindly copy/paste & spread possible design mistakes.
> >>>
> >>> Marc-Andr=C3=A9, any particular reason to implement vmcoreinfo using =
qdev
> >>> and not plain object?
> >>>
> >>
> >> I don't remember (damn 8y ago..). It seems the design changed over
> >> time during review, qdev might have been necessary and stayed this
> >> way.
> >
> > I changed it to TYPE_OBJECT and we get a crash here:
> >
> > #3  0x0000aaaaab207a48 [PAC] in object_class_dynamic_cast_assert
> >      (class=3D0xaaaaac608880, typename=3Dtypename@entry=3D0xaaaaab4b963=
0
> > "device", file=3Dfile@entry=3D0xaaaaab4300d0
> > "/workspace/qemu-ani/include/hw/qdev-core.h", line=3Dline@entry=3D77,
> > func=3Dfunc@entry=3D0xaaaaab595a90 <__func__.0> "DEVICE_CLASS") at
> > ../qom/object.c:1021
> > #4  0x0000aaaaaaec2d74 in DEVICE_CLASS (klass=3D<optimized out>) at
> > /workspace/qemu-ani/include/hw/qdev-core.h:77
> > #5  vmcoreinfo_device_class_init (klass=3D<optimized out>,
> > data=3D<optimized out>) at ../hw/misc/vmcoreinfo.c:88
>
> I believe you have enough knowledge to understand the concepts you
> are mixing here. You can not change a type signature without
> implementing its interface (which as you noticed, for QEMU is checked
> at runtime).
>

Yes the point was to quickly try and see changing to DEVICE works. Turned
out that more changes would be required and therefore I left it for the
maintained of that device.


> > Basically doing this would be illegal for vmcoreinfo and we need to
> > adjust the code :
> >
> >     DeviceClass *dc =3D DEVICE_CLASS(klass);
> >
> >      dc->vmsd =3D &vmstate_vmcoreinfo;
> >      dc->realize =3D vmcoreinfo_realize;
> >      dc->hotpluggable =3D false;
> >      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>
> See the conversion:
>
> https://lore.kernel.org/qemu-devel/20241219153857.57450-1-philmd@linaro.o=
rg/


Yes I see you sent a patch and Dan's response. That was exactly also my
opinion. Vmfwupdate, like vmcoreinfo is like a device not a generic object.
So device type is more appropriate.


> > Anyway, for vmfwupdate, it is actually like a device with device
> properties:
> >
> > +    device_class_set_props(dc, vmfwupdate_properties);
> >
> > So I prefer to make it qdev type for now.
>
> We have the opportunity to start with the correct model.
> Consider simplifying our future (see what is required in
> the suggested vmcoreinfo conversion). Except if you insist
> and commit to do the vmfwupdate later.
>
>

--0000000000001b0f1b0629a1c80a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 19 Dec, 2024, 9:16 pm Ph=
ilippe Mathieu-Daud=C3=A9, &lt;<a href=3D"mailto:philmd@linaro.org">philmd@=
linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 19/12=
/24 15:07, Ani Sinha wrote:<br>
&gt; On Thu, Dec 19, 2024 at 6:25=E2=80=AFPM Marc-Andr=C3=A9 Lureau<br>
&gt; &lt;<a href=3D"mailto:marcandre.lureau@redhat.com" target=3D"_blank" r=
el=3D"noreferrer">marcandre.lureau@redhat.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Hi<br>
&gt;&gt;<br>
&gt;&gt; On Thu, Dec 19, 2024 at 2:03=E2=80=AFPM Philippe Mathieu-Daud=C3=
=A9<br>
&gt;&gt; &lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank" rel=3D"=
noreferrer">philmd@linaro.org</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt; +static const TypeInfo vmfwupdate_device_info =3D =
{<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D TYPE_VMFWUPDATE,<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D TYPE_DEVICE,<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; What is the qdev API used here? Why not use a plain ob=
ject?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I wrote this taking vmcoreinfo device as starting point. I=
 will leave this as is for now unless anyone has strong opinions.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; We shouldn&#39;t blindly copy/paste &amp; spread possible desi=
gn mistakes.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Marc-Andr=C3=A9, any particular reason to implement vmcoreinfo=
 using qdev<br>
&gt;&gt;&gt; and not plain object?<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; I don&#39;t remember (damn 8y ago..). It seems the design changed =
over<br>
&gt;&gt; time during review, qdev might have been necessary and stayed this=
<br>
&gt;&gt; way.<br>
&gt; <br>
&gt; I changed it to TYPE_OBJECT and we get a crash here:<br>
&gt; <br>
&gt; #3=C2=A0 0x0000aaaaab207a48 [PAC] in object_class_dynamic_cast_assert<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 (class=3D0xaaaaac608880, typename=3Dtypename@entry=
=3D0xaaaaab4b9630<br>
&gt; &quot;device&quot;, file=3Dfile@entry=3D0xaaaaab4300d0<br>
&gt; &quot;/workspace/qemu-ani/include/hw/qdev-core.h&quot;, line=3Dline@en=
try=3D77,<br>
&gt; func=3Dfunc@entry=3D0xaaaaab595a90 &lt;__func__.0&gt; &quot;DEVICE_CLA=
SS&quot;) at<br>
&gt; ../qom/object.c:1021<br>
&gt; #4=C2=A0 0x0000aaaaaaec2d74 in DEVICE_CLASS (klass=3D&lt;optimized out=
&gt;) at<br>
&gt; /workspace/qemu-ani/include/hw/qdev-core.h:77<br>
&gt; #5=C2=A0 vmcoreinfo_device_class_init (klass=3D&lt;optimized out&gt;,<=
br>
&gt; data=3D&lt;optimized out&gt;) at ../hw/misc/vmcoreinfo.c:88<br>
<br>
I believe you have enough knowledge to understand the concepts you<br>
are mixing here. You can not change a type signature without<br>
implementing its interface (which as you noticed, for QEMU is checked<br>
at runtime).<br></blockquote></div></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">Yes the point was to quickly try and see changing to DEVICE wor=
ks. Turned out that more changes would be required and therefore I left it =
for the maintained of that device.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">
<br>
&gt; Basically doing this would be illegal for vmcoreinfo and we need to<br=
>
&gt; adjust the code :<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 dc-&gt;vmsd =3D &amp;vmstate_vmcoreinfo;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 dc-&gt;realize =3D vmcoreinfo_realize;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 dc-&gt;hotpluggable =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 set_bit(DEVICE_CATEGORY_MISC, dc-&gt;categories);<=
br>
<br>
See the conversion:<br>
<a href=3D"https://lore.kernel.org/qemu-devel/20241219153857.57450-1-philmd=
@linaro.org/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lore.=
kernel.org/qemu-devel/20241219153857.57450-1-philmd@linaro.org/</a></blockq=
uote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yes I see yo=
u sent a patch and Dan&#39;s response. That was exactly also my opinion. Vm=
fwupdate, like vmcoreinfo is like a device not a generic object. So device =
type is more appropriate.</div><div dir=3D"auto"><br></div><div dir=3D"auto=
"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex"><br>
&gt; Anyway, for vmfwupdate, it is actually like a device with device prope=
rties:<br>
&gt; <br>
&gt; +=C2=A0 =C2=A0 device_class_set_props(dc, vmfwupdate_properties);<br>
&gt; <br>
&gt; So I prefer to make it qdev type for now.<br>
<br>
We have the opportunity to start with the correct model.<br>
Consider simplifying our future (see what is required in<br>
the suggested vmcoreinfo conversion). Except if you insist<br>
and commit to do the vmfwupdate later.<br>
<br>
</blockquote></div></div></div>

--0000000000001b0f1b0629a1c80a--


