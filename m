Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBD3C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 16:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1pE1-0005Yb-Eg; Mon, 07 Apr 2025 12:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dionnaglaze@google.com>)
 id 1u1pE0-0005YQ-2U
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 12:21:28 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dionnaglaze@google.com>)
 id 1u1pDy-0007qE-0X
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 12:21:27 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ac297cbe017so1050959566b.0
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 09:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1744042882; x=1744647682; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bL0aXEgui9VZ7sTVn1XGSTgd0YBucqzIaJbU5jUHxR0=;
 b=u0uvoqq2skaN2kvZbMzeBpvNsL3Ae8aEO6rXBKebbuK0twd3pkv2VegSjnn92bc6Ck
 B8hGDgu/K12QVsMXPx+ooy6gxDLryQF9L48oZg7t3R1uxRCNaHQsJUnkU/yjEcgYxSyt
 moPTwuNURAv2JOGVKSbUnsphNNRNO/Vt/l0gwwtZwdAv94fqHpxCSHHdjPWm7DnM8V3d
 ADA0X1mHnytYI8Eg7EQgJeAxwigXUGoPRwVvKSHZHsa9D8EsTJ0k5pxkGmDHz0usQL/Z
 HSMRxSBA2y5HAHsqM5Q9C18hhoeKM1j6jgeSGle83W1wu5MyfwoBhtp5XsVYH/VTH85N
 ZIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744042882; x=1744647682;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bL0aXEgui9VZ7sTVn1XGSTgd0YBucqzIaJbU5jUHxR0=;
 b=IUadSP4jZo37tA64evA0XFFHGPKjHR+Dcc63phHQaVyIR3TZclfEfb7TzdOkVv6N8S
 KrKh4+KM9P2sE2pyzONOyfXbkfmf0y5CHQ5V5KhzBTOuVlZi2AxdRUSANBvQnvbHIUEL
 cVTfRTYI1tClSlFHXgrTbPn0t/UX7mV9g6jvgRBsoRUmtP8sL8xvxrYNLoLmweShN6m2
 Tu6aqocWcFHtjHwVXyWtDzHUwLPY5KIFhWZGFUQBRaoaXjygt1gkrIvWR1Evm4Y1OzJt
 APfY3s/KNkvKFUbxXTzdff3/S6Qi4cHUrFZ4uNq71EoXD/KD/4GFat2YAyd8CYc84PBi
 Bh/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7cJLzHUVbxkQqmtZtQWm1icRUiwAUqT4JUesg8VZTHQC3Hof3IQZJ3GugbvadSebwbp6tlRbzVrs7@nongnu.org
X-Gm-Message-State: AOJu0YysEYH55JkbjnwgBZ0pEWwvxtOxDLAMzQpob0XWfGpePhi/Dpi6
 GSDUoZuo5iptEPJh2/y1Y+uwYfdJbmIzLCVWJyEMNNG80QHq9LYJ1FleF1a/UY+dKyeYBVpvkXH
 f35xqNNaWNVXDhXyJSqf/voyjermlcpEBC5aj
X-Gm-Gg: ASbGncuAc0Uiyckv9aTAJdL098wO7k39lagzf20s/jeuSz+0WaWSFqNM7+O9I2V0NUE
 di7C8Kit5q/q/KsnqvQDvTM5K64+tXiPy+DrsB7Lvs0smSB/E7PKSIp3ILlCKZ2daqNysj8wNDn
 J2uaT5GSSUjy+jOBK+WB8SAo613g==
