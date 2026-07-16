Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283BAC4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 22:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkV1h-0006XV-QI; Thu, 16 Jul 2026 18:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wkV1Z-0006XC-SY
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 18:57:51 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wkV1N-0008Uc-EZ
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 18:57:42 -0400
Received: from [192.168.10.145] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66GMvQcE086198
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 17 Jul 2026 07:57:26 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=zu4Jnw5ulcuZgBSLkG2jTebw26UtrZsnH/q14Xe37IM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1784242646; v=1;
 b=DP7GwyoQ3SZalLHK/wyeD7Qx/HdWwUEHoutQSz/M1ePe0SjNYgJF97kucZtoyyXl
 J/5lLrQh1jKS6RQtwtEhNdN4tmwi66906tyX735iPukgBYjwd9n2Vwuhdte9p2zZ
 C6oQdcx4RHjP8EwvDIhXSKprDjwKK/cUDkrkoRfDX8QUil4kPETiszro8YJ5qbkG
 ZFEd2mI05khVJ+hHJbzk81jzshuNO6VwoG/C0vMGC/rRF+fs3Sd05AXn1Hi09DSt
 Z4Jk7nKskkXYjBKdR4q/45kCI1kRFQvJApBldgafdwDBIV4i49vFK2FgnfuXAkp1
 iEot+FrZbgKmmTpWRPEtPg==
Message-ID: <ec997fca-6dc4-4268-9269-0e4be676b0fb@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 17 Jul 2026 07:57:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/virtio-gpu: validate stride against width on
 scanout
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260715201055.2465320-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260715201055.2465320-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/07/16 5:10, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Validate that the framebuffer stride is at least width * bytes_per_pixel
> in both virtio_gpu_scanout_blob_to_fb() and virtio_gpu_do_set_scanout().
> 
> A guest can set a very small stride while using a large width. The total
> size check (offset + stride * height <= blob_size) passes because
> stride * height is small, but pixman reads width * bytes_per_pixel per
> row, causing heap OOB reads. The leaked data is rendered to the host
> display.
> 
> The check is added in virtio_gpu_do_set_scanout() to cover all paths:
> blob scanout, non-blob scanout and migration post_load. The additional
> early check in virtio_gpu_scanout_blob_to_fb() rejects invalid blob
> configurations early.
> 
> Fixes: CVE-2026-63109
> Fixes: 144bd171c837 ("virtio-gpu: Support blob scanout using dmabuf fd")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3989
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/virtio-gpu.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 89a73793a42..1d4b8ee4192 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -647,6 +647,14 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
>           return false;
>       }
>   
> +    if (fb->stride < (uint64_t)fb->width * fb->bytes_pp) {

I found that fb->bytes_pp cannot be trusted because it is restored 
independently from the migration stream. I think that field should be 
removed from virtio_gpu_framebuffer; its migration slot can be preserved 
with VMSTATE_UNUSED_TEST(). Bytes per pixel can be derived from
fb->format, which Pixman actually uses.

Regards,
Akihiko Odaki

> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: stride %u too small for width %u at %u bpp\n",
> +                      __func__, fb->stride, fb->width, fb->bytes_pp);
> +        *error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +        return false;
> +    }
> +
>       g->parent_obj.enable = 1;
>   
>       if (res->blob) {
> @@ -754,6 +762,14 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
>       fb->width = ss->width;
>       fb->height = ss->height;
>       fb->stride = ss->strides[0];
> +
> +    if (fb->stride < (uint64_t)fb->width * fb->bytes_pp) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: stride %u too small for width %u at %u bpp\n",
> +                      __func__, fb->stride, fb->width, fb->bytes_pp);
> +        return false;
> +    }
> +
>       fb->offset = ss->offsets[0] + ss->r.x * fb->bytes_pp + ss->r.y * fb->stride;
>   
>       fbend = fb->offset;


