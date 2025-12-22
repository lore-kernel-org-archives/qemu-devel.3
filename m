Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2F5E677E9
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 15:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXhvS-0005Uf-41; Mon, 22 Dec 2025 10:34:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vXhvP-0005UM-VI
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 10:34:19 -0500
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vXhvN-0002wO-Hj
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 10:34:19 -0500
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-888bd3bd639so50751576d6.1
 for <qemu-devel@nongnu.org>; Mon, 22 Dec 2025 07:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766417655; x=1767022455; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3qN34Fe461jrVkd5+G33zyOeiWoHMrltBsXW39NmJC8=;
 b=GpmYFFDqe4xAGAoPxMfojPrdiWNjMdaIL0lluykboJ8CfTe5CwOgDm2s3tGPzkFG9F
 jGCOoA3L1Uf357njVXFtYWoEISAscZuvEagLQj5emVS/TSwYvP92Xgcy8VpSUlDkN2VI
 Lj4cl+wkw+oYZMdr4vfucla/ImFaDTXkoov0wlX7P0yjQ/bGQp55AWj5izH/YSdEbKzp
 sYXjPmUbL1rsM5bRfPEhnEzw9BEIXQaS6QCEc4y6uiUxni08wJ80A7bh4yeDUHXc+Mtj
 PSjDSfV0rl4wMVhpuIdV4tbUrhBy5Tvbg5x6bW1FPjRsQEIh1+mVldCiVguvLr+5omcs
 od5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766417655; x=1767022455;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3qN34Fe461jrVkd5+G33zyOeiWoHMrltBsXW39NmJC8=;
 b=SOVmWU/qxXSxaYCdXvR37yLPPa84R1PwTKUG0AEdxmnD/gHeZuCy5reapPSDK+ksnM
 Y/m4oELPzVMNgpKVFizrJcUG31dPRas8navFIrpxJny+vkSGvV5ct0/e8MhoJRuOXThK
 BbwIbUg2hzZdAl/9DJhbkUgZIkIcr9BAG62/nuQXasWDUtetl7tBQAOJLCESu0JSVrWc
 Ttiw10RQktPgJjOACLMed31O5Oj+tHLL0/dV2Eu0iAJ7dfyXZSv/2fpaoQ+g0aWMk1HS
 p+4N5qWbjjvtv0UNCKxZ3wAwavQo6+y2veDnC5s3pVmAsf85aQZW9VPBGxJqpmFvzrQE
 uWHQ==
X-Gm-Message-State: AOJu0Yw4z8UQvbodMI4LGTN99/1zHbM/JC23smaAt28mdGn1/345w6v2
 rqhQXMB25/vKUp9HKosZsaeLHIynmGpUsZYB1PLjSmkD4hZ2sSmVqdPNQqqOjacA8tU/ajhqELp
 iBhl+khjvFY1TTihsLp/zm2URgcJ9284=
X-Gm-Gg: AY/fxX595wK8ZjLb6mb6NKTkIEq372XAKyi8oP+73LBKJ8cnkKiAUctbWJh0pdjycVd
 h26hikbSjOw2+jve5Voi9Hlc+YaTEk4ogzAYXm48TwgrowLThHXdBvHQX8eFKiZWi9MCEtuW8Rw
 2EXg8wiWYVVCugzrhIQpg9g90Dnga3X6eUU/mfI1+7A0XTZvdwyvBZCPzkX36+SAgdWzpZza/67
 7kcAKAq1m8uZj2a/9WFWg5044VPS2IJe3Z6ZsUbtZQKPn6f1mEmZ7Xm2ouPGYDqknnmJAxuicQK
 T49X+hM8bSJCTaXiUritRgCMKJc=
X-Google-Smtp-Source: AGHT+IEuYByg8J0bv2+u3YUlYycRuM910YQcjonezjWNRa8PDLP7mMEsZc7WyfcLzvvT4BQ+5b1rS9xH6FgMdUFpavA=
X-Received: by 2002:a05:6214:2f90:b0:880:5589:54cd with SMTP id
 6a1803df08f44-88d833b7eccmr158879426d6.19.1766417655156; Mon, 22 Dec 2025
 07:34:15 -0800 (PST)
MIME-Version: 1.0
References: <20251222151259.3965-1-j@getutm.app>
In-Reply-To: <20251222151259.3965-1-j@getutm.app>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 22 Dec 2025 19:34:03 +0400
X-Gm-Features: AQt7F2p9V2Ddm0w6MexWeLs2bKQtvG7Mul-755VNLhBgla4wMX4x4qJna7pDCbg
Message-ID: <CAJ+F1CJBjM+s0vgCj1T3tFib6SQOV-RJEcrEpCLv==K2UCRLpg@mail.gmail.com>
Subject: Re: [PATCH] virrtio-gpu-virgl: correct parent for blob memory region
To: Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qv1-xf34.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi

On Mon, Dec 22, 2025 at 7:15=E2=80=AFPM Joelle van Dyne <j@getutm.app> wrot=
e:
>
> When `owner` =3D=3D `mr`, `object_unparent` will crash:
>
> object_unparent(mr) ->
> object_property_del_child(mr, mr) ->
> object_finalize_child_property(mr, name, mr) ->
> object_unref(mr) ->
> object_finalize(mr) ->
> object_property_del_all(mr) ->
> object_finalize_child_property(mr, name, mr) ->
> object_unref(mr) ->
> fail on g_assert(obj->ref > 0)
>
> Signed-off-by: Joelle van Dyne <j@getutm.app>

Fixes: commit 7c092f17 ("virtio-gpu: Handle resource blob commands")

I'd suggest an assert for this case in memory_region_do_init(), as
that seems undesired.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/display/virtio-gpu-virgl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.=
c
> index 18404be5892..4109ff7932a 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -123,7 +123,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>      vmr->g =3D g;
>
>      mr =3D &vmr->mr;
> -    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
> +    memory_region_init_ram_ptr(mr, OBJECT(g), "blob", size, data);
>      memory_region_add_subregion(&b->hostmem, offset, mr);
>      memory_region_set_enabled(mr, true);
>
> --
> 2.50.1 (Apple Git-155)
>
>


--=20
Marc-Andr=C3=A9 Lureau

