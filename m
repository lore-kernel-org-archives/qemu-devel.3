Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A62CF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 12:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svFFG-0000hT-AR; Mon, 30 Sep 2024 08:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1svFFB-0000gy-T1
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:11:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1svFF8-00016o-RX
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:11:13 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UBjGt3017390;
 Mon, 30 Sep 2024 12:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 kjO5CiJHl9o5K/6zBjPS8evZESO33xCLKHtT8iOtYIg=; b=IrGtimZ+fj2QDx5E
 YZtfHP3AaJo/wLznZ560pnATZILklPPag1Mkb24e8AtATqAbIZWjZdl0et1Ne/jk
 ay64ejKSl/THli1upX4wA1jrn2zCbxLMYxSeN15c7vj3pXyDDfBi40XMKmw3zPeW
 yDq7cJ6Te0z1fFVNjK1u6cx7BqTRFP/KDlG2mkjEMTlHmNjZ0wznX9OJKGz9GcNP
 nJ/usN4TjKpSYFPh9Mzb/+hSVjZKSgDgX8sYamiPwtsmMYjLaxmSLgsK0knRBZgh
 YAUWa45jgBukTYyOaPiQfbWHlUe8CsFq41Un8NaT1TRbc3wx5JZD0+qpw53SnyqX
 3yDw8A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x87khdu3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 12:10:57 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48UCAv3B028532;
 Mon, 30 Sep 2024 12:10:57 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x87khdu2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 12:10:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UAHTtq020408;
 Mon, 30 Sep 2024 12:10:56 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xv4rxm3y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 12:10:56 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48UCAsVH37355948
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2024 12:10:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D49F82004D;
 Mon, 30 Sep 2024 12:10:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6137820040;
 Mon, 30 Sep 2024 12:10:54 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 30 Sep 2024 12:10:54 +0000 (GMT)
Message-ID: <4e3ab59f55937b846fc214f3c3ca3e15c4afb19c.camel@linux.ibm.com>
Subject: Re: [PULL v2 00/47] riscv-to-apply queue
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Peter Maydell
 <peter.maydell@linaro.org>, Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Date: Mon, 30 Sep 2024 14:10:54 +0200
In-Reply-To: <13ee9889-b503-45ea-a074-ffafbd052c4e@ventanamicro.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
 <CAFEAcA9Sb-fpNhm-6DPwss5zMpw=nEp31Wt6q1OA6DqCg3wKEg@mail.gmail.com>
 <13ee9889-b503-45ea-a074-ffafbd052c4e@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lUl7SSnp0_Ux9t2Nzkk0Ro8I6SkKAs8c
X-Proofpoint-ORIG-GUID: IIPjVXv6sSC3K4J7SF5u1y7yRVTlW4bE
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_10,2024-09-27_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300087
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URI_DOTEDU=1.999 autolearn=no autolearn_force=no
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

On Sat, 2024-09-28 at 17:40 -0300, Daniel Henrique Barboza wrote:
>=20
>=20
> On 9/28/24 8:34 AM, Peter Maydell wrote:
> > On Tue, 24 Sept 2024 at 23:18, Alistair Francis
> > <alistair23@gmail.com> wrote:
> > >=20
> > > The following changes since commit
> > > 01dc65a3bc262ab1bec8fe89775e9bbfa627becb:
> > >=20
> > > =C2=A0=C2=A0 Merge tag 'pull-target-arm-20240919' of
> > > https://git.linaro.org/people/pmaydell/qemu-arm=C2=A0into staging
> > > (2024-09-19 14:15:15 +0100)
> > >=20
> > > are available in the Git repository at:
> > >=20
> > > =C2=A0=C2=A0 https://github.com/alistair23/qemu.git=C2=A0tags/pull-ri=
scv-to-
> > > apply-20240925-1
> > >=20
> > > for you to fetch changes up to
> > > 6bfa92c5757fe7a9580e1f6e065076777cae650f:
> > >=20
> > > =C2=A0=C2=A0 bsd-user: Add RISC-V 64-bit Target Configuration and Deb=
ug XML
> > > Files (2024-09-24 12:53:16 +1000)
> > >=20
> > > ----------------------------------------------------------------
> > > RISC-V PR for 9.2
> > >=20
> > > * Add a property to set vl to ceil(AVL/2)
> > > * Enable numamem testing for RISC-V
> > > * Consider MISA bit choice in implied rule
> > > * Fix the za64rs priv spec requirements
> > > * Enable Bit Manip for OpenTitan Ibex CPU
> > > * Fix the group bit setting of AIA with KVM
> > > * Stop timer with infinite timecmp
> > > * Add 'fcsr' register to QEMU log as a part of F extension
> > > * Fix riscv64 build on musl libc
> > > * Add preliminary textra trigger CSR functions
> > > * RISC-V IOMMU support
> > > * RISC-V bsd-user support
> > > * Respect firmware ELF entry point
> > > * Add Svvptc extension support
> > > * Fix masking of rv32 physical address
> > > * Fix linking problem with semihosting disabled
> > > * Fix IMSIC interrupt state updates
> > >=20
> >=20
> > This fails the riscv qos-tests on s390x. My guess is that the new
> > IOMMU support has endianness bugs and fails on bigendian hosts.
> >=20
> > https://gitlab.com/qemu-project/qemu/-/jobs/7942189143
> >=20
> > full test log (4MB) at
> > https://qemu-project.gitlab.io/-/qemu/-/jobs/7942189143/artifacts/build=
/meson-logs/testlog.txt
> >=20
> > The assertion failure is
> > ERROR:../tests/qtest/riscv-iommu-test.c:72:test_reg_reset:
> > assertion
> > failed (cap & RISCV_IOMMU_CAP_VERSION =3D=3D 0x10): (0 =3D=3D 16)
>=20
> The root cause is that the qtests I added aren't considering the
> endianess of the
> host. The RISC-V IOMMU is being implemented as LE only and all regs
> are being
> read/written in memory as LE. The qtest read/write helpers must take
> the qtest
> endianess into account. We make this type of handling in other qtest
> archs like
> ppc64.
>=20
> I have a fix for the tests but I'm unable to run the ubuntu-22.04-
> s390x-all-system
> job to verify it, even after setting Cirrus like Thomas taught me a
> week ago. In
> fact I have no 'ubuntu-22-*' jobs available to run.
>=20
> If there's a way to run these ubuntu s390x tests, let me know.
> Otherwise I'm inclined
> to remove the IOMMU qtests for now until I'm able to verify that
> they'll work in a
> BE host (I'll install a BE VM to verify).

You can get a free s390x VM here:

https://linuxone.cloud.marist.edu/#/register?flag=3DVM

Best regards,
Ilya

[...]

