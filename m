Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4372FC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 01:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSRvD-00017b-Ll; Tue, 23 Jan 2024 20:19:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1rSRvA-00011A-A0
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 20:19:17 -0500
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1rSRv7-0002VR-CB
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 20:19:15 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 0BCADCE2FED;
 Wed, 24 Jan 2024 01:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F879C433F1;
 Wed, 24 Jan 2024 01:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706059149;
 bh=xI9QkHcCotyomOjIkiFDcV0CgjT/jadobMJ6uOqT+z4=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=VWi/B60bSgT8d+xlNibrY+ZlcSMlXnFkOsPMO2pb78lcWGxVZkrI3hq51TaCnck13
 xSSCTfR2q60z9A031tlJZKL5XX7/LOOZKn7WuughmGxhS4MYgK7d3gd4GJLRMAZaFI
 DGuVkD7lRl0TGwytzrb7Cen81lkSgjAdrne+EykfVTKwF0+KzKM3tk5kmAYZRiyUf7
 F96/XxnvkvtcYjXqPGBpMtGLLW+qS+M7Zino3aYXwpcip17eNKbUHF+VBDXBXRfCIV
 T4SWqGjNYzv5hv+2DlGeLlssrLEnui4steaFn9rl/lRRvqD6xlrPMlV7eNDNUE2MrQ
 t1cOGOYgsyH/w==
Date: Tue, 23 Jan 2024 17:19:07 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
cc: sstabellini@kernel.org, anthony.perard@citrix.com, paul@xen.org, 
 vikram.garhwal@amd.com, viresh.kumar@linaro.org, 
 xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, 
 Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] xen: Drop out of coroutine context
 xen_invalidate_map_cache_entry
