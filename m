Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1763F8E49F
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 13:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wE5NT-0000x7-P7; Sat, 18 Apr 2026 09:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mtosatti@redhat.com>)
 id 1wE5NS-0000wr-LJ
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 09:06:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mtosatti@redhat.com>)
 id 1wE5NP-00018n-5o
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 09:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776517581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K4nuebS8y372vawLKXFvx7hkXXZCSxPjXNeX1sq2ohU=;
 b=NOqaEyjjEYvwWWDWbuUvXcZyNjRPmIo87mchP9Ozo+kt8aGE/5IE+0m22OM3XnBulhKDav
 koz4ZyH8dzMHSBbwL/dI75ZDxNBjp0aPvnCUwZejsLFGbZiOIbh3wjK7A1E/aaf3YplACN
 ShJ+GCnVMVR25u6W0YBW31v+0X744aI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-QrWvJZUIPfOBDagirqwwdQ-1; Sat,
 18 Apr 2026 09:05:11 -0400
X-MC-Unique: QrWvJZUIPfOBDagirqwwdQ-1
X-Mimecast-MFC-AGG-ID: QrWvJZUIPfOBDagirqwwdQ_1776517510
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CC04195608F; Sat, 18 Apr 2026 13:05:10 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AF24180057E; Sat, 18 Apr 2026 13:05:09 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
 id 45921401E4564; Fri, 17 Apr 2026 02:51:56 -0300 (-03)
Date: Fri, 17 Apr 2026 02:51:56 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Florian Schmidt <flosch@nutanix.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 2/2] Add HvExtCallGetBootZeroedMemory
Message-ID: <aeHKfOmm2b7cY70i@tpad>
References: <20260112113139.3762156-1-flosch@nutanix.com>
 <20260112113139.3762156-3-flosch@nutanix.com>
 <a28bd807-6e98-4393-a354-b7ed1f7a08ae@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a28bd807-6e98-4393-a354-b7ed1f7a08ae@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mtosatti@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 20
X-Spam_score: 2.0
X-Spam_bar: ++
X-Spam_report: (2.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIMWL_WL_HIGH=-0.54, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Apr 16, 2026 at 02:47:06PM +0200, Paolo Bonzini wrote:
> On 1/12/26 12:31, Florian Schmidt wrote:
> > This call allows a guest to ask the hypervisor which of its (guest
> > physical) memory ranges were already zeroed out by the hypervisor, which
> > means there's no need for the guest to zero them out again at boot.
> > 
> > For now, we simply send one entry back that says "all
> > 64-bit-adddressable memory is zeroed out". This seems to work fine.
> 
> This is risky and depends on the firmware.
> 
> As discussed on IRC, there are multiple sources of writes and each of them
> needs to be tracked, and we can say that any write potentially makes the
> page nonzero.
> 
> The main two are QEMU and the guest, i.e. KVM.
> 
> Dirty page tracking is suitable for QEMU, but not so much for KVM.  When
> QEMU enables dirty page tracking in KVM, it does so lazily, i.e. all pages
> are assumed dirty at the beginning.  This is exactly the opposite of what
> you want here (almost all pages are zero at the beginning).  So maybe only
> enable this hypercall when dirty page tracking uses a ring buffer?
> 
> But as far as QEMU is concerned you could indeed add a fourth dirty memory
> bitmap, DIRTY_MEMORY_NONZERO, and turn it off after the first call to the
> hypercall (hopefully Windows only calls it once)?
> 
> As an alternative to tracking dirty pages in KVM, it would be possible to
> ask KVM to build a bitmap of pages that were mapped, even at high
> granularity (e.g. with 32MB you'd fit the bitmap for 1TB of memory in a
> single page!).  QEMU could use dirty page tracking, and build a combination
> (NOR) of the bitmap from KVM and QEMU's dirty page bitmap.
> 
> QEMU could also do the same high-granularity tracking, but that leaves out
> other sources of writes like VFIO or vhost, both of which probably matter to
> Nutanix :) and which would be stuck with 4k-granularity dirty page tracking.
> 
> Sorry for the delay, I was hoping to have some better ideas.
> 
> Paolo

Hi,

Is this to improve boot time of very large guests ?

