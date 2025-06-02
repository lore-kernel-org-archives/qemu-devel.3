Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17DBC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 11:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM370-000153-Bs; Mon, 02 Jun 2025 07:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tabba@google.com>) id 1uM36x-00014F-QD
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 07:13:48 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tabba@google.com>) id 1uM36v-0003iu-Cn
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 07:13:47 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4a58197794eso345951cf.1
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 04:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1748862823; x=1749467623; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f8dEAF79E3N+09IzcVzt0JByl2jpxQuRRlI6WwFJD5s=;
 b=gFDC5tUoL9X6xRHoI6AQQ7hvvzGYGTqFRsMNXs4TtH6lz0xO6MmtsaG0HmeUDvQyFR
 /P9ZrMDhqgiqlBTQrVcrlCbVBnFz9wXgmntV7LLm4/+fWU6ATAzvf2BT28UGNckMXer4
 1i96nyri4gooRsglbvHXm7KXSc7suM5oZVyO+sjsFiw99QqDgCXJDpTSBp2j4G/yjy5K
 dbZKqRblp3yNMnmIrccaatShQBDpS7zoW0wOx246mf1+5nPlLrTKQJkl9Cx9DnqBVXYX
 f+XIYBfhtLNP7LTMvRhEIbe/08xIt+Dl95OOLnRROpnE3sDnDov2lFYw4Db884Np1bwi
 Cs4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748862823; x=1749467623;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f8dEAF79E3N+09IzcVzt0JByl2jpxQuRRlI6WwFJD5s=;
 b=eHW7FnnWZ7+7V5+kd6ypaqVv70mNXpzhaYpfkg9X7rD24EOSYWIUgMjOfg29Ti3Wr1
 OL/rHgcJ1IWPmQpvEGDV+2pRXH4h4AJR+jVrIcpT5btwzRSFOTJ3hkE/IrfRIdZEjZ9B
 bjZVHcCE2mQEY76Jj20s2kIuNuNnNUZ4EOWtykYUbftKxo0pHxe+NKyDXDHJo3KNOQBT
 plpchDLnbb6kSpWsydF8HZeJJr3l8kf9RARDgzBQ9fTCg8OFlwuPins+PayNa6Xt5s1R
 Nb6vDSbNTv0uc3FIqwhVUFq1gVTGmPWmg9kOSmR6OcSjv3OOuAh7T65OZM9LAq//iVmN
 oodA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2jfh8gM69xzenIb5vbSxVitPuBrAjRt24do3ZBj3uNCLrS4ZqO0FoBp1ULhn3cBGyHuvzvbWk9fTy@nongnu.org
X-Gm-Message-State: AOJu0Yz3UNIEd8OtJ2G77eZ+GoUQsC9LS46FQTieyonuP+fZejtM443L
 OigXMrUKIqBv2owXKTL5rDn8EBVxeqwaTQXJ/Hy4CYgeB5p2JxyoE5lAggwqd7Griq5E2xxI7Ch
 fTuSUaQONzf0aydz2lCbN/lbLUNPwh835Ws1vAQy/
X-Gm-Gg: ASbGncv6ppxYbyQllgeTyvwknVrLzJ6bCNSiTfYKhPBt6vut/ewOmjldxB7aw6yVeIK
 6vqC5141ZKnygGYy+3bSD75GkADTFQQlJxYAGMVPtXAo+2/NP7VWcIeAkwnN/h/M05p/tBXrgPB
 CvkhkK+K7HQgekze4dxfT+mNW3foRJk8NZ+foAwuQooRY=
X-Google-Smtp-Source: AGHT+IGwYjwwlPRO5odjKdIKbJHHZStw9OOAS6neCRvXXMHEHJTRLzURMRF6KmmQqeBeJGexACUuNAzOIaw2KTUsLGI=
X-Received: by 2002:a05:622a:1c0b:b0:48d:8f6e:ece7 with SMTP id
 d75a77b69052e-4a458161417mr5165681cf.3.1748862822877; Mon, 02 Jun 2025
 04:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250527180245.1413463-1-tabba@google.com>
 <20250527180245.1413463-9-tabba@google.com>
 <8f85fcf7-3593-46e8-b257-d0da2b7337b9@amd.com>
