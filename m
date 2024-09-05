Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3703BCD5BB8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 19:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smIOp-0007vp-NN; Thu, 05 Sep 2024 15:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1smIOn-0007vD-G5
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:44:09 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1smIOl-0003Rb-Oh
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:44:09 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-717911ef035so793252b3a.3
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 12:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725565446; x=1726170246; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bhzHgBk1Wbi+/58dCxkPcLmAavBQgrOz7hw5DtNm4jk=;
 b=mSQn4R+DNz9OsfrzUs4wkpjO1086rg5xXUdy4qUr1mgnSQzEqLtBQqbymIfnSdtlDA
 WMXfRc3ulQaAp7jLtwVPbBrkAMNsDocIMPGj6BJRsu3Tlyj19KKML0wg2hLDdqSeMVcz
 zZL5liq0TBxIwjOPOc+8BURRpR2+8+KC4A+QDx7FjDGU0gNTEv0N9ixNU5t3HIA6RNp5
 LmZdjU7IKGwqVj+jTWCwfjSFxAMCv+zNNoEK6eO62QLnyjaYTJHbEmO9oCJHUvNy8K/W
 uF8Rla5Ft17MRTjbybybgC7dySC8uaW28j4z5bDtvOJOjgBiZxsvsZq0pT/+pzwFcBQN
 LWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725565446; x=1726170246;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bhzHgBk1Wbi+/58dCxkPcLmAavBQgrOz7hw5DtNm4jk=;
 b=B/jbqybgNESsLY7sJBtyX0nblSEz0uQ9eDeFQ53TdYKvOg2IAfubXO8aqXow9/P26y
 zhERms9GVlmgLp7L4IlP2oNQQXkarX6CIj5Jszjh+covbDlD2LmUxuCn6X6RpKjT60zT
 hLW2IljJRW+TU4k4OU8V5bdoyCnQ97ZdeI49z2wlnGVsLWXRN/Smf1fz2NSkpfitIGKE
 d7XhOHNCxrH7BSI7M1/w8hW8I+4omL3bmdgDGGmlEvi5GDFRqtf5GmV/7ouF60aPn02d
 NDIABbyr1QJ2ogqqx0dDt7Ss2jEiUrOLl2NYI52C8BvSch41RFC7cMFZwpXvxt1jBwdL
 FDww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmWIW477AGcgu/kxTq5DbGYeCfsDrBylZw6uMeJaNGH8tBnHgSVbDf6VvN3rlit+d+dK9I2DD/85Pn@nongnu.org
X-Gm-Message-State: AOJu0Yx2cREiEGZttyQzYdX9k2P76LM6EGd2et5xUApCpeEkb7aL0nK3
 yGAQRMdMcO+DtNb0icZKjixLb6jNH8DZBidfdapmfC4Rbdyze1g/JM/t1YABEqg=
X-Google-Smtp-Source: AGHT+IGviJ4rLliIR/JDrpB1RmD0CPcSd9mW/3sjSp4wGfBy9vQMHrIBeP10rTlomjnY8DTiOnfbeQ==
X-Received: by 2002:a05:6a20:e18a:b0:1cf:12a9:a7b6 with SMTP id
 adf61e73a8af0-1cf1d1ec1e9mr34992637.40.1725565445851; 
 Thu, 05 Sep 2024 12:44:05 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7d4fbdad7besm3751106a12.76.2024.09.05.12.44.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2024 12:44:05 -0700 (PDT)
Message-ID: <aca89438-a7c0-4cd9-9668-2917a04ec779@linaro.org>
Date: Thu, 5 Sep 2024 12:44:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] util/util/cpuinfo-riscv.c: fix riscv64 build on
 musl libc
To: =?UTF-8?Q?Milan_P=2E_Stani=C4=87?= <mps@arvanta.net>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20240905150702.2484-1-mps@arvanta.net>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240905150702.2484-1-mps@arvanta.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 9/5/24 08:06, Milan P. Stanić wrote:
> build fails on musl libc (alpine linux) with this error:
> 
> ../util/cpuinfo-riscv.c: In function 'cpuinfo_init':
> ../util/cpuinfo-riscv.c:63:21: error: '__NR_riscv_hwprobe' undeclared (first use in this function); did you mean 'riscv_hwprobe'?
>     63 |         if (syscall(__NR_riscv_hwprobe, &pair, 1, 0, NULL, 0) == 0
>        |                     ^~~~~~~~~~~~~~~~~~
>        |                     riscv_hwprobe
> ../util/cpuinfo-riscv.c:63:21: note: each undeclared identifier is reported only once for each function it appears in
> ninja: subcommand failed
> 
> add '#include "asm/unistd.h"' to util/cpuinfo-riscv.c fixes build
> 
> Signed-off-by: Milan P. Stanić <mps@arvanta.net>
> ---
>   util/cpuinfo-riscv.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/util/cpuinfo-riscv.c b/util/cpuinfo-riscv.c
> index 497ce12680..8cacc67645 100644
> --- a/util/cpuinfo-riscv.c
> +++ b/util/cpuinfo-riscv.c
> @@ -9,6 +9,7 @@
>   #ifdef CONFIG_ASM_HWPROBE_H
>   #include <asm/hwprobe.h>
>   #include <sys/syscall.h>
> +#include <asm/unistd.h>

I suppose this is ok, but...

For some reason musl processes asm/unistd.h at build-time to produce <bits/syscall.h>, 
which is included by <sys/syscall.h>.  This will be "fixed" the next time musl is rebuilt 
against current kernel headers.


r~

