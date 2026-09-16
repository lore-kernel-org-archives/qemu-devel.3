Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87103C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6nCa-0004UA-Ta; Wed, 16 Sep 2026 06:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6nBl-0003RP-UE
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:48:35 -0400
Received: from mail-oo2-x2b.google.com ([2607:f8b0:4864:31::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6nBk-0003Dg-B1
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:48:29 -0400
Received: by mail-oo2-x2b.google.com with SMTP id
 46e09a7af769-801a8bf8112so268735a34.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 03:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789555706; x=1790160506; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ArrLv87NoYG6bnZ9RdTF3i6KyMXrY3vJMfzzUbvf+mU=;
 b=OKWfkU79ouH85MbeJTmolniiUbcGAgrUevQNrc5S0mpECj6UaIJnCIlIhs0HdtL60d
 PxTXgNTM486J6p2LZ87+LmoePeeVXbOBYsM8cnjodP4FsjKC8B/tGexuDJAzxafh2f6s
 /MZcRJOOWwuEUUU59/BPFx25eShijMrI/j6iefJClHAlG1do3E3kXu3Vc1ZTpvtKJb+H
 vIGQjN34FxITkdU5YzwCj0QY7CTFndRECH0Zo3LU3+WyewQ2YokWrmlk3qVX9F5A6u5m
 vlXuATM6m6aolS/jUwNO+mqGU0quL2o294UO6yD7EpZiz3vhZuqbSQp3KgNQHRuHr2qT
 Z3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789555706; x=1790160506;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ArrLv87NoYG6bnZ9RdTF3i6KyMXrY3vJMfzzUbvf+mU=;
 b=hD75IBsa/Df6LfFmQTq3pakCP3OdJyuyKR8lN2ZqZO/BTC/tQtnP3QBJ+u9Bii5a1N
 wHTLQyfoTkxvFwJpkYwJALSk7OuHa9keGnMLsma4S2y0RUjBXVpy9g0GqY1ZqS74u7of
 l1dK8cgvMPTTyncn071BgJ8QZ5ArsQK4oFUea2t0rcFmZT9cYRan1ZHa1v0KCp16H+N/
 yv7pmsx/vjvGKmrqxD2/FaNdoZnY4v5JAgo+6GQ2Rt40y+o1XEpjJ1p94Viyr1jFyj3h
 JVkURWz2ufUPU81gGIoaAs0+tEPij1LyjX7POoVMdtkR6rWX1k9lC1rA63GcCaZHFHoa
 4BUw==
X-Gm-Message-State: AFuF++mKlq0QkSmtPQ78Eax1POtbO84eOJqLCTAk2eGgXYYGkxMa7sCW
 pYxboBzWI5Q4nCdEwaQ7Z64sHPuHUHUrKgrOMk+YoPDNZ3Y0+kQcy65IQd4NNGPMW4M=
X-Gm-Gg: AYBFou0hp681+6OoT4vSe7NOVzNnFn/PXKQFYZ9wAdyS6Qye1PP2pvhLgsv64fhHgve
 Fh54WS9zJIUfeX0+DwsDSaMwdmLNuDCEeaPQfxvkVox/uxdXxU47l0aJWJTnbO9063KrHMIfQsE
 FQ3qPqGHlI+stkStbmDpRby/g+cXeAN2dfTvI+lXUb2dfEbMpoBXGP1o5+nS6zy8wMaa8zBPFhr
 onvmLazlK3Du7vtHzBcArr0reBODYvt+bBpm+ZsYIuim9K+BcPefV/UOmpVYolB5J17ZgAX1ZJU
 rTLkU549WXQBedSqkxTvcGaKTwwYqVDIbMBPKgM97VU25/mgNyVFPc4738VimfBpVm6g16W+BI2
 jpEF/vZLBxh3rgWdISEFq2mEf5ql577XfmhersjTR+4SY1IJGnGBLLHd35Zz7o7B44KRm+aLzFz
 m5wqscslzoZPrZ9JPdYgBYCxKkdAahGmx7kjbi6+7YzKDamyXBbGF8radYpoAAAjQCkmt66Xl87
 qGWUcPxEWI0Hym9rWBBtdu8hplfcyadU9S4iOlndw/xCh+2ybf2RgQeafd1iw==
X-Received: by 2002:a05:6820:308a:b0:6b7:8396:f3c7 with SMTP id
 006d021491bc7-6c7d36fd309mr1989010eaf.41.1789555706601; 
 Wed, 16 Sep 2026 03:48:26 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:845c:f507:397b:9b72?
 ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5ad25bbsm6082737eec.19.2026.09.16.03.48.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 03:48:26 -0700 (PDT)
Message-ID: <cb3eecce-f10a-46f3-a6d5-687d170e9eac@linaro.org>
Date: Wed, 16 Sep 2026 00:48:23 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg: Fix building outside of the source tree
To: Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org
References: <20260915110855.491985-1-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260915110855.491985-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/15/26 01:08, Ilya Leoshkevich wrote:
> Running TCG tests from a build directory that is outside of the source
> tree fails with:
> 
>      [...]/qemu/tests/tcg/multiarch/libs/float_helpers.c:228:1: fatal error: opening dependency file tests/tcg/s390x-linux-user-float_convs.d: No such file or directory
> 
> This is because the build directory is not mounted into the container.
> Add this mount. Do not bother with preventing overlapping mounts, they
> are harmless.
> 
> Fixes: 27939ad414ca ("tests/tcg/meson.build: introduce cc_dockerfile and cc_docker_host_arch")
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   tests/tcg/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

