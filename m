Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCDAD0D17C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 23:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdd1z-0002It-QD; Wed, 07 Jan 2026 18:33:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdd1w-0002Ev-BR
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 18:33:32 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdd1u-0005bq-R9
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 18:33:32 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-34abc7da414so1688799a91.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 15:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767828809; x=1768433609; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rceQyFvz/zOIVCBSgxaQ+4S6S37imC/uqA2mw0zYJ/c=;
 b=GxpwiOnd5riFFT/b402tqx/uZGzTJNtxOvvwf30p/o4FoSBFs5IjI5rIo5/GcQIpHr
 7vhVIPenfimpcj1Cf1jjSELM9l3Z0jZByH1Kd6LfvEdVuzD71sJRFc+VM/3EzQEPPtY7
 1Ztw4zlunagIA3X0Gxfqi4EYEvLb0fD/Zy3W123gtA/fTkxIJMZha9KbmU6dN1qDBKLA
 od55MVMhGyg3nrWYx2kSsWl3BmBbrjDHNGs3o+AAnZoV8cG5JIZt7B1I83qnIRaUEUXs
 IvEAQhVM/CX7E42OMFdwkw1SotqojbriWClal6n/BiMABdL8IWjsKd+pbVmkMQGipBt7
 8OJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767828809; x=1768433609;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rceQyFvz/zOIVCBSgxaQ+4S6S37imC/uqA2mw0zYJ/c=;
 b=sTB2UYHYjCeLE2e+qAKceC0StTpE6DNR8T3zlqvaa803UNp2hNOGVmuTAdom10nap0
 V6wCBMGzF5VHTwp3wO+o/QdJ1e2IJsuNgf2saEZsTTl6vHYi2DCGPyXDevPhOM9mg/lz
 ppOsGW+fgPo2E/VWpQNMJ2+JtKP/J0g+EfIs4AJRswdbrRlbOh1fFjvf+1ioo8woQRM2
 TYK4sjgjNt/Iruq45HCVnSCL51ExYo52pVFSXbsLKlTJYbz3rjkLTk/ewf+OBeNxQ7d0
 8YoNC4AcFRoZF957a6UU/LvGC7dtI3bw/DRRhl4Z2xv/vuEGy/AQ/A5TwXba1tpoSc0N
 KujQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4RKScsPMjQKoDjmMOCgJi0CGVmr5t5soc7T1UQhuaOp7SEY4cAvwodg1EO7y1j+hLmi0mC+emZdVg@nongnu.org
X-Gm-Message-State: AOJu0Ywu9g4G1V79yREnf4yOLD0G70+n1PG1VneMzrSJejwT80lKx9by
 B4QkH6/QpzDnTwJm5IdfGy9vlOe3m4Xrq661LhJg1cKx6HAJEzG//Yu6Rd/25GWb0oU=
X-Gm-Gg: AY/fxX4P1rjmk8JBJBSmb12I9HciNpzQSMQxRO9f/pqNkRNtR+OlQLrS+moutwFtUoc
 ZOfz0E6AjROHfQRS7Z2R/fdfytrTxSvve1RnS2Ct/ZKsGTW6L1E95QQ7LtSPI0tUGNz+KAF+gDd
 5E7Yr7AKIth00Ey5ndH7BBYfii3YmIn9a0MBD1/edyp7bmaeA+ca6N1AqVY7TktmxJf609zRS+f
 2Y+5rJ2YLf0QjIsOL575wv6qXfdrer5BHCPCVHK4HHLGW1S3l9+KXct79/9UD71euCI2xU3sAft
 o9TxyHCoxFE8nfF0ziJJcHg66QnYkghoMlHJDhl9d0C10gZoSyONMNDLMNDchwR0KtjBWpN5IZQ
 h90EPP2tJhAon/jvluqDhOsoYkLTBcF2qe+92ZZf4LxaBE/YmmhzexBqRCWVugVTZY0v6/xFPsu
 8cEMFTSQ/7dWAge/k8SD5GQwshQjFu/Q==
X-Google-Smtp-Source: AGHT+IGeaNKPQgDNy3rpzg7DuDqyaQsgfsbmaAJdZvmYD21s4ITG2gVQFFjs13gOaLHvui3+0LAq8A==
X-Received: by 2002:a17:90b:5287:b0:343:7714:4caa with SMTP id
 98e67ed59e1d1-34f68b4c72dmr3525287a91.3.1767828809446; 
 Wed, 07 Jan 2026 15:33:29 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5f88efb5sm5981400a91.10.2026.01.07.15.33.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 15:33:29 -0800 (PST)
Message-ID: <283b729f-d898-4326-bdf2-1fdb581439a0@linaro.org>
Date: Thu, 8 Jan 2026 10:33:24 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/i386/tcg: mask addresses for VSIB
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20260107151400.273916-1-pbonzini@redhat.com>
 <20260107151400.273916-4-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260107151400.273916-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 1/8/26 02:13, Paolo Bonzini wrote:
> VSIB can have either 32-bit or 64-bit addresses, pass a constant mask to
> the helper and apply it before the load.
> 
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/ops_sse.h                | 16 ++++++++--------
>   target/i386/tcg/ops_sse_header.h.inc |  8 ++++----
>   target/i386/tcg/emit.c.inc           | 17 +++++++++--------
>   3 files changed, 21 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

