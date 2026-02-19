Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B47E9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt5Rq-0002uP-5N; Thu, 19 Feb 2026 09:56:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vt5Rc-0002se-2y
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:55:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vt5RS-0003rf-D0
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771512944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XDvmPhCkW/Iu1cLbbFF/unJjlmqlmVOAcHnXJZTq6UM=;
 b=J2bCVTTq12MBSWn33IeovFkqAYta/Ju9XUzawJUNAJJEvUIRc029/BmrnxwyYh8vZiPC8B
 3tJuNZkn1riUJvdsoKXyVy6SBMB8BmkUJxYE3qx8Tpavc5Iz/N+vR8vE+M0nGJaF7SPKz6
 jiDWLKlgyeh2+FnHKw8Ew42JJ4FV/rY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-6kiMP-iCPQWCF0_Qfby0ZA-1; Thu, 19 Feb 2026 09:55:43 -0500
X-MC-Unique: 6kiMP-iCPQWCF0_Qfby0ZA-1
X-Mimecast-MFC-AGG-ID: 6kiMP-iCPQWCF0_Qfby0ZA_1771512942
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43623192c6aso990059f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 06:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771512942; x=1772117742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XDvmPhCkW/Iu1cLbbFF/unJjlmqlmVOAcHnXJZTq6UM=;
 b=tY684YvXAnoMzHo+pNVhsBhKc4VfV6iirUujE+eIc60kjiP9eHWtfp/7jAZROpU8xx
 P2uF4w3OJT/Dl+7KPmJvpNSQrIHK53lsT+R1BgEvCflTA0xJNBTniq9zvy1w2V/C2mZj
 vaq41VIMHzxLDiEiZkV0ad5bLe7rJu2mQ4QH5q3LI8xRUdQhvw3hecSth8R77vscIwpD
 +PsWydoL9dmALU+bs3pIGjz3Kr6zAYB3qPtPQKoGVjkNL5x6GWFLDmmFXSEgcGsYaWMR
 ituow4/zdvXkOuOEhA6GktGDbUeTK3CRVSgY3gzg0iyebpm/bU0LzNodRvJMVAyHVPo8
 Z6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771512942; x=1772117742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XDvmPhCkW/Iu1cLbbFF/unJjlmqlmVOAcHnXJZTq6UM=;
 b=vjRCguP0KN/HD3YWrH4AYOOnCPPVCOCImUHegXygP67yj1AQT/Y8HlVS4+PlnyfHOF
 W8oBkFsMORlphqtUVJ8vM+s2nHjI+g8QgnYTc7CTQrBPQH5JtcLo7QAU/r/dLpVo6cZp
 TrE9C8d+lXoFRFkKu5gYRNbo8r9kURNV5UDy0FuwPqHM4aUx9a9M0PT7GayN7usfmZww
 +JdIdzYb6B+bHfNyRlHJX70ksle6e4KQ+bu8BkfnUgZG6Oi82VUI56GVXr5ufx1nwYDr
 hJ9hg2YAwrg7SebWE1oFCDgo5ONEo2c3LyQQ6MdTgoYQVAS023AywmSO0Vc1MYTeejrP
 5zSg==
X-Gm-Message-State: AOJu0YweD1/Xt6xj0qeWQDNiSAd89RGz5TdIH1kZyZZaaerMER1wgcMv
 eYhvISQXutFcN72710Efik1HZJtl8mm0vvOGsmgjqBNj4fQdelAxi6CJ8I3Y7cAYkr1gUJ9wEcO
 Te7H7jkg+wq9rsM3y9nGV/RTYVvbQRA2WgOSrQGe4m6cJtd4E8gq+YZOw
X-Gm-Gg: AZuq6aK7ZQKaRKQ5CjXu6sgPQtSeClvD5yAdrXZHP/sgLTZFOssuORE8TviGW2HDeos
 hvQKE2JzmlaA7CP7B7qAvMvKXqyJDV/xsxvbSUgxHQl6kfOduC7a1C2HbZxzHjnbtpOETcnaXuR
 bFRfbYFuWFFzGicbLoCozXiECHMJ9E5rZuLG86WcxhjrF49XinoGGL6MT/PffbVYUMTlC7+EXZw
 NfCGFoNbpFoyUUWlR2UrQMmcvyc3ruXcUwUhh4t8h42GjgHL98TfDH25MWr7KeOdEfg//vYtsD0
 4J4b7y9uSRNTZxJ0pcmgR6NM/xrhEfcqqfyRgkjUIdZIF5oesx6xBA7rHaVQ14PVDTKJSPSGIyi
 hTh7dHw==
X-Received: by 2002:a05:6000:2911:b0:437:71b2:6f34 with SMTP id
 ffacd0b85a97d-43958df112cmr9002358f8f.1.1771512941858; 
 Thu, 19 Feb 2026 06:55:41 -0800 (PST)
