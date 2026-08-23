Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBC1C5DF97
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 09:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy4Kv-0007N6-U4; Sun, 23 Aug 2026 05:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wy4Ks-0007MQ-2H
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 05:17:50 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wy4Kp-0000bn-QU
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 05:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787476668; x=1819012668;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=3plaIBwoXwGEz5vqEHuq92dc+8utBVt5RFi57XVnMDg=;
 b=T3D7EVJMc6VmpgLwLhaAr4d8QcSX5GOA4FWky+7eSwGLzT5lYElhZCcd
 TvYqYGdqkEvZM2inUZnHXI/qdjjCInXswLZozKV74KQ11T5LumSVnCRTZ
 BPrAgiJWz4OLjWK0Kf6Ea1IUGdBqITFKWfELnjWhMw2/L1fgoAgkS2Lmj
 ZTO3li7Xo0pptKRonQs35lplt3Wj/NGy5TUm4LUphjs0jomsx0Vd27H4Q
 7Ecqz1dxOjzaunr3JHCvKZh2fdHRoJaLsQ3tKf8ZTmx5UNLV2jlgqK9Hk
 q59KBGJfG9iQLLl+mVpfH1CMPbxV1DeXAr5PK7D3yjxsvpivxr0s7MYr2 Q==;
X-CSE-ConnectionGUID: f5RZh6pdTUmlZ3Fs7aZF2Q==
X-CSE-MsgGUID: d8BVVHRhT3iOMPBoSY6gwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="113492463"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; d="scan'208";a="113492463"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2026 02:17:43 -0700
X-CSE-ConnectionGUID: rEEgqJCdRdqRUusIB2+KlQ==
X-CSE-MsgGUID: ZbkYFtboRVulDUyu/tlRuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; d="scan'208";a="262472054"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by fmviesa006.fm.intel.com with ESMTP; 23 Aug 2026 02:17:41 -0700
Date: Sun, 23 Aug 2026 17:17:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Yanjing Zhou <zhouyanjing@hygon.cn>
Subject: Re: [PATCH v2 7/9] hw/i386: Reserve AMD IOMMU HT GPA range for Hygon
Message-ID: <aoq6tHPU70oKHCub@intel.com>
References: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
 <20260810082956.1768042-8-zhang_wei@open-hieco.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810082956.1768042-8-zhang_wei@open-hieco.net>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 10, 2026 at 04:29:54PM +0800, Tina Zhang wrote:
> Date: Mon, 10 Aug 2026 16:29:54 +0800
> From: Tina Zhang <zhang_wei@open-hieco.net>
> Subject: [PATCH v2 7/9] hw/i386: Reserve AMD IOMMU HT GPA range for Hygon
> X-Mailer: git-send-email 2.43.7
> 
> pc_memory_init() avoids the AMD IOMMU HyperTransport range below 1 TiB
> only for AMD vCPUs.  Dhyana therefore allows RAM, hotplug address space,
> or 64-bit PCI MMIO to overlap 0xfd00000000-0xffffffffff.
> 
> Linux supports Dhyana platforms in the AMD IOMMU driver.  The driver
> reports this range as reserved unless the IOMMU advertises
> FEATURE_HT_RANGE_IGNORE.  A VFIO device cannot DMA to guest addresses
> that QEMU places in the reserved range: VFIO_DMA_MAP may fail with
> -EINVAL, or the IOMMU may report an INVALID_DEVICE_REQUEST fault.
> 
> Apply the AMD IOMMU HT GPA layout to Hygon vCPUs.  When the possible
> address space reaches the reserved range, move RAM above 4 GiB to 1 TiB;
> also expose the range as reserved in E820 when the vCPU can address it.
> 
> Changing the GPA layout affects migration, so enable the Hygon behavior
> through x-hygon-vendor-abi-fixes.  pc-11.0 and older machine types retain
> their previous Hygon layout.  The existing enforce_amd_1tb_hole setting
> continues to preserve the AMD layout of pc/q35 machine types through 7.0.
> 
> Add functional tests for Dhyana with the current q35 machine type and
> with pc-q35-11.0 compatibility.
> 
> Signed-off-by: Yanjing Zhou <zhouyanjing@hygon.cn>
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
>  hw/i386/pc.c                                  | 18 ++++++---
>  .../functional/x86_64/test_mem_addr_space.py  | 37 +++++++++++++++++++
>  2 files changed, 50 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 2b4e322b2f..04aef6c267 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -738,6 +738,12 @@ static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_size)
>  #define AMD_ABOVE_1TB_START  (AMD_HT_END + 1)
>  #define AMD_HT_SIZE          (AMD_ABOVE_1TB_START - AMD_HT_START)
>  
> +static bool x86_cpu_has_amd_iommu_ht_gpa_hole(const X86CPU *cpu)
> +{
> +    return IS_AMD_CPU(&cpu->env) ||
> +           (IS_HYGON_CPU(&cpu->env) && cpu->hygon_vendor_abi_fixes);
> +}
> +
>  void pc_memory_init(PCMachineState *pcms,
>                      MemoryRegion *system_memory,
>                      MemoryRegion *rom_memory,
> @@ -762,12 +768,14 @@ void pc_memory_init(PCMachineState *pcms,
>      linux_boot = (machine->kernel_filename != NULL);
>  
>      /*
> -     * The HyperTransport range close to the 1T boundary is unique to AMD
> -     * hosts with IOMMUs enabled. Restrict the ram-above-4g relocation
> -     * to above 1T to AMD vCPUs only. @enforce_amd_1tb_hole is only false in
> -     * older machine types (<= 7.0) for compatibility purposes.
> +     * The HyperTransport range close to the 1T boundary is reserved by the
> +     * AMD IOMMU GPA layout.  Apply the ram-above-4g relocation only to vCPUs
> +     * that use that layout. @enforce_amd_1tb_hole preserves older AMD
> +     * machine types (<= 7.0), and x-hygon-vendor-abi-fixes preserves older
> +     * Hygon machine types (<= 11.0).
                               ^^^^^^^

nit: <= 11.1.

>       */

And x-hygon-vendor-abi-fixes is not here, or maybe we can palce all checks
in a single helper...

> -    if (IS_AMD_CPU(&cpu->env) && pcmc->enforce_amd_1tb_hole) {
> +    if (x86_cpu_has_amd_iommu_ht_gpa_hole(cpu) &&
> +        pcmc->enforce_amd_1tb_hole) {

...for example:

/*
 * The HyperTransport range close to the 1T boundary is unique to AMD &
 * Hygon hosts with IOMMUs enabled. Restrict the ram-above-4g relocation
 * to above 1T to AMD & Hygon vCPUs only. @enforce_amd_1tb_hole is only false
 * in older machine types (<= 7.0) and @x-hygon-vendor-abi-fixes is false in
 * machine types (<= 11.1), for compatibility purposes.
 */
static inline bool x86_cpu_has_iommu_ht_gpa_hole(PCMachineState *pcms,
                                                 const X86CPU *cpu)
{
    if (!pcmc->enforce_amd_1tb_hole) {
        return false;
    }

    return IS_AMD_CPU(&cpu->env) ||
           (IS_HYGON_CPU(&cpu->env) && cpu->hygon_vendor_abi_fixes);
}

>          /* Bail out if max possible address does not cross HT range */
>          if (pc_max_used_gpa(pcms, pci_hole64_size) >= AMD_HT_START) {
>              x86ms->above_4g_mem_start = AMD_ABOVE_1TB_START;
> diff --git a/tests/functional/x86_64/test_mem_addr_space.py b/tests/functional/x86_64/test_mem_addr_space.py
> index 61b4a190b4..b80f9acd99 100755
> --- a/tests/functional/x86_64/test_mem_addr_space.py
> +++ b/tests/functional/x86_64/test_mem_addr_space.py
> @@ -208,6 +208,25 @@ def test_phybits_low_tcg_q35_71_amd(self):
>          self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code should be 1")
>          self.assertRegex(self.vm.get_log(), r'phys-bits too low')
>  
> +    def test_phybits_low_tcg_q35_hygon(self):

like q35-7.1 AMD case, I think it's better to record the version in test
name:

def test_phybits_low_tcg_q35_112_hygon(self):

> +        """
> +        Same as q35-7.1 AMD case except that here we check that Dhyana
> +        follows the same AMD IOMMU HT reserved GPA range on new machine
> +        types.
> +        """
> +        self.ensure_64bit_binary()
> +        self.set_machine('q35')

For compatibility checks, it's better to explicitly specify the version:

self.set_machine('pc-q35-11.2')

> +        self.vm.add_args('-S', '-cpu', 'Dhyana,phys-bits=40',
> +                         '-m', '512,slots=1,maxmem=976G',
> +                         '-display', 'none',
> +                         '-object', 'memory-backend-ram,id=mem1,size=1G',
> +                         '-device', 'pc-dimm,id=vm0,memdev=mem1')
> +        self.vm.set_qmp_monitor(enabled=False)
> +        self.vm.launch()
> +        self.vm.wait()
> +        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code should be 1")
> +        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
> +
>      def test_phybits_ok_tcg_q35_70_amd(self):
>          """
>          Same as q35-7.0 AMD case except that here we check that QEMU can
> @@ -225,6 +244,24 @@ def test_phybits_ok_tcg_q35_70_amd(self):
>          self.vm.shutdown()
>          self.assertNotRegex(self.vm.get_log(), r'phys-bits too low')
>  
> +    def test_phybits_ok_tcg_q35_110_hygon(self):

test_phybits_ok_tcg_q35_111_hygon?

> +        """
> +        Same as q35-7.1 Dhyana case except that here we check that the
> +        q35-11.0 compatibility setting keeps the old memory layout.

q35-11.1.

> +        """
> +        self.ensure_64bit_binary()
> +        self.set_machine('pc-q35-11.0')

self.set_machine('pc-q35-11.1')?

Thanks,
Zhao


