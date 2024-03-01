Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2622C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 17:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6HA-0000RV-QR; Fri, 01 Mar 2024 12:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rg6H4-0000Bk-87
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:02:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rg6H0-0001XO-Az
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:02:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709312533;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=HUiA58gAhSzpAi1rIUEjCgHjbcLeM+FPBFuyz13n684=;
 b=Xm1Or42kSzg9eEzt+u0dwDOZ5OnHWFYph1DQyBpC8mPL8bcL2STXZURtzxAUQJsGKgv0Jx
 /RQt2gPZ3d7f418Fm2HgYC/5hnei4n/i6wBHHCoNI4wtvNjL9G7JoSK7KsUEwpokL12jFy
 A5qQi0h9MSFfIhl+hmXHCR6lyotQsaY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-pY6bapfUPwyY_4G5Dc4dAQ-1; Fri,
 01 Mar 2024 12:02:09 -0500
X-MC-Unique: pY6bapfUPwyY_4G5Dc4dAQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F6EA1C0515A;
 Fri,  1 Mar 2024 17:01:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A79571121312;
 Fri,  1 Mar 2024 17:01:49 +0000 (UTC)
Date: Fri, 1 Mar 2024 17:01:47 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH 7/9] i386/sev: Refactor setting of reset vector and
 initial CPU state
Message-ID: <ZeIJ-3zFzj0PAvDe@redhat.com>
References: <cover.1709044754.git.roy.hopkins@suse.com>
 <bf045e3364a0575d9680832dec5acba7aa441895.1709044754.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bf045e3364a0575d9680832dec5acba7aa441895.1709044754.git.roy.hopkins@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Feb 27, 2024 at 02:50:13PM +0000, Roy Hopkins wrote:
