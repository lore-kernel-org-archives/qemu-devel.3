Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9041ECD343F
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 02:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMywy-0006jO-6r; Tue, 12 May 2026 22:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wMyww-0006iy-Gz
 for qemu-devel@nongnu.org; Tue, 12 May 2026 22:03:50 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wMywr-0006kR-Q3
 for qemu-devel@nongnu.org; Tue, 12 May 2026 22:03:49 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-67c9616b4feso9081475a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 19:03:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778637824; cv=none;
 d=google.com; s=arc-20240605;
 b=O+oaRcZmwbg4xjhmMXQidigirI+Umfooza84cB07LgQBQBeJqRwKr6AoUCAfngoogo
 lMIIr4hGFR1RSlakMwdxQECx08vAtFini3F2dKD18tiP/T2VSQz3ZyK6HiGt2+fDMq0d
 ghBekqjXwxq4xdp19p9+3vyNDnCCaYi8kPf3LYgYIibPOaoQw5lE0m7dkdcbw2qwGMaA
 0qry7Ume14bCLS9vyaMYy0vub1fnPVjvVCo6NA/oMjMnsM5PNyIVQ0hrrnCChK+30BdY
 vAk+nHodwS5Z9ggkEsWDpmkjVEPq1+tf4UpNWZVMhPe4uSSCJ7O4XBbQH9vS4hRg07T8
 3few==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7uZVwfzuItfS+E5t6mZvakOJSftLf5QmrpZ2WJx2AmA=;
 fh=ZYowU56v7xRccSWB6xbpRV/KLSRMvcq2WCxvjpFPC7k=;
 b=jOg5UgY6Qvx4Bgvz40CMZ6atRSmfrQ1kKKsEJS6paYd7pUkUAcMKD5eyFguvWCKUTN
 52ZzmpF7KZb8Y9FwY1B/re/IND3QcKDUvjlvOillmDD0+CaLaHXVmfWz1GGnaA/BA0Kb
 +2cmxPGJ0O0i0cj9CUU/CPjSsxUDTDot/0x6+sxDDVxSMk8XKLD9pxWUfJrz0kTt841X
 1IbnypGvquv5MGou4W6IM3FP65vWPuqDXGs7kPILXnT8AMsDxoQzN5rEOd8CIkemJahz
 P29OWRtg1zo6L/15qNGO6L1fI36ZM7fZ3SQaFnNT82QxIzTDGKtnKPc60Jug9GOHIJtw
 jb0Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778637824; x=1779242624; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7uZVwfzuItfS+E5t6mZvakOJSftLf5QmrpZ2WJx2AmA=;
 b=YryD7xjbQ9OrgLz1Oqxrt/0xhzFFaqVJsDh/yC6fpAxDkGHSEPNBaGA4xA8ytynQD/
 XFAqRQCCaV/X9IsSPgys9UzYGZfRWKi1Em6zSneOZn/VOiCNye6hQIZotI17m4+hj4W0
 0QBsUbt3tLNbT4Vi0Fg5IfqlGKr44bIfQ4NtMRYQ36DZc2SeyQuua/v5Ihc7u42Qvkpl
 wmsc3emaxKMS1VExJ0bBOa4xTQhfSS7F6AmymOszhbLnseK2QyPzBqmJVFys+/gLmOFU
 oSv0DC8Ufk/UJXb0prcU0SUpDZtGI/IiA+EGZdPl4i3ueDq1Ybqin/d20Ef6Fov6ea90
 q9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778637824; x=1779242624;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7uZVwfzuItfS+E5t6mZvakOJSftLf5QmrpZ2WJx2AmA=;
 b=QWJEVVilSJO7KqlbMyhtkqx43CuCbfrGZVd6kU8hK/Kxz6vcNM6jwHPA2ijLcHI4sx
 9ZPGi0V9WHsPj7hHYoZqbzKZthTUU6Sbx2JXNvEHk8594ncVZ5LU2wOL6zvwIhDs4CMa
 3BYjaATTwevWoJcgbxsqymKIzFtfFOPJJUptCGgwIh9c2ZRZeTjb/c+Rpcu23bQ0Lm2L
 +vr7a6f5gZuWsNQOrH4+OcswClDtT00QeUxxG6RKI5kfmWzoCXoyj7+auwVQtlT/FrHF
 hQ1tJyDm9iGOwX9RPAWen1N8Li8WqSP+CSsaXMLeXRw/26xzBtwtb4cerqCOywSJbLCX
 StdA==
X-Forwarded-Encrypted: i=1;
 AFNElJ83ZpvvGzREjzfW7KDmCrDj8U7A2laF8PEpU+0BuW5y4HllBJNS5yW8nK4G0tiwfKOK5606uXW+oMAW@nongnu.org
X-Gm-Message-State: AOJu0YwTSFUDonOIV1GqIEFZUmkKwUrJSl1fC/KYa/kd7rpb5hnKjmCw
 JvtLx5otvkxRAJzRQB15016PlqF73nKq8WB6G9aTMlkz5S4QuQXBLmvwyu9w2enrznx1ADj1qgn
 EJy74DPog8clk6/UP6/BX65T3cS3XD54=
X-Gm-Gg: Acq92OFgVawsvxO2gjrBswsXvpqrZwUeYVC07KRbZjpirxsECedbmuSOEcIH7MmK7il
 9FcNfQB+46TSFlrE/LIgVIKZ1114j7N/rXJKqCiT3MulMjLNe+B6A+6KinUMKHFZJM9cu1fN2n1
 f6kMNRJhdABF2egSz9wQrHynF7oGP/CHlatJEuN+oC0KrIoJv7RkMu1yW3LkJrQfqTFbQsPNPSw
 /iaYZRiiySwZ/lPQEdSRsrKpzjg89F0qr73n19BjrYpbCYowOIYmxj0PglNQauAhGQiRT/Totq1
 62Gq49NnlW3QJMYe/ThnI8aI7tbBgIB55TCuPA==
X-Received: by 2002:a17:906:7950:b0:bd1:9f5c:abbf with SMTP id
 a640c23a62f3a-bd3c1836753mr68844966b.43.1778637823542; Tue, 12 May 2026
 19:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260507120524.111056-1-npiggin@gmail.com>
 <20260507120524.111056-4-npiggin@gmail.com>
In-Reply-To: <20260507120524.111056-4-npiggin@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 13 May 2026 12:03:17 +1000
X-Gm-Features: AVHnY4LScY33z7Zble0R1vz-Qm_nTY8Who0XdTN1VRzU64XFjSaGQ7SxT6pFnLk
Message-ID: <CAKmqyKO=pivPx5ohQdZXOE1u4sp8tU8dwpN10+WtaNGBhuofXA@mail.gmail.com>
Subject: Re: [PATCH 3/4] [RFC] hw/i2c/designware_i2c: Switch to QEMU register
 API
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Corey Minyard <cminyard@mvista.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Chris Rauer <crauer@google.com>, Michael Ellerman <mpe@kernel.org>, 
 Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52e.google.com
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

On Thu, May 7, 2026 at 10:07=E2=80=AFPM Nicholas Piggin <npiggin@gmail.com>=
 wrote:
