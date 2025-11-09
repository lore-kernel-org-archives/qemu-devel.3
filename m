Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100F2CCFA1A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 12:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI4cV-0004BC-B1; Sun, 09 Nov 2025 07:34:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vI4cU-0004Ax-HA; Sun, 09 Nov 2025 07:34:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vI4cS-00043G-Ud; Sun, 09 Nov 2025 07:34:10 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A9BM0kO007010;
 Sun, 9 Nov 2025 12:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=53lR4i
 5vu49mlV9CgKYyZ2oEHdvTfKNQ9VrqEC9Ymdw=; b=MYLaN5UOYBatpRWi9s3Qc0
 ur1nfRjPYg4BPRdigl/Sa4fwGkh+WN4vy2EMZcMVclbYwBnJ7iUxZu/EcI2QxCJ7
 py/u7+8FGcNySD+MLiR0qjI9W1o9GLKql139co5ObJl3i8W+xz2GtP1kCzpS7cdF
 ZFyaaLAyZ2aN/XXNeSE28CcJoGX01QtuxnxCcMaPufVRX9ton1rB28hL152a5yrG
 QMdoKJ3EHS4dd0xf1Cu1qTmGQRdt1CCTKvShR6cfJFpMNuBNLiE2LLvHu+nbeTsb
 f5mdpPdFJ81ZAMwvWGkPcfKzbOp2okjeCoKrshBkugdXM+j5gt0yxyHQ2uNFiSeQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wc6vdvh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 09 Nov 2025 12:34:04 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A9CY3Nw000329;
 Sun, 9 Nov 2025 12:34:04 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wc6vdvf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 09 Nov 2025 12:34:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A971gCI015147;
 Sun, 9 Nov 2025 12:34:02 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aagjxhkgx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 09 Nov 2025 12:34:02 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5A9CXm4I58392966
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 9 Nov 2025 12:33:49 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 76A9B58059;
 Sun,  9 Nov 2025 12:34:02 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8572C58058;
 Sun,  9 Nov 2025 12:34:00 +0000 (GMT)
Received: from [9.124.217.7] (unknown [9.124.217.7])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sun,  9 Nov 2025 12:34:00 +0000 (GMT)
Message-ID: <04809969-5de3-4cd5-9919-405a0b2cf09a@linux.ibm.com>
Date: Sun, 9 Nov 2025 18:03:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pc-bios/dtb/pegasos*.dtb: Fix compiled dtb blobs
To: Yogesh Vyas <yvyas1991@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
References: <20251108193717.DADA9597302@zero.eik.bme.hu>
 <b32eeb42-66b4-4dff-accd-cab187ef073b@gmail.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <b32eeb42-66b4-4dff-accd-cab187ef073b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAxOCBTYWx0ZWRfX1WliIHgNYn/o
 0yiIhvxFck1eELyHcAnvQD67oPgT1DDEyJzqWdgE0nwm8o5BPeS1svHCRYtQGKvYPjOrojUkxLW
 k6V/chiI+nc5ZNFeXs9sA6uVBbL5VkCWMFE6TL3tzoBtn5nvwaUd1O+mwmV7fVQjfOybi8PMMHX
 VOrkj2e0iZkME/XqFh9B/kZ4QhruJ1SR/MSb1BlGh8Agk4KUY3SR+Kc/uN0ylVVwj1hdCdR26vf
 hLR9xYDUsICzZYhiDoH8R5DHHiobVB0M0nsxMNF6eDiC/bNSVW5RX7JmAthgwMWZa+4saP5K+tF
 6MmBQqD3dT2PN32Tzm5zqsWqRbr10YHTWCs9bWPbOT4+/I0jZm0sY0g+VkpUb31ilvwJ0tTvzAU
 QoEdbN+egNZdxx/OPeK8QlS/ihKT1w==
X-Authority-Analysis: v=2.4 cv=GcEaXAXL c=1 sm=1 tr=0 ts=69108a3c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=9Cm5Y8c7GxDTzpMygq4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=oH34dK2VZjykjzsv8OSz:22
 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-GUID: saXKy6_BjZubvXJB69UQU8lzx60bSDia
X-Proofpoint-ORIG-GUID: _A-1_8UTtbS_m6NwShs3IDtEkZ8W7ZfF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080018
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 11/9/25 01:41, Yogesh Vyas wrote:
> Hi Balaton,
> 
> I just tested after applying this patch and it seems to solve the issue.
> Thank you very much.
> 
> Reported-by: Yogesh Vyas <yvyas1991@gmail.com>
> Tested-by: Yogesh Vyas <yvyas1991@gmail.com>
> 
> On 11/9/25 1:07 AM, BALATON Zoltan wrote:
>> When adding these files somehow an incomplete version was committed.
>> Regenerate and update these dtb files to match the dts which fixes
>> problems caused by missing nodes in the dtb.
>>
>> Fixes: 9099b430a4 (hw/ppc/pegasos2: Change device tree generation)
>> Fixes: 3c21f9dfcf (hw/ppc/pegasos2: Add VOF support for pegasos1)
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>> v2: updated commit message to mention the two commits fixed here
>>
>>   pc-bios/dtb/pegasos1.dtb | Bin 857 -> 1975 bytes
>>   pc-bios/dtb/pegasos2.dtb | Bin 1701 -> 2963 bytes
>>   2 files changed, 0 insertions(+), 0 deletions(-)
>>

Queued, thanks.

