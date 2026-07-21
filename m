Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA5FC4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 09:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm6b5-0003lA-Dg; Tue, 21 Jul 2026 05:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wm6b4-0003kW-4p; Tue, 21 Jul 2026 05:17:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wm6b2-0000fh-LQ; Tue, 21 Jul 2026 05:17:05 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KNCmmS3563422; Tue, 21 Jul 2026 09:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=cLp9GC
 NpuhEzxuFpHaRSWfIXPGvBtdWMZbwk1WsWqMA=; b=YN6XT7mEwOAPOlK1If2KYX
 G+xUND0FobUFXpT6ZWjedq1cq2Z3Ct1NYCJDln8K9Bj8AGkYGq0B8xXQbna/pqHS
 ffka9h2QaNz5QP6A2aZt3+TeV5O2oYNKzCMRYLxXyLCvuysj3RL7ITMfzACVtHl2
 EXNon/grPDr69Sj9pzCJAGdnjthaCOrgDYju6zQt7j0Vi1OK1wq7tSpsTsxhGSwZ
 +oh/z/BO5c3GKb4+OI4nl5VZOmDJge5ll39TtUVuvp5VW3N5naRAaJgiPCejc61X
 T+fqnOG8FC5jMWxh2xvmkmaAeYSOUfUV36TDahACd8JAc9n1XjwqYFWntM150TbQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg790usex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 09:17:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66L94c1k015152;
 Tue, 21 Jul 2026 09:17:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktq1sse-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 09:17:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66L9Guv142008960
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jul 2026 09:16:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 631E52004D;
 Tue, 21 Jul 2026 09:16:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B00020040;
 Tue, 21 Jul 2026 09:16:54 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.123.12.247])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Jul 2026 09:16:54 +0000 (GMT)
Message-ID: <48367a566958f46f06914d804b9158cf62218d96.camel@linux.ibm.com>
Subject: Re: [PATCH v2] target/ppc: Move VMX integer arithmetic and BCD
 instructions to decodetree.
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: rathc@linux.ibm.com
Cc: harshpb@linux.ibm.com, milesg@linux.ibm.com, npiggin@gmail.com,
 peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 richard.henderson@linaro.org, stefanha@redhat.com
Date: Tue, 21 Jul 2026 14:46:53 +0530
In-Reply-To: <20260721091344.52129-1-shivangu@linux.ibm.com>
References: <20260520160728.2283628-24-rathc@linux.ibm.com>
 <20260721091344.52129-1-shivangu@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: dF8cPhXIeX7SXknrxUeWlC-7lh8ZLvaf
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a5f390d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=_p7Ppdw_4vXb_FbOKpMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA5NiBTYWx0ZWRfX+pNSCS28WENV
 OO31QA7X2fh5KRRwQFlTS1rZ3v1p1c8L5z2XQj3VIh+GlZqv0/w2SDd9HMniEhl9jIeVEwrtodw
 lNJfTpdWAwf6vsreH3p6t3W53sDBM9k=
X-Proofpoint-GUID: lZs1EDowZimO32tj5r_1AKr33YMNJQBa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA5NiBTYWx0ZWRfX+JQJzlhO0Rmu
 iPMhMsrForuNgJgPA8UjpSyRas8EcLDRe8NDZkQERFbk33pUNZ6AhDs37YnnAO+1TmTVUxYYDxc
 i8HaIOlQmrRdvDDXic810JwZTcLhaU2pN7JCWcvkcdCeBimQyLQpxCny8qV9OgsZALp6cY/Kv9e
 yEDMh8CLHZI1DWunuc1uczbk2/g72V5ac5bDE96PzyIhkEf0x1k3jjo/uCj7r/xYGf+VGBvZKQk
 9jhl04Eb31bVq4dyKtA466fapP3vblpFInyYPD1oQuHqNb5Q1Cxgt/nELCgu1kYPayuZDnkvPEG
 9aW+vRUHWgJooX5q8VLT0Zbm5EbASXpT6HY75g40ex7fpuKD1xLvEEhyqozoBLY+WOgajwhZV42
 iWR7guD9quCsxADBL9V1Y5ioxyaOsDrmUPbouxjqOPUByCAwC09w5adpowcfVGQZPpEn6EStMGN
 dReBr3HI+dvHG+kgksg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210096
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On Tue, 2026-07-21 at 14:43 +0530, Shivang Upadhyay wrote:
>=20
> The changes were verified by validating that the tcg ops generated by
> those instructions remain the same, which were captured with the '-d
> in_asm,op' flag.
>=20
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---


Forgot to mention Changelog, I'll do that here.

-- Changelog --
Since v1:
	remove the dangling macro GEN_FORM_V.

~Shivang.