>
> Alistair suggested moving to QEMU register API. I haven't used it before
> but IMO it is an improvement. It is a lot of churn that is not very
> review-able but unfortunately also changes VMState making it a pain to
> do incrementally. If we decide to go this way, we should squash the
> conversion patch when we're happy with it.
>
> I tried not to rearrange the code too much, to reduce patch size. I
> prefer putting register implementation all together rather than grouped
> by read and write, which this API promotes. So if others like that style
> then I will move that.
>
> I didn't change to use all the FIELD APIs to set/clear bits, since
> it worked out a bit easier to script and only a smal win since there is
> little/no multibit fields and shifting/masking required.
>
> Register traces of loading the kernel drivers for the 2 devices added on
> the Atlantis machine in the series Joel posted earlier look identical
> modulo RTC data reads (which I guess is due to time differences).
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/i2c/Kconfig                  |    1 +
>  hw/i2c/designware_i2c.c         | 1022 ++++++++++++++-----------------
>  include/hw/i2c/designware_i2c.h |   56 +-
>  3 files changed, 471 insertions(+), 608 deletions(-)
>
> diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
> index d3f394edeb..0766130b59 100644
> --- a/hw/i2c/Kconfig
> +++ b/hw/i2c/Kconfig
> @@ -20,6 +20,7 @@ config ARM_SBCON_I2C
>
>  config DESIGNWARE_I2C
>      bool
> +    select REGISTER
>      select I2C
>
>  config ACPI_SMBUS
> diff --git a/hw/i2c/designware_i2c.c b/hw/i2c/designware_i2c.c
> index 83d0968580..b7be4d68c4 100644
> --- a/hw/i2c/designware_i2c.c
> +++ b/hw/i2c/designware_i2c.c
> @@ -16,452 +16,312 @@
>  #include "qemu/units.h"
>  #include "trace.h"
>
> -enum DesignWareI2CRegister {
> -    DW_IC_CON                   =3D 0x00,
> -    DW_IC_TAR                   =3D 0x04,
> -    DW_IC_SAR                   =3D 0x08,
> -    DW_IC_DATA_CMD              =3D 0x10,
> -    DW_IC_SS_SCL_HCNT           =3D 0x14,
> -    DW_IC_SS_SCL_LCNT           =3D 0x18,
> -    DW_IC_FS_SCL_HCNT           =3D 0x1c,
> -    DW_IC_FS_SCL_LCNT           =3D 0x20,
> -    DW_IC_INTR_STAT             =3D 0x2c,
> -    DW_IC_INTR_MASK             =3D 0x30,
> -    DW_IC_RAW_INTR_STAT         =3D 0x34,
> -    DW_IC_RX_TL                 =3D 0x38,
> -    DW_IC_TX_TL                 =3D 0x3c,
> -    DW_IC_CLR_INTR              =3D 0x40,
> -    DW_IC_CLR_RX_UNDER          =3D 0x44,
> -    DW_IC_CLR_RX_OVER           =3D 0x48,
> -    DW_IC_CLR_TX_OVER           =3D 0x4c,
> -    DW_IC_CLR_RD_REQ            =3D 0x50,
> -    DW_IC_CLR_TX_ABRT           =3D 0x54,
> -    DW_IC_CLR_RX_DONE           =3D 0x58,
> -    DW_IC_CLR_ACTIVITY          =3D 0x5c,
> -    DW_IC_CLR_STOP_DET          =3D 0x60,
> -    DW_IC_CLR_START_DET         =3D 0x64,
> -    DW_IC_CLR_GEN_CALL          =3D 0x68,
> -    DW_IC_ENABLE                =3D 0x6c,
> -    DW_IC_STATUS                =3D 0x70,
> -    DW_IC_TXFLR                 =3D 0x74,
> -    DW_IC_RXFLR                 =3D 0x78,
> -    DW_IC_SDA_HOLD              =3D 0x7c,
> -    DW_IC_TX_ABRT_SOURCE        =3D 0x80,
> -    DW_IC_SLV_DATA_NACK_ONLY    =3D 0x84,
> -    DW_IC_DMA_CR                =3D 0x88,
> -    DW_IC_DMA_TDLR              =3D 0x8c,
> -    DW_IC_DMA_RDLR              =3D 0x90,
> -    DW_IC_SDA_SETUP             =3D 0x94,
> -    DW_IC_ACK_GENERAL_CALL      =3D 0x98,
> -    DW_IC_ENABLE_STATUS         =3D 0x9c,
> -    DW_IC_FS_SPKLEN             =3D 0xa0,
> -    DW_IC_CLR_RESTART_DET       =3D 0xa8,
> -    DW_IC_COMP_PARAM_1          =3D 0xf4,
> -    DW_IC_COMP_VERSION          =3D 0xf8,
> -    DW_IC_COMP_TYPE             =3D 0xfc,
> -};
> -
> -/* DW_IC_CON fields */
> -#define DW_IC_CON_STOP_DET_IF_MASTER_ACTIV  BIT(10)
> -#define DW_IC_CON_RX_FIFO_FULL_HLD_CTRL     BIT(9)
> -#define DW_IC_CON_TX_EMPTY_CTRL             BIT(8)
> -#define DW_IC_CON_STOP_IF_ADDRESSED         BIT(7)
> -#define DW_IC_CON_SLAVE_DISABLE             BIT(6)
> -#define DW_IC_CON_IC_RESTART_EN             BIT(5)
> -#define DW_IC_CON_10BITADDR_MASTER          BIT(4)
> -#define DW_IC_CON_10BITADDR_SLAVE           BIT(3)
> -#define DW_IC_CON_SPEED(rv)                 extract32((rv), 1, 2)
> -#define DW_IC_CON_MASTER_MODE               BIT(0)
> -
> -/* DW_IC_TAR fields */
> -#define DW_IC_TAR_IC_10BITADDR_MASTER  BIT(12)
> -#define DW_IC_TAR_SPECIAL              BIT(11)
> -#define DW_IC_TAR_GC_OR_START          BIT(10)
> -#define DW_IC_TAR_ADDRESS(rv)          extract32((rv), 0, 10)
> -
> -/* DW_IC_DATA_CMD fields */
> -#define DW_IC_DATA_CMD_RESTART  BIT(10)
> -#define DW_IC_DATA_CMD_STOP     BIT(9)
> -#define DW_IC_DATA_CMD_CMD      BIT(8)
> -#define DW_IC_DATA_CMD_DAT(rv)  extract32((rv), 0, 8)
> -
> -/* DW_IC_INTR_STAT/INTR_MASK/RAW_INTR_STAT fields */
> -#define DW_IC_INTR_RESTART_DET  BIT(12)
> -#define DW_IC_INTR_GEN_CALL     BIT(11)
> -#define DW_IC_INTR_START_DET    BIT(10)
> -#define DW_IC_INTR_STOP_DET     BIT(9)
> -#define DW_IC_INTR_ACTIVITY     BIT(8)
> -#define DW_IC_INTR_RX_DONE      BIT(7)
> -#define DW_IC_INTR_TX_ABRT      BIT(6)
> -#define DW_IC_INTR_RD_REQ       BIT(5)
> -#define DW_IC_INTR_TX_EMPTY     BIT(4) /* Hardware clear only. */
> -#define DW_IC_INTR_TX_OVER      BIT(3)
> -#define DW_IC_INTR_RX_FULL      BIT(2) /* Hardware clear only. */
> -#define DW_IC_INTR_RX_OVER      BIT(1)
> -#define DW_IC_INTR_RX_UNDER     BIT(0)
> -
> -/* DW_IC_ENABLE fields */
> -#define DW_IC_ENABLE_TX_CMD_BLOCK  BIT(2)
> -#define DW_IC_ENABLE_ABORT         BIT(1)
> -#define DW_IC_ENABLE_ENABLE        BIT(0)
> -
> -/* DW_IC_STATUS fields */
> -#define DW_IC_STATUS_SLV_ACTIVITY  BIT(6)
> -#define DW_IC_STATUS_MST_ACTIVITY  BIT(5)
> -#define DW_IC_STATUS_RFF           BIT(4)
> -#define DW_IC_STATUS_RFNE          BIT(3)
> -#define DW_IC_STATUS_TFE           BIT(2)
> -#define DW_IC_STATUS_TFNF          BIT(1)
> -#define DW_IC_STATUS_ACTIVITY      BIT(0)
> -
> -/* DW_IC_TX_ABRT_SOURCE fields */
> -#define DW_IC_TX_TX_FLUSH_CNT          extract32((rv), 23, 9)
> -#define DW_IC_TX_ABRT_USER_ABRT        BIT(16)
> -#define DW_IC_TX_ABRT_SLVRD_INTX       BIT(15)
> -#define DW_IC_TX_ABRT_SLV_ARBLOST      BIT(14)
> -#define DW_IC_TX_ABRT_SLVFLUSH_TXFIFO  BIT(13)
> -#define DW_IC_TX_ARB_LOST              BIT(12)
> -#define DW_IC_TX_ABRT_MASTER_DIS       BIT(11)
> -#define DW_IC_TX_ABRT_10B_RD_NORSTRT   BIT(10)
> -#define DW_IC_TX_ABRT_SBYTE_NORSTRT    BIT(9)
> -#define DW_IC_TX_ABRT_HS_NORSTRT       BIT(8)
> -#define DW_IC_TX_ABRT_SBYTE_ACKDET     BIT(7)
> -#define DW_IC_TX_ABRT_HS_ACKDET        BIT(6)
> -#define DW_IC_TX_ABRT_GCALL_READ       BIT(5)
> -#define DW_IC_TX_ABRT_GCALL_NOACK      BIT(4)
> -#define DW_IC_TX_ABRT_TXDATA_NOACK     BIT(3)
> -#define DW_IC_TX_ABRT_10ADDR2_NOACK    BIT(2)
> -#define DW_IC_TX_ABRT_10ADDR1_NOACK    BIT(1)
> -#define DW_IC_TX_ABRT_7B_ADDR_NOACK    BIT(0)
> -
> -
> -/* IC_ENABLE_STATUS fields */
> -#define DW_IC_ENABLE_STATUS_SLV_RX_DATA_LOST         BIT(2)
> -#define DW_IC_ENABLE_STATUS_SLV_DISABLED_WHILE_BUSY  BIT(1)
> -#define DW_IC_ENABLE_STATUS_IC_EN                    BIT(0)
> -
> -/* Masks for writable registers. */
> -#define DW_IC_CON_MASK          0x000003ff
> -#define DW_IC_TAR_MASK          0x00000fff
> -#define DW_IC_SAR_MASK          0x000003ff
> -#define DW_IC_SS_SCL_HCNT_MASK  0x0000ffff
> -#define DW_IC_SS_SCL_LCNT_MASK  0x0000ffff
> -#define DW_IC_FS_SCL_HCNT_MASK  0x0000ffff
> -#define DW_IC_FS_SCL_LCNT_MASK  0x0000ffff
> -#define DW_IC_INTR_MASK_MASK    0x00001fff
> -#define DW_IC_ENABLE_MASK       0x00000007
> -#define DW_IC_SDA_HOLD_MASK     0x00ffffff
> -#define DW_IC_SDA_SETUP_MASK    0x000000ff
> -#define DW_IC_FS_SPKLEN_MASK    0x000000ff
> -
> -/* Reset values */
> -#define DW_IC_CON_INIT_VAL          0x7d
> -#define DW_IC_TAR_INIT_VAL          0x1055
> -#define DW_IC_SAR_INIT_VAL          0x55
> -#define DW_IC_SS_SCL_HCNT_INIT_VAL  0x190
> -#define DW_IC_SS_SCL_LCNT_INIT_VAL  0x1d6
> -#define DW_IC_FS_SCL_HCNT_INIT_VAL  0x3c
> -#define DW_IC_FS_SCL_LCNT_INIT_VAL  0x82
> -#define DW_IC_INTR_MASK_INIT_VAL    0x8ff
> -#define DW_IC_STATUS_INIT_VAL       0x6
> -#define DW_IC_SDA_HOLD_INIT_VAL     0x1
> -#define DW_IC_SDA_SETUP_INIT_VAL    0x64
> -#define DW_IC_FS_SPKLEN_INIT_VAL    0x2
> -
> -#define DW_IC_COMP_PARAM_1_HAS_ENCODED_PARAMS   BIT(7)
> -#define DW_IC_COMP_PARAM_1_HAS_DMA              0 /* bit 6 - DMA disable=
d. */
> -#define DW_IC_COMP_PARAM_1_INTR_IO              BIT(5)
> -#define DW_IC_COMP_PARAM_1_HC_COUNT_VAL         0 /* bit 4 - disabled */
> -#define DW_IC_COMP_PARAM_1_HIGH_SPEED_MODE      (BIT(2) | BIT(3))
> -#define DW_IC_COMP_PARAM_1_APB_DATA_WIDTH_32    BIT(1) /* bits 0, 1 */
> -#define DW_IC_COMP_PARAM_1_INIT_VAL             \
> -    (DW_IC_COMP_PARAM_1_APB_DATA_WIDTH_32 | \
> -    DW_IC_COMP_PARAM_1_HIGH_SPEED_MODE | \
> -    DW_IC_COMP_PARAM_1_HC_COUNT_VAL | \
> -    DW_IC_COMP_PARAM_1_INTR_IO | \
> -    DW_IC_COMP_PARAM_1_HAS_DMA | \
> -    DW_IC_COMP_PARAM_1_HAS_ENCODED_PARAMS | \
> -    ((DESIGNWARE_I2C_RX_FIFO_SIZE - 1) << 8) | \
> -    ((DESIGNWARE_I2C_TX_FIFO_SIZE - 1) << 16))
> -#define DW_IC_COMP_VERSION_INIT_VAL             0x3132302a
> -#define DW_IC_COMP_TYPE_INIT_VAL                0x44570140
> +#ifndef DESIGNWARE_I2C_ERR_DEBUG
> +#define DESIGNWARE_I2C_ERR_DEBUG 0
> +#endif
> +
> +REG32(DW_IC_CON,                0x00) /* I2C control */
> +    FIELD(DW_IC_CON, STOP_DET_IF_MASTER_ACTIV, 10, 1)
> +    FIELD(DW_IC_CON, RX_FIFO_FULL_HLD_CTRL,     9, 1)
> +    FIELD(DW_IC_CON, TX_EMPTY_CTRL,             8, 1)
> +    FIELD(DW_IC_CON, STOP_IF_ADDRESSED,         7, 1)
> +    FIELD(DW_IC_CON, SLAVE_DISABLE,             6, 1)
> +    FIELD(DW_IC_CON, IC_RESTART_EN,             5, 1)
> +    FIELD(DW_IC_CON, 10BITADDR_MASTER,          4, 1)
> +    FIELD(DW_IC_CON, 10BITADDR_SLAVE,           3, 1)
> +    FIELD(DW_IC_CON, SPEED,                     1, 2)
> +    FIELD(DW_IC_CON, MASTER_MODE,               0, 1)
> +REG32(DW_IC_TAR,                0x04) /* I2C target address */
> +    FIELD(DW_IC_TAR, IC_10BITADDR_MASTER, 12,  1)
> +    FIELD(DW_IC_TAR, SPECIAL,             11,  1)
> +    FIELD(DW_IC_TAR, GC_OR_START,         10,  1)
> +    FIELD(DW_IC_TAR, ADDRESS,              0, 10)
> +REG32(DW_IC_SAR,                0x08) /* I2C slave address */
> +REG32(DW_IC_DATA_CMD,           0x10)
> +    FIELD(DW_IC_DATA_CMD, RESTART, 10, 1)
> +    FIELD(DW_IC_DATA_CMD, STOP,     9, 1)
> +    FIELD(DW_IC_DATA_CMD, CMD,      8, 1)
> +    FIELD(DW_IC_DATA_CMD, DAT,      0, 8)
> +REG32(DW_IC_SS_SCL_HCNT,        0x14) /* Standard speed i2c clock scl hi=
gh count */
> +REG32(DW_IC_SS_SCL_LCNT,        0x18) /* Standard speed i2c clock scl lo=
w count */
> +REG32(DW_IC_FS_SCL_HCNT,        0x1c) /* Fast or fast plus i2c clock scl=
 high count */
