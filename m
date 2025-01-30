Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E21EC0218D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 21:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdcPk-00039D-8b; Thu, 30 Jan 2025 16:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdcPh-000394-QY
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 16:49:29 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdcPf-0000lx-3j
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 16:49:29 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38a88ba968aso1158044f8f.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 13:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738273763; x=1738878563; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nm29mYN9Jr42gbnUnsXDohJEDT8Ir7p5dgMF2mhpF68=;
 b=RAZ+FYICnuKKR3o/5TpxvDOPRqhOoLXUv7b9xWzM1jxl1i88jJlLpaAfZo3CeTArFe
 gxHE1ZW6bryT3AjAZGReLgQQEukIPJywNCqj4b2gley8cy9E2s4gyGjaL+JmfZSILxZf
 KmLZc6JTyj8ZNFCExZDyKviq2h1MaLS9hpvax4t3r94eP02i6qs6u84yll2ZLHKUUa2F
 GB8rJSMAiYIZa5O8H0aZNGWQKYAm2SPPMMbkmyVzQCvtrRO9dc+eaeNEvYMPUvvZihYt
 5L+BZ5dTAHERDFdJGqn2i8WSRSbIWKqNuiFUDHXvkbkBNXXc1ubqUxp5tE4vhQxg9fP3
 gcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738273763; x=1738878563;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nm29mYN9Jr42gbnUnsXDohJEDT8Ir7p5dgMF2mhpF68=;
 b=igQhyRd/kIOK7kI+wbONCQ/Fh+J0GAWG2a5HKV06UVh9u62H2OZJuEN1iq5mPqk2cf
 NWxieteI2iVaSncygEJjF8Bff5SIR4GnsowK1cMw0aXFdetWAQvlBLxQmOudhEczQnTB
 nnQjmtWlEqGq4TX4q4EDHQf7Dhq3oq3pX4QNBajgio/QRP79sNxJCvvj7Vap0neu/x+c
 7xl0VxmmBEVlSOldQc9r/japiIe5iTWCh2C8s/a5bFVucIrOvXZfrp0Rr201qPl2uctr
 47KHEYs8+mnTnPMxGRrb2nXvVlzRnrUTTcAxoDIk8m0EggP1NpG4LsdeCAwXE4nwlHx0
 4UmA==
X-Gm-Message-State: AOJu0Yz0NcxSUR4vXF8uSlY2KMyrZXNhypinmlo2U00gvxFimKMTwESs
 rmzzDcxxh+uu12ZkoXaBaYNL9MXzuDzID7KkMCE0M53YgLn+PouMgwDqS8rjXp5KBl6jJYZ64GA
 HCHQ=
X-Gm-Gg: ASbGnctAEFtLpvuCZVo9goBPsKuOg9/M4oUPd0qeEpNsfHzor16BDD0glT75nrMpJAq
 yMTLrUlsyPknAgN8AnQV1oncaCZczrTkQxs2Um/CN289u/N9prcTRUPg9Ikx/Hg42H7QmQsuZUk
 q9WpZ9CmCopsmTR9a8ACT3xsmwu98BjB8Ll0UbTNMs/V1lkWttfgNo5YtHxkdyRbjx9WDGMPGHq
 gMNKtudJR8FJ1cPcnQUBAOoUyEXWdYm1Y9bdZ6cs3hgVm4tfzDpiIZP+43cuIzEvZ628w0cyyHL
 QI6kSX6B+twCt33xkZfh6wHr1dAm96IQ2qHcZSHYIoJpnPw2aogKJ+HObEo=
X-Google-Smtp-Source: AGHT+IH7/96/W3+1I6UyzmTYh0l42qCa4VZ0Ph1olT4fRPUlnntpW3+euTl3L14q5rkzzLkCFAmOUw==
X-Received: by 2002:a5d:56d0:0:b0:38b:5e14:23e7 with SMTP id
 ffacd0b85a97d-38c519698a1mr6878371f8f.23.1738273762950; 
 Thu, 30 Jan 2025 13:49:22 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81911sm70178145e9.38.2025.01.30.13.49.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 13:49:22 -0800 (PST)
Message-ID: <bc3a555b-48a9-4fa3-aa17-e6c1147fa38a@linaro.org>
Date: Thu, 30 Jan 2025 22:49:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char/pci-multi: Convert legacy qemu_allocate_irqs to
 qemu_init_irq
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20250121182828.45088-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250121182828.45088-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 21/1/25 19:28, Philippe Mathieu-Daudé wrote:
> There are a fixed number of PCI IRQs, known beforehand.
> Allocate them within PCIMultiSerialState, and initialize
> using qemu_init_irq(), allowing to remove the legacy
> qemu_allocate_irqs() and qemu_free_irqs() calls.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20250121155526.29982-2-philmd@linaro.org>
>            "hw/irq: Introduce qemu_init_irqs() helper"
> ---
>   hw/char/serial-pci-multi.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Patch queued.

