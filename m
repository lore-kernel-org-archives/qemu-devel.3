Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CE6C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 13:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulow0-0002eg-E4; Tue, 12 Aug 2025 09:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ulovy-0002eI-9Q
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 09:20:58 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ulovr-00085i-99
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 09:20:57 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3b9141866dcso306247f8f.2
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 06:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755004847; x=1755609647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Fka+pEH0bFL/6o9XACC3eJoAEPxoWE5u3buW5u6ZS4=;
 b=DjAYQKTBz6T5i8kzr4b8lRo7sR0K0dBxNulVumgqMFKkd3F7y5RfwaNYUGFh5GjhWz
 L8GvTh/o4N9lrbPKQuQsEBAN7aCg2ejv33xTjhG20jg3aVvgnQySoSbLsRXmu2GsAxyE
 VcVyNYg/ZhgIaOyqWpXmesTVLnreNB7/309ETVL1i5NC1IpoQsIGCLmBToJn1GGZE1+c
 ttAPrbiPufv+xBihqZZ2O6Ck+MD5/9aA9lUiW8h65Z/KW3JhAF3U+NjVFOHM1+hZWER7
 76hPPQldXC5ZRozbJIQcf4drWxfM/DIY2C3kWu9UumEeRFSnvuJhYdrlFB3+tVsLulOd
 L04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755004847; x=1755609647;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6Fka+pEH0bFL/6o9XACC3eJoAEPxoWE5u3buW5u6ZS4=;
 b=ooyWQGHmMkhV9wk905wQFU25r2GEKYLhpVfehgmXXWEcqYwpFJf9TscRt5kOCg8oBy
 YMWT69hxaCOFblsQjEPm1G/8Fg90Bh5D1pt81ZDga20D81LXZ513hUg1fY0fUhWr7KC1
 gznvGHGJceEJ/PtEDkrC32ewGbBawBAe3Tjfop5iE55Dq4taIx4CHjqPzSSHYWnRB1W3
 AgSx+cgkrnmUTjrTx8pn2cTHXpRHCOcU/3Pb0vjOOi4kT5OX6mQYlyQfFqGEw4DNt0vX
 bL8dqEZYssbNTuqgWtL8Ssuk8ygH/BQh8VvSWHxKd/tHGZhopjBJybfH79yMoVUWUf6n
 PeGA==
X-Gm-Message-State: AOJu0YxabAp7uLUYIeJsdBq7P3MfGBvucvgDyk5VIw6FrRlMUFyPbCbu
 hFgc/ahNJNge7rV5l70oENvTJxCaVKXrH6YkqtdlpPnv2z02i+F1XV0nzx8Z125UdIY=
X-Gm-Gg: ASbGncuIy8HJZEqJqG2AT8qlVUMzJvVUzgc5ssFTTD4NBVeXd/RL8DpMauUNzS5ajzO
 M23snQpdfTZH60paDQWm02IvjIiMDyQBF0MoCGvCu4X4I7ezNVIaXtTag2JFpLfZg7VNCK8K2lc
 ihvi780/JA5x8diaDfxWylpDqbObQmE/vN54N0W1kzXQrnzOpqTqQFlzaJzvO8EDnwIP1FEOSTB
 12sC1zYVx70sAlvenfm1fidlv7jRQJeLDYbfafckg9NqOCa0huvoJfIo3nnHl4mqZopBDS6Zkw6
 1y6lquyFvNCR7JWGdBFsRjkqn7VHOsHOrVS/yf5M7n1otvwa6eNivE0kaNwZwZMZEJibyBAStY6
 jUu3ksuBHytRXPqpa7gFAHp8=
X-Google-Smtp-Source: AGHT+IEBMW1zfuGSVJtypG++212xFeeZkBRVDK4LXgtIiEBpOlqz1PU/5Am5CcqwB6hdLY1EmeiUSQ==
X-Received: by 2002:a05:6000:40cc:b0:3b7:905e:2a32 with SMTP id
 ffacd0b85a97d-3b910fce9b3mr2884710f8f.12.1755004847396; 
 Tue, 12 Aug 2025 06:20:47 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c338c7dsm44490718f8f.0.2025.08.12.06.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 06:20:46 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9AA775F7F3;
 Tue, 12 Aug 2025 14:20:45 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Guenter Roeck <linux@roeck-us.net>,
 qemu-riscv@nongnu.org,  Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,  Bin
 Meng <bmeng.cn@gmail.com>,  Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>,  Alistair Francis <Alistair.Francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,  Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH-for-10.1 1/2] hw/sd/ssi-sd: Return noise (dummy byte)
 when no card connected
In-Reply-To: <20250808135115.77310-2-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 8 Aug 2025 15:51:14
 +0200")
References: <20250808135115.77310-1-philmd@linaro.org>
 <20250808135115.77310-2-philmd@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Tue, 12 Aug 2025 14:20:45 +0100
Message-ID: <87o6skad76.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Commit 1585ab9f1ba ("hw/sd/sdcard: Fill SPI response bits in card
> code") exposed a bug in the SPI adapter: if no SD card is plugged,
> we shouldn't return any particular packet response, but the noise
> shifted on the MISO line. Return the dummy byte, otherwise we get:
>
>   qemu-system-riscv64: ../hw/sd/ssi-sd.c:160: ssi_sd_transfer: Assertion =
`s->arglen > 0' failed.
>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: 775616c3ae8 ("Partial SD card SPI mode support")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/sd/ssi-sd.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
> index 594dead19ee..3aacbd03871 100644
> --- a/hw/sd/ssi-sd.c
> +++ b/hw/sd/ssi-sd.c
> @@ -89,6 +89,10 @@ static uint32_t ssi_sd_transfer(SSIPeripheral *dev, ui=
nt32_t val)
>      SDRequest request;
>      uint8_t longresp[5];
>=20=20
> +    if (!sdbus_get_inserted(&s->sdbus)) {
> +        return SSI_DUMMY;
> +    }
> +

Seems fair although it's hard to track what is consuming this value. I
think we end up in ssi_transfer() which a surprising number of calls
don't even bother checking the return value, other just seem to | the
result when iterating across devices.

We should probably improve on the definitions of transfer/transfer_raw
and explain what the return value is.

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>      /*
>       * Special case: allow CMD12 (STOP TRANSMISSION) while reading data.
>       *

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

