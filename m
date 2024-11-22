Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D583AD75E53
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 14:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEUM4-0007b4-Pr; Fri, 22 Nov 2024 09:09:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tEUM0-0007Ya-8L
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 09:09:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tEULw-00033Y-Il
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 09:09:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732284562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yk2Ax7+hVQvI+U9sh4VeVFQ699U5AWMe6eQhGwrnkAY=;
 b=TEoTwk6/Z7lX+u4fYz3YqPVzuO4+e2xmI5Rgu7yYFw2x5KpDuoonDdwzv/0giEkKbCJCPZ
 HpCm9+doR5AdlaP9eH/fc+OCWNuHLdH7atT7wm/kBo2v2L5syHb51JjKLDXy0nKsqA3tD1
 Fg/OYNGmT6jS97ZOaLMxTPOx90rKYb8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-hBQIs8mIOIOQ8LDIUpz7RA-1; Fri, 22 Nov 2024 09:09:21 -0500
X-MC-Unique: hBQIs8mIOIOQ8LDIUpz7RA-1
X-Mimecast-MFC-AGG-ID: hBQIs8mIOIOQ8LDIUpz7RA
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38243a4ba5fso1465984f8f.2
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 06:09:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732284559; x=1732889359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yk2Ax7+hVQvI+U9sh4VeVFQ699U5AWMe6eQhGwrnkAY=;
 b=Zj0mEFoery2w5wuBvD+Hai0rcmtPx71tjO6EEnjJYA8a+DhrY9lAz5dOn4BQb4dyyo
 uOP5DiYLFu7TbmjJ7G1ybmOMkSjlP1rQdVI8imi438S4xKJDufe6sO3FjQUvxUSryU/1
 fTaO0bu9S5SkqUFdDQ5QkmDqq6PRNzEcb53Xb4aeQ7NHcuwQ14Yhi2DG5SddPhg8hA94
 h2e0O1Q7ODdCcN66zj6Yj8NAs/Hrr4U4Dfj/PnJ5dW5imwtCGkhIBJ4RXwGyhQo6qOBA
 59oJy3/z7GjLGKPn+v4VHwLi9ap8c4BF/KlaTE/6Wmd5UeH7hVX/bfFaiLql98PnXYxa
 B97Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsV8nJUfY2buZ8CskZbXA9Adm1V//FlqOMKlb/GdezBTsOm1Ck6oYE3j8kh1PW1BaQpcPiUfNTpzzi@nongnu.org
X-Gm-Message-State: AOJu0YzF02cnkOvFsloum+986HTWBdWNjvUqsFsAjUDILrzrN4QLJGOL
 c7mp/QZ9KUPCGp36Zt0kCj6UPpDOCAfP8HyN7YZge6YtmiqNUUvZeG13jy5mb1rjbjNfGvr7I4i
 HdT+zcTis7v/7Hqflmx2aZ3ZomPKTjS86QZR3Dribpru306o+rGc1pNpKCv5B
X-Gm-Gg: ASbGncs+jnp23M9jWiONuvVyOKVNg/DXaffVQnWWBLWHl3r81QcotctB2Lk2yWxnmxQ
 Cz3v28/hm4VvDKV5k3YzBcxdapY7SpiRvEDxGzeTj/A7IZ7CAGJZ4DTSGrv8A6EVYpx+v59bnhR
 DrVLNoxXdiLqz3FmUuBSMQwx4Vkwx0Pled0iKBBFmcxXeBg5q06+yWq95uFjs+yASNL62sAjGqU
 wkx8l7ETW5fRJiT0Tv2coioJvnerS4o3878yc6dS89lyVDCx2gH1l0/kwd6fnVeNR7H8v+bxT4y
 9zTA4ElXcAB0UdjQIe4SbA==
X-Received: by 2002:a05:6000:1788:b0:382:51d7:a2e0 with SMTP id
 ffacd0b85a97d-38260b61f45mr2788447f8f.27.1732284559096; 
 Fri, 22 Nov 2024 06:09:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyprGJV54qibFTr3TC4PN2R3DF0M9faj0ZtA0+QcxKPjJaRAb3VhPOvn4IscveuG6hYKjsCA==
X-Received: by 2002:a05:6000:1788:b0:382:51d7:a2e0 with SMTP id
 ffacd0b85a97d-38260b61f45mr2788423f8f.27.1732284558605; 
 Fri, 22 Nov 2024 06:09:18 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbc3a47sm2543903f8f.73.2024.11.22.06.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 06:09:17 -0800 (PST)
Date: Fri, 22 Nov 2024 15:09:17 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>, Paolo
 Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>
