Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5BDE77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 14:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNYXo-0007Q8-Fx; Tue, 17 Dec 2024 09:27:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNYXe-0007NU-NY
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:27:20 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNYXW-0004Rp-0p
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:27:17 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3eb7e725aa0so2497540b6e.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 06:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734445628; x=1735050428; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GsyXWVa1gTMAclEmkq2u33yD7kGsA26S3gQAbXi9QGM=;
 b=pajBoo9OmX4tGP2EskQlO5i+eBE5mEbF3sYjP14gG/KzixJLphDHVkg+UbMdlsmlk/
 37tV0wahYtUJqmh/f7VIDJlGCZ+YQBy6U32e1xIl80sYMv8UFrpm9Df6IqawnI5fStt/
 fgx9MINBEl9XQKrMnsrnnObvsyAivHWhAwDgT8Xz071PjCFtbF1oUBziDBEBbmkZdsEL
 orYYP7cuzW9hidkA1jLmHth+FFnOYzPkwxu9bqpdXSQX4yO3CUv5pZccbtOrNwnR3foU
 702E2crzRKxNMucyy/31k624h606jpUfHyAamq0f0ZOnVju79oizrvinaPGowsO6TZin
 rLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734445628; x=1735050428;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GsyXWVa1gTMAclEmkq2u33yD7kGsA26S3gQAbXi9QGM=;
 b=stkZqhp661hsK7slIDxYQGbh9DgHWZbT8w3jlxYkyRYKXr6gwVk7YPAzDvwHuF942d
 qUsswhf0SYa5o2YC6PJmAyPyor90bLc3FLMzGolnnrnVlW51hm5wVvqDbEWYobaeCsvd
 XWoxYpDdMCb+l6bTD4Q93VQ1P8YBK2Az0+2xk/ren7YnPngKOgl/lbHUE7RPBgCyRD8t
 v6dhadWnd+BSlMC5xggLuHGK/JKvKzLcbTCPDlaAiRUv2tUfn5/yJtsIpK82AteyG2lC
 g/368M2+z3WE2m5qrZ3NiwGG7hYlgtnUbw68STak8icBsbl34LLPSQuQX7Syjr0FG66f
 9UTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH6YaddmVW50klYqEFBvcDmWdC9KdNHnCludeGn8BtcDAJt+v80+c+86MUTVJ4eMOPjzEGEGOAGDl8@nongnu.org
X-Gm-Message-State: AOJu0YylDcZVpFeGot0WLm7InMZ/VCRswODhPymlaFf21JzgX/SlgBbQ
 bOi9/Vbeh772RNZ9i6qRrH+nydSvV54nD8h3VIyswMOXi3rChQVRYD1c/OEtEkg=
X-Gm-Gg: ASbGncvn3HBFRFyw6a1d+eRYeRUlJVCHNElBDDQH8pAHQyvn93zx8aLZl4srpdxa6oA
 /f2O2bzFqI3lRDA0cOosbFuTH4cOLCcZzv4PAext5dey3ki5S4RDYuiVn4eoqemc0sJrBAZ+BTr
 c+QqT7a0ycIjBR56reJDJI9jlecXK081r14AmT3LzM0EVmN5Z4i+902QtHOtg3JwAcHDfuPo2Eg
 c+5U+vA71w2Zj47wcezT8TRMU5PXAUw0qZzvqFN1UIRsG9Xxvcze86P1tQ4c1qm9dnQg60blKRr
 VaSd2pKK3dQpvXRC1yS+MhOrF5P2E1VchBs=
X-Google-Smtp-Source: AGHT+IECci/ivsrEMzYhXJhplB5FPPyQGqsmyrJDHvJT7/HayPjU5AwJl7S2Wa9Rr1XSanBFdC/Npg==
X-Received: by 2002:a05:6808:1987:b0:3eb:777c:184e with SMTP id
 5614622812f47-3ebcb271462mr1808803b6e.13.1734445628205; 
 Tue, 17 Dec 2024 06:27:08 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e48371490sm1999987a34.33.2024.12.17.06.27.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 06:27:07 -0800 (PST)
Message-ID: <0efe16ad-f34b-4a7e-b872-c3f2eb67f977@linaro.org>
Date: Tue, 17 Dec 2024 08:27:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Declare cpu_loop_exit_requested() in
 'exec/cpu-common.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20241217140648.98538-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241217140648.98538-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

On 12/17/24 08:06, Philippe Mathieu-Daudé wrote:
> Move cpu_loop_exit_requested() declaration to "exec/cpu-common.h",
> along with the related cpu_loop_exit_noexc(), cpu_loop_exit(),
> cpu_loop_exit_atomic() and cpu_loop_exit_restore() methods.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> Based-on:<20241212185341.2857-19-philmd@linaro.org>
> ---
>   include/exec/cpu-common.h     | 18 ++++++++++++++++++
>   include/exec/exec-all.h       | 17 -----------------
>   accel/tcg/cpu-exec.c          |  2 +-
>   target/arm/tcg/helper-a64.c   |  1 +
>   target/s390x/tcg/mem_helper.c |  1 +
>   5 files changed, 21 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

