Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDABACCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBecY-0004Fs-4Z; Wed, 22 Oct 2025 15:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vBecQ-0004FC-Ju; Wed, 22 Oct 2025 15:35:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vBecN-0002Ws-HD; Wed, 22 Oct 2025 15:35:34 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MDxYP1031143;
 Wed, 22 Oct 2025 19:35:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/2remY
 mmWb7dUko5oZSJMs510+zarKC4vZ9DesDvzxM=; b=cLvs79Ne3hfiljjQmy3LuW
 OP/4p72f+koLJVtHfV2SUSuDhO930n80v+RouUN+AJvOdlGGYri0Zxf9grBox9NI
 KbuR4muWcEj0Xq+bmgr5831Gk38E6xvMCnlytTpw7JGUpYCT6XfVM9zuo+7zQwys
 6KQWl0s1bpEnL8jFLhnzZ+cgdO9TNzLXbOUK8lsMpVuerRlALMa9xOqu6FuvtgY+
 JKPTRkos+mXGAbK7SBY0BHei4Xu58tyakxmILRQfRVmDQT8BWNgpQy3N20F5fBSN
 2s0B85zUcOPptHC7fA9vtU/d54JoI8dC6YYMMZibjmqXG9pIJXctg+c/p1k1njQw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vw92h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 19:35:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MHM1te032089;
 Wed, 22 Oct 2025 19:35:28 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vp7n25tp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 19:35:28 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59MJZRFR33292738
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Oct 2025 19:35:27 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 959C258059;
 Wed, 22 Oct 2025 19:35:27 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1DCB58057;
 Wed, 22 Oct 2025 19:35:26 +0000 (GMT)
Received: from [9.61.130.101] (unknown [9.61.130.101])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 22 Oct 2025 19:35:26 +0000 (GMT)
Message-ID: <6a017dfd-339b-4ad0-a5be-97f34cc4b8bf@linux.ibm.com>
Date: Wed, 22 Oct 2025 15:35:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] s390x: Build IPLB for virtio-pci devices
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20251020162023.3649165-1-jrossi@linux.ibm.com>
 <20251020162023.3649165-7-jrossi@linux.ibm.com>
 <2fe7ce6a-9e48-46f8-a91c-a2690b41f260@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <2fe7ce6a-9e48-46f8-a91c-a2690b41f260@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xyac5phXtYj8ArXpzMh94yzS7l8Q6gwN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXzN1L+KCamNN6
 ribbevRCr+SBa1CSUMGdffyIIJ5+p9+zkUItbYyaYeunpODYRGG6uiTDvpvPAEEVIcGz9shk0Q0
 zrn43kode7hnJJhl0JHWbeEMUhWU4NfnA2yQ1naivW2GZCcEIN7eCBgfKKe/a5d6pdYBEHtVYS1
 hCCJJoM2kfCgdk8fle51746J2atSvtaBduKpRPdONG+eyZeUT2tFoZaUxcD/wpxSTkeGwOkLqbl
 D66VzA6UgGj8hzRj2BONTAIgIhCQIHfpHN+3CsNo7IluSR/RjS6laozzPr9ViJPoSr5icA76CIL
 IPvTEQX8Te0x5o3Ooo6pCJPOXOzuoYep/ktJQ64v5X2juJhq6XU1VnGdeVQUN6rNpHBzTvtoFeq
 /wBwfZg3MMLCCFPh04wxfyRZ/xiefA==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f93201 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=KZ3Z-F9_PLUacrdqXr8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: xyac5phXtYj8ArXpzMh94yzS7l8Q6gwN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
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



On 10/21/25 10:08 AM, Thomas Huth wrote:
> On 20/10/2025 18.20, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> Search for a corresponding S390PCIBusDevice and build an IPLB if a 
>> device has
>> been indexed for boot but does not identify as a CCW device,
>>
>> PCI devices are not yet included in boot probing (they must have a 
>> boot index).
>> Per-device loadparm is not yet supported for PCI devices.
>
> Could you add it? Something similar to what has been done in 
> scsi_property_add_specifics() in hw/scsi/scsi-disk.c for the SCSI disks?
>
Sure. It will be included in the next version.

> ...
>> @@ -346,7 +349,7 @@ static void s390_ipl_set_boot_menu(S390IPLState 
>> *ipl)
>>   static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int 
>> *devtype)
>>   {
>>       CcwDevice *ccw_dev = NULL;
>> -    int tmp_dt = CCW_DEVTYPE_NONE;
>> +    int tmp_dt = S390_DEVTYPE_NONE;
>>         if (dev_st) {
>>           VirtIONet *virtio_net_dev = (VirtIONet *)
>> @@ -393,6 +396,31 @@ static CcwDevice 
>> *s390_get_ccw_device(DeviceState *dev_st, int *devtype)
>>       return ccw_dev;
>>   }
>>   +#define PCI_DEVTYPE_VIRTIO       0x05
>
> Is this for virtio-block only ? If so, I'd maybe rather name it 
> PCI_DEVTYPE_VIRTIO_BLK or so. Or will this be used for virtio-scsi-pci 
> etc., too?
I named it this way because it is the PCI equivalent of 
CCW_DEVTYPE_VIRTIO used in the above s390_get_ccw_device() function.  
Although The CCW function also has a different designation for 
virtio-net devices I don't think that will be useful for PCI (due to the 
change with the netboot binary).  So, this device type could be used for 
both virtio-blk-pci and virtio-net-pci.  Virtio-scsi-pci would need a 
different designation though (much like how there exists CCW_DEVTYPE_SCSI).

Regards,
Jared Rossi



