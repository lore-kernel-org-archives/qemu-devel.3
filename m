Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115BAE6F06A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 15:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6tHX-0002lz-L3; Fri, 01 Nov 2024 11:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t6tHW-0002ld-28
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 11:09:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t6tHS-00016n-HJ
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 11:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730473780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SG89O3ZcJkn/3n74/GcMsrPR+rAyb1vRFtP12ULI8+Q=;
 b=OoNm3oAZWnaV6FCK7XyoBgF3cnLMk0xoUCahW31QNZ/yPA80nxXy8L6XvcKLRCJWxUQrwa
 /IYUeIT9DZ6MAoM06iamlqbP2tOtI/CSju3xHFiXprleJvhD5Wfll5X1FnVdXTMru4UhvB
 z0eygdjbeW0rx/6qrMxh6n0rwnRZR5k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-sbJ_R6mMNz6zV5TQQ0y77g-1; Fri, 01 Nov 2024 11:09:38 -0400
X-MC-Unique: sbJ_R6mMNz6zV5TQQ0y77g-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315cefda02so14949265e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 08:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730473777; x=1731078577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SG89O3ZcJkn/3n74/GcMsrPR+rAyb1vRFtP12ULI8+Q=;
 b=rRgby/7Dk9M1hHUgwkTKKvMi7nSKektx0MSyqkYc7eau7FoCaEf1j+xGf4AvvxKmvY
 d5ZeiHr9szQ66QkmfpvpCeC3mQ0vHxnhwUORh5DGXna4d/zO0ES8mN8vIo5KTTKG8090
 EC2mEV9CbLfmqfBUBYk1PblrnMmfZpJ0XDQ5H3rlU/ztcjBK5bnWrdw2fbwwEgGcY9Yo
 b3/A8wsjYYE1V1PHm81FRv9bdrE8pa1JFt5ke+TlADS9rfxYeGi5tUNv24KI2OwI8Df9
 AP5FvNFXZ+6EPnCX35LlT2l92f9IKAv9FS+/cZFLHHlaAf4lblz7FzUiOsqlasVfjqfI
 lcGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVswzvIjxrgFtWE8txWBbJ7V6wp24esk9uPtOcZMB5ys2DH07byih0zMyRGSzxaS+OmBq+Xvg0SYWF0@nongnu.org
X-Gm-Message-State: AOJu0YzlPN5dh5/SKotKdl2A7S2DZ5OXG6pe2YNxNnSFsIbtiaBEetjm
 eyNeRyoUp8U9XUdLDq2c9k4P7RnqFc0NxsF8QYals2HzzfFoZlAHFFydIt+5NnJoSjDYJW1PN3A
 KpR8Cte+B3QrZ8bALAJHNCiSlqbjk6MW1My+Of7SQzp0Dsn3Htmtb
X-Received: by 2002:a05:600c:35d0:b0:431:58cd:b259 with SMTP id
 5b1f17b1804b1-4327b8214aemr70904465e9.31.1730473777052; 
 Fri, 01 Nov 2024 08:09:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF20hvGj0ogheTGX94mEBp9ZmTJzg6v/pyz4EFFfVxalM7jFEOkqbyxo5JXhZWA1K6wNJ4qYA==
X-Received: by 2002:a05:600c:35d0:b0:431:58cd:b259 with SMTP id
 5b1f17b1804b1-4327b8214aemr70904155e9.31.1730473776362; 
 Fri, 01 Nov 2024 08:09:36 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7d2bsm5437969f8f.16.2024.11.01.08.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 08:09:35 -0700 (PDT)
Date: Fri, 1 Nov 2024 16:09:34 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Anthony Harivel" <aharivel@redhat.com>
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 <pbonzini@redhat.com>, <mtosatti@redhat.com>, <qemu-devel@nongnu.org>,
 <vchundur@redhat.com>, <rjarry@redhat.com>, nathans@redhat.com,
 kenj@kenj.id.au, chorn@fluxcoil.net, sunyanan.choochotkaew1@ibm.com,
 vibhu.sharma2929@gmail.com
