Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 116B7E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNxEW-000485-B1; Wed, 18 Dec 2024 11:49:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1tNxER-00046s-NC; Wed, 18 Dec 2024 11:49:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1tNxEO-0006XB-4w; Wed, 18 Dec 2024 11:49:07 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BID0H1r032274;
 Wed, 18 Dec 2024 16:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Mnv/QF
 6POJ3da2DGSwCI29zg6A6XoR6rpja+YKT0qBg=; b=aCRRfJOMdUSGbk7BZgtzbT
 fht4KTzf0b3S/jnV7Fw9z31mjJUEmI3u1PzV6KMZFQYKprbZ/MGgVu1fnX40vQRr
 voKvC4Ikp7AtiSx/GF3ueXkNq+cTmVUdYD35qKLg9Dddtqe3Dn5RlCJwHVkDkTxA
 myo6Kjfv8e+4/k4LgbIesl18Ok6FkbUQ6etSfJBhDzNPw5kEXpMOJj1hck8muCW+
 dsBvENhIxV6nvLmoCzP0sgefBiG4TaCPzcUks0XGr4Q9juY9h/LxhPkdutHg3Cqk
 EmEPpzUB4zwEDKhoTx6KAKUY0uLmkAFYjA/HJZMKmdT80m7grLCpcPzm6glAKzOA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kkehcaev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Dec 2024 16:48:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIGYMPY024047;
 Wed, 18 Dec 2024 16:48:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnukgs34-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Dec 2024 16:48:56 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BIGmq0036962752
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2024 16:48:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BCD5D20040;
 Wed, 18 Dec 2024 16:48:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 29EE720043;
 Wed, 18 Dec 2024 16:48:52 +0000 (GMT)
Received: from [9.171.59.153] (unknown [9.171.59.153])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 18 Dec 2024 16:48:52 +0000 (GMT)
Message-ID: <9d912aae-2ac0-483e-814c-3a064a53b5a2@linux.ibm.com>
Date: Wed, 18 Dec 2024 17:48:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] s390x: virtio-mem support
To: David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20241008105455.2302628-1-david@redhat.com>
 <07ca4492-1590-4cc6-94a1-0eea417da59e@redhat.com>
 <7e1025b4-c246-432c-b70d-e7156afb6519@redhat.com>
 <8d06030b-37a2-4c41-9907-8e072dde47f7@redhat.com>
 <9089e146-d665-471b-a918-2571a212c99b@redhat.com>
 <15947eee-1e01-4b8a-b750-417250899ecd@redhat.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <15947eee-1e01-4b8a-b750-417250899ecd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aWOGxIkdTeukJVsCmn8_mnWGUIF3XMIA
X-Proofpoint-ORIG-GUID: aWOGxIkdTeukJVsCmn8_mnWGUIF3XMIA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412180128
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.116, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Am 16.12.24 um 22:18 schrieb David Hildenbrand:
> Thanks, queued to
> 
> https://github.com/davidhildenbrand/qemu.git mem-next
> On 13.12.24 15:26, David Hildenbrand wrote:
>> On 13.12.24 13:35, Thomas Huth wrote:
>>> On 12/12/2024 22.52, David Hildenbrand wrote:
>>>> On 13.11.24 15:46, David Hildenbrand wrote:
>>>>> On 08.10.24 12:54, David Hildenbrand wrote:
>>>>>> Based on current master.
>>>>>>
>>>>>> There is really not much left to do on s390x, because virtio-mem already
>>>>>> implements most things we need today (e.g., early-migration,
>>>>>> unplugged-inaccessible). The biggest part of this series is just doing what
>>>>>> we do with virtio-pci, wiring it up in the machine hotplug handler and ...
>>>>>> well, messing with the physical memory layout where we can now exceed
>>>>>> initial RAM size and have sparsity (memory holes).
>>>>>>
>>>>>> I tested a lot of things, including:
>>>>>>      * Memory hotplug/unplug
>>>>>>      * Device hotplug/unplug
>>>>>>      * System resets / reboots
>>>>>>      * Migrate to/from file (including storage attributes under KVM)
>>>>>>      * Basic live migration
>>>>>>      * Basic postcopy live migration
>>>>>>
>>>>>> More details on how to use it on s390x -- which is pretty much how
>>>>>> we use it on other architectures, except
>>>>>> s/virtio-mem-pci/virtio-mem-ccw/ --- is in the last patch.
>>>>>>
>>>>>> This series introduces a new diag(500) "STORAGE LIMIT" subcode that will
>>>>>> be documented in the kernel and at [2] once this+kernel part go upstream.
>>>>>>
>>>>>> There are not many s390x-specific virtio-mem future work items, except:
>>>>>> * Storage attribute migration might be improved
>>>>>> * We might want to reset storage attributes of unplugged memory
>>>>>>       (might or might not be required for upcoming page table reclaim in
>>>>>>        Linux; TBD)
>>>>>>
>>>>>> The Linux driver is available at [3].
>>>>>>
>>>>>> [1] https://lkml.kernel.org/r/20240906101658.514470-1-pbonzini@redhat.com
>>>>>> [2] https://gitlab.com/davidhildenbrand/s390x-os-virt-spec
>>>>>> [3] https://lkml.kernel.org/r/20240910191541.2179655-6-david@redhat.com
>>>>>
>>>>> Gentle ping (and thanks to Thomas for the review!).
>>>>>
>>>>> I assume the kernel portion will go upstream in the next merge window.
>>>>> I'd like get the QEMU parts merged soon after that.
>>>>>
>>>>> 9.2 is going to get released in roughly one month, so there is still time.
>>>>
>>>> In the meantime, 9.2 was released. I don't have any changes planned. Series
>>>> still applies to current master, I'll do a quick test tomorrow.
>>>>
>>>>>
>>>>> @Thomas, this is mostly s390x stuff, so I guess it should go through the
>>>>> s390x tree? But I could also take this through my "memory devices" tree.
>>>>
>>>> @Thomas, any thoughts?
>>>
>>> I'm fine either way - feel free to put it into your tree, otherwise I'll
>>> pick it up likely sometime next week.
>>
>> Okay, let me let this sit here for a couple days longer and retest it
>> next week. I can queue it then, as another required patch ("virtio-mem:
>> unplug memory only during system resets, not device resets") still sits
>> in my tree all-lonely. :)
> 
> Testing revealed no surprised.
> 
> Queued to
> 
> https://github.com/davidhildenbrand/qemu.git mem-next

Thank you for doing it. Awesome work.

