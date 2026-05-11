Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAE4CD484A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRvx-0006Ur-VG; Mon, 11 May 2026 10:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMRvp-0006Py-Pg
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:48:34 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMRvm-0002OO-Lb
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:48:29 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-67fd8befac7so2105042a12.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:48:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778510902; cv=none;
 d=google.com; s=arc-20240605;
 b=XQscCbKuPV8opC97y4HTVeZZQaqmvTiEExVinLiM/jRqkwcWx0/uL3WJ1GukYAaAz2
 yLzMJANZMfRwGMWA1F9rF6I+IWceXObRKkzRSwBLu0FGYejzSz5UM8N65jQ19xVwmR2C
 ysSOrl0FVH2xGGDpfVX5yx9TdaZmpJkGvxyPzXn7+2DNOz2JuHacdkXq5G1FY4BppAGw
 hKb/BpgNOjluZf152stU8k2rhR/PTfkUnvScaC9Gy9MtOrk5Et/2wkCSKmKqYzYozalm
 6gydXmWZ9DlcdiHS2T8NMx/bbgjoQAcJig6D7pk9pDcJ+qR6I5kePi8PxkG/IVuG3A/l
 0sgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PWJxoxz6bXD5xX/7icrkmlXM2C8ow3SYmXGh1OIVtkQ=;
 fh=1/KVKtzfGc2K4mAVttApsryT/zZmtT+a6xyvmHzR+7o=;
 b=OyV4XuS2l129P/wT9brirHMqBrtvD4J5bBHV6NYcEoYCDT9QjDjQl0eMBjb+QN1Cg3
 UMd+clx53wTp3slTXRu6qsYCBk6Yl9ho07N2KWLUWY7o/7k4zceaiFy7ecvEqJP5oVsY
 f2/zX98A2ACLPToH8CrcFzBCklj0fQlViCOY1lg8mHnTpHU3wMInEayGL7F5AOGyHkRx
 uLMyP9U08NTvD/HKdJEV8S/I9EupiPJW9YYmIB6gBW/vgOVYJFGmSJ1IsiXk791YMctQ
 ygahgzlE2HtAfZoSRQbhi4gfHFmZw/YkcdOHHaSl+lmKrWbw/1QjnCvXWoTfVBTMNTJb
 pLTg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778510902; x=1779115702; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PWJxoxz6bXD5xX/7icrkmlXM2C8ow3SYmXGh1OIVtkQ=;
 b=WRsxlT5KICTzv0MsTEnx26TAQ4b1TtN7R0pEc0LUKrRQz7RVtx1I/CzNiWG/9jgVSn
 tA/raix2Yf3e+WL5sF3XO8PTKtSMrgs2RL4u0X0OZpAG+saEwjtina47u1qB4ihdVAQQ
 Wdkbn3qGSMXnM1ezfe/3ecmivn0Ojct08vLimft6QOnZByDXOscNK77pDORa+fgc9+dK
 G2EchMkZ/8nMaE5HpqkhYBmSjfGNohQClT0fHklCKHjkjuqiUo2wvPo7jsrNgD+hlIr8
 A8d1v8uEjiqQJazcPe752xu4HP6f8TkCy7s7zC1x8spnYRXloZPTP1tYupmbL8Msf47N
 NhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778510902; x=1779115702;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PWJxoxz6bXD5xX/7icrkmlXM2C8ow3SYmXGh1OIVtkQ=;
 b=Bkm4vNoh/NHwwQqN44VSldnKlKOg+YJVGg6gRMT6zXU8AqHw591ElnhCQzILJHaBy9
 NDQhYg4o5bJJdoRizuaYeK6OJ5xn2cWIj1Lg1UeJGH+PL1t4GIIMnJu08+lXMox2Ocrg
 7WCL2O+5Qt8i+1Ug3ahuWG4Lk75hk5pgxQxUUDZBwfexpeVQFvmDJ3AKefrPJMARlOFC
 UedPUoz1GagSNjp3WJmZje1vZIve6L7LK0DGsxm1lzRGrqOKNITBrfflvPoWvnMArpyM
 e3ch4Dwhk/bw9b5C0VkVi1ZxtM/qZT/gEmgf8CBLAtp4gzrrsIl0ip67dySuz5gOfn/h
 Jmiw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+rUjpk91lb0MU9wAM7cvn/NRygb4kQpL/xgqP6qA553jZ9osgyE08RZ7ngHKh8iTrTilFTqpVIm2Na@nongnu.org
