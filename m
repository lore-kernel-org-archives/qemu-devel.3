Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D336BCF6D3B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 16:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw1zq-0004tN-Gr; Wed, 02 Oct 2024 12:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sw1zn-0004t7-5S
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 12:14:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sw1zk-000377-OM
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 12:14:34 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492FsfMd007837;
 Wed, 2 Oct 2024 16:14:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 uXX+p2aTkgm4BUCum7hnSmoAg7lb8CrdJoZCQxvfhiA=; b=oRjUYSXwwSmgwiy+
 m5IXajXwiIjJx8ZGLOaJC5gcJcUKTkLgkT5Fg6HDyZVS8gzhrPU4cpZzCrxk4Fp+
 J4RJJmFXH6G63x6Xf7xq9IPK9+8pilyXXWqlkXjntfPAtSzyoB0ScWX7Umo/DPtX
 tPs8GPNMXEtYoIv9h4VKPx6orC3vp0SAwwv4iZtXBctKTVEMTRCD4UUS6lu5LBbq
 Iv+8znEvvB+CxCumMyPZ2hiSaxrAafw5BXgSiDAY21Ys8kX3kc6NA2IjEauz+0L+
 MvfmNjhu0BFAugnHJaOBf2EYKgZlvpXl0wDzXIZ3HHNVqGHD39P2OgGf3wMbjc7Q
 oDLtcA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42197t83j4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Oct 2024 16:14:29 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 492GES9J025804;
 Wed, 2 Oct 2024 16:14:28 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42197t83hu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Oct 2024 16:14:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 492DZhxI017836;
 Wed, 2 Oct 2024 16:14:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xw4n3971-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Oct 2024 16:14:27 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 492GEP9718874704
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Oct 2024 16:14:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 94DB420040;
 Wed,  2 Oct 2024 16:14:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D69D20043;
 Wed,  2 Oct 2024 16:14:25 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  2 Oct 2024 16:14:25 +0000 (GMT)
Message-ID: <c2e3d873cee9d9548d632a5a27f4af06ce82bf88.camel@linux.ibm.com>
Subject: Re: [PATCH v1] linux-user: Add option to run `execve`d programs
 through QEMU
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Noah Goldstein <goldstein.w.n@gmail.com>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Date: Wed, 02 Oct 2024 18:14:24 +0200
In-Reply-To: <CAFUsyfKddfkryMX3Jn+2uDrteHDDgdzrQ3A4k5oXNpHq2FG_Gw@mail.gmail.com>
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
 <6109eea4230bb3aa7caf6deff526878231aa2136.camel@linux.ibm.com>
 <1251d17b-71f4-4630-b71f-990860bd9366@vivier.eu>
 <4d6c668781d12b8cd0c1fd18fbc4ef2abcf74806.camel@linux.ibm.com>
 <CAFUsyf++kWARZRJ0MriagYaoyJoJyKaHM09cQULiFECJ=bc4Uw@mail.gmail.com>
 <693ff38ebf2982d47cc419a406703e9e91dc79fd.camel@linux.ibm.com>
 <CAFUsyfKddfkryMX3Jn+2uDrteHDDgdzrQ3A4k5oXNpHq2FG_Gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 45McYuo1FcS67ZJ9S3gRkkTv31VWYDkK
