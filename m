Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4E0C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 14:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnH0P-0004rg-FF; Fri, 24 Jul 2026 10:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sef1548@gmail.com>) id 1wnGBd-00058M-AX
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:43:37 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sef1548@gmail.com>) id 1wnGBb-0001G4-M8
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:43:37 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47f7854678cso333967f8f.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:43:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784900614; cv=none;
 d=google.com; s=arc-20260327;
 b=spAaVWEscn3l5GuFjSIcgLCQFV9nKGAPsEFt4HMRWugXj+PMrnq+iNjcHqEEekeZCa
 4ffSJio3rvQgZU98+2IZWrSfJ6TAz2kFCPk0D+rdaIx/L0P26vTorQfjSGd/v2PG5+aE
 2ggQnNqzss0MaaOitP23k5OtnSRXslWkz3kBmHUPXlx9LzUxhZYecYKkPquXeNH6UgK/
 RL8+7HICn9fYM9BWjWT/PnR/4OFk4U02KzhrnArjcH1/j0GnskDrxh7wCBRl3MKynwjM
 duIyJAlrMXCZ5o012JJLvlRTkNCdHNXtJGaIU0KiyQhT+iPyicp4zeDLQZKLa2QMnpHC
 Mo0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AUVUTr/HgNRCnwG1yMKM1SC4paeEuvPkbXDF+YwNfeE=;
 fh=cQWVVH9T242gT2rnDxx0t7mEEgAwVlzt1yt//Mhx2Rw=;
 b=E3p8c1y2a2Ee7jvJNbn9SDgtKHNtzp9q9Ic9IkOCpX+h+L7bAfrd5oQaefBJxF3Z70
 RA8vQsHd0NBpXaYQ9t2VUSS06p4bMZqdEpO55q1B6FUGs2liEqT6dm+bqMGssZlZ40QR
 JCa3XLJJgpLlaXGoVoHYDirvDJlM6r6+SSTOc5I09TQ/af4mWmP9pGoN6FFADYNVqPu6
 S9N8TDFopMRBX7QeSL53CCSNsLR+eCEXZOQ47ommPqtcLetCfEnBct/BMWyjZ+aNYewy
 4Iw+nImLp2l3Wdsrfu95s71606BhpXMtWBMzMYimUI1K6bNCjsc7XO9EWRw+HDHCcit/
 er8Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784900614; x=1785505414; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AUVUTr/HgNRCnwG1yMKM1SC4paeEuvPkbXDF+YwNfeE=;
 b=due2kkYEls7SeKP/IH71Uy2etBbZNewclcAYCvSF6kuY+k2PE35AQJ3Qu7IBY90v26
 jZjH0qdS+YE4VIZjIBcLxfEYvxpe1VBN7etLaFfZGyTRZZB1uSP58vsorhw2ktNLGI7i
 9sFcec8AssLfu8uS0ypNn2exjpu7iukheNvcEe5hkGvbqhsr18TA6hf7m08UKsdFiMm3
 N7X4c+cFZwRd5KSvP1LDNhx+hBmcd9QR0aV0rK2x5udPguoicu3bQDnU6y+ed8MxRP9W
 wu3L2DW5hmVggVbTdjWV3SNdPGXsTZYWdqUxr4un84G/MrbndCVGJYBdxpcGk+HUHmB+
 jn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784900614; x=1785505414;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AUVUTr/HgNRCnwG1yMKM1SC4paeEuvPkbXDF+YwNfeE=;
 b=NonSc0QxtyDVCP289sUXK/LCYR10yFiAIBOG9+PibNb5o06WfP0kMkB4E+VlhOM2na
 dunZItkcj1PBzfRNGDkNz9vQTihox7ei7W+rID68XERslymZZrHmx0rzFDcl8Z5SBD7e
 xI6tsRBiBy9Lw1p0p0IR/W3ZPSrT1JluMHoLSS5DXYj+IARdOdT4mHVNs+JhUQ+77Wpj
 w3usQDRm84t6b9q8e82xOYQKWPXeJhiy3RtGPLh1v7Gboq8MIcb7Fi+CrMh79KnThJkb
 tXcCkk4JhyhEN/hQoqqxySi2tI6pwRHioVk474+i7tkYdnZO24n4FNgtKz8UvSjBStPI
 7EJw==
X-Gm-Message-State: AOJu0YxZjfAqb7ts7rNKiPUQRer9keBPvCmW9P/KKYq8vcO7SiMKl4TB
 bFN7iTm1z+a6QPpc3PXuOTWx5ZtcQNhqvrMJcgDRTsY+0IiLXcHq1xdU/SBz49RjeXb9wrMzpu4
 4r9Um71PgfMUGFn5R0Ume3u+CFUiOwTM=
X-Gm-Gg: AR+sD12JYjjF+xRl7HzsNP95ly+ubU8B2XM+27madV1e9HtB/BFMdHtiSPJazY13mlh
 UONx47rixrhOcvXLzSWykS8Hi+HIxDHX7pqmFyxMdiumMAElL7zJRiDLWB2p7znC5UdtdF2P9zV
 zE03p9DncX5QniFt/vsidiExrjo3D7jy12Syj+u8el314gfvA1SnOSnWMIByTEr7qOwt64opBYH
 HlnAitjA9ysC/L9f2ZPzsd+LsVKe5pg8l4OhDXUjeDW0HRfeeL10GVvZNmoykuUi6SEOVMqDha2
 1TSXG8GRbctxRCAmKLwK
X-Received: by 2002:a5d:5f86:0:b0:47d:dfc6:b28b with SMTP id
 ffacd0b85a97d-47f8d754476mr9310919f8f.30.1784900613772; Fri, 24 Jul 2026
 06:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260724124220.24152-1-22925483+botszhuang@users.noreply.github.com>
In-Reply-To: <20260724124220.24152-1-22925483+botszhuang@users.noreply.github.com>
From: Nick Huang <sef1548@gmail.com>
Date: Fri, 24 Jul 2026 21:43:22 +0800
X-Gm-Features: AUfX_my5LtMTa1rm8qHS320kbXroc8KMzN7IthO5D5FQzuPYwhuIi8ONzqT2mBI
Message-ID: <CABZAGREnda=cKM504On5qz2jF1VRwpAAAPFSoZC6SaVDeRE5jg@mail.gmail.com>
Subject: Re: [PATCH] fix BCM2835_I2C_CLKT
To: botszhuang <huang.botsz@gmail.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@mailo.com, 
 qemu-arm@nongnu.org, 
 botszhuang <22925483+botszhuang@users.noreply.github.com>, 
 botszhuang <botszhuang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=sef1548@gmail.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Tested-by: Nick Huang <sef1548@gmail.com>
--=20
Regards,
Nick Huang

