Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B098FD532D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 10:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvufW-0000cD-Qz; Fri, 27 Feb 2026 05:01:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vvufA-0000al-E9
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 05:01:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vvuf7-0003Qm-SA
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 05:01:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772186491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=61fyoBrkdil3bHeTyT+NFwBgyYTU5/Q4ejWUzRqwlIM=;
 b=H4KtspGVCZi4b5jlDDPS2wY4LetqRGtQzkLDT0edTPVvBoFExYPZLbNopwMpjq4nmsau3e
 FkUicckcVLLiHxesu44dDiWBr2VlSRbz2xA+VbuX6HjXJ14VwJwyjvBfKayH4OEuinEuo+
 wGtkTvqV/wdx/HiPFZkU0RCm9fIEOFE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-TStrzEfcPMiBG3KLqQlGlw-1; Fri, 27 Feb 2026 05:01:30 -0500
X-MC-Unique: TStrzEfcPMiBG3KLqQlGlw-1
X-Mimecast-MFC-AGG-ID: TStrzEfcPMiBG3KLqQlGlw_1772186488
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4836c819456so12705275e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 02:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772186488; x=1772791288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=61fyoBrkdil3bHeTyT+NFwBgyYTU5/Q4ejWUzRqwlIM=;
 b=PiHcmBVSmdm0MdXPGVnUtiYJspp2PFPr8vi/CwVmzT5kTYfsi7lziEQSS56Kiyu5Uq
 3DkmOird4WcZDr6CiSmLyIQUvVjWgqEomA6Tlbmb9AHJ77PbqIzCGDUJBNWaepMqNPwt
 JUxz3IGbgJNtyL5QRFTdW34WYqxyFEJuBPbc+nPHyfp2/FMW9gz03g+fPJu2uDYwF+s/
 WsRTPJUJ9cmU5z9YAehegDq/SOEnctvnqKLiTo/cuwvZwDkAy7VyxbCPL+JoZRKiHIAt
 uQavLJuYAhWvTv0NnXiijzr77w/e9fS2CxUbsXsPvAcLvJKKw/zzPLDlPLm2bPNXB816
 DjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772186488; x=1772791288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=61fyoBrkdil3bHeTyT+NFwBgyYTU5/Q4ejWUzRqwlIM=;
 b=u6Ag5j1miEAX92P5cy0cvRAmeMIKSE/qgUE8oDTIs7vXCuA3E7oVCyLELjupjzZtol
 EiMyfQfzghxCjeG/EtKdxY97kRm1Vd2dLrMq7mFtV/Z9ZDGh0UP2C+ZSwk0KffFASyVT
 qWM9uk5N57PZb3EjQVlomLqFAcg1TdDRddRz2vyIn8sF90nt2UCxywmlMSC3MFTwv2gf
 8OzqBTVzKeQuhYds6IVu65fLuEx9WskU8A1t2iajvFfdFNZg0vLlS5k6LNb9snKG6WJt
 WDszWBZQTPrhKDrnBhudfMalkbyuNKy1kCuXNdb9fdHQsbAnKDBAH9HnRnt1yv8Xeh8r
 H8yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG/VIgCMTCScAc89Mgn1VfYYvzK+ZqHJSsIRGwyejRRTOE/RBjNMOjPN1CV0FgthHBQBh4iPsj8JY9@nongnu.org
X-Gm-Message-State: AOJu0YywLNcy50POGaOovDalpYUt634MW40PSqN/EMYmYY4pcQM0wTak
 HgAYpQv1zWJMbONqjMVuenQHzNo+NdEONG9w9fKNot4W8ltPyd4vvqwz1MCY7OOq5fjOcl9nn7U
 aStWF+jdRVuIyODuaTxMgCzfMN+E0/qrLqyljM8/yjSWkLz6M1nABhLSJ
X-Gm-Gg: ATEYQzw6ZrFPZcTkaVqnQDSWCzppPxxng3jRtucpWlSxhLmjUw8ialyyIZbY9hUeUAZ
 rXHqBJJacxJN9VPjo4hapir8BovIZCpziKkteD72MrmRTpyZXh4CwDxhoUltZj72sAljwuka9w6
 ZJO0Q2UTSxefXnVY0Xdyfp6SkmPfQ2/I9MxuO6IaN/7pdcDYwLC1WFpQON96CefJtxnjWPYGVB+
 BWavSeOwDBEzPXnIs8/21FPEf33Bv1vT12WQdVziyKHUuyhhqCd7T940e3iBqXvGP+NLdX5u3GA
 vB0TTzGv6JI7PG9Gu6UDNysTYZsqFm3VODzKXYTAC+hctRtu7b1z1cKWDgiqxQ6Op7VfA0QBisv
 hTxLBDA==
