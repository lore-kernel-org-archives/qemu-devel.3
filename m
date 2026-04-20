Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5310EF36C31
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 07:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEipd-0004fa-Es; Mon, 20 Apr 2026 03:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEipY-0004eM-Gx
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 03:14:04 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEipU-0004Sv-SD
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 03:14:03 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso22668965e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 00:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776669235; x=1777274035; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HxxduNautQfvVXpIQKuGMctOqJFOdSUEL3IghfNBNfg=;
 b=LNay7zbu78Bvx7nIiMefsZGf2pzv5v1ywYlmh+LHzzoSLgIOCZket1bK55twre5mhJ
 OY1mND6Ar+6DbrFL4dN5umZKUrjQ63CISie2hOWb1z5+QH0T9v9BQhsCMBK2Vf6Xh3KS
 AqpdagHu61gLm6COwL4jgHTHb1UE7pQmHAWIAOCyHpwcL/niKq3rpLZwumNrjX3sI5Zy
 OHwz17Sp84FuIsOwYFcOtTft2uYaWYrppxVEgkMLYP1v6l2KjVQtalbR22noyd7g1YVO
 dD/d5rl84cEo0MgW4f4CWXyTIR8a7yKgU8XtCZE6e+mQGl/+FiyMCXeYuDBvURFGGN7T
 7kHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776669235; x=1777274035;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HxxduNautQfvVXpIQKuGMctOqJFOdSUEL3IghfNBNfg=;
 b=ltiJhoUBICKBrTJi3bUAxDk6f8XBELoBjfVLLtDZ4+q/Tqqek3qYdq5jB93H2xcl7W
 lpXGMG2kAv2no6Crvf6vHfCXNG29otKewZaYjhZ/eZJ5GWBC8UxQWgToWK6x79ddor4Q
 sM8zxXrl6EDsC4XUtgUXQrCFIkJBq0svXabafjPhLm4HUIsq+rUsK88sNhHk8A8sHyc0
 yq3b18mn4jEgeARrVZ4+pCo+hO8RXr3fsGyf0HJ6L80cUmK0GTTfThVVGQEe3n1otvh7
 8pqSKK/0Cj+CiBtC33ZCN/15OJb3eHzf83UcsJKCgY22o7qQSO0fYaoNiIGQ9H5RinBQ
 847g==
X-Gm-Message-State: AOJu0YxVn4BQmnZXTQ5qlqzMuFalayDTRkBa9hJYbjwCtN++q8p6lVRp
 L5em4SLvP/8bkD2hONHNbhTndUjZPtbQuF57cvi1MwTxcyWadzaYWqr8XA9eNJw7j7o=
X-Gm-Gg: AeBDietYS6HtTqpz+8fgNLTiJ0X2VdXxW4l7sHPj+h+B5QZvf+IWRrvE9Gj1Op/LMqA
 IKpvLIyG/Sroi7nyEN4hg7VC+E+lCyXyRTmgvOxVXeCmP/ZVHyWUYGO4Hzdy75zRREaac2ETH4c
 rmQ0j/4RC4Mszp6oM6jM8gV2yQS6ez+qmarIkFrfNwhvzqrIMWgikQgc3v/0K9JlpKZm/3/d6ko
 uFITSvKweT9MWTNT/HrNoHYF/o6B4Rrd3sc64+CeR2YmRsYtae69LNqqnvu/3ZJX4EmATM7XTI8
 huU52//v8eD4ULDtHFNB9hGZTyQ0JI0Zu11ExMthdsOqWr1bssj0ryMX5MVZyj5COoJ8uS+1/Wf
 vCBR/aUyx3W6bCZlZk6lAjYZvFr8W9uRh+qT0PX8Y8p9gG67+SvVSoSUA8UVXm1REhw0qMXro5Y
 M9/GEvv6fg2zar/NziQ4fmmivcn5ABQfokPyM0MbiXk/oqqIJPBivfADe+70XGHx1/tmm4Cqgax
 kwN
X-Received: by 2002:a05:600c:1da1:b0:488:79a3:f04c with SMTP id
 5b1f17b1804b1-488fb7863femr185214705e9.27.1776669235177; 
 Mon, 20 Apr 2026 00:13:55 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891978ef6bsm33937005e9.4.2026.04.20.00.13.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 00:13:54 -0700 (PDT)
Message-ID: <33852de5-a2a7-469c-9c08-177b2f3f144c@linaro.org>
Date: Mon, 20 Apr 2026 09:13:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm: Remove hw_error() for the unimplemented
 CM_LMBUSCNT register
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20260420064933.64765-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260420064933.64765-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 20/4/26 08:49, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> When writing to this register, QEMU currently aborts:
> 
>   $ echo "readl 0x10000018" | ./qemu-system-arm -audiodev none,id=snd0 \
>      -M integratorcp,accel=qtest,audiodev=snd0 -display none -qtest stdio
>   [I 0.000000] OPENED
>   [R +0.001907] readl 0x10000018
>   qemu: hardware error: integratorcm_read: CM_LMBUSCNT
>   [...]
>   Aborted                    (core dumped)
> 
> This is bad, a guest should ideally never be able to kill QEMU like this.
> 
> Now, according to the "Intergrator/CP User Guide" from:
> 
>   https://developer.arm.com/documentation/dui0159/b/porting-integrator-ap-and-im-pd1/registers
> 
>   "The Integrator/AP CM_LMBUSCNT has been removed."
> 
> That means this register does not seem to be implemented on real CP boards
> at all, only for older AP boards. Thus it should be fine if we simply
> ignore this register in QEMU and handle it like all other unimplemented
> registers in the "default" handler of the case statement.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3407
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/arm/integratorcp.c | 3 ---
>   1 file changed, 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

