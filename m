Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91ACBF532F6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 08:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4xLm-0004Ji-Lc; Tue, 24 Mar 2026 04:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1w4xLk-0004It-HD; Tue, 24 Mar 2026 04:42:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1w4xLi-00054D-UA; Tue, 24 Mar 2026 04:42:56 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62O5arZC4178383; Tue, 24 Mar 2026 08:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=oqGXyU
 ypB1JfGaftFlkZCJoy44Wg2H9UGDqXuOFTNQU=; b=l/2msU6XqJ8l9ZymhaznAC
 rIoMywA+Hv88fTNhmmFuPiEwAH1YsLldkwK2DWER1rJpdPq/g1PAPLReLCmnb+np
 tDYdE95ghmo4oo/DWkoWd/QuQlyFM+iy/e9i9RrCfVq0vWfdh6CaEK1ZoLZNJcqm
 jC83bOwhG8qWyx1ujru9iUIVkSkmunW1w0V34f/3u4yZqCUElBYO3JMTP/32iLlM
 XkdWdSPGylQNtWUCpRxQhnxnHl0W10RX9Rij0wRxqCPZU+cBdfsoD5bQmwu5oPqk
 Zg6VBo4PrZiNuHaiO6MgO5dCpSc32L/KoZ/b47xrWnf1Xpj5shDxNfmLl1fKSmOg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kw9thqt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 08:42:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62O7QP2Z031687;
 Tue, 24 Mar 2026 08:42:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nss3v1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 08:42:43 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62O8gdrR15991164
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 08:42:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 57D7320043;
 Tue, 24 Mar 2026 08:42:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8115E2004B;
 Tue, 24 Mar 2026 08:42:34 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.27.39])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Mar 2026 08:42:34 +0000 (GMT)
Message-ID: <8cde9a355050b306180f80e8d1340ec814c0876c.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ppc/pnv: fix dumpdtb option
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, Aditya Gupta <adityag@linux.ibm.com>, Harsh Prateek
 Bora	 <harshpb@linux.ibm.com>, Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-stable@nongnu.org
Date: Tue, 24 Mar 2026 14:12:32 +0530
In-Reply-To: <20260323231612.GA2637687@ax162>
References: <20260311143549.118720-1-shivangu@linux.ibm.com>
 <20260323231612.GA2637687@ax162>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: FrXxOc7rgNzTkzp2-iblFXJpU5cCcsgV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA2NiBTYWx0ZWRfX84s+4rHq/5Tm
 MyEfE+mzjkwiu3ocAWHH/CM9w3TEoJlLnYPQlHUghgDTh2cFE/a9Lqkmv2qtbhRO++wwJfUfxVv
 j0syrVyMPRUzMN4aHNUdkbQA+lTFBcp5D4ePIRxWvhr/WUEThU0sh+OURWA6WFshDOmxyUhsWlu
 p4PEKOzX2Pf+SoGDR5D5xql3/48Io1v2N84pHhXovD++v5328VumBTiPP1n2KKrHW+J7sESxldf
 XEWp55gMRW0olhw93+pRnRTAsyb+etp5q7LGEAY4eeKE3kAZNuyViOvIF94CsjUfmiti0jF+VEg
 M8ZjwSdkxJMy9R9dZFkvxN9Zu9Ajzo2zE9c2RVEc+3tujH7n07UV8WuoK8qUQ5vbdsx20+ngO2q
 CgDF+6iLo6bNA9vRESB82RrjToT6Xz7XFV+31CyDb+heO43+JhjbWiEstda9K4vkaKuap1o9I6x
 wZZigugJez9oL1OtedQ==
X-Proofpoint-GUID: 1iQD-BRxY7MPYL5PoB-Jlc7lymfzSr6X
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c24e84 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=p0WdMEafAAAA:8 a=DiSADyN12PveX24rIx0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240066
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, 2026-03-23 at 16:16 -0700, Nathan Chancellor wrote:
>=20
> After this patch landed in QEMU master as commit a16d4c2f16
> ("ppc/pnv:
> fix dumpdtb option"), I am seeing a hang on shutdown. With the files
> available at [1]:
>=20
> =C2=A0 $ qemu-system-ppc64 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -display none \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -nodefaults \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -device ipmi-bmc-sim,id=3Dbmc0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -machine powernv \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -kernel zImage.epapr \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -initrd rootfs.cpio \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -m 2G \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -serial mon:stdio
> =C2=A0 ...
> =C2=A0 [=C2=A0=C2=A0=C2=A0 1.308982][=C2=A0=C2=A0=C2=A0 T1] Run /init as =
init process
>=20
Hi Nathan,

 I have root-casued this issue. During discussion for this bug [1], I
made assumption about dtb not changing during between resets. To handle
that I removed the dt_recreation logic from `pnv_init` code.

But, As in your case the bmc details are provided from command line,
the bmc device is not present during `pnv_init`. And later on during
device initialization it gets filled with correct details. `pnv_reset`
is also called to start the cpu also, So previously the correct bmc
details were populated.

To handle this case, I should add the dt recreation logic to the "bmc
details found" case. [2].

Thanks for finding this case.

[1]https://lore.kernel.org/all/7yq2eac5yzsx2ve2nwbs7uhjguemravsimtm26dkgppe=
czqmix@wtrwux3aeswg/
[2]
https://gitlab.com/qemu-project/qemu/-/blob/master/hw/ppc/pnv.c?ref_type=3D=
heads#L772

~Shivang.