X-Gm-Message-State: AOJu0Yxb7BQzhPwsABq0DEkqSqVAjMYx1e/ilqIR4o3tBEs5BSV8+uXy
 S396LebM4Omatl59T1QKGFt5ck+rGbzVYTjRSTRaOZFc83RNSlpW1KZ6iMQU4eXnroPUICNP070
 dJ+p+xk3eN6+gEFgDfVIM8BJvPczOBOvFTjVaz6+zwQ==
X-Gm-Gg: Acq92OF2+oTwINNDYoBWDwOJWEPynEMAGl7SBC80MOVs13HhSoBDGcH2xN9eM6SJzxn
 2OeArmbLotdioCuLMOFGKBxdvPaA/GsGb59o9zkAs6BP90ZgNfzrBdf+YW71Qi9mdts7VFFyes+
 jRXcREshujAyokEIAybrKQ/Ld1YdYVDXOqEthVR9vvK8SkVkCjg+qT4nslAM6LRuQJvrusdheZ3
 wwudFln4F/7FyotRSqq9O7dNdWx/ATJAjobbdvFz8y3THE/2NddPu2JPR3M0HggiZ8DMlauu8Ew
 oYNSNZiwTtlJPSyy+VS0WmWi0NNkVy4ZDlix+Y3DLLwgMkJNXzToF88bhzErr3+08/xJ47lUTua
 6sg==
X-Received: by 2002:a17:907:2d2a:b0:bd2:2657:9b7f with SMTP id
 a640c23a62f3a-bd226579ff1mr15516466b.44.1778510902069; Mon, 11 May 2026
 07:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260501162634.4092394-1-peter.maydell@linaro.org>
In-Reply-To: <20260501162634.4092394-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2026 15:48:08 +0100
X-Gm-Features: AVHnY4Ke74-rHdd7oNHHu8_a75Gv12LA2ZSPZd-O17t0MakMwH2_0Q5sZa39nIM
Message-ID: <CAFEAcA8nVfzFrQ8y5x9_Qp62QogVcvN09Q0JkqcFrJv73g80oQ@mail.gmail.com>
Subject: Re: [PATCH] hw/i2c/microbit_i2c: Don't index off end of
 twi_read_sequence[]
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

Hi; ping for review?

thanks
-- PMM

On Fri, 1 May 2026 at 17:26, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> If the guest tries to read more bytes from our fake stub I2C device
> than we have provided, we incorrectly read one byte beyond the end of
> this array. Avoid this, and instead keep reporting the RXD register
> as containing the last byte of the "data transfer".
>
> Cc: qemu-stable@nongnu.org
> Fixes: 9d68bf564ec ("arm: Stub out NRF51 TWI magnetometer/accelerometer detection")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3408
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/i2c/microbit_i2c.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/i2c/microbit_i2c.c b/hw/i2c/microbit_i2c.c
> index 2291d6370e..d9689b6f1a 100644
> --- a/hw/i2c/microbit_i2c.c
> +++ b/hw/i2c/microbit_i2c.c
> @@ -41,8 +41,13 @@ static uint64_t microbit_i2c_read(void *opaque, hwaddr addr, unsigned int size)
>          data = 0x01;
>          break;
>      case NRF51_TWI_REG_RXD:
> +        /*
> +         * Return the next byte from our fake data sequence. If
> +         * the guest keeps reading the register after that, keep
> +         * returning the same last byte value.
> +         */
>          data = twi_read_sequence[s->read_idx];
> -        if (s->read_idx < G_N_ELEMENTS(twi_read_sequence)) {
> +        if (s->read_idx + 1 < G_N_ELEMENTS(twi_read_sequence)) {
>              s->read_idx++;
>          }
>          break;
> --

