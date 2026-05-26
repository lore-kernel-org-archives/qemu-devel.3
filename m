Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8390CD5BB4
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRmqC-0003nU-5f; Tue, 26 May 2026 04:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRmqA-0003mn-72
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:08:42 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRmq8-000270-KS
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:08:41 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-65ffefd8bd9so1153018d50.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 01:08:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779782919; cv=none;
 d=google.com; s=arc-20240605;
 b=caHI1upQWeaQgyDz6HlYxn7abXAIt2qsiSHxu0GUrfMyIzEupmQ5Jz68epb2mP/C58
 La7rqs+/oRYMEfvFtH+YU2ajYGfbRfDgoTowG4fikWld/0sgDlxynyO/sImqZxkIQmpg
 Zgpf75SsSbfplrK2lE/eJmEKtXvWEQKZZDxJ/n16sFM5x6NJ2m5LHo+FIfhs6RUfg/ki
 SNsoh9nalGc+/4BBy9y1SfkRlcgDpOoQHCIBy4W3Mfw5kWKHj0X668SLXzPhOt+iinFz
 eXZqVmr/ZWxdaLDCCq/Zw0KPQTxzNlXAzHjP7ihmzXGWJHiGUNBfD1HjfHFTUHgXi2Qs
 hSog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=U5DfpMlxZVRYI5k81JFixfaDChV2TY4u44UT/G4IMUc=;
 fh=1EGL808GC7UisafgVSBPpBEoPQPTRUcb3vaSrd4npec=;
 b=Rtm3T6dQnxzYOC17JDh4aJmQn+GBAVG17PXGEHc2GCDGvFv4qeEQx0B7pBxclkCCLp
 ePDHumAvCfatW3S07k5sL8a8rdlhVW5KffBWhLuKMErHJWdTQsfyX7N2KcJ3TWOI4eep
 6K/+y1Xh3vtdCJtTw3ex1fwCAhR4bjesPXyzF266kA1pCHPR2FmgjcK79VdBGV+qOMR9
 8OKl5+Pw6uOvppi2tBHsDutYlgToPMlJyIV1MHK/h0/jqeKWvAglIagiR2StcxYRzy2H
 rT57xl+mlsoYgAKsLXwvBC2nTv26yj2WyWHHvYaGws05kWXPli0SpIgipnGEkffCxxG1
 evow==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779782919; x=1780387719; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U5DfpMlxZVRYI5k81JFixfaDChV2TY4u44UT/G4IMUc=;
 b=N6/zhXHEMrxgG7ZYcl4ZIYynSC11YTxbrVfhwJF3Tcbd20ZNosVDrTBtleQlDUIODl
 a1l5dMiXzq9sGvI4RxeeAPbPogPizvWo1Saipre/wFWsMm94nwWWr10Zi2jNoP739y1M
 p/sqPSKFATlDuqEByq1njOJfKxbeJGpheUuEaHgA9J4abhjHj9sgDt3ra4zetHJIliUm
 UuPyAPyMRKFJFZceM9VK0mlojDbdIARtwUZGXPdAO8YXg+BZr7Ki1kN3BIC9kvOqcX5j
 rbnQwtNK4VS5BNeeiz0mwsLagDqiCTcthX7ur69Qh9RJFZoLdblEOZEGYbJvo+VB/sfI
 SB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779782919; x=1780387719;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U5DfpMlxZVRYI5k81JFixfaDChV2TY4u44UT/G4IMUc=;
 b=G4ciRbwI2H5XV5KTZEoPflTyrXXi03tDn/DKOIR+Tyeoy5efNQBiiIXG94kTaqa7uq
 N0pkXCtZkM0JXGJmV0OGDh8Da1TaOXfHd0MmnBkal9VOjTdoWOg2UT9v37ShacdQ06lq
 4PpUbDFpMEi3VuRYbR5eyvp3LkOQBs5u9tA1H5wJn3CkN6DWzNOra+ItwL+7iiGuJbJv
 rsqqds4OMMp0GaIKvgwMhEZpIOkJwlMAZHSV0/lkVQAJP+lpiy8YZtiJ2m8C5UmM/vbk
 RT+QJMce5WKdXxin2rUFiVwANii+KKE8UJRnBY90SQaMyhQ/DgJxEZctroKWX/6v5eex
 63vw==
