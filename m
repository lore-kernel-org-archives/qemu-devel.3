Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9422BD0D163
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 18:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdYZO-0003RE-H8; Wed, 07 Jan 2026 13:47:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vdYYf-0003Cz-8s; Wed, 07 Jan 2026 13:47:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vdYYd-0003LN-C8; Wed, 07 Jan 2026 13:47:00 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 607GmBdI018680;
 Wed, 7 Jan 2026 18:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=VBGA/x
 /t+oC1EVsqLS0W4Uj2+q138yPQNE3B7gQy/Uc=; b=T+52avL7wV6zdcmstp8qq2
 Aw/FSoXLiCiljJBw6PNzNSYcJl1khTsCR00VBqvhwMCZ6cFhUglfh/d9fmtq1d5m
 5Nka/qc/uRxKGlUu+9QXRp/BsnxcdQ5B+8NQ01w1Urd/p3eN/a2wDaqlhHAsLNGV
 +aUZCYMz7fMxy0/v+OmYqZZ51AcDv09l/gmjCShAsnHkJn2YRNZ/JbInUfWuL91H
 6RPls5JwWdaBmR0y3Ae84oqdVFtjEiNblUY8k8L8FFphKbO9lQM5sUOhzcGuSakk
 N9VV50oFSob+IAxCJOXpPl78bZKhpOwY1zSfS+GUQCwqIsFdr1jsRZHCJlqqeMQg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu6aq2g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jan 2026 18:46:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 607HtaP8014528;
 Wed, 7 Jan 2026 18:46:55 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfeen2t6d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jan 2026 18:46:54 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 607Ikr6T25821832
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Jan 2026 18:46:53 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DDAC58059;
 Wed,  7 Jan 2026 18:46:53 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4EB4E5804B;
 Wed,  7 Jan 2026 18:46:52 +0000 (GMT)
Received: from [9.61.39.95] (unknown [9.61.39.95])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  7 Jan 2026 18:46:52 +0000 (GMT)
Message-ID: <689115e6-c88d-4a43-81a2-a71180263bee@linux.ibm.com>
Date: Wed, 7 Jan 2026 13:46:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] hw: Add "loadparm" property to PCI devices for
 booting on s390x
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20251210205449.2783111-1-jrossi@linux.ibm.com>
 <20251210205449.2783111-10-jrossi@linux.ibm.com>
 <5e764e58-022c-4d0b-81d3-0564a15dea41@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <5e764e58-022c-4d0b-81d3-0564a15dea41@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QbNrf8bv c=1 sm=1 tr=0 ts=695eaa20 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=tMSkDYGm5BR7IfU_EXYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lCzGGo4zXBAcjz2RO1fa2nw2wAF8T35z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDE0NSBTYWx0ZWRfX//rNTfXMD6Eh
 8TgY6fLjrlBiQSH4v+ITPr17OdjPQX/hgOn+Erft1d8fFzfYAUuTa/pJOx0KOBTpmfoEwdmL374
 tb23HF5IWMOWmpcCDDmsSrcuudNPn1b3qkHu4xrRJS9z2XoNiSNcu6G7eoyP77zOarWbCu/FZtZ
 cpMjLNuCqQnE5sCi/XqPM6IbkBrLGkGSrRVrc+pbGCzFGSwuHK9TINDw4R7YdFR2r6k54uXxaJz
 TA2EbEahIqWzq2y5D0RHzVcZrs5bF7kKqrhEJZTCCsy4+BKC1pb1zJIiZwcEo01k9d63AxJ8Tgs
 IXWRmJDkr0eQeg5e2/4AACRXXbbjbXrarU5sg+P7eEDsruqn+9VHnAeQNrN3uz0IcYARtQTppxU
 +dMqIwT55RVJZUMCFvkxbsGFyf20wIaEfChg9uxa+pX1Qwn3RJpGgRG92mLqdjEaewHTzAR/5aL
 PA7xWmm9VDDhcxxc+UQ==
