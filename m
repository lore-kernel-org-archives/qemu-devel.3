Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A34CC3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 01:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWQu7-0001or-NX; Tue, 23 Jul 2024 21:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1sWQu5-0001nt-DU
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 21:34:53 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1sWQu2-0001X4-GT
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 21:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=V3z+7mL5cGbAkRPBPA0cHgyvDq4mVo0ShDkQAVYd530=; b=QKZNNXd25X/louBT
 FXyDMNR052ki333+lq8CcZ3IN4qzUnDzsTywBkwTzGsONJuodJqKYU+tUZWjUtVFFqeqoPq92yk1D
 zlulM65vPk2vHBtlWfoY/OluhBozW+Wlp1ydpwn+Z7z+Jy+yIBXuW5BnZLghqP9wyyJWJB72jBOzC
 BSISZOgp0Lz8ZeCVC1xCjy4hM2zSBYMDl1haAEqSehvKUEaYduDwtbxAK9uMI+icbgaJgHhNR72Az
 T21ggwGoTCIKjPFfOMw5xxA/pNtBnrfaBbAigAD/GMNiYThJ5Jo/VLTJo1NywVydk0Fnh6JqBnuwm
 sxAZ4pGxb1dtegpN3g==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1sWQty-00Cwvh-2j;
 Wed, 24 Jul 2024 01:34:46 +0000
Date: Wed, 24 Jul 2024 01:34:46 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Don Porter <porter@cs.unc.edu>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 richard.henderson@linaro.org, philmd@linaro.org, berrange@redhat.com
Subject: Re: [PATCH v4 2/7] Import vmcs12 definition from Linux/KVM
Message-ID: <ZqBaNmVRc5DAI8k4@gallifrey>
References: <20240723010545.3648706-1-porter@cs.unc.edu>
 <20240723010545.3648706-3-porter@cs.unc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240723010545.3648706-3-porter@cs.unc.edu>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 01:33:18 up 76 days, 12:47, 1 user, load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

* Don Porter (porter@cs.unc.edu) wrote:
> Signed-off-by: Don Porter <porter@cs.unc.edu>
> ---
>  target/i386/kvm/vmcs12.h | 213 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 213 insertions(+)
>  create mode 100644 target/i386/kvm/vmcs12.h
> 
> diff --git a/target/i386/kvm/vmcs12.h b/target/i386/kvm/vmcs12.h
> new file mode 100644
> index 0000000000..c7b139f4db
> --- /dev/null
> +++ b/target/i386/kvm/vmcs12.h
> @@ -0,0 +1,213 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef QEMU_KVM_X86_VMX_VMCS12_H
> +#define QEMU_KVM_X86_VMX_VMCS12_H
> +
> +#include <linux/kvm.h>
> +
> +/* XXX: Stolen from Linux with light edits, for now */
> +
> +typedef uint64_t u64;
> +typedef uint32_t u32;
> +typedef uint16_t u16;

Hmm, it's a pity that scripts/update-linux-headers.sh can't be used
for this file; I don't think there are any cases of it doing things
out side linux's include?
Anyway, it has a big scary sed for fixing all of the kernel types,
so it's probably best to use that at least if you're copying it.

Dave

