Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F9CEA3C5D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 13:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAp7d-0000ov-2T; Thu, 09 Apr 2026 09:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.gruenbichler@proxmox.com>)
 id 1wAp7T-0000oU-4o
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 09:08:28 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.gruenbichler@proxmox.com>)
 id 1wAp7Q-0003QC-48
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 09:08:26 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id E86F2E09D4;
 Thu, 09 Apr 2026 15:08:11 +0200 (CEST)
Date: Thu, 09 Apr 2026 15:08:07 +0200
From: Fabian =?iso-8859-1?q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>
Subject: Re: [PATCH 0/2] migration: include timing and RAM stats on
 destination when query-migrate
To: Claudio Fontana <cfontana@suse.de>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>
Cc: "Daniel P." =?iso-8859-1?q?Berrang=E9?= <berrange@redhat.com>, Jim Fehlig
 <jfehlig@suse.com>, qemu-devel@nongnu.org,
 Trieu Huynh <vikingtc4@gmail.com>, Fiona Ebner <f.ebner@proxmox.com>
References: <20260405152612.93027-1-viking4@gmail.com>
 <878qb05gq7.fsf@suse.de> <ada038hgmY9hNqPK@x1.local>
 <5f29c2dd-95eb-44c6-b22e-1909f7453cdf@suse.de>
In-Reply-To: <5f29c2dd-95eb-44c6-b22e-1909f7453cdf@suse.de>
MIME-Version: 1.0
User-Agent: astroid/0.17.0 (https://github.com/astroidmail/astroid)
Message-Id: <1775739757.quazquvuzm.astroid@yuna.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1775740022430
Received-SPF: pass client-ip=94.136.29.106;
 envelope-from=f.gruenbichler@proxmox.com; helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

On April 9, 2026 12:08 pm, Claudio Fontana wrote:
> On 4/8/26 22:04, Peter Xu wrote:
>> On Mon, Apr 06, 2026 at 11:02:56AM -0300, Fabiano Rosas wrote:
>>> Trieu Huynh <vikingtc4@gmail.com> writes:
>>>
>>>> From: Trieu Huynh <vikingtc4@gmail.com>
>>>>
>>>> When query-migrate is called on the *destination* QEMU after a precopy
>>>> migration completes it returns only {"status": "completed"} =E2=80=94 =
no timing,
>>>> no RAM statistics.  The source correctly returns total-time, downtime,
>>>> setup-time, and full ram stats.

>>>> [..]
>>>>
>>>
>>> Hi, remember to copy the interested people in your series. Using
>>> get_maintainers is correct, but when there's already a discussion about
>>> the topic it's good to add some CCs manually.
>>>
>>> +CC Daniel and Claudio
>>=20
>> The request is a valid one.  Said that, redo accounting on both sides se=
em
>> to be a duplicated work and overkill to me, if src has everything.
>>=20
>> Is there a way we can make Libvirt always query the results before src d=
ies
>> and report it somewhere?  I recall these info were captured somewhere, d=
o
>> we at least dump them into logs?
>>=20
>> Thanks,
>>=20
>=20
> I am interested in the outcome, but I think the approach shown here is fi=
ne, the amount of duplication seems minimal to me.
>=20
> That said if we _have_ to keep libvirt in the picture, I think I see a po=
ssible alternative, but then the feature is not available to anyone that do=
es not use libvirt. At the same time, if libvirt is not used, one is free t=
o keep source QEMU alive and query the stats, like I think Proxmox does.

that is correct, we call query-migrate in a loop while migrating both to
log progress and to manage migration parameters, and manually switch
execution and ownership over to the target node once the migration has
converged:

https://git.proxmox.com/?p=3Dqemu-server.git;a=3Dblob;f=3Dsrc/PVE/QemuMigra=
te.pm;h=3Df7ec322770a47dcc8b89109ecfa6f15ea140f30f;hb=3DHEAD#l1423

> So with libvirt, I think we need a way to tell libvirt to keep the source=
 QEMU alive before the actual switchover and the source QEMU is destroyed,
> so that we can do everything that needs to be done from the platform laye=
r before the source QEMU is lost.
> It might go beyond querying for stats using QEMU and libvirt.
>=20
> Something similar to (and potentially combined with) virDomainMigrateFlag=
s VIR_MIGRATE_PAUSE, for example:
>=20
> VIR_MIGRATE_NO_SOURCE_SHUTOFF
>=20
> So one might say:
>=20
> flags =3D VIR_MIGRATE_LIVE | VIR_MIGRATE_PERSIST_DEST | VIR_MIGRATE_UNDEF=
INE_SOURCE | VIR_MIGRATE_PAUSE | VIR_MIGRATE_NO_SOURCE_SHUTOFF
> new_domain =3D virDomainMigrate3(old_domain, conn, params, nparams, flags=
)
>=20
> and then we could do everything that needs to be done from the platform l=
ayer,
> then issue a virDomainResume to start the domain on destination,
> and maybe a virDomainDestroyFlags on the original domain to terminate it =
on the source.
>=20
> But I would still favor the simplicity and the overall applicability of t=
his series from Trieu Huynh.
>=20
> Thanks,
>=20
> Claudio
>=20
>=20
>=20


