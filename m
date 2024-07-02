Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF54AC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 08:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZAM-0008DW-NH; Tue, 02 Jul 2024 04:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sOZAL-0008DJ-Af
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 04:47:09 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sOZA5-0003WY-RG
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 04:47:08 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WCxMh29P6z6JBDC;
 Tue,  2 Jul 2024 16:46:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 7FF171400CA;
 Tue,  2 Jul 2024 16:46:43 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 2 Jul
 2024 09:46:43 +0100
Date: Tue, 2 Jul 2024 09:46:42 +0100
To: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>, "nvdimm@lists.linux.dev"
 <nvdimm@lists.linux.dev>
Subject: Re: [BUG REPORT] cxl process in infinity loop
Message-ID: <20240702094642.00000fd8@Huawei.com>
In-Reply-To: <OSZPR01MB6453BC61D2FF4035F18084EF8DDC2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <OSZPR01MB6453BC61D2FF4035F18084EF8DDC2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.174.77]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Tue, 2 Jul 2024 00:30:06 +0000
"Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com> wrote:

> Hi, all
>=20
> When I did the cxl memory hot-plug test on QEMU, I accidentally connected=
=20
> two memdev to the same downstream port, the command like below:
>=20
> > -object memory-backend-ram,size=3D262144k,share=3Don,id=3Dvmem0 \
> > -object memory-backend-ram,size=3D262144k,share=3Don,id=3Dvmem1 \
> > -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
> > -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port0,chassis=3D0,slot=3D=
0 \
> > -device cxl-upstream,bus=3Droot_port0,id=3Dus0 \
> > -device cxl-downstream,port=3D0,bus=3Dus0,id=3Dswport00,chassis=3D0,slo=
t=3D5 \
> > -device cxl-downstream,port=3D0,bus=3Dus0,id=3Dswport01,chassis=3D0,slo=
t=3D7 \ =20
> same downstream port but has different slot!
>=20
> > -device cxl-type3,bus=3Dswport00,volatile-memdev=3Dvmem0,id=3Dcxl-vmem0=
 \
> > -device cxl-type3,bus=3Dswport01,volatile-memdev=3Dvmem1,id=3Dcxl-vmem1=
 \
> > -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D64G,cxl-fmw.0.interleav=
e-granularity=3D4k \ =20
>=20
> There is no error occurred when vm start, but when I executed the =E2=80=
=9Ccxl list=E2=80=9D command to view
> the CXL objects info, the process can not end properly.

I'd be happy to look preventing this on QEMU side if you send one,
but in general there are are lots of ways to shoot yourself in the
foot with CXL and PCI device emulation in QEMU so I'm not going
to rush to solve this specific one.

Likewise, some hardening in kernel / userspace probably makes sense but
this is a non compliant switch so priority of a fix is probably fairly low.

Jonathan

>=20
> Then I used strace to trace the process, I found that the process is in i=
nfinity loop:
> # strace cxl list
> ......
> clock_nanosleep(CLOCK_REALTIME, 0, {tv_sec=3D0, tv_nsec=3D1000000}, NULL)=
 =3D 0
> openat(AT_FDCWD, "/sys/bus/cxl/flush", O_WRONLY|O_CLOEXEC) =3D 3
> write(3, "1\n\0", 3)                    =3D 3
> close(3)                                =3D 0
> access("/run/udev/queue", F_OK)         =3D 0
> clock_nanosleep(CLOCK_REALTIME, 0, {tv_sec=3D0, tv_nsec=3D1000000}, NULL)=
 =3D 0
> openat(AT_FDCWD, "/sys/bus/cxl/flush", O_WRONLY|O_CLOEXEC) =3D 3
> write(3, "1\n\0", 3)                    =3D 3
> close(3)                                =3D 0
> access("/run/udev/queue", F_OK)         =3D 0
> clock_nanosleep(CLOCK_REALTIME, 0, {tv_sec=3D0, tv_nsec=3D1000000}, NULL)=
 =3D 0
> openat(AT_FDCWD, "/sys/bus/cxl/flush", O_WRONLY|O_CLOEXEC) =3D 3
> write(3, "1\n\0", 3)                    =3D 3
> close(3)                                =3D 0
> access("/run/udev/queue", F_OK)         =3D 0
> clock_nanosleep(CLOCK_REALTIME, 0, {tv_sec=3D0, tv_nsec=3D1000000}, NULL)=
 =3D 0
> openat(AT_FDCWD, "/sys/bus/cxl/flush", O_WRONLY|O_CLOEXEC) =3D 3
> write(3, "1\n\0", 3)                    =3D 3
> close(3)                                =3D 0
> access("/run/udev/queue", F_OK)         =3D 0
> clock_nanosleep(CLOCK_REALTIME, 0, {tv_sec=3D0, tv_nsec=3D1000000}, NULL)=
 =3D 0
> openat(AT_FDCWD, "/sys/bus/cxl/flush", O_WRONLY|O_CLOEXEC) =3D 3
> write(3, "1\n\0", 3)                    =3D 3
> close(3)                                =3D 0
> access("/run/udev/queue", F_OK)         =3D 0
> clock_nanosleep(CLOCK_REALTIME, 0, {tv_sec=3D0, tv_nsec=3D1000000}, NULL)=
 =3D 0
> openat(AT_FDCWD, "/sys/bus/cxl/flush", O_WRONLY|O_CLOEXEC) =3D 3
> write(3, "1\n\0", 3)                    =3D 3
> close(3)                                =3D 0
> access("/run/udev/queue", F_OK)         =3D 0
> clock_nanosleep(CLOCK_REALTIME, 0, {tv_sec=3D0, tv_nsec=3D1000000}, NULL)=
 =3D 0
> openat(AT_FDCWD, "/sys/bus/cxl/flush", O_WRONLY|O_CLOEXEC) =3D 3
> write(3, "1\n\0", 3)                    =3D 3
> close(3)                                =3D 0
> access("/run/udev/queue", F_OK)         =3D 0
> clock_nanosleep(CLOCK_REALTIME, 0, {tv_sec=3D0, tv_nsec=3D1000000}, NULL)=
 =3D 0
> openat(AT_FDCWD, "/sys/bus/cxl/flush", O_WRONLY|O_CLOEXEC) =3D 3
> write(3, "1\n\0", 3)                    =3D 3
> close(3)                                =3D 0
> access("/run/udev/queue", F_OK)         =3D 0
>=20
> [Environment]:
> linux: V6.10-rc3
> QEMU: V9.0.0
> ndctl: v79
>=20
> I know this is because of the wrong use of the QEMU command, but I think =
we should=20
> be aware of this error in one of the QEMU, OS or ndctl side at least.
>=20
> Thanks
> Xingtao


