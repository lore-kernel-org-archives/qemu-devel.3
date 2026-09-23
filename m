Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD5E9C982EA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 08:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9I0Q-0001eN-4k; Wed, 23 Sep 2026 04:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1x9I0J-0001e2-NK; Wed, 23 Sep 2026 04:07:00 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1x9I0H-0003MB-TP; Wed, 23 Sep 2026 04:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=8Uo8OoWApXCxOVPCtdfdc7CpPV3ybujIue65o8zU/lU=; b=K1lTu42JrPwqz+OV1OQxd5E8H4
 gonkvlR4ZWJ6oVlBU1vFiHg+Dsd4IcgSyXjSSHD+9RdpR2/vM0RtCKi/Aya6ot71KxbLaxIuyg2nT
 6ERR8IBVn+KxN0MOQbS+WgFTLFO53dgMJfE/PJVnwUVeZri6alZBROTNbPGPVrVbK95AtHzWKe/rB
 9ypdbYtuFeem7Hm5sV9kquY9seDV7oYimP9lrVR2mxllFZ/0+uHnnuu8mPQEbNtz7D3crICiX1qlY
 XNcC68+NYzrkMGdXh02JlQZ6TuTj+g/qrneNw6eZL6tejCGfKjdDrPtCfiCqZwKpxcaBdVRZcvrCa
 FSinhsnP8dj1lbmR+8o25kKR/izE7qv50kqs+Pp0mOcOqAeLimAUeQ4v9iiAIibvpzWL6pGmRhKuK
 EP9z06Ms4N7ATldJtj8wq8+ZfuHSV7jinslaeACufxt1f7LxRu9h12Az68QOVh8Oc+/tws4xScMzT
 oGjQrpT2yCxwSeo1qczmGMoKDdM3b+Hf35fefE/+7QesL6HuTqwB3pBr8JuxWpEkHydRyIfnAAp5N
 hLlq1Qn3fATdtbqwJiQSAmRSonpVxZnQ3fGtpZPJvKNUKpjryklwOSty+dn0LhZPMcoya4pr6SWpA
 qEph8/Fz99hk3cXooh8qD6fouPuWoYyOwnBmKC3kQ=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel =?UTF-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH] hw/9pfs: mutate FID path from main thread only
 (CVE-2026-93834)
Date: Wed, 23 Sep 2026 10:06:54 +0200
Message-ID: <6031071.DvuYhMxLoT@weasel>
In-Reply-To: <3717038.iIbC2pHGDl@weasel>
References: <E1x8d3N-003M3F-Pz@kylie.crudebyte.com>
 <arJ0_dq0W1Ah7NV_@redhat.com> <3717038.iIbC2pHGDl@weasel>
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

On Tuesday, 22 September 2026 17:10:58 CEST Christian Schoenebeck wrote:
> On Tuesday, 22 September 2026 14:30:53 CEST Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Sep 22, 2026 at 08:13:01AM +0200, Greg Kurz wrote:
> > > On Mon, 21 Sep 2026 14:18:58 +0200
> > >=20
> > > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > > v9fs_co_open2() is the only code that mutates a FID path from a wor=
ker
> > > > thread: inside its v9fs_co_run_in_worker() block it frees fidp->path
> > > > and copies in the new path under the held FID path write lock.
> > > >=20
> > > > Every other FID path mutation in the 9p codebase happens on the main
> > > > thread, so main thread readers (v9fs_walk(), v9fs_xattrwalk(),
> > > > v9fs_stat(), v9fs_co_name_to_path()) rely on the same (main) thread
> > > > atomicity and don't take the path read lock themselves on main thre=
ad.
> > > >=20
> > > > Fix this by making the worker thread block in v9fs_co_open2()
> > > > read-only
> > > > with respect to the FID: render the new path into the local 'path'
> > > > variable only and copy it to fidp->path after the worker block
> > > > returned
> > > > back to the main thread and still under the held write lock of the
> > > > FID,
> > > > like every other FID path mutation does.
> > > >=20
> > > > Fixes: 02cb7f3a25 ("hw/9pfs: Use read-write lock for protecting fid
> > > > path.")
> > >=20
> > > Wow, it's a long standing issue ! ;-)
> > >=20
> > > > Fixes: CVE-2026-93834
> > >=20
> > > Cannot find it... embargoed ?
> > >=20
> > > > Reported-by: Milad Nasr <https://gitlab.com/sirkhezr>
> > > > Suggested-by: Milad Nasr <https://gitlab.com/sirkhezr>
> > > > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4491
> > >=20
> > > Cannot find that either...
> >=20
> > Initially confidential, so only visible to maintainers with acccounts
> > added to the gitlab project. Bugs should be made public when their
> > patch is posted for review, so I've turned off the confidential flag
> > now.
>=20
> Strange policies. I would have:
>=20
> - Added Greg (reviewer and previous 9p maintainer for years) to the report
> while it was still private. Instead I am the only one getting LLM generat=
ed
> security reports thrown at me.
>=20
> - Considering the severeness of the vulnerability, I would have waited for
> the patch been pushed through stable branches before making the full repo=
rt
> public, or at least until merged on git.

CC-ing Peter Maydell for clarification on these QEMU policies:

Peter, context: this vulnerability was an unprivileged guest user sandbox=20
escape combined with arbitrary code execution on host.

/Christian



