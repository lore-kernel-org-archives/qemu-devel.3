Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E8AF3092A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy5gi-0000Kx-VJ; Thu, 05 Mar 2026 05:12:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu@demindiro.com>)
 id 1vy5ga-0000KX-FJ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:12:05 -0500
Received: from mail.salt-inc.org ([104.244.79.104] helo=vm0.salt-inc.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu@demindiro.com>)
 id 1vy5gS-00085W-T7
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:12:03 -0500
Received: from [192.168.2.172] (209.60-130-109.adsl-dyn.isp.belgacom.be
 [109.130.60.209])
 by vm0.salt-inc.org (Postfix) with ESMTPSA id 64549FF074;
 Thu,  5 Mar 2026 11:10:45 +0100 (CET)
Message-ID: <80ea964c-a33d-42ab-b5bc-ae63f6124a08@demindiro.com>
Date: Thu, 5 Mar 2026 11:10:44 +0100
MIME-Version: 1.0
User-Agent: Icedove Daily
Subject: Re: [PATCH 2/2] hw/i386/amd_iommu.c: fix incorrect page_size for
 hugepages
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Vasant Hegde <vasant.hegde@amd.com>
References: <20260225145831.28275-1-qemu@demindiro.com>
 <20260225145831.28275-3-qemu@demindiro.com>
 <863c6284-812c-495e-a452-a4dec3ed7115@amd.com>