Subject: Re: [PATCH v6 0/3] Add support for the RAPL MSRs series
Message-ID: <20241101160934.42d46c9f@imammedo.users.ipa.redhat.com>
In-Reply-To: <D52ED9BSZU9P.32LYD3328YTTN@redhat.com>
References: <20240522153453.1230389-1-aharivel@redhat.com>
 <20241016135259.49021bca@imammedo.users.ipa.redhat.com>
 <D4X8WRR5F2GP.2MCBI9HDM3UHM@redhat.com>
 <20241018142526.34a2de0a@imammedo.users.ipa.redhat.com>
 <ZxJbtkMO1QcoiqVn@redhat.com>
 <20241022144615.203cf0da@imammedo.users.ipa.redhat.com>
 <ZxelgDeuZaia-Vqf@redhat.com>
 <D52ED9BSZU9P.32LYD3328YTTN@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Tue, 22 Oct 2024 16:16:36 +0200
"Anthony Harivel" <aharivel@redhat.com> wrote:

> Daniel P. Berrang=C3=A9, Oct 22, 2024 at 15:15:
> > On Tue, Oct 22, 2024 at 02:46:15PM +0200, Igor Mammedov wrote: =20
> >> On Fri, 18 Oct 2024 13:59:34 +0100
> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> >>  =20
> >> > On Fri, Oct 18, 2024 at 02:25:26PM +0200, Igor Mammedov wrote: =20
> >> > > On Wed, 16 Oct 2024 14:56:39 +0200
> >> > > "Anthony Harivel" <aharivel@redhat.com> wrote: =20
> >> [...]
> >>  =20
> >> > >=20
> >> > > This also leads to a question, if we should account for
> >> > > not VCPU threads at all. Looking at real hardware, those
> >> > > MSRs return power usage of CPUs only, and they do not
> >> > > return consumption from auxiliary system components
> >> > > (io/memory/...). One can consider non VCPU threads in QEMU
> >> > > as auxiliary components, so we probably should not to
> >> > > account for them at all when modeling the same hw feature.
> >> > > (aka be consistent with what real hw does).   =20
> >> >=20
> >> > I understand your POV, but I think that would be a mistake,
> >> > and would undermine the usefulness of the feature.
> >> >=20
> >> > The deployment model has a cluster of hosts and guests, all
> >> > belonging to the same user. The user goal is to measure host
> >> > power consumption imposed by the guest, and dynamically adjust
> >> > guest workloads in order to minimize power consumption of the
> >> > host. =20
> >>=20
> >> For cloud use-case, host side is likely in a better position
> >> to accomplish the task of saving power by migrating VM to
> >> another socket/host to compact idle load. (I've found at least 1
> >> kubernetis tool[1], which does energy monitoring). Perhaps there
> >> are schedulers out there that do that using its data. =20
>=20
> I also work for Kepler project. I use it to monitor my VM has a black=20
> box and I used it inside my VM with this feature enable. Thanks to that=20
> I can optimize the workloads (dpdk application,database,..) inside my VM.=
=20
>=20
> This is the use-case in NFV deployment and I'm pretty sure this could be=
=20
> the use-case of many others.
>=20
> >
> > The host admin can merely shuffle workloads around, hoping that
> > a different packing of workloads onto machines, will reduce power
> > in some aount. You might win a few %, or low 10s of % with this
> > if you're good at it.
> >
> > The guest admin can change the way their workload operates to
> > reduce its inherant power consumption baseline. You could easily
> > come across ways to win high 10s of % with this. That's why it
> > is interesting to expose power consumption info to the guest
> > admin.
> >
> > IOW, neither makes the other obsolete, both approaches are
> > desirable.
> > =20
> >> > The guest workloads can impose non-negligble power consumption
> >> > loads on non-vCPU threads in QEMU. Without that accounted for,
> >> > any adjustments will be working from (sometimes very) inaccurate
> >> > data. =20
> >>=20
> >> Perhaps adding one or several energy sensors (ex: some i2c ones),
> >> would let us provide auxiliary threads consumption to guest, and
> >> even make it more granular if necessary (incl. vhost user/out of
> >> process device models or pass-through devices if they have PMU).
> >> It would be better than further muddling vCPUs consumption
> >> estimates with something that doesn't belong there. =20
>=20
> I'm confused about your statement. Like every software power metering=20
> tools out is using RAPL (Kepler, Scaphandre, PowerMon, etc) and custom=20
> sensors would be better than a what everyone is using ?

