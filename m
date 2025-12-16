Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD05D5E156
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 13:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVVUJ-00058d-W1; Tue, 16 Dec 2025 08:53:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVVUH-000587-DK
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 08:53:13 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVVUF-0001h1-N0
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 08:53:13 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 153195BCD6;
 Tue, 16 Dec 2025 13:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765893188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZFnNkL3gAOH3Set42pPIr6QBedDLQIpiu7ddBCaA7LI=;
 b=zFzYadJau6wA3wB+13s0HvQuJfFJUYmNB03+UF1ooKtOclfXEUgq6Q5bwhYM3vnedT7Wf6
 X2fTSo/7eHFUZ0FbLVMLkP2gtqV2v+vqP4wYVumYpLPcI565c4coQ2ateLwU+R8ZNv8A9f
 KNap3CAKnJ9bvqU07fCiyoC7JGG9ED8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765893188;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZFnNkL3gAOH3Set42pPIr6QBedDLQIpiu7ddBCaA7LI=;
 b=gYKuUYiuLAos2CQzp6ejIIOtGkrfYo3RhmFnHSoPseXDJb6TblDHNXT4W15uugK02icL0p
 +tHh9+E2sq99QSAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zFzYadJa;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gYKuUYiu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765893188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZFnNkL3gAOH3Set42pPIr6QBedDLQIpiu7ddBCaA7LI=;
 b=zFzYadJau6wA3wB+13s0HvQuJfFJUYmNB03+UF1ooKtOclfXEUgq6Q5bwhYM3vnedT7Wf6
 X2fTSo/7eHFUZ0FbLVMLkP2gtqV2v+vqP4wYVumYpLPcI565c4coQ2ateLwU+R8ZNv8A9f
 KNap3CAKnJ9bvqU07fCiyoC7JGG9ED8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765893188;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZFnNkL3gAOH3Set42pPIr6QBedDLQIpiu7ddBCaA7LI=;
 b=gYKuUYiuLAos2CQzp6ejIIOtGkrfYo3RhmFnHSoPseXDJb6TblDHNXT4W15uugK02icL0p
 +tHh9+E2sq99QSAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 826BB3EA63;
 Tue, 16 Dec 2025 13:53:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YNAfD0NkQWnjKQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 16 Dec 2025 13:53:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, David Hildenbrand <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chenyi Qiang
 <chenyi.qiang@intel.com>, peterx@redhat.com, Alexey Kardashevskiy
 <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: Re: [PATCH v3 01/12] kvm: Decouple memory attribute check from
 kvm_guest_memfd_supported
In-Reply-To: <20251215205203.1185099-2-peterx@redhat.com>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <20251215205203.1185099-2-peterx@redhat.com>
Date: Tue, 16 Dec 2025 10:53:04 -0300
Message-ID: <87345a354v.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 153195BCD6
X-Spamd-Result: default: False [-5.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[9];
 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> From: Xiaoyao Li <xiaoyao.li@intel.com>
>
> With the mmap support of guest memfd, KVM allows usersapce to create
> guest memfd serving as normal non-private memory for X86 DEFEAULT VM.
> However, KVM doesn't support private memory attriute for X86 DEFAULT
> VM.
>
> Make kvm_guest_memfd_supported not rely on KVM_MEMORY_ATTRIBUTE_PRIVATE
> and check KVM_MEMORY_ATTRIBUTE_PRIVATE separately when the machine
> requires guest_memfd to serve as private memory.
>
> This allows QMEU to create guest memfd with mmap to serve as the memory
> backend for X86 DEFAULT VM.
>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/system/kvm.h   | 1 +
>  accel/kvm/kvm-all.c    | 8 ++++++--
>  accel/stubs/kvm-stub.c | 5 +++++
>  system/physmem.c       | 8 ++++++++
>  4 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/include/system/kvm.h b/include/system/kvm.h
> index 8f9eecf044..b5811c90f1 100644
> --- a/include/system/kvm.h
> +++ b/include/system/kvm.h
> @@ -561,6 +561,7 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp);
>  
>  int kvm_set_memory_attributes_private(hwaddr start, uint64_t size);
>  int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size);
> +bool kvm_private_memory_attribute_supported(void);
>  
>  int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private);
>  
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 28006d73c5..59836ebdff 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1501,6 +1501,11 @@ int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size)
>      return kvm_set_memory_attributes(start, size, 0);
>  }
>  
> +bool kvm_private_memory_attribute_supported(void)
> +{
> +    return !!(kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
> +}
> +
>  /* Called with KVMMemoryListener.slots_lock held */
>  static void kvm_set_phys_mem(KVMMemoryListener *kml,
>                               MemoryRegionSection *section, bool add)
> @@ -2781,8 +2786,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
>      kvm_supported_memory_attributes = kvm_vm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
>      kvm_guest_memfd_supported =
>          kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
> -        kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2) &&
> -        (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
> +        kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2);
>      kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, KVM_CAP_PRE_FAULT_MEMORY);
>  
>      if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> index 68cd33ba97..73f04eb589 100644
> --- a/accel/stubs/kvm-stub.c
> +++ b/accel/stubs/kvm-stub.c
> @@ -125,3 +125,8 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
>  {
>      return -ENOSYS;
>  }
> +
> +bool kvm_private_memory_attribute_supported(void)
> +{
> +    return false;
> +}
> diff --git a/system/physmem.c b/system/physmem.c
> index c9869e4049..3555d2f6f7 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2211,6 +2211,14 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>                         object_get_typename(OBJECT(current_machine->cgs)));
>              goto out_free;
>          }
> +
> +        if (!kvm_private_memory_attribute_supported()) {
> +            error_setg(errp, "cannot set up private guest memory for %s: "
> +                       " KVM does not support private memory attribute",
> +                       object_get_typename(OBJECT(current_machine->cgs)));
> +            goto out_free;
> +        }

Hm, it took me a while to understand why this is under (new_block->flags
& RAM_GUEST_MEMFD) but checking for private memory support. If it's at
all feasible I would just squash all those patches doing
s/guest_memfd/guest_memfd_private/ to avoid having intermediate patches
where the terminology is not aligned.

Anyway, up to you. For this one:

Reviewed-by: Fabiano Rosas <farosas@suse.de>


