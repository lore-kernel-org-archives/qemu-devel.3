Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41748CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNpY-00072B-4P; Sat, 30 Aug 2025 11:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usC0c-0007Jt-Ij
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 23:12:06 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usC0a-0001Th-O4
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 23:12:06 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-24457fe9704so28628565ad.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 20:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756523522; x=1757128322; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W93BYCdUb+ss8Guv9YFZD35WMY45GW2bvrGgSXT5vaA=;
 b=kmSsIlrz35T0RI6aqU01gJEeSH0x1kMY6pnL/yPjqY24fX5ga1xEcWUMt2b0uCHFtt
 AKGFTj9xAhQ+ulerg0AQponW9DXsFLXQAWyRkSqGavUSEWMQV6Gu9PMMLZUH2F11Sv0y
 aD+Bf3STXWsFGZhHPfsEMJ6uX6hw3sM35bMtf0facFe2CqFuEwXbQNxXv29MZOhNOWeY
 vqW8m9h90DU14BKJWTkATW8Gj+M3aVaKS8O8s70wxhfJqz469S2UHliNQZJKlcoAvK2/
 yIypRxBJtwcdKNqyEWUcKN+/1bNNTTKNRIGwH+CpkwUO+exIt+SMksq0e2dQni3npl3R
 rkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756523522; x=1757128322;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W93BYCdUb+ss8Guv9YFZD35WMY45GW2bvrGgSXT5vaA=;
 b=pqP7kpmVSPNsl5DirzQXSESknDq6v2LkU5RwiCwxlAW6DHprYEvlEGL7mRd5ep0pcI
 6Ws37CeTJaRBnSH8Yz0BtmnO5nu4knRtXaMePBiNPFxYGFKgBMvHSHnfgynWNVp1zULd
 HdOiYQjpAoQXRh1VgadD3RL9HBOw/V4H9rmWOG9IDVE8+w1714Z0m2ruIGL+vr9xoJiD
 +doQpzbnoJyyurINOvz3UKv4EtVwY9kbd7U8rZ26wHv3+NxeqKOC0SiehQKWhyFTqWYT
 yEa+uHymAFmI7X9yfUJZklvKWC60Q0Rqd0P6Gmy+2kPrw63W5lq8XE+hE4sBZ52qcCPk
 AJLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVkAYVj0BoOpJlVGp/5Yr+3u3LHGpBSIw0NUxoP8RKNSH3L+7c0c9OCofKIONLvPjDN/SXZkIXBQjR@nongnu.org
X-Gm-Message-State: AOJu0YwrFcDv5ZWD8/Z2p1u1Ch0AHVtYFYSRpQlhQryoLvGvzra1O9MQ
 HfJcBcm+4OQxSqXtSj5/69CWLiQLEcEWoFZrlcvF4O97tAxOI4YY6Ro38seOVQWi+kI=
X-Gm-Gg: ASbGncvgPEXZaKILaWnXW03z7UIbMNvHioHiZi83c5KzIr82JD4gnRahm18OcP90YtY
 z40BqmwVuJZl9l0LccvPcK7Y/aJykJOlaBhZN9xQiKFwgr6DOthETzKmIj3kPYzlfiw9wlNRCry
 AfL9lAB9jQPO3nEtR61xmKE+mp0BF3Pv8eJIOaHfoGfhOqWUZlGnTqaVgYVt9VAXu8cSNYh9JHY
 iBEsER6VizRExN66AIyPVkctbAT0peeYfP+7Cj8r3/DO7sf4yMhXE6IAO1oP4AdX2mibwfIXJLG
 Y3q6yGkL4aOn8Jfg4iiqsILuvhtXjGESH4IEOT7DoZdDgi3da9QvFv6az/2f4FSwxA0qBwrR6nc
 rmX7zqi0gtdQzxgb6s04pAiJsJkYpSWJp74UhDmwKn+DD6TQKFQdBZgg0BWZnvacCIEKSGXhUk1
 U67EVu
X-Google-Smtp-Source: AGHT+IH4wRgt2YdrgXMyrFQrfMonHWeBtRVet+XOXL06Chw+3SIAkyduF7+3uL5wvSsVl6BUODuv2w==
X-Received: by 2002:a17:903:944:b0:240:11cd:8502 with SMTP id
 d9443c01a7336-249448cfba5mr7920945ad.13.1756523522296; 
 Fri, 29 Aug 2025 20:12:02 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-64.dyn.ip.vocus.au.
 [122.150.204.64]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490373e321sm39053745ad.55.2025.08.29.20.11.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 20:12:01 -0700 (PDT)
Message-ID: <b48aad39-d408-4666-9b19-e8f1fedf1a47@linaro.org>
Date: Sat, 30 Aug 2025 13:11:56 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 18/28] target: Use cpu_pointer_wrap_notreached for strict
 align targets
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250528081410.157251-1-richard.henderson@linaro.org>
 <20250528081410.157251-19-richard.henderson@linaro.org>
 <dee8def3-3ff7-4a86-8bcc-430f3775c1c3@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <dee8def3-3ff7-4a86-8bcc-430f3775c1c3@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 8/29/25 16:55, Michael Tokarev wrote:
> On 28.05.2025 11:14, Richard Henderson wrote:
>> Alpha, HPPA, and SH4 always use aligned addresses,
>> and therefore never produce accesses that cross pages.
>>
>> Cc: Helge Deller <deller@gmx.de>
>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> This seems to broke booting debian on alpha, -- see
> https://bugs.debian.org/1112285 .  I weren't able to repro it
> though, - asked the OP to get a backtrace.

Ok.  I haven't reproduced this either.
Let me know if you get more information.


r~

