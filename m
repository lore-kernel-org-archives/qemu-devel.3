Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3538CCFA03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 11:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGxlC-0007gA-SB; Thu, 06 Nov 2025 06:02:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGxl4-0007fA-BW
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 06:02:30 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGxl1-0003yS-Lh
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 06:02:26 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-7866e9e62e1so8049777b3.2
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 03:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762426941; x=1763031741; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=53c3RoZT9XRhHiOUA88/exc9m6q0Ch4NtH4tYxUC5UA=;
 b=c1J02ya4p+JlpMGdC8ZC3575wQdrrpiHEp6N+oiVVdptFKljYusrHHrln880B1G7Gy
 56GUZRC/9NKF3HpU8hKRlpdz6ICe77XiGgspabmTBNH9KjaTKtv/ItWLSFXIdNKb7Ovb
 gvA3m8spKmrOMGUzWbiMqdXJn+sXyrrb+m88Yy42MSaChLpSljDA4RJttTvwg+W2ac87
 LwFxy4PcATMLuOY6DidPMIYlCTi/+CyOp4wvV5+XGVU+uds93g+rA3hhcX4UmoYKTaZi
 ca/QdWvDgU2croFH91mGJfpg8u3HaMDHrxIn1mGfYhf5Hh0fej6pkKZYb4KrwDDWoaBG
 wDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762426942; x=1763031742;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=53c3RoZT9XRhHiOUA88/exc9m6q0Ch4NtH4tYxUC5UA=;
 b=Wn3Bcj+C34++r+tt6ISoBL40u2vUxUSM7plYNXkr+e6LTnHpST2HUXIelqggGcMzgg
 e/7lylECHRmVnMbFx5NUGN7agjSrxds2gks3HcFJ8+kbH1ThP2g+3Dp+ieY40XUmVgCl
 PXrgaQBpdu6QlURffJxtrCci4yo60z5Z3CZoPrfdrmU/CGjJqrX77g4xLmZ/DoMY2bFg
 f7to7U7yQv2DdydCouLIN+uTk6Y0l1wkXh8WYTrEwMGHIZ221Pnxg/APNcLjniaYVYi0
 ZvKxduePT394sFOZKwC1o/7TC/Wapmo8UsfTnKjaDyUSB4zIy9YmYIACIoD4lt1VRK+l
 +pGQ==
X-Gm-Message-State: AOJu0Yz9Ea/vXepeVhkgrVvrZgRLpsO5fVOgBfqqHrdKb2P72oZRIGbA
 56FsUJJsFOpG/5Rr3+oqTZLjehgji1nP9ywROYp+ZynHEC62rYaUOSJ854nXfTbzoWZJSNcVUs9
 BGd80sCb4NOp5rN/oC89T58JytAN/d36VFyYKlmHyww==
X-Gm-Gg: ASbGncsjtZc8NekqEfGhgmiKHb52a4sr1I2PWNM+jeuspaBMjD707jg+xbq5tlAnqYv
 jJ/p6+56/ewp2IwXWe7dIpqwCmXRofZwC06PfICH6zWL8QfpKLT/9Z6Jzo1uIVHLgpDB5ai5nmH
 Ci0r/PPBzRDDQ/1ayuGKVw3uEbiA/l6v8zJKyFh7e/PWGXD3FsoGeOPw7KEDpCgupIS9vKBwcNm
 zkBMWca9le/+b9Ne3A1o9L80UwuPsZElcCLCBLXxGiykYXj8GgcAvfvx6YKEg==
X-Google-Smtp-Source: AGHT+IFXLgzA694K0jcUKnxQdw2X8GayHjotqUMrV8AxlEXUOHr+5fKWAq+c8+ruZJHrywBpx5CVV3ocfLud3ilHGlE=
X-Received: by 2002:a05:690e:4282:20b0:63f:abbe:3964 with SMTP id
 956f58d0204a3-63fd34a876emr5139403d50.13.1762426941650; Thu, 06 Nov 2025
 03:02:21 -0800 (PST)
MIME-Version: 1.0
References: <20251104152204.6261-1-deller@kernel.org>
 <20251104152204.6261-4-deller@kernel.org>
