Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88D2D5AE7C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 10:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8zNA-00038S-KP; Thu, 07 Nov 2024 05:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8zN8-00038J-EG
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 05:04:14 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8zN7-00066C-0D
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 05:04:14 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37d3ecad390so1080478f8f.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 02:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730973851; x=1731578651; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6SsF1BcJr9O/rucTSzyxboNr+7KKvW+X/noKTJdP29A=;
 b=ZyAXeEq5fAT6reHkN3ficLK+9Aahn1Smz3Ydw7ATJr2Uip1eU7QV8G2P6Z1AkmwOjn
 U4Y3aRMPoo8qJw6rwOjsaJCz8MESwFvQ+QBfnDEfw3nm0QZm0T/Tv3ACFsPr1j6N720v
 k/uBrmw7NQW5YrtCOQzGE/9SbXcb1WtpyYatPDqfK9ihHmBnOmyEl1pKqZU9hIWJjs3n
 7IA6/GisWhTEgmkVOB9rvgJdSxn8bggDKJznE4fzR/FZSWtYz+v83Gkl7KPdYGbg/b/G
 ZcfOAbtMLGJm6whnW079ZdtmzarMwRU9sX2DxncFxg9xBpT7W39TGZWmhn1WvnOVwjha
 3xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730973851; x=1731578651;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6SsF1BcJr9O/rucTSzyxboNr+7KKvW+X/noKTJdP29A=;
 b=MbHsDftDeVKsI1uWhHZ7iZKVKDLVYRxjoArDgdOWw7XVyX7qECPH2ZaB+d6tFVSVnJ
 lGF2GCrlANR5Al0UUPMpXh8XITWXqNIRBg1QBeum4CRip28+HqxbsPtUTgtEB2Tqhy8o
 yCjAQK7GpKRK65Tw11nqhcnGZ4gAJJV8ys8km9RbwDATAn6zRh1RYFEFIKwLAJZdvrT/
 bfO2U1RXUQbSA0qo9JnS60lVIflfl1XD7bAv86fRgx9XhzopZpjm9ynB6UrWElKJlUjv
 eGZ2chtsZ58bboSeESo+gHnY4H3WlpZXLVmCABz/giwbR+gfQKCi/FDSpC8IRoPlLVab
 sweg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEN8mF9VH7MIrUSrjuGPmwMAMusc2N9huIjYuzBsanNdjWVoIithfwRakHVNv1S9GCm0pvwYD0Xsyh@nongnu.org
X-Gm-Message-State: AOJu0Yzdv1zde+EYXFoh8d/JTCtndj1UJzEJxVNJFV/h85+1LXOHgdl9
 al/sZHJAxYpE8+OYW210eW9j1X+F6jZmZOEJwG+8/463g5A3ifTYVxVYqpbwNdsRT3ptxPUvTNF
 tlGY=
X-Google-Smtp-Source: AGHT+IGRGHnOBpBQU0krlNgZNw6SZd+mlJF+W10BnxehdOAVUVj8h8w08xrT5wUZWDcKAX3CUfJ2TA==
X-Received: by 2002:a5d:6c6d:0:b0:37c:fbb7:5082 with SMTP id
 ffacd0b85a97d-381ef75cbffmr520596f8f.25.1730973851330; 
 Thu, 07 Nov 2024 02:04:11 -0800 (PST)
Received: from [172.16.23.118] ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9ea6b5sm1293276f8f.84.2024.11.07.02.04.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 02:04:10 -0800 (PST)
Message-ID: <45c72335-28bb-4c88-90ec-c6c03a963b2e@linaro.org>
Date: Thu, 7 Nov 2024 10:04:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] hw/sparc: Mark devices as big-endian
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20241106184612.71897-1-philmd@linaro.org>
 <20241106184612.71897-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241106184612.71897-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
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

On 11/6/24 18:46, Philippe Mathieu-Daudé wrote:
> These devices are only used by the SPARC targets, which are
> only built as big-endian. Therefore the DEVICE_NATIVE_ENDIAN
> definition expand to DEVICE_BIG_ENDIAN (besides, the
> DEVICE_LITTLE_ENDIAN case isn't tested). Simplify directly
> using DEVICE_BIG_ENDIAN.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/sparc/sun4m_iommu.c | 2 +-
>   hw/sparc64/sun4u.c     | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

