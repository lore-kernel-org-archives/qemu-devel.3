Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE75CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDLf7-0006UR-Fq; Mon, 27 Oct 2025 07:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vDLf4-0006Sq-RH
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:45:19 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vDLf0-0006KZ-5m
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:45:18 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-63c3d913b3bso7722106a12.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761565509; x=1762170309; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PFSH39XRIMlwqwI+bqs2giHc9er1rtvjubUyS0EOFQQ=;
 b=vZ1olwCJerCb54uZQgSgDit5QIxCD8Fd4XrZnN+ykl8wbiARbC6vrYAa3qE4K1jlI6
 sR6jq74Llj2ldJND0F7WZ/hj2cBSFrtCAsHLQ5Aif5sNumqRbVS4tGfFSrdlPSMrJiEq
 WQGeH4rpDUj5lvSdghUBysqZlaaKWC2YsRZteNidrtEernpChQFLbkSxfrqNkROMcsFa
 VyeTo8Cf8sxP7h+F/jRj+L5qHEiSUtm3CfIPcvDGGFnSDMFB3rEU89cBFQtCq+nG+QUt
 +BrSP11p7zIT6qJp5iIAd2vTx/B6R+Zhui/ufYmr3CZiavDXkkXOnJ5ArJpBi2p2vQYc
 VG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761565510; x=1762170310;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PFSH39XRIMlwqwI+bqs2giHc9er1rtvjubUyS0EOFQQ=;
 b=QZpb3pwQK5Y/B0PVzA20C1l4XuPlkSvvLqCye5uFKDYSBX4qdTqK3aVF+1aEclFO4/
 WyLkXpJhNcKiWXkQNAkkBiyfP5Fdmlx8a2ZtmVW2V2xD1oKrUQETOPqPNtORzB6EBbe4
 WPU7QhA4nfzi5L4i+y40qoJI7fXy1AFznkIjavMuvRaEz0oC+YQhvBusa24HLVxxDME5
 A9kKAb7cRZNfPmfeULaGjsUsv7IiNSMte+PkmozJXENIm734M9nRnd1oDC1gvLBihq9A
 VvfD8BTJZTV02Xwj18aomM9p/EFIDnLibI1CshHv/AdsbZ9JTltXNwd3EAy/I9gsAHCC
 F/7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXayH0IttfpA4qnSHKqfTSTtcTVxwyNzH6WTr9LNaPmLt8qK2Omx/ew4pcJNbfaeWC9/HGEd4cqHBd7@nongnu.org
X-Gm-Message-State: AOJu0YxtJs5NIN/HdAUkvRT+9oRO0RNyG/zGEWmKYXCk22XxIeaQVVHF
 ChB0UwrVZOiCe1wUTpTZnwYcHuqZnkWEQiu07cAtovSLlBrhX6evCxKxnYNCHbxt95ENbEnVZ98
 xl93toYG3saaPylSLAUHnofWkVugKP1en1EvEMqId+g==
X-Gm-Gg: ASbGncuVc42QbH4H+AksNGdIxiiUvS7JDmu+mr10D031q+XL00jw2+NZoZmBWQ0QwJm
 uFazkDbR9aMvQwSZRaDv1lVLc7kMHd42tgn67E7AIh3ME2twMWH+zEEpi1z+4phEBmj5hnVt6yn
 l/wnkaGRFciJL9hA9XRW5PLHCd6EduDJKRBQ7n/6uYpENgG0A8P44crl2kzSWAmOH2IHbagKuqL
 hj+81UjoRhLWSkSjlSjeP2gnUBfEaQL1GQnKjBuQUXZcnkWaxqSwA5E25iw6dNeVpiOoIMU
X-Google-Smtp-Source: AGHT+IEWw3nvJbS54MlftPnMOotBRaZt+4RO2auERxOZhnB9LpqFf1ztTe8OdlTCI2b5JQUyzlOnjDQzc/m59LRNw5I=
X-Received: by 2002:a05:6402:34c8:b0:63b:ee26:5449 with SMTP id
 4fb4d7f45d1cf-63e3e597dfemr12423873a12.32.1761565509458; Mon, 27 Oct 2025
 04:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <20251027075123.2237914-1-quic_haixcui@quicinc.com>
 <20251027075123.2237914-3-quic_haixcui@quicinc.com>
