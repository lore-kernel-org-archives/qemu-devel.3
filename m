Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616DBC87FCA
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Aug 2025 06:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukzyp-0002Yz-1k; Sun, 10 Aug 2025 02:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ukzyi-0002Yi-OP; Sun, 10 Aug 2025 02:56:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ukzyg-0005Ev-Fz; Sun, 10 Aug 2025 02:56:24 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57A3vcQx004422;
 Sun, 10 Aug 2025 06:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=a7YZ86
 i6Yd6AlnFr1SMzY1Es/C/RkrLzpmDEQEIW+uI=; b=nB0f70K913sJdh5xnov7Gj
 e9o7Xeu6i+VzEZfvDY+QDTRNlicYpsKHLXdqhHD0c00i+eilYXFhD6Gfhoev/+Vj
 SPrzgVAZYdom40JQDuQrJcb6ZatXA1nCQqI5iQkJJ2exlkESh36NqdUR/6EN/ayw
 tC8D/mWiHoaHt8PPmqtJiM/urQ/zJiek5cbUSzSjNsMqTC7O4n5IAMxzbaeSV8Iw
 E030b7qMH6ezjaEMxktTJ519tbJ/9nyN5Rr0v/fbrk53RtkbonfxwJefri//VKUX
 LQ4IpJvCsNudSa74MU+V4LadUcgVZNud+KhbwW2IClvwVHEWinyrLJ4IuvVqC7Qg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrnmcyu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 10 Aug 2025 06:56:18 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57A6uIFO027098;
 Sun, 10 Aug 2025 06:56:18 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrnmcyt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 10 Aug 2025 06:56:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57A1rRg8028585;
 Sun, 10 Aug 2025 06:56:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48ej5mrtaj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 10 Aug 2025 06:56:17 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57A6uDKm35390130
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 10 Aug 2025 06:56:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0F6320040;
 Sun, 10 Aug 2025 06:56:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7EA9220049;
 Sun, 10 Aug 2025 06:56:11 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.28.118]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sun, 10 Aug 2025 06:56:11 +0000 (GMT)
Date: Sun, 10 Aug 2025 12:26:06 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH v9 0/7] Power11 support for QEMU [PowerNV]
Message-ID: <yo6uk5z6dlq4jlk5hsaoyhymozdpo6ijpq5bz4fipkf5ftws4b@um57vsttgf65>
References: <20250808115929.1073910-1-adityag@linux.ibm.com>
 <baf6c854-832b-4a2e-922f-d34e6dadf821@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <baf6c854-832b-4a2e-922f-d34e6dadf821@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA0OCBTYWx0ZWRfX3OaIr6uCVU6n
 GNUQlP2lH0TW4qnq2mp6rgOinslbbYHk0krYOCXQSZss8pM2Smt7gHc3YvYm7OCHcWPNqh9DjXT
 lHevIRNFpvEoi7klK+qBfrEa4v+Y9PdGoTWKtYa2MmRxltK8+xTmyMBCGO7hWebYjJ9rh8xA/gt
 6C/C+Hp5vI7ODhhBtB/a11akoPnEsnkO5RAMU3qufcTLtxSVjUBIKqIkjvRaOXH08WqEK98ED4p
 346sOQQUM9hxF/uNU9bxkMVjS9/FRiTg0bl2+vTIzHKxe6oMb1POzDB7Ndp601whqeDdL0NE4CZ
 Gk6SbwOQUL1Oe+Wwl7ZRt/f31mmTSy6Ogtlnoqv+cfe/8h15lKURN6jKILUkSjs7iwnlykg241+
 xyi04dcgTeOVMl9hxpYwSH5h8ZcD2AbK1HVZhSx8f6wOLpiMLDgKD16zZlTPqMaBt/pX6pA9
X-Authority-Analysis: v=2.4 cv=GrpC+l1C c=1 sm=1 tr=0 ts=68984292 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=ajwdG1av7UouRkLRB5EA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: JsPrCK-YtWdu2JIWGujzPKHPnQG5Px5p
X-Proofpoint-ORIG-GUID: q5qupJJSOTfo05DChxIAcnTOJ1pz7aB8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508100048
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Cedric,
Sorry for the late reply, I am on vacation this week, will try to look
at this, but reply might be late.

