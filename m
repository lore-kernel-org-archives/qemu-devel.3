Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0EDCD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 01:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOmQa-0002xy-VC; Sun, 17 May 2026 21:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOmQR-0002xi-Vp
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:05:45 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOmQQ-0006tN-5k
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:05:43 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so440515566b.0
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 18:05:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779066340; cv=none;
 d=google.com; s=arc-20240605;
 b=NKeSvLn48jkxwt2eM9IiuwNe4ZgvxD1AQQJne3QXtzRiUfi55KJLW4L+T/JYM2aqOF
 oUHgoNys8NWWXCyElR1hlQNiLbidM5jzS/9rPVaHNp0Bxfbfxi/zdKug2sFEEjFv5Z+d
 aOb3456Sdaet5mILPXjRM6qvjq1nf6pmRopiNjW/q+VI8tI2lj59FQdxqgjXCxOOdc1m
 YRuH9h9TXrcw9SGd3KOsNs0pHMkeawMfOt6BtUq+W0IESnZyph4Nnmt4/4s4fDqJmJdJ
 wb8gm6R6025jni6vYXkZ/LzyxbPx+twEmbSgl/LNpe1yGWFdmxrN2P60mMXIRxiBzIDH
 KvFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=753A1F8KtBL0u5w1iol+jmj0+5FqLTr7Ouc7cknJ4JU=;
 fh=Ofc/7yYflL5fzGU4DVTgtdXtCN7XZwZQ8r7NIaePuJA=;
 b=J2HWJZee7YWCryJ0khzpiIwkjmPvmRatSue1/20vRSV1IRd+Gv2tvAuAjUhZvSmMx5
 mTIENGg6fKgHbgsm+ZrhvXK76vRjcsknIo7INdsVzS4Ik9Ae8AZgnBDt2EH9VwlJEZzp
 hLo0q0U/l+MkbNUvChb64LOygb4+jPjSO6zkZ2lxXP0nWynATnW2SBfUgy7rowVnHl6L
 PKv8iahZraxYD54/lc+VdhNNcKadlujI+RUJn1lr6/ldLkT63LS03Lltqpy6zsyfmW4u
 iugorWykBJQagg6dUReCZB7ej0hyVYCtEgbHDKHNn7sIUeoDR3VPkBUzX/GsPr/6e69I
 skdw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779066340; x=1779671140; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=753A1F8KtBL0u5w1iol+jmj0+5FqLTr7Ouc7cknJ4JU=;
 b=EYTIO57lMJxTIrpbBpLz7CW+mgN61FEJejH4eDwfSUoYSWQBLhG15M33P+TDR6ETPE
 M0jhTuuBx7DRPI4KDWayvU2EHk86ghqrt3ZiZS/bilmE9p3KgmcM0aqv+ov1xa0IQt5V
 TUbaHBO80th/i7jq6BZLYyEkJoEp8drbXGxI+NHYH8uuSnd3lXaLvY8srZ3N7pEfq0ja
 rr6zC4S7GX+L6BMP3R9ujKhLyJEQVfeHCiw63KfXgZ7Ekt/3e1xJjmoUSycGBCDq9dNM
 xoJ4xhSpaXue1L+PY2MYNetJD5CP0GAsV8EJQj0JWnckQgVd5KH05LtIfzsEiMrtI/4+
 zD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779066340; x=1779671140;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=753A1F8KtBL0u5w1iol+jmj0+5FqLTr7Ouc7cknJ4JU=;
 b=NyHC3geGoi7o6fAFr0gz2ZJ6hWTt3Ug6snEVAuFFcshRFLB8Wr+95LekEsAvu89W2m
 wMtpiKr0vGt3+r4ot3zX/cFVVduPWJYifizmf5XTD/mCjqaDg7XxYSfkj6DV1w6uMzPJ
 j7xSkFs2e1GTUKTStlvBIitXGzBC5TLmyt/GUfRA8ue2oj0DAU38jZw72/03diXuKZCJ
 X58TmqbToi/VfM90hTo5ImmXBiHM9EoQcg8DUnneIA5No7YkhVwsV7x1C8jYal8vA8Kf
 FJ9xDm+K9zcgOCCeRAyNweyIjjbfAWXAV/C9jKd+iWZJEJ+iDDqT+UdwftKTaHoNnp/k
 Cd6g==
X-Gm-Message-State: AOJu0YyZTEfGOOONoWFY9BZO4gxS2mvbUg6W1fYWva8yl2pux24Yy6pK
 F/NhLZZYSPM8u49/YLvSNPqsZIZnLA9mUYaSWkCd7XebRTRpKvZausiYAMs+NIXmGNwq4g/6ECg
 XUGcOqZczrAQDMmzP6ct05A1L/y8MrOk=
X-Gm-Gg: Acq92OE4xdF5vwYM7Rr0Yc7BAh7TvV7lSs+VWX2ayazLlNDk0PO9X4uY1mkX8mlutyM
 1GjjByH/D0h4CNySnMCpquQEqUr/Qm2gKILQWKCXojRVC87WdPMstbWK56kYYTgYXLQgURneLRu
 fa8ApKu8kD3qyc3WxNB4/K4itN8UkJ+4uOVJxjbxqSJ85S+WWms684uJjY6arEd2CMaRLCU2kgp
 D+sUWMZLFLRefoRlsTh4rr5o7CVB7yrgrH8teUdKglmrfi1yW4M+X08orbBcu6Zxp0sygPzBQ9Y
 DIkOwkgoLCedeZvj8agoXwT7jOn7juGzyJzIExSpm8j9fIN76G2yMInSFTU=
