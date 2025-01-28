Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7471C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcsMy-0006cv-7X; Tue, 28 Jan 2025 15:39:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcsMv-0006al-T7
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:39:34 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcsMt-0007fL-PS
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:39:33 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2166022c5caso97761305ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738096770; x=1738701570; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0m6gfdZfDonnsI66KDe3RyzYXNsfMO17neQ9nUSBVYE=;
 b=ihDtCu8EEwNXaF51XbEig7Em4bSMEv2eVG0SbKMRVCpiqd/Bec/2AYvwW0SxeGyvto
 npBm3PE0W2XQ0GLElF5P03dy5VZiNOOwsefc/P6EJQkKf1RSv3EefA1EfxMBcmtBY74v
 /25ap4gKZZ/LJjw+4PpK3chCd+VkMCVK4h6fr6BwrFpGGkP8ufhg2X551n2yLOY5ok3K
 3UYJj/JwRujmPYbBq/pGJXOkS7wYWzj2tjHLc3cyPnYQWvj7VXvkPmSrjeA9HXC1qqK3
 8Sjy/boa2bm3mfZ3NvTHKWE0HPHF02Lcs4BMidZj9tmxjqQ2rPNPQtIQWobD2XukcTYF
 Qb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738096770; x=1738701570;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0m6gfdZfDonnsI66KDe3RyzYXNsfMO17neQ9nUSBVYE=;
 b=Fi8nrK2KTRWxJsyudr8pP62mbM06MRj6XlXsPmgTogm7oIfS9+joatGmQtpyvjhbC0
 VmM9SaTw0TO5RViQuAZxQhVu2olMv1194CmQNNIwJO2/53BvkJgWjvnn5nYb/iYAWJpt
 WuId4o1pSzQ1L8f99JgBo00AkuA/vAjXJrG9uQg9o93C3efUJcCFh45ofJofaeNQ9YGL
 KPtga0Yq3qPE3EBUP/RtDBJokETUyxPcDTpZjBOo3aU2OrtQCgLLSnVsHGiwqoqDqDX1
 FefOfV8jWKUorhxfOx6o/keof169QnEfrcVAT0NkliRj2itlH7LhQ654X9oUN7Zdp+LD
 /JEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPlRLRGvE37g67gVrgPOX+bgQk5D7JvXSyEgxwSb8TvUkwbiwqVDn5LnryAm6vlKKXpZkoNbcoae8U@nongnu.org
X-Gm-Message-State: AOJu0YyJNqAYL7lCmAkZcsnRPyQT5J3RLro9kZErK7RSBz+nruOAeJ6/
 SZfXicXDgYc4qa8ZFPdCUKq9O6NXwwTNDGBq798Cz0Sy5w+JbFN4mi9cB5D41lE=
X-Gm-Gg: ASbGncvFaJ9u4n4KIAbpTuVd9mIbm9P020wPQoGLrCX+NU13YUdPQtyZtZajflbkPQv
 XbmYctrlgdAOa/j6rcK1xd8ONgtV1LBRSTXzVGLA11ZuQOF4OGy0+dTgmDe/F2r/I4kPkeEY2SJ
 d/XpP5h8vdg2ezVkAPRccfaj1REWbuxugmXTCZkBW4QX/x5tNwA0lmgYVSVEP8IcqbaCZM9YCNC
 5huEsGjVVwSgRrHuVQkZBSXFgVBrNhiDkf9iRa1dv85Bp/9rm43kwBVJnzkpjCxaBX45w9h9fqG
 pdN2TIbEsgcFigaYU0iwNIsgv6dkTio7mbKhVWh8cMHL/Csm9CUo4ynxcA==
X-Google-Smtp-Source: AGHT+IEn9YS06OeYDPQIxTG4TK6aeOsG98QHjnXvqTb++MpsGWzFfJ2DMMjIG/l31Hb1PXLRQsQmvA==
X-Received: by 2002:a05:6a00:ad8a:b0:726:41e:b314 with SMTP id
 d2e1a72fcca58-72fd0c623femr920016b3a.19.1738096770029; 
 Tue, 28 Jan 2025 12:39:30 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a760e42sm10003743b3a.100.2025.01.28.12.39.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 12:39:29 -0800 (PST)
Message-ID: <f60d500d-f299-4d4c-b857-29e34b33416d@linaro.org>
Date: Tue, 28 Jan 2025 12:39:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] meson: Deprecate 32-bit host systems
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, stefanha@redhat.com, pbonzini@redhat.com,
 mark.cave-ayland@ilande.co.uk, Liviu Ionescu <ilg@livius.net>
