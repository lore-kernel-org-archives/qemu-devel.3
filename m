Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A87D78325
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 14:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI73l-0003yr-7n; Mon, 02 Dec 2024 09:05:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tI73b-0003yI-2y
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 09:05:49 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tI73V-00042u-CP
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 09:05:44 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-434a044dce2so54176805e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 06:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733148339; x=1733753139; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JiakdafWghiFtbfn7nHFSJBrt8kg2pNkSq/91eDySFw=;
 b=rEr8FMObB544LEwPuJRZOaBg5v06ud4Ow0AY5xzgon+HagLO/QpV2u8R2OJO7rclLF
 vJ4k5Yv1EZWiwWlfghF2mQO77sgtCt56TAIxFTKiIZ1PtglzM5TiCOuKwz2kWuZhSPtX
 nq75PMdpEH/6w65LwZFkmiMlja7buWd6nxWW8HzgY1TUPePXyiMfCqcyJQdGMl99Dsup
 +S1rACxzOnt4gr+xc3NBviA61KtZedVepDB1KB9ave3EeNPasGRkGt0KIV+istLuhzaq
 xDw08B2brWvxd66q0Wh5kIn2QeNQeVuQ39JKdSjeowUr2hIGG8B4wA6pllBH1jwGjhne
 hQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733148339; x=1733753139;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JiakdafWghiFtbfn7nHFSJBrt8kg2pNkSq/91eDySFw=;
 b=MF95E9mu0IoRL2ACkRKr1UTbWmKvY08Gqy3SHnarF8A3iKFijc1aiPNMylsvHkEH7j
 rpE0XtMTcQHs8nX6nkimWY0Id7q/FKhKq/zamiC9w39GMUWxesgRItltpSDV6oVMwR78
 fik7RRGtJk3V3YhSB/Wb/SItySb6XiOZHmGqOJemT8danRDEHEXs7mF0WjlP+zWIJYka
 axnaN2j9D7o1aja4rDNIRJaws66xjKo1pMC5HgSAPWg8Cp1D9GOe/M/64KPpGvrJUN3B
 6IBZr4wwxbNKXIe6vQfugjcmGGxD/YvtHc4aSpHPzq+iqgC8O7neCQs9wxs40kH8wKuo
 a/4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH4qPmTzNRppfwV4eudKBXIvM1QwwMtALZVjjPQ5uZ7nBQ8taWuDX+hE6+NJKk8im/Lva1AQ1bLmrD@nongnu.org
X-Gm-Message-State: AOJu0Yx9lKmXO82qZGxKgm1PB3u/TyMs6aXn+OX00rlslekV9VYSKZ2Y
 uBZWjSi5RKPHOgOQcUYX1D9+D/kitFT9KYdiTJMzHSytBzGRrvVZwujXsqZG5LK0NzCjsCS5Is5
 0Nrc=
X-Gm-Gg: ASbGncvXpTWwl52np8SHW+VxMqS5itSoyxcm5Rnn5R87t9ntrORVE+MIiphUPb/CfVj
 QaV+M19hurhgtYsnMU6Uz5X34BlXZWiz6qP5ZUsJDLpTWZxDrdADbBYISzaq09legwKKnBnTsdc
 cFA7FhvC23dd4ISQ/nSnXG4cQk4tr21SK6OkecAzk2dcb3zJVYEOaXVZ04U87LSe66FgIGqXbVC
 gTvmxasl0SU1lhpVaQLs09XTn4gWfqvuanv6AXgX9iiVGO4JrLTxPEYBfWJkM8QW/FrXSEJJerp
 0liaPr9f9NK8JQUtO3uYDPQEugC1ig==
X-Google-Smtp-Source: AGHT+IFABt4ij7MMd5yjhrK0rSS8Hx3Eqdxfnio1Fku9YYv4WfZxhquwX9vN9BNiFPZ+aB404iL3aQ==
X-Received: by 2002:a05:600c:444f:b0:431:54f3:11ab with SMTP id
 5b1f17b1804b1-434a9dfbed9mr219559105e9.33.1733148337979; 
 Mon, 02 Dec 2024 06:05:37 -0800 (PST)
Received: from [192.168.68.213] (72.red-95-127-54.dynamicip.rima-tde.net.
 [95.127.54.72]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa74efbesm184569295e9.7.2024.12.02.06.05.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 06:05:37 -0800 (PST)
Message-ID: <b50ebf8c-3457-4069-93e6-dbcefb8ce458@linaro.org>
Date: Mon, 2 Dec 2024 15:05:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/67] target/arm: Convert SUBP, IRG, GMI to decodetree
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241201150607.12812-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 1/12/24 16:05, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 94 +++++++++++++++++++---------------
>   target/arm/tcg/a64.decode      |  7 +++
>   2 files changed, 59 insertions(+), 42 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


