Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BA2C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 12:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNCo-0004F8-SY; Fri, 09 May 2025 08:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1uDNCl-0004Ex-IU
 for qemu-devel@nongnu.org; Fri, 09 May 2025 08:51:55 -0400
Received: from smtp.eurecom.fr ([193.55.113.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1uDNCj-0004Nl-7m
 for qemu-devel@nongnu.org; Fri, 09 May 2025 08:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
 t=1746795114; x=1778331114;
 h=from:in-reply-to:references:date:cc:to:mime-version:
 message-id:subject:content-transfer-encoding;
 bh=3KrSJchCcxY2Dm72jEG18O94sA2AlQybD6XCFFlIRf8=;
 b=WDSY6/mpF1HE3F5X+DZOuBQIouEsL6S5976bGt+bHBR5tze+QUMbs4/m
 /gfrvzuhwOm/SGIyUjHs5CXb4j+sRBlYMqzgDOo1LRkFebLmnvYXFYStD
 oVfdtiqYi4N9L4iWujYXp87vjq6IFCT8WIb2W/xAEPsFU5FHL2xZvblWa w=;
X-CSE-ConnectionGUID: Osrgsv1ITe+cnN2zRYZz9w==
X-CSE-MsgGUID: 23OS3GqaS0uonWlnaz0AaQ==
X-IronPort-AV: E=Sophos;i="6.15,275,1739833200"; 
   d="scan'208";a="1242171"
Received: from quovadis.eurecom.fr ([10.3.2.233])
 by drago1i.eurecom.fr with ESMTP; 09 May 2025 14:51:48 +0200
From: "Marco Cavenati" <Marco.Cavenati@eurecom.fr>
In-Reply-To: <aB0Swile4IjxTUsd@x1.local>
Content-Type: text/plain; charset="utf-8"
X-Forward: 80.215.234.36
References: <20250327141451.163744-3-Marco.Cavenati@eurecom.fr>
 <87jz7rhjzq.fsf@suse.de> <4caa0-67f8d780-a89-60718600@156698708>
 <87ecxyhon3.fsf@suse.de> <7cd3c-67fe3180-3d9-10622a60@195384178>
 <87plhdfs9o.fsf@suse.de> <7cd3c-6800c580-4b5-10622a60@195456151>
 <871ptqg6u9.fsf@suse.de>
 <151d8c-680a4080-15-6f9ea10@196998929> <aB0Swile4IjxTUsd@x1.local>
Date: Fri, 09 May 2025 14:51:47 +0200
Cc: "Fabiano Rosas" <farosas@suse.de>, qemu-devel@nongnu.org,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Prasad Pandit" <ppandit@redhat.com>
To: "Peter Xu" <peterx@redhat.com>
MIME-Version: 1.0
Message-ID: <193e5a-681dfa80-3af-701c0f80@227192887>
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

Hello Peter,

On Thursday, May 08, 2025 22:23 CEST, Peter Xu <peterx@redhat.com> wrot=
e:

> > The scenarios where zeroing is not required (incoming migration and
> > -loadvm) share a common characteristic: the VM has not yet run in t=
he
> > current QEMU process.
> > To avoid splitting read=5Framblock=5Fmapped=5Fram(), could we imple=
ment
> > a check to determine if the VM has ever run and decide whether to z=
ero
> > the memory based on that? Maybe using RunState?
> >=20
> > Then we can add something like this to read=5Framblock=5Fmapped=5Fr=
am()
> > ...
> > clear=5Fbit=5Fidx =3D 0;
> > for (...) {
> >     // Zero pages
> >     if (guest=5Fhas=5Fever=5Frun()) {
> >         unread =3D TARGET=5FPAGE=5FSIZE * (set=5Fbit=5Fidx - clear=5F=
bit=5Fidx);
> >         offset =3D clear=5Fbit=5Fidx << TARGET=5FPAGE=5FBITS;
> >         host =3D host=5Ffrom=5Fram=5Fblock=5Foffset(block, offset);
> >         if (!host) {...}
> >         ram=5Fhandle=5Fzero(host, unread);
> >     }
> >     // Non-zero pages
> >     clear=5Fbit=5Fidx =3D find=5Fnext=5Fzero=5Fbit(bitmap, num=5Fpa=
ges, set=5Fbit=5Fidx + 1);
> > ...
> > (Plus trailing zero pages handling)
>=20
> [...]
>=20
> > > >> > In a nutshell, I'm using dirty page tracking to load from th=
e snapshot
> > > >> > only the pages that have been dirtied between two loadvm;
> > > >> > mapped-ram is required to seek and read only the dirtied pag=
es.
>=20
> I may not have the full picture here, please bare with me if so.
>=20
> It looks to me the major feature here you're proposing is like a grou=
p of
> snapshots in sequence, while only the 1st snapshot contains full RAM =
data,
> the rest only contains what were dirtied?
>
> From what I can tell, the interface will be completely different from
> snapshots then - firstly the VM will be running when taking (at least=
 the
> 2nd+) snapshots, meanwhile there will be an extra phase after normal =
save
> snapshot, which is "keep saving snapshots", during the window the use=
r is
> open to snapshot at any time based on the 1st snapshot.  I'm curious =
what's
> the interfacing for the feature.  It seems we need a separate command
> saying that "finished storing the current group of snapshots", which =
should
> stop the dirty tracking.

My goal is to speed up recurrent snapshot restore of short living VMs.
In my use case I create one snapshot, and then I restore it thousands
of times, leaving the VM running for just a few functions execution for
example.
Still, you are right in saying that this is a two steps process.
What I added (not in this patch, but in a downstream fork atm) are a
couple of HMP commands:
- loadvm=5Ffor=5Fhotreaload: in a nutshell it's a loadvm that also star=
ts dirty
tracking
- hotreload: again a loadvm but that takes advantage of the dirty log
to selectively restore only dirty pages

> I'm also curious what is the use case, and I also wonder if "whether =
we
> could avoid memset(0) on a zero page" is anything important here - ma=
ybe
> you could start with simple (which is to always memset() for a zero p=
age
> when a page is dirtied)?

My use case is, you guessed it, fuzz testing aka fuzzing.
About the zeroing, you are right, optimizing it is not a huge concern f=
or
my use case, doing what you say is perfectly fine.

Just to be clear, what I describe above is not the content of this patc=
h.
This patch aims only to make a first step in adding the support for the
mapped-ram feature for savevm/loadvm snapshots, which is a
prerequisite for my hotreload feature.
mapped-ram is currently supported only in (file) migration.
What's missing from this patch to have it working completely, is the
handling of zero pages. Differently from migration, with snapshots page=
s
are not all zero prior to the restore and must therefore be handled.

I hope I summarized in an understandable way, if not I'll be happy to
further clarify :)=20
Thanks for the feedback!
Best
Marco