> > Note that memory devies hotplugged later will still be zeroed out.
> > 
> > Signed-off-by: Florian Schmidt <flosch@nutanix.com>
> > ---
> >   docs/system/i386/hyperv.rst      |  5 +++++
> >   hw/hyperv/hyperv.c               | 34 ++++++++++++++++++++++++++++++++
> >   include/hw/hyperv/hyperv-proto.h | 11 +++++++++++
> >   include/hw/hyperv/hyperv.h       |  5 +++++
> >   target/i386/cpu.c                |  2 ++
> >   target/i386/cpu.h                |  1 +
> >   target/i386/kvm/hyperv-proto.h   |  5 +++++
> >   target/i386/kvm/hyperv.c         | 12 ++++++++++-
> >   8 files changed, 74 insertions(+), 1 deletion(-)
> > 
> > diff --git a/docs/system/i386/hyperv.rst b/docs/system/i386/hyperv.rst
> > index 1c1de77feb..7d2be2109e 100644
> > --- a/docs/system/i386/hyperv.rst
> > +++ b/docs/system/i386/hyperv.rst
> > @@ -256,6 +256,11 @@ Existing enlightenments
> >     Recommended: ``hv-evmcs`` (Intel)
> > +``hv-boot-zeroed-mem``
> > +  Enables the HvExtGetBootZeroedMemory hypercall. This allows a Windows guest to
> > +  inquire which memory has already been zeroed out by the host and thus doesn't
> > +  need to be zeroed out at boot again.
> > +
> >   Supplementary features
> >   ----------------------
> > diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> > index 13a42a68b2..d1b15c089e 100644
> > --- a/hw/hyperv/hyperv.c
> > +++ b/hw/hyperv/hyperv.c
> > @@ -727,6 +727,40 @@ cleanup:
> >       return ret;
> >   }
> > +uint16_t hyperv_ext_hcall_get_boot_zeroed_memory(uint64_t outgpa, bool fast)
> > +{
> > +    uint16_t ret;
> > +    struct hyperv_get_boot_zeroed_memory_output *zero_ranges = NULL;
> > +    hwaddr len;
> > +
> > +    if (fast) {
> > +        ret = HV_STATUS_INVALID_HYPERCALL_CODE;
> > +        goto cleanup;
> > +    }
> > +
> > +    len = sizeof(*zero_ranges);
> > +    zero_ranges = cpu_physical_memory_map(outgpa, &len, 1);
> > +    if (!zero_ranges || len < sizeof(*zero_ranges)) {
> > +        ret = HV_STATUS_INSUFFICIENT_MEMORY;
> > +        goto cleanup;
> > +    }
> > +
> > +    /*
> > +     * All memory we pass through will always be zeroed.
> > +     * (Check if that's actually true!)
> > +     */
> > +    zero_ranges->range_count = 1;
> > +    zero_ranges->ranges[0].start_pfn = 0x0;
> > +    zero_ranges->ranges[0].page_count = 0x10000000000000;
> > +    ret = HV_STATUS_SUCCESS;
> > +
> > +cleanup:
> > +    if (zero_ranges) {
> > +        cpu_physical_memory_unmap(zero_ranges, sizeof(*zero_ranges), 1, len);
> > +    }
> > +    return ret;
> > +}
> > +
> >   uint16_t hyperv_hcall_signal_event(uint64_t param, bool fast)
> >   {
> >       EventFlagHandler *handler;
> > diff --git a/include/hw/hyperv/hyperv-proto.h b/include/hw/hyperv/hyperv-proto.h
> > index f1d1d2eb26..5bf5684d11 100644
> > --- a/include/hw/hyperv/hyperv-proto.h
> > +++ b/include/hw/hyperv/hyperv-proto.h
> > @@ -36,6 +36,7 @@
> >   #define HV_RETRIEVE_DEBUG_DATA                0x006a
> >   #define HV_RESET_DEBUG_SESSION                0x006b
> >   #define HV_EXT_CALL_QUERY_CAPABILITIES        0x8001
> > +#define HV_EXT_CALL_GET_BOOT_ZEROED_MEMORY    0x8002
> >   #define HV_HYPERCALL_FAST                     (1u << 16)
> >   /*
> > @@ -192,4 +193,14 @@ struct hyperv_retrieve_debug_data_output {
> >       uint32_t retrieved_count;
> >       uint32_t remaining_count;
> >   } __attribute__ ((__packed__));
> > +
> > +struct hyperv_get_boot_zeroed_memory_range {
> > +    uint64_t start_pfn;
> > +    uint64_t page_count;
> > +} __attribute__ ((__packed__));
> > +
> > +struct hyperv_get_boot_zeroed_memory_output {
> > +    uint64_t range_count;
> > +    struct hyperv_get_boot_zeroed_memory_range ranges[255];
> > +} __attribute__ ((__packed__));
> >   #endif
> > diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
> > index 921e1623f7..54cd2fff72 100644
> > --- a/include/hw/hyperv/hyperv.h
> > +++ b/include/hw/hyperv/hyperv.h
> > @@ -101,6 +101,11 @@ uint16_t hyperv_hcall_post_dbg_data(uint64_t ingpa, uint64_t outgpa, bool fast);
> >    */
> >   uint16_t hyperv_ext_hcall_query_caps(uint64_t sup, uint64_t outgpa, bool fast);
> > +/*
> > + * Process HVCALL_EXT_GET_BOOT_ZEROED_MEMORY hypercall.
> > + */
> > +uint16_t hyperv_ext_hcall_get_boot_zeroed_memory(uint64_t outgpa, bool fast);
> > +
> >   uint32_t hyperv_syndbg_send(uint64_t ingpa, uint32_t count);
> >   uint32_t hyperv_syndbg_recv(uint64_t ingpa, uint32_t count);
> >   void hyperv_syndbg_set_pending_page(uint64_t ingpa);
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 37803cd724..d4160f3334 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -10492,6 +10492,8 @@ static const Property x86_cpu_properties[] = {
> >                         HYPERV_FEAT_TLBFLUSH_EXT, 0),
> >       DEFINE_PROP_BIT64("hv-tlbflush-direct", X86CPU, hyperv_features,
> >                         HYPERV_FEAT_TLBFLUSH_DIRECT, 0),
> > +    DEFINE_PROP_BIT64("hv-boot-zeroed-mem", X86CPU, hyperv_features,
> > +                      HYPERV_FEAT_BOOT_ZEROED_MEMORY, 0),
> >       DEFINE_PROP_ON_OFF_AUTO("hv-no-nonarch-coresharing", X86CPU,
> >                               hyperv_no_nonarch_cs, ON_OFF_AUTO_OFF),
> >   #ifdef CONFIG_SYNDBG
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index 2bbc977d90..a42eacd800 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -1463,6 +1463,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
> >   #define HYPERV_FEAT_XMM_INPUT           18
> >   #define HYPERV_FEAT_TLBFLUSH_EXT        19
> >   #define HYPERV_FEAT_TLBFLUSH_DIRECT     20
> > +#define HYPERV_FEAT_BOOT_ZEROED_MEMORY  21
> >   #ifndef HYPERV_SPINLOCK_NEVER_NOTIFY
> >   #define HYPERV_SPINLOCK_NEVER_NOTIFY             0xFFFFFFFF
> > diff --git a/target/i386/kvm/hyperv-proto.h b/target/i386/kvm/hyperv-proto.h
> > index 4eb2955ac5..ec38b717e4 100644
> > --- a/target/i386/kvm/hyperv-proto.h
> > +++ b/target/i386/kvm/hyperv-proto.h
> > @@ -94,6 +94,11 @@
> >   #define HV_NESTED_DIRECT_FLUSH              (1u << 17)
> >   #define HV_NESTED_MSR_BITMAP                (1u << 19)
> > +/*
> > + * HV_EXT_CALL_QUERY_CAPABILITIES bits
> > + */
> > +#define HV_EXT_CAP_GET_BOOT_ZEROED_MEMORY   (1u << 0)
> > +
> >   /*
> >    * Basic virtualized MSRs
> >    */
> > diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
> > index 1ac5c26799..f92ea7e0a2 100644
> > --- a/target/i386/kvm/hyperv.c
> > +++ b/target/i386/kvm/hyperv.c
> > @@ -55,7 +55,9 @@ static uint64_t calc_supported_ext_hypercalls(X86CPU *cpu)
> >   {
> >       uint64_t ret = 0;
> > -    /* For now, no extended hypercalls are supported. */
> > +    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_BOOT_ZEROED_MEMORY)) {
> > +        ret |= HV_EXT_CAP_GET_BOOT_ZEROED_MEMORY;
> > +    }
> >       return ret;
> >   }
> > @@ -122,6 +124,14 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
> >                   hyperv_ext_hcall_query_caps(calc_supported_ext_hypercalls(cpu),
> >                                               out_param, fast);
> >               break;
> > +        case HV_EXT_CALL_GET_BOOT_ZEROED_MEMORY:
> > +            if (!hyperv_feat_enabled(cpu, HYPERV_FEAT_BOOT_ZEROED_MEMORY)) {
> > +                exit->u.hcall.result = HV_STATUS_INVALID_HYPERCALL_CODE;
> > +            } else {
> > +                exit->u.hcall.result =
> > +                    hyperv_ext_hcall_get_boot_zeroed_memory(out_param, fast);
> > +            }
> > +            break;
> >           default:
> >               exit->u.hcall.result = HV_STATUS_INVALID_HYPERCALL_CODE;
> >           }
> 
> 


