Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C605DE7716F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 22:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIxyA-00061k-7J; Wed, 04 Dec 2024 17:35:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tIxy8-00061N-Ec
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 17:35:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tIxy6-00080p-JD
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 17:35:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733351733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0BKNVDowgX4Vx7wekRlE0HaYSsFZsoS2OxJJcq8l8h4=;
 b=WQFCw5cQ4VUM4pwx0qME8aen1nmOItf9DVwt22Bz/IEjNasfHC5XC8J9mqXncoXLwQ38Qe
 SIRW0dZtIUA8457VeFfWg2tWcIHlcbf5j2mxRcERFAKseBjj8ii24BzPUdhwxGL4C8EK9E
 ItyU7w7HvZG/+dAbpRcvTokRDNgaCt4=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-56fFF9aiMMq1b_H-4HE-eA-1; Wed, 04 Dec 2024 17:35:32 -0500
X-MC-Unique: 56fFF9aiMMq1b_H-4HE-eA-1
X-Mimecast-MFC-AGG-ID: 56fFF9aiMMq1b_H-4HE-eA
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-843df8d3714so3758139f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 14:35:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733351732; x=1733956532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0BKNVDowgX4Vx7wekRlE0HaYSsFZsoS2OxJJcq8l8h4=;
 b=WmG+DR9eJ7io4W+6VcQveh4734EmygcGflLnmzuAybwzSBzpgYZTxCFm/fVUsAQWgo
 ZXuj3HV4MlOb2l201dQBsVj7Xs8ufX9SGSIpdU1yYlc65/zM9IsYmROuO0OtkYCvG4oh
 4GyLt3/Rp7J0krvXwHr+IyU6hjjMs9DFe0+yq5pbM8kC/gJoxBNA0CHzWsvdPg3+w/7x
 QVY6nrnkrEdRIgG9Gf6P0y1/419bMD1AkB3SU7HfXI54iIlHqfRziYED4veBg24yXdEE
 /qYcXXYFU7GIqWrEO9UzFSqQrI9lFbhM47nZOaIncK5gNVJn1f4noPOxbaI/CHNPojmR
 MuMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4zHd9BFuIE8CGomnlNVqIxKXkJpxkTgHH+XCnL6jY8ls+5318zVCi3r2xPsiFz1E/l/+X+c7ZrVM7@nongnu.org
X-Gm-Message-State: AOJu0YyG36YP5wrG0G7MishI52XUd3tzdofYC5utUMIwWhJwqoLtbkMh
 OzccGG8vCkYVmsWfe0LlP08b/ao7cK8fzzRe/WZVithWHqTqxuCZtyAvZhSYIUcbRkYAL4n6daC
 SaGGxMUclH8/a6+qNsegQDirx+POLG+9MS3NLYg9kLVz7J1YX19Ai
X-Gm-Gg: ASbGncuH4vNzk53p2ZYnKf1ji21zHqGMhx/EX9kiaU1qPTW4OlxU+EKix7Q+Gguu8cr
 /D2CrmFfj1bt1jqpXvZe3APxLvAXBOWcQGI+kMcha25TElIItloTAilWqrQzyKgZb112EnzHbWF
 n5EzUM27XW1WuuSzURL8x613bjHeFMiyQGMMvZoX7YWyRcan9cANCARFVwaZUQiwu+gzmjZIlnh
 AtZaf1meBNvSIWCRzHRs6A7XxG+BBeAWBM0GVOPdOlQvPfKQfoxdg==
X-Received: by 2002:a05:6602:14ce:b0:82a:a4f0:f271 with SMTP id
 ca18e2360f4ac-8445b7defabmr283822739f.4.1733351731693; 
 Wed, 04 Dec 2024 14:35:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7tNjobQY/+Sy5SSPeukaF5Nxr76hQo8HeWBnqfutTCbjizWMwF40eoIdZYYz00makoTP+PA==
X-Received: by 2002:a05:6602:14ce:b0:82a:a4f0:f271 with SMTP id
 ca18e2360f4ac-8445b7defabmr283821539f.4.1733351731374; 
 Wed, 04 Dec 2024 14:35:31 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e28611c25asm26624173.46.2024.12.04.14.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 14:35:30 -0800 (PST)
