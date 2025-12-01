Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB75D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 15:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ5Q0-0005tg-6m; Mon, 01 Dec 2025 10:02:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=423f6341f=bchalios@amazon.es>)
 id 1vQ5Pu-0005t4-7b
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 10:02:18 -0500
Received: from fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com
 ([35.158.23.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=423f6341f=bchalios@amazon.es>)
 id 1vQ5Ps-0007AK-L5
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 10:02:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
 t=1764601336; x=1796137336;
 h=message-id:from:to:cc:date:in-reply-to:references:
 content-transfer-encoding:mime-version:subject;
 bh=G2Z6L/cGrX6dkkxT/efBGobLCUv8I8U4zeLwHCLNZ6E=;
 b=EvHaAOCOrFiuJG8dOP4Zqv/tYzIlYZV4zGbzsI6Eb54IwMQXCKQHh+tT
 /TRA28pIhKp+5ojXgGJgqTQBmG2gQkrxFCyvxBnNh6WC13XD0sUbm8HU5
 9AxGNWGLV98I3CVlRrGei5bMs9a3Hn6L/XBUtRWGz/AOZHsQIExzRMo6e
 crajbj1koY8Mq6xH70P2TpJTsCX/jww1OjkaP+lQ2tmZnk1vtrNAjrGCx
 HxcIM1TtIw38D3BM/rbOehdU1iBOgnmShasDSs9UER52yKC7/VQlAZjyz
 Dl9ZGoGaj9n/9Xa0cetpBPuJoE2PaipuRfaD2qxbyzpGI8uVEzVSPsTx5 g==;
X-CSE-ConnectionGUID: lzdX0k8bSS6n99PeigtYxA==
X-CSE-MsgGUID: EYZvUwXNQqOzOQOeraz9/A==
X-IronPort-AV: E=Sophos;i="6.20,241,1758585600"; 
   d="scan'208";a="6066050"
Subject: Re: [RFC PATCH 3/4] hw/acpi: add VM generation counter field to
 VMClock
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO
 smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
 by internal-fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com
 with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 15:01:58 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.232:18877]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.31.35:2525]
 with esmtp (Farcaster)
 id cfbf6f4a-9006-4153-86da-d61aad585e20; Mon, 1 Dec 2025 15:01:57 +0000 (UTC)
X-Farcaster-Flow-ID: cfbf6f4a-9006-4153-86da-d61aad585e20
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 1 Dec 2025 15:01:57 +0000
Received: from [127.0.0.1] (10.13.181.70) by EX19D012EUA001.ant.amazon.com
 (10.252.50.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Mon, 1 Dec 2025
 15:01:53 +0000
Message-ID: <843dc13c2dbb2b1f0bd622fe90e388e3e0752b92.camel@amazon.es>
From: Babis Chalios <bchalios@amazon.es>
To: "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, "David
 Woodhouse" <dwmw2@infradead.org>
CC: "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Graf (AWS), Alexander" <graf@amazon.de>,
 "mzxreary@0pointer.de" <mzxreary@0pointer.de>
Date: Mon, 1 Dec 2025 16:01:49 +0100
In-Reply-To: <aS2pJBM32o2cFVou@redhat.com>
References: <20251201125023.18344-1-bchalios@amazon.es>
 <20251201125023.18344-5-bchalios@amazon.es> <aS2iOER6KBMMtJ0X@redhat.com>
 <e10030cec8809f16e41a2a3baaf07cf22894f8ff.camel@infradead.org>
 <aS2pJBM32o2cFVou@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Originating-IP: [10.13.181.70]
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
 EX19D012EUA001.ant.amazon.com (10.252.50.122)
Received-SPF: pass client-ip=35.158.23.94;
 envelope-from=prvs=423f6341f=bchalios@amazon.es;
 helo=fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com
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

On Mon, 2025-12-01 at 14:41 +0000, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Dec 01, 2025 at 02:29:57PM +0000, David Woodhouse wrote:
> > On Mon, 2025-12-01 at 14:12 +0000, Daniel P. Berrang=C3=A9 wrote:
> > > From QEMU's POV, live migration and snapshots
> > > are indistiguishable operations, both using the same
> > > functionaility.
> > >=20
> > > eg
> > > =C2=A0 $ qemu-system-x86_64 -monitor stdio -device vmclock
> > > =C2=A0 (qemu) migrate file:snapshot.img
> > >=20
> > > and
> > >=20
> > > =C2=A0 $ qemu-system-x86_64 -monitor stdio -device vmclock -incoming
> > > file:snapshot.img
> > >=20
> > >=20
> > > and we can't check the QEMU migration target being "file:" and
> > > mgmt
> > > apps can use the "fd:" protocol to pass in a pre-opened target
> > > which can
> > > be a socket or pipe or file.
> >=20
> > What triggers the vmgenid to actually get updated for a snapshot?
> > That's the condition we're after, isn't it?
>=20
> I don't quiet understand the sequences, but libvirt is involved in
> setting
> guid=3Dnnnn as an arg to -device vmgenid when it spawns QEMU. This
> means
> libvirt has control over when it is changed or not.
>=20

That's a shame :(

Maybe we could do the same as VMGenID then. Make vm_generation_counter
something that the user can set when creating the device (same as
VMGenID's GUID). WDYT David?

Cheers,
Babis



