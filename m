Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410C8EA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniAq-0001zh-V2; Wed, 04 Feb 2026 14:04:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAn-0001wY-KG
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAk-00087R-FL
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HQNcwHET+Fc0wSADLVDsQMFcE8e91Voekz3r4JROCZw=;
 b=V6plI0R6upaK0bcHLLplYW6Z/OvPS0bjixxfdTohXn6HU2My+fjVgJ+2ySazbJmYSnfIjj
 K4DxmsZTsCm9KrfFEmk5JOwMS69lhuXiOhEAV8heXUdiuqCTRy0FPiqy5JwVn8MIDIevfH
 ff/bssACNEMHEkQZdi8XSTy0dmprs0o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-gDWdoMnOPxGHOOxVvl0MCg-1; Wed, 04 Feb 2026 14:04:16 -0500
X-MC-Unique: gDWdoMnOPxGHOOxVvl0MCg-1
X-Mimecast-MFC-AGG-ID: gDWdoMnOPxGHOOxVvl0MCg_1770231855
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-431054c09e3so204650f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231855; x=1770836655; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HQNcwHET+Fc0wSADLVDsQMFcE8e91Voekz3r4JROCZw=;
 b=appnDJDd27Ftfngqz3hmsvz9Lbj0VTuNKuGwMuWYGZ3zkbOQdy+76iI8KoCWh1QpSn
 nb6C2rXPKFALm56ZOuxlNTokSJ+RC93PggCItNXf3dwHxVSt/K6GYe2+A3wiZyNX+8F5
 i9XdOGQ/dgOBfeElbekH/KJKCpzhPOZCbe7uNnHaL7U4SSZekDUMuBoP38HZHWTHsQlJ
 SkISpNzhD69axSUbuENK+41LRsC/EVgTbOszSokEml+Qk1sub5iv/Nxq9vixKvq1wHVy
 F5jmAVuE3L6iISd5XWuxHbAa1qy7GjycHEr/fwfH8a5GQN/2FyZ5HeSC6imFsXr17GCd
 /Ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231855; x=1770836655;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HQNcwHET+Fc0wSADLVDsQMFcE8e91Voekz3r4JROCZw=;
 b=UNN7txCTh22oi7VrJP0kyiWzHxoh2ZY3nL9CSfIsPNXDkzaG1tGUqCsMtQ+oNf8Xkw
 rtxnK/VSxm8CDOTuhmCnXGCohVRqJ9JLo2p7X3XPpKPO4rX+nJOWkn/AX4vAVtLdsxPM
 YOFueYK1IiZx0kN7kPSquN/Q5vp1ksqb1SUGL1Gp90zjKU/DgS0JsZmPkUd3fAWlbERo
 CrdyKiII16q6Ihb5/EvOKbsBHHT14flxztA2r9xHM4HL+swMjCcuYvASl8Me4HsljYe3
 9VKWYj2xTzOZJspN9g7Rb6sJogRcRb2nvLpmILb1Uu5Oddu9vOXC2qgxkZtcynmD0wqK
 gJiw==
X-Gm-Message-State: AOJu0Yxd08slOlVqW+1jOjf44pywe1LCsy0j1m8ZPcC92HQulfXgBM+x
 E/qz/ZgsMvesOQ70Sj4m6WzOAEYfm4bZbUVpk2TV3/YQ1TG0IACJMuNhWyJ0AA7MkKhb919YxLU
 ixaKn7E2Ra0vospB0H+1sWKVBw2aE3qeRZ3THv6xLz+4/l+I9OMTylfBvd/jfU1p+3Z7H86lOmb
 +NKZ9/wf4Xm1dOl4Yn8FJG8AjzkiNf81HpXg==
