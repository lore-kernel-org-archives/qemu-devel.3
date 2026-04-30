Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C23FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 04:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIIg0-000489-0o; Thu, 30 Apr 2026 00:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIIfw-00047t-Si
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:06:57 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIIfs-0007MA-N2
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:06:56 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-38dd9f0fdc6so17838581fa.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 21:06:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777522011; cv=none;
 d=google.com; s=arc-20240605;
 b=lLhTNbdGiY1WbKRa4cTMpM8lMW+xLTGBdZdxapZDTOC8YiSW/DPPEklOdOe8MPpPeB
 X9XdFWZwHBFoF3QBulM2nOdPOnDOxDnawr3bzOWkMSmeAXp6F2DG7heMPYkmfuOOYp0i
 fl8OOOYP944tdGEjhoxUrFHdIJgCF/X34a6BS0+nD5VPjlH87I7N+V3g8Sa1KojPCHz8
 my0Dq1BiOUUqEdCr0zjjJrvzhRzGCLN1edCwYDuIUc10nq1U5J3De5JROYQ6QbsLLzxU
 rc4rrxbuWKq5sU1ueeTexgPUwe8Io4d5BjpDK8PwhMKZcLdljFXUicUjcrVyTT5RreaJ
 9YGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hlWUPudObPVWv8kMcOpV25jIHm6U8GzCgbO2GKJbH/0=;
 fh=DVgYJGs9e3xojhQ/KVC/Dfe0+7SQqU0xFHByAFldB7w=;
 b=S+BSIQp7RLn4O4axcmyssQ3TgOve1yJoto8MlgMax0FB55lp63qxzcbr8sQrrY3DpD
 6oOC3+cw3URqzdIVHPV5/yfn7K1BUiT0x/7W5dbfCQT/6owXIhaetWo7XAGisB0TBETy
 oQ+cmfL2Pfu/lrOyeXRNZbLkSnn/Cc61urjC5FUDGacloPHabjytK04JLMjtpigHUyyN
 MSNZB763K8KI1i8JSkiYp31qZEcQkfwJn7OBJgEDQZz3Idzk1yvGomtnrufd/xol2vRD
 87vsJMBFR4upWv0HtPcEUZ/ejON8V3aF/O/58ipAa86kzJoBdY7xwER1V3UITzEPNQYd
 Dzhg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777522011; x=1778126811; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hlWUPudObPVWv8kMcOpV25jIHm6U8GzCgbO2GKJbH/0=;
 b=dUFc6Dh8XHEpnj/222TCH0Tmtj58flBXn9cEY/3076mSsH7sxo5PzlIJNidNOiZogS
 8kFPfp3UIRHHqIx0pS8glc1x1zljQIVLpK0LuBIRRcQA5HLGybzhdzGzHB1esCLDqQjd
 dK4HrrOoB5C/HAK/FEWFCW1aBXKpd5C1WLvlnxGZXErkGvahDSV0YQ6ns3ttHgpgJZhu
 WapM8WlEfqXgiGEuB95OE6o+OmQKckosNVNk4JK69yy/7hs1EhZn5eFFckf/Fk+HNHs/
 /rNplR58IbkCKdZBZkzbjvd9PNCcPegze/ErHW7GcO/MQrY7v/dBMdpWCU8/dO8T3IJk
 RIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777522011; x=1778126811;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hlWUPudObPVWv8kMcOpV25jIHm6U8GzCgbO2GKJbH/0=;
 b=rMC5eolHRTJwysg7h4Wj5Zl/aFmiS1TIzahYDV4R+QloznfNxTJXP/ACJHnjTVVg08
 TuL4upZxnWZQ8mQx9P+dazTCMLj00E1i133/pvzjlWPGyZ/riA/JcmkKZW+Te3ERcFs4
 o0BhnZ1n2K/fO55fy0aNGgfToJaTj99v6J2o/rZTXMmR/2nryrsr2EB1BM7J4oZMbhOg
 6LffKtC3Uf5zsb9OUHZIX5D6bqd8rvoyFQDRA+7sfZ4HrGi8Too/oZjlIl5p1bkfqDVG
 WIeZgFfIwOpBy+XPV7sTT70JzKnCWGAZN9Ffb6OtLEH81QLQZKijTIQHVOMUUsqzufBL
 CZyw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+AFjFlhNRMWQlCvhywOqsik6cOVDqcrfEzVi/MVQ5vfwjE6Gf6kAwaUtDuhIleTbrENk5lHKDkJpcb@nongnu.org
X-Gm-Message-State: AOJu0YxbJbR7wo7KTbNyxLlCenzBdvXynBZZzDXQDq1XgHSU+UK8OIDN
 892wO4MUBKt/+vzxPBUOxR6/eMJAEoq5LXgeoD9sJela+bWOVLKnrulxylE6Xbwy/8NFlowz6BT
 f+SNq8ck2YZrYL2juMd16jK+PD9cN1Ju+FszE
X-Gm-Gg: AeBDiese4Nh74ZrcfnE6hpSqPJ/71RNMVOHtgd2bi5MAYUMqPxCLDZqcDZKpN4EfYi4
 uLMCV3jUlHwtq9I9QqCEbWe63fryg7NiFgI0IbXdsG8VDI0o+Lcbj9116BqB9lMhCH0HXFapACd
 fTaectF65+7CUWQNQQzT/70JWiStWCf4kJlUb7WqGOPJVlUOgx9guzmAQLrsuZy+UhBAN0v3jRn
 9uGnpa5p7Sya+SCouZ1Ng+mrycjELDV0Jxr6TuOon9kIuU94s04j+PlGrhOB+M6BmG+wrb/zV/z
 NtqaJQEIn56EJV80EBvwB/0KsUcM9QKQlpdt/xYt1gQLT7rUIgX2MQEe9lc=
X-Received: by 2002:a17:907:9493:b0:ba2:7836:788c with SMTP id
 a640c23a62f3a-bbb98a52f67mr38233366b.12.1777521228032; Wed, 29 Apr 2026
 20:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260425131721.932250-1-joel@jms.id.au>
 <20260425131721.932250-2-joel@jms.id.au>
