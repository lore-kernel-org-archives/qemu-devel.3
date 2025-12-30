Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50F0E94109
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 08:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaV7d-000130-Nh; Tue, 30 Dec 2025 03:30:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>) id 1vaV7a-00011y-V4
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 03:30:27 -0500
Received: from sender4-op-o12.zoho.com ([136.143.188.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>) id 1vaV7Y-0005s5-Pa
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 03:30:26 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1767083403; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=aH9IBuuduhChbo9MsOngnWhBAwMByEsgQcx1noPDqpd+8fW5LNU97caUjNij2ExtP3A/9lGszg1HVGT+Q4P3PuZm7w/fiqYn5H2v9UpDBCOIm+UT8totl/7XLBuBeERBkmdCTRAdDdnMbFzsS1S/CLxW6KFhJwE7CY3vkXkFdEk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1767083403;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=LJpH1HARvjskdKzfKikilHbmzvPqY+Q6k5LRrZ6CMYs=; 
 b=fxmhjZOofS6hMUlh2bnyjozGKin6LozdTneyGkuuUfMLykk0/quuegn0zR68Ec+9Y0jqTKq7QT1LZTej87vRUl8MbUunDptHLSEvQCk4sTR68fm4XgTU7cswhR4mpT/VxjtmFrij5K+C800VUmMV9UoM3684Z+L9fK8ZDW6FaIg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767083403; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=LJpH1HARvjskdKzfKikilHbmzvPqY+Q6k5LRrZ6CMYs=;
 b=MUB0X5ev//gaJV2ktTMxtwwwF17nqqL7ZperQVFQPhAy/pqqUvvZvTT3p6yfSE0e
 pWnN37JjYPn2wt5sQDskaAFF7uwCmcJs8TNI34jiz3GUqp2EfMamVNBq1PvcNkwmO7M
 tpJullSep5IT92v03FsOjeyRElVqljqbZd+iEeQE=
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 1767083401196358.94956268333954;
 Tue, 30 Dec 2025 00:30:01 -0800 (PST)
Date: Tue, 30 Dec 2025 16:30:01 +0800
From: Li Chen <me@linux.beauty>
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>
Cc: "Peter Xu" <peterx@redhat.com>, "Fabiano Rosas" <farosas@suse.de>,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 "Laurent Vivier" <lvivier@redhat.com>,
 "David Hildenbrand" <david@kernel.org>,
 =?UTF-8?Q?=22Philippe_Mathieu-Daud=C3=A9=22?= <philmd@linaro.org>,
 "qemu-devel" <qemu-devel@nongnu.org>,
 "David Matlack" <dmatlack@google.com>,
 "Pratyush Yadav" <pratyush@kernel.org>, "Mike Rapoport" <rppt@kernel.org>,
 "Alexander Graf" <graf@amazon.com>, "Jason Gunthorpe" <jgg@nvidia.com>,
 "Samiullah Khawaja" <skhawaja@google.com>
Message-ID: <19b6e60dfd2.187d822f1751681.8912147399180739154@linux.beauty>
In-Reply-To: <CA+CK2bA1Xv+asZ3d2jALk+VePDdDg+4ao0Y72CWV2i0rg3GsyQ@mail.gmail.com>
References: <20251229120839.89817-1-me@linux.beauty>
 <CA+CK2bA1Xv+asZ3d2jALk+VePDdDg+4ao0Y72CWV2i0rg3GsyQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] CPR: shared RAM with /dev/fdset for LUO kexec reboot
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Received-SPF: pass client-ip=136.143.188.12; envelope-from=me@linux.beauty;
 helo=sender4-op-o12.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Pasha,

Thanks for the detailed clarification, that's very helpful.

 ---- On Mon, 29 Dec 2025 23:50:35 +0800  Pasha Tatashin <pasha.tatashin@so=
leen.com> wrote ---=20
 > Hi Li,
 >=20
 > Thanks for the series. I have a few comments regarding the interaction
 > with the LUO agent and the broader architecture.
 >=20
 > > In the LUO/KHO update flow [1], a LUO agent coordinates a host kexec r=
eboot
 > > while keeping VM RAM content intact. LUO creates the guest RAM backing=
 as a
 > > memfd and passes it to QEMU via -add-fd on the initial launch, so that
 >=20
 > I am currently working on the LUO agent (LUOD) documentation, and the
 > intended behavior differs slightly from this description.
 >=20
 > Rather than the agent simply passing FDs, the design involves LUOD
 > opening /dev/liveupdate and creating a UDS socket (e.g., at
 > /run/luod/liveupdate.sock). Live-update-capable clients connect to
 > this socket, create a LUO session, and preserve their resources into
 > that session. Once all clients notify LUOD that they are ready, LUOD
 > performs the kexec reboot while keeping /dev/liveupdate open, ensuring
 > the LUO sessions survive.
 >=20
 > After the reboot, the restarted clients reconnect to LUOD via UDS and
 > request their preserved sessions. The sessions are passed as FDs back
 > to the clients. From those sessions, the clients retrieve the
 > resources, restore them, and resume suspended operations. Finally, the
 > clients "finish" their sessions, fully reclaiming ownership of the
 > preserved resources from LUO back to userspace.

Ack, and sorry for my cover letter text over-simplified the design.=20

 > > memory-backend-file can use it as the shared RAM backing. On update, L=
UO
 > > checkpoints QEMU, reboots the host kernel via kexec, and then re-launc=
hes QEMU
 > > to restore vmstate while reusing the same preserved memfd-backed RAM F=
D.
 > > Today LUO only supports handing off guest RAM via memfd [2].
 > >
 > > To re-attach that preserved RAM backing without reopening non-persiste=
nt
 > > paths, QEMU needs to let memory-backend-file consume the pre-opened FD=
 using
 > > mem-path=3D/dev/fdset/<id>. However, memory-backend-file currently use=
s
 > > open()/creat() directly, so /dev/fdset/<id> cannot be resolved through=
 the
 > > fdset mechanism, making this workflow impossible.
 > >
 > > This series allows /dev/fdset/<id> for file-backed RAM, documents the =
setup,
 > > and adds qtests to validate that x-ignore-shared keeps RAM transfer mi=
nimal
 > > in the cpr-reboot path.
 >=20
 > Sessions become particularly relevant when we look beyond guest RAM.
 > For complex resources like VFIO or IOMMU, simply passing the FD is
 > insufficient. These resources require specific ioctls to be issued by
 > clients after the FD is retrieved, but before vCPUs are resumed or the
 > session is "finished".

One question: in the intended LUOD/session architecture, do you still expec=
t
clients (or a wrapper) to inject the retrieved guest RAM memfd FD into QEMU
via -add-fd + /dev/fdset/<id> at QEMU startup? (as this patchset does)

Or is the longer-term plan that QEMU itself connects to LUOD over UDS, retr=
ieves
the session/resource FD directly, and consumes it as the RAM backing withou=
t
going through -add-fd?=20

If the latter, I think we'd likely need a QEMU-side interface to
consume an inherited/pre-opened FD for RAM backing during early machine ini=
t.

Regards,

Li=E2=80=8B


