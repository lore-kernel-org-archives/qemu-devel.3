Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538F1C2A09B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 16:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsNsn-000079-0s; Fri, 07 Aug 2026 12:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wsNsl-00006l-4e; Fri, 07 Aug 2026 12:57:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wsNsi-00068b-Sg; Fri, 07 Aug 2026 12:57:18 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677GlYQG153976; Fri, 7 Aug 2026 16:57:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=lfbwb1
 dBo7iTfiw791O693AJ8tlFqJxSTvQCbtyrAEA=; b=ON2liJ2ntxohccKGG4ki/W
 ix+tKyRyzUp+M8M764Jg7bO17E/lVOOJZXtnXFE7dvElzS95QktQC2sbOvZ+KWec
 vSw9aS2bJMMzS+t5jKxMzSrH8iDa1hMuKM6NXf4ECcqvij5l9ORmid7TMKmfb3DO
 t9nyi9e92qhdSQYaJ6xOjyV6g0q+RFrR0VW9vIB48lNaL6qGe+2mWiOi2pTL3t0C
 wDIjDqjNQiQKPPPJxbyfrqZzbZMRKZ2EwxrPxbPiBA7Ogi4h391AiuwQnMkK/p2O
 9IiPehEXLhh9zgp/Y/hDZuuB0pNG1FeLIsno1djz7Jsl0584AJcuIrx+UvEhWXQA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy01mxs3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Aug 2026 16:57:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677GuOnJ026031;
 Fri, 7 Aug 2026 16:57:10 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswu00a3q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Aug 2026 16:57:10 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 677Gv8Zp25559710
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Aug 2026 16:57:08 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 95BC35805B;
 Fri,  7 Aug 2026 16:57:08 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 171FA58058;
 Fri,  7 Aug 2026 16:57:08 +0000 (GMT)
Received: from [9.16.62.165] (unknown [9.16.62.165])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  7 Aug 2026 16:57:08 +0000 (GMT)
Message-ID: <ec3a1da6-07d4-4a7e-92ba-f173c277e949@linux.ibm.com>
Date: Fri, 7 Aug 2026 11:57:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/15] s390x/pci: Implement migration for emulated
 devices
To: Farhan Ali <alifm@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260804024443.56445-1-kshk@linux.ibm.com>
 <20260804024443.56445-15-kshk@linux.ibm.com>
 <b3bd5351-c51b-42fb-a1dc-09eb998befa9@linux.ibm.com>
Content-Language: en-US
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <b3bd5351-c51b-42fb-a1dc-09eb998befa9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PJS1U9tAXHVzQWOcykTMNBYVr0yvjoHA
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEzMSBTYWx0ZWRfX3kDaurejLZoB
 Q3c1tx57x92m0twgmJX9mKCYFU6kRml0tby5l+K9y0raOvT+3gQbOnlu9RmpzzOyJYmIlyVcoGS
 A0Uq4KTJiMgShsWxZwmT7M/b77zVxT0=
X-Proofpoint-ORIG-GUID: PJS1U9tAXHVzQWOcykTMNBYVr0yvjoHA
X-Authority-Analysis: v=2.4 cv=afNRWxot c=1 sm=1 tr=0 ts=6a760e67 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=y5_OHTmNZ1c2rmefk8oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEzMSBTYWx0ZWRfX5lDpqF0Vxbvn
 LHgCctMY2PP58CcAHopBLIBeIexHzmWxWi4AZ2yd+TRAp8aIH3e3UwDvRXAWiXI1b7XrduxHDFA
 eP2u25XiXl/3TDdp0DJotF3YgUhbnWwvLAvBxKwM7DNspNVfhoUuGUbVl0IC/5YnL/26ycgVaAk
 hV3FbHXMY+3f4I7hjGcmFXkpc9XIb2ibbTen0+0mpOHqrKfEMf1NfIidAurt+A67uN6MxhoONou
 ZmfzGcSmd6Eixifaz209GltHX9bYIM/coQoPHg+F9YN7IFlIwDK48YSZ7IFhYjE9/hhH8JDmxCL
 4bU7NHen9DRm6xM7PmS3I80mZ5gJhBXokClOax5U8PzP3cXDbL6D1+OsWvSZySVptWkc5NJ+/Pr
 R8lZRfZ0u8MHZSh+jkZ3wLNiXfKOHQoWNgqpvwBScD/0OFBEe0uw3fJqA8IUniknLd135SF1qG+
 EY2WSj5XBbTsljCul5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070131
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
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

