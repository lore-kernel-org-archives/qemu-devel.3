Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516D1C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKhY-0007y5-0r; Mon, 14 Jul 2025 11:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubJPz-0005eI-Sa
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:40:32 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubJPt-0002uE-1x
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:40:30 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2ea6dd628a7so2419937fac.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 06:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752500423; x=1753105223; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pOXwTc0IzXLffaiIKWgQKIln/ahq1DKPYM+fwaRdUqE=;
 b=lfLIgJnMMNTSWUBCCUT9YMFO22qs/47Zmq3FRmxOS7h1wXZB7ie8TeNbxoxHwG2g7P
 o20sM4ArxrDNR40cRygz8SB6wB4DiE0AVhVNkRw0QTE3XPjVcveZCsnGiEnxyBeJeOxi
 E5m2Ze9a1oYeAxqacLIp/r40A3l5tW9pSSeNWCyzenuPFS7wM57DRVUUw9m+IFV+UlGX
 /VEz0/8NLg7AXK9SXTcynqh06GKhYVx1poOQBc49yzz+EvccKqi49SsKB0Yv0N9GSdQf
 WAEDyhOzXssq970ebuQDaplvzVD1EpfA/UBWg8ElH88u0cWfQ6TbSConqegUB32yBptq
 yfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752500423; x=1753105223;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pOXwTc0IzXLffaiIKWgQKIln/ahq1DKPYM+fwaRdUqE=;
 b=EJSXK3ryaZ29S6l69SFPNCZA7dF6AvPK/nHInEyLG224Qfcy0h3sb31VfD0aIK2OGV
 B/+fYXvEqQ+6iJ9k2ueUFNpJeNOUHptXd0MpcHdAoSoN5jnbTa01zY2bF1LlyOdtNJdO
 JwxqJJIyBQPJRrQWzGVWIUwF20Qpts9MQ0EMUOA95MmKfCA6kTPHnd6m9STUPpsQYLyx
 pVMOi1/GCZ2MwFAllmcept1CKLubkMrJFkCZu17qTBMZzxseQJGusyR4lCtjhZfyAQmZ
 fh/X1eGHp0tz0riU/PxY7dfW0iWa44uTKpkmrM7gUpl+J3L1nzMI5gSoMicL8Btxqkp/
 rFOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw1ppf62zjVU0jM6yahw4dwYZol8qzhgrbj3OWqXK4ZHoOqBXXp/b/JRikwV/B/0T6h41HarWvOSe7@nongnu.org
X-Gm-Message-State: AOJu0YxDsAVqN3VRQ3ATbU/W2ajMbaYn+dCTZ4UxD4sqDB5mLV8d7M5r
 7Ltv6u+IYrtNrQrpIfd7GipyrF1BSbF9Cnb5ld+B4OzuF90DeoARa21unLn0WOrKHlM=
X-Gm-Gg: ASbGncufyebWVGLFxP10pokhbFxfH3FWYwiAroRq68aR3q6MRrPg/Kh6viRBa1uWsQy
 kWgoQX8G1nNkPzVcFpceHQKmzSs1n8pJgwtvm4r6ZHn2o2/YI/q704PusGp7G6Mlxz/65QmEWsT
 ZOwDDKphpwxxsanjLLemYlAFHkyyr8qqw+a8g3m3CvARHn2IBOSrB5lwqlb64e6RBJWxiALZhx5
 4cyBq548WmbisuHON4ZPVGHEBMwaKo84Gqwl4ILg+POetrQXRhRHYW4dzRcYcTEJEYLR8uDbTZX
 6QsRy9vMJyXtbLXoeWpvfelwD3+3miAWXkpg1gKR0bgPKUPheUcDLUoNLD/9IKy6mLEOKf0Sonq
 WTcIiWk4GQ9ITFZE8Rdz6hGgQK4Mfflh15CAUZxhdaM37BOfBX+/zoinlSm319RUFFeqPRBobuy
 U7eDeLEnHpgbs=
X-Google-Smtp-Source: AGHT+IGoJAliJRXV5uSJmiyEJLZ3YAfH6RuzJBvB2IlZ5DCL4OyewqBLf0JUKrrvJSN3s6L7VQKooQ==
X-Received: by 2002:a05:6870:3805:b0:2df:a9d0:1dc9 with SMTP id
 586e51a60fabf-2ff269c22eemr8197805fac.37.1752500422703; 
 Mon, 14 Jul 2025 06:40:22 -0700 (PDT)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ff111c4f8asm1902317fac.6.2025.07.14.06.40.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 06:40:22 -0700 (PDT)
Message-ID: <22834f14-4fb0-4cf1-94a4-0c53ab094765@linaro.org>
Date: Mon, 14 Jul 2025 07:40:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: do not call GETPC() in
 check_ret_from_m_mode()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
References: <20250714133739.1248296-1-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250714133739.1248296-1-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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

On 7/14/25 07:37, Daniel Henrique Barboza wrote:
> GETPC() should always be called from the top level helper, e.g. the
> first helper that is called by the translation code. We stopped doing
> that in commit 3157a553ec, and then we introduced problems when
> unwinding the exceptions being thrown by helper_mret(), as reported by
> [1].
> 
> Call GETPC() at the top level helper and pass the value along.
> 
> [1]https://gitlab.com/qemu-project/qemu/-/issues/3020
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Fixes: 3157a553ec ("target/riscv: Add Smrnmi mnret instruction")
> Closes:https://gitlab.com/qemu-project/qemu/-/issues/3020
> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
> ---
>   target/riscv/op_helper.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

