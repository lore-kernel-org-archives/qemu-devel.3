Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A8FCD343F
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 02:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMz5k-0000lH-Kd; Tue, 12 May 2026 22:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wMz5J-0000jt-7Q
 for qemu-devel@nongnu.org; Tue, 12 May 2026 22:12:32 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wMz5E-0001UB-Pk
 for qemu-devel@nongnu.org; Tue, 12 May 2026 22:12:27 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bcc9fdc959cso548812766b.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 19:12:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778638342; cv=none;
 d=google.com; s=arc-20240605;
 b=knVR6cpL/MaAa0E2BqmnlWuCIIbDupgzCC8nnssoaBJPOUgZjVIqTycK+DyIDaD5ul
 Hi4tCjzBBcxi2Rbe38K2Gh3u5myMdHRzWD89f+LdGeib0i4A49sjQbcv9NL8rpUVVYU8
 Rg73ApMrzag6a7Jt4jmvlFn74RXuaOIxWFCo3/w2kCOUjA8huoRjXzWDqIUsOhvnDaaB
 25ATy4SGctBB+IxelzKszDYaO5fZDG1Izdiigqd4L9A7FPksAXt3r0lfK//8ocVi/izZ
 cK62lfvv3cjaJ55WifXwVY1QOEDX7Zj9pz9KboCy4DKzWRC6ImgjlMQ1Gfj17vshZ+UY
 CxcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fkPZBDQ114Ri2GHG4KbIni77nQOUzkW8fE9EbZMkUdk=;
 fh=aAar/WoJi2Yu892/hPBWU/RHIpyRRCWdDXH6wEDlcls=;
 b=Xp5G/Bl4Id09/Z6kx18dsHyLS/VmGrajKs6AOD0jj8cbQtEHzX1QJJgNtyQ1jOmsvD
 8Kx3B5azJoy7oj5UwMzFeuNC9jm9b30wtermq/WcYgks8NbhNP6YAv9Pxqw/gHa6GycY
 qh086c3wZXm3cjO/ncqBrjseWHWaafGlg02kz23hLZ1U1daoygx33eFYWDEtmcesmE97
 TZX0pJwkkEj81Q6zKI24XHN5mQFxWaZvp81p90466ewWU/RPs8ZOaxROkqAod9bezHvR
 ZFMQPg81X3i6XPJzDvw1bM61AIgz5lwqtWLr+RHV1hff8vtI+2RuBvkwaWe9XdUXAHck
 b7dg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778638342; x=1779243142; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fkPZBDQ114Ri2GHG4KbIni77nQOUzkW8fE9EbZMkUdk=;
 b=br9/YM4NlIZcGs5kgzNltt34esaQKSJZ2hqsfEQuGJp1LzLH/ORKzLr1oCtKrGwXog
 1Yc1E+Az3ocTHD7MqtzOGD0PxtMjvnC8Zo5fR68cg6dfuiylQdU+7RhfaPZxgkNpFkCV
 P+DP4QKCSUBP+erSH7uLslhRZ63f9e/eEWD35EMdxrJYlihxz1xzZDXYGvjG2M8a43QH
 Dc7CgHT/Oo9gOzYndHk2ckTQJQXHLQDHGnPGzXDa/NL/I3p4lgVfKjcyTxstmD5gYNJ/
 camx2S15OsKh7HSzd0n3JZc20DNaGCrzuma5ANcHb5ENH9ftkclRQ3qh3FPhDnQlXrWr
 xgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778638342; x=1779243142;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fkPZBDQ114Ri2GHG4KbIni77nQOUzkW8fE9EbZMkUdk=;
 b=FaC9LHT0DI2XsN0f3S1SaC5as3rWhLwejyHy7GSsgaRF+BSmKLtezrIH5Y8At0BYxD
 cOLEipVFGaj758lBvsTPljZoH25o4Zbf7hCQmwC6ibLv3PTubXmr/k6VWxkQ+43sAce3
 OTPmNOnmkI9VzeeFwtcyM/Q7PzOYrrG0otryI5FGz2Vx23lkHK9YDQQ/NjzXMn1+JOWO
 8HOP7iPR1ysZYSwGkfQ8xI6XWYGJmxG6OFKdKOaeNfzdfOh7oR8O0E9CX9gVJVhRUEv2
 KF+vO8SjbAWlV4ACW8Tepsf05kRVKjS7XI8d6kWtczl52ofggCASTI7iXyX1/cKeJms4
 V7ug==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Izog8HVjMQPOZBoXUb2aiIquE1FTnp8Phv94rKDh6JvZFqtNVUGq/GvDO1+Hy8+/l1t1wY2HVJpjg@nongnu.org
X-Gm-Message-State: AOJu0YxfJVuTUKEUHmG3tvkCwVGg2gSo5dPPbs5twramUrxYde2GwCW4
 Q6XLN7V+IlloSZ/VsnJALXl4s+Vvo42ljIyHW1PNaDeIlPeR7kSr7cuc3QfvOBsAGFzE+wECpA4
 r9McyjZH6rNh+6W4TWaYNP9kMGio7TzM=
X-Gm-Gg: Acq92OFa+PjWc+ICEIZ/anebmO/t9Q9Na87wM0+Tp7AxabuY1PszoKdRxfLoRHpgbdu
 dzpbpLFroB32lA24FXiKLcFeYRCIkTDGs8zsLjAIjwaLJ7gcwgnzGL0XbpFDHSgmg7v0+dK3Cl6
 SEAt8UFl/V54EBtj9FjMRu89hSNwOBq78P0T+v7KYUVkxpVoYasrCKlNt68pVhhGdUSK6glsMxT
 j0oWMZtDKi3XHrM86dRNVk0Huc27Wy7F3NUgsNS+fTw42C74wR1MMx01nlxNt7ZSnM2I2/tnOk2
 sfX78y3prXWLbqdPBx7+xfGFgT8YcyvIdQcsgA==
