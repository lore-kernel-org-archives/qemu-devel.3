Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FF3C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 13:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0KJG-00020k-2g; Thu, 03 Apr 2025 09:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u0KJE-00020Z-IZ
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 09:08:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u0KJC-0005hD-SO
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 09:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743685717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=upDC7/LAdR6pykI/jCf6NqHXoYAXv10XX7M46M6US/M=;
 b=dc2LrocATDTQpDHfTKxwnVWKw9dVsBnoEVAMspGa445r61re4SaFEeyQbydfssqlh4RtJX
 zrtQ4XsKwjloL8sqvKIZjhsEbFsxL/yGATO8cyci7IOehytIqamiYV1EdG7Ixhp87z4B9Z
 aIICcJ03EhwBIWtLToR3+BC+6SVODyw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-2enqyza6PqKTbK3jhX_LBA-1; Thu, 03 Apr 2025 09:08:34 -0400
X-MC-Unique: 2enqyza6PqKTbK3jhX_LBA-1
X-Mimecast-MFC-AGG-ID: 2enqyza6PqKTbK3jhX_LBA_1743685713
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39ac9b0cb6aso706467f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 06:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743685713; x=1744290513;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=upDC7/LAdR6pykI/jCf6NqHXoYAXv10XX7M46M6US/M=;
 b=bqCcWNt8JGmWjU3Nykv6UC85oACy3Oma7YoL0Fc5Vtmi0SSqB3bV/eAHoIWozhoHDh
 LqNsYo80unM1IEqutZCmDUnDa+Fn8YR8JedwWg+xL+YlYLmgBUlsvTJDXlDgh5HMEFPN
 C2pEvTMbrj1HfuqUC34Go6q+BYyniZkV7P/LOjY3iy8vo6R6jC2my29jGT+AFMsGjWo1
 jxG8A5lDyQGFmKmEnWxfN6CLWUEfOlWq1J2caXmvOBljOvsyoHrAsDTorF9nHBWLBehI
 RNW8lZ1K9Mz+FsPdHPUvR11pSvnfi/6UoFQootC3zfUtG/SjlP5YEt2Q5jCHxxofFHLA
 7zCg==
X-Gm-Message-State: AOJu0YyrEMcnUzpzhg3TBz+Ivie5QPepqCuwr7WdSLgrz42ke4J7smHA
 LS/H7kIbHelc5/z38d/ZnatL/SB4Zo0amaBIBd2x/VlpqIb/xUrdtHG9tmpq9zdDosniF4T8EXQ
 hNmscDKk32xXe/q0zlOOoGb1VsFpXkOrQ29fQboNs5lslyL7Bf3Qo
X-Gm-Gg: ASbGncvaKgqufWVq2M89rR0vXS5+AW1c/mrbVp82xyo0YABPzOkS8uUuWMUl5S0IwCL
 tm0Axxez153CzoDaDl8iuWC9OxyC6VjaFGxVzxOndHtRQSoRj4jJ8SHp8dW9kzk6CjkDyHxKmOK
 KkpJefITFTA3FgncE/kTGlmntBZfP8ayQEtnpEbgDgoU73daW6a/rAr16D/d+T9upn/Bc8eVxc/
 XbmNwF8GHUOt7dk1db+jNM8mxfFGiMvbzxtWgjEx2nq9MKJn49NGSOfZN26E2oFCpcnzsD6BbkT
 VdXmj5KpyQ==
X-Received: by 2002:a05:6000:b0b:b0:391:4052:a232 with SMTP id
 ffacd0b85a97d-39c29807423mr4820731f8f.55.1743685713090; 
 Thu, 03 Apr 2025 06:08:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG90/48vI3pxUJLejbDw2IqlEZ7GhBuiHPfncRy0VX0DMzxle5/CAa8aYBRjhyp9JxmcUCFlg==
X-Received: by 2002:a05:6000:b0b:b0:391:4052:a232 with SMTP id
 ffacd0b85a97d-39c29807423mr4820701f8f.55.1743685712614; 
 Thu, 03 Apr 2025 06:08:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a6a60sm1718055f8f.29.2025.04.03.06.08.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 06:08:31 -0700 (PDT)
Date: Thu, 3 Apr 2025 09:08:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v1 1/2] virtio-gpu: fix hang under TCG when unmapping blob
Message-ID: <20250403090717-mutt-send-email-mst@kernel.org>
References: <20250403121704.2754589-1-manos.pitsidianakis@linaro.org>
 <20250403121704.2754589-2-manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250403121704.2754589-2-manos.pitsidianakis@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 03, 2025 at 03:17:01PM +0300, Manos Pitsidianakis wrote:
> This commit fixes an indefinite hang when using VIRTIO GPU blob objects
> under TCG in certain conditions.
> 
> The VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB VIRTIO command creates a
> MemoryRegion and attaches it to an offset on a PCI BAR of the
> VirtIOGPUdevice. The VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB command unmaps
> it.
> 
> Because virglrenderer commands are not thread-safe they are only
> called on the main context and QEMU performs the cleanup in three steps
> to prevent a use-after-free scenario where the guest can access the
> region after it’s unmapped:
> 
> 1. From the main context, the region’s field finish_unmapping is false
>    by default, so it sets a variable cmd_suspended, increases the
>    renderer_blocked variable, deletes the blob subregion, and unparents
>    the blob subregion causing its reference count to decrement.
> 
> 2. From an RCU context, the MemoryView gets freed, the FlatView gets
>    recalculated, the free callback of the blob region
>    virtio_gpu_virgl_hostmem_region_free is called which sets the
>    region’s field finish_unmapping to true, allowing the main thread
>    context to finish replying to the command
> 
> 3. From the main context, the command is processed again, but this time
>    finish_unmapping is true, so virgl_renderer_resource_unmap can be
>    called and a response is sent to the guest.
> 
> It happens so that under TCG, if the guest has no timers configured (and
> has no other interrupts that will cause the CPU to exit), the RCU thread
> does not have enough time to grab the locks and recalculate the
> FlatView.
> 
> That’s not a big problem in practice since most guests will assume a
> response will happen later in time and go on to do different things,
> potentially triggering interrupts and allowing the RCU context to run.
> If the guest waits for the unmap command to complete though, it blocks
> indefinitely. Attaching to the QEMU monitor and force quitting the guest
> allows the cleanup to continue.
> 
> There's no reason why the FlatView recalculation can't occur right away
> when we delete the blob subregion, however. It does not, because when we
> create the subregion we set the object as its own parent:
> 
>     memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
> 
> The extra self-reference is what prevents freeing the memory region
> object in the memory transaction of deleting the subregion.
> 
> This commit changes the owner object to the device, which removes the
> extra owner reference in the memory region and causes the MR to be
> freed right away in the main context.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/display/virtio-gpu-virgl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 145a0b3879..ad600ccc9c 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -120,7 +120,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>      vmr->g = g;
>  
>      mr = &vmr->mr;
> -    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
> +    memory_region_init_ram_ptr(mr, OBJECT(g), "blob", size, data);
>      memory_region_add_subregion(&b->hostmem, offset, mr);
>      memory_region_set_enabled(mr, true);
>  
> -- 
> γαῖα πυρί μιχθήτω


