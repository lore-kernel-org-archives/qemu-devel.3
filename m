Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A68C54FDF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 10:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpNZx-0007pX-6l; Thu, 30 Jul 2026 06:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpNZu-0007pI-1S
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 06:01:26 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpNZs-0000si-EI
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 06:01:25 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-81eef95653fso19676137b3.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 03:01:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785405683; cv=none;
 d=google.com; s=arc-20260327;
 b=Q6o1pYKWZxVvyntG//nyCGK/CDNUAfvH0hjfUdVsCoPxZUFx0vt1FQOVEOal1LolpZ
 VNJb+L1+NKHRyIau4NKsCL1KZ44GoG2mGh99jxvvem0MNBiyF8BgS/bL0pJMNu7jR+q2
 htzL/FRCkqdlwvBa4c5Xp2w2o+yBM6SdAfRldln8VlyjjFVXE7o/HnFN5JuW6wda6GMk
 eZ6zavFwWu2WAbTLRiUyerIqgnYMLldIGk58/XbtOeToMgeS5mm5MDHn+V2PAuYks9Pc
 CHSruuX0ft7Bm4kIlk9rbrRI3suLIJGb7VjpjWFlCu4Zn9cE5uKjIwawqPxkD8IIguUA
 O8Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=P/Mp+0yMQyzZMoOj4/c0gNHEj4eagwIPAsKb9yBtZw4=;
 fh=0S1te/u/jyDlhoB3tvqQYV+iBKDK8Bm69l07N0IsbL8=;
 b=L1pxuyLmBk6a3l44Qsg6YUPMydW/najODnlBPrpcOfjh0h+gayC3GCbW/9RjMjh7Tr
 vHlROL/XqwTU+0EIR9jjnfMDzXllR0SwkvUOK+S0ND5ftTmbbuM6vgcki/+nesKayfxv
 rkcKVwQkFDA7r/RVIeEuCUUuPo4Ozkrwnx+Ntzeoh7VdK3Ug7xw7N6oGJyDGDF9NO8H1
 8ho0A/nBVpgkWYwwSAuKuAS4jaddmqJs/VI0Yizp3GZ61xqkwtgbLa8nMETEDCuRl32W
 U8TSpQUY5lQSHa/Zd6lVdJZC6Zs2IizUAk7SAoKUR+i9hVhvezO62V5wZQhr+B379ak/
 nElQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785405683; x=1786010483; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=P/Mp+0yMQyzZMoOj4/c0gNHEj4eagwIPAsKb9yBtZw4=;
 b=PEVi+LIuK/Mn6QOriLEdCUsOOIOmMKx9/ov4GaTmEjufvQcsKNuj8FNzMBaEABTciU
 d3wGzCNOlLomV/cXsEYbisioyTlpqG/pKb550HCWIwkPVLrJO21MLtOpxiX0GCkv4b88
 mNfWyPk1loOtuVQh3ydvB0VhUmAzXNQdzHWTR890gUaA/ak7z5+PIMX/9nb/scukPF+U
 9+ZshvXDCQmf+Jh1+NhYdTdnlvd3TlohN0+2fte5yUhXIyWRMQboDi/VU2gc8v/P7veT
 HHUUH/2Ur0IAl2GcSd4K+vGEpmS+aTbkkPIZ575x3MlfXupJlK3/ldBWz9KR4TD8zQRk
 deNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785405683; x=1786010483;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P/Mp+0yMQyzZMoOj4/c0gNHEj4eagwIPAsKb9yBtZw4=;
 b=TpulTvJa94P6ycD5mpgg6fOkyu+zM1/wprV03Fb6jl6t0haRxc7bDOQKRaPGlhQpmb
 Bv6ENsEv5rtt3npb9LHUEJFLYUDmodEPEwtJOY4FFCTC8N0F9hrZJp6wNfMkhdE7qAf6
 TQwY3/NvqWeDA55wC6229UMyHNyKrJ7nsHfYAAtwMZj9u/i4nei1povaiYoDi9nn+po+
 5XXDyy3svld7jiB1h9kKMkJbXc9Gtf4C8vUKovzkNXpmwTopRqHtikrOnnFB9bMPI65p
 rfBtXlXlsfkl7TPT/P6jRluwhcDUicnDBzgaHd0BbfsPb5qejox2NCicjQKwzMxZz/dt
 iJlQ==
