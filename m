Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179D0FD530E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 08:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvt8k-0004Lk-7U; Fri, 27 Feb 2026 03:24:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vvt8f-0004LG-E6
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 03:23:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vvt8d-0004sv-TS
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 03:23:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772180634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gLgmgrNhGxDNfWixSDZTdsPZO4KQ9usFY6SiGOqZX+c=;
 b=QkfLmyk7O//frCzkp8tR/yNzaJZScyb53B85mmpb432g3uV0fTRrI/jmE48mcvQ7iimMk+
 bQJcFcspZMzE32X4TNsEiVCTBl3h3eITMwkKt5fuF/4WT6d+OLpu42qJi/FcDqbDWENRv/
 vk0f0l64yQgOYviJGK77vPvmcD3oCL0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-nYSBgkrBPTqMxtrpunNq5Q-1; Fri, 27 Feb 2026 03:23:52 -0500
X-MC-Unique: nYSBgkrBPTqMxtrpunNq5Q-1
X-Mimecast-MFC-AGG-ID: nYSBgkrBPTqMxtrpunNq5Q_1772180631
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4806cfffca6so17779105e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 00:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772180631; x=1772785431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gLgmgrNhGxDNfWixSDZTdsPZO4KQ9usFY6SiGOqZX+c=;
 b=N4XfZ8Cma4f+ZKtuMqPcsiDwgR/kOl/AZVaW3+GLZKv06hoKa+HKMDcX/hplnK5v9T
 vY6UiL6OTg7c/g8hG8nCr95KqGdI7uaWvz4fNfLghiZ9MqSf9/TzFoVkvWMeqzXvqwnO
 gLiXYbx73Hhx0zPBqxUC4KDwKqXEtV6gqHHz9sKcxHLqRM2X310OSrp6h+MR6r4JoQrW
 Qn/r7UXQSA97NMTQJkDi5Nnzyv32o52lundi0Ru16cUFMY21vvJnzRfZO7iVxOQ/N0VF
 Qc+cyazQeSnJcdUcJ8/HO+71a7136r7lg0FlBYlGBlO0xTj8Knn6cV9psvg4CQAEoQJ9
 GlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772180631; x=1772785431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gLgmgrNhGxDNfWixSDZTdsPZO4KQ9usFY6SiGOqZX+c=;
 b=Qc57OdZ/Jm5gZbxLzDAWH0xnbDoh5/duGxG0Ni7S1P2XaOfK7GPwKZ5Ah/aSzyqdc0
 uF3EHLzNAwyD+e4IpUK55a3qp7kFvaBqtOWN7oF2A9NWNKubBN5vI+jbUwSE+y+yEOWh
 Ig0FoFjuDUljOx5HLNP/p66xCSAjoH2TpmMu97hIVwPln118+3SCJ1cSYaqgdlit5P/C
 Es3Yu0I1ZMriLJBN8vbP8VIuRJMmcKs5HWqDvaQvxzINzFHDzVo30RkndRLtthL/Ha9q
 pTNkbAG4HACbMdRsbEwy7vYWqR2Crf4aIIV5sBwH2/Lnx/Ngvtcxa1dlnj5RiEH49Cjf
 9CfA==
X-Gm-Message-State: AOJu0YzisfzNeMvQvKzvyN8/zTZcbPnGb3VYQi7yQ+sm2aefHOGiLD6B
 wBeRsi9qGDofg7qwbr7WeWpHgWb/Cx2/juOshO1LIrUw0euLUeRcad+bFZiRMF/sRuuWKEhO1G7
 Y0/q7ixdA3vNz5X/4FiOXi2PxzDgcdNi/2ZwDETpyRH1ZPUtmHy3zeNtk
