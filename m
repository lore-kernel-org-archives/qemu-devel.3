Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0747C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 21:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wopYV-0003qI-GO; Tue, 28 Jul 2026 17:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wopYT-0003ps-GQ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 17:41:41 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wopXv-0001YK-Oq
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 17:41:41 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2cc61541f8cso22573315ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 14:41:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785274865; cv=none;
 d=google.com; s=arc-20260327;
 b=Sq+1RXTu5cUD5tv0l5GDzLZyr9axuQCwszwDinQRw/u8vwL3f8RtgVYhHb8U6hlcaX
 wMLBWdy+xttpw/SfSu1NnHpqMDMbcNdmoOT/se85zMjdQWmo2k51QaBD7lMTs4Dv5gvy
 ZgKRB064I2UmJDYwPzKyzcXuXAzeZ2m4rpOe7TC7BA+cYAdL/efKLNXkfWoJ+QM3v625
 /hlHTKItDzyZa9EatSsrkuYP6am+QeJxjX8+chEFtPbFi3Ki2nNCA5pWnKInzQv4qgvj
 yYjsfQQeU0wpw0SwPxJSO2/o5/uIrKoNjBHbZAmrDWDDdvqWNcyJBtDhWEIhjSUBWBHg
 nZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oZ+N2C7armcWSDTKFEdMj1iRZ85pSXiFCDQRfpbkiy0=;
 fh=3RAa/3vx0ub6AjuJh1B3e7s5wOYZxHLSlaYZ6HFirDQ=;
 b=fix17TL7LPyRxmEgUjeE0glxVCf5Yvo1B1BoGd5FjQU6hHIhY9eE3oeNICSiMRXGMr
 h+jJ7qlHe+z7FOwHsmPO/z1BoZmnGy3Ix8heeUX7yqEQ4TBvjZ/uDly1kg8Sht/RtRRz
 lFlsspcKy5Pre66iDXLakqx7eYu5fLjeojSfuOV/+UqLYySCQDSDMeEGXksaFoceVaAo
 FP2wb6bVlb4sBU4uX0VYC9h+MwSYCEXvhOg50WpEqr/0GHDKt1ilTO8XXOEzH4it/NxT
 W9ilWBWR+6uVP2a5L3/OjTRf0InAI2xgtbnlwilOKD9h5yP4fDzUyBZQNXeLUN74d8ZJ
 KSAQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785274865; x=1785879665; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oZ+N2C7armcWSDTKFEdMj1iRZ85pSXiFCDQRfpbkiy0=;
 b=Txyn2r+1L9pAQzNqbs9CTckcrNxljrh4KSPEo3IbUcf3DC5PvrXPRbQMsn6gR2CugB
 Tjd7szpx3EuWAWpNU9GryqubGxG5isc5cTyGZtKQC3ovfsMAvGNotogsKyvZvECEZoxt
 A5HZkZHBQKkTAPiyB6Z5Xz3hW00yklM0ys7i2HEhffhqltHhNmed2TtWiObTtp2OHVoE
 6IybJNVTdDXalqG/RJL/HQc4FJaPoH/LKjVLD7lIb/8LiXcU5/Hl2GjYEuzCKtZwhS78
 8PTz7fXVWsuNXR4WgWHJa9Yh9ayOtT86Ppv/oL1Sb7CPVk/9ubSLP6LZFZXhl27ZgPeS
 A8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785274865; x=1785879665;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oZ+N2C7armcWSDTKFEdMj1iRZ85pSXiFCDQRfpbkiy0=;
 b=orhpROQHYQFhsVJx/21tjO2Y07+XIgGifFZUmHR8YD4aE0vl4ak65uTxlSZI6opeIX
 tLYkBAMDUtgelTwPBssBSCd88113QCyugKXB65I2QpQcqHTacpdRN8gLYz3OCi/7QzHP
 BcKq0tniNgWQGg4CQEG3tiAE1hymqqNRCQJ5pARBA3GEcpZEtY5yJ2VxEY41tB0uAzMV
 rBvFuAnErijZ4ABV2kyllIG1WL14JTuoZPkjU+ihcqK522xYJQ4vB8SVkfWgWgg+/EzI
 ksr9oXzCPg7Efulh0AQoHI/iPXhQ0Am9Nup7A+Ys3mcrRVLBT+LyOvifXjQsC3sa7Tbh
 lkaQ==
X-Gm-Message-State: AOJu0YxQaoEGIULpXviLk5krGBn8TIfJNN7sBeesA7YgnumywOC6gc8/
 1HmoTixOzFhVLm+yKwfblsbEpD0j/bEslwjwdk/LaOhnX5eTVrAp8nrnWMIH4aRqAJ1USVo5rJu
 dXp7KpNPXnxCXCm4yZ6oLg7fA3RmfLdk=
