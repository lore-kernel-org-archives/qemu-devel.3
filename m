Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89D2C531CC
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 06:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wns7Q-0000a8-OG; Sun, 26 Jul 2026 02:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wns7M-0000Vu-3K
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 02:13:44 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wns7H-0002UL-8V
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 02:13:42 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66Q6DQQJ089195
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 26 Jul 2026 15:13:26 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=C81TAyb0C5fG96oalaZLYMjXyLFfmLJkBvqT21PdQVQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785046407; v=1;
 b=tkxNkT8xT5D4vklzFEup0LlJC8luuL07MMwyo/EdWBS5cCefwXpRNhjvTkW4kO67
 pxHwfBE27Xa/hF9OoGQL64Z1Tukjt2fBZSizWn8xDx507FIyqkclPWNFibug3kP/
 tBGZkZB96aLnaGdrN/cBMHnFoi/6O0CZPfspz+9TaPKoOWZJrfHf9LqBIlJU7xql
 M8vTxottpxLFOOwO9krE8ezGD8KpTQw8Y6ViFMbtoeRv2e71jFwZNV534HjOhnRk
 F9RINQfj2sJCLgggXeRF5wluCkAQwxkeAdvNX3fYuo2OG18cZmpsBH0GRE4UTfiC
 MMaDarZ7ucxlgWNDQ7cB0A==
Message-ID: <93be053e-6c71-4f7c-8aa8-eedbb06b588b@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 26 Jul 2026 15:13:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/display/virtio-gpu: fix use-after-free on blob
 detach backing
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: akihiko.odaki@gmail.com, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260725113727.1692271-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260725113727.1692271-1-marcandre.lureau@redhat.com>
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

On 2026/07/25 20:37, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> virtio_gpu_cleanup_mapping() tears down the udmabuf mapping (or, for the
> small-iov case, the guest memory mapping) via virtio_gpu_fini_udmabuf(),
> but leaves res->blob pointing at it afterwards. Once a blob resource
> goes through RESOURCE_DETACH_BACKING, res->blob is left dangling while
> res->blob_size is still non-zero.
> 
> virtio_gpu_update_cursor_data() only checks res->blob_size before
> copying from res->blob, so UPDATE_CURSOR on a detached blob resource
> makes QEMU memcpy from freed memory.
> 
> virtio_gpu_do_set_scanout() also creates scanout->ds over
> res->blob + fb->offset. RESOURCE_DETACH_BACKING leaves that surface
> installed, so a subsequent display refresh can still read the backing
> after virtio_gpu_fini_udmabuf() has unmapped it.
> 
> Disable any active scanouts referencing the resource before tearing down
> its backing, clear res->blob afterwards, and check it before
> dereferencing in virtio_gpu_update_cursor_data().
> 
> Fixes: CVE-2026-66020
> Fixes: bdd53f739273 ("virtio-gpu: Update cursor data using blob")

This should also have:
Fixes: 32db3c63ae11 ("virtio-gpu: Add virtio_gpu_set_scanout_blob")

> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3881
> Reported-by: 章鱼哥@aipy (www.aipyaipy.com)
> Reported-by: swing <swing@mail.exp.sh>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
> v2:
>   - disable active scanouts referencing the resource before tearing
>     down its backing, fixing a second use-after-free through the
>     display refresh path
>   - add LOG_GUEST_ERROR for the blob-size-too-small early return
> ---
>   hw/display/virtio-gpu.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 211a529ed720..b21ac8dace08 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -57,8 +57,16 @@ void virtio_gpu_update_cursor_data(VirtIOGPU *g,
>       }
>   
>       if (res->blob_size) {
> +        if (!res->blob) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: resource %d has no blob\n",
> +                          __func__, resource_id);
> +            return;
> +        }
>           if (res->blob_size < (s->current_cursor->width *
>                                 s->current_cursor->height * 4)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: blob size too small for resource %d\n",
> +                          __func__, resource_id);
>               return;
>           }
>           data = res->blob;
> @@ -969,6 +977,7 @@ void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
>   
>       if (res->blob) {
>           virtio_gpu_fini_udmabuf(g, res);
> +        res->blob = NULL;
>       }
>   }
>   
> @@ -1031,6 +1040,15 @@ virtio_gpu_resource_detach_backing(VirtIOGPU *g,
>       if (!res) {
>           return;
>       }
> +
> +    if (res->scanout_bitmask) {

I feel this is a premature optimization.

Perhaps this should not affect a non-blob scanout that doesn't use the 
backing storage, so we should have if (res->blob).

Regards,
Akihiko Odaki

> +        for (int i = 0; i < g->parent_obj.conf.max_outputs; i++) {
> +            if (res->scanout_bitmask & (1 << i)) {
> +                virtio_gpu_disable_scanout(g, i);
> +            }
> +        }
> +    }
> +
>       virtio_gpu_cleanup_mapping(g, res);
>   }
>   


