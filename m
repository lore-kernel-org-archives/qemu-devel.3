Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1313D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 15:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ5TO-0007ZP-5K; Mon, 01 Dec 2025 10:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=423f6341f=bchalios@amazon.es>)
 id 1vQ5TM-0007Xo-Jl
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 10:05:52 -0500
Received: from fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com
 ([18.199.210.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=423f6341f=bchalios@amazon.es>)
 id 1vQ5TH-0007rj-Mi
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 10:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
 t=1764601547; x=1796137547;
 h=message-id:from:to:cc:date:in-reply-to:references:
 content-transfer-encoding:mime-version:subject;
 bh=/5Sc3amRTHgi30WhwWteBG6vzxt7PXm45FgZdu64lOo=;
 b=IvAea5u2i6UfgzR9sl5wq4I8lzsaNsa/zxpGJrFLHmFPdGRFUtPT4mYn
 RxdE6KDt8q1k7BPgd/RqyZhg2pFFHPv/x8+TykkmDVbW9CpeCWUCYmUWb
 2m/ZZWSv1GzjXv80y6IIrlcX1bcMHy+WyKtwylGQ040DtEFz5rgS9+fXM
 kPNfTscvHvvtdpiKcyPsu5ya1Jecq2ZuWbXNgVy2wdIq8EzbILHjlKSw1
 dtHeKB9HShubOtSHOjVEuxTKME7wtGNPsWjvXCFLGOo6Kbi39MFjMERKC
 plaKIHdYqVcTkcqq/MkKyl7jVo65AcTssmhMLJ15751O7lZ4lzW8BClrk g==;
X-CSE-ConnectionGUID: EW1ZSsiYSEKLokPE62MczA==
X-CSE-MsgGUID: oKSmdHtdQ6C8CGrEF1dn+w==
X-IronPort-AV: E=Sophos;i="6.20,241,1758585600"; 
   d="scan'208";a="5959878"
Subject: Re: [RFC PATCH 2/4] hw/acpi: add new fields in VMClock ABI
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO
 smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
 by internal-fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com
 with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 15:05:25 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.234:28668]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.21.117:2525]
 with esmtp (Farcaster)
 id 2cd9e513-4a99-4b14-b4ad-7249d83b940c; Mon, 1 Dec 2025 15:05:25 +0000 (UTC)
X-Farcaster-Flow-ID: 2cd9e513-4a99-4b14-b4ad-7249d83b940c
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 1 Dec 2025 15:05:25 +0000
Received: from [127.0.0.1] (10.13.181.70) by EX19D012EUA001.ant.amazon.com
 (10.252.50.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Mon, 1 Dec 2025
 15:05:21 +0000
Message-ID: <5ba3ab6924b47613665f801193f7bcfd0584a0e1.camel@amazon.es>
From: Babis Chalios <bchalios@amazon.es>
To: David Woodhouse <dwmw2@infradead.org>, Cornelia Huck <cohuck@redhat.com>, 
 "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Graf (AWS), Alexander"
 <graf@amazon.de>, "mzxreary@0pointer.de" <mzxreary@0pointer.de>
Date: Mon, 1 Dec 2025 16:05:17 +0100
In-Reply-To: <8e8ab56ce4f8f2a0f0c084bd4e48958a441b40f1.camel@infradead.org>
References: <20251201125023.18344-1-bchalios@amazon.es>
 <20251201125023.18344-4-bchalios@amazon.es> <87qztenykd.fsf@redhat.com>
 <196b8afa77ec3253006dcde712b07f4e9c70de30.camel@infradead.org>
 <87ldjmnwyt.fsf@redhat.com>
 <8e8ab56ce4f8f2a0f0c084bd4e48958a441b40f1.camel@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Originating-IP: [10.13.181.70]
X-ClientProxiedBy: EX19D040UWA004.ant.amazon.com (10.13.139.93) To
 EX19D012EUA001.ant.amazon.com (10.252.50.122)
Received-SPF: pass client-ip=18.199.210.3;
 envelope-from=prvs=423f6341f=bchalios@amazon.es;
 helo=fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com
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

On Mon, 2025-12-01 at 14:27 +0000, David Woodhouse wrote:
> On Mon, 2025-12-01 at 14:38 +0100, Cornelia Huck wrote:
> > On Mon, Dec 01 2025, David Woodhouse <dwmw2@infradead.org> wrote:
> >=20
> > > On Mon, 2025-12-01 at 14:04 +0100, Cornelia Huck wrote:
> > > > On Mon, Dec 01 2025, "Chalios, Babis" <bchalios@amazon.es>
> > > > wrote:
> > > >=20
> > > > > VMClock now supports a vm_generation_counter field in the
> > > > > struct it
> > > > > exposes to userspace. The field signals a disruption that
> > > > > happened due
> > > > > to a guest loaded from a snapshot.
> > > > >=20
> > > > > Moreover, VMClock now optionally supports device
> > > > > notifications when the
> > > > > seq_count changes to a new even value.
> > > > >=20
> > > > > Signed-off-by: Babis Chalios <bchalios@amazon.es>
> > > > > ---
> > > > > =C2=A0include/standard-headers/linux/vmclock-abi.h | 20
> > > > > ++++++++++++++++++++
> > > > > =C2=A01 file changed, 20 insertions(+)
> > > >=20
> > > > Please either do a full linux-headers update against a specific
> > > > Linux
> > > > kernel version, or mark this as a placeholder patch if the code
> > > > is not
> > > > yet merged.
> > >=20
> > > The Linux patches are being posted simultaneously, so they'll be
> > > in
> > > Linux 6.20 (7.0?) at the earliest. We'll want to ingest the
> > > update
> > > before then.
> > >=20
> > > The intent is not for the Linux source to be the canonical
> > > definition
> > > of the data structure; we *are* working on publishing the spec,
> > > and
> > > Babis referenced the current draft. It isn't in the form of C
> > > source
> > > code though, so I suspect it makes sense to keep including the
> > > Linux
> > > header?
> >=20
> > Oh, including the Linux header sounds fine; but as long as the code
> > has
> > not yet been merged there, this needs to be marked as not yet ready
> > to
> > merge on the QEMU side. (And it needs to be updated by a full
> > headers
> > update when merged.)
>=20
> That's exactly what we *don't* want, and why we say that the
> canonical
> definition of this structure is the actual specification. There's no
> need for QEMU to only ever follow Linux.
>=20
> In that case, probably best *not* to use the Linux header and instead
> to build our own specifically for QEMU based on the specification.

I can do that for v1!

> It can be almost byte-for-byte identical

Why "almost", though?

Cheers,
Babis

