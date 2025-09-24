Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067B6CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1VCR-0005wI-Gw; Wed, 24 Sep 2025 15:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1VCN-0005vJ-1U
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:30:43 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1VC8-0008IV-S4
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:30:42 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-77f68fae1a8so264367b3a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758742222; x=1759347022; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LGt23Zi9TZnDmV5WPX33Dwy1LKjDNGSAxoLxzgxnq5c=;
 b=YuxQPUhegfQtoh8LToPrkNlrD8txVoFf0robQvqym8mqA7Bv2Nzv1Y3F6rLJ9aaUZl
 7jO2DglIgfRIYXbQOFMBkHSEeVljKnP8DOEf7zuit/uZJuNhM91N7u8PJ7pLW/vCIp7r
 gNla+YNZHX4pn0NeLEYH8HNFpyIsvwuqLu7dq282POQLEx8TImlf5R07lVcftvEw8ejx
 1AFISFJleK0butyYonOF0tkEmLz6qLx6aDND+TKG9wxt3YRnKdcy9GNQ8xPzNt/MZJTs
 c4VuZhFmnxWOg7EpLgXYl5+7XftSBPm2WKf9cH7gXGQBoPpNrshkDeTjf0S4N0bCWQZh
 7Wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758742222; x=1759347022;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LGt23Zi9TZnDmV5WPX33Dwy1LKjDNGSAxoLxzgxnq5c=;
 b=aC+wr9ng/LjyB7tXXAsmAxBjl5GLCQnmchOpYERKwJ8plitecTCerv1yUhZYBhZoaQ
 sEKWjfdohcIYhgBEJnOGky4CvH+gXJx1+Oz7uJQS7Yhdj2UVRJH2H9MO3qAscggajrzc
 WoskaQdy5KDQKD0UNjfBeBumdOUrr3jBN5ipkSKGV8xFOQM84XHqk9rOsPSatRHGkGZx
 hj85Bs+XyWxH5TOYqZI2mQHDu/45ehjmt18p7QIQFy+qKrDlsFjx8QtJt49j+oDXAnBo
 d9u/ddXLJwWwzNgbUxzzyoq4i8yWU9XvVc+DlFD6ynzkf0AIasJtM+aozd0UI7igasfA
 +zng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpeUhhfPAyIbUP0/y7FBKTnrY8Yrrea8xCmn5cvL8HGyLjPbnWcgsVNt+Fb5MaL6io3RP1/WDg8qhQ@nongnu.org
X-Gm-Message-State: AOJu0YzhTCbIlNrMXnJR8cnMXlT94eJB47FT3QaVKdsbcFEKPfZ7iOhY
 UswpiB4WH80WHlObr59WOmHClhZvinpCzG+q2bPwD9D43AmBIx+h4oifYBnc7XLNlnE=
X-Gm-Gg: ASbGncvQZtDT9Ck02Bn4wI6TIPhyWW8t4uWEDUJzWN1ID9jUtekjKgwaw3kaQM1TQaC
 EcTcX8Zn7OBfy7XWcWZbT+NhPCxLk9JCbLN9jQH/W+cd/709fOVmp/NCU8mV1cTph+gC/Iu7lHT
 dYoEFwQI1R8DLi8+bd6qntqf4exE5cgHYjz8v4MoHI2zI+CJgpRRTFcOACjijzrg4qoz7uFybD0
 FXgiaZYIEywNRS30VbY6Gt6hXU6d/wVN+aaH9HjqgJP7jlBgKVj8Ko44tX5I1/VFX9tC4YWJw4h
 uck1R5ycPxY3d5VVaSNHEhg2kNXlbekuSMyYK9US0IYs3JZDwZmPGbxZamtqpiFThpbZco3mh/a
 TJcSaD6ZcE+54ahuVz8BA4E3SzNyugNBlY8+q
X-Google-Smtp-Source: AGHT+IH1OgiZJmoRvoNJyeZ4kfqTe+7P4q69djQ5E7bwOUskI+95J6Yq91lIFhPFsaEoL90Yi/gyjA==
X-Received: by 2002:a05:6a00:189a:b0:776:20c2:d58b with SMTP id
 d2e1a72fcca58-780fced5d67mr1311269b3a.24.1758742222403; 
 Wed, 24 Sep 2025 12:30:22 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77f3ec82229sm8979355b3a.64.2025.09.24.12.30.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 12:30:22 -0700 (PDT)
Message-ID: <792456cc-6cea-4e97-a1c0-d4dfa8d37482@linaro.org>
Date: Wed, 24 Sep 2025 12:30:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/alpha: Access CPUState::cpu_index via helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
References: <20250924170103.52585-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250924170103.52585-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 T_SPF_HELO_TEMPERROR=0.01,
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

On 9/24/25 10:01, Philippe Mathieu-Daudé wrote:
> CPUState::cpu_index is a target agnostic field, meant
> for common code (i.e. accel/ and system/ folders).
> 
> Target specific code should use the CPUClass::get_arch_id()
> helper, even if there is a 1:1 mapping.
> 
> In preparation of generic changes around CPU indexing,
> introduce the whoami helper to access the generic
> CPUState::cpu_index field.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/alpha/helper.h     | 1 +
>   target/alpha/sys_helper.c | 5 +++++
>   target/alpha/translate.c  | 3 +--
>   3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/target/alpha/helper.h b/target/alpha/helper.h
> index d60f2087031..604af4213c9 100644
> --- a/target/alpha/helper.h
> +++ b/target/alpha/helper.h
> @@ -93,6 +93,7 @@ DEF_HELPER_FLAGS_2(tbis, TCG_CALL_NO_RWG, void, env, i64)
>   DEF_HELPER_FLAGS_1(tb_flush, TCG_CALL_NO_RWG, void, env)
>   
>   DEF_HELPER_1(halt, void, i64)
> +DEF_HELPER_1(whoami, i64, env)

The PALcode function name doesn't contain the 'O'.

Hooray for 1970's abbreviations still hanging on:
http://www.bitsavers.org/pdf/dec/pdp11/1160/AA-C815A-TC_1160_MIcroprogramming_Tools_V1.0_Nov77.pdf

I think WHAMI was a pdp10 instruction even before that, but I can't find docs.  :-)

>   
>   DEF_HELPER_FLAGS_0(get_vmtime, TCG_CALL_NO_RWG, i64)
>   DEF_HELPER_FLAGS_0(get_walltime, TCG_CALL_NO_RWG, i64)
> diff --git a/target/alpha/sys_helper.c b/target/alpha/sys_helper.c
> index 51e32544287..a757a558900 100644
> --- a/target/alpha/sys_helper.c
> +++ b/target/alpha/sys_helper.c
> @@ -73,3 +73,8 @@ void helper_set_alarm(CPUAlphaState *env, uint64_t expire)
>           timer_del(cpu->alarm_timer);
>       }
>   }
> +
> +uint64_t HELPER(whoami)(CPUAlphaState *env)
> +{
> +    return env_cpu(env)->cpu_index;
> +}

It's a correct transformation of the current code,
though hard to evaluate without further context.

Aside from the extra 'O',
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

