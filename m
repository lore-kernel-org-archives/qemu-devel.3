Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59137C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 17:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAB5k-0002H4-PG; Wed, 30 Apr 2025 13:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAB5i-0002Gm-61
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 13:19:26 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAB5g-0005Lj-Cs
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 13:19:25 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-301e05b90caso159371a91.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 10:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746033562; x=1746638362; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8FKY1QGncwyoGF5MUOgwlGuqbGe9Z34H/uyfw+A4wT4=;
 b=aToTytnUrgn0XbetMckfXU97XM3PqskjuASQb608vnR6cgOA2IQKWhLhQKiEq1vQ29
 qMzuI31oELJAusMm6k3ktmduRHBdB88LMO6wvTr76ALQfNA97xtL1+lGp6/zLEtoPeS9
 6BgwcNb0q+hFUojwDPmHzzOifpM2cN3NkWrgvQ8IBChXrPjzVWxXE9p7ttK95MUUL3gK
 TWKC4WjxpjK6obOIqECXXNvVw6m5p99gDgfGOKGcefzqDQfmEKYrXrqpbi+gwT6BF86X
 qUp8YKRoH+fZNsReJOmlIxd1kN+47+lfRuBCWptwlYqENudkDPU10vrVjVMsq5IFUNEt
 6bEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746033562; x=1746638362;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8FKY1QGncwyoGF5MUOgwlGuqbGe9Z34H/uyfw+A4wT4=;
 b=hwP+JZMMm+2AcVcxbFZ6TWlbr4lPrhX21n7SkqKqJJRkibT2TtefrucryK4EwU+6K4
 H/7kXBpiXGLERV41TPvCMyGvxhA1g4wEZ/lEAU1Xo2kr4i3D+XzHCSYPcvPej9t+737k
 uw5F79eo5K9/DyxOfSutFobGWW2++YdHm52E51XhKO2hxD1ZG0BumipO6Qf+tpDhBTpI
 K3+WVsu9AwSd1JF95Zzxj1MYbNlRT3FYXt7qqeSrhznk0xLmUsZnWkRjqJ8kFn+5M7D6
 pMUt6b9eg/eOof6mh+NfXY4lFCPGu7nMAqwo+5/Pc33dj9BHo1r1FYTuX7e3VrHA+xVA
 xJiA==
X-Gm-Message-State: AOJu0YxlgraC3dfz6YvTXkc+UQYa2tqVz2mncR/NxRdXhfI3xDpDjue0
 R+ng9AH4kQOXW0hHxrKtTKjceP90b0RpjKjpOgQZ2XGRw0H13nzI49YJunpSLHMztxBPG2VtlwW
 L
X-Gm-Gg: ASbGnct4wn5Hw0b4VlaxnuKS7/CLjHe6kVupRstb+LqaEMvJzewNz4WTmYdSWSxYfrN
 HPFMtEYZBXQ+r/BQgYtpYoIMR+0+4sByXxGDUnu2ZgsDMu1ykyT4+wgWiprullAaLuYz6uPwbZA
 gaPeYrFqB/rr+SKF6Hajjo1frtZFcnmmdTHQA/NVgVPTuOPbeoQB6bZBysbk8P14AGHiYpphOZd
 AuNWjbYPgXjEt3SFWQMR/wW042WOKPUlTWEwlAUVVG3RIWzGLeFGIbhGwPfLEZwsv8QYNiBE//N
 Ds1oWB82UWZj12KYW4pOQMUuo5Onq+jZpLJUYecP9n/RelVGOMRpsUaIYzxQSUXbVAkblSuNduc
 EZnlK0rLMTqBCpKa7tw==
X-Google-Smtp-Source: AGHT+IFciluorvFNXDdNLKUOyY/s9AQ4BA0sHLQ4JSoYdkUYDmJrYrSQvW5Z/IBfPasIURv1GwDz6Q==
X-Received: by 2002:a17:90b:4ad2:b0:30a:2173:9f0b with SMTP id
 98e67ed59e1d1-30a34467f57mr5122648a91.28.1746033562158; 
 Wed, 30 Apr 2025 10:19:22 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a34a2ea46sm1887380a91.31.2025.04.30.10.19.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 10:19:21 -0700 (PDT)
Message-ID: <91eb1dfb-1d04-4410-85e6-bf4f5ff59b9d@linaro.org>
Date: Wed, 30 Apr 2025 10:19:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] target/microblaze: Use 'obj' in DEVICE() casts in
 mb_cpu_initfn()
To: qemu-devel@nongnu.org
References: <20250429132200.605611-1-peter.maydell@linaro.org>
 <20250429132200.605611-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250429132200.605611-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 4/29/25 06:21, Peter Maydell wrote:
> We're about to make a change that removes the only other use
> of the 'cpu' local variable in mb_cpu_initfn(); since the
> DEVICE() casts work fine with the Object*, use that instead,
> so that we can remove the local variable when we make the
> following change.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/microblaze/cpu.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

