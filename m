Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F3BC5CFEB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuPyH-0002ji-TZ; Thu, 13 Aug 2026 03:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <msuchanek@suse.de>)
 id 1wuPyG-0002jO-6N; Thu, 13 Aug 2026 03:35:24 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <msuchanek@suse.de>)
 id 1wuPyE-0001PI-4V; Thu, 13 Aug 2026 03:35:23 -0400
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C99F13E6D;
 Thu, 13 Aug 2026 07:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786606515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+ohbpP4PWX0hIpf6SvEkZ4BNtZVxfmbgo05EbbLFYhw=;
 b=iqGI6biKSqg2QBAxper2lkTlKrcJBZpnQgfBROnMYrEv5dMRcZmdCKx/OCO4jGc2X6mJfS
 d59ho5LalGo9RHob2zCdIvA191Muf7iieCWRYsu4SK6HDiBFCh3qFQeg4bWPk4tfX4rhYL
 8THU3mpt4fnjwb/7koUaNpYpx2AGpjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786606515;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+ohbpP4PWX0hIpf6SvEkZ4BNtZVxfmbgo05EbbLFYhw=;
 b=hFkLVeuTB1LSSQxKQrDrYNw8dgWtAby7BJExZkje3yC8gcwW1q6Cvo6ojVMAJcBcST5rnX
 pm6VPTwBiyCPbxCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=owFWtnMF;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8oJpsy9O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786606510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+ohbpP4PWX0hIpf6SvEkZ4BNtZVxfmbgo05EbbLFYhw=;
 b=owFWtnMFiLLkxo4e+Xs3U+f70Atf2GY1mewfj+hZk2hBsadqgV4CGFI9YOru3KPYgf9i8g
 V+01bxeggG3OxM6ThvwgefmBk5xnBlYgv69vVq3fXO0UTnTcZ6fzXf81Hl5KBREXafOAYX
 eEPGmYeB5AoGDEqRon3K9WVa3TGno5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786606510;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+ohbpP4PWX0hIpf6SvEkZ4BNtZVxfmbgo05EbbLFYhw=;
 b=8oJpsy9Oqz0wtQUanWzulF6mnGZZ4PdaCAseOPc18xUIFrJaKfQHMo9frCW49DKpuRpoFy
 Jv533hhl6wozJMBg==
Date: Thu, 13 Aug 2026 09:35:09 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, Gautam Menghani <gautam@linux.ibm.com>
Subject: Re: [PATCH v6 1/3] [DO_NOT_MERGE] linux-headers: Add uapi header
 changes
Message-ID: <an1zrUhbu_RYkJ-y@kunlun.suse.cz>
References: <20260812170854.58709-1-amachhiw@linux.ibm.com>
 <20260812170854.58709-2-amachhiw@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812170854.58709-2-amachhiw@linux.ibm.com>
X-Spamd-Result: default: False [15.15 / 50.00]; SPAM_FLAG(5.00)[];
 NEURAL_SPAM_LONG(3.50)[1.000]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_SPAM_SHORT(2.96)[0.988];
 HFILTER_HOSTNAME_UNKNOWN(2.50)[]; RDNS_NONE(2.00)[];
 ONCE_RECEIVED(1.20)[]; HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
 HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWELVE(0.00)[13];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_ZERO(0.00)[0];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 FREEMAIL_CC(0.00)[nongnu.org,linux.ibm.com,eik.bme.hu,gmail.com,redhat.com,vger.kernel.org];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Spamd-Bar: +++++++++++++++
X-Rspamd-Queue-Id: C99F13E6D
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: add header
X-Spam: Yes
Received-SPF: pass client-ip=195.135.223.131; envelope-from=msuchanek@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hello,

some version of the kernel patches seems to be merged in the powerpc
tree now.

Cant his be merged now or is a refresh required?

Thanks

Michal

