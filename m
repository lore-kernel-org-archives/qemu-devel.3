Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4185AFF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 04:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJM5-0004vX-Fq; Thu, 30 Apr 2026 00:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJLy-0004pe-8y
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:50:22 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJLv-00013y-Ov
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:50:21 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso4680065e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 21:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777524618; x=1778129418; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1GsdYPjx9KfeuZi5uf25zUcS3hp7xF8ZgINMpaOT7uE=;
 b=F9uYu8VeFBx2eX2jD5BjtpoiHzB9IcwZQAMjgyd9r+TdUXVO/geFz8NTTxAaFHK9Ga
 JehlKLzHQM8OiFFUmvpLgkE11meY5LG7YvVIbeRIAx9k80g96/h0rmducacPdoSKOTjZ
 H4+hu4Rwl98vIHLJciSiMNvffTYodyyE9lZf1BJuV8+GrB2yIKAfn8jfr6vDhNwgYGQA
 r2wi25ACDRx4a5SLRekreFhZEJTcz6mldbXdvOddpUKdFQ/QAQMnzN8UmTq3zELNBNO0
 Pxt8fatP73v3w3R3SRAWKXZQhL6lIK1wSwYOb7iJixBWwCu+rXWHvpUg4yH9ufPo6vxD
 2H0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777524618; x=1778129418;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1GsdYPjx9KfeuZi5uf25zUcS3hp7xF8ZgINMpaOT7uE=;
 b=rafqJiMAkMvYZruE2m9mAs/IpEP4D4aKWaXauV4nM+H9cX2fsLLa68KBin9l5lb/jl
 O+kv1/FP5Zn7ENbQurl9x3DCe5IuwiH/KtUUoCwoZN0BBgME+Ngv3+L3UqW5B1a7385M
 oYioyX9tOMOr5qxQIMg8imsBfkvH2fm9SyyZpw3hcMXrDJKz0EqTYIQpIPWd8c9W9O5B
 Rn5Y/UmbJR7wJB9yLXkn/pb6ubK4NEaU2JF1LjfvSKXEpnsumH9PFHyr2jOtJLFmatpR
 BtMnum2XP7jC1V5lfiLkLp0gage5VroDSoga3fNos6jXKR9nFE17T+XLo9Qgdgb3nP+2
 TxSQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Ubz2f1sCXIgEsVuzhDVNvtlKKScgkX36vwZSOv0ponSBI46t1ho9UoHlHWWtLTEsNIYdJdeCjev+q@nongnu.org
X-Gm-Message-State: AOJu0YxKrVjcKxaOiaPXMKemflwL0J1+w/TR6oMPiB5HZY1UPEa8m+3G
 jRDONlyR2Q+6nH8tY1VPfkY7uWnZquMtaPx1HphUG2bR2HksSm7lOEYJBxcmo3YMIko=
X-Gm-Gg: AeBDiev20bL/sY5peSUOTgPp4/Zs0JFE+SOJld+IoJgdsZnl7/yesCTWvaRFsvPuSM1
 kaFfcfHSxgl/SYpZMee58tEQFttAnkL/Irjv6ah0Nem4Rg+2zDd6RIKdrgbT/j9z7ZRU3W2IqJF
 LmSRdkBiS8ZSAn/24wzd+DTzNYatVQ6kDSxb7YSUYV7ypOlF3dIBhU7XVTWoNgGiuGWYziwOB6X
 9SZIfWkvG8CeFswe7r0CpSSwNZB1XatEAk4ThU6XFzK2WCliqW+6ci7wt4d2OyrbFqya+KPrLOA
 ZMyq2+tOFww3Gd519v0RmQ2TSxR2hl62QHM0eiTLnjvqfZt8rN1WHjMn50351MU64z6nbPRppN2
 9ZiJV/1WBKmXCvq+5Ai1nHqe86C18g2cken21pnpDXwircxK+8tcvsoaO9zq/hnCyi/3hPEtY8d
 sG8QhZmLNW6b0HBi+I87gDX3rb6vSut8f6X5OLMGe2G9a7jbHsEdyFkcHjLZ4MfN+8d/0KV1cmj
 7/c
X-Received: by 2002:a05:600c:4fc8:b0:48a:7772:c26b with SMTP id
 5b1f17b1804b1-48a8445d259mr20779965e9.26.1777524617927; 
 Wed, 29 Apr 2026 21:50:17 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c3058f6sm32746245e9.17.2026.04.29.21.50.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 21:50:16 -0700 (PDT)
Message-ID: <1700f6fd-2852-40e5-a100-c3d2dbf31728@linaro.org>
Date: Thu, 30 Apr 2026 06:50:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/40] fpu: Inline float64_pack_raw into callers
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430000524.56046-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 30/4/26 02:04, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

