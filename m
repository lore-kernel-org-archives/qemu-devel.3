Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB31CCD193
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 17:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8iOU-0003EP-0M; Tue, 14 Oct 2025 13:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v8iON-0003Dg-DC
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 13:00:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v8iOK-0004v6-2i
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 13:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760461247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nxDkPntV5OLXd8NROvyjYRRdUaTdnggzBCf5Crj4Ya8=;
 b=QzfB38Grw0h69AG5iUarIWXm8KONWkoudsosoey1VBbAUBw67g5I3kCv5CpkGkPaS6FCNe
 WyIgiKT9N9XXRpgvz4lOhedJKGL/msTnYUGeKSDUIfAcEgnD7+Yo7neO4KfprlNS9e5HGm
 OpYs5KO0onA39amg5JJqjihgoPpF8EM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-wzKaB_9oMDSiwoTVCQPCPQ-1; Tue, 14 Oct 2025 13:00:46 -0400
X-MC-Unique: wzKaB_9oMDSiwoTVCQPCPQ-1
X-Mimecast-MFC-AGG-ID: wzKaB_9oMDSiwoTVCQPCPQ_1760461245
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-85641d6f913so3037595585a.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 10:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760461245; x=1761066045;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nxDkPntV5OLXd8NROvyjYRRdUaTdnggzBCf5Crj4Ya8=;
 b=ZzUct5DQdsriWJW4FqS9qy/IJ/+6dibcGhMOXbi8ivZAZ5Ce/RIZKmcqcFN/ylDXMl
 /BHFfjB7QKs4NEfnJUU6VCt70U98N2VczumOmMmKcbiCYvS5SCyvr1lvrWkO/Udi/78R
 KvLkln/2oycGmCCt/B2FpBUWdXGep20ucU2BUX2byUTBxi7RsdosKBGmR1wWTg2KEQXr
 Pdl3+JczuYOu2/xc2uci/XEXW5c20Q1DFkF41FAcd8p+MEg7HuwfUD4pasn4kVVpweim
 i9atTtju5Cpo4bACCJYKXOUnv9W7BOj3QeEG2LMVTTjiAj+mCQ23XPmv4DCYW1ebq+E9
 404g==
X-Gm-Message-State: AOJu0YyduQeqVaWbpELJ6GqF2EuyKIsNKW5WkPa9erG4McKLUpKmhHEJ
 Dd9qlOsA0UMCZS6+Im1sqUAqZNTWWExZYaYYLT+DB+vbHPgDHJ5FEjrM8wRBYokkruNf3K7Bqlb
 9iNIcNxBSPvpcKqldiMHXyjpu+XonQbJ80vnrc5z5FvBVnCg50uHtHsbF
X-Gm-Gg: ASbGncsOWsNZzmywvz5QyOKvustirxZcHDfzdK++hyxnj0Y+CpASAviRk60kcA7uKU/
 Z6KK7bYTiJM/Bi17bYqb1UIb4OKIYQ4wCrp6lmL9R5CSmJclLtddgzrplI9IKQv4yW4twCVQNfc
 4+gcexW6zVetJXRUFC2D342a6rrh43O0LGNPdITBO1XnFg7g0IouiepVkqu+gVu1oyEdYw+Qv/D
 qs/MA2J/15nLRzPHiacK7guCnUeFjb59+evZdtMo+UTdCFj6f5wLMrr5GxBRgwt5y8/hdrds6f1
 Pa06HqmxfR8z3PgcH7jGWGSxIEWaUo9b
X-Received: by 2002:a05:620a:c42:b0:864:e52f:311f with SMTP id
 af79cd13be357-8834ff8e275mr3862990685a.6.1760461244843; 
 Tue, 14 Oct 2025 10:00:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPhsYkd0C/QTTJJBKr8fo3Bz+RCmzzQiW8CcpsXiGg5tERZO3y+OdaYFFnMzPf1stNKNRQ+g==
X-Received: by 2002:a05:620a:c42:b0:864:e52f:311f with SMTP id
 af79cd13be357-8834ff8e275mr3862975585a.6.1760461243763; 
 Tue, 14 Oct 2025 10:00:43 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e881c8cecfsm2384461cf.19.2025.10.14.10.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 10:00:43 -0700 (PDT)