On 25/08/08 02:32PM, C=C3=A9dric Le Goater wrote:
> On 8/8/25 13:59, Aditya Gupta wrote:
> > Overview
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > Add support for Power11 powernv machine type.
> >=20
> > > <...snip...>
>
> Booting a PowerNV11 machine crashes QEMU. See below.
>=20
> Are you testing with petitboot kexecing a distro kernel from disk ?
> Please do and also start a KVM guest. Please check your tests.

No, I ran the qemu functional tests, and few boot tests with different
options.

The functional test already attaches a e1000e device, somehow that
didn't trigger the same error that you saw (maybe the kernel used
doesn't have support for that device).
Will add a test to try petitboot kexec scenario also, so we don't hit
these kind of issues in future.

Regarding KVM guest, iirc we can't start KVM guest for PowerNV yet right
?

About the error, seems xive2 always expecting powernv10 chip, I will
have to rethink how should I use the same xive2 for powernv11.

Thank you for testing this Cedric !

- Aditya G

>=20
> Thanks,
>=20
> C.
>=20
>=20
> [    6.806342] e1000e 0001:02:03.0 eth0: MAC: 3, PHY: 8, PBA No: 000000-0=
00
> [    6.844448] e1000e 0001:02:03.0 enP1p2s3: renamed from eth0
> ../include/hw/ppc/pnv_chip.h:110:PNV10_CHIP: Object 0x555556ab0cf0 is not=
 an instance of type pnv10-chip
>=20
> Thread 1 "qemu-system-ppc" received signal SIGABRT, Aborted.
> 0x00007ffff6a8d02c in __pthread_kill_implementation () from /lib64/libc.s=
o.6
> Missing rpms, try: dnf --enablerepo=3D'*debug*' install capstone-debuginf=
o-4.0.2-10.el9.x86_64 gnutls-debuginfo-3.8.3-9.el9.x86_64 pixman-debuginfo-=
0.40.0-6.el9.x86_64 zlib-debuginfo-1.2.11-40.el9.x86_64 lzo-debuginfo-2.10-=
7.el9.x86_64 SDL2-debuginfo-2.26.0-1.el9.x86_64 libpmem-debuginfo-1.12.1-1.=
el9.x86_64 libfdt-debuginfo-1.6.0-7.el9.x86_64 numactl-libs-debuginfo-2.0.1=
9-1.el9.x86_64 glib2-debuginfo-2.68.4-16.el9_6.2.x86_64 libzstd-debuginfo-1=
=2E5.5-1.el9.x86_64 libslirp-debuginfo-4.4.0-8.el9.x86_64 elfutils-libs-deb=
uginfo-0.193-1.el9.x86_64 ncurses-libs-debuginfo-6.2-12.20210508.el9.x86_64=
 usbredir-debuginfo-0.13.0-2.el9.x86_64 libusbx-debuginfo-1.0.26-1.el9.x86_=
