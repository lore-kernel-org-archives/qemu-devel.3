Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AAC0C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 18:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcqE8-0003xO-Ui; Tue, 28 Jan 2025 13:22:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcqE6-0003wb-WA
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 13:22:19 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcqE5-0004Gn-2u
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 13:22:18 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21619108a6bso103394595ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 10:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738088535; x=1738693335; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a0JahAq5sZpl6zfSli/j/9zwFDkE1SdlopvWt7M6jzg=;
 b=F3Vtf0nxsMLvSoHnNsrpVgYjBTkoNQjC1sQ9GVk9EOoIVEk0sTosyxdNez+zgoeMjR
 WGSh4FsDacUG423OkD/pQMjNxKy32Ug1zyK2MFo5LfddtrH6orw0GGstiV5+2AmEFgV+
 gUOcUaMydofuFm4GF7FRaJGyb3rGtr6AFWFMLzumcKH1I75ambWXgfoQKTJrtUbvzFH+
 OzDmQO27k80UhFR4mAaPEgXkdkxB6tGE1LqEKFMCkb7j/7DORcG+pQbD7e7gPgl0HdtF
 31CIK3n8UJp2LPd05nudtdxDXVIkki7lt3YTT+A/jxjzaKUpKzvqfrAi9vZfUpezPhz3
 cjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738088535; x=1738693335;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a0JahAq5sZpl6zfSli/j/9zwFDkE1SdlopvWt7M6jzg=;
 b=KwLMCHNj3yTeOqfxVNcQw993GIp8e1GYk0T6cfDUexK96Z3gMrx68ec3fZCyW6ONBV
 0acInMIZlQPQ8k0hUka0/h8eI+MygxuqA0FyCwdYTDQna/KA8TJwEzNBRLju+NWOj5di
 Tml6aCzSM1iaPaEGlQFPjNdiwrbzcyIzwCKyD4VHeCTxIBkBVp6g6jPlaSqPxcUw2wNz
 UfWk4pcSdXynfho6Eabm6IHvMnzCgTVV3O1fWmcai0yKXv9BsRmhK9qS6U8rPCoWOEgY
 JXikTpJZZrdwncoDiH525Jwhr+qAAcP4BdHvoWC/M+EOjNrXIyo9awwTTGwQ21bIJiFJ
 1L7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlw8fmk33skCawBZW9lXQNZbWv5GJUhjgSqIiC9fCoye4C+3+SgNPUxlkQh64gPAwkZqeSAzmloVjz@nongnu.org
X-Gm-Message-State: AOJu0Yx9BD28oSvEXRTvQMkasQVuybNQeqqv2BKRNkOsxWvB70Hp2tU7
 fJBSKqcpauLA6Q/7Ot4PY+ieJhrx1oH4DdaqhTIF5t3OHcJXtGhJxURmNyO2Y9Y=
X-Gm-Gg: ASbGncveAEI4E/yHFXU/3fOTM0fPkN9ch39P0zQTWIbpfRdUaz6BfmoiJ9yr017Vm8V
 bV1gD985w/xHhiYG3EcbkK1yj0KwhigV3OvnSfJ/2Iop6MtCKzuB1l5kIWY9iWZGpxBe5xaFa7T
 42Wx1v2MIik8e2uLHNwR0KcgFa94arHiMreBbJ7KyYAlqS68J3zaOAOn+WvPyQgcABeQXMQMnwL
 xp1jwtFK9qtm/EYxf/NHUw8fgQSXyfa32J4Ip7XMRXQrUNYQjqMSonRiCz3FzUieKB3YWmjcIbM
 qQKpCVyGScmIpTCVv870fjzm/rIpCG8cyQflFQRKMGa8Z70LiyIuOScPLA==
X-Google-Smtp-Source: AGHT+IEh7j0+tUPWOBOb0Tz237Tjb1L+mcrOGmHOfdD2X+xWifhTogtge5cp8YqTOhI2j5OYK7AKQA==
X-Received: by 2002:a05:6a21:390:b0:1e0:d4f4:5b2f with SMTP id
 adf61e73a8af0-1ed7a5efa56mr542516637.32.1738088534040; 
 Tue, 28 Jan 2025 10:22:14 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a69eb75sm9814368b3a.12.2025.01.28.10.22.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 10:22:13 -0800 (PST)
Message-ID: <0699b58e-9cbf-4b33-96c3-dfa0714cd583@linaro.org>
Date: Tue, 28 Jan 2025 10:22:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add myself as HPPA maintainer
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20250128170914.13353-2-deller@kernel.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128170914.13353-2-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/28/25 09:09, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Since I contribute quite some code to hppa, I'd like to step up and
> become the secondary maintainer for HPPA beside Richard.
> Additionally change status of hppa machines to maintained as I will
> take care of them.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


