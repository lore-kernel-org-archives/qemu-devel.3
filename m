Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED373C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DF3-0001kP-T2; Thu, 03 Sep 2026 15:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x2DF2-0001hH-9G
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:56 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x2DF0-0004QX-Hb
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:56 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-855de2d0d4dso2917347b3.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:36:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788464213; cv=none;
 d=google.com; s=arc-20260327;
 b=MdnTXU8Cr59zVxtMlnXfQ/TMYuXu0+arC9YPXepT15wGkcN7u7kGP7/MIUDfBRUt3w
 jgvOfJheOLR5KZfz5fvpfkgQWEBwZM+7H0ozDu4Uv4Itpq6WuLDv2/cxFdEQD6xFSExb
 /jnzXXxR/K59Uc+CQ9Fbfr5kKw4cSnnyYWyGkFxV+ybjuadJzOFEll5WxiaYDwUK++4T
 3C28P5Shp1nFwN/NVwhSRO7I18I02cdeSYVw/HkX73GM7kUfarIHAxdDE86g6nE5Y9w/
 k8aWHnYeTH/IWHsOnYc2G1uMOUlk5mfYDeL+01x12wChaxek+9m3EhSOigiQVlQIJy0z
 YmuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KnvKmW3TBZyzaFw7n+49BT3yo9R8atu4JaGZc62F6oU=;
 fh=PFYX6U2FHRZr1gfgcCQLKcBI9fIgRHJN7OKNLlsWtbg=;
 b=aDJ8ZwItsKrx1nZNySpZzy8PLSuCsA9Blg2p8FxjmmOEF9Is3B1KLzJWFfa7x9zPKk
 CsLfFIKPi+31DtC6m63nqPunXnLA/1/Cy+AeniMUZnRgxTdrsYUrmO/h/h5biV1cGrkd
 nI2sKuCaXk0TtnSmysrxu96cIfER6w1uAmOaA13FfjUrfvjqqrg/AGCv/VdqKS4MtnL5
 VfCvjxdZ7o+ERj3BmQy1z6P5dHrWdLEV5lxWLylanpBWGaV031PUKv+1cH7JL9AnJ0xI
 Vnk3f3IOTS07uq/lybs9sVZDXoHIuMRB3xhCT2xh2GtvpRB98FZabHyEj/pGIdl+hLKM
 6onA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788464213; x=1789069013; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KnvKmW3TBZyzaFw7n+49BT3yo9R8atu4JaGZc62F6oU=;
 b=KzFs2P0YmsB8EUIzmgfgSreZWp0RzmKdjCK5fWSB40WRAsdMLxRkOnezyWSh0RHHIo
 UQhOOj/nljB4LuwR9I5heu4aMsL6bR5UOA9lzaJnOnVPYvHevl8KSG9nEK2y7en8ujYj
 CtPL2V2oaXyu/03l63vye+qUtRGgNTntVprZCcbwfqu5kVesQsK7k9rkQ/IR8kbtniV8
 Aykk1y0M2KbIxhlIeRlWjREehVAGDoVKGulZ3/8pVj3+St/GSeARkooop6LkigkHIdeU
 Qnwjybv0jl9xKpUxTtvRw7B+rQcHaY8c+gH0PttkxGGSgO65oGB5Mex6XRLwtNa3lq5t
 guOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464213; x=1789069013;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KnvKmW3TBZyzaFw7n+49BT3yo9R8atu4JaGZc62F6oU=;
 b=L6FWqS1+otU3QVYz77POxT2WcbpxKlWsGlhebwVArlHinwDvWL1mrH1OiwgVgvmPZx
 FaBwYsTzleyXfZsOGITmDiE+4dsXzkWLd2hwfnc0633SEdP2NEzLP69pwaEWOY+QVkbS
 JjXkCSHQZGdv5NlssZEIwOYJMBVs08PJd5U1ngPuEXf7wkcSdrEZXFjyD1iKk0EKG2AC
 yeS8bonuKEjcXWG9ECJwPzAFhtqqllEDb5S/2I61rQVhz0kHwZ8l6FUcgqsJtz6vRAgU
 eth2pP3EdxY/FTmLl6vSKHI+tuV+cDWkLz1mzHTU84nOBz+tbTB6jLAFuRFEbHf4P6+2
 SkrQ==
X-Gm-Message-State: AFuF++maNW9VgD2wxD2ufGzgNLI2JUSm+SZJGgSbov4cb5s/j+MMEJBG
 JI3p8c1z7mxWhr8UXkOS7wSkueSi6xEqMdTbgcAhsUsr3PBioEfXMscnd1bHFrZKZvd2Oax9iMg
 Zejjwr605Oy482fICYFzu6un+cP6rrOxkoUD9oE4azA==
