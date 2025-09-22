Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FF2CAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 11:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0em9-0006gO-0p; Mon, 22 Sep 2025 07:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0em7-0006g2-Hf
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:32:07 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0em1-0001gy-SV
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:32:07 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45f2acb5f42so32144045e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 04:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758540715; x=1759145515; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AMr+T/dfewAzBS9BwfAt5nh2TRF2iZakiGe0kPUTzjE=;
 b=y+xjQlxngEDEU94S7IPyuksj8b5CigiLvpJNWSISYLYMMTSOG//U/G+l0LjTv7t/Bk
 GGz8wGPQCeExY1wrhVm/mXnXO5g4MgHMs4v/mpqzqt99fZzwSpOdm6TR+VVGih9prAiN
 0fsUl5L7f0fm4A/yfwcJm6tEWsCXY7ZDjHDr/WvKo+yi09MnIpdMhnEXjSsw6MI2Y5Ez
 27l9yVK2xcwxaW2Rq7Z7SCGJnYMI0fXM+T3tdADoaAZZqNnssnZWk8cjVMShOD6kcf8C
 3jF5DC2H7bCQHaIE64H1OQzsksYOouiy5imdVtrLgh2aef4xbqSar08JP6DoVS7dGi8b
 xmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758540715; x=1759145515;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AMr+T/dfewAzBS9BwfAt5nh2TRF2iZakiGe0kPUTzjE=;
 b=cXByVb8ggyfCtJQwyNxFyvFBZC3QyWz6apZUuXz9VF5rr23RPNHNb3lgoQ9Y5+QVoF
 1AAugBtYnSUKwrBtUsRINx5jtYmDXi4RJtewyPzRPXI6HTnThVD6FOTTtqf7zOfRJ8+h
 QNSfsHMM7UACqAD/AvsvPreJ8V/N4YsD9dnBQS3LAAE5+qeTiDiMvk4Dy2AifDLDQc90
 Py+6vYYJT7ILqQ1U7THjxA89o9z6xfyxHOe4zHmv7Knst6IRe/9ev+rlmxyAdSOhMQx4
 p21hNN3pa+W8URU0zgInSRsiro/P6FrTKU9xcZHulFdYAW/6UVUd3cJ5cajjGYVNEzJs
 Ghjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT7UzSa3VyL+0R2lbdeT7pf6EH2OqRwku86uXsrgULI1PHyEJaiMeKwQNqjJwxOielShQs1PmBkHs0@nongnu.org
X-Gm-Message-State: AOJu0YzNze2CGllWTzSEbzpN5+T2u6SQg14n/qTp+2yzW3YnZYMUAT2j
 r7xGAWM2UyONPz/Zi7TniEcI+bQLdqAEenC6fp6o/qLD9tcrPFoKbzKWT+21362grRRQzZYy/td
 EAm+9zuCCgA==
X-Gm-Gg: ASbGncscrP7F5CHiDTmZO1zb3UN+uicF0yIPC/pzBbRlQfCTKWdXjiKDQG5Oo8qAum2
 AqA2/syVBdPx3IlUpJV+DmJJ5i7FcKh56nN6nxRY7CTAm7NzK8ay/jBiUw4WCRgEEX21UKYlfW5
 ACdZrtodDWE+5SojflW/QeZojQFEQwu2tPsku+pKKW0dYNV72aU5P0t9tbGe+fjPHAnuL29B5Fo
 hijtGKHoJi4AhBYr2p6/IoiChV9NZ9Be0UUx1ZU3deu/Bj2GxulPXJgNpMAEVKFUfS8ta3J2kGD
 +YUFeaMN79kUPcfr3pRd6CmdOV8Kj6wD8V4hh4aa/dnHwrsj5GkBA+bWOGLQSsN3LY2F2cGLZWs
 zb1TOiRYeti8NBonqfGIsb5B09HO2byG/lkmfeIxaZr5t+8PZXTD64ezIQ7OWFTDhLA==
X-Google-Smtp-Source: AGHT+IG80KW8yzt1wcCS627aI+TTFBnIGIe5knMqOEvabBY+IU5XW5jtfz5BfwjMfaoiONoW1gKTAQ==
X-Received: by 2002:a05:600c:4c99:b0:45f:21e6:3ef7 with SMTP id
 5b1f17b1804b1-464fdf4431bmr113357295e9.17.1758540714863; 
 Mon, 22 Sep 2025 04:31:54 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3f88de2ced0sm8041078f8f.33.2025.09.22.04.31.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 04:31:54 -0700 (PDT)
Message-ID: <2506e480-3226-4fdc-bf1d-bf4324132ba4@linaro.org>
Date: Mon, 22 Sep 2025 13:31:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/25] tcg-plugins: add hooks for discontinuities
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
References: <cover.1757018626.git.neither@nut.email>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cover.1757018626.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Julian,

On 4/9/25 22:46, Julian Ganz wrote:
> Some analysis greatly benefits, or depends on, information about
> certain types of dicontinuities such as interrupts. For example, we may
> need to handle the execution of a new translation block differently if
> it is not the result of normal program flow but of an interrupt.
> 
> Even with the existing interfaces, it is more or less possible to
> discern these situations, e.g. as done by the cflow plugin. However,
> this process poses a considerable overhead to the core analysis one may
> intend to perform.
> 
> These changes introduce a generic and easy-to-use interface for plugin
> authors in the form of a callback for discontinuities. Patch 1 defines
> an enumeration of some trap-related discontinuities including somewhat
> narrow definitions of the discontinuity evetns and a callback type.
> Patch 2 defines the callback registration function. Patch 3 adds some
> hooks for triggering the callbacks. Patch 4 adds an example plugin
> showcasing the new API.
> 
> Patches 5 through 22 call the hooks for all architectures but hexagon,
> mapping architecture specific events to the three categories defined in
> patch 1. We don't plan to add hooks for hexagon since despite having
> exceptions apparently doesn't have any discontinuities associated with
> them.


> Richard Henderson proposed streamlining interrupts and exceptions for
> all targets and calling the hooks from a higher level rather than in
> each target code. However, there are a few obstacled and I decided to
> not do this as part of this series.

Does that mean another part is planned, and when it lands then these
patches will be reverted?

