Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFB9CCD199
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 02:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9wt5-0004uR-CT; Fri, 17 Oct 2025 22:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v9wt3-0004uE-VP; Fri, 17 Oct 2025 22:41:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v9wt1-00027q-N9; Fri, 17 Oct 2025 22:41:41 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HN2kpO021864;
 Sat, 18 Oct 2025 02:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=nS8SFH
 94APU6OMeU5PPn47bOMxBdPhZ9/avg3G7VWQY=; b=f+WTC+mBTbxnppPa2SRbeD
 MlJ/nZzHDuHpj7lSD+2hBH1VQgAXiTsXPXxpozu7zSYpzwo5o4t66wmpFlxV8EZG
 a/wtRGXJG80+4TMDUan3DJHKkhgXeTrMt6ochB0Vpxqr2PCAJlZ3mRdm3sTj4CY8
 cAL/KVrjMWA917ZOYYyTg0+B71fAugPkiNAt8OFlVAeatqEh3gDmvxQvP1H5VkjS
 DJT83eojSU9lKcj8tOFnkApj9oLRAoWK9Wg6N8s5D4naVvSj8bk1r/qh5Qex5Kke
 j94NA60Ap+mfKlE7LoC+M0LYzY/KNsh3VxWMFtLw7rkqKvNmHeegZO38lqSfOSRw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey9e8pw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 18 Oct 2025 02:41:26 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59I2fPLS026072;
 Sat, 18 Oct 2025 02:41:25 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey9e8pu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 18 Oct 2025 02:41:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59HLe6FM018826;
 Sat, 18 Oct 2025 02:41:24 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r2jn8fns-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 18 Oct 2025 02:41:24 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59I2fNdt19006108
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 18 Oct 2025 02:41:24 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D65B458056;
 Sat, 18 Oct 2025 02:41:23 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A3D45803F;
 Sat, 18 Oct 2025 02:41:21 +0000 (GMT)
Received: from [9.39.26.64] (unknown [9.39.26.64])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 18 Oct 2025 02:41:21 +0000 (GMT)
Message-ID: <a95fed21-de1c-4dc8-a776-a6a2acd4b7d3@linux.ibm.com>
Date: Sat, 18 Oct 2025 08:11:19 +0530
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
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <db65a6dd-cfdf-18b8-1764-8a1d7d3fcc24@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -EZ34a2aP35XD2OAa3IVSPOv-n6vsbRr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMSBTYWx0ZWRfX/D8df06x5e+Z
 IGnZWSxFT7sDFtfPuZDYPJ5bCqDiEiqwhAFgN9zEBzfctdTEZdMiDlsA5legqn1itXiIcZJ7NYe
 iLMR4uk3LCsH1uIsjNNNzjYfEMLDL+VtUyIfLHsjSogKqXZwar4zAZi21hui6b25G0z+qtxnu1i
 4n1ArI2uGdR7/PWAisKtWLqc74WFxt7ld179GC7KB++LPd875qhIx47zzTCfhVE+fr5eXPl4eCX
 StOYC6B0qz9SM2Sv2PAPzUn8cA1EjxXL+rXrlrgBdfkDOQ9CJy4DSdDMuOY3tJ/yh/YQWw/ANRB
 ll7xxmINtd48Yk+/DSESQQDt5sKSv0AZA2SJv4jYqJUjjOYpKPAaRAumCx+YoiNmxzqslLhLtOk
 S9vyyQvQI/DjYw2IyOMYk4GwT3nEkA==
X-Proofpoint-GUID: Ptlz1_L1TWjIKq5rREQ8ABFMtMfpbqop
X-Authority-Analysis: v=2.4 cv=QZ5rf8bv c=1 sm=1 tr=0 ts=68f2fe56 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=6JeE_j_6ij_iiuWLkdcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=oH34dK2VZjykjzsv8OSz:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=jd6J4Gguk5HxikPWLKER:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110011
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

Hi Mark,

Thanks much for pitching in to help with reviewing this series.