X-Proofpoint-GUID: icCbo1Eu9c-OUXZqoaKd3305Zy-JujS2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_16,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410020117
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 2024-10-02 at 10:10 -0500, Noah Goldstein wrote:
> On Wed, Oct 2, 2024 at 9:53=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.co=
m>
> wrote:
> >=20
> > On Wed, 2024-10-02 at 09:44 -0500, Noah Goldstein wrote:
> > > On Wed, Oct 2, 2024 at 9:38=E2=80=AFAM Ilya Leoshkevich
> > > <iii@linux.ibm.com>
> > > wrote:
> > > >=20
> > > > On Wed, 2024-10-02 at 16:08 +0200, Laurent Vivier wrote:
> > > > > Le 02/10/2024 =C3=A0 10:08, Ilya Leoshkevich a =C3=A9crit :
> > > > > > On Fri, 2024-08-30 at 15:36 -0700, Noah Goldstein wrote:
> > > > > > > The new option '-qemu-children' makes it so that on
> > > > > > > `execve`
> > > > > > > the
> > > > > > > child
> > > > > > > process will be launch by the same `qemu` executable that
> > > > > > > is
> > > > > > > currently
> > > > > > > running along with its current commandline arguments.
> > > > > > >=20
> > > > > > > The motivation for the change is to make it so that
> > > > > > > plugins
> > > > > > > running
> > > > > > > through `qemu` can continue to run on children.=C2=A0 Why not
> > > > > > > just
> > > > > > > `binfmt`?: Plugins can be desirable regardless of
> > > > > > > system/architecture
> > > > > > > emulation, and can sometimes be useful for elf files that
> > > > > > > can
> > > > > > > run
> > > > > > > natively. Enabling `binfmt` for all natively runnable elf
> > > > > > > files
> > > > > > > may
> > > > > > > not be desirable.
> > > > > >=20
> > > > > > Another reason to have this is that one may not have root
> > > > > > permissions
> > > > > > to configure binfmt-misc.
> > > > >=20
> > > > > A little note on that: binfmt_misc is now part of the user
> > > > > namespace
> > > > > (since linux v6.7), so you can
> > > > > configure binfmt_misc as a non root user in a given namepace.
> > > > >=20
> > > > > There is helper to use it with unshare from util-linux, you
> > > > > can
> > > > > do
> > > > > things like that:
> > > > >=20
> > > > > =C2=A0=C2=A0 With 'F' flag, load the interpreter from the initial
> > > > > namespace:
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 $ /bin/qemu-m68k-static --version
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 qemu-m68k version 8.2.2 (qemu-8.2.2-1.fc=
40)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 Copyright (c) 2003-2023 Fabrice Bellard =
and the QEMU
> > > > > Project
> > > > > developers
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 $ unshare --map-root-user --fork --pid
> > > > > --load-interp=3D":qemu-
> > > > > m68k:M::\\x7fELF\\x01\\x02\\x01\\x00\\x00\\x00\\x00\\x00\\x00
> > > > > \\x0
> > > > > 0\\x
> > > > > 00\\x00\\x00\\x02\\x00\\x04:\\xff\\xff\\xff\\xff\\xff\\xff\\x
> > > > > fe\\
> > > > > x00\
> > > > > \xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xfe\\xff\\xff:/
> > > > > bin/
> > > > > qemu
> > > > > -m68k-static:OCF"
> > > > > --root=3Dchroot/m68k/sid
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 # QEMU_VERSION=3D ls
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 qemu-m68k version 8.2.2 (qemu-8.2.2-1.fc=
40)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 Copyright (c) 2003-2023 Fabrice Bellard =
and the QEMU
> > > > > Project
> > > > > developers
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 # /qemu-m68k=C2=A0 --version
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 qemu-m68k version 8.0.50 (v8.0.0-340-gb1=
cff5e2da95)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 Copyright (c) 2003-2022 Fabrice Bellard =
and the QEMU
> > > > > Project
> > > > > developers
> > > > >=20
> > > > > =C2=A0=C2=A0 Without 'F' flag, from inside the namespace:
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 $ unshare --map-root-user --fork --pid
> > > > > --load-interp=3D":qemu-
> > > > > m68k:M::\\x7fELF\\x01\\x02\\x01\\x00\\x00\\x00\\x00\\x00\\x00
> > > > > \\x0
> > > > > 0\\x
> > > > > 00\\x00\\x00\\x02\\x00\\x04:\\xff\\xff\\xff\\xff\\xff\\xff\\x
> > > > > fe\\
> > > > > x00\
> > > > > \xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xfe\\xff\\xff:/
> > > > > qemu
> > > > > -
> > > > > m68k:OC"
> > > > > --root=3Dchroot/m68k/sid
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 # QEMU_VERSION=3D ls
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 qemu-m68k version 8.0.50 (v8.0.0-340-gb1=
cff5e2da95)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 Copyright (c) 2003-2022 Fabrice Bellard =
and the QEMU
> > > > > Project
> > > > > developers
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 # /qemu-m68k=C2=A0 --version
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 qemu-m68k version 8.0.50 (v8.0.0-340-gb1=
cff5e2da95)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 Copyright (c) 2003-2022 Fabrice Bellard =
and the QEMU
> > > > > Project
> > > > > developers
> > > > >=20
> > > > > Thanks,
> > > > > Laurent
> > > > >=20
> > > >=20
> > > > Thanks for posting this, I wasn't aware of this feature and it
> > > > looks
> > > > really useful.
> > > >=20
> > > > IIUC it also resolves the main problem this patch is dealing
> > > > with:
> > >=20
> > > I might misunderstand, but I don't think it does in the sense
> > > that it still might not be desirable to use the same qemu flags
> > > for the entire class of executables.
> > >=20
> > > I.e the original motivating case was wanting to attach
> > > some plugins to a process and its children and AFAICT
> > > binfmt still doesn't give that level of control.
> >=20
> > I think if you start a process in a user namespace, which has a
> > binfmt_misc handler for a certain class of binaries, then this
> > handler
> > will affect only this process and its children, and not the rest of
> > the
> > system.
>=20
> It won't also affect other binaries in the user namespace?

It would, but you should be able to create a user namespace just
for=C2=A0your program. It should also be possible to nest user namespaces.

> > > > =C2=A0 Enabling `binfmt` for all natively runnable elf files may
> > > > =C2=A0 not be desirable.