Date: Wed, 4 Dec 2024 15:35:28 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Corvin =?UTF-8?B?S8O2aG5l?= <C.Koehne@beckhoff.com>
Cc: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "clg@redhat.com" <clg@redhat.com>
Subject: Re: [PATCH v2 9/9] vfio/igd: add x-igd-gms option back to set DSM
 region size for guest
Message-ID: <20241204153528.5059341e.alex.williamson@redhat.com>
In-Reply-To: <fb3afcb5ea495e96c6aa9e657cb413ab47c15026.camel@beckhoff.com>
References: <20241203133548.38252-1-tomitamoeko@gmail.com>
 <20241203133548.38252-10-tomitamoeko@gmail.com>
 <fb3afcb5ea495e96c6aa9e657cb413ab47c15026.camel@beckhoff.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Tue, 3 Dec 2024 16:30:56 +0000
Corvin K=C3=B6hne <C.Koehne@beckhoff.com> wrote:

> On Tue, 2024-12-03 at 21:35 +0800, Tomita Moeko wrote:
> > =EF=BB=BFCAUTION: External Email!!
> > DSM region is likely to store framebuffer in Windows, a small DSM
> > region may cause display issues (e.g. half of the screen is black).
> > By default, QEMU uses host's original value, which is determined by
> > DVMT Pre-Allocated option in Intel FSP of host bios. Some vendors
> > do not expose this config item to users. In such cases, x-igd-gms
> > option can be used to manually set the data stolen memory size for
> > guest.
> >=20
> > When DVMT Pre-Allocated option is available in host BIOS, user should
> > set DSM region size there instead of using x-igd-gms option.
> >  =20
>=20
> It might be worth linking the commit which has removed x-igd-gms and ment=
ion
> that the behaviour changed slightly. Previously, the DSM region size was =
set to
> 0 if x-igd-gms was unset. This patch keeps the host value if x-igd-gms is=
 unset.

Yes, this is really quite confusing.  We never actually removed the
x-igd-gms option as $Subject implies, we only gutted it from doing
anything, *sigh*.  Let's please summarize how 971ca22f041b left the
option but removed any implementation behind that option and this
brings it back to provide some function.

> > Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> > ---
> > =C2=A0hw/vfio/igd.c | 17 +++++++++++++++++
> > =C2=A01 file changed, 17 insertions(+)
> >=20
> > diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> > index e464cd6949..0814730f40 100644
> > --- a/hw/vfio/igd.c
> > +++ b/hw/vfio/igd.c
> > @@ -717,6 +717,23 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev=
, int
> > nr)
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0 QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quir=
k, next);
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * Allow user to override dsm size using x-igd=
-gms option, in multiples
> > of
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * 32MiB. This option should only be used when=
 the desired size cannot be
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * set from DVMT Pre-Allocated option in host =
BIOS.
> > +=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0 if (vdev->igd_gms) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (gen < 8 && vdev->igd_gm=
s <=3D 0x10) { =20
>=20
> This doesn't work as intended for values larger than 0x10. For those valu=
es,
> qemu ignores the generation and set GMS as it would be a gen 8 or later d=
evice.
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gmc=
h &=3D ~(IGD_GMCH_GEN6_GMS_MASK << IGD_GMCH_GEN6_GMS_SHIFT);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gmc=
h |=3D vdev->igd_gms << IGD_GMCH_GEN6_GMS_SHIFT;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (vdev->igd_gms <=
=3D 0x40) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gmc=
h &=3D ~(IGD_GMCH_GEN8_GMS_MASK << IGD_GMCH_GEN8_GMS_SHIFT);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gmc=
h |=3D vdev->igd_gms << IGD_GMCH_GEN8_GMS_SHIFT;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err=
or_report("Unsupported IGD GMS value 0x%x", vdev->igd_gms);

We clearly know the upper limit of valid values for the device
generation, can we include that in the error report?  Thanks,

Alex

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0 ggms_size =3D igd_gtt_memory_size(gen, gmch);
> > =C2=A0=C2=A0=C2=A0=C2=A0 gms_size =3D igd_stolen_memory_size(gen, gmch);
> > =C2=A0 =20
>=20


