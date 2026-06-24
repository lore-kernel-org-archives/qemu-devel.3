Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519DECDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 08:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcJ4q-0001AG-KJ; Wed, 24 Jun 2026 04:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wcJ4g-00013J-HH
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 04:35:11 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wcJ4d-00041p-JU
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 04:35:10 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65O8YpZG085352
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Jun 2026 17:34:51 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=0AaJqk3KD62/sk8GamWIn+QQHskCLQwaOeT74dWVarA=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1782290091; v=1;
 b=ZXkGqc3ywijYAjry7vIYn+gi5Ce/Ut4ThRsGVw4LNdh+cqJIYbcEguPTWPV9JFU/
 svpei/PszJznjE0QeHghQ6kYOmMJ0+qvldzaPntJ14J9PePN7WPDrKAR3uT4FRvP
 kqYSIfQ5MCRZX+Jhf5Yp4Ewu6Muhq+mHkRnaxBXmdQEXUxZjz5JFNC4n7l5aHAuL
 Acjl/UDx8CMywkcj2kCKFZxDJP0KFnTAEKQEnImm0MuntXqawnMtTw//nDu5QK37
 rFvU/lqeTD+EAuOgrDTiB+qUXhBtSpO3tHoNNnUWzhBj+M9+24JqPjwufbvlml/T
 cp/iph7oIU4niDFUNfmkhA==
Message-ID: <8d873098-5ed2-46e1-86e7-83dd5e706c21@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 24 Jun 2026 17:34:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] virtio-gpu: use unsigned shift for scanout bitmask
 operations
To: Bin Guo <guobin@linux.alibaba.com>, alex.bennee@linaro.org
Cc: mst@redhat.com, dmitry.osipenko@collabora.com, qemu-devel@nongnu.org
References: <cover.1782270919.git.guobin@linux.alibaba.com>
 <22d21cfbe4466c27e33e979717957f48673d4647.1782270919.git.guobin@linux.alibaba.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <22d21cfbe4466c27e33e979717957f48673d4647.1782270919.git.guobin@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2026/06/24 14:55, Bin Guo wrote:
> The scanout_bitmask field is uint32_t, but all six bit operations used
> the signed literal `1 << shift`.  When the shift count reaches 31 this
> is undefined behavior (signed integer overflow).  Replace every
> occurrence with `1U << shift` to perform an unsigned shift, which is
> well-defined for all bit positions 0-31.

I think we can make use of the BIT() macro.

Regards,
Akihiko Odaki

> 
> No functional change; the result is already stored in a uint32_t, so
> the generated code is identical on most platforms.
> 
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>   hw/display/virtio-gpu.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 88526051a9..9dfffa270a 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -387,7 +387,7 @@ void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
>   
>       res = virtio_gpu_find_resource(g, scanout->resource_id);
>       if (res) {
> -        res->scanout_bitmask &= ~(1 << scanout_id);
> +        res->scanout_bitmask &= ~(1U << scanout_id);
>       }
>   
>       qemu_console_set_surface(scanout->con, NULL);
> @@ -405,7 +405,7 @@ static void virtio_gpu_resource_destroy(VirtIOGPU *g,
>   
>       if (res->scanout_bitmask) {
>           for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
> -            if (res->scanout_bitmask & (1 << i)) {
> +            if (res->scanout_bitmask & (1U << i)) {
>                   virtio_gpu_disable_scanout(g, i);
>               }
>           }
> @@ -571,7 +571,7 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
>       for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
>           QemuRect rect;
>   
> -        if (!(res->scanout_bitmask & (1 << i))) {
> +        if (!(res->scanout_bitmask & (1U << i))) {
>               continue;
>           }
>           scanout = &g->parent_obj.scanout[i];
> @@ -605,10 +605,10 @@ void virtio_gpu_update_scanout(VirtIOGPU *g,
>       scanout = &g->parent_obj.scanout[scanout_id];
>       ores = virtio_gpu_find_resource(g, scanout->resource_id);
>       if (ores) {
> -        ores->scanout_bitmask &= ~(1 << scanout_id);
> +        ores->scanout_bitmask &= ~(1U << scanout_id);
>       }
>   
> -    res->scanout_bitmask |= (1 << scanout_id);
> +    res->scanout_bitmask |= (1U << scanout_id);
>       scanout->resource_id = res->resource_id;
>       scanout->x = r->x;
>       scanout->y = r->y;
> @@ -1490,7 +1490,7 @@ static int virtio_gpu_post_load(void *opaque, int version_id)
>           if (scanout->cursor.resource_id) {
>               update_cursor(g, &scanout->cursor);
>           }
> -        res->scanout_bitmask |= (1 << i);
> +        res->scanout_bitmask |= (1U << i);
>       }
>   
>       return 0;


