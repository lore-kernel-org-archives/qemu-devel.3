Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4551D68BCB
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 16:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tByoJ-0004rM-St; Fri, 15 Nov 2024 11:04:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tByo8-0004m4-VL
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:04:29 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tByo2-00046g-T9
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:04:28 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37d495d217bso1556095f8f.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 08:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731686661; x=1732291461; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tRwx5X6o7HQU5QotGoEOz/I/pAt5G+gNOGikPtmFw1w=;
 b=L5t+dR86nKik4g9gRVz/ZCKuZFUGv1fdAqthbaIytnWpKgeQuMOzQ1wfOxAJpK3sL4
 Dt5Rnh/OL6qbJHR4YhyrV/2F7F6NH+WurPy0FVhXh1DITNbfAXj0mYeWXayAY2cFSK+8
 rXh3MA2DhuCqBaCRR2/EIT1C3dpnWXHJuEUNoRwE9WWDlIeucbtPPt+m9wYaXmvX29Gv
 TaIZQG/Pg71vcsxg13gwdBlfnuWe8Hbq/LkseVSrrV1QC5WsHhjr+HMawt++qAnskrk0
 wVHVIB2xDio0p9/TyNItRBCmZhUyqzwTBPLjfdCikxskh64yjCL0JPZzBNn+IUK7Orm1
 5c4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731686661; x=1732291461;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tRwx5X6o7HQU5QotGoEOz/I/pAt5G+gNOGikPtmFw1w=;
 b=dZ+zOzy81VqUKlzWrFrbuSNpZYa9HbprJNdYgfzX0lkyI2wdOt2f/RRIz+LVSBlYKK
 Vqd+iDoGNvONe52a/PZtG6Pi9YWRpF4u5hGDFC9+xY5uiVhGQ9Herw+glCmLFZImRhW4
 h8V6u1SUbACPL5odqcRc3l2kssx7XIunwOXyx3gN+sgJD2wLhg8tZW54QGP/JPW212zi
 ZBatGCo3oM+kHBaAuXahMAGlzgYt71i/igVTdFyxoI6MYwgvcD2zT7+h83kzSHSKHzxn
 iFpjWWo+fQmV03A5j7m86x93Qtw1lu4XQlTJlFhcxsHCvtFnmYcjdVTMwDE7foZxcuqg
 G5gA==
X-Gm-Message-State: AOJu0YzuAx/L7NiXySAFuwNj3zpEt5k+VY23Qyh3/2PuUSdTl/Ctn0Dw
 Ms0epurdIIdj38OIpY96RO5tlE+dOB1HlrR+hfSVdXlJIx26Ais32tAAk+9TQ84=
X-Google-Smtp-Source: AGHT+IFf2ANL/uzhkv+XzVax/Yp8GKMTByS9TdobmoT22iUoRfmlH8O0uw7HSOaFApSDtuIfJ/xntA==
X-Received: by 2002:a05:6000:4289:b0:381:eb8a:b81b with SMTP id
 ffacd0b85a97d-38225a83ba1mr3158251f8f.33.1731686659294; 
 Fri, 15 Nov 2024 08:04:19 -0800 (PST)
Received: from [192.168.69.174] ([176.187.214.209])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae2f651sm4901689f8f.87.2024.11.15.08.04.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2024 08:04:18 -0800 (PST)
Message-ID: <26531687-7f5b-49d4-8a1f-e7a414d971e5@linaro.org>
Date: Fri, 15 Nov 2024 17:04:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] accel/tcg: Move cpu_unwind_state_data() declaration
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20241115152053.66442-1-philmd@linaro.org>
 <20241115152053.66442-6-philmd@linaro.org>
 <CAFEAcA-07TbFe1RYs47qb5jsmdQ1eH70+5nVVB5+3jRaFKhzAQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-07TbFe1RYs47qb5jsmdQ1eH70+5nVVB5+3jRaFKhzAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 15/11/24 15:48, Peter Maydell wrote:
> On Fri, 15 Nov 2024 at 15:21, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> cpu_unwind_state_data() is specific to TCG accelerator,
>> move it to "exec/translate-all.h".
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/exec/cpu-common.h    | 13 -------------
>>   include/exec/translate-all.h | 12 ++++++++++++
>>   2 files changed, 12 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
>> index 638dc806a5..b36fbf2a39 100644
>> --- a/include/exec/cpu-common.h
>> +++ b/include/exec/cpu-common.h
>> @@ -193,19 +193,6 @@ void tcg_cflags_set(CPUState *cpu, uint32_t flags);
>>   /* current cflags for hashing/comparison */
>>   uint32_t curr_cflags(CPUState *cpu);
>>
>> -/**
>> - * cpu_unwind_state_data:
>> - * @cpu: the cpu context
>> - * @host_pc: the host pc within the translation
>> - * @data: output data
>> - *
>> - * Attempt to load the the unwind state for a host pc occurring in
>> - * translated code.  If @host_pc is not in translated code, the
>> - * function returns false; otherwise @data is loaded.
>> - * This is the same unwind info as given to restore_state_to_opc.
>> - */
>> -bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data);
>> -
>>   /**
>>    * cpu_restore_state:
>>    * @cpu: the cpu context
>> diff --git a/include/exec/translate-all.h b/include/exec/translate-all.h
>> index 85c9460c7c..f06cfedd52 100644
>> --- a/include/exec/translate-all.h
>> +++ b/include/exec/translate-all.h
>> @@ -21,6 +21,18 @@
>>
>>   #include "exec/exec-all.h"
>>
>> +/**
>> + * cpu_unwind_state_data:
>> + * @cpu: the cpu context
>> + * @host_pc: the host pc within the translation
>> + * @data: output data
>> + *
>> + * Attempt to load the the unwind state for a host pc occurring in
>> + * translated code.  If @host_pc is not in translated code, the
>> + * function returns false; otherwise @data is loaded.
>> + * This is the same unwind info as given to restore_state_to_opc.
>> + */
>> +bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data);
>>
>>   /* translate-all.c */
>>   void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
> 
> This function is used by some code in target/i386 and
> target/openrisc, but a quick grep suggests that they don't
> include translate-all.h or any other header that would pull
> it in indirectly.

Oops, this slipped to the next patch.

> It also seems a bit odd to move the cpu_unwind_state_data()
> prototype but not the similar cpu_restore_state() (which is
> also TCG-only).

OK I'll move them together (clearing "exec/cpu-common.h" is
not easy...)


