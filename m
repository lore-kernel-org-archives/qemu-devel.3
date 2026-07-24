Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CADDC531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 19:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnLnD-0008Ii-To; Fri, 24 Jul 2026 15:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wnLnB-0008Hb-2m; Fri, 24 Jul 2026 15:42:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wnLn9-0003JQ-I7; Fri, 24 Jul 2026 15:42:44 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66OHBkN7556002; Fri, 24 Jul 2026 19:42:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=aaR94Y
 ocVMr3Zfd/G229OFh58aEvNtjo8rK3FdxsWGw=; b=l+9GAicyhtFOObAWcGfFDB
 62MwJ8zU0S69CNcS6HYbZbGdUBFJPs1f+q5Lt0uMOU3VER9s7kwM9zsWFTefh8hV
 mJX8q1buU4g/TGMkkOJNv+piVM1AuTh4qXzQw5+tuClrCFfSJtVYB5yIr/lBYxyK
 2ogzpyEvlszk3R+3gl9gQGMqq+SrJPZCG0KOvu7R1bTUupK0ZimyzAqnsRIQvOpi
 bze0MZh444hUoZgi9oGst+RVcPLsyTStocf/p7SfKPIV498ai9ZeoFREK6AvVPBO
 S8o8RYzc+q3i82kWUEUmDVzWL0AlmKTqXjaQiI2X0yve26ySXmV4IbveM4O5GlSQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8gs9nt1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 19:42:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OJYfK3017180;
 Fri, 24 Jul 2026 19:42:38 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyt4db-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 19:42:38 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66OJgbwV65470770
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 19:42:37 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1AA9158056;
 Fri, 24 Jul 2026 19:42:37 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69B8058052;
 Fri, 24 Jul 2026 19:42:36 +0000 (GMT)
Received: from [9.61.253.58] (unknown [9.61.253.58])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Jul 2026 19:42:36 +0000 (GMT)
Message-ID: <3430e017-88c1-45e3-a5aa-1a7a1ad5dd8c@linux.ibm.com>
Date: Fri, 24 Jul 2026 12:42:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/15] s390x/pci: Move dm_mr from S390PCIIOMMU to
 S390PCIBusDevice
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260724030919.123733-1-kshk@linux.ibm.com>
 <20260724030919.123733-5-kshk@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260724030919.123733-5-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE3NyBTYWx0ZWRfXx9zzOB6Q98mP
 qVg/iOypA7DjuvHoUQKlsJY1WYDvYrkrnmMR8WWpXi8wbQuAjDOcM6ozoUa+XisybCdF3Ppeway
 ni3DJVSVDJRb3H9VihtWVuemafZl098=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE3NyBTYWx0ZWRfX//YbksnzGbRg
 XMzrouAQgR1uR+iN0ZRjtggj5ZAN6qEbQFnWx+HyJn5theMA9Hu9xTuLFD2KFBYi+VjCOV0AqSC
 554pHteNIrn71RXfPSnLNjMVLg1DiGn6tRFK3xnAPEv4w1nz9350SXc7TX6ToEaL17iuK6ROuvh
 CxvlAa5/e1gk7bsb/WaC1i+2kJLskLn3+lCY0MEwsnKqwifrleVlQu/kY0Xwyj6DKAt3zrsbIAo
 OvREzFB5GLXmFtv1oHv+LH5Ghi2C54ElN/zNkLyuE+okmkpfwrFa/5erz7roB0nCd90IgkwIva4
 CEln4RwCsLe2CV1v+2IuJmPi6BAgZY2CUz4JEB5DQWO0xD1XpCygS+5CoR+JcKiTDfhbb+biWZB
 kQi2N92SLcqaAI7EDDnKumEOGU/BVNwzi7IuFB1yWAI+ENshcJTmei5xRtjyIBfHTzSK72Aq1HP
 6EDftR+C2smL2BUkS0w==
X-Authority-Analysis: v=2.4 cv=Q9LiJY2a c=1 sm=1 tr=0 ts=6a63c02f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Z_9tqueNEkMZuojxhz4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 43hrohClHDTpKU8Kyrti_3vHe7lktu1A
X-Proofpoint-GUID: 43hrohClHDTpKU8Kyrti_3vHe7lktu1A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240177
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


On 7/23/2026 8:09 PM, Konstantin Shkolnyy wrote:
> This field is only used when S390PCIBusDevice exists, so it can be moved
> there to simplify S390PCIIOMMU which purpose is just to store the "root"
> AddressSpace.
>
> Signed-off-by: Konstantin Shkolnyy<kshk@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c         | 21 +++++++++++----------
>   hw/s390x/s390-pci-inst.c        |  2 +-
>   include/hw/s390x/s390-pci-bus.h |  4 ++--
>   3 files changed, 14 insertions(+), 13 deletions(-)

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>



