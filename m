Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3A0C3ABD8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 13:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH0I7-0004TB-BU; Mon, 19 May 2025 09:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uH0Hx-0004Ru-Jt; Mon, 19 May 2025 09:12:18 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uH0Hu-0003fw-Bg; Mon, 19 May 2025 09:12:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1747660322; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CaMPDzocZ4jR38fqRDuaH9rYeyX1UGRNE/M12l/b7YolpUF3AzLLjyyPUKVYhxOJa61IuiZfHy71QdpKb7zylTPf9pqshMZcEBdSwk7GPOAUXAUun0RBkwv6C1ZvzS/pyRFEeVNngck96sTgFrnQGQjVfT7RwObMcgYXXnk2N4Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1747660322;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=i0I35tKFK1j1epsZjqFjcmHhc85sid0Fh8aL6lxUjj8=; 
 b=N+LSGOK1oJaPUrSh+LT/QDt7vEIcLa9dq+MjhuvIobn49shHnx+NV5JBa668xX6gZwq3j93bKhJ5Mi5XNX3/vzYuqw5R6oOZaV8iz0axb/9RGz4VOnwBWHgkRNJt28FBlqzlxgwVaj23Kjjk/w0Lyu78w413B1WlWbECW6Vk7+8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747660322; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=i0I35tKFK1j1epsZjqFjcmHhc85sid0Fh8aL6lxUjj8=;
 b=JRsYUFc+b1tg4ROsFa7BgbWHbmCbeFrwmPfvzxHIARPviqalpdksJzxe2ZAah8fO
 TVnqn8fti87CzX2uDy0t28DTEEls5WbQeKCCgaRbSOx1AvQS43Yodkh3lvLIzncGVGy
 5WKf9CEgpK4QA+mpg3KG82NysymPbF6wo0yJtsxA=
Received: by mx.zohomail.com with SMTPS id 1747660319796409.9969457384624;
 Mon, 19 May 2025 06:11:59 -0700 (PDT)
Message-ID: <6420d58e-ab55-448b-a860-889d3fed04a2@collabora.com>
Date: Mon, 19 May 2025 16:11:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio-gpu: support context init multiple timeline
To: Yiwei Zhang <zzyiwei@gmail.com>, qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, qemu-stable@nongnu.org
References: <20250518152651.334115-1-zzyiwei@gmail.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250518152651.334115-1-zzyiwei@gmail.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 5/18/25 18:26, Yiwei Zhang wrote:
> Venus and later native contexts have their own fence context along with
> multiple timelines within. Fences wtih VIRTIO_GPU_FLAG_INFO_RING_IDX in
> the flags must be dispatched to be created on the target context. Fence
> signaling also has to be handled on the specific timeline within that
> target context.
> 
> Before this change, venus fencing is completely broken if the host
> driver doesn't support implicit fencing with external memory objects.
> Frames can go backwards along with random artifacts on screen if the
> host driver doesn't attach an implicit fence to the render target. The
> symptom could be hidden by certain guest wsi backend that waits on a
> venus native VkFence object for the actual payload with limited present
> modes or under special configs. e.g. x11 mailbox or xwayland.
> 
> After this change, everything related to venus fencing starts making
> sense. Confirmed this via guest and host side perfetto tracing.
> 
> Changes since v1:
> - Minor commit msg updates based on feedbacks from BALATON
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 94d0ea1c1928 ("virtio-gpu: Support Venus context")
> Signed-off-by: Yiwei Zhang <zzyiwei@gmail.com>
> ---
>  hw/display/virtio-gpu-virgl.c | 44 +++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 145a0b3879..94ddc01f91 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -970,6 +970,15 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>      }
>  
>      trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type);
> +#if VIRGL_VERSION_MAJOR >= 1
> +    if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX) {
> +        virgl_renderer_context_create_fence(cmd->cmd_hdr.ctx_id,
> +                                            VIRGL_RENDERER_FENCE_FLAG_MERGEABLE,
> +                                            cmd->cmd_hdr.ring_idx,
> +                                            cmd->cmd_hdr.fence_id);
> +        return;
> +    }
> +#endif
>      virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type);
>  }
>  
> @@ -983,6 +992,11 @@ static void virgl_write_fence(void *opaque, uint32_t fence)
>           * the guest can end up emitting fences out of order
>           * so we should check all fenced cmds not just the first one.
>           */
> +#if VIRGL_VERSION_MAJOR >= 1
> +        if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX) {
> +            continue;
> +        }
> +#endif

Is it possible that virglrenderer will ever write a context fence in
virgl_renderer_create_fence()? Do we really need this check?

-- 
Best regards,
Dmitry

