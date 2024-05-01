Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA932C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 21:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2HAE-00065j-3n; Wed, 01 May 2024 17:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s2HAB-00065F-A6
 for qemu-devel@nongnu.org; Wed, 01 May 2024 17:06:51 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s2HA9-0004NE-7g
 for qemu-devel@nongnu.org; Wed, 01 May 2024 17:06:51 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 2BB15CE12A3;
 Wed,  1 May 2024 21:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121B8C072AA;
 Wed,  1 May 2024 21:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1714597605;
 bh=xKWmAR8bRUG3hI2S8/E9BMmyLRlDJp0dhBplSrRXHPs=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=B2AmvL80x1kupedRVlAr399URmuGcwn3cwpbwfyoUtVewfBPYmPJni0NCIjfAJcmd
 Py1e7coDbmDim3EQ24z0YS3iR/u0WHj2J/OwYw9MTV93ZmNF9RIqI9lL2nJQLkTHLf
 z1tKh29NeN8Pj2Q4swIjQ6Re68UkSXBwPptU6B2quqQ1+eRLNytsfaTc5WBapkGmEW
 1BpkMSCAYKCPnlti+/eu6KPCd+8EmiOura+0WhNbduzalZxgqYBxP2KHU/jNtt1t5H
 ka/XXZ85YcxpNqT3Zifd3SnrL7LfxvQvnhKIIDwKUpbKLerjSkYFsIs1tkl72YzKXF
 8El8bd6GxMr7A==
Date: Wed, 1 May 2024 14:06:40 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com, 
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v4 14/17] xen: Add xen_mr_is_memory()
In-Reply-To: <20240430164939.925307-15-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2405011405050.497719@ubuntu-linux-20-04-desktop>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
 <20240430164939.925307-15-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=sstabellini@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Tue, 30 Apr 2024, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Add xen_mr_is_memory() to abstract away tests for the
> xen_memory MR.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

There is an important change in this patch below


> ---
>  hw/xen/xen-hvm-common.c | 8 +++++++-
>  include/sysemu/xen.h    | 8 ++++++++
>  system/physmem.c        | 2 +-
>  3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
> index 1627da7398..0267b88d26 100644
> --- a/hw/xen/xen-hvm-common.c
> +++ b/hw/xen/xen-hvm-common.c
> @@ -12,6 +12,12 @@
>  
>  MemoryRegion xen_memory;
>  
> +/* Check for xen memory.  */
> +bool xen_mr_is_memory(MemoryRegion *mr)
> +{
> +    return mr == &xen_memory;
> +}
> +
>  void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
>                     Error **errp)
>  {
> @@ -28,7 +34,7 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
>          return;
>      }
>  
> -    if (mr == &xen_memory) {
> +    if (xen_mr_is_memory(mr)) {
>          return;
>      }
>  
> diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
> index 754ec2e6cb..dc72f83bcb 100644
> --- a/include/sysemu/xen.h
> +++ b/include/sysemu/xen.h
> @@ -34,6 +34,8 @@ void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
>  void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
>                     struct MemoryRegion *mr, Error **errp);
>  
> +bool xen_mr_is_memory(MemoryRegion *mr);
> +
>  #else /* !CONFIG_XEN_IS_POSSIBLE */
>  
>  #define xen_enabled() 0
> @@ -47,6 +49,12 @@ static inline void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
>      g_assert_not_reached();
>  }
>  
> +static inline bool xen_mr_is_memory(MemoryRegion *mr)
> +{
> +    g_assert_not_reached();
> +    return false;
> +}
> +
>  #endif /* CONFIG_XEN_IS_POSSIBLE */
>  
>  #endif
> diff --git a/system/physmem.c b/system/physmem.c
> index ad7a8c7d95..1a5ffcba2a 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2227,7 +2227,7 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
>           * because we don't want to map the entire memory in QEMU.
>           * In that case just map the requested area.
>           */
> -        if (block->offset == 0) {
> +        if (xen_mr_is_memory(block->mr)) {

This changes this check from block->offset == 0 to block->mr ==
&xen_memory. I think that's correct in all cases (x86 machines, ARM
machines) but I wanted to highlight it.

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>





>              return xen_map_cache(block->mr, addr, len, lock, lock,
>                                   is_write);
>          }
> -- 
> 2.40.1
> 

