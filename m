Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C55C1D5AE7C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 10:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8zPg-0004Fs-5P; Thu, 07 Nov 2024 05:06:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8zPb-0004EV-3n
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 05:06:48 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8zPZ-0006d1-HU
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 05:06:46 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43158625112so6902885e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 02:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730974004; x=1731578804; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1dz191DCPMR9xtW9f5iRKot5gr/U3qIkbBSgrymPmlM=;
 b=BtxAaSCVg+lB+YNfMAz4WgOzViSD3wWyXlL6HYAs+u8wGT7z6Lcj/69TxSOU7g5XKR
 oic807Qz1Pmy7DZ6MKRQ+7g3Ch2LjZIeKDDr07XDOG8sjylBBPxLt0cy90V5XXC4wnQH
 9Dj5KOuQStBpr2Ewgi1/X9l7FgpGwFU0MqIQzXfcDweOjO3inAEgM6AoFCi/92kc8xt0
 oQka6PNLk91QbcjegZM/JtYP8GeyPP3GwmyTxdhx/663GyrlDyI/W2fH0vTsuFsD7V0A
 QwWTT4Iy3ce3rbLohj4o+Bgf7v1AoZDXPTuUApv6xCJfHa8QKfKaDSJRJlriHPp73xSw
 jn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730974004; x=1731578804;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1dz191DCPMR9xtW9f5iRKot5gr/U3qIkbBSgrymPmlM=;
 b=d3NmbRzfiqy1VBCRYCfXMC9edbg+hlXxatse2JiRmj0pkBLKXzfomf/4gKBJ36o3MJ
 kuZ9iPuqVqbYoduLMkCIEw5ayX89Z/XDihkMk+x30TncjiKG5VgnI6tx8mc8IBP4RnfG
 TQhl4pXCdv71ix/cNn6x9NnPe0Uo8PoYCL3n6G2+HT7zI3e1cKyln84Yh+OV6y+YIwSJ
 wKa8lHDJFcEviK04WQhAM6zWkJEufBCCJ/GqT9cbgON2XlXOkZGwixXZPFew1QVSpmdR
 vh7vEYwsHgPItd4MkbjyXcgEtDw0sArM2AGbFAutS5yBj9328PXxf6ran9Fpodfw1Oxq
 GOig==
X-Forwarded-Encrypted: i=1;
 AJvYcCU72hK4af6Yuq9AOhmW07v9+CusvFr5j4orKU0gdn+0FUKkKACsriblbRM8/crXqWKfYqWpHToevd6x@nongnu.org
X-Gm-Message-State: AOJu0YxcwZbTyL+KfoGTJF0sgZocW53nzHnXF7sbbq4DL2bKPl2hdr+L
 CA9WHN72ia1boh4C3P0mjiQD9cXSoBQvccbB8VT+0uqFhiNoChESU/Cq7IQm50A=
X-Google-Smtp-Source: AGHT+IEK2yRaSQneinHYyyDgBI8KnFgvSoPY4J/KgOtU0um/VWcRjGx/5cB2nkv2v9StfbEjc6/yag==
X-Received: by 2002:a05:600c:3b8d:b0:426:6edf:6597 with SMTP id
 5b1f17b1804b1-43283255a89mr187489445e9.19.1730974003815; 
 Thu, 07 Nov 2024 02:06:43 -0800 (PST)
Received: from [172.16.23.118] ([89.101.241.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381edc1104asm1224066f8f.88.2024.11.07.02.06.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 02:06:43 -0800 (PST)
Message-ID: <cbcd1176-399c-48bf-b47a-17dc640fc4b2@linaro.org>
Date: Thu, 7 Nov 2024 10:06:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/16] hw/microblaze: Propagate CPU endianness to
 microblaze_load_kernel()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
References: <20241107012223.94337-1-philmd@linaro.org>
 <20241107012223.94337-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241107012223.94337-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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

On 11/7/24 01:22, Philippe Mathieu-Daudé wrote:
> Pass vCPU endianness as argument so we can load kernels
> with different endianness (different from the qemu-system-binary
> builtin one).
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Anton Johansson<anjo@rev.ng>
> Reviewed-by: Alistair Francis<alistair.francis@wdc.com>
> Reviewed-by: Edgar E. Iglesias<edgar.iglesias@amd.com>
> Message-Id:<20241105130431.22564-9-philmd@linaro.org>
> ---
>   hw/microblaze/boot.h                     | 4 ++--
>   hw/microblaze/boot.c                     | 8 ++++----
>   hw/microblaze/petalogix_ml605_mmu.c      | 2 +-
>   hw/microblaze/petalogix_s3adsp1800_mmu.c | 2 +-
>   hw/microblaze/xlnx-zynqmp-pmu.c          | 2 +-
>   5 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