X-Google-Smtp-Source: AGHT+IHaZfiiixr2CvxJUutFuYS0WeWFCTsIB5XVgtcSPk189u2jGRfPpc77KOb64Sn/B4q8VRTq6HVV8UrRezacj4g=
X-Received: by 2002:a17:907:1c99:b0:ac6:e29b:8503 with SMTP id
 a640c23a62f3a-ac81a4131c5mr10207666b.1.1744042881899; Mon, 07 Apr 2025
 09:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <4p7orqixni5m3444l53isxe5awdwasrb5e5bu6wu4phhycqpir@z22wgnaxowsg>
 <CAK3XEhNeB29eaPxZ_1Cc7WfEzOGZZPcvTc5uC1XAdtG0uNfDRw@mail.gmail.com>
 <h2s75tkddnrmodbbr7hxugrivpbhq7cfpbmhmgqmnn5mlafedk@jhv5cobgtjkc>
 <CAK3XEhPYmBsn2-=PMR7qVQHiu0ydoh3EfJOEuunLccriSkKipg@mail.gmail.com>
 <53jhridwtejsuy4qojjr66rcjdebnyarwke4bs3m3w2afmqhe6@pab5zfyo46fx>
 <4f6a21a9-746e-45ac-88c7-dc0204480a86@amazon.com>
 <kmqzqeaatk3iyrpl4tvfxtfv6gefyusxpyxtz5bollw7jlp3wk@5c4zawrzehwq>
 <d79cff63-324f-4624-aef3-b6570cdb23e2@amazon.com>
 <rtbmlitus6unzibiatblquot2bthx4dmozbxgcbovisial6qar@konful7gzrsz>
 <6d815066-9977-4683-a2d5-871dda3e5369@amazon.com>
 <fwdk2pc4rfa5o22gdfqq4cfsqged4v6hmlrtqdwltgqj2bkpl4@bicazjx5d22l>
In-Reply-To: <fwdk2pc4rfa5o22gdfqq4cfsqged4v6hmlrtqdwltgqj2bkpl4@bicazjx5d22l>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Mon, 7 Apr 2025 09:21:09 -0700
X-Gm-Features: ATxdqUEdDSG42HNxIBTvYud_W0P39gjlLEKos7uBzUjpTP7hAEayNhgeH5Xj-bc
Message-ID: <CAAH4kHZhEX0kaE3r5PVOOWh1PhzZNOfyWMixDm0PbCnjfmZceA@mail.gmail.com>
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: Gerd Hoffman <kraxel@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, Ani Sinha <anisinha@redhat.com>, 
 =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=dionnaglaze@google.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Wed, Mar 26, 2025 at 2:53=E2=80=AFPM Gerd Hoffman <kraxel@redhat.com> wr=
ote:
>
>   Hi,
>
> > > >    2) The security posture of the system may be different between 2=
 validly
> > > > signed images. Think of Daniel's example of verbose kernel output. =
Maybe I
> > > > consider verbose kernel output already inacceptable, while RH think=
s it's an
> > > > ok posture to have. The user needs to have the chance to differenti=
ate
> > > > between a system booted with or without verbose kernel output.
> > > You easily get that by looking at the vTPM measurements.  So not sure
> > > what you are asking for, do you want be able to also do that without =
a
> > > vTPM?
> >
> > All of this should work without vTPMs. Why add complexity when you don'=
t
> > need it? The industry is already struggling to deal with TPMs alone. Th=
ere
> > are way too many potential holes in a solution where you first have to
> > reason about the integrity of your TPM before you can trust it. All of =
the
> > vTPM in SEV-SNP talk is a house of cards I'm happy to push (blow to kee=
p the
> > analogy?) against as hard as I can.
>
> TPM is the only thing we have outside of confidential computing.  So
> naturally there is alot of code and infrastructure for that despite the
> complexity of TPMs.  So having vTPMs in CVMs allows to reuse that
> infrastructure and it totally makes sense to support that.
>
> That doesn't imply this is the only option to handle things.  Having the
> option to tie everything to the launch measurement makes sense too.
> Fair point.
>
> > > > Ukify.py then generates the blob along with the FUKI.
> > > Doesn't fly from a distro point of view.  The UKI is signed, so RH sh=
ips
> > > that and the customer can't modify it to update the blob, say with so=
me
> > > additional hashes for 'db'.
> >
> > I don't follow. Is RH going to ship a UKI or a FUKI?
>
> How should I answer that one while we are still discussing the design?
>
> > And if RH ships the UKI, ukify could still take a UKI as input and
> > generate a FUKI based on it, no?
>
> Of course you can, but it'll break the RH signature.
>
> > During that process, it would generate a db which gets put at a fixed
> > location in RAM so the (RH provided) firmware picks it up and validates=
 the
