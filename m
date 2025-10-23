Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCE3CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 18:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBzql-0007yc-Af; Thu, 23 Oct 2025 14:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBzqj-0007yM-4x
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:15:45 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBzqh-000648-8D
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:15:44 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c3e26d534fso783969a34.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 11:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761243341; x=1761848141; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x2kl15loVr2HBhCYVWwgrTR9MffJF/yQB0EHf9rOLQg=;
 b=KYa06g6EViXFMFVySjfaSYRjgEqvVgMmUzzRo7ZhED/tqoyIsKFZmnhVqkNrzxnX4J
 y4PgTxH53syqU47rD8hK9QuoiDi38TbWKJUfB33mXSzErm+w4qhqh01TO047XyUgVT3o
 1TagXoyXl3AbQwrTK5g77t2oFvCgkZBHBC7fEfD8clOSzJNZ7T1YVicp9+0LXttB4eNx
 pENhTZN2ckjr4j74XTk9hetBIHlm9ZXdFRJ5+bzJWupJW0heqZiaWByN1Gq2oWAobu4U
 lwS+FsFXw93jyDoJmDUkNTJKuqIfX8ZBIEGFTISasfYjXcdEAI8JN0dhQ1wD1oV1/YJB
 JvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761243341; x=1761848141;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x2kl15loVr2HBhCYVWwgrTR9MffJF/yQB0EHf9rOLQg=;
 b=YqufTizSWMNfVnTg/a2apuEty8LMo8SSq3IdMFGi42YhP+fnKve3crkYQKzbyVJXi6
 5LjPPEXYNR+1d722cNV51MA53wn5o/tWIq17gHXWA+cXltys+pCouP1zEtgyIg/wb7bj
 P0hOSFiwGb4IPkW/RVSdqfj79gmrDq0rBfQfTaPkehf5deskQgE9vvUYqWQzSWd7yhiZ
 jHVDo8MKqjjPdckUXI2VtxhIfVyeKe293VnkV1sezSF8Wi0Ukde7lmnliT9OHbA+xAPY
 jtYxjamLb41S1QWjlitGDGYdjj5eEYDXdt3BidAmZfnXC0tq0S5cfej9eDuMH/b5qQMg
 EGRg==
X-Gm-Message-State: AOJu0YydduH34oN2LhyXz9Eu1RFoMkblxzZgppJAI66zaESFuiokUt9u
 5ua4mbEf7a1afYg8qTHg43HugdwKHwK1wjcKGwUi1ytGSBrf2OIjo/ScOVL6nuJrkMs0+X3cD9R
 /AiST
X-Gm-Gg: ASbGncudC/9skvG53yF+vRWo+o/XxRqxsKy2WXOGkpmkxSRrtuTiI18F9KUwDx/8DcA
 fwhLQ6ssH/bNCoxaUhbTb0A78h8oZMjIp9NmZZhPuoXNtszC7rXbyVWVxIQC+VaBevyeOrp5IDU
 rJF296h4ILmWZR66FfM+h0B6fR+eV+LckeI/bVex8u2KubLZgPD0AfamQbnOJV+NYvSv2v8xHoK
 YREAXczLMC3iSX/i4j3rfoaBBl8PMLqWoKAq1SXTW9u5C7aFvZO8/M+fjXPQJkn5aRvo4OfD7g0
 5Fr+xsIyrIGemNZCsyGFRvjIFoaAY51+ZODaJydvv5TZDzawIIiKwC4oZxVmmDMkRljXzgGdEni
 /SF79y8+zWziEKTHA4wWEOG3qkMk0GBEiijtLd35OJD8tnQRqvh0Xg4Vj0S/V1cXlCJSMrNX0cE
 NAeivT3i/XwkrXJUvNm2Sor8w09kdDMXWNesSm7M17vAVgJD8hMU806BwRWsWy
X-Google-Smtp-Source: AGHT+IFtmMfsoQMPkQB/jB1XziAVbDn1e7zpwG9BCBGXU9+lpK1Dslo4NJhCkRP8zT+KyCt7X2Webw==
X-Received: by 2002:a05:6830:4407:b0:7c2:78a2:7703 with SMTP id
 46e09a7af769-7c27ccaa341mr11717540a34.26.1761243341189; 
 Thu, 23 Oct 2025 11:15:41 -0700 (PDT)
Received: from ?IPV6:2607:fb90:8ae0:85c9:1b89:4cd2:87fd:d3df?
 ([2607:fb90:8ae0:85c9:1b89:4cd2:87fd:d3df])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c51b059913sm812979a34.32.2025.10.23.11.15.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 11:15:40 -0700 (PDT)
Message-ID: <325c46b7-54fd-4793-95f1-2dc6cc44869c@linaro.org>
Date: Thu, 23 Oct 2025 13:15:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/37] riscv-to-apply queue
To: qemu-devel@nongnu.org, Alistair Francis <alistair23@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20251023041435.1775208-1-alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251023041435.1775208-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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

On 10/22/25 23:13, alistair23@gmail.com wrote:
> From: Alistair Francis<alistair.francis@wdc.com>
> 
> The following changes since commit c0e80879c876cbe4cbde43a92403329bcedf2ba0:
> 
>    Merge tag 'pull-vfio-20251022' ofhttps://github.com/legoater/qemu into staging (2025-10-22 08:01:21 -0500)
> 
> are available in the Git repository at:
> 
>    https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20251023
> 
> for you to fetch changes up to 741566c3e07fd34ed28d4464d1d7fda67db12925:
> 
>    target/riscv: Make PMP CSRs conform to WARL constraints (2025-10-23 14:11:45 +1000)
> 
> ----------------------------------------------------------------
> Second RISC-V PR for 10.2
> 
> * Correct mmu-type property of sifive_u harts in device tree
> * Centralize MO_TE uses in a pair of helpers
> * Fix Ethernet interface support for microchip-icicle-kit
> * Fix mask for smsiaddrcfgh
> * Add support for MIPS P8700 CPU
> * Fix env->priv setting in reset_regs_csr()
> * Coverity-related fixes
> * Fix riscv_cpu_sirq_pending() mask
> * Fix a uninitialized variable warning
> * Make PMP granularity configurable

Something in here is causing failures on s390x:

https://gitlab.com/qemu-project/qemu/-/jobs/11827080939#L5859

It seems obvious to suspect the endianness changes from the big-endian host, but I also 
don't immediately see anything wrong.


r~

