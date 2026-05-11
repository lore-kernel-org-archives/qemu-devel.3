Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D77CD37B7
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 05:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMJcN-0006lL-CL; Mon, 11 May 2026 01:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wMJcL-0006kx-4g; Mon, 11 May 2026 01:55:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wMJcJ-0004QK-BO; Mon, 11 May 2026 01:55:48 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B31dOP1439978; Mon, 11 May 2026 05:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=zcs/7b
 oKerosyBrlOdKSFXO7NBSMmGF6DenFtAyx7O8=; b=gC4U1opMxseETcbhh08h4d
 qGPV+Z73lue9x4D7ysHPbwVcR5Ajg4OK2wtF0VnGLlX0ek2bB3gVBIIb84nIf7qw
 0uoDbd0XoK5OQHftAkMV7B+WHb0AGaZ2dc6wsKKSGuRIuav/GgVjyOZCElVjx/1j
 ErHQ3ihdR/uUcW4kvpIvKvf23wHekYthszD2ph6XcIcOog9hnvKSPTjqc/BAaToe
 IoSJw8OUmikFPn1PM8wBoXU4uVQ7GMc1Ua3MqfN/69emkZa220qXH7rqyT6EFVIC
 RImZPFGQCk/uh+u3aDz0uW8k+KBfQDjphT4RKI3tDxOd8/kGgb6HfiFt4Bx479qw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1ve6xt1y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 05:55:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64B5sqEF018484;
 Mon, 11 May 2026 05:55:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e2fmvv0t9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 05:55:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64B5taxH45285664
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 May 2026 05:55:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0335320043;
 Mon, 11 May 2026 05:55:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62C9820040;
 Mon, 11 May 2026 05:55:33 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.123.12.247])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 11 May 2026 05:55:33 +0000 (GMT)
Message-ID: <721dded9a7e50500c5b003abb012a7aac807cb2b.camel@linux.ibm.com>
Subject: Re: [PATCH] ppc/spapr: Skip system reset for quiesced CPUs
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Mahesh J Salgaonkar	
 <mahesh@linux.ibm.com>, Anushree Mathur
 <anushree.mathur@linux.vnet.ibm.com>, Vishal Chourasia
 <vishalc@linux.ibm.com>, Misbah Anjum N <misanjum@linux.ibm.com>
Date: Mon, 11 May 2026 11:25:32 +0530
In-Reply-To: <776218d1-c2e2-4c6a-a43c-432027d1958a@linux.ibm.com>
References: <20260430085409.680930-1-shivangu@linux.ibm.com>
 <776218d1-c2e2-4c6a-a43c-432027d1958a@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA1OSBTYWx0ZWRfX4QUZRgTxUBM4
 h4nrvl+3pHJ4Nvaimf1mKhZm6D72yA5gswlmUAyZrjNXT7IOVpJcFskfuRfD9M7/iJ/Ytd7OMYj
 0JgwPgCx4Nq0+YaclguvaO0PEp3CJ2vShkKk3V8e22nnazLo82BfmZt7+6SulRrvZnyCzZc27Ba
 tDemgdReHp331LdY8fojTe6sYjINx/8OqZ4HZeU0VyiLRSPXiNBjbmFaGk0eqm0+P2uRXk1MBn5
 6xtBPys+NRnASqyv4v3mgGkapV41CEhtLuFMUSFK8i1Z1d896vu2W1mzie8jPKASl/cAYO/KFFz
 2RCM5HzFTD/ViXqg8vesj6EQBfhW44jJPOklTEnxj7N1rXXnRLhGED/LXXyqfurMZlEP0YWa538
 K9J+JbBHWCl6iVZ+duSajO9+LMyX1YQge71B49yVBfvn2mGnmGbG/uQ2DjtbXxNkpCiJAIfj5fh
 nU2IxOJesBObsPIiKqg==
X-Proofpoint-GUID: JikyyXvZ2GTR_BE3E-oY1DOMDugGSt49
X-Proofpoint-ORIG-GUID: JikyyXvZ2GTR_BE3E-oY1DOMDugGSt49
X-Authority-Analysis: v=2.4 cv=CeQ4Irrl c=1 sm=1 tr=0 ts=6a016f5e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=8SqjWUzWz8EIUUORS24A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110059
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Harsh,=20

On Fri, 2026-05-08 at 22:54 +0530, Harsh Prateek Bora wrote:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* =
Skip quiesced CPUs */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(c->env.quiesced) continue;
>=20
> Qemu coding style suggests having braces even for single statements=20
> within an if block.
> Please refer Block structure in docs/devel/style.rst.

Ill fix it and send a v2.

Thanks.
~Shivang.

