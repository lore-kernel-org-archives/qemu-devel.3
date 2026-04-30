Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAEBCD1297
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 06:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIKR6-0000Jd-IK; Thu, 30 Apr 2026 01:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIKR4-0000Iv-Ou
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:59:42 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIKR3-0003pR-6T
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:59:42 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so6474475e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777528779; x=1778133579; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FIHJ7D7YFuXIN81xtCLVVmaG4xLfzXZKWOr/nwnRhDQ=;
 b=ENx1sd/I7+imAuvP7HbpjPyZ8nho8nJc88tF7Kdug+pH4VWujsricO61oIMXl9Cdj4
 g6PptlnvaHWXySke4IrS3mKL9Qw8GLzQKLY8XWBK1L/fy/i1swIvGWLrpMAkdRpK1VB5
 zvvt28t11eZH3GrNUK8Zw7Ayyy0faZI3vPnA+GrGi5M9AtV63b7yfSBbE2tLBN2dTUWc
 Ss2lOLmBuulh+Ue0vz3wjMqBjmB3GCiuksorBjOld6Z1i6bzdzF7cVz/8LIqOikH8Mt+
 P+LTbhubD7F5ujxg54T4FOqys02zGrkZEgWLjDR0CwcebNFQJHmK8evQ2G1Vt9coe72h
 MiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777528779; x=1778133579;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FIHJ7D7YFuXIN81xtCLVVmaG4xLfzXZKWOr/nwnRhDQ=;
 b=aOhlwh5LQY7tS/5/r/W02SZDAV+HvPF745JjYFO5JDxwY0GOIQV39PF37Zn7pNkfbe
 KqC+Ib/+2EgqN6i7uuz7CH07Qw2uUna30iDgzrTlReXU5cmkM7noj/ZseEDWWOSUYeAz
 s5fSQEzWJNrx+eenn9rolRMH2dUYG0Y45pM4A6YsbJ+Id3SR+8zVctSZ0vut7WgZHM52
 KXT8ZGwpt2MbNvt2pqmhO7zZJ1W3zXETOFSbZkjROdIw+UZnZlf5jnC+egL0g54BR76l
 4OqDqwiipM/1Wizr2dxT5BG1PRaUsn+6BO/zoF21YOdB5MW3+Tw47T4sfbaBs9qgFzhz
 rLSQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+d2oethswT4GSL/LNAUBRc/HKKUSEXrdvLhgnf7aa1bqoxi2cDASvXhd6cAOEr6O6fl29Sy5Ok2z41@nongnu.org
X-Gm-Message-State: AOJu0YwfZkTp+YKhwr7nwfRotiRrB5ePA0C91flk8pbAP4bbOeLzG/3+
 hNGUaC72clsmhSeiOdM2i4TwZAB5aItyW6clRpO5ZA84d8wrP2Mn/ywN+f9/9gyDo44=
X-Gm-Gg: AeBDiesBZstFAwj4QRPg1CoEBHY+2+uh9K1eg38H/e6Mcqmvso1Eamaxec6gJlCnd9/
 BXjOCvqWNNYFzUhYg7MXsi4bpMGCRD1dr08rZOY3ndYvetqgsjUgfRX6Es5U2lheY4hCEYF/TTy
 WDhAl4aV8aRfHoMrYMyoqz0S9xvI7/rqh0o5HzvIaWFo8sIoeMoDKxg7E7WOfPaz4QbjW4kSJB1
 uxwG8zeJld4iL2m92Jq8Oax/2t+T4FbfWKjkd/77fHctKiHQSK2xBs3mos+5/qbH9ywjEQHzJcF
 N3eV93gMmjnPd5fw0TKx1G+qwJf5XG9IkwjjrJbvXzz6NSoqpXIam/TqhJ8kxzwJJHrmfhFLMZL
 CnXFgqHNww3cIdCdDo19tXgLBqct3pytQEchvUFsmghD2AU2C65NWwBLzUK/ufPNoWa4xU5NjeQ
 0UQf22U188keXrt5ovvy6ljIYNAXmaR5QiiFU7f4W3xbtx8R5LfCsl3CM9/nphMrMnujWTHf+pd
 8Dw
X-Received: by 2002:a05:600c:4e4f:b0:486:ff92:63e5 with SMTP id
 5b1f17b1804b1-48a83f6c7f6mr23713685e9.6.1777528779469; 
 Wed, 29 Apr 2026 22:59:39 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a82307f7csm42046885e9.12.2026.04.29.22.59.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 22:59:38 -0700 (PDT)
Message-ID: <5d6dc1e9-f5ac-4118-b60a-c9e3ace530b5@linaro.org>
Date: Thu, 30 Apr 2026 07:59:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/40] fpu: Drop QEMU_FLATTEN from muladd routines
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-28-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430000524.56046-28-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 30/4/26 02:05, Richard Henderson wrote:
> The float16, bfloat16 and float128 paths are not so
> important that they require forced optimization.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

