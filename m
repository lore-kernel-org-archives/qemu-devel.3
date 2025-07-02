Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D79FC83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 05:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWqMZ-0006v5-9F; Wed, 02 Jul 2025 01:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uWqMV-0006uS-03; Wed, 02 Jul 2025 01:50:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uWqML-0001zW-1c; Wed, 02 Jul 2025 01:50:23 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5621kbW6032651;
 Wed, 2 Jul 2025 05:50:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=WUW7f0
 pv6tHR0ffLpjCqggBKn73+6T9JL1z5/D9xCoI=; b=IUs13MMUeI67bpdxXbntl5
 EjMKbVc6mA6m4yYRsqv2T4/lSlXWnfFExyioPff82XM9OqJSZiX4KBcfRtCiTV7B
 UwLBK68/WdKqNaPOWvbUh9C75ZUuu9Yvmu5KfAVmU0xeBrCvttChdqJYf3Q9SRWF
 Uuy44mWMVSxG1j1udOTq6/V+nbViQf/csPAX9UpK/8+74kE0M912bQAdmL7lDkdA
 A5Nf4gs7Bn1mG87ro8mRVTiHbtMpuq9Ocb9P4G8dn7/gLHADepY1ifaEtO15OAbi
 atEZAfAHlZ49Oukl0vXxAm2DlEkD9eh/q5cgxIFNgDIWLbG5Vcvs6+xGuD6yMp/Q
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j7wrkk39-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Jul 2025 05:50:11 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5625oBni012017;
 Wed, 2 Jul 2025 05:50:11 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j7wrkk35-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Jul 2025 05:50:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5621G3Z4011873;
 Wed, 2 Jul 2025 05:50:09 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47jv7mx0pr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Jul 2025 05:50:09 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5625o8f714025402
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Jul 2025 05:50:09 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C5A4F58058;
 Wed,  2 Jul 2025 05:50:08 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 688DA5805B;
 Wed,  2 Jul 2025 05:50:04 +0000 (GMT)
Received: from [9.39.26.167] (unknown [9.39.26.167])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  2 Jul 2025 05:50:04 +0000 (GMT)
Message-ID: <ece06429-f17c-4ce1-9718-87929b72a3f6@linux.ibm.com>
Date: Wed, 2 Jul 2025 11:20:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] treewide: update docs file extensions (.txt -> .rst)
 in comments
To: Sean Wei <me@sean.taipei>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>
References: <20250616.qemu.relocated@sean.taipei>
 <20250616.qemu.relocated.05@sean.taipei>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20250616.qemu.relocated.05@sean.taipei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E/PNpbdl c=1 sm=1 tr=0 ts=6864c893 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=f7IdgyKtn90A:10 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=Lm4k6Wx4rnOZHVdF27EA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _RzbbUMHgAjXwq-WKm2xPi2JWmwchHU1
X-Proofpoint-ORIG-GUID: 8zV6gtCOS2tGH1rJ-DKoOnmJp5F3bFlD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA0NCBTYWx0ZWRfX47nABBLFL9qQ
 fOPjkpxu9lwJ0h8WRBH/3AJVkMFESOe3Tf+ivU1c0PAwnSS4cANlt0EX4wwxCsGzQSJZxY9etqp
 imgl8D6v0/3XgSx1V2A7V5MrFILQ9l7prQ1pIObsqEsxEgy8v/dD9Hkj4Vdcxu3D8jk93hMUwJx
 N62otOQs5EZUhrKIcSrufIJzkWs50bs0IZYfqNuQ8LJnN6QZeqI5utHqPLTJ+cMzXaJ8e0FxVUI
 v8QLpYkIBFOAPLjL6Njo3K+7Fyx22cheNRz3mgzPxk0NeiU8r72BVl/UsVrSynMoB8ksbj9oOuV
 hkG1eWcQV0EXnX1HA/+gLWvsk9H7rJxDo0jRjTpSnnRnzilKgTqKciG5xXXWxtz+revgZVCHp1N
 nZ8LKpAgRkCjAYOj6ABqUKWfJenHMD/bpOh0XXyHA+an+EhfiDfYyUD6TV1t/P7/BnsxNSrQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 clxscore=1011 adultscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507020044
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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



