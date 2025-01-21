Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F618C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 23:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taNbZ-000263-Si; Tue, 21 Jan 2025 18:24:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taNbX-00025a-K3
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 18:24:19 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taNbQ-0007UL-8U
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 18:24:19 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21a7ed0155cso100831235ad.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 15:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737501847; x=1738106647; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rs3dCNUwSY0XOcZEFo3g20MbK4Lzwm6L6sxtsL4qksY=;
 b=fNx1bIxXyvlZ22998M/SUYBuuGP9mPHHaWG6wlUfSegSVHS43DaCKcbjTxP4Jd7IJl
 jG238AzU+wFfr+Dl5edJ+MxYMT5SMABmnin37wuTgKotc1p4HT/u5RTCtPL5Us8hk+9H
 SgFZHsehipK6IMnOVnkLM1GB66GLmk8QNdOKG2iSTdK3VNkReH3kG8Jkxkn1QW0luh6M
 d+BYa1+DBHQi1sfXf29wF6XVNItT9fuwcgznyFlJFz+zsPid0+UURXXBSL7rsjlK/8U5
 W4ETYT7B73LwQPJSnahwdetlDs8Ft5dQueUZzXufMn8Ntu3WHWElzOQT7gaqa1gleVwA
 fRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737501847; x=1738106647;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rs3dCNUwSY0XOcZEFo3g20MbK4Lzwm6L6sxtsL4qksY=;
 b=DQw5euXrgPd6eLXUoC0GlusCeHdjul+uaQT7b4vfrj+9Wzu0bR0c6RAT727o70NAvf
 iUi4jp3I0tYop1Pl2nGkr4/NPxnUHNuowNgCi7n9/GVH9axwOjwYxSl03pZSbzq72AOc
 6VYccP9/SsIpYObiXfQ2Q+eQFLy2izJFLwu4D98BQ/xFiXbMz1pl7UeSxdvy/m1FAcVS
 I2f6ze29Cr6pYgTzWxt+Zhsa25pLGOiKgRjGq5THOKotKZ3t6kAAMqK/k0UHwW/K9KQv
 DMUrekawxVtPE5oYDV5Vm+gs6JhPWeFoyw74eolrsWrqMliHTVU4efDoC9BYQK1HgvpB
 2Qxw==
X-Gm-Message-State: AOJu0YwXOGfCAAXqvEmRiuYiQTaiGpLurYjFGn3jtd/Xt3RghZipTTgS
 0Lugu73E02ozCYIRtDHjeq7XFkj1yMnPOqM/NMhUVfkA7MCLfBW8p0QRdnKkCprKT3+YYKspB3B
 G
X-Gm-Gg: ASbGnctVRMBybsT5UqPhWIrQpFg9taZ7GP5iCLs+N6cTUsU9iwuvg0WpCLOBrft/kur
 VdoSAz2WxPKIoshdhiVAPTtYwVis37ei/XpSlgl9zJigH4kkkwRQocek+uWZjXJCFORn5oe8ZpY
 cu4iU5FGVQduAIBuUs4yA1OBHXSMLXm7kjCtu4tsqN/WUvc0YiSU2fX86TswEFC5dAB+OpQQJrT
 awRG+Cn0Ng7FW55KN6v3mOZKN89lE3HKl9ijoWHPW4cpGJdQvm3W/I5hkawz+PA1xgtwHqaMc01
 QiFs1oWmv18WLkRKyajfh+l+METYWv4uTGBnb2+FJF+KljE=
X-Google-Smtp-Source: AGHT+IFDJV2Lmj00IPDmMGrpk31r/jgWoOEsc43/QgJL+T+6kOKKhrMOAu/p17aTabB3kFyxJCKHPQ==
X-Received: by 2002:a17:902:f54a:b0:21c:e19:5692 with SMTP id
 d9443c01a7336-21c355c43famr276247475ad.36.1737501847108; 
 Tue, 21 Jan 2025 15:24:07 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3a8a6dsm83110395ad.141.2025.01.21.15.24.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 15:24:06 -0800 (PST)
Message-ID: <178b7292-4a53-4d5d-94a4-96175605f46f@linaro.org>
Date: Tue, 21 Jan 2025 15:24:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Constify target_shmlba() argument
To: qemu-devel@nongnu.org
References: <20250121190339.58223-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121190339.58223-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 1/21/25 11:03, Philippe Mathieu-Daudé wrote:
> Returning target segment low boundary address multiple
> shouldn't need to modify the CPU env. Make it const.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   linux-user/arm/target_syscall.h    | 2 +-
>   linux-user/mips/target_syscall.h   | 2 +-
>   linux-user/mips64/target_syscall.h | 2 +-
>   linux-user/sh4/target_syscall.h    | 2 +-
>   linux-user/sparc/target_syscall.h  | 2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

