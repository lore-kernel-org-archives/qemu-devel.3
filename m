Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E466DCD6E43
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvm8-00027n-Sp; Fri, 29 May 2026 07:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1wSvm5-00027Z-W3; Fri, 29 May 2026 07:53:14 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1wSvm4-0000vN-1Z; Fri, 29 May 2026 07:53:13 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D1F7340403;
 Fri, 29 May 2026 11:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73481F00893;
 Fri, 29 May 2026 11:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780055589;
 bh=vph/IA+xak26xLPAwzzNA1eKOZZHpZ7wKRfzzNO7HiM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=lKy5z1xCCDYdNLy+6GWw5Atl5sNO7OialJgik3eOfmeP3DK/HJc4tOkI5/tpKBnul
 X5+LV5SG4xvfhbf7FkVWt4judJ3kH72IcyK15flYOGdhTFHmR03NS7bT01Xw9vwviY
 fblo+DZIHDbUW32/DWAgaq665A0ajbm1aE9x39S+PVw06Gz2cFHHY6J/0UeO7oyED/
 njCcflRtPoucWHCyc/wIVAoKERSGxXdJvjZQVs/M4m12c5iXTlNhip4bOjZqIU/izv
 dgmDpUg1ym8bXFpxB3oJZXLOndI27cVuGxp3uRovMj6gQHcB5lMIbT6IvOwFfIwOCE
 sqjU1y+LzqhLg==
Date: Fri, 29 May 2026 12:53:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Aaron Esau <aaron1esau@gmail.com>
Cc: mjt@tls.msk.ru, qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com,
 berrange@redhat.com, qemu-stable@nongnu.org, jic23@kernel.org,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/2] hw/cxl: fix OOB read in Get Log command due to
 incorrect pointer arithmetic
Message-ID: <20260529125301.44c7a382@jic23-huawei>
In-Reply-To: <CADucPGTnQdxsGDkpyfnGUvqWu6Y6Ph_NbAgP4D3=__OpNiJ0Jw@mail.gmail.com>
References: <20260416200702.2374709-1-git@aaronesau.com>
 <20260416200702.2374709-2-git@aaronesau.com>
 <c18a3fa5-4474-42db-b8be-95f164d1b184@tls.msk.ru>
 <CADucPGTnQdxsGDkpyfnGUvqWu6Y6Ph_NbAgP4D3=__OpNiJ0Jw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=172.234.252.31; envelope-from=jic23@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 13 May 2026 16:41:48 -0500
Aaron Esau <aaron1esau@gmail.com> wrote:

> Hi mjt,
>=20
> I haven't contributed to qemu before. Am I responsible for anything
> beyond submitting the patch here, to get this merged into master?
>=20
> - Aaron
>=20
> On Wed, May 13, 2026 at 1:35=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> =
wrote:
> >
> > On 16.04.2026 23:07, Aaron Esau wrote: =20
> > > From: Aaron Esau <aaron1esau@gmail.com>
> > >
> > > The memmove in cmd_logs_get_log() uses cci->cel_log + get_log->offset,
> > > which performs pointer arithmetic in units of sizeof(struct cel_log)
> > > (4 bytes per element). However, per CXL r3.1 Section 8.2.9.5.2, the
> > > offset field is a byte offset into the log.
> > >
> > > The existing bounds check correctly treats offset as a byte value:
> > >
> > >      (uint64_t)get_log->offset + get_log->length >=3D sizeof(cci->cel=
_log) =20
> >
> > ...
> >
> > Ping?
> >
> > Has this patchset been forgotten, or is it not needed anymore?
> > If it's needed, it would be nice if it lands in the master branch
> > in the next 10 days.

Sorry, this is me running slow due to other demands. I'm just catching
up with the qemu list as the email address this went to for me is dead.
Looks like my maintainers update hasn't been picked up by anyone yet.

The fix may look frightening but for now it's hardening only as offset
passed by all the guest software stacks I know of is always 0.

Fix looks correct to me.  I'll queue it up on my cxl tree but more
than happy if this goes directly via someone else.

Reviewed-by: Jonathan Cameron <jic23@kernel.org>


+ cc linux-cxl (and my kernel.org) address so that folk are aware of the po=
tential
issue.

Thanks,

Jonathan

> > Thanks,
> >
> > /mjt
> > =20


