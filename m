Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916A2E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJGq-0003y6-DB; Thu, 19 Dec 2024 11:21:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tOHBd-0000E0-SG
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:07:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tOHBc-00041U-8T
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:07:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734617250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0VOZOqTYjuBQWSRbaodVkgoqbpVNKqGHG8LBQQLmWQQ=;
 b=H+W/C/3LfClGEzekN3MLI8o4RPg1z2kxeF3og1CGNX9aamPYErVKK2rtS8lzGhO2IoXM8Z
 ygCO+kgSKOl9CBtuon+6pYGxBNRz7HGBqFzD+atR7XwF0gZhk5A05C3mtgxAVIlpG83+kW
 103QDXnelL11xkwXwmzg4s+bGMp1AX4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-rWnqeOEhNZKsnDv-0ZdfOw-1; Thu, 19 Dec 2024 09:07:27 -0500
X-MC-Unique: rWnqeOEhNZKsnDv-0ZdfOw-1
X-Mimecast-MFC-AGG-ID: rWnqeOEhNZKsnDv-0ZdfOw
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5412ceadaa3so397373e87.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 06:07:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734617245; x=1735222045;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0VOZOqTYjuBQWSRbaodVkgoqbpVNKqGHG8LBQQLmWQQ=;
 b=c/2Sg8AxXXf9ymY0LjfVYL/IlAd7Rc0iPDKa3aJKGeuDjZor9bT8TOpTncPG6AvXNM
 WfvNeXS4SecfAOFTahTYzYtzA7QNmdryTi1l+sQeStj4qBMYio5PEyxrjvh8sKIp1xGl
 fUsaJLPV5sJkK29urylsZDTda+S34u5r8YVMdOsTGaSPPNEJ79sl91X5zELoRVj0m2gX
 04h3GC/iledECZILnHZC7TOpv07ouVR0e4CHMJDyNCdqBFG3UVrFsZGQkXC0Voq1rJjo
 lA3l/n2zTQa51lEx5Q1wJqcCOaGsIQH0s/SqjxUtb+mU8T0wbDLRPwFalil8fWDJly/y
 tAYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhhUgFK9aOmu1SFWruY8AJ5ZlVCwMz3B9oVSOeHCUlbNCUPbrrzLvzW6KL/eLFtC/UXSm4OwnjwWm1@nongnu.org
X-Gm-Message-State: AOJu0YxFSjP4cBhKWQmsyRAxqMC4iZPsfuNXhjFr3IqJb7+EFKh5rTZ9
 kLq05xDIuqFS0aRqaYlq2oR+6UZv3+BFzq+4wL38Q7/UKffSC+if7Y+u2uhVk4fOaRnDxgsUg0G
 9ZKJjVuVo9i7AL1p4wC57UIaGxyh+0McSYO3fkaAo++AdZ/I01HRnzMiqdKw2EvhXbvrQg0JsgW
 dB+7/pDeB8o88NN+dOhBJv9h/G/L8=
X-Gm-Gg: ASbGnctR+P9YJMHv1cajmm3DjGpCbz47fNCNm89Z4FmpFbglEpBgcMN48iYRaVs7grK
 Ipr+w75HRHNRaaTyHbVQYRkRbk7fJfR08InxSX6w=
X-Received: by 2002:a05:6512:39ce:b0:542:2486:6977 with SMTP id
 2adb3069b0e04-542248669c2mr692379e87.19.1734617245234; 
 Thu, 19 Dec 2024 06:07:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcAMvTLxSY1+GLJkuonTmESrsvV+wwEEdyE1vUIFzVSrS318AwzLkS3ie1nPQXh6E3MSAkYugxZTQ+zdKfPTs=
X-Received: by 2002:a05:6512:39ce:b0:542:2486:6977 with SMTP id
 2adb3069b0e04-542248669c2mr692349e87.19.1734617244860; Thu, 19 Dec 2024
 06:07:24 -0800 (PST)
MIME-Version: 1.0
References: <20241216114841.1025070-1-anisinha@redhat.com>
 <61096f4d-7b5f-48fd-9840-caf058db2201@linaro.org>
 <2933CCF9-F9D6-46D1-9658-07B85104011D@redhat.com>
 <6eed1b13-f41a-4590-8254-dbfb1f9c7a5b@linaro.org>
 <CAMxuvawa3G_G4DvSNdF_y2anTtte0ayVaANsvo9Gh_TKP3bEbA@mail.gmail.com>
In-Reply-To: <CAMxuvawa3G_G4DvSNdF_y2anTtte0ayVaANsvo9Gh_TKP3bEbA@mail.gmail.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Thu, 19 Dec 2024 19:37:12 +0530
Message-ID: <CAK3XEhPu1mg3KWWDViw0bSQHq=+wxmB0ZDu=Yf7-Z2889sW=yg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alexander Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Daniel Berrange <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On Thu, Dec 19, 2024 at 6:25=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi
>
> On Thu, Dec 19, 2024 at 2:03=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
> <philmd@linaro.org> wrote:
> > >>> +static const TypeInfo vmfwupdate_device_info =3D {
> > >>> +    .name          =3D TYPE_VMFWUPDATE,
> > >>> +    .parent        =3D TYPE_DEVICE,
> > >>
> > >> What is the qdev API used here? Why not use a plain object?
> > >
> > > I wrote this taking vmcoreinfo device as starting point. I will leave=
 this as is for now unless anyone has strong opinions.
> >
> > We shouldn't blindly copy/paste & spread possible design mistakes.
> >
> > Marc-Andr=C3=A9, any particular reason to implement vmcoreinfo using qd=
ev
> > and not plain object?
> >
>
> I don't remember (damn 8y ago..). It seems the design changed over
> time during review, qdev might have been necessary and stayed this
> way.

I changed it to TYPE_OBJECT and we get a crash here:

#3  0x0000aaaaab207a48 [PAC] in object_class_dynamic_cast_assert
    (class=3D0xaaaaac608880, typename=3Dtypename@entry=3D0xaaaaab4b9630
"device", file=3Dfile@entry=3D0xaaaaab4300d0
"/workspace/qemu-ani/include/hw/qdev-core.h", line=3Dline@entry=3D77,
func=3Dfunc@entry=3D0xaaaaab595a90 <__func__.0> "DEVICE_CLASS") at
../qom/object.c:1021
#4  0x0000aaaaaaec2d74 in DEVICE_CLASS (klass=3D<optimized out>) at
/workspace/qemu-ani/include/hw/qdev-core.h:77
#5  vmcoreinfo_device_class_init (klass=3D<optimized out>,
data=3D<optimized out>) at ../hw/misc/vmcoreinfo.c:88

Basically doing this would be illegal for vmcoreinfo and we need to
adjust the code :

   DeviceClass *dc =3D DEVICE_CLASS(klass);

    dc->vmsd =3D &vmstate_vmcoreinfo;
    dc->realize =3D vmcoreinfo_realize;
    dc->hotpluggable =3D false;
    set_bit(DEVICE_CATEGORY_MISC, dc->categories);

Anyway, for vmfwupdate, it is actually like a device with device properties=
:

+    device_class_set_props(dc, vmfwupdate_properties);

So I prefer to make it qdev type for now.


