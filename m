Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C27CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 04:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB3aG-0006Wm-QV; Tue, 21 Oct 2025 00:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vB3a8-0006WN-L3; Tue, 21 Oct 2025 00:02:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vB3a6-0003dw-5q; Tue, 21 Oct 2025 00:02:44 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KMSf3q008824;
 Tue, 21 Oct 2025 04:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vdEes4
 9G/6NJj1oN3C3mKUHGugc87JzmB2o4oksKee8=; b=ND2HV/lhMEqrAXyI5cvMJ9
 D+IYme/fanI3fWTgg3TQHdDoCCbwLhPF6ekfU06XFDg1MgoMbx3dQOhAdmsXQOO8
 zcobEr6yzcPFzi42LDfgVeD1zpm5lTWoJPihUAeEPlXdxf/UKBObW9YniXVU5y6V
 rIY9RdT6sz60QNrq00IQvC2gu/T584vAmJHs08zA9XkPFVbyP9doPkUFd5ZS7Cng
 Xn7agUYTVsIJ1z76A7yPidh4V7q2+NJJuagVEnFKye9SXyRx+AnMgUidWJgUdH2S
 rhwMBJ+hdJcTmWvVlIgFAtSSSSJ9CT4CxXWSCn3ujj6rehfxTirikMvnQG4dHAqQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31c3q82-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 04:02:28 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59L42RH1001685;
 Tue, 21 Oct 2025 04:02:27 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31c3q7y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 04:02:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59L3fq5J032096;
 Tue, 21 Oct 2025 04:02:27 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vp7mrvtv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 04:02:27 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59L42Qjw14418492
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Oct 2025 04:02:26 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63B6258069;
 Tue, 21 Oct 2025 04:02:26 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 26EF358056;
 Tue, 21 Oct 2025 04:02:24 +0000 (GMT)
Received: from [9.109.242.24] (unknown [9.109.242.24])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Oct 2025 04:02:23 +0000 (GMT)
Message-ID: <855a1360-c937-402c-825d-bcf2d9050aee@linux.ibm.com>
Date: Tue, 21 Oct 2025 09:32:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] hw/pci-host/raven: Simplify PCI facing part
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1758219840.git.balaton@eik.bme.hu>
 <ebfd5b64421e8a876c5a6e2ce3dc871de500b69d.1758219840.git.balaton@eik.bme.hu>
 <b5db600a-3278-427d-9f67-b222cb0c1bd1@ilande.co.uk>
 <db65a6dd-cfdf-18b8-1764-8a1d7d3fcc24@eik.bme.hu>
 <a95fed21-de1c-4dc8-a776-a6a2acd4b7d3@linux.ibm.com>
 <b83b904c-6dcc-4b4f-afc0-499ffafca15c@ilande.co.uk>
 <818e8c63-9ef1-c2f5-6a85-7ef37a80d44b@eik.bme.hu>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <818e8c63-9ef1-c2f5-6a85-7ef37a80d44b@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ps6oB2DR9yi2H5mMSm_f8N34woht4LIY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX/wqZjysLf7xz
 aaHrUrr7K1+bd5squ7mcV+0sBrOHJ9R1Q8tWzJejJNIG51SC9xdywji0oD9vncYjWUI/rBnczn+
 QrQAtfF+TpuX+c1oMbABbIIzV7SCvtSUr3Eo6LV01/gmmc1YvfH1S5XYK+VrUzau8BM9Z72BT9K
 2KsOhBc8PdB4A7XxBTWNHpHNksPtnoxdt6np9Ng5yVxuSKLAAEzbUGoW7bBQudBHC+rc3040T+O
 jGTfp1NMMPbg6cUt7kV0PsaduSriVyqclKG/XhSRH6PKbPFBRdt3jqAL2N0hYNkQydgDmHky3Ee
 XT3OIw3VFJCYok3cZjG2ho4ai7SX03UzOaPPI1+a/XK7uPIhO5sPbUIUW3rI9Hh+OL0YiV6wwZ5
 svodh16i8Qh+fmTSjyRaVgJYxhp/0w==
