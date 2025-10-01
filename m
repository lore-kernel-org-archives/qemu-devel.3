Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAF7CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rWD-00068v-8g; Wed, 01 Oct 2025 03:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3rVy-00063p-N6
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:44:46 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3rVm-00006W-NA
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:44:39 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e48d6b95fso42447225e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 00:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759304654; x=1759909454; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5mvOurtfVgbsknJplVVqBtHhH2OZfJOG3WCz7BbXb2k=;
 b=gskbckEq1LXsJtyp4645Qdp2SP6Uq4hMVWtq7JsssWYy7tFlzuYK/vCHkfUGNez53C
 Cis385r2RVW0DPXlsbsCIU5NhntUKj1k0eyjshBmqWud6fPlS6Scu9b346dI/d5ufoaC
 AHmMrCh2lqZUup9kttYpJsBG/tj+z8+xMiNBrdRGsCeTUYMtda14KelUBr1jZ5c74iir
 yMb3M8FH4uS4oeXT9kptvT8ZBR0SbDefNqqzPxFhxlK7AdSu9CzFeHwIkQAk6l7Dpf20
 SHSv7hPsp0jJIJriIcakl75AKg1W7TaKDSh3wvgnaDKey6gIaRWDCmj88A1JZH0WDG4d
 Ubng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759304654; x=1759909454;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5mvOurtfVgbsknJplVVqBtHhH2OZfJOG3WCz7BbXb2k=;
 b=KLbmvw7Zcw/M6ABI6pyg+5WBTSjmQi0v1tNt4ryu32ULZ0zGdtZq6HdXlLECDo2BVf
 hHy7e/4UM0cE2q9NRQOSklLk2BHyZS8GHYKHFgqA1IWBg/MAPHhaT3pBKzkYtUpxCW6i
 9a4BzQ6Do5h0Wn37mSQsr55IDY3sJ2oOvHx5clAbbzaWWQ59tSIoElIyXvShKyChkWkM
 u1QH5WaeF3QR4ayd2w+m0Li8+FKfRkV44fdvxeWrBlFd0IMzT7i8lzTAWQ3i+gtWCOlz
 2t3PyHn6Bp3SYQy+T2KOjL44tj7V662VFljUzrdDQFWcb9Gh/bafcpRy7vH5plImCe4S
 ZeDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdUhuDBja7800A7QYurCbiGiwuB4aBw4cb5v2mHtszisOCDh/bNr0jXYmCw+gN9eX1PoEXNDc6xspy@nongnu.org
X-Gm-Message-State: AOJu0Yx0VKUJvkTj6GpszPuME2eXs5wctOLB5xkhVylLVbknXldeg3DM
 GqVHTO+VI04JF0IT2baeijZfjkNGjUeHd7a37LXeDbLwKbxqxOu+rOKzq1HO6xTd3Ws=
X-Gm-Gg: ASbGncsTmrfYR21/g7wRM9Md64KTbj4FZJsKu5tg+l51sXuOfvEMWwqrV+P2xsrWf0b
 2Sc6rXkr4w5KSFwRsBzUdwmhA9NjiR2GEjtsagYEDGWtnUNEAEJ6QFBr5iV/qjDXVri9jh8Mj+m
 /wB4zBoGzkLPg9NkyUO+kG7eU6KXZh/ykk/4fMJdS8QzsFfxmWP0FdEin8wBVJBNQl2AZozlIFN
 /ued0z+6ZEHZpR0Oou3C6cFaXLD4RJQKzDrB+WRj8ZMT/iAOfjzINU7fjGDgIa9Z/HS4u0yA9uH
 a3oj4dlaVCnUhhJMycxnAGs+h9MRCg8lfoEjFy4eF0S/ULxEYSEVb3ZIwUOJrH0yhC4QKlQCAfR
 jj/e9k5Mr1CpTWwnK5JNUEWJVRltzh0gbeVMFz/CbHCSk86Mb9JcMnwKRS/dANXsAL/nOAEjmSB
 UvqG/Ybw+qIYtN2cxJo4RMJlxb
X-Google-Smtp-Source: AGHT+IG/iE4QZTmtSmACiRnpr27mouIG13EzcQpXpgPE9tMB8O9doVa12m6ueYCjAz8a6H3ttS6U0A==
X-Received: by 2002:a05:6000:607:b0:3fe:efa8:7f1d with SMTP id
 ffacd0b85a97d-425577edcfcmr1645676f8f.7.1759304653886; 
 Wed, 01 Oct 2025 00:44:13 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc7e2bf35sm26306890f8f.53.2025.10.01.00.44.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 00:44:13 -0700 (PDT)
Message-ID: <0f8deeef-4862-4564-ac5f-12dfaa12ca89@linaro.org>
Date: Wed, 1 Oct 2025 09:44:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/33] target/riscv: Replace target_ulong in
 riscv_ctr_add_entry()
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-28-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251001073306.28573-28-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 1/10/25 09:33, Anton Johansson wrote:
> Widen to 64 bits in size to hold all relevant values.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h        | 2 +-
>   target/riscv/cpu_helper.c | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


