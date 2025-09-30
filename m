Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089CBCAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 20:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3gtQ-0002DK-CE; Tue, 30 Sep 2025 16:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3gtN-0002D2-5Q
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:24:09 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3gtD-0006Om-MY
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:24:06 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-781ea2cee3fso3298479b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 13:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759263835; x=1759868635; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L9ylyh2dM5RT8Al+sDv6RJiAWnHe0LWE4ktaPitWzh0=;
 b=wfqK++bS+sbceRDu7ZMiih8O99tqS7y1/pS+X4RQKf/aMKkBORZCBG+zSnod9ut7FL
 3k1C61mUIIsTqf7r2LXLm0DdDvBzFMI/vnIrOU2Nf1CxW5vrJr8u7dw2wJMAB+nY09Fn
 BaOh+WmFLATMkI4CcLeQYvdLtIAgjf0ZtC60tSav1g960DgsnC44fThZUKeBbFhAZUXK
 Xk3rLbkvAOSCysYso5mhAtPiphc0DpJOPJa0iiECVXOtEZouUzhWAp1IjxabA9HzDPKs
 H5X+mUIunjRdQd45ZIKOZu3zGfGBhhdARLjh9iPLVV8Sw2ObkQK8OB1SjCVtDj3pdaLz
 FKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759263835; x=1759868635;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L9ylyh2dM5RT8Al+sDv6RJiAWnHe0LWE4ktaPitWzh0=;
 b=DIeM5GBCdXMfcrM8dQIio/X9XXupEFC4rMt0pj8TUKk1WHPym6BcwEKyWxDiwRtxE+
 YY4LCTX8eWAmjkm/tTwA+U9SLpVmou/+5YGTR2sv9RkJ4rEWb1GTrDuKtZ+9ONj0vaYM
 yxrg3iIFbuHsJG7A5l8aYTgQz/tI9h4D/mWQw/toY2I9RCC/bxgnMbUCM52PQWalQdjN
 3dlmhQksiyv82oY2nVCmnLA4KK1kaRn/V5A7dE5IV+EvLx08epvyijGycp5Y4JR/keQC
 6ZRufKEfWFwTea2BF7FzoQ+Ofrud5X8wGLy4/EBBhJVvTtDOXUH14hZbpnosjRRyVqyZ
 VWvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRodnlFU5px1ThV892NxlZwDs2rYY5gHuoLSDBg8TJg1QsDLpmfY1J/Mb/LHmXyxVm1pkyDSAVThDi@nongnu.org
X-Gm-Message-State: AOJu0YyxQvQ9nB9pP72xaKYBNBivSGmRqJ6t5lkEcwFcyzrFOYHr79zJ
 kDCG9PyrvPjg2L5meQ/+Mr28/SKimU/5FRP4uaVOrRCn7F3QKu8pjonERt1nNluigaBq2zO/eWo
 It6HN49nMuA==
X-Gm-Gg: ASbGncv2d3os8LtBR9qx/4Su8RxQgQa+Eti+kWz+klnW1Ly4KJHVijAppRBK3ZlmVfb
 T6zgWa9zzgMGPEDpECYSsuN/Jz6O1wSTwpEdNRCb8xamby0CcA7JO/cleIxzH8Hur0U8yGsgM9M
 GtmXte3S0MWYCIqQEMB3YnYB39/+DhH3kYJI3GfCjLUMouRFt3Yn/nUdeETCOFGF4Yhn4tEf/7P
 Oy3B2Q4bzi0WWUJmSJe7iGm6zDQHLkEjzsOVpxlGL02hqt3II6FURo7IkMlDrMeSYiyi4q/R0VV
 RN3l00jr6m4+ij+iRkA93PUhD5C9vJtJ1bkrjd+vngHsPqQCPbJyEoQYUhvqo71ZwRPv8pmW12/
 4VhnZpj0EpOrBWFtgcMo/4SI/KRa8njAmnpwI9Pse1IoZP4UCXqZYPWCezwQt
X-Google-Smtp-Source: AGHT+IHoc4VA/fFWdT6Th4F/S3vIzEJvNsijlS17hYXqMSkv7upvOIlA0Mowea/k/OfjeBhay+mIrw==
X-Received: by 2002:a05:6a20:d310:b0:251:2a11:e61 with SMTP id
 adf61e73a8af0-321da316837mr1370311637.17.1759263835138; 
 Tue, 30 Sep 2025 13:23:55 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bacf4sm14791362a12.7.2025.09.30.13.23.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 13:23:54 -0700 (PDT)
Message-ID: <b0ef6dde-22fe-4e2f-9e63-372431b984a1@linaro.org>
Date: Tue, 30 Sep 2025 13:23:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/18] target/i386/whpx: Replace legacy
 cpu_physical_memory_rw() call
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
 <20250930082126.28618-11-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250930082126.28618-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> Get the vCPU address space and convert the legacy
> cpu_physical_memory_rw() by address_space_rw().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/i386/whpx/whpx-all.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

