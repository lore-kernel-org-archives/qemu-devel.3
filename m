Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4F810F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYSy-00061e-I6; Wed, 08 Apr 2026 15:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wAY41-0006GV-Dk; Wed, 08 Apr 2026 14:55:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wAS3F-0007h0-B8; Wed, 08 Apr 2026 08:30:35 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6387EHeQ2590952; Wed, 8 Apr 2026 12:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=FG7pfh
 6FfwPjQkkJumHrYmpDSREH9azgO7En8yQs/Bg=; b=gqZAOXfyQs4oddvitVWU5y
 236XTQdlp0SuEfSWjjyBmdk3A+XXDqCew0KShOw2ZyruD5t/QpzWHiz7Iot6AZB3
 qG00r147VXPbl5zXAnnUdpmRqmd3e4cwY3zReuTKynkiJ2hfwbyukGsS/HGs74mB
 HJVLnuI4WX8n/N7nKxPjEy1NGwHa+6fdP9IU+0FBb1EMFPz8HOqy2VvUcKYF+lZe
 JliU6Z6bvaJEDjp+ZT1p13E2PM5psLRE+lGh/NCSAo7b+W3IUET9rJUoq0GjIb6v
 fEdJ5py9SW3erCzTRH4tf/LMpdqIWKv27TsdAwB8JYZT2iNVbIMekA+FJKxpMxNg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2e7xbn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Apr 2026 12:28:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 638B8mlf014352;
 Wed, 8 Apr 2026 12:28:23 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg4qbgh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Apr 2026 12:28:23 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 638CSNTi31326786
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Apr 2026 12:28:23 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA7DA58061;
 Wed,  8 Apr 2026 12:28:22 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3711D58059;
 Wed,  8 Apr 2026 12:28:22 +0000 (GMT)
