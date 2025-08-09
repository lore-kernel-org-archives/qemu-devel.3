Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E6FC87FCF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 22:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uksGO-0007Ho-42; Sat, 09 Aug 2025 18:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uksGM-0007HZ-8z
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 18:42:06 -0400
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uksGK-0006hF-89
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 18:42:06 -0400
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3e543e231f4so1846205ab.1
 for <qemu-devel@nongnu.org>; Sat, 09 Aug 2025 15:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754779322; x=1755384122; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aYUaC+w1msnD21FD1YQF/q46+yp67v/LMkyamV0bwTU=;
 b=fNnsAO76Bv77iIWgRaW0fIJZVamcMzXFXRm4pq/oaFNvp7rqJ0zPEPtjsmr64ksHnT
 RCXgMKaSucnZYc6Bsh7CMuVW8HAuy2SvWAprXU4lQrOue98Ix/DHgO7qbMD/ZV0daEc6
 uxsazzDGA0pOOYlLhUdE4WYzbq+2YBpfSjnTHynkkqWy8fx4WnfaisCyeJ5A3fw5fHpk
 oFiX1ODsVtheKmssOk7xNZwNd9hc59eJ6muElCNotAaC5hS5+jUz5hB13l60UdBs+K3z
 l1p+EbtZ1doui/hj1ka8JT/wD/AoMg0ydH+Q9GDM2VgEy0LdKEBN0G6Y9kUSByl66xG9
 W8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754779322; x=1755384122;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aYUaC+w1msnD21FD1YQF/q46+yp67v/LMkyamV0bwTU=;
 b=nEArc5RPhmcf4CwR5sV5KRjVO2DkaCjut5HworL71Do3Uo9qkmOAPcRdlyuGqKoXgV
 3iF/9FzUdSI8LU5wksz+Qp06+SKyjyM1ceJOZMXzTgV61E4Kv6YqTDouGH059ibf7diQ
 6MMEmJC5vNes7zqV2QiiaoCnl0l93RXNItQVd+DGuj/bTfwST2eaerwFxP+ZPbAwLmbv
 q8NxQJK+Mcd5IKKkXyt4lNxGFqPIIPQ1WSvUzp5l1lYrDz94TrnMsGuo/s8+B/iBG1mF
 ByKPWD/Ow6mZcnpXKk4hum0XhGWtPb3tcF96fQNQJbCQ3+QGZhYIw7CqY2YGF3V0cDgy
 TSqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqIcV4o6Hewj9UVKYEYWr7pG4IMPagTHVVPiE+AIZ22/qIt9+fQ8fX+uZou26ml/oAF7kt2zWqIqh2@nongnu.org
X-Gm-Message-State: AOJu0Yw4Nf1G3ETlWJWyY6Y3vFGh9MhVq1H8MBTPLT/YLeaVSHOAiVpw
 pvVByd6eEqARFY+IYze7K62fXZiImQ+r+UeGrv0asbrDSW/AgBRbYpPiUPMEm1xjy0M=
X-Gm-Gg: ASbGnctSfIWJcsrRLrhEMDc2+a2isNuZjPLqfDAfSxR7ALmE50Y3A0kX9JyAYnmk1sG
 PASKWt9spkFpZiwW+RIyCkWGqxwHqSNPoMzZEfR0blw08i+zl2LxJLL3GMAvBbZGrJAhTxxC1BH
 Jjo9mFogdz2ROd4nEVW9/CeoBBz2/tx34kuBqcxZFJD1RgYJikmBdtenbBP5bhL4iybZadRhwIo
 OaerCLkke5mp3yOksO/WpG3WiZzMF+87fbQW6x08OqfWbuUBeDdg4XsVI+Ga41MB0TEPXlSXcUs
 /3ewo91AwpEP9Wk6ytdRyOP+z1qETMQY+TB5Hd3zDOu1rtjPEYAifmF3tFV0SnYoH7R/PDgnOzx
 HTyPA3G/VRihtA2pBzaC0PcoqdjW2ABwFi/DUE2KYMDG6ijFMiyy/NestbdmEWN60b2PyUyHWs/
 3Lsq5hTHyArhOjpuam
X-Google-Smtp-Source: AGHT+IGENvWHKO/HaWvjIPBtGtieSz4qjPpikKHWlJw5onVPrrmvLUkzhOx1XGtove8dpV8y7e9tFw==
X-Received: by 2002:a05:6e02:1d85:b0:3e3:ed80:843f with SMTP id
 e9e14a558f8ab-3e533aee918mr122727825ab.9.1754779321926; 
 Sat, 09 Aug 2025 15:42:01 -0700 (PDT)
Received: from [10.153.194.227] ([172.58.166.125])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e533bd1b44sm21029665ab.4.2025.08.09.15.41.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Aug 2025 15:42:01 -0700 (PDT)
Message-ID: <eff1c21d-bec0-44c1-ab82-5ec53de06c24@linaro.org>
Date: Sun, 10 Aug 2025 08:41:50 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] accel: use store_release/load_acquire for
 cross-thread exit_request
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, peterx@redhat.com
References: <20250808185905.62776-1-pbonzini@redhat.com>
 <20250808185905.62776-2-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250808185905.62776-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x134.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/9/25 04:58, Paolo Bonzini wrote:
> cpu->exit_request do not use a load-acquire/store-release pair right now,
> but this means that cpu_exit() does not store it after any flags that are
> read in the slow path.
> 
> Probably everything is protected one way or the other by the BQL, because
> after reading cpu->exit_request the CPU thread often goes to sleep
> (by waiting on the BQL-protected cpu->halt_cond), but it's not clear.
> Use load-acquire/store-release consistently.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   accel/kvm/kvm-all.c          | 19 +++++++++----------
>   accel/tcg/cpu-exec.c         |  7 +++++--
>   accel/tcg/tcg-accel-ops-rr.c |  2 +-
>   hw/core/cpu-common.c         |  3 ++-
>   target/i386/nvmm/nvmm-all.c  |  5 ++---
>   target/i386/whpx/whpx-all.c  |  3 ++-
>   6 files changed, 21 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index 39e674aca21..f189ce861c9 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -84,7 +84,8 @@ void cpu_reset_interrupt(CPUState *cpu, int mask)
>   
>   void cpu_exit(CPUState *cpu)
>   {
> -    qatomic_set(&cpu->exit_request, 1);
> +    /* Ensure cpu_exec will see the reason why the exit request was set.  */
> +    qatomic_store_release(&cpu->exit_request, 1);


While you're touching the lines, since exit_request is bool, let's use true (and elsewhere 
in other patches, false).


r~

