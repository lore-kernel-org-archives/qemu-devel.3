Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912E9CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 18:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urKgk-0006Zc-85; Wed, 27 Aug 2025 14:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1urKfo-0005zM-IL; Wed, 27 Aug 2025 14:15:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1urKfY-0003OA-Je; Wed, 27 Aug 2025 14:14:59 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RH6gDE030697;
 Wed, 27 Aug 2025 18:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mjJpzw
 XOnRCY59kMZInre1S7YcxRXFl+fmLkgmwpWeA=; b=QrXyFRqOcEZW+VLdeInmwq
 xnMypS2kzxLRO1AsOEmD1ZQVhK/DpjCum3tfBTkV8vvBpKUr9joNTEJsZCRpEfWQ
 6EB59XNYYjgz14of2Y5dRiLFdvHpJyEq0+EfZpkeT6x8jWuW9d5ZtoUTHc6898KG
 rKwSE8UKupJTdAt5HWT4U63itYGIfNl8KYvJLb0vi3f/RS9dMN8nz4eU3fMLkSeu
 VKOwAa7wxCyEnrr5hCzC69LpZkyku9Ytjc4DyT+Lg5eEjx8cokoVaG/Svtq1xun5
 hrzELp82OOGFchmxnRv3cvG8WujX1tK5nogkPVfXzokQW2ndnakip8w6U9/A4R/Q
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5avnmd8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Aug 2025 18:14:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57RFXTMP007458;
 Wed, 27 Aug 2025 18:14:42 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qqyuhf0k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Aug 2025 18:14:41 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57RIEefj22151718
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Aug 2025 18:14:40 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1018F5805A;
 Wed, 27 Aug 2025 18:14:40 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 086AA58052;
 Wed, 27 Aug 2025 18:14:39 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 27 Aug 2025 18:14:38 +0000 (GMT)
Message-ID: <b30104a2-9e65-4776-9d4e-106adfddf5a8@linux.ibm.com>
Date: Wed, 27 Aug 2025 14:14:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/29] s390x/diag: Implement DIAG 320 subcode 1
To: Zhuoying Cai <zycai@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>,
 thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20250818214323.529501-1-zycai@linux.ibm.com>
 <20250818214323.529501-8-zycai@linux.ibm.com>
 <82c91b19-eb26-422b-9f2b-248ccd45b6db@linux.ibm.com>
 <4cbc7613-aa51-4a3b-9467-2185426b9c14@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <4cbc7613-aa51-4a3b-9467-2185426b9c14@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0uNpDupRp8hMD9_z6zTErb76bAUViQhO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfXxbstoxunRqgv
 /6wvhi+JYX9Em3JxpUZEtSV0IYhzH9meO1JhVi+N/BQgVq+o3OvZMRpzYcrWsnwpgXkHT7EtPF8
 fUmbLPdBY/fjs6mft/2MepzHqAIg0jdc+hmmJBZqJPrqwL7vS++Yv0kaCL4VJwpwJGExr5vUwCG
 iaqczMhJp2l4frFBmgwPxhp2496m0xZ3XOjKfjtKynA18sh0WVYcn4TocqOnky46Z1OgCLXhGHd
 MzObEAaj7nBNbmfOOBm2lh6t9m3/n1Uia8UKhAmr/u80RzRiW8k5Q7SKlvN5NFiwyWhy/iTjbig
 vdIZlb6gxtdY0pPmydfg7ZQc84BXI2XKJSMD54x0qC3dyDUhNVKx6ABzJ79N3FBQGpq0GAYZJkB
 bN46UQ6W
X-Proofpoint-ORIG-GUID: 0uNpDupRp8hMD9_z6zTErb76bAUViQhO
X-Authority-Analysis: v=2.4 cv=SNNCVPvH c=1 sm=1 tr=0 ts=68af4b12 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=p0b7QmCGGhMIWEN_CaYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230021
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
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

On 8/27/25 10:35, Zhuoying Cai wrote:
> On 8/26/25 6:30 PM, Jared Rossi wrote:
>>
>>
>> On 8/18/25 5:43 PM, Zhuoying Cai wrote:

[...]

>>> +
>>> +struct VCStorageSizeBlock {
>>> +    uint32_t length;
>>> +    uint8_t reserved0[3];
>>> +    uint8_t version;
>>> +    uint32_t reserved1[6];
>>> +    uint16_t total_vc_ct;
>>> +    uint16_t max_vc_ct;
>>> +    uint32_t reserved3[11];
>>> +    uint32_t max_single_vcb_len;
>>> +    uint32_t total_vcb_len;
>>> +    uint32_t reserved4[10];
>>> +};
>>> +typedef struct VCStorageSizeBlock VCStorageSizeBlock;
>> Previous versions included a build bug message for the size of this 
>> structure,
>> was it dropped by mistake?
>>
> 
> Thanks for pointing it out. The use of the build error message was
> misunderstood as unnecessary in the last version.
> 
> I'll add it back in the next version.
> 

Yes, this was my call and I should've asked for clarity on it before
claiming it wasn't needed.  That was my bad.

[...]

-- 
Regards,
  Collin

