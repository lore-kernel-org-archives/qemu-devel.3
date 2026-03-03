Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BBFEDEBF5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 22:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxXv7-0001Dm-Jl; Tue, 03 Mar 2026 17:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francesco@valla.it>)
 id 1vxXVv-0002XE-0G
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 16:42:47 -0500
Received: from delivery.antispam.mailspamprotection.com ([185.56.87.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francesco@valla.it>)
 id 1vxXVs-0007Od-Og
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 16:42:46 -0500
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-bh0b.prod.antispam.mailspamprotection.com;
 s=arckey; t=1772574162; 
 b=YLJ7dFKr+0fWDWNvxH0+hP94lDpxo/zaR+Hm5U1n7abWFv77aWJTJ96Mp8jpCqGVN/0L6Zrgjt
 hpbKX5+U8W2m01uMfm4WMxZjb9xbUv5AqyRB/Ua2Lii+tEHMiwjetJaLRlA5qutKT9Yx4/EWCP
 EWH4cRBJXc5RBh62O8Vdb8B1mQVTkbBO4S7QM4iMmMCKzOrMbhLsVDo3Cr5h9IL9RumXuvt9bM
 0A9ujzueb/+C06sw6v66xRFKBEImekk/hLKnGMlKuah/R/M9VJh/8LYDB4ugXg2QDET16fAiAI
 EPgC6GmrmfU+SJ3aevE2P1Tv1ftLD7yISyclYOVa4NCgCg==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-bh0b.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-bh0b.prod.antispam.mailspamprotection.com;
 s=arckey; t=1772574162; 
 bh=sT1WTGuzR5fiePLymPLZZ3/EMwNLUTogJdV9p9h+MgE=;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:DKIM-Signature:DKIM-Signature;
 b=EjsHivKLSJ5mA5KSNMuis/JO2fd9og7O+6JAzPGbI3eBbweZWsWGcn6RuV2gqW4aVYb10LXCvC
 J/wpEcq2912Gud1NJ8+Njw0xJXHW12wAxnEA7mvh4iwvCAMvLJ4k94+MPnZPAER/03ov7g2FRv
 shtztUZFzWBkVhm56m/b3Xvcj1v+ToJ1YDospvespjJdLFLUaTDNccF4hvqykDw8e3mrDnRPGv
 fwxP4/9y/YrfZMur4C/yaaGTp6XRLDJEndZjk/L7dcOjZ2GUqJyL92UGi+pTstW72YBa/BDO8E
 y50vJ/EdbyPvek2h1l/nhuWjIf4Lg4BK3d655PQu7UOx2A==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Reply-To:List-Unsubscribe;
 bh=sT1WTGuzR5fiePLymPLZZ3/EMwNLUTogJdV9p9h+MgE=; b=mAEBnk283Gemf6nIRK7Fz7u16x
 cqRpLCfqzqOL0MxxTT0qh640DNnnnKmzGp9FVojoOPYH+m/yXTtaOM1890BKDmHpfVaGRQEe6mfAe
 pIA36tcUrzj0cXyfspnsdCet28s/0hr1aFshIxeRj34D4NCU1rVgsXVkHrhBYOpoHjwA=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-bh0b.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.98.1)
 (envelope-from <francesco@valla.it>) id 1vxXVm-00000001bts-2zYm
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 21:42:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=sT1WTGuzR5fiePLymPLZZ3/EMwNLUTogJdV9p9h+MgE=; b=DkuRCXqnr+LicvnadsYeNFpLnU
 slFgyatq1U5vy9Hn2b4KkP1U2kcPj/q3PmMRh/zzySOdy/P6UuESaN2N1D452iwqvrfx0OpGI7aQC
 NziLD+T/rTOXjxKZYGUiglhJAS6zG7j0TlRX6ezAiEVWnLzl6PZemtTdhxlNfyIfhIo0=;
Received: from [82.57.88.19] (port=62003 helo=bywater.localnet)
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <francesco@valla.it>)
 id 1vxXVe-000000008XT-2LHZ; Tue, 03 Mar 2026 21:42:30 +0000
From: Francesco Valla <francesco@valla.it>
To: "mvaralar@redhat.com" <mvaralar@redhat.com>,
 "sgarzare@redhat.com" <sgarzare@redhat.com>,
 Ammar Yasser <aerosound161@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: GSoC virtio-rtc project
Date: Tue, 03 Mar 2026 22:42:30 +0100
Message-ID: <2787739.lGaqSPkdTl@bywater>
In-Reply-To: <CAHxyR9LgW-MY8PWs_hpGUh=AiYNfD-W8FirmkGMO1Xguby4Lxg@mail.gmail.com>
References: <CAHxyR9KTC0QzbSYQTAqpBxnyEWJG9+xMGENHps4vfJEPR16Dww@mail.gmail.com>
 <9abb752c-8f26-408e-b6d3-4d4cc2fb86b0@redhat.com>
 <CAHxyR9LgW-MY8PWs_hpGUh=AiYNfD-W8FirmkGMO1Xguby4Lxg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - nongnu.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 099eaf29ab42fad7eba14c81d8c598c0
X-AntiAbuse: ID - 099eaf29ab42fad7eba14c81d8c598c0
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vxXVm-00000001bts-2zYm-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-bh0b.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
Received-SPF: pass client-ip=185.56.87.11; envelope-from=francesco@valla.it;
 helo=delivery.antispam.mailspamprotection.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 03 Mar 2026 17:08:42 -0500
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

Hello Ammar,

On luned=C3=AC 2 marzo 2026 at 23:53, Ammar Yasser wrote:
> Hello maintainers
>=20
> Re-introducing myself in case you missed my email to the mailing list.

I *did* lost your first e-mail, so thank you for writing this one.

> I'm Ammar, a software engineer working with Linux kernel and virtualizati=
on.
> I'm interested in contributing to QEMU for GSoC 2026, particularly the
> virtio-rtc vhost-user device project. If accepted, this would be my second
> GSoC participation. I participated in 2024 with KubeVirt, which was my
> original introduction to QEMU.
>=20
> I have the following questions in order to formulate a successful proposa=
l:
>=20
> 1. What would you like to see from a successful proposal ? The current
> points i am studying and plan to include in mine are:
>=20
> - an overview of the RTC device spec
> - how it would interact with QEMU
> - some of the rust data types and enums we would introduce for requests,
> different error types.. etc
> - a breakdown for some of the RTC C implementations that currently exist =
in
> QEMU (allwinner, aspeed, goldfish.. etc), and what ideas can we borrow fr=
om
> them in our rust implementation
>=20
> I am leaving out implementation specific details out of the current phase.
> Let me know if this sounds appropriate
>=20

I'd include some details on how you intend to perform the activity (e.g.: h=
ow
to split and order the various tasks).

> 2. I am looking for issues I can tackle to familiarize myself with the
> vhost-device repo and how one device is structured. Any ones you have that
> are relevant to the project or you think are important in general?
>=20

No preferences there, please select the one(s) you think appropriate.

> Thanks in advance
>=20
> Ammar
>=20
>=20

Regards,

=46rancesco