> > UKI it loads is exactly that one UKI.
>
> Well.  If you want put the db into the igvm and the igvm into the uki
> you've got a chicken-and-egg problem.  Moving the firmware from the main
> UKI to UKI add-on would solve that.

Why is embedding a public key that will sign the IGVM in the IGVM a
chicken-and-egg problem? It's only that if db were a list of
acceptable measurements, which it isn't.
I'm not sure why relying on secure boot makes any sense for
confidential computing. I still think that tearing down the VM context
and rebuilding it is more secure, given
the need for an honest launch measurement/MRTD.

For Cloud Computing, which is the only place that FUKI makes sense as
a delivery mechanism, it's more important to rely on attestation
policy that has more awareness of the current security posture of
measurements.
Secure boot conflates authentic with secure. With a supply chain
distribution standard like CoRIM, we can ensure that individual
binaries have not only authentic measurements, but also security
version numbers (SVNs) that can be compared against a shorter-lived
endorsement of what is the most up-to-date and which CVEs are known
for lower SVNs.
Revocation is just not a real thing that works. Short-lived policy is.
Policy services can be updated more simply than the UEFI variables of
every node in the fleet.



>
> > We can extend that with an additional signature flow, where the ukify
> > generated db contains a signature for the UKI instead.
>
> certificate, not signature.  But, yes, that would work.
>
> > But I would generally advise against optimizing for certificate based
> > flows until revocation is sorted out.
>
> Well, if at the end of the day we'll go pass on a 'db' both signatures
> and hashes can be used.
>
> > > Effectively we need something roughly equivalent to shim's MokList.  =
The
> > > distro ships a default configuration (like the cert compiled into the
> > > shim binary) which works fine for most people.  For IGVM that would b=
e a
> > > default efi variable store compiled into the firmware binary.
> >
> > This only makes sense in a world where RH ships an SVSM and that's all =
you
> > want to attest. But that's a different flow from what we describe here.=
 To
> > actually get workload attestation, you need to include your rootfs in t=
he
> > attestation. And the only entity that can do that is the end customer. =
And
> > they will typically do that through something like dm-verity or fs-veri=
ty
> > and a hash provided on the kernel command line.
>
> So you'll have the RH UKI + customer add-on with the kernel command
> line.  And you need a customized igvm containing a 'db' which will allow
> both, either via certificate+signature or via hash, whatever you prefer.
>
> > > Does it make sense to simply move the firmware update sections from t=
he
> > > main UKI to an add-on?  That would allow customers to easily use thei=
r
> > > own if they wish, without breaking the RH signature on the UKI.
> >
> > I'm still not convinced "RH signature" is a useful marker at execution =
time
> > of confidential workloads.
>
> If the customer agrees they can go for hashes.  If not they should be
> able to use certificates.  So patching the RH shipped UKI is not an
> option.
>
> > > RH default igvm/add-on would simply have empty 'db' and 'dbx' pages.
> > >
> > > Looks workable to me.
> >
> > I would personally consider the "RH binary adds RH signature into binar=
y by
> > default" a backdoor, but that's you call :).
>
> It's surely possible to ship two variants, one with the RH certificates
> and one blank, so customers can pick the latter if they want allow
> specific hashes only.
>
> > I agree with the plan to amend the IGVM spec with the UEFI variable upd=
ate
> > page. I don't think it should be "db" and "dbx" pages. It should be a m=
ore
> > generic. In fact, why not make it a loader UEFI (PE) binary?
>
> Not convinced a PE binary is a good idea.  Adds one more indirection for
> no obvious gain.
>
> > > > All unauthenticated data, such as locations of the UKI and its add-=
ons gets
> > > > passed as parameter to the firmware IGVM.
> > > i.e. have a IGVM parameter for opaque_addr + opaque_size instead of
> > > placing this in the vmfwupdate struct?
> >
> > It would be a pretty natural fit for it, no?
>
> Absolutely.  Just wanted to make sure we are talking about the same thing=
.
>
> take care,
>   Gerd
>
>


--
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

