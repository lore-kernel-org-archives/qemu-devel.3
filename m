Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C0BCD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 16:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLNxy-0003i4-FB; Fri, 08 May 2026 12:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wLNxv-0003go-MY; Fri, 08 May 2026 12:22:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wLNxt-0001Tj-Mm; Fri, 08 May 2026 12:22:15 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6487rmRX1692621; Fri, 8 May 2026 16:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9XH8xV
 DiLVgqUPYS3hlQzprUOe7T6HBhoVFT8+8GL2U=; b=IbAdH0Bsa7bvUhcYiLxcVr
 u4YoPNkcnOds5PlrhwmvOU3AJGAfY5gMhrSlLqKkKj76Pu0MUFm14Ww0Gfsjz+N7
 UEOuf/ZzgZu3Ea2hLDiCn1TlOmBIkVc6uD1B6miMnlk4Lu++S7G0d6wWCFATbq7W
 JFnj91lMlGwGxUS8wB9e38/jWAjO7FUubI0mjQCoZ6zSA0OHX4Oiygrexu1y1cSn
 nlnmVsWMEABgFHTAimHArCp35qqkr+YKUCTvO3r1k58R4kegek8z9++B5CKuk3ju
 8wwbZXhyG01mMKA0b7efLvRkLnFsUwpU4fbNglfppkAPL/srEndRwoIoSyr4lnRg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6u96t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 16:22:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 648G9UvA001819;
 Fri, 8 May 2026 16:22:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3hgw69-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 16:22:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 648GM6k030016164
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 May 2026 16:22:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E22F220043;
 Fri,  8 May 2026 16:22:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BBF3420040;
 Fri,  8 May 2026 16:22:04 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.23.51])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 May 2026 16:22:04 +0000 (GMT)
Message-ID: <bd67aeea764e60b15685d6bcea02042512aa2484.camel@linux.ibm.com>
Subject: Re: [PATCH] ppc/pnv: Fix uninitialized MpiplProcDumpArea struct
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, Peter Maydell
 <peter.maydell@linaro.org>
Date: Fri, 08 May 2026 21:52:02 +0530
In-Reply-To: <73894a74-732d-4912-989b-ddc37567ae74@linux.ibm.com>
References: <20260508142029.624039-1-shivangu@linux.ibm.com>
 <73894a74-732d-4912-989b-ddc37567ae74@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69fe0db3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=J3Ysix8-SOV1uZc6LEsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 0ngfKMEjvYlwFSRfzx2SJ3L4z8m5FrpM
X-Proofpoint-GUID: 0ngfKMEjvYlwFSRfzx2SJ3L4z8m5FrpM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE2MSBTYWx0ZWRfX/pOHMEyImrK/
 Lcsiq1hO+bW8m2VHyqdmUsm75pAWnbFkt3Z2fgikyLLfDxU40AgQIE9eUq2yZfr6K6MW96s588B
 0ec2hlGwJ1EVd2s4wBv61Tb8dJPcBVLUT2kQLc5L2t0UNyrYHzjF5Fvdhoz2564EovB5OPl+JuL
 XIgjANQd0ZSD0HBUO90cRFnt9/mbI10KgCs7I9ywv1CaGtwaphDpK6I981ABMLHVHOewo4DM8B8
 4sx3CnajiAiWuahHcwEgJPcRtmm5gMjfMBIQJK7EMVR3U+I7IY6cAcThtREbBUlpIKANp1fVPKW
 YJARpyiuINIekIjSk7OWVfZAo8roXmjO+8BrCJnLte8A37zYgcyhgQsaowrockV3ED3I1ft47nx
 ddo40hfPKWAezowudHlQLrIR68bK0ydWcCoxfBIlfFIW44kLbSKDjrqrZyjcVA8mlBRY6kIdHDI
 tXyu6YJWVxVkvr4jSMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080161
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On Fri, 2026-05-08 at 21:07 +0530, Aditya Gupta wrote:
> Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Thanks Aditya

