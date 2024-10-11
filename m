Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AC8D24470
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJMx-0004Yr-0A; Fri, 11 Oct 2024 13:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1szJMo-00049x-MV; Fri, 11 Oct 2024 13:23:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1szJMm-0005Gw-5r; Fri, 11 Oct 2024 13:23:54 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BEwEYJ014379;
 Fri, 11 Oct 2024 17:23:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:from:subject:to:cc:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 36JLlCOmLs2p/IH/fJ8MHwYax3e/Jt8+3zgGG3y5LPE=; b=GnFTWmMgj+zxMvXG
 +SGjpawozbFY8VKYtrb/mmcxZdNcdfm/JPDu6ZkvdD5birpvm6KBrLTtpuwUaqkG
 0Sngc37VHyIIVJipjV+AcNl0lzjNwLZX3R6rwIRmtB88Pk13rwVghAPE7X5wg0Dh
 if4MGyF72LE7Hu4KrzYM9OeTw+GWNqtYj7nnR5A+PAxf7Hp/wp1O0/usQMij0uQv
 LXBHHTQGHu+JRZbSvCQEt1GMHie5CkV4vbQQETL/jaqriJPCRYzQ663RtOc7A8Tn
 x7lkkvaHF5EQ1/A2XD81tjmkl8qvWRkoqsz7shfVr5LxPvY1qcehCHHwcGYP/Euv
 +H050Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42767x0njx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Oct 2024 17:23:02 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49BHN11I020969;
 Fri, 11 Oct 2024 17:23:01 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42767x0njs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Oct 2024 17:23:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49BEefZS022856;
 Fri, 11 Oct 2024 17:23:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423h9kenv2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Oct 2024 17:23:00 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49BHMuM79765186
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Oct 2024 17:22:56 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9874520043;
 Fri, 11 Oct 2024 17:22:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AFBDE20040;
 Fri, 11 Oct 2024 17:22:52 +0000 (GMT)
Received: from [9.39.17.157] (unknown [9.39.17.157])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Oct 2024 17:22:52 +0000 (GMT)
Message-ID: <84adb86d-a60c-4468-84a3-5bdc545bc161@linux.ibm.com>
Date: Fri, 11 Oct 2024 22:52:52 +0530
User-Agent: Mozilla Thunderbird
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: Re: [PATCH v16 03/13] hw/ppc/spapr_pci: Do not reject VFs created
 after a PF
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
 <20240913-reuse-v16-3-d016b4b4f616@daynix.com>
 <3cc3456d-a47d-4960-9d5e-10cf1c8b4beb@redhat.com>
Content-Language: en-US
In-Reply-To: <3cc3456d-a47d-4960-9d5e-10cf1c8b4beb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5xlgVMVJLAIG8La36nBbuWLyIB1Aht8e
X-Proofpoint-ORIG-GUID: qrFE37GSQXS5pR6chAGwI2hHXjWYkzgy
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_14,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410110118
Received-SPF: pass client-ip=148.163.156.1; envelope-from=sbhat@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 9/18/24 7:57 PM, Cédric Le Goater wrote:
> Adding :
>
>   Harsh for QEMU/PPC pseries machine,
>   Shivaprasad for KVM/PPC VFIO and IOMMU support.
>
> Thanks,
>
> C.
>
>
> On 9/13/24 05:44, Akihiko Odaki wrote:
>> A PF may automatically create VFs and the PF may be function 0.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   hw/ppc/spapr_pci.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
>> index f63182a03c41..ed4454bbf79e 100644
>> --- a/hw/ppc/spapr_pci.c
>> +++ b/hw/ppc/spapr_pci.c
>> @@ -1573,7 +1573,9 @@ static void spapr_pci_pre_plug(HotplugHandler 
>> *plug_handler,
>>        * hotplug, we do not allow functions to be hotplugged to a
>>        * slot that already has function 0 present
>>        */
>> -    if (plugged_dev->hotplugged && bus->devices[PCI_DEVFN(slotnr, 
>> 0)] &&
>> +    if (plugged_dev->hotplugged &&
>> +        !pci_is_vf(pdev) &&

I see there is history to this change. The reverted[1] virtio-net-pci 
SRIOV emulation support

needed this as the VFs were explicitly specified with -device 
virtio-net-pci,sriov-pf=X

property. I see the pre_plug handlers for the VFs cant be reached now 
with the reverted

code base for the other devices(nvme and igb) supporting the SRIOV 
emulation.


Do the VFs really reach this path in today's code base ? Other than the 
above

workflow, the pre_plug() handlers wont be called for VFs when the

echo X > /<sys-fs-pf-path>/sriov_numvfs inside the guest too. I don't 
see the

workflow(PF automatically creating VFs) to hit this path. Could you 
clarify how?


I see before the revert of virito-net-pci sriov use-case, the out of 
order VF hot|cold

plug post PF are prevented here. Even if we allowed VFs to continue 
here, PFs were

prevented in pcie_sriov_register_device() which is followed sequentially 
anyway. Now,

as the pcie_sriov_register_device() is no longer there, this check 
actually makes

sense as this would be the only place we avoid the out of order plugging.


On a side note, for testing this fulky on PPC, we need more work on Qemu 
today as the

open-sriov[2] is supported only on PowerVM.


Thanks,

Shivaprasad


Reference :

[1] - Atleast till commit b0fdaee5d1

[2] - 
https://lore.kernel.org/linuxppc-dev/20180105164552.36371-1-bryantly@linux.vnet.ibm.com/


