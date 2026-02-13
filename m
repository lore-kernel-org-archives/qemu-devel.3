Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3600EDF16C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 14:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vquB5-0002ic-Pq; Fri, 13 Feb 2026 09:29:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vquB2-0002hk-1L
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:29:49 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vquB0-0005R5-H0
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:29:47 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64ada2c30a1so955406d50.0
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 06:29:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770992985; cv=none;
 d=google.com; s=arc-20240605;
 b=aVj602/ttd8cNJLcQHqRbxMcTkZ+kKxlap1H5htQ3IyZzhwU//lxCK+2UCJq1FsMGr
 oJRVB97lmdmTMSbnY0cVyIDcYetehp+VJPU7uNaegs5/ktf2MGHY468t/HeOrVqsY/s3
 DSB2vaUJgH5fi8+HFI8kpqlZbl2wMZNV9YEZIVGXP0fyFmDq2q7FSWIPjkZNpLcXtVPZ
 x5/FrtieU9W2u/Rlo0GMm3mQCn8YK9CEqzSbVnNlEOFFRflqOM9iBktxVj3sdqDTcbQs
 4tXiBViKiTGYCL9nwmZysUVtl72HIfFrj9yBTNrNvEcs6sKQeICJ0wBpCGjPXoToEq1S
 wDaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tqwK3yBORotpOSI0CUF8Cx0yzJehZCvRyr4GhVdd9PY=;
 fh=SlNjvCS/vawEqeuCNP/be0Z7MFgKr1Z+zcNNBB5ZzQ0=;
 b=A4ndKERxw2YKHriMH2e6r4f31lywZvOHy6Nd6y78AWfTx7qzfTGEZT7RhSz3sA+rel
 DDhx5yfJpOWJuXywPVBPcAvLUF5PD2/e33rJMfmR3Aao9I6U30XhDhnsT0yhVwgLaebF
 wxi2a14FHuOp+dUyiYF0weCk/y7HTCouROIAxe1InpJCOCrZjPfGJsUPUZ68uN25iSTt
 M2pteXZG6/ueYx06lKwgAvGd97kg9uo1dyUAlbG0bx9xEVsdHnzZOdmOa+6OMssOU0IG
 tGUhK2duLTpgY6LlDulbkS952DxosWh8ZppaybV74/aIKrhxYvQQHhwSZFAZ/LRTHF11
 1WQA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770992985; x=1771597785; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tqwK3yBORotpOSI0CUF8Cx0yzJehZCvRyr4GhVdd9PY=;
 b=PLvq30HFd4eYSxW4nDLWly4Od3z1Dc7Dj5wOirqZva51CvCPtc5Sgf9IOs2GonKKjy
 /JqH4qxJxptd3KbmWQAZo6UvwybRFI4OKhhDusBJyFAJrvAoySJ59e0lY2ITMGdgXeG2
 G7aYu6+tO7yg6umpcZBOIkr9Ck4UyNrHv9yYD+r21yylI2NybYz+bHqp1A6XaLLK/jn6
 9FW7edwT2NYDQg7u9M+XSyqUfLorabvKP30vFzAs3GvF/xDMitEPlp98AKnHSPufys6s
 OJU6cuCglPXTkgciLfILiWkBYVBCkDboXqIMdOfoi14/7AFHRu2xJ1xXYknFiXcuWYA9
 TEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770992985; x=1771597785;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tqwK3yBORotpOSI0CUF8Cx0yzJehZCvRyr4GhVdd9PY=;
 b=MVJBo1F09Wt2YFFGqxKS4ctnv3mBctZaBlgVUaMRt9+Jb6qk5VcUpCY0/k3xVOxYF5
 5+jYH0gcFV5HhIya1SJ7HWtp50w8fvDHZRlmH5JwEg56hNZ4rTVX11Fei9+A9X7M9x3k
 4SprBC2BHFSZhpJGps1kGimz1st7KLKazYc+/E3MireGiSkcL4dAn1G9D4GHVxfXi50S
 Twy4ONCEWhyedRwFOwV5d5/OdR5acvlCZEwxSt+24PUMwUMjpnfgrBVwLcqFcPcsJLNm
 xdVGtZ5IvSA1LhImSq6ZtKkO0KasZFPM2PVkbKxIklreEizbcZJ0NEJtc9j//TW6Fq2l
 t+aQ==
