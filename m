Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E9BC56205
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws27K-00011R-Ut; Thu, 06 Aug 2026 13:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws27I-00010g-PI
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:42:52 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws27H-00038u-06
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:42:52 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2cc97653887so29934655ad.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 10:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786038169; x=1786642969; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qu5Dd5fdshxW051RRVWmVpvHBpKdzpJ6blH9N4sEoR0=;
 b=BKopC7l79ldBuunPIwq6N1XQ1myjeMuyKj7BpqiG5RXd2qrwYphluENSLuyp79auLD
 btHKSAr9R99jjHZ72B3XaXyxXYxBc87lN0k/yKJDLaZz/WaE5Gr/7YI2hzV1P4HrwMp/
 vj6AckaVZN04SuH91FsawSJ06Qm0+YjnwVJjswcvYuGcXtDtueUXfC17FlvYmlV7Arnx
 ZeORj2fMZuHmeE6gi2nz0AT0GYvKqg4RqjYHVf6sTJliQN0Ee8awxaqxqIVQ3RhQlE3u
 E5qsidbMz1euSgZXj4EdUODIcPLBWd1V3SILbKSso0zEb8MEKXaMauXoWf/EgkgTYmvd
 VaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786038169; x=1786642969;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qu5Dd5fdshxW051RRVWmVpvHBpKdzpJ6blH9N4sEoR0=;
 b=c7RmNyyOl+yRiZRds08XBXy+vDaKxTjw4xYqerzanes4+/SFRbsEEPN5qPAGG5vPvr
 0ks/Ieg8NYEqr1ln3GN6WXzy4oTJBZ2gi4HyA0hi6JRJGNuWCVhhUxBrUIcofYLbcc+9
 FphbhjZTHZ6ADA7Ou8MGRt6jAx5wwmX3BpuZkMWa2mjBW4GAQ7Pi55EEE4eBg9gwBZ49
 V6k29wwGW9NkffDbWynUMfzGdxDcOTF1wLLFdORRdWgh7dKczOix2WPYhaHe4e+zrx7n
 yPmLfQttU9E0+XfurhG7bD4plXG8nvmrywD7/WxkB2ztdvRVI8r+kWAji+N82+cw5DHT
 GHKw==
X-Forwarded-Encrypted: i=1;
 AHgh+RptNV7Y7QH9oMzn1CF3VuOwF7ias2tM1pim399G8p0IPQKgAM9XkihxiUEr2WbvvS7DMgHucEhqCmUk@nongnu.org
X-Gm-Message-State: AOJu0YzYIqGwxzMucHIdtPwKxliJiuzx4lIgzaDpNGfhzddWMmiFhw4g
 GwhZcD8aZpmimhnosQHiqDGrpEN0Iu76UwH6YxbQTWmrz/Kh1/aPUi+eThhtEIvo09g=
X-Gm-Gg: AR+sD11GWUxQw2J/S5Fop4ZiZgVBawKgBDyKjqhbqEpDNH+4ds9ghZqvnvXS9dsWzPp
 aWl3nh8kEmn9qALwcjziFWaAR/DH6ZzOS2b3XgYFchTjDyHDru2CJpF5OEoK7BcP2f909mthWnr
 AYac+/ztFdEBJXDJtEshFQ6hb+pyV4sgY5VgOqufKGyWKRzygO7UiqWVmtVbu9g9b4uqvYsoJsa
 u8gqKIXh3TpxosrjgOM3rtJgtMgQJc/VYYg+T1ane60+XY1nQqMBSSHfKLdRwr/2vBQZ9G9PZVU
 nHLOaLkbZw2jsfsCO0dGnMh7/8be5czN8R/W4ugcMw4i70PlHau944xFjCyyxznv7tPhlYsct3o
 ay6XsWUjpcpGzns5/Od+Z7F3g9YQ3VqNSRlR6+5VqYQ7T/gIszXeTYaHSfiEKd8VVrr5Szw1sGu
 RIT1RpBPW1Ameco5qGbWgBC/knOUZXBPUFTVHBtFoGIszwg5TxWK0az2n3M7ZEOkKxnVgbSd5jW
 tOOjrnz6+vGmmTf1E8BDvce4CFU
X-Received: by 2002:a17:902:e5c6:b0:2ca:17e2:2acc with SMTP id
 d9443c01a7336-2d0ca9444damr181164205ad.21.1786038169199; 
 Thu, 06 Aug 2026 10:42:49 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d120877ce5sm78785ad.35.2026.08.06.10.42.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 10:42:48 -0700 (PDT)
Message-ID: <6339f8e0-dda8-405f-bb79-dcd95a297da2@linaro.org>
Date: Thu, 6 Aug 2026 10:42:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/tcg/s390x: Test LOAD and STORE REVERSED
To: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
References: <20260731185628.23161-1-richard.henderson@linaro.org>
 <20260803123928.1875606-1-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260803123928.1875606-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 8/3/26 05:38, Ilya Leoshkevich wrote:
> Add a small test to prevent regressions.
> 
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
> 
> v1 -> v2: CC:qemu-devel@nongnu.org.
>            Check that upper bytes are not modified.
> 
>   tests/tcg/s390x/Makefile.target       |  1 +
>   tests/tcg/s390x/load-store-reversed.c | 46 +++++++++++++++++++++++++++
>   2 files changed, 47 insertions(+)
>   create mode 100644 tests/tcg/s390x/load-store-reversed.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

