Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A2EE92FC4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaJ3y-0003b1-4B; Mon, 29 Dec 2025 14:37:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ3u-0003PT-UW
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:37:51 -0500
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ3r-0000Ca-Uo
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:37:50 -0500
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4ee147baf7bso3867371cf.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 11:37:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767037067; cv=none;
 d=google.com; s=arc-20240605;
 b=ITnUKblkOjRBIm7AzKgwyNuNOKhJ7zaO6dG264pOEfVRhqhDunwrXePnd2Rl0S07Rq
 mvSxXxD6wOhLHW2iHlpGKlR15gQzFlKMvFNCExL1qVPdm/1bTm4cOMkzyLw5AmiQLU39
 CW84cECb2E3+bz5d4MmurcQEJQ4wsKurYD2leXkmnAfPVumexB3Bzk8RDDTthi6dGIqY
 yKcPqA0Tb5wfxRLV/KSasEzlfSYfg3sww/eC+1kWG/Vr3CgR+w9XFRZhpt5xJPAsUqKC
 ZmIK+Dy+BrcQf1QsYMbRnVcyTzs3T5SWlq1kp//lemDQ8L2XjMUL7vQYV5VDc35dQ0nB
 i4LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BEkMAuhfVz5MJ8iUXWjEfc+uuB7ze2iJHaRwGuoZ+Ok=;
 fh=xjnLSQC0n5BsyYl2oZ4MoQYtmIVPXq/vcNBxOS6W81g=;
 b=AVEY4kmUgxC1wob5HlQegmoSBLG/IFDOxYd1jdZKrF6WzF5XqQndUnndr3cnWcFB7E
 r6YxwJ5cUnEm51L55yHbt8tY0q5z2OQjFaLixYUvV0nWX26snTgTDuX8IdYelVp8lwN0
 72IcvpRQrckH5Bfc5Q4BMuXzBtYznFwMSFVYj+fYlNBRVVRmq9ZG4XMfwE9aeK+BF0Mm
 NotEaEFZotB9gcAi6ikriw1OYiPr5kUSWRUE4f5OYCa9soL7VZoCk+b99/9uGYKMwK0g
 LI8h64kWedcK4tqjuFyByJl281Qbkbyj7uLe7pUrvDP3ucRzmnFM5O9I2C3w3tXXwQZ0
 sUzg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1767037067; x=1767641867; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BEkMAuhfVz5MJ8iUXWjEfc+uuB7ze2iJHaRwGuoZ+Ok=;
 b=1aAVkz5+gVZY1MFXyyNNdkBMAVLelB7YhkxZ1h6t/ckJoxNTEr8L2Y90U2y0BEtlji
 1WkdwndIhGEsKtSaNQ636xbTPhhCC5u6/h3v3OHWxeIBnNv93C40VyCRHt3flZ8shP6t
 x26ePlYJZz2KvZndUBijSPNozfCJBvbnx0W3ibtvNBGC2EJk3sbCaylma+XToxcm910g
 fFHgXOcFTKBVZIWBTTahiwmFrZtWFUz7f5M3hNle+peSPMuPhUlgpy2DVjTNcgQu6zaN
 T8YuuNt8JHlMUJvADdzD5DVDxhf7GwzA4OMvbYjcnctpoWLu2c2bV6dpohuxpu8nPZLk
 Kdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767037067; x=1767641867;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BEkMAuhfVz5MJ8iUXWjEfc+uuB7ze2iJHaRwGuoZ+Ok=;
 b=eFOpsw4Ox3Nn0g6RkeQi0Q27P4v7+tPGYdpLFU206D5kpmJ7yPHfcwmesXL3PUdSxN
 5WdvrMkpmcTZlzLlWU6C0QMr5hJmpuOsdyikmQKFgMFVNRMLUJpqq15D7VwuBvzmVlL9
 03shxX7whDeYlpZ+tNMjqG3+wDH5lqpFtkHyB2XgzcMfzhh9Ahk7bJztxE+Vo5vLT2Ks
 BJAcZ7+GXytwzKvPEVLVV/d+Z9h33EJKKFgda42D0kzEIrUIeC4DzYYQusjMr4JKj24D
 WpHlepI1PvAzZ9miylU4R/zPuLCbubtSqDePMCseGW/44xNQGYLY/oE46g0lVhp4LpgZ
 zAQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKMKSJkrn9vWE6PxYZCFUOjwpuoIKQC1wdk5I7tJOWnTf/fGV375br75nXoKfMWbD0rFH2Kwdz7Rci@nongnu.org