Content-Language: en-US
From: David Hoppenbrouwers <qemu@demindiro.com>
In-Reply-To: <863c6284-812c-495e-a452-a4dec3ed7115@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=104.244.79.104; envelope-from=qemu@demindiro.com;
 helo=vm0.salt-inc.org
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/2/26 6:34 AM, Sairaj Kodilkar wrote:
> 
> 
> On 2/25/2026 8:28 PM, David Hoppenbrouwers wrote:
>> [You don't often get email from qemu@demindiro.com. Learn why this is 
>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> fetch_pte() incorrectly calculated the page_size for the next level 
>> before
>> checking whether the entry at the current level is a leaf.
>>
>> The incorrect behavior can be observed with a nested Linux guest under
>> specific conditions (using Alpine with linux-stable kernel):
>>
>> 1. Define the first guest as such:
>>
>>      /path/to/qemu-system-x86_64 \
>>          -M q35 \
>>          -enable-kvm \
>>          -cpu host \
>>          -m 8G \
>>          -device amd-iommu,dma-remap=on \
>>          -device virtio-blk,drive=boot,bootindex=1 \
>>          -device nvme,drive=vfio,bootindex=2,serial=nvme-vfio-0 \
>>          -device virtio-net-pci,netdev=net \
>>          -netdev user,id=net,hostfwd=tcp::2223-:22 \
>>          -serial unix:/tmp/genesys.unix \
>>          -drive if=none,id=boot,file=alpine-vm.qcow2,format=qcow2 \
>>          -drive if=none,id=vfio,file=vfio.qcow2,format=qcow2 \
>>          -display none \
>>          -monitor stdio \
>>          -trace 'pci*' \
>>          -trace 'amdvi_fetch_pte*'
>>
>>     Add -cdrom path-to-alpine.iso for the first run to install Alpine.
>>
>> 2. In /etc/update-extlinux.conf, add the following to 
>> default_kernel_opts:
>>
>>      iommu.strict=1 amd_iommu_dump=1 amd_iommu=v2_pgsizes_only,pgtbl_v2
>>
>>     v2_pgsizes_only is important to coerce Linux into using NextLevel=0
>>     for 2M pages.
>>
>> 3. Add /etc/modprobe.d/vfio.conf with the following content:
>>
>>      /etc/modprobe.d/vfio.conf
>>      options vfio-pci ids=1234:11e8,1b36:0010
>>      options vfio_iommu_type1 allow_unsafe_interrupts=1
>>      softdep igb pre: vfio-pci
>>
>> 4. In /etc/mkinitfs/mkinitfs.conf, add vfio and hugetlbfs to features.
>>
>> 5. In /etc/sysctl.conf, add vm.nr_hugepages=512
>>
>> 6. mkdir /hugepages
>>
>> 7. In /etc/fstab, add hugetlbfs:
>>
>>      hugetlbfs  /hugepages  hugetlbfs  defaults  0 0
>>
>> 8. Reboot
>>
>> 9. Define the second, nested guest as such:
>>
>>      qemu-system-x86_64 \
>>          -M q35 \
>>          -enable-kvm \
>>          -cpu host \
>>          -m 512M \
>>          -mem-prealloc \
>>          -mem-path /hugepages/qemu \
>>          -display none \
>>          -serial stdio \
>>          -device vfio-pci,host=0000:00:04.0 \
>>          -cdrom path-to-alpine.iso
>>
>>      scp the original ISO into the guest.
>>      Doublecheck -device with lspci -nn.
>>
>> If you launch the second guest inside the first guest without this patch,
>> you will observe that booting gets stuck / takes a very long time:
>>
>>      ISOLINUX 6.04 6.04-pre1  Copyright (C) 1994-2015 H. Peter Anvin 
>> et al
>>      boot:
>>
>> The following trace can be observed:
>>
>>      amdvi_fetch_pte_translate 0x0000000002867000
>>      amdvi_fetch_pte_root level=3 pte=6000000103629603
>>      amdvi_fetch_pte_walk level=3 pte=6000000103629603 NextLevel=3 
>> page_size=0x40000000
>>      amdvi_fetch_pte_walk level=2 pte=600000010362c401 NextLevel=2 
>> page_size=0x200000
>>      amdvi_fetch_pte_walk level=1 pte=700000016b400001 NextLevel=0 
>> page_size=0x1000
>>      amdvi_fetch_pte_found level=0 pte=700000016b400001 NextLevel=0 
>> page_size=0x1000
>>      amdvi_fetch_pte_translate 0x0000000002e0e000
>>      amdvi_fetch_pte_root level=3 pte=6000000103629603
>>      amdvi_fetch_pte_walk level=3 pte=6000000103629603 NextLevel=3 
>> page_size=0x40000000
>>      amdvi_fetch_pte_walk level=2 pte=600000010362c401 NextLevel=2 
>> page_size=0x200000
>>      amdvi_fetch_pte_walk level=1 pte=700000016b200001 NextLevel=0 
>> page_size=0x1000
>>      amdvi_fetch_pte_found level=0 pte=700000016b200001 NextLevel=0 
>> page_size=0x1000
>>
>> Note that NextLevel skips from 2 to 0, indicating a hugepage. However, it
>> incorrectly determined the page_size to be 0x1000 when it should be 
>> 0x200000.
>> It doesn't seem the "host" (first guest) observes this mismatch, but 
>> the second
>> guest is clearly affected.
>>
>> I have observed it booting eventually, but I don't remember how long 
>> it took.
>> If/when it does, run setup-alpine. When it asks about which disk to 
>> use it
>> will be missing the NVMe drive.
>>
>> If you apply this patch for the first guest then the second guest will 
>> boot
>> much faster and see the NVMe drive. The trace will be longer and look 
>> like
>> this:
>>
>>      ...
>>      amdvi_fetch_pte_translate 0x000000001ffd8000
>>      amdvi_fetch_pte_root level=3 pte=600000010373e603
>>      amdvi_fetch_pte_walk level=3 pte=600000010373e603 NextLevel=3 
>> page_size=0x8000000000
>>      amdvi_fetch_pte_walk level=2 pte=600000010370b401 NextLevel=2 
>> page_size=0x40000000
>>      amdvi_fetch_pte_walk level=1 pte=700000014b800001 NextLevel=0 
>> page_size=0x200000
>>      amdvi_fetch_pte_found level=0 pte=700000014b800001 NextLevel=0 
>> page_size=0x200000
>>      amdvi_fetch_pte_translate 0x0000000000007c00
>>      amdvi_fetch_pte_root level=3 pte=600000010373e603
>>      amdvi_fetch_pte_walk level=3 pte=600000010373e603 NextLevel=3 
>> page_size=0x8000000000
>>      amdvi_fetch_pte_walk level=2 pte=600000010370b401 NextLevel=2 
>> page_size=0x40000000
>>      amdvi_fetch_pte_walk level=1 pte=600000010366c201 NextLevel=1 
>> page_size=0x200000
>>      amdvi_fetch_pte_found level=0 pte=700000016b807001 NextLevel=0 
>> page_size=0x1000
>>      amdvi_fetch_pte_translate 0x000000001ffdc000
>>      amdvi_fetch_pte_root level=3 pte=600000010373e603
>>      amdvi_fetch_pte_walk level=3 pte=600000010373e603 NextLevel=3 
>> page_size=0x8000000000
>>      amdvi_fetch_pte_walk level=2 pte=600000010370b401 NextLevel=2 
>> page_size=0x40000000
>>      amdvi_fetch_pte_walk level=1 pte=700000014b800001 NextLevel=0 
>> page_size=0x200000
>>      amdvi_fetch_pte_found level=0 pte=700000014b800001 NextLevel=0 
>> page_size=0x200000
>>      ...
> 
> Hi David,
> 
> Thanks for the fix, here are few nits,
> 
> Please move the description and reproduction steps of the bug to the cover
> letter and include only necessary information about the bug and what patch
> is doing to resolve it. Also keep the subsystem name as "amd_iommu" in the
> commit message.
> 
> Please see [1] for more information about commit message
> [1] https://www.qemu.org/docs/master/devel/submitting-a- 
> patch.html#write-a-meaningful-commit-message
> 
>>
>> Signed-off-by: David Hoppenbrouwers <qemu@demindiro.com>
>> ---
>>   hw/i386/amd_iommu.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 29999fd776..2e83f8f4de 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -684,6 +684,13 @@ static uint64_t fetch_pte(AMDVIAddressSpace *as, 
>> hwaddr address, uint64_t dte,
>>       level = mode = get_pte_translation_mode(dte);
>>       assert(mode > 0 && mode < 7);
>>
>> +    /*
>> +     * TODO what is the actual behavior if NextLevel=0 or 7 in the root?
>> +     * For now, set the page_size for the root to be consistent with 
>> earlier
>> +     * QEMU versions,
>> +     */
>> +    *page_size = PTE_LEVEL_PAGE_SIZE(level);
>> +
>>       /*
>>        * If IOVA is larger than the max supported by the current 
>> pgtable level,
>>        * there is nothing to do.
>> @@ -700,9 +707,6 @@ static uint64_t fetch_pte(AMDVIAddressSpace *as, 
>> hwaddr address, uint64_t dte,
>>
>>           level -= 1;
>>
>> -        /* Update the page_size */
>> -        *page_size = PTE_LEVEL_PAGE_SIZE(level);
>> -
>>           /* Permission bits are ANDed at every level, including the 
>> DTE */
>>           perms &= amdvi_get_perms(*pte);
>>           if (perms == IOMMU_NONE) {
>> @@ -720,6 +724,9 @@ static uint64_t fetch_pte(AMDVIAddressSpace *as, 
>> hwaddr address, uint64_t dte,
>>               break;
>>           }
>>
>> +        /* Update the page_size */
>> +        *page_size = PTE_LEVEL_PAGE_SIZE(level);
>> +
>>           /*
>>            * Index the pgtable using the IOVA bits corresponding to 
>> current level
>>            * and walk down to the lower level.
>> -- 
>> 2.52.0
> 
> Looking at the fetch_pte code, it was harder to read as it treats DTE as 
> regular PTE
> and creates confusion about how levels are managed.
> 
> I propose following patch (tested with FIO) to resolve this bug...
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 789e09d6f2bc..4570a715c9c0 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -658,13 +658,16 @@ static uint64_t large_pte_page_size(uint64_t pte)
>    * -AMDVI_FR_PT_ENTRY_INV: A PTE could not be read from guest memory 
> during a
>    *      page table walk. This means that the DTE has valid data, but 
> one of the
>    *      lower level entries in the Page Table could not be read.
> + *
> + *  NOTE: fetch_pte assumes that the provided DTE is valid, i.e. caller 
> has
> + *  passed dte with bits 0 and 1 set
>    */
>   static uint64_t fetch_pte(AMDVIAddressSpace *as, hwaddr address, 
> uint64_t dte,
>                             uint64_t *pte, hwaddr *page_size)
>   {
>       IOMMUAccessFlags perms = amdvi_get_perms(dte);
> 
> -    uint8_t level, mode;
> +    uint8_t level, mode, next_level;
>       uint64_t pte_addr;
> 
>       *pte = dte;
> @@ -691,51 +694,47 @@ static uint64_t fetch_pte(AMDVIAddressSpace *as, 
> hwaddr address, uint64_t dte,
>           return -AMDVI_FR_PT_ROOT_INV;
>       }
> 
> -    do {
> -        level -= 1;
> -
> -        /* Update the page_size */
> -        *page_size = PTE_LEVEL_PAGE_SIZE(level);
> -
> -        /* Permission bits are ANDed at every level, including the DTE */
> -        perms &= amdvi_get_perms(*pte);
> -        if (perms == IOMMU_NONE) {
> -            return 0;
> -        }
> -
> -        /* Not Present */
> -        if (!IOMMU_PTE_PRESENT(*pte)) {
> -            return 0;
> -        }
> +    *page_size = PTE_LEVEL_PAGE_SIZE(level);
> 
> -        /* Large or Leaf PTE found */
> -        if (PTE_NEXT_LEVEL(*pte) == 7 || PTE_NEXT_LEVEL(*pte) == 0) {
> -            /* Leaf PTE found */
> -            break;
> -        }
> -
> -        /*
> -         * Index the pgtable using the IOVA bits corresponding to 
> current level
> -         * and walk down to the lower level.
> -         */
> +    do {
>           pte_addr = NEXT_PTE_ADDR(*pte, level, address);
>           *pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
> 
> -        if (*pte == (uint64_t)-1) {
> +        if (*pte == (uint64_t) -1) {
>               /*
>                * A returned PTE of -1 indicates a failure to read the 
> page table
> -             * entry from guest memory.
> +             * entry from guest memory
>                */
>               if (level == mode - 1) {
>                   /* Failure to retrieve the Page Table from Root 
> Pointer */
>                   *page_size = 0;
>                   return -AMDVI_FR_PT_ROOT_INV;
>               } else {
> -                /* Failure to read PTE. Page walk skips a page_size 
> chunk */
>                   return -AMDVI_FR_PT_ENTRY_INV;
>               }
>           }
> -    } while (level > 0);
> +
> +        next_level = PTE_NEXT_LEVEL(*pte);
> +        *page_size = PTE_LEVEL_PAGE_SIZE(level - 1);
> +
> +        /* Permission bits are ANDed at every level, including the DTE */
> +        perms &= amdvi_get_perms(*pte);
> +
> +        if (!IOMMU_PTE_PRESENT(*pte) || perms == IOMMU_NONE) {
> +            return 0;
> +        }
> +
> +        /* Large or Leaf PTE found */
> +        if (next_level == 0 || next_level == 7) {
> +            break;
> +        }
> +
> +        /* AMD IOMMU supports level skip hence assign next_level to level
> +         * instead of decrementing it
> +         */
> +        level = next_level;
> +    } while(level > 0);
> +
> 
>       assert(PTE_NEXT_LEVEL(*pte) == 0 || PTE_NEXT_LEVEL(*pte) == 7 ||
>              level == 0);
> @@ -745,7 +744,7 @@ static uint64_t fetch_pte(AMDVIAddressSpace *as, 
> hwaddr address, uint64_t dte,
>        * the range starts in the middle of a contiguous page, the 
> returned PTE
>        * must be the first PTE of the series.
>        */
> -    if (PTE_NEXT_LEVEL(*pte) == 7) {
> +    if (next_level == 7) {
>           /* Update page_size with the large PTE page size */
>           *page_size = large_pte_page_size(*pte);
>       }
> @@ -840,6 +839,12 @@ static void 
> amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as,
>       uint64_t pte;
>       int ret;
> 
> +    /* Return if DTE is not valid */
> +    if (!(dte[0] & AMDVI_DEV_TRANSLATION_VALID) ||
> +        !(dte[0] & AMDVI_DEV_VALID)) {
> +        return;
> +    }
> +
>       while (iova < end) {
> 
>           ret = fetch_pte(as, iova, dte[0], &pte, &pagesize);
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index 302ccca5121f..721d69c97311 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -190,7 +190,7 @@
>   #define PT_LEVEL_SHIFT(level)           (12 + ((level) * 9))
> 
>   /* Return IOVA bit group used to index the Page Table at specific 
> level */
> -#define PT_LEVEL_INDEX(level, iova)     (((iova) >> 
> PT_LEVEL_SHIFT(level)) & \
> +#define PT_LEVEL_INDEX(level, iova)     (((iova) >> 
> PT_LEVEL_SHIFT(level - 1)) & \
>                                           GENMASK64(8, 0))
> 
>   /* Return the max address for a specified level i.e. max_oaddr */
> -- 
> 
> @David Could you please test above patch ?

It appears to work fine with both the Linux VM and my own kernel project.

> I have rearraged some part of code. Along with it I have added a 
> requirement that caller
> must validate DTE before calling fetch_pte. This requirement simplifies 
> the loop.
> 
> If @David and @Alejandro are okay with this change, I can prepare and 
> send official patch.

It is fine with me. I don't need to send a v2?

> Thanks
> Sairaj