> +REG32(DW_IC_FS_SCL_LCNT,        0x20) /* Fast or fast plus i2c clock scl=
 low count */
> +REG32(DW_IC_INTR_STAT,          0x2c)
> +REG32(DW_IC_INTR_MASK,          0x30) /* I2C Interrupt Mask */
> +REG32(DW_IC_RAW_INTR_STAT,      0x34) /* I2C raw interrupt status */
> +    /* DW_IC_INTR_STAT/INTR_MASK/RAW_INTR_STAT fields */
> +    SHARED_FIELD(DW_IC_INTR_RESTART_DET, 12, 1)
> +    SHARED_FIELD(DW_IC_INTR_GEN_CALL,    11, 1)
> +    SHARED_FIELD(DW_IC_INTR_START_DET,   10, 1)
> +    SHARED_FIELD(DW_IC_INTR_STOP_DET,    9, 1)
> +    SHARED_FIELD(DW_IC_INTR_ACTIVITY,    8, 1)
> +    SHARED_FIELD(DW_IC_INTR_RX_DONE,     7, 1)
> +    SHARED_FIELD(DW_IC_INTR_TX_ABRT,     6, 1)
> +    SHARED_FIELD(DW_IC_INTR_RD_REQ,      5, 1)
> +    SHARED_FIELD(DW_IC_INTR_TX_EMPTY,    4, 1) /* Hardware clear only. *=
/
> +    SHARED_FIELD(DW_IC_INTR_TX_OVER,     3, 1)
> +    SHARED_FIELD(DW_IC_INTR_RX_FULL,     2, 1) /* Hardware clear only. *=
/
> +    SHARED_FIELD(DW_IC_INTR_RX_OVER,     1, 1)
> +    SHARED_FIELD(DW_IC_INTR_RX_UNDER,    0, 1)
> +
> +#define DW_IC_INTR_ANY_MASK                \
> +            (DW_IC_INTR_RESTART_DET_MASK | \
> +             DW_IC_INTR_GEN_CALL_MASK    | \
> +             DW_IC_INTR_START_DET_MASK   | \
> +             DW_IC_INTR_STOP_DET_MASK    | \
> +             DW_IC_INTR_ACTIVITY_MASK    | \
> +             DW_IC_INTR_RX_DONE_MASK     | \
> +             DW_IC_INTR_TX_ABRT_MASK     | \
> +             DW_IC_INTR_RD_REQ_MASK      | \
> +             DW_IC_INTR_TX_EMPTY_MASK    | \
> +             DW_IC_INTR_TX_OVER_MASK     | \
> +             DW_IC_INTR_RX_FULL_MASK     | \
> +             DW_IC_INTR_RX_OVER_MASK     | \
> +             DW_IC_INTR_RX_UNDER_MASK)
> +
> +#define DW_IC_INTR_ANY_SW_CLEAR_MASK       \
> +            (DW_IC_INTR_ANY_MASK         & \
> +            ~(DW_IC_INTR_TX_EMPTY_MASK   | \
> +              DW_IC_INTR_RX_FULL_MASK))
> +
> +REG32(DW_IC_RX_TL,              0x38) /* I2C receive FIFO threshold */
> +REG32(DW_IC_TX_TL,              0x3c) /* I2C transmit FIFO threshold */
> +REG32(DW_IC_CLR_INTR,           0x40)
> +REG32(DW_IC_CLR_RX_UNDER,       0x44)
> +REG32(DW_IC_CLR_RX_OVER,        0x48)
> +REG32(DW_IC_CLR_TX_OVER,        0x4c)
> +REG32(DW_IC_CLR_RD_REQ,         0x50)
> +REG32(DW_IC_CLR_TX_ABRT,        0x54)
> +REG32(DW_IC_CLR_RX_DONE,        0x58)
> +REG32(DW_IC_CLR_ACTIVITY,       0x5c)
> +REG32(DW_IC_CLR_STOP_DET,       0x60)
> +REG32(DW_IC_CLR_START_DET,      0x64)
> +REG32(DW_IC_CLR_GEN_CALL,       0x68)
> +REG32(DW_IC_ENABLE,             0x6c) /* I2C enable */
> +    FIELD(DW_IC_ENABLE, TX_CMD_BLOCK, 2, 1)
> +    FIELD(DW_IC_ENABLE, ABORT,        1, 1)
> +    FIELD(DW_IC_ENABLE, ENABLE,       0, 1)
> +REG32(DW_IC_STATUS,             0x70) /* I2C status */
> +    FIELD(DW_IC_STATUS, SLV_ACTIVITY, 6, 1)
> +    FIELD(DW_IC_STATUS, MST_ACTIVITY, 5, 1)
> +    FIELD(DW_IC_STATUS, RFF,          4, 1)
> +    FIELD(DW_IC_STATUS, RFNE,         3, 1)
> +    FIELD(DW_IC_STATUS, TFE,          2, 1)
> +    FIELD(DW_IC_STATUS, TFNF,         1, 1)
> +    FIELD(DW_IC_STATUS, ACTIVITY,     0, 1)
> +REG32(DW_IC_TXFLR,              0x74) /* I2C transmit fifo level */
> +REG32(DW_IC_RXFLR,              0x78) /* I2C receive fifo level */
> +REG32(DW_IC_SDA_HOLD,           0x7c) /* I2C SDA hold time length */
> +REG32(DW_IC_TX_ABRT_SOURCE,     0x80) /* The I2C transmit abort source *=
/
> +    FIELD(DW_IC_TX_ABRT_SOURCE, USER_ABRT,       16, 1)
> +    FIELD(DW_IC_TX_ABRT_SOURCE, SLVRD_INTX,      15, 1)
> +    FIELD(DW_IC_TX_ABRT_SOURCE, SLV_ARBLOST,     14, 1)
> +    FIELD(DW_IC_TX_ABRT_SOURCE, SLVFLUSH_TXFIFO, 13, 1)
> +    FIELD(DW_IC_TX_ABRT_SOURCE, ARB_LOST,        12, 1)
> +    FIELD(DW_IC_TX_ABRT_SOURCE, MASTER_DIS,      11, 1)
> +    FIELD(DW_IC_TX_ABRT_SOURCE, 10B_RD_NORSTRT,  10, 1)
> +    FIELD(DW_IC_TX_ABRT_SOURCE, SBYTE_NORSTRT,   9, 1)
> +    FIELD(DW_IC_TX_ABRT_SOURCE, HS_NORSTRT,      8, 1)
> +    FIELD(DW_IC_TX_ABRT_SOURCE, SBYTE_ACKDET,    7, 1)
> +    FIELD(DW_IC_TX_ABRT_SOURCE, HS_ACKDET,       6, 1)
> +    FIELD(DW_IC_TX_ABRT_SOURCE, GCALL_READ,      5, 1)
> +    FIELD(DW_IC_TX_ABRT_SOURCE, GCALL_NOACK,     4, 1)
> +    FIELD(DW_IC_TX_ABRT_SOURCE, TXDATA_NOACK,    3, 1)
> +    FIELD(DW_IC_TX_ABRT_SOURCE, 10ADDR2_NOACK,   2, 1)
> +    FIELD(DW_IC_TX_ABRT_SOURCE, 10ADDR1_NOACK,   1, 1)
> +    FIELD(DW_IC_TX_ABRT_SOURCE, 7B_ADDR_NOACK,   0, 1)
> +REG32(DW_IC_SLV_DATA_NACK_ONLY, 0x84)
> +REG32(DW_IC_DMA_CR,             0x88)
> +REG32(DW_IC_DMA_TDLR,           0x8c)
> +REG32(DW_IC_DMA_RDLR,           0x90)
> +REG32(DW_IC_SDA_SETUP,          0x94) /* I2C SDA setup */
> +REG32(DW_IC_ACK_GENERAL_CALL,   0x98)
> +REG32(DW_IC_ENABLE_STATUS,      0x9c) /* I2C enable status */
> +    FIELD(DW_IC_ENABLE_STATUS, SLV_RX_DATA_LOST,        2, 1)
> +    FIELD(DW_IC_ENABLE_STATUS, SLV_DISABLED_WHILE_BUSY, 1, 1)
> +    FIELD(DW_IC_ENABLE_STATUS, IC_EN,                   0, 1)
> +REG32(DW_IC_FS_SPKLEN,          0xa0) /* I2C SS, FS or FM+ spike suppres=
sion limit */
> +REG32(DW_IC_CLR_RESTART_DET,    0xa8)
> +REG32(DW_IC_COMP_PARAM_1,       0xf4) /* Component parameter */
> +    FIELD(DW_IC_COMP_PARAM_1, TX_FIFO_SIZE,       16, 8)
> +    FIELD(DW_IC_COMP_PARAM_1, RX_FIFO_SIZE,        8, 8)
> +    FIELD(DW_IC_COMP_PARAM_1, HAS_ENCODED_PARAMS,  7, 1)
> +    FIELD(DW_IC_COMP_PARAM_1, HAS_DMA,             6, 1)
> +    FIELD(DW_IC_COMP_PARAM_1, INTR_IO,             5, 1)
> +    FIELD(DW_IC_COMP_PARAM_1, HC_COUNT_VAL,        4, 1)
> +    FIELD(DW_IC_COMP_PARAM_1, HIGH_SPEED_MODE,     2, 2)
> +    FIELD(DW_IC_COMP_PARAM_1, APB_DATA_WIDTH_32,   0, 2)
> +REG32(DW_IC_COMP_VERSION,       0xf8) /* I2C component version */
> +REG32(DW_IC_COMP_TYPE,          0xfc) /* I2C component type */

