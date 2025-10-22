Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15BDCCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBeNr-0001OB-DQ; Wed, 22 Oct 2025 15:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBeNo-0001Nu-Vg
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:20:29 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBeNn-0000mS-Ap
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:20:28 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42701b29a7eso851848f8f.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 12:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761160825; x=1761765625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XvVAVwoiI5ujDrd3pakXUUAhOuihFGwAdRS3HMm/RwU=;
 b=u0kg5AUq+ueJLGqZgljYlRP2x7oDNmjydybtolYd0kIv7qp8lsyPfprDEHyfRhhC7m
 +jCHJI507oyjomfBQh6076LM8SjBLhn1DmM2TybK6iSD20WJ+oCEb+qUaRIK2xK/tAcr
 ZL+XQKVEezW+nILeKsjXMM1N0J6o69cAOPaDrjBCGOgUCRGwCiehB9qTWU0CiUYQKBOQ
 7yV06IfTZ5amWxoOdg1d2a9mtjM6ZnJLC+bIkWN91w5sANo2/rpmmUFX5hup0bktYD9c
 i2v3nQ+wpvdcbkHzzIhiDkkILFSw2AxiRfYrDszIcQtH9j1tMmDBCFon3Ffnr0gsabP1
 xL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761160825; x=1761765625;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XvVAVwoiI5ujDrd3pakXUUAhOuihFGwAdRS3HMm/RwU=;
 b=Tq9jN4WZVSi0sb5bQyHJSxoshxrB3OBXFlM7b3z9j5MdVk6yKhDvbkFBty0ejE0qI/
 2SlRcwXFxU04mi9arhKlSFQvE5SK2M/jNFfi4Oc3fLTxmADQZg3+yIvnL72aAXk1gzda
 4nLdQKLqmnSufHK8Udp3tGhRtdjpP4ID8sYw3zxm1DKD6DomoSVY5l4qKGoSqLPpayaf
 as435nQD1Ze4UBoqf5mxZu+T44PYbZScKCHaP+jDyOlHL3Zo7w/UCVt6pDIRblso1nk/
 bkdVe9Zqeel6K7GaIS8LrjfOVbr7g0wmJbJgs3aunGuddB6f8CwrjippGn1ipHgzPMj5
 LGBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrXopZRY/a7KEmESuFuI5rcPSHFLVeoUmheEITkhcjLpUqu8jZtykP1vDxydp18p2jzGLnWqSMKahH@nongnu.org
X-Gm-Message-State: AOJu0YzrY3GRoY3bP51UqxB1LGs2PZe7G2TvIZcerytpoV2KgxwxvVu6
 iukU4QvLawNERsKQc978xaHcYtOT5iYk4SAyIJj7nU14VSwHSo1ef5J9kXkmtoWTKx8YwuKe1Bm
 BW8nYp9o=
X-Gm-Gg: ASbGnctBMTcfy0GbnkgIVXpPrys/s0uZJafqyxxoBNvOhwIGC0LONXYBvCzs5fzTLbH
 aLMCKf+uprjgi6/ovOwRJ9nhi/W7Gg7l1dE2SB/TwcWcdPZQX+4fkmkooZVHaNMWiGDT2vICd5s
 n38/DJy3U/QfMyYDslp5p1G55BhjzjCy+3h3yrXn3tvXbGS5cnadhDplDZ+TF3+2Q7xE3VUO+N+
 pY3/qIl6uCzK8FArSzOuWEiyrVzU/P9og0h70oOZtkpIBg2TCiA70+XKAnegXcAgVh0fje6qyGe
 nnF80hjXI36YZnf4UKkILov3SUSAcArGfVpAYpAmnoGRoCmItedSxAK+dq/RoDtgprNbDO/AF4V
 0QFxrR96hzcLml90ADLJ1uOvnlLaQtpRp/8bi6GyDV1qCzSv3hdOKg1YX/1dzkeOELqjdgLPpYx
 6ZwSh6/jZbSErK8/jyXYF8FDkxkM7KsBXwQeZyqvtlWcc=
X-Google-Smtp-Source: AGHT+IHq8THmx3Vout0w5cw9t5E43xxOob/pZrhwUFYOzf1iInrdgqA40JxVyqtR2jyMUpIHG1tF/w==
X-Received: by 2002:a05:6000:310e:b0:426:dac0:8ee8 with SMTP id
 ffacd0b85a97d-428532554b6mr3740572f8f.10.1761160825333; 
 Wed, 22 Oct 2025 12:20:25 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00ce678sm26683017f8f.51.2025.10.22.12.20.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 12:20:24 -0700 (PDT)
Message-ID: <e9a945e3-3280-4c25-82be-557c322b3e5d@linaro.org>
Date: Wed, 22 Oct 2025 21:20:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] ncr710: Add driver for the NCR 53c710 SCSI chip
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
References: <20251017200653.23337-1-deller@kernel.org>
 <20251017200653.23337-3-deller@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251017200653.23337-3-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 17/10/25 22:06, deller@kernel.org wrote:
> From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
> 
> Add an emulation for the NCR 53c710 SCSI chip.
> This SCSI chip was used widely in historic machines, e.g. as SCSI core
> in the LASI controller in HP PA-RISC machines.
> 
> This driver was developed during the Google Summer of Code 2025 program.
> 
> Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   hw/scsi/lasi_ncr710.c |  303 +++++
>   hw/scsi/lasi_ncr710.h |   53 +
>   hw/scsi/ncr53c710.c   | 2477 +++++++++++++++++++++++++++++++++++++++++

This is really huge.

>   hw/scsi/ncr53c710.h   |  270 +++++
>   hw/scsi/trace-events  |   33 +
>   5 files changed, 3136 insertions(+)
>   create mode 100644 hw/scsi/lasi_ncr710.c
>   create mode 100644 hw/scsi/lasi_ncr710.h
>   create mode 100644 hw/scsi/ncr53c710.c
>   create mode 100644 hw/scsi/ncr53c710.h


