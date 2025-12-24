Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8FFE776F0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 18:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYTjx-0001VY-F1; Wed, 24 Dec 2025 13:37:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYTjT-0001IW-QV
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 13:37:12 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYTjR-0004YS-Qh
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 13:37:11 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b802d5e9f06so788778666b.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 10:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766601428; x=1767206228; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2g7V4OBZIUL9GZ1hpCJ91UGdg+6rCali79qO2nf28dk=;
 b=XcMeqKSqJuYPXLWAWKtMCgGzx+5MF0HL/aWlhpIA6PsWv9M3mwo/0mgnAFCsjqirDm
 uahWmvFuwNWsMk+dH6QaICXL+K3vVDekNpxvjCM33J2RsxgZ6AkVnfOPQiMD86fpciRl
 j8YX8WTOi0uTZqOYhvVCvctvrbqn0dGKU8/lQ5/WShU3O1QDURIWAoi5rwz6VuA1lvLM
 seo27u15ytPCqbtT266yym4/2C19+HygvcLU458o6gs16q59DgbnnoqEAyRb2EyrRAWd
 +5esZaRS0bErYLgw+uxJb09oAejR8WumrBW+S2qu6k5yntVDxhagKwJ9jcH8Xk5xTEWg
 S0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766601428; x=1767206228;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2g7V4OBZIUL9GZ1hpCJ91UGdg+6rCali79qO2nf28dk=;
 b=Go2kGwOmn+ZVn5b2SLknSDRxd2x+Ye0DZ5tJjr92VOEoZazhyY0vL9CQXsN67GkDCe
 Zhmt+ESgveZxfjzl6uqSGAxVBYt9qbdThRg3sy+ssyhCEj5QLr7asz+zQ9xNKVrI+CYC
 ZkreK61NsrQDnSs03JVmAG4uYll8FydFpZmkdn0EIQKwP/yKV5BKibfFr9C14ivZrIy1
 nhWBcWwQK0iXm1VNQQ5zOqNiiha+2nU70vY8yHGRiPrjiCAmuat/+KSXiWyWoNFOwSaE
 780G6m43UAAHtl8aCvlGINkx/UUG76yKBptA9YEGdvsFeaJkw1iMAfzf/gsh6ag9vCsZ
 JSSg==
X-Gm-Message-State: AOJu0YzEg074FuWMckQdXXz4y4Rp8QcK7k0muCY7ifPSsKbWT386RhyS
 n9tMyOVdF9audI7OccMhgJ7t1wBTxJBHhpLK8XH3zJWuRuDwGAVv/pVQBywq377M9njpqoysw4D
 axQzesE3X029IsedRvd139gVU0bLgK8efsEpLDE5VQA==
X-Gm-Gg: AY/fxX4MTMjNwz89QD9mN+vJTCZxG3iVVJxAgf0jdagQdijgqCF5K/5AnDrt9+fC7zG
 g8/V5XmelMW4P8zbRk7V7GJahZGQUzQR+Usb5Q+HtWPPyz9eUmKhePSWdL0RbBFTe6drZgURZBa
 ZSvjzJD6F3mfV75HqcfNBD0+j6t5ttC7QnS0KsPlFcdOyC5T065vfLl0FNOXZRR1j4Mu9Q7Em87
 Fql7lABjy42SdH1ArQftvcO1VxkzYjik87SPCFStjevZXF8h1vxqqiYF/cA6Ez/4pYp4qw=
X-Google-Smtp-Source: AGHT+IEaCk1pYeS7IBV/vR1IAnlTRJH+ULhUUKtLzdlBD0FTyK1KCE81XuwQeYjVaTJpH97S7+RC38/9AGzULoxdr0s=
X-Received: by 2002:a17:907:7f07:b0:b72:6d3e:848f with SMTP id
 a640c23a62f3a-b8036f60a9bmr1678484066b.19.1766601427974; Wed, 24 Dec 2025
 10:37:07 -0800 (PST)
MIME-Version: 1.0
References: <20251224151351.86733-1-philmd@linaro.org>
 <20251224151351.86733-8-philmd@linaro.org>
In-Reply-To: <20251224151351.86733-8-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 24 Dec 2025 20:36:42 +0200
X-Gm-Features: AQt7F2pegv5ImaZaRtEYJQEuHStX3X6LRo61QlGMgBEDcryJ_X3dolgarm6e1Tw
Message-ID: <CAAjaMXbjJ5ZPhpyoUOJLgFd=SkHvJigkb_4rqk7x1oZjm85Wew@mail.gmail.com>
Subject: Re: [PATCH 7/9] hw/virtio: Remove unused ldst_phys() helpers
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
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> None of the following virtio ldst_phys() inlined helpers are used:
>
>  - virtio_lduw_phys()
>  - virtio_ldl_phys[_cached]()
>  - virtio_ldq_phys[_cached]()
>  - virtio_stw_phys()
>  - virtio_stl_phys[_cached]()
>
> Just remove them.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


>  include/hw/virtio/virtio-access.h | 85 -------------------------------
>  1 file changed, 85 deletions(-)
>
> diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio=
-access.h
> index 07aae69042a..c866769cad8 100644
> --- a/include/hw/virtio/virtio-access.h
> +++ b/include/hw/virtio/virtio-access.h
> @@ -39,60 +39,6 @@ static inline bool virtio_access_is_big_endian(VirtIOD=
evice *vdev)
>  #endif
>  }
>
> -static inline uint16_t virtio_lduw_phys(VirtIODevice *vdev, hwaddr pa)
> -{
> -    AddressSpace *dma_as =3D vdev->dma_as;
> -
> -    if (virtio_access_is_big_endian(vdev)) {
> -        return lduw_be_phys(dma_as, pa);
> -    }
> -    return lduw_le_phys(dma_as, pa);
> -}
> -
> -static inline uint32_t virtio_ldl_phys(VirtIODevice *vdev, hwaddr pa)
> -{
> -    AddressSpace *dma_as =3D vdev->dma_as;
> -
> -    if (virtio_access_is_big_endian(vdev)) {
> -        return ldl_be_phys(dma_as, pa);
> -    }
> -    return ldl_le_phys(dma_as, pa);
> -}
> -
> -static inline uint64_t virtio_ldq_phys(VirtIODevice *vdev, hwaddr pa)
> -{
> -    AddressSpace *dma_as =3D vdev->dma_as;
> -
> -    if (virtio_access_is_big_endian(vdev)) {
> -        return ldq_be_phys(dma_as, pa);
> -    }
> -    return ldq_le_phys(dma_as, pa);
> -}
> -
> -static inline void virtio_stw_phys(VirtIODevice *vdev, hwaddr pa,
> -                                   uint16_t value)
> -{
> -    AddressSpace *dma_as =3D vdev->dma_as;
> -
> -    if (virtio_access_is_big_endian(vdev)) {
> -        stw_be_phys(dma_as, pa, value);
> -    } else {
> -        stw_le_phys(dma_as, pa, value);
> -    }
> -}
> -
> -static inline void virtio_stl_phys(VirtIODevice *vdev, hwaddr pa,
> -                                   uint32_t value)
> -{
> -    AddressSpace *dma_as =3D vdev->dma_as;
> -
> -    if (virtio_access_is_big_endian(vdev)) {
> -        stl_be_phys(dma_as, pa, value);
> -    } else {
> -        stl_le_phys(dma_as, pa, value);
> -    }
> -}
> -
>  static inline void virtio_stw_p(VirtIODevice *vdev, void *ptr, uint16_t =
v)
>  {
>      if (virtio_access_is_big_endian(vdev)) {
> @@ -166,26 +112,6 @@ static inline uint16_t virtio_lduw_phys_cached(VirtI=
ODevice *vdev,
>      return lduw_le_phys_cached(cache, pa);
>  }
>
> -static inline uint32_t virtio_ldl_phys_cached(VirtIODevice *vdev,
> -                                              MemoryRegionCache *cache,
> -                                              hwaddr pa)
> -{
> -    if (virtio_access_is_big_endian(vdev)) {
> -        return ldl_be_phys_cached(cache, pa);
> -    }
> -    return ldl_le_phys_cached(cache, pa);
> -}
> -
> -static inline uint64_t virtio_ldq_phys_cached(VirtIODevice *vdev,
> -                                              MemoryRegionCache *cache,
> -                                              hwaddr pa)
> -{
> -    if (virtio_access_is_big_endian(vdev)) {
> -        return ldq_be_phys_cached(cache, pa);
> -    }
> -    return ldq_le_phys_cached(cache, pa);
> -}
> -
>  static inline void virtio_stw_phys_cached(VirtIODevice *vdev,
>                                            MemoryRegionCache *cache,
>                                            hwaddr pa, uint16_t value)
> @@ -197,17 +123,6 @@ static inline void virtio_stw_phys_cached(VirtIODevi=
ce *vdev,
>      }
>  }
>
> -static inline void virtio_stl_phys_cached(VirtIODevice *vdev,
> -                                          MemoryRegionCache *cache,
> -                                          hwaddr pa, uint32_t value)
> -{
> -    if (virtio_access_is_big_endian(vdev)) {
> -        stl_be_phys_cached(cache, pa, value);
> -    } else {
> -        stl_le_phys_cached(cache, pa, value);
> -    }
> -}
> -
>  static inline void virtio_tswap16s(VirtIODevice *vdev, uint16_t *s)
>  {
>      *s =3D virtio_tswap16(vdev, *s);
> --
> 2.52.0
>