This looks fine to me, again no datasheet so no idea if it's right though :=
)

For future reference, generally in QEMU when people say the Register
API they just mean this maco part above

>
>  static void dw_i2c_update_irq(DesignWareI2CState *s)
>  {
> -    int level;
> -    uint32_t intr =3D s->ic_raw_intr_stat & s->ic_intr_mask;
> -
> -    level =3D !!((intr & DW_IC_INTR_RX_UNDER) |
> -        (intr & DW_IC_INTR_RX_OVER) |
> -        (intr & DW_IC_INTR_RX_FULL) |
> -        (intr & DW_IC_INTR_TX_OVER) |
> -        (intr & DW_IC_INTR_TX_EMPTY) |
> -        (intr & DW_IC_INTR_RD_REQ) |
> -        (intr & DW_IC_INTR_TX_ABRT) |
> -        (intr & DW_IC_INTR_RX_DONE) |
> -        (intr & DW_IC_INTR_ACTIVITY) |
> -        (intr & DW_IC_INTR_STOP_DET) |
> -        (intr & DW_IC_INTR_START_DET) |
> -        (intr & DW_IC_INTR_GEN_CALL) |
> -        (intr & DW_IC_INTR_RESTART_DET)
> -        );
> -    qemu_set_irq(s->irq, level);
> +    uint32_t intr =3D s->regs[R_DW_IC_RAW_INTR_STAT] & s->regs[R_DW_IC_I=
NTR_MASK];

Which gives you advantages like this and the FIELD set/clear which you
aren't using anyway.

> +
> +    qemu_set_irq(s->irq, !!(intr & DW_IC_INTR_ANY_MASK));
>  }
>
> -static uint8_t dw_i2c_read_ic_data_cmd(DesignWareI2CState *s)
> +static uint64_t dw_ic_data_cmd_reg_post_read(RegisterInfo *reg, uint64_t=
 value)
