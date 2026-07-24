Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD529C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 14:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnH0Q-0004ru-4c; Fri, 24 Jul 2026 10:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sef1548@gmail.com>) id 1wnGK9-0007DQ-Tf
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:52:25 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sef1548@gmail.com>) id 1wnGK8-00024m-Az
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:52:25 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-47f71156e1aso253661f8f.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:52:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784901142; cv=none;
 d=google.com; s=arc-20260327;
 b=kSGzLMgXX4xUBK03tFY2ErNuXN0mcLqGQBKy4/g4BOx/QjAD3mncrlxqXYlNeoNQpZ
 GEvlTLJez3R06NC4pF8y/wWVqVDmQeK8M/n+puwL5emq3cUiVyNY0vgkWJD56tdlap7Q
 CfYEki01nmq0pcndrYhn4KoZMldBF9Tjguh4+JcimTQBTN4nzK5YoF4WocN5BHtZqu6T
 lx6KnaL5Ev4rYXI/kX/tI9d3ZYZOgfqsru8QYdhikj5A/qX+PwoCKQDSZ+WwDMz2+Zfi
 uvknZEkJ2hcj1RmGtt34lPCiL98WKOINRxzgNWqZLhx1rVAmgFWROp5SdZcQkIyZlQ31
 ksuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=V6oyUglO8Xu1C1gsvw104MavYBVhw711ANAZceOpkdA=;
 fh=+/O8SE4RNoswfmsvXQegDS/RwwHnf+tvdYA1v73atHw=;
 b=AxsEZMUJJja8dUBAF2u3MUIolddYa8BahjQ6u1BLjKn9EirrxU/iQh96Y4KGiGmPGS
 rgUGd7nePp2foOpqameHmZCZTbtRGUiYSOdilG6aAy8u1Wy3CXPMPACr1m/nxpHdzdte
 UXoQoJG/ywFwvZWs9g1hmynxPx0dbhr5uaWoalOnZoZtRZN1hhOmzgeDR2JeGFEBNobG
 9Wc3Wbs7qXY+eX8l0Fyxx8SH9wweN2b9jSp0hKVLtPhzGvDVsOTo5mwtmSDKsfDeJkBl
 6aiY7csWNUb4q9eyHW3jwBfGbI33G6gsYRDtzAZ0qfZ3edQblP25g/vFhQ7BhB+TMuDM
 ABKQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784901142; x=1785505942; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=V6oyUglO8Xu1C1gsvw104MavYBVhw711ANAZceOpkdA=;
 b=XaPqfmr3B80HDyCI69DGLw215wbvCvn2TTc0IW4lisbKxR5K0UvRS7YGrfwYU0ydKZ
 Eq9lU2JBH4X3hki9Wv0GFpNJEXVHlcpz7BZ2C1mQa1ecIMJsm+6IHDplUVSFgZY/Z7Je
 t2jzBv7vsFLPCI1q9Y9LRkd22y0BhyEQFX6p/0Z6bBR7aO0HU0+0y+MW7DYcS7I35S02
 QIXpIRI05DZkNgB/lOGRadiqI8ji1IMQlB6yKwTS4PRLPafVgqqWstcGGcFR4d93ZKgi
 lL1DnPu74On7K3muR5D5g6YDPG1KDhD8gw3HxjwUSihUdsKD6vNBHKBWj1+1hwD4bGmC
 jeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784901142; x=1785505942;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V6oyUglO8Xu1C1gsvw104MavYBVhw711ANAZceOpkdA=;
 b=FoF0UvXwDWkO5ghd8S9TxssxTSvshAIAOdxiJkrXsjEdbhOKvhVKsybABZsRZAodAm
 suIGp2Z3niMZEOY2RGMSaxiEElGHgoN/OAZH86mYaFu+6yrLBkkmApw6qn6GYVZjd7+T
 BSVCBPaYXoPIEMSPDAc91VR2ahypJrgTcQbISAlDkd7mVgh/oAr23/L1IJANvkahoRF4
 Htv9MmC1OrcGG3t7dZBCeF4t59RC0jbD6Z3864Rj3E53FcqEqboAAtrxKMq7rXoidsyh
 rnQbHNxsZgEX2Goh27hyTQoXasrNgjtnTo0dZRrO4dNbc3wuTj6S/vbqHL/7OGy7ouK8
 kzUg==
