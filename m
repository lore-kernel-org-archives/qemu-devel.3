Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A5EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 01:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seOys-0004GW-2e; Wed, 14 Aug 2024 21:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seOyh-0003rA-Vv
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 21:08:37 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seOyf-0003pd-Vw
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 21:08:35 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70d2b921c48so329748b3a.1
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 18:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723684112; x=1724288912; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CmqHbOp7wYUoT2YMfl5DkEQLY2NDOvGQIIoAk1F1FCI=;
 b=qshPS6wFnSd497yDJM5M8vJbUgqJdOn+Jfxd+f4n3JgtsE6F5TSntNxtE3oPIgyJhc
 TwLc5awde5ILiGN+VhoLMyMV16pHnbrNk0bI4Ssj6k+StTckLIJqqv2vU/HLcsY5AOXX
 iU9SyHTTTwpQR7BGtuNM70/hDgOfQf+Q1u0Wu8iizO2LbkqL5nGQ1mDoaZu8VabeYPdO
 wuO2ccQwbaYBiN3SckRJNyfSqcqEYdvv7GCqse1LaYT5LkMidZFopmlgkL3iPTQDRN4j
 Yp7PZWKq03279yAFJGazfwM9pm63kD4xNZgkXD5F4AQfn3nn0Us5ivebcepJdAtgZsNj
 cupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723684112; x=1724288912;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CmqHbOp7wYUoT2YMfl5DkEQLY2NDOvGQIIoAk1F1FCI=;
 b=lk/FjCrhFOxtU5yxJTH65urAppzTFroNkwtQrgUY8/bdjrWEF8OKuZOn/06O4uIbYS
 VqP9ks6DNFsp6zqvokyUuPT9wC9RebJPjDKchmf4cY+DCr+obre/qd3gUh9xDfam4Ewn
 pG8kkoXySUO6ef3T+2PJ6cnWBNQAnw+nQ9ldqBeh/EvKtpVFAXuh8yxspI8bmHLH3kfe
 hsrIq8gXqgB1tnez9O/PluYQ17G74CGSE/l8qfT2Zxw6tfDieQsDoM4Uvl7bPbogfZ71
 9U7JteEpZQk1IZF+SwgkC88FaCDABelRsI+Fu7xsAHZzXAz4kuR+CMyZQye+I55Qi+dC
 UQIA==
X-Gm-Message-State: AOJu0Yyd5LXvOd0nFr6w12BTdRbcBR0h2pTK3TMg7EAlOzddORuyHd+2
 yjX7gR44q6lsPHyQBs9B5YbhQwiSCPDS8fxow//oOQGJjhROsx1fpuTArkh6d/4/PYVq0Z+4BV9
 t
X-Google-Smtp-Source: AGHT+IFxUDVSTI92g9aceDqcQVOTq/pmWEpWtG04ZPRvisvE/8CbbnPtrDPmzhk+bVZmIXwRksCSHA==
X-Received: by 2002:a05:6a20:43a8:b0:1c4:9ef6:499b with SMTP id
 adf61e73a8af0-1c8eaecaa4bmr6652126637.29.1723684112314; 
 Wed, 14 Aug 2024 18:08:32 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7c6b6356baesm137930a12.68.2024.08.14.18.08.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Aug 2024 18:08:31 -0700 (PDT)
Message-ID: <e9591a35-9710-427c-bcd0-669d510d702c@linaro.org>
Date: Thu, 15 Aug 2024 11:08:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] linux-user patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20240815010556.535100-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240815010556.535100-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Bah, s/PATCH/PULL/

r~

On 8/15/24 11:05, Richard Henderson wrote:
> The following changes since commit c4d062885529a84928ddd260dab419b7d8dd4f90:
> 
>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-08-15 07:41:16 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-lu-20240815
> 
> for you to fetch changes up to 3aefee3ec01e607529a9918e2978f365c5c3b5e9:
> 
>    linux-user: Preserve NULL hit in target_mmap subroutines (2024-08-15 11:03:47 +1000)
> 
> ----------------------------------------------------------------
> linux-user: Preserve NULL hit in target_mmap subroutines
> 
> ----------------------------------------------------------------
> Richard Henderson (1):
>        linux-user: Preserve NULL hit in target_mmap subroutines
> 
>   linux-user/mmap.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)


