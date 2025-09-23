Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAADCAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 16:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v15o7-00022v-1G; Tue, 23 Sep 2025 12:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v15o5-00022P-33
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 12:23:57 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v15nz-00067J-G7
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 12:23:56 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-77f3405c38aso2218977b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 09:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758644628; x=1759249428; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yGiE9kKq6FAG1JtxfLXqMCUrbHIt+FTBYUuW1v8svrc=;
 b=WY8iCRHiCAw8WFpRGbCVNDGWGnMiIeDxkL6W7xbs+RCp4S3dgEHN9cbPmrWi3FBP92
 2d+Ye+Zr6XvWctdNhp75lji7TadyC+tSANTKlStzWLWy0fkOSCLHcsh91jbHaPhw3Izr
 MpKoUMWRcTTyq5n+jms1iPHtKYYmIrQ02nQNoxrw95+Oz57pnKkZS0+bhaPo5YL8hGuj
 3xhA6a312TUT82N9XtBSLSe98IkIa0Pf0a7vuOkr+Dtbs1X7JpixHTOdPVX+A+hmfPgF
 EGL4pBR7XXtbA2kdjjl63ssV8hU7Ul6hFxoSb91AvS1tDB77hqnU4w1Slq3ZQR3HQkbR
 fxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758644628; x=1759249428;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yGiE9kKq6FAG1JtxfLXqMCUrbHIt+FTBYUuW1v8svrc=;
 b=QpZPnir71+cK1EAfocdSg5Qf0P0R2PSGpOEt5IXKjo6u/rR+/tzxnbhvUCCMu+MJMK
 TcYv0Iz/eNMbge5211rQv5fYYQKnx2n7YhfVwtNeQSlP8XuWSEblUHavK9bIyiyTG5v2
 i3mSLEwl9QUFAS9KdtqPG3Ycql1Oz6hk4kOCy3RqfkzH0a23DUH7IshSLBCcDzQH4YFM
 RFMCC2m4xKllWN14Lvuu/L3vFwLEfbA8lyvOPASAtVKIqWqdmN2D5xSadMMQNAwiGucj
 7uA6/4Wm80ff4UgGYyRMZhsFnb5T3uiL656Cr94XtWzgaG7jIP98SulhnuBYCnY+AmXW
 NvkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMZNypE1mrAaMxeSCuR0+KZkbctLavI5Viu1aper2EZ/vjxrRoLFLZVEefsbmpitqU89TjPGq22dvI@nongnu.org
X-Gm-Message-State: AOJu0Ywf/qmGQNoJpXtpZ9DUEN+n0nNaqzEQCW98LkMHLWh06JUQz7iB
 OJCvb0Wkw827CkfyMCLKBMLMLCvXkuxg6OtSjY02EO1R6lKik+qmeCWPG2xG3SPyIGI=
X-Gm-Gg: ASbGnct96MWAP2xP7A170kP1K2XS+PRtHkYr4Qda9coZmH4qhyF4n4mqs24EqITjG/2
 5VFFwXCuVzpjH55msQaPfD7f1jGmcBmlMn55Lael/4QUJ5Ve7vahHjJdJb+d6AV42rlEtSX9sd8
 ZKFyFtDwW6bSGgx7+Mnf3hmlXke8dzVUYWww7b/Kk3zQaAt7NNMHbgPTsJYB2HNh+kIuhOuSczV
 bO6bFufBKYfzFN1JjqGGsuZwRBWk+mhiMkpW6LwIC0OPKXM5aZU3aZL/l3KnIrIhPrc0Iw4gu9D
 hfab3kufjJKudieg2P8NSbwkLMQXuXLeNuluDG9tAByKp+6V0mI6AgZCvt78nlqiAkH9rvwFUma
 JYfwl9Fh+WUYN5IydUA7PSc2FAg47dI/hN1u/
X-Google-Smtp-Source: AGHT+IEFXq4edNnnHTvp5jXkY8D6INRV9OIaLB3OhBqILlnS6RlgDqt09TcPKqa0UZyPNYp0GRFi8g==
X-Received: by 2002:a05:6a00:3e29:b0:777:8ba9:d200 with SMTP id
 d2e1a72fcca58-77f538b5db2mr3300712b3a.10.1758644628273; 
 Tue, 23 Sep 2025 09:23:48 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77cfbb7ab97sm16311859b3a.14.2025.09.23.09.23.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 09:23:47 -0700 (PDT)
Message-ID: <4f86aeeb-0ce8-49b5-a8db-e7f0d13125f3@linaro.org>
Date: Tue, 23 Sep 2025 09:23:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] gdbstub: Remove tb_flush uses
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
 <20250923023922.3102471-2-richard.henderson@linaro.org>
 <199f10af-7c15-4787-ae2a-8eb2714a1a22@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <199f10af-7c15-4787-ae2a-8eb2714a1a22@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 9/23/25 02:11, Philippe Mathieu-Daudé wrote:
>> @@ -174,9 +173,6 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState 
>> state)
>>           } else {
>>               trace_gdbstub_hit_break();
>>           }
>> -        if (tcg_enabled()) {
>> -            tb_flush(cpu);
>> -        }
>>           ret = GDB_SIGNAL_TRAP;
>>           break;
>>       case RUN_STATE_PAUSED:
> 
> To squash:
> 
> -- >8 --
> diff --git a/gdbstub/system.c b/gdbstub/system.c
> index f31d401e0b3..c139476bf26 100644
> --- a/gdbstub/system.c
> +++ b/gdbstub/system.c
> @@ -26,3 +26,2 @@
>   #include "system/replay.h"
> -#include "system/tcg.h"
>   #include "hw/core/cpu.h"
> ---

Done, thanks.

r~

