Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8281BC04FF8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 08:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxMwK-0001uj-AB; Thu, 18 Apr 2024 04:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rxMwI-0001uL-1h; Thu, 18 Apr 2024 04:16:14 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rxMwE-0006Tn-Ms; Thu, 18 Apr 2024 04:16:13 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VKrC36F1mz6K5qR;
 Thu, 18 Apr 2024 16:13:51 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id D8A22140684;
 Thu, 18 Apr 2024 16:15:54 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 18 Apr
 2024 09:15:54 +0100
Date: Thu, 18 Apr 2024 09:15:55 +0100
To: Richard Henderson <richard.henderson@linaro.org>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, Philippe
 =?ISO-8859-1?Q?Ma?= =?ISO-8859-1?Q?thieu-Daud=E9?= <philmd@linaro.org>, Idan
 Horowitz <idan.horowitz@gmail.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v3 5/6] target/arm: Do memory type alignment check when
 translation disabled
Message-ID: <20240418091555.00006666@Huawei.com>
In-Reply-To: <0c878d25-3fbb-4f0b-bc9e-ca638f8c4f1e@linaro.org>
References: <20240301204110.656742-1-richard.henderson@linaro.org>
 <20240301204110.656742-6-richard.henderson@linaro.org>
 <20240416161111.0000607c@huawei.com>
 <0c878d25-3fbb-4f0b-bc9e-ca638f8c4f1e@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 17 Apr 2024 13:07:35 -0700
Richard Henderson <richard.henderson@linaro.org> wrote:

> On 4/16/24 08:11, Jonathan Cameron wrote:
> > On Fri,  1 Mar 2024 10:41:09 -1000
> > Richard Henderson <richard.henderson@linaro.org> wrote:
> >  =20
> >> If translation is disabled, the default memory type is Device, which
> >> requires alignment checking.  This is more optimally done early via
> >> the MemOp given to the TCG memory operation.
> >>
> >> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> >> Reported-by: Idan Horowitz <idan.horowitz@gmail.com>
> >> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1204
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org> =20
> >=20
> > Hi Richard.
> >=20
> > I noticed some tests I was running stopped booting with master.
> > (it's a fun and complex stack of QEMU + kvm on QEMU for vCPU Hotplug ke=
rnel work,
> > but this is the host booting)
> >=20
> > EDK2 build from upstream as of somepoint last week.
> >=20
> > Bisects to this patch.
> >=20
> >   qemu-system-aarch64 -M virt,gic-version=3D3,virtualization=3Dtrue -m =
4g,maxmem=3D8G,slots=3D8 -cpu cortex-a76 -smp cpus=3D4,threads=3D2,clusters=
=3D2,sockets=3D1 \
> >   -kernel Image \
> >   -drive if=3Dnone,file=3Dfull.qcow2,format=3Dqcow2,id=3Dhd \
> >   -device ioh3420,id=3Droot_port1 -device virtio-blk-pci,drive=3Dhd \
> >   -netdev user,id=3Dmynet,hostfwd=3Dtcp::5555-:22 -device virtio-net-pc=
i,netdev=3Dmynet,id=3Dbob \
> >   -nographic -no-reboot -append 'earlycon root=3D/dev/vda2 fsck.mode=3D=
skip tp_printk' \
> >   -monitor telnet:127.0.0.1:1235,server,nowait -bios QEMU_EFI.fd \
> >   -object memory-backend-ram,size=3D4G,id=3Dmem0 \
> >   -numa node,nodeid=3D0,cpus=3D0-3,memdev=3Dmem0
> >=20
> > Symptoms: Nothing on console from edk2 which is built in debug mode so =
is normally very noisy.
> >            No sign of anything much happening at all :( =20
>=20
> This isn't a fantastic bug report.
>=20
> (1) If it doesn't boot efi, then none of the -kernel parameters are neces=
sary.
> (2) I'd be surprised if the full.qcow2 drive parameters are necessary eit=
her.
>      But if they are, what contents?  Is a new empty drive sufficient, ju=
st
>      enough to send the bios through the correct device initialization?
> (3) edk2 build from ...
>      Well, this is partly edk2's fault, as the build documentation is awf=
ul.
>      I spent an entire afternoon trying to figure it out and gave up.
>=20
> I will say that the edk2 shipped with qemu does work, so... are you absol=
utely
> certain that it isn't a bug in edk2 since then?  Firmware bugs are exactl=
y what
> that patch is supposed to expose, as requested by issue #1204.
>=20
> I'd say you should boot with "-d int" and see what kind of interrupts you=
're getting very=20
> early on.  I suspect that you'll see data aborts with ESR xx/yy where the=
 last 6 bits of=20
> yy are 0x21 (alignment fault).

Hi Richard,

Sorry for lack of details, I was aware it wasn't great and should have stat=
ed I planned
to come back with more details when I had time to debug.  Snowed under so f=
or now I've
just dropped back to 8.2 and will get back to this perhaps next week.

Jonathan

>=20
>=20
> r~


