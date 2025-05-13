Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C20C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 10:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEn75-0005Rz-Qu; Tue, 13 May 2025 06:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEn73-0005KJ-Pb
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:43:53 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEn71-0002nP-Rw
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:43:53 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a1b8e8b2b2so2838920f8f.2
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 03:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747133029; x=1747737829; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mJvVulSRNfflEB8cQn+WQSd8w0kajqIwEFRa+psHWy8=;
 b=gVkjqj7nsxqCsW3W5meTN9djfPvO6kOyaHvX5LAfCgzPbYpSrH9dwTZqj4P1DYNUVU
 qnMfB2wiOHQzTJZMwyr2+I3MV6WD3o2yJXuhynYEvyDXXolKMiOw1PVCo86ngLpTCa6B
 wfHkpjB3ff1aPeB+/wP3vY6mkEQgTdvPzl0ZWPc9oa3j1nDD3CcpB/INcqKn5axOssz0
 X0ww13tMFx/orOmv1aAxylVA4FqBxPK7v8Q8OREwQBT2erDu0bkvs6YuLBvu2q6rKbsK
 GVXLASz9LutotV4B84PuzaRU4CaJ6gYMtGX9or0fI5B3QIDD9kNCCVHyBxmjdbTpiKB4
 y4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747133029; x=1747737829;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mJvVulSRNfflEB8cQn+WQSd8w0kajqIwEFRa+psHWy8=;
 b=rzRWthStXlhdNwGLPOQXjnlIQc8LkQlKzXL6YSUCXRfd6AHj4ATX7WYB99Vmllh3ME
 M1DmJTKROzdYq2TE75Jv+rbuR+QoQ+OuGExTpGpo5dWODbPYrU2odRj8ff/Iz6/WB0kr
 YJKFKOmqpoaCHALo+pl48OqHVLadQhEQvHtcdXP125yGZQz2ooZ1OvubsfZ7S0T+J7PG
 9y4HOsp++CLeA+Kv/awCBZmHUrZRUAhoHPSAc1mbwgZ22QwlTspZd3IsgNd9bhD+k+MY
 T/evt8Sa2Q9zviXuk+LGj+Me3tDw7u6XeDlceJrwhsfmdssyI87riawJSs2dRQhKam/K
 Bc+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjGZliSj3YmdiYbZPSEwnUNO9iY2RCA/lGQ+0rsQg1Zk/OatmjjpxkhoM/hrdM6uNCld1MMVMBC+ya@nongnu.org
X-Gm-Message-State: AOJu0YxWTeWi7qJ2eyLahP6q0XEJFxSz6OpzkT8y6sz836gsEPUf3nAv
 KrDIoMylRK6vx5PKnaRbrCathRkX/AYvJadzwpRQhsI7zp99d1npKFEiWzTnwXg=
X-Gm-Gg: ASbGncvLI4FCEXCO9CGnNJJNBJub1K6UFcksrpIe6PSpaQJMXelgMuHdF0vTJMQIPRF
 vJb1l2GXzIMLU6oB1MJWKeTZME2tn1+RXL/tMAxejrcg03aKVhlUPyaLamrnjz8Lnp5C6CjRX9t
 0zxGa1suFmms9cSsq0J4sPU0aQKde+WsPXR8Zkp2jNMV9o2ZuWtFQfdshk8ZZ76hA+9nakVUKAM
 BBhqpB0Te6mcRZ0TAyPOxZTdgUuTvLTHeylzkat9DZ1wArkD1r9wy3rhzo7uUhp6675ekRDFDWs
 oqcQWlsKnj/vzZnBTTpEWAuUMwangrTqZaEx6S6/NTq7k11hVdsj+8wWG4hXeassICOKohormav
 nBAQoH9ks1xLPFBYDTA==
X-Google-Smtp-Source: AGHT+IE7SsWW23d4HuC9Pllcgg0YtTVNoY6INYytzgrD/bzPNjDtRytLc0ANVeFDV9A+rxypcRpFkQ==
X-Received: by 2002:a05:6000:250d:b0:3a3:447c:c341 with SMTP id
 ffacd0b85a97d-3a3447cc490mr1847209f8f.27.1747133029496; 
 Tue, 13 May 2025 03:43:49 -0700 (PDT)
Received: from [10.61.1.197] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57ee95asm15868601f8f.11.2025.05.13.03.43.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 03:43:49 -0700 (PDT)
Message-ID: <b050aa86-b6b1-4cb4-baa7-44cab9412ef9@linaro.org>
Date: Tue, 13 May 2025 11:43:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 34/48] target/arm/machine: reduce migration include to
 avoid target specific definitions
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
 <20250512180502.2395029-35-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250512180502.2395029-35-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 12/5/25 20:04, Pierrick Bouvier wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/machine.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index 978249fb71b..f7956898fa1 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -6,7 +6,8 @@
>   #include "kvm_arm.h"
>   #include "internals.h"
>   #include "cpu-features.h"
> -#include "migration/cpu.h"
> +#include "migration/qemu-file-types.h"
> +#include "migration/vmstate.h"

Ah indeed I did the same for microblaze.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


