Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99AE5CA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 15:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0ipn-0001Ql-V8; Mon, 22 Sep 2025 11:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1v0ipl-0001Pt-KA
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:52:09 -0400
Received: from smtp.eurecom.fr ([193.55.113.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1v0ipi-00044d-0q
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
 t=1758556326; x=1790092326;
 h=from:in-reply-to:references:date:cc:to:mime-version:
 message-id:subject:content-transfer-encoding;
 bh=2jQKoC/cXkUqCV0Snl4xPrpe8OBeLSvH3bPTs/mEWWs=;
 b=S9nteqAMboTew64pkmfQjFg/K6fc2YOAOMFBQ85KpYq0FufCDnho3JfP
 xR7im+kIcBcY6YkscTaZuDf3NY20kkDaHFi3R15o79hw5rrxMK4WV1EZc
 7P/gF2En7zNRSy/cBXGtBmrRpVZrjXL/PZD6AtxBiI+zLAVtfgzStZhZs k=;
X-CSE-ConnectionGUID: SLKK5wELT0iC0ewnd6gSCQ==
X-CSE-MsgGUID: VfkAZIi+TSe3icbmAfyD8g==
X-IronPort-AV: E=Sophos;i="6.18,285,1751234400"; 
   d="scan'208";a="3006408"
Received: from quovadis.eurecom.fr ([10.3.2.233])
 by drago1i.eurecom.fr with ESMTP; 22 Sep 2025 17:51:58 +0200
From: "Marco Cavenati" <Marco.Cavenati@eurecom.fr>
In-Reply-To: <87ecs2t9sv.fsf@suse.de>
Content-Type: text/plain; charset="utf-8"
X-Forward: 193.55.114.5
References: <20250327141451.163744-3-Marco.Cavenati@eurecom.fr>
 <87jz7rhjzq.fsf@suse.de> <1b7bdf-68c98b00-641-3c30b780@162059662>
 <87ecs2t9sv.fsf@suse.de>
Date: Mon, 22 Sep 2025 17:51:58 +0200
Cc: "Peter Xu" <peterx@redhat.com>, qemu-devel@nongnu.org,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Prasad Pandit" <ppandit@redhat.com>
To: "Fabiano Rosas" <farosas@suse.de>
MIME-Version: 1.0
Message-ID: <1b7bdf-68d17080-aab-3c30b780@82293076>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?migration=3A?= add  
 =?utf-8?q?FEATURE=5FSEEKABLE?= to QIOChannelBlock
User-Agent: SOGoMail 5.12.1
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

On Friday, September 19, 2025 23:24 CEST, Fabiano Rosas <farosas@suse.d=
e> wrote:

> "Marco Cavenati" <Marco.Cavenati@eurecom.fr> writes:
>=20
> > Hello Fabiano,
> >
> > On Thursday, April 10, 2025 21:52 CEST, Fabiano Rosas <farosas@suse=
.de> wrote:
> >
> >> Marco Cavenati <Marco.Cavenati@eurecom.fr> writes:
> >>=20
> >> > Enable the use of the mapped-ram migration feature with savevm/l=
oadvm
> >> > snapshots by adding the QIO=5FCHANNEL=5FFEATURE=5FSEEKABLE featu=
re to
> >> > QIOChannelBlock. Implement io=5Fpreadv and io=5Fpwritev methods =
to provide
> >> > positioned I/O capabilities that don't modify the channel's posi=
tion
> >> > pointer.
> >>=20
> >> We'll need to add the infrastructure to reject multifd and direct-=
io
> >> before this. The rest of the capabilities should not affect mapped=
-ram,
> >> so it's fine (for now) if we don't honor them.
> >
> > Do you have any status update on this infrastructure you mentioned?
> >
>=20
> I'm doing the work suggested by Daniel of passing migration
> configuration options via the commands themselves. When that is ready=
 we
> can include savevm and have it only accept mapped-ram and clear all
> other options.
>=20
> But don't worry about that, propose your changes and I'll make sure t=
o
> have *something* ready before it merges. I don't see an issue with
> merging this single patch, for instance:
> https://lore.kernel.org/r/20250327143934.7935-2-farosas@suse.de

Perfect!

> >> What about zero page handling? Mapped-ram doesn't send zero pages
> >> because the file will always have zeroes in it and the migration
> >> destination is guaranteed to not have been running previously. I b=
elieve
> >> loading a snapshot in a VM that's already been running would leave=
 stale
> >> data in the guest's memory.
> >
> > About the zero handling I'd like to hear your opinion about this id=
ea I
> > proposed a while back:
> > The scenarios where zeroing is not required (incoming migration and
> > -loadvm) share a common characteristic: the VM has not yet run in t=
he
> > current QEMU process.
> > To avoid splitting read=5Framblock=5Fmapped=5Fram(), could we imple=
ment
> > a check to determine if the VM has ever run and decide whether to z=
ero
> > the memory based on that? Maybe using RunState?
> >
>=20
> We could just as well add some flag to load=5Fsnapshot() since we kno=
w
> which invocations are guaranteed to happen with clean memory.
>=20
> But if you can use existing code for that it would be great. Adding a
> global guest=5Fhas=5Fever=5Frun flag, not so much. What's the Machine=
InitPhase
> before -loadvm?

MachineInitPhase is set to PHASE=5FMACHINE=5FREADY during ram=5Fload() =
for
both -loadvm and HMP loadvm, so unfortunately that isn=E2=80=99t an opt=
ion.

RunState during ram=5Fload() is
- RUN=5FSTATE=5FINMIGRATE for -incoming,
- RUN=5FSTATE=5FPRELAUNCH for -loadvm
- RUN=5FSTATE=5FRESTORE=5FVM for HMP loadvm.
But I=E2=80=99m not sure how reliable (or unreliable) it would be to de=
pend on this
to infer that RAM is zero.

As for using a flag, I don=E2=80=99t see an obvious way to pass one dow=
n through
load=5Fsnapshot -> qemu=5Floadvm=5Fstate -> ... -> read=5Framblock=5Fma=
pped=5Fram.
Do you already have something in mind?

Thank you
Marco


