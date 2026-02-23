Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC609EEC28E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 21:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vudsR-0004NQ-K9; Mon, 23 Feb 2026 16:54:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vudsP-0004NH-1D
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 16:54:01 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vudsN-0001BR-Ge
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 16:54:00 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-824a829f9bbso2527302b3a.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 13:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771883637; x=1772488437; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kTLOtO/RHLtE37NU+BLXdtADh+ZKDhQz9ZS6H6Y2nEM=;
 b=GkQ+XcW8kWqcOs5eJtovvpewpPyh6LFt6/FWtVnS8TOoOR87Zdp40WbdRt+yL/zeWt
 JN/vaeZjUolEpsqGT1rbBvH0tsfmSJ/BlX8po+7S16AJQ6HX9vYFnWEzsImegOLZHrqy
 21MCnzNs3yTtNmfmBKN2ggM1KFPnkr/S1H57+0Aatlvas+CSok5fja5++uPzDQRvJJzo
 +e0Q4N1tyEKMbdbTlK/W1vf+Cb0cGgI681nwb+eRQvLLoGba+uUdemP1mFcS/qVbOmQF
 /0IuwYNYHLNxmazoFhhAw5u5pVVaRi8Yviw+w6y3mu9p8bY5oE9IVvEB5EfYY2wzMK5+
 hxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771883637; x=1772488437;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kTLOtO/RHLtE37NU+BLXdtADh+ZKDhQz9ZS6H6Y2nEM=;
 b=C6vmnK7HW0paM0UcbvS5JfS6w/Iy7LPl1z3l6W/w9pisZG4MXP24IWrv+yeMCXL/Pr
 LoOaxGelJL4xYjYI1xJ5LPjNel0tG4G/eZWhTDbxgmejeQxHIlt3IqIM4BpsSXhnyLAW
 2lH1v3Mw9641bJckijIssQmV9sNQ/fhHzL84jT2tsOCku32D4WJJxudLSIbDGIHLG0iz
 rS91QOD/puV5GHG4kvxmD8Ab4TH4EfppZU/xy40V0Ttugd/7DB5rYKSJOvTT4i9pUbjg
 QqFd91aje+SUSbKNBypFx6weUoY43vdF0kpevg8uUoFRNj/clANYoOOl2idBCdG1WFja
 mQGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYXTVyj4aLF/KYnUtssRptE4VkETXiijdrMZI2Mm/Luofdzj2YLRX5suJG1UN06SLYF4rWRUmXB80v@nongnu.org
X-Gm-Message-State: AOJu0YxTpXIPMARUu1l9hoC6yVeSyaYewHKEsOYw80fSRAaQreGegpkK
 u9OMfKrQ7ivUEeZFJaGcoCbu4N5uPny0VXRfHKhKuRG+Jqxh+G/HeP1x5SB3GrfJFH/4INp3+Nu
 h6Ez+zoM=
X-Gm-Gg: AZuq6aKiPI4MCV/7WQSUT3pTsdfg/WGVxPDlxBL6TsEvYdJT6JK5nC8cwtyqGIUkFd6
 zzFbX2yaf5YFPXH8/Dlm8AhxEdkRjoNqhMfXi8Si9evazqdu4LLAq+oiOuG4zI9ZhKH/KvAPJZ6
 zyvO8G5eod+bXYm0Ac/40GWRFXMxF1h1s5Q1uKKcyumckIJyYABtscjs2zGXluHVG6QoWwEWERT
 wC6E5SX11T6FhUTP/QNqetV1qcwkfhong24hB8W+/pBN95XtW9N3gvZBtiZgR2yP7rPr7VuMmXp
 F0ZoYc6z0Zw5vTXcVmNd4Tun4+yxMX1TgGaTpN/ZTjc/ZKbAdqnlv2HeQiis9AJPZAnSlY5UY/z
 gkKwTgtROedw0GifaZQaYmvy99EnggOfjrqTjtQJ+PiwZ4hwnVN6fvIrJj3RkyTRGDsykTZz8MN
 3A7YQXhvGFtWdgZzVEN+x0puoVlqP9TCIRv7yQWEa5Mmjv0rn0MGYu2NhOyP0B3VrZOl4IuBBz/
 mzb
X-Received: by 2002:a05:6a00:3999:b0:81f:9a5b:e8fc with SMTP id
 d2e1a72fcca58-826daa6eec8mr9040814b3a.54.1771883637290; 
 Mon, 23 Feb 2026 13:53:57 -0800 (PST)
Received: from [10.34.149.227] (123-243-199-74.static.tpgi.com.au.
 [123.243.199.74]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-826dd6435c5sm9171789b3a.9.2026.02.23.13.53.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Feb 2026 13:53:56 -0800 (PST)
Message-ID: <5edd0981-2505-40b9-b8cf-542a1c1e438c@linaro.org>
Date: Tue, 24 Feb 2026 07:53:50 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix: copy paste bug
To: Weixie Cui <cuiweixie@gmail.com>, qemu-devel@nongnu.org
References: <20260223095436.61247-1-cuiweixie@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260223095436.61247-1-cuiweixie@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 2/23/26 19:54, Weixie Cui wrote:
> ---
>   hw/ssi/xilinx_spips.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index a4718fb72d..f6e717bc01 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -369,7 +369,7 @@ static void xilinx_spips_reset(DeviceState *d)
>       memset(s->regs, 0, sizeof(s->regs));
>   
>       fifo8_reset(&s->rx_fifo);
> -    fifo8_reset(&s->rx_fifo);
> +    fifo8_reset(&s->tx_fifo);
>       /* non zero resets */
>       s->regs[R_CONFIG] |= MODEFAIL_GEN_EN;
>       s->regs[R_SLAVE_IDLE_COUNT] = 0xFF;
> @@ -397,7 +397,7 @@ static void xlnx_zynqmp_qspips_reset(DeviceState *d)
>       memset(s->regs, 0, sizeof(s->regs));
>   
>       fifo8_reset(&s->rx_fifo_g);
> -    fifo8_reset(&s->rx_fifo_g);
> +    fifo8_reset(&s->tx_fifo_g);
>       fifo32_reset(&s->fifo_g);
>       s->regs[R_INTR_STATUS] = R_INTR_STATUS_RESET;
>       s->regs[R_GPIO] = 1;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

