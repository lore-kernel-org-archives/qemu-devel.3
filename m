Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFC5CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 16:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcQjh-0004Kx-J0; Wed, 24 Jun 2026 12:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcQjf-0004Km-VD
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 12:45:59 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcQje-0003H8-I5
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 12:45:59 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-37cae9b7536so951128a91.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 09:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782319557; x=1782924357; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TxFalI+M6zuxV5N/1aMvN/+6kvLL+xMkvljOLUpYpzc=;
 b=C6VWiU2Zus2JZbuj3BPA4U2zsixU3rSnO4uHNMB53XMPLNAEVRotk3e/iGVYfi9OqF
 s9ljQ5cl/sL9YYNn5DsFAAx+7FCBGDr9ERv0goNI8lmIcBmHFmY5DgwfNrIMS4GxvE2X
 iEhLG+sfMwFBgi93Y1SgEHnVGG+mZLuA7zEWv05aUJoBTv01AOqiSFDe5un8eyWnfjJA
 06rhBsYv4U3fZrVca1hNVzenP6d6OmjCOsCRNEb3HdQpi8AVnwpRsxEN3r684+mHtQsy
 Odb+9gfwPSltbwO2AET5Hlbn5MvMFSddxhqfqh25mExCM7xrvJH42BrZbfTALYO5C0Xv
 Cqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782319557; x=1782924357;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TxFalI+M6zuxV5N/1aMvN/+6kvLL+xMkvljOLUpYpzc=;
 b=h3EorsW0CZBFHCh8udNWw6IAVB6j/WrH0DAfgVLD1B7fBJmDL+biLwFj82gwsZud7b
 HqAmwmMMUNboThtlsO5qoQv5Z5sWllI0itd1DzI5/L7Wc+Vd0fh/qQHU+CI19qzrkiO2
 G7i0SP3UYW+/zEY3XQLJuhXK9ScyhORXm5HWIqo6Q9inpHSwk68Sg7Co8g031OQn1nMh
 ffD4TGHLD7dVky2UpfHwclftBtKQA8dLA9IkUmxWjjn1Tbn85QyL1auCToTKzgx05aEu
 BE20Qw42F/EmkKwRQDFHBFIrBLSGj189/OU+X2dQSjXvooCpAuuoVB78g9IYsq7DmSiq
 qxlw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrvQzKlJDdOYP3or1orhdvcjF590i6kpp3MJkpf+diBMKLfXxArcRCp40t4Rycii66ZPOnbUBZy6NL6@nongnu.org
X-Gm-Message-State: AOJu0YwEiTZ4nYq9NT8DagD6RmIAjAAejGNt6+N4tUjNEZHcJmzAB5xK
 OX0zGjXxq9+ykOPgZqOj7w0C7hByi/Oovayk6TkjQklTpzm4DklS5LBCXXqqZL2dNEo=
X-Gm-Gg: AfdE7ck30GiuSihZ3wfJxl7O9DcH/Ip5m/MLa/eeS3WkaoGHyAnxU73ArqgqdPmAFtt
 xw6sbnXsa1JPZkw2bdYmuA8AXxYPi+0iB0jyURpFdT4pVu+pnFDpgkpxdi0MMFh7cChcb2b6Scx
 tkgZ7/o3QCpl+Ea1IQd14m1cDYmHIcWP7qyRLyhFENG/p/zKLxePrpJs5ZmfQp1ihGcNXeoRXyU
 ylm0U3gPVsoFeQLymeJxNTy+Gg0OUNvLF9uL6V32Hvv/Ts0ESP7d4kaJemJILIhwjxwanksO5Ax
 IoLGQwZ3HLDlHHMyG9az9YOZaOJvknYzlZvPpzAb/474VYR8ALykjV4mSxaFMe4iRJDcN6C9J8J
 jVfOl4ByQXR5QsjM+etl4qxsQ7xd6Qa4Fiscr0XQvlCogj2W+17sgnR0fPG0rlX6A8bsKL5O7xR
 Yz6VfogvF3mwjMt5wsbEZxFU7pulQ3JhrCx/21Phko01oGzZyA51b/dG2H6tOhE1DVHijG
X-Received: by 2002:a17:903:3d0d:b0:2bf:1e59:d99 with SMTP id
 d9443c01a7336-2c7e1442a31mr43054205ad.8.1782319556610; 
 Wed, 24 Jun 2026 09:45:56 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f5b04be8sm2179345ad.35.2026.06.24.09.45.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 09:45:56 -0700 (PDT)
Message-ID: <7c6f0c09-cb4a-42ed-80b6-fa5ab977cc4d@linaro.org>
Date: Wed, 24 Jun 2026 09:45:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/tcg: Remove per-vCPU
 ignore_memory_transaction_failures flag
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260624154950.47345-1-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260624154950.47345-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 6/24/26 08:49, Philippe Mathieu-Daudé wrote:
> The %ignore_memory_transaction_failures flag is meant for legacy
> machines, and is defined once per machine. It is applied to all
> vCPUs such machine creates, to be eventually only used by the TCG
> SoftMMU layer.
> We can decouple it of the vCPU layer by making it a TCG-specific
> global, setting it once when the machine is initialized (via the
> per-accelerator init_machine callback), allowing to remove machine
> code in the common vCPU layer.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   accel/tcg/internal-common.h |  2 ++
>   include/hw/core/cpu.h       |  2 --
>   accel/tcg/cputlb.c          |  8 ++++++--
>   accel/tcg/tcg-all.c         |  3 +++
>   hw/core/cpu-common.c        | 15 ---------------
>   5 files changed, 11 insertions(+), 19 deletions(-)

Nice.  Perhaps note PHASE_MACHINE_CREATED comes before PHASE_ACCEL_CREATED?

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

