Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F477C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 16:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgmEr-00022d-EQ; Mon, 06 Jul 2026 12:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wgmEp-00021l-Kx; Mon, 06 Jul 2026 12:32:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wgmEo-0003B4-38; Mon, 06 Jul 2026 12:32:07 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666FIJJt4049896; Mon, 6 Jul 2026 16:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YGnvkv
 NBcZaRyeGGSmCphevNmEbwQEThNgV24Nc4JQQ=; b=ShuxbSWy3a+HSYwSx2a4K8
 SFVCipuy+0b3uXaLpO+GE+EadRtVfB1SnhYXLMjH+J8J8+gcET+yDZkjEVYFWnzL
 gDDK9+oVw2DWacf+SZb0qVuNQ1TMXf5pBQLbNrm3zO25gLgVNftKUeRVp8/1LXlv
 kI7w2ispv/0ZRVQ95xiRWmKbYhJ7YeeNco2nnT5/jWvmcUZBmcUK6Go4JuxFgNiW
 /mqO9bKUhDNRaPM31dwulwm7b+mVSZNRCk+y3yRa80CbdN4Ze5UOOBXDy11/JKvE
 PqgdtrFaIzm2R7aIAU4TAlpCBiYvVVg5BDNM/Ofj2aM3MJJMak1/ev+fxDRBliEw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsjvng-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 16:32:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666GJdB2024991;
 Mon, 6 Jul 2026 16:32:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqfx4a6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 16:32:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 666GVwNP54460730
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 16:31:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E423B2004B;
 Mon,  6 Jul 2026 16:31:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A9362004D;
 Mon,  6 Jul 2026 16:31:57 +0000 (GMT)
Received: from [9.111.95.63] (unknown [9.111.95.63])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 16:31:57 +0000 (GMT)
Message-ID: <4a383828-7488-4160-b46b-36f3a3f37b77@linux.ibm.com>
Date: Mon, 6 Jul 2026 18:31:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] s390x: interface hardening fixes
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
References: <20260706091909.864405-1-borntraeger@linux.ibm.com>
 <87pl10jgmk.fsf@redhat.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <87pl10jgmk.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1GF2fsT0RucKijyHo1ZnCGzCcjKP_Lft
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2NiBTYWx0ZWRfX72BsXPnSIlHP
 CUpqozZpGG6ZTtc75fQBryvJkXOkoaVrzVX0XsHfCi0EzIdkuaKdvuQao1G8gStx2fBQjteRM1B
 NxuTZodNuLgyWuycAQPE7q6tO5LUt5s=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4bd882 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=lL1esD3gOx3WIaik-PUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 1GF2fsT0RucKijyHo1ZnCGzCcjKP_Lft
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2NiBTYWx0ZWRfXygOU0cFlGV+/
 7INbIW0Jj0hAAKKkE9F885r5g0AsNlooKs3tFecJRwL2twLsKFhmQybHzuUdE2ew87HmWbT3QhM
 imwSj5xxq8HUX+0fOAr8En8uhyOD+DNBB2l1bPgl5x0Rft+ftZHlFVQwQpRVSXX6nJaOBvw9wUL
 5QW78OYNl+/rTwm5coU3+Ij0t0cbhWCgNrlg2Rw3RkdGQOxzoVmT/GHn/JBtlWhwMocvitSmWDC
 PwU9GOK+Bmu52EX8eH/li038qOWCH+hJ8pVq3h97wkxWqTo5rpv+Ek8Oyhx6PkTjDaS3fQI2CeH
 HyQ5UoSJdZ0nluJOPeXzTWvJ2Zq+MRSVTUKUJG53ZDp4QPU/onB0+PTAdsn9wx8rNvEJJVl+dGR
 Vx79fWA1muVxuQPmObv9K8hK89jRgd1j2bZSBy9JQr+O39qV8+vZ+IYK3ZM9Yrkcd0j4rBZnf9J
 S8sKs09sn1xYi7QhJ0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060166
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Am 06.07.26 um 17:13 schrieb Cornelia Huck:
> On Mon, Jul 06 2026, Christian Borntraeger <borntraeger@linux.ibm.com> wrote:
> 
>> Several fixes that improve the guest->host error handling.
>>
>> Christian Borntraeger (1):
>>    s390x/sclp: reject invalid write event data headers
>>
>> Eric Farman (1):
>>    s390x/css: limit number of CHPIDs in description
>>
>> Matthew Rosato (3):
>>    s390x/pci: Tighten region detection for BAR read/write
>>    s390x/pci: Shrink RPCIT ranges to registered window
>>    s390x/ioinst: Require strict length and format for SEI CHSC handler
>>
>>   hw/s390x/css.c            | 17 +++++++++++++++++
>>   hw/s390x/event-facility.c |  6 ++++++
>>   hw/s390x/s390-pci-inst.c  | 32 ++++++++++++++++++++++++++++++--
>>   target/s390x/ioinst.c     | 20 ++++++++++++++++++++
>>   4 files changed, 73 insertions(+), 2 deletions(-)
> 
> I think the patches from other people are missing your s-o-b?
> 

Right. I guess I must re-send them, we cannot "heal" the patches by
Adding
Christian Borntraeger <borntraeger@linux.ibm.com>


