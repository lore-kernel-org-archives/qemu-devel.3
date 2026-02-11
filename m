Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2BAECD6EE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 20:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqH7F-0007Q8-Dp; Wed, 11 Feb 2026 15:47:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vqH7D-0007Pq-Ps
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 15:47:15 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vqH7B-0006po-QV
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 15:47:15 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1770842816; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=n7jZOh9e9v9HUjuWfUUgvYN6SseDraTa5Vj18wXFRAJHLyX4APhq3X42NnYbX7TVn+r16k/n8NvjoTxe9TmVttvMkjGKnqsvYj3KxhqXP7iQitIF4zjbmnjAFkOP5sgkoR0sbjjzVBXdvWJ64+KBjb3gI/chapyCj+lZLsiF/eo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1770842816;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=lKKs+m3oFpg+Tc+P9igc4fgC+VRSznLaKnHFiXCttf8=; 
 b=gktIdjbl5eawZ1UV0WWFYmgzDmOPz4BsB5HWo2iKpGHsqCPraPpOSnqyHh9zzfpe2DSNYSLw47YlJeXhbwtCUeoyHix/T6HLBT0UvLimQmsVYQx1hricTGXkg1DN2+SuSEAHHbZdpyxabu74vduQYJ/hT1WX7yH7EDiAGOsMdDk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770842816; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=lKKs+m3oFpg+Tc+P9igc4fgC+VRSznLaKnHFiXCttf8=;
 b=EKj4MOViMPuuEQyWHJgfDFQmBh3QP407msPAtEd1i0/S07MbvYP9+3gyNOi0IPiC
 mtomYsYLyfkDAsj0jnzIgjvf3lK0s3IdG7bEaXL74siDH0GRpawafZJ8ZfS3eHkHEoh
 UivmjFOqM4ohlhe64OdtD7doq0q0kdze6jCeNC80=
Received: by mx.zohomail.com with SMTPS id 1770842815536202.6959493672615;
 Wed, 11 Feb 2026 12:46:55 -0800 (PST)
Message-ID: <4eb93d7a-1fa9-4b3c-8ad7-a2eb64f025a0@collabora.com>
Date: Wed, 11 Feb 2026 23:46:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 41/51] virtio-gpu-virgl: correct parent for blob memory
 region
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Joelle van Dyne <j@getutm.app>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <cover.1770231744.git.mst@redhat.com>
 <81cb15cf3774140da7c17341018a3852f920acb5.1770231744.git.mst@redhat.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <81cb15cf3774140da7c17341018a3852f920acb5.1770231744.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/4/26 22:04, Michael S. Tsirkin wrote:
> From: Joelle van Dyne <j@getutm.app>
> 
> When `owner` == `mr`, `object_unparent` will crash:
> 
> object_unparent(mr) ->
> object_property_del_child(mr, mr) ->
> object_finalize_child_property(mr, name, mr) ->
> object_unref(mr) ->
> object_finalize(mr) ->
> object_property_del_all(mr) ->
> object_finalize_child_property(mr, name, mr) ->
> object_unref(mr) ->
> fail on g_assert(obj->ref > 0)
> 
> However, passing a different `owner` to `memory_region_init` does not
> work. `memory_region_ref` has an optimization where it takes a ref
> only on the owner. That means when flatviews are created, it does not
> take a ref on the region and you can get a UAF from `flatview_destroy`
> called from RCU.
> 
> The correct fix therefore is to use `NULL` as the name which will set
> the `owner` but not the `parent` (which is still NULL). This allows us
> to use `memory_region_ref` on itself while not having to rely on unparent
> for cleanup.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Message-Id: <20260103214400.71694-1-j@getutm.app>
> ---
>  hw/display/virtio-gpu-virgl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 07f6355ad6..6a83fb63c8 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -120,7 +120,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>      vmr->g = g;
>  
>      mr = &vmr->mr;
> -    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
> +    memory_region_init_ram_ptr(mr, OBJECT(mr), NULL, size, data);
>      memory_region_add_subregion(&b->hostmem, offset, mr);
>      memory_region_set_enabled(mr, true);
>  
> @@ -186,7 +186,7 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
>          /* memory region owns self res->mr object and frees it by itself */
>          memory_region_set_enabled(mr, false);
>          memory_region_del_subregion(&b->hostmem, mr);
> -        object_unparent(OBJECT(mr));
> +        object_unref(OBJECT(mr));
>      }
>  
>      return 0;

Hello Michael,

This patch introduces regression. Running any venus application results
in a crash:

Thread 2 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
(gdb) bt
#0  0x00007ffff56565e2 in __strcmp_evex () at /lib64/libc.so.6
#1  0x0000555555841bdb in find_fd (head=0x5555572337d0 <cpr_state>,
name=0x0, id=0) at ../migration/cpr.c:68
#2  cpr_delete_fd (name=name@entry=0x0, id=id@entry=0) at
../migration/cpr.c:77
#3  0x000055555582290a in qemu_ram_free (block=0x7ff7e93aa7f0) at
../system/physmem.c:2615
#4  0x000055555581ae02 in memory_region_finalize (obj=<optimized out>)
at ../system/memory.c:1816
#5  0x0000555555a70ab9 in object_deinit (obj=<optimized out>,
type=<optimized out>) at ../qom/object.c:715
#6  object_finalize (data=0x7ff7e936eff0) at ../qom/object.c:729
#7  object_unref (objptr=0x7ff7e936eff0) at ../qom/object.c:1232
#8  0x0000555555814fae in memory_region_unref (mr=<optimized out>) at
../system/memory.c:1848
#9  flatview_destroy (view=0x555559ed6c40) at ../system/memory.c:301
#10 0x0000555555bfc122 in call_rcu_thread (opaque=<optimized out>) at
../util/rcu.c:324
#11 0x0000555555bf17a7 in qemu_thread_start (args=0x555557b99520) at
../util/qemu-thread-posix.c:393
#12 0x00007ffff556f464 in start_thread () at /lib64/libc.so.6
#13 0x00007ffff55f25ac in __clone3 () at /lib64/libc.so.6

There is a v2 version of this patch that doesn't crash [1]. Was v1
applied by mistake instead of v2?

[1] https://lore.kernel.org/qemu-devel/20251223184023.1913-1-j@getutm.app/

-- 
Best regards,
Dmitry

