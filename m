Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A047BC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFC3b-0003ts-FR; Wed, 14 May 2025 09:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1uFC1d-0004du-DY; Wed, 14 May 2025 09:19:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1uFC1a-0003Nx-2E; Wed, 14 May 2025 09:19:57 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E6IOEr026368;
 Wed, 14 May 2025 13:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=XheT1k
 8Tjy/YoUA47SAlUo4Wtk+yrz9AroZXzGACti8=; b=tJpgKKrw+0pVmHiigiaT1I
 3PQ+GURAfuO5H5IkHShxWWXfwvDlW89vPyQwt3BaaIlI8+w4Wgm093pybSgxXT+2
 NWYWEW3JV9u0SMApohAVSmr9clV9yFZWlyEUe6R0pWDKIKtKM3RMISHE9eONKbuU
 8Q56Y5GxFfnJYs1JGHK1tyEnPavEYwnMj4NM68QdLf9Bndx0V3SCMkRwK3aoyu8x
 Pcjekdxm74Ht8OH+7k7cQ5NNIW7B1cBKgc0b3MmoibDv4+Ss38ZK/nxF7/Q/Zs2d
 Ny0g0F940F4VlIHgj4+luLtvaqPN+HXSNroDgS+/eRxfZLqkesObaNLqvQp++QrA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mnst1x78-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 13:19:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54E9prFh021396;
 Wed, 14 May 2025 13:19:48 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfrmb4x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 13:19:48 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EDJl4B61145486
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 13:19:47 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2FF2658043;
 Wed, 14 May 2025 13:19:47 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6DF5058055;
 Wed, 14 May 2025 13:19:46 +0000 (GMT)
Received: from [9.61.136.253] (unknown [9.61.136.253])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 13:19:46 +0000 (GMT)
Message-ID: <2fbce552-1fa2-48f8-b5a2-a052296523f9@linux.ibm.com>
Date: Wed, 14 May 2025 09:19:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x: Clear RAM on diag308 subcode 3 reset
To: Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Nicholas Miehlbradt <nicholas@linux.ibm.com>,
 richard.henderson@linaro.org, iii@linux.ibm.com, pasic@linux.ibm.com,
 farman@linux.ibm.com, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20250429052021.10789-1-nicholas@linux.ibm.com>
 <489d0473-579a-4850-a6d5-be38bf2954b9@redhat.com>
 <5863e80e-8296-4f63-bf7d-783b2a9aca0a@linux.ibm.com>
 <27d5d332-bc7c-4036-a3d9-d4666411bd4a@linux.ibm.com>
 <14b9b607-c88a-4691-9872-cc6a51834c95@linux.ibm.com>
 <1c983e1e-9610-4c53-8453-2db52ffa47e9@linux.ibm.com>
 <b6e97526-4353-4b62-b992-bd7019d08c27@redhat.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <b6e97526-4353-4b62-b992-bd7019d08c27@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QOR0fFHbgBYqmzHKPwosraKD30ZND9JE
X-Authority-Analysis: v=2.4 cv=V+590fni c=1 sm=1 tr=0 ts=68249875 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=z5aA2HeAKe8svm0xGp0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: QOR0fFHbgBYqmzHKPwosraKD30ZND9JE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDExNSBTYWx0ZWRfX7tL6EbzYqYpk
 12ZYRvj8vxtaLblXu09ZeWAILr8hU2o7bdE8WKfqH+b0gmedq1085L4Hf8mgEjeY/vjzq1ka0pU
 /R4MtRjL3vN2jPP/czwbddKZ6mOtQCxpF11pXTLZgk78MF2hdebms+Th9bN/SZ+tI5HkC0vgbyl
 4c+ZTF0OIsXnqDgJuZmhLTkQL1f2Tfpf9nRdfEl24iVPhFkyotwUOOWhxpkQYhOP3OahQmjNwQa
 CRpwpTeAUwufEmn1pSRTHDFWsy6EsfqqLZ0SkraTCheqSSUBOeqqTkQ9tDToe3e+5JbbO6DwwEg
 1hQ4BNnWkbYUns7IfepWSqX+iAVCr16tD4flVU841quT1r/X3BJyl0cJ7BuvpbJQYYYh4rXWUmc
 npBcomaVKm75XUjyvycPIYYE2XPPU27ccAZVn8qirjkMOqJNNOirtRTSTJW4/VINgxlIBawz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140115
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/14/25 5:32 AM, Thomas Huth wrote:
> On 13/05/2025 15.42, Matthew Rosato wrote:
>> On 5/13/25 2:50 AM, Christian Borntraeger wrote:
>>> Am 29.04.25 um 16:09 schrieb Matthew Rosato:
>>>> On 4/29/25 3:45 AM, Christian Borntraeger wrote:
>>>>> Am 29.04.25 um 09:37 schrieb David Hildenbrand:
>>>>> [...]
>>>>>> The only problem I see is with vfio devices is the new "memory pinned" mode. [1]
>>>>>>
>>>>>> There, we'd have to check if any such device is around (discarding of ram is disabled?), and fallback to actual zeroing of memory.
>>>>>
>>>>> CC Matt to double check.
>>>>
>>>> When triggering the "relaxed translation" mode via iommu.passthrough in the guest, we now take the default (for other platforms) memory_region_is_ram() path in vfio_listener_region_add/del() which handles the pin/unpin from vfio common code.  As for ram discarding, we then also use the vfio common path and only uncoordinated discards are disabled via:
>>>>
>>>> vfio_ram_block_discard_disable() -> ram_block_uncoordinated_discard_disable()
>>>
>>> So this patch is good?
>>>
>>
>> Worked fine in my testing in combination with iommu.passthrough=1.  I traced to verify I was hitting the S390_RESET_REIPL_CLEAR path in s390_machine_reset() and observed the pinned memory of the guest shrink / grow.  Device worked fine afterwards.
> 
> What about David's concern here: https://lore.kernel.org/qemu-devel/489d0473-579a-4850-a6d5-be38bf2954b9@redhat.com/ ?
> 

With the current code + this patch applied and testing with a vfio-pci device in the pinned mode, I can observe the pinned memory be discarded / pinned memory shrinks until finally ram_discard_block_range returns rc=0.

We don't disable discarding of ram when using the vfio-pci pinned memory mode, we only disable uncoordinated discarding of ram - maybe David's concern was based on an older version of my implementation that required disabling both coordinated and uncoordinated discards?

Or am I missing some other concern?

