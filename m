Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED2FC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 15:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3GU2-00048J-7I; Fri, 11 Apr 2025 11:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1u3GTy-00041r-Ou; Fri, 11 Apr 2025 11:39:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1u3GTu-0003cA-U5; Fri, 11 Apr 2025 11:39:54 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BE3YV1017271;
 Fri, 11 Apr 2025 15:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=oURppQ
 40FVpyQGW2FcMCiUn7+Hr90rzXaujRYAUBhSA=; b=Yr85Wj9MVokwLmHIwgz11a
 YEGKwsbW+k4MvCb0wxjdgtlj1+7XjA3gyRyqfC9NrrXqHSPak25k3qtUshNr+lpO
 vCnBeSPq69XY0qNDxyAzIgbtduzlxfbe8htdEepuG1S+pcFbNtDCYQcgnvNIOe3x
 QdxvalPPoIzw00vHM1muBjmZ9xvTxSC5oUO2Ns2n4Sp0uQDCeDwxZRU+g3cbYu6C
 gzo5ZNO3T6UOnWBxCt+0gyiafwwEIzIY3lnW98Cc0pUEVXrdaL9rZ59S4nT16iuP
 ODOzCzbz4GRCoUmNjQ32Hn8H/sDPsYnEZ/JIOIfA7pDUeTcxAqB8wclXhFXj9/CQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45y4gqgf5u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Apr 2025 15:39:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53BDvYXn013915;
 Fri, 11 Apr 2025 15:39:39 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufup3jc3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Apr 2025 15:39:39 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53BFdc4f28836394
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 15:39:38 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E64758052;
 Fri, 11 Apr 2025 15:39:38 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C54FB58045;
 Fri, 11 Apr 2025 15:39:36 +0000 (GMT)
Received: from [9.61.169.61] (unknown [9.61.169.61])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 11 Apr 2025 15:39:36 +0000 (GMT)
Message-ID: <630be5a9-c27d-40c4-95b3-139e8fcb355d@linux.ibm.com>
Date: Fri, 11 Apr 2025 11:39:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/24] hw/s390x/ipl: Set iplb->len to maximum length of
 IPL Parameter Block
To: Thomas Huth <thuth@redhat.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, fiuczy@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 iii@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250408155527.123341-1-zycai@linux.ibm.com>
 <20250408155527.123341-14-zycai@linux.ibm.com>
 <3033a0df-44d5-458d-b738-cb93456e9f75@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <3033a0df-44d5-458d-b738-cb93456e9f75@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pcMdfj_SCHE9fYClBnkWBRCX7cOURNIg
X-Proofpoint-ORIG-GUID: pcMdfj_SCHE9fYClBnkWBRCX7cOURNIg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=936 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110095
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 4/11/25 10:46 AM, Thomas Huth wrote:
> On 08/04/2025 17.55, Zhuoying Cai wrote:
>> The IPL Information Report Block (IIRB) immediately follows the IPL
>> Parameter Block (IPLB).
>>
>> The IPLB struct is allocated 4KB in memory, and iplb->len indicates
>> the amount of memory currently used by the IPLB.
>>
>> To ensure proper alignment of the IIRB and prevent overlap, set
>> iplb->len to the maximum length of the IPLB, allowing alignment
>> constraints to be determined based on its size.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>   hw/s390x/ipl.c | 6 +++---
>>   hw/s390x/ipl.h | 1 +
>>   2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index 59ec81181d..b646fcc74e 100644
>> --- a/hw/s390x/ipl.c
>> +++ b/hw/s390x/ipl.c
>> @@ -460,7 +460,7 @@ static bool s390_build_iplb(DeviceState *dev_st, 
>> IplParameterBlock *iplb)
>>               if (scsi_lp && strlen(scsi_lp) > 0) {
>>                   lp = scsi_lp;
>>               }
>> -            iplb->len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
>> +            iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
>>               iplb->blk0_len =
>>                   cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN - 
>> S390_IPLB_HEADER_LEN);
>>               iplb->pbt = S390_IPL_TYPE_QEMU_SCSI;
>> @@ -471,14 +471,14 @@ static bool s390_build_iplb(DeviceState 
>> *dev_st, IplParameterBlock *iplb)
>>               iplb->scsi.ssid = ccw_dev->sch->ssid & 3;
>>               break;
>>           case CCW_DEVTYPE_VFIO:
>> -            iplb->len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
>> +            iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
>>               iplb->pbt = S390_IPL_TYPE_CCW;
>>               iplb->ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
>>               iplb->ccw.ssid = ccw_dev->sch->ssid & 3;
>>               break;
>>           case CCW_DEVTYPE_VIRTIO_NET:
>>           case CCW_DEVTYPE_VIRTIO:
>> -            iplb->len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
>> +            iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
>>               iplb->blk0_len =
>>                   cpu_to_be32(S390_IPLB_MIN_CCW_LEN - 
>> S390_IPLB_HEADER_LEN);
>>               iplb->pbt = S390_IPL_TYPE_CCW;
>
> Wouldn't it make sense to only do this iff the secure IPL is also used?

The size of the IPLB struct itself is always the 4K max length, just 
that most of it is (currently) unused reserved space at the end. With 
secure IPL this matters for alignment, because the next block (IIRB) 
must follow immediately after the IPLB in memory, but I think in general 
the length of the IPLB as a whole should be 4K anyway, since that is 
what's actually allocated for the IplParameterBlock struct.

>
>  Thomas
>


