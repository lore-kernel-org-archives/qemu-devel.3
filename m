Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256D7CD4F21
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 15:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOdXM-0007MQ-Tx; Sun, 17 May 2026 11:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOdX7-0007LS-Lp
 for qemu-devel@nongnu.org; Sun, 17 May 2026 11:36:03 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOdX6-0002lr-3f
 for qemu-devel@nongnu.org; Sun, 17 May 2026 11:36:01 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso13050695e9.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 08:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779032158; x=1779636958; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gu4xACLf4LIfVkuWzTNd9lt+vsT8s19thDLSjqw+Q1I=;
 b=jRlK0pkBq3aMJvu81+0TdUeNOptNP+RDnxhWrDqYFRRpYGKD7BS9PeIknV0OGY7v0w
 KbS8yvBVtXzku272hYENDIjb5msb4aJFJtirRZ/sBUu8xEr9/cJmFzv0Oii70HomCFRc
 nHnWj3NKKVUHplasZ8eRej1qkR3DYJQwA06CjPDssy0YPmnksnbkWFwPJ7aW0NqpS0Pv
 9/4TQpzWHpgL+paOq+HvQsY6c8w8NRu0Hbf6rulIUvm0eKsae5s8diRVo0jbPqcMdArk
 oW0oWDHBw7QHclgBMZc9llow9l79/VeWtbhoUjTXUsSVmqXdS5205q1ODmicI1Um+AJK
 lvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779032158; x=1779636958;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gu4xACLf4LIfVkuWzTNd9lt+vsT8s19thDLSjqw+Q1I=;
 b=GK2Lyep3cd/IwJQWveznVItXcLt6lz3eGE3hX58cnRQkethjXZhy8Ge/gT/Cu0Ct1J
 UIG1k9q2/fNF1rZP8kkSSyyI0LaC+oMPfl/g2ypldJI3dGaD1MNSOrkKoaIKqX3/JT9g
 r3S63fvPBLZAaHlva5JPb7LKrXCpztgeJsQl023gw/OKIXdqbLlC7WsfsQUvcrIxVLcN
 Vu3xO12zFM+r6tCVvlCUbwmKZ4JKOalhlrxHeRgCMotHOSZbeEEHln8n1ml/EEv/qBYK
 beWsqf/FLXSTOxqfliRYVeAowMQPqimEK+MewCDaepEhQV2bnjYtjMbhjMaRluNEG9b5
 qSlA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/JCrxiwIgdW1lezfDGn4Qqa++aa1xvHIf759j2wWZJojONtEl0lcjpxs3hLADzoSsw4ZtmIvmxFj3c@nongnu.org
X-Gm-Message-State: AOJu0YwSgrcccHfak2/wSKhTGYsUfK5AI4Bmz67UxUWnYdjYgthtwQ8D
 64uic2pLI0yplbX4KqR2dudUjQGwGdjutWRv1FDBjbvA13ucOL3Tq4YXB9g8PxExWxo=
X-Gm-Gg: Acq92OHTOLyO1vOhplSh7WBX+ohthKyYdfv3+FSxax8vengBYLOpI9k8qBoxM6zFmXx
 1OaWQu3JDX6s2hB53PtPUFBPoW0t+C0YBWZ9w68X7UQ8tarIL3q71ywfZLpGv5y6v3Onf76BRvs
 1gnpNQoFtRKWS/5VpshYI6rUXLSk0VatYmNC5lm/0RGgun5fMRvqaiaKUlvY2gMiUTIMsT8j2xD
 kwjJLHBf8phGI3V8ICRkKR7kntyfr8ONEx9b2wnVF6ZM0sbtR44JAOQNiRtyiH5a6ErvdYxushB
 awGZ+imwAaNbIk0S2c2+TTmCt+UkjqQZZ7V3tIOqKSRAxfC5GWoZVdpq6OrTiRoNzlz6WeNidnA
 qlSwqB/PE7NSasbYpNyFScc5JNd1vbjb7K0bruNsXdrHfoVBv2uTRx7fqW7H7XJUKdS0gYj/eEa
 H/MJ5e5nGmxUIrUlBqqOeHmcLje9GyJlEEbn9oewwYJj+VWwnQv6Xqjy82je9T5aklNw==
X-Received: by 2002:a05:600c:4fc9:b0:489:1c1f:35df with SMTP id
 5b1f17b1804b1-48fe60e58ecmr160151645e9.10.1779032157675; 
 Sun, 17 May 2026 08:35:57 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5cab818sm202737635e9.14.2026.05.17.08.35.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 08:35:56 -0700 (PDT)
Message-ID: <cc75dbbd-c040-4bcc-9d5f-7a1c58cc3ba1@linaro.org>
Date: Sun, 17 May 2026 17:35:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/27] target/riscv: Fix size of [m|s|vs]iselect fields
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, alistair.francis@wdc.com
References: <20260515180437.23620-1-anjo@rev.ng>
 <20260515180437.23620-15-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260515180437.23620-15-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 15/5/26 20:04, Anton Johansson wrote:
> [m|s|vs]iselect are defined in version 20250508 of the privileged
> specification to be XLEN in size, however QEMU only ever uses at most
> 16 bits of these fields, so fix them to 16.  Update relevant function
> arguments.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   target/riscv/cpu.h     |  6 +++---
>   target/riscv/csr.c     | 32 ++++++++++++++++----------------
>   target/riscv/machine.c |  6 +++---
>   3 files changed, 22 insertions(+), 22 deletions(-)

-static inline int riscv_cpu_xlen(CPURISCVState *env)
+static inline uint16_t riscv_cpu_xlen(CPURISCVState *env)


