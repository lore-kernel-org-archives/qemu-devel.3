Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978FBC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 11:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucMLf-0008VK-K2; Thu, 17 Jul 2025 07:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ucMLX-0008Jc-6o
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 07:00:16 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ucMLV-0003tJ-De
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 07:00:14 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4561514c7f0so8430645e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 04:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752750011; x=1753354811; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m9VGDQ5p29SEmIud5CccOWSz0DIopmjYl0YiPm2OVNA=;
 b=A6eCikWT9/8KYXzsc/F6CtjdAmRjx7Z/cmHeIbkVvoPdQPc9Q7b5X5YFJCSb4jbjU6
 L6zo+M9JmT5Hh37pKEiggTfLEqhqte3PH23pcRNIvIaEc/e/MVfUj65w0L9TgVEnvIlv
 M8xnDT9AOYqaDPNsAV/syZHDtl2CCXZIPRGk6nMxTwwpd6UmKu8Hy0BmXbshCfBwizZy
 qKQ+1iXXFeongRTzZx6rh96rJuhFnhWZY1bj/rTvAQ1KMTILGkxa40X9k1cE712s7fQs
 EYEiVMmkpFZmT8w8H5vOeAzzEjgPV3UUtydh7kwXmN8hQf5+y3sQw86fX5yumBoGFH1v
 l9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752750011; x=1753354811;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m9VGDQ5p29SEmIud5CccOWSz0DIopmjYl0YiPm2OVNA=;
 b=PEODin3WlTOMqoUSnOQ9KEN7ucBDhzK9rDyq6btQqdx6QbY2SMXr1G5yxAPAz7GFGO
 RRO3v48IM7PNAO6AaBSMvE0VeL0f2ZEsogcW9DrYWByxE/vbJkeifeQiJsN2LDz0bDme
 1K3KUIoqqFuuiH/2NxKa+SafXKUCd9OL2toaiDCS2w86J86jEgGawBrxvLzrh/AKC1CX
 mVruGyxkUGcOODtPxbwk8ICLfVMhbpa9NzADQ88D2kYI/i0JpS/Hk7kfOQI/nPC0r+Yq
 AC+ly83q+PiwLMlCatIwADR6j1zZlnMT0Ei8/CNkylbE75dUjLO26kFqq3kYoQuEKaYD
 KORw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJKSIYmo6jMrdCg2I/FdfUFKSEho0KoNiXXY5GuE8jgI//DW2gWgpB9t8gLaKEbSjN7ht8oTkfXQsk@nongnu.org
X-Gm-Message-State: AOJu0YwsXJQjiPY5/vOiIEZJknSjLE5SZjHGGhz3NQlHsGD9omQuWemn
 FK7u80tachpbgu5qEtaQKe4bJVj2Co1Kl9swTXfhK7SR4iPpJQZ+M/Bat/V1bzswNSdQyhck71V
 j+EVIEnE=
X-Gm-Gg: ASbGncu64D04PA6INVh5apdPJoWIFqY56j4erCXZRxXcqpMRslnRPQXZj5HnZL121Ay
 UiFeI0VaU+jLm+4UMPhb8M86hI1REFWlz+HKz1kYpcpgsH71vxNDkku/pS6iItF8LsvMc3bjZqS
 HtrCUJ6eS7EiDDHzDmkzSwy7/G+QGs03MYAI43iYml8JWFFgcU5og+Etce77p9lro9fOjN0aZkH
 CrvCAb9eqy89uDGvc61ccZwN0OaxXqBR3uFcSnRghj/MvHwq5VKBIZDrOJNqADmEnW2Cjlzy7XJ
 hs0tN/oItTCYxsqMQiCksJd+0yaHzVDek3oOfZvCDTywzRXorJStlfkkjskmU2FdMS+rKl4BAez
 HLkXe7hWOxBjGTmF9LlzrxcyEY5mYpHU1y+z1Axghq3T1JDSaJAPdAT7W4nrhl+lBiA==
X-Google-Smtp-Source: AGHT+IEuL2N13vrD7FLs8NSlKUBTdssqAGv6nO3FwQTS++GNt2xACuAeWKDN8xYbm8ka5/bBIbRFkQ==
X-Received: by 2002:a5d:5d0f:0:b0:3a5:2875:f985 with SMTP id
 ffacd0b85a97d-3b60e541decmr5001179f8f.59.1752750011510; 
 Thu, 17 Jul 2025 04:00:11 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc22a8sm20827582f8f.34.2025.07.17.04.00.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Jul 2025 04:00:11 -0700 (PDT)
Message-ID: <cab37022-776e-4e41-96ef-5220a032df0d@linaro.org>
Date: Thu, 17 Jul 2025 13:00:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel: fix over-quoting of QEMU_TEST_KEEP_SCRATCH
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250717104105.2656786-1-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250717104105.2656786-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 17/7/25 12:41, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   docs/devel/testing/functional.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


