Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADD8F532D4
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 06:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4vId-0007R2-Od; Tue, 24 Mar 2026 02:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1w4vIR-0007M6-Hw; Tue, 24 Mar 2026 02:31:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1w4vIP-0001YG-EN; Tue, 24 Mar 2026 02:31:23 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62O5Ola0506491; Tue, 24 Mar 2026 06:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=UlSC7Q
 sFXEiO7ATeBD3l/pdJcv+f3chbaa6pbS3qByE=; b=ayoBCwNttZVVhG8oAKNsN6
 oCyQP4AX2w9oD7BeiTGGHeplxJxA4E4MG8yYcWeQnRSSVus6LhnsCoumaZdjnjxx
 ZrMqHAunlSGfX83iRV9hyP/kbrkJw1iss01yRFHy6fSa+J0ImCAYk0zFc6pVZ9GC
 HxC0nLrZ8HA6nxIk6pyBjSN+iyv+5CaJbRLJ74omewEmtuP9IFS+u109qJKco9e1
 texobVY+DEh8sZaTttsk+nRsdHHbk2taR5jFQG+8JQbjyLGUthRKRmBiGBUEhje3
 RQEGQhaRzPOefUeXSZMWQ9jM+f7uii9WHdn3/y5DgEtGWTwjDEbi/5dP2OOrH71g
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqa4bq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 06:30:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62O3571R009118;
 Tue, 24 Mar 2026 06:30:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nngg9t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 06:30:56 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62O6UpfB49152370
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 06:30:51 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C51F52004D;
 Tue, 24 Mar 2026 06:30:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0179420040;
 Tue, 24 Mar 2026 06:30:47 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.27.39])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Mar 2026 06:30:46 +0000 (GMT)
Message-ID: <a1c46f0f91ae6d8e35bfeb4a1aaacdb3fd41cb54.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ppc/pnv: fix dumpdtb option
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, Aditya Gupta <adityag@linux.ibm.com>, Harsh Prateek
 Bora	 <harshpb@linux.ibm.com>, Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-stable@nongnu.org
Date: Tue, 24 Mar 2026 12:00:45 +0530
In-Reply-To: <20260323231612.GA2637687@ax162>
References: <20260311143549.118720-1-shivangu@linux.ibm.com>
 <20260323231612.GA2637687@ax162>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: weUmnclqJudOzndrOxFiShpJyC92jTt0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA1MCBTYWx0ZWRfX6nXwHM4cSp+f
 F3gfzJjLtK2WyU+5Ni2z49A1x9a+ygYApCZEG4i6R3TCbhhjd2+zYRuh3GmMR8hXMYreIWxVv3i
 K/CkoRJceqoyeNFG+iA53G5r13TwjtJQWff+4Gkmm+Mxb4zV4ngLNnpux8dYsmdJo84/4hRFfeL
 gHob3Rh3j02DQyBdFz3ARPeKeDQvAwmBXKuHDWldY0iCn00/cvtTO4jFqvZHmo1vbDUz1uu7h7+
 tMFEtKrcnAhyprdKirukYjkYl4N7nw/pIJOb2GX6/3Dqo0+3t9G66YcLgI0AtwEjnOHm2ISg8oP
 GI7645rt079hw5l+5YsAF5G9Yuutbq3vxYp8SQzCUVsOcsdT41ANPHEI7gevZPiDBajv4ArpSU7
 jT81K9ZSuzINMEnxyVnEfzRyziPtlrx+X68K6U21xIU1VtYvAbKW5sgOiyIrQ6NEHXJacGoEdzs
 gbeDLXCsRdFss4hWyfA==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c22fa2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=NEAV23lmAAAA:8
 a=r6kEJVaEsWYU55XCqSoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: O5YMz070utKZU72MPwp-DMDz9S4be2No
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1011 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603240050
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
> and QEMU just hangs after the shutdown print. At the parent change,
> the
> machine shuts down cleanly. If there is any other information I can
> provide or patches I can test, I am more than happy to do so.
>=20
> [1]:
> https://github.com/nathanchance/bug-files/tree/4e7f04b87d0f8c604365be15f1=
dead97a08e5aa4/qemu-a16d4c2f162a86db1f84ef0836d42eabaf57fe69
>=20
> Cheers,
> Nathan
>=20
Hi Nathan,

Thanks for reporting this, I am looking into this.

~Shivang.

