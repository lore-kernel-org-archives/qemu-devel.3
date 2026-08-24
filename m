Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AB7C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 22:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wydGp-0006DG-T9; Mon, 24 Aug 2026 18:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wydGp-0006D4-4C; Mon, 24 Aug 2026 18:35:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wydGn-0002mf-7D; Mon, 24 Aug 2026 18:35:58 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OJVU9S2857990; Mon, 24 Aug 2026 22:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ILfmid
 0SNPAY+ezbdylZmwPFxy+gYAw6CM7fsWIzAEw=; b=IuWSfv+bbTU/ZanP/3T9jj
 xvcdP/BgplTP4d9iwWqszURSl4ssbBFZqDXXQSWjmmna2c6sdQ5dInokUJbG0sbM
 gBYEtJDLgmK6JLLShQSWL2mbICrmmHZk3cj2iqhF1J0psnk/8k7jJH76tDvwSXO2
 AMjWMErhyJmgaMesr5usKlunN5XRxF6UhTWARdFVTEgplD22bRot/kQlsYPS2X3d
 VI0jnZfEsDNmlwydJyh8DyotKVsGZirGJ/d0KvbcUBzsly8fuWg0QOhB+IVyYffx
 shwwLPjiB6gVMh2bW+Nvhbd1XcPSMg5eJ+Naon34QfMpRPfbFLCczCTKxDNfsBgQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4mm78-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 22:35:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OMQO4q026908;
 Mon, 24 Aug 2026 22:35:51 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsy0njr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 22:35:51 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OMZnEx30212668
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 22:35:50 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF8A05805A;
 Mon, 24 Aug 2026 22:35:49 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0BB3858056;
 Mon, 24 Aug 2026 22:35:49 +0000 (GMT)
Received: from [9.61.21.147] (unknown [9.61.21.147])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 22:35:48 +0000 (GMT)
Message-ID: <e4520f30-6176-498e-840e-a5407aa68004@linux.ibm.com>
Date: Mon, 24 Aug 2026 18:35:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/15] s390x/pci: Implement migration for emulated
 devices
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260818172521.223460-1-kshk@linux.ibm.com>
 <20260818172521.223460-15-kshk@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260818172521.223460-15-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qSvB_sGf4zVshjwhG_TOkEwtClVVmiTR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE5MSBTYWx0ZWRfX5QPOlCG/UOLj
 9sOC9R57Z3r/q0NjLPg4N8k1+UxuQs7UZd3UQLgasb8ahYcY5Pg3N6cM0kaX3Bgz13OgPtnTy2D
 B37BQNwGfypgf7rGxKSWd8XxlNWa6QI=
X-Proofpoint-GUID: qSvB_sGf4zVshjwhG_TOkEwtClVVmiTR
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8cc748 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=UDfE9F3vlcjxGpvxn6gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE5MSBTYWx0ZWRfXxnz73Zsk5C6d
 410e8Y7ji+J1zbgN4ZIozG49qm8JlMhkOtRnplEjEdycKEFzhZtHRq+FV2kNExx3zf2Kl5TZXKG
 EMU9wYE03CmH0/04RhC5M/X0Bcs2m7i3XLq1+0o6UpG9gYkY75Mr8jWvvnlfzWmDbV8PuoYRk9k
 Sz18XQkKZJfKQTV71I/G17eS0dvDbQc3lzlLF31UP0n7NoluRHDrCYPxbHJ3sw/ow3RHVdqBoux
 rjeUsUhZHxmVJAIoE6KFX9GjtZSK4BP744lxXfKRUkCkafyDeJoFyvCEL/eS5neUslyPVSiJSB8
 Elf8aBKdRIlRjM3xQA5WyBq+Jc43vtGbaPPW2I4mHQmi8rmbPgj/TbUnRGzRXJvkP7UuH8jEzV0
 TjHAar6hRPD8wMe1jdDffjVBZ5YrkVi7EL+NKHGntCifmBuDf14iant1j3L2AY1XYitVClhfz5e
 wPyMZ5omgaImxKRxBsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240191
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 8/18/26 1:25 PM, Konstantin Shkolnyy wrote:
> Implement zPCI device state migration, consequently enabling migration
> of VMs that have emulated PCI devices, whether virtio or not.
> Migration is allowed for devices whose function handle has the
> FH_SHM_EMUL bit set. For these devices QEMU will save and restore the
> state of its zPCI emulator.
> 
> This will enable emulated PCI migration starting with s390-ccw-virtio-11.2.
> 
> Passthrough devices will continue to block migration.
> 
> Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c         | 195 +++++++++++++++++++++++++++++++-
>  hw/s390x/s390-pci-inst.c        |   2 +-
>  hw/s390x/s390-virtio-ccw.c      |   4 +
>  include/hw/s390x/s390-pci-bus.h |   4 +
>  4 files changed, 199 insertions(+), 6 deletions(-)
> 

One high level comment is that S390pciState has some fields in it that
need consideration.

pending_sei seems like it needs to be handled for sure.

Migrating next_idx would probably only be an optimization; it should get
re-calculated the next time a device is plugged if we don't migrate it.

I think we are OK with zpci_groups because we are only migrating
emulated devices, they should get recreated as-expected on the target.
If we were to ever change the default CLP payload, it would need to be
on a qemu machine boundary.
That would need to be re-visited for vfio-pci migration.  Basically, a
guest does not expect the CLP payload to change.

And then same for next_sim_grp, this is only used for vfio-pci devices
that disable interpretation support.
Not necessary now but would need to be re-visited for vfio-pci migration.

zpci_dma_limit is going to be null without vfio-pci; if/when vfio-pci is
supported I think the list will need to be re-populated (not migrated)
as part of updating the max_dma_limit and replaying the IOMMU.

bus_no, bus, zpci_table, iommu_table and zpci_devs all need to be
reconstructed on the target + fixed up during load for zpci_devs and
zpci_table.

[...]
>  static const TypeInfo s390_pcibus_info = {
>      .name = TYPE_S390_PCI_BUS,
>      .parent = TYPE_BUS,
>      .instance_size = sizeof(S390PCIBus),
> +    /*
> +     * Implement get_dev_path() to provide each zpci device with a unique
> +     * stable UID-based bus "path". The "path" is used as part of idstr in the
> +     * migration stream, making idstr unique and instance_id always 0.
> +     * For migration to succeed, (idstr+instance_id) must match those generated
> +     * during QEMU start. Without unique idstr, QEMU will generate variable
> +     * instance_id to distinquish devices, and that instance_id can change

Typo 's/distinquish/distinguish/' (replace the Q with a G)

[...]

> +        VMSTATE_BOOL(iommu_enabled, S390PCIBusDevice),
> +        VMSTATE_UINT64(g_iota, S390PCIBusDevice),
> +        VMSTATE_UINT64(pba, S390PCIBusDevice),
> +        VMSTATE_UINT64(pal, S390PCIBusDevice),
> +        VMSTATE_UINT64(max_dma_limit, S390PCIBusDevice),

As mentioned in an earlier patch, let's not migrate this value.

Since you are only migrating emulated devices for now and fencing
vfio-pci, it will always be 0.  Set it to 0 unconditionally during load,
before the iommu replay.

If we enable migration of vfio-pci in the future, we would have to
acquire the new DMA limit on the target side prior to the iommu replay
for those devices (while emulated devices remain a 0).



