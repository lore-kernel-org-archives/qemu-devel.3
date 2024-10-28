Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB27D5B84C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 06:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5fRP-0001UX-EQ; Tue, 29 Oct 2024 02:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fR5-0001N7-US
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:10:39 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fR3-00077M-BP
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:10:35 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37d49a7207cso3591458f8f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 23:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730182231; x=1730787031; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dKWEdO2S5aw/JSzKgSCFRrq4eJQgzUdy3Wu8jQfmul0=;
 b=nARUA9+dwVq4Rr2YuIm+6mCt0MUMYQi+BBk1iCywGVGXIsM6U3XmOr+YNVB0tGJfdk
 VfFdj8+p40Y6b+2TZ5Pi6SQdntcjR18fvV238zeOSeroQpBG55pIEJniOPNQK6Muw7co
 7UVng2jzQ57XxyAqD0WgZkfK992XLMMfrJi00Vl+tOUhFSLzTNC1x+a3B59TyPjM94ak
 qtrmzqiZYBqHPqjqON/4ZE8ufIjfgJNeJEnXdWpAKp+80LxVDuj5bLWVw+MKo0tXHyc+
 c+PWdynjl68jQnIaNKhr+FktsjyIVCm2NR4a33PZ9rr6HB14spZ4od9fdcsfsL1WmIya
 jgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730182231; x=1730787031;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dKWEdO2S5aw/JSzKgSCFRrq4eJQgzUdy3Wu8jQfmul0=;
 b=qVodYfHp++JtjJZZtZvhUV0DbM0hmW5ehBA8sZvjV0vdzq7U0MFMrDmtSrGCthw5YN
 C3ij09yCprl+cq24Csm7W9ZIG5Xkk/nR7pDWOEUYHv6I0UnxvgjQPQ63t75HLyK7mg66
 4zG2KSBRY2uHdEPjPxkiNOsRJEAmej0oe9SISe6jOM+9Ft4dH86+ZBB6O7OVNXVZFD2j
 XQ2ZOlV8BdvXvLrmP2fZuRN2r2P0wggLd0jUyGIcJHF3bLbGkNevpZ86I0GFRKOCPK+/
 6iBr9YrjXB4+KUCA1rqyMPyLg2WL/7daFLlooAG3KjN6u0Ve25oKx2vkPGV6H9A9GRCJ
 0fbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUM11A5yhEzM7bslYfiWxJp+1qFb3/gyXNwjcwGUQa/Aob+mfAh2c/7R6FXRUKUeNGr4XkG5gBTjmyD@nongnu.org
X-Gm-Message-State: AOJu0YxrjLgXEV0o63/WLcwlRfZvGKTnGP7Tx0GxdMxqpOcmJsm/6KGc
 dAUuQrt2BrP03yznRbWOBdH8jZxM1eVAyPsnvMaIlQ9Y73al2SBTmDk2L7j75io=
X-Google-Smtp-Source: AGHT+IGGy0H/FlmH2GUISdMS+4yeXD6bznqQY22mE1VDSljWmF9uQ/5LJb5oAfoIAEYon5L6JvB13A==
X-Received: by 2002:a05:6000:104a:b0:37d:377f:da4f with SMTP id
 ffacd0b85a97d-38061159595mr7630058f8f.27.1730182230553; 
 Mon, 28 Oct 2024 23:10:30 -0700 (PDT)
Received: from [192.168.21.227] ([90.197.151.65])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b70bc1sm11560253f8f.70.2024.10.28.23.10.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 23:10:30 -0700 (PDT)
Message-ID: <a229e630-954e-4681-87d0-6b64983369b9@linaro.org>
Date: Mon, 28 Oct 2024 12:10:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/21] target/arm: Explicitly set 2-NaN propagation rule
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
 <20241025141254.2141506-4-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241025141254.2141506-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/25/24 15:12, Peter Maydell wrote:
> Set the 2-NaN propagation rule explicitly in the float_status words
> we use.  We wrap this plus the pre-existing setting of the
> tininess-before-rounding flag in a new function
> arm_set_default_fp_behaviours() to avoid repetition, since we have a
> lot of float_status words at this point.
> 
> The situation with FPA11 emulation in linux-user is a little odd, and
> arguably "correct" behaviour there would be to exactly match a real
> Linux kernel's FPA11 emulation.  However FPA11 emulation is
> essentially dead at this point and so it seems better to continue
> with QEMU's current behaviour and leave a comment describing the
> situation.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   linux-user/arm/nwfpe/fpa11.c   | 18 ++++++++++++++++++
>   target/arm/cpu.c               | 25 +++++++++++++++++--------
>   fpu/softfloat-specialize.c.inc | 13 ++-----------
>   3 files changed, 37 insertions(+), 19 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

