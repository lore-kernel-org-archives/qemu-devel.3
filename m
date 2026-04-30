Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75FDFF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 05:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJoh-0005US-6W; Thu, 30 Apr 2026 01:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJod-0005TU-Cr
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:19:59 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJob-0005Ta-RS
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:19:59 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so8036235e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777526396; x=1778131196; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sOYf98GYsYlSUi/d8QzH9IzEzINdTaBeN+dEzHDsUY0=;
 b=BBeBUW54ivinnsdYEb+z3W287kP7fQq0OQ/tOJJemO8SSl+Q/1EKx9ptOEnEO6vpOP
 z+oQCnl4MgEPzxjSQ5/lzqx8/xgrADTXnfl5YDdA41iTqVS1Wb61zp2F7CKzC4ZY/95q
 mZzO9K7ZQ6jxxvNps0Lh9PCnrzFgpBGeCy8CBxjDd394q0SWf5saUxOptbW8bdI+M06X
 yWxKtsUyzC9Bdtv4ovmAENDjET37UkA56AKkFwqRojEwKRDOb+gOS515y1URdp5qLqUF
 0unLXw5bHppokP8rfKe3ZV/1o3vzarqJU8NEVD6ocnhM0AHpN2CcASH+N2Zb9jVd3KUl
 G3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777526396; x=1778131196;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sOYf98GYsYlSUi/d8QzH9IzEzINdTaBeN+dEzHDsUY0=;
 b=kDevVPmNwE69ESj0SLgr1ITzk/XZ5YOOEYxP3Z61qWtKbA9ecIyTnl16vWc3FIkV+9
 m/II9GZpxGT1VAEwfNl0ivuvSr25G31qYnYpyUWSn/hPmBBhh7Dq/04vD6kt91OEe4QV
 rQArTz4ieERXb74DLGhGCwIGYJOJMZ6Pcprl72pPskWRaG9tj1APp4NFeDc85cBk2tkd
 B9yUQmsuJbfF5EbXKnkzq0vxF3bbU3ExaOM3doRRbp0WmDDaaJXZ6lRgxHcbRMscTUix
 J7o4I2HPkdbgTHzVr7NdCFWbMUa27K/D+WF15OD/NryQvC0ZtQyOtBFZoBvTonht+qu7
 dCQg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+w60hYVrkNX/wS+2IAUbGuG+FXf3Iu/fiJytk0DLejz9BPf1a4QOsKCSVI7UkZuzz7wy5f3fJdq1zt@nongnu.org
X-Gm-Message-State: AOJu0YwoW9EYXSekqbS5Srr3D7K2uTV6qbwo5pEcDUSQd0ZUnVAkBZwA
 GhoED9C6bQA9O6oBMlQNcU9SYzUrII9dw+vDaYw4DQ6+bSIbc9tTVCZZ6rOeTSDty4g=
X-Gm-Gg: AeBDiesU/KDPlgpqEPVzew17ItGGHqSP/kIENBwn+/AwRCehOoZCmjByLtgLMHJa4cc
 Ed+QVruKFNj56axqsisVD/R8Rh6rf7sJ4oo1Vo4+ikxCP6p8P2b/12tzqqqjR0KsL7ruCrWKwee
 Y3B0NCIwAp/is8ofazIw3Gene+Iin6gqugjQgYnk0NW5uA+Kbjd1pe3C9yGtZ+/p5RjksglcQMB
 XP1DSVCyTXV86ePCW2QGbtouy2J3HUO4GJQnZr1wQU53DVGY9MxMQvPxvOje9T/2pcNLv4sQTni
 kA9DFLm0J4pEfwvYsRDVasGZji32j6uHM+NDmbX6q+X6fVxNDLc2ZDKMTjHzKKYVOE5KMiLcXAK
 QmbnqTACPywQAQCyFqInK9R6EH5yfSNvtXGjVH+DfBAmNSoKHiSHhWL89zKtKFvFmNYBdmV2z8+
 yrXTZswEcnZtYBXJuUp/3AOxakCthEDYPUk3N3koTkJ4DgD2Gro4y4eBQQDVNm4TipljSpVFwD5
 Ixh
X-Received: by 2002:a05:600c:3e8d:b0:48a:53ea:140b with SMTP id
 5b1f17b1804b1-48a844a4728mr20764735e9.28.1777526395907; 
 Wed, 29 Apr 2026 22:19:55 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a81b99127sm36861095e9.0.2026.04.29.22.19.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 22:19:54 -0700 (PDT)
Message-ID: <674755fb-f857-4008-9d4a-07dd1d1f9a3d@linaro.org>
Date: Thu, 30 Apr 2026 07:19:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 31/40] fpu: Return struct from parts{64,128}_addsub
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-32-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430000524.56046-32-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 30/4/26 02:05, Richard Henderson wrote:
> At the same time, export.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/fpu/softfloat-parts.h |  5 ++++
>   fpu/softfloat.c               | 30 +++++++++++------------
>   fpu/softfloat-parts.c.inc     | 45 ++++++++++++++++++-----------------
>   3 files changed, 43 insertions(+), 37 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

