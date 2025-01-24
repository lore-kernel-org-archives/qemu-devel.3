Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1DAC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 17:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbNDn-00079A-Sv; Fri, 24 Jan 2025 12:11:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbNDl-0006zW-GB
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:11:53 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbNDj-00067Q-7D
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:11:53 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ef6c56032eso3300034a91.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 09:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737738710; x=1738343510; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I7mkmUrHBsGCWGsb6KT+pRga/zStRaevJnxH2qkyJKE=;
 b=tcwY7ZySl5NQi+jHY1suUHFh66yYRSxviJQAFucaVKPIV4zUqlIyVXqaENNKyIdSA+
 EffxQELZh9ToPKFDsATGKnsQKNYZCnAfkgKHr24ukuKQff7QZwqvNivDzpHemrnofp9f
 Ep2OYl024XwFIugaudnqMFUFiMjtgbnVg4V9Y6L4u+/e8+zJ0iBFZlnvxkbjwxNFVHwE
 qEO2co+3rikiSX/ksMHE8aPYTgYgeNfYm5kt6jbvuDt8weSTVTjUToQVj4WqkkhzQ41f
 7VsLKELBukZB0dolhJLE6qKyLKHCTPhEF0iehYLuCETyY1QE6x045yPcJHbZnkL83/Wi
 inaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737738710; x=1738343510;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I7mkmUrHBsGCWGsb6KT+pRga/zStRaevJnxH2qkyJKE=;
 b=f+U3mZaULllcDl80nbWZTR5+4fURYDZrmfQGKrHd/WyNU4zBIhwMrl60PdXj/bWCyX
 Oq0HU1bl4F22PgHEJnbwbeX1sCRP0onT7zEWA/sW95tIARFDRAHzPHzAg+CmW+WNtgly
 uqZCMnqVXJM28iyeHlfz23RX4EAqdd7JutnJwdb17plrglg4wNFlXWxY9VwrEPDnZybO
 IK5tp/buAUqQ2AWJn29xfsSS5d7Opt+hRqvQF/ybvGtks+uOEsZo/IZC4jpl0nxLU7Jd
 PzrPOtiv31goSQTtc9+eA5DYvJV1QeF4sGJNrVCgWqEJghVEATJf00ZUyIBdP9TsuMiR
 PrYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVB80AZG2XuKyrpJ0wdjTngSacgSd4BeMXCrAvJW9w3EDkJeW6i0YQJCz2zczlD+Bi3CrDVpsnikBi@nongnu.org
X-Gm-Message-State: AOJu0YzNV9zbR7J1fD5t9X/3RdRHmHLDrfpqoBB4W/O2tPlR4plszCMJ
 NkfAUTdIYoJb/aPUqR9i3AnmCPF4dQzJlt3+JwxjdKf3tPvNoohkN4A7xjjZJLA=
X-Gm-Gg: ASbGncsowqjaGL6vXNqMERv728gk90pTxhxDGhY+KKnFBq1QbSZTQzC3vG8SmIHXG1O
 rHe1PA8xe/TN05JNq6flqXRWF4dqA4DrFqeaeaQ7m3L084KSImC9EjKGLJ1oY8VTg23tpfp/lHD
 HlhPQey69T7Kfh7FExzKiN8NG7rELw7aciiFEhyFiZYOANP5mTEc7KlgQx62+JqMctIbojyV2Q6
 HEbj4qiOzoHhfEdq7Ui7jysRNT3xz+M/A+I+L4XMJjRDmMDrZIi3em4DxIha+fg24+gNd2cgzbL
 UUKWv2jLLR+aBbcWhEANbGE3
X-Google-Smtp-Source: AGHT+IE4TPhmPDiu4esYgCyaQPz6rfM6AmT6bGrgbkU0d7FTOyrTj9nAm9uqAaWqBJzXkdjNwvRByg==
X-Received: by 2002:a05:6a00:1c9f:b0:728:e2cc:bfd6 with SMTP id
 d2e1a72fcca58-72dafa68bc6mr47930632b3a.18.1737738709919; 
 Fri, 24 Jan 2025 09:11:49 -0800 (PST)
Received: from [192.168.163.227] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a69fcbfsm2118061b3a.30.2025.01.24.09.11.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 09:11:49 -0800 (PST)
Message-ID: <90e45c23-75b9-4838-876d-3a2169b41c3c@linaro.org>
Date: Fri, 24 Jan 2025 09:11:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/28] target/microblaze: Move has_work() from CPUClass to
 SysemuCPUOps
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250121142341.17001-1-philmd@linaro.org>
 <20250121142341.17001-17-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121142341.17001-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/21/25 06:23, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/microblaze/cpu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

