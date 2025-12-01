Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAEAD116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 15:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ67X-0001H4-9b; Mon, 01 Dec 2025 10:47:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=423f6341f=bchalios@amazon.es>)
 id 1vQ67T-0001Gn-8L
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 10:47:19 -0500
Received: from fra-out-001.esa.eu-central-1.outbound.mail-perimeter.amazon.com
 ([18.156.205.64])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=423f6341f=bchalios@amazon.es>)
 id 1vQ67R-0004jx-9M
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 10:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
 t=1764604037; x=1796140037;
 h=message-id:from:to:cc:date:in-reply-to:references:
 content-transfer-encoding:mime-version:subject;
 bh=ca77OHfB+bSKPqSn4kh8qlrAxssY+E9O3sPIOUVogic=;
 b=dNXiih2NJ4sg5XNpf/SowluN3iTx9TFc98Yn5si8oOVgCc5DgJN4De+U
 GMb1YXHUalyPCbwzz2PtBIOwfCvAGsD/WqHzdfROen5pUmzH215ouaZ2C
 l7iCHtUwwLKXHcDaj6SVoO5Ay8v+6dsFXCoODs8lmF27GXu++1Awz2gRn
 /wYUaoHWQDtdAJdXpBKNr+ansmngB+rvxHgLMxYjnsNE9vq+mLxXujqkY
 BVYgJhANcIbOymklm2UcCX6IDc6eksvRxcwUjMsnAX5ht0kLb7fScNRSz
 4rDwmniIgB/1/0rYEHC54hne7TuDUUtTgBhItVsCT9dl0JlNInclEy05E g==;
X-CSE-ConnectionGUID: BwjmQNXhTJy4PZX7/uTwRQ==
X-CSE-MsgGUID: E0aEuZMXQrKTMdgtOh7D6Q==
X-IronPort-AV: E=Sophos;i="6.20,241,1758585600"; 
   d="scan'208";a="5755876"
Subject: Re: [RFC PATCH 0/4] vmclock: add support for VM generation counter and
 notifications
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO
 smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
 by internal-fra-out-001.esa.eu-central-1.outbound.mail-perimeter.amazon.com
 with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 15:46:58 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:8467]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.27.255:2525]
 with esmtp (Farcaster)
 id 40486556-d5ae-4518-a588-d6b9ec3e8b46; Mon, 1 Dec 2025 15:46:57 +0000 (UTC)
X-Farcaster-Flow-ID: 40486556-d5ae-4518-a588-d6b9ec3e8b46
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 1 Dec 2025 15:46:57 +0000
Received: from [127.0.0.1] (10.13.181.70) by EX19D012EUA001.ant.amazon.com
 (10.252.50.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Mon, 1 Dec 2025
 15:46:53 +0000
Message-ID: <5dcae34ba9eb8e505de01039657f33dc87dffeeb.camel@amazon.es>
From: Babis Chalios <bchalios@amazon.es>
To: "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "Graf
 (AWS), Alexander" <graf@amazon.de>, "mzxreary@0pointer.de"
 <mzxreary@0pointer.de>
Date: Mon, 1 Dec 2025 16:46:49 +0100
In-Reply-To: <aS2v1nTakVbWYbht@redhat.com>
References: <20251201125023.18344-1-bchalios@amazon.es>
 <aS2v1nTakVbWYbht@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Originating-IP: [10.13.181.70]
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D012EUA001.ant.amazon.com (10.252.50.122)
Received-SPF: pass client-ip=18.156.205.64;
 envelope-from=prvs=423f6341f=bchalios@amazon.es;
 helo=fra-out-001.esa.eu-central-1.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

On Mon, 2025-12-01 at 15:10 +0000, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Dec 01, 2025 at 12:50:24PM +0000, Chalios, Babis wrote:
> > Latest specification of VMClock[1] adds support for VM generation
> > counter
> > and notifications. VM generation counter is similar to
> > disruption_marker
> > but it only changes when the guest has been loaded from a snapshot,
> > not
> > on live migration. Its purpose is to notify the guest about
> > snapshot
> > events and let it perform actions such as recreating UUIDs,
> > resetting
> > network connections, reseeding entropy, etc.
> >=20
> > Moreover, the spec now describes a notification that the device can
> > send
> > after updating the seq counter to a new even number.
> >=20
> > I have already sent the Linux changes to the mailing list here:
> > https://lore.kernel.org/lkml/20251127103159.19816-1-bchalios@amazon.es/=
T/#u
> >=20
> > [1] https://david.woodhou.se/VMClock.pdf
>=20
> Should that spec document the expected behaviour of guests when a
> hypervisor
> advertizes both vmclock and vmgenid devices ?
>=20
> QEMU supports both, and to avoid assumptions about whether a guest
> supports
> the newer vmclock, I could expect mgmt apps to expose both these QEMU
> devices.
>=20
> IIUC, your intent is that 'vmclock' obsoletes the need for 'vmgenid',
> so
> should the spec say that explicitly, and suggest that guest kernels
> ignore
> the vmgenid if both=C2=A0 are present, to avoid the same kind of actions
> being
> triggered twice ?
>=20
>=20

The two devices are completely orthogonal. VMGenID (as implemented in
Linux) is used to let the guest kernel know that it needs to reseed its
internal PRNG. VMClock, instead, notifies guest user-space about the
snapshot loading event. It is not about the kernel and it is not
restricted to restricted to reseeding entropy pools.

Cheers,
Babis

> With regards,
> Daniel
> --
> > : https://berrange.com=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -o-=C2=A0=C2=A0=C2=
=A0
> > https://www.flickr.com/photos/dberrange=C2=A0:|
> > : https://libvirt.org=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=
o-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > https://fstop138.berrange.com=C2=A0:|
> > : https://entangle-photo.org=C2=A0=C2=A0=C2=A0 -o-=C2=A0=C2=A0=C2=A0
> > https://www.instagram.com/dberrange=C2=A0:|
>=20


