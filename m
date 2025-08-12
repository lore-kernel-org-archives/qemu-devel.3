Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045F4CA0EDC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 22:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulxTO-00021l-G8; Tue, 12 Aug 2025 18:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ulxTM-00021C-S3
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 18:28:00 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ulxTB-0007SN-SH
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 18:28:00 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b427094abdeso5516926a12.3
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 15:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755037662; x=1755642462; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3RnmojMkff3wTajQMcpgl2BoyW/3jnA55jwakIRN5aA=;
 b=OT/t9xH8aK1t3/w8VAOeuOllyBBSfsPfvumybNvHWqzN9bkAPYTfSyyOKneaPSvLiQ
 f5nuGJ9A7zILFY2BQZmLGKdECMUrZ9nQvjBTuYbSEaRAREz9Qf5H7SNzEgVXrGJd4nmk
 yu2CHLZ+s31kuUULiXhepDk9pYM6VAMQqmfQBTQxqwI0jsHYFA+Nuc+aDWBITwzcjdIv
 NoyeCx/KJH1WdfV8TR3x87/XuXHk9r/a3kGP5w2ZLo3coVmX0Ct8ecox2vatD5Rrplbg
 RoyTi4GV+cKpTYbDQNCx7/jAWeWWMnYoBcF4cyt6Bi7dNOgoRuTIRjrEhc3KRFK9/O/q
 LLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755037662; x=1755642462;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3RnmojMkff3wTajQMcpgl2BoyW/3jnA55jwakIRN5aA=;
 b=L13PLtzrod0eBqlm/lRp0iB3FFjzgNFisxykUFDs0fGciAuucT0d1xU0dwxbjQ52eL
 +UK1d/ZDXexzX/OpCmBgjvaYUnnFnlArQT7mVf8BORdzFUpUm6Y/L2Tyx1qmnOE7Qtc5
 oK/kYfDciM/qbhfyJxuBc+Cz2xie8f/3c6ltvq7x1m9ODaJFEnFK7gGGWlNsHDZ9KYeG
 7MTEhLN6kfA0qjUsH9E1fxYegYkaw3NY0dQB5oMOxBFIAQvhzw//iDrOWGUByCAJHwPr
 /ldSvG9zN4vHfCxYs3mUNM1itXwf5ZDdCOOGr4c35slH1cHegS30MbYbCHjLfbl/W0Vg
 bBZA==
X-Gm-Message-State: AOJu0YynM+w8KHJESc5rJDNms/U+P9hRbQqf0A6aLiv+WCEP+Otqt0Fb
 fLrkPoQpAxDrw7BJ9oh06huYORQW2bxN8WQL5xd98Eg2hb5if6L8W/+VGoZCJGi2mTAar5shu2/
 P1WoaKmE=
X-Gm-Gg: ASbGncs2trlUU5/PJRItSrsvHHb0O5Q4ZnbOMdkmkPdxNHluOaACqk8Jiub7vMydOQD
 SavWafD7zU8q5J2Uhzt+R1TTTGvilvpZ3Se/VJrpKuS53kAJvp1wVJ8QxNXPeY1O/F16SIZp7rK
 HWDzZ1D53FQuWCNH7uID9/ptZf9MWKP+k2NgB2SzP3ct5peAyRhjlmhl/LchG9dnU8U1qn9dzAp
 xF8B/yEC1CMYc9nzxUMseZ28z3rnK5xkg/0GeEEgHbi6RXtMzTZeIiiQPIHZAifVjT1FmpNpv7m
 TmGv21jKCxhc90fxHotyi4fv2m8BG8jxrtVGhTjZs7rEdEIVLNlSTEYApiF3wSINXpVE1G72/Bz
 /m+GlTt0nA2avrcLKzmx6k9W+1XpQ+9ODUL31A7eq
X-Google-Smtp-Source: AGHT+IGyk0byUtYWYGhV60INaQDOFf0NC80T9gT8pulOOKvu59XxsUbB16w2FShb8S7hTE+V3Q6HPg==
X-Received: by 2002:a17:90a:ec8d:b0:31e:c630:ec93 with SMTP id
 98e67ed59e1d1-321d0e6ceefmr1087263a91.16.1755037661988; 
 Tue, 12 Aug 2025 15:27:41 -0700 (PDT)
Received: from [192.168.4.112] ([168.140.255.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-321d1d79ebesm202898a91.6.2025.08.12.15.27.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 15:27:41 -0700 (PDT)
Message-ID: <1d054662-86f7-4eba-858d-a278f6a7a247@linaro.org>
Date: Wed, 13 Aug 2025 08:27:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 07/10] target/arm: Replace kvm_arm_el2_supported by
 host_cpu_feature_supported
To: qemu-devel@nongnu.org
References: <20250812172823.86329-1-philmd@linaro.org>
 <20250812173131.86888-1-philmd@linaro.org>
 <20250812173131.86888-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250812173131.86888-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 8/13/25 03:31, Philippe Mathieu-Daudé wrote:
> Use the generic host_cpu_feature_supported() helper to
> check for the EL2 feature support. This will allow to
> expand to non-KVM accelerators such HVF.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/kvm_arm.h  | 11 -----------
>   hw/arm/virt.c         |  8 +-------
>   target/arm/kvm-stub.c |  5 -----
>   target/arm/kvm.c      |  6 +++---
>   4 files changed, 4 insertions(+), 26 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

