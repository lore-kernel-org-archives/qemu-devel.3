Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCF6E9E30D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 14:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqBED-0005bX-8S; Wed, 11 Feb 2026 09:30:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1vqBE9-0005Yj-BW
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 09:30:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1vqBE6-0002BY-F4
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 09:30:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770820197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GN15X+TAid9B0KOc2ERlH5+isxNWIydaprAFj1PbZYI=;
 b=TovStu31b9mjnru+lurkC9izLwbcYLIz/7UhLtr25Gln+h37dvrxva22fBol4gRDVN9BBo
 sh0es+Q8P5Yp/mXf6i0G0aSp8eyfUw0WF306F5IPWWBdeQtBaeW3Aadv0dOJL8rP9MSZ1l
 kjYFlbMkujIzlwrxwg0jEvEp754cdSY=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-JEtu7Rs5PPK_Ty1-M2DyEQ-1; Wed, 11 Feb 2026 09:29:56 -0500
X-MC-Unique: JEtu7Rs5PPK_Ty1-M2DyEQ-1
X-Mimecast-MFC-AGG-ID: JEtu7Rs5PPK_Ty1-M2DyEQ_1770820195
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-673eef46147so5165735eaf.0
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 06:29:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770820195; cv=none;
 d=google.com; s=arc-20240605;
 b=PQ0YXuufoKS8UaeWc7gZfGUGxrtXqP4fiX7ISaVEQCM2z6UERV08W5E210iVt4VfHj
 MNecx37dGi5lEuwdkr72oLruymeCF+L6+dFW2FNEaS/ViwaQy6njNzw5V5LK7/qjvEnw
 ny/wDP0ArHtTwTtvtMSpDOSJj1EM7j+cOlNjX+2X0gE0/jETVQPh0ctIRCySLz+z0dSC
 m2UrtKLxPcsf8reA+yeJTKdMEgVXdwhnSJgP4k35bTqnXDP2/n7ttlGgGUN6zrXsYTML
 BHUxkryJcu30np485VSHa6H5qVrkYtwdXb2EGpC3FDj0ZiTv6a1ozJEbKuuAl0l6MHAk
 nxAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GN15X+TAid9B0KOc2ERlH5+isxNWIydaprAFj1PbZYI=;
 fh=tOAdM3Fbhpt0301roSv6FtCo1R7eu/CAkr/w65rw+s8=;
 b=daLQ44Vsq1hNap+/DfkM5MsCIRQM2NY68cQKve2YrqE2bbxadjhoBZyinDx7I1dKwI
 3nNHrI2nH3reWbw52Bd+UjAjrVPcjX1rntdGOd5XjGpYyqkgIqHjOGtag6scCLKvePMI
 nhNI1x+E60L3q15Nrh/tgZK4JSX0MpvJpVRiMiOLJU6NeDWzVO2nK6M9Si7u18UGkLWq
 FebIR030otCJqJDPsv5KTl7emZHNvRNevYSJiwiZWhwKXznl3LGwPzj6lgNc5WKAUVCQ
 YIDTUCflYh3FvCzJdiwz2XtrSeqtqQpH4V1uxMzPx621LXTSpRilxwGIpF14dncpQq6x
 uJ5g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770820195; x=1771424995; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GN15X+TAid9B0KOc2ERlH5+isxNWIydaprAFj1PbZYI=;
 b=eUag3SdAQVwFZeDfGgw0w7Q/UrRXKriBcIaUbGJhpz6Yh4GoCNi5TxIB1gTNhH7/4e
 CGpVxmhmDYDEBDxqA+e2LPxsPJ7xSr3rWjNQIra9/Leu9/ljtKUBvkQv6Ly/+SGWJM6A
 9yUr5J6t5SQRRFE+2drPP3MTdIfW2noHbk8nFQfmX7VzYpErvqv3+LETNIuDKwygf5be
 Y79+thFmD8JBjcISZG/CUZT9NZBbJP3gSlPpCmWKSepXluKzJLXqBFH2X1GBcGOln9us
 ZLnnrV1mWYw8y3c0UDK9oie9Y8uwZwi4YdR5/g16tkWutAKQOYDVM7rzAHf1vKlh0b90
 88cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770820195; x=1771424995;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GN15X+TAid9B0KOc2ERlH5+isxNWIydaprAFj1PbZYI=;
 b=Eel4Vd0HMw/RjVjxWnGGALxcDR8xCb6+HbjkNPhyz4UwZ4+AIXjxtNB0yIHz0dCui9
 vZdz13ZPnB+JexfNX/BlmuK/i/hN6myal/2qIIHyVgnpsMlA5Ffdmrj785htth4nwYwN
 PFboNGFL+bo7iBBZtX5PNcaIlFuEIy9PUYX+nhb5VW3qFpxBfQg4rwgeQ1K+JIbSZkVs
 nmqpW/3pWVHDGfOgdTqXsiV6eVO8aYLze4SQGkIaqRTLJJx9dqFfJeaANnJ+pH5dSA4q
 GwMlbsJttZWLV6W3wtWZ7exLi0k7Z4pbsxCwCsobEMi+boHg7xQYHcjpe9fKmdBjfzPM
 YLRQ==
