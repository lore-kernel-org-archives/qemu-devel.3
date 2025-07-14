Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989E1C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 22:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubRiz-0007Wt-9x; Mon, 14 Jul 2025 18:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubQoQ-00033m-Fd
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 17:34:15 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubQoO-0001l4-Ex
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 17:34:14 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a4fb9c2436so2887847f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 14:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752528851; x=1753133651; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=od9WYTsloOatPqWwjiS3jmqklVQjCvEdJgRfr+o+36A=;
 b=uhsgEGKE4aX2xfGPMuMWezeob7otK8ohhnVoxCA2s5IR/JvuzUXZSB6x13n+Oh9WlU
 nX492H57JShrhFePC5LJ9ZCP+FtWhtfi1DpKQY/82tBJx7jyItjQyzeE0glHVzgYlZDY
 XuID2ZEiR+12lOG/W8utfU9bEF1G1j8pf99/Byg9yYV2gtFHZ0XMeSiV77voS7TMn+Qc
 DTWQhzpneCqOBCIWh5RLbdwGf/LNnoj/ZHoa2gzpJa2fSCwX1YwSL+OO6eeVSjwmMG13
 cOJ2qk0mxwNVXrFLL9N51+MK/kRPhSf1c3YTjqxGwX/i2IdnXmXNYCiBwAGeqBQab0pH
 ZChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752528851; x=1753133651;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=od9WYTsloOatPqWwjiS3jmqklVQjCvEdJgRfr+o+36A=;
 b=tGLGocXzVEsBQl5UKPoCLTD0cjPhyf2ZwDmxFWOv7dBqMiia+Kz8bclGt8hZfhPIIH
 moJVijtq7TUcpLmWFXKIlaJv8gOCr0c+8wjGEjbf0kbiacCEhkvQE5H44sX2APpiNBYw
 8TxgHANnReaAx72KZ2ubn8lRzMMvwSPFaKwOH+gIRVqtNJ8s6ncWYVJadgGFmjKG8fKx
 R69BI1dydxzWppGEq9G2bhy8ngej28pMmnF3vNRCseht+M63pdn4seULGGB/LuWfixNk
 u83H6F913bNwfp/nTZl2//iC3GsIMCwPY47aS67m/bXxYypHbSRPdqqidUHy00Lfp64i
 xLrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq/07apFQ8J0m391omNVUaB7YkDLVqcbOzQ8LsLaoR1wiPS4YgZLEdGkuWQpyHBaidqTbMt8z4uhkv@nongnu.org
X-Gm-Message-State: AOJu0Yxp8WlVpj2OG3n5RzKH+n6rxZFG4Ea7QaJ1K0sWaX0uBnzZ1rK6
 a5sKHCDI1HlSzR5T4AHMQj7a9wImQYqxin06GD4MPevHGzyJ5dB+16/mRgpVvnH29Vw=
X-Gm-Gg: ASbGncsYcEgcYLkgMrqU6P7pmeZWe1yZy3Jy+0n/O+/VWk2F2KrLyYXYYHCF7dVjk2y
 Ytx+KYJ+qdJv1ls+/TWYVuY7/RDkM+Sk6Rj0Mf/Fs50tNSnk5JwSFoacIxmqYZIIS4R+7AWh9Jy
 xHiG3u/s8zkRYVfvGCOG85tO5vXJdzUfo6LssGuH5YO8rcWvqG+ZETUzuYSsZJyHU58siwxm3d6
 klpwWesOWXswcvsDGmf7ee7q2xAg//B3WuAv8dq8tWKcZ9S9lEk7727H6VjroYOxKiF8h4hrgyL
 YqAJgIcJUCLGc63rX/uOTPggF3i5QWlH9W6IP5XE/rPYdc1kV5uH43Zwa20KjcB3bkzTBRrknOJ
 dU1CCCKUQ2MzzUtIbYlxgL92cUxc2ewGtH+PQsdlcNRvvHnU/naVWPmBPZygVS9bbJDf+ns0=
X-Google-Smtp-Source: AGHT+IHNDbrd0j3raV/rZCWS3Vy22wPpDmdb5x/iYv3fDO53ymA5/ibW5yqlcpBUclHuw1uWCAdbjQ==
X-Received: by 2002:a05:6000:471d:b0:3a4:dc42:a0c3 with SMTP id
 ffacd0b85a97d-3b5f18e813amr13800774f8f.56.1752528850660; 
 Mon, 14 Jul 2025 14:34:10 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc1e4fsm13254124f8f.21.2025.07.14.14.34.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 14:34:09 -0700 (PDT)
Message-ID: <1ef61fdf-c151-4d6d-bd90-240b3462c2e6@linaro.org>
Date: Mon, 14 Jul 2025 23:34:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] hw/microblaze: Add missing FDT dependency
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250708204806.1898-1-shentey@gmail.com>
 <20250708204806.1898-2-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250708204806.1898-2-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 8/7/25 22:48, Bernhard Beschow wrote:
> These boards ship with a bundled DTB, and dtc will be required for generating
> these from device tree sources. Prepare for that by adding an FDT dependency.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/microblaze/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