References: <20250128004254.33442-1-richard.henderson@linaro.org>
 <9a280789-9248-4eca-b50c-048fc58e3f53@redhat.com>
 <87plk72tvr.fsf@draig.linaro.org>
 <ad6ca73a-c38a-4a9b-bdcb-ab50aa53ccd1@linaro.org>
 <Z5ii-ueFt5-5Brxz@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <Z5ii-ueFt5-5Brxz@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/28/25 01:27, Daniel P. Berrangé wrote:
> I'm not sure that's the case here.
> 
> 32-on-32 is already effectively unmaintained, so we're not suffering
> in terms of keeping the 32-on-32 code reliable.

Correct.

As evidence, on i686, the absolutely easiest available 32-bit host, we have the following 
failures with make check-functional:

>   2/185 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-aarch64_rme_virt                  ERROR             1.50s   exit status 1
>   3/185 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-aarch64_rme_sbsaref               ERROR             2.69s   exit status 1
>   4/185 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-aarch64_virt                      ERROR           206.84s   exit status 1
>  12/185 qemu:func-thorough+func-ppc64-thorough+thorough / func-ppc64-ppc64_tuxrun                          ERROR             4.95s   exit status 1
>  17/185 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-aarch64_aspeed                    TIMEOUT         600.01s   killed by signal 15 SIGTERM
>  24/185 qemu:func-thorough+func-ppc64-thorough+thorough / func-ppc64-ppc64_powernv                         TIMEOUT         480.01s   killed by signal 15 SIGTERM
> 115/185 qemu:func-quick+func-x86_64 / func-x86_64-mem_addr_space                                           ERROR             8.92s   exit status 1
> 132/185 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-aarch64_xlnx_versal               ERROR             0.35s   exit status 1
> 147/185 qemu:func-thorough+func-m68k-thorough+thorough / func-m68k-m68k_q800                               ERROR             0.88s   exit status 1
> 156/185 qemu:func-thorough+func-riscv64-thorough+thorough / func-riscv64-riscv64_tuxrun                    TIMEOUT         120.01s   killed by signal 15 SIGTERM
> 163/185 qemu:func-thorough+func-x86_64-thorough+thorough / func-x86_64-x86_64_kvm_xen                      TIMEOUT         180.01s   killed by signal 15 SIGTERM
> 177/185 qemu:func-thorough+func-x86_64-thorough+thorough / func-x86_64-linux_initrd                        ERROR             0.35s   exit status 1
> 178/185 qemu:func-thorough+func-x86_64-thorough+thorough / func-x86_64-multiprocess                        ERROR             0.77s   exit status 1

8 of these are due to the test asking for more RAM than the host can provide to the guest.

   Output: qemu-system-aarch64: at most 2047 MB RAM can be simulated
   Output: qemu-system-ppc64: ram size 4294967296 exceeds permitted maximum 4294967295
   Output: qemu-system-x86_64: ram size 4294967296 exceeds permitted maximum 4294967295

Some are probably trivially fixable, simply by asking for less RAM.  But the point is that 
no one has reported the failures, and I can only conclude that no one cares about this 
host.  And if we can't keep i686 working, then other more obscure hosts have even less chance.

I'll also note that those error messages above are misleading -- in at least some of the 
x86_64 cases the command-line is "-m 512,slots=1,maxmem=59.6G".  So we're asking to 
reserve physical address space for almost 60G, which is not what the error message suggests.


> We're suffering from the complexity that 32-on-32 code places on the
> rest of the XX-on-64 code that we do care about.
> 
> IOW if someone volunteered to maintain 32-on-32 that's not actually
> solving the complexity problem, just perpetuating it.

Correct.


> So again lets be clear...
> 
> Either we...
> 
>   * ...want to kill 32-on-32 code to reduce the complexity on the
>     main XX-on-64 codebase regardless of interest in 32-on-32
> 
> Or
> 
>   * ...want to kill 32-on-32 code because it is buggy due to lack
>     of maintainers, but would welcome someone to step forward to
>     maintain it
> 
> It sounded like we were wanting the former, not the latter.
Correct.

Frankly, no one has stepped forward in the last 2 years, the last time we mooted 
deprecating all 32-bit hosts, but got talked out of it.  So I don't think option 2 is a 
real option.


r~

