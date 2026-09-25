Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF9BC98306
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 06:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9zQb-0004Mn-1U; Fri, 25 Sep 2026 02:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1x9zQT-0004MS-F0; Fri, 25 Sep 2026 02:28:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1x9zQQ-0007OO-AQ; Fri, 25 Sep 2026 02:28:53 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P4aThl075561; Fri, 25 Sep 2026 06:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=EY8D1X
 zxkrY4drBHhu5g5nA+P0vnEpCUlsaoTNaJO48=; b=oX1keQ8+tF4oUXjaYvrEYF
 Yx1h3LMpJ8WxmEzYKJpIHUOlWOWAUe0Hk+mSBec8Uce68yu3Iqw6ULYQZG0G3X8r
 gIsVVRc9lb6NNlEfZEIHbOxB13TuHGqaUtHrmKoXGhkEplSHz6FGatYQBg9MXTAU
 ek/N66aBRM2EPPpey5fnePBXE59ogjoNhytnnP5SXhvjhvg3+jLNUW8KeXMcEVMk
 M1Rn7h8ZqWdNVTkioajNAliC/gyTpTcPRN4DIJeEBxaeUq2QmFlsgdhNDTLAQsxN
 FjellAGK9OVlECeexcJ5OytIfYEP+rSnT5G2j8COXPfQ98DuPWJlhvFsFNRuL8XA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2wn3m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 06:28:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P4lVv53296986; Fri, 25 Sep 2026 06:28:44 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qsc21-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 06:28:44 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68P6Sgp27209572
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Sep 2026 06:28:42 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C274558059;
 Fri, 25 Sep 2026 06:28:42 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD84658043;
 Fri, 25 Sep 2026 06:28:34 +0000 (GMT)
Received: from [9.43.103.81] (unknown [9.43.103.81])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 25 Sep 2026 06:28:34 +0000 (GMT)
Message-ID: <bfaef03d-8fe9-460e-b6c5-d9a3691c3073@linux.ibm.com>
Date: Fri, 25 Sep 2026 11:58:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/8] ppc/spapr: add baseline VOF disk boot support
To: Narayana Murty N <nnmlinux@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, aik@ozlabs.ru
Cc: pbonzini@redhat.com, th.huth@posteo.eu, sbhat@linux.ibm.com,
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, rathc@linux.ibm.com,
 balaton@eik.bme.hu, philmd@oss.qualcomm.com, npiggin@gmail.com,
 marcandre.lureau@redhat.com, fam@euphon.net, avnish@linux.ibm.com
References: <20260817102733.605346-1-uverma@linux.ibm.com>
 <20260817102733.605346-4-uverma@linux.ibm.com>
 <50158801-d888-4e75-890b-3c54c29bb484@linux.ibm.com>
Content-Language: en-US, en-ZM
From: Utkarsh Verma <uverma@linux.ibm.com>
In-Reply-To: <50158801-d888-4e75-890b-3c54c29bb484@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Lt0bGye25a22YiBTcdSprucitxQQH1dj
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab6149d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=eW0sz4pM0ASWS_Q1l_oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAyNCBTYWx0ZWRfXwBb3IeC3038P
 oMKQPuFkipmTHWaPBiM5NAQvtGc0mlByIyuFCVkozXYNcHSbU/glLSiK4x77n31RTXQQ8veLK1F
 VM2Z9az9T+FIKVnLlb+oIEaNM5UitCUnuGJspDtggs90a4Bn2xkAy5Lgbs4EJIdWATuXDH6Rnhe
 lrhKuNZCfgp/boyfCWEQP2oEIh7PWYO50AM4RrNH9EK71ozZQT6Wo/v4TYmZfA3wbxrwAZhGvyV
 L5dbdJJbkVPtp3EPJ+FkDzrUu5coS4z0zXo3MT5PAzTOc+LxtZMzF64MO83YsYBjw5mjqh3nDN8
 vkZ8i74ZLvlPhsWycaDQ6BcQSp2ed1wx60vH0KqhazhNo5z+deMV7SwU9I53zRxY2lWInN2KNHG
 h+qceCFZlCr3ARQ4TCGjawMu5/xzmZA6SH9JaP4o2AgNQexdmAkS9CW6ClmDXarRs8JQu4dhJEG
 XIheCwrKxmuu60e7y7Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAyNCBTYWx0ZWRfX8fLrLyky3ecu
 ea7ZqF5aUE2UCQ6KgsCPhQSWDO04sTT+vgD8ghjXsDWP8BccELNhKFV/L2UOrEt0fn8/Yk7dH9x
 yGlb2sWo6GDvRPn1S23uwgFL4tjCAY8=
