Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2117C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 15:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rae60-0000Gf-Jy; Thu, 15 Feb 2024 10:56:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rae5y-0000GU-V8
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:56:19 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rae5w-0000Oi-2B
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:56:18 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbKM905C9z67M1q;
 Thu, 15 Feb 2024 23:52:21 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 960A414025A;
 Thu, 15 Feb 2024 23:56:05 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 15:56:05 +0000
Date: Thu, 15 Feb 2024 15:56:04 +0000
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>,
 "Gregory Price" <gregory.price@memverge.com>, Alex =?ISO-8859-1?Q?Benn=E9e?=
 <alex.bennee@linaro.org>, Sajjan Rao <sajjanr@gmail.com>, Dimitrios Palyvos
 <dimitrios.palyvos@zptcorp.com>, <richard.henderson@linaro.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/3] target/i386: Enable page walking from MMIO memory
Message-ID: <20240215155604.000078b0@Huawei.com>
In-Reply-To: <5b53790b-8f94-4b21-b1da-e7f278af0dd7@linaro.org>
References: <20240215150133.2088-1-Jonathan.Cameron@huawei.com>
 <20240215150133.2088-3-Jonathan.Cameron@huawei.com>
 <5b53790b-8f94-4b21-b1da-e7f278af0dd7@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 15 Feb 2024 16:31:26 +0100
Philippe Mathieu-Daud=E9 <philmd@linaro.org> wrote:

> On 15/2/24 16:01, Jonathan Cameron via wrote:
> > From: Gregory Price <gregory.price@memverge.com>
> >=20
> > CXL emulation of interleave requires read and write hooks due to
> > requirement for subpage granularity. The Linux kernel stack now enables
> > using this memory as conventional memory in a separate NUMA node. If a
> > process is deliberately forced to run from that node
> > $ numactl --membind=3D1 ls
> > the page table walk on i386 fails.
> >=20
> > Useful part of backtrace:
> >=20
> >      (cpu=3Dcpu@entry=3D0x555556fd9000, fmt=3Dfmt@entry=3D0x555555fe337=
8 "cpu_io_recompile: could not find TB for pc=3D%p")
> >      at ../../cpu-target.c:359
> >      (retaddr=3D0, addr=3D19595792376, attrs=3D..., xlat=3D<optimized o=
ut>, cpu=3D0x555556fd9000, out_offset=3D<synthetic pointer>)
> >      at ../../accel/tcg/cputlb.c:1339
> >      (cpu=3D0x555556fd9000, full=3D0x7fffee0d96e0, ret_be=3Dret_be@entr=
y=3D0, addr=3D19595792376, size=3Dsize@entry=3D8, mmu_idx=3D4, type=3DMMU_D=
ATA_LOAD, ra=3D0) at ../../accel/tcg/cputlb.c:2030
> >      (cpu=3Dcpu@entry=3D0x555556fd9000, p=3Dp@entry=3D0x7ffff56fddc0, m=
mu_idx=3D<optimized out>, type=3Dtype@entry=3DMMU_DATA_LOAD, memop=3D<optim=
ized out>, ra=3Dra@entry=3D0) at ../../accel/tcg/cputlb.c:2356
> >      (cpu=3Dcpu@entry=3D0x555556fd9000, addr=3Daddr@entry=3D19595792376=
, oi=3Doi@entry=3D52, ra=3Dra@entry=3D0, access_type=3Daccess_type@entry=3D=
MMU_DATA_LOAD) at ../../accel/tcg/cputlb.c:2439
> >      at ../../accel/tcg/ldst_common.c.inc:301
> >      at ../../target/i386/tcg/sysemu/excp_helper.c:173
> >      (err=3D0x7ffff56fdf80, out=3D0x7ffff56fdf70, mmu_idx=3D0, access_t=
ype=3DMMU_INST_FETCH, addr=3D18446744072116178925, env=3D0x555556fdb7c0)
> >      at ../../target/i386/tcg/sysemu/excp_helper.c:578
> >      (cs=3D0x555556fd9000, addr=3D18446744072116178925, size=3D<optimiz=
ed out>, access_type=3DMMU_INST_FETCH, mmu_idx=3D0, probe=3D<optimized out>=
, retaddr=3D0) at ../../target/i386/tcg/sysemu/excp_helper.c:604
> >=20
> > Avoid this by plumbing the address all the way down from
> > x86_cpu_tlb_fill() where is available as retaddr to the actual accessors
> > which provide it to probe_access_full() which already handles MMIO acce=
sses.
> >  =20
>=20
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>

Good point!  Sorry Peter.

> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
Thanks
>=20
> > Signed-off-by: Gregory Price <gregory.price@memverge.com>
> >=20
> > ---
> > Patch posted in reply to thread:
> > https://lore.kernel.org/qemu-devel/ZbvpSaOXzZkqDd6c@memverge.com/
> >=20
> > I checked Gregory was fine with me adding Sign-off / author via the CXL=
 discord.
> > ---
> >   target/i386/tcg/sysemu/excp_helper.c | 57 +++++++++++++++-------------
> >   1 file changed, 30 insertions(+), 27 deletions(-) =20
>=20