X-Gm-Message-State: AOJu0YwGfKz7dOCybWEhjP1NKk+CWvuXEAVKvqVP3Br4G9lmhCmgYc/L
 a8CcHfcsffW20niOOGVdMorSvNtM1InLCtiWr/6B1gbl51RrJ+2tIff9CnuTqmeWNlAB/PY5uOp
 VznUhnDJ+wxFiuHo/pAmPjif5JQGmoGM=
X-Gm-Gg: AR+sD12MP2oje2d8nUd/9b2/9TyB/MM8CcGxV8FeG7iFnvIODeWiLnzx8ad7+f5jEfA
 brmjApn4gl8XiPZCUFNPzCs+plVDL/ZMelHj1ppfazIG2FQ/fDH8UHj9YvQKXRqhL5oOBeqHKb3
 AMRjpPJyhWd8AECCnMiqeCMYciBuUw3hMrazXxFIj7/p118lJwSnfj8s9CD1/C+fKnQWw9DkO8J
 2gYjwkyAehQtIlEEQAneVbt2hsekH5HxGdfMj4yxyn606KkkLSTJexAHPMGBMP1fAk1c7o3seU8
 q0udPEyJdd4Pn50sr5Kx
X-Received: by 2002:a05:6000:4022:b0:47f:80f6:afac with SMTP id
 ffacd0b85a97d-47f8dca592emr9663654f8f.49.1784901142267; Fri, 24 Jul 2026
 06:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260724124220.24152-1-22925483+botszhuang@users.noreply.github.com>
In-Reply-To: <20260724124220.24152-1-22925483+botszhuang@users.noreply.github.com>
From: Nick Huang <sef1548@gmail.com>
Date: Fri, 24 Jul 2026 21:52:10 +0800
X-Gm-Features: AUfX_mxyid183ZDhvc8jEW3aqyjgalQqizKUI04sk3aqGVEmTHw0h8-XwxYkC5k
Message-ID: <CABZAGRHQa4n4A+EAXSEfFCRRR8oo=4tRQMGCWJ7UpRGoVd5jXg@mail.gmail.com>
Subject: Re: [PATCH] fix BCM2835_I2C_CLKT
To: botszhuang <huang.botsz@gmail.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@mailo.com, 
 qemu-arm@nongnu.org, 
 botszhuang <22925483+botszhuang@users.noreply.github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=sef1548@gmail.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 24 Jul 2026 10:36:04 -0400
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

botszhuang <huang.botsz@gmail.com> =E6=96=BC 2026=E5=B9=B47=E6=9C=8824=E6=
=97=A5=E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=888:51=E5=AF=AB=E9=81=93=EF=BC=9A
>
> hw/i2c/bcm2835_i2c: Correct CLKT register offset
>
> The Clock Stretch Timeout (CLKT) register for the BCM2835 I2C controller =
is actually located at offset 0x1c, not 0x20.
>
> The previous incorrect value caused the guest OS to read from and write t=
o the wrong memory address when configuring the I2C timeout, which could le=
ad to unexpected controller behavior.
>
> Update the BCM2835_I2C_CLKT macro to match the hardware specification.
>
> Signed-off-by: botszhuang <botszhuang@gmail.com>
> ---
>  include/hw/i2c/bcm2835_i2c.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/hw/i2c/bcm2835_i2c.h b/include/hw/i2c/bcm2835_i2c.h
> index 45f876df22..519c65f765 100644
> --- a/include/hw/i2c/bcm2835_i2c.h
> +++ b/include/hw/i2c/bcm2835_i2c.h
> @@ -38,7 +38,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2835I2CState, BCM2835_I2C=
)
>  #define BCM2835_I2C_FIFO    0x10                  /* FIFO */
>  #define BCM2835_I2C_DIV     0x14                  /* Clock Divider */
>  #define BCM2835_I2C_DEL     0x18                  /* Data Delay */
> -#define BCM2835_I2C_CLKT    0x20                  /* Clock Stretch Timeo=
ut */
> +#define BCM2835_I2C_CLKT    0x1c                  /* Clock Stretch Timeo=
ut */
>
>  #define BCM2835_I2C_C_I2CEN     BIT(15)           /* I2C enable */
>  #define BCM2835_I2C_C_INTR      BIT(10)           /* Interrupt on RXR */
> --
> 2.43.0
>
Hi
Tested-by: Nick Huang <sef1548@gmail.com>
--=20
Regards,
Nick Huang

