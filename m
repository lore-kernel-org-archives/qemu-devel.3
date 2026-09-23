Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD2EC982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 09:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9IqG-0000jM-DT; Wed, 23 Sep 2026 05:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1x9IqD-0000ij-EO; Wed, 23 Sep 2026 05:00:38 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1x9IqB-0000W8-Bg; Wed, 23 Sep 2026 05:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=xYFsXi069Yv/Ze46WIeJeEAMCSzOw0rZ09nJMSKr2F0=; b=eYgXX7Zcs/oYJxvNZ5qtB6ffmz
 XtPkwhFwWrDp2ozbPfb6mfu99rTiPXOrO+3SJbSgskUS2jEWEzzAkXdSkvFn30LFOv4NWLOpq8WAw
 P28tc/EpN7bIA/KsC3DezNurmOO2qkHv8egAmrWejMPXxQYXKUARKr22JGRlgEXmIdqHj//fJABNP
 6Jf/nWieEE5SKIPhAO1dLAGa+6Pz+nhAV2ny4mSDNt3dqc1w+Ng9g6k0I2EE+R0+cZxbFmgddCkmF
 xFIrhaIaGJ81WghZY0keikA58UW+I3NPVXAQmTK9W/WiszoOpmuplhuMGj25uZfH6INkwvtkOWND2
 ML41VFFM0QPFFeT/8nzmWg16jkagL1dRVT2Os1HiEJM/WAwr5+SRUb/nMFFmXT2ZMZ/V+NVM/zBnz
 O3omgJqyDflql0Uo/3btluGOiqPQMggP72CmpQAaXty9I2PTWG5BRwAeD2GE/aih0tzeSqJNSzEtq
 Dtr5m5D/xkEEfanmxdCE2qfx/0Z/8DXAMR/JhydSLNwJkiTp1U3+eJwIagxmax/Yq3PC7AhVt6bNX
 iqljoBB95/0mPD3icKqyAj7CfficGocXURVAch2FhCNJYlRX2lxPoFjDchdgDc7zjxh5KGrN0q26Z
 AiAA/e5bddybPshGbwcI0u7qnBtzoojPmZLVkBpH0=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>, qemu-stable@nongnu.org,
 Daniel =?UTF-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH] hw/9pfs: mutate FID path from main thread only
 (CVE-2026-93834)
Date: Wed, 23 Sep 2026 11:00:24 +0200
Message-ID: <2051859.PYKUYFuaPT@weasel>
In-Reply-To: <arOKiMszxR-k_7AS@redhat.com>
References: <E1x8d3N-003M3F-Pz@kylie.crudebyte.com> <3717038.iIbC2pHGDl@weasel>
 <arOKiMszxR-k_7AS@redhat.com>
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

On Wednesday, 23 September 2026 10:15:04 CEST Daniel P. Berrang=C3=A9 wrote:
> On Tue, Sep 22, 2026 at 05:10:58PM +0200, Christian Schoenebeck wrote:
> > On Tuesday, 22 September 2026 14:30:53 CEST Daniel P. Berrang=C3=A9 wro=
te:
> > > On Tue, Sep 22, 2026 at 08:13:01AM +0200, Greg Kurz wrote:
> > > > On Mon, 21 Sep 2026 14:18:58 +0200
> > > >=20
> > > > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > > > v9fs_co_open2() is the only code that mutates a FID path from a
> > > > > worker
> > > > > thread: inside its v9fs_co_run_in_worker() block it frees fidp->p=
ath
> > > > > and copies in the new path under the held FID path write lock.
> > > > >=20
> > > > > Every other FID path mutation in the 9p codebase happens on the m=
ain
> > > > > thread, so main thread readers (v9fs_walk(), v9fs_xattrwalk(),
> > > > > v9fs_stat(), v9fs_co_name_to_path()) rely on the same (main) thre=
ad
> > > > > atomicity and don't take the path read lock themselves on main
> > > > > thread.
> > > > >=20
> > > > > Fix this by making the worker thread block in v9fs_co_open2()
> > > > > read-only
> > > > > with respect to the FID: render the new path into the local 'path'
> > > > > variable only and copy it to fidp->path after the worker block
> > > > > returned
> > > > > back to the main thread and still under the held write lock of the
> > > > > FID,
> > > > > like every other FID path mutation does.
> > > > >=20
> > > > > Fixes: 02cb7f3a25 ("hw/9pfs: Use read-write lock for protecting f=
id
> > > > > path.")
> > > >=20
> > > > Wow, it's a long standing issue ! ;-)
> > > >=20
> > > > > Fixes: CVE-2026-93834
> > > >=20
> > > > Cannot find it... embargoed ?
> > > >=20
> > > > > Reported-by: Milad Nasr <https://gitlab.com/sirkhezr>
> > > > > Suggested-by: Milad Nasr <https://gitlab.com/sirkhezr>
> > > > > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4491
> > > >=20
> > > > Cannot find that either...
> > >=20
> > > Initially confidential, so only visible to maintainers with acccounts
> > > added to the gitlab project. Bugs should be made public when their
> > > patch is posted for review, so I've turned off the confidential flag
> > > now.
> >=20
> > Strange policies. I would have:
> >=20
> > - Added Greg (reviewer and previous 9p maintainer for years) to the rep=
ort
> > while it was still private. Instead I am the only one getting LLM
> > generated
> > security reports thrown at me.
>=20
> While we primarily only intend to add people in the MAINTAINERS file
> to the gitlab project, given Greg's long term involvement in QEMU I
> see no problem with adding him as a member in gitlab, which would
> allow for viewing all confidential bugs.
>=20
> Greg, just ask one of the project owners listed:
>=20
>   https://gitlab.com/qemu-project/qemu/-/project_members?max_role=3Dstati=
c-50
>=20
> to add your gitlab account
>=20
> > - Considering the severeness of the vulnerability, I would have waited =
for
> > the patch been pushed through stable branches before making the full
> > report public, or at least until merged on git.
>=20
> Once a patch is posted on the public mailing list, we consider the
> flaw to be public. Both the code and patch description provide
> sufficient info about the flaw that keeping the bug private is a
> false sense of protection. So it is documented that the confidential
> flag is to be removed when posting to qemu-devel:
>=20
>    https://www.qemu.org/contribute/security-process/
>=20
> If a maintainer really wants additional code review before a bug is
> made public, then best to do that via private email, or the issue
> tracker, as best fits the situation.

1. I explicitly *asked* on the private security report how to proceed and=20
emphasized the question under the circumstance of its severeness, and was t=
old=20
to send the patch to public qemu-devel.

2. The patch alone neither exposes the severeness class, nor how to exploit=
=2E=20
Making the security report public OTOH provides anybody a turn-key solution=
=20
for existing production distributions, before these distros had any chance =
to=20
patch.

3. It is not trivial to generate a working exploit from the patch alone, as=
 it=20
requires deep understanding of the target system's memory layout to constru=
ct=20
a working exploit. Many LLMS probably fail on that task. Would be interesti=
ng=20
to know from Milad Nasr how long the (supposedly frontier) LLM took to=20
construct the working exploits, but I guess it still took a while.

4. Current embargo policy says:

"Thus the QEMU maintainers will generally reject requests for arbitrary=20
embargoes unless high severity, extenuating circumstances can be=20
demonstrated."

=2D> It *was* high severity.

5. This rather relaxed handling, does not match with the very strict policy=
=20
OTOTH of denying official reviewers access to private security reports.

/Christian





