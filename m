Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81D9C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 21:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukUZj-0003XR-Ak; Fri, 08 Aug 2025 17:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukUZh-0003W9-B2
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 17:24:29 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukUZf-0000G6-Gi
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 17:24:29 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3b785a69454so1450856f8f.2
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 14:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754688265; x=1755293065; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fb+SfSoPZlynboeBUrdrc4P4D7nm+adi191E883lDsI=;
 b=UFA4/8WM6we/pnA3a387GV13z6IsN6ggpZ3DaTe6OTRRdg0O+xgGgb89V503NWPB6E
 ANVKAHYRKluvUXygYOvvjtmazsIKk1OIMdJ5uJFEA0fEY6552OaB+NVzLykpjiLfuBgP
 3HsOtfYgS+niX7KpEwL0kFVT9aSG3lVasDFkyJ2vAbhKmZsOm795qwfoydEhhs1hLqPY
 0xy5Q2YTy9EWagKzJaie0NJVG2HTDcLEe59W4NKvfV8sKHXqYTvnv/zTyhSK2DQtZ5/g
 Oksi5zbsFwpmzuvdPLePtWvngmRHPWZCEkJyhNZHRcVsFm53A9JDd3hc0/RufIgvFxIa
 D6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754688265; x=1755293065;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fb+SfSoPZlynboeBUrdrc4P4D7nm+adi191E883lDsI=;
 b=THwjTpcIk+A3SKH8VzUHM6Qz84x19WX6/uTVXvqz3oCwZ77J+XBK8uQSADXK8orwut
 kMlc3zoeGfjKPLycltTRKLxt2jDmyIXAGsD597ekCJ14gvkTLoZVUVxCV/GmIimyoOOy
 1VDyQ1WALfd/arBQfG4PnMgu6ybPovZhQNepd1CjbsH+O3Ta4HRj633oq4ygkHugIaCV
 Jwh1EwHw2gZB1n9xwD6BfcC8S3pbpVPWgLYw1Zj8Bm+I4DJUQb/gpjGQbbwaFXLw/uW4
 AYUe7DU844X/SD0oQfXhffvt442t613vymFHXM7otuvLqianA/Dp9X66wr+T626/cRvm
 d5/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVeMGos1k2S2ExKQqmOV6l1dgnYmVUMpeatLfCfEfF2eRbLQKLVdAb9av2tQVBSTkQuXeAI7Ufotnx@nongnu.org
X-Gm-Message-State: AOJu0Yzo1GGy9Mz+Kz39CV0a6rzhvOxXR1gfOXOPD1gsPvZmsgQSTvRa
 PW76+wg5+k9FniXJy9AW9BqqMa5PZkvSLmTfcIQ26B/RTtfXmfgJ4Pbqolh5UlswLxM=
X-Gm-Gg: ASbGncvwi7HY52K1TfdESmW72jqobAVKZsUHOW8Nf6AbM/BJUZ0JwD1zctMpkrQvfAG
 qEQlx21K+hAHH9zJjGOoHOaBp+X7we8v4d7fhVsoBLHwtKvU3Z3kr9yX3pyjzPAeOU+ovoW2/8c
 9SKa4ij23EzbT/0yPf68JB4/bJmIx0Pci7dqEytSfcAvBeX+gaRA5TfYbpNix2HNmN1uSzA3n+Y
 0UcWw8Sumc7DiuHFKhHaGESuENlzYsaNqGrliLWO1rDfW4b7FmeLnbPWVJfO7XyZEligkOtaj/u
 9MZcxefe0p0Flq0RmuCJJfw8YeqapW0EihM16RcM6Fyq1egmh/iDpvll8nz6jMiSylFIsGn1RRp
 t5xwcfH3PiMmCPIjeL6ff4H0DunPpbFj2A+LzitxcUE7ZL4A51pw66RVjEEAxadUNEQ==
X-Google-Smtp-Source: AGHT+IFabKx3FUcHOawLppjwKK3v58/iJ+nRRKpyBfNMXmDhjahnhlPgd9MVV3l5/i5HQQXrPudngw==
X-Received: by 2002:a05:6000:144e:b0:3b7:95b7:92e7 with SMTP id
 ffacd0b85a97d-3b900b6a21cmr2937109f8f.52.1754688265531; 
 Fri, 08 Aug 2025 14:24:25 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e075047fsm104951015e9.1.2025.08.08.14.24.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 14:24:25 -0700 (PDT)
Message-ID: <50f36e7c-c274-4a1e-9fba-1a70c492e3f6@linaro.org>
Date: Fri, 8 Aug 2025 23:24:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] accel: make all calls to qemu_wait_io_event look the
 same
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, richard.henderson@linaro.org, peterx@redhat.com
References: <20250808185905.62776-1-pbonzini@redhat.com>
 <20250808185905.62776-9-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250808185905.62776-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 8/8/25 20:59, Paolo Bonzini wrote:
> There is no reason for some accelerators to use qemu_wait_io_event_common
> (which is specifically separated for round robin).  They can also check
> on the first pass through the loop as well directly, without setting
> cpu->exit_request for no particular reason.
> 
> There is also no need to use qatomic_set_mb() because the ordering of
> the communication between I/O and vCPU threads is always the same.
> In the I/O thread:
> 
> (a) store other memory locations that will be checked if cpu->exit_request
>      or cpu->interrupt_request is 1 (for example cpu->stop or cpu->work_list
>      for cpu->exit_request)
> 
> (b) cpu_exit(): store-release cpu->exit_request, or
> (b) cpu_interrupt(): store-release cpu->interrupt_request
> 
>>>> at this point, cpu->halt_cond is broadcast and the BQL released
> 
> (c) do the accelerator-specific kick (e.g. write icount_decr for TCG,
>      pthread_kill for KVM, etc.)
> 
> In the vCPU thread instead the opposite order is respected:
> 
> (c) the accelerator's execution loop exits thanks to the kick
> 
> (b) then the inner execution loop checks cpu->interrupt_request
>      and cpu->exit_request.  If needed cpu->interrupt_request is
>      converted into cpu->exit_request when work is needed outside
>      the execution loop.
> 
> (a) then the other memory locations are checked.  Some may need
>      to be read under the BQL, and the vCPU thread may also take
>      for the vCPU thread can sleep on cpu->halt_cond; but in
>      principle this step is correct even without the BQL.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   accel/dummy-cpus.c                |  2 +-
>   accel/hvf/hvf-accel-ops.c         |  2 +-
>   accel/kvm/kvm-accel-ops.c         |  3 ++-
>   accel/kvm/kvm-all.c               |  2 --
>   accel/tcg/cpu-exec.c              |  1 -
>   accel/tcg/tcg-accel-ops-mttcg.c   |  7 ++----
>   accel/tcg/tcg-accel-ops-rr.c      | 38 ++++++++++++++++---------------
>   accel/tcg/tcg-accel-ops.c         |  2 --
>   system/cpus.c                     |  1 +
>   target/i386/nvmm/nvmm-accel-ops.c |  6 ++---
>   target/i386/nvmm/nvmm-all.c       |  2 --
>   target/i386/whpx/whpx-accel-ops.c |  6 ++---
>   target/i386/whpx/whpx-all.c       |  2 --
>   13 files changed, 31 insertions(+), 43 deletions(-)

Great!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


