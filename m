Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4506DC61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x15dg-00059X-G7; Mon, 31 Aug 2026 13:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x15de-00058y-JO; Mon, 31 Aug 2026 13:17:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x15dc-0005Hz-NL; Mon, 31 Aug 2026 13:17:42 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VG1jKw1615924; Mon, 31 Aug 2026 17:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=lH/0W9
 MW5wsu2vBd7udarBPifBukp1Gu/MTuQDUjoL4=; b=HGBn4vXjdtlECIY2v9wUhR
 UB6kVN50jk83+MsCCpXyxm7opAVUaweJCFBhjvPy+bHMPnvj+oYZ/qyK47V1hLfY
 vGduxmnbJGjpD2nlrKpNDfuIN/IZPJAMhyFx6AtQspFjhssGnNSsY2mo/XThqI/I
 FaAYy1zCXf0S7r10Imre54vj6DeV3PH6ZRu87o6HojEBxGDidNVyCm3UnvTDLCsF
 fJLEKxvvRi53cExvuvzNif0ZjQLUxbahGL/eZmYlN/vJwfgbQ2KzzptPnqy4P+qv
 Bbjx46kJwLitQpiYBSp5in1kWFcrd/I8oeX+8/lahQbBT3GmXTY0xdiwPVAJjV1A
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudjseb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 17:17:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VHBO9l017282;
 Mon, 31 Aug 2026 17:17:37 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gca4vy7fn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 17:17:37 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67VHGt1u14287516
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 17:16:56 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 783875805D;
 Mon, 31 Aug 2026 17:17:36 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3481558058;
 Mon, 31 Aug 2026 17:17:35 +0000 (GMT)
Received: from [9.61.73.66] (unknown [9.61.73.66])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 17:17:35 +0000 (GMT)
Message-ID: <06d1f170-7a26-49b4-9d01-594ba5f8efa4@linux.ibm.com>
Date: Mon, 31 Aug 2026 13:17:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/7] pc-bios/s390-ccw: Split virtio-ccw and generic
 virtio net
To: Matthew Rosato <mjrosato@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, borntraeger@linux.ibm.com, jjherne@linux.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com
References: <20260818205324.580199-1-zycai@linux.ibm.com>
 <20260818205324.580199-2-zycai@linux.ibm.com>
 <b9dafa7d-d3d0-46c7-8ef1-c800811181dc@linux.ibm.com>
 <3b52a781-ea4c-4fec-b059-bebecc27ad3f@linux.ibm.com>
 <91c8fb44-fcc0-4c94-8494-084d6eaa6504@linux.ibm.com>
 <59fcd3e6-e0aa-4078-b36d-e7d51a4f4558@linux.ibm.com>
 <b7a5f123-3da8-4d3a-b011-1f431c4bf1d9@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <b7a5f123-3da8-4d3a-b011-1f431c4bf1d9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ijAhZHYuL-YWia5QimHF97TfIPAc6xh5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE0NyBTYWx0ZWRfX5XdVf7jNH09S
 /qVDgljin0lfhHVgNMj+1LZCpIAX15RTWrhfyM8kBGQanvosLknRgUxH0nJTD+nU+UrGA6PKJpZ
 Pw44OZBv3A+fg51s1ikMZxOfz2ABIpc/j86Ml0HOhllaGKC8zdrjjZ/aE71m60FvcvVkynecvnS
 sJyf2H/CyBnbg4vNP7bANcXmTrn5sdoPps7GFB2np7wDnNcUJuWHijwicDVT7WUrapixR0aOWXW
 YYfKksDGeArFnk2zn79iZUtHkOOJXCsVdNL1awLsD8MCR7Hp3niZ2dRZNo4SqSFDLzY3JhGzi9j
 wTZkVkz1FEi/sTDWCEnHMBK4CRdk518uirqfrB1K/w5xN8XE6MmXe4ohvbaTWnAnS6IdB9rtF2f
 HeASeOk7uEdzMKhZrYNtMpoAOFKK+GJX/Shd1PJRFT8eE0/xRJ8LkvCuMmho+i/KJWDsRyIkPG5
 BgC+aM4fbIVHBC8JTwQ==
