Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B7ACCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 18:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBdvC-00059Y-9r; Wed, 22 Oct 2025 14:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBdux-000541-Pc
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 14:50:41 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBduw-0004jr-A7
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 14:50:39 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c3e996f8faso290837a34.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 11:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761159034; x=1761763834; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ce8jhHMFOqbp+B8eK2xEVgO5NB/QajDBzCKha1kcoSU=;
 b=ccW0k53esvx4N5zcMoILFUr7KcJmH1wagUUOWgHnlKlDMe1l7XwIDJ8D4io6d+fc4U
 y4PPY6W1Gcs9TgI3LFGI3jX9HbDXd4hcAPJXthrAd1ix3rHrJejjUMs8ahMBZJiClwI+
 sXq3R6ygfC+B1bGvNrGL8wAMdbf2qgJc7Q4aGsh8LD7Rb2yPBF21mNzK4NhbPLtCG+tn
 F4k5TTQChjJskdKwYFYuyPDFiQcAYVUDa8v8Kwwtr2dwv8XMM27jZljBSu8A7pyCR/ua
 rjDQyao3OUZlaT3I4MgZ5mKHkR0x6jBCGFatAWafx6oltECddM7Vx7XTPFxTGywZM7d9
 XOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761159034; x=1761763834;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ce8jhHMFOqbp+B8eK2xEVgO5NB/QajDBzCKha1kcoSU=;
 b=U09BMLXKI1xWW1mRkQPPk2nc1YkqOcwKXGMtA5B169HdvyerMET4dcC7ovTmoW8RO3
 Nouagj1NPjfJD0z7mt6VaYEpxDyziRAmMl6KKR0Qqco39dunczEqk3uo4jGm9lmY4Saj
 QLjSzT52jCvQnylodINYQsq7698hf//m2Tr8dQ5jomKc6NzfMQM1arBoY2aD5PRVnFx4
 R3n69KD0qXxW86Yr0/BPBpmhxBgMrluZBc9TsnqJOm101FX0qmtjDqQ4X891C4C1wakK
 RvPNbLZiEPjjSUetNMyM2YAI9CgcueGCHJFdZat8tFN9q+xOl1tYgsd6T93se9J3pPHA
 3oFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5lPP+xm+kVhTgpXcyhE54zCeftzH4SeNPvPdwlr0im5IjEcQ/dT2REJ0r4OKXZJwqn699qjFAod67@nongnu.org
X-Gm-Message-State: AOJu0YwWkkW9HbrQrv7hTqxXecwyrEiqU/A5oCPLoxri/JCZqwje8HHf
 uz/2fEanUCSrvkXoRppYBzHmf/g6A+FEJgvYkH7BKG4fKDxanY0MoKWFKi7j9taQbmw=
X-Gm-Gg: ASbGnctqpiv8Z9dOxtzxZRKvqnhK3wd5lbdJC0uOb4P2EE02tBu5BPew3YxF0M8Oo95
 w7bxMgvmHRyVwCrQFCRkxBPivBiKsuumBRTOBgyYf45aowXcqh5tubjJPgjvYBSofMM1XQiZbQs
 skArY8JtxeGRBgWQl2hrUtyq+gpJvb8Z8+rmvC2UCA9OklV85dDFy74Hxg4rI1rqlfPRr9mxa7D
 7G4DCe4OFEanrlnlpEWVp/47fxPtJdX+VRefdkx3Hwq7hzp6VKRLGJDIbDO6UluO1T1EXxLbm97
 SuZ5xKbXFkKg1fyJ65yJQqxjEk8phfbB1xSjzh+qch8Q7zA9rr/FfclPDH3FqE3jo3zGfAYA+qv
 6nZtXZ0tOTCa6UPqAPuxgEdXIHQUZwArgoNeiT0kq35KVlmiO1ESM4WVN6nmmBBCIgJlWSwK9uu
 NX44sAj3OGLFwJ0I/CrDWZEmowHefRlq4qvoxlZGmH+jCIwwGooP2ADMkudFMR
X-Google-Smtp-Source: AGHT+IG3OlmXJ85zgre5gLYEJAsapl+sFfp9LtMcr7Umqxc8xwhnO0ZRsOfRudiGVb5sFfSWhQblSA==
X-Received: by 2002:a05:6830:6486:b0:7c2:901e:e40f with SMTP id
 46e09a7af769-7c3e53d87bemr1186164a34.18.1761159034501; 
 Wed, 22 Oct 2025 11:50:34 -0700 (PDT)
Received: from ?IPV6:2607:fb90:5ec2:421a:7b72:4f29:1f36:27f3?
 ([2607:fb90:5ec2:421a:7b72:4f29:1f36:27f3])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c28879e8e2sm4878827a34.3.2025.10.22.11.50.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 11:50:33 -0700 (PDT)
Message-ID: <eeae7a65-1190-494b-8795-cca064f94f8a@linaro.org>
Date: Wed, 22 Oct 2025 13:50:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] hw/hppa: Fix interrupt of LASI parallel port
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
References: <20251017200653.23337-1-deller@kernel.org>
 <20251017200653.23337-7-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251017200653.23337-7-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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

On 10/17/25 15:06, deller@kernel.org wrote:
> From: Helge Deller<deller@gmx.de>
> 
> Fix wrong assignment where the LASI parallel port was using the IRQ line of the
> LASI LAN card.
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> ---
>   hw/hppa/machine.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

