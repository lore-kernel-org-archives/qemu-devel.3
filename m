Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B86AC021B2
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 18:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmGJC-0000E6-On; Sun, 23 Feb 2025 13:02:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmGJ8-0000D5-A8
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 13:02:28 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmGJ6-0002Mw-Ab
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 13:02:25 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2212a930001so101059575ad.0
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 10:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740333742; x=1740938542; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PKE+pmRpCSm89qLjgRCToQjKTTzWlqN7l5sbX86gXPY=;
 b=d6/xQqeKFkNBMwJdIZcGTmCYdHGOBEc0DGL2Ejg98SRYCio45M8e9ZT2usL4DKv/l7
 IBDoJRfWn7zbfhEDby7BtbLgJ16EX6aZsmO3UOChgTCjc7gdX0NMexznfoe/5Lj9e98W
 A/UTbTsjB5tdMyUJcDONM/zNYATY6nfYGJ1qjQD16cJKPDtlotwpYKFq4TApoE9s23jt
 zWUsUhJIKwX1I+OP1Po+a/Hy1L2hzFqWzEhhLJc/Ly+mFef54XC2ONd0K+zcfHgOZrqF
 LnrDaF7N6pXk2XZ/bTbSVIJ54duSdCXYoFDy+oROvts9cRI/eqbWMHMVC0Vtpi/zDkWE
 6p5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740333742; x=1740938542;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PKE+pmRpCSm89qLjgRCToQjKTTzWlqN7l5sbX86gXPY=;
 b=ovMCyxUicKcGyldFmhuFY2gbVkVcNFG77a/ZlwO1Coze/HaBtxBEWPbKlxq7vkwT/G
 bSXuKTt0J1NuMqQ6wo5lldY+jdU08SlXawqwL7Ua2A8vBahWvNvWGu/WAWJ02Nk/yEbR
 VaasdOi8F/IR39GBsoOzMYhEALL67Vnbc4fpQ6IHFPOyYYubrZPY9FLF/SWkcs7ZSITb
 0FjI86r/eqaW42tBWGZBUvw+Zho3zHPg4bZdFIp7ycujfu7L7k96n3RLBQgaG2F+Ha64
 3gbbaM5zI5MWa+eeFuANcQxP8IYnGv2Bsc9wYafdOhY+pQT2glowriqCQgZkG6t7QGJW
 Rokg==
X-Gm-Message-State: AOJu0YyY024Ivy7px3K0t26u1mrpiL8QsdPVv6W33s5sCOm7VRKVvtcK
 RoRNFW5xUgPTtXZfHB34hRgMCQIwhajM78LPqrGQYIlixIxrxaPJGBEZbCfMQbEYk+eYtHV9d2p
 O
X-Gm-Gg: ASbGnctraAFPck119ntDrlPjXmf/2zEDNq2yzuZriVDn3CKs0BkGoD2G7IgAUrkliLK
 +DWAuBCe2Dl+W6cFXLYYFEa+ayUzEMjrXwj9IC86aSAdACMkYLv6A7+7M+KACysfQUQRXVXZlp0
 wxDHsxlgunkAVfaT8Q4KcN42QLBY8aFhV0HBHGyknbtVjYKTVS0NiUfvKcSJf+vA3rYTKB3pr4J
 4U6Qk8K+Fw3i4z4eLFMjPdxZPOuS9+ZX4iq/G+8VdWsRIL/KpGn1xV+CqQ+sYROmh1ICbKskYu6
 qktX2n23ZetRtB06hrT1LK5nSv1UcCPNvz3gwvVMVLmuOgmtuIGiethCkNO6/cBUOsplGSFv7J1
 k9ze5/Is=
X-Google-Smtp-Source: AGHT+IFsm/jljmhltXhcoc5Pk5r7QR17hJO0nb5ynfjwU/QZdJroQvkHr7ZM9FWUqxWcF3AqImhmsQ==
X-Received: by 2002:a17:903:2f92:b0:215:a964:e680 with SMTP id
 d9443c01a7336-221a10de4a8mr149954875ad.25.1740333742399; 
 Sun, 23 Feb 2025 10:02:22 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d556dad1sm166626105ad.185.2025.02.23.10.02.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Feb 2025 10:02:21 -0800 (PST)
Message-ID: <07e97547-5682-482f-ab5d-b6793ec94387@linaro.org>
Date: Sun, 23 Feb 2025 10:02:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] hw/char/pl011: Really use RX FIFO depth
To: qemu-devel@nongnu.org
References: <20250220092903.3726-1-philmd@linaro.org>
 <20250220092903.3726-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250220092903.3726-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 2/20/25 01:28, Philippe Mathieu-Daudé wrote:
> While we model a 16-elements RX FIFO since the PL011 model was
> introduced in commit cdbdb648b7c ("ARM Versatile Platform Baseboard
> emulation"), we only read 1 char at a time!
> 
> Have the IOCanReadHandler handler return how many elements are
> available, and use that in the IOReadHandler handler.
> 
> Example of FIFO better used by enabling the pl011 tracing events
> and running the tests/functional/test_aarch64_virt.py tests:
> 
>    pl011_can_receive LCR 0x70, RX FIFO used 0/16, can_receive 16 chars
>    pl011_receive recv 5 chars
>    pl011_fifo_rx_put RX FIFO push char [0x72] 1/16 depth used
>    pl011_irq_state irq state 1
>    pl011_fifo_rx_put RX FIFO push char [0x6f] 2/16 depth used
>    pl011_fifo_rx_put RX FIFO push char [0x6f] 3/16 depth used
>    pl011_fifo_rx_put RX FIFO push char [0x74] 4/16 depth used
>    pl011_fifo_rx_put RX FIFO push char [0x0d] 5/16 depth used
>    pl011_can_receive LCR 0x70, RX FIFO used 5/16, can_receive 11 chars
>    pl011_can_receive LCR 0x70, RX FIFO used 5/16, can_receive 11 chars
>    pl011_write addr 0x038 value 0x00000050 reg IMSC
>    pl011_irq_state irq state 1
>    pl011_can_receive LCR 0x70, RX FIFO used 5/16, can_receive 11 chars
>    pl011_read addr 0x03c value 0x00000030 reg RIS
>    pl011_write addr 0x044 value 0x00000000 reg ICR
>    pl011_irq_state irq state 1
>    pl011_read addr 0x018 value 0x00000080 reg FR
>    pl011_read_fifo RX FIFO read, used 4/16
>    pl011_irq_state irq state 1
>    pl011_read addr 0x000 value 0x00000072 reg DR
>    pl011_can_receive LCR 0x70, RX FIFO used 4/16, can_receive 12 chars
>    pl011_read addr 0x018 value 0x00000080 reg FR
>    pl011_read_fifo RX FIFO read, used 3/16
>    pl011_irq_state irq state 1
>    pl011_read addr 0x000 value 0x0000006f reg DR
>    pl011_can_receive LCR 0x70, RX FIFO used 3/16, can_receive 13 chars
>    pl011_read addr 0x018 value 0x00000080 reg FR
>    pl011_read_fifo RX FIFO read, used 2/16
>    pl011_irq_state irq state 1
>    pl011_read addr 0x000 value 0x0000006f reg DR
>    pl011_can_receive LCR 0x70, RX FIFO used 2/16, can_receive 14 chars
>    pl011_read addr 0x018 value 0x00000080 reg FR
>    pl011_read_fifo RX FIFO read, used 1/16
>    pl011_irq_state irq state 1
>    pl011_read addr 0x000 value 0x00000074 reg DR
>    pl011_can_receive LCR 0x70, RX FIFO used 1/16, can_receive 15 chars
>    pl011_read addr 0x018 value 0x00000080 reg FR
>    pl011_read_fifo RX FIFO read, used 0/16
>    pl011_irq_state irq state 0
>    pl011_read addr 0x000 value 0x0000000d reg DR
>    pl011_can_receive LCR 0x70, RX FIFO used 0/16, can_receive 16 chars
>    pl011_read addr 0x018 value 0x00000090 reg FR
>    pl011_read addr 0x03c value 0x00000020 reg RIS
>    pl011_write addr 0x038 value 0x00000050 reg IMSC
>    pl011_irq_state irq state 0
>    pl011_can_receive LCR 0x70, RX FIFO used 0/16, can_receive 16 chars
>    pl011_can_receive LCR 0x70, RX FIFO used 0/16, can_receive 16 chars
>    pl011_read addr 0x018 value 0x00000090 reg FR
>    pl011_write addr 0x000 value 0x00000072 reg DR
> 
> Inspired-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Luc Michel <luc.michel@amd.com>
> ---
>   hw/char/pl011.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index f7485e7c541..23a9db8c57c 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -489,7 +489,6 @@ static int pl011_can_receive(void *opaque)
>       PL011State *s = (PL011State *)opaque;
>       unsigned fifo_depth = pl011_get_fifo_depth(s);
>       unsigned fifo_available = fifo_depth - s->read_count;
> -    int r = fifo_available ? 1 : 0;
>   
>       if (!(s->cr & CR_UARTEN)) {
>           qemu_log_mask(LOG_GUEST_ERROR,
> @@ -500,7 +499,8 @@ static int pl011_can_receive(void *opaque)
>                         "PL011 receiving data on disabled RX UART\n");
>       }
>       trace_pl011_can_receive(s->lcr, s->read_count, fifo_depth, fifo_available);
> -    return r;
> +
> +    return fifo_available;
>   }

Ah, I get it; my bool comment was ill-informed.


>   static void pl011_receive(void *opaque, const uint8_t *buf, int size)
> @@ -515,7 +515,9 @@ static void pl011_receive(void *opaque, const uint8_t *buf, int size)
>           return;
>       }
>   
> -    pl011_fifo_rx_put(opaque, *buf);
> +    for (int i = 0; i < size; i++) {
> +        pl011_fifo_rx_put(opaque, buf[i]);
> +    }
>   }

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

