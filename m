Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D454CCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE1kl-0004K7-6a; Wed, 29 Oct 2025 04:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1kh-0004HU-QM
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:41:55 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1kf-0000EZ-Bt
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:41:55 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-421851bca51so6318882f8f.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 01:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761727309; x=1762332109; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SBvBFkeIedbY5IcBgnqkKR385QLPGJXyW68yoj9oBCQ=;
 b=sjweYyp/WgSbaUOc4pnsgnvZRR7LlN5q/KL68ariJEuuf/9WVnzyll1r7O4boz3mGe
 h3mQw4joW+/eebK4RLcTiQmhr4S1gZhJUGUcL3OIZxyd3YUlAiLNNGdAWCKwDfLe2YTN
 bom1KF//+oj/vszGDH80jv+Z22gXZDyoXW8b5MzibbTOXpPtEE3If963QgT0K/xmd6Vu
 eOEhu/f73/Uj9ibKQEy9zCZJPANtiK0LCt6f4ySeLtBYSwGP6LfOwHoJrzN8rVjTLk94
 O0MhJDkkI/DGM4UBo4dbrKpmH12Pxp/ek4L9sNwXBh1UqTGem3OHSuG2ySCq/RQO+Bpu
 /oTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761727309; x=1762332109;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SBvBFkeIedbY5IcBgnqkKR385QLPGJXyW68yoj9oBCQ=;
 b=G1Dwd8JNmR0jlOTpXwZMn/jz+BVDzrFutrKSJWQghy5GGUSmNX0gTSKQwXlqp4/gbc
 eI7QS+yBCVSRdT/aZVZUhzBJukJUg6BJh3WrPYQTEWxxeyQUz+sMotyg2ZAkne8Xa/cM
 M1k4iTRlxtkxzjEdC+nqyhy9cqyikzpaO03ahXn33yEwGt+MxzJ9CKMILhIvwth5KfNn
 8FcAhlS8BVDAmV2nxYparT7817ppTQUR5xoQH7BLq5ZhQiqMDsZK7tAiMgzlqcNTOQtN
 UQe9HCaKa5AVCVo63UGK+C/7NWdXM96xkh6H8z/3pnnBmVujoF08y4naoJ5Uh7PRxvD0
 S3kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDnOXARiB7XKg6uCazF4I2DgHBUWQhVXxsJopDLApiB1+hz2A3JIN72sjZ5TNbU1eYfJhry2zdLDRo@nongnu.org
X-Gm-Message-State: AOJu0YxbSma43kAp/LqJ4bOOAOUKFOmABRULNfTRR63qy0bLEiV+/mGb
 /qE7dz1jM7I1UyQfZBnkY0F6KH+j7mBPRr17RkKCAwJu/gGlZGkCLCy7dfNoalZS9tg=
X-Gm-Gg: ASbGncuTovJZ1q/LaPWIYl8KE+a9jAVerSJcO//bIKyxXFZNluGmmeSzMCSAm7PUjQL
 rl6nX7w9fpc4KRFAgU5v/t5IDtx2QwxEwIOuZ2OIl8URipgT+tUe7UHON4zP1+/1v9okH7aWSqW
 UzNEHbRIsULXakAeJHpajJi6D2QIpXlkRXdyeIxuE8h2pzPFM7MlfM2kVw6m4JvDXzw/Ahb5LWm
 /YdmvqcTL4izqwRw1JCO9htTyP3nBor/bsINkb0tbOINc9eEV2+iEY1JYgPyXZKNVSbjIgACXmB
 i/9cs6zF3LZnzEZsieW0MKYIliJ+w34l6B4kEMPkeQ/ud9vdMtajOPjMYjhLtfZu3RVr5tZsn8G
 2EjZ81sNkwZBZ0wIdvz+tUikn7Xqa/c+yJh2HlNwxut6a+JWt8BI5DOd0SEGTjFHcUfOzLl7nTa
 428nEGr1JpFoEA2GO+
X-Google-Smtp-Source: AGHT+IFbGvtx41Sh6WnxyLOoFeLAoTx6JQgLXLPNeBNjss3FeZF8b8GXB9uMkFDgmQuNyqA2ORR6JQ==
X-Received: by 2002:a05:6000:2283:b0:425:7590:6a1f with SMTP id
 ffacd0b85a97d-429aeff13a2mr1345069f8f.49.1761727309292; 
 Wed, 29 Oct 2025 01:41:49 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952df6b9sm25901687f8f.44.2025.10.29.01.41.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 01:41:48 -0700 (PDT)
Message-ID: <c45152ab-b42b-4320-a6c4-efd5ec8f3d98@linaro.org>
Date: Wed, 29 Oct 2025 09:41:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/25] hw/fdt: Use memory_region_get_address()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-15-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028181300.41475-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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

On 10/28/25 19:12, Philippe Mathieu-Daudé wrote:
> MemoryRegion::addr is private data of MemoryRegion, use
> memory_region_get_address() to access it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/i386/microvm-dt.c          | 4 ++--
>   hw/loongarch/virt-fdt-build.c | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