X-Received: by 2002:a05:600c:3111:b0:483:78c5:d743 with SMTP id
 5b1f17b1804b1-483c9c2baa9mr28651205e9.28.1772186488134; 
 Fri, 27 Feb 2026 02:01:28 -0800 (PST)
X-Received: by 2002:a05:600c:3111:b0:483:78c5:d743 with SMTP id
 5b1f17b1804b1-483c9c2baa9mr28650515e9.28.1772186487587; 
 Fri, 27 Feb 2026 02:01:27 -0800 (PST)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfba9566sm87157325e9.3.2026.02.27.02.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 02:01:26 -0800 (PST)
Date: Fri, 27 Feb 2026 11:01:25 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-devel@nongnu.org, mst@redhat.com,
 anisinha@redhat.com, pbonzini@redhat.com, shannon.zhaosl@gmail.com,
 philmd@linaro.org, zhao1.liu@intel.com, rad@semihalf.com,
 leif.lindholm@oss.qualcomm.com
Subject: Re: [PATCH 08/11] arm: virt: create GWDT watchdog paired with WDAT
 ACPI table
Message-ID: <20260227110125.1d46e695@imammedo>
In-Reply-To: <aaFdZY5ESpQCJigY@redhat.com>
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <20260206131438.1857182-9-imammedo@redhat.com>
 <CAFEAcA_QO_Pm5qKy2xOer+VmyMZ6KZ1KdUpf_ETV9fQu4YmaHg@mail.gmail.com>
 <20260219131751.4e4e4e0e@imammedo> <aZ8THMubft44Q3E-@redhat.com>
 <20260226135648.4c1a4009@imammedo> <878qced4xx.fsf@pond.sub.org>
 <aaFdZY5ESpQCJigY@redhat.com>
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

On Fri, 27 Feb 2026 09:01:25 +0000
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Fri, Feb 27, 2026 at 08:24:42AM +0100, Markus Armbruster wrote:
> > Igor Mammedov <imammedo@redhat.com> writes:
> >  =20
> > > On Wed, 25 Feb 2026 15:19:56 +0000
> > > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote: =20
> > >>=20
> > >> Right, if there was a case where we were already using -device to
> > >> create the watchdog, then I would suggest having a simple
> > >> 'wadt=3Don|off' property as standard for any watchdog wanting that
> > >> ACPI abstraction wrapper.
> > >>=20
> > >> That could (hypothetically) be the case if we had chosen to add
> > >> WADT suport backed by i6300esb, eg -device i6300esb,wadt=3Don|off
> > >>=20
> > >> For cases built-in to the machine type, I'd suggest <type>-wadt=3Don=
|off
> > >>=20
> > >> eg for Q35,  "-machine q35,itco-wadt=3Don|off"
> > >>=20
> > >> for virt, '-machine virt,gwdt-wadt=3Don|off' =20
> > >
> > > CCin Markus since it touches QAPI stuff.
> > >
> > > For respin, I've went ahead with a bit more generic approach
> > > (as a user, I wouldn't really care what kind of built-in watchdog boa=
rd ships,
> > > and having 1 property instead total instead of machine specific ones =
makes it
> > > easier for mgmt layer to deal with).
> > >
> > > here is current idea:
> > >
> > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > index 6411e68856..a0c6719b58 100644
> > > --- a/hw/core/machine.c
> > > +++ b/hw/core/machine.c
> > > @@ -1257,6 +1271,14 @@ static void machine_class_init(ObjectClass *oc=
, const void *data)
> > >          NULL, NULL);
> > >      object_class_property_set_description(oc, "memory",
> > >          "Memory size configuration");
> > > +
> > > +    object_class_property_add_enum(oc, "watchdog", "WatchdogType",
> > > +        &WatchdogType_lookup,
> > > +        machine_get_watchdog, machine_set_watchdog);
> > > +     object_class_property_set_description(oc, "watchdog",
> > > +        "Use: auto (watchdog is configured according board defaults)=
,"
> > > +        " off (disabled), native (built-in watchdog), wdat (ACPI bas=
ed watchdog)]. "
> > > +        " Default: auto");
> > >  } =20
> >=20
> > Adds the property to abstract base type "machine", i.e. every machine
> > has it.
> >=20
> > Fundamentally assumes there is at most one onboard watchdog of interest.
> >=20
> > I'm lacking context, please bear with me: who or what is going to set
> > this property, and for what purpose?
> >  =20
> > > diff --git a/qapi/machine-common.json b/qapi/machine-common.json
> > > index 92e84dfb14..7f5e10340f 100644
> > > --- a/qapi/machine-common.json
> > > +++ b/qapi/machine-common.json
> > > @@ -9,6 +9,23 @@
> > >  # Common machine types
> > >  # ********************
> > >  ##
> > > +##
> > > +# @WatchdogType:
> > > +#
> > > +# On board watchdog configuration.
> > > +#
> > > +# @auto: Watchdog is configured according to board defaults. =20
> >=20
> > As far as I can tell, we don't document "boards" (machine types)
> > anywhere, let alone "board defaults".  Not this patch's fault, of
> > course.  The meaning of @auto remains unclear.
> >  =20
> > > +#
> > > +# @off: Watchdog disabled (ARM).
> > > +#
> > > +# @native: Native watchdog (arm/virt: sbsa-gwdt, x86/q53: TCO)
> > > +#
> > > +# @wdat: ACPI WDAT watchdog.
> > > +#
> > > +# Since: 10.2 =20
> >=20
> > 11.0
> >  =20
> > > +##
> > > +{ 'enum': 'WatchdogType',
> > > +  'data': [ 'auto', 'off', 'native', 'wdat' ] } =20
> >=20
> > What do managament applications need to know about onboard watchdog
> > configuration?
> >=20
> > Do they need to know what @auto means for the machine type at hand?
> >=20
> > Do they ever need to pick a value?  Do they need to know which values
> > work with the machine type then? =20
>=20
> Libvirt generally wants to work with & express the exact hardware
> and not rely on "auto" settings in QEMU.
>=20
> So in terms of the built-in watchdog for Q35 we currently express
> this explicitly via
>=20
>     <watchdog model=3D'itco' />

