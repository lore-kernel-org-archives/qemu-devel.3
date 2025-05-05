Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06ED1C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBsMH-00068Y-4I; Mon, 05 May 2025 05:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBsME-00067O-M9
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:43:31 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBsMC-0003iR-TW
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:43:30 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-441c99459e9so6336935e9.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746438207; x=1747043007; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F5j8VztzuQ6U2qAz6Vf5ANoYsbgBjEt117vmRePnIQU=;
 b=mcosZIkqUJGcdYmyJxYAw8uL18AZPTajjBgPKU27LRvesjQivkqmrjL/fd++sXSgNA
 2t1ZECgIZr/B+czGpOK6PuaT7anKbMwYAh+e11Q2wJ+DwfZOW+5nmq97DufNZ6mFw4G0
 1BOrTRiaFF00VCgTeZMKYJoi78sWSlNzNAZmqhNQOj2J04AXaQP3IyTpRvxJJ6GkkVgT
 Rlj15gEE/KyTuIJAawlgkcWx4583mBDcO68ZvZEEAnWIu9rcq/RqpjP9am6TUgBOAbbl
 lkb3mpue2UvkljCg/lXO2z9LnWx0QotgFYXVGEBh4Don5ZSLA7oAIm2hVke30seHtJrP
 6CVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746438207; x=1747043007;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F5j8VztzuQ6U2qAz6Vf5ANoYsbgBjEt117vmRePnIQU=;
 b=Rg/VDK+DaY6gIaI8DsqDs/Q2xF8HcjaBsQOHtFLmUH0qt9bM+0fkuZEZXQCaPWHJbR
 KARjyuS6RLAEtm2LZHsO9dYwfJlw/YP2j97v3sZE241cFmw9Xt6ocXD7pXHTCfCTa5pG
 SwQlJ7c4mJBGT5iZHk4UbKp49XdnOjc6u5px6d3qHhSeNqeIPPS3izaw0+zz1GKfN3sW
 d2xOrWqIs9ZY/oCfw1UreTgtgcJw8vps1BoBJqDaXsY1Ohxo0ymBNe6LtxzkFpTMeAW7
 1JTxZKfDyFu7K7r/WlXcsseZ6ngXNcesRayT4Uwtlpi7byNCHDceWscjE06IU7xohn+X
 WnDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO2h21amttNTLEbKSX/ob56ErMntAEX7h5yqWKi0tZSS/RYc3EuA39lc/5Q6CjJ77398piEZFFGmgl@nongnu.org
X-Gm-Message-State: AOJu0YwzH6vm3qNSEqCPsyRQNi7wmrYue+qjV5cMS5jtQw67qvrRqVS4
 1AgdD+DKt6S6SKGQf+QOx+WCgoztRFeujzSXw+gGMyeAbowLCy+l5jptnZCSGok=
X-Gm-Gg: ASbGncscF0yD6GO6msSGy1ISBMWNk2Kd5Ly9nmY6YEJz8U1CZzQJcPVS8gvPAWzOHyM
 v/m4vkedi5uVNPYhIwOfMeWr694SH3zuaMnCV5E36SH9QyR4qvtj+tiYoKQFtRTxXJF3NqJlcMV
 h617VPexBReqfZjAojj3bcNK1eWxOJX7bFbe5hqQTnmTa6FlpwGhGfRGpD79Znr4fRLud9QtJeO
 nMg26FSVcYQD0iTAJraqkwQzV6TZH/+o6q8OE8EYLjU1zSJNyGIoU6sPkz9U/FCccbdQ9ctSbPh
 PbuPmeZFL07ir8dzYHn6hljs6UkfjdeD7qjC05CK+Kn+QgHrQ0ZNo6ciHZb+dSPFaKarhdn76sd
 4gvMEpFwYpppwRq/aDg==
X-Google-Smtp-Source: AGHT+IFJo6RHd1tr+nxXlihSQrdHHm0KILDqf9wSC7iMLlI1sXAvKZCZbH5MrQfEt81Jb4BTr9ux6A==
X-Received: by 2002:a05:6000:240b:b0:3a0:8020:c5c5 with SMTP id
 ffacd0b85a97d-3a099aef8e6mr8513185f8f.58.1746438206685; 
 Mon, 05 May 2025 02:43:26 -0700 (PDT)
Received: from [10.194.152.213] (29.red-88-28-18.dynamicip.rima-tde.net.
 [88.28.18.29]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae0d15sm10069415f8f.13.2025.05.05.02.43.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 02:43:26 -0700 (PDT)
Message-ID: <5d461945-155b-40e8-bab4-502e57d94b03@linaro.org>
Date: Mon, 5 May 2025 11:43:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/i386/emulate: stop overloading
 decode->op[N].ptr
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: wei.liu@kernel.org
References: <20250502214841.242584-1-pbonzini@redhat.com>
 <20250502214841.242584-3-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250502214841.242584-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Hi Paolo,

On 2/5/25 23:48, Paolo Bonzini wrote:
> decode->op[N].ptr can contain either a host pointer (!) in CPUState
> or a guest virtual address.  Pass the whole struct to read_val_ext
> and write_val_ext, so that it can decide the contents based on the
> operand type.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/emulate/x86_decode.h |   9 ++-
>   target/i386/emulate/x86_emu.h    |   8 +--
>   target/i386/emulate/x86_decode.c |  74 +++++++++----------
>   target/i386/emulate/x86_emu.c    | 119 ++++++++++++++++---------------
>   4 files changed, 109 insertions(+), 101 deletions(-)
> 
> diff --git a/target/i386/emulate/x86_decode.h b/target/i386/emulate/x86_decode.h
> index 87cc728598d..497cbdef9c7 100644
> --- a/target/i386/emulate/x86_decode.h
> +++ b/target/i386/emulate/x86_decode.h
> @@ -266,7 +266,10 @@ typedef struct x86_decode_op {
>       int reg;
>       target_ulong val;
>   
> -    target_ulong ptr;
> +    union {
> +        target_ulong addr;

Prefer 'vaddr' type for "guest virtual address".

> +        void *regptr;
> +    };
>   } x86_decode_op;