X-Gm-Message-State: AOJu0Yyz24Sm+Jb5qj2aepTOpJVTsEjmqv1751Xixi6TRBaGXkuRzwe8
 Kb7dwUoI5uJLwmb6TMtiZXGA8MQatA9UypIDO+6G8ZGGU49XRxT1IWtq4gc+bzZ0GpZ2zn7Figp
 yJ2stiiQtu3u0pYzyKmj8vcE8E7mm/vIe8nQfQh+6uA==
X-Gm-Gg: AR+sD1219Q4mim9opQEMw2GcszxH0++LrrhGHaxU2Z/nK3Rl0NkZrpvFD9ICm8t0DDN
 j+36SzAryHPUfDIwRGSdrFB1g8n2cKhuU1zqfAmmyv3rshCqnMFPoqlLmhmDWfWSypXG3XnsaXo
 8/OeZSsoPDOhEUv/KIBDQmviJrJZTRzFoCOGeMBXpysutViecp/rhUKygp7Q0Rl0vH/3l6iiugV
 GU0h2FgVxZp6QprYpC4Qgd9kZ/kqZMcKp2/zKw+u+ItktjQyzzeJXwLPazabwVFH6o6trCX5Zkt
 6DOqFrorUaDabhYL3W1Opgg1Us7t5BDpuWMSqeXjgsfzmX4zknlL2ew5lsQovDyC7KadWzQy2yC
 WqoMCjzS7Cbdk5ya92Xy/DJFiEzgK
X-Received: by 2002:a05:690c:3744:b0:81e:776b:ba51 with SMTP id
 00721157ae682-81fb8b3e74amr12539207b3.58.1785405682739; Thu, 30 Jul 2026
 03:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
 <20260727-fix-v1-11-ca3fa3851347@redhat.com>
In-Reply-To: <20260727-fix-v1-11-ca3fa3851347@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jul 2026 11:01:11 +0100
X-Gm-Features: AUfX_mxs7FzIdxxvcXYzBEL2kSRitDgg5UC9DMfJVwMU65uNV-MCPkPUQWTJT-8
Message-ID: <CAFEAcA_hVqYGFWGMnWEYcA9to29SFvpzseo-zTv-Pq+uLdyMiQ@mail.gmail.com>
Subject: Re: [GIT PULL 11/23] hw/display/virtio-gpu: Avoid leaking migration
 blocker
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 27 Jul 2026 at 12:53, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>
> virtio_gpu_base_device_realize() leaks a migration blocker if a
> check of the output list fails after adding one. Perform the check
> before adding a migration blocker to avoid the leak. This also
> simplifies the code by merging two loops.
>
> Fixes: d3a4969dc5ac ("Support per-head resolutions with virtio-gpu")
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Message-ID: <20260725-virgl-v1-1-58bb51e60da5@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  hw/display/virtio-gpu-base.c | 37 ++++++++++++++++---------------------
>  1 file changed, 16 insertions(+), 21 deletions(-)



> @@ -207,6 +212,17 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
>                         node->value->name, EDID_NAME_MAX_LENGTH);
>              return false;
>          }
> +        if (node->value->has_xres !=3D node->value->has_yres) {
> +            error_setg(errp,
> +                       "must set both outputs[%zd].xres and outputs[%zd]=
.yres",
> +                       output_idx, output_idx);
> +            return false;
> +        }
> +        if (node->value->has_xres && node->value->has_yres) {
> +            g->enabled_output_bitmask |=3D (1 << output_idx);
> +            g->req_state[output_idx].width =3D node->value->xres;
> +            g->req_state[output_idx].height =3D node->value->yres;
> +        }

Hi; Coverity points out an issue with this change (CID 1664272):
just before this added code there is an existing check:

        if (node->value && node->value->name &&
            strlen(node->value->name) > EDID_NAME_MAX_LENGTH) {
            ...
        }

That check assumes that node->value can be NULL, but this added
code assumes node->value is not NULL and unconditionally
dereferences it. Which is correct ?

thanks
-- PMM