X-Gm-Message-State: AOJu0YzpP6k7vroQ/aLNq0oPBuDPrnHJ2a1ClLfo/AHYSX9UAL2UAieN
 XC65tUrYh6+SIY4qJL6gdSOPCNfahsKnmvPF5QxwpbDrmPtL7yY0tYwsF3IxbpLoKcy3Jefq4Lz
 O0zgElWvbIaAEoSPb7yKwOfiq41HvwntVxC8Itq6moA==
X-Gm-Gg: Acq92OFJrXMApqgDz9WTjcWykzTKE7OSmSyTY8buz25g9JawRmxxVG99ncjifBLPbqr
 cQDvMXwCeKH+8Gt/NWq4/Df4X+NgEfr+NU6mvOsq9ct9S2ipJ47EVo9aY8qnzrRa+DL3spESUfp
 FilVDUKjOukroLvYv4SMm79TqkJ2qs+9Qn/8paEwoiyO4rPBjA7oNw5i8E1bh3ulfnnwgnHxJRg
 QdChuYzOSfRLtvZ09MeM/cPCvMTA8VDf0CLdQ0tlV3z38OZ+xDQF7SxKVvlT4BVNS5IIEVau1h5
 TOgGcFdgTWyA6FQwiCxt1WqjuePPOhaab33qp8ZpS8X0tlrV1x5isFuDf2Oz0REGcWc=
X-Received: by 2002:a53:acd0:0:10b0:65e:14b6:b1ce with SMTP id
 956f58d0204a3-65ec96337c7mr13756559d50.9.1779782919057; Tue, 26 May 2026
 01:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260525032634.7754-1-nicholasrighi@gmail.com>
In-Reply-To: <20260525032634.7754-1-nicholasrighi@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 May 2026 09:08:27 +0100
X-Gm-Features: AVHnY4IaJjBVqZSYxM5YT6vuritWXZQIawL5wLxbuYri-rsE00EpCcdn2BNIIb8
Message-ID: <CAFEAcA83RtkukDbExv72YztjHZkhLy8JyOc49gY3eaKoW-5jKA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/bcm2838: Route I2C interrupts to GIC
To: Nicholas Righi <nicholasrighi@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Mon, 25 May 2026 at 04:26, Nicholas Righi <nicholasrighi@gmail.com> wrote:
>
> The I2C interrupts are only routed to the legacy interrupt controller. This means
> that for modern device trees that use the GIC, the interrupts don't work. This patch
> re-routes the I2C OR'd interrupt from the legacy interrupt controller to the GIC so
> I2C emulation works out of the box with current kernels.
>

> diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
> index c14a854046..6895f70385 100644
> --- a/hw/arm/bcm2838.c
> +++ b/hw/arm/bcm2838.c
> @@ -184,6 +184,9 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
>      sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->aux), 0,
>                         qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_AUX_UART1));
>
> +    qdev_connect_gpio_out(DEVICE(&ps_base->orgated_i2c_irq), 0,
> +                        qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_I2C));

We already connect this output from orgated_i2c_irq to
somewhere else, in hw/arm/bcm2835_peripherals.c:

    qdev_connect_gpio_out(DEVICE(&s->orgated_i2c_irq), 0,
                          qdev_get_gpio_in_named(DEVICE(&s->ic),
                                                 BCM2835_IC_GPU_IRQ,
                                                 INTERRUPT_I2C));

It is not possible to connect one GPIO output to two places
like this -- the second call will silently override the first one.
You need to create a TYPE_IRQ_SPLIT object, connect the
output from the device to the input of the splitter, and
connect the outputs of the splitter to the legacy interrupt
controller and the GIC.

thanks
-- PMM

