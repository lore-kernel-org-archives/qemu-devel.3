Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AED0C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkeD1-0000VF-CP; Fri, 17 Jul 2026 04:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wkeCa-0000To-Lp; Fri, 17 Jul 2026 04:45:54 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wkeCW-0003tx-RJ; Fri, 17 Jul 2026 04:45:47 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66H8jV3X014557
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 17 Jul 2026 17:45:31 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=4p3NEAOyBTzbDAIiWh/KndwyElLuEFTPm5Uww5vLlQE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1784277931; v=1;
 b=sC2UxIyi8CapDFYiljUCpHFbp02xHDwlK9lv2F2JsfdYfbjCKpxRkbpymWlTl1VZ
 vemGix6+tfvbFGmdcDt/uP9vMBUBc6FWcdck3pMaHZ4JuOShcPKejzK4eKW/uoCp
 gXYKQnKAhZbldjA60rphHcZK2QpIyyOZRXsmhSSwxM66pFP6MlGXT4kivxjWqcCN
 7pw5+zu3x5JbtdKvBFn3KQsP704rpWaSQV5Is2VRGG+Dvbh8rdeX8mbTnetEl3Wt
 YR9JDgcxSGdqyLR+WWWlSjXf92sRaTJ1NjNeUwXBp6+N4JCnIvbNTG2nF3cEfwxx
 9bD8r29S9vJAZJO38wqBqg==
Message-ID: <ad105136-dbd3-48e4-a450-8055853161ca@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 17 Jul 2026 17:45:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-gpu: fix NULL deref in rutabaga set_scanout
To: jianghaotian.sunday@gmail.com, qemu-devel@nongnu.org
Cc: mst@redhat.com, alex.bennee@linaro.org, dmitry.osipenko@collabora.com,
 qemu-stable@nongnu.org
References: <20260717083208.291036-1-jianghaotian.sunday@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260717083208.291036-1-jianghaotian.sunday@gmail.com>
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

On 2026/07/17 17:32, jianghaotian.sunday@gmail.com wrote:
> From: Haotian Jiang <jianghaotian.sunday@gmail.com>
> 
> rutabaga_cmd_set_scanout() checks scanout_id < VIRTIO_GPU_MAX_SCANOUTS
> (16), but does not check scanout_id < conf.max_outputs like the base
> class (virtio-gpu.c) and virgl backend (virtio-gpu-virgl.c) do.
> 
> With the default max_outputs=1, virtio_gpu_base_device_realize only
> initializes scanout[0].con. A guest submitting SET_SCANOUT with
> scanout_id >= 1 takes the con=NULL path, and
> qemu_console_set_surface(NULL, NULL) dereferences con->ds, crashing
> QEMU.
> 
> Add the same max_outputs check used by the base class and virgl backend.
> 
> Fixes: 1dcc6adbc1 ("gfxstream + rutabaga: add initial support for gfxstream")
> Reported-by: Haotian Jiang of Tencent Security (Yunding Lab) <jianghaotian.sunday@gmail.com>
> Signed-off-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
> Cc: qemu-stable@nongnu.org
> ---
>   hw/display/virtio-gpu-rutabaga.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
> index 6ff1263901..24386487ba 100644
> --- a/hw/display/virtio-gpu-rutabaga.c
> +++ b/hw/display/virtio-gpu-rutabaga.c
> @@ -303,6 +303,14 @@ rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
>                                        ss.r.width, ss.r.height, ss.r.x, ss.r.y);
>   
>       CHECK(ss.scanout_id < VIRTIO_GPU_MAX_SCANOUTS, cmd);
> +
> +    if (ss.scanout_id >= vb->conf.max_outputs) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout id specified %d",
> +                      __func__, ss.scanout_id);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_SCANOUT_ID;
> +        return;
> +    }
> +

We can simply replace VIRTIO_GPU_MAX_SCANOUTS with vb->conf.max_outputs 
since we already ensure vb->conf.max_outputs <= VIRTIO_GPU_MAX_SCANOUTS 
during realization.

Regards,
Akihiko Odaki

>       scanout = &vb->scanout[ss.scanout_id];
>   
>       if (ss.resource_id == 0) {


