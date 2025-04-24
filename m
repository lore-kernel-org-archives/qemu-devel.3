Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1934EC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 13:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7wst-0007mh-8C; Thu, 24 Apr 2025 09:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1u7wsq-0007mK-Rw
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 09:44:57 -0400
Received: from smtp.eurecom.fr ([193.55.113.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1u7wso-0005O8-Ho
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 09:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
 t=1745502295; x=1777038295;
 h=from:in-reply-to:references:date:cc:to:mime-version:
 message-id:subject:content-transfer-encoding;
 bh=DhJNduWkafYxci5GwprPARnBA9b6GD/fmqAJKheNxt4=;
 b=zbe6QTz1c41LJgXrAt1rTL+uRuJDutnHh4xhN5M5p0vz4TNcszlsEpIk
 kU9V2FFlwbFVPIQE/ziHxmleg0g5ZWcbJ7cvQhqFKj5L67fbCueQFlHec
 z0RbC69M74tuwI33i1izI2aD9ic9f0qA64zFHRCBiCZKHmGeK3bsNgwOV c=;
X-CSE-ConnectionGUID: Ak/wFbzBRhaR/POW8O1fAw==
X-CSE-MsgGUID: bOV9LnCJQquwPgBVwsT+CQ==
X-IronPort-AV: E=Sophos;i="6.15,236,1739833200"; 
   d="scan'208";a="995489"
Received: from quovadis.eurecom.fr ([10.3.2.233])
 by drago1i.eurecom.fr with ESMTP; 24 Apr 2025 15:44:50 +0200
From: "Marco Cavenati" <Marco.Cavenati@eurecom.fr>
In-Reply-To: <871ptqg6u9.fsf@suse.de>
Content-Type: text/plain; charset="utf-8"
X-Forward: 193.55.114.5
References: <20250327141451.163744-3-Marco.Cavenati@eurecom.fr>
 <87jz7rhjzq.fsf@suse.de> <4caa0-67f8d780-a89-60718600@156698708>
 <87ecxyhon3.fsf@suse.de> <7cd3c-67fe3180-3d9-10622a60@195384178>
 <87plhdfs9o.fsf@suse.de> <7cd3c-6800c580-4b5-10622a60@195456151>
 <871ptqg6u9.fsf@suse.de>
Date: Thu, 24 Apr 2025 15:44:49 +0200
Cc: "Peter Xu" <peterx@redhat.com>, qemu-devel@nongnu.org,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Prasad Pandit" <ppandit@redhat.com>
To: "Fabiano Rosas" <farosas@suse.de>
MIME-Version: 1.0
Message-ID: <151d8c-680a4080-15-6f9ea10@196998929>
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

On Thursday, April 17, 2025 17:12 CEST, Fabiano Rosas <farosas@suse.de>=
 wrote:

> For enabling mapped-ram generically at this point I think we don't ha=
ve
> much choice but to introduce a new version of read=5Framblock=5Fmappe=
d=5Fram()
> that writes zero pages. It would need to discriminate the zero pages,
> (instead of doing a big copy of a bunch of pages) so we could avoid
> copying a page that's already zero. In fact, if we do that, it would
> already work without further changes. The performance of -loadvm woul=
d
> leave something to be improved, but we could tackle that later.
>=20
> What do you think?
>=20
> If we decide we need to explicitly select that new code, I don't thin=
k
> we need any new capability, because the user has no choice in it. We
> know that loadvm needs it, but -loadvm doesn't, any other sort of
> mapped-ram migration also doesn't need it. There is some discussion t=
o
> be had on whether we want to bind it to the commands themselves, or d=
o
> some form of detection of clean ram. I think it's best we postopone t=
his
> part of the discussion until Peter is back (next week), so we can hav=
e
> more eyes on it.

The scenarios where zeroing is not required (incoming migration and
-loadvm) share a common characteristic: the VM has not yet run in the
current QEMU process.
To avoid splitting read=5Framblock=5Fmapped=5Fram(), could we implement
a check to determine if the VM has ever run and decide whether to zero
the memory based on that? Maybe using RunState?

Then we can add something like this to read=5Framblock=5Fmapped=5Fram()
...
clear=5Fbit=5Fidx =3D 0;
for (...) {
    // Zero pages
    if (guest=5Fhas=5Fever=5Frun()) {
        unread =3D TARGET=5FPAGE=5FSIZE * (set=5Fbit=5Fidx - clear=5Fbi=
t=5Fidx);
        offset =3D clear=5Fbit=5Fidx << TARGET=5FPAGE=5FBITS;
        host =3D host=5Ffrom=5Fram=5Fblock=5Foffset(block, offset);
        if (!host) {...}
        ram=5Fhandle=5Fzero(host, unread);
    }
    // Non-zero pages
    clear=5Fbit=5Fidx =3D find=5Fnext=5Fzero=5Fbit(bitmap, num=5Fpages,=
 set=5Fbit=5Fidx + 1);
...
(Plus trailing zero pages handling)

> >> We'd benefit from a separate "don't load zero pages" option only w=
hen
> >> the VM is guaranteed to be stopped and more importantly, not allow=
ed to
> >> be unstopped. This is the tricky part. We have experimented with a=
nd
> >> dropped the idea of detecting a stopped-vm-migration for mapped-ra=
m (the
> >> idea back then was not to do better zero page handling, but skip d=
irty
> >> tracking altogether).
> >>=20
> >> Since we're dealing with snapshots here, which are asynchronous, I=
'm
> >> wondering wheter it would make sense to extend the zero-page-detec=
tion
> >> option to the destination. Then we could bind the loadvm process t=
o
> >> zero-page-detection=3Dnone because I don't think we can safely ign=
ore them
> >> anyway.
> >
> >> > My overall goal is a hot-loadvm feature that currently lives in =
a fork
> >> > downstream and has a long way before getting in a mergeable stat=
e :)
> >>=20
> >> Cool. Don't hesitate to send stuff our way, the sooner and more of=
ten we
> >> discuss this, the better the chances of getting it merged upstream=
.
> >>=20
> >> Do you use libvirt at all? Mapped-ram support has been added to it=
 in
> >> the latest version. The original use-case for mapped-ram was quick
> >> snapshot saving and loading after all. Libvirt does it in a way th=
at
> >> does not use savevm, which might be helpful.
> >
> > No, I don't use libvirt. Thanks for the hint, but in that case I gu=
ess
> > libvirt would spawn a new "QEMU -incoming"  for each restore, and
> > that would be too expensive.
> >
> >> > In a nutshell, I'm using dirty page tracking to load from the sn=
apshot
> >> > only the pages that have been dirtied between two loadvm;
> >> > mapped-ram is required to seek and read only the dirtied pages.
> >>=20
> >> But then you'd have a bitmap of pages you could correlate with the
> >> file=5Fbmap and force-load whatever pages you need. It doesn't see=
m like
> >> zero page handling would affect you too much in that case.
> >
> > Perhaps I'm missing your point; if a page was zero in the snapshot
> > and then gets dirtied, I need to zero it out.
>=20
> I used "zero page handling" as "a policy on how to deal with zero
> pages", similarly to the zero-page-detection option.
>=20
> The page is being zeroed because it was dirty (on your dirty bitmap) =
not
> because some policy determined that it needs to be zeroed. IOW, it se=
ems
> your solution doesn't need to have any knowledge of whether the whole
> memory is supposed to be zeroed (as discussed above), the presence of=
 a
> dirty bitmap already selects which pages are restored and if there's =
a 1
> for that page in the bitmap, then we don't really care what's in the
> file=5Fbmap.
>=20
> If we implement generic snapshot + mapped-ram + zero page then you co=
uld
> probably simply OR your dirty bitmap on top of the file=5Fbmap.
>=20
> Does that makes sense? I might be missing something, I'm looking at a
> bunch of threads before going on vacation.

It makes sense, but special handling for zero pages instead of simply
ORing the two maps could improve performance.
If dirty =3D true and file=5Fbmap =3D false, instead of reading the zer=
o
page from the snapshot I can simply memset to 0 as above.

Enjoy your vacation :)

Thank you.
Best,
Marco


