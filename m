Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B41C54FCD
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 07:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wq3tZ-0001eX-P5; Sat, 01 Aug 2026 03:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wq3tX-0001eP-QB
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 03:12:31 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wq3tU-0007Hh-GT
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 03:12:31 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6717CMV8037362
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 1 Aug 2026 16:12:22 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=p1ZJBzQRwpo56oYxUfoSQb8+xU0eNE7zf1z8W6dA3Fc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785568342; v=1;
 b=HOwU8xWAsACXyzLXS1+mWb8RlPudye7hffrzHgj3wvgPmPd0MIkPIjjc7UVuBli2
 olcR0Wv7zzpdhOp6JpL4wJHCY3XPL0x/Je21EIJD5/kKi8VaPppLtyi601W0L1nc
 xJDIIcbBwg6LZNHUl+eh6V2VDnm+IxuTQrOJpfeI9D74YwH7c7CDCP0JTn7MyAJo
 GkPa0iwLSOI9CWzvyjIcHvFFjO1TlevPCd8LxiDHVgLZMg563ZaHdqIxY4HZf2rH
 SJg1d7bVL+yQpD3slbWYmhITq3Qo6w9xvWlpCxm1vpStvIY8TACpsZifNF5O3pLS
 h1+nOYDvz1ZaNG9s//CJYA==
Message-ID: <11151483-95e4-4e82-8664-5f61f4bf2cb6@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 1 Aug 2026 16:12:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio-gpu: reject requests with short/truncated
 control headers
To: Ankur Saini <ankur98saini@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20260729-virtio-gpu-short-header-v2-1-18036a97219a@gmail.com>
 <fca5a423-cba9-452f-86f5-c382524b7087@rsg.ci.i.u-tokyo.ac.jp>
 <CAE+rwOMBiusrWqbWFgA6Tqxi1pvE4KWEcJkmmw3+0RUYHNiGaQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CAE+rwOMBiusrWqbWFgA6Tqxi1pvE4KWEcJkmmw3+0RUYHNiGaQ@mail.gmail.com>
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

On 2026/07/29 16:28, Ankur Saini wrote:
> Thanks. Just to clarify, the vhost-user-gpu check was already there and 
> compares the return value of iov_to_buf(), not iov_size(). != and < 
> should be equivalent for vhost-user-gpu check so I left it unchanged.

The fact that the checks compare different values made me look at how 
virtio-gpu copies commands.

For commands with type-specific fields, processing copies the request
in two stages:

1. Copy the common header to determine the command type.
2. Copy the complete type-specific command.

vhost-user-gpu open-codes the first step in vg_handle_ctrl() and uses 
VUGPU_FILL_CMD() for the second. virtio-gpu uses VIRTIO_GPU_FILL_CMD() 
for both steps.

Both fill macros already detect a short copy, but only log and return. 
They should instead complete the malformed request with 
ERR_INVALID_PARAMETER. For a common-header copy, the partially copied 
header must also be cleared before forming the response.

Once VIRTIO_GPU_FILL_CMD() handles this failure, the new check in 
virtio_gpu_process_cmdq() will be unnecessary because the macro covers 
the first step. Fixing both macros will also reject truncated 
type-specific commands.

Regards,
Akihiko Odaki

