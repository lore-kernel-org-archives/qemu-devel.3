Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2DDCAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 20:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3gvm-0003D5-PL; Tue, 30 Sep 2025 16:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3gvg-00039r-VK
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:26:33 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3gvZ-0007KT-SM
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:26:32 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-76e4fc419a9so6587883b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 13:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759263980; x=1759868780; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0sP/Kj+uEVO8prWRAvGBkYlBDE1NizznNXEOTzEv5NY=;
 b=GBF6UkDCLo36cKwvXYWFcZ400WYfZSAm2H1DNsGz4ci8nPMyp1PitN/ZWn82pOSVuy
 lsImqBkdDPpWRnd91q2ZeuUpkjUbMSnl7h/FXIMNKIxLewqxlLm/b3e771sRdK2x/QAQ
 CLq+b9+bxD9rold2tdyo/4nQWPlFFuTWFDM0MM8P5laZ2a9OJ2KFrj1fFbDUzYg4EllB
 HFjMn0nbXEOx2pagAa725BpmK7ykRuYBg+OiLsjaayd5LV0Ghc3abAZ8b4/rpkM1SWGa
 2h9fR7OT8iTtlWLXUbg37nCntfDxwcLQZ2eCLOhuDiaiNIIerWR/sexUS2Lwmt2wczxN
 BFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759263980; x=1759868780;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0sP/Kj+uEVO8prWRAvGBkYlBDE1NizznNXEOTzEv5NY=;
 b=vTYbplNtVlKGhn9pXWuF+TlIFB6nPg/gel7N66+r0E+2wZEm3RzZYk5Gz80rNC72v2
 8GHXBcG2PmpF/xpQan/qb26KB+jhz/f9BBier6vN4h1OI5AeaKYhC7KbAh11xelMVFij
 2rNhZXQvnNT+YaIBgzWppjR3OlAs3/qGwmnhPmWuVbeHtgkOZWFV3UITIubJ44nZXfyn
 4CnsIXSlkhf798E7Mg5jwGTILA2Vsy6Lo0q7GIlRjv9bSI7UUxC0VIATh5Q0a47M1MNy
 vARcY6TY/uQ8MoPsxk7Zg/aJxfd3Qswq9TRa0vVU6yfyY+PsdyaJjCXNSGulG3tmLhPJ
 ddCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8N2dFgV8nPSq0kFBUqiGYnWZCdrT7slPAVFLTraXBFGLaGqJlH13BDAoKVCIBmKASM2n0uDECVlcn@nongnu.org
X-Gm-Message-State: AOJu0YzYanK6bJjGnebVvp9Lbc8juB5FuqtIgM3nmMUuyb8JJvgE9gne
 lensOu6fu2LKIGL012KBqa9r9MK8HkYj2HPJxjKU8NYTQtWOQUu7Se05U6idbVo1TU7lYkcUifd
 aE9QlUKuuNw==
X-Gm-Gg: ASbGncsrUfjYyuB1WRJXaOgHtGDd3+eVyIx4Ckn10T4nwpyL8N+HBRf+H9KHFxf9svY
 gtH6xmFQ1MSntud3XRyOHPtwbbfoR9BVUHsyOh229QBAYL4m/1mrxnrzx0TTE/F/BFJDhzwpt3d
 GJyYb1V712Np/wQvUl/RPX1Gphp4qBHHA/ryrs5Ndiw+SdwTZKFH1loTHZ9smrBf/8GNwE4NTSw
 bDVgBTKYiCOH7JGNmGmI3afFh65r7VRewgBxuBTkiPc5eEKtYDgkWWGFCkvYveT+ZCUuOI34Fze
 86wcwclIe4ILl2tzsezGUTadPev//gPRCRgYAMb4navNOoLImBtuMIepx/12Q+pa0H4c9GXSFpc
 sH/dnkRAYqZyIQj9OgOamBhVEnyzJ9BiMBq/8rVT32PcdfhKKgUpqkYdDlkHA
X-Google-Smtp-Source: AGHT+IE2suxUviR3YRz4x3KzzykvXCXfFXqCoufKk56Y48IBkJ347/3RJRi3ZyHPJywSuDN0Pm2HRA==
X-Received: by 2002:a17:903:11c7:b0:283:c950:a76f with SMTP id
 d9443c01a7336-28e7f318638mr10922925ad.43.1759263979865; 
 Tue, 30 Sep 2025 13:26:19 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53cbe6dsm14878852a12.21.2025.09.30.13.26.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 13:26:19 -0700 (PDT)
Message-ID: <3ef0810f-ec9a-494a-97d3-cc4e3985e1f1@linaro.org>
Date: Tue, 30 Sep 2025 13:26:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/18] target/i386/nvmm: Inline
 cpu_physical_memory_rw() in nvmm_mem_callback
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
 <20250930082126.28618-13-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250930082126.28618-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 9/30/25 01:21, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/i386/nvmm/nvmm-all.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

