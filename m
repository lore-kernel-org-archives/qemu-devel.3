Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B88D2C55F
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 14:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Fgp-0004t8-8Q; Tue, 22 Oct 2024 10:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1t3Fgl-0004sT-HE
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:16:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1t3Fgh-00053S-Nv
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729606602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eUPqXBhtBxt0h0YDULs3P6w2Zw2BcSwnautScDhquNk=;
 b=av4eL6WBDOVN+yFqZKCAzxngXc7Ugv61IVmFbZi3j8d+ZSptaL2GCBW4zzwSYtxbpgnmTY
 2JcPHK7EzYQSjId6ssm/RKuLJ4GG68QDCPcfpvq+FiYewApyIPkDfLM2GrjDK7d0T3bAsQ
 QvwgiR/eIn9psLYpRZTNFgveZWTGKSs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-Ksh86lR1No-h_9xYqt1ccA-1; Tue, 22 Oct 2024 10:16:40 -0400
X-MC-Unique: Ksh86lR1No-h_9xYqt1ccA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d95264eb4so2858290f8f.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 07:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729606599; x=1730211399;
 h=in-reply-to:references:user-agent:to:from:subject:cc:message-id
 :date:content-transfer-encoding:mime-version:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eUPqXBhtBxt0h0YDULs3P6w2Zw2BcSwnautScDhquNk=;
 b=mFLIIKDk2WJLXwg6E6VGw/6byW952T4soFLNHIvX/ZrKhrAGgBKNX9hZE3dYa5k8jI
 m+KyCBWNUxri8uuRivOdmc7sTT1vvzrQBIPrgJczSZKfu5XVX8GPvADCmPDppi2Neibc
 FsHP3nb98GO2mFjjGOH6HOzyOhiDijrvS5/oxO4SGoRiq5ShhudlhzjZ51nJdE48N37b
 3Q1vClqv9EgLO1RUvKjXqEXjJJIHEF693vZZTrnfrCiDF6JjoEqqxEB6luMYTkKE0405
 FfkPPB+glxziyUuTuauCh2sn+Xct6igPu2daNZmsuVDdkz0TyvrBFonHwkNiejpCsNz4
 TKjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNPOxtZmw8zmvXe6u42KOh5NbvgjeW/jMKFhNwXDTifh7NWBrS+D5vY2JvErHy9pBoaaKCs17yEakQ@nongnu.org
X-Gm-Message-State: AOJu0Yy7Ey0Ngxl0qXnaQ3DKyKdzZ8CUFUsqtBmCiMRLwBxyXUGAhzsP
 Ocoh38yBJJuErpmGS5yesJR8zjtUNIoYZoHLUb/W6QeLwBn5jWVxBQ/tjcUFqbPsPKWTRar5FYS
 +cCovbMgN9GvhpH2kypz6iYraiI3sjmnyws9BJdgdvxvti+cVYDTx
X-Received: by 2002:a5d:63ca:0:b0:37d:47b3:7b86 with SMTP id
 ffacd0b85a97d-37ef21ac59emr1954363f8f.44.1729606598726; 
 Tue, 22 Oct 2024 07:16:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnMwMbawVvBiQv90mhUsi6lh8ZyKZUV3wIqOBOZpCyQNkdyQnexX3z+odV9Awt0Dr+7C96tw==
X-Received: by 2002:a5d:63ca:0:b0:37d:47b3:7b86 with SMTP id
 ffacd0b85a97d-37ef21ac59emr1954335f8f.44.1729606598234; 
 Tue, 22 Oct 2024 07:16:38 -0700 (PDT)