In-Reply-To: <8f85fcf7-3593-46e8-b257-d0da2b7337b9@amd.com>
From: Fuad Tabba <tabba@google.com>
Date: Mon, 2 Jun 2025 12:13:06 +0100
X-Gm-Features: AX0GCFvtbu_WgsBEElVSF2IfOuSPM9sWX6IdM_pHws-fhAfFTMXPKjL4cYGIGz8
Message-ID: <CA+EHjTx98wjg5UBRO9c-A8CZ7tc7yHrku+AKWY6G5pu2pE=ELQ@mail.gmail.com>
Subject: Re: [PATCH v10 08/16] KVM: guest_memfd: Allow host to map guest_memfd
 pages
To: Shivank Garg <shivankg@amd.com>
Cc: kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mm@kvack.org, 
 pbonzini@redhat.com, chenhuacai@kernel.org, mpe@ellerman.id.au, 
 anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
 aou@eecs.berkeley.edu, seanjc@google.com, viro@zeniv.linux.org.uk, 
 brauner@kernel.org, willy@infradead.org, akpm@linux-foundation.org, 
 xiaoyao.li@intel.com, yilun.xu@intel.com, chao.p.peng@linux.intel.com, 
 jarkko@kernel.org, amoorthy@google.com, dmatlack@google.com, 
 isaku.yamahata@intel.com, mic@digikod.net, vbabka@suse.cz, 
 vannapurve@google.com, ackerleytng@google.com, mail@maciej.szmigiero.name, 
 david@redhat.com, michael.roth@amd.com, wei.w.wang@intel.com, 
 liam.merwick@oracle.com, isaku.yamahata@gmail.com, 
 kirill.shutemov@linux.intel.com, suzuki.poulose@arm.com, steven.price@arm.com, 
 quic_eberman@quicinc.com, quic_mnalajal@quicinc.com, quic_tsoni@quicinc.com, 
 quic_svaddagi@quicinc.com, quic_cvanscha@quicinc.com, 
 quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, catalin.marinas@arm.com, 
 james.morse@arm.com, yuzenghui@huawei.com, oliver.upton@linux.dev, 
 maz@kernel.org, will@kernel.org, qperret@google.com, keirf@google.com, 
 roypat@amazon.co.uk, shuah@kernel.org, hch@infradead.org, jgg@nvidia.com, 
 rientjes@google.com, jhubbard@nvidia.com, fvdl@google.com, hughd@google.com, 
 jthoughton@google.com, peterx@redhat.com, pankaj.gupta@amd.com, 
 ira.weiny@intel.com, qemu-devel@nongnu.org, qemu-discuss@nongnu.org, 
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, nikunj@amd.com, 
 Bharata B Rao <bharata@amd.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=tabba@google.com; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -176
