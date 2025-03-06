Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A996DC282EC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 01:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq0BP-00028A-RE; Wed, 05 Mar 2025 20:37:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tq0BN-00025k-W1
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 20:37:54 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tq0BM-0007TL-DH
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 20:37:53 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ff087762bbso229390a91.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 17:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741225071; x=1741829871; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=84oIm26LMO/dL4ja0yC87OeXTy+S7aYVlRtwBb/jWaE=;
 b=oQDTO1ZM94UnNEt/9ItDg6hYpwDHJDMuU3xS8/rKl8Z85ldfbBohOWWawonlN4a9zQ
 hCyDvgKosoBHG08vvcmMSow2JTL9IO9YrimBpzEw7gtaFyM4woKdFXx2nMQPxDu7FYbn
 LObBAAk1jUiswqziHGKXBVlEsVur3C9XzKPI/rrqnQCgMFSyHp7ICnom5Z2l2zLX1y6Q
 rkhAKtHDA3ZjlLMo2UPfVB4pYbne6tFsqTcCe5wxJ8RSFJMBkMvA++JgFmHMhy81a2EN
 8HR1ZVIyk68ix4CTjl8x2OF+6SSu0kpelYbH/0M3G3STGNsSUanE3hf0Akae0u8GqFY5
 t5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741225071; x=1741829871;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=84oIm26LMO/dL4ja0yC87OeXTy+S7aYVlRtwBb/jWaE=;
 b=Y1CZFQoqa9Bcd0MJA3/lj1EGdkqr5dF2kRlq8s/CIvemAzm5JbZrjlXHDkUbdK6FTR
 YXq1l9d7gZ3tiEGbjpPIsjqpFRw9IzJiOU8rvZYoVUuXChWpfdQlYPehUoqLDCsKf3mt
 fBf3LC1ANuj0k6UL2Yg03pyFzA9vgZoPCuQ3kO+/9Ty/FzalKcYPooOXVNu3oR6GG7LU
 DSAM3J2UAsywGpnzaFPDXQzfQ24UCpVHocxXILacp8ih7rkzwONlbW+RBzXrIVrQkOYu
 zhEI98rV2ozBQFDwcnqkrOGS2UgoAVZ5Y5vIvjd8dwBvYpoR9pwvEx/Slf8SpyZK05hy
 zBsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa4cR8QKpNUL1VoxnE9KYbwlkEWZl1wSAGmh5T+WIvbqPpSDnf8bjL7tzN4rMwWeQVIuAPhu0Z8NaE@nongnu.org
X-Gm-Message-State: AOJu0YwbQV9VEzKVe3R3vmiqYccIn0ErAVIWkuiWyFzRMebWguKMRd8X
 B7mCXoTVzlSMPtHUwu/gFzo2S2Nb3dQ80luJ7zIVlUkh4lP5gJJ6ub7awuvriqw=
X-Gm-Gg: ASbGncsHS8QRo5mGNp9nJuVv3XBfnWP8+WiY0hRqf2jo2Tr3r2e2ZHD2B29PyxsUWN7
 tBZCubJZhkgTCHo9FCd24q0pAZwrWG2+Hqt4oknGfRXw3Jwf1qmeY5ZJOvyOjnAl9kFOC8yJIpE
 lcUQtLOmt4FdU/ooRdls4YkyHAqzs6xgXLZDf+57P7XAwE51prW9uZMZeSpmHdP3H+WzMa/QJtP
 nRIinm1HJcKgx/9QzKzwE0Wy7mmUVbaHCJSSMm1t7OpvsMfhdgr/V7Jam+O2C24xKDO6K69ghPM
 vDwqNLsMNy50+lh1Ou91Wik5B7q0lOGmjo5J6PK9Ykh7k3N5cXSObT+/spTDFadHZKY1BN1K8DJ
 TIsBytYLE
X-Google-Smtp-Source: AGHT+IGJV8HVdRsT8veUT0JW8wwOacKv6nkE7RMEYAwvl5Nz5e+gBsgp4zoK5Nix7AhbvL1DAUvD7A==
X-Received: by 2002:a17:90b:37cd:b0:2ee:aed2:c15c with SMTP id
 98e67ed59e1d1-2ff497eb78bmr8457263a91.28.1741225070969; 
 Wed, 05 Mar 2025 17:37:50 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff58cd1889sm1185678a91.42.2025.03.05.17.37.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 17:37:50 -0800 (PST)
Message-ID: <b07de87e-9dba-4549-bd53-80461c035c1c@linaro.org>
Date: Wed, 5 Mar 2025 17:37:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/18] include: Poison TARGET_PHYS_ADDR_SPACE_BITS
 definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250305153929.43687-1-philmd@linaro.org>
 <20250305153929.43687-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250305153929.43687-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 3/5/25 07:39, Philippe Mathieu-Daudé wrote:
> Ensure common code never use this target specific definition.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/poison.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/exec/poison.h b/include/exec/poison.h
> index 0c4ad04eb97..0ab7f0da1c7 100644
> --- a/include/exec/poison.h
> +++ b/include/exec/poison.h
> @@ -47,6 +47,7 @@
>   #pragma GCC poison TARGET_PAGE_MASK
>   #pragma GCC poison TARGET_PAGE_BITS
>   #pragma GCC poison TARGET_PAGE_ALIGN
> +#pragma GCC poison TARGET_PHYS_ADDR_SPACE_BITS
>   
>   #pragma GCC poison CPU_INTERRUPT_HARD
>   #pragma GCC poison CPU_INTERRUPT_EXITTB

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

