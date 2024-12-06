Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5522E7717B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 08:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJTpx-0003D2-1i; Fri, 06 Dec 2024 03:37:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJTpu-00033J-FD
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:37:18 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJTps-0000cz-S0
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:37:18 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43497839b80so11813115e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 00:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733474235; x=1734079035; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7nhidEb1IbCnfI1VRfOcGhrs6Oze2WCXwJfisKinazk=;
 b=l8dF8J4iVOTJop1lHcS9FjRaZY5TPkoF0+PX4fF2nEB0QG/5VNc24Ava5YrhXaPJM3
 FvlWDnhU8DHxPqx+CIOy6TymyHCBuRwoQw2eco+8eJTQnLLBnVhpVer/NXTY+Dez2OfE
 Jcbos11PWaBJwaJbgr/ib0jiMxiBL4S1G6o0spjeHfzWMtH9NnXtvP8BXSdhPRWaStIE
 ANbnJ15IZli6CmmCycw2e9vBjNJTSB3XaUeC2BsUBPA/mw4LS1ppj5YsbYjiZQ63pjPP
 XM+d0EanwMuOBLyJb0xjxNlzxwQv1FoqUFDbIGp9/W2BVScnVQ6mFOR8ndc22vUI6tyI
 ngIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733474235; x=1734079035;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7nhidEb1IbCnfI1VRfOcGhrs6Oze2WCXwJfisKinazk=;
 b=b/YFT9UmN0I5hMzA42xBTJaw7Nt7zKukYGNGKq2hferS7um16S+58nRytICERTh4LP
 DzoPMEh1coGwLvn56yd5l0qCwfi4mw8IgBAaCRqEc60/sBoEoGAkzsKJEsrYUMt79rvG
 adtxL9Y1PmUvPJ0dMA1CP/DmBeAZOgNqBkKktxsgfqueRTaiG0O/fasD1zRN9ixgW8AF
 68TORIDJeCUlwNpkGSqmHg78ys4FPGebyqWwxEMjcjUtY+2cfKZQjFA4wNlBLjzwku+h
 eAF01SUEQlUGE3FskHTn0zplPzu6LVAbRzMTinqbdgmErrfmyuLfITXX5HScdF5bXENi
 sAmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLNfebXBvISNQ9Yb/7DUNgD3OS0Ohv+Ij+FRN8B/YQ3UUJ4gwPmEZxbszA5vs0w1w3ffvah44LNlv2@nongnu.org
X-Gm-Message-State: AOJu0YwFn653nMUpQLe/daPETRJCuBbREjkKNkc5/Xa8Q74/i+VdlQ6c
 NRcBi91MFv2Wqi0kP2Tnx7reV1cGrYYNHxrL3OM0iCKxKLBzlXOtDaE/zJ+b6jY=
X-Gm-Gg: ASbGncuADDDfid1hdYADJD5b1cvHjcsoz1+Uw5Shbj3HA9o33c5M5/HLV2zLfaCnj/L
 fSU9giHkz4D8ekTuyCkx7qwvAEIaCvpG7+EZX8FmW+ACzwMdprY6kENs93LjMpmm8YH1TRKsBK1
 7Yy8cEC28NOWsTOVhHiA0ZEnJmJoIxxj4Qm8zu2p+9R4sXf9hCw1aEU0Nt4bgOysO2VV2pa++T8
 tcEatRbqWX9ZmPsCnNycabiuxRg4tSkzs+eNjJjh58EOUaydXm1sz4PEJgORFjbtu54p+AHU3pv
 DLv18xnBoi79BpKdUw==
X-Google-Smtp-Source: AGHT+IG9DBQelwCsmMzJ54my13zdTmiwP784EUq+eKAzn8jvDb3TXIkZJ9Z1jJI33FMAm6TQxjv6XQ==
X-Received: by 2002:a05:600c:a46:b0:42c:b16e:7a22 with SMTP id
 5b1f17b1804b1-434ddeb5573mr16890775e9.12.1733474235259; 
 Fri, 06 Dec 2024 00:37:15 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3862e52a96csm576484f8f.33.2024.12.06.00.37.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 00:37:14 -0800 (PST)
Message-ID: <62a7bc66-b987-408b-a296-33b71e286239@linaro.org>
Date: Fri, 6 Dec 2024 09:37:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] target/arm: Convert neon_helper.c to fpst alias
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20241206031224.78525-1-richard.henderson@linaro.org>
 <20241206031224.78525-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241206031224.78525-6-richard.henderson@linaro.org>
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

On 6/12/24 04:12, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.h          | 14 +++++++-------
>   target/arm/tcg/neon_helper.c | 21 +++++++--------------
>   2 files changed, 14 insertions(+), 21 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


