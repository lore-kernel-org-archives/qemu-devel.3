Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4C0C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 21:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDV3Q-0002bt-TI; Fri, 09 May 2025 17:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1uDV3O-0002ZJ-Oe
 for qemu-devel@nongnu.org; Fri, 09 May 2025 17:14:46 -0400
Received: from smtp.eurecom.fr ([193.55.113.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1uDV3M-0003iU-GE
 for qemu-devel@nongnu.org; Fri, 09 May 2025 17:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
 t=1746825284; x=1778361284;
 h=from:in-reply-to:references:date:cc:to:mime-version:
 message-id:subject:content-transfer-encoding;
 bh=iQqRefYE6NZz7OjOZAjgKaOjIhd4yg593OcmbVd26KM=;
 b=XZTfWvtuOAGwvscmt/t2VXkIh66DQg/1OnP6ppYCc944NDF9CGkH5QZS
 WyOXKkP97n/Pek6ldE/IaP5z0msoZmuqN3nrOc0p9fXH+bmDHQ0vEYVi2
 15pW3AdIsjxWe9Trdkq/BoPQefd56bqDLXaCCGER8F2A/dMIBkDz5Gd44 U=;
X-CSE-ConnectionGUID: GrPdYT9+Ql2Tkp4jYLOhGA==
X-CSE-MsgGUID: 3wUeaCccRDW/rfQyuCGF9Q==
X-IronPort-AV: E=Sophos;i="6.15,276,1739833200"; 
   d="scan'208";a="1247564"
Received: from quovadis.eurecom.fr ([10.3.2.233])
 by drago1i.eurecom.fr with ESMTP; 09 May 2025 23:14:41 +0200
From: "Marco Cavenati" <Marco.Cavenati@eurecom.fr>
In-Reply-To: <aB4rhlVGCSk7IwoE@x1.local>
Content-Type: text/plain; charset="utf-8"
X-Forward: 80.215.234.36
References: <87jz7rhjzq.fsf@suse.de> <4caa0-67f8d780-a89-60718600@156698708>
 <87ecxyhon3.fsf@suse.de> <7cd3c-67fe3180-3d9-10622a60@195384178>
 <87plhdfs9o.fsf@suse.de> <7cd3c-6800c580-4b5-10622a60@195456151>
 <871ptqg6u9.fsf@suse.de> <151d8c-680a4080-15-6f9ea10@196998929>
 <aB0Swile4IjxTUsd@x1.local>
 <193e5a-681dfa80-3af-701c0f80@227192887> <aB4rhlVGCSk7IwoE@x1.local>
Date: Fri, 09 May 2025 23:14:41 +0200
Cc: "Fabiano Rosas" <farosas@suse.de>, qemu-devel@nongnu.org,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Prasad Pandit" <ppandit@redhat.com>
To: "Peter Xu" <peterx@redhat.com>
MIME-Version: 1.0
Message-ID: <1b54a0-681e7080-273-3299e580@146025174>
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

On Friday, May 09, 2025 18:21 CEST, Peter Xu <peterx@redhat.com> wrote:
=20
> So you don't really need to take sequence of snapshots?  Hmm, that so=
unds
> like a completely different use case that I originally thought.

Correct

> Have you thought of leveraging ignore-shared and MAP=5FPRIVATE for th=
e major
> chunk of guest mem?
>=20
> Let me explain; it's a very rough idea, but maybe you can collect som=
ething
> useful.
>=20
> So.. if you keep reloading one VM state thousands of times, it's bett=
er
> first that you have some shmem file (let's imagine that's enough.. yo=
u
> could have more backends) keeping the major chunk of the VM RAM image=
 that
> you migrated before into a file.
>=20
> Say, the major part of guest mem is stored here:
>=20
>   PATH=5FRAM=3D/dev/shm/XXX
>=20
> Then you migrate (with ignore-shared=3Don) to a file here (NOTE: I =5F=
think=5F
> you really can use file migration in this case with VM stopped first,=
 not
> snapshot save/load):
>=20
>   PATH=5FVM=5FIMAGE=3D/tmp/VM=5FIMAGE=5FYYY
>=20
> Then, the two files above should contain all info you need to start a=
 new
> VM.
>=20
> When you want to recover that VM state, boot a VM using this cmdline:
>=20
>   $qemu ... \
>   -object memory-backend-file,mem-path=3D$PATH=5FRAM,share=3Doff
>   -incoming file:$PATH=5FVM=5FIMAGE
>=20
> That'll boot a VM, directly loading the shmem page cache (always pres=
ent on
> the host, occupying RAM, though, outside of VM lifecycle, but it's pa=
rt of
> the design..), loading VM image would be lightning fast because it's =
tiny
> when there's almost no RAM inside.  No concern on mapped-ram at all a=
s the
> rest RAMs are too trivial to just be a stream.
>=20
> The important bit is share=3Doff - that will mmap() the VM major RAM =
as
> MAP=5FPRIVATE, then it'll do CoW on the "snapshot" you made before, w=
henever
> you writes to some guest pages during fuzzing some functions, it copi=
es the
> shmem page cache over.  shmem page cache should never change its cont=
ent.
>=20
> Sounds working to you?

I didn't know much about these options, cool, thanks for the explanatio=
n.

My only concern is that I'd have to restart the QEMU process for each i=
teration.
Honestly I've never measured the impact it would have but I fear that i=
t would=20
be noticeable since the goal is to restore many times a second. What do=
 you
think?
(Also, snapshots conveniently take care of the disk as well, but this s=
houldn't=20
be too big of a deal.)

Thanks,
Best
Marco


