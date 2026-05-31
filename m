Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4560CCD6E55
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 21:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTo0J-0002qj-Lo; Sun, 31 May 2026 17:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTo0I-0002qb-77
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:47:30 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTo0G-0000Fb-MO
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:47:29 -0400
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-45efb698ef2so559951f8f.3
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 14:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780264047; x=1780868847; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SULUbXgtDdB6jQU+fcdenQUitQ9LJvAUYI0FeK20OgM=;
 b=BCxMm3lJ0k9j6UME3EtqBBUd8es9wyAy2NkVnyVZuLHPWW9//cGMGMfoGztQp2/YfK
 KMOvuoCgRwE+/Pxe4Lg1jxKuXgvtILTBHxB1yTshQhcae0/mgaz25sT9HFFUawDxIi3E
 xw6JTVjgkodyGy65OxC+t8qnk+fJcxnesvBadvBQ+IPT91MeZYXMGef+Z3nmsiyDBrOB
 ++Lq+iQSSC/I0WQWnYkXchdZsdT18jb3vmKtGe7xJ2dRwACSBi5S93GQ7kpN0V+HLEso
 lo+tGKc91FTxLTfMb4C8ZK3aBOEfuoUrKCwLc5YqCLu1ORA62M/YcAtaJKLyqhjUtH3a
 Q5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780264047; x=1780868847;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SULUbXgtDdB6jQU+fcdenQUitQ9LJvAUYI0FeK20OgM=;
 b=hedN1RrXU6TVvvN9SdgGmqNiOrJpOtBWTI57DLiUlImM6lHEVBlMky7XKw3jp4Poui
 MelqQSP+MlVQWFRad3nYb2ZDOyUxwMolRJiIEae6G4NPC4+g2AFcSaaQX8uYXO8ruxai
 9P/6M+I72bg7rGEJyFue3EAaWhE5DI/zQIuIg3qgg+2p1gRUbmmlCLbvvuRel8Q/2evR
 NUSgkre6w9VKr67tXm50qBGZ79twUvOWuZFNSwA42lqqzS0IzcpGa1mxpCmAtbu/tTku
 YgHOZNv9zL8io9A6obK07HSa4BLoNyDtr45+TmJvKpm47T6mW4Yg0Q9YCdfHt2O295HE
 7uOg==
X-Forwarded-Encrypted: i=1;
 AFNElJ98xihE24g0uZKwadYjjf0xIly0JIjyWhbmPy23dqGrvt/Ipis9imRthgTwJN4edO+k3F6Ar6LDiKDP@nongnu.org
X-Gm-Message-State: AOJu0YxJ93fWugWhuvOcCIm2GSz0AG90o/oGig/u3xEI5fXzyeQC44Ir
 WZ3meD9lqK6ETma8+DT0WyD81VbKdOTB6ohdQWZoihUgSMTtWey+UUKhjK3OQ4UO7jg=
X-Gm-Gg: Acq92OG5E1akzsadcPEcZ0NdKpxfYB4PjLvy9cmCJmEWhJ1fpdh/LUamHB0CFuja4yC
 w6+Olm2LbtNWkAC4xy0ot5JSyf/fxfGzQmK5r5Z38PZWsdJY/cxrJgfrCzaz7KIQisYfow3US70
 GSbkYAgbH040i/QNjBBl+KMHFx1M7TK7eBTcYSqNX8eMU4rcffIz3pFeBgGFgDtxwHuvmdsmdRW
 +jGHFzOrdYqT3koc+f/qe5H/wEFFR62vLHJ23g4PPm0iosMXALqLeZnDr099gzRdlD/TBXl6qFv
 bDKr21LYcOuG4KzJQ3FypH13obBw/QaT1/vfsNfszf1uqnVdOTXm7andGpsJaccpAS34Ei4llb1
 p1jxYKxPI//XQkGN+UDrYncCDVIECxa/hl17i9Mjb8EqYfjp7RyQjH/qlUF6XyAlXEm482T1bXY
 oN7oTcXFdddb8pZDBQEZqPrVkQ5KzobRzE8ScCiX119bNYf49TaeoxqU5iA+r7gQPKu7PzkmVNJ
 NPO
X-Received: by 2002:a5d:4b04:0:b0:43c:fa96:d939 with SMTP id
 ffacd0b85a97d-45ef6b5b49dmr11319739f8f.22.1780264046725; 
 Sun, 31 May 2026 14:47:26 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34c3081sm20672855f8f.15.2026.05.31.14.47.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 14:47:25 -0700 (PDT)
Message-ID: <26787a1e-9d3a-433c-bd6c-1174ce4426a0@linaro.org>
Date: Sun, 31 May 2026 23:47:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] linux-user: Pass image_range to probe_guest_base
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, deller@gmx.de
References: <20260530211248.375318-1-richard.henderson@linaro.org>
 <20260530211248.375318-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260530211248.375318-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
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
> Pass a PGBRange structure instead of separate guest_loaddr
> and guest_hiaddr parameters.  This allows NULL to indicate
> that the image is relocatable, so that image_range->lo == 0
> is a valid fixed setting.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/1890

Elegant fix.
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/user-internals.h | 13 ++++-------
>   linux-user/elfload.c        | 46 +++++++++++++++++--------------------
>   linux-user/flatload.c       |  2 +-
>   3 files changed, 27 insertions(+), 34 deletions(-)

