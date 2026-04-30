Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED1DFF8864
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 03:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIIGl-0000st-MV; Wed, 29 Apr 2026 23:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wIIGj-0000sT-Q2
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 23:40:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wIIGh-0002tQ-SB
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 23:40:53 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TLFDwM2585373; Thu, 30 Apr 2026 03:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=yW3+c2
 03skTRpv2athZJ35AdeKSjcLRKHYMqHGOTvBA=; b=PaZFqmvNnO0pJCra6mVZyF
 OBwYMAFJRmo/SdK7dfeTPnl4yLWDl/MyFQov2G+rwar8Wnl7WfsvH4A71pqww5OX
 sNk8LYqwIdwROIi3c5U6UJnqerwH2m3ElTYIOxO0uzi08KylTcPlc76F1kl+l0H+
 ZXBOrzaGajDOx9dyjDat8E79s4MX+ksYAtSFsIzzRKcPOx4oSb06O5VwaZNu4Dok
 RsQL6Zyqo6rFVi15R38rjb6hujT+rGtXv8eCbX/YVPA9MTtBrv8UZbHlb6Bmr86e
 1i/pTUXyjtqTvyNKNzvM6bT0orB2KqZ8AP7MuNgrtYDD69bYWG5Fq/y5p3S4OJcQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb5dpq8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 03:40:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63U3crb3004615;
 Thu, 30 Apr 2026 03:40:48 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8aw1atb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 03:40:48 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63U3elSG24052382
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Apr 2026 03:40:47 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD70958052;
 Thu, 30 Apr 2026 03:40:47 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8483258056;
 Thu, 30 Apr 2026 03:40:47 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Apr 2026 03:40:47 +0000 (GMT)
Message-ID: <43171c3b-339c-4335-b79b-387442048b11@linux.ibm.com>
Date: Wed, 29 Apr 2026 23:40:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: Dynamically allocate tpm-tis buffer
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20260427200134.453022-1-armenon@redhat.com>
 <765f0577-ee8f-4944-93fe-bb93e420668f@linux.ibm.com>
 <afBbLDmdYFY5feJx@fedora>
 <84607c2e-1da9-43d2-8a5b-e50e91c0f8ba@linux.ibm.com>
 <4b5c983e-8bbb-4851-bb0f-f478ad14121b@linux.ibm.com>
 <afJk9Lsn25UQOnwE@fedora>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <afJk9Lsn25UQOnwE@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69f2cf41 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=NEAV23lmAAAA:8
 a=iufaBhWlcYUnWXjxM-4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDAzMSBTYWx0ZWRfX2kIccYees7dq
 r0iRfSghoC8NiRI/jJyMaTL0eRu3P/XBvfZoUJa3m8Dfd3rr6qxEJtZzXSOqipP5gvqQx/k2kza
 tfqoyNIuySEybEYBK4Zh4mL2NopJzp1UVjA/z2BUmMwDoA7d09MWXaPFP+FWVoEEjgwgXZ+K0qH
 rpXaClbjdBlIC1v6npiM+ErT+h6cyLB60H0VSWd4CdOKXvaPWxpHL7h50FqWI/9bQX/AgFhDJF3
 teBvQIwabFMOcSMhEb330mMgTtEr9Lr/4KagfKbVEp9Qqtmii2YwnZBpfOXITxakbDqrtVJToLL
 IPKvXCtX4e8vT2L7gb1w3kUBSw0VVCCN1B0jKLq+onZwB2UJ7LCx+QrGBLE/DwMRZU6X2+/qkAV
 ZTwl8shgc8e4lhBLkfzSwze6EPjqfH2YxrKUBa1oPs9Dj+trBcfvTn0aytzUhEaMfXISz0aGv/x
 62rc9TYvDHNGHCL94mw==
X-Proofpoint-GUID: -JX2PzekWj5MtlG8XAXrLbSpv35LkiZ0
X-Proofpoint-ORIG-GUID: -JX2PzekWj5MtlG8XAXrLbSpv35LkiZ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300031
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
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



On 4/29/26 4:07 PM, Arun Menon wrote:
> Hi Stefan,
> 
> On Wed, Apr 29, 2026 at 02:15:16PM -0400, Stefan Berger wrote:
>>
>>
>> On 4/28/26 8:57 AM, Stefan Berger wrote:
>>>
>>>
>>> On 4/28/26 3:01 AM, Arun Menon wrote:
>>
>>>>>
>>>>> With MAX() it can now be bigger than TPM_TIS_BUFFER_MAX if the
>>>>> backend says
>>>>> so -- hm...
>>>>
>>>> TPM_TIS_BUFFER_MAX is still 4096.
>>>
>>> Oh, I had still based my patches on your TPM_TIS_BUFFER_MAX increase to
>>> 8192 bytes. Let me fixes this along with a few other things. I will let
>>> you know.
>>>
>>> I have another series that I will post now that can be applied to
>>> master. It's adding a test for TIS over I2C but I will need to extend
>>> that one also with the large transfer test case then.
>>>
>>>
>>
>> So I have resolved this issue now along with a few other things. My branch
>> is here: https://github.com/stefanberger/qemu-tpm/tree/work-tpm-for-11.1
>>
>> - I have applied the i2c swtpm test case series first since it could be
>> easily upstreamed first
>> - Then your patch "migration/vmstate: Add VMState support for GByteArray"
>> - Then the CRB chunk + TIS extended buffer support series. I modified my
>> patches (last 4 in that series) to
>>    - increased MAX_TIS_BUFFER_SIZE to 8192
>>    - added migration blockers dynamically for TIS whenever >4096 bytes are
>> either in the request or response; remove them later on again when device
>> goes into ready state for example
>>    - added large transfer test also for i2c
>>
>> Please pick up those patches for v6 posting, or otherwise you can split your
>> v5 series up into CRB-only support for v6 and I post my (last 4) patches
>> later on.
>>
> 
> Thank you. I agree. I will post v6 as CRB-only support. The GByteArray
> patch is already accepted. The complex TIS changes can be posted
> separately later.
> 
> Regarding the TIS buffer: I saw you implemented the migration blockers
> and 8192-byte increase in your branch. Should I discard my

It's quite dynamic with the blocker being set when 4097 bytes of a TPM 
command were received or when a TPM response with > 4096 bytes is 
received. The blocker is removed when the device goes into ready state. 
The intention is to allow a user to choose an old machine type with a 
PQC-enabled swtpm+libtpms and be able to migrate to an older version of 
QEMU unless the blocker was set. Correct me if I am wrong in my thinking...

> 'Dynamically allocate tpm-tis buffer' patch entirely, or do you want to
> try and adapt that logic into your TIS follow-up series later?
> 

It may be good to have a dynamically allocate tpm-tis buffer for future 
proofing the TIS, though it would have to support saving a range of the 
bytes in this buffer -- like 1:1 replacement using GByteArray for the 
VMSTATE_PARTIAL_BUFFER and VMSTATE_BUFFER_START_MIDDLE that I am using now.

> Since your new migration blockers are based on the 4096/8192 threshold,
> it might be simpler to stick with the static approach for now, but let
 > me know what you prefer.

It would still be good not to have to worry about buffer size increases 
anymore...

> 
> 
> Regards,
> Arun Menon
> 
>>
> 


