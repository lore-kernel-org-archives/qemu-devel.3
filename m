Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6352FCCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 08:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAlZb-0002qJ-Vi; Mon, 20 Oct 2025 04:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAlZZ-0002pm-UP
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:48:57 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAlZX-0002H8-FC
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:48:57 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-471131d6121so32622975e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 01:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760950131; x=1761554931; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WdDtpILsUv4cP71oucHl1R2iOruPWbIhFXmnGcRbwf4=;
 b=RCe01YRo4Cf4erdBAYPdJRGvLGtUb+1tIuahMMZ/j5/jZy2U0HQ8YWJkzy0I6S5+0S
 RQUCyrF/MKvrkM2EE4UQKbg8Er7hGlxm4RwFNIb03n6uEIxlmgILqDpDpVjf4xU6a0fO
 fi+yjE0NBEOSHSlV/Gv5uKJgKEzyryAk+kJgejTPajdYfIXaAZK6xqJqdaLpULP2lSzr
 wPsMKzDhIk7czfdNGnG8PkMVyi39z49SB6fuDmoo8n9x0pnMv8roIa7sUuEYUinH1Tp7
 Jo1SFeq/sd+SkzBFP5jt7d7bJGYxlseqdncJkAlOn3u0YFWknjs95O+ZHio4x+o8HLGP
 JuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760950131; x=1761554931;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WdDtpILsUv4cP71oucHl1R2iOruPWbIhFXmnGcRbwf4=;
 b=L3YBe05EowsYD+T/mfZ4S46lwxOHslb0rx0iFn3PxD/VzACwwBU+Is2nwx/Yp3ZsTK
 +f10FnUHgEXfHL1pt+sWS9zaHTZ/Q8GWJUJpVz4fFI9TaSEYgtUEmmDOQ6fnVfWriOLV
 yi5mDUbLv0YUsU8ICkfjRYXhc3af72FusaC03VUULnSNXosDF2sZLLQqUoWpqHdHPz6D
 oC96PJxu29/7y7KBcFdSH23G96vcKbWBK0Iqfboyy9ZNfLaBk9EosrU+iavBVOVGYDVF
 aL1XGCnKlPyKYMux7/m8VD6vWvd65vPHA+hY60wsf6bG4geQ+9fPrKfcsOy+zSg8icF4
 BRQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL/pPxc7ZPwAoQHiQvNp1MpqUqwV8bw2HLLTr29Yzuu/eddvCwp/L5p3RoXe5yigDc5VSwx0JoX5qY@nongnu.org
X-Gm-Message-State: AOJu0Yw+rbg6mtTmKqCABhcQx4GUKeM8yuzanZ2hfB3+ZoHYbDcZqwZP
 39uIwqUbEWkS5E2DShraFNKyMXL8fwVN4Hsc1bC302dD70QmPrOuE802FTyLWsEtqvw=
X-Gm-Gg: ASbGncsEFj8XWfCvB6DA0ICKw05VPzShnqDRAwYZfDliK3llyVjxqNLSvb7uLk2di7b
 7AEB09nR8r6/LVkQTUNY6JiDH3KTXQAqvesI5VZaX3UsUtgPayL8/ZEgtZcne4fOWXbVuisl1CO
 1V2Y98T7TJgG6ZommAXllkJ31onzgvuziQ1nYEfyBHwnU2yhuY9iy4/c2Eu2Fl7vxD2/Oz91O+S
 VVK+uZ3uLUpntbYbKZABOft+tXqHRPr3M1jv1X4SvfJbK9iSFNJSYdBy7Ob7aDVRBWsF+5w9vVs
 d6XEhQZLAjZHvJy6R3Eo9oZpQmLUxSEJMdp8kk0ZvViozUy/NP00ZdBYJsVzUNWrUut4qu7wlG/
 lRf/kIqnMlgZG8BejU9Woe52g6hvS5xSXXbgfp3KURELLnfpH/4900pIE4FFm2nrVxPBOhJgAUA
 w0HweWjrOfsH12vE2tGFVmKNnfEG4b7hvhZLQb+BWzdhJa1Eo8aGtjaQ==
X-Google-Smtp-Source: AGHT+IH2orjIOjO6J7P+HIMsKsbZuxWltIbKh0EGtRQSE5sR9toAS84EmM0ErV8r+lOd/Joxr651Mw==
X-Received: by 2002:a05:600c:37c7:b0:471:12ef:84be with SMTP id
 5b1f17b1804b1-47117900c2dmr88123715e9.22.1760950131227; 
 Mon, 20 Oct 2025 01:48:51 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144d17cdsm217241155e9.18.2025.10.20.01.48.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 01:48:50 -0700 (PDT)
Message-ID: <403949c7-4745-4020-879b-f965e652a6f8@linaro.org>
Date: Mon, 20 Oct 2025 10:48:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/13] hw/ppc/pegasos2: Remove fdt pointer from machine
 state
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster
 <armbru@redhat.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1760798392.git.balaton@eik.bme.hu>
 <1c95348927decbe66456a0be2ff5a63073cda90e.1760798392.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1c95348927decbe66456a0be2ff5a63073cda90e.1760798392.git.balaton@eik.bme.hu>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 18/10/25 17:11, BALATON Zoltan wrote:
> The machine class has a field for storing the fdt so we don't need our
> own and can use that instead.

OK as of today, but I expect MachineState::fdt to be reworked (if not
removed) as it doesn't scale with heterogeneous machines.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/pegasos2.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)


