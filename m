Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48A3C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 02:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTA5R-0000lI-4q; Sat, 21 Jun 2025 22:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTA5P-0000hR-8K
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:05:35 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTA5N-0007Uz-Ot
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:05:34 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-747fc7506d4so2306352b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 19:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750557930; x=1751162730; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lJHH+dsJKgbUwtCNBv+yYHKKwoBetwktYrK4b3iWW0I=;
 b=EzCNo3Ari6pSZNxNrRm6HQBamywIGgMpgUjH/8XSZehkRgNcfXTiSVdGzhoFGD1i2t
 B6Da7ZdlX7C+CTD+oxMDfxDHyOdaUWnxXL29bUBVOm5XWAViK66KbBrDzVPPDYtih3Hy
 /3i1KUZN0XcmGSE9niJCT/HM8nDxm4RO9OO7nf3a+DXTLG9BR2wSAzRSPl0jqPIQwFBc
 YJ4Hgts75tQc1gtSFoNHi50GpAGW7PX8RqllXVXE0A0QC1Y4jk3yyFn9W9F7FOBDMccc
 XUtmG8lagu41qPrLGRE1rD72owudyAFkT9WJnWw7I9GSlxR6y3HqmKMONMuq0pZp/bEU
 wisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750557930; x=1751162730;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lJHH+dsJKgbUwtCNBv+yYHKKwoBetwktYrK4b3iWW0I=;
 b=SxlJGbCobGoE+9QCaXEXAAc5tFlVIeS9hbjUoRfi6GqF+D34ubYjj8oYiGcX3oLZj0
 6czbbPdhRjiYEGsHQij8EuWkFAQkr658TTSBoAtivoY89/Tv/sux+nFw9qYNkQw3TcZy
 VHptgEsK82IiwT1Of3Pc3/rx8rMqLEH4gXnMaMO3zOiMFLAwA3cKY+qZCiT0lA92yXkY
 tojaTi67U56VVEUTZnO42T9zFdS8WYyAWjxEiJA634Gck3z9ORU/iryd7BIaxoEjiZSb
 SXXQkRv596RhH+GWXjOvvOwpSbqFFXFsB84jdr/TwpX13r41z1Gca1OL6C3KE09t/NCL
 q+cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxOofSypTxHfUPuJaibxy30FqaStIS+iGSCo2pZ2o3imBPb+mR8DfsHi5Dq4RAQBvfQ7aampcjS/YL@nongnu.org
X-Gm-Message-State: AOJu0Ywqqjyiifw7yeppEbVbrk08VuChPfCIC/S79+Ua/v+pPHLfyY+7
 DJAGQqNcH+eSU1CN/aaqZ4F5S5wXCpW0EYrHYzVyxvf4yHBCli/J0b05adHj1laPJydXP2Y7ZBq
 WZKDzFws=
X-Gm-Gg: ASbGncuJIifJ3YCARW1xYR9c/sBesNrn42ArVasHHO6wOmAmGSyW3eEnNWjVeYMSnZZ
 kUQJLXqrbFwEUn1bHp7rrNFSIFibSZMigFjHfv+OSi4mKejkANNB8odP0jfeqd+ZNGBpPy1qi+I
 AC6daZ7vinTfPs2bNMBE1NFVHo6ZC3vMavZwl/km1LK++qp1DDdRjWPkN+xp6DXrH32oikuZOi6
 0xCBWkB9W21u9L7iV2jOZODM+V5twWMsiHQjlT9LpqPusACcM0kglwZe0/hbr+L7sNIqvUf6fCm
 QSobnAcno14gf451MthlRJftdcBrX5EnymQHRemtnmiQRYlRu6K6hzPgQTt3dt5cmY/CEvV15h0
 5IZqwCUD+LkHy6sd6Uq7kgnhdf/Pp
X-Google-Smtp-Source: AGHT+IEPxzNsCLTZfGa8jxNQDgnGHqI6rSsOsqe9LRftIDjVfgWbeuSULxy/xgV3AZb4q+eeBaBJzw==
X-Received: by 2002:a05:6a00:2d8a:b0:742:a91d:b2f6 with SMTP id
 d2e1a72fcca58-7490da6de4dmr11224540b3a.13.1750557929823; 
 Sat, 21 Jun 2025 19:05:29 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a64b197sm5176349b3a.122.2025.06.21.19.05.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 19:05:29 -0700 (PDT)
Message-ID: <25f2f5e5-c8a1-4a28-b3aa-644ce50dce7a@linaro.org>
Date: Sat, 21 Jun 2025 19:05:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 35/48] accel/nvmm: Convert to
 AccelOpsClass::cpu_thread_routine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-36-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-36-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 6/20/25 10:13, Philippe Mathieu-Daudé wrote:
> By converting toAccelOpsClass::cpu_thread_routine we can
> let the common accel_create_vcpu_thread() create the thread.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/i386/nvmm/nvmm-accel-ops.c | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

