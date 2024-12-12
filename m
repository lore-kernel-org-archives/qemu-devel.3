Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9474FE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 16:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLlvM-0008Pw-P0; Thu, 12 Dec 2024 11:20:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLlvK-0008P2-Ox
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 11:20:22 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLlvH-00070y-HR
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 11:20:22 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3eba347aa6fso94651b6e.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 08:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734020418; x=1734625218; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RUYOA85KwWXURaDKhy0VcAaBSG2S2ZxlnVbkJi276R8=;
 b=rRHauxA+TmFZqHO5C+2+OjjQN/3eRwJrZpnQebVCIes+UFZT1T92bxhfD98Pp0W6c9
 f/6p0xd5IrlqGCe5QvcU0X2GJQ0pwfju8yGF/Ggt97CEjzgUWsoOSeSmj4pPeaGsTBRx
 mBMT208KNcQDwM5QWiKvp7g1k/zz5fETuKM7ClTkQGmKc+ArHE5QYGtQ66DItD1+RD4S
 vOpN9tzukgJLouM3WofdqvE6oC3/gtPYwWdqS7vkqQK9DrmEoxrZFeGYtx15HZSjINFL
 Yrf7r9lT1HnLul09wmSyoWHJvwC9VeXqAZmh+iwc16GW3v+XaBpxCqWEszRSE0pW7uo9
 UiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734020418; x=1734625218;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RUYOA85KwWXURaDKhy0VcAaBSG2S2ZxlnVbkJi276R8=;
 b=YB4BF0mgt7yvMJKdvPIbvua79A+1KTqmG1Xi2rnLUDHqW73qeZDMGxxxR7GkZNHQ7r
 YfKOO0re6OnIW01pSJmjGyRhooiFOalKAxeVKsegndGbTSSE0gNEJJ+WfyPPb+iI1eDf
 Lc7e49NNSxGblH7/XqZGbtC0HkSaAY06ayylTvuaC1f7dJrHk6yLGPGWINtf0IJ5SWKT
 rR1N1phJrE0Urj0leTjE985vnbmQepQ//KppqHmaQnwHAlSd7sFEyzLaECRnRTwkjKD5
 vus+QJHjLTf1KOY8CWwI2k2Vp0tiB9ihF+kaHzJxIdOKy1X3G9VGYjBALjVrNOMNqEPU
 V/Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+l9b+jh4OUWI23DDAoa1LHhaCP2nHmj4ViJCOsQDna7W+bSNn9SQ8yYlwn8wHmGVIwqrHc4jC/NMU@nongnu.org
X-Gm-Message-State: AOJu0Yw8ibOEcr32WVT0rZHIQ6IRw3/49Kcv7bpwDMfmupdYZcGaBxwg
 FQjBmFRwZwe+b5bRyN292lU59PE5JCyH41l1eT9tGrxImtc4BIg1VvWByU9QDEw=
X-Gm-Gg: ASbGncstNWtYe4HcYv/i/5NDHcrYYFkAD//EH7B1re/uFyGCe34nzTTB5IooHnAWhJB
 2AeXsbAPJnNxoeEtuHdP/sZ5uv6aGrUriDzVWVUEs1ZDyEwH70aPa8FoCoAqV3ASELRkh1vnxL+
 k7dCQ5CMhpLh5R9En+6VMf7as5bCYaFrxx5q7qtmNUK8H3QnP+kdQZ6kDD+hhRi5owB0CzjkSXt
 unrVpiAlrSYnlp0aOECVNrNDFODcKvEcqZSaD9PTJzh+GBc7eLSpYmphOic1JgHjD50tZaj5g==
X-Google-Smtp-Source: AGHT+IGwSANwEAq3RvE37UQ1cu85gP4JmY0jSflV5J4a71Imfk9YtB+oj+NIPBp2RE6iCx9BsH1ylA==
X-Received: by 2002:a05:6808:1981:b0:3eb:6044:5a7e with SMTP id
 5614622812f47-3eb85ba8b46mr4853224b6e.19.1734020418075; 
 Thu, 12 Dec 2024 08:20:18 -0800 (PST)
Received: from [172.20.4.119] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb8c604bb5sm676028b6e.47.2024.12.12.08.20.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 08:20:17 -0800 (PST)
Message-ID: <58308515-6915-4fff-ae91-14bc176ed0a1@linaro.org>
Date: Thu, 12 Dec 2024 10:20:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/11] target/ppc: implement address swizzle for
 gen_ld_atomic()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, npiggin@gmail.com,
 danielhb413@gmail.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
 <20241212151412.570454-9-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241212151412.570454-9-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

On 12/12/24 09:14, Mark Cave-Ayland wrote:
> The gen_ld_atomic() function uses a number of TCG atomic primitives within its
> implementation. Update gen_ld_atomic() so that it implements the address swizzle
> if required.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   target/ppc/translate.c | 81 +++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 72 insertions(+), 9 deletions(-)

These are all Power ISA 3.0 instructions.
There will be no swizzling.

r~

