Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1475D277CA
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 23:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veMN5-0002mR-7o; Fri, 09 Jan 2026 18:58:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veMN2-0002ly-LR
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 18:58:20 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veMN1-0005uQ-2O
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 18:58:20 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c4464dfeae8so3177909a12.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 15:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768003097; x=1768607897; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mje2gOjYiDWt65hk7u+4Nn3vGSdkI0p00DoobJfq0k4=;
 b=r31m3FcqEgJi3Pwc6KEiFIfArSC68RBMb9ff1ryaWuwPMJE5PeH4uSCHD5jR0mBorW
 yHyZct2WQZyHrJCWcr8ZmKUmJSlgEUlF39PE2c1gU4U1CTehbM8u4lHpU76A+Fsbn3ya
 rEXRi7sBp+j1P9AH4ncV+QTeIJH6S9Y3JaS0/CzeYmH9yJnhOjTxMsORoRStH/aLXoop
 4xQwK9Ajn7JDvGyC9usaANwy5rQVI3QfEoGa5T3i3AUXNvgxrldxivS8SX4bC/9qV8fw
 dWkjM8fx3zILzwEk5046/arffv79BFGyAYEcykONeDDJQa1KvsTc+kJcez1bnseFA32z
 qLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768003097; x=1768607897;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mje2gOjYiDWt65hk7u+4Nn3vGSdkI0p00DoobJfq0k4=;
 b=fX6DFc8P8oJRfJeffcXyWFAk2DWqJLp5SWZXi1kouKXpVY4yeETJ14OB6rsd/knnSe
 howT/qUWE4F5sJVWGwar/5Fzm2AOScadUcKIfdpRKPs/2DE2vi368Kj77ALQPt1mhXE+
 ebgpx5iGQ6WsqwzRV6pJGH4jzakb+x9HNfUq3eo6eOr6+0PGUDz4S0nNmcx7LobvWuK1
 1mb9mequ/Bls08tKJo8M+TZA59oD0IG0xZBhgrSHOIHYu63wmLdP91R52bEOASZlDOst
 X0bjIr6ivhw3lthV9D0CxcjgXuN7Ak3ApFqp9XflL6Z98rSuXdTXp3dBwaueVEj2u7Wn
 1Z2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQsKKzMkw6765WraAY5rrA/Uir+cREK1a0Xd5sKATfjXd50rgj+D7TX5PN66fnZNuzCbBciGfKgtYi@nongnu.org
X-Gm-Message-State: AOJu0YxrmevBzxNLzx8MElI/PgC0nqo5YhKt0oAi4dtkepekTV3myAd5
 vW6+dJZSYYGKHGTS21WNwsIwia7IF0J0UIeynsH6yWdDQKv2V7CIK2p2u/JK0p9iWy4=
X-Gm-Gg: AY/fxX6ALq0pDh4supP7X3Ke+UaiM2sKvPqmrF6tvrDRznMUPSU4mRoW+/5Ej9Puj/r
 qtXO7Y9ekRE9Qe05spKQndTr3f8ru9EoRBlRdhBwyW+ynfkdU2YCLPKAYGT2fKATBwyGdhYxnRW
 wuZdeq18usTYkj2rhfaGrmUyRmdR1yIiMAAg9kaeKy3v6sAlF9UV/rGKEjKLSkV2yB3a7fJE+bb
 iplU3iyDAG8Y6RBTOvvpjuxdkhp+JGh2W8Eik8mQW+86/eHm2LZL83nD7J/nvOA6Dsn4UZqgrh5
 RuBi9eL7bhKV1/OWPhDhxQt15/M4vSJ/IcprY1wEHFCJ+DwKBJYI4ZdMTxWhH2Y6np/fNeDSCx0
 iE3/E4f7MIziHV5lUFNkbHDX43AaNep21/T4+i/VgjG247DmISv/hklXWfEb6rdTD6X8FYWI1lG
 /urlRFZp2MOhb6lvgsKlwdTfk+wQ==
X-Google-Smtp-Source: AGHT+IFZQyB6rmzCce5gjEcN/OfeJ6usyNf50MGnxCA8S8RMUsB5Qk+6Wbjjkywgg9tEuSO0RY1b7A==
X-Received: by 2002:a05:6a20:3c90:b0:364:1349:add3 with SMTP id
 adf61e73a8af0-3898f992b72mr10630490637.48.1768003097356; 
 Fri, 09 Jan 2026 15:58:17 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cbf28ebe4sm11656140a12.4.2026.01.09.15.58.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 15:58:16 -0800 (PST)
Message-ID: <1b7465ff-d645-472f-9bdf-031f10779442@linaro.org>
Date: Sat, 10 Jan 2026 10:58:10 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/18] target/s390x: Remove unused 'gdbstub/helpers.h'
 header in helper.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <thuth@redhat.com>
References: <20260107130807.69870-1-philmd@linaro.org>
 <20260107130807.69870-6-philmd@linaro.org>
 <9eec8c4a-c6fb-4c47-8701-1afec420f5b7@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <9eec8c4a-c6fb-4c47-8701-1afec420f5b7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 1/8/26 07:09, Philippe Mathieu-Daudé wrote:
> On 7/1/26 14:07, Philippe Mathieu-Daudé wrote:
> 
> Updated description:
> 
>      "gdbstub/helpers.h" uses target-specific symbols, but we don't
>      need it, so remove it.
> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/s390x/helper.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
>> index 8d1e03f6768..a6c89ed0af3 100644
>> --- a/target/s390x/helper.c
>> +++ b/target/s390x/helper.c
>> @@ -21,7 +21,6 @@
>>   #include "qemu/osdep.h"
>>   #include "cpu.h"
>>   #include "s390x-internal.h"
>> -#include "gdbstub/helpers.h"
>>   #include "qemu/timer.h"
>>   #include "hw/s390x/ioinst.h"
>>   #include "system/hw_accel.h"
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

