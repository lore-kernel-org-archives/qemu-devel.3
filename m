Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0336D1812F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 16:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Nuf-0000pS-VL; Mon, 14 Oct 2024 12:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1t0NuQ-0000oF-VV; Mon, 14 Oct 2024 12:27:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1t0NuN-0008Rv-Pt; Mon, 14 Oct 2024 12:27:02 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EFnqFh024388;
 Mon, 14 Oct 2024 16:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:from:to:cc:references
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=9
 1v+v9uAgwtjzba52U8NGlJM9RVggebiThyx0fwxhc8=; b=n/xQGQ3N5mQgXt8Z6
 oChdyug/rJY+jwMPbMbLu8GKvWI1JR6xPlrC0oSwzMwPZpU7rLvz2OETy50iMsx/
 3uPKtuglr5i0Buzc4WDhiUnmGV4/EMe6SKPGw2JsC5GpDAn3WprRCNxLXGjwM6IA
 TQhuw+t1+0LH6/7Jc6VSl/hJchd0AP+uYmXXLNmK9XX/MemePBQ1GgXSq/wP2MI6
 P+Hf2RQzjBmQbKnL/Y515WKGAlq1AzghdXbRHd0OmPE5EQmPuf/VoI1s4f1QxWit
 Db2W2TXryNwWYPAc+dthmxDWAR3lFYCSU6NMrDtgyqJIVoYKipSAiARAxdTHjgek
 XejUA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42969m051f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Oct 2024 16:26:51 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49EGQoif017159;
 Mon, 14 Oct 2024 16:26:50 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42969m051a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Oct 2024 16:26:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49EE24J8027480;
 Mon, 14 Oct 2024 16:26:49 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4283txfkqf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Oct 2024 16:26:49 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49EGQj6H34275662
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Oct 2024 16:26:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8DE3E2004B;
 Mon, 14 Oct 2024 16:26:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2B4F20067;
 Mon, 14 Oct 2024 16:26:39 +0000 (GMT)
Received: from [9.124.219.41] (unknown [9.124.219.41])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Oct 2024 16:26:39 +0000 (GMT)
Message-ID: <afc250e2-18e6-43c0-911e-f252229f71ff@linux.ibm.com>
Date: Mon, 14 Oct 2024 21:56:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 02/13] hw/ppc/spapr_pci: Do not create DT for disabled
 PCI device
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240913-reuse-v16-0-d016b4b4f616@daynix.com>
 <20240913-reuse-v16-2-d016b4b4f616@daynix.com>
 <b143662e-67a1-4edf-8bfa-cf43039989a8@redhat.com>
 <8128049b-1070-481d-bd54-f98ee5c2e598@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <8128049b-1070-481d-bd54-f98ee5c2e598@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Q27kBdC-KkSdEaq16_OlO90_LPQ8Z9vQ
X-Proofpoint-ORIG-GUID: 88IMaKJgU1N_XK6djBWYjYo_CpEshZo6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_10,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=821 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410140113
Received-SPF: pass client-ip=148.163.158.5; envelope-from=sbhat@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 10/11/24 10:52 PM, Shivaprasad G Bhat wrote:
>
> On 9/18/24 7:57 PM, Cédric Le Goater wrote:
>> Hello,
>>
>> Adding :
>>
>>   Harsh for QEMU/PPC pseries machine,
>>   Shivaprasad for KVM/PPC VFIO and IOMMU support.
>>
>> Could you please give us your feedback on these changes ?
>>
>> Thanks,
>>
>> C.
>>
>>
>>
>>  On 9/13/24 05:44, Akihiko Odaki wrote:
>>> Disabled means it is a disabled SR-IOV VF or it is powered off, and
>>> hidden from the guest.
>
> I see you are taking care of not powering on VFs in the following 8th 
> patch in
>
> the series. Without it, this patch doesn't hold. Hope this patch and 
> the 8th patch
>
>  go together.
>
>
> Reviewed-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
>
>

While review/testing the patch again with the [8/13], I see the same 
check is needed

in spapr_pci_dt_populate() before the call to spapr_dt_pci_device() to 
take care of the

hotplug path. Kindly add the same there too. So, my Review-by would be 
with that.


Thanks,

Shivaprasad


> Thanks,
>
> Shivaprasad
>
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>>   hw/ppc/spapr_pci.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
>>> index 7cf9904c3546..f63182a03c41 100644
>>> --- a/hw/ppc/spapr_pci.c
>>> +++ b/hw/ppc/spapr_pci.c
>>> @@ -1296,6 +1296,10 @@ static void spapr_dt_pci_device_cb(PCIBus 
>>> *bus, PCIDevice *pdev,
>>>           return;
>>>       }
>>> +    if (!pdev->enabled) {
>>> +        return;
>>> +    }
>>>       err = spapr_dt_pci_device(p->sphb, pdev, p->fdt, p->offset);
>>>       if (err < 0) {
>>>           p->err = err;
>>>

