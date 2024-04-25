Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8600C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 07:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rztYH-000822-7W; Thu, 25 Apr 2024 03:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1rztYD-00081g-Db; Thu, 25 Apr 2024 03:29:50 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1rztYB-0006Ay-PG; Thu, 25 Apr 2024 03:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=Da3yxCWGzsnWNN6km+BcKJYVIH43tAdmKiFk55A1vrc=; b=eKRbj7ldRIKCcDi
 0cwKzubk4X8WO9Ygs0PGviGBDuafgdKDlM8E1dJB/AwqSHYNXNgORb5G5zM2z1FL1RQdM3/qcZi32
 A3dCSpLSlOnWKd5lLN2/pOdpCFWqxJwbbPc40X2gr45k2ce95tEPc4vqpUnkPeB+TMfKGqyU0sea2
 PM=;
Date: Thu, 25 Apr 2024 09:30:57 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 David Hildenbrand <david@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 09/24] physmem: Restrict TCG CPU IOTLB code to TCG accel
Message-ID: <2efaq47itirahcuk3yxpccdyuuuvgbdugudzwl2qenhezso456@566dj53tasun>
References: <20240418192525.97451-1-philmd@linaro.org>
 <20240418192525.97451-10-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240418192525.97451-10-philmd@linaro.org>
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 18/04/24, Philippe Mathieu-Daudé wrote:
> Restrict iotlb_to_section(), address_space_translate_for_iotlb()
> and memory_region_section_get_iotlb() to TCG. Declare them in
> "exec/cputlb.h". Declare iotlb_to_section() using the
> MemoryRegionSection typedef.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/exec/cputlb.h   | 25 +++++++++++++++++++++++--
>  include/exec/exec-all.h | 21 ---------------------
>  system/physmem.c        |  6 ++++++
>  3 files changed, 29 insertions(+), 23 deletions(-)
> 
> diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
> index 173eb98b9a..3594f904b4 100644
> --- a/include/exec/cputlb.h
> +++ b/include/exec/cputlb.h
> @@ -21,6 +21,8 @@
>  #define CPUTLB_H
>  
>  #include "exec/abi_ptr.h"
> +#include "exec/hwaddr.h"
> +#include "exec/memattrs.h"
>  #include "exec/cpu-common.h"
>  #include "exec/mmu-access-type.h"
>  
> @@ -43,10 +45,29 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
>                          MMUAccessType access_type, int mmu_idx);
>  
>  #if !defined(CONFIG_USER_ONLY)
> -/* cputlb.c */
> +
>  void tlb_protect_code(ram_addr_t ram_addr);
>  void tlb_unprotect_code(ram_addr_t ram_addr);
> -#endif
> +
> +/**
> + * iotlb_to_section:
> + * @cpu: CPU performing the access
> + * @index: TCG CPU IOTLB entry
> + *
> + * Given a TCG CPU IOTLB entry, return the MemoryRegionSection that
> + * it refers to. @index will have been initially created and returned
> + * by memory_region_section_get_iotlb().
> + */
> +MemoryRegionSection *iotlb_to_section(CPUState *cpu,
> +                                      hwaddr index, MemTxAttrs attrs);
> +MemoryRegionSection *
> +address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr addr,
> +                                  hwaddr *xlat, hwaddr *plen,
> +                                  MemTxAttrs attrs, int *prot);
> +hwaddr memory_region_section_get_iotlb(CPUState *cpu,
> +                                       MemoryRegionSection *section);
> +
> +#endif /* CONFIG_USER_ONLY */

!CONFIG_USER_ONLY

>  
>  #endif /* CONFIG_TCG */
>  
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 5cddfea01b..e4cff08db4 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -536,21 +536,6 @@ extern __thread uintptr_t tci_tb_ptr;
>     smaller than 4 bytes, so we don't worry about special-casing this.  */
>  #define GETPC_ADJ   2
>  
> -#if !defined(CONFIG_USER_ONLY)
> -
> -/**
> - * iotlb_to_section:
> - * @cpu: CPU performing the access
> - * @index: TCG CPU IOTLB entry
> - *
> - * Given a TCG CPU IOTLB entry, return the MemoryRegionSection that
> - * it refers to. @index will have been initially created and returned
> - * by memory_region_section_get_iotlb().
> - */
> -struct MemoryRegionSection *iotlb_to_section(CPUState *cpu,
> -                                             hwaddr index, MemTxAttrs attrs);
> -#endif
> -
>  /**
>   * get_page_addr_code_hostp()
>   * @env: CPUArchState
> @@ -659,12 +644,6 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
>  void tlb_set_dirty(CPUState *cpu, vaddr addr);
>  void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
>  
> -MemoryRegionSection *
> -address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr addr,
> -                                  hwaddr *xlat, hwaddr *plen,
> -                                  MemTxAttrs attrs, int *prot);
> -hwaddr memory_region_section_get_iotlb(CPUState *cpu,
> -                                       MemoryRegionSection *section);
>  #endif
>  
>  #endif
> diff --git a/system/physmem.c b/system/physmem.c
> index cf6334f3a3..38d3ede9f9 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -31,6 +31,7 @@
>  #endif /* CONFIG_TCG */
>  
>  #include "exec/exec-all.h"
> +#include "exec/cputlb.h"
>  #include "exec/target_page.h"
>  #include "hw/qdev-core.h"
>  #include "hw/qdev-properties.h"
> @@ -585,6 +586,7 @@ typedef struct TCGIOMMUNotifier {
>      bool active;
>  } TCGIOMMUNotifier;
>  
> +#ifdef CONFIG_TCG
>  static void tcg_iommu_unmap_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>  {
>      TCGIOMMUNotifier *notifier = container_of(n, TCGIOMMUNotifier, n);
> @@ -648,6 +650,7 @@ static void tcg_register_iommu_notifier(CPUState *cpu,
>          notifier->active = true;
>      }
>  }
> +#endif
>  
>  void tcg_iommu_free_notifier_list(CPUState *cpu)
>  {
> @@ -668,6 +671,7 @@ void tcg_iommu_init_notifier_list(CPUState *cpu)
>      cpu->iommu_notifiers = g_array_new(false, true, sizeof(TCGIOMMUNotifier *));
>  }
>  
> +#ifdef CONFIG_TCG
>  /* Called from RCU critical section */
>  MemoryRegionSection *
>  address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr orig_addr,
> @@ -761,6 +765,8 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
>      return section - d->map.sections;
>  }
>  
> +#endif /* CONFIG_TCG */

I might be missing some context here but are the other iotlb functions
#ifdef CONFIG_TCG'd by some other patch?

Otherwise,
Reviewed-by: Anton Johansson <anjo@rev.ng>