X-Proofpoint-GUID: 25dK-mJAyu1-GF6bd69RxaskzoiQZED2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250024
Received-SPF: pass client-ip=148.163.156.1; envelope-from=uverma@linux.ibm.com;
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



On 9/17/26 11:03 PM, Narayana Murty N wrote:
> 
> 
> On 17/08/26 3:57 PM, uverma@linux.ibm.com wrote:
>> From: Utkarsh Verma <uverma@linux.ibm.com>
>>
>> Add initial support for disk boot via VOF.
>> Scan all the block devices, and for each device search for PReP 
>> partition,
>> load the ELF payload (GRUB), and set the '/chosen' node in FDT with 
>> boot kernel
>> and bootpath properties.
>>
>> AI-used-for: code
>> Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
>> ---
>>   hw/ppc/spapr_vof.c   | 142 ++++++++++++++++++++++++++++++++++++++++---
>>   hw/ppc/vof.c         |   3 +
>>   include/hw/ppc/vof.h |   2 +
>>   3 files changed, 139 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/ppc/spapr_vof.c b/hw/ppc/spapr_vof.c
>> index 46d78756e6..5bf9613005 100644
>> --- a/hw/ppc/spapr_vof.c
>> +++ b/hw/ppc/spapr_vof.c
>> @@ -10,8 +10,15 @@
>>   #include "hw/ppc/spapr_cpu_core.h"
>>   #include "hw/ppc/fdt.h"
>>   #include "hw/ppc/vof.h"
>> +#include "hw/ppc/spapr_vof.h"
>> +#include "hw/core/qdev.h"
>> +#include "hw/core/loader.h"
>>   #include "system/system.h"
>> +#include "system/block-backend.h"
>> +#include "system/block-backend-global-state.h"
>>   #include "qom/qom-qobject.h"
>> +#include "target/ppc/cpu.h"
>> +#include "elf.h"
>>   #include "trace.h"
>>   target_ulong spapr_h_vof_client(PowerPCCPU *cpu, SpaprMachineState 
>> *spapr,
>> @@ -32,10 +39,10 @@ void 
>> spapr_vof_client_dt_finalize(SpaprMachineState *spapr, void *fdt)
>>       vof_build_dt(fdt, spapr->vof);
>> -    if (spapr->vof->bootargs) {
>> -        int chosen;
>> +    int chosen;
>> +    _FDT(chosen = fdt_path_offset(fdt, "/chosen"));
>> -        _FDT(chosen = fdt_path_offset(fdt, "/chosen"));
>> +    if (spapr->vof->bootargs) {
>>           /*
>>            * If the client did not change "bootargs", 
>> spapr_dt_chosen() must have
>>            * stored machine->kernel_cmdline in it before getting here.
>> @@ -43,6 +50,22 @@ void spapr_vof_client_dt_finalize(SpaprMachineState 
>> *spapr, void *fdt)
>>           _FDT(fdt_setprop_string(fdt, chosen, "bootargs", spapr->vof- 
>> >bootargs));
>>       }
>> +    if (spapr->vof->disk_boot) {
>> +        /*
>> +         * If disk boot is detected change the "qemu,boot-kernel" to 
>> hold
>> +         * kernel_addr/kernel_size which contain the GRUB entry point 
>> and size
>> +         */
>> +        uint64_t kern[2];
>> +        kern[0] = cpu_to_be64(spapr->kernel_addr);
>> +        kern[1] = cpu_to_be64(spapr->kernel_size);
>> +        _FDT(fdt_setprop(fdt, chosen, "qemu,boot-kernel", &kern, 
>> sizeof(kern)));
>> +
>> +        if (spapr->vof->bootpath) {
>> +            _FDT(fdt_setprop_string(fdt, chosen, "bootpath",
>> +                                    spapr->vof->bootpath));
>> +        }
>> +    }
>> +
>>       /*
>>        * SLOF-less setup requires an open instance of stdout for early
>>        * kernel printk. By now all phandles are settled so we can open
>> @@ -54,11 +77,100 @@ void 
>> spapr_vof_client_dt_finalize(SpaprMachineState *spapr, void *fdt)
>>       }
>>   }
>> +static bool vof_elf_segment_cb(void *opaque,
>> +                                uint64_t paddr, uint64_t vaddr,
>> +                                uint64_t filesz, uint64_t memsz)
>> +{
>> +    Vof *vof = opaque;
>> +
>> +    if (memsz == 0) {
>> +        return true;
>> +    }
>> +
>> +    if (paddr != vaddr) {
>> +        error_report("spapr_vof_load_elf: segment paddr/vaddr mismatch "
>> +                     "(paddr=0x%" PRIx64 " vaddr=0x%" PRIx64 ")",
>> +                     paddr, vaddr);
>> +        return false;
>> +    }
>> +
>> +    if (vof_claim(vof, paddr, memsz, 0) == -1) {
>> +        error_report("spapr_vof_load_elf: vof_claim failed for "
>> +                     "paddr=0x%" PRIx64 " size=0x%" PRIx64, paddr, 
>> memsz);
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>> +static bool spapr_vof_try_prep_boot(SpaprMachineState *spapr, Vof *vof)
>> +{
>> +    BlockBackend *blk;
>> +    DeviceState *dev;
>> +    uint64_t partition_offset;
>> +    uint64_t partition_size;
>> +    uint8_t *prep_data;
>> +    uint64_t entry_point;
>> +    uint64_t load_size;
>> +
>> +    for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
>> +
>> +        if (!blk_is_inserted(blk)) {
>> +            continue;
>> +        }
>> +
>> +        partition_offset = 0;
>> +        partition_size   = 0;
>> +
>> +        if (!spapr_vof_find_prep_partition(blk, &partition_offset,
>> +                                           &partition_size)) {
>> +            continue;
>> +        }
>> +
>> +        prep_data = g_malloc(partition_size);
> partition_size is derived directly from MBR/GPT data.
> Before allocating this buffer, validate using overflow-safe arithmetic.
> 
Will add a sanity check in v2. Something like:
partition_size > 0 && \
partition_size <= 10 MB (PReP partition is usually 4–8 MB) && \
partition_size <= blk_getlength(blk)

>> +        if (blk_pread(blk, partition_offset, partition_size,
>> +                      prep_data, 0) < 0) {
>> +            g_free(prep_data);
>> +            continue;
>> +        }
>> +
>> +        uint64_t lowaddr = UINT64_MAX, highaddr = 0;
>> +        entry_point = 0;
>> +        ssize_t ret = load_elf_ram_sym_buf(prep_data, partition_size,
>> +                                           NULL, NULL, NULL,
>> +                                           &entry_point, &lowaddr, 
>> &highaddr,
>> +                                           NULL, ELFDATA2MSB,
>> +                                           PPC_ELF_MACHINE, 0, 0,
>> +                                           NULL, false, NULL,
>> +                                           vof_elf_segment_cb, vof);
>> +        if (ret <= 0) {
>> +            error_report("spapr_vof_try_prep_boot: %s", 
>> load_elf_strerror(ret));
>> +            g_free(prep_data);
>> +            continue;
>> +        }
>> +        load_size = highaddr - lowaddr;
>> +
>> +        g_free(prep_data);
>> +
>> +        spapr->kernel_addr = entry_point;
>> +        spapr->kernel_size = load_size;
>> +
>> +        vof->disk_boot = true;
>> +        dev = blk_get_attached_dev(blk);
>> +        if (dev) {
>> +            vof->bootpath = qdev_get_fw_dev_path(dev);
>> +        }
>> +        return true;
>> +    }
> In the above loop if partially PT_LOAD( blk 1, blk 2 succeeded but blk 3 
> failed)
> spapr_vof_try_prep_boot() then continues and tries the next 
> BlockBackend, but I don't see anything undoing the first two claims.
> 
> Could a malformed first boot disk therefore poison the VOF allocation 
> map and make a valid second disk fail to boot?
> 
> This probably needs either a validation-first/commit-second model or 
> explicit claim rollback.
> 
Will fix in v2. I will add vof_release() which will free the entries in 
the vof->claimed map added during a failed attempt.

> Thanks,
> Narayana Murty N
>> +    return false;
>> +}
>> +
>>   void spapr_vof_reset(SpaprMachineState *spapr, void *fdt, Error **errp)
>>   {
>>       target_ulong stack_ptr;
>>       Vof *vof = spapr->vof;
>>       PowerPCCPU *first_ppc_cpu = POWERPC_CPU(first_cpu);
>> +    MachineState *machine = MACHINE(spapr);
>>       vof_init(vof, spapr->rma_size, errp);
>> @@ -70,7 +182,7 @@ void spapr_vof_reset(SpaprMachineState *spapr, void 
>> *fdt, Error **errp)
>>       /* Stack grows downwards plus reserve space for the minimum 
>> stack frame */
>>       stack_ptr += VOF_STACK_SIZE - 0x20;
>> -    if (spapr->kernel_size &&
>> +    if (machine->kernel_filename && spapr->kernel_size &&
>>           vof_claim(vof, spapr->kernel_addr, spapr->kernel_size, 0) == 
>> -1) {
>>           error_setg(errp, "Memory for kernel is in use");
>>           return;
>> @@ -82,6 +194,14 @@ void spapr_vof_reset(SpaprMachineState *spapr, 
>> void *fdt, Error **errp)
>>           return;
>>       }
>> +    /*
>> +     * Disk boot: load GRUB from the PReP boot partition on the block 
>> device, if
>> +     * no kernel/initrd are provided
>> +     */
>> +    if (!machine->kernel_filename) {
>> +        spapr_vof_try_prep_boot(spapr, vof);
>> +    }
>> +
>>       spapr_vof_client_dt_finalize(spapr, fdt);
>>       spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT,
>> @@ -91,10 +211,16 @@ void spapr_vof_reset(SpaprMachineState *spapr, 
>> void *fdt, Error **errp)
>>       /*
>>        * At this point the expected allocation map is:
>>        *
>> -     * 0..c38 - the initial firmware
>> -     * 8000..10000 - stack
>> -     * 400000.. - kernel
>> -     * 3ea0000.. - initramdisk
>> +     * Kernel + initrd boot:
>> +     *   0..c38      - the initial firmware
>> +     *   8000..10000 - stack
>> +     *   400000..    - kernel
>> +     *   3ea0000..   - initramdisk
>> +     *
>> +     * Disk (GRUB) boot:
>> +     *   0..c38      - the initial firmware
>> +     *   8000..10000 - stack
>> +     *   400000..    - GRUB (loaded from PReP partition)
>>        *
>>        * We skip writing FDT as nothing expects it; OF client 
>> interface is
>>        * going to be used for reading the device tree.
>> diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
>> index fa7b73159a..a78bb1f116 100644
>> --- a/hw/ppc/vof.c
>> +++ b/hw/ppc/vof.c
>> @@ -1041,6 +1041,9 @@ void vof_cleanup(Vof *vof)
>>       vof->of_instances = NULL;
>>       vof->of_instance_last = 0;
>>       vof->claimed_base = 0;
>> +    g_free(vof->bootpath);
>> +    vof->bootpath = NULL;
>> +    vof->disk_boot = false;
>>   }
>>   void vof_build_dt(void *fdt, Vof *vof)
>> diff --git a/include/hw/ppc/vof.h b/include/hw/ppc/vof.h
>> index 3a0fbffe54..e17779ee8a 100644
>> --- a/include/hw/ppc/vof.h
>> +++ b/include/hw/ppc/vof.h
>> @@ -18,6 +18,8 @@ typedef struct Vof {
>>       GHashTable *of_instances; /* ihandle -> SpaprOfInstance */
>>       uint32_t of_instance_last;
>>       char *bootargs;
>> +    char *bootpath;
>> +    bool disk_boot;
>>       long fw_size;
>>   } Vof;
> 
> 

Regards,
Utkarsh