X-Gm-Message-State: AOJu0YyNzEIB4JHBs2oirQ7t1OVDZQO8ZAR9lABh8SyNzreO8vBUJ5PB
 qDoDQWKGrml181Y15XX2rtOLo/xArw5VhLmHwlNe2jPuhVygwKv9k1aZ/laVBRKNIo5JY0bNVDw
 0qne7zawJsQLTwlsOj3L6ay9DgI+75Ca4tnl7T3oaTWZB/VDN0x6zI9ujndo4SQpupEKTnTOukj
 k+sly2Z3hfSefp1XQ31gKsDQdeRt2yiHI=
X-Gm-Gg: AZuq6aI6ed/5NBxOeFb5q/ly03R4AKgzQV3dvzg6HZyiM2X4ZRq7SOJyB5Rt9ccGkRn
 lxTflO6tIkJ1FwMFcOw64yv6TEm3kLvAB6536au8oR7lNw8pZTEc5lIH17MfUdVgIUhrXi1Ial1
 S3fOJb7hnXR8yCDbEAAPebg1Y6NHzQyu+z4m8nOGTJH8QDet1HMmmbqnsIVLlJ/4/Ag7w7pUDbF
 V7Hn1XSiKbPFtAjxDcYBZq6wRVa02a7NKMB
X-Received: by 2002:a05:6820:2008:b0:672:a49f:1297 with SMTP id
 006d021491bc7-67437f5c609mr1351852eaf.4.1770820195165; 
 Wed, 11 Feb 2026 06:29:55 -0800 (PST)
X-Received: by 2002:a05:6820:2008:b0:672:a49f:1297 with SMTP id
 006d021491bc7-67437f5c609mr1351837eaf.4.1770820194743; Wed, 11 Feb 2026
 06:29:54 -0800 (PST)
MIME-Version: 1.0
References: <20260211122759.125094-1-mbawa@redhat.com>
 <BE3C6640-85CB-437D-A038-81762FA5AD33@unpredictable.fr>
In-Reply-To: <BE3C6640-85CB-437D-A038-81762FA5AD33@unpredictable.fr>
From: Mohammadfaiz Bawa <mbawa@redhat.com>
Date: Wed, 11 Feb 2026 19:59:37 +0530
X-Gm-Features: AZwV_Qjflcr1G72rm6uYICQYbC-LmZcJHgaw36ltsi1OueVYZEKSrkkBk7Wxx6k
Message-ID: <CAJg9KkwOov56rOFOKergi9nUvqbbF=TMzSWBfFge1Y6v2s8Q2A@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt: Add virtio-transports property
To: mohamed@unpredictable.fr
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, 
 alex.bennee@linaro.org, philmd@linaro.org, cohuck@redhat.com, 
 eric.auger@redhat.com, sebott@redhat.com
Content-Type: multipart/alternative; boundary="000000000000abc14f064a8d34ab"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000abc14f064a8d34ab
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mohamed,

Thanks for the review!

> Any particular reason to (keep) capping the maximum to 16?

To be honest, I simply preserved the existing behavior,
"NUM_VIRTIO_TRANSPORTS"
was already hardcoded to 32 in virt.h before this patch.I didn't want to
change more than necessary for the scope of this fix.

