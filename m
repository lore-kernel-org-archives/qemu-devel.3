Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE20C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojJO-00019K-K2; Tue, 28 Jul 2026 11:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wojIi-0000ua-Lz
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:01:04 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wojIe-0004U7-KJ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:00:58 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2cc891373e0so41469805ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:00:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785250853; cv=none;
 d=google.com; s=arc-20260327;
 b=nLGLx+ySBXGYVQ3icZJgOuQnthzzx2cHKVQc5e35VI5I3wxE7ew+tbnJblTvPiQy9U
 aQ6eCX9moWrahhXBFUZYjCp5/VMQvu6klahUrIfLrukk5/hx0se/x7tDt1e5Y4drXMMC
 axeCmBNCzQOdPfNC8Myn6XSNYbUVm7dOqh8bHnEKCGA4aJXk88zUM05mNhhjx+7aAxE9
 NgtTK0zQbt5kdQTAp5hSu/znXRjvPwqxUOvetAhFR1WwHCNF6C7GAS5x0LBVqu5XjjxY
 lUHQ/Yqicy5LKEfFKQlt9EOS0vSzQrGRu/Nkjapqlpy5GQupn0SrzrkMi8CvMZzxOay5
 z9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=I9nGH2HOII0KvYCyI1XiZ+VLE6CP0CMgf7y1ozKwvvg=;
 fh=ut2Ye+ajiSKq+5WEtA5sGQnab4rtdPfyqSGEClyB1fw=;
 b=NtNaIgwhHvrhjSwnYabv7Boymzw3+JVXwVdGgCn2yVXo1MC3h2UpK6+s4poBjAJsiU
 1Ifj8/Trq7J8KPpSttSkt/L7LfwXfS4EE7iw8Mbtu/WD0clTxqlGXOHhgsKGqB4moRuU
 Ypnq2RfD854qLicb0TnEXKoqACbxYk0KmgsUgWprBlhDc4y9n4VQxjhUlKebrk+8T/FP
 5+jfbBpcaIr3fqGpq/lY214dknfG52Ih/jO1PSnIj/le9rKFPisdi/+oZwk8FTAmSFJf
 F3+ZOoqa9CM2Zu/C/9TYF+aI76k0tB5K4d3M8nSEil7a87Ig0JhmOsAAa+6Xl2GFCFS9
 DAQA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785250853; x=1785855653; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I9nGH2HOII0KvYCyI1XiZ+VLE6CP0CMgf7y1ozKwvvg=;
 b=Nwde0NWQrptCiB/IEzqoLZZbWAK0MNl/MxTGEbmcD+nfhNr9cMHf+y+n5miTDP0JtA
 tzuH0YuZtCFdJxplyG7F2a5otTwjxxWmLad4CJ9XzoN5BRC3AZ3Wj80IWstaciWWBQzj
 1+Wj/3t4gUsaYr1Cmd7dwdgLeYgSoaLk7+W0cR7b+wDhcPEfSzWGqxNuiJMUq5sYhIkT
 mGHoBsal4pg109wm2LKFrhhfQ3yIzr5wnACiPORb+v/VAE7dwIMA5seybtm1kKZWgs3C
 s1scxXXq8qit8YI4WTDPLcSodFKNzVa2BOwBA5bImsxjg7Ul2CKG2+bMWsBgJkm4P7nP
 MLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785250853; x=1785855653;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I9nGH2HOII0KvYCyI1XiZ+VLE6CP0CMgf7y1ozKwvvg=;
 b=X+bZTyWpcaoF5+Gkvaqv6K1jKJEL35Fk9Nmm7UTc8USin9Jey3gNpUhlliYi2qIEwy
 sksZR/zam0emkzksGc8BYg09yEt5ZQolydrHJH+mSMGuz2o+dq8TU4mxgGgXCmo9zGGg
 jwC/aw6+znNIuVqINYCfvF5QIvEl03a5zOpozG1f4hV4UIDt7DHgMHbxjNKcbsMDdSt6
 ghG+c9x3c4ZEKwASdKSDsNuG/clk/E4BxwlYJmAPfJr4C83X804AHG52jHfJ8TkEq8nE
 JBBtF50GkuY3j+rRYF7g12VScWupteBYmOowpopShiMyDKFqU67N4YHmyINDc7Z6uwEp
 EWfQ==
X-Gm-Message-State: AOJu0Yy6+zSwNfOREyDOP7/ezcChAR0giJ4fRMKCdQBMigbZIFNqRlJ6
 Lk/+n/yV9cwkLKxrFy0gC+DwJGLPUOKOjkzDDokyU7IErKVDpMP4KzI3N9fF/doP1p55R3J+Wdt
 zkZ+J65w+o3HzyuMJplgNIIeGk0iRrTk=
X-Gm-Gg: AR+sD13IeBr4SObkPL3na3WvnwtP7srZDVMFpr3Z0g7xXnKX5KFeVm2TxoNRRucAWTf
 qhks0PNRIp93hAN+l4VyUVZ7kMbaeWB7c0DQDD13BTvky4qWEaZGC2V1Xvlh/v9uZ29vrGvSsGn
 eTqW0ra/9gVdWGyW8wF6lrbaev2OeZfS6EcbslfWHJIG9CbMHmACUcc7gZAdJrI5F3rmmZqd8dE
 CCXN13ts1E/9vHyeuK58/bfVvORFEx8FGnTve79L38cOj+EzKqp28Zt0YXIO9uRoLoICSsN0sP/
 c4F1Pf2udr39hSQqLw==
X-Received: by 2002:a05:6a20:c6c1:b0:3c3:a529:1e44 with SMTP id
 adf61e73a8af0-3c8ba5f59ccmr3295724637.57.1785250852676; Tue, 28 Jul 2026
 08:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260728-virtio-gpu-short-header-v1-1-af19a00b100d@gmail.com>
In-Reply-To: <20260728-virtio-gpu-short-header-v1-1-af19a00b100d@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 28 Jul 2026 19:00:39 +0400
X-Gm-Features: AUfX_mzYPhdyILP6PdOp9A4N_Pmp3P4aBDbDFvxcIF4vwQFY5WHivif1BQ2UFzE
Message-ID: <CAJ+F1CLyJxV4nBPQFse9dO8t4Pkx6y6G8+AS7cGF6eVNTEKDvA@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu: reject requests with short/truncated control
 headers
To: Ankur Saini <ankur98saini@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Jul 28, 2026 at 6:47=E2=80=AFPM Ankur Saini <ankur98saini@gmail.com=
> wrote:
>
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

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
> A control request shorter than virtio_gpu_ctrl_hdr can leave cmd_hdr
> partially initialized. If the supplied bytes set the fence flag, stale
> fence metadata may later be returned to the guest.
>
> Validate the common header length before dispatch. Clear cmd_hdr and
> complete malformed requests with ERR_INVALID_PARAMETER so stale fields
> cannot reach the response.
> ---
>  hw/display/virtio-gpu.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
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


--=20
Marc-Andr=C3=A9 Lureau

