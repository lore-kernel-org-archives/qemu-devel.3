Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948EEC531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 14:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnH0Q-0004ry-DQ; Fri, 24 Jul 2026 10:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sef1548@gmail.com>) id 1wnG9X-0004g7-8P
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:41:28 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sef1548@gmail.com>) id 1wnG9V-00016v-Oh
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:41:27 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49548aebcd8so3662495e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:41:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784900483; cv=none;
 d=google.com; s=arc-20260327;
 b=okS3OexFa1Xx95hM0xP0nIpeeHM9Axg2+D1mqNucPQvHbIoI2gtaVbE13uFJ8NnbfQ
 w9OwO4PmKzB4VHGT9MR8HWp6c84X0ifYb5XZgQvzheTAzYiW9V6AU1/DyrMkzihLPS/R
 89VoKfaXOvbGOp1DUJzSuAd82qzv49XvXJKaB9xQ+mAyuMFoRdv7bTV0qzTAPtnt2+JQ
 6g8E5rX7KztpTD11gQfwx9f65GekczxilMTLAeWY+MQa7Oysr9QhYw1SJTMScnJGD7HX
 cZkAC9E16MI3aI59fR/RWEINIk+v19zWGQurcYAHuMEleaSK9eK7UNm9p5H8O1Pgyhdi
 Y/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AUVUTr/HgNRCnwG1yMKM1SC4paeEuvPkbXDF+YwNfeE=;
 fh=cQWVVH9T242gT2rnDxx0t7mEEgAwVlzt1yt//Mhx2Rw=;
 b=jOqal3gvzBt+A4Yp05lmSXpsLK5xlOmm18RSOFbysFKvwWRsg7rJW4ZSJCtv81UbA9
 8zH4aQwVt5uB0WPGHw9lvo48C8G/dVdtmSzXyuAAzlzFFBUbKrHI6alraowHOAuvWiRP
 +E9mg3GuEbVUWw1D0dhIF1J46Fb/l5Ns8/SxCCYFP235qzABnoYKAsjdmwlBZ52dOLPa
 1do8hi7UekE201HALbc5DvjjhqXc6yyBNljCxSLJsnXDdZ5mu/T47bcuLb1XlhLwDtgN
 b8s4ern8g6fiqig45l3WyZ5jqnRIwH54t6VKOLRESmMXwIhPgfliJ3715phxKEzSq2pb
 x07w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784900483; x=1785505283; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AUVUTr/HgNRCnwG1yMKM1SC4paeEuvPkbXDF+YwNfeE=;
 b=sK4LSAEP8jl294bvj4PHJJ/t2BzsSkhB/Avz4ix+DJob+i9dftpV/MYLAMS8qjM8Te
 wTM84Mr54oIJ4QjS+3HyD1XdaJcxCH2RdW6qiXnDLwSCjwFFMuG6DIfiwQb8MSVwcNse
 Jd0CdORLw10FCkaJS8oAhorTWpJn9y5bQ9pInTD8F/+Aab2r/cFVaGQzO+/lGqMn2/Il
 QUKFekutHaZ+nPcJPWPllo7e7k8QcOcqc0Ogtts2i+AEU568bP0Ie2oVz4olVWLzbhI3
 eiVv3l6YgL8cj5UghmvvuBjdQGwHDQfxCm79gYEa4RBXmPa2ILsXyf4vn1o1ILvJWEmf
 4hYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784900483; x=1785505283;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AUVUTr/HgNRCnwG1yMKM1SC4paeEuvPkbXDF+YwNfeE=;
 b=XgxuP9fYFWsT1qKBm2N4hgW3wipoHi2MUvv1T7etPSW5V7JP12faWda9M45QiUajES
 cUYIbNuqjXnGqOHOwPXfOVI6h+r9Rvbf4Rz7PFSpgAkHvJ80xL0FLjMmXqst8BH7gY0h
 i+1FtPYtEPg8O1vfmeydDpds8pGK6f07iEpmPEdfo7TZ8Vxgi7NWzaOxWUqopV9ac4jz
 2xYWTvzAZxjghaT7ZAskysprvoKnAEM8Y5xgE2MHTzBJsiITJs2bHgx09Zbk3YyPE7UF
 IqQm0Y8b6b+mctu4VLvCC51avxu/9FBk/MUDAYogM19DnS2ya1SHDJD0Dp+s9OUX03SO
 PG/g==
X-Gm-Message-State: AOJu0YwBDn8f2jn3OchF1Ke0AwevcAVajayxSNCLb2T52M6alz7A+ZyM
 H+xyiOuJVYiDAAEp+u5LfacOaWcKWq7dVJNlwrIOpp3e64NZHtKd06bcelA4HlkM6Uvg5baTM0a
 44hpHlzvyuO+JKW0tquVgKH0ng8NS8+k=
X-Gm-Gg: AR+sD12eHWXrO1r2ERM31t9gEMverqu8PmtTnQzMt5O8lta4jYIXUxwu/z3+GBeVaZZ
 YGnFLlv6ghCGgtWNev8ySbL0PVXabNe3pN2fqAqseKqggxlxRHggk+daFPAyezzH4+R+KWsgSG3
 k1bZYA+VKyzhhjInuGBNbkGuwQqgUK1hF8KSNmf96pkntpWw7Oi6ZoiKayXl/QDAyV3HFCn4Od7
 EHaum4fbU95gDowjZS7lIgYq1zE7PDTYVEuSSG55Vr/He6/ms9tIWfVDXcxASyRNv+H3F1OlC9Q
 dqBHb0FWzmCHEFd0GbWq
X-Received: by 2002:a05:600c:35c9:b0:490:9782:3eb8 with SMTP id
 5b1f17b1804b1-49573cffadfmr89335425e9.25.1784900482527; Fri, 24 Jul 2026
 06:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260724124220.24152-1-22925483+botszhuang@users.noreply.github.com>
In-Reply-To: <20260724124220.24152-1-22925483+botszhuang@users.noreply.github.com>
From: Nick Huang <sef1548@gmail.com>
Date: Fri, 24 Jul 2026 21:41:10 +0800
X-Gm-Features: AUfX_mzkR-JlXs9TM4M8AMyvrXPbVdOW-WzjEEeyNV6UeLYPuIi8HEZb5TME_rw
Message-ID: <CABZAGRFOiXdJxsnyvpDkD9YjvoO=mH1H-W0FUBJ_q1WcYnG=Hg@mail.gmail.com>
Subject: Re: [PATCH] fix BCM2835_I2C_CLKT
To: botszhuang <huang.botsz@gmail.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@mailo.com, 
 qemu-arm@nongnu.org, 
 botszhuang <22925483+botszhuang@users.noreply.github.com>, 
 botszhuang <botszhuang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=sef1548@gmail.com; helo=mail-wm1-x332.google.com
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

Tested-by: Nick Huang <sef1548@gmail.com>
--=20
Regards,
Nick Huang