>  {
> +    DesignWareI2CState *s =3D DESIGNWARE_I2C(reg->opaque);
> +
> +    g_assert(value =3D=3D 0);
> +
>      if (s->status !=3D DW_I2C_STATUS_RECEIVING) {
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: Attempted to read from RX fifo when not in re=
ceive "
>                        "state.\n", DEVICE(s)->canonical_path);
>          if (s->status !=3D DW_I2C_STATUS_IDLE) {
> -            s->ic_raw_intr_stat |=3D DW_IC_INTR_RX_UNDER;
> +            SHARED_ARRAY_FIELD_DP32(s->regs, R_DW_IC_RAW_INTR_STAT,
> +                                    DW_IC_INTR_RX_UNDER, 1);
>              dw_i2c_update_irq(s);
>          }
>          return 0;
>      }
>
> -    g_assert(s->ic_rxflr =3D=3D fifo8_num_used(&s->rx_fifo));
> +    g_assert(s->regs[R_DW_IC_RXFLR] =3D=3D fifo8_num_used(&s->rx_fifo));
>
>      if (fifo8_is_empty(&s->rx_fifo)) {
> -        s->ic_raw_intr_stat |=3D DW_IC_INTR_RX_UNDER;
> +        SHARED_ARRAY_FIELD_DP32(s->regs, R_DW_IC_RAW_INTR_STAT, DW_IC_IN=
TR_RX_UNDER, 1);
>          dw_i2c_update_irq(s);
>          return 0;
>      }
>
> -    s->ic_rxflr--;
> -    if (s->ic_rxflr <=3D s->ic_rx_tl) {
> -        s->ic_raw_intr_stat &=3D ~DW_IC_INTR_RX_FULL;
> +    s->regs[R_DW_IC_RXFLR]--;
> +    if (s->regs[R_DW_IC_RXFLR] <=3D s->regs[R_DW_IC_RX_TL]) {
> +        SHARED_ARRAY_FIELD_DP32(s->regs, R_DW_IC_RAW_INTR_STAT, DW_IC_IN=
TR_RX_FULL, 0);
>          dw_i2c_update_irq(s);
>      }
>
>      return fifo8_pop(&s->rx_fifo);
>  }
>
> -static uint64_t dw_i2c_read(void *opaque, hwaddr offset, unsigned size)
> +static uint64_t dw_ic_clr_intr_reg_post_read(RegisterInfo *reg, uint64_t=
 value)
