Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF68FC369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 09:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5LGw-0003SL-KT; Thu, 17 Apr 2025 05:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1u5LGu-0003Rx-HE
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 05:11:00 -0400
Received: from smtp.eurecom.fr ([193.55.113.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1u5LGs-0002NC-8L
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 05:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
 t=1744881058; x=1776417058;
 h=from:in-reply-to:references:date:cc:to:mime-version:
 message-id:subject:content-transfer-encoding;
 bh=Pbbsn3Z4DnHy/E/r/MQqrn7EsNpRyoqOCAb9iFq3mHs=;
 b=PIYjhQaIA1OkxZVb/rJfloiXPfRcO2/euL6TEAzZga0Pnw8vQLxsD96U
 QZAcUY+6WXACB8mr98i04fDAYFkHO5mW1qp7LDkKH10x4i+mqknysKrTD
 c1E/0ob5EjzBgl4UaRBcJITDJkwa7TY3bWA9kE3XXgMB4vitM0DA0VPKy w=;
X-CSE-ConnectionGUID: dGqiBrh6SQW0IUsFtpnILw==
X-CSE-MsgGUID: 3v08MM1ZSe+90IbdQOhldQ==
X-IronPort-AV: E=Sophos;i="6.15,218,1739833200"; 
   d="scan'208";a="894647"
Received: from quovadis.eurecom.fr ([10.3.2.233])
 by drago1i.eurecom.fr with ESMTP; 17 Apr 2025 11:10:53 +0200
From: "Marco Cavenati" <Marco.Cavenati@eurecom.fr>
In-Reply-To: <87plhdfs9o.fsf@suse.de>
Content-Type: text/plain; charset="utf-8"
X-Forward: 193.55.114.5
References: <20250327141451.163744-3-Marco.Cavenati@eurecom.fr>
 <87jz7rhjzq.fsf@suse.de> <4caa0-67f8d780-a89-60718600@156698708>
 <87ecxyhon3.fsf@suse.de> <7cd3c-67fe3180-3d9-10622a60@195384178>
 <87plhdfs9o.fsf@suse.de>
Date: Thu, 17 Apr 2025 11:10:53 +0200
Cc: "Peter Xu" <peterx@redhat.com>, qemu-devel@nongnu.org,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Prasad Pandit" <ppandit@redhat.com>
To: "Fabiano Rosas" <farosas@suse.de>
MIME-Version: 1.0
Message-ID: <7cd3c-6800c580-4b5-10622a60@195456151>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?migration=3A?= add 
 =?utf-8?q?FEATURE=5FSEEKABLE?= to QIOChannelBlock
User-Agent: SOGoMail 5.12.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=193.55.113.210;
 envelope-from=Marco.Cavenati@eurecom.fr; helo=smtp.eurecom.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tuesday, April 15, 2025 15:50 CEST, Fabiano Rosas <farosas@suse.de> =
wrote:

> > So, I see your point on performance, but I'm not fully comfortable
> > with the difference in zero page handling between mapped-ram on
> > and mapped-ram off. In the former case zero pages are skipped, whil=
e
> > in the latter they are explicitly zeroed.
> > Enabling mapped-ram has the implicit effect to also skip zero-pages=
.
> > I think it is an optimization not really bound to mapped-ram and it
> > could be better to have this feature external to mapped-ram, enable=
d
> > when the destination ram is known to be already zeroed (also for
> > mapped-ram off ideally).
>=20
> From a design perspective that makes sense. The only use case current=
ly
> would be mapped-ram =5Fmigration=5F (as opposed to snapshot) because
> non-mapped-ram migration is usually done live. The stream of pages wi=
ll
> potentially have several versions of the same page, therefore we need=
 to
> clear it when it's a zero page.

It might be a niche use case (and maybe I'm the only one still using
plain old QEMU snapshots) but, also the cli option `-loadvm file` might
benefit from skipping 0 pages: snapshots are taken with the VM stopped
and the `-loadvm file` acts on a clean ram.

> We'd benefit from a separate "don't load zero pages" option only when
> the VM is guaranteed to be stopped and more importantly, not allowed =
to
> be unstopped. This is the tricky part. We have experimented with and
> dropped the idea of detecting a stopped-vm-migration for mapped-ram (=
the
> idea back then was not to do better zero page handling, but skip dirt=
y
> tracking altogether).
>=20
> Since we're dealing with snapshots here, which are asynchronous, I'm
> wondering wheter it would make sense to extend the zero-page-detectio=
n
> option to the destination. Then we could bind the loadvm process to
> zero-page-detection=3Dnone because I don't think we can safely ignore=
 them
> anyway.

> > My overall goal is a hot-loadvm feature that currently lives in a f=
ork
> > downstream and has a long way before getting in a mergeable state :=
)
>=20
> Cool. Don't hesitate to send stuff our way, the sooner and more often=
 we
> discuss this, the better the chances of getting it merged upstream.
>=20
> Do you use libvirt at all? Mapped-ram support has been added to it in
> the latest version. The original use-case for mapped-ram was quick
> snapshot saving and loading after all. Libvirt does it in a way that
> does not use savevm, which might be helpful.

No, I don't use libvirt. Thanks for the hint, but in that case I guess
libvirt would spawn a new "QEMU -incoming"  for each restore, and
that would be too expensive.

> > In a nutshell, I'm using dirty page tracking to load from the snaps=
hot
> > only the pages that have been dirtied between two loadvm;
> > mapped-ram is required to seek and read only the dirtied pages.
>=20
> But then you'd have a bitmap of pages you could correlate with the
> file=5Fbmap and force-load whatever pages you need. It doesn't seem l=
ike
> zero page handling would affect you too much in that case.

Perhaps I'm missing your point; if a page was zero in the snapshot
and then gets dirtied, I need to zero it out. But yeah, the code will b=
e
different and for my specific use case I don't absolutely need
mapped-ram snapshots restore to fully work.

Thank you.
Best,
Marco