X-Gm-Gg: AZuq6aKnzDqPsVK7xZR2YHt/X1dImS0a8fBTLngIx2k/tQOLpSMyiyJz9Xhvkp6t89w
 5Ht4+R09WWMxHxHoStjNzytlPTY8pxyuyAOUgNN5+87ZeXWGXAPPj54kZ+ytkexi9jbU+iWuJLP
 /NTZ6NlX7C+9j6NSyh7VUPWgzTULaRa1zaPNnYtsmEkCNDA62n2He90ATaOwTID66BreQ366t73
 kKtPtrXrS29IaCQrEs9VjnCGkCLRuBp3WIsfqu3/BHBSmaieajB496/ZqjEydAcXU5JZlR9AJ38
 DO9RuETi4ZuuSfPv1+kzRDzzrJM5LE2kFxzfNbXfLQcZDgEPXcIY5VF9HAYDmnA8lz6KrVmDALK
 kElIJc7zAuHPGSqSKhKLHKIKdOrGAVZlZAw==
X-Received: by 2002:a05:600c:4fcc:b0:480:1d0b:2d15 with SMTP id
 5b1f17b1804b1-4830e9926c0mr59612725e9.27.1770231854808; 
 Wed, 04 Feb 2026 11:04:14 -0800 (PST)
X-Received: by 2002:a05:600c:4fcc:b0:480:1d0b:2d15 with SMTP id
 5b1f17b1804b1-4830e9926c0mr59612415e9.27.1770231854198; 
 Wed, 04 Feb 2026 11:04:14 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d835f0sm3017765e9.14.2026.02.04.11.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:04:13 -0800 (PST)
Date: Wed, 4 Feb 2026 14:04:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Haixu Cui <quic_haixcui@quicinc.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 36/51] standard-headers: Update virtio_spi.h from Linux
 v6.18-rc3
Message-ID: <ef6fa0ac68f599fdd1c055f9c660ca5dcd1522d4.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Haixu Cui <quic_haixcui@quicinc.com>

Synced virtio_spi.h from upstream Linux kernelusing
scripts/update-linux-headers.sh.

Source:
- Linux commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa (v6.18-rc3)
- Author: Linus Torvalds <torvalds@linux-foundation.org>
- Date:   Sun Oct 26 15:59:49 2025 -0700

This update ensures QEMU's standard headers are consistent with the latest
virtio SPI definitions from Linux v6.18-rc3.

Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251216032122.1316684-2-quic_haixcui@quicinc.com>
---
 include/standard-headers/linux/virtio_spi.h | 181 ++++++++++++++++++++
 1 file changed, 181 insertions(+)
 create mode 100644 include/standard-headers/linux/virtio_spi.h