X-Gm-Message-State: AOJu0Yxh0QboPV+N50y0MCf35vTuFPc0t75vzqmomq6wVBHcCcU7fADF
 CcLzQFzloTEM7CjTwZRyabtuHIEZ2isZSxIusnDAl390QSzoa0aGnM1ak5voHtTE4sc64ZtPbw7
 Mg27Tn4aoDXTxSmWiLJxqpayLzT5S9XOOqwOnBisH
X-Gm-Gg: AY/fxX6iTew5xCBZh0bzZfVHPlS+zRL5sXQVM9XHCjn4jpmf09Zb4srVnGiMBsTJxKy
 vteech13r5LJD9K6JPyyuJfBMj4m+lXhW1Z/y/c9/64HyCeEgAgRsiV73pAvdA+5zeNnVCsTr91
 92Nv4hif8JFAAPpED2bQVZY4FwjMTqFcxiE2e5DLdfK2uXPNsgc1VVMn4E52xR2sqMUQd15AMYc
 2am0SdNnr2jTU11kCKvcfIcoLeSpQVaisctUPRfgaI2azjLDbuTpc5sBXtp7PGiBBiLR0rVsvkA
 2vjIvdaq3LL8VGexROgjzokLHw==
X-Google-Smtp-Source: AGHT+IGMsYGWEVX8FIMC0RiwBpi2skAIsBQu8m6OLWxtuDX93hFsAoN12iq19EX54gWnuhm0xohJi/v48WcunEVcH7Y=
X-Received: by 2002:ac8:5318:0:b0:4f4:e604:f5b with SMTP id
 d75a77b69052e-4f4e604104amr23968551cf.0.1767037066731; Mon, 29 Dec 2025
 11:37:46 -0800 (PST)
MIME-Version: 1.0
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-3-kane_chen@aspeedtech.com>
In-Reply-To: <20251224014203.756264-3-kane_chen@aspeedtech.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Mon, 29 Dec 2025 11:37:35 -0800
X-Gm-Features: AQt7F2o3FmrhBJeQJzJuL1FpbivPNp6Ik46_ynbKyCY6YP8P5tLP7Dn0UYG5QK0
Message-ID: <CA+QoejUMZ1H+UJQ1tgZjAix9tzqq+vBQCqDVXGsJCsULEKohug@mail.gmail.com>
Subject: Re: [PATCH v4 02/19] hw/arm/aspeed: Attach LTPI controller to AST27X0
 platform
To: Kane Chen <kane_chen@aspeedtech.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 troy_lee@aspeedtech.com, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x830.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Tue, Dec 23, 2025 at 5:42=E2=80=AFPM Kane Chen <kane_chen@aspeedtech.com=
> wrote:
>
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
>
> Connect the LTPI controller device (representing the AST1700 I/O
> expander) to the AST27X0 SoC model. This patch sets up the memory
> mapping and device registration according to the AST2700 SoC design,
> where the LTPI controller is exposed at fixed MMIO regions.
>
> This change only handles device instantiation and integration,
> without implementing the controller's internal logic.
>
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>

Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>


