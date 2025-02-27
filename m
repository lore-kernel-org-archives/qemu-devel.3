Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E08C021B8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 00:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnS7M-0007D6-J1; Wed, 26 Feb 2025 19:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnS7J-0007CS-Gj; Wed, 26 Feb 2025 19:51:09 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnS7H-00027E-K6; Wed, 26 Feb 2025 19:51:09 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2234e4b079cso4334675ad.1; 
 Wed, 26 Feb 2025 16:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740617466; x=1741222266; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Q8bZXMLhhcmBHGsN34NU9PAndMI29LhpHM5xzUGPs4=;
 b=dW0mSBFffrjdT3oknS3TfjtupnI5+eM5Z4MDQtNXGmSi3AAer79Gq+mixxRpuqEKXP
 AlHQbg+7a97FIb6dCvZ+/GNvRxok4xbz62XAq2TXIlwCCzqCd3ChUKaT2okcTg07+JMQ
 OLn3EdPxMEX4sgmQL7F+Ar7TdMo00uW8jwYwv+5b2wNb/6Nteo8pWI8trGWb/LCqm8in
 lQt3kBAohpxXMnjxFK6ekh4R51xKTgWD0pnLgpdV3slKRiT+VkubfSyMV69GZROXWbdn
 XCNd3sCfxp16JzC0FTQYXjhuuvsrm3zbi1FLWIx0HalzTQ2ZjBzXctqU6Sff6wGCBf0U
 dMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740617466; x=1741222266;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3Q8bZXMLhhcmBHGsN34NU9PAndMI29LhpHM5xzUGPs4=;
 b=Na89uQwcuAtBgVTJaVSibSDnlxy+yj6UtvYQbveStSo1BceT7WlWUR6DyXwb/JKYaD
 zffgq97FmD4K6C466nFFSPX90mTM05dNnj3o/uAgeE7Lgi1CyAg1xImbHE9L2DCV00LD
 cGf2DLuzwWSZzFgSk0wZwxc8OP9Q4Qj6XwZJClwRz12AfsY+nAebFkNh7R7jOkh7/bC/
 NqTzxt/zFfcDipiwUvyidvaaKPmwfCT07+IUfsnyjtS6gFq+c3cU4cFnmtcc1YVDaAFN
 lpQ/Sxo6qUrtPlmobN0q4IxZUvk2F6h2dJ4VwqKop6TWJvpjalLpgzIaCmOwveJ2cELH
 ANmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDG7PqFeysYocHvfstD7Wnlqs6bBQoMyPgiYpnjoz85gYMsA2OwPniE143WiHSNqKfxmxjp5xY8/V+@nongnu.org,
 AJvYcCVZbD8h0Yr6UmL5QyRZmPvpyFrAoiu+5N7JcZ8LiqpRZwKNYlpnfAjEt9VzDJl24owkyNqQZqVu9B4=@nongnu.org
X-Gm-Message-State: AOJu0Yw/f5i1/zzhBD6oQfmykOSZSgxobbrBGIqFzfIrq0Og8/q8De0o
 UfOAfBIvSTv5U4QDyqvbVbXVonJyTUpM/FGFPyGj1aHyIspd8LksdenPRQ==
X-Gm-Gg: ASbGncvrhjLYkk77r2cCUg70AmhqBj10lLd9d9SVbWJrV5cz8bT9xLYokzosyVhCual
 Nm0xL1KjMXCvi2itoHWPj1MSIRVKLTurWmLFOTaroGUJHL3KTUC5GsmrYCUsSXqn/F51wdQM01+
 jk4j3sZJM3BKKZUA5B7KUAb2hYjX+6Ogg6PoUsTXRGLmuXBmCZO5bDpzhH/CH8qNLEjhPmo5xF4
 ixWWSE4GbXMVWjKcJ2xNsG3gmngIWnjGroPmCrZOOX2o5CzJ22Ta3cPejFZRBr+68uBw6JGy/jL
 LnwFCpTyAK7lyCkH6w==
X-Google-Smtp-Source: AGHT+IFspvlg+fPzriTMbNVElkpHxs1sXvIvvZTZpUObrKtOAFOq3Qe7suEnOhKZL+naCzlvVDt23A==
X-Received: by 2002:a17:902:eccf:b0:21f:6fb9:9299 with SMTP id
 d9443c01a7336-22307b69880mr134966185ad.27.1740617465545; 
 Wed, 26 Feb 2025 16:51:05 -0800 (PST)
Received: from localhost ([1.146.90.134]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223504e2291sm2605665ad.187.2025.02.26.16.51.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 16:51:05 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Feb 2025 10:50:59 +1000
Message-Id: <D82TE63DN8E5.1M16STS88RJO6@gmail.com>
Subject: Re: [PATCH 1/4] ppc/amigaone: Simplify replacement dummy_fw
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.19.0
References: <cover.1740243918.git.balaton@eik.bme.hu>
 <d9cec2b2294887c3849ee651e72fd31ecf43a935.1740243918.git.balaton@eik.bme.hu>
In-Reply-To: <d9cec2b2294887c3849ee651e72fd31ecf43a935.1740243918.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sun Feb 23, 2025 at 3:52 AM AEST, BALATON Zoltan wrote:
> There's no need to do shift in a loop, doing it in one instruction
> works just as well, only the result is used.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Resulting asm looks right to me.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  hw/ppc/amigaone.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
> index b02792221c..4290d58613 100644
> --- a/hw/ppc/amigaone.c
> +++ b/hw/ppc/amigaone.c
> @@ -41,10 +41,7 @@
> =20
>  /* AmigaOS calls this routine from ROM, use this if no firmware loaded *=
/
>  static const char dummy_fw[] =3D {
> -    0x38, 0x00, 0x00, 0x08, /* li      r0,8 */
> -    0x7c, 0x09, 0x03, 0xa6, /* mtctr   r0 */
> -    0x54, 0x63, 0xf8, 0x7e, /* srwi    r3,r3,1 */
> -    0x42, 0x00, 0xff, 0xfc, /* bdnz    0x8 */
> +    0x54, 0x63, 0xc2, 0x3e, /* srwi    r3,r3,8 */
>      0x7c, 0x63, 0x18, 0xf8, /* not     r3,r3 */
>      0x4e, 0x80, 0x00, 0x20, /* blr */
>  };


