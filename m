Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E67EFCE4D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 00:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxwFY-0006Pl-7B; Wed, 04 Mar 2026 19:07:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1vxwFW-0006P4-7O
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 19:07:30 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1vxwFU-00014N-Cm
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 19:07:29 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1340040C29;
 Thu,  5 Mar 2026 00:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D85C4CEF7;
 Thu,  5 Mar 2026 00:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772669245;
 bh=pjv0XFNJ1B5r1groVKrNX4KoO8JMgModOOta/p4M1fk=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=DHStb9EIea9qnBsSQExLEgGK0/h6CsKUQmdcrfXkCl+xgD/o7EBY3m7YaEajxoWns
 dpxGvfQcu9QQW2UXdlQ3fWgPZcrnNYCHwO6B/MD3Z7M6JH1Cm/2/dD6ZajsdckseMS
 jLGgjaSCFFJhk/MVNfPX9vxIz2Lu6xE4qEDcfp5S9SoEz/6cvj6K3bbPrJL5HTvkBx
 ELZUM/JOZ2IL76JOBFGINI+6dM30VwkVWTR0tV9Ml81+PqDzAo01J9MWIYlNYk0EBQ
 6QZR+447fwE/yG9xqR5sPAVs+A/ku8ItYvAXKDt//aBMqDqpUqXY6B/EIu1+mOxM5i
 7P2g3Hbo+LsIw==
Date: Wed, 4 Mar 2026 16:07:23 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@amd.com, 
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v1 3/5] physmem: xen: Conditionalize use of the
 mapcache
In-Reply-To: <20260304015222.979224-4-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2603041606480.250016@ubuntu-linux-20-04-desktop>
References: <20260304015222.979224-1-edgar.iglesias@gmail.com>
 <20260304015222.979224-4-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=sstabellini@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 4 Mar 2026, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Conditionalize use of the mapcache. This is in preparation
> to optionally disable the mapcache at runtime.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> ---
>  system/physmem.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index e5ff26acec..64e6d50f8f 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -578,7 +578,8 @@ MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
>                                      is_write, true, &as, attrs);
>      mr = section.mr;
>  
> -    if (xen_enabled() && memory_access_is_direct(mr, is_write, attrs)) {
> +    if (xen_map_cache_enabled() &&
> +        memory_access_is_direct(mr, is_write, attrs)) {
>          hwaddr page = ((addr & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE) - addr;
>          *plen = MIN(page, *plen);
>      }

All the other changes make sense. For this one, the code inside the if
check is not strictly related to the mapcache. Are you sure it should be
changed?


> @@ -2577,7 +2578,7 @@ static void reclaim_ramblock(RAMBlock *block)
>  {
>      if (block->flags & RAM_PREALLOC) {
>          ;
> -    } else if (xen_enabled()) {
> +    } else if (xen_map_cache_enabled()) {
>          xen_invalidate_map_cache_entry(block->host);
>  #if !defined(_WIN32) && !defined(EMSCRIPTEN)
>      } else if (block->fd >= 0) {
> @@ -2736,7 +2737,7 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
>          len = *size;
>      }
>  
> -    if (xen_enabled() && block->host == NULL) {
> +    if (xen_map_cache_enabled() && block->host == NULL) {
>          /* We need to check if the requested address is in the RAM
>           * because we don't want to map the entire memory in QEMU.
>           * In that case just map the requested area.
> @@ -2785,7 +2786,7 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
>      RAMBlock *block;
>      uint8_t *host = ptr;
>  
> -    if (xen_enabled()) {
> +    if (xen_map_cache_enabled()) {
>          ram_addr_t ram_addr;
>          RCU_READ_LOCK_GUARD();
>          ram_addr = xen_ram_addr_from_mapcache(ptr);
> @@ -3787,7 +3788,7 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
>          if (is_write) {
>              invalidate_and_set_dirty(mr, addr1, access_len);
>          }
> -        if (xen_enabled()) {
> +        if (xen_map_cache_enabled()) {
>              xen_invalidate_map_cache_entry(buffer);
>          }
>          memory_region_unref(mr);
> @@ -3898,7 +3899,7 @@ void address_space_cache_destroy(MemoryRegionCache *cache)
>          return;
>      }
>  
> -    if (xen_enabled()) {
> +    if (xen_map_cache_enabled()) {
>          xen_invalidate_map_cache_entry(cache->ptr);
>      }
>      memory_region_unref(cache->mrs.mr);
> -- 
> 2.43.0
> 

