Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296D1CF3195
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 11:00:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLfuB-0006pt-JB; Wed, 19 Nov 2025 05:59:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLfu8-0006mn-RQ
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 05:59:16 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLfu6-0001NV-AF
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 05:59:16 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso5118085e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 02:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763549952; x=1764154752; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mbxWBV2NfcpfZzpfmZ/gbOVV3RUfMgkdtdtA+NgIZ+4=;
 b=Z14NnzK2X7BUovsM/Pi0VDvfi4FkKqQ5o+mQirrhO1ORu/kpCRMAs/W7lD42yHYoxR
 2ctMDbDpm30WnWjSxBSzpIMgSm+D2UlegulyOq1PLapN7+M4X4hty/SihN/8nzDYUpN7
 kOWhD0TF/FP2k9cNwArViaPkLOILZzpaE/v/qxlQtDHPwwU+EkH5dQizlnc8jhvCEd4v
 NTbH9pNEowE4K6xrt/5x+NidaWwuZqE2FHOght/KjxWc5PUl7oBio+wfpQJ85S6gk1wH
 ZdFiOC0PbGEk3AdbMhXRFy9xS4u1OfSTSoUQ1M+SVtHPGoShNrk3VsX8HifzH8JfliSz
 6AeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763549952; x=1764154752;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mbxWBV2NfcpfZzpfmZ/gbOVV3RUfMgkdtdtA+NgIZ+4=;
 b=h/lolNumW2t9u4AE3eYotYWIRPJ+GdRAFJs9VOBf+yDDc6pIfSmECjNMdooAKBXjLK
 QSI0dnXYbTKVBPzYjvBh9rtdoSUydsxd4N9P3jk3jrM+7ro1+9LoWdEAETR79NnzicVg
 i8xwJftsEglIwsNTFZQpzDJsaCmf1ngnPGxrLQ4uWTIoJl9x6q0y4FZcoChPUvFxPkJa
 CYp1I7VJG0x16mcsEfcX+r5nnWRraQiCeYQCdph5Sf6Ga1ceG9EyI2r1crRIWsZrxvTz
 gg9PtKn+F2K5vR967n6fkafLgekJXyL3D8rxsOuITOML9XGhBcwFDf3XPAEqslYJ4egq
 ht4A==
X-Gm-Message-State: AOJu0YwvmvG+MiDQyqhc/W+rcLxPOCz/FDiWgaXsYbI7VYEu+XnLU6at
 +PWz5EdvQIf2bnfLrTPUK+wxLP+x2/jUUXQayLuM2k73DfnF7iix7e458w4bW7/t1Uc=
X-Gm-Gg: ASbGncsNPMB4j26Wm5mfHZVWhEfngV36WpJXS7qb4JsawlM3e27s/b4WI+oUaFRUD7X
 684783dchuiyAG/8dTdcvUNeAcHrJh96VCY6uuGOgOEsRnEJ0RvqBjwIcymbYqJMI+W9xZMZNJ6
 SdJtMNPBjRlLMGhNTfb5hVE0G/ZMD0wmpNl0DV/0dthK8fub/KvObUG07blDHC+nk7XuCguvMtp
 bg2ikIjbSif/MYDTb0v+3Yzx61K1GRXaN6bJ4Aq7a39lCtBW/CpXruPSOqPtyf+uRlE+vjkT0dW
 elbcUh6MzGzH064Z0GeMxNiPGhsMQA7UopAbNg/+567QsbeFHielqa4v7/dTS9baaJxvRNbcJoZ
 7m1LDZxF7wP2d6dCqBzszdf/TNa94kT0ri5UhO9YNtdF8mdblOF64g6nYH8V4bKbDEooHR5F+Zv
 1S8gTaEQQwT36asIPeUupNNvgCKRb4bJ7Y5AVrZ1wMlLY89pwKFJZGBX3qwt+r+2TMHwuL+9aoi
 F/olM6mNEkoVtie
X-Google-Smtp-Source: AGHT+IEvNHpy140G18dls3NSRTg2GOy5kqqIOTeqWf53H9Eczuxa8nr2cOzMuoBkKE4QAffPug72+w==
X-Received: by 2002:a05:600c:840f:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-477b18b3858mr20396475e9.3.1763549952091; 
 Wed, 19 Nov 2025 02:59:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:ed5:b1f0:90e8:1fdb:2cba:9db1?
 ([2a01:e0a:ed5:b1f0:90e8:1fdb:2cba:9db1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b0ffe377sm42026725e9.1.2025.11.19.02.59.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Nov 2025 02:59:11 -0800 (PST)
Message-ID: <a726cac1-9a4c-4bdb-986a-c240fb6c9de9@linaro.org>
Date: Wed, 19 Nov 2025 11:59:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: svm: fix sign extension of exit code
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20251115002644.103889-1-pbonzini@redhat.com>
 <3e215a17-11ed-4172-9598-42a2e1bd9e9e@linaro.org>
 <851ab1f1-c05b-48e9-a08d-2076fa9ab67c@redhat.com>
 <24c4e4cf-ddce-4e93-8f0c-33e48cdc130c@linaro.org>
 <CABgObfZHSY0AA1OFbjeOpx7GVhvdfBMYVXgc5h096q3QNK_Zpw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CABgObfZHSY0AA1OFbjeOpx7GVhvdfBMYVXgc5h096q3QNK_Zpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/18/25 14:07, Paolo Bonzini wrote:
> On Tue, Nov 18, 2025 at 9:31 AM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 11/17/25 12:32, Paolo Bonzini wrote:
>>> On 11/17/25 10:42, Richard Henderson wrote:
>>>> On 11/15/25 01:26, Paolo Bonzini wrote:
>>>>> -void cpu_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1,
>>>>> +void cpu_vmexit(CPUX86State *env, uint64_t exit_code, uint64_t exit_info_1,
>>>>>                    uintptr_t retaddr)
>>>>>    {
>>>>>        CPUState *cs = env_cpu(env);
>>>>> @@ -732,7 +732,7 @@ void cpu_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t
>>>>> exit_info_1,
>>>>>        qemu_log_mask(CPU_LOG_TB_IN_ASM, "vmexit(%08x, %016" PRIx64 ", %016"
>>>>>                      PRIx64 ", " TARGET_FMT_lx ")!\n",
>>>>> -                  exit_code, exit_info_1,
>>>>> +                  (uint32_t)exit_code, exit_info_1,
>>>>
>>>> Why cast instead of printing all 64 bits?
>>>
>>> Because in practice exit_code is either a very small negative value (-1...-4) or a
>>> positive value.  For QEMU in addition the positive value will also be small (less than 16
>>> bits); values between 0x8000_0000 and 0xffff_ffff could happen in principle but are for
>>> use by software and by the processor[1].  So the high 32 bits are basically unused, and
>>> the cast removes eight zeroes or f's from the log.
>>
>> Then maybe you really want the signed int64_t?
> 
> The problem is not in the type (int64_t or uint64_t work equally well,
> they're all just constants), it's in the format string. Positive codes
> are written in hexadecimal in the manual, so:
> - %ld makes it hard to match the positive codes in the manual
> - %lx still prints a -1 as ffffffffffffffff.
> 
> So all the cast is doing is making the log more readable.

Ok then.


r~

