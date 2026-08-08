Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BAFC5AD2B
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 01:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsW6M-0003oB-M9; Fri, 07 Aug 2026 21:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wsW6L-0003o3-9p
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 21:43:53 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wsW6I-0008Rk-QF
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 21:43:52 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-84e3007a2b7so125169b3a.0
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 18:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786153428; x=1786758228; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=O4GIHFJ3Jzq4zAZSw1vIDcvJbZyv6aXJ6LIgb6JFwg8=;
 b=VkIIZgTqL2aDmEzI5yJ0TlAC1NvAHusqJdn/tXntg6HPTIvJGNAX2Ord4/atYUIRsC
 JWZTgktwdU8yeVvEj/Irll5/iZb4qj1762u5/ZALBAqSWRQXe4qYaxDDPMwcmdhzJqdE
 IUD4Rnyt17Aiw6Vc6yuZNlWQVfUpQDUlKi4MpH3hw4numiDIE3PWlF5zWWwABWCxNKvL
 FwsMfzt+Av18sj6yHfdd5ZG3gPHz0+TKh0BDEJrczbEYIaI3aShCpCm+3niy/f/UF3MZ
 CCGQqHzOuadApURvs0CC6jPvTHhKONk4K9Cr4eU1+USrAAV4CgYl6xjVNn8o6/6p7Eos
 HG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786153428; x=1786758228;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O4GIHFJ3Jzq4zAZSw1vIDcvJbZyv6aXJ6LIgb6JFwg8=;
 b=O2VQ9Pb83ZGnJU/5aH0luA8HX7bxeoyA8QSCkkm1CGSxy6UxEOT2b33r1SQmd6/WSE
 aA9ohtH+9zqb+/iEkOwBmRqmnYg8+3unEWNOFpglGCt06pKjTs1hUtmErefSSRti/8NB
 l0cTMPESIX9AsglxVq8ok1amDais/nESdcw0GkFQiWb2pYQM3SsGnk6aSaHzN+x+5gpf
 132jXkpbW5KyNpgDHkBCyTSEIEjEUclI9Vs/XOWRogLIuqMbyom5PA+eO004CD4O0jBg
 pF10l2DzBmrJh+ZTIazFDRsi9Y8Hmg5TbJphmhQS6f9RV2DRRG123piF4Q8kA8n84mbB
 WOeg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq0HRdeI4IljXhlTtmcPJ0V5zLkxB59RkRny6p4BoRgUptSBEgNtNUmuBwmEk1nKF0qBh4LaMHFNocA@nongnu.org
X-Gm-Message-State: AOJu0Yxsq90A7JJtYK9lu8np16vhB3jLCQl8Rn9Cbe4VrorfI3sO6yT5
 sAPIfP2xVXFkbbw35GNISdnKJYYnOhgRx45mn+jIZj3k9gfYsWySywEWpX66FRe929I=
X-Gm-Gg: AR+sD13bwHcdueFCIyz5lT5q1bsPHjgPejMv3aFeJ3ym3wlqXjW+6H527L+P4hhtKJt
 xwbcGeVLyexd56AQmklZXqFUSMQ+gN7Un3Kn6Nhe7VjSlvctHBd50pKjsm0ijVckgE0Do0jbwC2
 /pAYCtQ80IZkWQQV/VFPqJLseFOWLOqBIwN0CnTTZ4nZmlPhJuRx8OETcMQzIwQIBe1pc66j9Rn
 UQspE8Vww3UB1EuX2ypd9j7UjK3m46sJg0elQlzE8avgVdvxGwWEwoPUdkFNokZW7phO8rXexc5
 8RYpooZvo5yFTEhKUWoyKdvkXm8bgKpBvzFU5GpYNEUle5EwA60GoyvCUZ83I+D6pEki7mOaIZm
 sx9fnuBEqVIm7p5v4CpnDSHzJGa16r5ayuocgk6qC3hgPnnMbfGYjBGE2rVyROkgFaYHPwWXRik
 ec5Fx582uG8+VGyGIxF/Goip3M46HejueF+PMxP8duCqNzqlmVTkj2L+CiPnD+vHCFGU76PZ4S3
 lsXYuapPS0SaEUlMCe4/oUGHd4Y
X-Received: by 2002:a05:6a00:3696:b0:842:3a3b:d6e7 with SMTP id
 d2e1a72fcca58-84f696a193cmr4434393b3a.23.1786153428475; 
 Fri, 07 Aug 2026 18:43:48 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f5a51d88dsm1590777b3a.29.2026.08.07.18.43.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 18:43:47 -0700 (PDT)
Message-ID: <34ea6eb3-7e4e-4d50-b3ad-26c48ef3af34@linaro.org>
Date: Fri, 7 Aug 2026 18:43:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/i386: Clear OF, SF, and AF for fcomi/fucomi
To: Simon Scherer <scherer.simon89@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20260807062831.19618-1-scherer.simon89@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260807062831.19618-1-scherer.simon89@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 8/6/26 23:28, Simon Scherer wrote:
> helper_fcomi_ST0_FT0() and helper_fucomi_ST0_FT0() only cleared
> CC_Z, CC_P, and CC_C before merging in the comparison result,
> leaving CC_O, CC_S, and CC_A untouched from whatever they were
> set to beforehand.
> 
> The Intel SDM documents FCOMI/FCOMIP/FUCOMI/FUCOMIP as setting OF,
> SF, and AF to 0 unconditionally. The AMD manual doesn't mention them
> at all. However, testing on multiple real Intel and AMD systems confirms
> all three are unconditionally cleared regardless of the comparison
> result or their prior value.
> 
> Since fcomi_ccval[] only ever contains CC_C, CC_Z, 0, or CC_Z|CC_P|CC_C,
> and CC_O|CC_S|CC_Z|CC_A|CC_P|CC_C already covers every flag bit, CC_SRC
> can be assigned from fcomi_ccval[ret + 1] directly instead of ORing it
> into a masked cpu_cc_compute_all() result.
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/work_items/4133
> Signed-off-by: Simon Scherer<scherer.simon89@gmail.com>
> ---
> v2: Simplify per Richard Henderson's review: CC_O|CC_S|CC_A|CC_Z|CC_P|CC_C already covers
>      every flag, so drop the now-pointless cpu_cc_compute_all() call and assign
>      CC_SRC from fcomi_ccval[] directly.
> 
>   target/i386/tcg/fpu_helper.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

