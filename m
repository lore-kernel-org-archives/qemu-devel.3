Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792F9CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 11:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utOjv-0007K1-Jt; Tue, 02 Sep 2025 06:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utOjo-0007IC-Cf
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:59:45 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utOjm-0004Io-2T
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:59:43 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3b9edf4cf6cso4484193f8f.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756810780; x=1757415580; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sYSm3MALHXGITzvWOiv8N7/LI0WiPKeOPn+3WTtIWNs=;
 b=AQlVzq9czSxeb+xWbYzSeNhj53jnSezqRq/ja367tzQBI7w55ZMibwbl8nBrDU19/X
 V8qOqZoMwcldK8YrRR4jmCGyeyhfkOjTZaXubfEJpB5HKRMeiZ88Cfdo/c3wNr7eBFJX
 xxEN/tQJIADqVMUEx6EzSiLSWnmydGFyMt75hIIz0EVSucbVKmi/soRNmFMIdu2J4wkc
 MnNveL1c1BiSty+UBqfCEzEjgChg+bs5f2vsKtQtln3Tv4Exbi+ytb3FG899fGpZHths
 BoMI2wqSK8k1RvzSocGXRyhlQzz+9OoqM/jNei/PlTp2TRNlQAiroaLrnzwdMvQTU0LO
 sDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756810780; x=1757415580;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sYSm3MALHXGITzvWOiv8N7/LI0WiPKeOPn+3WTtIWNs=;
 b=ipt99ANhy/D5pZhaMLCRfZ41aXL7pn86lZ5s6Kl8bUwA9PMSuGxySQtvadJ2rx/TUN
 hQJ781CnuOUAAVLNyQpl23JdB2+SC8gwBxeqtHlJKGgzWx/LGg5WEykGewnUKI0YGmmG
 RGpWadVXl77BzKTbbNK86xj3cB1UMlsf8tOMW7wZoO6ajDxr2F+P7FjKrUMZrDY1mtuF
 GxJS8aQHsEzUL5hGNiSv6det9TAQt3L1QoplBFgwWL5RP2EMaHIUgBgI0QP3zleK6qIj
 Y17Ak8PKIw3tTBmPBI6EqzAE/SbCZ7JVptpI93PzK4y6YyD6OlIVKxc8tjH4DmBhPxfa
 LEPw==
X-Gm-Message-State: AOJu0YydI3/SxcArj+7omvCGBsHVAWZx1JPnxpEBSHPGmQnGCsNXnJMi
 mBKsvDVIcQhl5hK9VopipKo6JfSIqj+ZUtk3w2V5vHR8rm3px8rbqVyFX5IsZD0cVp3tszgzdbg
 8dzUN
X-Gm-Gg: ASbGnctUbHzyespWIBue0okcPwtEvID0Wc0f5ouvCtkxg17CWmMgWF5qZPWrwzmb6s3
 bdHWCaNUKeJSgOgdHcwnGnCcjitCzBh0EDfuUXoF0q3EvdwDZdx+21RqTZUF2YV2I/HOBShtlrT
 ApWmI66/UfolVeCzpo0bTJO5Ovgkvkk9pdSt31NKP41X7nZcxURLeDG1hVB055fsNmy8ZhFpaDj
 WU59vCHlsEVNlL6dMfq6CDHMzNOcFyp23N2EqE+cKBb+tMMKTKHvk4edwKUvFEkS9m+W8WtIglf
 qKjAiq7uAxWmcPz+OhNM7+0+IRyUk3Ex2acB43aAbiIeqKkqmKyyam6EOPqAnbpTzKmk475Z7AN
 Or7OphBjdzJCwmmMLe6+VXz7sdiJc0YnTATD91i6997Kjet2DZAnOt/8/lDm+SaFNgukw6U7vzO
 tRNs4+z3cDkJ0=
X-Google-Smtp-Source: AGHT+IEb1R1fWgUdPNYc8rfI+4h9Tdma1OwzjVWOrYg3L0hCbGSPM6rdbs/6PotjP/QUknCttXsGQQ==
X-Received: by 2002:a05:6000:1ac8:b0:3cd:5405:16e7 with SMTP id
 ffacd0b85a97d-3d1de4bc31dmr8088172f8f.29.1756810779754; 
 Tue, 02 Sep 2025 03:59:39 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf270fbd01sm19642567f8f.13.2025.09.02.03.59.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 03:59:39 -0700 (PDT)
Message-ID: <1a7c5f84-7cf0-4451-a82f-f6f5b938e2b0@linaro.org>
Date: Tue, 2 Sep 2025 12:59:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1? 0/3] linux-user: Select default CPUs for
 MicroMIPS and MIPS16e ASEs
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250814070650.78657-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250814070650.78657-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 14/8/25 09:06, Philippe Mathieu-Daudé wrote:
> We weren't parsing MIPS ASE in the ELF header, so couldn't
> automatically pick an appropriate CPU.


> Philippe Mathieu-Daudé (3):
>    elf: Add EF_MIPS_ARCH_ASE definitions
>    linux-user/mips: Select 74Kf CPU to run MIPS16e binaries
>    linux-user/mips: Select M14Kc CPU to run microMIPS binaries

Series now queued, thanks.

