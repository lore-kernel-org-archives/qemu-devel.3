Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B109E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL1jv-0006PB-J9; Tue, 10 Dec 2024 10:01:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tL1js-0006OI-SX
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:01:28 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tL1jr-0005fX-6z
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:01:28 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-434b3e32e9dso61193615e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733842885; x=1734447685; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VHqBIiAdSvqU//UY4DCQWiiXIRjCI7I6YRN2pMzbihs=;
 b=v2AVA87I3QJXm6OKoaNtwyYSZtCnAQzYK+NGxCqyKylFBFA/eqR+r+AhTR3WMKfarW
 sP+Y7aEGrf83FvMfGuvCmvQlxSy310YgVPcO0KvDYKS1HQm/cM9910+UiwUead2QUCro
 tLf8bAmPWJe/jamlw8pHBN0m2ED+YXlShuXtHSRs80zBonVzK+KZDnHbsBhhM/FyGNGb
 f99L60LpP5u+vbxS+M7+aD6TvEvML9uUCqv6faKDlQ0/SNIQ5yeVBc7zS7uJT6wlo5Ox
 fgVUz8kCqPsQ96Rnke3a7KO3oCyS0/d60+si9OHMr+RYrpueG3MC7LdPegrubeb1mI5u
 jUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733842885; x=1734447685;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VHqBIiAdSvqU//UY4DCQWiiXIRjCI7I6YRN2pMzbihs=;
 b=EwUUuUvzfnecFvJYepktJdPJxCcdx6uvot25fQSDBAKassajEI1UwG20i3RtYdItLp
 REvIpZrg+q8yXSIRXHZX1SjnxSIqYdvdpIomYJq6i1jOxbLAAmIVBwO8HH8be8Y445Oj
 KVp36in2EjQXEeQh08Ng6t1rN8vMcqK58afySSk3xWdVVp9JWv1HyAkEB2lViIyfmWxW
 6MQyXEevsAmkjUxbMM/THwaL5a8W5nwGJHohvEbMBa3XjeXXATFMPJDuovHEnLH56UXz
 /6MqTJiAk0GScjlDbW3RE8a+xnPaDNo2sz22XNfmzEJDyUWULHag96Tr9/kZEPPuMRg8
 spXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY3mM9RwMYAdeIXFZR0ZQeASgNyDRlM9jDBEJ6RB+8Lsj9V+3kNRwGxk8KaRikEkKafhHI1lH4xEeB@nongnu.org
X-Gm-Message-State: AOJu0YxQH1WjCO9EV9MpzJbbbVBUd8VoiOqzwx0+uuaJE6sQNBPQxL6J
 S2gtevbj2qTErOOaeTQ8m9NzLXqxT6YQJpWmkyPPJFT9m6V3yEGaHCQJPDueYTk=
X-Gm-Gg: ASbGncv8MKAkFdFhVXzGfF3JHd6K5ynFZk42cl5WfAKY7kxb6wK24ECVc3GNIhKO8XE
 yULscEPLkovPiKg24/Y5eE2tdX2DVfwN4UOhO77g/He1FYmvjpAvS013NN/WRMbXD48nM3z8qR/
 dnkX+xLvcR9VC17Mv9SROUZyLEY5zozLpAWPFn+Jnbzmz9iVFeL9dtbTos8HS7+lyhE2+sWjotl
 HQY4YYGJHKdz/XR488eRAWtGLwf3vWdvZFXVi9LtEKGSFK9rwM7xCWrELSm6Fg5wYdHsMfOzFD1
 ZEm74Uy5iPq3JNjUFm7KzoLr
X-Google-Smtp-Source: AGHT+IEyZ65a3B8Sx/MUj3jf/xgN/eOs1aSVDUWbFdaMiiZW6Dsuc+LE+K9XL/bPLuQPRiNUYgetLw==
X-Received: by 2002:a05:600c:a09:b0:434:fff1:1ade with SMTP id
 5b1f17b1804b1-434fff11b3emr43837145e9.13.1733842885282; 
 Tue, 10 Dec 2024 07:01:25 -0800 (PST)
Received: from [192.168.224.213] (223.132.22.93.rev.sfr.net. [93.22.132.223])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f0dfc2a2sm109340855e9.31.2024.12.10.07.01.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 07:01:17 -0800 (PST)
Message-ID: <00cf7fd5-240c-4dd4-ae83-0290a6795dd5@linaro.org>
Date: Tue, 10 Dec 2024 16:00:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tcg: Reset free_temps before tcg_optimize
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, wannacu <wannacu2049@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20241210145253.1822737-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241210145253.1822737-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 10/12/24 15:52, Richard Henderson wrote:
> When allocating new temps during tcg_optmize, do not re-use
> any EBB temps that were used within the TB.  We do not have
> any idea what span of the TB in which the temp was live.
> 
> Introduce tcg_temp_ebb_reset_freed and use before tcg_optimize,
> as well as replacing the equivalent in plugin_gen_inject and
> tcg_func_start.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: fb04ab7ddd8 ("tcg/optimize: Lower TCG_COND_TST{EQ,NE} if unsupported")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2711
> Reported-by: wannacu <wannacu2049@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/tcg/tcg-temp-internal.h | 6 ++++++
>   accel/tcg/plugin-gen.c          | 2 +-
>   tcg/tcg.c                       | 5 ++++-
>   3 files changed, 11 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


