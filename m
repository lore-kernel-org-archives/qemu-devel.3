Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C129FC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 22:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhbVI-0004yg-QG; Thu, 31 Jul 2025 18:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhbHu-0002Oq-1M
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:58:10 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhbHs-0003zq-9k
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:58:09 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-76bd9d723bfso471447b3a.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753999087; x=1754603887; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=avucBA3ZazYATof4kYRCYvw68yQdsd0Sn1KnjhZENn4=;
 b=gRjUJEW3YBHfS8LVDj1kXsiaFBDMAVY+hYLk7DFeBQr4OoNwh001Zcg6tAmMPO6uFh
 7tLAmflLuSbHUBFk/L7amiW0D0brmIt5Wy9ZBUa0mRTtxK+qYDMX/VEcfdRe+ToLuq4X
 98D1j4BAMHtPMUkxezAmqAyKMmoe/NRpVqh2DREY/UEjNg+WoXFPOKick2jzKth3q9Z+
 X3Bq9VKYSIjg1ef7i6jPb74l52TDson1c6o0WmIsdsqKcdDhPKNpmwxfsFYdShJCHx/Q
 oLjpZMegDh9k3s3X1zlMSKc9xQ0sKIfpQQb7Idxe6gyLfz2V0wrGlwN2E5nOukHyHafV
 AlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753999087; x=1754603887;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=avucBA3ZazYATof4kYRCYvw68yQdsd0Sn1KnjhZENn4=;
 b=aaaZwKUCzLXeDTBpIaLa3dJkFCvEHKfOxXOD1hzbF2GNAgigXxlaTnHU1IyV2JoEia
 tP+jiTWr+zpdrIXjGHhIOWSw6684yT+WfdNASCw3OEqQ0pMI9YPRf80MOP3YxQ9kqlQa
 OgNVsFPRyjdjIVUYwXRvvZAwPyyszPq97LO1o5+w8ekoTOf3TtMaC1WtuiLyqInexdb+
 aqDNpzhoL+tVPGEuBONsPJBqdJRa9PuXeX1+PY3J3dB6sjDOIjjGfT27jTb47rof80xw
 JkNRNA63Mvt0ResIS8bSr3wZuAkYTf8toP9dfY5uk36LVr6cQbiQzcS7TQamBamHWlxA
 MMrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdMGx2t2ubViomoTP89xeqONY/fFQCqv3wlUqe8k5Zp+Z3hj3+UAWrdCa/xQ1y51aFiTyJOmdZChWP@nongnu.org
X-Gm-Message-State: AOJu0YwpgZdTV/Ys1qMIyakl0mclCt3QcmeKQBNIHjNKNAYdcEiOs3Fe
 I8Nj2bhzMSJvJmOAkc9ZLXcRaco7bSjE7LEoqrKN8uZ01fbmLiQQsBEk0ikWKcCceRA=
X-Gm-Gg: ASbGnctP5Q1af3a3pu/8xM0Axnl7aViJvEbvtrXiv/j6WlJdvVlhLNbCkd7fp0lbnuA
 uQ232OVjwoUEpvGOnT1zvekaV25Qz084e46sE2EDJ9eAqkwwjSBIh4cCHRXnPjgR7+4tlQBtqJH
 LLpq2cw9O3lyj+uZA4G8OEAEltssMbyNO+v9dT+9y+pjHFGf3qp1pYjkj8CD4bFULoFAG2DBR7n
 PIifUboKT+m5LmpMq1Xe+N43PWqD/0acUxQA+6p+1Zg0zkK4H4dii2BKsNkkdipms1QuvQ/F14y
 YiiYd4lrw8+VyQblHM3RcT+sXJ2zB3nVkrsNBkzIiHgKRSTwxBAcaSVX6/gjg8g/ylxxlfteXaa
 tNCqWvlTchQ0Hm7wE4DKbfYXNGTgAXcbenQc=
X-Google-Smtp-Source: AGHT+IEjUV889+1SqWIFU4wUHLcxbPAXjVRavAqnK7T3HVNZetYpjVHLyVzQAMv5x1OA2KKyavuVyA==
X-Received: by 2002:aa7:88d4:0:b0:746:3025:6576 with SMTP id
 d2e1a72fcca58-76bdced5c93mr513691b3a.14.1753999086688; 
 Thu, 31 Jul 2025 14:58:06 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce8f800sm2439191b3a.42.2025.07.31.14.58.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:58:06 -0700 (PDT)
Message-ID: <7450f12c-319c-4aa1-9b00-4d6792a38d97@linaro.org>
Date: Thu, 31 Jul 2025 14:58:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 78/82] linux-user: Change exported get_elf_hwcap to
 abi_ulong
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-79-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-79-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> AArch64 is about to add the first 64-bit hwcap bit, so we
> have to expand the return type.  Since the only user
> assigns this to a abi_ulong, match that type.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/loader.h  |  2 +-
>   linux-user/elfload.c | 10 +++++-----
>   2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


