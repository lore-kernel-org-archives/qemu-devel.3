Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8541DC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 06:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq4yP-0007vB-Dl; Thu, 06 Mar 2025 01:44:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tq4yO-0007uB-3i
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:44:48 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tq4yL-0006SE-6K
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:44:46 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-390fb1b987fso308660f8f.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 22:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741243483; x=1741848283; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UMoWzdJKPmx3GK+kmpHJkUBkTaJGlw70lnDXziwQI9Q=;
 b=YwFrBBpSgN0XvOG56I7SkzRSgF/7sv7Txce8gKa/l417laWf2vdd4eox1zD1vDbUg/
 foOU7GlSJzYjJ54jShUhZ0ZVX48rbLmaCAmsQwVYrf2ElT0IbISeVYgIIYE4cL/fmVVm
 2uqDt757jSHbYqR8xgQCtkR1dHHh+vw+GpUb2+U/Y960sWgZSN0B+vQllrrLj/SJya5y
 KzGxUOygKXqlUx85ahAhLDRDCPqQlfkP0PHExSfH9+msp4g/EFKVMQj0K472HB4JbAQG
 HKh8kdaqh4PNiJpK70RD2/GZAP2/hPttMw8y0VC7nPZ7c0hNgGmCgNmgfLqiuLmO2YvK
 jGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741243483; x=1741848283;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UMoWzdJKPmx3GK+kmpHJkUBkTaJGlw70lnDXziwQI9Q=;
 b=b/bYFOFjKcInGzlpNUViQuxaTUKqXpjdam9oc22CY1t46dPSM6oyZy508IEsQVcwsv
 lo9O/kob0ZCZZF1PyqFofs/rzYn2e+gZadUUVWS6AJggbqzre6f40juW0PQ1/5tmC2Yd
 pnoAlCrl5eJf0fprmx1y5fgiiKakT6XozDiCeciR60yLovlFxJ7t9YKDlO+SUHOeHgun
 PAZxv2+TeRphQSGPKEwI/jakje7WapBpwF3GKvijgErrw8zq80wo7Gthr9sot9jDO9+K
 AcEdBrJRuDCbHuYRMRQWJR6TsuuqAVffqMIbm3D+9yuTiIrYwBvAqiJvT9jzEjn+DCUI
 Uwsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGoJmigx/RlRgO5CBwo3+rF4HB+SQBYHqXwhM538I7yeOVAm2AAjbF6CdARa/VObHAQrbxXQw6OqCm@nongnu.org
X-Gm-Message-State: AOJu0Yykob+9icx9mSPN2+HvkDJXPnlQwB0oPZjgjSPqq6QbEybRNLsF
 k1ABfd58QJ8tzgG43q1nFBxVpzMTVA/KWbA70yxt9u4G1iDhJwbbTXJIGQr9O5c=
X-Gm-Gg: ASbGncuNmifv7FsmxneSiG3zmsmLKWW8zbU5PY2Pqsx5g3YCxFyyCOhAG4Bs3CN1d3o
 xEZ9K8jN5cSWRTjivbsLN3KSTACCqjSoI1ZjgmBJdiQ/rZuHtiArZlxt2qws4/u4KeMT0tv+iNY
 tT77DmRvaLe+mHNstQ1Zr2cs3MAdXZgLLLFH0b7nYb8drt5Zx4EWE+6DMNzOEbbmZ8u3iVvivUy
 kdj84LbU9xVAoRowYB/R5NObQOixImoiMvsIIjpFlvlASUWMhZ0NDlU9qqpgMaEWQA++lQzQSJ+
 TKW+nZ1a0wARB2tphN96qrbkqGoHK09DctYO3hiz/QDwQZtlhTZKsUkVJlU9QPrXNEEpDuwRmov
 FEe5XoQZpj8KJ
X-Google-Smtp-Source: AGHT+IG51/TVu0yGDusBChVu1K5myslQQqOEAyRUHbnXnnHjWYVVzzKs2dRLuEMQDHqMG5gDwg+7Zw==
X-Received: by 2002:a5d:598d:0:b0:390:d990:823 with SMTP id
 ffacd0b85a97d-3911f740b29mr5064279f8f.13.1741243483163; 
 Wed, 05 Mar 2025 22:44:43 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c103808sm968518f8f.97.2025.03.05.22.44.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 22:44:42 -0800 (PST)
Message-ID: <4a96e43a-a4f3-4b24-8ffe-63b5da01f82b@linaro.org>
Date: Thu, 6 Mar 2025 07:44:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: add missing 'Asset' type in function test doc
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20250306060706.1982992-1-adityag@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250306060706.1982992-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 6/3/25 07:07, Aditya Gupta wrote:
> Seems 'Asset' got missed in the documentation by mistake.
> 
> Also fix the one spellcheck issue pointed by spellcheck
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   docs/devel/testing/functional.rst | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
> index ecc738922b7c..50fca2a0291e 100644
> --- a/docs/devel/testing/functional.rst
> +++ b/docs/devel/testing/functional.rst
> @@ -251,7 +251,7 @@ Many functional tests download assets (e.g. Linux kernels, initrds,
>   firmware images, etc.) from the internet to be able to run tests with
>   them. This imposes additional challenges to the test framework.
>   
> -First there is the the problem that some people might not have an
> +First there is the problem that some people might not have an
>   unconstrained internet connection, so such tests should not be run by
>   default when running ``make check``. To accomplish this situation,
>   the tests that download files should only be added to the "thorough"
> @@ -274,7 +274,9 @@ the tests are run. This pre-caching is done with the qemu_test.Asset
>   class. To use it in your test, declare an asset in your test class with
>   its URL and SHA256 checksum like this::
>   
> -    ASSET_somename = (
> +    from qemu_test import Asset
> +
> +    ASSET_somename = Asset(
>           ('https://www.qemu.org/assets/images/qemu_head_200.png'),
>           '34b74cad46ea28a2966c1d04e102510daf1fd73e6582b6b74523940d5da029dd')
>   

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


