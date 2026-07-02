Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4DF0C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfLoa-0003EB-Q9; Thu, 02 Jul 2026 14:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLoX-0003Bm-0U
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:07:05 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLoU-0002E4-Ag
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:07:04 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-845eb7b96feso1653686b3a.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 11:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783015621; x=1783620421; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ItlymjENmn1AVJm5yiNCQ8JseetCMgXOicY/Ez1UY3E=;
 b=AE/RFQYyxbkBIlnNG2ONn6MmufaBrgIRSMYJA0ploqlA3vLI52zgZHFbotfGVO5fnw
 wPcVUnxx2r6PkOcpXMjXINuLrcHE6jFQUoja9jjV4vBErOUCzQcNcFEi7Qlfv9T6HARv
 ymQSMvYN0i/n2qx1vm2iQeAhhq+BEMofIKAJQ8IJwjG/B8hX1TNRrjSFsl8Ex4rk9zIV
 sdbsugQn2AHdrzzG3cjIYf7f/7NNglzBhbZQlz4H+BFZqir4HK+ZwmwVL9FDgns22thg
 4TD+K3bqL2rxQEZSW3MzJX13DDtoIsg7qr3oAelSM1XunsokjT0jf6oupiAqh3zRrTI3
 BBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783015621; x=1783620421;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ItlymjENmn1AVJm5yiNCQ8JseetCMgXOicY/Ez1UY3E=;
 b=PAPTrsLV1Rq3d9dIgKRGcIvbNkzaB0Aw7mgMFACUlOvUOgKxWo7MeOxMhbso8Tlht6
 0PNvCtj/FSEdn4h/G3GeNWv+9tbYyVOXcSdTQ4Bj8hRa4EJ0YkhQBYWsqCU5WN1wzKwZ
 jv5Dlpk3yQJzQmfoaA/FPcqLIDMOtKmYLcu3q4up/ZeMhAbi7iasl6LVjcnoF7qQ+6DF
 JcwBpwQhjMaz0z08RclGyDKk0JmgZDvaoI4qLX6BcpakCPkOdv187fx9UWqYG92L/aJs
 FtAlapOuXwpODUswcCvFyDJD3ZKBkHlcAatrmgNSQXkW05GIX7QxF2Ki7xi9iNd6tYF8
 4DXQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrDvnRRzOaAPZv7WC62Ge45nHWIMvn2CXOLZ4WPj07XYDRW1s+6y1uBp8Aic35IPerajpi67Kxm0Ato@nongnu.org
X-Gm-Message-State: AOJu0YwnO8O+G8R4edOKw/O1gw1tVbFGKCtUaqG84Q9K9JWKg44l+5xB
 L1dX5HSlua0SLlDPoM1Fm4p19kwVb5hrEBU/IJWXnvO/cSo/7/8kCXm5f9PSRzC/qU4=
X-Gm-Gg: AfdE7cnFvat8Q1IMsWXltID7TumyBCFRmNZa9Judkt8UFwQySilS/rmtAGNMjQjGYt7
 ArGizfLyoh/AOzyvRr17hGIoRRCRLRnKRE5nCRgjzL6fZa3CitOk1knEBp1m5dlnLIiO3qY2XBR
 E+zTzVbSWOU5ZG5cxtvRRDasRs4bH3LdEOGwUYA7VHaD+tQMvBFtKZ0lZrgbB2hc6qDz64JmkQQ
 sko4rXm13WEvkgRDNGEf7qpMUVsum12XHFsGt6nENq0z6DRXSIgmzP0d5JIp1HXY+FxQqORHXGC
 ZKgLgJPj0ETvDgiaJrvq9y/v7R2GdtGHmX07Fv8XGKyriADidKQAQ2zVTYiGzHGgcpJDVwWZmEJ
 /xcE+QlIIgVx6Kc3XG8MT2VMGkLtK7VsJcZBWeIpc5JZ5iARbNMbSoqvjqMekMyOCizWc3Iaups
 6/OuJjMo51CpZu9XhS0nxzXZIX4Iuss5zkoNZR+shfm0I4NjwVOMkWnP/Qew==
X-Received: by 2002:a05:6a00:cd1:b0:83e:b443:965e with SMTP id
 d2e1a72fcca58-847c075cae0mr7012180b3a.3.1783015620742; 
 Thu, 02 Jul 2026 11:07:00 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847cb9ad161sm1728266b3a.51.2026.07.02.11.07.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 11:07:00 -0700 (PDT)
Message-ID: <de592374-d84f-44fc-a6e0-f40dab5cf542@linaro.org>
Date: Thu, 2 Jul 2026 11:06:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/33] cpu: Move CPUWatchpoint definition to
 'exec/watchpoint.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-30-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-30-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/30/26 15:00, Philippe Mathieu-Daudé wrote:
> Define CPUWatchpoint in "exec/watchpoint.h", including this
> header where appropriate.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   include/accel/tcg/cpu-ops.h |  1 +
>   include/exec/breakpoint.h   |  9 ---------
>   include/exec/watchpoint.h   | 12 ++++++++++++
>   target/arm/internals.h      |  1 +
>   gdbstub/system.c            |  1 +
>   target/arm/hyp_gdbstub.c    |  1 +
>   target/i386/kvm/kvm.c       |  1 +
>   target/ppc/kvm.c            |  1 +
>   target/s390x/kvm/kvm.c      |  1 +
>   9 files changed, 19 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

