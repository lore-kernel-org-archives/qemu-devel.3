Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189BFC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 19:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgoha-0003AV-8J; Mon, 06 Jul 2026 15:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wgohY-0003A7-EE; Mon, 06 Jul 2026 15:09:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wgohW-00037l-Vm; Mon, 06 Jul 2026 15:09:56 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666FIMie962178; Mon, 6 Jul 2026 19:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4S07ib
 ieItU/L+f7YaCIxltH1JICl2yo+pbm1s2ehPE=; b=jbVR536EvtSrtgLgG5L6el
 YxR+DCBO32DDognwmQ/BJaxql2x27WzJlkumc6jx/9hLheuO6/i3pWNcW/zBmKig
 iv6Msx2AvxSoTgwFPO9Qayj8/iojE0P02OUVWLT7kN4c8armrdcnKOmZ+Qlbq9na
 ZzGMDXsv2Pc9mOJHtY44wq1OzpMJkyzjwuWshKUX/ET1EK/sgReB61HgeKrpWhda
 yZ03imOjFIS/Kppu629Fp1+htNYJj27Xj+BFRjJ7eOPbevBFm0aNvBMyKvexAXP8
 +eQjg0aCi7WPWKQXDPNlW60UXJcg7IdRHbX/uXocrktFpEr1jLkpx+/EG3zum3uw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqjwe6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 19:09:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666J4dDK006308;
 Mon, 6 Jul 2026 19:09:49 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqfxnpq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 19:09:49 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 666J9lFY49152368
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 19:09:48 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C72375805A;
 Mon,  6 Jul 2026 19:09:47 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2F8B58051;
 Mon,  6 Jul 2026 19:09:46 +0000 (GMT)
Received: from [9.61.247.63] (unknown [9.61.247.63])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 19:09:46 +0000 (GMT)
Message-ID: <3990e90d-2bcd-4d47-b089-dce6a864bc4b@linux.ibm.com>
Date: Mon, 6 Jul 2026 12:09:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] s390x/pci: Tighten region detection for BAR read/write
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, qemu-stable@nongnu.org
References: <20260706091909.864405-1-borntraeger@linux.ibm.com>
 <20260706091909.864405-3-borntraeger@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260706091909.864405-3-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE5MCBTYWx0ZWRfX8bgq1XcLOmi6
 G7SAovrr9KUoSXet5cyzolSjUpCt/WMnernRd4DVpG7P+q6BK30diSSDNR07owv9NaRq6nhZTmF
 fvWmSZPfYlBRugXE1vKccnzWZ/bcWh8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE5MCBTYWx0ZWRfX3FN/x/Gj5NyI
 YKFHOEcs2na62tvb8/8JDSf9RTyI3OX1AaBQYdNV0XYA6WAoh9pxOu6jMQQG3bIDoisL0Pgd1/n
 01kXB3FzXa4RTuTUGAX9RAFtgJUv5sk9QCPomvdtF7xFGMvyRvmeOrRP42Kdnw62mX4pp9eJWVH
 j5nOIcrWk9BAZBbdls139d9Pt2likRQWOQ262EjhzMTtyoysC3yx8nkWRIVN+IKmQgc2buoK+d3
 K0vR9ynAIS67Dq1H+rgTWTQG3ExkJDpEyJYJSw+DdSMuMBMNFSY9Fk4873NP83WyfB1rVq+RU5a
 iqGkxISEF/yuC7CU/fxa76o/bq+Xwp/Q/Rk5KtXI7sa56XcmNcg6QJhKr8aRgEvnhk9sStfmcH1
 CmgQRGFFnGfxId2bAjRHg4oYk1qdIWbTGIiEtsRC6H2g0FcAFZSGpXag7johp7Ho9vyNfi9bIay
 rtNq2Mn2awOO6KPXNuQ==
X-Proofpoint-GUID: vcfbzgPshjw-MaiRip-qFU2OhGUs42nn
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4bfd7e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=BIMvIGbzfbui6xJufPwA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: vcfbzgPshjw-MaiRip-qFU2OhGUs42nn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060190
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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


On 7/6/2026 2:19 AM, Christian Borntraeger wrote:
> From: Matthew Rosato<mjrosato@linux.ibm.com>
>
> For PCISTG/PCISTB/PCILG instruction emulation, ensure that the offset
> and length provided by the guest does not overflow, and only return
> a memory region when the specified offset+length combination matches
> an existing subregion or the parent region.
>
> Cc:qemu-stable@nongnu.org
> Fixes: 4f6482bfe3 ("s390x/pci: search for subregion inside the BARs")
> Reviewed-by: Christian Borntraeger<borntraeger@linux.ibm.com>
> Signed-off-by: Matthew Rosato<mjrosato@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-inst.c | 24 +++++++++++++++++++++++-
>   1 file changed, 23 insertions(+), 1 deletion(-)

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>



