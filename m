Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7896CC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 18:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9q0W-0001yf-2B; Tue, 29 Apr 2025 14:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1u9q0Q-0001wz-C4; Tue, 29 Apr 2025 14:48:34 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1u9q0M-0005N3-RU; Tue, 29 Apr 2025 14:48:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1745952489; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=C4MzeXacDBoJxKw9jZwxTqhh/7CNtmZvQ6Gmjr9/B2vLU7+4BzdZO+YWfBSjxLyIFlv09cxRo1kPd+3fa5ON6Md8KzJv2ewsfrcPgad8B/RTeROYXL/LSz3KH2fcPFJvAGBvzmNX+tKE2EEP7ylHcSWxBPwH+DWMbivecK5sAko=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1745952489;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Yw6K7+P0IhnRvA1OE3yXKPhguHzVqRLq3CxC4f2co/4=; 
 b=QLOCLHVerYQYk//gw4BnNh8ooKHEDeTX9qF4gX6YvX/wNIeXbYT1eHp3H7yXXU4byFLkiGq9k4VrI97g1QzphuLLrEnjQnT0+PygfQ/icq+mpyxIKU5h+uE7R/IU7tPI35DQjaS79xkGA14HW7LDqngvs+GYosTAF5VlXVdYscA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745952489; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Yw6K7+P0IhnRvA1OE3yXKPhguHzVqRLq3CxC4f2co/4=;
 b=JgnKlLZPsU5E5clvfPaFzYtwSqOy9DprGkhMOl6+kOOnN1XRQo+jcaaDKojNtLKM
 2LJ/eQ4anumPWKy4WXCDWt3Znr0BlX1JzBGy+rBmXQRrL6S/IFtnYMaooh6a2xkBd7/
 LPQP2T66a36NbXVGRb+TKjFm1+D1RtKRlXPzKZXc=
Received: by mx.zohomail.com with SMTPS id 1745952487984766.6216250032528;
 Tue, 29 Apr 2025 11:48:07 -0700 (PDT)
Message-ID: <8b123991-21f2-47b5-851d-6b53fbfaa691@collabora.com>
Date: Tue, 29 Apr 2025 21:48:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] virtio-gpu: fix hang under TCG when unmapping blob
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-stable@nongnu.org
References: <20250428125918.449346-1-alex.bennee@linaro.org>
 <20250428125918.449346-9-alex.bennee@linaro.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250428125918.449346-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 4/28/25 15:59, Alex BennÃ©e wrote:
> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> 
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
> thus no interrupt will cause the CPU to exit), the RCU thread does not
> have enough time to grab the locks and recalculate the FlatView.
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
> The extra reference is what prevents freeing the memory region object in
> the memory transaction of deleting the subregion.
> 
> This commit changes the owner object to the device, which removes the
> extra owner reference in the memory region and causes the MR to be
> freed right away in the main context.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Tested-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20250410122643.1747913-3-manos.pitsidianakis@linaro.org>
> Cc: qemu-stable@nongnu.org
> ---
>  hw/display/virtio-gpu-virgl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 71a7500de9..8fbe4e70cc 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -112,7 +112,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>      vmr->g = g;
>      mr = g_new0(MemoryRegion, 1);
>  
> -    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
> +    memory_region_init_ram_ptr(mr, OBJECT(g), "blob", size, data);
>      memory_region_add_subregion(&b->hostmem, offset, mr);
>      memory_region_set_enabled(mr, true);
>  

This change makes QEMU to crash.

AFAICT, it effectively reverts code to old bugged version [1] that was
rejected in the past.

+Akihiko Odaki

[1]
https://lore.kernel.org/qemu-devel/20230915111130.24064-10-ray.huang@amd.com/


-- 
Best regards,
Dmitry