X-Gm-Message-State: AOJu0Yw5ZzLDnu1qiy09Ee6wfrJJuf9KKT8o+hpXDz8YPCEZTPwfet25
 NTggDchsJNqTfGeqob5DGUVcLUq4wH9UygPgxRWVeIzbTbOuT3cUjY6WFAWVvjQRkYu03C4vJv6
 462ol0Gg069bOS5P5c5Wn1ZNt3zsduhrzqgkcM7kgyQ==
X-Gm-Gg: AZuq6aJ2SKRSSL3pG/22+hKxpoKGPeV5uJq3gu/+ePEJLUmLX0RhpPkFItDmK0/u4wZ
 3II2ya4E+Et4Fqy0IQ1OBlscE85iCj+BswLtieWw5q1T6zH1qVXQs3TGP1aZj2VxpfZBMwPgZPu
 ohM8lrAA8WupSwRlUrtCeYA+JJJnt+vD8AOQXjqEXvGIAzz//Az9lo+/FKixYY6BJIm6MiwIypJ
 DsutaEyQY2UrSmKWABXpNX/k/PFKWW5EGEWGXFePKgnAIJoc1kAFZ29r/qoGqPjbQsEfKz0nlcy
 fImxXb8zLRX25MaFlIcU+JydQGl+c2doKZAkf1JGN3bedIVe8T97lPMVsXVtptOX440=
X-Received: by 2002:a05:690e:134a:b0:649:b4cd:b539 with SMTP id
 956f58d0204a3-64c198c9bc3mr1275325d50.35.1770992985105; Fri, 13 Feb 2026
 06:29:45 -0800 (PST)
MIME-Version: 1.0
References: <cover.1770231744.git.mst@redhat.com>
 <81cb15cf3774140da7c17341018a3852f920acb5.1770231744.git.mst@redhat.com>
In-Reply-To: <81cb15cf3774140da7c17341018a3852f920acb5.1770231744.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Feb 2026 14:29:33 +0000
X-Gm-Features: AZwV_QgFObt9rhrJWn73X6IuIXAcPZJWlpGLEVkBttoZHudblGCwhNVsRE6KtLA
Message-ID: <CAFEAcA_8jB_KLzUzLS1=uG3y-nRRK_C2ZZp9SwKo1WrGu8dJkQ@mail.gmail.com>
Subject: Re: [PULL 41/51] virtio-gpu-virgl: correct parent for blob memory
 region
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Joelle van Dyne <j@getutm.app>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Wed, 4 Feb 2026 at 19:04, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Joelle van Dyne <j@getutm.app>
>
> When `owner` == `mr`, `object_unparent` will crash:
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
> However, passing a different `owner` to `memory_region_init` does not
> work. `memory_region_ref` has an optimization where it takes a ref
> only on the owner. That means when flatviews are created, it does not
> take a ref on the region and you can get a UAF from `flatview_destroy`
> called from RCU.
>
> The correct fix therefore is to use `NULL` as the name which will set
> the `owner` but not the `parent` (which is still NULL). This allows us
> to use `memory_region_ref` on itself while not having to rely on unparent
> for cleanup.
>
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Message-Id: <20260103214400.71694-1-j@getutm.app>
> ---
>  hw/display/virtio-gpu-virgl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 07f6355ad6..6a83fb63c8 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -120,7 +120,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>      vmr->g = g;
>
>      mr = &vmr->mr;
> -    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
> +    memory_region_init_ram_ptr(mr, OBJECT(mr), NULL, size, data);

This looks very odd. The owner of an MR should be the
device that that MR belongs to, not the MR itself,
and usually not NULL either. The name should be something
useful for people looking at the HMP info output about
memory layouts.

If there's a use-after-free issue then I suspect that the right
fix must be somewhere else, not here.

thanks
-- PMM