X-Proofpoint-GUID: ck4Qwud0HYqpR24h8_zJ5qQ5tbzzN7Va
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68f705d4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=69wJf7TsAAAA:8 a=MBbOA-HLD692_vL6JOgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=RAnounYMGgIA:10 a=kDwrXxujhdMA:10
 a=yII1x0vjwq8A:10 a=Fg1AiH1G6rFz08G2ETeA:22 a=oH34dK2VZjykjzsv8OSz:22
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=jd6J4Gguk5HxikPWLKER:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 10/20/25 04:56, BALATON Zoltan wrote:
> On Sun, 19 Oct 2025, Mark Cave-Ayland wrote:
>> On 18/10/2025 03:41, Harsh Prateek Bora wrote:
>>> Hi Mark,
>>>
>>> Thanks much for pitching in to help with reviewing this series.
>>
>> Hi Harsh,
>>
>> No worries - I've looked at raven before when working on adding 40p 
>> support for OpenBIOS, so I do have some familiarity.

Nice, thanks.

>>
>>> On 9/19/25 01:51, BALATON Zoltan wrote:
>>>> On Thu, 18 Sep 2025, Mark Cave-Ayland wrote:
>>>>> On 18/09/2025 19:50, BALATON Zoltan wrote:
>>>>>> The raven PCI device does not need a state struct as it has no 
>>>>>> data to
>>>>>> store there any more, so we can remove that to simplify code.
>>>>>>
>>>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>>>> ---
>>>>>>   hw/pci-host/raven.c | 30 +-----------------------------
>>>>>>   1 file changed, 1 insertion(+), 29 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
>>>>>> index f8c0be5d21..172f01694c 100644
>>>>>> --- a/hw/pci-host/raven.c
>>>>>> +++ b/hw/pci-host/raven.c
>>>>>> @@ -31,7 +31,6 @@
>>>>>>   #include "hw/pci/pci_bus.h"
>>>>>>   #include "hw/pci/pci_host.h"
>>>>>>   #include "hw/qdev-properties.h"
>>>>>> -#include "migration/vmstate.h"
>>>>>>   #include "hw/intc/i8259.h"
>>>>>>   #include "hw/irq.h"
>>>>>>   #include "hw/or-irq.h"
>>>>>> @@ -40,12 +39,6 @@
>>>>>>   #define TYPE_RAVEN_PCI_DEVICE "raven"
>>>>>>   #define TYPE_RAVEN_PCI_HOST_BRIDGE "raven-pcihost"
>>>>>>   -OBJECT_DECLARE_SIMPLE_TYPE(RavenPCIState, RAVEN_PCI_DEVICE)
>>>>>> -
>>>>>> -struct RavenPCIState {
>>>>>> -    PCIDevice dev;
>>>>>> -};
>>>>>> -
>>>>>>   typedef struct PRePPCIState PREPPCIState;
>>>>>>   DECLARE_INSTANCE_CHECKER(PREPPCIState, RAVEN_PCI_HOST_BRIDGE,
>>>>>>                            TYPE_RAVEN_PCI_HOST_BRIDGE)
>>>>>> @@ -65,7 +58,6 @@ struct PRePPCIState {
>>>>>>       MemoryRegion bm_ram_alias;
>>>>>>       MemoryRegion bm_pci_memory_alias;
>>>>>>       AddressSpace bm_as;
>>>>>> -    RavenPCIState pci_dev;
>>>>>>         int contiguous_map;
>>>>>>   };
>>>>>> @@ -268,8 +260,7 @@ static void 
>>>>>> raven_pcihost_realizefn(DeviceState *d, Error **errp)
>>>>>>                             "pci-intack", 1);
>>>>>>       memory_region_add_subregion(address_space_mem, 0xbffffff0, 
>>>>>> &s->pci_intack);
>>>>>>   -    /* TODO Remove once realize propagates to child devices. */
>>>>>> -    qdev_realize(DEVICE(&s->pci_dev), BUS(&s->pci_bus), errp);
>>>>>> +    pci_create_simple(&s->pci_bus, PCI_DEVFN(0, 0), 
>>>>>> TYPE_RAVEN_PCI_DEVICE);
>>>>>>   }
>>>
>>> <snip>
>>>
>>>>>> @@ -361,7 +334,6 @@ static void raven_class_init(ObjectClass 
>>>>>> *klass, const void *data)
>>>>>>   static const TypeInfo raven_info = {
>>>>>>       .name = TYPE_RAVEN_PCI_DEVICE,
>>>>>>       .parent = TYPE_PCI_DEVICE,
>>>>>> -    .instance_size = sizeof(RavenPCIState),
>>>>>>       .class_init = raven_class_init,
>>>>>>       .interfaces = (const InterfaceInfo[]) {
>>>>>>           { INTERFACE_CONVENTIONAL_PCI_DEVICE },
>>>>>
>>>>> I agree with removing RavenPCIState, but pci_create_simple() isn't 
>>>>> the right solution here because it both init()s and realize()s the 
>>>>> inner object. The right way to do this is for the parent to init() 
>>>>> its inner object(s) within its init() function, and similarly for 
>>>>> it to realize() its inner object(s) within its realize() function.
>>>>>
>>>>> FWIW it looks as if the same mistake is present in several other 
>>>>> hw/pci-host devices.
>>>>
>>>> So maybe that's not a mistake then. There's no need to init and 
>>>> realize it separately as this is an internal object which is enough 
>>>> to be created in realize method and init and realize there at one go 
>>>> for which pci_create_simple is appropriate. I think this inner 
>>>> object would only need to be init separately if it exposed something 
>>>> (like a property) that could be inspected or set before realize but 
>>>> that's not the case here so it does not have to be created in init 
>>>> only in realize. (A lot of simple devices don't even have init 
>>>> method only realize so init is only needed for things that have to 
>>>> be set before realize.)
>>>
>>> Do we have a consensus here ?
>>>
>>> regards,
>>> Harsh
>> Given there is still some ongoing discussion regarding object 
>> modelling, I think this will require a separate tidy-up so let's go 
>> with the pci_create_simple() approach for now.

Sure, thanks for considering.

>>
>> The changes to the interrupt routing and readability of some of the 
>> changes from a developer's perspective are still of concern to me.
> 
> I think simpler is more readable so not having an or-irq object where 
> not needed as the PCI code can handle this makes it more readable (also 
> the same as ppc440_pcix which was previously approved by Peter[1] and a 
> patch to add or-irq there was dropped as unneeded[2] so doing the same 
> thing the same way here is also more readable and more consistent). Thus 
> I think the interrupt routing changes should be OK and having an or-irq 
> is an unneeded complication.
> 
> What other readablility concerns do you have? Is it about not passing 
> the whole device state struct to callbacks but only what they need from 
> it? I've answered that already and I think that unnecessary casts would 
> not add any readablility. I'd like to hear others' opinion too but it 
> seems not many care so it's only us and we both seem to have strong view 
> on these things so it's hard to come to an agreement.

I think since the changes are contained to prep/raven (which although I 
am not so familiar with), I hope we just need to ensure changes are safe 
enough and can be provided a R-b to be considered for merge and any 
improvements can be done as a follow-up later as needed. Thanks again.

regards,
Harsh

> 
> Regards,
> BALATON Zoltan
> 
> [1] commit 2a9cf49598c65 and 
> https://lists.nongnu.org/archive/html/qemu-ppc/2021-01/msg00031.html
> 
> [2] https://lists.nongnu.org/archive/html/qemu-ppc/2020-12/msg00422.html 
> https://lists.nongnu.org/archive/html/qemu-ppc/2020-12/msg00423.html

