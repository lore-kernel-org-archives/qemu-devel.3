Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484F7C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 17:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufLzO-0000n2-LQ; Fri, 25 Jul 2025 13:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufLzM-0000bT-AY
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 13:13:44 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufLzK-0005Pc-Iw
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 13:13:44 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b3bcb168fd5so2309140a12.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 10:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753463621; x=1754068421; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j7f0JfhmFjswOaMNGxW0UFwA3ZONKSqmHrbHvbGvjgw=;
 b=kQYtOqaGXWBSHCa4/17NG59bFoR6s5L9I++BejPJU/3DKttyuYi4TSagX/+2B0wmDM
 OOaDdsLTkJGaIzRiDVPGVlhMl2uv5U8rVXa5zqa53sw/r+KRprcJ76PDKgiTxJjQVjiI
 mGf7EJlaJrVRDbQgZVJ782T4LkotEecqPIM3q2pE/iCHw/sTfP0HOzOYrXu9T5N4/qav
 O1sCK5qsjMCsmZZNjF5O28R6ZTJg++jMzq20lsXt1irlClvNFxAmNS91/fgtt3Iuh08K
 JLLZW7xekE7HpWvOdBPu8PfBXy15qjx2B0sRTquptwTUDbowQ3jSMADbLfsXeD4SQFt6
 BWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753463621; x=1754068421;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j7f0JfhmFjswOaMNGxW0UFwA3ZONKSqmHrbHvbGvjgw=;
 b=isq65yylvneJMamG1n3facbYFAKh51UZ0JTrhRd7JhraI4Rn/s2tGq4t5WwgUWr6PF
 KImBWrxAmD+ULR8spuuS+z28QXVAcFn91VXgFFwy1Pjp+DIcmnweVHt07KK53YshjQCC
 Oditnw2FWSpIZvidDy8ihs1cTcjJgCYn6x/Met74RtKYDEH+FPPNfrPl8eges2Eoz7Dy
 hkS3YkcuokAem9r/N9VtY8OC/TMK1/lmNnVGjzm13KHsdHmJg/Oo36JJCG/T0Osir2ty
 vP5WEXiMn++S/PWKZcvlZiYo6IRJHwDUow3BTKvWRGgVqMSedypq23t2Oxhu0bR7bu/I
 52hQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV91ZcYyfOpXMnM69GfYymJV31v3onu7xVFtjGbSnpZa6R7y9viPW0lm1Ec9+qmgDOQM51ssRm/wHfo@nongnu.org
X-Gm-Message-State: AOJu0YympLNc4HlnlUE/csXYpcy1NBdLGyUeSJbFKK5yaOwbbq76gyhg
 ViGKMAihdbkH/V0SDLytZ+MT3stG+GXbPAGsAQEglN92Ma5M6pBKoEMldCKfRFXMNV8=
X-Gm-Gg: ASbGncvbUpEQvNXW/YCz02tpfQTeZFGUl6ZgEQXCq2m/6e803LUXNe+pM5Kx0Ae0K4Y
 beHPXvTfCFCzZJ8pyNojHfjTTy18L/6reUn1qv68m6YBeTjgDXwvb/AuWet4hu0x0K/rKespEtU
 Q7tVjwxWZB4LkstTzhPKQvd6wUv6oO+4qJpzq8C5kARyri5Mhk7S3Nlo9MFyqEbnz2+UwTm6+9T
 /7ZPAGbjRncrIWLx+jg9SDcPjsvgk/kmXVtptX3WasZQgABOclOhlRGbojXgik9Hv1c9IyuKwJe
 MFOpx/4c++dstWGPoD8ItEIOVfx+3rHgthOXfCz+++Zw587lvsT+lKUDNjCoI64AhvComgDh1TG
 tfikOnwtCGBxzgQMcOC+wIRVCkOVaH9x+8p/QWr/yByAvDw==
X-Google-Smtp-Source: AGHT+IHi5OtTgWklN0cJzVtMw0pPQiRMXZU8Cs/2BWVU0vWLb7BdbGMhqoL9nA32GBQpmlnCDFPi8w==
X-Received: by 2002:a17:90b:3c81:b0:313:fab4:1df6 with SMTP id
 98e67ed59e1d1-31e77a4a468mr3723588a91.32.1753463620846; 
 Fri, 25 Jul 2025 10:13:40 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662937c5sm3887608a91.18.2025.07.25.10.13.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 10:13:40 -0700 (PDT)
Message-ID: <833aa4ea-562e-4e3f-a2dc-8c7d3ee189e3@linaro.org>
Date: Fri, 25 Jul 2025 10:13:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.2? 2/2] linux-user/aarch64: Generate ESR signal
 records
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20250725165106.37105-1-richard.henderson@linaro.org>
 <20250725165106.37105-3-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250725165106.37105-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
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

On 7/25/25 9:51 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/aarch64/cpu_loop.c |  2 ++
>   linux-user/aarch64/signal.c   | 34 +++++++++++++++++++++++++++++++++-
>   2 files changed, 35 insertions(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


