Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C90C5B555
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 05:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNPT2-0006Gz-UU; Fri, 06 Jun 2025 01:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uNPSw-0006GY-96; Fri, 06 Jun 2025 01:18:07 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uNPSs-00022d-LI; Fri, 06 Jun 2025 01:18:06 -0400
Received: from [10.100.116.185] ([157.82.128.1]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5565HfOQ049590
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 6 Jun 2025 14:17:41 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=19c+6VnYku6N+rvawX3+k50mOTzZsXpibedpOmLFBvE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1749187061; v=1;
 b=NzaAUjFFnvP7/ESfVWbz0jXKlxllNPksvKQpbu1JDavD2M04hKZ3K66gfCtkfZW1
 cpaw4OaYgA1dSwa8jqhKkLL5QbV6EBlyuyfoPcfaLHXunRNy+S5AEdh5emB1xtip
 6ACCE40uKIMOAT5nOqnVOqMPEAgjrbcqEeXQJ29kNUJhlQN1aFC37d6T/u0UjcuW
 WnloOPW+9ovRIMYFZ6NWYp+pfimPBcMXSEajw5kvS0qKmi47snpVHPc6T7i6Ezk9
 jWDun+QdJBWscTfwdMOR253W95h8tsaWqcy4ap8j7Ys/qrRsUBjvMYh3kWWamVtK
 RdxbiGnCahwNlQYWLNPCww==
Message-ID: <ee5115ab-b818-4746-8806-5056f3570011@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 6 Jun 2025 14:17:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 09/17] hw/display: re-arrange memory region tracking
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
 <20250605162651.2614401-10-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250605162651.2614401-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/06/06 1:26, Alex Bennée wrote:
> QOM objects can be embedded in other QOM objects and managed as part
> of their lifetime but this isn't the case for
> virtio_gpu_virgl_hostmem_region. However before we can split it out we
> need some other way of associating the wider data structure with the
> memory region.
> 
> Fortunately MemoryRegion has an opaque pointer. This is passed down to
> MemoryRegionOps for device type regions but is unused in the
> memory_region_init_ram_ptr() case. Use the opaque to carry the
> reference and allow the final MemoryRegion object to be reaped when
> its reference count is cleared.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-Id: <20250410122643.1747913-2-manos.pitsidianakis@linaro.org>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-ID: <20250603110204.838117-10-alex.bennee@linaro.org>

I have told you that you should address all comments before sending a 
series again a few times[1][2], but you haven't done that.

For this patch, I raised a concern with [3]:

I pointed out it has no effect (fixing or improving something) other 
than adding a memory allocation, but you didn't make a reply to prove 
otherwise.

I also pointed out it leaks memory and you asked for a test case[4], but 
you made this pull request without giving me 24 hours to reply to it.

The situation of "[PULL 03/17] tests/tcg: make aarch64 boot.S handle 
different starting modes" is also similar. I added a comment about 
symbol naming and you gave a reasoning, but I didn't get time to review 
it either[5]. Besides, I also had a suggestion to make the code shorter 
for the past version, but it is also dismissed.

I also pointed out "[PULL 11/17] ui/gtk-gl-area: Remove extra draw call 
in refresh" has an undressed comment[2][7].

I would like to see improvements in how comments are addressed before a 
series is resent.

Regards,
Akihiko Odaki

[1] 
https://lore.kernel.org/qemu-devel/e6af12bd-1c36-4e50-8bae-d8d80cad13a0@daynix.com
[2] 
https://lore.kernel.org/qemu-devel/e037e38c-dd8d-4f65-b2d5-2629be5f6740@daynix.com
[3] 
https://lore.kernel.org/qemu-devel/1a86b86d-145a-44fc-9f87-2804767fb109@daynix.com/
[4] https://lore.kernel.org/qemu-devel/87o6v2764e.fsf@draig.linaro.org/
[5] https://lore.kernel.org/qemu-devel/874iwu372j.fsf@draig.linaro.org/
[6] 
https://lore.kernel.org/qemu-devel/7a76e746-9022-48cf-8216-775071e6d631@daynix.com/
[7] 
https://lore.kernel.org/qemu-devel/63911dcc-482b-45c5-9468-120ae3df691b@daynix.com/

> 
> diff --git a/include/system/memory.h b/include/system/memory.h
> index fc35a0dcad..90715ff44a 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -784,6 +784,7 @@ struct MemoryRegion {
>       DeviceState *dev;
>   
>       const MemoryRegionOps *ops;
> +    /* opaque data, used by backends like @ops */
>       void *opaque;
>       MemoryRegion *container;
>       int mapped_via_alias; /* Mapped via an alias, container might be NULL */
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 145a0b3879..71a7500de9 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -52,17 +52,11 @@ virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
>   
>   #if VIRGL_VERSION_MAJOR >= 1
>   struct virtio_gpu_virgl_hostmem_region {
> -    MemoryRegion mr;
> +    MemoryRegion *mr;
>       struct VirtIOGPU *g;
>       bool finish_unmapping;
>   };
>   
> -static struct virtio_gpu_virgl_hostmem_region *
> -to_hostmem_region(MemoryRegion *mr)
> -{
> -    return container_of(mr, struct virtio_gpu_virgl_hostmem_region, mr);
> -}
> -
>   static void virtio_gpu_virgl_resume_cmdq_bh(void *opaque)
>   {
>       VirtIOGPU *g = opaque;
> @@ -73,14 +67,12 @@ static void virtio_gpu_virgl_resume_cmdq_bh(void *opaque)
>   static void virtio_gpu_virgl_hostmem_region_free(void *obj)
>   {
>       MemoryRegion *mr = MEMORY_REGION(obj);
> -    struct virtio_gpu_virgl_hostmem_region *vmr;
> +    struct virtio_gpu_virgl_hostmem_region *vmr = mr->opaque;
>       VirtIOGPUBase *b;
>       VirtIOGPUGL *gl;
>   
> -    vmr = to_hostmem_region(mr);
> -    vmr->finish_unmapping = true;
> -
>       b = VIRTIO_GPU_BASE(vmr->g);
> +    vmr->finish_unmapping = true;
>       b->renderer_blocked--;
>   
>       /*
> @@ -118,8 +110,8 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>   
>       vmr = g_new0(struct virtio_gpu_virgl_hostmem_region, 1);
>       vmr->g = g;
> +    mr = g_new0(MemoryRegion, 1);
>   
> -    mr = &vmr->mr;
>       memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
>       memory_region_add_subregion(&b->hostmem, offset, mr);
>       memory_region_set_enabled(mr, true);
> @@ -131,7 +123,9 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>        * command processing until MR is fully unreferenced and freed.
>        */
>       OBJECT(mr)->free = virtio_gpu_virgl_hostmem_region_free;
> +    mr->opaque = vmr;
>   
> +    vmr->mr = mr;
>       res->mr = mr;
>   
>       return 0;
> @@ -142,16 +136,15 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
>                                        struct virtio_gpu_virgl_resource *res,
>                                        bool *cmd_suspended)
>   {
> -    struct virtio_gpu_virgl_hostmem_region *vmr;
>       VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
>       MemoryRegion *mr = res->mr;
> +    struct virtio_gpu_virgl_hostmem_region *vmr;
>       int ret;
>   
>       if (!mr) {
>           return 0;
>       }
> -
> -    vmr = to_hostmem_region(res->mr);
> +    vmr = mr->opaque;
>   
>       /*
>        * Perform async unmapping in 3 steps:


