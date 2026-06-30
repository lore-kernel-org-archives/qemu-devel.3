Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851C1C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 20:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weeg1-0001UQ-Ns; Tue, 30 Jun 2026 16:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weeg0-0001Tx-9E
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 16:03:24 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weefy-0007US-P0
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 16:03:24 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-6611669cd16so4865175d50.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 13:03:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782849801; cv=none;
 d=google.com; s=arc-20260327;
 b=SlXj5X15vAX6I1nbFSeuYaL9FSpBqE3ZWK7evppePR8jULCS2WKH8p/A137PZHk0Sy
 XfcXtLFUMwbdh1OorTZNpPh1LtDEDG5MLOX7Ip6m0a83hX39a5vxJj9rBMteZslt1a/x
 3HcdxnVSJHs2Z13NbksxJXJ9eCpIo1TVMqWRxMWLOncPh7lrBvYNevbLujER8v9V9En5
 ZGh5Lgjy5exNnkdnvmUdOt3c/T0fNaCbkfpik9lf32bUqg8B/G17jQ11TUdDYGDoAzSE
 UZj/dsoe7mjpIdZg2EJnAgxvVDAU50xttjNeKAdLDUX9obKOXowR6BuWMHOEeCvc9svb
 ZWqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bXhZ8i7eqVyE6MmcjkVTC+SVyUFICSV6c/GTYl9CE3c=;
 fh=QuZ9/BSZ6wXz9VHMgGKA6llgU+UYbsb3suA74w1Y7Dk=;
 b=YXbWNW8rxbLiGeGiHajLMZErPYw1+L07jCmy3XkwKl9BDTMEcsxdT+PrO+VqHXrKuy
 fhUH0b5tvv6FhyRIK66v9mBHbf2owg3IgamkJ2YoThzgscGMhyqqEU5IRCfaKMk3tgEZ
 QFW5E11UEaMfOczAaCVY/QoWuHtGltZ8wyWSBk0MkLDOZ5MCZtKaeNI+uXh+qsMmfYKu
 KzpRmAW2JrkeRrATxU6Zzl9uHlgPJjqM3GlWVgD9KyeUAPDcUcSTY4xYf8puCZAh2HE3
 csMPb9pr0GcQYNMrW0HmbWzoEhs1Wx0VfviFyvo4qrKV/92Cg+Rs6t8aIUIhNfiZGNQp
 +VoQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782849801; x=1783454601; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bXhZ8i7eqVyE6MmcjkVTC+SVyUFICSV6c/GTYl9CE3c=;
 b=HrkJnNjyiIesRodNn0+6ibCo61dbLoC4PXxAGh8rivWe1q5t8oMkYiDTrqRvpzhjmz
 w7gE76L5TZ+6Ph0Nsk0VKFTH60XYIqbs7QnDjOGFLKRXnKlh0nJL1XopoYNnCyFRogb6
 KnguWaux109/DIUXXX0+a0DmIZHVbter43jRGmg1rc3UQuVc1vnh029ygwoOx1fvTDpa
 iqNDvBKSLWFtO21gUb6yHlKmE0IZh8PKZFqggQlzZ8VAmKoIhx7a+dqZA68t4zPrRWXB
 C6jukDvigUVqg0NlQqk6kTg+dAkhPyyRh7d46OzbG0O1iI8aneEML5boUTGJ3WtYwDDC
 8gRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782849801; x=1783454601;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bXhZ8i7eqVyE6MmcjkVTC+SVyUFICSV6c/GTYl9CE3c=;
 b=onQXGYods9nfgBQWb2dSsF3/lTQYH9Kj2UnUDIz1b67PdOENiTLZWbRIafih4a818q
 5nBQifiNHQ48E8ggqNn+N1YyIIefr55JAgU+IYbk3VNF/yMg3XgxO428EeFcFNzV9bL6
 9gFrzT3eozuJYCnTbJPf0iDMkLWVBhI1ndq3l5wg4Ob7hzE8pOkw9B9SM/wnlCfb/c5Y
 C3mQz/cF5JZYyWvy1xa/Hg2x5VHh5Jq4kU30bBmBS2+3gar9yQwoPYh9kdwcQz4LLmPk
 PeOvDtT3+zBWHJ3R86TLPmWfHQo0f8Ykd8p/2yv/vLkEScRgojilfqTYAhw9ZCil/UhZ
 Hftw==
X-Gm-Message-State: AOJu0Yx2gJK6sOCcz3X/ibygF2M9zbyt3FanK2oqoW05VDBefXha0zAb
 3BldMNmz2qRbdQJ5IpO9868n5A1P2yjF5hisj7VLx864y2w157TULR3YfV9EELyAn2fZLu/ECrS
 Lo0Qf8WBapv6j1/Nk3XIeEps2P9S1/HJVHz7DxnnZRA==
X-Gm-Gg: AfdE7clcZqKqPJy9Iuzh3xEFWVNbdRF4EdiY7aN7ucqjqGpEd4knxTq/ii4oy7KttEG
 /0P7r8qsA9wvZb6jfH/2Kxp0DQDJwFxnxaF4ZMiy5k22HLvJ25rtWZ4gO0BwiF5/eerU+o3T0ZV
 Fk4IWIXk2Id3L+Unu6do85uVllM9L9+MGG0bUGwMGNxrF5jrw+P4B2dHOIWozmcZNFzvuNiTRBm
 JX4kpbJbTLjrDiatGljzKf38FTqOZyBS7Nh2uwFnaxtkMJ7yBNs16Aa0QyALY1CmP5uVph4f6uY
 8uchq7RyFHNBVECdg3NkOb3Dlq2MPsDWr9DoAI4jESKrhImPhAbzgCl3RgxOJtH1mhM=
X-Received: by 2002:a05:690e:d4f:b0:664:f064:f66b with SMTP id
 956f58d0204a3-664f97956dcmr5308553d50.26.1782849801265; Tue, 30 Jun 2026
 13:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260630173245.2070268-1-clg@redhat.com>
In-Reply-To: <20260630173245.2070268-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jun 2026 21:03:09 +0100
X-Gm-Features: AVVi8CeKn3WwLouWQSn1WO-k9UfRbjLz7znD4rBG3Dxu-4tKcxs4Ps63L1r6hR8
Message-ID: <CAFEAcA8G2sti8T=u_Sa5HSSNXAJfJMmbv14PVD0y6yn1wDEaHw@mail.gmail.com>
Subject: Re: [PATCH] platform-bus: Align MMIO regions to host page size
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Tue, 30 Jun 2026 at 18:33, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> On aarch64 hosts with 64K pages, the platform bus MMIO allocator can
> place device regions (such as the 1KB "tpm-ppi" region) at offsets
> that are not aligned to the host page size. This causes unnecessary
> and noisy VFIO IOMMU warnings when starting VMs configured with
> passed-through PCI devices:
>
>   vfio_listener_valid_section received unaligned region tpm-ppi
>     iova=3D0xc005000 offset_within_region=3D0x0
>     qemu_real_host_page_size=3D0x10000

Why does vfio care about the tpm-ppi region? I thought vfio
was only for passthrough devices, not for normal ones.

> Fix this by ensuring the alignment used by the platform bus allocator
> is at least qemu_real_host_page_size().
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  hw/core/platform-bus.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
> index a2217a2deec7ab0f49b211c6658db02d13c319df..a17a38c1ba5491e2001fec5a2=
9c188de67e93d11 100644
> --- a/hw/core/platform-bus.c
> +++ b/hw/core/platform-bus.c
> @@ -140,6 +140,13 @@ static void platform_bus_map_mmio(PlatformBusDevice =
*pbus, SysBusDevice *sbdev,
>          return;
>      }
>
> +    /*
> +     * Ensure alignment is at least the host page size so that IOMMU
> +     * mappings (e.g. VFIO) work on hosts with large pages such as
> +     * aarch64 with 64K pages.
> +     */
> +    alignment =3D MAX(alignment, qemu_real_host_page_size());

Do we need to tie this to machine versions? Otherwise I think
the memory layout can change underfoot which would break a
guest migrated from an old QEMU to new.

-- PMM

