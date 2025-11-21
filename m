Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85AECFC504
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd5W-0003VF-BA; Fri, 21 Nov 2025 21:10:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1vMcrY-00069h-Gs; Fri, 21 Nov 2025 20:56:32 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1vMcph-0006qV-Cw; Fri, 21 Nov 2025 20:56:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=xZBmjOGSZoa+2aL5x4woIrYjfLg3sU220QEFMHUTJpM=; b=hlMINAeetPLPFGP9
 DCXVzhiePadQthcnxsCXyVmnW6VwsN1f99YyTIMGXBLFzlLAwQCCfRhohhA8JHQw9WopgvmlZSNe9
 ChraoHtEO7/JtJnq3fVoHZSpK0yD4PJlxvZ3fXI/CMaLqwdygqlojLOxzQicqgvH6rEKIaYV5q+dC
 9fF4budUObNUXPneqDI13Oa2zg4oAEkUQwrwYAbtWiuXFycihblAtcYwuw9rIQQxGhcvtCahj4M19
 h+hB/OQXLls/7hLaOzXx6U9CGb2mAaDDOK7VGfvA3Pz2jzo1yj5RRGthzOR1lOLnIa/nKutnvrU+1
 aFYpkjxx4ViSutOaLw==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vMVCi-00000005pJs-2dXP;
 Fri, 21 Nov 2025 17:45:52 +0000
Date: Fri, 21 Nov 2025 17:45:52 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com, pizhenwei@bytedance.com,
 alistair.francis@wdc.com, stefanb@linux.vnet.ibm.com,
 kwolf@redhat.com, hreitz@redhat.com, sw@weilnetz.de,
 qemu_oss@crudebyte.com, groug@kaod.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, kraxel@redhat.com,
 shentey@gmail.com, npiggin@gmail.com, harshpb@linux.ibm.com,
 sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 edgar.iglesias@gmail.com, elena.ufimtseva@oracle.com,
 jag.raman@oracle.com, sgarzare@redhat.com, pbonzini@redhat.com,
 fam@euphon.net, philmd@linaro.org, alex@shazbot.org, clg@redhat.com,
 peterx@redhat.com, farosas@suse.de, lizhijian@fujitsu.com,
 jasowang@redhat.com, samuel.thibault@ens-lyon.org,
 michael.roth@amd.com, kkostiuk@redhat.com, zhao1.liu@intel.com,
 mtosatti@redhat.com, rathc@linux.ibm.com, palmer@dabbelt.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, marcandre.lureau@redhat.com,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org
Subject: Re: [PATCH 09/14] error: Use error_setg_file_open() for simplicity
 and consistency
Message-ID: <aSClUIvI2W-PVv6B@gallifrey>
References: <20251120191339.756429-1-armbru@redhat.com>
 <20251120191339.756429-10-armbru@redhat.com>
 <aR-q2YeegIEPmk2R@gallifrey> <87see8q6qm.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87see8q6qm.fsf@pond.sub.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 17:44:26 up 25 days, 17:20,  2 users,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

* Markus Armbruster (armbru@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dave@treblig.org> writes:
>=20
> > * Markus Armbruster (armbru@redhat.com) wrote:
> >> Replace
> >>=20
> >>     error_setg_errno(errp, errno, MSG, FNAME);
> >>=20
> >> by
> >>=20
> >>     error_setg_file_open(errp, errno, FNAME);
> >>=20
> >> where MSG is "Could not open '%s'" or similar.
> >>=20
> >> Also replace equivalent uses of error_setg().
> >>=20
> >> A few messages lose prefixes ("net dump: ", "SEV: ", __func__ ": ").
> >> We could put them back with error_prepend().  Not worth the bother.
> >
> > Yeh, I guess you could just do it with another macro using
> > the same internal function just with string concatenation.
>=20
> I'm no fan of such prefixes.  A sign of developers not caring enough to
> craft a good error message for *users*.  *Especially* in the case of
> __func__.
>=20
> The error messages changes in question are:
>=20
>     net dump: can't open DUMP-FILE: REASON
>     Could not open 'DUMP-FILE': REASON
>=20
>     SEV: Failed to open SEV-DEVICE: REASON
>     Could not open 'SEV-DEVICE': REASON
>=20
>     sev_common_kvm_init: Failed to open SEV_DEVICE 'REASON'
>     Could not open 'SEV-DEVICE': REASON
>=20
> I think these are all improvements, and the loss of the prefix is fine.

Yeh, although I find the error messages aren't just for users;
they're often for the first dev to see it to guess which other
dev to pass the problem to, so a hint about where it's coming
=66rom can be useful.

Dave

> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >
> > Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
>=20
> Thanks!
>=20
--=20
 -----Open up your eyes, open up your mind, open up your code -------  =20
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \=20
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