X-Gm-Gg: AR+sD11WeHpbEuckd+ZuCIu839nBdzD+h5upXhkLcyepj+NW7X9VVXDCZATYJopoa1L
 Za1InLJFykyzcDBwnZlquGa6oOB0uMyzSqCBbP3oGI3IvnxJRW8E3Qyssl+/Cf3cTuxZUGBX0ib
 5sL4sYa4ySdHP6XnfTWzrmkIOdqOTSFMFGsCsMvdFn/IqsNQgUXkD7HBi1BRWCqKbNYwe4Y9mUX
 2Mp4MzNmwvwpQQCY8YXXFmqHgU4lM9Nkq9+5WiQyNiekXGjR3X+4TI5pULL3slXseMy96tw2gdp
 MlGD6qQReh9PjX4s6N7o0/um3LKLtQFQWjlok+40BgFY/sETqFMBhJQhhvXEqxhKpbMD39WQCs8
 u
X-Received: by 2002:a17:903:41cf:b0:2cf:4c37:d955 with SMTP id
 d9443c01a7336-2d015f082famr43643655ad.27.1785274865124; Tue, 28 Jul 2026
 14:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260729-virtio-gpu-short-header-v2-1-18036a97219a@gmail.com>
In-Reply-To: <20260729-virtio-gpu-short-header-v2-1-18036a97219a@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 29 Jul 2026 01:40:53 +0400
X-Gm-Features: AUfX_myfNAnir7EmvrAbr83eiahageErFIIeS4CNPYMUCEkKX5vZxIR7nqP-pY0
Message-ID: <CAJ+F1CJo=t-c+ejrGcZfd3DDVb0Xh7CGpWUFaE9ojoWFqcM8og@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-gpu: reject requests with short/truncated
 control headers
To: Ankur Saini <ankur98saini@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Jul 29, 2026 at 12:45=E2=80=AFAM Ankur Saini <ankur98saini@gmail.co=
m> wrote:
>
> A control request shorter than virtio_gpu_ctrl_hdr can leave cmd_hdr
> partially initialized. If the supplied bytes set the fence flag, stale
> fence metadata may later be returned to the guest.
>
> The vhost-user-gpu backend has the same issue: it logs a short header
> copy but continues to process the partially initialized command.

yeah, at least it had a warning ;) (and a bit less exploitable than
full-blown qemu)

>
> Validate the common header length before dispatch in both paths. Clear
> cmd_hdr and complete malformed requests with ERR_INVALID_PARAMETER so
> stale fields cannot reach the response.
>
> Fixes: CVE-2026-18054
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4094
> Reported-by: Ankur Saini <ankur98saini@gmail.com>
> Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Ankur Saini <ankur98saini@gmail.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
> Changes in v2:
> - Also reject short/truncated control headers in vhost-user-gpu.
> - Expand the commit message to describe both affected paths.
> - Link to v1: https://lore.kernel.org/qemu-devel/20260728-virtio-gpu-shor=
t-header-v1-1-af19a00b100d@gmail.com
> ---
>  contrib/vhost-user-gpu/vhost-user-gpu.c | 21 ++++++++++++---------
>  hw/display/virtio-gpu.c                 | 10 ++++++++--
>  2 files changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-user=
-gpu/vhost-user-gpu.c
> index bb41758e34..8149834745 100644
> --- a/contrib/vhost-user-gpu/vhost-user-gpu.c
> +++ b/contrib/vhost-user-gpu/vhost-user-gpu.c
> @@ -924,16 +924,19 @@ vg_handle_ctrl(VuDev *dev, int qidx)
>          if (len !=3D sizeof(cmd->cmd_hdr)) {
>              g_warning("%s: command size incorrect %zu vs %zu\n",
>                        __func__, len, sizeof(cmd->cmd_hdr));
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
>          } else {
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
>          }
>
>          if (cmd->state !=3D VG_CMD_STATE_FINISHED) {
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 4d46a4eb10..15a845eff6 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1105,8 +1105,14 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
>              break;
>          }
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
>          /* command suspended */
>          if (!cmd->finished && !(cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_FEN=
CE)) {
>
> ---
> base-commit: 299e7557ed15a9a325620698add379a3ce2d1d95
> change-id: 20260728-virtio-gpu-short-header-476aa1dae4f7
>
> Best regards,
> --
> Ankur Saini <ankur98saini@gmail.com>
>
>