On 260805 17:02, Farhan Ali wrote:
> 
> On 8/3/2026 7:44 PM, Konstantin Shkolnyy wrote:
>> Implement zPCI device state migration, consequently enabling migration
>> of VMs that have emulated PCI devices, whether virtio or not.
>> Migration is allowed for devices whose function handle has the
>> FH_SHM_EMUL bit set. For these devices QEMU will save and restore the
>> state of its zPCI emulator.
>>
>> This will enable emulated PCI migration starting with s390-ccw- 
>> virtio-11.1.
>>
>> Passthrough devices will continue to block migration.
>>
>> Signed-off-by: Konstantin Shkolnyy<kshk@linux.ibm.com>
>> ---
>>   hw/s390x/s390-pci-bus.c         | 189 +++++++++++++++++++++++++++++++-
>>   hw/s390x/s390-pci-inst.c        |   2 +-
>>   hw/s390x/s390-virtio-ccw.c      |   4 +
>>   include/hw/s390x/s390-pci-bus.h |   4 +
>>   4 files changed, 193 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index a94e24a2ac..9441c80ef4 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -26,6 +26,7 @@
>>   #include "hw/pci/pci_bridge.h"
>>   #include "hw/pci/msi.h"
>>   #include "exec/cpu-common.h"
>> +#include "migration/blocker.h"
>>   #include "qemu/error-report.h"
>>   #include "qemu/module.h"
>>   #include "system/physmem.h"
>> @@ -34,6 +35,11 @@
>>   #include "trace.h"
>> +static const Property phb_props[] = {
>> +    DEFINE_PROP_BOOL("x-zpci-emul-dev-migr-enabled", S390pciState,
>> +                     emul_dev_migr_enabled, true),
>> +};
>> +
>>   S390pciState *s390_get_phb(void)
>>   {
>>       static S390pciState *phb;
>> @@ -917,6 +923,23 @@ static void set_pbdev_info(S390PCIBusDevice *pbdev)
>>       pbdev->pci_group = s390_group_find(ZPCI_DEFAULT_FN_GRP);
>>   }
>> +static int s390_set_emul_dev_migration_blocker(S390pciState *s, Error 
>> **errp)
>> +{
>> +    if (s->emul_dev_migr_enabled) {
>> +        return 0;
>> +    }
>> +    error_setg(&s->emul_dev_migr_blocker,
>> +               "Migration disabled for emulated zPCI devices on this 
>> machine type");
>> +    return migrate_add_blocker(&s->emul_dev_migr_blocker, errp);
>> +}
>> +
> I was trying to test this patch series, and something i tried was doing 
> was a save/restore of a VM with just CCW devices. But with this patch 
> the save/restore of the VM fails with error:
> 
> error: Requested operation is not valid: cannot migrate domain: 
> Migration disabled for emulated zPCI devices on this machine type
> 
> I think this is a regression, as the save/restore works with the same 
> guest definition with current master branch. I also think this may break 
> live migration for guest with just CCW devices. Something to also note, 
> by default libvirt auto adds a pci-root controller to the guest 
> definition [1]. So i wonder if that's tripping up the migration blocker?
> 
> 
> [1] https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/ 
> html/virtualization_deployment_and_administration_guide/sect- 
> guest_virtual_machine_device_configuration-configuring_device_controllers

Yes, indeed there is this device in qtree, even without any PCI devices 
configured in the libvirt XML, and it blocks migration:

       dev: s390-pcihost, id ""
         x-zpci-emul-dev-migr-enabled = false
         x-config-reg-migration-enabled = true
         bypass-iommu = false
         bus: s390-pcibus.0
           type s390-pcibus
         bus: pci.0
           type PCI

Instead of creating a single migration blocker for this s390-pcihost, 
I'll create one for each PCI device if this x-zpci-emul-dev-migr-enabled 
flag if false.


