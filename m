Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92523C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXgzS-0003qB-Sz; Fri, 04 Jul 2025 10:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXgzJ-0003p3-Ly
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:02:03 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXgzE-0000Ed-Ge
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:02:01 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-40a4de175a3so617709b6e.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751637714; x=1752242514; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gdQOyqpRwSgJgq1ODB3x5MH5gjNy7ViEFGXyEVIG+Y0=;
 b=QYd8PcEDlIWXz0Pxw62P2UDJ1N43hGnn4oesvpA85i8Hi5OppaKQd1Sd4LR+MHtqKl
 10SGvycCevFrKeMTrQvbXjweQeHG+rHkPjdZh+sGHc7WdVgSFf+ygukv/FyQ3zoyTfJR
 xXCJ6onaoRBWk810TZaJ9o0v868rLjqwq1b3eIfJSrx6QX+GWjzk+XRfA1AojonYQ4Cb
 fU9FUQw34iZL032Im7p/vVwB5deXX0sQmbgx628mcrGakoo10Bz3TDGB6KWyEMPuhvYX
 lc+uArGRsUzgDDhUc4oAD/59X9kIrDhYVejDlJfVnxNM/3nxh6jAxCYOLHu6YUe7J1H9
 eNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751637714; x=1752242514;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gdQOyqpRwSgJgq1ODB3x5MH5gjNy7ViEFGXyEVIG+Y0=;
 b=WK6qZx1v0s4K227BRzATRHzNwtNXdqkIr4I6JlFJO4JwrSYkgv4IcMgII4yUEys/YO
 QZTnLRVAhUyYMGXhXYVsDYtsieYv7XEuf5FUF6SbM53QUw5VNrqB35mh+ETBu0ngcCUa
 sNxbX01uH3oDd6mw9MwjuZ80zJigCv6Y9fcjQbAc7AH2U5Bfy9Qy8g1kvXN9UIi0IWKR
 JcVlh5n8L9kS6G6N9yDRYW4owHxF0sgJ3SVRwsJlZaxEROhzLiq9L5K+pRSZyXKrr0n4
 V/M5isaZm3fCcINqp4pnflnTw4EnlMc5JMF54j/f13ycar2B+Xy28+vnS2KxslygAVr0
 6M1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdkGsOgV8aMtjealB4nKvmRvyjWl0RZKXT6aZeybfiidXzFene5hFDqhf+zV8Y40lJ7+wCfLNK4QhK@nongnu.org
X-Gm-Message-State: AOJu0Yy9bPlaiLD3tbVL4Zn9Pw9306u3y335T2iBXAcbrmJQHSbLcpiq
 w4MEwNd6LigRtKXZyQcSHfzj2wAK0svNAuAGg4J8kF+azlqlpJydq1wVBjPuR0oPEmA=
X-Gm-Gg: ASbGnctK6nIpZHlcBlHMzA2AHpNiv//aKuHZih4i8H9Ok4T3tbVqzT7GcqFsEk5U9yq
 Susv7FSVOhv+Jv/5v2MHfmK8cVIcVaRpqqY5lFxcA/uqke+rp7MIN4Z47JH7A3P7GVh9eDyKnFe
 gAq0wRYqi2f7GjqURlQa3BNQcRZEvoX2EN80IaNj84h6w8gyG9ZZ1WYXyMZ7uszUDR1gE526PFO
 qEaFAnf0cozb0CKMaFQuS9H8vHE6K4PJkxgcTmDY2e8BD+uvRbJ29LtyjIUDGpIFLLojwin4vpy
 qc5Go1GHXRnS7YcoYop+x73KCBuk/KQ5bLWbt1GwRwOXzIqJIH0DewXS97SpPIUci+1FW4mdT6W
 lJFI8ckFlAyzBdFcRdJup0rE6o5wrUP5EJw3AgceC
X-Google-Smtp-Source: AGHT+IHxIVOO+gNuc/LC25XI0U1uFEyxSWF05BGWni1kCzTzcdJfCOeeBeDR0keZpUpg1vyhdOOQdg==
X-Received: by 2002:a05:6808:3028:b0:40a:525d:6220 with SMTP id
 5614622812f47-40d043e6d65mr2043241b6e.22.1751637714178; 
 Fri, 04 Jul 2025 07:01:54 -0700 (PDT)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40d02a44bc5sm315193b6e.18.2025.07.04.07.01.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jul 2025 07:01:53 -0700 (PDT)
Message-ID: <c6eb1d9f-b3eb-4418-8bf1-6edd47ddc2e0@linaro.org>
Date: Fri, 4 Jul 2025 08:01:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 37/39] accel: Rename 'system/accel-ops.h' ->
 'accel/accel-cpu-ops.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-38-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250703173248.44995-38-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

On 7/3/25 11:32, Philippe Mathieu-Daudé wrote:
> Unfortunately "system/accel-ops.h" handlers are not only
> system-specific. For example, the cpu_reset_hold() hook
> is part of the vCPU creation, after it is realized.
> 
> Mechanical rename to drop 'system' using:
> 
>    $ sed -i -e s_system/accel-ops.h_accel/accel-cpu-ops.h_g \
>                $(git grep -l system/accel-ops.h)
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/{system/accel-ops.h => accel/accel-cpu-ops.h} | 8 ++++----
>   accel/accel-common.c                                  | 2 +-
>   accel/accel-system.c                                  | 2 +-
>   accel/hvf/hvf-accel-ops.c                             | 2 +-
>   accel/kvm/kvm-accel-ops.c                             | 2 +-
>   accel/qtest/qtest.c                                   | 2 +-
>   accel/tcg/tcg-accel-ops.c                             | 2 +-
>   accel/xen/xen-all.c                                   | 2 +-
>   cpu-target.c                                          | 2 +-
>   gdbstub/system.c                                      | 2 +-
>   system/cpus.c                                         | 2 +-
>   target/i386/nvmm/nvmm-accel-ops.c                     | 2 +-
>   target/i386/whpx/whpx-accel-ops.c                     | 2 +-
>   13 files changed, 16 insertions(+), 16 deletions(-)
>   rename include/{system/accel-ops.h => accel/accel-cpu-ops.h} (96%)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


