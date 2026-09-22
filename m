Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5669CC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 15:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9299-00013K-JN; Tue, 22 Sep 2026 11:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1x9298-000135-Ho; Tue, 22 Sep 2026 11:11:02 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1x9296-0000xp-V5; Tue, 22 Sep 2026 11:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=VS1pYh26Ucsso/Fh7CZSSGHyw504gytKGzzopyqGhM4=; b=buoX4O2GA6eG0V5/Jnfb8zz4XO
 eUC5G3nqX42ofAEzuBW25WaS5Fbcea0vwmNkcvKX8DdEPHRE2FwvAJrzL8wsZUBfDxbtbAm8D+G+m
 SIKNtl1Yv4bQeLnOfZGyEKQvWTn9CTPnhkj6O3Wu1FdsY9LFve8aohSZLxQFD79V77eEfYJTM2nWF
 jKBVKH7bHFYl4ia1K6mFgJZwObIFV+1NQafmMJOQbsBooy0aKnNx6E5prP+nLT9TygDdX6619mOZM
 0Hkdw3CJRUjtScHPSlwNaQSiI9rYA3aWYKeSDIYFIEjGK4HOe+0qGitTWJDwaBMTocs51sBG1fjk+
 rgaWYBdoOuq5GP8tXuaiFdpKTq0A4yICW5VpH12B291p6LF/xsnJ3/UwyOrzvYLvvu5xsaB0Rb1Ym
 OTgp6Dqp6pzquu4/gW8GD1ORcnj+zoaDNU3XRYi1Np/nWoXJrx4Mc4WRSx0X942dpZIFqJoPjO0Qe
 fGtzfyk6UaCtchriGq2fh6s8wuaHJ8RvKBa8S+8SRwYZuqFQLKTQ/uetT9grF+7yKuiiZG/b2Lzch
 uyw/edtNNe566ID3Hw6nHH1Q+vRwFOiwtFvUvMmTA7GACwHB8C+uoANEqby7SSWAvkFpISGBiy0WT
 HdN3kGAW1IhTo82s9NVmWPeHldM6K4td2w8agfNeM=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Daniel =?UTF-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH] hw/9pfs: mutate FID path from main thread only
 (CVE-2026-93834)
Date: Tue, 22 Sep 2026 17:10:58 +0200
Message-ID: <3717038.iIbC2pHGDl@weasel>
In-Reply-To: <arJ0_dq0W1Ah7NV_@redhat.com>
References: <E1x8d3N-003M3F-Pz@kylie.crudebyte.com>
 <20260922081301.244e5524@bahia> <arJ0_dq0W1Ah7NV_@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tuesday, 22 September 2026 14:30:53 CEST Daniel P. Berrang=C3=A9 wrote:
> On Tue, Sep 22, 2026 at 08:13:01AM +0200, Greg Kurz wrote:
> > On Mon, 21 Sep 2026 14:18:58 +0200
> >=20
> > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > v9fs_co_open2() is the only code that mutates a FID path from a worker
> > > thread: inside its v9fs_co_run_in_worker() block it frees fidp->path
> > > and copies in the new path under the held FID path write lock.
> > >=20
> > > Every other FID path mutation in the 9p codebase happens on the main
> > > thread, so main thread readers (v9fs_walk(), v9fs_xattrwalk(),
> > > v9fs_stat(), v9fs_co_name_to_path()) rely on the same (main) thread
> > > atomicity and don't take the path read lock themselves on main thread.
> > >=20
> > > Fix this by making the worker thread block in v9fs_co_open2() read-on=
ly
> > > with respect to the FID: render the new path into the local 'path'
> > > variable only and copy it to fidp->path after the worker block return=
ed
> > > back to the main thread and still under the held write lock of the FI=
D,
> > > like every other FID path mutation does.
> > >=20
> > > Fixes: 02cb7f3a25 ("hw/9pfs: Use read-write lock for protecting fid
> > > path.")
> >=20
> > Wow, it's a long standing issue ! ;-)
> >=20
> > > Fixes: CVE-2026-93834
> >=20
> > Cannot find it... embargoed ?
> >=20
> > > Reported-by: Milad Nasr <https://gitlab.com/sirkhezr>
> > > Suggested-by: Milad Nasr <https://gitlab.com/sirkhezr>
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4491
> >=20
> > Cannot find that either...
>=20
> Initially confidential, so only visible to maintainers with acccounts
> added to the gitlab project. Bugs should be made public when their
> patch is posted for review, so I've turned off the confidential flag
> now.

Strange policies. I would have:

=2D Added Greg (reviewer and previous 9p maintainer for years) to the repor=
t=20
while it was still private. Instead I am the only one getting LLM generated=
=20
security reports thrown at me.

=2D Considering the severeness of the vulnerability, I would have waited fo=
r the=20
patch been pushed through stable branches before making the full report=20
public, or at least until merged on git.

/Christian