> When an SEV guest is started, the reset vector and state are
> extracted from metadata that is contained in the firmware volume.
> 
> In preparation for using IGVM to setup the initial CPU state,
> the code has been refactored to populate vmcb_save_area for each
> CPU which is then applied during guest startup and CPU reset.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> ---
>  target/i386/sev.c | 288 +++++++++++++++++++++++++++++++++++++++++-----
>  target/i386/sev.h | 110 ++++++++++++++++++
>  2 files changed, 369 insertions(+), 29 deletions(-)
> 
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 173de91afe..d6902432fd 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -74,9 +74,7 @@ struct SevGuestState {
>      SevState state;
>      gchar *measurement;
>  
> -    uint32_t reset_cs;
> -    uint32_t reset_ip;
> -    bool reset_data_valid;
> +    QTAILQ_HEAD(, SevLaunchVmsa) launch_vmsa;
>  };
>  
>  #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
> @@ -99,6 +97,12 @@ typedef struct QEMU_PACKED SevHashTableDescriptor {
>  /* hard code sha256 digest size */
>  #define HASH_SIZE 32
>  
> +/* Convert between SEV-ES VMSA and SegmentCache flags/attributes */
> +#define FLAGS_VMSA_TO_SEGCACHE(flags) \
> +    ((((flags) & 0xff00) << 12) | (((flags) & 0xff) << 8))
> +#define FLAGS_SEGCACHE_TO_VMSA(flags) \
> +    ((((flags) & 0xff00) >> 8) | (((flags) & 0xf00000) >> 12))
> +
>  typedef struct QEMU_PACKED SevHashTableEntry {
>      QemuUUID guid;
>      uint16_t len;
> @@ -125,6 +129,15 @@ typedef struct QEMU_PACKED PaddedSevHashTable {
>  QEMU_BUILD_BUG_ON(sizeof(PaddedSevHashTable) % 16 != 0);
>  
>  static SevGuestState *sev_guest;
> +
> +typedef struct SevLaunchVmsa {
> +    QTAILQ_ENTRY(SevLaunchVmsa) next;
> +
> +    uint16_t cpu_index;
> +    uint64_t gpa;
> +    struct sev_es_save_area vmsa;
> +} SevLaunchVmsa;
> +
>  static Error *sev_mig_blocker;
>  
>  static const char *const sev_fw_errlist[] = {
> @@ -291,6 +304,149 @@ sev_guest_finalize(Object *obj)
>  {
>  }
>  
> +static void sev_apply_cpu_context(CPUState *cpu)
> +{
> +    SevGuestState *sev_guest = SEV_GUEST(MACHINE(qdev_get_machine())->cgs);
> +    X86CPU *x86;
> +    CPUX86State *env;
> +    struct SevLaunchVmsa *launch_vmsa;
> +
> +    /* See if an initial VMSA has been provided for this CPU */
> +    QTAILQ_FOREACH(launch_vmsa, &sev_guest->launch_vmsa, next)
> +    {
> +        if (cpu->cpu_index == launch_vmsa->cpu_index) {
> +            x86 = X86_CPU(cpu);
> +            env = &x86->env;
> +
> +            /*
> +             * Ideally we would provide the VMSA directly to kvm which would
> +             * ensure that the resulting initial VMSA measurement which is
> +             * calculated during KVM_SEV_LAUNCH_UPDATE_VMSA is calculated from
> +             * exactly what we provide here. Currently this is not possible so
> +             * we need to copy the parts of the VMSA structure that we currently
> +             * support into the CPU state.
> +             */

This sounds like it is saying that the code is not honouring
everything in the VMSA defiend by the IGVM file ?

If so, that is pretty awkward. The VMSA is effectively an external
ABI between QEMU and the guest owner (or whatever is validating
guest attestation reports for them), and thus predictability and
stability of this over time is critical.

We don't want the attestation process to be dependent/variable on
the particular QEMU/KVM version, because any upgrade to QEMU/KVM
could then alter the effective VMSA that the guest owner sees.

We've already suffered pain in this respect not long ago when the
kernel arbitrarily changed a default setting which altered the
VMSA it exposed, breaking existing apps that validate attestation.

What will it take to provide the full VMSA to KVM, so that we can
guarantee to the guest owner than the VMSA for the guest is going
to perfectly match what their IGVM defined ?

> +            cpu_load_efer(env, launch_vmsa->vmsa.efer);
> +            cpu_x86_update_cr4(env, launch_vmsa->vmsa.cr4);
> +            cpu_x86_update_cr0(env, launch_vmsa->vmsa.cr0);
> +            cpu_x86_update_cr3(env, launch_vmsa->vmsa.cr3);
> +
> +            cpu_x86_load_seg_cache(
> +                env, R_CS, launch_vmsa->vmsa.cs.selector,
> +                launch_vmsa->vmsa.cs.base, launch_vmsa->vmsa.cs.limit,
> +                FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.cs.attrib));
> +            cpu_x86_load_seg_cache(
> +                env, R_DS, launch_vmsa->vmsa.ds.selector,
> +                launch_vmsa->vmsa.ds.base, launch_vmsa->vmsa.ds.limit,
> +                FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.ds.attrib));
> +            cpu_x86_load_seg_cache(
> +                env, R_ES, launch_vmsa->vmsa.es.selector,
> +                launch_vmsa->vmsa.es.base, launch_vmsa->vmsa.es.limit,
> +                FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.es.attrib));
> +            cpu_x86_load_seg_cache(
> +                env, R_FS, launch_vmsa->vmsa.fs.selector,
> +                launch_vmsa->vmsa.fs.base, launch_vmsa->vmsa.fs.limit,
> +                FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.fs.attrib));
> +            cpu_x86_load_seg_cache(
> +                env, R_GS, launch_vmsa->vmsa.gs.selector,
> +                launch_vmsa->vmsa.gs.base, launch_vmsa->vmsa.gs.limit,
> +                FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.gs.attrib));
> +            cpu_x86_load_seg_cache(
> +                env, R_SS, launch_vmsa->vmsa.ss.selector,
> +                launch_vmsa->vmsa.ss.base, launch_vmsa->vmsa.ss.limit,
> +                FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.ss.attrib));
> +
> +            env->gdt.base = launch_vmsa->vmsa.gdtr.base;
> +            env->gdt.limit = launch_vmsa->vmsa.gdtr.limit;
> +            env->idt.base = launch_vmsa->vmsa.idtr.base;
> +            env->idt.limit = launch_vmsa->vmsa.idtr.limit;
> +
> +            env->regs[R_EAX] = launch_vmsa->vmsa.rax;
> +            env->regs[R_ECX] = launch_vmsa->vmsa.rcx;
> +            env->regs[R_EDX] = launch_vmsa->vmsa.rdx;
> +            env->regs[R_EBX] = launch_vmsa->vmsa.rbx;
> +            env->regs[R_ESP] = launch_vmsa->vmsa.rsp;
> +            env->regs[R_EBP] = launch_vmsa->vmsa.rbp;
> +            env->regs[R_ESI] = launch_vmsa->vmsa.rsi;
> +            env->regs[R_EDI] = launch_vmsa->vmsa.rdi;
> +#ifdef TARGET_X86_64
> +            env->regs[R_R8] = launch_vmsa->vmsa.r8;
> +            env->regs[R_R9] = launch_vmsa->vmsa.r9;
> +            env->regs[R_R10] = launch_vmsa->vmsa.r10;
> +            env->regs[R_R11] = launch_vmsa->vmsa.r11;
> +            env->regs[R_R12] = launch_vmsa->vmsa.r12;
> +            env->regs[R_R13] = launch_vmsa->vmsa.r13;
> +            env->regs[R_R14] = launch_vmsa->vmsa.r14;
> +            env->regs[R_R15] = launch_vmsa->vmsa.r15;
> +#endif
> +            env->eip = launch_vmsa->vmsa.rip;
> +            break;
> +        }
> +    }
> +}


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


