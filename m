Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD76C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 21:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZGaH-0000z3-AG; Wed, 31 Jul 2024 17:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZGaG-0000yU-7O
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 17:10:08 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZGaE-00021D-AJ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 17:10:07 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ef2cb7d562so80326171fa.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 14:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722460203; x=1723065003; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BuDYVeevQ08mppjeQvpSIJXfEoYrzrGVm7kAqDyjw6Q=;
 b=Q6TQcZNA6ED5vT8sCOmX+fo28Ncgx2CWdQGK8t55f3rMjLCO5UHtu7kQ+ayV3NT8sV
 UDl3NuTgqTUy3CtemNK+Z5lWxs/e0d4T0GUFQGvj3MPuUpEyDzMjmlWwdCBA3u/zv3i1
 gFZgBBBNUHfPZStmYo7mZeZh5IKoJpg0OxC1JFQKGQZo7HYv32yiwPm/d6shlzBOqXov
 Wj2TpJA8LQhCKHkcH4/uuVlTSpj3H5grHFWMwZ5vxZdmImpq/G2vv5us6cFd36G1gjyP
 eefFCSII2ARh+/kME/TAxWbPcM6cJcRV6Kdy67V5lILFsQtJRcbVcSqaMxWQbd73Npm5
 YSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722460203; x=1723065003;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BuDYVeevQ08mppjeQvpSIJXfEoYrzrGVm7kAqDyjw6Q=;
 b=kdEFKBJ8oh8auTYItZrJB/Dcs85KP3FQuvI7e9CeEOxEtP5KO7WQ98I7AlfJLrg6Pd
 M+ddyz9erRDWk7XUFFA5F3l7X1GvOZLEWUZcJ9u2cctLxy0Rdgou9WvaWDlXh0t+tR4u
 OHE1E9gDv5HJBDQ3FpsrZthVcwfv6GFxEuC6Cx8U77zbi212agFTf7RUL7UQ23TVh/88
 4JBcS0+7kOFrC+VRrWb5YzqLDsTiNqgCfMqzh7vWDIZbpbiNsz80Vg8KaEmUBhvFNvKN
 MAPecl0zUzDiW/0Scr72MorIJtSIrBcPCLzt6Ck5k8Je83sSZ4acfOoINQUfD7Jm6jNY
 EvaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDSG9MrVV3jb4C7e0Zuops2s2MaTELX0G8B2tPzxWq4Ki8xYUjgZyMoTTqRvHbKKgntfivXJr8QFHY@nongnu.org
X-Gm-Message-State: AOJu0YxTmCVaZ8pgADIfltyhmfDBLGYg2qYIEj2N7mIcLJ7/Jgw0o7Ja
 GlT2zg+UxuxBkSJ8oM2rw48iuX7Hm4qeuW1eGe5+pXenZZ+UIGgo6kCaDXnqtuw=
X-Google-Smtp-Source: AGHT+IEOFS6zGCRzUcRHb51UqR6yKkfDmRuT4WWCsHGYEl4B7l02Qj9TKsjgT6pRiE2VJOH0rnoz2Q==
X-Received: by 2002:a05:6512:489a:b0:52c:e0e1:9ae3 with SMTP id
 2adb3069b0e04-530b61f340fmr133661e87.57.1722460203386; 
 Wed, 31 Jul 2024 14:10:03 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acadb021asm808139066b.188.2024.07.31.14.10.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 14:10:02 -0700 (PDT)
Message-ID: <e087a52e-bc14-4238-8524-63af1a6d5bb1@linaro.org>
Date: Wed, 31 Jul 2024 23:10:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/xtensa: Correct assert condition in
 handle_interrupt()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>
References: <20240731172246.3682311-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240731172246.3682311-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
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

On 31/7/24 19:22, Peter Maydell wrote:
> In commit ad18376b90c8101 we added an assert that the level value was
> in-bounds for the array we're about to index into.  However, the
> assert condition is wrong -- env->config->interrupt_vector is an
> array of uint32_t, so we should bounds check the index against
> ARRAY_SIZE(...), not against sizeof().
> 
> Resolves: Coverity CID 1507131
> Fixes: ad18376b90c8101 ("target/xtensa: Assert that interrupt level is within bounds")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Spotted because Coverity (correctly) thought the issue was still
> outstanding.
> ---
>   target/xtensa/exc_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


