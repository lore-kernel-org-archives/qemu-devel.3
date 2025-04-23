Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C150EC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 20:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7gKd-0003dd-Gu; Wed, 23 Apr 2025 16:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7gKb-0003dC-Uz
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 16:04:29 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7gKa-0004iY-Bm
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 16:04:29 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736b98acaadso178950b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 13:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745438666; x=1746043466; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eIu/5mDEtzcyqOw3nVOVQ2PUqTJG7463M1RR40P65CA=;
 b=s/QGZAFNwhz7/qojlUHQ4ACIONEqsgC9WAYzGpJsxJP12qmk3N3CCZyD9r8l9lxjTq
 xtf1qUoIbfOJ03vB7xeIMIH34hUEhBbmdahzHXuFAONbYkBrFMGS2fbofMgnLipNdQL6
 pBzIOFd9BtceNaNCPGJ7nFulde0bAmbANRxLQSkWG7/7k/WY1WyZ9C/FvrYtKI8yMGWv
 9zVVpOwd6YaPmRi1wPKW5jZoSOvYpiNYAbhwp34L4Ajf8RNDRYBxH/wFeefopcDc1EEQ
 ScnYhkMLBI30/TwpYMPJ6pImhGBcDfIQX5IiMWRPgmqjt8oK6dSYz+Iup33yvs7gNbXH
 RsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745438666; x=1746043466;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eIu/5mDEtzcyqOw3nVOVQ2PUqTJG7463M1RR40P65CA=;
 b=UhGbJbpU+vgQJntECKF4/nxtgP+eH0Nax0nkVLCMo2O5W0F+VQseiZBQGb0M+EWI5r
 NkAVySEC7aABebr4pI+lg0hyxTXtl8HeA2oys349IXPZ5cLv/j4DEqPCX8MXJF8IECLR
 t9kgvc5OW+LjiRVb9iLfcY8f5vWOuAT1qKQ6C7CausRdV83PDEyb1QMZVGjL/0827EZ3
 Zxzkm9c/Zuv+SNw5o08siO0xCU9ltPAQxs6jsuUM0hb4hemxiHARP08mq+Q3eEp/eTS8
 6H/j51ROlnza22nbAISSM3zibdOnU3uU+lpAQaOiU5QvXxSozSGEIdv900CMG7NIQRrP
 PWMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6Q2tRw+HhrxybLMOO6s8XEMAMNCmPvE41FnabQQIRFTjbamBI0gTeVMONO/AvE9eZxqSce74XyCR9@nongnu.org
X-Gm-Message-State: AOJu0YzoEOZyu05ZSJloBlsaZ0TontsgSogtZvygm+MP7nxK6FH6FDzn
 sPL9TQODTG9Muc/95ZrI9CUil4UM+Elj0Q83ES8YZcM3748qq/630eMog0XMJJg=
X-Gm-Gg: ASbGnctWFZEN5dBKZjHmAHbJ4e5w+ggNBGyA2uVRlBmiC2bCOrVU+NteF9yjwE2HNlx
 tM9Ly5Qlghayjjtlngvxiqxioxw3gOXBEamlUbZWhp+TPZw3Hh8sChWBUoOBv4bEwhyIAdc46eg
 Y1gGbRAi4XMggjMApuumfPfmWyrFosVcYElZ+jKyWaXCgOVckkSTbrKjRRvzzYAfUwT9ZeGSm4D
 M/ZOaU2EXrpuhnOjTqJIdasXkj2LtR6DaALQVkdJWJNCmq759t+wKlUcS5c6cMxo6yGsIA3DErc
 z6VCut6IWWpJxKCMSg3ei3iItYg2nGKcOnGeJgsl1iZOicjVnbIAn3WdKh5ZLZwAqA2NyPzxAYd
 OXVkV9KFxst8PMIB8IA==
X-Google-Smtp-Source: AGHT+IEf0OmLhtb0bMZWv2thB1xBvSh2GUv6SxBB38curzwR5JIx//yG2YXtLku+Q7KLPbGcV29PbA==
X-Received: by 2002:a05:6a20:d48d:b0:1f0:e706:1370 with SMTP id
 adf61e73a8af0-204411cc111mr1192140637.35.1745438666357; 
 Wed, 23 Apr 2025 13:04:26 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbfa574fasm11369423b3a.99.2025.04.23.13.04.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 13:04:25 -0700 (PDT)
Message-ID: <990864df-638a-4c0d-a01b-87c916771bd8@linaro.org>
Date: Wed, 23 Apr 2025 13:04:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 06/19] hw/arm: Filter machine types for
 qemu-system-arm/aarch64 binaries
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-7-philmd@linaro.org>
 <a4a65446-07b7-4048-993a-6d0d7848b163@linaro.org>
 <0d3d3209-4513-4366-a105-6b71aa9caa88@linaro.org>
 <1937ddb0-a87d-4a87-ac73-3be72ded0c55@linaro.org>
 <6f2805ef-2fcd-4525-a7fd-cad59c64f38c@linaro.org>
 <213ba7a9-6c86-48cd-b595-38954d938665@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <213ba7a9-6c86-48cd-b595-38954d938665@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 4/23/25 12:33, Pierrick Bouvier wrote:
> Else, in case we make this array const, can we expect the linker to deduplicate it? I'm 
> not familiar with how final .data section is assembled.

No, we do not expect de-duplication.
It's a "that would technically break the object model" thing.
Const or not,

   static S *a = &(S){ };
   static S *b = &(S){ };
   assert(a != b);


r~

