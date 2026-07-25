Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE30EC531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 12:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnbn8-00041j-8k; Sat, 25 Jul 2026 08:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wnbml-0003u4-1Y
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 08:47:24 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wnbmj-0004X4-F7
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 08:47:22 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ca64c3ce5fso15365845ad.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 05:47:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784983639; cv=none;
 d=google.com; s=arc-20260327;
 b=VVjeoPO5wSnixDLSFFw96X0qVw1eNCgQKugYNll3YhfD96m65a444xJTu95PJ4EV1h
 DjTs4CjUSuqyvYex15vBkH30+5BkpgFEknF/qFiXAOcErSnh50l5HTs6oJaCbUlq/RTA
 2A/AmyCpw2KQaTIkgWYfQTTFhNdekopDJHXpN2ueQ6WEkRzujql2ukKhPyYdhX9cLLWl
 18d3uM35a6Mn5F/wsV9bVdDhH9Ibp12LGreX0KLUAqWk4x9a23wgTmWag2/4XzH0tT0y
 F9SO2Jo/934my3wixpL+rBoSnuHgmuGOtqexmrJPfSIJFxnso7JqarzgsIzpliKM7EOi
 Cfwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Vuq3i4V44wfJ//0X0jqR8Mz95XylNUIobmAcxYW2ayM=;
 fh=fWOTDz5YDRO8gq4Ddplx48s4Kmwze/7hZKKkVfzrGlw=;
 b=QlCEEp7TaVDhXiiBnghPa7tuxF6M8zlAUZMu/t4Q3KxXxbi6dUM6xwdj+FrNZddUlE
 wXgEFwi5l5Eu0EpwdqCUUmbr60QVRdRM8ayibV8utZwNpApVwJJyuqSSY04zi+aZr7n5
 +NJiRXtDAw3fsmTgJZ0mdFamqF9r1PV+WVutDvEumhU5RmMwCRFqpImwjc1cfhCz8RKM
 DvOSFVF+XWfKv2YMYUwzGRorwA4oyTTXSlR06TobkxlYaxqyKp5GQdVJlvH9UKi7qV0l
 3qpE8YP+D+CjJNN5lVuEaIaHDZE3yPQP774V6fo0IPYSTfbvozan+qLURf2yOjMrF+UL
 mx5A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784983639; x=1785588439; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Vuq3i4V44wfJ//0X0jqR8Mz95XylNUIobmAcxYW2ayM=;
 b=TACaHbkrjACvf7H2xsEGNrl6rkgp+4+okCphXxY19sWHzyrwbdTGk29PgOBhZ3LOWR
 /GYefOIN5QvmgtRJNK89Wq38IEXWuhfi+ZzfSKa6/Fo7UOCjjNIsRezm31xpH5QuQO60
 ptOoODYSiem606DkEcJGEOeOR6Ei/lq2c4DAXCnXcbTKPvw4t08N/PnLLm0/eUULEY8D
 oKkCCvSliPhBA+1bNOl2Ae4LEvp/qgw60jP4kwE2BJeTgKagbRQ0sT7bQrw6XVPGoK+z
 Czq4NS580P6vkFae7bZ6TuwzpE4BVxrxTqqJaVVJ08/t6qKZYVJcsrKqOmXOYcC99T74
 WNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784983639; x=1785588439;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vuq3i4V44wfJ//0X0jqR8Mz95XylNUIobmAcxYW2ayM=;
 b=FSAIR3gRC/Ufksw47JaucLckM2JL4ibPnhuNpR7ziI+VutXWFB1hREhl8h1ItY3Gvj
 hHCKR6tHU5iwtVq7WSJNCWn/HxOMqUzv2GQee7h0BihTY/36b3B3NWrXDb3j0Wpzv9JG
 c8nOB3bFnGTLSCsWP3p6EkpD8bUu8CQJ6WlhiwIwD1baDJ97CGEmGML3XShnw46Nmp3j
 /U5lD3VE/nBEBl5Uw5BUckQd4mmpEqUIsAY8zfqpBPH77bLIgL/EZ6PtK99ezy6VKAQL
 QNXT7YU+bkU0w8G7UpESX8u2iETDGoY8pqV5wXjB9vNY84rS/k4vQ5ECjRz0cvXse0f9
 3zPA==
X-Gm-Message-State: AOJu0Yy6//uPen5NwRyvmwfdIyUAiT/otOTKX2EqVgjQcu/wmD7MJbEf
 /0lbq9see8Yq0ffRd64ARGOb7RWSFFSACMCGfALiLXvQNoow8aoVGpCWKmDBL5DOqIFwE15MIgQ
 q8RO2YSNCLCDjvosw02/4Qd3/qG2+YcRLnFgbRlO84A==
X-Gm-Gg: AR+sD13gCpAAbTDWGU8d3pyocsFjt/VSlxfGJ7wFyTmT/Wa1KBD/YhDklSB/h3RuHKF
 NYAWjdkYPXwkht65+QlZcBw1/oJYJkSthtn8LVaq0+/KGE4i7YoLNdDr7AzYs2g9gbk2t/5BpzW
 Rte71e6+OVh+6CdDq8tna+fOGy57+VGzseJD/mksuX3zZairpHEOUI3yFtqY17H6ffS83CtTJMT
 tgpwhOElfIEDToS4X1c5L9QBAouXm+xXpZoXC3wu5amk4a333vWCawvqGVE56iHHQuJRIVsJzDo
 /gIRz/2VPbTIEHHYckH/yfwN+PlJ
X-Received: by 2002:a17:902:f642:b0:2c9:9a19:10c with SMTP id
 d9443c01a7336-2cfde867022mr20277825ad.40.1784983639530; Sat, 25 Jul 2026
 05:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260725-backing-v1-1-5b584bf7df5a@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260725-backing-v1-1-5b584bf7df5a@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 25 Jul 2026 16:47:06 +0400
X-Gm-Features: AUfX_mzainS7MwuraEXsGMu9-fEvWDj2C2vTXi3EWBXkHljHDoUCIyBH6qjwOD8
Message-ID: <CAJ+F1CL4k2irS4_OiN0VA+nCGFgG4pZz08xEnk1gwoCkzp6xWQ@mail.gmail.com>
Subject: Re: [PATCH] hw/display/virtio-gpu: Initialize blob mapping for
 ATTACH_BACKING
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pl1-x635.google.com
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

On Sat, Jul 25, 2026 at 11:13=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> It is necessary for blob cursor and scanout.
>
> Fixes: e0933d91b1cd ("virtio-gpu: Add virtio_gpu_resource_create_blob")
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/display/virtio-gpu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 718ba3039290..e886298ec42f 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -984,6 +984,10 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
>          cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
>          return;
>      }
> +
> +    if (!res->image) {
> +        virtio_gpu_init_udmabuf(res);
> +    }
>  }
>
>  static void
>
> ---
> base-commit: 006a22cb26998998385b104db1ff9466ef2f3153
> change-id: 20260725-backing-db0e69515455
>
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>
>


--=20
Marc-Andr=C3=A9 Lureau