X-Received: by 2002:a05:6000:2911:b0:437:71b2:6f34 with SMTP id
 ffacd0b85a97d-43958df112cmr9002312f8f.1.1771512941224; 
 Thu, 19 Feb 2026 06:55:41 -0800 (PST)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac7d91sm51532468f8f.26.2026.02.19.06.55.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 06:55:40 -0800 (PST)
Date: Thu, 19 Feb 2026 15:55:38 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH 08/11] arm: virt: create GWDT watchdog paired with WDAT
 ACPI table
Message-ID: <20260219155538.6e0b5a4f@imammedo>
In-Reply-To: <CAFEAcA-qaSRM9MJDk2nhDQKWoP7odcou2DXff-fuYPNEE=g6vg@mail.gmail.com>
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <20260206131438.1857182-9-imammedo@redhat.com>
 <CAFEAcA_QO_Pm5qKy2xOer+VmyMZ6KZ1KdUpf_ETV9fQu4YmaHg@mail.gmail.com>
 <20260219131751.4e4e4e0e@imammedo>
 <CAFEAcA-qaSRM9MJDk2nhDQKWoP7odcou2DXff-fuYPNEE=g6vg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 19 Feb 2026 13:00:13 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Thu, 19 Feb 2026 at 12:17, Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > On Wed, 18 Feb 2026 19:08:36 +0000
> > Peter Maydell <peter.maydell@linaro.org> wrote: =20
>=20
> > > Please can you also add support for exposing this device
> > > in the device tree ? =20
> >
> > It's possible,
> > but we probably should not enable it if acpi variant was requested,
> > to avoid confusion on guest side. =20
>=20
> Why? Almost every other device on this board we advertise
> via DTB for device tree guests and via ACPI for ACPI guests.
If we expose both guest may try to load both drivers causing conflict or mi=
sbehavior.
(
that's what x86 solved by quirk on guest side preferring WDAT watchdog
instead of native one.
)
I can try and see what arm kernel would do in presence if both
but that's not the point.
(my guess is that only 1st loaded driver would succeed, the rest
would fail on claimed resources)

One should consider plain GWDT whatchdog as a different device
when compared to WDAT one.
The later one is basically an synthetic watchdog with it's own driver.
=46rom guest pov they are different devices (using the same registers/irqs).

exposing only one watchdog in fw (DT or ACPI), lets user pick a preferred o=
ne
without need to hack guest kernel with a quirk.

> (The exceptions are things like the CXL handling that really
> only has an ACPI representation and can't be described in the DTB.)=20
> > For Windows it doesn't really mater, for linux it does.
> > on x86 linux guest uses a quirk to disable native iTCO watchdog
> > in favor of WDAT one if later is present.
> > I assume quirk is not desirable so we should expose only a preferred
> > variant. =20
>=20
> For this Arm board there is no watchdog except the one you're
> adding in this patch, though.
>=20
> > > Can we have a command line option name that isn't ACPI
> > > specific, please? There's nothing inherent to ACPI about
> > > "I would like a watchdog device". =20
> >
> > that is specifically asking for ACPI flavor being used/configured.
> > acpi specific option conflates 2 things:
> >    1. watchdog device creation (of the board choice) with properties tu=
ned for WDAT usage
> >    2. how to expose it on firmware level (in this case ACPI WDAT table)=
 =20
>=20
> Right, and I think that's the wrong way to approach this,
> at least for the virt board. We should either always create
> or allow the user to ask us to create a watchdog device.
> And then we should do what we do for all the other devices,
> which is expose it via both the mechanisms that we have
> for telling the guest about hardware (ACPI and DTB).

Looks like I wasn't clear, WDAT is not a description
of the hardware watchdog. It's a 'abstract watchdog device',
that uses a set IO/MMIO operations from WDAT table to manage
whatever hardware watchdog board provides. Guest uses WDAT
specific driver to manage it.

Windows and Linux[1] use it without need for hardware specific driver.
All hardware specific details are encoded in WDAT table provided by board.

q35 would provide its own WDAT for underling TCO watchdog
while virt-arm would provide GWDT specific WDAT.

=46rom guest pov it's the same WDAT watchdog, and guest doesn't
need any other watchdog drivers beside WDAT one.


machine.watchdog =3D (on|off) will handle/expose native watchdog whatever i=
t is.
but with this user won't be able to pick wdat/acpi watchdog.

would following enum be acceptable?

machine.watchdog {
  "on" or "native",=20
  "off",
  "acpi" or "wdat"
}

1) https://lkml.iu.edu/hypermail/linux/kernel/1609.1/04003.html

>=20
> thanks
> -- PMM
>=20


