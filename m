Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69DACCFA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 14:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vISxd-0000J0-TZ; Mon, 10 Nov 2025 09:33:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vISvk-0008G9-Ag
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:31:53 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vISve-0004Oa-Ua
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:31:36 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-429c48e05aeso1641285f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 06:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762785093; x=1763389893; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XxJ/viwu1qxfONw+tYJxfH0yjm5NzlFnKvPkXSiETkM=;
 b=sOsZvZjdm9MOYxHWMl0fsTI3nDr7IT27/yJ3PB960dh8WPMQe7DsTayaAUug7Z1Bri
 LQ65S2A7iMiEzCH06syAazJYNBP/7jhFJ2JuOyAPhHZVdKriJLdR6FnX4FaHCEPkPo/u
 2rJO8AxODaVr/wTnbIzVYRqIASDIBvwHtCUS04lCeqmj1kaMKJb5bDxKrX+WK+Bafm8Q
 aIZ2pD+mSX3zWCe2NcAJBqUp/HsUerNYJCz4DQwOSQyH9lG8HLSboNLAFoxDk/VXv/Mm
 +X8RNd9uvT2gaM+MzTYPaKNseUEDvuBttyQgmiFRai9cO0aRHxrOK4qByeror44p56Yj
 P5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762785093; x=1763389893;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XxJ/viwu1qxfONw+tYJxfH0yjm5NzlFnKvPkXSiETkM=;
 b=o78v7c78BHAz69728H1UV9w+drMIGEDg2F15lXmpn4mflb7PKZ3Hd5FbGep+BMJvmY
 dpFMEsmiLbEcfMHBidHs8ZtQMXLM6IIWHunwnfESqSVjeI1X0385ykQmTiijhUc1W9Q8
 e4cmAptAgY6/Ps03+7gl7PR6WnoRHQJ1qfOg7ztISll24P8ci3e556vhacdEP/t5qd9w
 bfEZxF7UwR1avtrokeUJmmTv+KEMCgqmBL3gSX6IGTPyy6VhSZXawha4EJxY31JhzG/8
 lhRPOa95z2herYYasQOYynuk0bVTxTtQjetRAVkbU4k8Ua1BafvnlsKsJjvjY30r8+4y
 8FOg==
X-Gm-Message-State: AOJu0YyWYnNXK11LfArq4AIwqSxZlByZ48MYhdPs91MgWIBur3QYDyOW
 rjiRlNej7uP/Wyeu8cd5TyCLOVDEDX9juYX+O0zPNyPpX1LaOFa7zdo38Ur1BAg72eXuYDq3Vwg
 EjhlTizU=
X-Gm-Gg: ASbGncshgr4M3lNkqkQL22QSHUdyYEPlIb/K/hlPEpJhNfU8m/U6RSqahsDwe3KqAyy
 cP66G/BwbnL7W7RJnd76cCiszb0aq5eu8kTuyR1gZzPtwl+OUlB0a96xbWh7BRYT2qbqIi6HWF7
 Merb7t7ZZ1aQ1WgOG1r6dYxJwq9My6wYVKmE9lT0ePWyrWeX17b6BOGagsZWFlg5GzWrQPVlExM
 BqOT+BbTYv/yJEa6lWlSHGjJFTkQ6TiS0UBVH47we+7lBoHTkj20TQR0/qmetZxpshUKuPOxn4M
 z6s5uYs0pfMIOH+tUE+JhP8eiAT9pv0J+tHcIQO/a9j7rRH9zgsSuz34aWa12kpJ+xj9CNNoU9/
 8VZcP4z8ly8IN7Pet0VT6ZrGr/s5wYIYKoaYH4BiHH3/3f0UNryFS+martXLq3rUh2uAVgs9r0Y
 /+S/SRxOUEJRrI1GyTaA==
X-Google-Smtp-Source: AGHT+IFa8ob/tL1nyJ6ZaAftjXJk8GJb7gf3FciAQbYSLGA4YySRe0CnueufSxShkUmTLp6Cw9EIKw==
X-Received: by 2002:a05:6000:22c5:b0:425:82b4:a099 with SMTP id
 ffacd0b85a97d-42b26eacf26mr10447599f8f.0.1762785092684; 
 Mon, 10 Nov 2025 06:31:32 -0800 (PST)
Received: from [192.168.50.95] ([206.204.154.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b3123036bsm14023367f8f.28.2025.11.10.06.31.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 06:31:32 -0800 (PST)
Message-ID: <54da5df2-8a93-4b6a-8f95-8e8313affff1@linaro.org>
Date: Mon, 10 Nov 2025 15:31:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] misc patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20251110111046.33990-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251110111046.33990-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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

On 11/10/25 12:10, Richard Henderson wrote:
> The following changes since commit 917ac07f9aef579b9538a81d45f45850aba42906:
> 
>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-11-05 16:07:18 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-misc-20251110
> 
> for you to fetch changes up to 4f503afc7eb503997fedad84f24e2cdf696a7a0e:
> 
>    target/x86: Correctly handle invalid 0x0f 0xc7 0xxx insns (2025-11-10 12:02:45 +0100)
> 
> ----------------------------------------------------------------
> accel/tcg: Trace tb_flush() calls
> accel/tcg: Trace tb_gen_code() buffer overflow
> qapi/parser: Mollify mypy
> tests/functional: Mark another MIPS replay test as flaky
> target/x86: Correctly handle invalid 0x0f 0xc7 0xxx insns
> 

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