In-Reply-To: <20251104152204.6261-4-deller@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Nov 2025 11:02:09 +0000
X-Gm-Features: AWmQ_bkQJ9SO78clO8WtjhDJnYK7uDf-WNvv2nyWF9sA4fHk43TnQVCL5s3HqwU
Message-ID: <CAFEAcA889hm1xyRBQFVzfvrz4OQfKZZAaZEciQe+r5wB4CuRhQ@mail.gmail.com>
Subject: Re: [PULL v2 3/3] i82596: Implement enhanced TX/RX with packet
 queuing and filtering
To: deller@kernel.org
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Jason Wang <jasowang@redhat.com>, 
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Tue, 4 Nov 2025 at 15:22, <deller@kernel.org> wrote:
>
> From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
>
> In this patch I have added the following:
> - Rewrote transmit path with CSMA/CD collision handling and retry logic
> - Implemented flexible TX buffer descriptor (TBD) chain processing
> - Rewrote receive path with packet filtering and monitor mode support
> - Added RX packet queue for handling resource exhaustion
> - Implemented queue flush timer and management
> - Added RX state machine with proper state transitions
> - Implemented packet filtering (unicast, broadcast, multicast, promiscuous)
> - Added SCB RU_START enhancement to find usable RFDs
> - Implemented dump command support
> - Added bus throttle timer loading (LOAD_THROTTLE/LOAD_START commands)
> - Enhanced signal_ca with proper initialization sequence
> - Finally, adding self-test functionality
>
> Note:
> With this patch, and the previous ones in the patch series, we are able
> to achive proper 82596 NIC emulation.

Hi; Coverity spotted an issue in this code (CID 1642868):

> +static ssize_t i82596_receive_packet(I82596State *s, const uint8_t *buf,
> +                                      size_t size, bool from_queue)
> +{
> +    struct i82596_rx_descriptor rfd;
> +    uint32_t rfd_addr, rbd_addr;
> +    uint16_t rx_status = 0;
> +    uint16_t is_broadcast = 0;
> +    bool packet_completed = true;
> +    bool simplified_mode = false;
> +    size_t frame_size = size;
> +    size_t payload_size = 0;
> +    size_t bytes_copied = 0;
> +    const uint8_t *packet_data = buf;
> +    bool crc_valid = true;

Here we set crc_valid to true...

> +    bool out_of_resources = false;
> +    size_t crc_size = i82596_get_crc_size(s);
> +
> +    trace_i82596_receive_packet(buf, size);

[snipped]

> +rx_complete:
> +    if (I596_CRCINM && !I596_LOOPBACK && packet_completed) {
> +        uint8_t crc_data[4];
> +        size_t crc_len = crc_size;
> +
> +        if (I596_CRC16_32) {
> +            uint32_t crc = crc32(~0, packet_data, frame_size);
> +            crc = cpu_to_be32(crc);
> +            memcpy(crc_data, &crc, 4);
> +        } else {
> +            uint16_t crc = i82596_calculate_crc16(packet_data, frame_size);
> +            crc = cpu_to_be16(crc);
> +            memcpy(crc_data, &crc, 2);
>          }
>
> -        if (s->cu_status != CU_ACTIVE) {
> -            break;
> +        if (simplified_mode) {
> +            address_space_write(&address_space_memory,
> +                                rfd_addr + 0x1E + bytes_copied,
> +                                MEMTXATTRS_UNSPECIFIED, crc_data, crc_len);
> +        }
> +    }

...but nowhere in any of this code do we ever set crc_valid to
anything else...

> +
> +    if (packet_completed && crc_valid) {

...so this condition is the same as "if (packet_completed)"...

> +        rx_status |= STAT_C | STAT_OK;
> +        if (is_broadcast) {
> +            rx_status |= 0x0001;
> +        }
> +    } else if (packet_completed) {

...and the code in this block is unreachable.


> +        rx_status |= STAT_C;
> +        if (!crc_valid) {
> +            rx_status |= RX_CRC_ERRORS;
> +        }
> +    } else {
> +        rx_status |= STAT_B;
> +    }
> +

What was the intention here?

thanks
-- PMM