X-Received: by 2002:a17:907:9806:b0:bd4:d755:1fc6 with SMTP id
 a640c23a62f3a-bd517aa7566mr607949266b.33.1779066340518; Sun, 17 May 2026
 18:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260515180437.23620-1-anjo@rev.ng>
 <20260515180437.23620-28-anjo@rev.ng>
In-Reply-To: <20260515180437.23620-28-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 11:05:14 +1000
X-Gm-Features: AVHnY4LRzKWVb0r2kL8FavgEg9zgsFP0kpnfLSfez56qH6SeD7ImRJ-jj0qUTwk
Message-ID: <CAKmqyKNNtm7Vk7mRAPb45bkJhcLw86+=qi_CzQb8OWHosgM99g@mail.gmail.com>
Subject: Re: [PATCH v6 27/27] target/riscv: Fix pmp.h/cpu.h circular inclusion
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62c.google.com
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

On Sat, May 16, 2026 at 4:02=E2=80=AFAM Anton Johansson via qemu developmen=
t
<qemu-devel@nongnu.org> wrote:
>
> pmp.h is only needed and included for system mode, however relevant
> macros (MAX_RISCV_PMPS, OLD_MAX_RISCV_PMPS, MIN_RISCV_PMP_GRANULARITY)
> are required unconditionally by cpu.c, and so are defined in cpu.h.
> pmp.h then defines pmp_table_t depending on these macros and so requires
> cpu.h, and cpu.h in turn uses pmp_table_t resulting in circular
> inclusion.
>
> Move PMP macros to pmp.h and only exose PMP properties in system mode.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h | 4 ----
>  target/riscv/pmp.h | 4 +++-
>  target/riscv/cpu.c | 6 ++++++
>  3 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index ad5d23ee6b..4bd24c15c5 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -180,10 +180,6 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_impl=
ied_rules[];
>
>  #define MMU_USER_IDX 3
>
> -#define MAX_RISCV_PMPS (64)
> -#define OLD_MAX_RISCV_PMPS (16)
> -#define MIN_RISCV_PMP_GRANULARITY 4
> -
>  #if !defined(CONFIG_USER_ONLY)
>  #include "pmp.h"
>  #endif
> diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
> index eae305ac6f..4c95c2767a 100644
> --- a/target/riscv/pmp.h
> +++ b/target/riscv/pmp.h
> @@ -22,7 +22,9 @@
>  #ifndef RISCV_PMP_H
>  #define RISCV_PMP_H
>
> -#include "cpu.h"
> +#define MAX_RISCV_PMPS (64)
> +#define OLD_MAX_RISCV_PMPS (16)
> +#define MIN_RISCV_PMP_GRANULARITY 4
>
>  typedef enum {
>      PMP_READ  =3D 1 << 0,
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 753f92307f..36f9570f2d 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1127,7 +1127,9 @@ static void riscv_cpu_init(Object *obj)
>      cpu->cfg.cbop_blocksize =3D 64;
>      cpu->cfg.cboz_blocksize =3D 64;
>      cpu->cfg.pmp_regions =3D 16;
> +#ifndef CONFIG_USER_ONLY
>      cpu->cfg.pmp_granularity =3D MIN_RISCV_PMP_GRANULARITY;
> +#endif
>      cpu->env.vext_ver =3D VEXT_VERSION_1_00_0;
>      cpu->cfg.max_satp_mode =3D -1;
>
> @@ -1550,6 +1552,7 @@ static const PropertyInfo prop_mmu =3D {
>      .set =3D prop_mmu_set,
>  };
>
> +#ifndef CONFIG_USER_ONLY
>  static void prop_pmp_set(Object *obj, Visitor *v, const char *name,
>                           void *opaque, Error **errp)
>  {
> @@ -1658,6 +1661,7 @@ static const PropertyInfo prop_pmp_granularity =3D =
{
>      .get =3D prop_pmp_granularity_get,
>      .set =3D prop_pmp_granularity_set,
>  };
> +#endif /* !CONFIG_USER_ONLY */
>
>  static int priv_spec_from_str(const char *priv_spec_str)
>  {
> @@ -2666,9 +2670,11 @@ static const Property riscv_cpu_properties[] =3D {
>      {.name =3D "pmu-num", .info =3D &prop_pmu_num}, /* Deprecated */
>
>      {.name =3D "mmu", .info =3D &prop_mmu},
> +#ifndef CONFIG_USER_ONLY
>      {.name =3D "pmp", .info =3D &prop_pmp},
>      {.name =3D "num-pmp-regions", .info =3D &prop_num_pmp_regions},
>      {.name =3D "pmp-granularity", .info =3D &prop_pmp_granularity},
> +#endif
>
>      {.name =3D "priv_spec", .info =3D &prop_priv_spec},
>      {.name =3D "vext_spec", .info =3D &prop_vext_spec},
> --
> 2.52.0
>
>