On 6/16/25 21:20, Sean Wei wrote:
> Several source comments still refer to docs with the old .txt
> extension that were previously converted to reStructuredText.
> 
> Update these references to use the correct .rst extensions to
> maintain accurate in-tree documentation pointers.
> 
> No functional changes.
> 
> Related commits:
>    50f8174c5c1 (Jul 2021): docs/specs/acpi_nvdimm: Convert to rST
>    f054eb1c920 (Jul 2021): docs/specs/acpi_pci_hotplug: Convert to rST
>    912fb3678b8 (Sep 2023): docs/specs/vmgenid: Convert to rST
>    bb1cff6ee04 (Sep 2023): docs/specs/ivshmem-spec: Convert to rST
>    55ff468f781 (Jan 2022): docs: Rename ppc-spapr-hotplug.txt to .rst
> 
> Signed-off-by: Sean Wei <me@sean.taipei>
> ---
>   hw/acpi/nvdimm.c               | 2 +-
>   hw/acpi/pcihp.c                | 2 +-
>   hw/acpi/vmgenid.c              | 6 +++---
>   hw/misc/ivshmem-flat.c         | 2 +-
>   hw/ppc/spapr.c                 | 2 +-
>   include/hw/acpi/pcihp.h        | 2 +-
>   include/hw/misc/ivshmem-flat.h | 2 +-
>   tests/qtest/vmgenid-test.c     | 2 +-
>   8 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> 
> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> index 9ba90806f2..732d613ac0 100644
> --- a/hw/acpi/nvdimm.c
> +++ b/hw/acpi/nvdimm.c
> @@ -535,7 +535,7 @@ nvdimm_dsm_no_payload(uint32_t func_ret_status, hwaddr dsm_mem_addr)
>   
>   #define NVDIMM_QEMU_RSVD_HANDLE_ROOT         0x10000
>   
> -/* Read FIT data, defined in docs/specs/acpi_nvdimm.txt. */
> +/* Read FIT data, defined in docs/specs/acpi_nvdimm.rst. */
>   static void nvdimm_dsm_func_read_fit(NVDIMMState *state, NvdimmDsmIn *in,
>                                        hwaddr dsm_mem_addr)
>   {
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index aac90013d4..497281ae20 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -3,7 +3,7 @@
>    *
>    * QEMU supports PCI hotplug via ACPI. This module
>    * implements the interface between QEMU and the ACPI BIOS.
> - * Interface specification - see docs/specs/acpi_pci_hotplug.txt
> + * Interface specification - see docs/specs/acpi_pci_hotplug.rst
>    *
>    * Copyright (c) 2013, Red Hat Inc, Michael S. Tsirkin (mst@redhat.com)
>    * Copyright (c) 2006 Fabrice Bellard
> diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
> index fac3d6d97e..33c35c85dd 100644
> --- a/hw/acpi/vmgenid.c
> +++ b/hw/acpi/vmgenid.c
> @@ -38,7 +38,7 @@ void vmgenid_build_acpi(VmGenIdState *vms, GArray *table_data, GArray *guid,
>       guid_le = qemu_uuid_bswap(vms->guid);
>       /* The GUID is written at a fixed offset into the fw_cfg file
>        * in order to implement the "OVMF SDT Header probe suppressor"
> -     * see docs/specs/vmgenid.txt for more details
> +     * see docs/specs/vmgenid.rst for more details
>        */
>       g_array_insert_vals(guid, VMGENID_GUID_OFFSET, guid_le.data,
>                           ARRAY_SIZE(guid_le.data));
> @@ -101,7 +101,7 @@ void vmgenid_build_acpi(VmGenIdState *vms, GArray *table_data, GArray *guid,
>        * < 4GB, but write 64 bits anyway.
>        * The address that is patched in is offset in order to implement
>        * the "OVMF SDT Header probe suppressor"
> -     * see docs/specs/vmgenid.txt for more details.
> +     * see docs/specs/vmgenid.rst for more details.
>        */
>       bios_linker_loader_write_pointer(linker,
>           VMGENID_ADDR_FW_CFG_FILE, 0, sizeof(uint64_t),
> @@ -153,7 +153,7 @@ static void vmgenid_update_guest(VmGenIdState *vms)
>               guid_le = qemu_uuid_bswap(vms->guid);
>               /* The GUID is written at a fixed offset into the fw_cfg file
>                * in order to implement the "OVMF SDT Header probe suppressor"
> -             * see docs/specs/vmgenid.txt for more details.
> +             * see docs/specs/vmgenid.rst for more details.
>                */
>               cpu_physical_memory_write(vmgenid_addr, guid_le.data,
>                                         sizeof(guid_le.data));
> diff --git a/hw/misc/ivshmem-flat.c b/hw/misc/ivshmem-flat.c
> index be28c24d73..fe4be6be17 100644
> --- a/hw/misc/ivshmem-flat.c
> +++ b/hw/misc/ivshmem-flat.c
> @@ -362,7 +362,7 @@ static bool ivshmem_flat_connect_server(DeviceState *dev, Error **errp)
>        *
>        *  ivshmem_flat_recv_msg() calls return 'msg' and 'fd'.
>        *
> -     *  See ./docs/specs/ivshmem-spec.txt for details on the protocol.
> +     *  See docs/specs/ivshmem-spec.rst for details on the protocol.
>        */
>   
>       /* Step 0 */
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 702f774cda..08615f6c90 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -577,7 +577,7 @@ static int spapr_dt_dynamic_memory(SpaprMachineState *spapr, void *fdt,
>   
>   /*
>    * Adds ibm,dynamic-reconfiguration-memory node.
> - * Refer to docs/specs/ppc-spapr-hotplug.txt for the documentation
> + * Refer to docs/specs/ppc-spapr-hotplug.rst for the documentation
>    * of this device tree node.
>    */
>   static int spapr_dt_dynamic_reconfiguration_memory(SpaprMachineState *spapr,
> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> index a97904bada..cdc0cb8e43 100644
> --- a/include/hw/acpi/pcihp.h
> +++ b/include/hw/acpi/pcihp.h
> @@ -3,7 +3,7 @@
>    *
>    * QEMU supports PCI hotplug via ACPI. This module
>    * implements the interface between QEMU and the ACPI BIOS.
> - * Interface specification - see docs/specs/acpi_pci_hotplug.txt
> + * Interface specification - see docs/specs/acpi_pci_hotplug.rst
>    *
>    * Copyright (c) 2013, Red Hat Inc, Michael S. Tsirkin (mst@redhat.com)
>    * Copyright (c) 2006 Fabrice Bellard
> diff --git a/include/hw/misc/ivshmem-flat.h b/include/hw/misc/ivshmem-flat.h
> index 09bc3abcad..3eca99004e 100644
> --- a/include/hw/misc/ivshmem-flat.h
> +++ b/include/hw/misc/ivshmem-flat.h
> @@ -36,7 +36,7 @@ typedef struct IvshmemFTState IvshmemFTState;
>   
>   DECLARE_INSTANCE_CHECKER(IvshmemFTState, IVSHMEM_FLAT, TYPE_IVSHMEM_FLAT)
>   
> -/* Ivshmem registers. See ./docs/specs/ivshmem-spec.txt for details. */
> +/* Ivshmem registers. See docs/specs/ivshmem-spec.rst for details. */
>   enum ivshmem_registers {
>       INTMASK = 0,
>       INTSTATUS = 4,
> diff --git a/tests/qtest/vmgenid-test.c b/tests/qtest/vmgenid-test.c
> index e613374665..33e96b7c55 100644
> --- a/tests/qtest/vmgenid-test.c
> +++ b/tests/qtest/vmgenid-test.c
> @@ -61,7 +61,7 @@ static uint32_t acpi_find_vgia(QTestState *qts)
>   
>               /* The GUID is written at a fixed offset into the fw_cfg file
>                * in order to implement the "OVMF SDT Header probe suppressor"
> -             * see docs/specs/vmgenid.txt for more details
> +             * see docs/specs/vmgenid.rst for more details
>                */
>               guid_offset = le32_to_cpu(vgia_val) + VMGENID_GUID_OFFSET;
>               g_free(table_aml);

