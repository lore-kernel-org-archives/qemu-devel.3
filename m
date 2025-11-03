Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D664FCCFA04
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 09:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFr9x-0002N6-ET; Mon, 03 Nov 2025 04:47:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vFr9u-0002MP-CC; Mon, 03 Nov 2025 04:47:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vFr9n-0006Xy-1i; Mon, 03 Nov 2025 04:47:30 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A33P4xx029163;
 Mon, 3 Nov 2025 09:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=bPDfMg
 sWdqATbCjh6IV3uuTcpC+yd+RCZN3XxC1vgt0=; b=QA5N3dJY3ZlKA+7ARe5I5N
 Y9mGGAHOwSroVniRA2li88HSpJVjKUI2uWGKW2qvPzPtqsfWxiSbyZ2txwWyoHBu
 FO+LJvCMP2vW6D/8qMYmp1tMuYZ+g1B4b+CjLZcTbyV/LgP5BjmTcOqn4NznCH57
 N0wvK8YPDDSLMYIth0IxuLry5v0QSDeb1IzxGHl+sjPCppnnn7bUYEDxuy6g9bUA
 KZRTV+8tBB1jUezWGA9AVfE2x3fIe2iDTlPVc9uBhLPOjyKwBRKKjMgJjbvTCLrJ
 uBix57nVJaxvizv60XOdk2h8YXB2XhSiasuQTbdgCk/XcPjBo0Ut/W9MgTiK4jOQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59q8nxny-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Nov 2025 09:47:13 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A39i00Y027162;
 Mon, 3 Nov 2025 09:47:13 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59q8nxnu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Nov 2025 09:47:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A37Wcvs018667;
 Mon, 3 Nov 2025 09:47:11 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5whn4xxh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Nov 2025 09:47:11 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5A39kwCJ30409244
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Nov 2025 09:46:58 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 77C0D58058;
 Mon,  3 Nov 2025 09:47:11 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 950E458059;
 Mon,  3 Nov 2025 09:47:09 +0000 (GMT)
Received: from [9.124.213.97] (unknown [9.124.213.97])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Nov 2025 09:47:09 +0000 (GMT)
Message-ID: <8ad81131-3e39-4bf3-bfa3-f8011c5bada6@linux.ibm.com>
Date: Mon, 3 Nov 2025 15:17:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ppc/pegasos: Fix memory leak
To: Peter Maydell <peter.maydell@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>
References: <20251101165236.76E8B5972E3@zero.eik.bme.hu>
 <078c2da0-ac1e-4f07-a777-d8615a4456bd@linux.ibm.com>
 <CAFEAcA-4bJaJyOYdTeBsb0KdKRj6q-ABGRzT2rQk1psNakkfLw@mail.gmail.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CAFEAcA-4bJaJyOYdTeBsb0KdKRj6q-ABGRzT2rQk1psNakkfLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=StmdKfO0 c=1 sm=1 tr=0 ts=69087a21 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8
 a=s0EiKFZlAbcSFnNId94A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=cvBusfyB2V15izCimMoJ:22 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-ORIG-GUID: iL0epHTEJQ-Ob6AiWzjmJyrLaob8sDx5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAxOCBTYWx0ZWRfXwYKCLmJYWOhM
 c3xJ4w9cfnHO+0TjmZ5A2dQMy4KeEIGaItqiEQ6loi8vShasNfr1J/ue9frpNhMKN0AKkuOiaYq
 5fZn1eHTIE6LcEwA/90SuR2tgM+1bp3gEtY+OzNPF6Cj5V6PJ8OWVX2Q4SdiYIITHgxr3fc5n2J
 yMgpdtpDj0Sx46Gw9uChS3QnYjuTg9ukKcHHjN+b7/alzs16AOvumvyyiYHeAJF5E88bh160bWi
 7P1RvKyhZx3U7pIQAW8hzVNjYfLAJ9oHQ8LXlC0kh/aYq95pSRnKcAan7L5Eeg6JhqN4eDNf6Et
 m6wODDlgtzVJCNFZ9cZ8hGmCW1aqWOHJKjXe36bEDqGFY9tL+BAKB4jopLc1wgjrlM/J3Vp2afA
 fTdRmdm6IRZ59WQXfKxi+Mqb4cK/9g==
X-Proofpoint-GUID: 9i6tZ8_qdzV1TbosSVuKxh54OkzLRSNt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010018
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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



On 11/3/25 15:09, Peter Maydell wrote:
> On Mon, 3 Nov 2025 at 02:21, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
>>
>> Hi Balaton,
>>
>> Thanks for taking care of this ...
>>
>> On 11/1/25 22:22, BALATON Zoltan wrote:
>>> Commit 9099b430a4 introduced an early return that caused a leak of a
>>> GString. Allocate it later to avoid the leak.
>>>
>>
>> I think we also want to mention:
>>
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> 
> You can if you like, but it's not essential -- I just
> forward the info from the coverity reports.

Sure, thanks Peter.
I think now that I mentioned it, b4 am will pick it anyway.

regards,
Harsh
> 
> -- PMM

