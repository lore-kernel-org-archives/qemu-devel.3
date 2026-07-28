Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1327C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonrB-0004W9-81; Tue, 28 Jul 2026 15:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wonr9-0004Vm-Ex
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:52:51 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wonr5-0007YB-BZ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:52:51 -0400
Received: from [192.168.10.145] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66SJqZtN049585
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 29 Jul 2026 04:52:36 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=tqxz+G8Z6SMBIVYcDsTTcUmYRJhCKSIAllBLHfEcCQc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785268356; v=1;
 b=GCXaDQyPerqJ9wn8f719fZYedSK5udLG8Oeo6/uZCX73C8DYgJQqF9XnURVXtxZA
 /8DH5pqX2RVEaotCt4Z/Mrb8Wo2QBK0LcaLXzb4jVkTvBz6GrmEw8ytxa5DZOiDW
 X1ssB4YqcaqhWcn+LDdstFNYlG5kAmJsShu89VQE/YTL33AP5LZ2GOwemN/1dhfv
 TPs0QoY6E8tXkfEWsihGrahiba0feJrgeC783rpahT7TAjUx0Ie0R9/fmpNQcR7F
 a4i2ZneKP2xFdbuot31gQHKFT24QsYxMjESUxML3Dcj/tFYKBELqpYxg3yIXML7B
 qT6SBTDLqho6yI26YkPFSg==
Message-ID: <0d877012-ea43-4f5b-ab85-16b0a733b5e5@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 29 Jul 2026 04:52:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-gpu: reject requests with short/truncated control
 headers
To: Ankur Saini <ankur98saini@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260728-virtio-gpu-short-header-v1-1-af19a00b100d@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260728-virtio-gpu-short-header-v1-1-af19a00b100d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2026/07/28 23:16, Ankur Saini wrote:
> A control request shorter than virtio_gpu_ctrl_hdr can leave cmd_hdr
> partially initialized. If the supplied bytes set the fence flag, stale
> fence metadata may later be returned to the guest.
> 
> Validate the common header length before dispatch. Clear cmd_hdr and
> complete malformed requests with ERR_INVALID_PARAMETER so stale fields
> cannot reach the response.
> 
> Fixes: CVE-2026-18054
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4094
> Reported-by: Ankur Saini <ankur98saini@gmail.com>
> Signed-off-by: Ankur Saini <ankur98saini@gmail.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Please also fix vhost-user-gpu.

Regards,
Akihiko Odaki

> ---
> A control request shorter than virtio_gpu_ctrl_hdr can leave cmd_hdr
> partially initialized. If the supplied bytes set the fence flag, stale
> fence metadata may later be returned to the guest.
> 
> Validate the common header length before dispatch. Clear cmd_hdr and
> complete malformed requests with ERR_INVALID_PARAMETER so stale fields
> cannot reach the response.
> ---
>   hw/display/virtio-gpu.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 4d46a4eb10..15a845eff6 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1105,8 +1105,14 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
>               break;
>           }
>   
> -        /* process command */
> -        vgc->process_cmd(g, cmd);
> +        if (unlikely(iov_size(cmd->elem.out_sg, cmd->elem.out_num) <
> +                     sizeof(cmd->cmd_hdr))) {
> +            memset(&cmd->cmd_hdr, 0, sizeof(cmd->cmd_hdr));
> +            virtio_gpu_ctrl_response_nodata(
> +                g, cmd, VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER);
> +        } else {
> +            vgc->process_cmd(g, cmd);
> +        }
>   
>           /* command suspended */
>           if (!cmd->finished && !(cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_FENCE)) {
> 
> ---
> base-commit: 299e7557ed15a9a325620698add379a3ce2d1d95
> change-id: 20260728-virtio-gpu-short-header-476aa1dae4f7
> 
> Best regards,