In-Reply-To: <20260425131721.932250-2-joel@jms.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 30 Apr 2026 13:53:21 +1000
X-Gm-Features: AVHnY4KvUk-ZdK0pNSqxtihY0i4woRQTP8oX9P-bvNHbVoA24KTZSvW5985PqBc
Message-ID: <CAKmqyKPyUYfnS3BsHT31hp_P5ufDOZHmr3VW8aUyeTTSTS-Rcw@mail.gmail.com>
Subject: Re: [PATCH v4 01/13] hw/i2c: Add designware i2c controller
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Chris Rauer <crauer@google.com>, Michael Ellerman <mpe@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=alistair23@gmail.com; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, Apr 25, 2026 at 11:20=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrot=
e:
>
> From: Chris Rauer <crauer@google.com>
>
> In the past this model has been submitted for use with the arm virt
> machine, however in this case it will be used by the upcoming
> Tenstorrent Atlantis RISC-V machine.
>
> This is a re-submission of the model with Chris' permission, with a
> light touch of updates to make it build with qemu master.
>
> Reviewed-by: Hao Wu <wuhaotsh@google.com>
> Signed-off-by: Chris Rauer <crauer@google.com>
> Link: https://lore.kernel.org/qemu-devel/20220110214755.810343-2-venture@=
google.com
> [jms: rebase and minor build fixes for class_init and reset callback]
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v4: Remove unused random header
> v2: Add trace event for read and write, document Alano and myself as
> reviewers.
> ---
>  MAINTAINERS                     |   8 +
>  include/hw/i2c/designware_i2c.h | 101 ++++
>  hw/i2c/designware_i2c.c         | 817 ++++++++++++++++++++++++++++++++
>  hw/i2c/Kconfig                  |   4 +
>  hw/i2c/meson.build              |   1 +
>  hw/i2c/trace-events             |   4 +
>  6 files changed, 935 insertions(+)
>  create mode 100644 include/hw/i2c/designware_i2c.h
>  create mode 100644 hw/i2c/designware_i2c.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa4267b15806..e1942a86eba5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2716,6 +2716,14 @@ S: Orphan
>  F: hw/gpio/pcf8574.c
>  F: include/gpio/pcf8574.h
>
> +DesignWare I2C
> +M: Chris Rauer <crauer@google.com>
> +R: Alano Song <alanosong@163.com>
> +R: Joel Stanley <joel@jms.id.au>
> +S: Maintained
> +F: hw/i2c/designware_i2c.c
> +F: include/hw/i2c/designware_i2c.h
> +
>  Generic Loader
>  M: Alistair Francis <alistair@alistair23.me>
>  S: Maintained
> diff --git a/include/hw/i2c/designware_i2c.h b/include/hw/i2c/designware_=
i2c.h
> new file mode 100644
> index 000000000000..0d8f904f51b7
> --- /dev/null
> +++ b/include/hw/i2c/designware_i2c.h
> @@ -0,0 +1,101 @@
> +/*
> + * DesignWare I2C Module.
> + *
> + * Copyright 2021 Google LLC
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef DESIGNWARE_I2C_H
> +#define DESIGNWARE_I2C_H
> +
> +#include "hw/i2c/i2c.h"
> +#include "hw/core/irq.h"
> +#include "hw/core/sysbus.h"
> +
> +/* Size of the FIFO buffers. */
> +#define DESIGNWARE_I2C_RX_FIFO_SIZE 16
> +#define DESIGNWARE_I2C_TX_FIFO_SIZE 16
> +
> +typedef enum DesignWareI2CStatus {
> +    DW_I2C_STATUS_IDLE,
> +    DW_I2C_STATUS_SENDING_ADDRESS,
> +    DW_I2C_STATUS_SENDING,
> +    DW_I2C_STATUS_RECEIVING,
> +} DesignWareI2CStatus;
> +
> +/*
> + * struct DesignWareI2CState - DesignWare I2C device state.
> + * @bus: The underlying I2C Bus
> + * @irq: GIC interrupt line to fire on events
> + * @ic_con: : I2C control register
> + * @ic_tar: I2C target address register
> + * @ic_sar: I2C slave address register
> + * @ic_ss_scl_hcnt: Standard speed i2c clock scl high count register
> + * @ic_ss_scl_lcnt: Standard speed i2c clock scl low count register
> + * @ic_fs_scl_hcnt: Fast mode or fast mode plus i2c clock scl high count
> + *                  register
> + * @ic_fs_scl_lcnt:Fast mode or fast mode plus i2c clock scl low count
> + *                  register
> + * @ic_intr_mask: I2C Interrupt Mask Register
> + * @ic_raw_intr_stat: I2C raw interrupt status register
> + * @ic_rx_tl: I2C receive FIFO threshold register
> + * @ic_tx_tl: I2C transmit FIFO threshold register
> + * @ic_enable: I2C enable register
> + * @ic_status: I2C status register
> + * @ic_txflr: I2C transmit fifo level register
> + * @ic_rxflr: I2C receive fifo level register
> + * @ic_sda_hold: I2C SDA hold time length register
> + * @ic_tx_abrt_source: The I2C transmit abort source register
> + * @ic_sda_setup: I2C SDA setup register
> + * @ic_enable_status: I2C enable status register
> + * @ic_fs_spklen: I2C SS, FS or FM+ spike suppression limit
> + * @ic_comp_param_1: Component parameter register
> + * @ic_comp_version: I2C component version register
> + * @ic_comp_type: I2C component type register
> + * @rx_fifo: The FIFO buffer for receiving in FIFO mode.
> + * @rx_cur: The current position of rx_fifo.
> + * @status: The current status of the SMBus.
> + */
> +typedef struct DesignWareI2CState {
> +    SysBusDevice parent;
> +
> +    MemoryRegion iomem;
> +
> +    I2CBus      *bus;
> +    qemu_irq     irq;
> +
> +    uint32_t ic_con;
> +    uint32_t ic_tar;
> +    uint32_t ic_sar;
> +    uint32_t ic_ss_scl_hcnt;
> +    uint32_t ic_ss_scl_lcnt;
> +    uint32_t ic_fs_scl_hcnt;
> +    uint32_t ic_fs_scl_lcnt;
> +    uint32_t ic_intr_mask;
> +    uint32_t ic_raw_intr_stat;
> +    uint32_t ic_rx_tl;
> +    uint32_t ic_tx_tl;
> +    uint32_t ic_enable;
> +    uint32_t ic_status;
> +    uint32_t ic_txflr;
> +    uint32_t ic_rxflr;
> +    uint32_t ic_sda_hold;
> +    uint32_t ic_tx_abrt_source;
> +    uint32_t ic_sda_setup;
> +    uint32_t ic_enable_status;
> +    uint32_t ic_fs_spklen;
> +    uint32_t ic_comp_param_1;
> +    uint32_t ic_comp_version;
> +    uint32_t ic_comp_type;
> +
> +    uint8_t      rx_fifo[DESIGNWARE_I2C_RX_FIFO_SIZE];
> +    uint8_t      rx_cur;
> +
> +    DesignWareI2CStatus status;
> +} DesignWareI2CState;
> +
> +#define TYPE_DESIGNWARE_I2C "designware-i2c"
> +#define DESIGNWARE_I2C(obj) OBJECT_CHECK(DesignWareI2CState, (obj), \
> +                                        TYPE_DESIGNWARE_I2C)
> +
> +#endif /* DESIGNWARE_I2C_H */
> diff --git a/hw/i2c/designware_i2c.c b/hw/i2c/designware_i2c.c
> new file mode 100644
> index 000000000000..7d8b1c13533e
> --- /dev/null
> +++ b/hw/i2c/designware_i2c.c
> @@ -0,0 +1,817 @@
> +/*
> + * DesignWare I2C Module.
> + *
> + * Copyright 2021 Google LLC
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "hw/i2c/designware_i2c.h"
> +#include "migration/vmstate.h"
> +#include "qemu/bitops.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qemu/units.h"
> +#include "trace.h"
> +
> +enum DesignWareI2CRegister {
> +    DW_IC_CON                   =3D 0x00,
> +    DW_IC_TAR                   =3D 0x04,
> +    DW_IC_SAR                   =3D 0x08,
> +    DW_IC_DATA_CMD              =3D 0x10,
> +    DW_IC_SS_SCL_HCNT           =3D 0x14,
> +    DW_IC_SS_SCL_LCNT           =3D 0x18,
> +    DW_IC_FS_SCL_HCNT           =3D 0x1c,
> +    DW_IC_FS_SCL_LCNT           =3D 0x20,
> +    DW_IC_INTR_STAT             =3D 0x2c,
> +    DW_IC_INTR_MASK             =3D 0x30,
> +    DW_IC_RAW_INTR_STAT         =3D 0x34,
> +    DW_IC_RX_TL                 =3D 0x38,
> +    DW_IC_TX_TL                 =3D 0x3c,
> +    DW_IC_CLR_INTR              =3D 0x40,
> +    DW_IC_CLR_RX_UNDER          =3D 0x44,
> +    DW_IC_CLR_RX_OVER           =3D 0x48,
> +    DW_IC_CLR_TX_OVER           =3D 0x4c,
> +    DW_IC_CLR_RD_REQ            =3D 0x50,
> +    DW_IC_CLR_TX_ABRT           =3D 0x54,
> +    DW_IC_CLR_RX_DONE           =3D 0x58,
> +    DW_IC_CLR_ACTIVITY          =3D 0x5c,
> +    DW_IC_CLR_STOP_DET          =3D 0x60,
> +    DW_IC_CLR_START_DET         =3D 0x64,
> +    DW_IC_CLR_GEN_CALL          =3D 0x68,
> +    DW_IC_ENABLE                =3D 0x6c,
> +    DW_IC_STATUS                =3D 0x70,
> +    DW_IC_TXFLR                 =3D 0x74,
> +    DW_IC_RXFLR                 =3D 0x78,
> +    DW_IC_SDA_HOLD              =3D 0x7c,
> +    DW_IC_TX_ABRT_SOURCE        =3D 0x80,
> +    DW_IC_SLV_DATA_NACK_ONLY    =3D 0x84,
> +    DW_IC_DMA_CR                =3D 0x88,
> +    DW_IC_DMA_TDLR              =3D 0x8c,
> +    DW_IC_DMA_RDLR              =3D 0x90,
> +    DW_IC_SDA_SETUP             =3D 0x94,
> +    DW_IC_ACK_GENERAL_CALL      =3D 0x98,
> +    DW_IC_ENABLE_STATUS         =3D 0x9c,
> +    DW_IC_FS_SPKLEN             =3D 0xa0,
> +    DW_IC_CLR_RESTART_DET       =3D 0xa8,
> +    DW_IC_COMP_PARAM_1          =3D 0xf4,
> +    DW_IC_COMP_VERSION          =3D 0xf8,
> +    DW_IC_COMP_TYPE             =3D 0xfc,
> +};
> +
> +/* DW_IC_CON fields */
> +#define DW_IC_CON_STOP_DET_IF_MASTER_ACTIV  BIT(10)
> +#define DW_IC_CON_RX_FIFO_FULL_HLD_CTRL     BIT(9)
> +#define DW_IC_CON_TX_EMPTY_CTRL             BIT(8)
> +#define DW_IC_CON_STOP_IF_ADDRESSED         BIT(7)
> +#define DW_IC_CON_SLAVE_DISABLE             BIT(6)
> +#define DW_IC_CON_IC_RESTART_EN             BIT(5)
> +#define DW_IC_CON_10BITADDR_MASTER          BIT(4)
> +#define DW_IC_CON_10BITADDR_SLAVE           BIT(3)
> +#define DW_IC_CON_SPEED(rv)                 extract32((rv), 1, 2)
> +#define DW_IC_CON_MASTER_MODE               BIT(0)
> +
> +/* DW_IC_TAR fields */
> +#define DW_IC_TAR_IC_10BITADDR_MASTER  BIT(12)
> +#define DW_IC_TAR_SPECIAL              BIT(11)
> +#define DW_IC_TAR_GC_OR_START          BIT(10)
> +#define DW_IC_TAR_ADDRESS(rv)          extract32((rv), 0, 10)
> +
> +/* DW_IC_DATA_CMD fields */
> +#define DW_IC_DATA_CMD_RESTART  BIT(10)
> +#define DW_IC_DATA_CMD_STOP     BIT(9)
> +#define DW_IC_DATA_CMD_CMD      BIT(8)
> +#define DW_IC_DATA_CMD_DAT(rv)  extract32((rv), 0, 8)
> +
> +/* DW_IC_INTR_STAT/INTR_MASK/RAW_INTR_STAT fields */
> +#define DW_IC_INTR_RESTART_DET  BIT(12)
> +#define DW_IC_INTR_GEN_CALL     BIT(11)
> +#define DW_IC_INTR_START_DET    BIT(10)
> +#define DW_IC_INTR_STOP_DET     BIT(9)
> +#define DW_IC_INTR_ACTIVITY     BIT(8)
> +#define DW_IC_INTR_RX_DONE      BIT(7)
> +#define DW_IC_INTR_TX_ABRT      BIT(6)
> +#define DW_IC_INTR_RD_REQ       BIT(5)
> +#define DW_IC_INTR_TX_EMPTY     BIT(4) /* Hardware clear only. */
> +#define DW_IC_INTR_TX_OVER      BIT(3)
> +#define DW_IC_INTR_RX_FULL      BIT(2) /* Hardware clear only. */
> +#define DW_IC_INTR_RX_OVER      BIT(1)
> +#define DW_IC_INTR_RX_UNDER     BIT(0)
> +
> +/* DW_IC_ENABLE fields */
> +#define DW_IC_ENABLE_TX_CMD_BLOCK  BIT(2)
> +#define DW_IC_ENABLE_ABORT         BIT(1)
> +#define DW_IC_ENABLE_ENABLE        BIT(0)
> +
> +/* DW_IC_STATUS fields */
> +#define DW_IC_STATUS_SLV_ACTIVITY  BIT(6)
> +#define DW_IC_STATUS_MST_ACTIVITY  BIT(5)
> +#define DW_IC_STATUS_RFF           BIT(4)
> +#define DW_IC_STATUS_RFNE          BIT(3)
> +#define DW_IC_STATUS_TFE           BIT(2)
> +#define DW_IC_STATUS_TFNF          BIT(1)
> +#define DW_IC_STATUS_ACTIVITY      BIT(0)
> +
> +/* DW_IC_TX_ABRT_SOURCE fields */
> +#define DW_IC_TX_TX_FLUSH_CNT          extract32((rv), 23, 9)
> +#define DW_IC_TX_ABRT_USER_ABRT        BIT(16)
> +#define DW_IC_TX_ABRT_SLVRD_INTX       BIT(15)
> +#define DW_IC_TX_ABRT_SLV_ARBLOST      BIT(14)
> +#define DW_IC_TX_ABRT_SLVFLUSH_TXFIFO  BIT(13)
> +#define DW_IC_TX_ARB_LOST              BIT(12)
> +#define DW_IC_TX_ABRT_MASTER_DIS       BIT(11)
> +#define DW_IC_TX_ABRT_10B_RD_NORSTRT   BIT(10)
> +#define DW_IC_TX_ABRT_SBYTE_NORSTRT    BIT(9)
> +#define DW_IC_TX_ABRT_HS_NORSTRT       BIT(8)
> +#define DW_IC_TX_ABRT_SBYTE_ACKDET     BIT(7)
> +#define DW_IC_TX_ABRT_HS_ACKDET        BIT(6)
> +#define DW_IC_TX_ABRT_GCALL_READ       BIT(5)
> +#define DW_IC_TX_ABRT_GCALL_NOACK      BIT(4)
> +#define DW_IC_TX_ABRT_TXDATA_NOACK     BIT(3)
> +#define DW_IC_TX_ABRT_10ADDR2_NOACK    BIT(2)
> +#define DW_IC_TX_ABRT_10ADDR1_NOACK    BIT(1)
> +#define DW_IC_TX_ABRT_7B_ADDR_NOACK    BIT(0)
> +
> +
> +/* IC_ENABLE_STATUS fields */
> +#define DW_IC_ENABLE_STATUS_SLV_RX_DATA_LOST         BIT(2)
> +#define DW_IC_ENABLE_STATUS_SLV_DISABLED_WHILE_BUSY  BIT(1)
> +#define DW_IC_ENABLE_STATUS_IC_EN                    BIT(0)
> +
> +/* Masks for writable registers. */
> +#define DW_IC_CON_MASK          0x000003ff
> +#define DW_IC_TAR_MASK          0x00000fff
> +#define DW_IC_SAR_MASK          0x000003ff
> +#define DW_IC_SS_SCL_HCNT_MASK  0x0000ffff
> +#define DW_IC_SS_SCL_LCNT_MASK  0x0000ffff
> +#define DW_IC_FS_SCL_HCNT_MASK  0x0000ffff
> +#define DW_IC_FS_SCL_LCNT_MASK  0x0000ffff
> +#define DW_IC_INTR_MASK_MASK    0x00001fff
> +#define DW_IC_ENABLE_MASK       0x00000007
> +#define DW_IC_SDA_HOLD_MASK     0x00ffffff
> +#define DW_IC_SDA_SETUP_MASK    0x000000ff
> +#define DW_IC_FS_SPKLEN_MASK    0x000000ff
> +
> +/* Reset values */
> +#define DW_IC_CON_INIT_VAL          0x7d
> +#define DW_IC_TAR_INIT_VAL          0x1055
> +#define DW_IC_SAR_INIT_VAL          0x55
> +#define DW_IC_SS_SCL_HCNT_INIT_VAL  0x190
> +#define DW_IC_SS_SCL_LCNT_INIT_VAL  0x1d6
> +#define DW_IC_FS_SCL_HCNT_INIT_VAL  0x3c
> +#define DW_IC_FS_SCL_LCNT_INIT_VAL  0x82
> +#define DW_IC_INTR_MASK_INIT_VAL    0x8ff
> +#define DW_IC_STATUS_INIT_VAL       0x6
> +#define DW_IC_SDA_HOLD_INIT_VAL     0x1
> +#define DW_IC_SDA_SETUP_INIT_VAL    0x64
> +#define DW_IC_FS_SPKLEN_INIT_VAL    0x2
> +
> +#define DW_IC_COMP_PARAM_1_HAS_ENCODED_PARAMS   BIT(7)
> +#define DW_IC_COMP_PARAM_1_HAS_DMA              0 /* bit 6 - DMA disable=
d. */
> +#define DW_IC_COMP_PARAM_1_INTR_IO              BIT(5)
> +#define DW_IC_COMP_PARAM_1_HC_COUNT_VAL         0 /* bit 4 - disabled */
> +#define DW_IC_COMP_PARAM_1_HIGH_SPEED_MODE      (BIT(2) | BIT(3))
> +#define DW_IC_COMP_PARAM_1_APB_DATA_WIDTH_32    BIT(1) /* bits 0, 1 */
> +#define DW_IC_COMP_PARAM_1_INIT_VAL             \
> +    (DW_IC_COMP_PARAM_1_APB_DATA_WIDTH_32 | \
> +    DW_IC_COMP_PARAM_1_HIGH_SPEED_MODE | \
> +    DW_IC_COMP_PARAM_1_HC_COUNT_VAL | \
> +    DW_IC_COMP_PARAM_1_INTR_IO | \
> +    DW_IC_COMP_PARAM_1_HAS_DMA | \
> +    DW_IC_COMP_PARAM_1_HAS_ENCODED_PARAMS | \
> +    ((DESIGNWARE_I2C_RX_FIFO_SIZE - 1) << 8) | \
> +    ((DESIGNWARE_I2C_TX_FIFO_SIZE - 1) << 16))
> +#define DW_IC_COMP_VERSION_INIT_VAL             0x3132302a
> +#define DW_IC_COMP_TYPE_INIT_VAL                0x44570140