On Wed, Aug 12, 2026 at 10:38:52PM +0530, Amit Machhiwal wrote:
> This is a temporary patch intended for review and testing purposes only.
> It syncs the QEMU linux-headers with the kernel v9 changes that introduce
> the KVM_PPC_GET_COMPAT_CAPS ioctl for querying host CPU compatibility
> capabilities. The struct kvm_ppc_compat_caps places 'size' as the first
> field as required by copy_struct_from/to_user() versioning, with
> KVM_PPC_COMPAT_CAPS_SIZE_VER0 (24) defined as the frozen version-floor
> constant. The capability number is KVM_CAP_PPC_COMPAT_CAPS (250) and
> the ioctl is defined as _IO so the ioctl number remains stable if the
> struct grows in future versions. Capability bit definitions for POWER9,
> POWER10, and POWER11 compatibility modes are also included.
> 
> The actual header sync will be done via scripts/update-linux-headers.sh
> once the kernel changes [1] are merged upstream.
> 
> [1] https://lore.kernel.org/all/20260808161148.66673-1-amachhiw@linux.ibm.com/
> 
> Tested-by: Gautam Menghani <gautam@linux.ibm.com>
> Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> No changes in this version.
> 
>  linux-headers/asm-powerpc/kvm.h | 19 +++++++++++++++++++
>  linux-headers/linux/kvm.h       |  3 +++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
> index 077c5437f521..2c229fe0562c 100644
> --- a/linux-headers/asm-powerpc/kvm.h
> +++ b/linux-headers/asm-powerpc/kvm.h
> @@ -437,6 +437,25 @@ struct kvm_ppc_cpu_char {
>  	__u64	behaviour_mask;		/* valid bits in behaviour */
>  };
>  
> +/* For KVM_PPC_GET_COMPAT_CAPS */
> +struct kvm_ppc_compat_caps {
> +	__u64	size;			/* Size of this structure */
> +	__u64	flags;			/* Reserved for future use */
> +	__u64	compat_capabilities;	/* Capabilities supported by the host */
> +};
> +#define KVM_PPC_COMPAT_CAPS_SIZE_VER0	24 /* sizeof first published struct */
> +
> +/*
> + * Capability bits for compat_capabilities field in kvm_ppc_compat_caps.
> + * These bits indicate which processor compatibility modes are supported.
> + */
> +#define KVM_PPC_COMPAT_CAP_POWER9	(1ULL << 62)
> +#define KVM_PPC_COMPAT_CAP_POWER10	(1ULL << 61)
> +#define KVM_PPC_COMPAT_CAP_POWER11	(1ULL << 60)
> +#define KVM_PPC_COMPAT_BITMASK		(KVM_PPC_COMPAT_CAP_POWER9 | \
> +					 KVM_PPC_COMPAT_CAP_POWER10 | \
> +					 KVM_PPC_COMPAT_CAP_POWER11)
> +
>  /*
>   * Values for character and character_mask.
>   * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index dd52e2a65bfd..aea4ab5c6953 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -986,6 +986,7 @@ struct kvm_enable_cap {
>  #define KVM_CAP_S390_KEYOP 247
>  #define KVM_CAP_S390_VSIE_ESAMODE 248
>  #define KVM_CAP_S390_HPAGE_2G 249
> +#define KVM_CAP_PPC_COMPAT_CAPS 250
>  
>  struct kvm_irq_routing_irqchip {
>  	__u32 irqchip;
> @@ -1330,6 +1331,8 @@ struct kvm_s390_keyop {
>  /* Available with KVM_CAP_COUNTER_OFFSET */
>  #define KVM_ARM_SET_COUNTER_OFFSET _IOW(KVMIO,  0xb5, struct kvm_arm_counter_offset)
>  #define KVM_ARM_GET_REG_WRITABLE_MASKS _IOR(KVMIO,  0xb6, struct reg_mask_range)
> +/* Available with KVM_CAP_PPC_COMPAT_CAPS */
> +#define KVM_PPC_GET_COMPAT_CAPS	_IO(KVMIO,  0xb8)
>  
>  /* ioctl for vm fd */
>  #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
> -- 
> 2.50.1 (Apple Git-155)
> 
> 

