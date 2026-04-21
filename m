Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D79F327A8
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 06:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF4IS-0001Ti-9u; Tue, 21 Apr 2026 02:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wF4IN-0001Qd-52
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 02:09:16 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wF4IK-00084v-ED
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 02:09:14 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4891f625344so17892495e9.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 23:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776751749; x=1777356549; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PsvOmqdR+PAMgvW8Ny63cT8kUXc//ZS402nme+dkyxY=;
 b=Qlij1u4b71rUk6xzICpzg8FIJM01IxkuUxe/u1+wP/JYo4bNM9No4hV0BBkxQ7/LS0
 +hWoqTzak4rR7xzrNenhEeWLECfubCud8L7XwWkOzAI4ePK2ZB3ggNMivpzqCFoVkT6I
 XYyIxNB00PpwD/jclM0KZMNkd8VD7j5H+6QQeLswEzfvGMpTBlBxpUswsqQcd4FT051H
 HngTfljGBFGIeIs6GfysUre7UIIUh2NxLfmNe24eS6Ayyyer2s/zQfvrvi7wIwfnH9TO
 DlJ2mt75t3RSWqv7Z1Xq4MZVsVdcOdDvshV0DcAZ8HveD4ls865UZemOy3n4SW6ERcPz
 pbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776751749; x=1777356549;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PsvOmqdR+PAMgvW8Ny63cT8kUXc//ZS402nme+dkyxY=;
 b=iPBaV548Tq9C89Z5HAl+o52ySkSD+kWe9pdOvCmm/M/yG3rnGNPoC8mWXC32m7NeBh
 2zV3xFwnn0iNyGGDlH60ZPKT6EUVgMltOZbmQkXnlPZergG1SPRkM4i8Ca6V5vGUT5ya
 dmelwufh9oOrf5Ng8eJd7qtvz0Du9Q50eQ4v6FANROmgcGwOB/3IUX2mDksm5GvIF49/
 8sFqQYUpTiJxEeGp0rokgc/qsQWS6IoHNam2WVaTejk+acRPNxEzTj641ml3Vf0Bug0L
 xwEhzwSTtrVBWXfqNzbJRJvM+c/VHthRdRCCXlD9KWPx/qo5Y3No5ygz6CzsTx63ft/o
 U48w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9YpcD5kTHb1RiqOlNyPIG7Iu7KgYc42R1lyVa2XD0xXK26vFSiMNCfJ6eYomY4AYz/bV0lTcc//ovu@nongnu.org
X-Gm-Message-State: AOJu0YxsPxvE6B98BQd+C0uvPD4IrCqJ+6oPCJgVoy2yHGrLVzqJMQJn
 sU7yCOIBl4xaq7nE5W5KmPGXW/Gu1wDqBB2OP+R/pxW6NLn7afUtm42TcLIqsO+plW0=
X-Gm-Gg: AeBDievRMJy+mjW/7ZIg+bwdKSo0MELShUm6XxPnTDxkSB2NYARvp3VovJLyb+xkibY
 LcYrT0R8kJBnZC97GPzKf7+oR9H220iQNwZp9U0EJliBJwaIHARnqicoOEZ/aYNU0XxEgUcIHgK
 qwz6mWgVBTeR18AOrymRmSjIKvtaECleSL7zF7XY11uFXqs9Hbi1sL1GQ6u2ZRaLAa5f95obFyZ
 JCdIwY3WYHgB1XKFygaezrUSMYx5t9NL5qLK8dXk33clTjyhyYt88LwobuWvq1DsyjuwBSxLeiI
 LWRzMN4yw1Wtvt/1E3me/t8ZMVzEUS7C40tjeKf8qu+y8DWY8uzzww3mxp076D3WXkTKzxIHnA1
 zU/+aFwaf6KUNF0OfsEzEpp55DfwbuDzOjLoiWRasvZLDNRJlJ4K3Ym/vfu+iGmID+xu9YwSYcf
 T+J+GHCgZtVccznQyIEBe7mw67R6lq4qSS9xD7NXcvgONxYDi/thHCkjfNQwldrkZcqE/xtyPwC
 IFU
X-Received: by 2002:a05:600d:8447:b0:486:f893:56c6 with SMTP id
 5b1f17b1804b1-488fb8b18d1mr164856175e9.10.1776751749469; 
 Mon, 20 Apr 2026 23:09:09 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a4b329542sm139338775e9.3.2026.04.20.23.09.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 23:09:08 -0700 (PDT)
Message-ID: <42263811-2d99-4d2a-aba7-a19dda3b5047@linaro.org>
Date: Tue, 21 Apr 2026 08:09:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/13] hw/riscv/atlantis: Add some i2c peripherals
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Michael Ellerman <mpe@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20260421053140.752059-1-joel@jms.id.au>
 <20260421053140.752059-14-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260421053140.752059-14-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 21/4/26 07:31, Joel Stanley wrote:
> Add an I2C RTC device and a temperature sensor. These are not present
> on the board but help for testing.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v3: Use HWADDR_PRIX in i2c device string consistent
> ---
>   hw/riscv/tt_atlantis.c | 18 ++++++++++++++++++
>   hw/riscv/Kconfig       |  2 ++
>   2 files changed, 20 insertions(+)


> @@ -542,6 +555,9 @@ static void finalize_fdt(TTAtlantisState *s)
>                          TT_ATL_I2C0_IRQ + i,
>                          aplic_s_phandle, periph_clk_phandle);
>       }
> +

Worth mentioning /* QEMU specific */ ?

> +    create_fdt_i2c_device(s, 0, "national,lm75", 0x48);
> +    create_fdt_i2c_device(s, 0, "dallas,ds1338", 0x6f);

Maybe use another bus to extend coverage, like #4.

>   }

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


