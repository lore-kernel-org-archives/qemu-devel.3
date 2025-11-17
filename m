Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D70CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 09:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKvPI-0003kH-KH; Mon, 17 Nov 2025 04:20:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vKvP1-0003iV-Ac
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:20:05 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vKvOz-0002xR-NZ
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:20:03 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4774f41628bso26231205e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 01:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763371200; x=1763976000; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=12jZZeLTvfy9HJFuCu3xwvboNtNQZrKJ9IZFVJ+nnxM=;
 b=Xp7ckIyJGtQM4tQBnbWAYRCt3suXyYKYO8caNu72J8Yqrwxts/1bGvHf/QXy7CYLvM
 uXL/g1s4+OYAjiYF/NlEWcSLGgqLSnlWLiogUfPRE0MM5P9Gi1RU4xQ2gIYwFqZtZRIO
 0vBUUmAYU00+IIcwJNcMkcuQcn/XEaLI6bnDgF2KHZecfqGLMDEfXI4S59XevQUDsoUR
 v+BaB4pmIBYRDRZ+Uk6HVtwj5DIphCSJAWfHWqA1AqJispROhV465LWGe36RU0LShalb
 /36agVLpbA5VEhnrWr63KK/HeCvGMqr6QoOxNPhZZGsIbAU8x9lUBORNymaA2TO4zVY5
 eXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763371200; x=1763976000;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=12jZZeLTvfy9HJFuCu3xwvboNtNQZrKJ9IZFVJ+nnxM=;
 b=JaeMzG41gGTdYKURlZNN+nurJlGLrggT+aQ0SJA1UZENQ6PxOjFcO6S1WP0WbMgO35
 kUHTAweESxtTL/jNOk3KAhw8Ob2Y4qz9xGx8xaCuQ49xt4bDGW+mg19pgKv8y6p6V3ca
 1zz5GBaMD9k9ZLRVidhHr2aCC+IM3IA5efxaxEVkPTISnkIxdqWYnxiICZK48RKclhgk
 rf82FVF9lkByxT0p702w1vgdf223ThexNbseq79VxZfEHJZQB6OIXqqDHzGFiV+5S9OE
 +G1LqIEtidiv0xji4LJ34bsAtwhuukCxk3I9+YQ8RgHmHYBo0PGGI0V9Oj6S8xLt9+0e
 lrXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEjNCK3hhA9zBTSWq9EAR8b11qSQKEJDmyPLWaW6Dol0b2+0LxLU5B5kPS+I5GGPVfhcIYQ7uBX1uF@nongnu.org
X-Gm-Message-State: AOJu0Yx1NLeGvZceKzMPzTJzKBmzdVCet5vC8qmYxg2UD6psZQH+rcx6
 EdOxSM9IJFfAtiN/sXvdmbHqYsiaANT2GS9ZAwAKCankJ3/TJFosi1bfW7ogcrszdi8=
X-Gm-Gg: ASbGncs/ipOgj6Ctrx6F0lmWWuJfgvP2oezs38gH0HsIcCDRCWLnz1ko1yDndE+OZXE
 PU8Euvk8FOdIE6E2Hws4WXKF0n8kmoDv7YejRAdfHpqeMi3XpIARQlWy1WI1O0AbHMI2Nz1xE2Q
 7JiQPn4Ul98wjwHtW0GazpQI/nc77BK65u8EYNzni2nc4+ilkat22WpOQR3EYQj6eMr1Ep0pvXQ
 DnlnAX5VWCWeeSfz1IBbhE46MGe7GWI0fxQF+PIgb+XoOV+a4ysatCOtbm0dxyGLsdejCYhD9Wb
 5kdx8NUXrZRDr67Pn7+xheLX965lc79x18oilyjT0IkekAxVEJfiVw7ghKPvZoSaSuD6qfHwX4S
 qTJctbCA4VYv/zHb11K/dxE9wVku8k7vC9n2yqHDbajvvzeXxNTZl3/thWcvRkUvHsNNHCghHLE
 5ZZpV4/n6AhrgigCzmeYsK8k32oIiYKdmwjSbyd2SUClnhTsSbewpm/hS3gSUO
X-Google-Smtp-Source: AGHT+IE7Gye+gnDU2YqzZXOy9NYg68IZin26VGax2m+8GT3THFUzLP7+G3qsURc4DVvoEhA4LutYHQ==
X-Received: by 2002:a05:600c:1d24:b0:475:ddad:c3a9 with SMTP id
 5b1f17b1804b1-4778fdb3970mr117062155e9.13.1763371200114; 
 Mon, 17 Nov 2025 01:20:00 -0800 (PST)
Received: from [192.168.8.105] (66.red-37-158-132.dynamicip.rima-tde.net.
 [37.158.132.66]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779b509a5esm119434345e9.2.2025.11.17.01.19.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 01:19:59 -0800 (PST)
Message-ID: <245a1415-1493-4202-838f-e13c3882eff2@linaro.org>
Date: Mon, 17 Nov 2025 10:19:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] scripts/clean-includes: Make ignore-regexes one per
 line
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>
References: <20251104160943.751997-1-peter.maydell@linaro.org>
 <20251104160943.751997-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251104160943.751997-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

On 11/4/25 17:09, Peter Maydell wrote:
> Currently we have a single extended regular expression defining
> files that clean-includes should ignore. This is now very long
> and awkward to read and edit.
> 
> Switch to having a list of newline-separated EREs that we write
> to a file for grep's -f option, so we can express them more
> legibly in the shell script. We allow for comments in the
> regex list, which lets us document why we have put the
> exclusions in.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   scripts/clean-includes | 28 ++++++++++++++++++++++------
>   1 file changed, 22 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