> ---
>  include/hw/arm/aspeed_soc.h |  5 +++++
>  hw/arm/aspeed_ast27x0.c     | 21 +++++++++++++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 18ff961a38..bca10c387b 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -43,6 +43,7 @@
>  #include "hw/fsi/aspeed_apb2opb.h"
>  #include "hw/char/serial-mm.h"
>  #include "hw/intc/arm_gicv3.h"
> +#include "hw/misc/aspeed_ltpi.h"
>
>  #define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"
>
> @@ -55,6 +56,7 @@
>  #define ASPEED_UARTS_NUM 13
>  #define ASPEED_JTAG_NUM  2
>  #define ASPEED_PCIE_NUM  3
> +#define ASPEED_IOEXP_NUM 2
>
>  struct AspeedSoCState {
>      DeviceState parent;
> @@ -112,6 +114,7 @@ struct AspeedSoCState {
>      UnimplementedDeviceState ltpi;
>      UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];
>      AspeedAPB2OPBState fsi[2];
> +    AspeedLTPIState ltpi_ctrl[ASPEED_IOEXP_NUM];
>  };
>
>  #define TYPE_ASPEED_SOC "aspeed-soc"
> @@ -279,6 +282,8 @@ enum {
>      ASPEED_GIC_REDIST,
>      ASPEED_DEV_IPC0,
>      ASPEED_DEV_IPC1,
> +    ASPEED_DEV_LTPI_CTRL1,
> +    ASPEED_DEV_LTPI_CTRL2,
>  };
>
>  const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 70be3871bb..341b53189b 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -88,6 +88,8 @@ static const hwaddr aspeed_soc_ast2700_memmap[] =3D {
>      [ASPEED_DEV_UART10]    =3D  0x14C33900,
>      [ASPEED_DEV_UART11]    =3D  0x14C33A00,
>      [ASPEED_DEV_UART12]    =3D  0x14C33B00,
> +    [ASPEED_DEV_LTPI_CTRL1] =3D  0x14C34000,
> +    [ASPEED_DEV_LTPI_CTRL2] =3D  0x14C35000,
>      [ASPEED_DEV_WDT]       =3D  0x14C37000,
>      [ASPEED_DEV_LTPI]      =3D  0x30000000,
>      [ASPEED_DEV_PCIE_MMIO0] =3D 0x60000000,
> @@ -556,6 +558,11 @@ static void aspeed_soc_ast2700_init(Object *obj)
>          object_property_set_int(OBJECT(&s->pcie[i]), "id", i, &error_abo=
rt);
>      }
>
> +    for (i =3D 0; i < ASPEED_IOEXP_NUM; i++) {
> +        object_initialize_child(obj, "ltpi-ctrl[*]",
> +                                &s->ltpi_ctrl[i], TYPE_ASPEED_LTPI);
> +    }
> +
>      object_initialize_child(obj, "dpmcu", &s->dpmcu,
>                              TYPE_UNIMPLEMENTED_DEVICE);
>      object_initialize_child(obj, "ltpi", &s->ltpi,
> @@ -1047,6 +1054,20 @@ static void aspeed_soc_ast2700_realize(DeviceState=
 *dev, Error **errp)
>          return;
>      }
>
> +    /* LTPI controller */
> +    for (i =3D 0; i < ASPEED_IOEXP_NUM; i++) {
> +        AspeedLTPIState *ltpi_ctrl;
> +        hwaddr ltpi_base;
> +
> +        ltpi_ctrl =3D ASPEED_LTPI(&s->ltpi_ctrl[i]);
> +        ltpi_base =3D sc->memmap[ASPEED_DEV_LTPI_CTRL1 + i];
> +
> +        if (!sysbus_realize(SYS_BUS_DEVICE(ltpi_ctrl), errp)) {
> +            return;
> +        }
> +        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(ltpi_ctrl), 0, ltpi_ba=
se);
> +    }
> +
>      aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
>                                    "aspeed.dpmcu",
>                                    sc->memmap[ASPEED_DEV_DPMCU],
> --
> 2.43.0
>

