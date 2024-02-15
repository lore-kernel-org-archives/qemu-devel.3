Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33747C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 16:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raeKh-0006nb-OO; Thu, 15 Feb 2024 11:11:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1raeKb-0006lx-DO
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 11:11:26 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1raeKW-0004JN-Sd
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 11:11:23 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbKj15jsHz6K8j1;
 Fri, 16 Feb 2024 00:07:49 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id A60C8140682;
 Fri, 16 Feb 2024 00:11:17 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 16:11:17 +0000
Date: Thu, 15 Feb 2024 16:11:16 +0000
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>,
 "Gregory Price" <gregory.price@memverge.com>, Alex =?ISO-8859-1?Q?Benn=E9e?=
 <alex.bennee@linaro.org>, Sajjan Rao <sajjanr@gmail.com>, Dimitrios Palyvos
 <dimitrios.palyvos@zptcorp.com>, <richard.henderson@linaro.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] tcg: Avoid double lock if page tables happen to be
 in mmio memory.
Message-ID: <20240215161116.0000210e@huawei.com>
In-Reply-To: <bdeb194e-28f6-4dda-bf85-bd1a0b983ecd@linaro.org>
References: <20240215150133.2088-1-Jonathan.Cameron@huawei.com>
 <20240215150133.2088-4-Jonathan.Cameron@huawei.com>
 <bdeb194e-28f6-4dda-bf85-bd1a0b983ecd@linaro.org>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 15 Feb 2024 16:33:45 +0100
Philippe Mathieu-Daud=E9 <philmd@linaro.org> wrote:

> On 15/2/24 16:01, Jonathan Cameron via wrote:
> > On i386, after fixing the page walking code to work with pages in
> > MMIO memory (specifically CXL emulated interleaved memory),
> > a crash was seen in an interrupt handling path.
> >=20
> > Useful part of bt
> >=20
> > Peter identified this as being due to the BQL already being
> > held when the page table walker encounters MMIO memory and attempts
> > to take the lock again.  There are other examples of similar paths
> > TCG, so this follows the approach taken in those of simply checking
> > if the lock is already held and if it is, don't take it again.
> >=20
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >   accel/tcg/cputlb.c | 9 +++++++--
> >   1 file changed, 7 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> > index 047cd2cc0a..3b8d178707 100644
> > --- a/accel/tcg/cputlb.c
> > +++ b/accel/tcg/cputlb.c
> > @@ -2019,6 +2019,7 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPU=
TLBEntryFull *full,
> >                                  int mmu_idx, MMUAccessType type, uintp=
tr_t ra)
> >   {
> >       MemoryRegionSection *section;
> > +    bool locked =3D bql_locked(); =20
>=20
> Maybe clearer as:
>=20
>         bool need_lock =3D !bql_locked();
>=20
> >       MemoryRegion *mr;
> >       hwaddr mr_offset;
> >       MemTxAttrs attrs;
> > @@ -2030,10 +2031,14 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, C=
PUTLBEntryFull *full,
> >       section =3D io_prepare(&mr_offset, cpu, full->xlat_section, attrs=
, addr, ra);
> >       mr =3D section->mr;
> >  =20
> > -    bql_lock();
> > +    if (!locked) { =20
>=20
> if (unlikely(need_lock)) {

Isn't this reversed? Until now we've always taken the lock here so I'm gues=
sing
it normally is needed. if (likely(need_lock))?
if we are going to mark it one way or the other.

>=20
> > +        bql_lock();
> > +    }
> >       ret =3D int_ld_mmio_beN(cpu, full, ret_be, addr, size, mmu_idx,
> >                             type, ra, mr, mr_offset);
> > -    bql_unlock();
> > +    if (!locked) { =20
>=20
> Ditto.
>=20
> > +        bql_unlock();
> > +    }
> >  =20
> >       return ret;
> >   } =20
>=20


