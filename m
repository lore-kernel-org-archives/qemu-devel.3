Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61638CD6E55
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 21:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTnw6-0001Qo-8M; Sun, 31 May 2026 17:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTnw4-0001Qd-7u
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:43:08 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTnw2-0007G2-TK
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:43:08 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-45f3cf907ceso475643f8f.2
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 14:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780263785; x=1780868585; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TEf39xkJAmb1A8rYQ7UzzOsMEtse9eEIACZEcWTgwok=;
 b=YUPzhTsnhGjJxn9cpahGhULPnYSYYxvzcVN07wFVFSN7qPQrkZAJ8IlhVmy8AHEZa+
 36MVKQwQHgH3JqXp+HJYg3ZLc6oy0Cccu3Ijw0UY3Pdjx23fo8n20dBTaNQF2m6jkG+M
 01LiwMJXLwnBivExWQ8iE5LuORGo0mdI1khZemSJazZ/WSLpDbnKRb7RSaA/XA3PwDSw
 WKcF0V/vFsaJotnin1pjIHXdXYWstRJA6WXQ7edJi09MjlZWLHmz/CRFbqps6CXJKnSN
 EycbW7PWN5ODab78TQ17Kx1yMtxUZGgEPxDT5U7i9cwdaa5SxoQ+wbRC3apa9ZGGkATu
 5/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780263785; x=1780868585;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TEf39xkJAmb1A8rYQ7UzzOsMEtse9eEIACZEcWTgwok=;
 b=Pwp/RruZ41zmdnmeWbbdHHB98uHLvko+at2VGpabiYAz4seJAaR6xKY0ZyjJRmfslb
 ZourTZ2A3zGzKw8ywilX5tecDhUB4Rt1vFpSH/mA3Vm+6I1OyxCWZhwiuw3SQkhRzvt2
 urovOJnrh/8K52LI6bwUCTCotSxqrGoKNb33n/496b6hRT/uXaJyJGbHdC9TU3RpY28i
 CWzBwkY0rMViRIY8SSWovct4sI+xLmB5VDPFnfTTygt300g7d9VU6F2QhIERkm4v9A32
 PSjptNk4QcDXnCN8fSxFaWXyVWqYeOo0oXkQ8cbe1gS4BV3eiTwu7nXrX5xve4laEZnX
 PiOQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9SFc4hCgbh9MUYwjGlGd4wkHIsjLzFNNtlcjtViw7veuYCmYRs6x1XVE3+2eowC7E/nUIU95l6tyxY@nongnu.org
X-Gm-Message-State: AOJu0YwcBpGCoQYl6M22KW0JkTkll3t9boDlqR6x0GeXZXQcwCl9kxCU
 wQcEm266EaAwQKxB9sq2KCBvZmyxYXbVF20puZRVzEAs+todqR43Hs1lVzvlHq5bPzU=
X-Gm-Gg: Acq92OF9uBGZkBKlgNJSsvlino8VkhSn/n6FmDqcGcvol1VZhYcfBGQ1oetwqpHQbOO
 +3E6B3aMWoRf7BRZTZy/UsCfpqhCIcSdeTxYWjBw3ywHJGVvn4wZpHB9bclftsjXfSO1SBPtVh4
 0MIZrsmE57HQ65k45S9gz/MSOBnA/tB2kt4KiHx/kj1pbE4voxvo0+PEWiHXP3fxlRXvopGaA0m
 luZcG8mWjOc85/7DmutY/zVZDH497Js/HMuPf5w1sgBCxrXHXMw4NNKGfiOJl7f2mtvyZl0tniJ
 v4+BABzDDwPEgqrfsrZ7lTG2gjbYYeTSqr4Xl0vP51EjutwPfku4w8fgc5Sv1Tq/Sxxjhzqlwbr
 SVoe3/A3epBPEmW8Bj200J7uGvemN8YM1KFjhPcSRK8o1sMHernMLa05d6qSxvcOC+qX2bxBxvZ
 IDiJhyO0GBddRVqvGtB4uS3xDcHgeMbsQA9yiZmu8suu1ZJZ7/jZk93HQDct9bKVKdrMG6fJKFy
 zLa
X-Received: by 2002:a5d:6f0a:0:b0:460:e2e:6e2b with SMTP id
 ffacd0b85a97d-4600e2e6fc3mr5691367f8f.20.1780263784739; 
 Sun, 31 May 2026 14:43:04 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354cd7csm20201833f8f.18.2026.05.31.14.43.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 14:43:04 -0700 (PDT)
Message-ID: <9db36f7a-2b63-4580-84e4-804751015fd4@linaro.org>
Date: Sun, 31 May 2026 23:43:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] linux-user: Introduce PGBRange
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, deller@gmx.de
References: <20260530211248.375318-1-richard.henderson@linaro.org>
 <20260530211248.375318-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260530211248.375318-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 30/5/26 23:12, Richard Henderson wrote:
> Create a structure to hold a beginning/end range for guest virtual
> addresses, for use by probe_guest_base.  Use vaddr for clarity.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/user-internals.h |  5 +++++
>   linux-user/elfload.c        | 36 ++++++++++++++++++------------------
>   2 files changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
> index 21daf422b7..73b0109e9c 100644
> --- a/linux-user/user-internals.h
> +++ b/linux-user/user-internals.h
> @@ -75,6 +75,11 @@ void clone_fork_end(bool child);
>   void fork_start(void);
>   void fork_end(pid_t pid);
>   

Short docstring?

Otherwise,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +typedef struct PGBRange {
> +    vaddr lo;
> +    vaddr hi;
> +} PGBRange;

