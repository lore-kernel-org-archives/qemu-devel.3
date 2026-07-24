Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AC1C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 08:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnAqv-0001PB-Bd; Fri, 24 Jul 2026 04:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnAqo-0001O8-Sn
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 04:01:48 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnAqm-0007ZQ-0d
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 04:01:46 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66O81WI4019522
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 24 Jul 2026 17:01:32 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=bAwoe/H8r8/CxX7nGiUFeMaLfGDJ2xbOpdLHL15SfWw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1784880092; v=1;
 b=g60Ay9wQeRTmiOl71g6oOVtIqNVcZPS2VmjAQl953wRmzfFQc01I37YTPgo1T2dV
 NUCzblZlrk1sqDhEhdQnhghLMVkhrMePBCUQ7UcmoGnZCunProf0DwF/G6MxI5o5
 1OxTYnhyhgnftQECLsl791cHpedAa7+C2uyNe6olkjDIa7Rbbg3dU4sRaMNz8Cla
 qveb/GY0Zb7PTY+L+ngEOHnEoDZhk5DUBRNPqGeS2bQvGEfhAnZBE3pfcWbSrQ4G
 Psz8fN3sEkrAfLeD5KqenZiGbnDPD3gmJDxlytveX+2fl9Wm+FtSmL+ziqVYWLeg
 Gr/ltmthyBUriymVbsehGg==
Message-ID: <c45bd86d-aef7-415d-bf49-8b436cd52231@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 24 Jul 2026 17:01:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/virtio-gpu: fix offset truncation in
 scanout_blob_to_fb
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260724040126.867935-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260724040126.867935-1-marcandre.lureau@redhat.com>
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

On 2026/07/24 13:01, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> virtio_gpu_scanout_blob_to_fb() computes the framebuffer offset from
> guest-controlled offsets[0], r.x, r.y and stride using uint32_t
> arithmetic. The sum can wrap around, so a small fb->offset passes the
> fbend > blob_size check even though the real offset lies outside the
> blob. The wrapped value is later used as data + fb->offset in
> virtio_gpu_do_set_scanout(), letting the guest point the scanout at
> host memory beyond the blob.

fbend is computed from the same wrapped fb->offset that is later used
for data + fb->offset. Since fbend is checked against blob_size, the
wrapped pointer and scanout extent remain within the blob. Wraparound
can select a different in-bounds region, but the described host
out-of-bounds access does not follow.

> 
> Compute the offset in uint64_t, reject values wider than UINT32_MAX
> (the width of fb->offset), and only store into fb->offset once both
> range checks pass.
> 
> Fixes: CVE-2026-66019
> Fixes: 32db3c63ae11 ("virtio-gpu: Add virtio_gpu_set_scanout_blob")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3871
> Reported-by: Cyber_black <Cyberblackk@proton.me>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/virtio-gpu.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 36d2bd9edee6..d1e32840e223 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -784,7 +784,7 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
>                                      struct virtio_gpu_set_scanout_blob *ss,
>                                      uint64_t blob_size)
>   {
> -    uint64_t fbend;
> +    uint64_t fbend, offset;
>       uint32_t bytes_pp;
>   
>       fb->format = virtio_gpu_get_pixman_format(ss->format);
> @@ -814,18 +814,20 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
>           return false;
>       }
>   
> -    fb->offset = ss->offsets[0] + ss->r.x * bytes_pp + ss->r.y * fb->stride;
> +    offset = (uint64_t)ss->offsets[0] + (uint64_t)ss->r.x * bytes_pp +
> +             (uint64_t)ss->r.y * fb->stride;
>   
> -    fbend = fb->offset;
> -    fbend += (uint64_t) fb->stride * ss->r.height;
> +    fbend = offset + (uint64_t)fb->stride * ss->r.height;
>   
> -    if (fbend > blob_size) {
> +    if (offset > UINT32_MAX || fbend > blob_size) {
>           qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: fb end out of range\n",
> +                      "%s: invalid fb bounds\n",
>                         __func__);
>           return false;
>       }
>   
> +    fb->offset = offset;
> +
>       return true;
>   }
>   

This patch does not apply to master and appears to be based on:

Based-on: <20260719-bpp-v1-1-9b91946d6cf3@rsg.ci.i.u-tokyo.ac.jp>
("[PATCH] hw/display/virtio-gpu: Remove the bytes_pp field")

The dependency is not declared. Please record the prerequisite.

Regards,
Akihiko Odaki