X-Received: by 2002:a17:906:fe03:b0:bd3:7c4e:149e with SMTP id
 a640c23a62f3a-bd3c1b3ef97mr72623466b.41.1778638341979; Tue, 12 May 2026
 19:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260508205129.377032-1-andrew.jones@oss.qualcomm.com>
In-Reply-To: <20260508205129.377032-1-andrew.jones@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 13 May 2026 12:11:55 +1000
X-Gm-Features: AVHnY4IiezQptHHqpOAc_668G0T2fWDd_jDDV57YyJoeW2VpVd39ZkNCMM6i91s
Message-ID: <CAKmqyKOVVncGdTmKvSn8BbPFCUGi35YmZ9Ak9LojwW3qZNoEwQ@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu: Fix Svnapot 64KB pages
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 palmer@dabbelt.com, daniel.barboza@oss.qualcomm.com, tjeznach@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sat, May 9, 2026 at 6:52=E2=80=AFAM Andrew Jones
<andrew.jones@oss.qualcomm.com> wrote:
>
> The Svnapot extension encodes a 64KB leaf PTE by setting PTE_N and
> storing bits [3:0] of the PPN as a NAPOT size indicator. The IOMMU
> model wasn't checking PTE_N and therefore was using the raw (NAPOT-
> encoded) PPN directly in the physical address, yielding an address
> 32 KB above the correct base.
>
> Fix both riscv_iommu_spa_fetch() and pdt_memory_read() by mirroring
> the Svnapot handling already present in target/riscv/cpu_helper.c:
>
>   napot_bits  =3D ctz64(ppn) + 1          /* 4 for 64KB */
>   napot_mask  =3D (1 << napot_bits) - 1   /* 0xF */
>   phys_base   =3D PPN_PHYS(ppn & ~napot_mask)
>   page_offset =3D addr & (PPN_PHYS(napot_mask) | (TARGET_PAGE_SIZE - 1))
>
> The spec only defines napot_bits =3D=3D 4 (64KB); any other value is
> treated as a reserved encoding.
>
> This is a fix, rather than new feature support, because the spec
> says "IOMMU implementations must support the Svnapot standard
> extension for NAPOT Translation Contiguity."
>
> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/riscv/riscv-iommu.c | 44 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 40 insertions(+), 4 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 25a356d1d366..eb09cc974812 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -237,6 +237,25 @@ static bool riscv_iommu_msi_check(RISCVIOMMUState *s=
, RISCVIOMMUContext *ctx,
>      return true;
>  }
>
> +/* Returns the NAPOT page mask, or 0 for reserved encodings. */
> +static hwaddr riscv_iommu_napot_page_mask(hwaddr ppn, hwaddr addr, hwadd=
r *out)
> +{
> +    int napot_bits =3D ctz64(ppn) + 1;
> +    hwaddr napot_mask, page_mask;
> +
> +    /* The spec only defines 64KB (napot_bits =3D=3D 4) */
> +    if (napot_bits !=3D 4) {
> +        return 0;
> +    }
> +
> +    napot_mask =3D (1ULL << napot_bits) - 1;
> +    page_mask =3D PPN_PHYS(napot_mask) | (TARGET_PAGE_SIZE - 1);
> +
> +    *out =3D PPN_PHYS(ppn & ~napot_mask) | (addr & page_mask);
> +
> +    return page_mask;
> +}
> +
>  /*
>   * RISCV IOMMU Address Translation Lookup - Page Table Walk
>   *
> @@ -458,9 +477,20 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s,=
 RISCVIOMMUContext *ctx,
>          } else {
>              /* Leaf PTE, translation completed. */
>              sc[pass].step =3D sc[pass].levels;
> -            base =3D PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
> -            /* Update address mask based on smallest translation granula=
rity */
> -            iotlb->addr_mask &=3D (1ULL << va_skip) - 1;
> +
> +            if (pte & PTE_N) {
> +                hwaddr mask =3D riscv_iommu_napot_page_mask(ppn, addr, &=
base);
> +
> +                if (!mask) {
> +                    break;
> +                }
> +                iotlb->addr_mask &=3D mask;
> +            } else {
> +                base =3D PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1)=
);
> +                /* Update address mask based on smallest translation gra=
nularity */
> +                iotlb->addr_mask &=3D (1ULL << va_skip) - 1;
> +            }
> +
>              /* Continue with S-Stage translation? */
>              if (pass && sc[0].step !=3D sc[0].levels) {
>                  pass =3D S_STAGE;
> @@ -997,7 +1027,13 @@ static MemTxResult pdt_memory_read(RISCVIOMMUState =
*s,
>              return MEMTX_ACCESS_ERROR; /* Misaligned PPN */
>          } else {
>              /* Leaf PTE, translation completed. */
> -            base =3D PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
> +            if (pte & PTE_N) {
> +                if (!riscv_iommu_napot_page_mask(ppn, addr, &base)) {
> +                    return MEMTX_ACCESS_ERROR;
> +                }
> +            } else {
> +                base =3D PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1)=
);
> +            }
>              break;
>          }
>
> --
> 2.43.0
>
>