I would prefer these to sue the QEMU register API

> +
> +static void dw_i2c_update_irq(DesignWareI2CState *s)
> +{
> +    int level;
> +    uint32_t intr =3D s->ic_raw_intr_stat & s->ic_intr_mask;
> +
> +    level =3D !!((intr & DW_IC_INTR_RX_UNDER) |
> +        (intr & DW_IC_INTR_RX_OVER) |
> +        (intr & DW_IC_INTR_RX_FULL) |
> +        (intr & DW_IC_INTR_TX_OVER) |
> +        (intr & DW_IC_INTR_TX_EMPTY) |
> +        (intr & DW_IC_INTR_RD_REQ) |
> +        (intr & DW_IC_INTR_TX_ABRT) |
> +        (intr & DW_IC_INTR_RX_DONE) |
> +        (intr & DW_IC_INTR_ACTIVITY) |
> +        (intr & DW_IC_INTR_STOP_DET) |
> +        (intr & DW_IC_INTR_START_DET) |
> +        (intr & DW_IC_INTR_GEN_CALL) |
> +        (intr & DW_IC_INTR_RESTART_DET)
> +        );
> +    qemu_set_irq(s->irq, level);
> +}
> +
> +static uint32_t dw_i2c_read_ic_data_cmd(DesignWareI2CState *s)
> +{
> +    uint32_t value =3D s->rx_fifo[s->rx_cur];
> +
> +    if (s->status !=3D DW_I2C_STATUS_RECEIVING) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Attempted to read from RX fifo when not in re=
ceive "
> +                      "state.\n", DEVICE(s)->canonical_path);
> +        if (s->status !=3D DW_I2C_STATUS_IDLE) {
> +            s->ic_raw_intr_stat &=3D ~DW_IC_INTR_RX_UNDER;
> +            dw_i2c_update_irq(s);
> +        }
> +        return 0;
> +    }
> +
> +    s->rx_cur =3D (s->rx_cur + 1) % DESIGNWARE_I2C_RX_FIFO_SIZE;
> +
> +    if (s->ic_rxflr > 0) {
> +        s->ic_rxflr--;
> +    } else {
> +        s->ic_raw_intr_stat &=3D ~DW_IC_INTR_RX_UNDER;
> +        dw_i2c_update_irq(s);
> +        return 0;
> +    }
> +
> +    if (s->ic_rxflr <=3D s->ic_rx_tl) {
> +        s->ic_raw_intr_stat &=3D ~DW_IC_INTR_RX_FULL;
> +        dw_i2c_update_irq(s);
> +    }
> +
> +    return value;
> +}
> +
> +static uint64_t dw_i2c_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    uint64_t value =3D 0;
> +
> +    DesignWareI2CState *s =3D opaque;
> +
> +    switch (offset) {
> +    case DW_IC_CON:
> +        value =3D s->ic_con;
> +        break;
> +    case DW_IC_TAR:
> +        value =3D s->ic_tar;
> +        break;
> +    case DW_IC_SAR:
> +        qemu_log_mask(LOG_UNIMP, "%s: unsupported read - ic_sar\n",
> +                      DEVICE(s)->canonical_path);
> +        value =3D s->ic_sar;
> +        break;
> +    case DW_IC_DATA_CMD:
> +        value =3D dw_i2c_read_ic_data_cmd(s);
> +        break;
> +    case DW_IC_SS_SCL_HCNT:
> +        value =3D s->ic_ss_scl_hcnt;
> +        break;
> +    case DW_IC_SS_SCL_LCNT:
> +        value =3D s->ic_ss_scl_lcnt;
> +        break;
> +    case DW_IC_FS_SCL_HCNT:
> +        value =3D s->ic_fs_scl_hcnt;
> +        break;
> +    case DW_IC_FS_SCL_LCNT:
> +        value =3D s->ic_fs_scl_lcnt;
> +        break;
> +    case DW_IC_INTR_STAT:
> +        value =3D s->ic_raw_intr_stat & s->ic_intr_mask;
> +        break;
> +    case DW_IC_INTR_MASK:
> +        value =3D s->ic_intr_mask;
> +        break;
> +    case DW_IC_RAW_INTR_STAT:
> +        value =3D s->ic_raw_intr_stat;
> +        break;
> +    case DW_IC_RX_TL:
> +        value =3D s->ic_rx_tl;
> +        break;
> +    case DW_IC_TX_TL:
> +        value =3D s->ic_tx_tl;
> +        break;
> +    case DW_IC_CLR_INTR:
> +        s->ic_raw_intr_stat &=3D ~(DW_IC_INTR_GEN_CALL |
> +            DW_IC_INTR_RESTART_DET |
> +            DW_IC_INTR_START_DET |
> +            DW_IC_INTR_STOP_DET |
> +            DW_IC_INTR_ACTIVITY |
> +            DW_IC_INTR_RX_DONE |
> +            DW_IC_INTR_TX_ABRT |
> +            DW_IC_INTR_RD_REQ |
> +            DW_IC_INTR_TX_OVER |
> +            DW_IC_INTR_RX_OVER |
> +            DW_IC_INTR_RX_UNDER);
> +        s->ic_tx_abrt_source =3D 0;
> +        dw_i2c_update_irq(s);
> +        break;
> +    case DW_IC_CLR_RX_UNDER:
> +        s->ic_raw_intr_stat &=3D ~(DW_IC_INTR_RX_UNDER);
> +        dw_i2c_update_irq(s);
> +        break;
> +    case DW_IC_CLR_RX_OVER:
> +        s->ic_raw_intr_stat &=3D ~(DW_IC_INTR_RX_OVER);
> +        dw_i2c_update_irq(s);
> +        break;
> +    case DW_IC_CLR_TX_OVER:
> +        s->ic_raw_intr_stat &=3D ~(DW_IC_INTR_TX_OVER);
> +        dw_i2c_update_irq(s);
> +        break;
> +    case DW_IC_CLR_RD_REQ:
> +        s->ic_raw_intr_stat &=3D ~(DW_IC_INTR_RD_REQ);
> +        dw_i2c_update_irq(s);
> +        break;
> +    case DW_IC_CLR_TX_ABRT:
> +        s->ic_raw_intr_stat &=3D ~(DW_IC_INTR_TX_ABRT);
> +        s->ic_tx_abrt_source =3D 0;
> +        dw_i2c_update_irq(s);
> +        break;
> +    case DW_IC_CLR_RX_DONE:
> +        s->ic_raw_intr_stat &=3D ~(DW_IC_INTR_RX_DONE);
> +        dw_i2c_update_irq(s);
> +        break;
> +    case DW_IC_CLR_ACTIVITY:
> +        s->ic_raw_intr_stat &=3D ~(DW_IC_INTR_ACTIVITY);
> +        dw_i2c_update_irq(s);
> +        break;
> +    case DW_IC_CLR_STOP_DET:
> +        s->ic_raw_intr_stat &=3D ~(DW_IC_INTR_STOP_DET);
> +        dw_i2c_update_irq(s);
> +        break;
> +    case DW_IC_CLR_START_DET:
> +        s->ic_raw_intr_stat &=3D ~(DW_IC_INTR_START_DET);
> +        dw_i2c_update_irq(s);
> +        break;
> +    case DW_IC_CLR_GEN_CALL:
> +        s->ic_raw_intr_stat &=3D ~(DW_IC_INTR_GEN_CALL);
> +        dw_i2c_update_irq(s);
> +        break;
> +    case DW_IC_ENABLE:
> +        value =3D s->ic_enable;
> +        break;
> +    case DW_IC_STATUS:
> +        value =3D s->ic_status;
> +        break;
> +    case DW_IC_TXFLR:
> +        value =3D s->ic_txflr;
> +        break;
> +    case DW_IC_RXFLR:
> +        value =3D s->ic_rxflr;
> +        break;
> +    case DW_IC_SDA_HOLD:
> +        value =3D s->ic_sda_hold;
> +        break;
> +    case DW_IC_TX_ABRT_SOURCE:
> +        value =3D s->ic_tx_abrt_source;
> +        break;
> +    case DW_IC_SLV_DATA_NACK_ONLY:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: unsupported read - ic_slv_data_nack_only\n",
> +                      DEVICE(s)->canonical_path);
> +        break;
> +    case DW_IC_DMA_CR:
> +        qemu_log_mask(LOG_UNIMP, "%s: unsupported read - ic_dma_cr\n",
> +                      DEVICE(s)->canonical_path);
> +        break;
> +    case DW_IC_DMA_TDLR:
> +        qemu_log_mask(LOG_UNIMP, "%s: unsupported read - ic_dma_tdlr\n",
> +                      DEVICE(s)->canonical_path);
> +        break;
> +    case DW_IC_DMA_RDLR:
> +        qemu_log_mask(LOG_UNIMP, "%s: unsupported read - ic_dma_rdlr\n",
> +                      DEVICE(s)->canonical_path);
> +        break;
> +    case DW_IC_SDA_SETUP:
> +        value =3D s->ic_sda_setup;
> +        break;
> +    case DW_IC_ACK_GENERAL_CALL:
> +        qemu_log_mask(LOG_UNIMP, "%s: unsupported read - ic_ack_general_=
call\n",
> +                      DEVICE(s)->canonical_path);
> +        break;
> +    case DW_IC_ENABLE_STATUS:
> +        value =3D s->ic_enable_status;
> +        break;
> +    case DW_IC_FS_SPKLEN:
> +        value =3D s->ic_fs_spklen;
> +        break;
> +    case DW_IC_CLR_RESTART_DET:
> +        s->ic_raw_intr_stat &=3D ~(DW_IC_INTR_RESTART_DET);
> +        break;
> +    case DW_IC_COMP_PARAM_1:
> +        value =3D s->ic_comp_param_1;
> +        break;
> +    case DW_IC_COMP_VERSION:
> +        value =3D s->ic_comp_version;
> +        break;
> +    case DW_IC_COMP_TYPE:
> +        value =3D s->ic_comp_type;
> +        break;
> +
> +    /* This register is invalid at this point. */
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: read from invalid offset 0x%" HWADDR_PRIx "\n=
",
> +                      DEVICE(s)->canonical_path, offset);
> +        break;
> +    }
> +
> +    trace_dw_i2c_read(DEVICE(s)->canonical_path, offset, value);
> +
> +    return value;
> +}
> +
> +static void dw_i2c_write_ic_con(DesignWareI2CState *s, uint32_t value)
> +{
> +    if (value & DW_IC_CON_RX_FIFO_FULL_HLD_CTRL) {
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: unsupported ic_con flag - RX_FIFO_FULL_HLD_CT=
RL\n",
> +                      DEVICE(s)->canonical_path);
> +    }
> +
> +    if (!(s->ic_enable & DW_IC_ENABLE_ENABLE)) {
> +        s->ic_con =3D value & DW_IC_CON_MASK;
> +    } else {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: invalid setting to ic_con %d when ic_enable[0=
]=3D=3D1\n",
> +                      DEVICE(s)->canonical_path, value);
> +    }
> +}
> +
> +static void dw_i2c_reset_to_idle(DesignWareI2CState *s)
> +{
> +        s->ic_enable_status &=3D ~DW_IC_ENABLE_STATUS_IC_EN;
> +        s->ic_raw_intr_stat &=3D ~DW_IC_INTR_TX_EMPTY;
> +        s->ic_raw_intr_stat &=3D ~DW_IC_INTR_RX_FULL;
> +        s->ic_raw_intr_stat &=3D ~DW_IC_INTR_RX_UNDER;
> +        s->ic_raw_intr_stat &=3D ~DW_IC_INTR_RX_OVER;
> +        s->ic_rxflr =3D 0;
> +        s->ic_status &=3D ~DW_IC_STATUS_ACTIVITY;
> +        s->status =3D DW_I2C_STATUS_IDLE;
> +        dw_i2c_update_irq(s);
> +}
> +
> +static void dw_ic_tx_abort(DesignWareI2CState *s, uint32_t src)
> +{
> +    s->ic_tx_abrt_source |=3D src;
> +    s->ic_raw_intr_stat |=3D DW_IC_INTR_TX_ABRT;
> +    dw_i2c_reset_to_idle(s);
> +    dw_i2c_update_irq(s);
> +}
> +
> +static void dw_i2c_write_ic_data_cmd(DesignWareI2CState *s, uint32_t val=
ue)
> +{
> +    int recv =3D !!(value & DW_IC_DATA_CMD_CMD);
> +
> +    if (s->status =3D=3D DW_I2C_STATUS_IDLE ||
> +        s->ic_raw_intr_stat & DW_IC_INTR_TX_ABRT) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Attempted to write to TX fifo when it is held=
 in "
> +                      "reset.\n", DEVICE(s)->canonical_path);
> +        return;
> +    }
> +
> +    /* Send the address if it hasn't been sent yet. */
> +    if (s->status =3D=3D DW_I2C_STATUS_SENDING_ADDRESS) {
> +        int rv =3D i2c_start_transfer(s->bus, DW_IC_TAR_ADDRESS(s->ic_ta=
r), recv);
> +        if (rv) {
> +            dw_ic_tx_abort(s, DW_IC_TX_ABRT_7B_ADDR_NOACK);
> +            return;
> +        }
> +        s->status =3D recv ? DW_I2C_STATUS_RECEIVING : DW_I2C_STATUS_SEN=
DING;
> +    }
> +
> +    /* Send data */
> +    if (!recv) {
> +        int rv =3D i2c_send(s->bus, DW_IC_DATA_CMD_DAT(value));
> +        if (rv) {
> +            i2c_end_transfer(s->bus);
> +            dw_ic_tx_abort(s, DW_IC_TX_ABRT_TXDATA_NOACK);
> +            return;
> +        }
> +        dw_i2c_update_irq(s);
> +    }
> +
> +    /* Restart command */
> +    if (value & DW_IC_DATA_CMD_RESTART && s->ic_con & DW_IC_CON_IC_RESTA=
RT_EN) {
> +        s->ic_raw_intr_stat |=3D DW_IC_INTR_RESTART_DET |
> +                               DW_IC_INTR_START_DET |
> +                               DW_IC_INTR_ACTIVITY;
> +        s->ic_status |=3D DW_IC_STATUS_ACTIVITY;
> +        dw_i2c_update_irq(s);
> +
> +        if (i2c_start_transfer(s->bus, DW_IC_TAR_ADDRESS(s->ic_tar), rec=
v)) {
> +            dw_ic_tx_abort(s, DW_IC_TX_ABRT_7B_ADDR_NOACK);
> +            return;
> +        }
> +
> +        s->status =3D recv ? DW_I2C_STATUS_RECEIVING : DW_I2C_STATUS_SEN=
DING;
> +    }
> +
> +    /* Receive data */
> +    if (recv) {
> +        uint8_t pos =3D (s->rx_cur + s->ic_rxflr) % DESIGNWARE_I2C_RX_FI=
FO_SIZE;
> +
> +        if (s->ic_rxflr < DESIGNWARE_I2C_RX_FIFO_SIZE) {
> +            s->rx_fifo[pos] =3D i2c_recv(s->bus);
> +            s->ic_rxflr++;

QEMU also has the Fifo8 which would handle the FIFO for you, I would
prefer that as well.

> +        } else {
> +            s->ic_raw_intr_stat |=3D DW_IC_INTR_RX_OVER;
> +            dw_i2c_update_irq(s);
> +        }
> +
> +        if (s->ic_rxflr > s->ic_rx_tl) {
> +            s->ic_raw_intr_stat |=3D DW_IC_INTR_RX_FULL;
> +            dw_i2c_update_irq(s);
> +        }
> +        if (value & DW_IC_DATA_CMD_STOP) {
> +            i2c_nack(s->bus);
> +        }
> +    }
> +
> +    /* Stop command */
> +    if (value & DW_IC_DATA_CMD_STOP) {
> +        s->ic_raw_intr_stat |=3D DW_IC_INTR_STOP_DET;
> +        s->ic_status &=3D ~DW_IC_STATUS_ACTIVITY;
> +        s->ic_raw_intr_stat &=3D ~DW_IC_INTR_TX_EMPTY;
> +        i2c_end_transfer(s->bus);
> +        dw_i2c_update_irq(s);
> +    }
> +}
> +
> +static void dw_i2c_write_ic_enable(DesignWareI2CState *s, uint32_t value=
)
> +{
> +    if (value & DW_IC_ENABLE_ENABLE && !(s->ic_con & DW_IC_CON_SLAVE_DIS=
ABLE)) {
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: Designware I2C slave mode is not supported.\n=
",
> +                      DEVICE(s)->canonical_path);
> +        return;
> +    }
> +
> +    s->ic_enable =3D value & DW_IC_ENABLE_MASK;
> +
> +    if (value & DW_IC_ENABLE_ABORT || value & DW_IC_ENABLE_TX_CMD_BLOCK)=
 {
> +        dw_ic_tx_abort(s, DW_IC_TX_ABRT_USER_ABRT);
> +        return;
> +    }
> +
> +    if (value & DW_IC_ENABLE_ENABLE) {
> +        s->ic_enable_status |=3D DW_IC_ENABLE_STATUS_IC_EN;
> +        s->ic_status |=3D DW_IC_STATUS_ACTIVITY;
> +        s->ic_raw_intr_stat |=3D DW_IC_INTR_ACTIVITY |
> +                               DW_IC_INTR_START_DET |
> +                               DW_IC_INTR_TX_EMPTY;
> +        s->status =3D DW_I2C_STATUS_SENDING_ADDRESS;
> +        dw_i2c_update_irq(s);
> +    } else if ((value & DW_IC_ENABLE_ENABLE) =3D=3D 0) {
> +        dw_i2c_reset_to_idle(s);
> +    }
> +
> +}
> +
> +static void dw_i2c_write_ic_rx_tl(DesignWareI2CState *s, uint32_t value)
> +{
> +    /* Note that a value of 0 for ic_rx_tl indicates a threashold of 1. =
*/
> +    if (value > DESIGNWARE_I2C_RX_FIFO_SIZE - 1) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: invalid setting to ic_rx_tl %d\n",
> +                      DEVICE(s)->canonical_path, value);
> +        s->ic_rx_tl =3D DESIGNWARE_I2C_RX_FIFO_SIZE - 1;
> +    } else {
> +        s->ic_rx_tl =3D value;
> +    }
> +
> +    if (s->ic_rxflr > s->ic_rx_tl && s->ic_enable & DW_IC_ENABLE_ENABLE)=
 {
> +        s->ic_raw_intr_stat |=3D DW_IC_INTR_RX_FULL;
> +    } else {
> +        s->ic_raw_intr_stat &=3D ~DW_IC_INTR_RX_FULL;
> +    }
> +    dw_i2c_update_irq(s);
> +}
> +
> +static void dw_i2c_write_ic_tx_tl(DesignWareI2CState *s, uint32_t value)
> +{
> +    /*
> +     * Note that a value of 0 for ic_tx_tl indicates a threashold of 1.
> +     * However, the tx threshold is not used in the model because comman=
ds are
> +     * always sent out as soon as they are written.
> +     */
> +    if (value > DESIGNWARE_I2C_TX_FIFO_SIZE - 1) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: invalid setting to ic_tx_tl %d\n",
> +                      DEVICE(s)->canonical_path, value);
> +        s->ic_tx_tl =3D DESIGNWARE_I2C_TX_FIFO_SIZE - 1;
> +    } else {
> +        s->ic_tx_tl =3D value;
> +    }
> +}
> +
> +static void dw_i2c_write(void *opaque, hwaddr offset, uint64_t value,
> +                              unsigned size)
> +{
> +    DesignWareI2CState *s =3D opaque;
> +
> +    trace_dw_i2c_write(DEVICE(s)->canonical_path, offset, value);
> +
> +    /* The order of the registers are their order in memory. */
> +    switch (offset) {
> +    case DW_IC_CON:
> +        dw_i2c_write_ic_con(s, value);
> +        break;
> +    case DW_IC_TAR:
> +        s->ic_tar =3D value & DW_IC_TAR_MASK;
> +        break;
> +    case DW_IC_SAR:
> +        qemu_log_mask(LOG_UNIMP, "%s: unsupported write - ic_sar\n",
> +                      DEVICE(s)->canonical_path);
> +        s->ic_sar =3D value & DW_IC_SAR_MASK;
> +        break;
> +    case DW_IC_DATA_CMD:
> +        dw_i2c_write_ic_data_cmd(s, value);
> +        break;
> +    case DW_IC_SS_SCL_HCNT:
> +        s->ic_ss_scl_hcnt =3D value & DW_IC_SS_SCL_HCNT_MASK;
> +        break;
> +    case DW_IC_SS_SCL_LCNT:
> +        s->ic_ss_scl_lcnt =3D value & DW_IC_SS_SCL_LCNT_MASK;
> +        break;
> +    case DW_IC_FS_SCL_HCNT:
> +        s->ic_fs_scl_hcnt =3D value & DW_IC_FS_SCL_HCNT_MASK;
> +        break;
> +    case DW_IC_FS_SCL_LCNT:
> +        s->ic_fs_scl_lcnt =3D value & DW_IC_FS_SCL_LCNT_MASK;
> +        break;
> +    case DW_IC_INTR_MASK:
> +        s->ic_intr_mask =3D value & DW_IC_INTR_MASK_MASK;
> +        dw_i2c_update_irq(s);
> +        break;
> +    case DW_IC_RX_TL:
> +        dw_i2c_write_ic_rx_tl(s, value);
> +        break;
> +    case DW_IC_TX_TL:
> +        dw_i2c_write_ic_tx_tl(s, value);
> +        break;
> +    case DW_IC_ENABLE:
> +        dw_i2c_write_ic_enable(s, value);
> +        break;
> +    case DW_IC_SDA_HOLD:
> +        s->ic_sda_hold =3D value & DW_IC_SDA_HOLD_MASK;
> +        break;
> +    case DW_IC_SLV_DATA_NACK_ONLY:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: unsupported write - ic_slv_data_nack_only\n",
> +                      DEVICE(s)->canonical_path);
> +        break;
> +    case DW_IC_DMA_CR:
> +        qemu_log_mask(LOG_UNIMP, "%s: unsupported write - ic_dma_cr\n",
> +                      DEVICE(s)->canonical_path);
> +        break;
> +    case DW_IC_DMA_TDLR:
> +        qemu_log_mask(LOG_UNIMP, "%s: unsupported write - ic_dma_tdlr\n"=
,
> +                      DEVICE(s)->canonical_path);
> +        break;
> +    case DW_IC_DMA_RDLR:
> +        qemu_log_mask(LOG_UNIMP, "%s: unsupported write - ic_dma_rdlr\n"=
,
> +                      DEVICE(s)->canonical_path);
> +        break;
> +    case DW_IC_SDA_SETUP:
> +        s->ic_sda_setup =3D value & DW_IC_SDA_SETUP_MASK;
> +        break;
> +    case DW_IC_ACK_GENERAL_CALL:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: unsupported write - ic_ack_general_call\n",
> +                      DEVICE(s)->canonical_path);
> +        break;
> +    case DW_IC_FS_SPKLEN:
> +        s->ic_fs_spklen =3D value & DW_IC_FS_SPKLEN_MASK;
> +        break;
> +
> +    /* This register is invalid at this point. */
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: write to invalid offset or readonly register =
0x%"
> +                      HWADDR_PRIx "\n",
> +                      DEVICE(s)->canonical_path, offset);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps designware_i2c_ops =3D {
> +    .read =3D dw_i2c_read,
> +    .write =3D dw_i2c_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +        .unaligned =3D false,
> +    },
> +};
> +
> +static void designware_i2c_enter_reset(Object *obj, ResetType type)
> +{
> +    DesignWareI2CState *s =3D DESIGNWARE_I2C(obj);
> +
> +    s->ic_con =3D DW_IC_CON_INIT_VAL;
> +    s->ic_tar =3D DW_IC_TAR_INIT_VAL;
> +    s->ic_sar =3D DW_IC_SAR_INIT_VAL;
> +    s->ic_ss_scl_hcnt =3D DW_IC_SS_SCL_HCNT_INIT_VAL;
> +    s->ic_ss_scl_lcnt =3D DW_IC_SS_SCL_LCNT_INIT_VAL;
> +    s->ic_fs_scl_hcnt =3D DW_IC_FS_SCL_HCNT_INIT_VAL;
> +    s->ic_fs_scl_lcnt =3D DW_IC_FS_SCL_LCNT_INIT_VAL;
> +    s->ic_intr_mask =3D DW_IC_INTR_MASK_INIT_VAL;
> +    s->ic_raw_intr_stat =3D 0;
> +    s->ic_rx_tl =3D 0;
> +    s->ic_tx_tl =3D 0;
> +    s->ic_enable =3D 0;
> +    s->ic_status =3D DW_IC_STATUS_INIT_VAL;
> +    s->ic_txflr =3D 0;
> +    s->ic_rxflr =3D 0;
> +    s->ic_sda_hold =3D DW_IC_SDA_HOLD_INIT_VAL;
> +    s->ic_tx_abrt_source =3D 0;
> +    s->ic_sda_setup =3D DW_IC_SDA_SETUP_INIT_VAL;
> +    s->ic_enable_status =3D 0;
> +    s->ic_fs_spklen =3D DW_IC_FS_SPKLEN_INIT_VAL;
> +    s->ic_comp_param_1 =3D DW_IC_COMP_PARAM_1_INIT_VAL;
> +    s->ic_comp_version =3D DW_IC_COMP_VERSION_INIT_VAL;
> +    s->ic_comp_type =3D DW_IC_COMP_TYPE_INIT_VAL;
> +
> +    s->rx_cur =3D 0;
> +    s->status =3D DW_I2C_STATUS_IDLE;
> +}
> +
> +static void designware_i2c_hold_reset(Object *obj, ResetType type)
> +{
> +    DesignWareI2CState *s =3D DESIGNWARE_I2C(obj);
> +
> +    qemu_irq_lower(s->irq);
> +}
> +
> +static const VMStateDescription vmstate_designware_i2c =3D {
> +    .name =3D TYPE_DESIGNWARE_I2C,
> +    .version_id =3D 0,
> +    .minimum_version_id =3D 0,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32(ic_con, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_tar, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_sar, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_ss_scl_hcnt, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_ss_scl_lcnt, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_fs_scl_hcnt, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_fs_scl_lcnt, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_intr_mask, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_raw_intr_stat, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_rx_tl, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_tx_tl, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_enable, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_status, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_txflr, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_rxflr, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_sda_hold, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_tx_abrt_source, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_sda_setup, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_enable_status, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_fs_spklen, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_comp_param_1, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_comp_version, DesignWareI2CState),
> +        VMSTATE_UINT32(ic_comp_type, DesignWareI2CState),
> +        VMSTATE_UINT32(status, DesignWareI2CState),
> +        VMSTATE_UINT8_ARRAY(rx_fifo, DesignWareI2CState,
> +                        DESIGNWARE_I2C_RX_FIFO_SIZE),
> +        VMSTATE_UINT8(rx_cur, DesignWareI2CState),
> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
> +static void designware_i2c_smbus_init(Object *obj)
> +{
> +    DesignWareI2CState *s =3D DESIGNWARE_I2C(obj);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +
> +    sysbus_init_irq(sbd, &s->irq);
> +
> +    memory_region_init_io(&s->iomem, obj, &designware_i2c_ops, s,
> +                          "regs", 4 * KiB);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +
> +    s->bus =3D i2c_init_bus(DEVICE(s), "i2c-bus");
> +}
> +
> +static void designware_i2c_class_init(ObjectClass *klass, const void *da=
ta)
> +{
> +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->desc =3D "Designware I2C";
> +    dc->vmsd =3D &vmstate_designware_i2c;
> +    rc->phases.enter =3D designware_i2c_enter_reset;
> +    rc->phases.hold =3D designware_i2c_hold_reset;
> +}
> +
> +static const TypeInfo designware_i2c_types[] =3D {
> +    {
> +        .name =3D TYPE_DESIGNWARE_I2C,
> +        .parent =3D TYPE_SYS_BUS_DEVICE,
> +        .instance_size =3D sizeof(DesignWareI2CState),
> +        .class_init =3D designware_i2c_class_init,
> +        .instance_init =3D designware_i2c_smbus_init,
> +    },
> +};
> +DEFINE_TYPES(designware_i2c_types);

Overall this looks ok. I don't have access to the datasheet though (I
assume that's secret) so it's just a quick read through

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
> index 596a7a3165ad..d3f394edeb9c 100644
> --- a/hw/i2c/Kconfig
> +++ b/hw/i2c/Kconfig
> @@ -18,6 +18,10 @@ config ARM_SBCON_I2C
>      bool
>      select BITBANG_I2C
>
> +config DESIGNWARE_I2C
> +    bool
> +    select I2C
> +
>  config ACPI_SMBUS
>      bool
>      select SMBUS
> diff --git a/hw/i2c/meson.build b/hw/i2c/meson.build
> index c459adcb596c..88aea35662dd 100644
> --- a/hw/i2c/meson.build
> +++ b/hw/i2c/meson.build
> @@ -11,6 +11,7 @@ i2c_ss.add(when: 'CONFIG_MPC_I2C', if_true: files('mpc_=
i2c.c'))
>  i2c_ss.add(when: 'CONFIG_ALLWINNER_I2C', if_true: files('allwinner-i2c.c=
'))
>  i2c_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('microbit_i2c.c'))
>  i2c_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_smbus.c'))
> +i2c_ss.add(when: 'CONFIG_DESIGNWARE_I2C', if_true: files('designware_i2c=
.c'))
>  i2c_ss.add(when: 'CONFIG_SMBUS_EEPROM', if_true: files('smbus_eeprom.c')=
)
>  i2c_ss.add(when: 'CONFIG_ARM_SBCON_I2C', if_true: files('arm_sbcon_i2c.c=
'))
>  i2c_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_i2c.c'))
> diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
> index 1ad0e95c0e60..8a78d2d3c8de 100644
> --- a/hw/i2c/trace-events
> +++ b/hw/i2c/trace-events
> @@ -61,3 +61,7 @@ pca954x_read_data(uint8_t value) "PCA954X read data: 0x=
%02x"
>
>  imx_i2c_read(const char *id, const char *reg, uint64_t ofs, uint64_t val=
ue) "%s:[%s (0x%" PRIx64 ")] -> 0x%02" PRIx64
>  imx_i2c_write(const char *id, const char *reg, uint64_t ofs, uint64_t va=
lue) "%s:[%s (0x%" PRIx64 ")] <- 0x%02" PRIx64
> +
> +# designware_i2c.c
> +dw_i2c_read(const char *id, uint64_t ofs, uint64_t value) "%s: offset 0x=
%02" PRIx64 " -> value: 0x%02" PRIx64
> +dw_i2c_write(const char *id, uint64_t ofs, uint64_t value) "%s: offset: =
0x%02" PRIx64 " <- value: 0x%02" PRIx64
> --
> 2.47.3
>
>

