Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15626C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 09:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJUKY-0001q3-AL; Mon, 26 May 2025 05:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJUKN-0001pO-UN
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:41:07 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJUKK-0005uD-Nn
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:41:02 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-443a787bd14so22087655e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 02:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748252458; x=1748857258; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o/3OyUiRP3KARuilfO7gfosU/5cLNdYR8AB7wqy3SX8=;
 b=Vx3pHdD1ulAckp3lEs05E/L9tcEij2BciLJhFGdZHcjTqde3LZNQ1+f+jCQkFU2iB0
 3mTAvG5zxpJj+Hazvp1PqWXCVLS1StH40L22B/icRr8o0PWvJnmE3ZnLgGVwyZv1g1WO
 1Tn/6UiyCXY9bCBoRz2iR7pJIznGjsGQB64VNNcA6tqG7mw2jA6/nsjykHX0YSBfm+15
 17rJJRG9rxGxFMXmayj73zz01smVcOM9PUh1VLz9B7+c/oMYT67A12hZQ2u6SaHUAUkO
 AbwjyuKO5B8LlSsf408NDaZPeDp25FLqWV6acDwAOFzx9qrLhqQvqt6TyN3cmg6KUIVr
 x8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748252458; x=1748857258;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o/3OyUiRP3KARuilfO7gfosU/5cLNdYR8AB7wqy3SX8=;
 b=DYF1g18cAG/OSVF4jHBhEzEHj/h6bcH6ujn2BPqowp//MdFiDzi9yWhVOTcipnqlKa
 eBDWZU3dlSHqeNbH1KOSgxk3eIkYTpmrQxpOgL96eRAYuUzQTNIIUeiQplhG+0U8lRR+
 Zdc4XGw6m/vAn0b5lmMG86qw+0/ilDrRwJUYRlQU/TlMmcB+Aqhz9onQ4zmKDiumifgn
 tthqksvF/Rl4eoUqRkDyrdEDYCwiVG6FnmdSnGyKM2+fb4IT6Pdp/JAdV4d8BN/yQABK
 NvW4mD3GoaEm2WERkM9vLZOdbQkgHwZu+kDU7PN/hqmPeizja6UtGnwC90mKA4GDk90b
 BPIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXx47mjS1CVF638rO9lw26K2nlr3wvCasj7V8IvAHsunHwQZl9ZoG/R6GFNCudHDagdU3feLxQJYMcW@nongnu.org
X-Gm-Message-State: AOJu0Yzut6y/52AQqFDTmzanJ1sflLRMFDtYpYtDBPyQuan7A33bMSGa
 442EKNFBFgPi/kjb4pwFOwOB2/1KBi5+Dy8Nae2g5mFHpamagsFeAtrJdz27LwGkBT6akrXabXP
 iXm6QnFHXWQ==
X-Gm-Gg: ASbGnctrHxf5qPzJbKHZn9p12SoKSz8oqt/NG99OTbPeRPflV6i5skP6DyJV/JIX1NI
 o0d+k4Bj4zLCfGm4G7CJipClMv+rNaLq4xEIH2HE32MtagYYZXLhElCVJdgb9OMGLCGDBqZrY3v
 nxKGONf0CfycN8uXAGEfZSyY7oOTeV5V6ukaBuR/hbfh50WVwBl5Nj8Z1V4SyulBgE+StHPyZzo
 BYPqxRXAmmDt9/bvTE41lJSRaWh29LaiRJI1b00/km2uCvmjxTViWDtGubtm/G1bdriuzeqpfj9
 RJD+bKJK12bOLs2cBOkNbhBZSyzN7ppRdnenjYNgNkU6TloLyeImz4sA52oUWl/1BfmV8+PMpud
 y5VzQJszLRaLLRecxEofktRJ2
X-Google-Smtp-Source: AGHT+IFhicBCthYJQAvwxXA5E02ITMNsKYRLOb/vGGc8TZRGsLQ4YbWn7qVg/fPJBjZHnDfTJggdcA==
X-Received: by 2002:a05:600c:3208:b0:441:bbe5:f562 with SMTP id
 5b1f17b1804b1-44b53991a34mr82242695e9.16.1748252458311; 
 Mon, 26 May 2025 02:40:58 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d37498e8sm4522577f8f.16.2025.05.26.02.40.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 02:40:57 -0700 (PDT)
Message-ID: <267060e4-f7e0-4540-b701-11d1d650ec25@linaro.org>
Date: Mon, 26 May 2025 11:40:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/block: Drop unused nand.c
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
References: <20250522142859.3122389-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250522142859.3122389-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 22/5/25 16:28, Peter Maydell wrote:
> The nand.c device (TYPE_NAND) is an emulation of a NAND flash memory
> chip which was used by the old OMAP boards.  No current QEMU board
> uses it, and although techically "-device nand,chip-id=0x6b" doesn't
> error out, it's not possible to usefully use it from the command
> line because the only interface it has is via calling C functions
> like nand_setpins() and nand_setio().
> 
> The "config OMAP" stanza (used only by the SX1 board) is the only
> thing that does "select NAND" to compile in this code, but the SX1
> board doesn't actually use the NAND device.
> 
> Remove the NAND device code entirely; this is effectively leftover
> cleanup from when we dropped the PXA boards and the OMAP boards
> other than the sx1.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/block/flash.h |  18 -
>   hw/block/nand.c          | 835 ---------------------------------------
>   hw/arm/Kconfig           |   1 -
>   hw/block/Kconfig         |   3 -
>   hw/block/meson.build     |   1 -
>   5 files changed, 858 deletions(-)
>   delete mode 100644 hw/block/nand.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


