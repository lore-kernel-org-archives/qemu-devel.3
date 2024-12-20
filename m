Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1FDE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 13:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOd6K-0002Hv-R1; Fri, 20 Dec 2024 08:31:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tOd69-0002Fp-Rj
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 08:31:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tOd67-0004jS-Dl
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 08:31:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734701477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8p3QUiYEwSaFTc1LOsmCnz4u3q2nceb1Rt4iLa5PiZA=;
 b=K0RFB0NFVJ4Wqn+EY4FrGrD8o0AzmIerHh28DhwfySL4lsSG04PDwC4A9mPBQc2qP7VCfV
 IBeU40heRca8uMDk9+DserE1BtWTYMsYkvpu6wH+CRNNfTcfvB09hZRDzDQUvZjp9I7x1E
 U96xKOTr0gyQf3me5+Jc1eUIYSGrDAY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-VozV50pWOZ-dk1dVOJ9R2Q-1; Fri, 20 Dec 2024 08:31:15 -0500
X-MC-Unique: VozV50pWOZ-dk1dVOJ9R2Q-1
X-Mimecast-MFC-AGG-ID: VozV50pWOZ-dk1dVOJ9R2Q
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aa6b904a886so144614366b.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 05:31:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734701474; x=1735306274;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8p3QUiYEwSaFTc1LOsmCnz4u3q2nceb1Rt4iLa5PiZA=;
 b=lBFyFL1vLPyjsoWBa0wnUqP0+Hi7SFF651Af5d2CelBkYJun7J273JKZsq6Xx7G/If
 K7//lKSHcO62Q3HWXAQCFR/exIU8RZNXuDGjs/tLl/A81Xau2ZnkqoTBVGDfmnMz+VQG
 91U+JFjPS0tOLuLgDv/R0bptDFAbDahYlstFJANo1G4ZljgpfGDl0Mf3xNwjDlFbssHG
 WR8aQju4PQnFJB1sLoAknhWeHQgg+PHRP5QS44SjUfwr+m9ik3aO84QNCBejw69BSPhO
 9t2jSompmhs6xKy6Lifjhgyc24JVq+QR96m2Vh3Sl9y6O2ChnHoevGjei3eeX1DmXinn
 yxuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUmFArmsqkSBiEvgB9r7zIYmYZ9m/vWBFq8mNdtxBCVlfjSL8/IAs5/RjhkvA+tIjgZNX/Mp3/t94C@nongnu.org
X-Gm-Message-State: AOJu0YzIYslIdF1bJDsVIJObX4Xw+/O6SHyBypjHe0czDh0+CEpeEWJH
 fgo/ZEs5apIC3N1LwA4MQRpHTiSVtuAfKrA/P1IUqcKw3FdtRi3eRu3BZ+SRVqA+N36jaWs6ssf
 yCFKOqUJiHMwkjc9CAfsJa9cTrhXnuB0/GgQrrnMZao7/PrM3CVewtTE54rAToOvCrBNnmiP13F
 Tdt7C1JTwDnB3BLlIKEoVuTyvYHy0=
X-Gm-Gg: ASbGncuC2/24yKYAH2CnrKlTK5oykwFemvfXDtOAfc0W41ZnEDuIraYeyHF63zTXL+b
 76S9u6/axX7gGDfifEJD/TBt6ToauuBdST6w=
X-Received: by 2002:a17:907:d9e:b0:aa6:8676:3b3b with SMTP id
 a640c23a62f3a-aac2cc722f0mr218156466b.30.1734701474212; 
 Fri, 20 Dec 2024 05:31:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpqfOeUoK/NLkRGnjKFPL1EWzW1qdTZRcttGYTgRFaGCJt/nTh3jtRZbIg2LBllD47KJlms4+Kxw1H1WAHomI=
X-Received: by 2002:a17:907:d9e:b0:aa6:8676:3b3b with SMTP id
 a640c23a62f3a-aac2cc722f0mr218153366b.30.1734701473813; Fri, 20 Dec 2024
 05:31:13 -0800 (PST)
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
In-Reply-To: <1bbf92cf-d9d0-421e-b674-fb216cb7216a@amazon.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Fri, 20 Dec 2024 19:01:02 +0530
Message-ID: <CAK3XEhOmpQULP6xCetkrwHC_FzSMRs7LSsCyzeUpvqRkw-zkOA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: Alexander Graf <graf@amazon.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffman <kraxel@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
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

On Fri, Dec 20, 2024 at 5:03=E2=80=AFPM Alexander Graf <graf@amazon.com> wr=
ote:
>
>
> On 20.12.24 11:00, Ani Sinha wrote:
> >>> Either add the I386 dependency or don't use PC_MACHINE, because on
> >>> non-x86 targets PC_MACHINE(qdev_get_machine()) will crash.
> >> Ah this is where we have a disconnect. I assumed that
> >>> pcms =3D PC_MACHINE(m_obj)
> >> would return NULL on non-x86.
> >>
> >> Seems a better way to do this (as is done in vga.c) is to use
> >> object_dynamic_cast()
> >> How about
> >>
> >> diff --git a/hw/misc/vmfwupdate.c b/hw/misc/vmfwupdate.c
> >> index 0e90bd10e1..19d042b929 100644
> >> --- a/hw/misc/vmfwupdate.c
> >> +++ b/hw/misc/vmfwupdate.c
> >> @@ -32,9 +32,11 @@ static inline VMFwUpdateState *vmfwupdate_find(void=
)
> >>   static uint64_t get_max_fw_size(void)
> >>   {
> >>       Object *m_obj =3D qdev_get_machine();
> >> -    PCMachineState *pcms =3D PC_MACHINE(m_obj);
> >> +    MachineState *ms =3D MACHINE(m_obj);
> >> +    PCMachineState *pcms;
> >> -    if (pcms) {
> >> +    if (object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE)) {
> >> +        pcms =3D PC_MACHINE(m_obj);
> >>           return pcms->max_fw_size;
> >>       } else {
> >>           return 0;
> >>
> > For the records, I tested this with arm and the following command line
> > does not crash QEMU;
> >
> > ./qemu-system-arm -machine virt-9.2 -device vmfwupdate
> >
> > I have also added a separate functional test to exercise basic device
> > creation which will be part of v5 when I send it out.
>
>
> You are currently not implementing the reset logic required to actually
> make vmfwupdate work.

Yes that is correct and that is by design. The reset logic on CoCo
depends on the larger piece of work on how to enable reset and
re-instantiation of the VM without simply terminating. I did not want
to wait until all those complicated bits were sorted out first. I
wanted to make sure that the hypervisor/guest interface is put in
place.

That means technically, the device should not be
> instantiable on *any* platform at the moment. For example with the
> command line above you would advertise the capability to update firmware
> in fw-cfg, but then not back it by functionality.

OK so if we wanted to put this work peace meal in smaller chunks, can
we have an additional capability bit that actually advertizes this
functionality on certain machine types/platforms?

If QEMU were to merge
> this patch, it would just create a broken device.

Are you talking about CoCo or non-CoCo?

>
> Please make sure that the vmfwupdate device can only be instantiated on
> machine types that it has full support for.
>
>
> Alex
>
>
>
>
> Amazon Web Services Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597


