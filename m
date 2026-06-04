Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E306FCD6E6E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 23:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVHuP-0001Ot-3y; Thu, 04 Jun 2026 19:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHuM-0001OD-U0
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:55:30 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHuK-0001PO-Bu
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:55:30 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-36ba706ab46so887442a91.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 16:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780617326; x=1781222126; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vHDS4aMpMK5Y1Kz0vp0t7rHq2Wt93CEbb3gvEl0QSQ4=;
 b=Oz2WkKpLs66h1NAjW3L53eicKTUShsLW8Xoa7pmclUWc9ApeDWF5v2UgmNLNkpxNQU
 kSLo5uDw7mriDwKihwpPWaZ22+C00QU4YNaHZ24vva1x7rFc2i4ynR9fobF4CieMLEyW
 Q3pg9bXSsnvTi/Re0XqmY3V5bH0mo7TSC2cVGrzNM6OknnNBNu41BdQ+PW+Ldl3ztwjk
 S25VetJNR8+6tIahKt4YB3JWlKGB5wasbblwlFDknDOosS93Bf36EHlSChFDuJ7FdLvG
 LJOD1l1npUMjAY9wSzBB8As6+VNoBtA2uja1Gu+pixkXSadmGOQK9ABX6ntgVwevYIf8
 fAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780617326; x=1781222126;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vHDS4aMpMK5Y1Kz0vp0t7rHq2Wt93CEbb3gvEl0QSQ4=;
 b=W2izZCwCDedhCjIAmsP8KZKKG4U3fESWkCv2s1+/cI4Qrj+GeVxq9snKbNVD7uYte2
 IQCvgaHE44WpQj6Eg1lB8BKYVg6WzCinkES11OjvLL4u3il/Z2dVLsM1f2r7nEZ+YpAK
 UToqtAxpSr967dPGFhHk4AUNKIEL5DpQdzERR0QqaArUb9AhdVx7+EwnjO73+/WjnhoH
 YrQcsGJC6GE3OaWWlTwtygTrdPtQAfcTt/fMiBPNbGbFKaoQ4NmqrQwQbDU+5KB6gfVs
 cBppVjfVNpJIIIaiAqyK0lC5mVNrK6h0wLH2tss85J1Oi6c0oOFYpsDKFcxeQw5m8y4D
 8dPg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8pIyHPAbpLKUxgEmhFnWm+xqPMdkn/wdbiCcC539chv22z/+G4KgtNyomGvxqJ4ynz0W2dC3gELVx4@nongnu.org
X-Gm-Message-State: AOJu0Yzrrs+/Jf3kwtPqKbOVHPsFbgCfTPWji7GPLjLRrRimdRU+mo0P
 mkSphyR9+mzYk+BhsPw/XLFoL3FMjwQOaljc7if6SkaZ1giwQ8mHqg7ABmg63369i6E=
X-Gm-Gg: Acq92OGZrrbwamumuKkFgzTGq57rwBYQS5Jdhx+AHgkwBTUJgC0VOfhv7Lcra68J5qG
 /bXtlPVUDMwWY+X9p6va7P9n8Xpf3LE64Ta3ac3PIYGwaJc79cIwQvz6jysOKkw3kEtRkOTJDDG
 1MfFO5cbMBbqWkpZ5+p1qZDzIKaxWF4Xrw6WrFZheGdQuIPAwZMAVfJx837gcIhtJl/ZjthPXjk
 7ErHBEsX9N8drJrViRru8bq+/UDKMPdtz/FwZ93/wR4tRdZ5dvxB2ySLZjORSj64aMnc7DgO8oK
 xfNMb5ve63qEfaBh1iGy8ov9A1hQq/PEvGPU9f5MrAWwxayl+jxAPXn7xCWglN/ufOIaC3WCSI4
 0FDSvBxRe92x/1ts1SRnuCef28sHKopivM50XoCEfo5AQJdmid5k4dYIrnT4cKiJhXmy8WLVdDb
 OagESCDGqBQjRJ9GaFdyxnoBC13udemXVrIX9GxdnYXfkGSQk=
X-Received: by 2002:a17:90b:4a50:b0:369:7421:b36f with SMTP id
 98e67ed59e1d1-370f0c4ecf2mr1019585a91.21.1780617326420; 
 Thu, 04 Jun 2026 16:55:26 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f6bf827f1sm5484180a91.3.2026.06.04.16.55.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 16:55:25 -0700 (PDT)
Message-ID: <fc032f29-f22a-4ac3-8a33-acc8eb46f974@linaro.org>
Date: Thu, 4 Jun 2026 16:55:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] linux-user/alpha: add coredump support
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Matt Turner <mattst88@gmail.com>
References: <20260526190535.10833-1-deller@kernel.org>
 <20260526190535.10833-4-deller@kernel.org>
 <27b8facc-9b5d-48c0-ab84-6a8cedaa1672@linaro.org>
 <9454aa45-8e52-4fc5-9570-94d1ff66bf26@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <9454aa45-8e52-4fc5-9570-94d1ff66bf26@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/4/26 14:44, Helge Deller wrote:
> On 5/27/26 17:53, Richard Henderson wrote:
>> On 5/26/26 12:05, Helge Deller wrote:
>>> +/*
>>> + * Matches the kernel's elf_gregset_t (ELF_NGREG = 33):
>>> + *   r0-r30 at indices 0-30, pc at 31, ps at 32.
>>> + * r31 (hardwired zero) is not stored; pc occupies index 31.
>>> + */
>>> +typedef struct target_elf_gregset_t {
>>> +    abi_ulong regs[31];  /* integer registers r0-r30  [0..30] */
>>> +    abi_ulong pc;        /* program counter           [31]    */
>>> +    abi_ulong ps;        /* processor status          [32]    */
>>> +} target_elf_gregset_t;
>>> +
>>
>> But see dump_elf_thread():
>>
>>          /* Once upon a time this was the PS value.  Which is stupid
>>             since that is always 8 for usermode.  Usurped for the more
>>             useful value of the thread's UNIQUE field.  */
>>          dest[32] = ti->pcb.unique;
> 
> Ok, what is your suggestion here?
> Replace ps with unique? According to kernel this then should get the tls value.
> What is this then in linux-user?

env->unique.


r~

