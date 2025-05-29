Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00716C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 18:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKiGz-0002w0-Uf; Thu, 29 May 2025 14:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uKiGw-0002u0-Po
 for qemu-devel@nongnu.org; Thu, 29 May 2025 14:46:35 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uKiGv-0004fr-8Z
 for qemu-devel@nongnu.org; Thu, 29 May 2025 14:46:34 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22e033a3a07so17915165ad.0
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 11:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748544390; x=1749149190; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lUmw4m9w2rOwm6YWNk6mdQNQwI2f789XprUSxNld8T8=;
 b=IgqF26EO7EefKNu2Rkdi9J7uIGB4JE0fjijJD15JL3jz8ggmngfMbK549WlBej79kr
 h6jieL8IxQeJMYP18UmZx8JTxpSjS/Q+gEIF7w4CIqOlhxZhVCPYv8uYZxefyVKT7TQJ
 5E+GiUY7/CDEdVI5ZsUZh8DE7E6PAq3eR2+DNthKCFV9kdL3jY5BaeCagVIX1f2XBmPE
 mpH6QUrq4SZs3Fw1JMDTXbeyg31HXlVWn7S+R2kjrNKQkm318chFMIMyI//mGY8QRks/
 oMzIQik7yLXOrivg+Li5B/PQwp1q4PWuIcmrPIrLEqiIBYcXwJ3ytGvdU7ILSgKwt8XG
 wjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748544390; x=1749149190;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lUmw4m9w2rOwm6YWNk6mdQNQwI2f789XprUSxNld8T8=;
 b=tGn0RzfkFX/r3PsOXxbB1xfjfYknx4Aqx7QTcKApcvSryzYQ7/Lhtvd2VRqHwbpu+p
 +faQTgLHPX1qwn6HP19A9p/Ik11B3FueZhff/Sve6Ln4HJDPPRUZWuEa1iPnE8/gxZd4
 TLQUJV6yIui0LpsB4yL80qWu9E85lPWi95lEvepetjMO0hIfD0ai8rvcJVcGlrbpxA5G
 H4+VZh6v7nvSyB9McaGrVnFFrLO9RtObLonS/s/aH3VF2lnz9rCCcPKDerOJxUyZ3nio
 zzdJAoNT0GtM/0r+Y324ihjYymWpe4g8UvMWABR8obbiX8QuT/1MvTB/LtqfwB+HOlTw
 9paA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyam6d/09D+ILGOY7TftsQE2XaVJKXvc5pa1fHP1WHrpsyMT9alWyIBQKM1lEkBLFx/brzjnGoH1kD@nongnu.org
X-Gm-Message-State: AOJu0Yy6mFWjRvS5v+nFt/Qz7HmsaCxqBfwwIGM7PA8ijxoq0hEncDrk
 mMazRaSfTKYSkQuC7IO1p9SIwGQO9STPIWcl3FWZEMmeMmrZ6Qa8k9GnklNZet2XKac=
X-Gm-Gg: ASbGncto7bFhzZ+oALKp5oeFKOVZ0gf+QADjgc0MTF4otKviJgJOvcrIbHig1Ut/TfJ
 tu8/YZrjoC1v21mxJryZjXg8GlNroF+FTk3lUjG0f6LlWYiPsDjUW9pU+6WAtYIDEEq/duERp2h
 3zqDhgw2DClNBLKgMWFKl9Huemxh+ne20+jkcZZrU2GHA5QntPSesZgU9+RFFeNQo88y5Zhsln5
 NVwHDi9oV3awlkXiDRiYIGvywj+AxJ5caf9XjDT4YsqR4BUYJhyggQHQ3LHAc/E1PtiRLbtQM7O
 EF7hZ1bdYj6gPVEYp6sUreoO9TcE8INsjcoNhZm9vjmdJsI9HYZoYmQMKKcpT0xE
X-Google-Smtp-Source: AGHT+IFh8f3GJuGvGyeItt6rZRY/x6kkZYoMrFO0btOg3ZrIahNy0uO+qlX4iomjQQAlRkR3h8ZMPw==
X-Received: by 2002:a17:90b:2dcb:b0:311:e8cc:425d with SMTP id
 98e67ed59e1d1-31241506d31mr874199a91.10.1748544390572; 
 Thu, 29 May 2025 11:46:30 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3121bdc7328sm1698432a91.48.2025.05.29.11.46.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 11:46:30 -0700 (PDT)
Message-ID: <ff108a5a-3084-40ca-8167-3dd9068de5c6@linaro.org>
Date: Thu, 29 May 2025 11:46:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] plugins: Add memory hardware address read/write API
Content-Language: en-US
To: Rowan Hart <rowanbhart@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250523020344.1341179-1-rowanbhart@gmail.com>
 <20250523020344.1341179-6-rowanbhart@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250523020344.1341179-6-rowanbhart@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 5/22/25 7:03 PM, Rowan Hart wrote:
> From: novafacing <rowanbhart@gmail.com>
> 
> This patch adds functions to the plugins API to allow plugins to read
> and write memory via hardware addresses. The functions use the current
> address space of the current CPU in order to avoid exposing address
> space information to users. A later patch may want to add a function to
> permit a specified address space, for example to facilitate
> architecture-specific plugins that want to operate on them, for example
> reading ARM secure memory.
> 
> Signed-off-by: novafacing <rowanbhart@gmail.com>
> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
> ---
>   include/qemu/qemu-plugin.h | 93 ++++++++++++++++++++++++++++++++++++
>   plugins/api.c              | 97 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 190 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


