Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8760ACDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 15:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclZz-0004Wo-Tw; Thu, 25 Jun 2026 11:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wclZm-0004Jt-Mg
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:01:14 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wclZl-0004OR-06
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:01:10 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-845b6d9bf39so436109b3a.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 08:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782399667; x=1783004467; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VnbojJRvJMNZggHQQ/0yXUgJjr8vMxIqf/+s8zNOQO0=;
 b=q8OM6Ykzy/6EPbNsmMQuyZzTfKpHQbJxjQynue4hb/oXJcjeyKzjYc5WiYNetBUrQ4
 ub4ysTCMvqzrYhCLVUaVvKBcaXCPezCmEEujieoPQnS2TDqIwQYIDzG7qMjuWVFEotQX
 L4Q850g7z6cD1yiQ7uXI+6Z9nPoSJZLRNNBybxDeknYJ5GeLSlTcSyDQz5CF5Vqs0dkC
 4A979DeCYmvEEakN/8VDlsm3IZ0NFtkbctzLnfhLDVfrgZWTcLq/3pLNsEIKqA30uk/o
 M/t3HJN7ASa7RVi+8MFMpvQsTx45suI63QHzfsqA4Yj5QNGA62rfncoUf9HjlXNtWLl+
 JBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782399667; x=1783004467;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VnbojJRvJMNZggHQQ/0yXUgJjr8vMxIqf/+s8zNOQO0=;
 b=k6jSu7wE/Uqq6EPyScliawCYGTA5BEppwtQ8Wx0t/nKQ3M7OjumkveM8G+b37FLVXB
 49xwyjMEzTPEj59PPkmyF+0jSdVYWpWR2+toGrv43YUEB0uDTzhqBvmT5j/j1tkQcgdJ
 P5nYO7mR/hpJ6r10xzFgAb9sxtbuNp6gyitqd9LRNpIce7yfkthx0mkK0fM4tXQRqavV
 HwtTsidKmwUM2V1skLKF41eTUT9HHu/sEM5ch0lzoRdual+MC6BVgYiu1IFDfZPXGfQU
 p242E0ofgGAx4Yf6188O+Umx2jSJKQH4PCsEGEUBK+MO5zqVyw9O0geYmlTyemnAkAzW
 3XUg==
X-Gm-Message-State: AOJu0Yy7l2NkgB2o+QB6G6tXFERDrjDeoDGe8vEuwuisvpbHBtfMzwpK
 n+xiXEf++lq6ew9iJ8ozztMxsso2JEzIpn/L2LEs58uXApGz4CPfDeLRhbJt3xI0nIAIeLEJKeI
 f2xZM
X-Gm-Gg: AfdE7cks8kEbLlNQXW3Ujp3ZAnfIa89qJJHmxKHZZ12ltIPdPt1NWDZYCaoGm8Z4+3h
 C5fiFhu9SJ7sNllJDsRab2y/EFP3vF14s2YNA+EfAF1QdnGHZ03pmpeDPbNUXZqMr8yL8W+t5r+
 pU/0TyIbJQQFglOWAUl9Er2w3mNh4yg1dqjnM3vOxPq2HvY44tpuW+WSyzA6ROW8kZFEOcTKbwM
 bfilZi+j1cC975EbkC4ATfnC8dyVxEdePlGaDeofaUgM4QC1xCocc7Mdw/wzM7RS98qiVtte8ul
 iKiDFMli1oEtmzu5zA55erMk7iSWJhz1GoHmwEI7KCcplAcwqpF4u6JZoDzoHMB6G5o3eNQlH7J
 unEq4r28Qt6ht6s8mBTKNs8D2AkgFnodUDvPnZO9qHqKnOfFiX1yGAi6rZTtcYX7gTKbo9YIdYv
 tfXbtJ6NhOL2+UfNmUQVV0uHcBVQN6lJOOLc3GEBQDhjoJg3k9syzBz+V2eg==
X-Received: by 2002:aa7:9308:0:b0:836:6f2e:bb6d with SMTP id
 d2e1a72fcca58-84591b767b0mr12153623b3a.14.1782399666375; 
 Thu, 25 Jun 2026 08:01:06 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a4002c51sm4834103b3a.27.2026.06.25.08.01.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2026 08:01:03 -0700 (PDT)
Message-ID: <ab46b535-9519-4647-b50d-4ba1ecb8d7a7@linaro.org>
Date: Thu, 25 Jun 2026 08:01:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/7] target/arm: do not clear halting reason in
 has_work helper
To: qemu-devel@nongnu.org
References: <20260624103049.884930-1-alex.bennee@linaro.org>
 <20260624103049.884930-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260624103049.884930-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 6/24/26 03:30, Alex Bennée wrote:
> The helper will be called multiple times as we exit a loop and until
> we actually restart (via arm_cpu_exec_halt) we should leave the
> condition the same.
> 
> Fixes: 6fd2fcdc61b (target/arm: teach arm_cpu_has_work about halting reasons)
> Reviewed-by: Peter Maydell<peter.maydell@linaro.org>
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   include/hw/core/sysemu-cpu-ops.h | 3 +++
>   target/arm/cpu.c                 | 4 ++--
>   2 files changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