Date: Tue, 14 Oct 2025 13:00:39 -0400
From: Peter Xu <peterx@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH 5/8] hw/display: re-arrange memory region tracking
Message-ID: <aO6Btwg4vo2vZRnY@x1.local>
References: <20251014111234.3190346-1-alex.bennee@linaro.org>
 <20251014111234.3190346-6-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251014111234.3190346-6-alex.bennee@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 14, 2025 at 12:12:31PM +0100, Alex Bennée wrote:
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
> ---
>  include/system/memory.h       |  1 +
>  hw/display/virtio-gpu-virgl.c | 23 ++++++++---------------
>  2 files changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/include/system/memory.h b/include/system/memory.h
> index 3bd5ffa5e0d..3349a5185a0 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -843,6 +843,7 @@ struct MemoryRegion {
>      DeviceState *dev;
>  
>      const MemoryRegionOps *ops;
> +    /* opaque data, used by backends like @ops */

IMHO this comment isn't very helpful..  Maybe it should provide a list of
things that are using the opaque, in this case memory_region_init_ram_ptr
is the new addition.

Having memory_region_init() directly taking opaque as a parameter would be
nice but it might be an overkill indeed..  Still, there's option to at
least start to have opaque passed into memory_region_init_ram_ptr() so
people when reading memory.c will also know when opaque is used.  Otherwise
it can easily break virtio-gpu if someone decides to reuse opaque for the
API, without noticing it's used in virtio-gpu (like the ->free use..).

No strong feelings, but if anyone agrees it could be at least something to
be considered to be worked on top.

Thanks,

>      void *opaque;
>      MemoryRegion *container;
>      int mapped_via_alias; /* Mapped via an alias, container might be NULL */
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 07f6355ad62..0ef0b2743fe 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -52,17 +52,11 @@ virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
>  
>  #if VIRGL_VERSION_MAJOR >= 1
>  struct virtio_gpu_virgl_hostmem_region {
> -    MemoryRegion mr;
> +    MemoryRegion *mr;
>      struct VirtIOGPU *g;
>      bool finish_unmapping;
>  };
>  
> -static struct virtio_gpu_virgl_hostmem_region *
> -to_hostmem_region(MemoryRegion *mr)
> -{
> -    return container_of(mr, struct virtio_gpu_virgl_hostmem_region, mr);
> -}
> -
>  static void virtio_gpu_virgl_resume_cmdq_bh(void *opaque)
>  {
>      VirtIOGPU *g = opaque;
> @@ -73,14 +67,12 @@ static void virtio_gpu_virgl_resume_cmdq_bh(void *opaque)
>  static void virtio_gpu_virgl_hostmem_region_free(void *obj)
>  {
>      MemoryRegion *mr = MEMORY_REGION(obj);
> -    struct virtio_gpu_virgl_hostmem_region *vmr;
> +    struct virtio_gpu_virgl_hostmem_region *vmr = mr->opaque;
>      VirtIOGPUBase *b;
>      VirtIOGPUGL *gl;
>  
> -    vmr = to_hostmem_region(mr);
> -    vmr->finish_unmapping = true;
> -
>      b = VIRTIO_GPU_BASE(vmr->g);
> +    vmr->finish_unmapping = true;
>      b->renderer_blocked--;
>  
>      /*
> @@ -118,8 +110,8 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>  
>      vmr = g_new0(struct virtio_gpu_virgl_hostmem_region, 1);
>      vmr->g = g;
> +    mr = g_new0(MemoryRegion, 1);
>  
> -    mr = &vmr->mr;
>      memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
>      memory_region_add_subregion(&b->hostmem, offset, mr);
>      memory_region_set_enabled(mr, true);
> @@ -131,7 +123,9 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>       * command processing until MR is fully unreferenced and freed.
>       */
>      OBJECT(mr)->free = virtio_gpu_virgl_hostmem_region_free;
> +    mr->opaque = vmr;
>  
> +    vmr->mr = mr;
>      res->mr = mr;
>  
>      trace_virtio_gpu_cmd_res_map_blob(res->base.resource_id, vmr, mr);
> @@ -144,16 +138,15 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
>                                       struct virtio_gpu_virgl_resource *res,
>                                       bool *cmd_suspended)
>  {
> -    struct virtio_gpu_virgl_hostmem_region *vmr;
>      VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
>      MemoryRegion *mr = res->mr;
> +    struct virtio_gpu_virgl_hostmem_region *vmr;
>      int ret;
>  
>      if (!mr) {
>          return 0;
>      }
> -
> -    vmr = to_hostmem_region(res->mr);
> +    vmr = mr->opaque;
>  
>      trace_virtio_gpu_cmd_res_unmap_blob(res->base.resource_id, mr, vmr->finish_unmapping);
>  
> -- 
> 2.47.3
> 

-- 
Peter Xu


