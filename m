Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A85C55172
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 05:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr8A7-000802-0a; Tue, 04 Aug 2026 01:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wr8A4-0007zr-Le
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 01:58:00 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wr89y-0000fu-S8
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 01:57:58 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6745vm7O059906
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 4 Aug 2026 14:57:48 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=cA2CC/uled0cbxwh0gZqeRlEWw0/VNY2NMPluFyQce4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785823068; v=1;
 b=RxDjCvpr4gkayoR35jzY0x6s4aS0bT4Ok9lf+c+e29+NsS66u/w/ADubmxHqsE01
 JTP1rFWOLaK0fWBDz3n/s8BjwSrrjUheJJb3ne+4UwQbvC5eTlBh4MBhT1iaIvEx
 G/lpOVEO5kzYDbSg++5Pvi4BGj22U1qn5xZIUOSp7KNqaKByotLFCA4CKj/Bz1B2
 Qg8FFnet1F1j6Jh689ZBoY1UYPFi2JjZfEfcsXj61vPC7SGKqzN+Io4Z7IHLTmGl
 8JOMtiOUH15wJeN1xSTr+nXUUDEpPwu65IjRm2JUgTA2cqvnvi0GO86Zg/k15lBI
 zwfMOXG+ZJFtONVvi1nV4Q==
Message-ID: <e4313c26-fff3-470b-ab9e-8b90cdc98a43@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 4 Aug 2026 14:57:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] virtio-gpu: reject requests with short/truncated
 control headers
To: Ankur Saini <ankur98saini@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20260803-virtio-gpu-short-header-v3-1-936c1daa8e61@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260803-virtio-gpu-short-header-v3-1-936c1daa8e61@gmail.com>
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

On 2026/08/04 2:09, Ankur Saini wrote:
> A short control request can leave command data partially initialized.
> For the common header, guest-controlled flags can then cause stale fence
> metadata to be returned to the guest.
> 
> The command fill helpers detect a short copy but only log and return,
> leaving the malformed request without an error or completion. Make
> VIRTIO_GPU_FILL_CMD() clear the partially copied object and complete the
> request with ERR_INVALID_PARAMETER. Make VUGPU_FILL_CMD() report the same
> error through the existing vhost-user-gpu dispatcher. This also rejects
> truncated type-specific commands.

One small correction: this says the malformed request is left without 
completion, but virtio_gpu_simple_process_cmd() and vg_process_cmd() 
actually complete them, though its response type is 
VIRTIO_GPU_RESP_OK_NODATA.

With that addressed,

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

> 
> The vhost-user-gpu common header is copied outside VUGPU_FILL_CMD(), so
> clear it and complete the request directly when that copy is short.
> 
> Fixes: CVE-2026-18054
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4094
> Reported-by: Ankur Saini <ankur98saini@gmail.com>
> Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Ankur Saini <ankur98saini@gmail.com>
> ---
> Changes in v3:
> - Handle short copies in VIRTIO_GPU_FILL_CMD() and VUGPU_FILL_CMD(),
>    also rejecting truncated type-specific commands.
> - Clear partially copied QEMU command data before completing the error.
> - Keep vhost-user-gpu's explicit common-header check and drop the
>    redundant virtio_gpu_process_cmdq() check.
> - Rebase onto current master.
> - Link to v2: https://lore.kernel.org/qemu-devel/20260729-virtio-gpu-short-header-v2-1-18036a97219a@gmail.com
> 
> Changes in v2:
> - Also reject short/truncated control headers in vhost-user-gpu.
> - Expand the commit message to describe both affected paths.
> - Link to v1: https://lore.kernel.org/qemu-devel/20260728-virtio-gpu-short-header-v1-1-af19a00b100d@gmail.com
> ---
>   contrib/vhost-user-gpu/vhost-user-gpu.c | 21 ++++++++++++---------
>   contrib/vhost-user-gpu/vugpu.h          |  1 +
>   include/hw/virtio/virtio-gpu.h          |  3 +++
>   3 files changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-user-gpu/vhost-user-gpu.c
> index bb41758e34..8149834745 100644
> --- a/contrib/vhost-user-gpu/vhost-user-gpu.c
> +++ b/contrib/vhost-user-gpu/vhost-user-gpu.c
> @@ -924,16 +924,19 @@ vg_handle_ctrl(VuDev *dev, int qidx)
>           if (len != sizeof(cmd->cmd_hdr)) {
>               g_warning("%s: command size incorrect %zu vs %zu\n",
>                         __func__, len, sizeof(cmd->cmd_hdr));
> -        }
> -
> -        virtio_gpu_ctrl_hdr_bswap(&cmd->cmd_hdr);
> -        g_debug("%d %s\n", cmd->cmd_hdr.type,
> -                vg_cmd_to_string(cmd->cmd_hdr.type));
> -
> -        if (vg->virgl) {
> -            vg_virgl_process_cmd(vg, cmd);
> +            memset(&cmd->cmd_hdr, 0, sizeof(cmd->cmd_hdr));
> +            vg_ctrl_response_nodata(
> +                vg, cmd, VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER);
>           } else {
> -            vg_process_cmd(vg, cmd);
> +            virtio_gpu_ctrl_hdr_bswap(&cmd->cmd_hdr);
> +            g_debug("%d %s\n", cmd->cmd_hdr.type,
> +                    vg_cmd_to_string(cmd->cmd_hdr.type));
> +
> +            if (vg->virgl) {
> +                vg_virgl_process_cmd(vg, cmd);
> +            } else {
> +                vg_process_cmd(vg, cmd);
> +            }
>           }
>   
>           if (cmd->state != VG_CMD_STATE_FINISHED) {
> diff --git a/contrib/vhost-user-gpu/vugpu.h b/contrib/vhost-user-gpu/vugpu.h
> index 2374eb90cb..aaf2870cb2 100644
> --- a/contrib/vhost-user-gpu/vugpu.h
> +++ b/contrib/vhost-user-gpu/vugpu.h
> @@ -179,6 +179,7 @@ struct virtio_gpu_ctrl_command {
>           if (vugpufillcmd_s_ != sizeof(out)) {                   \
>               g_critical("%s: command size incorrect %zu vs %zu", \
>                          __func__, vugpufillcmd_s_, sizeof(out)); \
> +            cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER; \
>               return;                                             \
>           }                                                       \
>       } while (0)
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 2f60c72078..f965defa6b 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -315,6 +315,9 @@ struct VirtIOGPURutabaga {
>               qemu_log_mask(LOG_GUEST_ERROR,                              \
>                             "%s: command size incorrect %zu vs %zu\n",    \
>                             __func__, virtiogpufillcmd_s_, sizeof(out));  \
> +            memset(&out, 0, sizeof(out));                               \
> +            virtio_gpu_ctrl_response_nodata(                            \
> +                g, cmd, VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER);         \
>               return;                                                     \
>           }                                                               \
>       } while (0)
> 
> ---
> base-commit: b428fe036233cbd15d37e3c027ab6ca4d3661a80
> change-id: 20260728-virtio-gpu-short-header-476aa1dae4f7
> 
> Best regards,