X-Gm-Gg: AYBFou19aUSyzWeN4/ZI21L5TmBHJeoIW2cSxOYMzGAojiTdBs5hF7P40VvhETtbCmb
 OVAdRttt+V/w71EFpKrBdx+zuFaoJ4NbcJZjehSbD2PyKJFw+F36ufWqPEsqpyqTPQzwdUwhB4h
 +XBYf1BeaIuSto5V6g21gIrgvnaWRf3ASSVq+xrz83ftOAFTUOutrydWOun7EGGENONaEpcOTmI
 sDWE9Q4ifKb3iYESqda8w06jqC/EjRbx6WnLLaWHTW5BZmvMplTye/wHjaPEWvN3Hn9CkgPuIgY
 pswC/0tsCf1LQl4YJP3xt+u2DsFAD+O7QWRnDJLRoRBmWk063JROXo4drJ0na2KHMbreOC/Ufsl
 I+w5gjV8ZCBoO3SVHUDmgjnVlbcAA
X-Received: by 2002:a05:690c:9e:b0:825:468e:e0eb with SMTP id
 00721157ae682-87184ce3443mr405097b3.15.1788464213023; Thu, 03 Sep 2026
 12:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
 <20260825-fixes-v1-5-c59e8a620836@redhat.com>
In-Reply-To: <20260825-fixes-v1-5-c59e8a620836@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Sep 2026 20:36:40 +0100
X-Gm-Features: AcwNN1WHFLy88AH3YdI-MbJaa2hm_9OytCwGn0ijwm41kJRY7Ix158rUS4DyKKc
Message-ID: <CAFEAcA-e1N+f2G+ah3=9OXD9oM85ZEzUD3-DuRyrRg8KoU3ZDw@mail.gmail.com>
Subject: Re: [GIT PULL 05/19] virtio-gpu: use g_try_malloc to avoid
 guest-triggered abort
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Tue, 25 Aug 2026 at 12:29, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Use g_try_malloc/g_try_new0 for guest-controlled allocation, so failure
> returns an error to the guest rather than crashing the host (glib
> behaviour).
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3898
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Message-ID: <20260805130141.211398-1-marcandre.lureau@redhat.com>

Hi; Coverity has some notes about this commit (CID 1685636,
1685637, 1685638):

> @@ -498,17 +498,22 @@ vg_create_mapping_iov(VuGpu *g,
>      }
>
>      esize =3D sizeof(*ents) * ab->nr_entries;
> -    ents =3D g_malloc(esize);
> +    ents =3D g_try_malloc(esize);
> +    if (!ents && esize) {
> +        return -1;
> +    }

This means that if esize =3D=3D 0 we will continue even though
ents is NULL.

>      s =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
>                     sizeof(*ab), ents, esize);

Coverity complains because it thinks iov_to_buf() might
try to dereference a NULL ent. I think that's wrong (a
zero size makes iov_to_buf() never touch the buffer), but
it does raise the question -- do we really want to be
continuing ahead here with a zero size and NULL buffer pointer,
rather than handling zero sizes with some kind of early return?

I think it's preferable to have the "allocation failure"
check be a plain "if (!ptr) { leave early }", because then
static analysis tools don't go down blind alleys assuming
that execution can run through all kinds of paths in the rest
of the function with a NULL pointer.

This specific check is what is triggering CID 1685638.

> diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/virg=
l.c
> index 550fd03bf5c4..20bae57d0fe4 100644
> --- a/contrib/vhost-user-gpu/virgl.c
> +++ b/contrib/vhost-user-gpu/virgl.c
> @@ -209,7 +209,11 @@ virgl_cmd_submit_3d(VuGpu *g,
>          return;
>      }
>
> -    buf =3D g_malloc(cs.size);
> +    buf =3D g_try_malloc(cs.size);
> +    if (!buf && cs.size) {
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
> +        return;
> +    }
>      s =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
>                     sizeof(cs), buf, cs.size);

This one is CID 1685636.

>      if (s !=3D cs.size) {

> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index fbb6fec7a0ad..9eb010082d0d 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -892,7 +892,10 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
>      }
>
>      esize =3D sizeof(*ents) * nr_entries;
> -    ents =3D g_malloc(esize);
> +    ents =3D g_try_malloc(esize);
> +    if (!ents && esize) {
> +        return -1;
> +    }
>      s =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
>                     offset, ents, esize);

And this one is CID 1685637.

thanks
-- PMM

