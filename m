Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8F9CD98F2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc0Mq-0001PF-IZ; Tue, 23 Jun 2026 08:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wc0Mk-0001Mp-IP; Tue, 23 Jun 2026 08:36:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wc0Mg-0004k9-8F; Tue, 23 Jun 2026 08:36:33 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NBmIHv1983848; Tue, 23 Jun 2026 12:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=DjfEkMvW1+uQtps6mRowBedfj0COVgdR2lDQWdQvZws=; b=fq2BCzy1V7UB
 d9+qN7MtFirJO71+ZN7XpcVrRqoONKT0mel0HShbdQSFGR25EkASc3B6KSwwPC0X
 2tDZrl8Yni6r+YeqOcRUFpwWGqGRfDxSEf2oeWjV+12K/3Yzy84AYkAMKgL/tNe3
 03ZXHqgHHqenTJmdihW501CjR+ZeVMshrD/ULENH/ch1BtYl0/41hyQBXTR4WdLi
 9TWLzhbuZFnbbMDADb7TRvf+46R//nDmr3Q0yb6vz3QvgO9H44/a9ULqRnU4asHg
 gKbs7ikncz5siikp4HW+zPQFUnJiIqw8QDEZoqR20f7p6i2a0KFhdyACE2myYWxb
 +eR3ELKepw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3efyu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 12:36:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NCYfge030784;
 Tue, 23 Jun 2026 12:36:16 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qbdn3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 12:36:16 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65NCaEj421365302
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 12:36:14 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 98D1058055;
 Tue, 23 Jun 2026 12:36:14 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B8EE5803F;
 Tue, 23 Jun 2026 12:36:13 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 12:36:13 +0000 (GMT)
MIME-Version: 1.0
Date: Tue, 23 Jun 2026 14:36:12 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Finn Callies <fcallies@linux.ibm.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, linux390-list@tuxmaker.boeblingen.de.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v7 14/17] target/s390x: Support protected key AES XTS for
 cpacf km instruction
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <66653376-f6d7-4370-b963-201053d7e903@linux.ibm.com>
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-15-freude@linux.ibm.com>
 <66653376-f6d7-4370-b963-201053d7e903@linux.ibm.com>
Message-ID: <7a8fed33ff59b4f663a48f18280c5740@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3a7dc1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=h9qcHH6SNZZdh75yfzwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEwMSBTYWx0ZWRfXxZ2JflQrtrmD
 ZM5WC9wN63lXsJERmcV0/DmagH+S9INn1Piu2OPUZQu9SFQtbc9QXmkBcU6ncSNd6Gp6Ajiacme
 z7bB+glSV+HVHuxb1kbvEQWfTxgGfHY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEwMSBTYWx0ZWRfX9R8Xlzh529Hj
 Nt/dGPV3cMTD0UjDfxw+/ZQI+BFE3CGshRmOD5v9apuHqxMF+bsxo/2d2AW2qjE/0Pj19x7NcAF
 7yBpxOu3UGTFQws4d1pLYQbNAeUE/xK9d8tZV9/dOMoveH0GQRRQF0XEF+flv6cYySEp7VnC89v
 MbKl9yrZ7MJT8ziTTxc53abaIJFlu6JrH8I2nA9K2a3mSXFWBDZBnCkVsvQ6KsFbWz9FF2ijTEY
 eoKVs18Ut33nr2fwhobSxY3cVaiZ02xEjx1hpLnsOhZqZvpxVRdpg0a8M93EbL/Vw+uIap++2VZ
 zCvNwHkJvzOj+xPRKcNpErq6bJheSL1kEUpSRN/wGokrOCy9AJ2R01b6GH8GTgKWovZoEX3FeL0
 MmYhEN4sZO964jMTCtnuxK7/x8z5h7LFJ5wLZDaxe1XaX9HNI8y2ZtlT7P92VmOIZnR7Iz2DwLf
 cKMZQDHZntM0nCPnPOg==
X-Proofpoint-ORIG-GUID: WiVLvZ_4k3u4_iWI48m2q88HydO_TboP
X-Proofpoint-GUID: WiVLvZ_4k3u4_iWI48m2q88HydO_TboP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230101
Received-SPF: pass client-ip=148.163.156.1; envelope-from=freude@linux.ibm.com;
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
Reply-To: freude@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026-06-18 08:22, Finn Callies wrote:
> On 17.06.26 11:48, Harald Freudenberger wrote:
>> Support the subfunctions CPACF_KM_PXTS_128 and CPACF_KM_PAES_256
>> for the cpacf km instruction.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> 
> With the suggestion:
> 
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> 
>> ---
>>   target/s390x/gen-features.c      |   2 +
>>   target/s390x/tcg/cpacf.h         |   4 ++
>>   target/s390x/tcg/cpacf_aes.c     | 106 
>> +++++++++++++++++++++++++++++++
>>   target/s390x/tcg/crypto_helper.c |   6 ++
>>   4 files changed, 118 insertions(+)
>> 
>> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
>> index 126bacb281..c4c59c3504 100644
>> --- a/target/s390x/gen-features.c
>> +++ b/target/s390x/gen-features.c
>> @@ -929,6 +929,8 @@ static uint16_t qemu_MAX[] = {
>>       S390_FEAT_KM_EAES_256,
>>       S390_FEAT_KM_XTS_AES_128,
>>       S390_FEAT_KM_XTS_AES_256,
>> +    S390_FEAT_KM_XTS_EAES_128,
>> +    S390_FEAT_KM_XTS_EAES_256,
> 
> PAES or ENCRYPTED_AES

Again - not within this patch series.

> 
>>       S390_FEAT_KMC_AES_128,
>>       S390_FEAT_KMC_AES_192,
>>       S390_FEAT_KMC_AES_256,
> 
> [ snip ]

