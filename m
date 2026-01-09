Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B140D26D9F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 21:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veKId-0001Gh-GD; Fri, 09 Jan 2026 16:45:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veKIa-0001B4-2V
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:45:36 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veKIY-0006iO-9j
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:45:35 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-81f3d6990d6so508b3a.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 13:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767995132; x=1768599932; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C5bwS7Ydw4h1epvBUeP0sJwRWrgVkYWsxZi9jXfWaSs=;
 b=iOlC7DVS15+kBWrDLJVjP5QVBR5DKBZwjF1WaueLg91RQbidMHWaQKPa1yL82kZ/Yc
 qB8K8/pD/VYa0HpNeL2k9Ya/qnmugyl0sGyNDxBS2EAtejNMFIZrg3w8GdSKB5OQxkb+
 0MQiyYRd/ECYTlEHtYAC1plAzEu8vwG7FQHEn8M49xz6B7WkXP0YtxhvIhT8YOdsyRcT
 KaOmzwVG8O/v2hd98oTbIUTwkdbDQ+d3AQx2XSSh6W6YktzDceVz3sbhQ63EcFT9CEsE
 6i/dHZHCEFgO6MtDHaze3AT74upJwsUpmqT67/59+X7wEoGYkrWpgtLdB+wMPh9mvnke
 y9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767995132; x=1768599932;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C5bwS7Ydw4h1epvBUeP0sJwRWrgVkYWsxZi9jXfWaSs=;
 b=gBIPqWjpGZUrOOExhVoZWz5de4Zb2Q6FlGHm+BCJAJGdhjQcgJNwH/8lINwSLxOD6K
 dtgUjxVQkf+3Zhhby6d60CFJAVYRmKgxZwYTWVnhsgWGj96zc8MR1ULQpb1LcZrCo4so
 dDKgonl4jVSfUbuPIZuLcyoAnkUfWyt1TwAT2nBSdK+znZUbYDMU3BgETHhl3A+/EjWk
 8dHQqD+wlsF6cZkNr11Gpne9HDmqO7rbLjpzQS2Kis65F0a4HyksnOcwNRmT1dxjG0JN
 jabvd5KpxcjENqfy0qmAy47aR2wY+WZotaREw7DyG4CYYoWYsvmI/w169eIMcVVBCVY1
 Dn/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBIBZs7U8FZle6rKDmuOxnZ70X2K+nulU0kSzFLcEKyJGlrqlnf+dGswF65j57TWoIj2LUbQIJgg4n@nongnu.org
X-Gm-Message-State: AOJu0YzE82cmWwxaMD2aqKvP5Sd/ZcmjG/bn6WgwQHTT6tjmgcHxzQWk
 4R5dTUmkvb/uLFaaiJXGXrn4TYXpvCH9fiiK6F1j+CF6DDLjVcPk5BkyPAcUP0otV2s=
X-Gm-Gg: AY/fxX522UbH53qKp18A8cMaBGINHRFP+DchZYSdBOJq0nPml7pvQs/bZcqfNF9gnqw
 8T2lCgG++7wtJgW7alJtzWumfuX+tLQz8qsjwe1rscWXn0pA0eiG8PzWsmAEGav+HixYo6jaYfx
 9bjkDhNO1VDnD/J94pwpGZEFSv/+ZGXNqW+5WRBh57zbY2/kdDqUab17tVXoMqsmepxLMx9af7J
 nM6xwAoh5CtxgtLlY2EDwz22K2VhfuopXFjowdB1UKTjXwNkaPsjUopm3SWa0zPG+adUuIjSnSh
 SoCJ1nWxGvs5BLjYhUj4T7t4/PKdzwaw/GgzKjdD3bAe8WfTsRx5mqdo6ywZ+OHtsIMtZdCPSfD
 LkrLCov38IfHfP08cztFe4lPNw3zYNVvw/OSK/5QhuSH1YrFQnHZUyK8B8qovuGDoQVRdT3TwgN
 0d/0dfbDTy5PQQvRli37qzk2ahCA==
X-Google-Smtp-Source: AGHT+IEZHQKGE7flY73vIZE1r789n6s7tfM3ZKVX4Pe149syCy88QPNIgU6cALAI1I2BqpzR+G/68w==
X-Received: by 2002:a05:6a00:3490:b0:7e8:4398:b361 with SMTP id
 d2e1a72fcca58-81b7fcc9dc4mr9010164b3a.52.1767995132437; 
 Fri, 09 Jan 2026 13:45:32 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81e3eb854e3sm2721964b3a.5.2026.01.09.13.45.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 13:45:32 -0800 (PST)
Message-ID: <cb89578f-1ff7-4230-8b1c-ece8993bc1a2@linaro.org>
Date: Sat, 10 Jan 2026 08:45:25 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/29] target/arm/tcg/translate.h: replace target_ulong
 with uint64_t
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-11-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109053158.2800705-11-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 1/9/26 16:31, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/translate.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

