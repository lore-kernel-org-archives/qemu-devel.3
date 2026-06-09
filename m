Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87E7CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 21:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX4NP-00009h-MS; Tue, 09 Jun 2026 17:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wX4Mv-0007vH-6u; Tue, 09 Jun 2026 17:52:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wX4Mr-0001SR-NF; Tue, 09 Jun 2026 17:52:20 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659HZ95l3019572; Tue, 9 Jun 2026 21:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=bARAb8
 /mpgzNFEFTTfLrc9gtsFO66OT4Lku8Fy5zH6s=; b=QZDwg6cIr/JUCb+gattwtX
 mnY2Kfs7LgQ4Ggsps+5OxSJsxcoQnZxTIe4vJ/pk9704kHvDfjW8/GnEUQwdrMca
 gZ8jsWej/7LEhS/MvI8HR0d1ygWY/WHm9Y8pOhkBW7YzMbyl3h3NzBjK8NFDBFnq
 hBZvZACz0JlHhULWj5RzugSO1TF2WPD7RbZAxmVsemF4yGzAx8Ca0lQmgy7AFZWI
 qIXOt7dO0e+s1Y408WwE774Gj9bToEQPIKfm7ElE/Zyj/5QJhIxq8N3bRUdIVfeP
 EYAxfdMdEnA2Ytw/Xrh9VBNwOX5RT7yt6te5aCiREmFdUy3Fzcn+VOvcfMl6dpJg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qpdh7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2026 21:51:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659LnbnD029817;
 Tue, 9 Jun 2026 21:51:57 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jybqgg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2026 21:51:57 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 659Lpuqo32047622
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jun 2026 21:51:56 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1633B5805E;
 Tue,  9 Jun 2026 21:51:56 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E739658051;
 Tue,  9 Jun 2026 21:51:54 +0000 (GMT)
Received: from [9.61.12.186] (unknown [9.61.12.186])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  9 Jun 2026 21:51:54 +0000 (GMT)
Message-ID: <2635b777-34d9-4add-870d-0de0902c5e3e@linux.ibm.com>
Date: Tue, 9 Jun 2026 17:51:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 09/32] s390x/diag: Implement DIAG 320 subcode 2
To: Jared Rossi <jrossi@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260505201905.997996-1-zycai@linux.ibm.com>
 <20260505201905.997996-10-zycai@linux.ibm.com>
 <ce623f2a-9247-4a67-98a0-7a180fdb88ca@linux.ibm.com>
 <053fe695-54a7-475e-b7f0-11a7eb34f67c@linux.ibm.com>
 <febb7ef1-4059-42f2-9ec0-4beac378cc45@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <febb7ef1-4059-42f2-9ec0-4beac378cc45@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a288afe cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=20KFwNOVAAAA:8
 a=57xXvlBjRI5xFtRfWcwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: r-NhG_onf2VpasidIwG6SuSkw9NMP2QU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIwMyBTYWx0ZWRfX3ZOSXO+kU5uj
 YylhDQ6+PK4rkXdDAoJl8GQ+Za5jzhhFW+OtScpIzYWfQ5fRSC1KnhWgoKid8SVweIJjGSarW39
 mWC0szrhpHBLZrMl/qjOq/eY7EhmPIv4w1eR4fQcIMmRkZ0plpTATT5hbNXqW91TD0KeOIoqCiH
 GtzzJYHFYmFWW8Ah57en1sCW/d7Sd1d6UQlXykbe9HIU/uDGysl9qTBxGDcBByF4KyVOgfziSvl
 PHAclBtCCTt6rQsfYHhm5nY7c2UpXnYIVXsU6JDNoEDqOI/ifEK/jDoE7pUALHhmqG0aboz2n8f
 ao3Pd4icGj5QkLKF7GIZ1+GxJAOK3iuu6aQSkKcK5r1lfO9IvviJiIoh2J6FLbCVdIz7iwsmV8j
 nqsMziYpYxJTwRg4csdEKx0Y7px7t6ZBa65wUdjG2Oyr3PgWSsyonQI9PfRqySs5ya9Pd7Hot8H
 zHZlZv43PEgMkq28jVw==
X-Proofpoint-ORIG-GUID: r-NhG_onf2VpasidIwG6SuSkw9NMP2QU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090203
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
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

On 6/9/26 1:42 PM, Jared Rossi wrote:
> 
> 
> On 6/9/26 11:28 AM, Zhuoying Cai wrote:
>> [...]
> 
>>      vce_max_size = sizeof(VCEntryHeader) +
>>                     ROUND_UP(CERT_KEY_ID_LEN, 4) +
>>                     ROUND_UP(CERT_HASH_LEN, 4) +
>>                     ROUND_UP(cert->der_size, 4);
>>
>> After thinking about this, I’m not entirely sure, but I think using the
>> calculated vce_max_size might be a better choice than MAX_ENTRY_SIZE,
>> since vce_max_size more closely reflects the size of the current VCE.
>>
>> MAX_ENTRY_SIZE is currently defined as 8192, which is significantly
>> larger than the size of a single VCB that will be requested in a later
>> patch.
> 
> I agree that it does make more sense to use the calculated size here, but
> do we actually know 8192 is significantly larger than what we will need?
> If so that seems like a problem with our definition of the max size.
> 
> Can we use a smaller value, or is it possible that the calculated
> vce_max_size is close to 8k anyway?
> 

I'm not entirely sure, but I think it’s uncommon for a self-generated
certificate to reach such a large size, though it is not impossible.
From my experience, the largest certificate I’ve generated used an RSA
16384-bit key and was 5982 bytes. Typically, certificates range from
about 1 KB to 4 KB in size. For reference, RHEL 10.2 signs components
using the Red Hat Secure Boot 302 certificate from
https://access.redhat.com/security/team/key, which has a size of 4429 bytes.

>> Although we check whether the remaining space is sufficient to
>> store the VCE, allocating MAX_ENTRY_SIZE for each VCE might be unnecessary?
>>
>> Just wondering if this makes sense, or if you think we should keep using
>> MAX_ENTRY_SIZE here?
> In this context, yes, it would be better to use the calculated size, but
> also if you feel that the current definition of MAX_ENTRY_SIZE will be
> significantly larger than we need, should we reconsider what we define
> MAX_ENTRY_SIZE as?

We could reduce the limit to something like 6144 (6 * 1024) or 7168 (7 *
1024) to better align with the certificate sizes we are likely to use
during verification, or keep it at 8192 (8 * 1024) to provide additional
buffer for less common cases.

Please let me know what you think.

>> [...]
> 
> Regards,
> Jared Rossi