X-Spam_score: -17.7
X-Spam_bar: -----------------
X-Spam_report: (-17.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Shivank,

On Mon, 2 Jun 2025 at 11:44, Shivank Garg <shivankg@amd.com> wrote:
>
>
>
> On 5/27/2025 11:32 PM, Fuad Tabba wrote:
> > This patch enables support for shared memory in guest_memfd, including
> > mapping that memory at the host userspace. This support is gated by the
> > configuration option KVM_GMEM_SHARED_MEM, and toggled by the guest_memfd
> > flag GUEST_MEMFD_FLAG_SUPPORT_SHARED, which can be set when creating a
> > guest_memfd instance.
> >
> > Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > Signed-off-by: Fuad Tabba <tabba@google.com>
> > ---
> >  arch/x86/include/asm/kvm_host.h | 10 ++++
> >  arch/x86/kvm/x86.c              |  3 +-
> >  include/linux/kvm_host.h        | 13 ++++++
> >  include/uapi/linux/kvm.h        |  1 +
> >  virt/kvm/Kconfig                |  5 ++
> >  virt/kvm/guest_memfd.c          | 81 +++++++++++++++++++++++++++++++++
> >  6 files changed, 112 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > index 709cc2a7ba66..ce9ad4cd93c5 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -2255,8 +2255,18 @@ void kvm_configure_mmu(bool enable_tdp, int tdp_forced_root_level,
> >
> >  #ifdef CONFIG_KVM_GMEM
> >  #define kvm_arch_supports_gmem(kvm) ((kvm)->arch.supports_gmem)
> > +
> > +/*
> > + * CoCo VMs with hardware support that use guest_memfd only for backing private
> > + * memory, e.g., TDX, cannot use guest_memfd with userspace mapping enabled.
> > + */
> > +#define kvm_arch_supports_gmem_shared_mem(kvm)                       \
> > +     (IS_ENABLED(CONFIG_KVM_GMEM_SHARED_MEM) &&                      \
> > +      ((kvm)->arch.vm_type == KVM_X86_SW_PROTECTED_VM ||             \
> > +       (kvm)->arch.vm_type == KVM_X86_DEFAULT_VM))
> >  #else
> >  #define kvm_arch_supports_gmem(kvm) false
> > +#define kvm_arch_supports_gmem_shared_mem(kvm) false
> >  #endif
> >
> >  #define kvm_arch_has_readonly_mem(kvm) (!(kvm)->arch.has_protected_state)
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 035ced06b2dd..2a02f2457c42 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -12718,7 +12718,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
> >               return -EINVAL;
> >
> >       kvm->arch.vm_type = type;
> > -     kvm->arch.supports_gmem = (type == KVM_X86_SW_PROTECTED_VM);
> > +     kvm->arch.supports_gmem =
> > +             type == KVM_X86_DEFAULT_VM || type == KVM_X86_SW_PROTECTED_VM;
>
>
> I've been testing this patch-series. I did not saw failure with guest_memfd selftests but encountered a regression on my system with KVM_X86_DEFAULT_VM.
>
> I'm getting below error in QEMU:
> Issue #1 - QEMU fails to start with KVM_X86_DEFAULT_VM, showing:
>
> qemu-system-x86_64: kvm_set_user_memory_region: KVM_SET_USER_MEMORY_REGION2 failed, slot=65536, start=0x0, size=0x80000000, flags=0x0, guest_memfd=-1, guest_memfd_offset=0x0: Invalid argument
> kvm_set_phys_mem: error registering slot: Invalid argument
>
> I did some digging to find out,
> In kvm_set_memory_region as_id >= kvm_arch_nr_memslot_as_ids(kvm) now returns true.
> (as_id:1 kvm_arch_nr_memslot_as_ids(kvm):1 id:0 KVM_MEM_SLOTS_NUM:32767)
>
> /* SMM is currently unsupported for guests with guest_memfd (esp private) memory. */
> # define kvm_arch_nr_memslot_as_ids(kvm) (kvm_arch_supports_gmem(kvm) ? 1 : 2)
> evaluates to be 1
>
> I'm still debugging to find answer to these question
> Why slot=65536 and (as_id = mem->slot >> 16 = 1) is requested for KVM_X86_DEFAULT_VM case
> which is making it fail for above check.
> Was this change intentional for KVM_X86_DEFAULT_VM? Should this be considered as KVM regression or QEMU[1] compatibility issue?

Yes, this was intentional. We talked about this during the guest_memfd
biweekly sync on May 15 [*]. We came to the conclusion that we cannot
support SMM with private memory. KVM_X86_DEFAULT_VM cannot have
private memory, but guest_memfd with shared memory.

[*] https://docs.google.com/document/d/1M6766BzdY1Lhk7LiR5IqVR8B8mG3cr-cxTxOrAosPOk/edit?tab=t.0#heading=h.b4x45fcfgzvo

> ---
> Issue #2: Testing challenges with QEMU changes[2] and mmap Implementation:
> Currently, QEMU only enables guest_memfd for SEV_SNP_GUEST (KVM_X86_SNP_VM) by setting require_guest_memfd=true. However, the new mmap implementation doesn't support SNP guests per kvm_arch_supports_gmem_shared_mem().
>
> static void
> sev_snp_guest_instance_init(Object *obj)
> {
>     ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
>     SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
>
>     cgs->require_guest_memfd = true;
>
>
> To bypass this, I did two things and failed:
> 1. Enabling guest_memfd for KVM_X86_DEFAULT_VM in QEMU: Hits Issue #1 above
> 2. Adding KVM_X86_SNP_VM to kvm_arch_supports_gmem_shared_mem(): mmap() succeeds but QEMU stuck during boot.
>
>
>
> My NUMA policy support for guest-memfd patch[3] depends on mmap() support and extends
> kvm_gmem_vm_ops with get_policy/set_policy operations.
> Since NUMA policy applies to both shared and private memory scenarios, what checks should
> be included in the mmap() implementation, and what's the recommended approach for
> integrating with your shared memory restrictions?

KVM_X86_SNP_VM doesn't support in-place shared memory yet, so I think
this is to be expected for now.

Thanks,
/fuad

>
> [1] https://github.com/qemu/qemu
> [2] Snippet to QEMU changes to add mmap
>
> +                new_block->guest_memfd = kvm_create_guest_memfd(
> +                                           new_block->max_length, /*0 */GUEST_MEMFD_FLAG_SUPPORT_SHARED, errp);
> +                if (new_block->guest_memfd < 0) {
> +                        qemu_mutex_unlock_ramlist();
> +                        goto out_free;
> +                }
> +                new_block->ptr_memfd = mmap(NULL, new_block->max_length,
> +                                            PROT_READ | PROT_WRITE,
> +                                            MAP_SHARED,
> +                                            new_block->guest_memfd, 0);
> +                if (new_block->ptr_memfd == MAP_FAILED) {
> +                    error_report("Failed to mmap guest_memfd");
> +                    qemu_mutex_unlock_ramlist();
> +                    goto out_free;
> +                }
> +                printf("mmap successful\n");
> +            }
> [3] https://lore.kernel.org/linux-mm/20250408112402.181574-1-shivankg@amd.com
>
>
>
> >       /* Decided by the vendor code for other VM types.  */
> >       kvm->arch.pre_fault_allowed =
> >               type == KVM_X86_DEFAULT_VM || type == KVM_X86_SW_PROTECTED_VM;
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 80371475818f..ba83547e62b0 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -729,6 +729,19 @@ static inline bool kvm_arch_supports_gmem(struct kvm *kvm)
> >  }
> >  #endif
> >
> > +/*
> > + * Returns true if this VM supports shared mem in guest_memfd.
> > + *
> > + * Arch code must define kvm_arch_supports_gmem_shared_mem if support for
> > + * guest_memfd is enabled.
> > + */
> > +#if !defined(kvm_arch_supports_gmem_shared_mem) && !IS_ENABLED(CONFIG_KVM_GMEM)
> > +static inline bool kvm_arch_supports_gmem_shared_mem(struct kvm *kvm)
> > +{
> > +     return false;
> > +}
> > +#endif
> > +
> >  #ifndef kvm_arch_has_readonly_mem
> >  static inline bool kvm_arch_has_readonly_mem(struct kvm *kvm)
> >  {
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index b6ae8ad8934b..c2714c9d1a0e 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -1566,6 +1566,7 @@ struct kvm_memory_attributes {
> >  #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
> >
> >  #define KVM_CREATE_GUEST_MEMFD       _IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
> > +#define GUEST_MEMFD_FLAG_SUPPORT_SHARED      (1ULL << 0)
> >
> >  struct kvm_create_guest_memfd {
> >       __u64 size;
> > diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> > index 559c93ad90be..df225298ab10 100644
> > --- a/virt/kvm/Kconfig
> > +++ b/virt/kvm/Kconfig
> > @@ -128,3 +128,8 @@ config HAVE_KVM_ARCH_GMEM_PREPARE
> >  config HAVE_KVM_ARCH_GMEM_INVALIDATE
> >         bool
> >         depends on KVM_GMEM
> > +
> > +config KVM_GMEM_SHARED_MEM
> > +       select KVM_GMEM
> > +       bool
> > +       prompt "Enable support for non-private (shared) memory in guest_memfd"
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > index 6db515833f61..5d34712f64fc 100644
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> > @@ -312,7 +312,81 @@ static pgoff_t kvm_gmem_get_index(struct kvm_memory_slot *slot, gfn_t gfn)
> >       return gfn - slot->base_gfn + slot->gmem.pgoff;
> >  }
> >
> > +static bool kvm_gmem_supports_shared(struct inode *inode)
> > +{
> > +     u64 flags;
> > +
> > +     if (!IS_ENABLED(CONFIG_KVM_GMEM_SHARED_MEM))
> > +             return false;
> > +
> > +     flags = (u64)inode->i_private;
> > +
> > +     return flags & GUEST_MEMFD_FLAG_SUPPORT_SHARED;
> > +}
> > +
> > +
> > +#ifdef CONFIG_KVM_GMEM_SHARED_MEM
> > +static vm_fault_t kvm_gmem_fault_shared(struct vm_fault *vmf)
> > +{
> > +     struct inode *inode = file_inode(vmf->vma->vm_file);
> > +     struct folio *folio;
> > +     vm_fault_t ret = VM_FAULT_LOCKED;
> > +
> > +     folio = kvm_gmem_get_folio(inode, vmf->pgoff);
> > +     if (IS_ERR(folio)) {
> > +             int err = PTR_ERR(folio);
> > +
> > +             if (err == -EAGAIN)
> > +                     return VM_FAULT_RETRY;
> > +
> > +             return vmf_error(err);
> > +     }
> > +
> > +     if (WARN_ON_ONCE(folio_test_large(folio))) {
> > +             ret = VM_FAULT_SIGBUS;
> > +             goto out_folio;
> > +     }
> > +
> > +     if (!folio_test_uptodate(folio)) {
> > +             clear_highpage(folio_page(folio, 0));
> > +             kvm_gmem_mark_prepared(folio);
> > +     }
> > +
> > +     vmf->page = folio_file_page(folio, vmf->pgoff);
> > +
> > +out_folio:
> > +     if (ret != VM_FAULT_LOCKED) {
> > +             folio_unlock(folio);
> > +             folio_put(folio);
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static const struct vm_operations_struct kvm_gmem_vm_ops = {
> > +     .fault = kvm_gmem_fault_shared,
> > +};
> > +
> > +static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
> > +{
> > +     if (!kvm_gmem_supports_shared(file_inode(file)))
> > +             return -ENODEV;
> > +
> > +     if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) !=
> > +         (VM_SHARED | VM_MAYSHARE)) {
> > +             return -EINVAL;
> > +     }
> > +
> > +     vma->vm_ops = &kvm_gmem_vm_ops;
> > +
> > +     return 0;
> > +}
> > +#else
> > +#define kvm_gmem_mmap NULL
> > +#endif /* CONFIG_KVM_GMEM_SHARED_MEM */
> > +
> >  static struct file_operations kvm_gmem_fops = {
> > +     .mmap           = kvm_gmem_mmap,
> >       .open           = generic_file_open,
> >       .release        = kvm_gmem_release,
> >       .fallocate      = kvm_gmem_fallocate,
> > @@ -463,6 +537,9 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
> >       u64 flags = args->flags;
> >       u64 valid_flags = 0;
> >
> > +     if (kvm_arch_supports_gmem_shared_mem(kvm))
> > +             valid_flags |= GUEST_MEMFD_FLAG_SUPPORT_SHARED;
> > +
> >       if (flags & ~valid_flags)
> >               return -EINVAL;
> >
> > @@ -501,6 +578,10 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
> >           offset + size > i_size_read(inode))
> >               goto err;
> >
> > +     if (kvm_gmem_supports_shared(inode) &&
> > +         !kvm_arch_supports_gmem_shared_mem(kvm))
> > +             goto err;
> > +
> >       filemap_invalidate_lock(inode->i_mapping);
> >
> >       start = offset >> PAGE_SHIFT;
>
>
>
>
>
>
>

