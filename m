Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCFBFEDA0E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 18:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ZcF-0004L5-I6; Tue, 17 Mar 2026 14:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2ZcB-0004KO-6y
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 14:58:03 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2Zc9-00050v-Hm
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 14:58:02 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4852fdb36a8so71322655e9.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 11:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773773879; x=1774378679; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yJkWYiLIGqVioNfAcL6Y1XAMAyuB4FLuRT5rWj8lJOU=;
 b=Gx1Jw8jxFDXLq9gxojpHwOxLvT7NZQVsTmyiLs7igDF/4olJ0YljO+/frwW4dIEAXL
 XFwc/hP7ub2u9qthA4A/w5nZRTXUjjDioEUBY4MnKH9K70wV9+R15NSTFV+KHHJXvxw3
 v12wouSur1bLp906GqcadQiybCx+gmkufnd4dKhFpnaU0YeY7DWVNRWGIXRblgYTHNaD
 YqZ95O3dkVNAo9nHl3z3Azfb8sXltYyUfQ1ncQPuEbeHLFNtFWeAE5qyQctyJnCthH6V
 dlP59sZV/uyoWXFTBtOKZ7KUdjiIppm3sv6erJXNZHJv684qUmpJEAz41zXxosflXS16
 YIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773773879; x=1774378679;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yJkWYiLIGqVioNfAcL6Y1XAMAyuB4FLuRT5rWj8lJOU=;
 b=rzZooC6Ik7lr+d5JD25cRJXYm3EKQIri7xCdM5gLjv2zVSlIu+IzV43Ihxs3V5x/Vq
 YYpnRnM7OO5QQtLzPENWiMgpMSGCZUouTXF9G0AFxs++FqbOV/LTU978HebZdQZQmfpf
 SyQrUgsnjYaoo2Qz4F7YivAFqah6oZmIeSHJw3Ydmcip0GkUzSsNO417kCVgOWviYXt0
 8FM9QyDEQhR4st3RThpzAdXYekE6xGkLKNKa4Dv17cD/A1wYSxDEBc0IB5koiTLx3Oy+
 ANX1HpbtbxYqdrKRbLjs1owtF9HL6os+p5itcjcPVs7jEejL2+SpBKT2EixtPJn8kbNy
 POYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnZwdC6b4Yw5Ps5NlENpUCGZcodEEyrLLXxJy5svhFnzUXAjp2hfYpi0TXIgQN6hIEs6Dmu/M29a6E@nongnu.org
X-Gm-Message-State: AOJu0Yw+CkUZx3RgqkY3mLBKFqRs7S3xHmBzd0M+UH+OQotXK7WAJYU+
 dibfN2voH4QYoM02dvxW4rY6pGh/or1pIBAkpoSXTifxDxhVTH4M6tJkA50IMM7Oo3k=
X-Gm-Gg: ATEYQzwcNLnVmxFYGqSkrgv6SoojJIUFzkiQ72PTsnF7mFqp2EkjzLd4t2EcmBqFDsC
 lSCqVmmO9wKD/0Mgh6cEmM/CgldrHWls9GJ5h1eOcUmI7fEXxJV8Vps0wOlMqoerDk5R7QeCovq
 8jaCItiEoZsKgGP5x7HwCxCOh1VhsRxq1quoWGI9nm2LbbI/bQmV2t23yiLom8V8lgNdWHVLKi7
 Yge7AOY2GQL0XYobxduseF0R2HbsXoPvTmTzhzkz5rBo+I7m5mAb7nBZFz3rn5StEaspeEilNAL
 7puNiFB423FpWVozbyXwcK6SDbwSun8UuXqJ53gbuRw52PD+oHxyXxamgc2Ge3Oy+rhHPWcrmh7
 sKaGm0ur0GvMdbGZAqSfR7cNGErWxWlk9dgjKijP/f1Q5YHSHiLg6PGgRY+WtAMCrwcQu7vmJSJ
 r9QEY5+SWLJUKKy8PJ0bX8CAUrudtHkXKxh3+ProGIcPqbJZ/wExyw07arTYE/cbqCAQ==
X-Received: by 2002:a05:600c:1d0c:b0:485:3cf3:1010 with SMTP id
 5b1f17b1804b1-486f442e5d6mr12095395e9.2.1773773879088; 
 Tue, 17 Mar 2026 11:57:59 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f443ae26sm9341145e9.14.2026.03.17.11.57.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 11:57:58 -0700 (PDT)
Message-ID: <bd5b5f1c-db87-49f0-b880-70a26ca9fbc3@linaro.org>
Date: Tue, 17 Mar 2026 19:57:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/mips: Move count_clock to MIPSCPU struct
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20260317175031.3035740-1-peter.maydell@linaro.org>
 <20260317175031.3035740-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317175031.3035740-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 17/3/26 18:50, Peter Maydell wrote:
> The count_clock pointer is not something we can do a shallow copy of,
> as linux-user cpu_copy() does, and although it is a system-mode piece
> of state we unconditionally create it, so it is present also in
> user-mode.
> 
> There isn't any need to keep this in the env struct rather than the
> CPU struct, so move it to avoid possible memory leaks or
> double-usage. This also puts it next to the other Clocks that this
> CPU has.
> 
> I haven't seen any sanitizer reports about this field, so this is
> averting a possible problem rather than correcting an observed one.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/mips/cpu.c              |  4 ++--
>   target/mips/cpu.h              |  2 +-
>   target/mips/system/cp0_timer.c | 12 ++++++++----
>   3 files changed, 11 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

