Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF60C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 21:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubnWb-0003lP-BX; Tue, 15 Jul 2025 17:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1ubnW8-0003bI-G9; Tue, 15 Jul 2025 17:48:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1ubnW6-0007hW-CU; Tue, 15 Jul 2025 17:48:52 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FI1bbx008271;
 Tue, 15 Jul 2025 21:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Pny8zE
 XFiwDtVqLt+k6znuKLegCV8NRjy3uhVdC9iOo=; b=Z7HHudyskdP3koEyGaXjay
 QlOJVk6aorfYjek7YsBOvlu82eeCSGB/pZkkl+ipvScudBClJFXGRE//m712dNVs
 +1AWIEYPzN7+dtrZ1mtvNqL+N6/QnfDp10cVrAEcc5mhs3JpA/9jvRvkq+yETBHx
 vo/jB5a79L5Ozw/SrWeC5EpsyvMTTlB+RP1315tnnRTO9gH2Nozh++J7ec4Vlt1J
 IiKBqkgi36eJEyvUwLU4+tk18nlHh63O50+AhoIzPuuBKkZhIu5Q4DVOTQ0ZSMUm
 d1W939swJAFlKWzMJpJOdBE1oviRJx4L+YxqumTdxgkBORXrMTtKUYpaqshnY63Q
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ufc71hs6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 21:48:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56FIUT8b021914;
 Tue, 15 Jul 2025 21:48:41 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v4r344u4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 21:48:41 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56FLmdXm17498752
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Jul 2025 21:48:40 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB0E958053;
 Tue, 15 Jul 2025 21:48:39 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 85D9758043;
 Tue, 15 Jul 2025 21:48:38 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 15 Jul 2025 21:48:38 +0000 (GMT)
Message-ID: <ead03e08-4121-4636-bbdf-77572f42e9f7@linux.ibm.com>
Date: Tue, 15 Jul 2025 17:48:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/28] pc-bios/s390-ccw: Refactor zipl_load_segment
 function
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com
References: <20250711211105.439554-1-zycai@linux.ibm.com>
 <20250711211105.439554-20-zycai@linux.ibm.com>
 <be952290-0791-41e3-bfc7-a22eecfe97d6@linux.ibm.com>
 <310f1563-e04a-4aa2-aed1-ee631676c4a0@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <310f1563-e04a-4aa2-aed1-ee631676c4a0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Je68rVKV c=1 sm=1 tr=0 ts=6876ccba cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=_g1u71sQhU4pD6qgZ1wA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDIwMiBTYWx0ZWRfX1el31TZsdNwb
 oKe+Hn6m0cgojqa1zqqRP7Z58f4FwSYK0qbu9hOl5t3Zzds8szSmTKQLlrcOtRwAVkSkeWgEMYm
 tRm56R5cgUWiO9RjAddIk5dXX4exszVFoCEstQB0u0uW5FrSpbVBmqbq9EBK+YK0IOLwJMB2ge0
 Ow8OKwd8dqa+eDO5AuR7oXUZ1VNs//CxYvTGVJagmQCoW+WH1OmsvLD6cu9BtlSrWbt5omvOqLY
 EQBmWEDcsVLL9UmyFt6YYAUrW2foKRqAall5OY49gaUY5IfJl7v6AK2n36KCjHyvh2huer34nLQ
 8DZlNBAeeGFqrwWYUYfe71UXiDgWW9EawF27R3gRK6VBlJGV9R0VOS0UUrqzg+Zvui4oPP+XE28
 SQV9vdA0QAWj9y/rAar/0+KSHRi7ismmhyouHD5tCSfBM1oI7OtlDKZmY2FbrQZ5hurzN2+X
X-Proofpoint-GUID: yBG_G-akp92V3CMs9dMB_5IT96JgJ6CB
X-Proofpoint-ORIG-GUID: yBG_G-akp92V3CMs9dMB_5IT96JgJ6CB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_05,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=844 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150202
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

[...]

>>> @@ -662,6 +661,9 @@ static int zipl_load_segment(ComponentEntry *entry)
>>>                   */
>>>                  break;
>>>              }
>>> +
>>> +            comp_len += bprs->size * (bprs[i].blockct + 1);
>>> +
>>
>> I'm confused by the arithmetic here.  Why is size multiplied by the
>> block count?  Won't that artificially inflate the value representing the
>> size of the component?  What's the reason that comp_len += bprs->size
>> isn't sufficient?
>>
> 
> A component table entry points to a segment table, which holds pointers
> to code segments loaded into contiguous memory.
> 
> Since segments can vary in length, the block count field may be nonzero.
> 
> Block size indicates the number of bytes in a single logical block, so
> the total component size is the block size multiplied by the block count.
> 

Okay.  After referencing both your explanation and our disk layout docs,
this makes more sense to me.  Thanks!

More nitpicking: I think it reads better to put this line of code as the
last line of the for loop.  That will keep all disk-reading code
together and make it a little more clear that this variable isn't used
elsewhere in the inner loop.

Functionally, I think the patch is fine :)

[...]

-- 
Regards,
  Collin

