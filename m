Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9DFC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 21:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhEAE-0003Qf-0v; Wed, 30 Jul 2025 17:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhE1J-0006H0-4k
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:07:30 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhE1G-0005oI-Aw
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:07:28 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-24009eeb2a7so2672065ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 14:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753909642; x=1754514442; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MR9fnJrcf5LYRap2O4RxYL9PFRGccXHyVg2jjgHuz7o=;
 b=WU2RxgYQxs+o8pgwYpatxbfaDY4IxqGW1Si+89t0si0NzMMUnWzUaZv+DvGSYyVWhc
 jBSMrsrSVCEmvP/Q2MS0hpXaDXuTXsfSjBILEpUJcmwuYRsV70Enn6Nyc1Hqdto226Xj
 ubBOrMShjCfXeY/epoDIKrE72FUH4XqP+9xt/l5DTBDoUqSIob3c0DvkG1K5GFDaObSf
 L14JJiBmFjk+wq+wURQ1AiW50G+ECe3VWg6GuFP2Bzy+J9b5pAvsX01mq+AyFvuZvDYT
 aaDhjFTgLHm5fITxh5RQrRdGrCHeNBAqp7xjidoB5s2ReN5oagmx8qLrJlpiL0e0wf4B
 OSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753909642; x=1754514442;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MR9fnJrcf5LYRap2O4RxYL9PFRGccXHyVg2jjgHuz7o=;
 b=ZaMgxliboXV1XFEX1C1T6rU5v+3mtXLTo8mhgLW3HxZmU921XnNKYFmN4jbeGtHB78
 5F28KBcAe1SBbTu33cJmyTh0QkalJ5p6mF3VKQ1VpeY52Z85J591NNFNCnFE/PzpcDL/
 tt6OLbpoIPuSQ2+J7OHuBEToAqdpKnXNbSrCLOGEFZxeePd6ZI3ZNI9OZWSB76Scxj0j
 +ct7+hUIWcxWirtK1in8MDIYdvczYY8oYKmh6GlBsg73egr8KXI8XC/PDfLS1BE5zjth
 g4gGg/+JJ1ygtbHjNHDSYdxgmaAeiBkU6Mwuff4hQKM+e5BcfEwBiTpvbDn4tFj0so+3
 cZmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQqBX1Mj67oKuY0TogiRb4IyPGoxsnMX9hnB4054HjYZflIsJJkTs7oqWE+PQbLqfGtNQ1seTok7bU@nongnu.org
X-Gm-Message-State: AOJu0Yxe0Fo701qOr+mrGV8Rvp0pL8JlH71goLyQBRawT3hOaRSCWkVx
 M+wm+nyna/VLW7+OSQQiFJ5u2GXY1IyAbf4igIEpWhR+a8bjOjiZvehpObPJB/F9t4g=
X-Gm-Gg: ASbGncuE8cYkgpjYebSGRtAlTALzJ6mXY++Kmx8IgM7fMVJyBEsgrQnLxTiiY6cJfuD
 90DmqbiCHFox8x7kAd/pqtsO6ha8jDW853gCFXAl17tSrerp/Q916ALd8QkpeEsVuW2ChBSfQOO
 6+10hroE0bJIDLZdQSzw7hXXFOtVwZ5lK+/PqXs7K5gi3v8+BVmS0hnlmSlQ5fFOEdnumlpZfMu
 USfcS4J+lDBLmV8+EGtl0s05ACaLdpFLMXN/+vUm9LOyisMPHpVb+hYLdjYrDfwKvnNo2B6ABxm
 a4+h8aTZVtQhHAATSSgQwIf5PFbz6+XCuqMguvYMqEfkyiu0vSGzvf8ZD6pnZY935RzFktVKExA
 BLbY8U2gNssfxJ95uPwDirAQDQu2RMorGS6k=
X-Google-Smtp-Source: AGHT+IGiaMOln2OaB1DjP4Rl+Ua4s2rBYpW4C7aEH0ItEXJFUhECYf8QD3qUZpq6qr9VORadPs8Qfg==
X-Received: by 2002:a17:902:ebc7:b0:240:8cdf:f933 with SMTP id
 d9443c01a7336-24096a9dd25mr68415675ad.22.1753909642117; 
 Wed, 30 Jul 2025 14:07:22 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899b783sm321505ad.133.2025.07.30.14.07.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 14:07:21 -0700 (PDT)
Message-ID: <b3be00a4-9a7b-403d-a1fe-b10764502888@linaro.org>
Date: Wed, 30 Jul 2025 14:07:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/82] target/arm: Split out mmuidx.h from cpu.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-30-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-30-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h    | 207 +-----------------------------------------
>   target/arm/mmuidx.h | 216 ++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 217 insertions(+), 206 deletions(-)
>   create mode 100644 target/arm/mmuidx.h

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


