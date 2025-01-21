Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B80C0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGbd-00045w-Fy; Tue, 21 Jan 2025 10:55:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taGbN-0003qN-SN
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:55:42 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taGbJ-0001wL-CY
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:55:41 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2f43da61ba9so7668336a91.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 07:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737474936; x=1738079736; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GOM5JsDuoW0vxvLZgWi76izSmLrosmbeC5Qt0kuKtlA=;
 b=rj8dnGzVGqUGEQzrBuNobBaXMpE3qN4MW6rCNsrAJTwu88b5oGWXq0YKbwmJ44kN6X
 S4Ae7bAczTDpu5MPAZa0T+X1jW9hBpoyfUFCleUvitKyTz2crq/WvBw44WxaSHJ7/aQq
 xmDUoQYxKmm5krgj5mvoSQdYXgtutpiBWFr0ZiOFIN1VI+DLKMeVTfOMNsbUzV2/21Cr
 FaOSz7VBYAz+3sB8F4spMM60BcuhFMvDINdhqyB3Z/oSZa9EfoBTPqvJvYiGJOytYaim
 +8Ux45qm/CcMi6K9w9umZvh7yQ4H7Br6dlCCdustI0lxYmOCtBg2adu+S36HMWz5QdNc
 VW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737474936; x=1738079736;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GOM5JsDuoW0vxvLZgWi76izSmLrosmbeC5Qt0kuKtlA=;
 b=AQlM9+mE16f7WG1y+I+t4lCg189O7sLGMF50nGDqB59LIQxnO52U2aIcehFc7Ih34m
 ury0xqnIHkgPKOzu0Pdl5wxTllDq7Vaa37Suo471MlQzhZJ2jw2hPda4SsAhM54IAWij
 Cb2F/M55WHeyYnK3XuldqjEGWI/Ghk3YNFGQ2yv6Vs9V7eGls82awsF5zZ59CwnCz8fu
 mQsdGcjYHbIa4ajduCwkqRsEJlxikq8UFiH24xBDcPDESCefP9RFXV4bp/V0mBj+rR1M
 TDE3qYcwsjlRPGfnq3SmfWdfbj0Rbzdh+y2jFdfYp2SQKlVYLOsvtW7ufuwWLfFaZ/lw
 oGOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR/FHCt0RcoaqTyVmf2zLtwc4x4KV7LtEnsYCcra8aoleS/hMnw/ENpZg+QHfyosy4UoH57CXOXAID@nongnu.org
X-Gm-Message-State: AOJu0Yy+wYV9cbVfWFVW616Y4GS41tOqq6cG1o18RDAxpQGHWLkuDn/K
 DdPeml4ommxGb0J5c7/DqP5nALrxnNSidIYMYTzLdUIdGBoGikqsIg2kunsWfeU=
X-Gm-Gg: ASbGncvLCOr7U4s2lDOyoBuTlMyqDAGTCU6Gd/xhq1CTgWc0EEOPd3nCgDN63DV1fg6
 qv5GBQFr0L1t6DMfaGMa9k+vaHs35KHIk8ZNQCMvw5nCQejwSNWcOlecquz39bY23rWElBZ1MS5
 eH1I4Ix5fslhhCOcGWoisLXDf3V0+CXplEmyvxQn3M3bMz35T62Y3z/9TZBB3RD7x7hWpJp0oe1
 G0VGM/qFZZ9WMBvQ7DjARhaxhLI8sRPKobPH3jg9O1L0F+M12fWS5ZT7gU9UBJew0eYEsAeC2kQ
 HYvq0R7i1/gPfUr8/MJTJg9y1dAks2hsl/PB
X-Google-Smtp-Source: AGHT+IEBErHYeWkQs/3WVP2J0ss5HRcyGIQWwFjpnWF+DXDFoxvW/XTmXcHVuSbn4oPcs24gzRKnzQ==
X-Received: by 2002:a17:90b:2590:b0:2ee:c6c8:d89f with SMTP id
 98e67ed59e1d1-2f782c93dc9mr28369246a91.14.1737474935723; 
 Tue, 21 Jan 2025 07:55:35 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77614d9b0sm10948450a91.18.2025.01.21.07.55.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 07:55:35 -0800 (PST)
Message-ID: <bc75c763-5433-4f18-9f40-318eabcd20a3@linaro.org>
Date: Tue, 21 Jan 2025 07:55:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] cpus: Prefer cached CpuClass over CPU_GET_CLASS()
 macro
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
References: <20250121114056.53949-1-philmd@linaro.org>
 <20250121114056.53949-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121114056.53949-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/21/25 03:40, Philippe Mathieu-Daudé wrote:
> CpuState caches its CPUClass since commit 6fbdff87062
> ("cpu: cache CPUClass in CPUState for hot code paths"),
> use it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/core/cpu.h | 10 +++-----
>   cpu-common.c          | 10 ++++----
>   cpu-target.c          |  6 ++---
>   hw/core/cpu-common.c  | 13 ++++------
>   hw/core/cpu-system.c  | 55 +++++++++++++++----------------------------
>   5 files changed, 32 insertions(+), 62 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

