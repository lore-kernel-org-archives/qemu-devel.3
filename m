Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D115EC48291
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 15:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVYwk-0005nN-PH; Thu, 01 Feb 2024 10:25:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVYwh-0005gY-HK
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 10:25:43 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVYwf-0006jY-Vm
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 10:25:43 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-55eed368b0bso1921448a12.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 07:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706801140; x=1707405940; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P81bZc09JLdONIL0Ovoy2Kr/nCbiqlVDh16Y88Zh264=;
 b=fQWFHE7pT2AK2SCmz1cqn0muiJ+or3jRysR8nVI5ZmpclVqIp1+ZcwHtLRDWlE3lib
 VJ32IoGJX4R3/YQH+iDjNdTYIMFCKGXB5ct1U9aXTMwnkVqJOoLs2GFG6nEH9mnIJlXw
 eKmWD21OBPgseQw+Vr6S/5U1nbG/J8k83QjWBTZIbJwJezu0I4waCkUL9vDIjZnYcxsH
 toh6UCAPkCCVIU31ymVLGekCvfJ8WJhzayVugyAoF1qonvmc1FKgLZdOtwSeHH1jMdlj
 XS+EWQ7eFgUX6D6NoEXkPnw/obyfnNtx4LMB1p34a3MeIX0vqvyl2+Xrp9se6FK7MGwD
 DiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706801140; x=1707405940;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P81bZc09JLdONIL0Ovoy2Kr/nCbiqlVDh16Y88Zh264=;
 b=IBeC3oRiz8LsqhevBx0rEc91pvRh0I8pKn9RNHePsdw9x68NZHYAbT2wds/Ju3Bzn3
 nzgmBWabHC7SGRyH/ZwZcV0vZumJWDXecTADhJ6ApYKVnC8w3udpf/HC4m1V2MoZXbGJ
 gQ39xSW7YOl8eatuKmFSOOvWCFzQkbsjiIuFqb0eHMF7FBmf5g7DBbctl2cdnrxWXr/2
 WkD82OYCgqlx/FCnsJJDBDNdd0nzGsaejzBmNLkA2mEXg2iyhIGS0is2NTwWKa3NrAlt
 DlsICxjTbwATNrqluxlws/Qq07MBPjkuMe1jVacOXgciJ+3xdqcO2GooOk3elRnxyx9p
 +G/w==
X-Gm-Message-State: AOJu0YwnGOKIC9M+zSSpbT524uw6y038sumSuOiAldnekpNCNMTkZ7hx
 bHl1NOXJXntKOy+7xmu9NauUscQToK+atmBtHpKjkrKgx7p/fEr42WCAK371Ovsl2ny+7QyVspK
 fW0Qgyaeb4leEdWJdya2Tm53LfbEJpgOaMF8cLFgFqHGGrCSg
X-Google-Smtp-Source: AGHT+IGKN1v9S9jrGm22kSKru/hDOHHOUf2ZCOnU6gL37MPD1U2fZ9T7Ol6mHYLHj2gTupxvFtq5RKQpDHaSPghnS1c=
X-Received: by 2002:a05:6402:28a7:b0:55f:16d2:46a8 with SMTP id
 eg39-20020a05640228a700b0055f16d246a8mr5007383edb.3.1706801140592; Thu, 01
 Feb 2024 07:25:40 -0800 (PST)
MIME-Version: 1.0
References: <20240126005541.1839038-1-komlodi@google.com>
 <20240126005541.1839038-4-komlodi@google.com>
In-Reply-To: <20240126005541.1839038-4-komlodi@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 15:25:30 +0000
Message-ID: <CAFEAcA9V8j=72YN1VXx_WTAEjJ8caSd_qhdEwXV79xQ1DDMN0A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] hw/i2c: smbus_slave: Reset state on reset
To: Joe Komlodi <komlodi@google.com>
Cc: qemu-devel@nongnu.org, venture@google.com, minyard@acm.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 26 Jan 2024 at 00:56, Joe Komlodi <komlodi@google.com> wrote:
>
> If a reset comes while the SMBus device is not in its idle state, it's
> possible for it to get confused on valid transactions post-reset.
>
> Signed-off-by: Joe Komlodi <komlodi@google.com>
> ---
>  hw/i2c/smbus_slave.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
> index e24a1ef472..58abde29de 100644
> --- a/hw/i2c/smbus_slave.c
> +++ b/hw/i2c/smbus_slave.c
> @@ -201,10 +201,19 @@ static int smbus_i2c_send(I2CSlave *s, uint8_t data)
>      return 0;
>  }
>
> +static void smbus_device_enter_reset(Object *obj, ResetType type)
> +{
> +    SMBusDevice *dev = SMBUS_DEVICE(obj);
> +    dev->mode = SMBUS_IDLE;
> +    dev->data_len = 0;
> +}
> +
>  static void smbus_device_class_init(ObjectClass *klass, void *data)
>  {
>      I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>
> +    rc->phases.enter = smbus_device_enter_reset;
>      sc->event = smbus_i2c_event;
>      sc->recv = smbus_i2c_recv;
>      sc->send = smbus_i2c_send;
> -

This should probably be the 'hold' phase of reset, unless there's
a strong reason to do it in the 'enter' phase.

thanks
-- PMM

