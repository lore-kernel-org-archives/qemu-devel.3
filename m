Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281D1C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 15:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp92w-000400-7g; Tue, 26 Mar 2024 11:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rp92T-0003i1-2t
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:48:39 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rp92P-0001oJ-Np
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711468114; x=1743004114;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=PSDsdy9cCNNUizkkvJKo+ZRNsRTL6uHLRjjn/ZAdyaA=;
 b=lW4mx5Cw10XVInXvMShL6BumHfrb/Vz/Qv9GITdFjX/rOy9jP1SYGBB2
 EJkb9YgIVBruN6FVRUw0vVpd/XOu8PlmPOUgqzs/W3KmBoSGVeSj94vjp
 kJq3PEmV3IHUicSgLCT1Ypu7nh2HLYKtrPGiBzMzKsjaCBJUKN+P6oSKq
 1j9wx6VEnkvI2Q33FwHbOLU1CA2YruEjnYpjp9Hypn+nY0bXkYFVKsiHL
 iEBy5oMTsp9meRQ+9X3O5ev6BgukofwpcdQh911hxYa7DRYuG0eZ14j6y
 wxRioIy9UCi0gqmcjVtUJAS7h7BHv6P5btEOm/2U5O1v+HC/rczbSs+PF w==;
X-CSE-ConnectionGUID: JtqEm3c0RaWiUJEsrkmREg==
X-CSE-MsgGUID: y7h56RDPTxeSD2KfuCP5cg==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6466230"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6466230"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2024 08:48:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; d="scan'208";a="20717018"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.224.7])
 ([10.124.224.7])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2024 08:48:29 -0700
Message-ID: <62c24e8e-4b6a-4710-a4b8-a26197d0143e@intel.com>
Date: Tue, 26 Mar 2024 23:48:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/26] KVM: track whether guest state is encrypted
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: michael.roth@amd.com, david@redhat.com
References: <20240322181116.1228416-1-pbonzini@redhat.com>
 <20240322181116.1228416-13-pbonzini@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240322181116.1228416-13-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/23/2024 2:11 AM, Paolo Bonzini wrote:
> So far, KVM has allowed KVM_GET/SET_* ioctls to execute even if the
> guest state is encrypted, in which case they do nothing.  For the new
> API using VM types, instead, the ioctls will fail which is a safer and
> more robust approach.
> 
> The new API will be the only one available for SEV-SNP and TDX, but it
> is also usable for SEV and SEV-ES.  In preparation for that, require
> architecture-specific KVM code to communicate the point at which guest
> state is protected (which must be after kvm_cpu_synchronize_post_init(),
> though that might change in the future in order to suppor migration).
>  From that point, skip reading registers so that cpu->vcpu_dirty is
> never true: if it ever becomes true, kvm_arch_put_registers() will
> fail miserably.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/sysemu/kvm.h     |  2 ++
>   include/sysemu/kvm_int.h |  1 +
>   accel/kvm/kvm-all.c      | 14 ++++++++++++--
>   target/i386/sev.c        |  1 +
>   4 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index fad9a7e8ff3..302e8f6f1e5 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -539,6 +539,8 @@ bool kvm_dirty_ring_enabled(void);
>   
>   uint32_t kvm_dirty_ring_size(void);
>   
> +void kvm_mark_guest_state_protected(void);
> +
>   /**
>    * kvm_hwpoisoned_mem - indicate if there is any hwpoisoned page
>    * reported for the VM.
> diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
> index 882e37e12c5..3496be7997a 100644
> --- a/include/sysemu/kvm_int.h
> +++ b/include/sysemu/kvm_int.h
> @@ -87,6 +87,7 @@ struct KVMState
>       bool kernel_irqchip_required;
>       OnOffAuto kernel_irqchip_split;
>       bool sync_mmu;
> +    bool guest_state_protected;
>       uint64_t manual_dirty_log_protect;
>       /* The man page (and posix) say ioctl numbers are signed int, but
>        * they're not.  Linux, glibc and *BSD all treat ioctl numbers as
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index a8cecd040eb..05fa3533c66 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2698,7 +2698,7 @@ bool kvm_cpu_check_are_resettable(void)
>   
>   static void do_kvm_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
>   {
> -    if (!cpu->vcpu_dirty) {
> +    if (!cpu->vcpu_dirty && !kvm_state->guest_state_protected) {
>           int ret = kvm_arch_get_registers(cpu);
>           if (ret) {
>               error_report("Failed to get registers: %s", strerror(-ret));
> @@ -2712,7 +2712,7 @@ static void do_kvm_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
>   
>   void kvm_cpu_synchronize_state(CPUState *cpu)
>   {
> -    if (!cpu->vcpu_dirty) {
> +    if (!cpu->vcpu_dirty && !kvm_state->guest_state_protected) {
>           run_on_cpu(cpu, do_kvm_cpu_synchronize_state, RUN_ON_CPU_NULL);
>       }
>   }
> @@ -2747,6 +2747,11 @@ static void do_kvm_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)
>   
>   void kvm_cpu_synchronize_post_init(CPUState *cpu)
>   {
> +    /*
> +     * This runs before the machine_init_done notifiers, and is the last
> +     * opportunity to synchronize the state of confidential guests.
> +     */ > +    assert(!kvm_state->guest_state_protected);

So, this requires confidential guests to call 
kvm_mark_guest_state_protected() in its machine_init_done notifier callback?

But for TDX, the guest_state is protected at the beginning, not some 
time later when machine_init_done.

>       run_on_cpu(cpu, do_kvm_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
>   }
>   
> @@ -4094,3 +4099,8 @@ void query_stats_schemas_cb(StatsSchemaList **result, Error **errp)
>           query_stats_schema_vcpu(first_cpu, &stats_args);
>       }
>   }
> +
> +void kvm_mark_guest_state_protected(void)
> +{
> +    kvm_state->guest_state_protected = true;
> +}
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index b8f79d34d19..c49a8fd55eb 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -755,6 +755,7 @@ sev_launch_get_measure(Notifier *notifier, void *unused)
>           if (ret) {
>               exit(1);
>           }
> +        kvm_mark_guest_state_protected();
>       }
>   
>       /* query the measurement blob length */


