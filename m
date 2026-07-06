Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B013C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 14:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjt0-0000NH-0F; Mon, 06 Jul 2026 10:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wgjsy-0000KH-0z; Mon, 06 Jul 2026 10:01:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wgjsw-0002SM-A6; Mon, 06 Jul 2026 10:01:23 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666BJke33467894; Mon, 6 Jul 2026 14:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ZMzsjs
 QQX7OHb3CEPb+0O9WaNYeUoM4nuiXFiSfJUaY=; b=jeyenesryyrSZkK60cyeBJ
 Wi3vHS5/HqYTIe1UY/XiURKy18FASnCTxqVHUvXS4gnpHIFNaeNyGBmrZKdY+VEy
 Njf5gGbOGHgfco8GAh48AhOTEbjrkEhrIZuV2ZQ3QM9JfKPOTRGyPLwaklCgfjFd
 kiXo7TNwGRHhduyKrQukzOFq+KHtL8wL1XREbDCIARxWZyE0zwxplT5VHHppZ2wR
 GFgZj7UV0yOgizF6cV8MgfXzisYswasYsOwHvtqIdTh658LnBPZyMqwRn/3x7qQK
 MjI58qlqnsYUWG5fvG90Poq2UkuIm0N1Nxe6NVEyfh8xY0CmMwJMEga1NC3OIROg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdjctj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 14:01:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666DndDl008250;
 Mon, 6 Jul 2026 14:01:19 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6xwhd3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 14:01:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 666E1G5Q27263318
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 14:01:16 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 06DF72004B;
 Mon,  6 Jul 2026 14:01:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 797A020040;
 Mon,  6 Jul 2026 14:01:14 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.124.214.4])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 14:01:14 +0000 (GMT)
Message-ID: <ff009ea7aab34ce0f49de8e6a28d9745f437df7f.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 22/28] target/ppc: Move Fixed-Point Load/Store
 String instructions to decodetree.
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: milesg@linux.ibm.com, harshpb@linux.ibm.com
Date: Mon, 06 Jul 2026 19:31:13 +0530
In-Reply-To: <a1b01852-701d-421d-a72e-0d357f40e16b@linux.ibm.com>
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
 <20260520160728.2283628-23-rathc@linux.ibm.com>
 <a1b01852-701d-421d-a72e-0d357f40e16b@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4bb530 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VGsWule6AY4RDN8V-CQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX55xGt6+BLqPh
 h6ed0JSJ1JCwhSH/BVSA8tIXzKwW+mHW+LC4IzWAo1hSQ0Cle3xO+W01o15JCjgT1hfVcNmeBIa
 DaUalpg6pARvIaXxurmK0lkJt24FS2+o+UceX3h94enCgRZWfxONOBRKJhZsTeT/bZxJbTeLyXq
 nPadjk/Ul04gocYWSaP8z6l04dMBQENrGC9CCXjzNw+W6EroQyxM/u+OyV/6hFp1ymbsllT0jHs
 Elo4cPXTwh9sH0vxwQDvHKECBrsrk8Rw3sZsKXwG92UPZFJ883kM6eBfVlhcUWXPmE81asszM6W
 H2Vx1g4agjhM5i704GCBtt83OVrQCgBbRk/PatQV08Fb0X1ZIb2AhdPilAkCRX/scxi26e1ZQUl
 AiquNg+mlnMB5rxj6sTbI1tn2ChmtZLXg7SnzGEZRw7MjWJRgsF7pWfUSNqPZFp88DRZKWG2BDj
 FRWO1ZRVjYfBrcyJAeA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX7ip4Bb/aAht0
 1/mMFDZbELuQN7UIWBZckfU7vSJ/r2dRyFWkW2mabd5rVRy+VDgs/xJw1eVr9nwRYvhz+Vk4bl8
 vE81oT/jxw/dCIC5LwL7hrlxeCoCWUs=
X-Proofpoint-GUID: 4AnSCCQwyWXnDOpyoF6G24bUeGZHVqEW
X-Proofpoint-ORIG-GUID: 4AnSCCQwyWXnDOpyoF6G24bUeGZHVqEW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 2026-07-06 at 14:24 +0530, Chinmay Rath wrote:
> > =C2=A0=C2=A0 GEN_HANDLER(lmw, 0x2E, 0xFF, 0xFF, 0x00000000, PPC_INTEGER=
),
> > =C2=A0=C2=A0 GEN_HANDLER(stmw, 0x2F, 0xFF, 0xFF, 0x00000000, PPC_INTEGE=
R),
> > -GEN_HANDLER(lswi, 0x1F, 0x15, 0x12, 0x00000001, PPC_STRING),
> > -GEN_HANDLER(lswx, 0x1F, 0x15, 0x10, 0x00000001, PPC_STRING),
> > -GEN_HANDLER(stswi, 0x1F, 0x15, 0x16, 0x00000001, PPC_STRING),
> > -GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
> Looks like you have missed adding those ^ PPC_STRING flag checks in
> the=20
> new trans_XXX() handlers.
>=20
> Regards,
> Chinmay

Thanks Chinmay, Great find. I'll send a fix asap.

~Shivang.