>  {
> -    uint64_t value =3D 0;
> +    DesignWareI2CState *s =3D DESIGNWARE_I2C(reg->opaque);
>
> -    DesignWareI2CState *s =3D opaque;
> +    g_assert(value =3D=3D 0);
>
> -    switch (offset) {
> -    case DW_IC_CON:
> -        value =3D s->ic_con;
> +    switch (reg->access->addr) {
> +    case A_DW_IC_CLR_INTR:
> +        s->regs[R_DW_IC_RAW_INTR_STAT] &=3D ~DW_IC_INTR_ANY_SW_CLEAR_MAS=
K;
>          break;
> -    case DW_IC_TAR:
> -        value =3D s->ic_tar;
> +    case A_DW_IC_CLR_RX_UNDER:
> +        s->regs[R_DW_IC_RAW_INTR_STAT] &=3D ~DW_IC_INTR_RX_UNDER_MASK;
>          break;
> -    case DW_IC_SAR:
> -        qemu_log_mask(LOG_UNIMP, "%s: unsupported read - ic_sar\n",
> -                      DEVICE(s)->canonical_path);
> -        value =3D s->ic_sar;
> -        break;
> -    case DW_IC_DATA_CMD:
> -        value =3D dw_i2c_read_ic_data_cmd(s);
> -        break;
> -    case DW_IC_SS_SCL_HCNT:
> -        value =3D s->ic_ss_scl_hcnt;
> +    case A_DW_IC_CLR_RX_OVER:
> +        s->regs[R_DW_IC_RAW_INTR_STAT] &=3D ~DW_IC_INTR_RX_OVER_MASK;
>          break;
> -    case DW_IC_SS_SCL_LCNT:
> -        value =3D s->ic_ss_scl_lcnt;
> +    case A_DW_IC_CLR_TX_OVER:
> +        s->regs[R_DW_IC_RAW_INTR_STAT] &=3D ~DW_IC_INTR_TX_OVER_MASK;
>          break;
> -    case DW_IC_FS_SCL_HCNT:
> -        value =3D s->ic_fs_scl_hcnt;
> +    case A_DW_IC_CLR_RD_REQ:
> +        s->regs[R_DW_IC_RAW_INTR_STAT] &=3D ~DW_IC_INTR_RD_REQ_MASK;
>          break;
> -    case DW_IC_FS_SCL_LCNT:
> -        value =3D s->ic_fs_scl_lcnt;
> +    case A_DW_IC_CLR_TX_ABRT:
> +        s->regs[R_DW_IC_RAW_INTR_STAT] &=3D ~DW_IC_INTR_TX_ABRT_MASK;
>          break;
> -    case DW_IC_INTR_STAT:
> -        value =3D s->ic_raw_intr_stat & s->ic_intr_mask;
> +    case A_DW_IC_CLR_RX_DONE:
> +        s->regs[R_DW_IC_RAW_INTR_STAT] &=3D ~DW_IC_INTR_RX_DONE_MASK;
>          break;
> -    case DW_IC_INTR_MASK:
> -        value =3D s->ic_intr_mask;
> +    case A_DW_IC_CLR_ACTIVITY:
> +        s->regs[R_DW_IC_RAW_INTR_STAT] &=3D ~DW_IC_INTR_ACTIVITY_MASK;
>          break;
> -    case DW_IC_RAW_INTR_STAT:
> -        value =3D s->ic_raw_intr_stat;
> +    case A_DW_IC_CLR_STOP_DET:
> +        s->regs[R_DW_IC_RAW_INTR_STAT] &=3D ~DW_IC_INTR_STOP_DET_MASK;
>          break;
> -    case DW_IC_RX_TL:
> -        value =3D s->ic_rx_tl;
> +    case A_DW_IC_CLR_START_DET:
> +        s->regs[R_DW_IC_RAW_INTR_STAT] &=3D ~DW_IC_INTR_START_DET_MASK;
>          break;
> -    case DW_IC_TX_TL:
> -        value =3D s->ic_tx_tl;
> -        break;
> -    case DW_IC_CLR_INTR:
> -        s->ic_raw_intr_stat &=3D ~(DW_IC_INTR_GEN_CALL |
> -            DW_IC_INTR_RESTART_DET |
> -            DW_IC_INTR_START_DET |
> -            DW_IC_INTR_STOP_DET |
> -            DW_IC_INTR_ACTIVITY |
> -            DW_IC_INTR_RX_DONE |
> -            DW_IC_INTR_TX_ABRT |
> -            DW_IC_INTR_RD_REQ |
> -            DW_IC_INTR_TX_OVER |
> -            DW_IC_INTR_RX_OVER |
> -            DW_IC_INTR_RX_UNDER);
> -        s->ic_tx_abrt_source =3D 0;
> -        dw_i2c_update_irq(s);
> +    case A_DW_IC_CLR_GEN_CALL:
> +        s->regs[R_DW_IC_RAW_INTR_STAT] &=3D ~DW_IC_INTR_GEN_CALL_MASK;
>          break;
> -    case DW_IC_CLR_RX_UNDER:
> -        s->ic_raw_intr_stat &=3D ~(DW_IC_INTR_RX_UNDER);
> -        dw_i2c_update_irq(s);
> -        break;
> -    case DW_IC_CLR_RX_OVER:
> -        s->ic_raw_intr_stat &=3D ~(DW_IC_INTR_RX_OVER);
> -        dw_i2c_update_irq(s);
> -        break;
> -    case DW_IC_CLR_TX_OVER:
> -        s->ic_raw_intr_stat &=3D ~(DW_IC_INTR_TX_OVER);
> -        dw_i2c_update_irq(s);
> -        break;
> -    case DW_IC_CLR_RD_REQ:
> -        s->ic_raw_intr_stat &=3D ~(DW_IC_INTR_RD_REQ);
> -        dw_i2c_update_irq(s);
> -        break;
> -    case DW_IC_CLR_TX_ABRT:
> -        s->ic_raw_intr_stat &=3D ~(DW_IC_INTR_TX_ABRT);
> -        s->ic_tx_abrt_source =3D 0;
> -        dw_i2c_update_irq(s);
> +    case A_DW_IC_CLR_RESTART_DET:
> +        s->regs[R_DW_IC_RAW_INTR_STAT] &=3D ~DW_IC_INTR_RESTART_DET_MASK=
;
>          break;
> -    case DW_IC_CLR_RX_DONE:
> -        s->ic_raw_intr_stat &=3D ~(DW_IC_INTR_RX_DONE);
> -        dw_i2c_update_irq(s);
> -        break;
> -    case DW_IC_CLR_ACTIVITY:
> -        s->ic_raw_intr_stat &=3D ~(DW_IC_INTR_ACTIVITY);
> -        dw_i2c_update_irq(s);
> -        break;
> -    case DW_IC_CLR_STOP_DET:
> -        s->ic_raw_intr_stat &=3D ~(DW_IC_INTR_STOP_DET);
> -        dw_i2c_update_irq(s);
> -        break;
> -    case DW_IC_CLR_START_DET:
> -        s->ic_raw_intr_stat &=3D ~(DW_IC_INTR_START_DET);
> -        dw_i2c_update_irq(s);
> -        break;
> -    case DW_IC_CLR_GEN_CALL:
> -        s->ic_raw_intr_stat &=3D ~(DW_IC_INTR_GEN_CALL);
> -        dw_i2c_update_irq(s);
> -        break;
> -    case DW_IC_ENABLE:
> -        value =3D s->ic_enable;
> -        break;
> -    case DW_IC_STATUS:
> -        value =3D s->ic_status;
> -        break;
> -    case DW_IC_TXFLR:
> -        value =3D s->ic_txflr;
> -        break;
> -    case DW_IC_RXFLR:
> -        value =3D s->ic_rxflr;
> -        break;
> -    case DW_IC_SDA_HOLD:
> -        value =3D s->ic_sda_hold;
> -        break;
> -    case DW_IC_TX_ABRT_SOURCE:
> -        value =3D s->ic_tx_abrt_source;
> -        break;
> -    case DW_IC_SLV_DATA_NACK_ONLY:
> -        qemu_log_mask(LOG_UNIMP,
> -                      "%s: unsupported read - ic_slv_data_nack_only\n",
> -                      DEVICE(s)->canonical_path);
> -        break;
> -    case DW_IC_DMA_CR:
> -        qemu_log_mask(LOG_UNIMP, "%s: unsupported read - ic_dma_cr\n",
> -                      DEVICE(s)->canonical_path);
> -        break;
> -    case DW_IC_DMA_TDLR:
> -        qemu_log_mask(LOG_UNIMP, "%s: unsupported read - ic_dma_tdlr\n",
> -                      DEVICE(s)->canonical_path);
> -        break;
> -    case DW_IC_DMA_RDLR:
> -        qemu_log_mask(LOG_UNIMP, "%s: unsupported read - ic_dma_rdlr\n",
> -                      DEVICE(s)->canonical_path);
> -        break;
> -    case DW_IC_SDA_SETUP:
> -        value =3D s->ic_sda_setup;
> -        break;
> -    case DW_IC_ACK_GENERAL_CALL:
> -        qemu_log_mask(LOG_UNIMP, "%s: unsupported read - ic_ack_general_=
call\n",
> -                      DEVICE(s)->canonical_path);
> -        break;
> -    case DW_IC_ENABLE_STATUS:
> -        value =3D s->ic_enable_status;
> -        break;
> -    case DW_IC_FS_SPKLEN:
> -        value =3D s->ic_fs_spklen;
> -        break;
> -    case DW_IC_CLR_RESTART_DET:
> -        s->ic_raw_intr_stat &=3D ~(DW_IC_INTR_RESTART_DET);
> -        dw_i2c_update_irq(s);
> -        break;
> -    case DW_IC_COMP_PARAM_1:
> -        value =3D s->ic_comp_param_1;
> -        break;
> -    case DW_IC_COMP_VERSION:
> -        value =3D s->ic_comp_version;
> -        break;
> -    case DW_IC_COMP_TYPE:
> -        value =3D s->ic_comp_type;
> -        break;
> -
> -    /* This register is invalid at this point. */
>      default:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: read from invalid offset 0x%" HWADDR_PRIx "\n=
",
> -                      DEVICE(s)->canonical_path, offset);
> -        break;
> +        g_assert_not_reached();
>      }
>
> -    trace_dw_i2c_read(DEVICE(s)->canonical_path, offset, value);
> +    dw_i2c_update_irq(s);
>
> -    return value;
> +    return 0;
>  }
>
> -static void dw_i2c_write_ic_con(DesignWareI2CState *s, uint32_t value)
> +static uint64_t dw_ic_intr_stat_reg_post_read(RegisterInfo *reg, uint64_=
t value)
>  {
> -    if (value & DW_IC_CON_RX_FIFO_FULL_HLD_CTRL) {
> -        qemu_log_mask(LOG_UNIMP,
> -                      "%s: unsupported ic_con flag - RX_FIFO_FULL_HLD_CT=
RL\n",
> -                      DEVICE(s)->canonical_path);
> -    }
> +    DesignWareI2CState *s =3D DESIGNWARE_I2C(reg->opaque);
>
> -    if (!(s->ic_enable & DW_IC_ENABLE_ENABLE)) {
> -        s->ic_con =3D value & DW_IC_CON_MASK;
> -    } else {
> +    g_assert(value =3D=3D 0);
> +
> +    return s->regs[R_DW_IC_RAW_INTR_STAT] & s->regs[R_DW_IC_INTR_MASK];
> +}
> +
> +static uint64_t dw_ic_unsupported_reg_post_read(RegisterInfo *reg, uint6=
4_t value)
> +{
> +    DesignWareI2CState *s =3D DESIGNWARE_I2C(reg->opaque);
> +
> +    qemu_log_mask(LOG_UNIMP, "%s: unsupported read - %s\n",
> +                  DEVICE(s)->canonical_path, reg->access->name);
> +
> +    return 0;
> +}
> +
> +static uint64_t dw_ic_unsupported_reg_pre_write(RegisterInfo *reg, uint6=
4_t value)
> +{
> +    DesignWareI2CState *s =3D DESIGNWARE_I2C(reg->opaque);
> +
> +    qemu_log_mask(LOG_UNIMP, "%s: unsupported write - %s\n",
> +                  DEVICE(s)->canonical_path, reg->access->name);
> +
> +    return 0;
> +}
> +
> +static uint64_t dw_ic_con_reg_pre_write(RegisterInfo *reg, uint64_t valu=
e)
> +{
> +    DesignWareI2CState *s =3D DESIGNWARE_I2C(reg->opaque);
> +
> +    if (s->regs[R_DW_IC_ENABLE] & R_DW_IC_ENABLE_ENABLE_MASK) {
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: invalid setting to ic_con %d when ic_enable[0=
]=3D=3D1\n",
> -                      DEVICE(s)->canonical_path, value);
> +                      DEVICE(s)->canonical_path, (int)value);
> +        return s->regs[R_DW_IC_CON]; /* keep old value */
>      }
> +
> +    return value;
>  }
>
>  static void dw_i2c_reset_to_idle(DesignWareI2CState *s)
>  {
> -        s->ic_enable_status &=3D ~DW_IC_ENABLE_STATUS_IC_EN;
> -        s->ic_raw_intr_stat &=3D ~DW_IC_INTR_TX_EMPTY;
> -        s->ic_raw_intr_stat &=3D ~DW_IC_INTR_RX_FULL;
> -        s->ic_raw_intr_stat &=3D ~DW_IC_INTR_RX_UNDER;
> -        s->ic_raw_intr_stat &=3D ~DW_IC_INTR_RX_OVER;
> -        s->ic_rxflr =3D 0;
> +        s->regs[R_DW_IC_ENABLE_STATUS] &=3D ~R_DW_IC_ENABLE_STATUS_IC_EN=
_MASK;
> +        s->regs[R_DW_IC_RAW_INTR_STAT] &=3D ~DW_IC_INTR_TX_EMPTY_MASK;
> +        s->regs[R_DW_IC_RAW_INTR_STAT] &=3D ~DW_IC_INTR_RX_FULL_MASK;
> +        s->regs[R_DW_IC_RAW_INTR_STAT] &=3D ~DW_IC_INTR_RX_UNDER_MASK;
> +        s->regs[R_DW_IC_RAW_INTR_STAT] &=3D ~DW_IC_INTR_RX_OVER_MASK;
> +        s->regs[R_DW_IC_RXFLR] =3D 0;
>          fifo8_reset(&s->rx_fifo);
> -        s->ic_status &=3D ~DW_IC_STATUS_ACTIVITY;
> +        s->regs[R_DW_IC_STATUS] &=3D ~R_DW_IC_STATUS_ACTIVITY_MASK;
>          s->status =3D DW_I2C_STATUS_IDLE;
>          dw_i2c_update_irq(s);
>  }
>
>  static void dw_ic_tx_abort(DesignWareI2CState *s, uint32_t src)
>  {
> -    s->ic_tx_abrt_source |=3D src;
> -    s->ic_raw_intr_stat |=3D DW_IC_INTR_TX_ABRT;
> +    s->regs[R_DW_IC_TX_ABRT_SOURCE] |=3D src;
> +    s->regs[R_DW_IC_RAW_INTR_STAT] |=3D DW_IC_INTR_TX_ABRT_MASK;
>      dw_i2c_reset_to_idle(s);
>      dw_i2c_update_irq(s);
>  }
>
> -static void dw_i2c_write_ic_data_cmd(DesignWareI2CState *s, uint32_t val=
ue)
> +static void dw_ic_data_cmd_reg_post_write(RegisterInfo *reg, uint64_t va=
lue)
>  {
> -    int recv =3D !!(value & DW_IC_DATA_CMD_CMD);
> +    DesignWareI2CState *s =3D DESIGNWARE_I2C(reg->opaque);
> +    int recv =3D !!(value & R_DW_IC_DATA_CMD_CMD_MASK);
> +
> +    s->regs[R_DW_IC_DATA_CMD] =3D 0; /* Register has no storage */
>
>      if (s->status =3D=3D DW_I2C_STATUS_IDLE ||
> -        s->ic_raw_intr_stat & DW_IC_INTR_TX_ABRT) {
> +        s->regs[R_DW_IC_RAW_INTR_STAT] & DW_IC_INTR_TX_ABRT_MASK) {
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: Attempted to write to TX fifo when it is held=
 in "
>                        "reset.\n", DEVICE(s)->canonical_path);
> @@ -470,9 +330,10 @@ static void dw_i2c_write_ic_data_cmd(DesignWareI2CSt=
ate *s, uint32_t value)
>
>      /* Send the address if it hasn't been sent yet. */
>      if (s->status =3D=3D DW_I2C_STATUS_SENDING_ADDRESS) {
> -        int rv =3D i2c_start_transfer(s->bus, DW_IC_TAR_ADDRESS(s->ic_ta=
r), recv);
> +        int rv =3D i2c_start_transfer(s->bus,
> +                     ARRAY_FIELD_EX32(s->regs, DW_IC_TAR, ADDRESS), recv=
);
>          if (rv) {
> -            dw_ic_tx_abort(s, DW_IC_TX_ABRT_7B_ADDR_NOACK);
> +            dw_ic_tx_abort(s, R_DW_IC_TX_ABRT_SOURCE_7B_ADDR_NOACK_MASK)=
;
>              return;
>          }
>          s->status =3D recv ? DW_I2C_STATUS_RECEIVING : DW_I2C_STATUS_SEN=
DING;
> @@ -480,25 +341,27 @@ static void dw_i2c_write_ic_data_cmd(DesignWareI2CS=
tate *s, uint32_t value)
>
>      /* Send data */
>      if (!recv) {
> -        int rv =3D i2c_send(s->bus, DW_IC_DATA_CMD_DAT(value));
> +        int rv =3D i2c_send(s->bus, FIELD_EX32(value, DW_IC_DATA_CMD, DA=
T));
>          if (rv) {
>              i2c_end_transfer(s->bus);
> -            dw_ic_tx_abort(s, DW_IC_TX_ABRT_TXDATA_NOACK);
> +            dw_ic_tx_abort(s, R_DW_IC_TX_ABRT_SOURCE_TXDATA_NOACK_MASK);
>              return;
>          }
>          dw_i2c_update_irq(s);
>      }
>
>      /* Restart command */
> -    if (value & DW_IC_DATA_CMD_RESTART && s->ic_con & DW_IC_CON_IC_RESTA=
RT_EN) {
> -        s->ic_raw_intr_stat |=3D DW_IC_INTR_RESTART_DET |
> -                               DW_IC_INTR_START_DET |
> -                               DW_IC_INTR_ACTIVITY;
> -        s->ic_status |=3D DW_IC_STATUS_ACTIVITY;
> +    if (value & R_DW_IC_DATA_CMD_RESTART_MASK &&
> +            s->regs[R_DW_IC_CON] & R_DW_IC_CON_IC_RESTART_EN_MASK) {
> +        s->regs[R_DW_IC_RAW_INTR_STAT] |=3D DW_IC_INTR_RESTART_DET_MASK =
|
> +                                          DW_IC_INTR_START_DET_MASK |
> +                                          DW_IC_INTR_ACTIVITY_MASK;
> +        s->regs[R_DW_IC_STATUS] |=3D R_DW_IC_STATUS_ACTIVITY_MASK;
>          dw_i2c_update_irq(s);
>
> -        if (i2c_start_transfer(s->bus, DW_IC_TAR_ADDRESS(s->ic_tar), rec=
v)) {
> -            dw_ic_tx_abort(s, DW_IC_TX_ABRT_7B_ADDR_NOACK);
> +        if (i2c_start_transfer(s->bus,
> +                    ARRAY_FIELD_EX32(s->regs, DW_IC_TAR, ADDRESS), recv)=
) {
> +            dw_ic_tx_abort(s, R_DW_IC_TX_ABRT_SOURCE_7B_ADDR_NOACK_MASK)=
;
>              return;
>          }
>
> @@ -507,87 +370,113 @@ static void dw_i2c_write_ic_data_cmd(DesignWareI2C=
State *s, uint32_t value)
>
>      /* Receive data */
>      if (recv) {
> -        g_assert(s->ic_rxflr =3D=3D fifo8_num_used(&s->rx_fifo));
> +        g_assert(s->regs[R_DW_IC_RXFLR] =3D=3D fifo8_num_used(&s->rx_fif=
o));
>
>          if (!fifo8_is_full(&s->rx_fifo)) {
>              fifo8_push(&s->rx_fifo, i2c_recv(s->bus));
> -            s->ic_rxflr++;
> +            s->regs[R_DW_IC_RXFLR]++;
>          } else {
> -            s->ic_raw_intr_stat |=3D DW_IC_INTR_RX_OVER;
> +            s->regs[R_DW_IC_RAW_INTR_STAT] |=3D DW_IC_INTR_RX_OVER_MASK;
>              dw_i2c_update_irq(s);
>          }
>
> -        if (s->ic_rxflr > s->ic_rx_tl) {
> -            s->ic_raw_intr_stat |=3D DW_IC_INTR_RX_FULL;
> +        if (s->regs[R_DW_IC_RXFLR] > s->regs[R_DW_IC_RX_TL]) {
> +            s->regs[R_DW_IC_RAW_INTR_STAT] |=3D DW_IC_INTR_RX_FULL_MASK;
>              dw_i2c_update_irq(s);
>          }
> -        if (value & DW_IC_DATA_CMD_STOP) {
> +        if (value & R_DW_IC_DATA_CMD_STOP_MASK) {
>              i2c_nack(s->bus);
>          }
>      }
>
>      /* Stop command */
> -    if (value & DW_IC_DATA_CMD_STOP) {
> -        s->ic_raw_intr_stat |=3D DW_IC_INTR_STOP_DET;
> -        s->ic_status &=3D ~DW_IC_STATUS_ACTIVITY;
> -        s->ic_raw_intr_stat &=3D ~DW_IC_INTR_TX_EMPTY;
> +    if (value & R_DW_IC_DATA_CMD_STOP_MASK) {
> +        s->regs[R_DW_IC_RAW_INTR_STAT] |=3D DW_IC_INTR_STOP_DET_MASK;
> +        s->regs[R_DW_IC_STATUS] &=3D ~R_DW_IC_STATUS_ACTIVITY_MASK;
> +        s->regs[R_DW_IC_RAW_INTR_STAT] &=3D ~DW_IC_INTR_TX_EMPTY_MASK;
>          i2c_end_transfer(s->bus);
>          dw_i2c_update_irq(s);
>      }
>  }
>
> -static void dw_i2c_write_ic_enable(DesignWareI2CState *s, uint32_t value=
)
> +static void dw_ic_intr_mask_reg_post_write(RegisterInfo *reg, uint64_t v=
alue)
> +{
> +    DesignWareI2CState *s =3D DESIGNWARE_I2C(reg->opaque);
> +
> +    dw_i2c_update_irq(s);
> +}
> +
> +static uint64_t dw_ic_enable_reg_pre_write(RegisterInfo *reg, uint64_t v=
alue)
>  {
> -    if (value & DW_IC_ENABLE_ENABLE && !(s->ic_con & DW_IC_CON_SLAVE_DIS=
ABLE)) {
> +    DesignWareI2CState *s =3D DESIGNWARE_I2C(reg->opaque);
> +
> +    if (value & R_DW_IC_ENABLE_ENABLE_MASK &&
> +            !(s->regs[R_DW_IC_CON] & R_DW_IC_CON_SLAVE_DISABLE_MASK)) {
>          qemu_log_mask(LOG_UNIMP,
>                        "%s: Designware I2C slave mode is not supported.\n=
",
>                        DEVICE(s)->canonical_path);
> -        return;
> +        return s->regs[R_DW_IC_ENABLE]; /* keep old value */
>      }
>
> -    s->ic_enable =3D value & DW_IC_ENABLE_MASK;
> +    return value;
> +}
> +
> +static void dw_ic_enable_reg_post_write(RegisterInfo *reg, uint64_t valu=
e)
> +{
> +    DesignWareI2CState *s =3D DESIGNWARE_I2C(reg->opaque);
> +
> +    s->regs[R_DW_IC_ENABLE] =3D value & R_DW_IC_ENABLE_ENABLE_MASK;
>
> -    if (value & DW_IC_ENABLE_ABORT || value & DW_IC_ENABLE_TX_CMD_BLOCK)=
 {
> -        dw_ic_tx_abort(s, DW_IC_TX_ABRT_USER_ABRT);
> +    if (value & R_DW_IC_ENABLE_ABORT_MASK || value & R_DW_IC_ENABLE_TX_C=
MD_BLOCK_MASK) {
> +        dw_ic_tx_abort(s, R_DW_IC_TX_ABRT_SOURCE_USER_ABRT_MASK);
>          return;
>      }
>
> -    if (value & DW_IC_ENABLE_ENABLE) {
> -        s->ic_enable_status |=3D DW_IC_ENABLE_STATUS_IC_EN;
> -        s->ic_status |=3D DW_IC_STATUS_ACTIVITY;
> -        s->ic_raw_intr_stat |=3D DW_IC_INTR_ACTIVITY |
> -                               DW_IC_INTR_START_DET |
> -                               DW_IC_INTR_TX_EMPTY;
> +    if (value & R_DW_IC_ENABLE_ENABLE_MASK) {
> +        s->regs[R_DW_IC_ENABLE_STATUS] |=3D R_DW_IC_ENABLE_STATUS_IC_EN_=
MASK;
> +        s->regs[R_DW_IC_STATUS] |=3D R_DW_IC_STATUS_ACTIVITY_MASK;
> +        s->regs[R_DW_IC_RAW_INTR_STAT] |=3D DW_IC_INTR_ACTIVITY_MASK |
> +                                          DW_IC_INTR_START_DET_MASK |
> +                                          DW_IC_INTR_TX_EMPTY_MASK;
>          s->status =3D DW_I2C_STATUS_SENDING_ADDRESS;
>          dw_i2c_update_irq(s);
> -    } else if ((value & DW_IC_ENABLE_ENABLE) =3D=3D 0) {
> +    } else if ((value & R_DW_IC_ENABLE_ENABLE_MASK) =3D=3D 0) {
>          dw_i2c_reset_to_idle(s);
>      }
> -
>  }
>
> -static void dw_i2c_write_ic_rx_tl(DesignWareI2CState *s, uint32_t value)
> +static uint64_t dw_ic_rx_tl_reg_pre_write(RegisterInfo *reg, uint64_t va=
lue)
>  {
> +    DesignWareI2CState *s =3D DESIGNWARE_I2C(reg->opaque);
> +
>      /* Note that a value of 0 for ic_rx_tl indicates a threashold of 1. =
*/
>      if (value > DESIGNWARE_I2C_RX_FIFO_SIZE - 1) {
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: invalid setting to ic_rx_tl %d\n",
> -                      DEVICE(s)->canonical_path, value);
> -        s->ic_rx_tl =3D DESIGNWARE_I2C_RX_FIFO_SIZE - 1;
> -    } else {
> -        s->ic_rx_tl =3D value;
> +                      DEVICE(s)->canonical_path, (int)value);
> +        return DESIGNWARE_I2C_RX_FIFO_SIZE - 1;
>      }
>
> -    if (s->ic_rxflr > s->ic_rx_tl && s->ic_enable & DW_IC_ENABLE_ENABLE)=
 {
> -        s->ic_raw_intr_stat |=3D DW_IC_INTR_RX_FULL;
> +    return value;
> +}
> +
> +static void dw_ic_rx_tl_reg_post_write(RegisterInfo *reg, uint64_t value=
)
> +{
> +    DesignWareI2CState *s =3D DESIGNWARE_I2C(reg->opaque);
> +
> +    if (s->regs[R_DW_IC_RXFLR] > s->regs[R_DW_IC_RX_TL] &&
> +            s->regs[R_DW_IC_ENABLE] & R_DW_IC_ENABLE_ENABLE_MASK) {
> +        s->regs[R_DW_IC_RAW_INTR_STAT] |=3D DW_IC_INTR_RX_FULL_MASK;
>      } else {
> -        s->ic_raw_intr_stat &=3D ~DW_IC_INTR_RX_FULL;
> +        s->regs[R_DW_IC_RAW_INTR_STAT] &=3D ~DW_IC_INTR_RX_FULL_MASK;
>      }
>      dw_i2c_update_irq(s);
>  }
>
> -static void dw_i2c_write_ic_tx_tl(DesignWareI2CState *s, uint32_t value)
> +static uint64_t dw_ic_tx_tl_reg_pre_write(RegisterInfo *reg, uint64_t va=
lue)
>  {
> +    DesignWareI2CState *s =3D DESIGNWARE_I2C(reg->opaque);
> +
>      /*
>       * Note that a value of 0 for ic_tx_tl indicates a threashold of 1.
>       * However, the tx threshold is not used in the model because comman=
ds are
> @@ -596,106 +485,154 @@ static void dw_i2c_write_ic_tx_tl(DesignWareI2CSt=
ate *s, uint32_t value)
>      if (value > DESIGNWARE_I2C_TX_FIFO_SIZE - 1) {
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: invalid setting to ic_tx_tl %d\n",
> -                      DEVICE(s)->canonical_path, value);
> -        s->ic_tx_tl =3D DESIGNWARE_I2C_TX_FIFO_SIZE - 1;
> -    } else {
> -        s->ic_tx_tl =3D value;
> +                      DEVICE(s)->canonical_path, (int)value);
> +        return DESIGNWARE_I2C_TX_FIFO_SIZE - 1;
>      }
> -}
>
> -static void dw_i2c_write(void *opaque, hwaddr offset, uint64_t value,
> -                              unsigned size)
> -{
> -    DesignWareI2CState *s =3D opaque;
> -
> -    trace_dw_i2c_write(DEVICE(s)->canonical_path, offset, value);
> -
> -    /* The order of the registers are their order in memory. */
> -    switch (offset) {
> -    case DW_IC_CON:
> -        dw_i2c_write_ic_con(s, value);
> -        break;
> -    case DW_IC_TAR:
> -        s->ic_tar =3D value & DW_IC_TAR_MASK;
> -        break;
> -    case DW_IC_SAR:
> -        qemu_log_mask(LOG_UNIMP, "%s: unsupported write - ic_sar\n",
> -                      DEVICE(s)->canonical_path);
> -        s->ic_sar =3D value & DW_IC_SAR_MASK;
> -        break;
> -    case DW_IC_DATA_CMD:
> -        dw_i2c_write_ic_data_cmd(s, value);
> -        break;
> -    case DW_IC_SS_SCL_HCNT:
> -        s->ic_ss_scl_hcnt =3D value & DW_IC_SS_SCL_HCNT_MASK;
> -        break;
> -    case DW_IC_SS_SCL_LCNT:
> -        s->ic_ss_scl_lcnt =3D value & DW_IC_SS_SCL_LCNT_MASK;
> -        break;
> -    case DW_IC_FS_SCL_HCNT:
> -        s->ic_fs_scl_hcnt =3D value & DW_IC_FS_SCL_HCNT_MASK;
> -        break;
> -    case DW_IC_FS_SCL_LCNT:
> -        s->ic_fs_scl_lcnt =3D value & DW_IC_FS_SCL_LCNT_MASK;
> -        break;
> -    case DW_IC_INTR_MASK:
> -        s->ic_intr_mask =3D value & DW_IC_INTR_MASK_MASK;
> -        dw_i2c_update_irq(s);
> -        break;
> -    case DW_IC_RX_TL:
> -        dw_i2c_write_ic_rx_tl(s, value);
> -        break;
> -    case DW_IC_TX_TL:
> -        dw_i2c_write_ic_tx_tl(s, value);
> -        break;
> -    case DW_IC_ENABLE:
> -        dw_i2c_write_ic_enable(s, value);
> -        break;
> -    case DW_IC_SDA_HOLD:
> -        s->ic_sda_hold =3D value & DW_IC_SDA_HOLD_MASK;
> -        break;
> -    case DW_IC_SLV_DATA_NACK_ONLY:
> -        qemu_log_mask(LOG_UNIMP,
> -                      "%s: unsupported write - ic_slv_data_nack_only\n",
> -                      DEVICE(s)->canonical_path);
> -        break;
> -    case DW_IC_DMA_CR:
> -        qemu_log_mask(LOG_UNIMP, "%s: unsupported write - ic_dma_cr\n",
> -                      DEVICE(s)->canonical_path);
> -        break;
> -    case DW_IC_DMA_TDLR:
> -        qemu_log_mask(LOG_UNIMP, "%s: unsupported write - ic_dma_tdlr\n"=
,
> -                      DEVICE(s)->canonical_path);
> -        break;
> -    case DW_IC_DMA_RDLR:
> -        qemu_log_mask(LOG_UNIMP, "%s: unsupported write - ic_dma_rdlr\n"=
,
> -                      DEVICE(s)->canonical_path);
> -        break;
> -    case DW_IC_SDA_SETUP:
> -        s->ic_sda_setup =3D value & DW_IC_SDA_SETUP_MASK;
> -        break;
> -    case DW_IC_ACK_GENERAL_CALL:
> -        qemu_log_mask(LOG_UNIMP,
> -                      "%s: unsupported write - ic_ack_general_call\n",
> -                      DEVICE(s)->canonical_path);
> -        break;
> -    case DW_IC_FS_SPKLEN:
> -        s->ic_fs_spklen =3D value & DW_IC_FS_SPKLEN_MASK;
> -        break;
> +    return value;
> +}
>
> -    /* This register is invalid at this point. */
> -    default:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: write to invalid offset or readonly register =
0x%"
> -                      HWADDR_PRIx "\n",
> -                      DEVICE(s)->canonical_path, offset);
> -        break;
> +static const RegisterAccessInfo designware_i2c_regs_info[] =3D {

QEMU doesn't expect you to implement the RegisterAccessInfo struct.
This struct exists as it's easy to autogenerate from RTL (or some
other source), but you don't have to write it out yourself. You can
use the REG/FIELD macros above and not RegisterAccessInfo, which is
what most devices do (Xilinx devices excluded).

Sorry for the extra hassle and work or converting it to
RegisterAccessInfo. Keeping the RegisterAccessInfo is fine, just
letting you know you don't have to do it next time.

I think squash these 4 together and that'll be it for the I2C patch in
your Atlantis series.

Alistair

