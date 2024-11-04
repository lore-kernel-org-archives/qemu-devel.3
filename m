Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713EED111A6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 05:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7pEE-00068w-8y; Mon, 04 Nov 2024 00:02:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1t7pE6-00068E-IA; Mon, 04 Nov 2024 00:02:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1t7pE4-0006Sg-2A; Mon, 04 Nov 2024 00:02:05 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A44EEZ9013832;
 Mon, 4 Nov 2024 05:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=rTzFal
 5oKcQjUd8cHibjiUn8hQv0Gw82+Sy008qxpWk=; b=gekVQAnIZvPcyfb6UwtGjZ
 45oZn7PYEhTRy+ZiRpxOUNAeR+w18yZnQgPhPsfCkDE8rD5Hj0iFiqMHE9iPQIuS
 /WTgKNeNMG3C7FkLGGD8hFswM8qtnAaQpdf0k2OIPPUg8Z8g9hc7CSxD/98YvUa1
 n1WkGm2EupQHalW5L/CBfnlJpt0WMqDuE9J02ae2aw1I930U9Og6cX/6T5DkJS6L
 3Txj97/Kpq9kwVUM5QhIeIE5JGOXeALYcgOXXAha6L7/+4I8iVStDWcLpzPFy4MC
 ifPbkJEUNIEsUVOXKzx7YlRP4GvWTA7B5PU8lskyKqo04Z5p08dF+ULDX87GhVJw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42pq1802u3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Nov 2024 05:01:51 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A451oS7001015;
 Mon, 4 Nov 2024 05:01:50 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42pq1802u1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Nov 2024 05:01:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3GsYYm032065;
 Mon, 4 Nov 2024 05:01:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nydmhfy8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Nov 2024 05:01:49 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A451kOr55247232
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 Nov 2024 05:01:46 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6EDF20040;
 Mon,  4 Nov 2024 05:01:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A174C20043;
 Mon,  4 Nov 2024 05:01:42 +0000 (GMT)
Received: from [9.124.213.130] (unknown [9.124.213.130])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  4 Nov 2024 05:01:42 +0000 (GMT)
Message-ID: <90d874e8-e479-42c5-8e3a-515387c62cc7@linux.ibm.com>
Date: Mon, 4 Nov 2024 10:31:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 02/14] hw/ppc/spapr_pci: Do not create DT for disabled
 PCI device
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20241022-reuse-v17-0-bd7c133237e4@daynix.com>
 <20241022-reuse-v17-2-bd7c133237e4@daynix.com>
 <50194bd5-cef8-484c-b8c3-bd616414f280@linux.ibm.com>
 <c1565bd8-a8a5-4cfb-905b-0f852562500d@daynix.com>
Content-Language: en-US
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
In-Reply-To: <c1565bd8-a8a5-4cfb-905b-0f852562500d@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: d7TepUhSHkDPGOa_C209Q5l3kgOuzPwB
X-Proofpoint-ORIG-GUID: W012GACXUy9dVvwD32Z_SUFSMKscNjth
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411040039
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


On 10/28/24 11:28 AM, Akihiko Odaki wrote:
> On 2024/10/28 12:08, Shivaprasad G Bhat wrote:
>>
>> On 10/22/24 2:06 PM, Akihiko Odaki wrote:
>>> Disabled means it is a disabled SR-IOV VF and hidden from the guest.
>>> Do not create DT when starting the system and also keep the disabled 
>>> PCI
>>> device not linked to DRC, which generates DT in case of hotplug.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>>   hw/ppc/spapr_pci.c | 14 +++++++++-----
>>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
>>> index 5c0024bef9c4..679a22fe4e79 100644
>>> --- a/hw/ppc/spapr_pci.c
>>> +++ b/hw/ppc/spapr_pci.c
>>> @@ -1291,8 +1291,7 @@ static void spapr_dt_pci_device_cb(PCIBus 
>>> *bus, PCIDevice *pdev,
>>>       PciWalkFdt *p = opaque;
>>>       int err;
>>> -    if (p->err) {
>>> -        /* Something's already broken, don't keep going */
>>> +    if (p->err || !pdev->enabled) {
>>>           return;
>>>       }
>>> @@ -1592,10 +1591,10 @@ static void spapr_pci_plug(HotplugHandler 
>>> *plug_handler,
>>>       uint32_t slotnr = PCI_SLOT(pdev->devfn);
>>>       /*
>>> -     * If DR is disabled we don't need to do anything in the case of
>>> -     * hotplug or coldplug callbacks.
>>> +     * If DR or the PCI device is disabled we don't need to do 
>>> anything
>>> +     * in the case of hotplug or coldplug callbacks.
>>>        */
>>> -    if (!phb->dr_enabled) {
>>> +    if (!phb->dr_enabled || !pdev->enabled) {
>>>           return;
>>>       }
>>
>> Thank you. This is the right place to be called from the hotplug handler
>>
>> instead of the spapr_pci_dt_populate() unlike I mentioned before..
>>
>>
>>> @@ -1680,6 +1679,11 @@ static void 
>>> spapr_pci_unplug_request(HotplugHandler *plug_handler,
>>>       }
>>>       g_assert(drc);
>>> +
>>> +    if (!drc->dev) {
>>> +        return;
>>
>> I agree with the change here, but were you able to get to this path? 
>> I don't see
>>
>>   this if condition being entered with,
>>
>> qemu-system-ppc64 -nographic  -serial none -device spapr-pci-host- 
>> bridge,index=4,id=pci.1  -device igb,id=igb0 <<< 'device_del igb0'
>
> No. VFs bypass the hotplug path when unplugging. For context, see 
> unparent_vfs() in "[PATCH v17 09/14] pcie_sriov: Reuse SR-IOV VF 
> device instances.
>
Thanks. Looks good to me.

Reviewed-by: Shivaprasad G Bhat<sbhat@linux.ibm.com>
Tested-by: Shivaprasad G Bhat<sbhat@linux.ibm.com>


Regards,

Shivaprasad

> Regards,
> Akihiko Odaki
>
>>
>>
>> Regards,
>>
>> Shivaprasad
>>
>>> +    }
>>> +
>>>       g_assert(drc->dev == plugged_dev);
>>>       if (!spapr_drc_unplug_requested(drc)) {
>>>
>

