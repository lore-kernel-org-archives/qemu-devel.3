Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA51C36010
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 11:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzDBf-0003tI-OL; Mon, 31 Mar 2025 07:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzDBd-0003su-Es
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 07:20:13 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzDBb-0005Pt-MP
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 07:20:13 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39ac8e7688aso3479132f8f.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 04:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743420009; x=1744024809; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FMVHqsTPretwWz7FUkx1jwwFQduMUsmy4P/isUnCU/c=;
 b=xVEcvzke8PRAoW4JtX67Far7ieY82+u/iGAJ2PgBv2qp1lNcgbUVWIMSnYh1If85Wc
 n5lUJTkFaPtRBAXZDlQ2kQIn6TmIweAe230MwmQ7jD1RWxMPf+oHoXBonnM7CYwijl91
 eeurKigVH6DTsYlgTpnYnuvja/5h6xGCuGIjAdR815iaj0yTmvNjPxcAzwrXcQB0ZAcd
 yviaYcKn2LyCsApq+pg3NoEHc37c8vU+4fOT1Ak2DtGwVmZvM6X3iWgXXYizaJ5FsEJD
 ZHSv3M0AbojKYPl2v2xvAxFkCRm7CO0FAOyXGYGI4GDsGbumoyx4qvcLFOErQ+QoxvLa
 K5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743420009; x=1744024809;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FMVHqsTPretwWz7FUkx1jwwFQduMUsmy4P/isUnCU/c=;
 b=nKkhlAGYOHJ2Lm7wq6zxSmk/vMlDQeKu73ltx8crZTJPVNwR+ZeFMbc9aqjsagadIY
 1JXQRi1Tz0Jdb2vtu/PPXLkJ+G9X50LlELTGZH9+teqG7LbF0h0/Ce/KphwG9pBl5GaP
 ee4AB33idZ1080IzenK+IuadjJlG19G1NY1adBFxXiXPQomF5xoZBeAtxv/T7LHpRItt
 rUDFORng2bUclElePO1YI78YwOFgIO/yen4kUtX0J8pjAPdF81f/NvRfaa5mOnPqdM9s
 Ogha04grL+ws2G9xR6n+taX/Pir/WTrtYKFBWMiYLijN7wIAKcRS4PRQnFK02gj8K1wS
 G3yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkyQCgDj4CQHg81O5IFJxwgI11QsNKSpkxmfEXtqvIFJnccY2w/kq0TI4UV51ovQdiiMIvZkjFt1pL@nongnu.org
X-Gm-Message-State: AOJu0YyzHzMhT1z6kzUJmUHjdk3ee5dJg6voY78gMMTIdlKCVBHBGl0S
 tqQnYfZ3ywNsXe37xXhLEQIjr16zNSSySbeycO+wa3b2ZnKr+D9Pt1RgxiMaHzM=
X-Gm-Gg: ASbGncstZjQM47W9iKZXs9/jmByNhqhkrSPIFMtP0SkUcNBKF0bCZeDDXrxy5u95B5H
 NadpX1ofWO4X7+gnNIlC6ohpOYD3Ybt1dwB7PatNRLYvSx+nDRsxSeakRh/g++SJa76Z9gvhwRH
 i2oYpeMtFQXLv/dvZLxJ1hcy/A5/huwSNfcNAeq4x96yZzLqBPItHA+DRyqq6iwcN6WzT81wQf3
 dxZmjmqeHRepL4ntWNrv+4pzpfh5NAfKp+MPVvoqsldcKiZzlVUaRHcJ+urwJJLR+ThpK6FRJ0C
 oLdeVJj4Yy6KkVyT3MewTulqfVga6K854RbCO5maXaXucvSHrn2pG9jQMhDylCMGhnKZtZ0qw05
 DPV+a0ORs9vF2
X-Google-Smtp-Source: AGHT+IEkYKxq9DzwMd8BIQKTr74mGlBqQB+2xlMQkBMavHzehd5zuUXoZqyV/kbUBkRnZJcO6NNLFQ==
X-Received: by 2002:a5d:59a5:0:b0:391:4743:6dc2 with SMTP id
 ffacd0b85a97d-39c120e3bd7mr6316117f8f.25.1743420008844; 
 Mon, 31 Mar 2025 04:20:08 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b662736sm10812996f8f.22.2025.03.31.04.20.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 04:20:08 -0700 (PDT)
Message-ID: <7c4beda4-7f0f-46fa-98bc-52d6abe21ab4@linaro.org>
Date: Mon, 31 Mar 2025 13:20:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char/bcm2835_aux: Fix incorrect interrupt ID when RX
 disabled
To: Chung-Yi Chen <yeechen0207@gmail.com>, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org
References: <20250328123725.94176-1-yeechen0207@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250328123725.94176-1-yeechen0207@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 28/3/25 13:37, Chung-Yi Chen wrote:
> This patch fixes a misconfiguration issue in the read implementation of
> the AUX_MU_IIR_REG register. This issue can lead to a transmit interrupt
> being incorrectly interpreted as a receive interrupt when the receive
> interrupt is disabled and the receive FIFO holds valid bytes.
> 
> The AUX_MU_IIR_REG register (interrupt ID bits [2:1]) indicates the
> status of mini UART interrupts:
> 
>      - 00: No interrupts
>      - 01: Transmit FIFO is empty
>      - 10: Receive FIFO is not empty
>      - 11: <Not possible>
> 
> When the transmit interrupt is enabled and the receive interrupt is
> disabled, the original code incorrectly sets the interrupt ID bits.
> Specifically:
> 
>      1. Transmit FIFO empty, receive FIFO empty
>          - Expected 0b01, returned 0b01 (correct)
>      2. Transmit FIFO empty, receive FIFO not empty
>          - Expected 0b01, returned 0b10 (incorrect)
> 
> In the second case, the code sets the interrupt ID to 0b10 (receive FIFO
> is not empty) even if the receive interrupt is disabled.
> 
> To fix this, the patch adds additional condition for setting the
> interrupt ID bits to also check if the receive interrupt is enabled.
> 
> Reference: BCM2835 ARM Peripherals, page 13. Available on
> https://datasheets.raspberrypi.com/bcm2835/bcm2835-peripherals.pdf
> 
> Signed-off-by: Chung-Yi Chen <yeechen0207@gmail.com>
> ---
>   hw/char/bcm2835_aux.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Queued to hw-misc, thanks!