X-Gm-Gg: ATEYQzysUgaHqN1Uar+RYL5qPWENDao4h8hIefcSMqXvzEhlazw2+hcY8FPVOdcWo2s
 pPUp89yDTjn3SYFfW5kLiMC0PfSIib9s93RYfZoCngsFFvyuQ+h1cLTceo1WBf5AveK96KglgZU
 6KMNfIwSVuXfYJcb7OsvCWZMMQf5SAiqC9se1xcckfowTYO5uNM64fVJiOE1oKCWrtqSRZMkpgk
 lMTBFV29iYNOnLJ0/K83gN8eb+fsTH/2cc7oy1Zo41k9aKR9q7fax0efAOne3uvZhku9tRVTWOp
 XLxt3m0R+xtQK98Cp3SMPRRG1AvRcqLrdjJUcX/EzQ2pSLGkOHld6yRxEXlcFdWUk92QjtfAsqT
 9+f7htQ==
X-Received: by 2002:a05:600c:3e86:b0:483:47ae:7c00 with SMTP id
 5b1f17b1804b1-483c9c02502mr20802735e9.20.1772180630997; 
 Fri, 27 Feb 2026 00:23:50 -0800 (PST)
X-Received: by 2002:a05:600c:3e86:b0:483:47ae:7c00 with SMTP id
 5b1f17b1804b1-483c9c02502mr20802395e9.20.1772180630570; 
 Fri, 27 Feb 2026 00:23:50 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfabb84esm174506425e9.0.2026.02.27.00.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 00:23:50 -0800 (PST)
Date: Fri, 27 Feb 2026 09:23:47 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com
Subject: Re: [PATCH 02/11] machine: add "acpi-watchdog" property
Message-ID: <20260227092347.157da3c6@imammedo>
In-Reply-To: <de38bb8a-91d5-4088-83bf-0730d3aa3d56@linaro.org>
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <20260206131438.1857182-3-imammedo@redhat.com>
 <de38bb8a-91d5-4088-83bf-0730d3aa3d56@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, 26 Feb 2026 18:08:09 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> Hi Igor,
>=20
> On 6/2/26 14:14, Igor Mammedov wrote:
> > It will be used by following code to enable ACPI watchdog.
> > Initial support will bring it to Q35 and arm/virt machines using
> > respective iTCO and GWDT watchdogs as hardware backend.
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >   include/hw/core/boards.h |  1 +
> >   hw/core/machine.c        | 20 ++++++++++++++++++++
> >   2 files changed, 21 insertions(+) =20
>=20
>=20
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 6411e68856..4ca808fb73 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -499,6 +499,20 @@ static void machine_set_usb(Object *obj, bool valu=
e, Error **errp)
> >       ms->usb_disabled =3D !value;
> >   }
> >  =20
> > +static bool machine_get_acpi_watchdog(Object *obj, Error **errp)
> > +{
> > +    MachineState *ms =3D MACHINE(obj);
> > +
> > +    return ms->acpi_watchdog;
> > +}
> > +
> > +static void machine_set_acpi_watchdog(Object *obj, bool value, Error *=
*errp)
> > +{
> > +    MachineState *ms =3D MACHINE(obj);
> > +
> > +    ms->acpi_watchdog =3D value;
> > +}
> > +
> >   static bool machine_get_graphics(Object *obj, Error **errp)
> >   {
> >       MachineState *ms =3D MACHINE(obj);
> > @@ -1257,6 +1271,12 @@ static void machine_class_init(ObjectClass *oc, =
const void *data)
> >           NULL, NULL);
> >       object_class_property_set_description(oc, "memory",
> >           "Memory size configuration");
> > +
> > +    object_class_property_add_bool(oc, "acpi-watchdog",
> > +        machine_get_acpi_watchdog, machine_set_acpi_watchdog);
> > +     object_class_property_set_description(oc, "acpi-watchdog",
> > +        "Set on/off to enable/disable ACPI watchdog."
> > +        " Default: off (ACPI watchdog is disabled)."); =20
>=20
> Should we check for CONFIG_ACPI somewhere?

I do check it when I build wdat specific files.
Anyways, this part has been reworked see my reply in
8/11 thread with new more generic 'watchdog' option.

>=20
> >   } =20
>=20


