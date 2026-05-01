Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF07CD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkg9-0006G3-PY; Fri, 01 May 2026 06:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIkg8-000682-2S
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:01:00 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIkg6-0002Gh-Gi
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:00:59 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-82faf871346so1135880b3a.0
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777629657; x=1778234457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JXaVS1/goLgTCrLAsNTlWLMlo4tfxFnPwJXiw4w1tyI=;
 b=TQeHJToEurxTOy5J8udEpTzAzSyd7oKSSV9i8nsGHT5roLwhS3J1R+zTHGYVumdz3n
 AqBnfip9LgCoXgnGr3W54+bz64UdKgVf6V3qmQ1f7ypW1WbWN1YevvTpR/bsFYrrc3W8
 P3sTQ+RExLxzCAdFC9SA8E8ObXrBAztHMUyDQVYzuTSH5Jolj6RXOk2QqtxVT7ce2O4u
 jqYNhtTkTYCvESMhaD5YUz5XdO2BTTmHXkoCQs9jnbgZGRGyMzdtR4s4hAv1hYt6qKHg
 qzVDsFcWRiH8V2r92xBlINO1IAauH0fZS6TW3tTymgBeGUcDZpBGOaN3CvSP0GRt3WEz
 wKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777629657; x=1778234457;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JXaVS1/goLgTCrLAsNTlWLMlo4tfxFnPwJXiw4w1tyI=;
 b=g0p3uOhrdgh1pn/4pDgp3VMtnpcTCCXLwcvRH2lXKzJJPdvm/fNUMIDMAW1zD6DcqN
 AkPVVvcG78RjZC70O9YfdfLTGKFycX5zDY8bdrgyMEeDk72YS+MWIqQW1fDze3lVhhay
 Z3dTexd3aLuJtBQTVAJ0K4qkYzoTiiGsWwH83Dp8VyfqSq884N2o24p8oBDvb54QsFpj
 9p8Loe3qO5d9aTpc9RAcH3CL4EIwmPRoP2JGivIEEticGzRAdhD+0uTrwKejyS1ijD+n
 0p/o4kLMlh+YPLHbbykpXusNIp/AZPLR1mYjmwdHxlnULNIrFnauIokxVcxNjLMIN2Mk
 BHeQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/R9cC48erbPRo8I/2HighcmKO2y22lBHDHKMuDdywO5JbF2BXmzehnZAZglZy0B/ACetU6H2RakMp+@nongnu.org
X-Gm-Message-State: AOJu0YxGyxKlLaBzaA7bG8K7SycOeWHScmSqkxWplbLAxpKqncNXEXBJ
 rlxe4Ykrc2ZxnhSSmM2gq/IZriXvb3FasVZ2wvxYRAGY40qzjpcVUtW4ciewC/v48Sr/IQ+oKnO
 yUGY4ctg=
X-Gm-Gg: AeBDieuYU22C4PAjOLKlKUKqXDbanESvzGzNDIG9ipbZFCXrlPZ6XY6dk0Lr0GncDpW
 amW3PUN59pwxKYmzm7p4JGxVZRpOB3w+dseBh+n1C2gGtn0oED90qXgkYdtEQXJxMh38hJFPxMQ
 l0iAjAyjy1zTjh3GRAmlx2NJgje5YgjCvVEt/JB5RK31BJi1Ig2IasHlWi/BzIpD9XsOOolb7np
 1IsFxMfgHzkI0osbnbEWgsaqfnTH8UKSa6SnQieTcBosXVVCPFP4W6j3KQNFEJQ1oiK/IoFOzfK
 XAwy5CaqCl1eNIRFyfZSXqnMLUtgN8wuZfYUGNWDudZthtiRReJCyXcqxpXLQJ8LkLyV5QyRX5U
 M+QJrj+O85CQ4x8Qe0jxS8AFMUX9NcO6TzTJLh0KBMTc98R/qVQk+5hgPckwww9sG3hfYvrgAPu
 06T+6m64t3wQpHct+X3JtkS014395S9yznb9KRw6CIoEbmdK27xLg/
X-Received: by 2002:a05:6a00:1812:b0:82c:e83d:a9b0 with SMTP id
 d2e1a72fcca58-834fdb63cc0mr7766524b3a.21.1777629656724; 
 Fri, 01 May 2026 03:00:56 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8351588f05dsm1951726b3a.16.2026.05.01.03.00.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2026 03:00:56 -0700 (PDT)
Message-ID: <e287e5f9-56aa-4b1d-8706-9de0a5c9f3be@linaro.org>
Date: Fri, 1 May 2026 20:00:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/25] hw/xtensa: Use cpu_translate_for_debug()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
 <20260430093810.2762539-22-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260430093810.2762539-22-peter.maydell@linaro.org>
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

On 4/30/26 19:38, Peter Maydell wrote:
> We want to remove the cpu_get_phys_addr_debug() function; update the
> xtensa boards to use cpu_translate_for_debug() instead.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/xtensa/sim.c    | 6 +++++-
>   hw/xtensa/xtfpga.c | 6 +++++-
>   2 files changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

