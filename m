Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8593BC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 15:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNDOc-0003mc-HR; Fri, 28 Jun 2024 11:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNDOa-0003m8-Cv
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 11:20:16 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNDOY-0007rR-Sa
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 11:20:16 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57cf8880f95so1002891a12.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 08:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719588013; x=1720192813; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=29q9/kTFdKiSwP8WIESsqaL6j0WiAfqyjBbV89YWouQ=;
 b=RBiBjCBGYWfeWPCUbbWVzhbUijsnJ5H5eliiOGLnzWV6Gy+EVn+3BneJ7GVJOcKho/
 W1FE+9RaQK4DrtD0rb9SFTu4oaFDfs62ELcAm+oGe3s+tta6oPAYKj5DUD3ztFYSCqji
 N3DJHZtsyrC0yw8/jQn2EI+LjadcclOsFsUgfagcrk1abyRGq6dPIkwOb+4RiZETpLAS
 IxWZL4SCb/eXVb+NvP+mF7lxHg1GsKjuBtPGUHrfF0v9hvH2Aq3jfjxqEJSQfSbl9JdG
 1PCDSL/3o6UTK5pT0DgUesOjT47zFc1hJEkcYlmPOAXX/gXfJhBqF/kmoYqhuEoVbyyi
 Dxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719588013; x=1720192813;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=29q9/kTFdKiSwP8WIESsqaL6j0WiAfqyjBbV89YWouQ=;
 b=kNY8jivOVd0GGYgkrRhoeolgzq+CyeJsh4i34taPsUdtsXFkVoWZv7jFJpPHudlPTV
 cecvmE2infP6LFSUVz+9rZrno700oFgeTKVk6sTxo6ak45BvbnuFDyvV9fqbAt16RgX0
 37tAhkpPJJY/oslj03gpu3B5IBIUrqAz6CeS+MaIXPYBv74JQA6uyv7GMqgITmSXf0GS
 ZEOOjDwagmnx3d+TMGx+ofirT/++ikUOu2pwfiCdH1YO0LhF7IH3hPtn7Zq+3Gg7QcyF
 mFqV9nwAdVk0CQtZMlseLQ6Mxd382CiRoJeV1xklJtPyNv3MVKWm9IhqDf0REFRsCXbi
 V6bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5cqVLkHvP9GiMiv+bx4BCK/+rG3EvJkotrZ4Lq+kJXHa/iBYDlDhE21Cwj5PqvEKw0wn1kiuUDhsFKokmaUkJwzCu1IE=
X-Gm-Message-State: AOJu0Yym0mx2T8+hdWW3gDgrzNwiaGUp0XqUYkWxQe5/IlR+ZrGKmsOc
 JjTJ8oNDrpuF6ha6KMK5x0ZUIzB6zdYYE8CAvsHVk1RRi3nfsbJeFxb81iw897uESedA01s7+gb
 ySjQzlpHPWso7egqlbjoBPlMWKF/F79Y5vuUv9w==
X-Google-Smtp-Source: AGHT+IFwq7zCapDmqiYDNDWukZIRN3W76PmzDqGwNbfaeijvHsiHMzuOmM46yO07qLbe9jQrGDuW7eGhoFMnumcgtzM=
X-Received: by 2002:a50:8e19:0:b0:57c:cba1:444e with SMTP id
 4fb4d7f45d1cf-57d7003d5bdmr10492855a12.13.1719588013228; Fri, 28 Jun 2024
 08:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
 <20240627-san-v2-6-750bb0946dbd@daynix.com>
In-Reply-To: <20240627-san-v2-6-750bb0946dbd@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jun 2024 16:20:02 +0100
Message-ID: <CAFEAcA-Zmc0BQgUiqEgzCvVGWyiPt9bo+Xt90n4wxhJ3_D91fA@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] ppc/vof: Fix unaligned FDT property access
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, 
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Thu, 27 Jun 2024 at 14:39, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> FDT properties are aligned by 4 bytes, not 8 bytes.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/ppc/vof.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
> index e3b430a81f4f..b5b6514d79fc 100644
> --- a/hw/ppc/vof.c
> +++ b/hw/ppc/vof.c
> @@ -646,7 +646,7 @@ static void vof_dt_memory_available(void *fdt, GArray *claimed, uint64_t base)
>      mem0_reg = fdt_getprop(fdt, offset, "reg", &proplen);
>      g_assert(mem0_reg && proplen == sizeof(uint32_t) * (ac + sc));
>      if (sc == 2) {
> -        mem0_end = be64_to_cpu(*(uint64_t *)(mem0_reg + sizeof(uint32_t) * ac));
> +        mem0_end = ldq_be_p(mem0_reg + sizeof(uint32_t) * ac);
>      } else {
>          mem0_end = be32_to_cpu(*(uint32_t *)(mem0_reg + sizeof(uint32_t) * ac));
>      }

I did wonder if there was a better way to do what this is doing,
but neither we (in system/device_tree.c) nor libfdt seem to
provide one.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

