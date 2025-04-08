Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A88C369A2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 15:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2AU5-0004IS-4Z; Tue, 08 Apr 2025 11:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1u2ATz-0004Ge-UP
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 11:03:24 -0400
Received: from smtp.eurecom.fr ([193.55.113.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1u2ATx-0006HH-GE
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 11:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
 t=1744124601; x=1775660601;
 h=from:in-reply-to:references:date:cc:to:mime-version:
 message-id:subject:content-transfer-encoding;
 bh=thBKmdv1p7hMR0r0Sa4QyhwHWEmD1//WB6s2OVwHRs4=;
 b=q6nE/c3cvuIlVukBgr1Inucn2zDt0iYUFFnYxxeV0Xg0a1vjQTAsQC0o
 A/o9sbPmwZaNKM2GdVnCHHSMO5S5DM0NpdVnfVvR2SkWkbSYTkod6ntPj
 VxASre1mEKarpNOjcqqLW0CE+4h58BUgRUkDydDA28UjbVorEdJ8lDZuN w=;
X-CSE-ConnectionGUID: 2TLovCGBTMGTHkbtGDQZWg==
X-CSE-MsgGUID: U8sWdCa8TeyhMxAivCd2qA==
X-IronPort-AV: E=Sophos;i="6.15,198,1739833200"; 
   d="scan'208";a="748353"
Received: from quovadis.eurecom.fr ([10.3.2.233])
 by drago1i.eurecom.fr with ESMTP; 08 Apr 2025 17:03:16 +0200
From: "Marco Cavenati" <Marco.Cavenati@eurecom.fr>
In-Reply-To: <CAE8KmOyL_HJ6p2AZPedYbiDpeNH2LKj+wodF-nX3OgcH8Aq4jA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 193.55.114.5
References: <20250327141451.163744-3-Marco.Cavenati@eurecom.fr>
 <CAE8KmOzbtMwwTF662e_xo77EQ-nK-QOcqYDfmirkX-m8faAcxQ@mail.gmail.com>
 <5ed-67efa080-44f-38bc9540@144005994>
 <CAE8KmOzz2cyHimBXcs79wOOzg2KyKwmSNSXbkJomhGdhwWfKBg@mail.gmail.com>
 <5ef-67efcb00-537-1a6bb1a0@222476586>
 <CAE8KmOyBjkFhc-pa-m897S2h+G=vRgkDf69595K9NvogT_oKRw@mail.gmail.com>
 <4c8ae-67f39480-20b-1b3425c0@158944275>
 <CAE8KmOyL_HJ6p2AZPedYbiDpeNH2LKj+wodF-nX3OgcH8Aq4jA@mail.gmail.com>
Date: Tue, 08 Apr 2025 17:03:15 +0200
Cc: "Peter Xu" <peterx@redhat.com>, "Fabiano Rosas" <farosas@suse.de>,
 qemu-devel@nongnu.org
To: "Prasad Pandit" <ppandit@redhat.com>
MIME-Version: 1.0
Message-ID: <483a7-67f53a80-989-1b9677a0@18488120>
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
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tuesday, April 08, 2025 07:25 CEST, Prasad Pandit <ppandit@redhat.co=
m> wrote:

> *  =5Fchannel=5Fpreadv/=5Fwritev functions are generic. They are inde=
pendent
> of whether the underlying channel is file or socket or memory or
> something else. They are called if and when they are defined and they
> in turn call channel specific preadv/pwritev functions.
>=20
>         if (!klass->io=5Fpwritev) {
>             error=5Fsetg(errp, "Channel does not support pwritev");
>             return -1;
>         }

They also require QIO=5FCHANNEL=5FFEATURE=5FSEEKABLE.
    if (!qio=5Fchannel=5Fhas=5Ffeature(ioc, QIO=5FCHANNEL=5FFEATURE=5FS=
EEKABLE)) {
        error=5Fsetg=5Ferrno(errp, EINVAL, "Requested channel is not se=
ekable");
        return -1;
    }

> * io: add and implement QIO=5FCHANNEL=5FFEATURE=5FSEEKABLE for channe=
l file
>     -> https://gitlab.com/qemu-project/qemu/-/commit/401e311ff72e0a62=
c834bfe466de68a82cfd90cb
>=20
>    This commit sets the *=5FFEATURE=5FSEEKABLE flag for the file chan=
nel
> when the lseek(2) call succeeds.

The QIOChannelBlock io=5Fseek (qio=5Fchannel=5Fblock=5Fseek) function
cannot fail for SEEK=5FCUR, no need to check.

> * ie. 'file' OR 'fd' channel is seekable when lseek(2) call works.
> Similarly Block channel would be seekable when ->io=5Fseek() method i=
s
> defined and it works. And ->io=5Fseek() method is also called if and
> when it is defined
>=20
>     qio=5Fchannel=5Fio=5Fseek
>         if (!klass->io=5Fseek) {
>             error=5Fsetg(errp, "Channel does not support random
> access");
>             return -1;
>         }
>
>   Setting  '*=5FFEATURE=5FSEEKABLE' for the block channel does not en=
sure
> that ->io=5Fseek() is defined and works.

QIOChannelBlock io=5Fseek is always implemented and works
(except for SEEK=5FEND).
=20
> It seems redundant that way.

I'm not sure I understand what you mean here.

TLDR: QIOChannelBlock is already always seekable, this patch just adds
the capability explicitly so that it will work with mapped-ram.

Best
Marco


