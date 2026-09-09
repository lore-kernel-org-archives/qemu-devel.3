Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CA2C79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4E6T-0005W4-IQ; Wed, 09 Sep 2026 04:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x4E6N-0005Vj-Gf
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 04:56:20 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x4E6J-0005k8-PS
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 04:56:19 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6898tt1L055110
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 9 Sep 2026 17:55:55 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=SuZkQIBTSLMS3S1qhgBXGqCwgJ2QFnwoWyl6ixt916Q=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1788944155; v=1;
 b=VST2ei/JCe3FrpLJQ3zUwfG8BHE8NSTRZbXniiLrO29lY9BMD35bCILIKrb6U2mT
 RCjhopGmgvwsKwknyZCdgD6s863htGKt58Gvv1o+uzbUhcmW3w2uwS7l+gF4VSRd
 vNeeipO9hl/qHCxfZ7oAINdmQhE8/U0C/c2ExnikruuV/LANyxpseMCXeUIs/8ib
 /lD3iiSD2C/vfMhShmY59SaijdEMsUEdQG4bAIlKL19NbvWxUeO8M9JqAjVZ/dVb
 8Iig2TyurvBrVfQGdsLwPRn/IYA2QuSQYyBL2feuDnqyBCde81xpC3ZTEaeD5pVV
 d9WfP2tnLLfL0Y9BpIXYQw==
Message-ID: <f87348c4-b79b-42fe-9a0c-88ec2d83c9d4@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 9 Sep 2026 17:55:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/25] virtio-gpu: fix use-after-free on blob cursor
 after detach
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Alex Williamson
 <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 swing <swing@mail.exp.sh>
References: <20260904-virtio-gpu-cleanup-v2-0-15b5ae6b0023@redhat.com>
 <20260904-virtio-gpu-cleanup-v2-2-15b5ae6b0023@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260904-virtio-gpu-cleanup-v2-2-15b5ae6b0023@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/09/04 22:10, Marc-André Lureau wrote:
> virtio_gpu_cleanup_mapping() unmaps the guest IOVs and tears down any
> udmabuf mapping, but leaves res->blob pointing at the freed memory. Once
> a blob resource goes through RESOURCE_DETACH_BACKING, res->blob is left
> dangling while res->blob_size is still non-zero.
> 
> virtio_gpu_update_cursor_data() only checks res->blob_size before copying
> from res->blob, so an UPDATE_CURSOR on a detached blob resource makes
> QEMU memcpy from freed memory.

Well, I forgot the presence of this patch and fixed the described issue 
with d3c2da174ca6 ("hw/display/virtio-gpu: Check cursor data presence"), 
so the issue is no longer present. Clearing res->blob and adding proper 
error messages are still nice additions.

> 
> Clear res->blob after tearing down its backing, keeping init/fini
> symmetric, and check it before dereferencing in
> virtio_gpu_update_cursor_data().
> 
> Fixes: CVE-2026-66020
> Fixes: bdd53f739273 ("virtio-gpu: Update cursor data using blob")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3881
> Reported-by: 章鱼哥@aipy (www.aipyaipy.com)
> Reported-by: swing <swing@mail.exp.sh>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/virtio-gpu-udmabuf.c | 1 +
>   hw/display/virtio-gpu.c         | 8 ++++++++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
> index c230509852ff..03f0b29754e1 100644
> --- a/hw/display/virtio-gpu-udmabuf.c
> +++ b/hw/display/virtio-gpu-udmabuf.c
> @@ -92,6 +92,7 @@ static void virtio_gpu_destroy_udmabuf(struct virtio_gpu_simple_resource *res)
>           close(res->dmabuf_fd);
>           res->dmabuf_fd = -1;
>       }
> +    res->blob = NULL;
>   }
>   
>   static int find_memory_backend_type(Object *obj, void *opaque)
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 5b63a292933a..aeb6155130d0 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -61,8 +61,16 @@ void virtio_gpu_update_cursor_data(VirtIOGPU *g,
>           }
>           data = pixman_image_get_data(res->image);
>       } else {
> +        if (!res->blob) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: resource %d has no blob\n",
> +                          __func__, resource_id);
> +            return;
> +        }
>           if (!res->iov || res->blob_size < (s->current_cursor->width *
>                                              s->current_cursor->height * 4)) {

This res->iov check I added will be unnecessary and misleading with the 
error message.

Regards,
Akihiko Odaki

> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: blob size too small for resource %d\n",
> +                          __func__, resource_id);
>               return;
>           }
>           data = res->blob;
> 


