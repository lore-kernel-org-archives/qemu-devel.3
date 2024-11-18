Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765A3D49212
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD11k-0004fP-Lm; Mon, 18 Nov 2024 07:38:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD11h-0004ad-4d
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:38:46 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD11d-00041c-Sq
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:38:44 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-382325b0508so1476578f8f.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 04:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731933520; x=1732538320; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C1FD9QnL0UtPU//v+ntexYMaYyrPe1nPOrTuXV4cgiU=;
 b=Rh8FUcsByfxF/5AJj1A87CXNqDEjK4EUuIvTb8aveKeuYVkYpsbjaP8bWJuJjErjtF
 6PIvqxectQodNXKIMAVGNV3EUlpYpGS2vlYN7ASEy6F2z5K9CPHhXowT6a86tDv0Aarj
 SFYblYCpVtXUAfLWxb2vayb+xijV2E3eX9c0MIUq6XOcLz3crSwo0ns0c5R/BOrYojyd
 0Np4Xa2p+v05bcrhzdVn0AMOeOs8y9bFNRaR6g4f3kt98zHIY0+xA9sicvXx1p5L1IM3
 nk8sbD/vR2zOwpC1pdwAvt971JeiJaQGKD7Qh58b/hKxTK/u73pQp6gtdFz5OnuN12wk
 AKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731933520; x=1732538320;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C1FD9QnL0UtPU//v+ntexYMaYyrPe1nPOrTuXV4cgiU=;
 b=YqteZPS+IrquiBMR+4sg/2KFRviqZqjR5/UMM2pGjZMC94cN0dX1xqK2Y6SFQVXzwp
 e+5fJyKPrzK87HOwdnhFdEQpeoXAaXTqvC065U0M7l0yUgkD8PL9jO6whXlx/VFQVrgD
 h7dZZQ5Nu1HOKWX5cW2RdwjyYDvCAXiLehcljP/jDbsyefTdKW3yWYy0jvXKbiFJRAob
 ZY11+7jsE9NxEC0istn6x3wJUP+Za2tgKPamwB2QRmjEDVKJ7OsnJe++yy/Y3mTeyvT8
 7s3bMz2+vk1v+bAwpCF9/EH2KXv7rESY2btYUkZ7oVZUgGKMI+A9oa6I8V2yE0cFfNS1
 Ekgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRLQ/yRgX4R+3AZs+Pj+jFK3CCg45aL7SWJhghDAeLKs6pkh1gQaKYw1NCq1MHSoo51PoGWkYXOeYE@nongnu.org
X-Gm-Message-State: AOJu0YxGV6CJwh5ffx3CDTnytfmdGk0h9wJcRJ7wVoXVh03JxgGxzVlI
 viCpdOadFF5pCVAEqSgcguVbUDTqRkvX/PLw7EtznDMW2S4aQvsjrV2tNaRhsAQ=
X-Google-Smtp-Source: AGHT+IEvmjNSpw75uC6KjawHL8sv68pklt0oVar/JC/1Ow+F7N53DuLbGa6xURUHCX9XVRUK9HsTYg==
X-Received: by 2002:a5d:5f94:0:b0:382:4b83:d4c0 with SMTP id
 ffacd0b85a97d-3824b83d615mr74044f8f.3.1731933520179; 
 Mon, 18 Nov 2024 04:38:40 -0800 (PST)
Received: from [192.168.69.197] ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3824aad691csm945517f8f.1.2024.11.18.04.38.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 04:38:39 -0800 (PST)
Message-ID: <109b2266-90e3-492b-a562-7b2884c24433@linaro.org>
Date: Mon, 18 Nov 2024 13:38:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/mos6522: Fix bad class definition of the MOS6522
 device
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Cc: qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-stable@nongnu.org
References: <20241114104653.963812-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241114104653.963812-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 14/11/24 10:46, Thomas Huth wrote:
> When compiling QEMU with --enable-cfi, the "q800" m68k machine
> currently crashes very early, when the q800_machine_init() function
> tries to wire the interrupts of the "via1" device.
> This happens because TYPE_MOS6522_Q800_VIA1 is supposed to be a
> proper SysBus device, but its parent (TYPE_MOS6522) has a mistake
> in its class definition where it is only derived from DeviceClass,
> and not from SysBusDeviceClass, so we end up in funny memory access
> issues here. Using the right class hierarchy for the MOS6522 device
> fixes the problem.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2675
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/hw/misc/mos6522.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Patch queued to hw-misc, thanks.