In-Reply-To: <20240124021450.21656-1-peng.fan@oss.nxp.com>
Message-ID: <alpine.DEB.2.22.394.2401231718590.2287888@ubuntu-linux-20-04-desktop>
References: <20240124021450.21656-1-peng.fan@oss.nxp.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=sstabellini@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 24 Jan 2024, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> xen_invalidate_map_cache_entry is not expected to run in a
> coroutine. Without this, there is crash:
> 
>     signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
>     threadid=<optimized out>) at pthread_kill.c:78
>     at /usr/src/debug/glibc/2.38+git-r0/sysdeps/posix/raise.c:26
>     fmt=0xffff9e1ca8a8 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n",
>     assertion=assertion@entry=0xaaaae0d25740 "!qemu_in_coroutine()",
>     file=file@entry=0xaaaae0d301a8 "../qemu-xen-dir-remote/block/graph-lock.c", line=line@entry=260,
>     function=function@entry=0xaaaae0e522c0 <__PRETTY_FUNCTION__.3> "bdrv_graph_rdlock_main_loop") at assert.c:92
>     assertion=assertion@entry=0xaaaae0d25740 "!qemu_in_coroutine()",
>     file=file@entry=0xaaaae0d301a8 "../qemu-xen-dir-remote/block/graph-lock.c", line=line@entry=260,
>     function=function@entry=0xaaaae0e522c0 <__PRETTY_FUNCTION__.3> "bdrv_graph_rdlock_main_loop") at assert.c:101
>     at ../qemu-xen-dir-remote/block/graph-lock.c:260
>     at /home/Freenix/work/sw-stash/xen/upstream/tools/qemu-xen-dir-remote/include/block/graph-lock.h:259
>     host=host@entry=0xffff742c8000, size=size@entry=2097152)
>     at ../qemu-xen-dir-remote/block/io.c:3362
>     host=0xffff742c8000, size=2097152)
>     at ../qemu-xen-dir-remote/block/block-backend.c:2859
>     host=<optimized out>, size=<optimized out>, max_size=<optimized out>)
>     at ../qemu-xen-dir-remote/block/block-ram-registrar.c:33
>     size=2097152, max_size=2097152)
>     at ../qemu-xen-dir-remote/hw/core/numa.c:883
>     buffer=buffer@entry=0xffff743c5000 "")
>     at ../qemu-xen-dir-remote/hw/xen/xen-mapcache.c:475
>     buffer=buffer@entry=0xffff743c5000 "")
>     at ../qemu-xen-dir-remote/hw/xen/xen-mapcache.c:487
>     as=as@entry=0xaaaae1ca3ae8 <address_space_memory>, buffer=0xffff743c5000,
>     len=<optimized out>, is_write=is_write@entry=true,
>     access_len=access_len@entry=32768)
>     at ../qemu-xen-dir-remote/system/physmem.c:3199
>     dir=DMA_DIRECTION_FROM_DEVICE, len=<optimized out>,
>     buffer=<optimized out>, as=0xaaaae1ca3ae8 <address_space_memory>)
>     at /home/Freenix/work/sw-stash/xen/upstream/tools/qemu-xen-dir-remote/include/sysemu/dma.h:236
>     elem=elem@entry=0xaaaaf620aa30, len=len@entry=32769)
>     at ../qemu-xen-dir-remote/hw/virtio/virtio.c:758
>     elem=elem@entry=0xaaaaf620aa30, len=len@entry=32769, idx=idx@entry=0)
>     at ../qemu-xen-dir-remote/hw/virtio/virtio.c:919
>     elem=elem@entry=0xaaaaf620aa30, len=32769)
>     at ../qemu-xen-dir-remote/hw/virtio/virtio.c:994
>     req=req@entry=0xaaaaf620aa30, status=status@entry=0 '\000')
>     at ../qemu-xen-dir-remote/hw/block/virtio-blk.c:67
>     ret=0) at ../qemu-xen-dir-remote/hw/block/virtio-blk.c:136
>     at ../qemu-xen-dir-remote/block/block-backend.c:1559
> --Type <RET> for more, q to quit, c to continue without paging--
>     at ../qemu-xen-dir-remote/block/block-backend.c:1614
>     i1=<optimized out>) at ../qemu-xen-dir-remote/util/coroutine-ucontext.c:177
>     at ../sysdeps/unix/sysv/linux/aarch64/setcontext.S:123
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> 
> V2:
>  Drop unused ret in XenMapCacheData (thanks Stefano)
> 
>  hw/xen/xen-mapcache.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> index f7d974677d..8d62b3d2ed 100644
> --- a/hw/xen/xen-mapcache.c
> +++ b/hw/xen/xen-mapcache.c
> @@ -481,11 +481,37 @@ static void xen_invalidate_map_cache_entry_unlocked(uint8_t *buffer)
>      g_free(entry);
>  }
>  
> -void xen_invalidate_map_cache_entry(uint8_t *buffer)
> +typedef struct XenMapCacheData {
> +    Coroutine *co;
> +    uint8_t *buffer;
> +} XenMapCacheData;
> +
> +static void xen_invalidate_map_cache_entry_bh(void *opaque)
>  {
> +    XenMapCacheData *data = opaque;
> +
>      mapcache_lock();
> -    xen_invalidate_map_cache_entry_unlocked(buffer);
> +    xen_invalidate_map_cache_entry_unlocked(data->buffer);
>      mapcache_unlock();
> +
> +    aio_co_wake(data->co);
> +}
> +
> +void coroutine_mixed_fn xen_invalidate_map_cache_entry(uint8_t *buffer)
> +{
> +    if (qemu_in_coroutine()) {
> +        XenMapCacheData data = {
> +            .co = qemu_coroutine_self(),
> +            .buffer = buffer,
> +        };
> +        aio_bh_schedule_oneshot(qemu_get_current_aio_context(),
> +                                xen_invalidate_map_cache_entry_bh, &data);
> +        qemu_coroutine_yield();
> +    } else {
> +        mapcache_lock();
> +        xen_invalidate_map_cache_entry_unlocked(buffer);
> +        mapcache_unlock();
> +    }
>  }
>  
>  void xen_invalidate_map_cache(void)
> -- 
> 2.35.3
> 

