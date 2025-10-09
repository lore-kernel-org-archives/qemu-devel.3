Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB98CCCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 16:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6tqx-00041u-Kq; Thu, 09 Oct 2025 12:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tqs-0003sa-Is
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:50:51 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tqm-0005Np-B4
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:50:50 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-781010ff051so868967b3a.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 09:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760028640; x=1760633440; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WVWUoSnflEAuoeO//LSBJcINHjLqJlfUIk8dX86DK1s=;
 b=o6XAJRCLRdG+PsuT5+lQOtppXGaWUlo9eGQU4DcUadFjx/IeqIlU8p6fz7LWlivfKl
 /w2FCLYY3Un445D3H2FiRXdQi4pjtTfdAtNBXVl6srazzIiVFoRizp+4HU2mLXgM7Le4
 OrXYiYAe0SCvBS/PmYL3/bmmGL1bLKVEjrNF+Yvywh/P8ZfQAlsksnUH2uVFBTDzNKj1
 uLLNYS/PJvsab8M+t4szD7oxMJzBKkzqVv/nJ68tdbK4z4cOPUOazczG9W+pwcg9oM5X
 KYqxzH2wtFLdCSAU02TzIidmjstL1EjXbVNq37SPEFAUJNsNNpNsOgto6Oal8iJMitYU
 1bRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760028640; x=1760633440;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WVWUoSnflEAuoeO//LSBJcINHjLqJlfUIk8dX86DK1s=;
 b=a+9OYjoThqlRi4YfVdWjvBbGT+ucfxTNRzj04WS97Q99KNWblgISfdL99ItDa6wlXd
 kigQlwwijoqSdfLlUNqqDxyHpyBD8aVdkx6UcPivpLu/JyEDe3cnFJdLR20RRg42VRgc
 5U7kT1G6yplh/6EoS3I17h+Vio4ZkVC6GPapiaAFEclS/CoYPgLjo56H4u5OA1I0/oHe
 mmszBfSQ7t1IpKEqulTi35rnmJq0xoYs4K7GMJdVvI+2NTVEF7qQP3tty8D0nNk3SFRJ
 ZdPlOvrnSH6z5gTkUJZAAu7AnwQ6bGgGoYVgmsXuGsZW0JqNNXYP9EoCfMi8WpHxu/+F
 SHRg==
X-Gm-Message-State: AOJu0Yw9hhAcjibqgClMW5BXSfQwAyXM8c24CgiHH68VyjB3wWg0Re+d
 dvCjDxX+NRuzhUhC+u/PChajXekRUAsBugpP7ee/EkhAS12cty+slvoKbB7XQkkURD/UibCgJ1u
 t2BfBF1w=
X-Gm-Gg: ASbGnctKL21VAjdPEA9V78AKMhY+F81yMDVuQ25uhEVvSP8Yt8AbTTU8jBnHujbUp0G
 EYqyM1h9iZqMq8Dcwvueek5kIgINV96o+i5A86QxGnKd0H9H+Wvgvwbm7El+EeOm9v8A6ycUfMr
 K7JmK6wAKIce6zl1750vk8ONsFYoGCtktV3i5B0E+NTXhyOp2apVBsIj7ktySFVj5GEGjCCPfPF
 N1pcN0UUGEyaNcjSFpE6u33DhnI1vNlzoo7nVx7N4WIOrgd1cbTEiHMKf2M8ewPbv06UYTHXWmJ
 aFh7jvtiOdDjzspgJGYNwJHi0E9/9rocpbLkr9NNhKsFUdfP1+5kx+76BstgT6Q8RmVr9OJb+H+
 s2hZvl4it7pwI6khgt32CiIFx7lag3tiEcPf5GLomm41+T0AHi+sm+bW3TzowrUWF
X-Google-Smtp-Source: AGHT+IEl0YA2OyZninmgVZ0B2MKzLlchGW4S51Z6SlCyQihEDSgwIdPBAr4kGVD7w5X7UtYe0W2txQ==
X-Received: by 2002:a05:6a00:14c5:b0:780:f758:4133 with SMTP id
 d2e1a72fcca58-793857038fdmr8391106b3a.10.1760028639497; 
 Thu, 09 Oct 2025 09:50:39 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992d0966d7sm203396b3a.40.2025.10.09.09.50.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 09:50:39 -0700 (PDT)
Message-ID: <fffdf0dc-b17c-4597-abcd-2cc06b359503@linaro.org>
Date: Thu, 9 Oct 2025 09:50:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] target/openrisc: Inline tcg_gen_trunc_i64_tl()
To: qemu-devel@nongnu.org
References: <20251009081903.13426-1-philmd@linaro.org>
 <20251009081903.13426-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009081903.13426-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 10/9/25 01:19, Philippe Mathieu-Daudé wrote:
> The OpenRISC targets are only built as 32-bit, so tcg_gen_trunc_i64_tl
> expands to tcg_gen_extrl_i64_i32(). Use the latter to simplify the
> next commit mechanical change.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Anton Johansson<anjo@rev.ng>
> ---
>   target/openrisc/translate.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