Received: from [9.61.9.165] (unknown [9.61.9.165])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Apr 2026 12:28:22 +0000 (GMT)
Message-ID: <e4e1ea36-29c7-47df-86d1-d108106a006a@linux.ibm.com>
Date: Wed, 8 Apr 2026 08:28:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] s390x/pci: Implement migration for emulated devices
To: Thomas Huth <thuth@redhat.com>, Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260402022921.298818-1-kshk@linux.ibm.com>
 <20260402022921.298818-15-kshk@linux.ibm.com>
 <021768ba-9871-421d-8b45-80c5ade6a456@redhat.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <021768ba-9871-421d-8b45-80c5ade6a456@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -t7IcIQqs9mcnktNEbxUDfFm3zcQei1I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDExNCBTYWx0ZWRfXyIXMtag7oBIc
 aiW5yb0LbPUJuJH2H+LGis2MfLkzEYpklOHL8E4ruSJgEe/bOUKFod7Yr5QFWX00U+y+K9500jn
 +UmFNob1ekwszhtPbmlgaGChFtPzADwedcm9FJP+oOLIe1idwiBAouZUwp8KLONK+yz//yyjpD+
 tYG20ZbQZLZdRmmvN9XbYoiJWrwOSPJkBKueRnTh7/g13w9gwHG8hUptBi/9hNd6+UzAeuoX1ZI
 zzUYZP9Q1aizDJntvjGyV8vH8sIZlTCjPDk1p2pbxCWq+Hf/efAIhQ2BI1VCtoBZH5bI61k8a69
 AwAyppx7vLA+mZseDUm+iQ+aTCS9VVoxwdFB3ycW+Og/L3sThxjatCyMG2a+vsebdbOgTej+eej
 KM8PGjREKYS3saO05zkhqjCrBnSjXYMAJY+pHCfELkfjkhHtg9YwejmcryZho1P90qcdPTmv+Zg
 U3imU61m4pMH62qeOjA==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d649e9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=Pc-w_4VLyfRQh03BNDkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -t7IcIQqs9mcnktNEbxUDfFm3zcQei1I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_04,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080114
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 4/8/26 6:01 AM, Thomas Huth wrote:
> On 02/04/2026 04.29, Konstantin Shkolnyy wrote:
>> Implement zPCI device state migration, consequently enabling migration
>> of VMs that have emulated PCI devices, whether virtio or not.
>> Migration is allowed for devices whose function handle has the
>> FH_SHM_EMUL bit set. For these devices QEMU will save and restore the
>> state of its zPCI emulator.
>>
>> Passthrough devices will continue to block migration.
>>
>> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>> ---
>>   hw/s390x/s390-pci-bus.c         | 112 ++++++++++++++++++++++++++++++--
>>   hw/s390x/s390-pci-inst.c        |   2 +-
>>   include/hw/s390x/s390-pci-bus.h |   2 +
>>   3 files changed, 110 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index f339a0fd94..b3037b9a8a 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> ...
>> +static const VMStateDescription s390_pci_device_vmstate = {
>> +    .name = TYPE_S390_PCI_DEVICE,
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .post_load = s390_pci_device_post_load,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_UINT32(state, S390PCIBusDevice),
>> +        VMSTATE_UINT16(uid, S390PCIBusDevice),
>> +        VMSTATE_UINT32(idx, S390PCIBusDevice),
>> +        VMSTATE_UINT32(fh, S390PCIBusDevice),
>> +        VMSTATE_UINT32(fid, S390PCIBusDevice),
>> +        VMSTATE_BOOL(fid_defined, S390PCIBusDevice),
>> +        VMSTATE_UINT64(fmb_addr, S390PCIBusDevice),
>> +        VMSTATE_UINT32(fmb.format, S390PCIBusDevice),
>> +        VMSTATE_UINT32(fmb.sample, S390PCIBusDevice),
>> +        VMSTATE_UINT64(fmb.last_update, S390PCIBusDevice),
>> +        VMSTATE_UINT64_ARRAY(fmb.counter, S390PCIBusDevice,
>> +                ARRAY_SIZE(((S390PCIBusDevice *)0)->fmb.counter)),
>> +        VMSTATE_UINT64(fmb.fmt0.dma_rbytes, S390PCIBusDevice),
>> +        VMSTATE_UINT64(fmb.fmt0.dma_wbytes, S390PCIBusDevice),
>> +        VMSTATE_UINT8(isc, S390PCIBusDevice),
>> +        VMSTATE_UINT16(noi, S390PCIBusDevice),
>> +        VMSTATE_UINT8(sum, S390PCIBusDevice),
>> +        VMSTATE_UINT8(pft, S390PCIBusDevice),
>> +        VMSTATE_UINT64(routes.adapter.ind_addr, S390PCIBusDevice),
>> +        VMSTATE_UINT64(routes.adapter.summary_addr, S390PCIBusDevice),
>> +        VMSTATE_UINT64(routes.adapter.ind_offset, S390PCIBusDevice),
>> +        VMSTATE_UINT32(routes.adapter.summary_offset, S390PCIBusDevice),
>> +        VMSTATE_UINT32(routes.adapter.adapter_id, S390PCIBusDevice),
>> +        VMSTATE_BOOL(iommu_enabled, S390PCIBusDevice),
>> +        VMSTATE_UINT64(g_iota, S390PCIBusDevice),
>> +        VMSTATE_UINT64(pba, S390PCIBusDevice),
>> +        VMSTATE_UINT64(pal, S390PCIBusDevice),
>> +        VMSTATE_UINT64(max_dma_limit, S390PCIBusDevice),
>> +        VMSTATE_PTR_TO_IND_ADDR(summary_ind, S390PCIBusDevice),
>> +        VMSTATE_PTR_TO_IND_ADDR(indicator, S390PCIBusDevice),
>> +        VMSTATE_BOOL(pci_unplug_request_processed, S390PCIBusDevice),
>> +        VMSTATE_BOOL(unplug_requested, S390PCIBusDevice),
>> +        VMSTATE_BOOL(interp, S390PCIBusDevice),
>> +        VMSTATE_BOOL(forwarding_assist, S390PCIBusDevice),
>> +        VMSTATE_BOOL(aif, S390PCIBusDevice),
>> +        VMSTATE_BOOL(rtr_avail, S390PCIBusDevice),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>>   };
>  Hi!
> 
> I assume this will likely break backward migration with old machine types?
> 
> Could you please try whether migrating a s390-ccw-virtio-10.2 machine
> from an old version of QEMU to a version of QEMU that includes your
> patches, and back from the new version to the old version works as
> expected?
> 
> If not, you might need to add a ".needed = ..." line to the
> s390_pci_device_vmstate, with a function that checks a variable from the
> machine state whether the PCI state is allowed or not. And then enable
> that variable only on the newest -11.1 machine type once it is available.

+1, I was having the same thought but hadn't gotten around to trying it yet.

We do already have a few examples for zPCI where we did this even though
migration was not even supported yet to kind of lay the groundwork for
backward migration ahead of time.

But honestly, looking at just this series in isolation, my concern is
things like an older machine type would not have the IOMMU replay
functionality added in patch 1.

So yes, please test to see what happens but make sure to include IOMMU
activity in that testing.

Tying this to a machine type is probably the safest bet, and given that
virtio-pci is not the default virtio transport on s390x I don't think it
would cause much hardship.
11.1 machine isn't available yet but I imagine will be soon after QEMU
11.0 release -- you can use Connie's series as a base:
https://lore.kernel.org/qemu-devel/20260331140347.653404-1-cohuck@redhat.com/


