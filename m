Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D29C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 17:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thXUq-0005My-Qm; Mon, 10 Feb 2025 12:23:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thXUo-0005Ja-Ot
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 12:22:58 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thXUn-0007Zp-8B
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 12:22:58 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso8624645e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 09:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739208175; x=1739812975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZxKItMBa6CMh5gmAKdypzeWgkVbkc2jWPlHO3gvO5Nk=;
 b=VSaVck2mfwZYMVzkXjETwHCjz7ia7oLitM/1+DfX8orkCR0liPg7rZkQTp0v3tUIi9
 PfN2jJTYv1QyLYKbuaUxWArU3GErDG5uKQOvZpt5WGXmsLlRPoQKGQeAnWEwUGnqLtNd
 3yOWzgngdhropJG2aKPZ/Qbu5b20TAvIIerG7cJI2bIi6rAVNIVo75X9W0KeVNHbN76r
 zs/K8CT0KU9POOmJGNqd9qAktUvQ1rdAAwmfKvghZy6A8DCQdVDLgyfkgjHd7ghLmSj7
 0zdCUB0enDpyhYBgE+i/mXFAkjV39HiPOkqM/P/Ky4vfFdqA5pY+r4u+N2CIIKdBgTmW
 piAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739208175; x=1739812975;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZxKItMBa6CMh5gmAKdypzeWgkVbkc2jWPlHO3gvO5Nk=;
 b=C2lacK3OkSZOobjcuQN87yHjX5rv262/BU9nrFjQ0xn05eH2UkuBVUOtw0EXUZfPi9
 U5RMZmabWEk/CoFPxxx38Mb9nW9rnQFvU1X/wV/JjAgx57WDn28daxAKzA+nLe0RecHR
 V2RMTAvQ+Fy4I1fu575D0I9f9O8TMUp81lYfcE+uJcb3QJaTOz4/OrKCvnREl8HQhm0J
 DF0sJ33bchcM5T12vOv3YS6D8iugtd2kUn5kB55/1yP17bBjw0bH/Q+CdQvIbqjtG3BX
 rhQUSmJzYDpoOFzRMqwXl40nF9PXsvYJkkDNTsJbd8XUKADQSW3+RWEocNZVQ8BjjlQO
 EC4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc6k3oryuhBhUm4w/M9N1nhro9rWvar2iaqcpPqhsrkv8PqMqMBhEWn1BtByswqWfGT4gAWltAo/53@nongnu.org
X-Gm-Message-State: AOJu0YzqzKEVXD7OD1Q9S/0FZF1yUgpMJ5W/tAMFzQdCmZvjmgAuZkp0
 pJc0/K4XnEPTEQUlDU39qQ75lb6EaG/BE2omWhXtftwTKcqqaZAo1aI2Ql2Yaq55nQYImyfp8fT
 +7gc=
X-Gm-Gg: ASbGncsmxukjY9uIJt9VfzNnnztfApLnuzZgmQOtWldXQQrQksVm475jyX4NUkmAKU6
 w+ViF1CUXwmCAWGAkt2PgaMtWaNiHyy5+40Z4EnrtM3zcW8YLzqoFv6jsn+hSnXL7zEgUcU/XLb
 RYb4Nm1LPa1OXDJ1t6XVZUL+vmRNqv6poUdsE2vzjzN/Hewl9CEiDur6lUyUwevszSagpLaovFf
 nY/6E4Zj0pUo5KYgDxhdGtP7J0FOzH3izBob8ZALyo7kzrIUqrwalmvtZNeuEOZlP9wtaSHgFzm
 gBW0s60MOIsop0LJGGs/YeyhAo+DL7Y/KoMlmSB1u+Ht/JPsSBEO6oE0X5w=
X-Google-Smtp-Source: AGHT+IG0TEk41y7B/w3WSj44zWrkP49DS25kVsbmgtCQi7k+D9M71z42VL9bPftY/PajGTJVG1XzCQ==
X-Received: by 2002:a05:600c:4f05:b0:434:a802:e9a6 with SMTP id
 5b1f17b1804b1-43924989da5mr138396115e9.7.1739208175204; 
 Mon, 10 Feb 2025 09:22:55 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd49d2cafsm7350912f8f.16.2025.02.10.09.22.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 09:22:54 -0800 (PST)
Message-ID: <2db2d180-b134-4cfe-a5be-b8542aff4bac@linaro.org>
Date: Mon, 10 Feb 2025 18:22:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] qom: Have class_init() take a const data argument
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20250210133134.90879-1-philmd@linaro.org>
 <20250210133134.90879-10-philmd@linaro.org>
 <37042664-844b-4376-ac35-6426b5e34c5d@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <37042664-844b-4376-ac35-6426b5e34c5d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 10/2/25 17:51, Richard Henderson wrote:
> On 2/10/25 05:31, Philippe Mathieu-Daudé wrote:
>> --- a/include/hw/core/cpu.h
>> +++ b/include/hw/core/cpu.h
>> @@ -170,7 +170,7 @@ struct CPUClass {
>>       void (*disas_set_info)(CPUState *cpu, disassemble_info *info);
>>       const char *deprecation_note;
>> -    struct AccelCPUClass *accel_cpu;
>> +    const struct AccelCPUClass *accel_cpu;
> 
> This to have been split out previously.
> It's certainly not gsed material.

Yes, mis-rebased with I misunderstood object_child_foreach() pattern.

(good eyes!)

> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks!

