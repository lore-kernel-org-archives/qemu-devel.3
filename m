Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3639CD12673
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 21:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQXdl-0006Wm-1Q; Tue, 02 Dec 2025 16:10:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQXdi-0006WF-Sb
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 16:10:27 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQXdh-0004nN-AI
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 16:10:26 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c6cc44ff62so4112232a34.3
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 13:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764709823; x=1765314623; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eP2dOlRdHDHuJ0joOA57uKndYTdH4d2UcJCpnf5hRjI=;
 b=i6dBJQm7wTqh8X0tCoMb2ytCMtK4Jy63/eejiKp0bWH0ekZkoQ53dziFg9gBi/VrC6
 rjhfG6CbVDYCeyS48LeQmOVexuKcL4kcv2Nq34dcnJjPgcNquEdPHugPFwMkb97/R7AB
 +NZtZgnOQ/T4r+Tzu8hzNCDnAbYf0ArjgYe+2WMC7w1mYoEqhGtvSXeCOQbpuE0RZqcc
 oyMarDyInYue6blvtCkedDQb4s3hgOuBp8lOkeJTZdDRViNdu8JgAGsOIz6fZor/Tz0N
 SFYVbYuZhCE6s+TmAXm6RbLnUdC9VndNRFZA5PiUWOTdKsiM64TB532LijVVPUElo8Il
 JHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764709823; x=1765314623;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eP2dOlRdHDHuJ0joOA57uKndYTdH4d2UcJCpnf5hRjI=;
 b=pr+bZtfiRo9JL8g8LotZg+qBJOaqaapLwS2I/UypJAPd53XwrhpuXL+s1rBNfSxpy4
 Bw8n+Gk7pu5GwisQuBFEselyA/edqW+ephItlb7oosqqx7MptsNTI5RWM/1Cm3QpsJyn
 ZtwXqCEW9/xYq9KMx9b/wA60NxFwpqHUFoOxSRoK74Yxe7mskidityXa1VYvkyOJRXoF
 xymh+k8k56X1azEbcwD4UXI26w/meGt8KpJ2YyiXf9w3z5Kv76fzJ4ax94BRQE/IZ0HH
 lC6YQ4IR0Ox9SAjNJVBFOtru95Oy/8ay4juOaWIrBRFO1l7hyRJTYcaPpwnRvcM6ZHPW
 32nQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPbE5W1qTT9WAlEhUMoi1LPCV4V56vhqPyw2wkqTw3OTYtgpQlFf+t+7u9y8vPvfC3pffOkhrXj/9y@nongnu.org
X-Gm-Message-State: AOJu0Yxatm75zX9kHW4xcb4x+bw5H2C1AcyoVqFU5cPv+flaX3nBxa05
 JgssEgSmK2RVKr6jow6st6nD5Jks0mYxmQxjdXg8MC+H0LJheD6e9n8XOvouOf/U6H8=
X-Gm-Gg: ASbGncvLnlb8kXAQyOqpkRGSJnYsQboRs6wiToWT4OP8FCQbU/2XSKFbhZH35bsrWLu
 eRKHy4cnRry4dXbezcTx7EfsVuWpRMwsLUEvPTkSXN8Hcq0S6pZmgmpiE6DjyovuyI1A8mYRBZJ
 iYRLH6W6r1f7b9OBhszOHKbVZ5LJP3aRJ5FCSAKUGdfUsRq2Am//bMMwkM0D51fgwzyCLKNUH8Q
 cGoTqxTt1PLDjEGqsVgws5zJ0MXJk9QflNxjHssYJ0fBNCGJwzeDRcSxwxn5PfgrEnp1OoKvvTY
 wocMCEFK0mXKfFNog1Ak5Z730lEx0lyn43vJF4MrXgwFbbP5QbM1xVYCbsnpOjg9sMtQ+NUPI3f
 jFsL9aWqcBFoMh29RHRcJn+hTo2KNZkre7KuX2Ho0S+TdAesXx6kJg5Ls5k7Nt1BcMDjEfxgf0Z
 Zwb6EKK+bW0IgkPZTotAZWeJ72gA==
X-Google-Smtp-Source: AGHT+IFet4oF3ipLzuQgxwdZ7W/ZBhn8WJ1yZQ2S/Ru9BBplSlWM75SArGb+YUdhXLP9eZ2AVc4qEw==
X-Received: by 2002:a05:6830:44a3:b0:7c7:541f:64c1 with SMTP id
 46e09a7af769-7c94db476e6mr38209a34.31.1764709823213; 
 Tue, 02 Dec 2025 13:10:23 -0800 (PST)
Received: from [10.27.3.244] ([187.210.107.189])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90f5fe927sm7348359a34.9.2025.12.02.13.10.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 13:10:22 -0800 (PST)
Message-ID: <78f97b85-29b2-4057-8484-053dfd1466d4@linaro.org>
Date: Tue, 2 Dec 2025 13:10:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tcg: Zero extend 32-bit addresses for TCI
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org
References: <20251202011228.503007-1-richard.henderson@linaro.org>
 <20251202011228.503007-3-richard.henderson@linaro.org>
 <e336abf5-589b-49b7-98b6-9206ead80197@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <e336abf5-589b-49b7-98b6-9206ead80197@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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

On 12/2/25 11:58, Philippe Mathieu-Daudé wrote:
> On 2/12/25 02:12, Richard Henderson wrote:
>> For native code generation, zero-extending 32-bit addresses for
>> the slow path helpers happens in tcg_out_{ld,st}_helper_args,
>> but there isn't really a slow path for TCI, so that didn't happen.
>>
>> Make the extension for TCI explicit in the opcode stream,
>> much like we already do for plugins and atomic helpers.
>>
>> Fixes: 24e46e6c9d9 ("accel/tcg: Widen tcg-ldst.h addresses to uint64_t")
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/tcg-op-ldst.c | 222 ++++++++++++++++++++++------------------------
>>   1 file changed, 107 insertions(+), 115 deletions(-)
> 
> Was slightly simpler to review with preliminary patch 1.5 posted
> (consider taking it in between). Anyway:

I hadn't been moving maybe_{extend,free}_addr64 at all, but replacing them.
But yes, this larger patch could be usefully refactored.


r~