I don't have strong feelings about this limit. If prefered, I can
remove the validation entirely and let uint8_t be the natural limit (255),
or we could increase it in a future patch if there's a real need for more
transports.

Happy to adjust based on feedback.

Thanks,
Faiz

On Wed, Feb 11, 2026 at 6:37=E2=80=AFPM Mohamed Mediouni <mohamed@unpredict=
able.fr>
wrote:

>
>
> > On 11. Feb 2026, at 13:27, Mohammadfaiz Bawa <mbawa@redhat.com> wrote:
> >
> > Windows ARM64 guests detect virtio-mmio devices declared in ACPI
> > tables even when no backend is attached. This causes "Unknown
> > devices" (ACPI\LNRO0005) to appear in Device Manager.
> >
> > Until Windows fixes that by supporting, adding a new machine
> > property 'virtio-transports' to control the number of
> > virtio-mmio transports instantiated. The default remains
> > NUM_VIRTIO_TRANSPORTS (32) for backward compatibility.
> > Setting it to 0 allows users to disable virtio-mmio entirely.
> >
> > Usage: -machine virt,virtio-transports=3D0
>
> Hello,
>
> With keeping in mind that this was documented in this (closed=E2=80=A6) i=
ssue
> https://github.com/virtio-win/kvm-guest-drivers-windows/issues/595
>
> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>
> >
> > Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
> > ---
> > hw/arm/virt-acpi-build.c |  2 +-
> > hw/arm/virt.c            | 43 ++++++++++++++++++++++++++++++++++++++--
> > include/hw/arm/virt.h    |  1 +
> > 3 files changed, 43 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index c145678185..27c007fd62 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -1150,7 +1150,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker=
,
> VirtMachineState *vms)
> >     fw_cfg_acpi_dsdt_add(scope, &memmap[VIRT_FW_CFG]);
> >     virtio_acpi_dsdt_add(scope, memmap[VIRT_MMIO].base,
> memmap[VIRT_MMIO].size,
> >                          (irqmap[VIRT_MMIO] + ARM_SPI_BASE),
> > -                         0, NUM_VIRTIO_TRANSPORTS);
> > +                         0, vms->virtio_transports);
> >     acpi_dsdt_add_pci(scope, memmap, irqmap[VIRT_PCIE] + ARM_SPI_BASE,
> vms);
> >     if (vms->acpi_dev) {
> >         build_ged_aml(scope, "\\_SB."GED_DEVICE,
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 390845c503..0a659ba540 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -1206,7 +1206,7 @@ static void create_virtio_devices(const
> VirtMachineState *vms)
> >      * between kernel versions). For reliable and stable identification
> >      * of disks users must use UUIDs or similar mechanisms.
> >      */
> > -    for (i =3D 0; i < NUM_VIRTIO_TRANSPORTS; i++) {
> > +    for (i =3D 0; i < vms->virtio_transports; i++) {
> >         int irq =3D vms->irqmap[VIRT_MMIO] + i;
> >         hwaddr base =3D vms->memmap[VIRT_MMIO].base + i * size;
> >
> > @@ -1221,7 +1221,7 @@ static void create_virtio_devices(const
> VirtMachineState *vms)
> >      * loop influences virtio device to virtio transport assignment,
> whereas
> >      * this loop controls how virtio transports are laid out in the dtb=
.
> >      */
> > -    for (i =3D NUM_VIRTIO_TRANSPORTS - 1; i >=3D 0; i--) {
> > +    for (i =3D vms->virtio_transports - 1; i >=3D 0; i--) {
> >         char *nodename;
> >         int irq =3D vms->irqmap[VIRT_MMIO] + i;
> >         hwaddr base =3D vms->memmap[VIRT_MMIO].base + i * size;
> > @@ -2705,6 +2705,36 @@ static void virt_set_highmem_mmio_size(Object
> *obj, Visitor *v,
> >     extended_memmap[VIRT_HIGH_PCIE_MMIO].size =3D size;
> > }
> >
> > +static void virt_get_virtio_transports(Object *obj, Visitor *v,
> > +                                       const char *name, void *opaque,
> > +                                       Error **errp)
> > +{
> > +    VirtMachineState *vms =3D VIRT_MACHINE(obj);
> > +    uint8_t transports =3D vms->virtio_transports;
> > +
> > +    visit_type_uint8(v, name, &transports, errp);
> > +}
> > +
> > +static void virt_set_virtio_transports(Object *obj, Visitor *v,
> > +                                       const char *name, void *opaque,
> > +                                       Error **errp)
> > +{
> > +    VirtMachineState *vms =3D VIRT_MACHINE(obj);
> > +    uint8_t transports;
> > +
> > +    if (!visit_type_uint8(v, name, &transports, errp)) {
> > +        return;
> > +    }
> > +
> > +    if (transports > NUM_VIRTIO_TRANSPORTS) {
> > +        error_setg(errp, "virtio-transports must not exceed %d",
> > +                   NUM_VIRTIO_TRANSPORTS);
> Any particular reason to (keep) capping the maximum to 16?
>
> From a cursory look, base_memmap seems to have room for plenty more.
>
>

--000000000000abc14f064a8d34ab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Mohamed,<br><br>Thanks for the review!<br><br>&gt; Any =
particular reason to (keep) capping the maximum to 16?<br><br>To be honest,=
 I simply preserved the existing behavior, &quot;NUM_VIRTIO_TRANSPORTS&quot=
;<br>was already hardcoded to 32 in virt.h before this patch.I didn&#39;t w=
ant to<br>change more than necessary for the scope of this fix.<br><br>I do=
n&#39;t have strong feelings about this limit. If prefered, I can<br>remove=
 the validation entirely and let uint8_t be the natural limit (255),<br>or =
we could increase it in a future patch if there&#39;s a real need for more<=
br>transports.<br><br>Happy to adjust based on feedback.<br><br><div>Thanks=
,<br>Faiz</div></div><br><div class=3D"gmail_quote gmail_quote_container"><=
div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 11, 2026 at 6:37=E2=80=AFP=
M Mohamed Mediouni &lt;<a href=3D"mailto:mohamed@unpredictable.fr">mohamed@=
unpredictable.fr</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex"><br>
<br>
&gt; On 11. Feb 2026, at 13:27, Mohammadfaiz Bawa &lt;<a href=3D"mailto:mba=
wa@redhat.com" target=3D"_blank">mbawa@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt; Windows ARM64 guests detect virtio-mmio devices declared in ACPI<br>
&gt; tables even when no backend is attached. This causes &quot;Unknown<br>
&gt; devices&quot; (ACPI\LNRO0005) to appear in Device Manager.<br>
&gt; <br>
&gt; Until Windows fixes that by supporting, adding a new machine<br>
&gt; property &#39;virtio-transports&#39; to control the number of<br>
&gt; virtio-mmio transports instantiated. The default remains<br>
&gt; NUM_VIRTIO_TRANSPORTS (32) for backward compatibility.<br>
&gt; Setting it to 0 allows users to disable virtio-mmio entirely.<br>
&gt; <br>
&gt; Usage: -machine virt,virtio-transports=3D0<br>
<br>
Hello,<br>
<br>
With keeping in mind that this was documented in this (closed=E2=80=A6) iss=
ue<br>
<a href=3D"https://github.com/virtio-win/kvm-guest-drivers-windows/issues/5=
95" rel=3D"noreferrer" target=3D"_blank">https://github.com/virtio-win/kvm-=
guest-drivers-windows/issues/595</a><br>
<br>
Reviewed-by: Mohamed Mediouni &lt;<a href=3D"mailto:mohamed@unpredictable.f=
r" target=3D"_blank">mohamed@unpredictable.fr</a>&gt;<br>
<br>
&gt; <br>
&gt; Signed-off-by: Mohammadfaiz Bawa &lt;<a href=3D"mailto:mbawa@redhat.co=
m" target=3D"_blank">mbawa@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt; hw/arm/virt-acpi-build.c |=C2=A0 2 +-<br>
&gt; hw/arm/virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 43 ++++++++++=
++++++++++++++++++++++++++++--<br>
&gt; include/hw/arm/virt.h=C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt; 3 files changed, 43 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c<br>
&gt; index c145678185..27c007fd62 100644<br>
&gt; --- a/hw/arm/virt-acpi-build.c<br>
&gt; +++ b/hw/arm/virt-acpi-build.c<br>
&gt; @@ -1150,7 +1150,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linke=
r, VirtMachineState *vms)<br>
&gt;=C2=A0 =C2=A0 =C2=A0fw_cfg_acpi_dsdt_add(scope, &amp;memmap[VIRT_FW_CFG=
]);<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtio_acpi_dsdt_add(scope, memmap[VIRT_MMIO].base,=
 memmap[VIRT_MMIO].size,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 (irqmap[VIRT_MMIO] + ARM_SPI_BASE),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A00, NUM_VIRTIO_TRANSPORTS);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A00, vms-&gt;virtio_transports);<br>
&gt;=C2=A0 =C2=A0 =C2=A0acpi_dsdt_add_pci(scope, memmap, irqmap[VIRT_PCIE] =
+ ARM_SPI_BASE, vms);<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (vms-&gt;acpi_dev) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build_ged_aml(scope, &quot;\\_SB.&quo=
t;GED_DEVICE,<br>
&gt; diff --git a/hw/arm/virt.c b/hw/arm/virt.c<br>
&gt; index 390845c503..0a659ba540 100644<br>
&gt; --- a/hw/arm/virt.c<br>
&gt; +++ b/hw/arm/virt.c<br>
&gt; @@ -1206,7 +1206,7 @@ static void create_virtio_devices(const VirtMach=
ineState *vms)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * between kernel versions). For reliable and stabl=
e identification<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * of disks users must use UUIDs or similar mechani=
sms.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; -=C2=A0 =C2=A0 for (i =3D 0; i &lt; NUM_VIRTIO_TRANSPORTS; i++) {<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; vms-&gt;virtio_transports; i++) {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int irq =3D vms-&gt;irqmap[VIRT_MMIO]=
 + i;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hwaddr base =3D vms-&gt;memmap[VIRT_M=
MIO].base + i * size;<br>
&gt; <br>
&gt; @@ -1221,7 +1221,7 @@ static void create_virtio_devices(const VirtMach=
ineState *vms)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * loop influences virtio device to virtio transpor=
t assignment, whereas<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * this loop controls how virtio transports are lai=
d out in the dtb.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; -=C2=A0 =C2=A0 for (i =3D NUM_VIRTIO_TRANSPORTS - 1; i &gt;=3D 0; i--)=
 {<br>
&gt; +=C2=A0 =C2=A0 for (i =3D vms-&gt;virtio_transports - 1; i &gt;=3D 0; =
i--) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *nodename;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int irq =3D vms-&gt;irqmap[VIRT_MMIO]=
 + i;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hwaddr base =3D vms-&gt;memmap[VIRT_M=
MIO].base + i * size;<br>
&gt; @@ -2705,6 +2705,36 @@ static void virt_set_highmem_mmio_size(Object *=
obj, Visitor *v,<br>
&gt;=C2=A0 =C2=A0 =C2=A0extended_memmap[VIRT_HIGH_PCIE_MMIO].size =3D size;=
<br>
&gt; }<br>
&gt; <br>
&gt; +static void virt_get_virtio_transports(Object *obj, Visitor *v,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const=
 char *name, void *opaque,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error=
 **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VirtMachineState *vms =3D VIRT_MACHINE(obj);<br>
&gt; +=C2=A0 =C2=A0 uint8_t transports =3D vms-&gt;virtio_transports;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 visit_type_uint8(v, name, &amp;transports, errp);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void virt_set_virtio_transports(Object *obj, Visitor *v,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const=
 char *name, void *opaque,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error=
 **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VirtMachineState *vms =3D VIRT_MACHINE(obj);<br>
&gt; +=C2=A0 =C2=A0 uint8_t transports;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!visit_type_uint8(v, name, &amp;transports, errp)) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (transports &gt; NUM_VIRTIO_TRANSPORTS) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;virtio-transports =
must not exceed %d&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
NUM_VIRTIO_TRANSPORTS);<br>
Any particular reason to (keep) capping the maximum to 16?<br>
<br>
From a cursory look, base_memmap seems to have room for plenty more.<br>
<br>
</blockquote></div>

--000000000000abc14f064a8d34ab--


