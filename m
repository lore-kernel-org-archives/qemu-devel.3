Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35A9CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 17:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6uWG-0008GZ-1b; Thu, 09 Oct 2025 13:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6uWE-0008Fj-EM
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:33:34 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6uWA-000418-U9
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:33:34 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-791c287c10dso1180451b3a.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 10:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760031207; x=1760636007; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wDpYtsL7QcTlX/gwxGv5Lw6yDPGTNv+3vNQIjZJpLV0=;
 b=fNxjOMWcSlNp0YtSwuAwmpMEPQFDrZ55f05ajEJlc2kDuNHiKWxfUo0YiWK1YBRv08
 aHXACDfw+PZxPEpy0/552qT7sqeSAulh/48umsQM1hqEzEm4sSZjxQNIycqPLMnu2F/y
 VY4HMcq2alqhGWsi/DYGXyQBdHpKZR1cGIZezVtGuH6a17S0797p4nbPHLwhXR8uZrr+
 BghY2GCymJ69JmiVU8e5gsItHtWXSF7G9S+1VXmUt+cjKPa80TPziwoxtjbkH4g6Djsj
 oDsy3cxoBbLMVnA92glGc2loEd414+rGD5lolxM6nLoil7Y7I9RSYjwifKfDwm6FWpHk
 I8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760031207; x=1760636007;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wDpYtsL7QcTlX/gwxGv5Lw6yDPGTNv+3vNQIjZJpLV0=;
 b=LQDknYrdEiW8KraKVBj9ujVrTHyCTXt/LoguxKLhQ3NGr2SFFgHP/M/8/9+Bms/BOu
 N5EIuRuma3KEjwQg8QguzuAjLOYfrGJVcbrwaSB+axDS3f4vd0x2PTKNLvJyOm4y1xgu
 yCadXUo3ixTRR1LmFyre/e46VK3taNOXeHE4fM/Wx6v6VjVzuBbjfL/yXaRsjaE0AbNS
 ogoG9VpFwgR4BJJ8ec2RH9urAgFjSDNnvKSGBRo7qS81NtHvUIPUGl/OVFfbZbcgeD4B
 Hk1czD6tWPmEQvC5cZBZOGD5iMzZz7vX232/rJel3+vrH7gij8bYyh24IHyqnVK1/Pzz
 +0dA==
X-Gm-Message-State: AOJu0YwdIv7PMQ3mSvT+tA+TBQbmqAUAutoYpCIP1IfWyCV3t1Qbrznf
 9fPqEbeJQKBLC/Qnwq9pjFuaevwcmLudtgU8Ko2EGMB59I3cWePtkZEtN257xxRXrV9KMQP0UZv
 1htxCpHU=
X-Gm-Gg: ASbGnctz9NaVNnGxzuqm8H2P/TQLv6rpvXCaEsFLIBiuIjXkobi0LjVis/SlonVpuVI
 MMM+X13WpdwviykFpV+AaMksoGtsH+rZcMwdKORRUGkZftchFvmIrVI2dtQ8pZnIZYuuUCSxW2I
 Lqvd+0HYHUuZHJ++rr0CXLj/RUT6v4HJbJRpwXvHZYmiU/NpQHj4egsIU0GT8mkFu9F9PUFpjyV
 eDyELqfZSgRwUyzigZHu7cN+QeGZh2wD3kGzTbXZVZtwvJqYHkFUU56ovq6CJkRdc2ShO9b9OnP
 DGVcs+92KxuuV1t1oenH+uMcyMe9HjH0kL7ca0EDcVyTtxGy25csvr+ddHRMQE0c0TTnSK+RrXR
 tH/TbqKoPrTqG6gob6Fw9+SaX9lUIzoZyYy1aQ7dzbBbct7wVmk95R8wo5igYgR2H
X-Google-Smtp-Source: AGHT+IH/wl4SXxPqejDlK2vKjxuDWGCRZUuzIm544dY9p9gWplUdWU3EvEP56sNwDQpW6Z9SKmRv8g==
X-Received: by 2002:a05:6a20:12ce:b0:309:48d8:cf0a with SMTP id
 adf61e73a8af0-32da8462fb2mr10632909637.54.1760031207205; 
 Thu, 09 Oct 2025 10:33:27 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992d6aca6asm282510b3a.70.2025.10.09.10.33.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 10:33:26 -0700 (PDT)
Message-ID: <a30a489a-93b7-4a9c-bd04-e27c9ee274f6@linaro.org>
Date: Thu, 9 Oct 2025 10:33:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] target/rx: Propagate DisasContext to gen_ld[u]() and
 gen_st()
To: qemu-devel@nongnu.org
References: <20251009151607.26278-1-philmd@linaro.org>
 <20251009151607.26278-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009151607.26278-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 10/9/25 08:16, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/rx/translate.c | 64 +++++++++++++++++++++----------------------
>   1 file changed, 32 insertions(+), 32 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

