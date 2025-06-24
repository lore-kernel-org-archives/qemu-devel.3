Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F77DC77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 13:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU3VV-0007lO-RU; Tue, 24 Jun 2025 09:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1uU3VT-0007km-Kq; Tue, 24 Jun 2025 09:16:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1uU3VP-00014t-KO; Tue, 24 Jun 2025 09:16:11 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O54Joh026617;
 Tue, 24 Jun 2025 13:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=gBukvY
 I4J+/1x10Qj8r6t85XFB5eG5+NMHkkobfO4YA=; b=Ovw7SNUCkBFhKYwAZX7qdV
 lmKbY/qwPO9uUjsNVIBvWXFgV9Ku09e+wfv7CTddgDyZYu9RBv4RaLr2z8g4xdnm
 lDVMitINb4Zf3vx3I+FZtrPignc/z84LBHxLVr/wGNhtAUvErNbHT7dRq5GjxqS7
 5FRQmWZpdsW/r4AZmqfWuoZyNCHH3/9wcX/VyDqxHDuir0JNTosDeV4iR7JKKJoL
 GowCpcMZLx5rci6yKmCC0eXh/WqQkG/0u6pGFecxHPeAWole21nZnjZ30cZdQ8pd
 DZc8j7ZkLnoshbH25ZsXP2Oh1gLbi37Gws37BoJfsX3EkyZdzOal+CpJJO1qtEew
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5trv64-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Jun 2025 13:16:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55O9Seq6015033;
 Tue, 24 Jun 2025 13:16:03 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e72tma8b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Jun 2025 13:16:03 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55ODG22I25755962
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Jun 2025 13:16:02 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7565F5804B;
 Tue, 24 Jun 2025 13:16:02 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E1AF658055;
 Tue, 24 Jun 2025 13:16:01 +0000 (GMT)
Received: from [9.61.75.155] (unknown [9.61.75.155])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 24 Jun 2025 13:16:01 +0000 (GMT)
Message-ID: <2d08e53a-4680-499e-b383-9418ad65df8b@linux.ibm.com>
Date: Tue, 24 Jun 2025 09:16:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] hw/s390x: Use preferred API call for IPLB chain write
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, philmd@linaro.org
Cc: zycai@linux.ibm.com
References: <20250623201216.721130-1-jrossi@linux.ibm.com>
 <20250623201216.721130-2-jrossi@linux.ibm.com>
 <4e95f3c7-8748-4cf5-ac21-78cf653bfd40@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <4e95f3c7-8748-4cf5-ac21-78cf653bfd40@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VVGzZfVxLKQKV7-1A1Q7WdiwWJDp2LA4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDEwOCBTYWx0ZWRfX3zS4sf18m6y4
 n7ic9IsGohHRuB1cOKNwwZK+KQGp1F1lw68hv/PyPLWBIFS1R54m7fnDUV0OYuwn7Jr0xqkZ2T9
 VMeXB7EzvgzRvqPX/KtxnDtqAVBFlPw/MEVPIuW3WHGfjlxeP91ijMwaB9rtQbh68PlGS1qlCvw
 2M0E5qiV2kVGzDhsGDd1NMw1EaHbzjrwSXyGYoUMTefypzmpJGEiAY7DDD8A0BcugQZ5+AOoIU0
 OD2XKDbDMmhJmky4Ah1YIXYDExYZmjwrhsEozwTS7UHCV5WGbnIL7nNFmYt8rmLfmKCDfoTLsXV
 OOQFdSktzprNrtuPa4h40s0Lk3IevW+T0EHRaEcWvpWvNBPkgaY1yOoiK9ClsGlObG+P33T+0CM
 yHZEU7o07a3oOJDgJTuyRNT4QMB3Kd+PDUGLdWyY6hYjmvnju4J6iLdYRId6EaX3YoUT46Zc
X-Authority-Analysis: v=2.4 cv=MshS63ae c=1 sm=1 tr=0 ts=685aa514 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=hHogkAqzgn52Mry1xMAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: VVGzZfVxLKQKV7-1A1Q7WdiwWJDp2LA4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_05,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=786 impostorscore=0
 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506240108
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
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



On 6/24/25 2:27 AM, Thomas Huth wrote:
> On 23/06/2025 22.12, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> Replace a recently introduced legacy API call with the preferred API 
>> call.
>>
>> fixes: 0927875 (hw/s390x: Build an IPLB for each boot device)
>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>> ---
>>   hw/s390x/ipl.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index 2f082396c7..f2606303e6 100644
>> --- a/hw/s390x/ipl.c
>> +++ b/hw/s390x/ipl.c
>> @@ -399,8 +399,16 @@ static uint64_t 
>> s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain)
>>       uint16_t count = be16_to_cpu(ipl->qipl.chain_len);
>>       uint64_t len = sizeof(IplParameterBlock) * count;
>>       uint64_t chain_addr = 
>> find_iplb_chain_addr(ipl->bios_start_addr, count);
>> +    MemTxResult ret;
>> +
>> +    ret = address_space_write(&address_space_memory, chain_addr,
>> +            MEMTXATTRS_UNSPECIFIED, iplb_chain, len);
>> +
>> +    if (ret != MEMTX_OK) {
>> +        error_report("Failed to map IPLB chain.");
>> +        exit(1);
>> +    }
>>   -    cpu_physical_memory_write(chain_addr, iplb_chain, len);
>
> By using address_space_memory, you're basically open-coding 
> cpu_physical_memory_write() here. That does not make too much sense. 
> If I got Philippe right in 
> https://lore.kernel.org/qemu-devel/469f3e5a-897a-4456-bd02-185435129ec4@linaro.org/ 
> , he rather asked about a device specific address space instead. 
> However, that ipl device does not have its own address space as far as 
> I can see, so that request does not make much sense here (unless I 
> missed something). Thus I'd suggest to drop this patch here.
>
>  Thomas
>

Yes, it is basically the same.  I interpreted Philippe's request to mean 
avoid introducing new calls to cpu_physical_memory_* functions as per 
the documentation in load-stores.rst.  If the request was to use a 
device specific address space, then Thomas is correct and it cannot done 
be here.

Regards,
Jared Rossi

