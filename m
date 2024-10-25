Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE65BD0C601
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 12:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4J06-00024I-2n; Fri, 25 Oct 2024 08:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t4Izn-0001zF-Eh
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 08:01:01 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t4Izj-0004hK-Hd
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 08:00:44 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4315e9e9642so18272295e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 05:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729857641; x=1730462441; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fT4lMuOgOB56WfuG238V6VrSQ7gyaX2jhXZYxFyoaD8=;
 b=HG/cmLKogjM5/1foVYwNVv5d8VKbU7pK3X1zr6UsbTmNhymRLsf1cQf7VTxRd91oPg
 Cg8FKTRNc4e5XIg+MDRgZ29UeWY3gQqWvHZysFlRWk8FunvMgHKV7P9RSWmE59xljwsq
 bxNcFwijkAFWoP7uE6RuX4u3eLoFs1pybf7lc+W5o5VYScco7VkNmhsQ3WHfaGvNSp00
 O3hH6pNscmrYgnVTeRzekUnv2areLDzHYKW4ockGQNN3Ob5oxLvRAhG/vbf5EqZ2OrMa
 2fcKhsJJ95lrOsmj3RoHqBY5sNHu0qvF7R81dn2b+5OIOsu3WfXLotyC1DqmZ+JIgmwz
 nI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729857641; x=1730462441;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fT4lMuOgOB56WfuG238V6VrSQ7gyaX2jhXZYxFyoaD8=;
 b=Zd9g1Qiqr8k2zseq7GWloDr4Z8NlNDVHbvUHVxRB1TKuIk2sLprFv76stZnBFzyM78
 p8a/c/GAdupFeHm0Ro3kK2NQcO6FU07/7v68fDnrd/i2QUj+ub0sfSzTwlaQyD6PFo8Z
 zir4jcLLMQgQLScARyyr/xt6NRSyyT1BbjRRCaHyuwLYhK2Aa2lBHqRPdeG0u7XW1T5l
 JP5wzJQKjaXcLbu51TCKb9Y2NTdU7aksnyr+hzU93S00eK1eHa8XB16Ku6TZctJ7asOd
 8MqcCnpeqcsBJhyCSMNLBiyMm7gIhrW9BVyuD9VEQ1af2qVBB8uv3mKCVl0SABRuHOQN
 5HNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX23pVfUUd+AWDWWOVxh1epJk0ZcCpcJizoKuQFduLSs+l0dzLWjTnCFj3oal5agttKkN76qACmn0i+@nongnu.org
X-Gm-Message-State: AOJu0Yz5PYqW+W5+SU+nUexKNoa5oXYIu4amqCnBFl2OTKWkirek0N8C
 ROhALkikewRthWWtGlLxyV7MTO6yXFsKyBN8F87gHzle980Mlk2wpjL9ivjxN7Y=
X-Google-Smtp-Source: AGHT+IHcD1fevFBRkVSdW3Qb18xqR7Hh4Mq3zUj4rkHb2/71NQ4BDvQD5qs+9AmwjMsQsxCgIQnP2A==
X-Received: by 2002:adf:f88d:0:b0:37c:d11f:c591 with SMTP id
 ffacd0b85a97d-37efcf06babmr6221046f8f.17.1729857641439; 
 Fri, 25 Oct 2024 05:00:41 -0700 (PDT)
Received: from [192.168.200.153] ([185.201.60.218])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b9294dsm1328846f8f.105.2024.10.25.05.00.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 05:00:41 -0700 (PDT)
Message-ID: <f4a58b30-f0bb-4818-95ff-d86c8e5ce5f4@linaro.org>
Date: Fri, 25 Oct 2024 13:00:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/mips: Introduce disas_mt_available()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@gmail.com>
References: <20241024195447.44600-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241024195447.44600-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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

On 10/24/24 20:54, Philippe Mathieu-Daudé wrote:
> Similarly to commit 17c2c320f3c ("Introduce ase_mt_available helper"),
> introduce the disas_mt_available() one which takes a DisasContext
> argument to determine whether Multi-Threading is available by
> checking the MT bit of the CP0_Config3 register.
> 
> Remove the then unused ASE_MT definition.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/mips-defs.h     |   1 -
>   target/mips/tcg/translate.h |   5 ++
>   target/mips/tcg/translate.c | 136 ++++++++++++++++++------------------
>   target/mips/cpu-defs.c.inc  |   4 +-
>   4 files changed, 75

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

