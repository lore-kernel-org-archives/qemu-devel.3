Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D1BD78337
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIAAG-0008GJ-Ll; Mon, 02 Dec 2024 12:24:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAA4-0008Dw-Vi
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:24:43 -0500
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAA0-0008Oa-US
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:24:38 -0500
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b1b224f6c6so380010485a.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733160275; x=1733765075; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=elTd2gGOmnXAPWzLP9+5WVrUGNqwtmoKfOWyUtpLLw4=;
 b=m48+HuXlcNHmzJBycHDKLoGKw63vDlUlx7a1Ygm1/2aWFnMQKRtldusiFwOa3Nf1+e
 qEu5fvp537RtcXZ9gA1P0RbYeoQpmNib5yCIDCXyPZaHiMqI3sTWeMG2LVGxAhdIhe7x
 7JaO6xXB3L/v2Va+1UUyW9Vtn7zkIiktLqhZ/MjGmTDTkdNsC3Dbz4PLCnhWQIx+WEVg
 3uVeQ3RC2UwKhDs6hRy3ptW4Ud+us7K3IQ+PCfhCruGxVrRYpgFqIA1c5JVGZ4bqYUy1
 Ev3tuWwCZ83ESkWzflM0QbhGCCaDJZpOJAqOb4FMcnoR2lXjyLWeezl2PgE8deBiF54D
 Erdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733160275; x=1733765075;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=elTd2gGOmnXAPWzLP9+5WVrUGNqwtmoKfOWyUtpLLw4=;
 b=KHH9jk8YLIvIBWgDhICZ5eeuBkVpRvIGe6c5Ip9Lq1i3KFfw01M4KLwQOIpkE5GRiR
 T2c13nYMCW1dBRZlEY9ZkpbvazLwyJIqJDiBcBurMOJX669vkzzIYF5IUM0LFvy1mJMt
 /slIxYFVyhZ6w0nqq0n4AXgJqM7GQjbRzT6ROYgJM0evluj0r/0goXdCw5epXfotSt5B
 vzQD5SZW3iJWLTgVzQGFUTJ+q3oQGwd943bmFXrgyRKuDDRES/618PpPjGMvu6L7Mc1n
 Poqcy5Mjt9Su6xGkfqIslPeGIZSUfIAJvho74AvU9nYHigxS9oaaw9kE7xLl2bEmSjsC
 qQBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlnN86S/B/X+K9l7TtuqpnC2GvjuwwBRIrp8WnU+gdwnJ+AylRDFwe2b5JYMCLkAi6ch67+9G8Unqh@nongnu.org
X-Gm-Message-State: AOJu0Yzq+oHdKcpGqB3fxqnUykZFfvNdFNsi2j88N82Yt+nIp9lpfoN7
 1AKk1RCk1wxsNrzUDj6FLel0lO1Xm/MqW8JUAbgl99aE6C9VdiHYlrlCiOuBuGPZlykOACLJfku
 PWLA=
X-Gm-Gg: ASbGncvfFZbXwXttTEozsCCohbUHw90Cd0tKrqjqKSiVHDB3c8jGl1my2GbLezAosWr
 dmg348V0rhvu6yNr9PMJH43ucPE9PD7igm+5MxeEdWdprj9kF9SeDauF0NEP6O/9YjmfVXBvpQr
 7bq5YeDD/dEuIzQaPMHsc8jJg5G6Pgjd10s5WV8FJhiONX2yhBK9r2N/O3Ufw82dOVOymqc/vQi
 6RmoDirjhPjHWh8JOFUF+YLRmrh/+EpdGIAJthY4E1kegzo3ElU347K9NcUCJCbQL0l4Dk=
X-Google-Smtp-Source: AGHT+IGAKLZhgz6aJLfaxUf+D4xYU4Hk9WpsD18lB9rbzJaYRwErnr3ZibGs3KChv6L1MI3RL//MTg==
X-Received: by 2002:a05:620a:2790:b0:7a9:b9dc:1b72 with SMTP id
 af79cd13be357-7b67c27f756mr3004324885a.23.1733160275224; 
 Mon, 02 Dec 2024 09:24:35 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6849b7965sm424027485a.111.2024.12.02.09.24.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:24:34 -0800 (PST)
Message-ID: <445402ad-3a40-4c17-87aa-ecd1e71e8957@linaro.org>
Date: Mon, 2 Dec 2024 11:24:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 32/54] target/sparc: Initialize local scratch
 float_status from env->fp_status
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-33-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-33-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x734.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/2/24 07:13, Peter Maydell wrote:
> In the helper functions flcmps and flcmpd we use a scratch float_status
> so that we don't change the CPU state if the comparison raises any
> floating point exception flags. Instead of zero-initializing this
> scratch float_status, initialize it as a copy of env->fp_status. This
> avoids the need to explicitly initialize settings like the NaN
> propagation rule or others we might add to softfloat in future.
> 
> To do this we need to pass the CPU env pointer in to the helper.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/sparc/helper.h     | 4 ++--
>   target/sparc/fop_helper.c | 8 ++++----
>   target/sparc/translate.c  | 4 ++--
>   3 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