In-Reply-To: <20251027075123.2237914-3-quic_haixcui@quicinc.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 27 Oct 2025 13:44:42 +0200
X-Gm-Features: AWmQ_bkoH6c8qrpquPHT31h3ZNP47BqJsP5TyVHLiEnDGz_SFQE2ek-pt_0hREE
Message-ID: <CAAjaMXamfeLc+ca3Cg+ZpqEM+jw6zg1w=sX63NX7FCSHgQj+NQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] standard-headers: Update virtio_spi.h from Linux
 v6.18-rc3
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: alex.bennee@linaro.org, viresh.kumar@linaro.org, quic_tsoni@quicinc.com, 
 qemu-devel@nongnu.org, mst@redhat.com, zhiqiang.tu@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x535.google.com
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

On Mon, Oct 27, 2025 at 9:52=E2=80=AFAM Haixu Cui <quic_haixcui@quicinc.com=
> wrote:
>
> Synced virtio_spi.h from upstream Linux kernelusing
> scripts/update-linux-headers.sh.
>
> Source:
> - Linux commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa (v6.18-rc3)
> - Author: Linus Torvalds <torvalds@linux-foundation.org>
> - Date:   Sun Oct 26 15:59:49 2025 -0700
>
> This update ensures QEMU's standard headers are consistent with the lates=
t
> virtio SPI definitions from Linux v6.18-rc3.
>
> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  include/standard-headers/linux/virtio_spi.h | 181 ++++++++++++++++++++
>  1 file changed, 181 insertions(+)
>  create mode 100644 include/standard-headers/linux/virtio_spi.h
>
> diff --git a/include/standard-headers/linux/virtio_spi.h b/include/standa=
rd-headers/linux/virtio_spi.h
> new file mode 100644
> index 0000000000..54e570fb4a
> --- /dev/null
> +++ b/include/standard-headers/linux/virtio_spi.h
> @@ -0,0 +1,181 @@
> +/* SPDX-License-Identifier: BSD-3-Clause */
> +/*
> + * Copyright (C) 2023 OpenSynergy GmbH
> + * Copyright (C) 2025 Qualcomm Innovation Center, Inc. All rights reserv=
ed.
> + */
> +#ifndef _LINUX_VIRTIO_VIRTIO_SPI_H
> +#define _LINUX_VIRTIO_VIRTIO_SPI_H
> +
> +#include "standard-headers/linux/types.h"
> +#include "standard-headers/linux/virtio_config.h"
> +#include "standard-headers/linux/virtio_ids.h"
> +#include "standard-headers/linux/virtio_types.h"
> +
> +/* Sample data on trailing clock edge */
> +#define VIRTIO_SPI_CPHA                        _BITUL(0)
> +/* Clock is high when IDLE */
> +#define VIRTIO_SPI_CPOL                        _BITUL(1)
> +/* Chip Select is active high */
> +#define VIRTIO_SPI_CS_HIGH                     _BITUL(2)
> +/* Transmit LSB first */
> +#define VIRTIO_SPI_MODE_LSB_FIRST              _BITUL(3)
> +/* Loopback mode */
> +#define VIRTIO_SPI_MODE_LOOP                   _BITUL(4)
> +
> +/**
> + * struct virtio_spi_config - All config fields are read-only for the
> + * Virtio SPI driver
> + * @cs_max_number: maximum number of chipselect the host SPI controller
> + *   supports.
> + * @cs_change_supported: indicates if the host SPI controller supports t=
o toggle
> + *   chipselect after each transfer in one message:
> + *   0: unsupported, chipselect will be kept in active state throughout =
the
> + *      message transaction;
> + *   1: supported.
> + *   Note: Message here contains a sequence of SPI transfers.
> + * @tx_nbits_supported: indicates the supported number of bit for writin=
g:
> + *   bit 0: DUAL (2-bit transfer), 1 for supported
> + *   bit 1: QUAD (4-bit transfer), 1 for supported
> + *   bit 2: OCTAL (8-bit transfer), 1 for supported
> + *   other bits are reserved as 0, 1-bit transfer is always supported.
> + * @rx_nbits_supported: indicates the supported number of bit for readin=
g:
> + *   bit 0: DUAL (2-bit transfer), 1 for supported
> + *   bit 1: QUAD (4-bit transfer), 1 for supported
> + *   bit 2: OCTAL (8-bit transfer), 1 for supported
> + *   other bits are reserved as 0, 1-bit transfer is always supported.
> + * @bits_per_word_mask: mask indicating which values of bits_per_word ar=
e
> + *   supported. If not set, no limitation for bits_per_word.
> + * @mode_func_supported: indicates the following features are supported =
or not:
> + *   bit 0-1: CPHA feature
> + *     0b00: invalid, should support as least one CPHA setting
> + *     0b01: supports CPHA=3D0 only
> + *     0b10: supports CPHA=3D1 only
> + *     0b11: supports CPHA=3D0 and CPHA=3D1.
> + *   bit 2-3: CPOL feature
> + *     0b00: invalid, should support as least one CPOL setting
> + *     0b01: supports CPOL=3D0 only
> + *     0b10: supports CPOL=3D1 only
> + *     0b11: supports CPOL=3D0 and CPOL=3D1.
> + *   bit 4: chipselect active high feature, 0 for unsupported and 1 for
> + *     supported, chipselect active low is supported by default.
> + *   bit 5: LSB first feature, 0 for unsupported and 1 for supported,
> + *     MSB first is supported by default.
> + *   bit 6: loopback mode feature, 0 for unsupported and 1 for supported=
,
> + *     normal mode is supported by default.
> + * @max_freq_hz: the maximum clock rate supported in Hz unit, 0 means no
> + *   limitation for transfer speed.
> + * @max_word_delay_ns: the maximum word delay supported, in nanoseconds.
> + *   A value of 0 indicates that word delay is unsupported.
> + *   Each transfer may consist of a sequence of words.
> + * @max_cs_setup_ns: the maximum delay supported after chipselect is ass=
erted,
> + *   in ns unit, 0 means delay is not supported to introduce after chips=
elect is
> + *   asserted.
> + * @max_cs_hold_ns: the maximum delay supported before chipselect is dea=
sserted,
> + *   in ns unit, 0 means delay is not supported to introduce before chip=
select
> + *   is deasserted.
> + * @max_cs_incative_ns: maximum delay supported after chipselect is deas=
serted,
> + *   in ns unit, 0 means delay is not supported to introduce after chips=
elect is
> + *   deasserted.
> + */
> +struct virtio_spi_config {
> +       uint8_t cs_max_number;
> +       uint8_t cs_change_supported;
> +#define VIRTIO_SPI_RX_TX_SUPPORT_DUAL          _BITUL(0)
> +#define VIRTIO_SPI_RX_TX_SUPPORT_QUAD          _BITUL(1)
> +#define VIRTIO_SPI_RX_TX_SUPPORT_OCTAL         _BITUL(2)
> +       uint8_t tx_nbits_supported;
> +       uint8_t rx_nbits_supported;
> +       uint32_t bits_per_word_mask;
> +#define VIRTIO_SPI_MF_SUPPORT_CPHA_0           _BITUL(0)
> +#define VIRTIO_SPI_MF_SUPPORT_CPHA_1           _BITUL(1)
> +#define VIRTIO_SPI_MF_SUPPORT_CPOL_0           _BITUL(2)
> +#define VIRTIO_SPI_MF_SUPPORT_CPOL_1           _BITUL(3)
> +#define VIRTIO_SPI_MF_SUPPORT_CS_HIGH          _BITUL(4)
> +#define VIRTIO_SPI_MF_SUPPORT_LSB_FIRST                _BITUL(5)
> +#define VIRTIO_SPI_MF_SUPPORT_LOOPBACK         _BITUL(6)
> +       uint32_t mode_func_supported;
> +       uint32_t max_freq_hz;
> +       uint32_t max_word_delay_ns;
> +       uint32_t max_cs_setup_ns;
> +       uint32_t max_cs_hold_ns;
> +       uint32_t max_cs_inactive_ns;
> +};
> +
> +/**
> + * struct spi_transfer_head - virtio SPI transfer descriptor
> + * @chip_select_id: chipselect index the SPI transfer used.
> + * @bits_per_word: the number of bits in each SPI transfer word.
> + * @cs_change: whether to deselect device after finishing this transfer
> + *     before starting the next transfer, 0 means cs keep asserted and
> + *     1 means cs deasserted then asserted again.
> + * @tx_nbits: bus width for write transfer.
> + *     0,1: bus width is 1, also known as SINGLE
> + *     2  : bus width is 2, also known as DUAL
> + *     4  : bus width is 4, also known as QUAD
> + *     8  : bus width is 8, also known as OCTAL
> + *     other values are invalid.
> + * @rx_nbits: bus width for read transfer.
> + *     0,1: bus width is 1, also known as SINGLE
> + *     2  : bus width is 2, also known as DUAL
> + *     4  : bus width is 4, also known as QUAD
> + *     8  : bus width is 8, also known as OCTAL
> + *     other values are invalid.
> + * @reserved: for future use.
> + * @mode: SPI transfer mode.
> + *     bit 0: CPHA, determines the timing (i.e. phase) of the data
> + *         bits relative to the clock pulses.For CPHA=3D0, the
> + *         "out" side changes the data on the trailing edge of the
> + *         preceding clock cycle, while the "in" side captures the data
> + *         on (or shortly after) the leading edge of the clock cycle.
> + *         For CPHA=3D1, the "out" side changes the data on the leading
> + *         edge of the current clock cycle, while the "in" side
> + *         captures the data on (or shortly after) the trailing edge of
> + *         the clock cycle.
> + *     bit 1: CPOL, determines the polarity of the clock. CPOL=3D0 is a
> + *         clock which idles at 0, and each cycle consists of a pulse
> + *         of 1. CPOL=3D1 is a clock which idles at 1, and each cycle
> + *         consists of a pulse of 0.
> + *     bit 2: CS_HIGH, if 1, chip select active high, else active low.
> + *     bit 3: LSB_FIRST, determines per-word bits-on-wire, if 0, MSB
> + *         first, else LSB first.
> + *     bit 4: LOOP, loopback mode.
> + * @freq: the transfer speed in Hz.
> + * @word_delay_ns: delay to be inserted between consecutive words of a
> + *     transfer, in ns unit.
> + * @cs_setup_ns: delay to be introduced after CS is asserted, in ns
> + *     unit.
> + * @cs_delay_hold_ns: delay to be introduced before CS is deasserted
> + *     for each transfer, in ns unit.
> + * @cs_change_delay_inactive_ns: delay to be introduced after CS is
> + *     deasserted and before next asserted, in ns unit.
> + */
> +struct spi_transfer_head {
> +       uint8_t chip_select_id;
> +       uint8_t bits_per_word;
> +       uint8_t cs_change;
> +       uint8_t tx_nbits;
> +       uint8_t rx_nbits;
> +       uint8_t reserved[3];
> +       uint32_t mode;
> +       uint32_t freq;
> +       uint32_t word_delay_ns;
> +       uint32_t cs_setup_ns;
> +       uint32_t cs_delay_hold_ns;
> +       uint32_t cs_change_delay_inactive_ns;
> +};
> +
> +/**
> + * struct spi_transfer_result - virtio SPI transfer result
> + * @result: Transfer result code.
> + *          VIRTIO_SPI_TRANS_OK: Transfer successful.
> + *          VIRTIO_SPI_PARAM_ERR: Parameter error.
> + *          VIRTIO_SPI_TRANS_ERR: Transfer error.
> + */
> +struct spi_transfer_result {
> +#define VIRTIO_SPI_TRANS_OK    0
> +#define VIRTIO_SPI_PARAM_ERR   1
> +#define VIRTIO_SPI_TRANS_ERR   2
> +       uint8_t result;
> +};
> +
> +#endif /* #ifndef _LINUX_VIRTIO_VIRTIO_SPI_H */
> --
> 2.34.1
>
>

