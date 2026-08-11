Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEAFC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 17:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtqYZ-0001GA-BE; Tue, 11 Aug 2026 13:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wtqYJ-0001FH-VY; Tue, 11 Aug 2026 13:46:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wtqYI-0002NX-2U; Tue, 11 Aug 2026 13:46:15 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BGVR443260533; Tue, 11 Aug 2026 17:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=AVN/0u
 ryYidjWfCD0rDE0d7QZR3jczuK96jA77B7VtE=; b=AI23AzpZOQV8tYgS1kkK0w
 cmqKaFfNspIhyFno9gSze1WYkmMr3YD01Fhe7K0/E2CMIf5tzIT4rgfPng8322w7
 +VT+Eh3lVD+L1t1eOYbFfX+vCSsRvTTPsTQ8SeiMJeTmUARMNlU6dmKePV7ER00s
 nNNoQcnoNl3YPDqnqLGQhQu0tvlgGv2Xos9EdwcUNxZKxV10VrNZTwz97gRwcBVA
 ZC04pumdBklF4TSIHciCxSMKArDsxy3SsUd49lA/PaIP02reACRfYvirWrdl4ns0
 itPZ6uySGjOYdSOuUlN6j4AKO4Z/rfqy0O8rSmIq2BKTF0FFXLzSl2TZPfZ6iR8g
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjyx8du-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 17:46:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BHfPnH018831;
 Tue, 11 Aug 2026 17:46:08 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy1u0m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 17:46:08 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67BHk6GF14680798
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Aug 2026 17:46:06 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D13D5805A;
 Tue, 11 Aug 2026 17:46:06 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9CDF458052;
 Tue, 11 Aug 2026 17:46:05 +0000 (GMT)
Received: from [9.61.240.229] (unknown [9.61.240.229])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Aug 2026 17:46:05 +0000 (GMT)
Message-ID: <67d90549-72b9-4b9e-95cf-b4afee18509c@linux.ibm.com>
Date: Tue, 11 Aug 2026 10:46:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/15] s390x/pci: Add a comment explaining S390PCIIOMMU
 purpose
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260807170812.658820-1-kshk@linux.ibm.com>
 <20260807170812.658820-14-kshk@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260807170812.658820-14-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE0NyBTYWx0ZWRfX02Ocoh3QhRII
 0Hf6s8OTvrJAp3EUvEOV/yTXgocDQqe2TFwOiXRT9pgSZWhuvlViHt3gCGLNMLOZzZ/9ntnbTP7
 BkTPbG3L3ccyhb27TSia10N8If5zRniMDMWyVfmBQQUlgoEPONoOhTHfiifKjvgW3ejy1MXWRqd
 eCEm/kAIHb/fxm5Qgk+q0eGeOO3iN4xP6rGEQnIpj6uZgHIGPifNqd1iRmOuZTMY+q1BJV6aA4G
 nINc0z5ioDo+pAs/qp/zwjZ53VZNo/8o1tdbHRbNflNQgFvD3gibj0IH9CCB6+Z4zgVErA+6IgR
 OpS09fy/ReTEt1qHaHeRLEzvTBA5AHIDA8VhqmyI8jtJkAEmlyY/0eJOfp2nCdgN0qTlxQVyh1q
 yAvHF49Uer/knrbVlydGUTR42wOjk0igZVfpv7+5iptacf6X67ATzi1lzPOCbaejxpFVZTP8qG6
 LD1IvXMEcHUR69k7dUQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE0NyBTYWx0ZWRfX45n1K2LNzYlT
 0TFMkaqenuc8qzF5bccC/t6RWLllUdUdH1TTJSuDJAGkyiEorNM9YYWKZThDJmJivMqN95kJcfi
 UD35hN89RAX9JWLTA4VPR1di17FhWTY=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7b5fe1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=bOLWJr1kWnAakH31W_MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mlAb-vYMz9rWBmr6kXZLiImQItU-WiKz
X-Proofpoint-ORIG-GUID: mlAb-vYMz9rWBmr6kXZLiImQItU-WiKz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110147
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


On 8/7/2026 10:08 AM, Konstantin Shkolnyy wrote:
> Because S390PCIIOMMU has just been cleaned up of fields it didn't have to
> carry, add a comment explaining why it exists in the first place and
> discouraging adding more fields to it in the future.
>
> Signed-off-by: Konstantin Shkolnyy<kshk@linux.ibm.com>
> ---
>   include/hw/s390x/s390-pci-bus.h | 11 +++++++++++
>   1 file changed, 11 insertions(+)

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>