not specifying above libvirt doesn't make itco go away on qemu side,
it's still there regardless of above.
but that said, I can work with it and add
  q35.wdat -> itco.wdat alias to toggle it


> Adding "WADT" is not expressing a new piece of hardware, just a
> configuration choice of the iTCO hardware. So from that POV in
> libvirt I anticipate expressing it as
>=20
>     <watchdog model=3D'itco' wadt=3D'yes|no'/>
>
> IMHO, similar reasoning works at the QEMU level - WADT is not a
> new type of watchdog hardware, just a config choice supported
> with certain specific QEMU watchdogs. So I'd prefer something
> closer to what I suggested in the mail that Igor replies to,
> where we have a simple boolean flag to control use of WADT,
> and other distinct properties if we need other controls on the
> watchdog, instead of trying overload multiple distinct settings
> into one enum.
>=20
> For Arm we would similarly want to express the choice of
> hardware directly as
>=20
>    <watchdog model=3D'gwdt'/>
for gwdt it's more than just adding extra ACPI table,
with wdat knob, watchdog entry in GTDT table should be disabled
and gwdt itself should be wired to use different freq
(in the end it's different hw that happens to use the same registers/
protocol).

if we make it built-in, we would need in addition to virt.wadt alias
also have virt.watchdog=3D[on|off] to manage creation.=20

> regardless of whether the GWDT ends up being something we have to
> add manually with -device, or something built-in to the machine.

Peter,
is it possible/acceptable to add sbsa-gwdt to virt board with
-device. (technically I can use generic hotplug hooks[1] to wire
it up to the board)

1)
virt_machine_device_*plug_cb()
=20
> > >> Q35 is easier as we rely on the guest quirks to disable direct
> > >> access via both paths.
> > >>=20
> > >> With GWDT we need to decide if gwdt-wadt=3Don should imply DTB
> > >> disabled, or if we just expose both & rely on a guest quirk
> > >> or worst case, need a separate property to toggle DTB too.
> > >>  =20
> > >> > I've used device property for x86 Q35 TCO watchdog and
> > >> > then using -global to enable it as workaround in previous version.
> > >> > Ugly but doable workaround. It puts a burden on users to learn how
> > >> > to configure it for each support watchdog/board combo.
> > >> > It's nightmare to discover/maintain though. =20
> >=20
> > Our unsolved "how to configure onboard devices" problem bites again.
> >=20
> > -global can be pressed into service when there's just once instance of
> > the device type.  The drawbacks you describe are real.  I want to see
> > less of it, not more. =20
>=20
> IIRC, the only place we use -global with watchdogs today is to
> set "-global ICH9-LPC.noreboot=3Doff" which was merely to workaround
> a historical QEMU bug which exposed a guest watchdog and then
> inexplicably made it not work by having it ignore the guest
> trigger event. Newer machine types fixed that broken default, but
> libvirt keeps setting things explicitly since that's easier than
> making machine version specific choices.
>=20
> I'm not sure we need -global to support the WADT features, as that
> seems like it can just a -machine property instead.
>=20
> With regards,
> Daniel