RAPL is used to measure CPU/DRAM/maybe GPU domains.
see my other reply to Daniel RAPL + aux
 (https://www.mail-archive.com/qemu-devel@nongnu.org/msg1072593.html)
My point wrt RAPL is: CPU domain on host and inside guest
should be doing the same thing, i.e. report only package/core
consumption of virtual CPU and nothing else (non vCPU induced load
should not be included in CPU domain).

For non vCPU consumption, we should do the same as bare-metal,
i.e. add power sensors where necessary. As minimum we can add
a system power meter sensor, which could account for total
energy draw (and that can include not only QEMU aux threads,
but also for other related processes (aka process handling dpdk NIC,
or other vhost user backend)).
Individual per device sensors also a possibility in the future
(i.e per NIC) is we can find a suitable sensor on host to derive
guest value.

[...]

> Adding RAPL inside VM makes total sens because you can use tools that=20
> are already out in the market.
no disagreement here.

Given the topic is relatively new, the tooling mostly concentrates on
RAPL as most available sensor. But some tools can pull energy values
from other sources, we surely can teach them to pull values from
a sensor(s) we'd want to add to QEMU (i.e. for an easy start borrow
sensor handling from lm_sensors). I'd pick acpi power meter as
a possible candidate for it is being guest OS agnostic and
we can attach it to anything in machine tree.

> > There's a tradeoff here in that info directly associated with
> > backends threads, is effectively exposing private QEMU impl
> > details as public ABI. IOW, we don't want too fine granularity
> > here, we need it abstracted sufficiently, that different
> > backend choices for a given don't change what sensors are
> > exposed.
> >
> > I also wonder how existing power monitoring applications
> > would consume such custom sensors - is there sufficient
> > standardization in this are that we're not inventing
> > something totally QEMU specific ?
> > =20
> >> > IOW, I think it is right to include non-vCPU threads usage in
> >> > the reported info, as it is still fundamentally part of the
> >> > load that the guest imposes on host pCPUs it is permitted to
> >> > run on. =20
> >>=20
> >>=20
> >> From what I've read, process energy usage done via RAPL is not
> >> exactly accurate. But there are monitoring tools out there that
> >> use RAPL and other sources to make energy consumption monitoring
> >> more reliable.
> >>=20
> >> Reinventing that wheel and pulling all of the nuances of process
> >> power monitoring inside of QEMU process, needlessly complicates it.
> >> Maybe we should reuse one of existing tools and channel its data
> >> through appropriate QEMU channels (RAPL/emulated PMU counters/...). =20
> >
> > Note, this feature is already released in QEMU 9.1.0.
> > =20
> >> Implementing RAPL in pure form though looks fine to me,
> >> so the same tools could use it the same way as on the host
> >> if needed without VM specific quirks. =20
> >
> > IMHO the so called "pure" form is misleading to applications, unless
> > we first provided  some other pratical way to expose the data that
> > we would be throwing away from RAPL.
> > =20
>=20
> The other possibility that I've think of is using a 3rd party tool to=20
> give maybe more "accurate value" to QEMU.=20
> For example, Kepler could be used to give value for each thread=20
> of QEMU and so instead of calculating and using the qemu-vmsr-helper,=20
> each values is transfered on request by QEMU via the UNIX thread that is=
=20
> used today between the daemon and QEMU. It's just an idea that I have=20
> and I don't know if that is acceptable for each project (QEMU and=20
> Kepler) that would really solve few issues.

=46rom QEMU point of view, it would be fine to get values from external
process and just proxy them to guest (preferably without any massaging).

Also on QEMU side, I'd suggest to split current monolith functionality
in 2 parts: frontend (KVM MSR interface for starters) and backend object
(created with -object CLI option) that will handle communication
with an external daemon. That way QEMU would be able easily change/add
different frontend and backend options (ex: add frontend for RAPL
with TCG accel, add backend for Kelper or other project(s)
down the road). (it would be good to make this split even for
qemu-vmsr-helper). (if you are interested, I can guide you wrt
QEMU side of the question).

PS:
As for other projects we probably should ask if they are open to an idea.
They definitely would need some patches for per thread accounting,
and maybe for some API to talk with external users (but the later
might exist and it might be better for QEMU to adopt it (here QEMU
backend object might help as translator of existing protocol to
QEMU specific internals).
The point is QEMU won't have to reinvent wheel, and other projects
will get more exposure/user-base.

On top of the projects, you've already pointed out for possible
integration with. I could add pmdadenki (CCed few authors) which
some distros are shipping/using.

> > With regards,
> > Daniel
> > --=20
> > |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> > |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> > |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :| =20
>=20