On 9/19/25 01:51, BALATON Zoltan wrote:
> On Thu, 18 Sep 2025, Mark Cave-Ayland wrote:
>> On 18/09/2025 19:50, BALATON Zoltan wrote:
>>> The raven PCI device does not need a state struct as it has no data to
>>> store there any more, so we can remove that to simplify code.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>   hw/pci-host/raven.c | 30 +-----------------------------
>>>   1 file changed, 1 insertion(+), 29 deletions(-)
>>>
>>> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
>>> index f8c0be5d21..172f01694c 100644
>>> --- a/hw/pci-host/raven.c
>>> +++ b/hw/pci-host/raven.c
>>> @@ -31,7 +31,6 @@
>>>   #include "hw/pci/pci_bus.h"
>>>   #include "hw/pci/pci_host.h"
>>>   #include "hw/qdev-properties.h"
>>> -#include "migration/vmstate.h"
>>>   #include "hw/intc/i8259.h"
>>>   #include "hw/irq.h"
>>>   #include "hw/or-irq.h"
>>> @@ -40,12 +39,6 @@
>>>   #define TYPE_RAVEN_PCI_DEVICE "raven"
>>>   #define TYPE_RAVEN_PCI_HOST_BRIDGE "raven-pcihost"
>>>   -OBJECT_DECLARE_SIMPLE_TYPE(RavenPCIState, RAVEN_PCI_DEVICE)
>>> -
>>> -struct RavenPCIState {
>>> -    PCIDevice dev;
>>> -};
>>> -
>>>   typedef struct PRePPCIState PREPPCIState;
>>>   DECLARE_INSTANCE_CHECKER(PREPPCIState, RAVEN_PCI_HOST_BRIDGE,
>>>                            TYPE_RAVEN_PCI_HOST_BRIDGE)
>>> @@ -65,7 +58,6 @@ struct PRePPCIState {
>>>       MemoryRegion bm_ram_alias;
>>>       MemoryRegion bm_pci_memory_alias;
>>>       AddressSpace bm_as;
>>> -    RavenPCIState pci_dev;
>>>         int contiguous_map;
>>>   };
>>> @@ -268,8 +260,7 @@ static void raven_pcihost_realizefn(DeviceState 
>>> *d, Error **errp)
>>>                             "pci-intack", 1);
>>>       memory_region_add_subregion(address_space_mem, 0xbffffff0, 
>>> &s->pci_intack);
>>>   -    /* TODO Remove once realize propagates to child devices. */
>>> -    qdev_realize(DEVICE(&s->pci_dev), BUS(&s->pci_bus), errp);
>>> +    pci_create_simple(&s->pci_bus, PCI_DEVFN(0, 0), 
>>> TYPE_RAVEN_PCI_DEVICE);
>>>   }

<snip>

>>> @@ -361,7 +334,6 @@ static void raven_class_init(ObjectClass *klass, 
>>> const void *data)
>>>   static const TypeInfo raven_info = {
>>>       .name = TYPE_RAVEN_PCI_DEVICE,
>>>       .parent = TYPE_PCI_DEVICE,
>>> -    .instance_size = sizeof(RavenPCIState),
>>>       .class_init = raven_class_init,
>>>       .interfaces = (const InterfaceInfo[]) {
>>>           { INTERFACE_CONVENTIONAL_PCI_DEVICE },
>>
>> I agree with removing RavenPCIState, but pci_create_simple() isn't the 
>> right solution here because it both init()s and realize()s the inner 
>> object. The right way to do this is for the parent to init() its inner 
>> object(s) within its init() function, and similarly for it to 
>> realize() its inner object(s) within its realize() function.
>>
>> FWIW it looks as if the same mistake is present in several other 
>> hw/pci-host devices.
> 
> So maybe that's not a mistake then. There's no need to init and realize 
> it separately as this is an internal object which is enough to be 
> created in realize method and init and realize there at one go for which 
> pci_create_simple is appropriate. I think this inner object would only 
> need to be init separately if it exposed something (like a property) 
> that could be inspected or set before realize but that's not the case 
> here so it does not have to be created in init only in realize. (A lot 
> of simple devices don't even have init method only realize so init is 
> only needed for things that have to be set before realize.)

Do we have a consensus here ?

regards,
Harsh

> 
> Regards,
> BALATON Zoltan
> 