64 glibc-debuginfo-2.34-221.el9.x86_64 p11-kit-debuginfo-0.25.3-3.el9.x86_6=
4 libidn2-debuginfo-2.3.0-7.el9.x86_64 libunistring-debuginfo-0.9.10-15.el9=
=2Ex86_64 libtasn1-debuginfo-4.16.0-9.el9.x86_64 nettle-debuginfo-3.10.1-1.=
el9.x86_64 ndctl-libs-debuginfo-78-2.el9.x86_64 daxctl-libs-debuginfo-78-2.=
el9.x86_64 libmount-debuginfo-2.37.4-21.el9.x86_64 libselinux-debuginfo-3.6=
-3.el9.x86_64 libffi-debuginfo-3.4.2-8.el9.x86_64 pcre-debuginfo-8.44-4.el9=
=2Ex86_64 elfutils-libelf-debuginfo-0.193-1.el9.x86_64 xz-libs-debuginfo-5.=
2.5-8.el9_0.x86_64 bzip2-libs-debuginfo-1.0.8-10.el9_5.x86_64 systemd-libs-=
debuginfo-252-53.el9.x86_64 libuuid-debuginfo-2.37.4-21.el9.x86_64 kmod-lib=
s-debuginfo-28-10.el9.x86_64 libblkid-debuginfo-2.37.4-21.el9.x86_64 pcre2-=
debuginfo-10.40-6.el9.x86_64 libgcc-debuginfo-11.5.0-9.el9.x86_64 openssl-l=
ibs-debuginfo-3.5.1-3.el9.x86_64
> (gdb) bt
> #0  0x00007ffff6a8d02c in __pthread_kill_implementation () at /lib64/libc=
=2Eso.6
> #1  0x00007ffff6a3fb86 in raise () at /lib64/libc.so.6
> #2  0x00007ffff6a29873 in abort () at /lib64/libc.so.6
> #3  0x0000555555d62988 in object_dynamic_cast_assert
>     (obj=3D0x555556ab0cf0, typename=3Dtypename@entry=3D0x5555560528a5 "pn=
v10-chip", file=3Dfile@entry=3D0x555556051628 "/home/legoater/work/qemu/qem=
u.git/include/hw/ppc/pnv_chip.h", line=3Dline@entry=3D110, func=3Dfunc@entr=
y=3D0x55555606a2c8 <__func__.27> "PNV10_CHIP")
>     at ../qom/object.c:925
> #4  0x0000555555cfe852 in PNV10_CHIP (obj=3D<optimized out>) at /home/leg=
oater/work/qemu/qemu.git/include/hw/ppc/pnv_chip.h:110
> #5  pnv_xive2_get_remote (fwd_addr=3D<optimized out>, vsd_type=3D2) at ..=
/hw/intc/pnv_xive2.c:113
> #6  pnv_xive2_vst_addr (idx=3D15, blk=3D<optimized out>, type=3D2, xive=
=3D<optimized out>) at ../hw/intc/pnv_xive2.c:265
> #7  pnv_xive2_vst_addr (xive=3D<optimized out>, type=3D2, blk=3D<optimize=
d out>, idx=3D15) at ../hw/intc/pnv_xive2.c:244
> #8  0x0000555555cfec35 in pnv_xive2_vst_read (xive=3D0x555556ab1500, type=
=3D2, blk=3D1 '\001', idx=3D15, data=3D0x7fffffffcf20)
>     at ../hw/intc/pnv_xive2.c:286
> #9  0x0000555555d06a69 in xive2_router_get_end (end=3D0x7fffffffcf20, end=
_idx=3D15, end_blk=3D1 '\001', xrtr=3D0x555556ab1500)
>     at ../hw/intc/xive2.c:1437
> #10 xive2_router_end_notify
>     (xrtr=3Dxrtr@entry=3D0x555556ab1500, end_blk=3D1 '\001', end_idx=3D15=
, end_data=3D97, redistribute=3Dredistribute@entry=3Dfalse)
>     at ../hw/intc/xive2.c:1669
> #11 0x0000555555d06990 in xive2_notify (xrtr=3D0x555556ab1500, lisn=3D104=
0385, pq_checked=3D<optimized out>)
>     at ../hw/intc/xive2.c:1955
> #12 0x0000555555add8bb in memory_region_write_accessor
>     (mr=3Dmr@entry=3D0x555556ab3e00, addr=3D136365408256, value=3Dvalue@e=
ntry=3D0x7fffffffd0e8, size=3Dsize@entry=3D8, shift=3D<optimized out>, mask=
=3Dmask@entry=3D18446744073709551615, attrs=3D...) at ../system/memory.c:490
> #13 0x0000555555adf1a2 in access_with_adjusted_size
>     (addr=3Daddr@entry=3D136365408256, value=3Dvalue@entry=3D0x7fffffffd0=
e8, size=3Dsize@entry=3D8, access_size_min=3D<optimized out>, access_size_m=
ax=3D<optimized out>, access_fn=3D0x555555add850 <memory_region_write_acces=
sor>, mr=3D0x555556ab3e00, attrs=3D...)
>     at ../system/memory.c:561
> #14 0x0000555555ae0164 in memory_region_dispatch_write (mr=3Dmr@entry=3D0=
x555556ab3e00, addr=3D136365408256, data=3D<optimized out>,
>     data@entry=3D0, op=3D<optimized out>, attrs=3Dattrs@entry=3D...) at .=
=2E/system/memory.c:1553
> #15 0x0000555555ae8357 in address_space_stq_internal
>     (as=3D<optimized out>, addr=3Daddr@entry=3D1694483783811072, val=3Dva=
l@entry=3D0, attrs=3D..., result=3Dresult@entry=3D0x7fffffffd1f4, endian=3D=
endian@entry=3DDEVICE_BIG_ENDIAN) at ../system/memory_ldst.c.inc:479
> #16 0x0000555555aeef0b in address_space_stq_be
>     (as=3D<optimized out>, addr=3Daddr@entry=3D1694483783811072, val=3Dva=
l@entry=3D0, attrs=3D...,
>     attrs@entry=3D..., result=3Dresult@entry=3D0x7fffffffd1f4) at ../syst=
em/memory_ldst.c.inc:524
> #17 0x0000555555d2159c in pnv_phb4_xive_notify_abt (pq_checked=3Dfalse, s=
rcno=3D<optimized out>, phb=3D0x5555574bc500)
>     at ../hw/pci-host/pnv_phb4.c:1650
> #18 pnv_phb4_xive_notify (xf=3D<optimized out>, srcno=3D<optimized out>, =
pq_checked=3D<optimized out>)
>     at ../hw/pci-host/pnv_phb4.c:1686
> #19 0x0000555555d203f0 in qemu_irq_pulse (irq=3D0x5555574c8440) at /home/=
legoater/work/qemu/qemu.git/include/hw/irq.h:33
> #20 pnv_phb4_msi_write (opaque=3D<optimized out>, addr=3D<optimized out>,=
 data=3D<optimized out>, size=3D<optimized out>)
