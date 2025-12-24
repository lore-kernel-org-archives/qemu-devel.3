Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDF4E7544F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 18:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYTkK-0001jI-MT; Wed, 24 Dec 2025 13:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYTk5-0001ZX-U8
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 13:37:50 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYTk2-0004qY-8T
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 13:37:49 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b735e278fa1so1081194066b.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 10:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766601464; x=1767206264; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JWkVdt27nVyShdZ50B07UJ5etLSAz32Ld8eCMPSHMio=;
 b=UVSyomBnNFbLh7zPPeghLGcie4v200tUnKSWsUpWL2cn456YAlic4BkTvi+tBys6ky
 QG8C/itf9RNc9bVnf9oRurWoO6Qk7aj2GT4iCZQYaawxMNa2wV9hAmFE8/K8xccNd19T
 bViDmA0+XrFJOsvQFcTl6J+d4UdhaxAFRCMg+tb0LVLNEN143VP7ifqzcFDona6lFIQ9
 M0wt5Pqg3XlJZjSSDDr+/a3Qso/aGwVJ/cx4OCXl3IbCXC1qFc5IQW8YyumjbI0+Y+bP
 MiPUQX6SNTm9h4ULoRbZuwdryvaaFHKWngGvWx6M8mchWXHjC4RkQsdR63tktzmQx6Fs
 y0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766601464; x=1767206264;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JWkVdt27nVyShdZ50B07UJ5etLSAz32Ld8eCMPSHMio=;
 b=wCDkvOHKn8sS8hbNyFToFGEJDj7sQkobS4ZnT/UTxpP1N7Wbr/bHmM6M2/S4bcOz7t
 dmpxTahwy0rq+pqDAvvTYANowRbZZRJH7o5sSHYKbFPhSiC1f73KgljbMDH7n5sz7KRp
 EmknHexUtzDE9Wl7jxpp/WCudEslS6S+2+n7cMCjHB1zeyd4IZwPTZiYE9eFRbOoT3QS
 rglP6egM23N0+dKAT7uHX8rShd+r8Sfr+UYFQJlX7Uec6FasbNLCXX2a65FFPs25HcGl
 RVh/uuQFv0KwAyHGRtg8SdYTv/XUxKqb8CzUzxHOquiARNXsZn6i8VObNV6zhkTVnpgE
 dMCg==
X-Gm-Message-State: AOJu0YwMZ1OrPXcFu+UuqZ/+jFsp9P0Ss702EFOGowEANeacyQ00s0cv
 IU7HqcpJE3IT3mMrobaPCDuZiZuT6jXnuscDJf0c7sW1AWYnfhawbP9OZrJo4WthDKgssmJYbUh
 0d3cVMnfu0BjseW1RY7cUf8zCbEhEdbXv44WEui+uXw==
X-Gm-Gg: AY/fxX6bFqTWBXDeKa6iHTsw91HnJHchB+AyuHR8WQvGR6QjI3OhZzC9ZX8CR9KjqIc
 5O923aeu+ATuD6/QKnP1kuEbzRL8qz+RoN0mRoki6Nllh6Rd6PddWzZoLyKN9xgODsxKcq5flOl
 VYmzlXHK9UTDmjPTPJdVk410jPCaRZ9xRJ2rIyUHzuEJEJXFui4ev/dg3zS0Pu6V4bbRXD6bsF0
 G4IpInGQRwm1TvHARM4TBvsy8uKtEGDRT/1YH6xXlQKrrNCDXJiPZp5A1atYBLHHOqM440=
X-Google-Smtp-Source: AGHT+IHncGsfHzoZ+DObaqMprM/Chy754T8dYyUt74eH/x0x010eyKO8a2CzSzSuMJWcpoIzdtYzvhYwUDUfQdYIc0I=
X-Received: by 2002:a17:906:209a:b0:b80:5aef:c30f with SMTP id
 a640c23a62f3a-b805aefc453mr1005782766b.44.1766601464040; Wed, 24 Dec 2025
 10:37:44 -0800 (PST)
