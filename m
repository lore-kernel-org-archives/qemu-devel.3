Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C5DC3601B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 20:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u04Gt-0008KZ-79; Wed, 02 Apr 2025 16:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u04Gk-0008I7-UB
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 16:01:03 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u04Gj-0003rh-1E
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 16:01:02 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736ad42dfd6so120673b3a.3
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 13:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743624059; x=1744228859; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZM8Fn99xepfey2zNJx6f4InsedmMIKCWo3l6nvk8erA=;
 b=zjPV4j4QaSX5k5cuLljpw4DjE9Co8eJVYGFQL4DYhLlk/IOQzmD8p7EqGx6KlQJ4u5
 IZUnBzNmclnmFUem9XMqvwkHoN6JHgYTGZj1JTnD2AMBP1d2eTKSwfFuctzkhuGpIrIM
 YN6qx0NLKVGf051VjLowgRjdSbDYgEJzYraVmYbYX+eHj5XomVnK+GyqtKxi/7bmFjfk
 QJZ+eSkfl8y9f42bNSnOIhG2CLlwHYbr88bA/vEbgL3kQqIUnH01hA2QQbffO4Ge8BY+
 vcAflRlaqcm7Ix6WquzmsbjFZ3n/fi2gcfjZoNOYw1886+Ei/j8T+MwKAz/IPA2k7Oj5
 wkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743624059; x=1744228859;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZM8Fn99xepfey2zNJx6f4InsedmMIKCWo3l6nvk8erA=;
 b=MkGfVynCFmCM2slV95gDEio0wMVhT6ipUcTtcl130h6jnvaI1gquEUEiQUj9V8tHuF
 2cA7oQPXHAJW6hqCH8eJuX+YaZKag6wbJZKh2dplSjyjfAtH9hWyFWYkIUX2P5K4gOsX
 Uf3EIQMrad+7tN24Ngf5WgiwgWghokiQj+Mg0+dYtz+eNtGNwwGh8nZbqhXxnG31AidO
 euV5nie8s1cIVrV4vxqNTKBxzm7IHXLVb1Srb8S7jr286YuHNMjTrJ7b3EAhrCkyWIX+
 e0YaTnky41xQ3ga4Dkoj3lAW2NmQtl+Fg9CcvRCiKydKmPeuWI0eexd2SmOIBazut3DT
 isEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfHH0/qfpJtJqeh3T25noPFvgzIXOMpb61Xw/CRv6X9fgZJ/HaKmVKyT0aVgEG6isDyLe596cxJRCg@nongnu.org
X-Gm-Message-State: AOJu0YysJLcRHhcwuc4zKaicZsdO6VncnsMLeCnHP5/s09m0BqEuggH6
 TRjsCJUY5U9haIKjxKvWZFthl3wq9xys9X/1MxYiX45erPb5smgBEYrg5Bg87Tg=
X-Gm-Gg: ASbGncsvZTEaaojLxG/6CCnPDc/ma6nxqljj+wSUZ/P7rSWC131bJZzQdBWs9ZTVqjb
 rZvx0ZquXZPNh7FK8yTKw6oAIjZLHZJjwH/vkBFcaSKE+NlrHP7nE150PmgOSpPS1T/WPK63igy
 9AeamzswmjREi+tloRjKUxhKx0c/GKaRY8XtA+hKEnnOfX0QdhLw5imsDGgP0V2p+Y7mmQhvABM
 gayDRuXRIwV0Qoup4rGpoVlpkoIY5JGJZWFE50tU3krTv61VnVgeIiHFYdsUeHM1wTBTVwlGZh/
 rx2Qv8X+SIzjiZni814gWY1tEPb62Y8o2UCb7G8BEPcKe8FHnXn3WOwTO4f+RTX/7BdGn9Jad/2
 WmwEmF5ci
X-Google-Smtp-Source: AGHT+IEgf0gzah/M7sSI3bHtfyai/iyoz0PgRVm2PKvyk181GHgt+aWWyOGodKWjzMN8fNSn+F0stQ==
X-Received: by 2002:a05:6a00:398f:b0:736:ab48:5b0 with SMTP id
 d2e1a72fcca58-739c78430demr4047765b3a.2.1743624059376; 
 Wed, 02 Apr 2025 13:00:59 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7397106ba79sm11776609b3a.104.2025.04.02.13.00.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 13:00:58 -0700 (PDT)
Message-ID: <90135439-b3a0-4e31-84e2-ce29b90db593@linaro.org>
Date: Wed, 2 Apr 2025 13:00:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 v2 0/7] tcg: Move TCG_GUEST_DEFAULT_MO ->
 TCGCPUOps::guest_default_memory_order
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250321181549.3331-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250321181549.3331-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 3/21/25 11:15, Philippe Mathieu-Daudé wrote:
> Since v1:
> - Do not use tcg_ctx in tcg_req_mo (rth)
> 
> Hi,
> 
> In this series we replace the TCG_GUEST_DEFAULT_MO definition
> from "cpu-param.h" by a 'guest_default_memory_order' field in
> TCGCPUOps.
> 
> Since tcg_req_mo() now accesses tcg_ctx, this impact the
> cpu_req_mo() calls in accel/tcg/{cputlb,user-exec}.c.
> 
> The long term goal is to be able to use targets with distinct
> guest memory order restrictions.
> 
> Philippe Mathieu-Daudé (7):
>    tcg: Always define TCG_GUEST_DEFAULT_MO
>    tcg: Simplify tcg_req_mo() macro
>    tcg: Define guest_default_memory_order in TCGCPUOps
>    tcg: Remove use of TCG_GUEST_DEFAULT_MO in tb_gen_code()
>    tcg: Propagate CPUState argument to cpu_req_mo()
>    tcg: Have tcg_req_mo() useTCGCPUOps::guest_default_memory_order
>    tcg: Remove the TCG_GUEST_DEFAULT_MO definition globally

Queued to tcg-next, thanks.


r~