Subject: Re: [PATCH v2 1/4] hw/loongarch/virt: Add CPU topology support
Message-ID: <20241122150917.242e7699@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZyzH8cjpTmkN88us@intel.com>
References: <20241029095335.2219343-1-maobibo@loongson.cn>
 <20241029095335.2219343-2-maobibo@loongson.cn>
 <ZyDg00Vwowxkt5LO@intel.com>
 <20241106114150.5af254a7@imammedo.users.ipa.redhat.com>
 <ZyzH8cjpTmkN88us@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

On Thu, 7 Nov 2024 22:00:17 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> Hi Igor,
>=20
> > > What's the difference between arch_id and CPU index (CPUState.cpu_ind=
ex)? =20
> >=20
> > They might be the same but not necessarily.
> > arch_id is unique cpu identifier from architecture point of view
> > (which easily could be sparse and without specific order).
> > (ex: for x86 it's apic_id, for spapr it's core_id) =20
>=20
> Yes, I was previously puzzled as to why the core_id of spapr is global,
> which is completely different from the meaning of core_id in x86. Now,
> your analogy has made it very clear to me. Thanks!
>=20
> > while cpu_index is internal QEMU, that existed before possible_cpus[]
> > and non-sparse range and depends on order of cpus are created.
> > For machines that support possible_cpus[], we override default
> > cpu_index assignment to fit possible_cpus[].
> >=20
> > It might be nice to get rid of cpu_index in favor of possible_cpus[],
> > but that would be a lot work probably with no huge benefit
> > when it comes majority of machines that don't need variable
> > cpu count.  =20
>=20
> Thank you! Now I see.
>=20
> > > In include/hw/boards.h, the doc of CPUArchId said:
> > >=20
> > > vcpus_count - number of threads provided by @cpu object
> > >=20
> > > And I undersatnd each element in possible_cpus->cpus[] is mapped to a
> > > CPU object, so that here vcpus_count should be 1. =20
> >=20
> > it's arch specific, CPU object in possible_cpus was meant to point to
> > thread/core/..higher layers in future../
> >=20
> > For example spapr put's there CPUCore, where vcpus_count can be > 1
> >
> > That is a bit broken though, since CPUCore is not CPUState by any means,
> > spapr_core_plug() gets away with it only because
> >   core_slot->cpu =3D CPU(dev)
> > CPU() is dumb pointer cast. =20
>=20
> Is it also because of architectural reasons that the smallest granularity
> supported by spapr can only be the core?

Yes, I think so if I recall it correctly.

> > Ideally CPUArchId::cpu should be (Object*) to accommodate various
> > levels of granularity correctly (with dumb cast above it's just
> > cosmetics though as long as we treat it as Object in non arch
> > specific code). =20
>=20
> Thank you. So, I would like to ask, should the elements in possible_cpus
> be understood as the smallest granularity supported by hotplug?

not necessarily, eventually we might want to plug sockets someday,
machine would expose only have_socket in hotpluggable CPUs interface
and hotplugging a CPU would look like (device_add xeon_E5_2630,socket-id=3D=
X),
which resembles real hw use-case. And that xeon device would create interna=
lly
all necessary vCPUs, and configure internal parameters topo/caches/whatnot.
=20
> I want to understand that this reason is unrelated to the loongarch patch,
> instead I mainly want to continue thinking about my previous qom-topo[*]
> proposal.
>=20
> I remember your hotplug slides also mentioned larger granularity hotplug,
> which I understand, for example, allows x86 to support core/socket, etc.
> (this of course requires core/socket object abstraction).
>=20
> If possible_cpus[] only needs to correspond to the smallest granularity
> topo object, then it matches my qom-topo proposal quite well, essentially
> mapping one layer of a complete topology tree (which is built from socket
> to thread, layer by layer) to possible_cpus[] (actually, this is my desig=
n:
> mapping the thread layer of the x86 topology tree to possible_cpus[]. :) )
>=20
> Although many years have passed, I still believe that larger granularity
> hotplug is valuable, especially as hardware includes more and more CPUs.

that wasn't the case in the past for virt world, as main goal of it there
is dynamic scalability, while in real hw (in x86 world) it's mainly RAS
feature.

> [*]: https://lore.kernel.org/qemu-devel/20240919015533.766754-1-zhao1.liu=
@intel.com/
It looks to me as too complicated approach, I'll comment there.

>=20
> [snip]
>=20
> > > IIUC, the phy_id is kind of like the x86 apic_id, but the field is co=
mpletely
> > > derived from topology, so why do you need to define it as a property =
and then
> > > expose it to the user? =20
> >=20
> > for x86 we do expose apic_id as a property as well, partly from histori=
cal pov
> > but also it's better to access cpu fields via properties from outside of
> > CPU object than directly poke inside of CPU structure from outside of C=
PU
> > (especially if it comes to generic code) =20
>=20
> Thank you for your guidance. Similar to Bibo=E2=80=99s question, I also w=
onder
> if there is the need for a property that won't be exposed to users.
>=20
> Regards,
> Zhao
>=20


