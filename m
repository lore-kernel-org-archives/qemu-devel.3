Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB36DCD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 15:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOzpJ-00051L-9E; Mon, 18 May 2026 11:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOzpH-00050y-Jr
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:24:15 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOzpG-0008NB-7n
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:24:15 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2bd2051167eso10061065ad.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 08:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779117853; x=1779722653; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6Y6gIWJNXvqS+Hb6BqNS77GroByKlTVbeZunAyJ/+Ew=;
 b=FqtPxMIFFCijcxmqj99MUBCw4pdqPOzG7So4ioP8j6DU+uIOf0YIJiL09D3RoJVMo2
 TKSXUy2vDnNukWf77Nxdaq9crN1FH2dlGhNQV4URU63xNJZzlNDErOyaLIIKLaenJyAY
 t2jhtf+SVdr9h0AgYO+7PrqwSKzwQ4weSBtWoMMSXkbTNZsaKVv1QemHqnMzlJjp4469
 jBf0YRhvwtfkT3dH11EdbTMofHHUI6V09n4FlXxhOJNXdEnlFr7No8mmVxTFT6vMCR7n
 bxNx3vM6CBnyk4IsyTURYgT3wlJlCjahF6RIZBLAwh/753W0FnpghjoppBlCROH+fGMH
 3/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779117853; x=1779722653;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6Y6gIWJNXvqS+Hb6BqNS77GroByKlTVbeZunAyJ/+Ew=;
 b=TQ134i8K8eqkney0Muvwt2o+9jOhjRy9NMSUsEZjQEpXDDegzne+ATMZanxSMu9aaC
 Pbz6tJ5DoBH4927hJwYOhiY0bhj57xdD2InoIfeLlK2uanItDEzGgqDdtxj8qSvmpnP2
 jcspelrf+SJvecvpmVP2kv3MwCJLNUYQn0nFB2Xk1YsdW0L2X5DGH6oi4Rw+AQTDslHb
 BZ92ATkaCrwUKuix6inmHfIg7RBcBzO/BP1P6z8xLf4ugg1K/jQXZXTbhOHrP/XD9aqz
 85JIkcbWmJxiYi/GUukOsX8yxt54+oes9bg17Z9JwNb+IY8NNe7HREyCdLZSGliD7hQy
 aSIw==
X-Gm-Message-State: AOJu0Yz1jq16O/JnboEtGSOl4SyDYyqDeP3OMXWCeJ+Iz5rOfeEWLnwT
 5NDiWhw8R3ilFo/Msod7fWmxn5c1+fTr3yLWCYlsh8alW3ftI4njai8+hce+V0C5gqJcnAoqD9A
 jeJvqnmU=
X-Gm-Gg: Acq92OFdJTh2C+NFeVfAt2SME9pOOGz5lySW4k6BHBuVl1rxXnnbupi/dJVSw5SniCC
 4iv2nlvonlOt5xuZB79fko2ZRT95vL7AnjpDNuyYxuO6M9eZbsjTC5076bTW1tl2GaBeVStvPkm
 8pHLuiI6z1+I9KgFwOXMiYl+1wh44ChbABM+HJzSfhlhP3Qx43sEwQeRvrn+gqFfjH7yTN6r0TM
 stluLkddTOf9MskxEh76yq8xzhd7f5GtBYnPoisc04q3u3YRGk+J8DoMS+yS6H52tyj093FPOzV
 8Sbz74mbwplEe/2zdLVTc+o5GPWWUcf4dWoEsrLJpxKDIwmYwpzjx6wYn0JpIw7sVjWITz773vk
 s1WEzVA527vDy1j588Y2xhuyE/GxRgdPKQ+d2YUCiRgSrVXEcjHRvzMiN5ErNC018Gphn20PoBf
 QNOBuEWLb/tE5s974f2s9drgKQgLQpr6MEFswD
X-Received: by 2002:a17:902:c403:b0:2bd:8dbd:17e6 with SMTP id
 d9443c01a7336-2bd8dbd19c6mr149194425ad.35.1779117852531; 
 Mon, 18 May 2026 08:24:12 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5d11c7f3sm150009335ad.70.2026.05.18.08.24.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 08:24:12 -0700 (PDT)
Message-ID: <a5655943-8b2b-4dcc-80d7-4058e0496a8f@linaro.org>
Date: Mon, 18 May 2026 08:24:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/14] target/arm/ptw: Flip sense of get_phys_addr_v6
 return value
To: qemu-devel@nongnu.org
References: <20260515142541.571911-1-peter.maydell@linaro.org>
 <20260515142541.571911-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260515142541.571911-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 5/15/26 07:25, Peter Maydell wrote:
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/ptw.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

