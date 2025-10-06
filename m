Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D83CCCA472
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 17:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5p86-0007cG-Kd; Mon, 06 Oct 2025 13:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5p84-0007aS-4N
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 13:36:08 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5p7x-0004tl-Be
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 13:36:07 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e3cdc1a6aso39207935e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 10:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759772157; x=1760376957; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ompXjkGtwyCsJlUF02KeFyMDHu7bcZYrK/9Du6Mnfrs=;
 b=aPurr/sT8LOCSv2cH2clAAkNkAPDvU2mVBxPtPXKg00PFOLx9kCWW7gH5jEgtBNY6Y
 8YBMia6gqCJlmxB8aY+uaB5EoPa8f4PIrPu9mZh1tqBTXtCFjiOMKXX03W9IZFJM3KAy
 GI/LlHwA90Zw0DIyign+b3ad/D88iyf1tiYZiLFAXybcJOiiBXZBuCHEoD23yrO3CCSv
 9cn5FeeXb/WOzYhs73DC1DwUbYRr2L1lH1YEFLmhLRd9/ylH0zGUx1+qWnKEokGluNKl
 lu9+Dqo1q3ZVUWQ01DK891SzFm+44Mlu3nxhGibfDnpzrAxWv2iWa9tzZlGsdqSvZYtU
 1aBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759772157; x=1760376957;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ompXjkGtwyCsJlUF02KeFyMDHu7bcZYrK/9Du6Mnfrs=;
 b=fpwj8kQqNIX4LJV0+fCPVLMHXP//FNhYzMiEveaT/d/bmV8w/DZPtvS9nouxPaDlMD
 83dEHsrI/T1VlYsvb+Yd1fD1/SgEsjwyS20NTmX4slh7rmHnAAzedW4ej3XZEcZyy/W0
 4/ozNQThzAU1sAKJxOlEsw5m2231hp4krhMN2YUWLDMoG/iM0BpapNJJk2UHGjbINjCO
 Lb0A69+XW4cznrl+EYblOqQtqJSi1sgf58FXMnHhgFXskVSw86O2Cw7QstqcVGQF6beA
 53x8XpYBg7K86VAfbEiXG8zJZUgpAquNeypusqrw0Xp9nxzV/RPmG3bRcwpOsHjwy2YT
 trwQ==
X-Gm-Message-State: AOJu0YztXA30mbtidw4ifiE2i8/3Ocd0+IAJRfTew4PiVuEYm3Wa6TnV
 pyLDqEPcM7T6d6Hn7+Lb3Z5bVGIm9KU2XMtm9OxZ4WmJnd58D6S+knKr8z6grnDD9WXgIDt+/Ll
 qLIJGCNaXjg==
X-Gm-Gg: ASbGnctzdfU66PJ3qJQLblRF8GJR53kAA6c6GcZvS4om6WqrMk1mtVcOOvWi02jq59K
 gGrGasY6GdJe6J6md5JSQOoJiNigfL9e8pUPULDxsiLZ7uTG0vUm9cVYXICVKtNEA8LsecMg+2G
 9JajJptaHuKOV9o/depetd3oVXGVsxw/mAPItHLiXy7o4aFqCnnV+anPuqgAXnvVqndmzKgMbHy
 nNgWGPgAREHA9f0+h7M+HuR/b6BzJdwaxWToX79445nNAxrv00cGiobsVJbTzG8GDJPIeTyr8Hk
 nflyrKwDnfp30S+tEZzYB+d++outGyj8oZD2vPuhs1UAxoTSmbjOQMdqvsHromlLcYrEtOH6POW
 gPuH8ww7Fj7+xS70eWbCOmWhDd3cnPeaPtDKY3K+4ZVKKZ54MGCoTwVZGFiUXYHcWIdB+AIYXaZ
 pWXhX/SwTHlKOxeoTDim/BYRtHdv/2
X-Google-Smtp-Source: AGHT+IE1mJ1danzthcgQvKVuflg5PhVhiPTTZqTJmph3LbDT01qzTbbrotxSQKod+Y28qXUDvN9jGA==
X-Received: by 2002:a05:600d:810a:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-46fa29b2a32mr3347175e9.11.1759772156988; 
 Mon, 06 Oct 2025 10:35:56 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e7234e58asm165188215e9.7.2025.10.06.10.35.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 10:35:56 -0700 (PDT)
Message-ID: <6c953c88-a31b-47d4-9384-ccd97444a7cd@linaro.org>
Date: Mon, 6 Oct 2025 19:35:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional/aarch64: Drop some sbsaref_alpine
 tests
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Radoslaw Biernacki <rad@semihalf.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20251006161850.181998-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251006161850.181998-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 6/10/25 18:18, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> test_sbsaref_alpine is one of the longest running test in our testsuite,
> because it does a full Linux boot a couple of times, for various different
> CPU configurations. That's quite a lot of testing each time, for a rather
> small additional test coverage. Thus let's drop some of the tests that don't
> provide much in addition to the other ones.
> 
> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2: Drop the tests instead of just not running them by default
> 
>   tests/functional/aarch64/test_sbsaref_alpine.py | 6 ------
>   1 file changed, 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