>     at ../hw/pci-host/pnv_phb4.c:1423
> #21 0x0000555555add8bb in memory_region_write_accessor
>     (mr=3Dmr@entry=3D0x55555d8c76b0, addr=3D0, value=3Dvalue@entry=3D0x7f=
ffffffd318, size=3Dsize@entry=3D4, shift=3D<optimized out>, mask=3Dmask@ent=
ry=3D4294967295, attrs=3D...) at ../system/memory.c:490
> #22 0x0000555555adf23b in access_with_adjusted_size
>     (addr=3Daddr@entry=3D0, value=3Dvalue@entry=3D0x7fffffffd318, size=3D=
size@entry=3D4, access_size_min=3D<optimized out>, access_size_max=3D<optim=
ized out>, access_fn=3D0x555555add850 <memory_region_write_accessor>, mr=3D=
0x55555d8c76b0, attrs=3D...)
>     at ../system/memory.c:566
> #23 0x0000555555ae0164 in memory_region_dispatch_write (mr=3Dmr@entry=3D0=
x55555d8c76b0, addr=3D0, data=3D<optimized out>,
>     data@entry=3D1, op=3Dop@entry=3DMO_32, attrs=3Dattrs@entry=3D...) at =
=2E./system/memory.c:1553
> #24 0x0000555555aee333 in address_space_stl_internal
>     (endian=3DDEVICE_LITTLE_ENDIAN, result=3D0x0, attrs=3D..., val=3D1, a=
ddr=3D<optimized out>, as=3D<optimized out>)
>     at ../system/memory_ldst.c.inc:319
> #25 address_space_stl_le (as=3D<optimized out>, addr=3D<optimized out>, v=
al=3D1, attrs=3D..., result=3D0x0)
>     at ../system/memory_ldst.c.inc:357
> #26 0x0000555555ef3c05 in aio_bh_call (bh=3Dbh@entry=3D0x55555d0d59e0) at=
 ../util/async.c:172
> #27 0x0000555555ef3d35 in aio_bh_poll (ctx=3Dctx@entry=3D0x55555667ad50) =
at ../util/async.c:219
> #28 0x0000555555edcede in aio_dispatch (ctx=3D0x55555667ad50) at ../util/=
aio-posix.c:436
> #29 0x0000555555ef3a7e in aio_ctx_dispatch (source=3D<optimized out>, cal=
lback=3D<optimized out>, user_data=3D<optimized out>)
>     at ../util/async.c:361
> #30 0x00007ffff76c0f4f in g_main_context_dispatch () at /lib64/libglib-2.=
0.so.0
> #31 0x0000555555ef5058 in glib_pollfds_poll () at ../util/main-loop.c:287
> #32 os_host_main_loop_wait (timeout=3D0) at ../util/main-loop.c:310
> #33 main_loop_wait (nonblocking=3Dnonblocking@entry=3D0) at ../util/main-=
loop.c:589
> #34 0x0000555555af89b3 in qemu_main_loop () at ../system/runstate.c:905
> #35 0x0000555555e4273c in qemu_default_main (opaque=3Dopaque@entry=3D0x0)=
 at ../system/main.c:50
> #36 0x000055555589eddd in main (argc=3D<optimized out>, argv=3D<optimized=
 out>) at ../system/main.c:93
>=20