Received: from localhost ([2a01:e0a:a9a:c460:2827:8723:3c60:c84a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a48564sm6729120f8f.29.2024.10.22.07.16.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 07:16:37 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Oct 2024 16:16:36 +0200
Message-Id: <D52ED9BSZU9P.32LYD3328YTTN@redhat.com>
Cc: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <qemu-devel@nongnu.org>,
 <vchundur@redhat.com>, <rjarry@redhat.com>
Subject: Re: [PATCH v6 0/3] Add support for the RAPL MSRs series
From: "Anthony Harivel" <aharivel@redhat.com>
To: =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, "Igor
 Mammedov" <imammedo@redhat.com>
User-Agent: aerc/0.18.2-69-g1c54bb3a9d11
References: <20240522153453.1230389-1-aharivel@redhat.com>
 <20241016135259.49021bca@imammedo.users.ipa.redhat.com>
 <D4X8WRR5F2GP.2MCBI9HDM3UHM@redhat.com>
 <20241018142526.34a2de0a@imammedo.users.ipa.redhat.com>
 <ZxJbtkMO1QcoiqVn@redhat.com>
 <20241022144615.203cf0da@imammedo.users.ipa.redhat.com>
 <ZxelgDeuZaia-Vqf@redhat.com>
In-Reply-To: <ZxelgDeuZaia-Vqf@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

Daniel P. Berrang=C3=A9, Oct 22, 2024 at 15:15:
> On Tue, Oct 22, 2024 at 02:46:15PM +0200, Igor Mammedov wrote:
>> On Fri, 18 Oct 2024 13:59:34 +0100
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>>=20
>> > On Fri, Oct 18, 2024 at 02:25:26PM +0200, Igor Mammedov wrote:
>> > > On Wed, 16 Oct 2024 14:56:39 +0200
>> > > "Anthony Harivel" <aharivel@redhat.com> wrote:
>> [...]
>>=20
>> > >=20
>> > > This also leads to a question, if we should account for
>> > > not VCPU threads at all. Looking at real hardware, those
>> > > MSRs return power usage of CPUs only, and they do not
>> > > return consumption from auxiliary system components
>> > > (io/memory/...). One can consider non VCPU threads in QEMU
>> > > as auxiliary components, so we probably should not to
>> > > account for them at all when modeling the same hw feature.
>> > > (aka be consistent with what real hw does). =20
>> >=20
>> > I understand your POV, but I think that would be a mistake,
>> > and would undermine the usefulness of the feature.
>> >=20
>> > The deployment model has a cluster of hosts and guests, all
>> > belonging to the same user. The user goal is to measure host
>> > power consumption imposed by the guest, and dynamically adjust
>> > guest workloads in order to minimize power consumption of the
>> > host.
>>=20
>> For cloud use-case, host side is likely in a better position
>> to accomplish the task of saving power by migrating VM to
>> another socket/host to compact idle load. (I've found at least 1
>> kubernetis tool[1], which does energy monitoring). Perhaps there
>> are schedulers out there that do that using its data.

I also work for Kepler project. I use it to monitor my VM has a black=20
box and I used it inside my VM with this feature enable. Thanks to that=20
I can optimize the workloads (dpdk application,database,..) inside my VM.=
=20

This is the use-case in NFV deployment and I'm pretty sure this could be=20
the use-case of many others.

>
> The host admin can merely shuffle workloads around, hoping that
> a different packing of workloads onto machines, will reduce power
> in some aount. You might win a few %, or low 10s of % with this
> if you're good at it.
>
> The guest admin can change the way their workload operates to
> reduce its inherant power consumption baseline. You could easily
> come across ways to win high 10s of % with this. That's why it
> is interesting to expose power consumption info to the guest
> admin.
>
> IOW, neither makes the other obsolete, both approaches are
> desirable.
>
>> > The guest workloads can impose non-negligble power consumption
>> > loads on non-vCPU threads in QEMU. Without that accounted for,
>> > any adjustments will be working from (sometimes very) inaccurate
>> > data.
>>=20
>> Perhaps adding one or several energy sensors (ex: some i2c ones),
>> would let us provide auxiliary threads consumption to guest, and
>> even make it more granular if necessary (incl. vhost user/out of
>> process device models or pass-through devices if they have PMU).
>> It would be better than further muddling vCPUs consumption
>> estimates with something that doesn't belong there.

I'm confused about your statement. Like every software power metering=20
tools out is using RAPL (Kepler, Scaphandre, PowerMon, etc) and custom=20
sensors would be better than a what everyone is using ?
The goal is not to be accurate. The goal is to be able to compare=20
A against B in the same environment and RAPL is given reproducible=20
values to do so.
Adding RAPL inside VM makes total sens because you can use tools that=20
are already out in the market.

>
> There's a tradeoff here in that info directly associated with
> backends threads, is effectively exposing private QEMU impl
> details as public ABI. IOW, we don't want too fine granularity
> here, we need it abstracted sufficiently, that different
> backend choices for a given don't change what sensors are
> exposed.
>
> I also wonder how existing power monitoring applications
> would consume such custom sensors - is there sufficient
> standardization in this are that we're not inventing
> something totally QEMU specific ?
>
>> > IOW, I think it is right to include non-vCPU threads usage in
>> > the reported info, as it is still fundamentally part of the
>> > load that the guest imposes on host pCPUs it is permitted to
>> > run on.
>>=20
>>=20
>> From what I've read, process energy usage done via RAPL is not
>> exactly accurate. But there are monitoring tools out there that
>> use RAPL and other sources to make energy consumption monitoring
>> more reliable.
>>=20
>> Reinventing that wheel and pulling all of the nuances of process
>> power monitoring inside of QEMU process, needlessly complicates it.
>> Maybe we should reuse one of existing tools and channel its data
>> through appropriate QEMU channels (RAPL/emulated PMU counters/...).
>
> Note, this feature is already released in QEMU 9.1.0.
>
>> Implementing RAPL in pure form though looks fine to me,
>> so the same tools could use it the same way as on the host
>> if needed without VM specific quirks.
>
> IMHO the so called "pure" form is misleading to applications, unless
> we first provided  some other pratical way to expose the data that
> we would be throwing away from RAPL.
>

The other possibility that I've think of is using a 3rd party tool to=20
give maybe more "accurate value" to QEMU.=20
For example, Kepler could be used to give value for each thread=20
of QEMU and so instead of calculating and using the qemu-vmsr-helper,=20
each values is transfered on request by QEMU via the UNIX thread that is=20
used today between the daemon and QEMU. It's just an idea that I have=20
and I don't know if that is acceptable for each project (QEMU and=20
Kepler) that would really solve few issues.

> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|