diff --git a/include/standard-headers/linux/virtio_spi.h b/include/standard-headers/linux/virtio_spi.h
new file mode 100644
index 0000000000..54e570fb4a
--- /dev/null
+++ b/include/standard-headers/linux/virtio_spi.h
@@ -0,0 +1,181 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Copyright (C) 2023 OpenSynergy GmbH
+ * Copyright (C) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#ifndef _LINUX_VIRTIO_VIRTIO_SPI_H
+#define _LINUX_VIRTIO_VIRTIO_SPI_H
+
+#include "standard-headers/linux/types.h"
+#include "standard-headers/linux/virtio_config.h"
+#include "standard-headers/linux/virtio_ids.h"
+#include "standard-headers/linux/virtio_types.h"
+
+/* Sample data on trailing clock edge */
+#define VIRTIO_SPI_CPHA			_BITUL(0)
+/* Clock is high when IDLE */
+#define VIRTIO_SPI_CPOL			_BITUL(1)
+/* Chip Select is active high */
+#define VIRTIO_SPI_CS_HIGH			_BITUL(2)
+/* Transmit LSB first */
+#define VIRTIO_SPI_MODE_LSB_FIRST		_BITUL(3)
+/* Loopback mode */
+#define VIRTIO_SPI_MODE_LOOP			_BITUL(4)
+
+/**
+ * struct virtio_spi_config - All config fields are read-only for the
+ * Virtio SPI driver
+ * @cs_max_number: maximum number of chipselect the host SPI controller
+ *   supports.
+ * @cs_change_supported: indicates if the host SPI controller supports to toggle
+ *   chipselect after each transfer in one message:
+ *   0: unsupported, chipselect will be kept in active state throughout the
+ *      message transaction;
+ *   1: supported.
+ *   Note: Message here contains a sequence of SPI transfers.
+ * @tx_nbits_supported: indicates the supported number of bit for writing:
+ *   bit 0: DUAL (2-bit transfer), 1 for supported
+ *   bit 1: QUAD (4-bit transfer), 1 for supported
+ *   bit 2: OCTAL (8-bit transfer), 1 for supported
+ *   other bits are reserved as 0, 1-bit transfer is always supported.
+ * @rx_nbits_supported: indicates the supported number of bit for reading:
+ *   bit 0: DUAL (2-bit transfer), 1 for supported
+ *   bit 1: QUAD (4-bit transfer), 1 for supported
+ *   bit 2: OCTAL (8-bit transfer), 1 for supported
+ *   other bits are reserved as 0, 1-bit transfer is always supported.
+ * @bits_per_word_mask: mask indicating which values of bits_per_word are
+ *   supported. If not set, no limitation for bits_per_word.
+ * @mode_func_supported: indicates the following features are supported or not:
+ *   bit 0-1: CPHA feature
+ *     0b00: invalid, should support as least one CPHA setting
+ *     0b01: supports CPHA=0 only
+ *     0b10: supports CPHA=1 only
+ *     0b11: supports CPHA=0 and CPHA=1.
+ *   bit 2-3: CPOL feature
+ *     0b00: invalid, should support as least one CPOL setting
+ *     0b01: supports CPOL=0 only
+ *     0b10: supports CPOL=1 only
+ *     0b11: supports CPOL=0 and CPOL=1.
+ *   bit 4: chipselect active high feature, 0 for unsupported and 1 for
+ *     supported, chipselect active low is supported by default.
+ *   bit 5: LSB first feature, 0 for unsupported and 1 for supported,
+ *     MSB first is supported by default.
+ *   bit 6: loopback mode feature, 0 for unsupported and 1 for supported,
+ *     normal mode is supported by default.
+ * @max_freq_hz: the maximum clock rate supported in Hz unit, 0 means no
+ *   limitation for transfer speed.
+ * @max_word_delay_ns: the maximum word delay supported, in nanoseconds.
+ *   A value of 0 indicates that word delay is unsupported.
+ *   Each transfer may consist of a sequence of words.
+ * @max_cs_setup_ns: the maximum delay supported after chipselect is asserted,
+ *   in ns unit, 0 means delay is not supported to introduce after chipselect is
+ *   asserted.
+ * @max_cs_hold_ns: the maximum delay supported before chipselect is deasserted,
+ *   in ns unit, 0 means delay is not supported to introduce before chipselect
+ *   is deasserted.
+ * @max_cs_incative_ns: maximum delay supported after chipselect is deasserted,
+ *   in ns unit, 0 means delay is not supported to introduce after chipselect is
+ *   deasserted.
+ */
+struct virtio_spi_config {
+	uint8_t cs_max_number;
+	uint8_t cs_change_supported;
+#define VIRTIO_SPI_RX_TX_SUPPORT_DUAL		_BITUL(0)
+#define VIRTIO_SPI_RX_TX_SUPPORT_QUAD		_BITUL(1)
+#define VIRTIO_SPI_RX_TX_SUPPORT_OCTAL		_BITUL(2)
+	uint8_t tx_nbits_supported;
+	uint8_t rx_nbits_supported;
+	uint32_t bits_per_word_mask;
+#define VIRTIO_SPI_MF_SUPPORT_CPHA_0		_BITUL(0)
+#define VIRTIO_SPI_MF_SUPPORT_CPHA_1		_BITUL(1)
+#define VIRTIO_SPI_MF_SUPPORT_CPOL_0		_BITUL(2)
+#define VIRTIO_SPI_MF_SUPPORT_CPOL_1		_BITUL(3)
+#define VIRTIO_SPI_MF_SUPPORT_CS_HIGH		_BITUL(4)
+#define VIRTIO_SPI_MF_SUPPORT_LSB_FIRST		_BITUL(5)
+#define VIRTIO_SPI_MF_SUPPORT_LOOPBACK		_BITUL(6)
+	uint32_t mode_func_supported;
+	uint32_t max_freq_hz;
+	uint32_t max_word_delay_ns;
+	uint32_t max_cs_setup_ns;
+	uint32_t max_cs_hold_ns;
+	uint32_t max_cs_inactive_ns;
+};
+
+/**
+ * struct spi_transfer_head - virtio SPI transfer descriptor
+ * @chip_select_id: chipselect index the SPI transfer used.
+ * @bits_per_word: the number of bits in each SPI transfer word.
+ * @cs_change: whether to deselect device after finishing this transfer
+ *     before starting the next transfer, 0 means cs keep asserted and
+ *     1 means cs deasserted then asserted again.
+ * @tx_nbits: bus width for write transfer.
+ *     0,1: bus width is 1, also known as SINGLE
+ *     2  : bus width is 2, also known as DUAL
+ *     4  : bus width is 4, also known as QUAD
+ *     8  : bus width is 8, also known as OCTAL
+ *     other values are invalid.
+ * @rx_nbits: bus width for read transfer.
+ *     0,1: bus width is 1, also known as SINGLE
+ *     2  : bus width is 2, also known as DUAL
+ *     4  : bus width is 4, also known as QUAD
+ *     8  : bus width is 8, also known as OCTAL
+ *     other values are invalid.
+ * @reserved: for future use.
+ * @mode: SPI transfer mode.
+ *     bit 0: CPHA, determines the timing (i.e. phase) of the data
+ *         bits relative to the clock pulses.For CPHA=0, the
+ *         "out" side changes the data on the trailing edge of the
+ *         preceding clock cycle, while the "in" side captures the data
+ *         on (or shortly after) the leading edge of the clock cycle.
+ *         For CPHA=1, the "out" side changes the data on the leading
+ *         edge of the current clock cycle, while the "in" side
+ *         captures the data on (or shortly after) the trailing edge of
+ *         the clock cycle.
+ *     bit 1: CPOL, determines the polarity of the clock. CPOL=0 is a
+ *         clock which idles at 0, and each cycle consists of a pulse
+ *         of 1. CPOL=1 is a clock which idles at 1, and each cycle
+ *         consists of a pulse of 0.
+ *     bit 2: CS_HIGH, if 1, chip select active high, else active low.
+ *     bit 3: LSB_FIRST, determines per-word bits-on-wire, if 0, MSB
+ *         first, else LSB first.
+ *     bit 4: LOOP, loopback mode.
+ * @freq: the transfer speed in Hz.
+ * @word_delay_ns: delay to be inserted between consecutive words of a
+ *     transfer, in ns unit.
+ * @cs_setup_ns: delay to be introduced after CS is asserted, in ns
+ *     unit.
+ * @cs_delay_hold_ns: delay to be introduced before CS is deasserted
+ *     for each transfer, in ns unit.
+ * @cs_change_delay_inactive_ns: delay to be introduced after CS is
+ *     deasserted and before next asserted, in ns unit.
+ */
+struct spi_transfer_head {
+	uint8_t chip_select_id;
+	uint8_t bits_per_word;
+	uint8_t cs_change;
+	uint8_t tx_nbits;
+	uint8_t rx_nbits;
+	uint8_t reserved[3];
+	uint32_t mode;
+	uint32_t freq;
+	uint32_t word_delay_ns;
+	uint32_t cs_setup_ns;
+	uint32_t cs_delay_hold_ns;
+	uint32_t cs_change_delay_inactive_ns;
+};
+
+/**
+ * struct spi_transfer_result - virtio SPI transfer result
+ * @result: Transfer result code.
+ *          VIRTIO_SPI_TRANS_OK: Transfer successful.
+ *          VIRTIO_SPI_PARAM_ERR: Parameter error.
+ *          VIRTIO_SPI_TRANS_ERR: Transfer error.
+ */
+struct spi_transfer_result {
+#define VIRTIO_SPI_TRANS_OK	0
+#define VIRTIO_SPI_PARAM_ERR	1
+#define VIRTIO_SPI_TRANS_ERR	2
+	uint8_t result;
+};
+
+#endif /* #ifndef _LINUX_VIRTIO_VIRTIO_SPI_H */
-- 
MST