> +/*
> + * struct vmcs12 describes the state that our guest hypervisor (L1) keeps for a
> + * single nested guest (L2), hence the name vmcs12. Any VMX implementation has
> + * a VMCS structure, and vmcs12 is our emulated VMX's VMCS. This structure is
> + * stored in guest memory specified by VMPTRLD, but is opaque to the guest,
> + * which must access it using VMREAD/VMWRITE/VMCLEAR instructions.
> + * More than one of these structures may exist, if L1 runs multiple L2 guests.
> + * nested_vmx_run() will use the data here to build the vmcs02: a VMCS for the
> + * underlying hardware which will be used to run L2.
> + * This structure is packed to ensure that its layout is identical across
> + * machines (necessary for live migration).
> + *
> + * IMPORTANT: Changing the layout of existing fields in this structure
> + * will break save/restore compatibility with older kvm releases. When
> + * adding new fields, either use space in the reserved padding* arrays
> + * or add the new fields to the end of the structure.
> + */
> +typedef u64 natural_width;
> +
> +
> +struct vmcs_hdr {
> +    u32 revision_id : 31;
> +    u32 shadow_vmcs : 1;
> +};
> +
> +struct __attribute__ ((__packed__)) vmcs12 {
> +        /*
> +         * According to the Intel spec, a VMCS region must start with the
> +         * following two fields. Then follow implementation-specific data.
> +         */
> +        struct vmcs_hdr hdr;
> +        u32 abort;
> +
> +        u32 launch_state; /* set to 0 by VMCLEAR, to 1 by VMLAUNCH */
> +        u32 padding[7]; /* room for future expansion */
> +
> +        u64 io_bitmap_a;
> +        u64 io_bitmap_b;
> +        u64 msr_bitmap;
> +        u64 vm_exit_msr_store_addr;
> +        u64 vm_exit_msr_load_addr;
> +        u64 vm_entry_msr_load_addr;
> +        u64 tsc_offset;
> +        u64 virtual_apic_page_addr;
> +        u64 apic_access_addr;
> +        u64 posted_intr_desc_addr;
> +        u64 ept_pointer;
> +        u64 eoi_exit_bitmap0;
> +        u64 eoi_exit_bitmap1;
> +        u64 eoi_exit_bitmap2;
> +        u64 eoi_exit_bitmap3;
> +        u64 xss_exit_bitmap;
> +        u64 guest_physical_address;
> +        u64 vmcs_link_pointer;
> +        u64 guest_ia32_debugctl;
> +        u64 guest_ia32_pat;
> +        u64 guest_ia32_efer;
> +        u64 guest_ia32_perf_global_ctrl;
> +        u64 guest_pdptr0;
> +        u64 guest_pdptr1;
> +        u64 guest_pdptr2;
> +        u64 guest_pdptr3;
> +        u64 guest_bndcfgs;
> +        u64 host_ia32_pat;
> +        u64 host_ia32_efer;
> +        u64 host_ia32_perf_global_ctrl;
> +        u64 vmread_bitmap;
> +        u64 vmwrite_bitmap;
> +        u64 vm_function_control;
> +        u64 eptp_list_address;
> +        u64 pml_address;
> +        u64 encls_exiting_bitmap;
> +        u64 tsc_multiplier;
> +        u64 padding64[1]; /* room for future expansion */
> +        /*
> +         * To allow migration of L1 (complete with its L2 guests) between
> +         * machines of different natural widths (32 or 64 bit), we cannot have
> +         * unsigned long fields with no explicit size. We use u64 (aliased
> +         * natural_width) instead. Luckily, x86 is little-endian.
> +         */
> +        natural_width cr0_guest_host_mask;
> +        natural_width cr4_guest_host_mask;
> +        natural_width cr0_read_shadow;
> +        natural_width cr4_read_shadow;
> +        /* Last remnants of cr3_target_value[0-3]. */
> +        natural_width dead_space[4];
> +        natural_width exit_qualification;
> +        natural_width guest_linear_address;
> +        natural_width guest_cr0;
> +        natural_width guest_cr3;
> +        natural_width guest_cr4;
> +        natural_width guest_es_base;
> +        natural_width guest_cs_base;
> +        natural_width guest_ss_base;
> +        natural_width guest_ds_base;
> +        natural_width guest_fs_base;
> +        natural_width guest_gs_base;
> +        natural_width guest_ldtr_base;
> +        natural_width guest_tr_base;
> +        natural_width guest_gdtr_base;
> +        natural_width guest_idtr_base;
> +        natural_width guest_dr7;
> +        natural_width guest_rsp;
> +        natural_width guest_rip;
> +        natural_width guest_rflags;
> +        natural_width guest_pending_dbg_exceptions;
> +        natural_width guest_sysenter_esp;
> +        natural_width guest_sysenter_eip;
> +        natural_width host_cr0;
> +        natural_width host_cr3;
> +        natural_width host_cr4;
> +        natural_width host_fs_base;
> +        natural_width host_gs_base;
> +        natural_width host_tr_base;
> +        natural_width host_gdtr_base;
> +        natural_width host_idtr_base;
> +        natural_width host_ia32_sysenter_esp;
> +        natural_width host_ia32_sysenter_eip;
> +        natural_width host_rsp;
> +        natural_width host_rip;
> +        natural_width paddingl[8]; /* room for future expansion */
> +        u32 pin_based_vm_exec_control;
> +        u32 cpu_based_vm_exec_control;
> +        u32 exception_bitmap;
> +        u32 page_fault_error_code_mask;
> +        u32 page_fault_error_code_match;
> +        u32 cr3_target_count;
> +        u32 vm_exit_controls;
> +        u32 vm_exit_msr_store_count;
> +        u32 vm_exit_msr_load_count;
> +        u32 vm_entry_controls;
> +        u32 vm_entry_msr_load_count;
> +        u32 vm_entry_intr_info_field;
> +        u32 vm_entry_exception_error_code;
> +        u32 vm_entry_instruction_len;
> +        u32 tpr_threshold;
> +        u32 secondary_vm_exec_control;
> +        u32 vm_instruction_error;
> +        u32 vm_exit_reason;
> +        u32 vm_exit_intr_info;
> +        u32 vm_exit_intr_error_code;
> +        u32 idt_vectoring_info_field;
> +        u32 idt_vectoring_error_code;
> +        u32 vm_exit_instruction_len;
> +        u32 vmx_instruction_info;
> +        u32 guest_es_limit;
> +        u32 guest_cs_limit;
> +        u32 guest_ss_limit;
> +        u32 guest_ds_limit;
> +        u32 guest_fs_limit;
> +        u32 guest_gs_limit;
> +        u32 guest_ldtr_limit;
> +        u32 guest_tr_limit;
> +        u32 guest_gdtr_limit;
> +        u32 guest_idtr_limit;
> +        u32 guest_es_ar_bytes;
> +        u32 guest_cs_ar_bytes;
> +        u32 guest_ss_ar_bytes;
> +        u32 guest_ds_ar_bytes;
> +        u32 guest_fs_ar_bytes;
> +        u32 guest_gs_ar_bytes;
> +        u32 guest_ldtr_ar_bytes;
> +        u32 guest_tr_ar_bytes;
> +        u32 guest_interruptibility_info;
> +        u32 guest_activity_state;
> +        u32 guest_sysenter_cs;
> +        u32 host_ia32_sysenter_cs;
> +        u32 vmx_preemption_timer_value;
> +        u32 padding32[7]; /* room for future expansion */
> +        u16 virtual_processor_id;
> +        u16 posted_intr_nv;
> +        u16 guest_es_selector;
> +        u16 guest_cs_selector;
> +        u16 guest_ss_selector;
> +        u16 guest_ds_selector;
> +        u16 guest_fs_selector;
> +        u16 guest_gs_selector;
> +        u16 guest_ldtr_selector;
> +        u16 guest_tr_selector;
> +        u16 guest_intr_status;
> +        u16 host_es_selector;
> +        u16 host_cs_selector;
> +        u16 host_ss_selector;
> +        u16 host_ds_selector;
> +        u16 host_fs_selector;
> +        u16 host_gs_selector;
> +        u16 host_tr_selector;
> +        u16 guest_pml_index;
> +};
> +
> +/*
> + * VMCS12_REVISION is an arbitrary id that should be changed if the content or
> + * layout of struct vmcs12 is changed. MSR_IA32_VMX_BASIC returns this id, and
> + * VMPTRLD verifies that the VMCS region that L1 is loading contains this id.
> + *
> + * IMPORTANT: Changing this value will break save/restore compatibility with
> + * older kvm releases.
> + */
> +#define VMCS12_REVISION 0x11e57ed0
> +
> +#endif
> -- 
> 2.34.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