> 
> The new virtio-gpu check looks at the total iov size, which can be 
> larger than the header for valid commands, so it needs to use <. Would 
> you still prefer changing the vhost-user-gpu condition to < for consistency?
> 
> Regards,
> Ankur Saini
> 
> On Wed, Jul 29, 2026 at 9:31 AM Akihiko Odaki <odaki@rsg.ci.i.u- 
> tokyo.ac.jp <mailto:odaki@rsg.ci.i.u-tokyo.ac.jp>> wrote:
> 
>     On 2026/07/29 5:44, Ankur Saini wrote:
>      > A control request shorter than virtio_gpu_ctrl_hdr can leave cmd_hdr
>      > partially initialized. If the supplied bytes set the fence flag,
>     stale
>      > fence metadata may later be returned to the guest.
>      >
>      > The vhost-user-gpu backend has the same issue: it logs a short header
>      > copy but continues to process the partially initialized command.
>      >
>      > Validate the common header length before dispatch in both paths.
>     Clear
>      > cmd_hdr and complete malformed requests with ERR_INVALID_PARAMETER so
>      > stale fields cannot reach the response.
> 
>     vhost-user-gpu and virtio-gpu has slightly different conditions:
> 
>     - vhost-user-gpu rejects: iov_size() != sizeof(cmd->cmd_hdr)
>     - virtio-gpu rejects: iov_size() < sizeof(cmd->cmd_hdr)
> 
>     Ideally they should be consistent.
> 
>     Regards,
>     Akihiko Odaki
> 
>      >
>      > Fixes: CVE-2026-18054
>      > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4094
>     <https://gitlab.com/qemu-project/qemu/-/work_items/4094>
>      > Reported-by: Ankur Saini <ankur98saini@gmail.com
>     <mailto:ankur98saini@gmail.com>>
>      > Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp
>     <mailto:odaki@rsg.ci.i.u-tokyo.ac.jp>>
>      > Signed-off-by: Ankur Saini <ankur98saini@gmail.com
>     <mailto:ankur98saini@gmail.com>>
>      > ---
>      > Changes in v2:
>      > - Also reject short/truncated control headers in vhost-user-gpu.
>      > - Expand the commit message to describe both affected paths.
>      > - Link to v1: https://lore.kernel.org/qemu-devel/20260728-virtio-
>     gpu-short-header-v1-1-af19a00b100d@gmail.com <https://
>     lore.kernel.org/qemu-devel/20260728-virtio-gpu-short-header-v1-1-
>     af19a00b100d@gmail.com>
>      > ---
>      >   contrib/vhost-user-gpu/vhost-user-gpu.c | 21 ++++++++++++---------
>      >   hw/display/virtio-gpu.c                 | 10 ++++++++--
>      >   2 files changed, 20 insertions(+), 11 deletions(-)
>      >
>      > diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/
>     vhost-user-gpu/vhost-user-gpu.c
>      > index bb41758e34..8149834745 100644
>      > --- a/contrib/vhost-user-gpu/vhost-user-gpu.c
>      > +++ b/contrib/vhost-user-gpu/vhost-user-gpu.c
>      > @@ -924,16 +924,19 @@ vg_handle_ctrl(VuDev *dev, int qidx)
>      >           if (len != sizeof(cmd->cmd_hdr)) {
>      >               g_warning("%s: command size incorrect %zu vs %zu\n",
>      >                         __func__, len, sizeof(cmd->cmd_hdr));
>      > -        }
>      > -
>      > -        virtio_gpu_ctrl_hdr_bswap(&cmd->cmd_hdr);
>      > -        g_debug("%d %s\n", cmd->cmd_hdr.type,
>      > -                vg_cmd_to_string(cmd->cmd_hdr.type));
>      > -
>      > -        if (vg->virgl) {
>      > -            vg_virgl_process_cmd(vg, cmd);
>      > +            memset(&cmd->cmd_hdr, 0, sizeof(cmd->cmd_hdr));
>      > +            vg_ctrl_response_nodata(
>      > +                vg, cmd, VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER);
>      >           } else {
>      > -            vg_process_cmd(vg, cmd);
>      > +            virtio_gpu_ctrl_hdr_bswap(&cmd->cmd_hdr);
>      > +            g_debug("%d %s\n", cmd->cmd_hdr.type,
>      > +                    vg_cmd_to_string(cmd->cmd_hdr.type));
>      > +
>      > +            if (vg->virgl) {
>      > +                vg_virgl_process_cmd(vg, cmd);
>      > +            } else {
>      > +                vg_process_cmd(vg, cmd);
>      > +            }
>      >           }
>      >
>      >           if (cmd->state != VG_CMD_STATE_FINISHED) {
>      > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>      > index 4d46a4eb10..15a845eff6 100644
>      > --- a/hw/display/virtio-gpu.c
>      > +++ b/hw/display/virtio-gpu.c
>      > @@ -1105,8 +1105,14 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
>      >               break;
>      >           }
>      >
>      > -        /* process command */
>      > -        vgc->process_cmd(g, cmd);
>      > +        if (unlikely(iov_size(cmd->elem.out_sg, cmd->elem.out_num) <
>      > +                     sizeof(cmd->cmd_hdr))) {
>      > +            memset(&cmd->cmd_hdr, 0, sizeof(cmd->cmd_hdr));
>      > +            virtio_gpu_ctrl_response_nodata(
>      > +                g, cmd, VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER);
>      > +        } else {
>      > +            vgc->process_cmd(g, cmd);
>      > +        }
>      >
>      >           /* command suspended */
>      >           if (!cmd->finished && !(cmd->cmd_hdr.flags &
>     VIRTIO_GPU_FLAG_FENCE)) {
>      >
>      > ---
>      > base-commit: 299e7557ed15a9a325620698add379a3ce2d1d95
>      > change-id: 20260728-virtio-gpu-short-header-476aa1dae4f7
>      >
>      > Best regards,
> 


