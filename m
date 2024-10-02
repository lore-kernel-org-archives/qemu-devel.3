Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B571CF6D2C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 14:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw0Ue-0007vT-TX; Wed, 02 Oct 2024 10:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sw0Uc-0007qu-1M
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 10:38:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sw0UZ-0000J1-SW
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 10:38:17 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492Dsp6T018244;
 Wed, 2 Oct 2024 14:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 K6J2JteUpSz/KpUEOJZC78lU8CPL14Srsc2bcUAr7q0=; b=INxJNvf1cTNhDS0M
 iqnSqPjO7fecBk1neSrUw/fSXcUR5vDlwh1I67sKtOouwuUzoURYRZ2bDBYFxqln
 CZ1FHdQYwPTW81tVNmuiAyCanHDYvUAqs+sg/0VRd3F/u/pZSyDrAqR1EAoz0WpZ
 lr13jqvQahQUssDtQKBW6DqeI1dBUZ3Qya+KIIB7SNxKjJOm1+UMlecQjsUWN0PF
 HzUlT9rLPZJ8kj9vPF+oEuF37i6e5NO3e1b2YIhPA6UIJe0DhQCfTaVc7X7kgxZR
 KHF7MpFtaPG2I1gG/DIAWapt6E1otVOgohb78wpMm7lxgY7mJTy3DWY4UKkzFFz4
 aBz/qQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4217fm08hn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Oct 2024 14:38:13 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 492EcDlE021565;
 Wed, 2 Oct 2024 14:38:13 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4217fm08fq-12
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Oct 2024 14:38:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 492CgH5S007989;
 Wed, 2 Oct 2024 14:25:44 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xvgy2x66-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Oct 2024 14:25:44 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 492EPgRW34800282
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Oct 2024 14:25:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1652720043;
 Wed,  2 Oct 2024 14:25:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C402720040;
 Wed,  2 Oct 2024 14:25:41 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  2 Oct 2024 14:25:41 +0000 (GMT)
Message-ID: <4d6c668781d12b8cd0c1fd18fbc4ef2abcf74806.camel@linux.ibm.com>
Subject: Re: [PATCH v1] linux-user: Add option to run `execve`d programs
 through QEMU
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>, Noah Goldstein
 <goldstein.w.n@gmail.com>, qemu-devel@nongnu.org
Date: Wed, 02 Oct 2024 16:25:41 +0200
In-Reply-To: <1251d17b-71f4-4630-b71f-990860bd9366@vivier.eu>
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
 <6109eea4230bb3aa7caf6deff526878231aa2136.camel@linux.ibm.com>
 <1251d17b-71f4-4630-b71f-990860bd9366@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cql6ii7tAA_-hApB5Zbx5MS70XY70k4C
X-Proofpoint-ORIG-GUID: GnBKXT1e4sxyeWPdvipJoJBzbmJ2nv9E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_14,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410020106
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

On Wed, 2024-10-02 at 16:08 +0200, Laurent Vivier wrote:
> Le 02/10/2024 =C3=A0 10:08, Ilya Leoshkevich a =C3=A9crit=C2=A0:
> > On Fri, 2024-08-30 at 15:36 -0700, Noah Goldstein wrote:
> > > The new option '-qemu-children' makes it so that on `execve` the
> > > child
> > > process will be launch by the same `qemu` executable that is
> > > currently
> > > running along with its current commandline arguments.
> > >=20
> > > The motivation for the change is to make it so that plugins
> > > running
> > > through `qemu` can continue to run on children.=C2=A0 Why not just
> > > `binfmt`?: Plugins can be desirable regardless of
> > > system/architecture
> > > emulation, and can sometimes be useful for elf files that can run
> > > natively. Enabling `binfmt` for all natively runnable elf files
> > > may
> > > not be desirable.
> >=20
> > Another reason to have this is that one may not have root
> > permissions
> > to configure binfmt-misc.
>=20
> A little note on that: binfmt_misc is now part of the user namespace
> (since linux v6.7), so you can=20
> configure binfmt_misc as a non root user in a given namepace.
>=20
> There is helper to use it with unshare from util-linux, you can do
> things like that:
>=20
> =C2=A0=C2=A0 With 'F' flag, load the interpreter from the initial namespa=
ce:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 $ /bin/qemu-m68k-static --version
> =C2=A0=C2=A0=C2=A0=C2=A0 qemu-m68k version 8.2.2 (qemu-8.2.2-1.fc40)
> =C2=A0=C2=A0=C2=A0=C2=A0 Copyright (c) 2003-2023 Fabrice Bellard and the =
QEMU Project
> developers
> =C2=A0=C2=A0=C2=A0=C2=A0 $ unshare --map-root-user --fork --pid=20
> --load-interp=3D":qemu-
> m68k:M::\\x7fELF\\x01\\x02\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x
> 00\\x00\\x00\\x02\\x00\\x04:\\xff\\xff\\xff\\xff\\xff\\xff\\xfe\\x00\
> \xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xfe\\xff\\xff:/bin/qemu
> -m68k-static:OCF"=20
> --root=3Dchroot/m68k/sid
> =C2=A0=C2=A0=C2=A0=C2=A0 # QEMU_VERSION=3D ls
> =C2=A0=C2=A0=C2=A0=C2=A0 qemu-m68k version 8.2.2 (qemu-8.2.2-1.fc40)
> =C2=A0=C2=A0=C2=A0=C2=A0 Copyright (c) 2003-2023 Fabrice Bellard and the =
QEMU Project
> developers
> =C2=A0=C2=A0=C2=A0=C2=A0 # /qemu-m68k=C2=A0 --version
> =C2=A0=C2=A0=C2=A0=C2=A0 qemu-m68k version 8.0.50 (v8.0.0-340-gb1cff5e2da=
95)
> =C2=A0=C2=A0=C2=A0=C2=A0 Copyright (c) 2003-2022 Fabrice Bellard and the =
QEMU Project
> developers
>=20
> =C2=A0=C2=A0 Without 'F' flag, from inside the namespace:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 $ unshare --map-root-user --fork --pid=20
> --load-interp=3D":qemu-
> m68k:M::\\x7fELF\\x01\\x02\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x
> 00\\x00\\x00\\x02\\x00\\x04:\\xff\\xff\\xff\\xff\\xff\\xff\\xfe\\x00\
> \xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xfe\\xff\\xff:/qemu-
> m68k:OC"=20
> --root=3Dchroot/m68k/sid
> =C2=A0=C2=A0=C2=A0=C2=A0 # QEMU_VERSION=3D ls
> =C2=A0=C2=A0=C2=A0=C2=A0 qemu-m68k version 8.0.50 (v8.0.0-340-gb1cff5e2da=
95)
> =C2=A0=C2=A0=C2=A0=C2=A0 Copyright (c) 2003-2022 Fabrice Bellard and the =
QEMU Project
> developers
> =C2=A0=C2=A0=C2=A0=C2=A0 # /qemu-m68k=C2=A0 --version
> =C2=A0=C2=A0=C2=A0=C2=A0 qemu-m68k version 8.0.50 (v8.0.0-340-gb1cff5e2da=
95)
> =C2=A0=C2=A0=C2=A0=C2=A0 Copyright (c) 2003-2022 Fabrice Bellard and the =
QEMU Project
> developers
>=20
> Thanks,
> Laurent
>=20

Thanks for posting this, I wasn't aware of this feature and it looks
really useful.=20

IIUC it also resolves the main problem this patch is dealing with:

  Enabling `binfmt` for all natively runnable elf files may
  not be desirable.