X-Proofpoint-ORIG-GUID: ijAhZHYuL-YWia5QimHF97TfIPAc6xh5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE0NyBTYWx0ZWRfX8CfMdodJvj08
 HJH4WMbP5LjmCIz1ScI5+Yhwr+B5KRcyz0Kui6a0VqV0Gd8ti7Ifd1UqP/0g656Vv9enZEC8rXx
 AMwxgBSJuZqIv11SIb+K33c7M9PpCYA=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a95b732 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=zs3X2yJ19ZC09JavB2kA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310147
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 8/26/26 4:49 PM, Matthew Rosato wrote:
> On 8/26/26 4:23 PM, Jared Rossi wrote:
>>
>>
>> On 8/26/26 3:41 PM, Matthew Rosato wrote:
>>> On 8/26/26 3:30 PM, Jared Rossi wrote:
>>>>
>>>> On 8/26/26 1:33 PM, Matthew Rosato wrote:
>>>>>> +bool virtio_net_setup(void)
>>>>>> +{
>>>>>> +    switch (virtio_get_device()->ipl_type) {
>>>>>> +    case S390_IPL_TYPE_CCW:
>>>>>> +        return virtio_ccw_net_setup();
>>>>>> +    default:
>>>>>> +        return false;
>>>>>> +    }
>>>>>> +}
>>>>> This patch is largely renaming, but this does seem to have a subtle
>>>>> functional change right here.
>>>>>
>>>>> AFAICT before this patch attempting to netboot with anything other than
>>>>> a ccw device would hit
>>>>> IPL_assert(iplb.pbt == S390_IPL_TYPE_CCW, "IPL_TYPE_CCW expected");
>>>>>
>>>>> Now, we will never call virtio_ccw_net_setup(), return false and
>>>>> instead
>>>>> bail out with
>>>>> "No virtio net device found."
>>>>>
>>>>> That is new behavior for !IPL_TYPE_CCW after this patch.  For
>>>>> IPL_TYPE_PCI, patch 4 will change the behavior again.
>>>>>
>>>>> That's not a deal-breaker, but I do think it's worth a mention in the
>>>>> commit message.  I then also wonder if the message
>>>>> "No virtio net device found"
>>>>> would be more accurate if it instead read something like:
>>>>> "No supported virtio net device found"
>>>>>
>>>>> Thanks,
>>>>> Matt
>>>>>
>>>> I’m not sure this is a valid concern.  A non-ccw net device would be
>>>> rejected before getting to virtio_net_setup() earlier at the
>>>> find_boot_device() step either way.  In the case of virtio-net-pci
>>>> specifically, it would fail because VIRTIO_ID_NET is not a supported PCI
>>>> type yet.  For some sort of non-ccw non-pci netboot device, I believe
>>>> there
>>>> wouldn't ever be an IPLB built for it, so it wouldn’t be recognized as
>>>> boot eligible at all.  I don’t think this patch affects any of that.
>>>>
>>>
>>> Based on that description it sounds like we don't even ever to expect to
>>> reach the new default: case then, as prior checks should have already
>>> weeded out all but the supported IPL_TYPE_* values.
>>>
>>> Should the default: case have an IPL_assert with its own message then?
>>
>> Right, we shouldn’t ever hit the default case, but I don’t follow your
>> suggestion about an IPL_assert.  What condition might be asserted there?
> 
> Since it's a switch statement looking at the type value would be
> redundant, but something like
> IPL_assert(false, "unexpected IPL type");
> should work
> 
>>
>> In my opinion simply returning false is appropriate, which will just print
>> the error and move on to the next boot device if there one.  A full panic
>> could be justified since something weird would need to happen to get into
>> the default case at all, but I don’t think it’s really necessary.
> 
> Yeah, my line of thinking was that if we shouldn't reach this code but
> somehow do, then something unexpected happened but we would kind of mask
> that by simply moving onto the next device.
> 
>>
>> If virtio_net_setup() does fail though, regardless of why, I do agree the
>> subsequent error message needs to be updated to clarify that no “valid” or
>> “supported” virtio network device was found rather than stating none was
>> found at all.
>>
> I leave it up to you and Joy to decide if you feel it makes sense to
> assert or update the message to be more accurate, but please do at least
> one of those.
> 
> Outside of that, this patch LGTM.
> 
> Thanks,
> Matt

Thanks for the suggestion!

Based on the discussion, I'd prefer having an IPL_assert/panic in the
default case and updating the subsequent error message to: "No valid
virtio-net device found." Since the default path should be unreachable,
reaching it would indicate an unexpected condition and should be treated
as fatal.

Please let me know if you'd prefer a different approach.