MIME-Version: 1.0
References: <20251224151351.86733-1-philmd@linaro.org>
 <20251224151351.86733-9-philmd@linaro.org>
In-Reply-To: <20251224151351.86733-9-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 24 Dec 2025 20:37:18 +0200
X-Gm-Features: AQt7F2oX57Ld59PIX_s4TWSvF2wPFN_Vb8awqAT1PYQPJUNJie7WAxAQR4F69Uk
Message-ID: <CAAjaMXbBD+qU1tv3OMTxgAsCHUPpWYgaqRYV8WHHjV=n11xvTQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] hw/virtio: Reduce virtio_lduw/stw_phys_cached() scope
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Andrew Jeffery <andrew@codeconstruct.com.au>,
 qemu-arm@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Weiwei Li <liwei1518@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>, 
 David Hildenbrand <david@kernel.org>, qemu-riscv@nongnu.org, 
 Steven Lee <steven_lee@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Troy Lee <leetroy@gmail.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Alistair Francis <alistair.francis@wdc.com>, Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x636.google.com
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

On Wed, Dec 24, 2025 at 5:15=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> virtio_lduw_phys_cached() and virtio_stw_phys_cached() are
> only used within hw/virtio/virtio.c: reduce their scope by
> moving their definitions there.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


>  include/hw/virtio/virtio-access.h | 21 ---------------------
>  hw/virtio/virtio.c                | 21 +++++++++++++++++++++
>  2 files changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio=
-access.h
> index c866769cad8..5b5fff5295e 100644
> --- a/include/hw/virtio/virtio-access.h
> +++ b/include/hw/virtio/virtio-access.h
> @@ -102,27 +102,6 @@ static inline uint16_t virtio_tswap16(VirtIODevice *=
vdev, uint16_t s)
>  #endif
>  }
>
> -static inline uint16_t virtio_lduw_phys_cached(VirtIODevice *vdev,
> -                                               MemoryRegionCache *cache,
> -                                               hwaddr pa)
> -{
> -    if (virtio_access_is_big_endian(vdev)) {
> -        return lduw_be_phys_cached(cache, pa);
> -    }
> -    return lduw_le_phys_cached(cache, pa);
> -}
> -
> -static inline void virtio_stw_phys_cached(VirtIODevice *vdev,
> -                                          MemoryRegionCache *cache,
> -                                          hwaddr pa, uint16_t value)
> -{
> -    if (virtio_access_is_big_endian(vdev)) {
> -        stw_be_phys_cached(cache, pa, value);
> -    } else {
> -        stw_le_phys_cached(cache, pa, value);
> -    }
> -}
> -
>  static inline void virtio_tswap16s(VirtIODevice *vdev, uint16_t *s)
>  {
>      *s =3D virtio_tswap16(vdev, *s);
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 257cda506a4..fba9d347d17 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -216,6 +216,27 @@ static void virtio_check_indirect_feature(VirtIODevi=
ce *vdev)
>      }
>  }
>
> +static inline uint16_t virtio_lduw_phys_cached(VirtIODevice *vdev,
> +                                               MemoryRegionCache *cache,
> +                                               hwaddr pa)
> +{
> +    if (virtio_access_is_big_endian(vdev)) {
> +        return lduw_be_phys_cached(cache, pa);
> +    }
> +    return lduw_le_phys_cached(cache, pa);
> +}
> +
> +static inline void virtio_stw_phys_cached(VirtIODevice *vdev,
> +                                          MemoryRegionCache *cache,
> +                                          hwaddr pa, uint16_t value)
> +{
> +    if (virtio_access_is_big_endian(vdev)) {
> +        stw_be_phys_cached(cache, pa, value);
> +    } else {
> +        stw_le_phys_cached(cache, pa, value);
> +    }
> +}
> +
>  /* Called within call_rcu().  */
>  static void virtio_free_region_cache(VRingMemoryRegionCaches *caches)
>  {
> --
> 2.52.0
>

