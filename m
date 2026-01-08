Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF43CF6ABF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 10:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdn95-0006er-Sg; Thu, 08 Jan 2026 05:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdn93-0006ef-T5
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:21:33 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdn92-0001tJ-1L
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:21:33 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-8035e31d834so2425712b3a.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 02:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767867690; x=1768472490; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QOBacYQyOfWUdZjzcUfi0s6M4s/gzbaFtqccFxsVF7o=;
 b=VrgaOAd3izeKUM9mMG4jeDi2luOpEpPSodN5wYf0rrIOs6viLCmp6dK/9miKeEMQ6S
 cVAZ1EOif4N8dyEEmEohKuZZ5YOJOH6uQW7WIyp35CX6/KZCzQR3ahn8RoUfZME4cJ1t
 c+4RfNuK0uka9EeBUN7kbYvtE+Gm4/Ct44GF7Wa+wRPxmTeYx7JFxYzwnInlR5evXibV
 UdvczB9tN9EGEQSZw+2GJ8q6ahqrqBkvwGP6oDG7BICvgXzFZni61yWe2BdNk0eOdu6L
 NwmBApkScKszRtZNAQsLkY/+7tdQyyjo0rsH20WEP7ILHcSqC/DUyNfds3Z6uv02yH+u
 Lq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767867690; x=1768472490;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QOBacYQyOfWUdZjzcUfi0s6M4s/gzbaFtqccFxsVF7o=;
 b=ag1WelyYPF4aZVkU0tMzLRKQpsADkst0IJWVUf7EbU+sI6cbqojGJRN0HB+TEhmTGm
 UpHwWkj05NO7X9uys2mAXK8G6O/U0+F4I3T79NK7wyDZ2Np21Rpvp+BMvCF+WTAfVS7L
 u6ZnopZCNCtOQ3x9/rzwmfsVKUj7Owe6V8jqqGDZT5IqGzC7nmM/PQt5oAyKDGVpUIBn
 G4jXZbCVtFgxz99W3iuM6R6mq1yI3yvDGWg1mRp1Hlg9lyKiJ0/k/K9vyqueAkPyNiAD
 Md1Hp1lM07OU7DRbIDW9i7FiUTEfIogy9Z9jv9fLZ/nKJc5mCk0QjQrW5Q9V4t+AJmJ8
 KFPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5S+jzuen2GPP6r8kmMNHK0exrBXQ/P1XCD2BXlOh2kdSfhHpNM3IOoD6JbF9JG7vZBPtRYWJX6BYT@nongnu.org
X-Gm-Message-State: AOJu0YxmYFepy8f3IFAbpywYM8ji3bACth5c9/1i9un0fYuedK+HfHmj
 gtOCqlHiHsSRWVgwoET7+bhT4jLPDmkV0j7x6zkmS2yyctQYBraAY6ArSCGg5xMcHSY=
X-Gm-Gg: AY/fxX72PFaUGPDBkdHlQzZUJX57RYqVB1ox8/y6C8Weid9UNhIVLe+ITriCyt/VK61
 94taYGkBkBhdMB+d91uD8lmyJzU6gu6Pn0uIiQwe3ATcZF3IYNDFK/SwY5AXjfQ7Oh1PqI94efr
 9HRrtc01c76qP4iJzOLGTR0EgPc6ymE8VL8J7wY8RrqjrNFxxkzIDxSW02roBDSvrD+RJv4RASy
 WCel3L1QZcU3R7h9fxXEyKegD87K4xoF1rLn4gIirnnrWz6c3os4d9jbj5TkC8ExiFCNInGRj1z
 2E2AEHh4oCS1AAYVGLj8Ame/Zy+AdHCCclAkgiPl/MO/udqqzPZNR9lyDZLAdGTp3/k6J2Dg9Hw
 kPtWvNlEQb0IxuALzq8iu5wqZiPS0MxCneWmnonvkudLp8o1qx1LrORGbWIe2jdQN+l1I4BW106
 N8jJf9LupMfJn/y5wLGZeg/NuGk2SEEVQ5O8JXkUno
X-Google-Smtp-Source: AGHT+IFA8GQjIZM6EXMZBt0XpRcGIIdcm2PI5/l2R3UeyeBUI0A5ZT7fdFZ0FJqq+Yr+jKxg5o0QoA==
X-Received: by 2002:a05:6a00:2c94:b0:7e8:43f5:bd1e with SMTP id
 d2e1a72fcca58-81b7f9d33fdmr5945734b3a.51.1767867690269; 
 Thu, 08 Jan 2026 02:21:30 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819c52f88casm7324164b3a.34.2026.01.08.02.21.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 02:21:29 -0800 (PST)
Message-ID: <f4e95447-941e-47d8-8923-3817cbd4bf5b@linaro.org>
Date: Thu, 8 Jan 2026 21:21:26 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/50] *: Remove __i386__ tests
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-6-richard.henderson@linaro.org>
 <d59e4ffe-87e5-42fd-b803-7c0092b062ce@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <d59e4ffe-87e5-42fd-b803-7c0092b062ce@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 1/8/26 20:47, Thomas Huth wrote:
> On 08/01/2026 06.29, Richard Henderson wrote:
>> Remove instances of __i386__, except from tests and imported headers.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
> ...
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 2060e561a2..63713f1992 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -7449,15 +7449,6 @@ void syscall_init(void)
>>                                 ~(TARGET_IOC_SIZEMASK << TARGET_IOC_SIZESHIFT)) |
>>                   (size << TARGET_IOC_SIZESHIFT);
>>           }
>> -
>> -        /* automatic consistency check if same arch */
>> -#if (defined(__i386__) && defined(TARGET_I386) && defined(TARGET_ABI32)) || \
>> -    (defined(__x86_64__) && defined(TARGET_X86_64))
> 
> This looks like we should keep the x86_64 part?
> 
>> -        if (unlikely(ie->target_cmd != ie->host_cmd)) {
>> -            fprintf(stderr, "ERROR: ioctl(%s): target=0x%x host=0x%x\n",
>> -                    ie->name, ie->target_cmd, ie->host_cmd);
>> -        }
>> -#endif

The block doesn't look worthwhile to keep, IMO.


r~