X-Proofpoint-GUID: lCzGGo4zXBAcjz2RO1fa2nw2wAF8T35z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601070145
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 1/7/26 10:50 AM, Thomas Huth wrote:
> On 10/12/2025 21.54, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> The loadparm is required on s390x to pass the information to the boot 
>> loader
>> such as which kernel should be started or whether the boot menu 
>> should be shown.
>>
>> Because PCI devices do not naturally allocate space for this, the 
>> property is
>> added on an architecture specific basis.
>>
>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>> ---
>>   include/hw/pci/pci_device.h |  3 +++
>>   hw/pci/pci.c                | 39 +++++++++++++++++++++++++++++++++++++
>>   hw/s390x/ipl.c              | 11 +++++++++--
>>   3 files changed, 51 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
>> index 88ccea5011..5cac6e1688 100644
>> --- a/include/hw/pci/pci_device.h
>> +++ b/include/hw/pci/pci_device.h
>> @@ -62,6 +62,9 @@ struct PCIDevice {
>>       bool partially_hotplugged;
>>       bool enabled;
>>   +    /* only for s390x */
>> +    char *loadparm;
>> +
>>       /* PCI config space */
>>       uint8_t *config;
>>   diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index b1eba348e0..1ea0d7c54c 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -36,6 +36,7 @@
>>   #include "migration/qemu-file-types.h"
>>   #include "migration/vmstate.h"
>>   #include "net/net.h"
>> +#include "system/arch_init.h"
>>   #include "system/numa.h"
>>   #include "system/runstate.h"
>>   #include "system/system.h"
>> @@ -2825,6 +2826,43 @@ int pci_qdev_find_device(const char *id, 
>> PCIDevice **pdev)
>>       return rc;
>>   }
>>   +static char *pci_qdev_property_get_loadparm(Object *obj, Error 
>> **errp)
>> +{
>> +    return g_strdup(PCI_DEVICE(obj)->loadparm);
>> +}
>> +
>> +static void pci_qdev_property_set_loadparm(Object *obj, const char 
>> *value,
>> +                                       Error **errp)
>> +{
>> +    void *lp_str;
>> +
>> +    if (object_property_get_int(obj, "bootindex", NULL) < 0) {
>> +        error_setg(errp, "'loadparm' is only valid for boot devices");
>> +        return;
>> +    }
>> +
>> +    lp_str = g_malloc0(strlen(value) + 1);
>> +    if (!qdev_prop_sanitize_s390x_loadparm(lp_str, value, errp)) {
>> +        g_free(lp_str);
>> +        return;
>> +    }
>> +    PCI_DEVICE(obj)->loadparm = lp_str;
>> +}
>> +
>> +static void pci_qdev_property_add_specifics(DeviceClass *dc)
>> +{
>> +    ObjectClass *oc = OBJECT_CLASS(dc);
>> +
>> +    /* The loadparm property is only supported on s390x */
>> +    if (qemu_arch_available(QEMU_ARCH_S390X)) {
>> +        object_class_property_add_str(oc, "loadparm",
>> + pci_qdev_property_get_loadparm,
>> + pci_qdev_property_set_loadparm);
>> +        object_class_property_set_description(oc, "loadparm",
>> +                                              "load parameter (s390x 
>> only)");
>> +    }
>> +}
>
> Adding this unconditionally to each and every PCI device is a little 
> bit ugly ... could we please limit this to virtio-blk-pci devices for 
> now?
> (or maybe check if there is a bootindex property, and only add it for 
> devices with a bootindex property?)
>
>  Thomas
>

Maybe I'm missing some nuance, but won't the check in 
pci_qdev_property_set_loadparm() already enforce that this is only added 
to boot devices?

Hmm... on second though, I guess the problem is that a loadparm property 
will still be added (but not necessarily set) for all PCI devices?  I 
agree that is not good.  I will limit what qualifies for the property to 
be added in the first place.

Thanks,
Jared Rossi

