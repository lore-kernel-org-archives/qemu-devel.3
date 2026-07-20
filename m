Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF54BC44529
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wliO4-0004PV-W6; Mon, 20 Jul 2026 03:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wliNi-0004MV-Ba; Mon, 20 Jul 2026 03:25:46 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wliNf-0002xs-4U; Mon, 20 Jul 2026 03:25:42 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66K7PKcT022852
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Jul 2026 16:25:20 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=lvZnoGb/rjsjQO79a23zyCAYcjE4jvzatFesIe5yv1E=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1784532321; v=1;
 b=YQjGlw8s5+twCthcwUgtmN9natGB07xDuflvCdf5wHIvuSYqMNcj0feD9L9P94JQ
 QfwHi6P8gBWyVViaJ4ilQNIOkjj7Kc8qTTWT7dOBdsLAhZzzwD4lFaJSmo+Prs/h
 wOedjJuy9KYHqD8I3qkDAaOHSXo85s6ndNzV0kr+yeV+0n8wHdytbq41FI+bYjRS
 Vvnhmh69MLcUNXw2zuo74EaAY975U9XQlw14C7pkf/Y2EAIlbE/PPiMazYjCI38k
 TRvrlOAYOE5SCsJBu9OvLsT2HMvtyvgkbamny1nwJYfL6uupSdG3Hvpdgfy4ryjG
 aF4iB9ZPxHwvMHvMTKEmpw==
Message-ID: <e0de6de4-85ed-4811-b381-22a25c4357de@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 20 Jul 2026 16:25:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio-gpu: fix NULL deref in rutabaga set_scanout
To: jianghaotian.sunday@gmail.com, qemu-devel@nongnu.org
Cc: mst@redhat.com, alex.bennee@linaro.org, dmitry.osipenko@collabora.com,
 qemu-stable@nongnu.org
References: <20260720071556.106003-1-jianghaotian.sunday@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260720071556.106003-1-jianghaotian.sunday@gmail.com>
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

Some nits still remain:

On 2026/07/20 16:15, jianghaotian.sunday@gmail.com wrote:
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

scanout_id >= VIRTIO_GPU_MAX_SCANOUTS is already covered by an existing 
check. Crashing QEMU may be the most probable consequence, but it may 
turn out otherwise. I think just noting the out of bound access is 
sufficient and concise.

> 
> Replace VIRTIO_GPU_MAX_SCANOUTS with vb->conf.max_outputs in the
> CHECK, since realization already ensures max_outputs <=
> VIRTIO_GPU_MAX_SCANOUTS.
> 
> Fixes: 1dcc6adbc1 ("gfxstream + rutabaga: add initial support for gfxstream")

docs/devel/submitting-a-patch.rst says:

 > If your patch fixes a commit that is already in the repository, please
 > add an additional line with
 > "Fixes: <at-least-12-digits-of-SHA-commit-id>
 > ("Fixed commit subject")" below the patch description / before your
 > "Signed-off-by:" line in the commit message.

This "Fixes:" tag only contains 10 digits.

Unfortunately, QEMU's documentation doesn't tell much about how to 
generate the Fixes: tag, but Linux's documentation has more details:
https://www.kernel.org/doc/html/v7.1/process/submitting-patches.html#describe-your-changes

Regards,
Akihiko Odaki

> Reported-by: Haotian Jiang of Tencent Security (Yunding Lab) <jianghaotian.sunday@gmail.com>
> Signed-off-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
> Cc: qemu-stable@nongnu.org
> ---
>   hw/display/virtio-gpu-rutabaga.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
> index 6ff1263901..3f78899442 100644
> --- a/hw/display/virtio-gpu-rutabaga.c
> +++ b/hw/display/virtio-gpu-rutabaga.c
> @@ -302,7 +302,7 @@ rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
>       trace_virtio_gpu_cmd_set_scanout(ss.scanout_id, ss.resource_id,
>                                        ss.r.width, ss.r.height, ss.r.x, ss.r.y);
>   
> -    CHECK(ss.scanout_id < VIRTIO_GPU_MAX_SCANOUTS, cmd);
> +    CHECK(ss.scanout_id < vb->conf.max_outputs, cmd);
>       scanout = &vb->scanout[ss.scanout_id];
>   
>       if (ss.resource_id == 0) {


