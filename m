Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B70AE784BE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 02:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va2x0-0000Yg-6L; Sun, 28 Dec 2025 21:25:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va2wx-0000YJ-QN
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 21:25:35 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va2ww-0004ka-C4
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 21:25:35 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7b22ffa2a88so8125002b3a.1
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 18:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766975132; x=1767579932; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5WoiaE2ZH6mJolbtaSStQffeSQiWWj8bzgqxv7YyGxA=;
 b=opYVzI3xGpW1EbYZjY/5uFlyUnAj13ZCT3etpk7o/eGcs8VmQfSlFlmeb4nzDVIACR
 7cx5UEDVQODCKHrpoMnFEh086MPaHw6tu/R7Y5rXOK7nJvFXt3MSrnaOgFGpYST+mTf7
 q9eY84SL5IMGgnvbC4nekmgSZIVxs9jRtV0Fz6kEl1JqNX3u4iSay6nYriSevcnrZ6ad
 CU0VlBvTYPefPDAA2873KD+OckN4cS4FJzOUkcg+zWl3lXBdd/6z/Eg9DFYTH+OnQLHS
 nSHnf/hHGdrXuMEwZ285MQLvS7JV3DrqaHtr2OJ/soM1lu4haHRqQ4x40Uj0B5vPk59j
 LL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766975132; x=1767579932;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5WoiaE2ZH6mJolbtaSStQffeSQiWWj8bzgqxv7YyGxA=;
 b=G+oRQdNN9cSeyIZTVnzaubFSBrZR+gzjgYYbMWkjrbAFZbMs+FQ9K1tnjqJjiWMv6Y
 zlC8lHA8RErdP4vqDvmotZVw5wmNEh0+rvNT2CUVnUVhEqteOObrZCId3RGa2piO3c3M
 MclkyS61QNsZ7vgckdRTDDTQ5CDToED0mrQv7nv4HYpuswaKSacUD+DhFTJm+cuPlSRi
 OvjuxkcgIcJCqaztupXErS5/qU9596wf9K7sq/6ZYoTwjhrW1kWg1sHlHW0Ro+8YnAy4
 pwJZb4RP6EcixF/v06TDi84vkxkk00G7RJsneeLifJghrvx2qw5C9DB1OiXSaoNB8l8D
 fDgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr6Jm6IbupDN+9aomQk6NNSrMOEVl1uGP9vTFLq5Cl8nHp3bgW8WeE/qhOE5uHFcdtZn/QBP4LWMYU@nongnu.org
X-Gm-Message-State: AOJu0YxoZKJplP6MqnZXlH4sCPviiSFRftV65g2c57iv6FlQ/UUNTh7d
 5UVyzrt+gce6Xr9SlV6eC3dG60bWLWxW8Dgjg+InwyAD9IhTaU3JmlqbFNl5ymSKFORGtpm74Eh
 Rk/jSdjQ=
X-Gm-Gg: AY/fxX40L3zKkKejKAYl8XqPD/9kGVs030NS/xiE386msSXObse7/a/qYM1jDg/Y2PD
 ylW5Ou8jv9u4Dqk7zIDMgy3f3vINZh3G63Sc0cNxmMNX1VSf8p9nQOGP1xm+gsFHcmnpfB9uRT7
 xnvsN+hagTzM61RQm8uICcHfwJ4mF0aanrSD0g7+NNOGbB5mPQqiM8p1ajCD54BQSt19bmn+P/V
 eM8Tdm21M9ynLzaOIF/6MDkqqblk4LKkE+9StyNQcxpb6r1BAkl+d7MOPqiBL6bKwQURCf8T9GO
 Nxw8QZ5IOl2G6fu/Ceb24vs4gA6vkieCzSw111AiM2eYgfVlZ7hCZ8eOSUT/7BrUwsELBi9QGdN
 oaFHKiFTIxl3Hqbxip7beILXp/FjlzHveJpUu9MDzrjsEeLDCuEyry8zcOEymfafK6bA2RPjmfr
 +1kUlhB/HqsXcPdsnKzTQ3UGKOlGZY4sRXMsUeJDm4OJDwOoR0qCsceRuBGzi+fyRCPCkncQ==
X-Google-Smtp-Source: AGHT+IHimLaATX1pxmcaNCuoxOSBIWK05q+hPxomr9l6f41OG4GXrws61iObecxedy3INSNzuTcH0g==
X-Received: by 2002:a05:6a20:244d:b0:366:1e11:11e6 with SMTP id
 adf61e73a8af0-376a88c865dmr28470052637.4.1766975132431; 
 Sun, 28 Dec 2025 18:25:32 -0800 (PST)
Received: from ?IPV6:2406:2d40:40cd:310:f6a1:5e51:f9d7:f095?
 ([2406:2d40:40cd:310:f6a1:5e51:f9d7:f095])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e88cd71sm27666605b3a.64.2025.12.28.18.25.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 18:25:31 -0800 (PST)
Message-ID: <d67462ac-167f-4510-aa82-bce5af8a89e9@linaro.org>
Date: Mon, 29 Dec 2025 13:25:27 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] target/alpha: Introduce
 alpha_phys_addr_space_bits()
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20251215-phys_addr-v2-0-633aa1d922cd@rev.ng>
 <20251215-phys_addr-v2-1-633aa1d922cd@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251215-phys_addr-v2-1-633aa1d922cd@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 12/16/25 06:42, Anton Johansson wrote:
> In preparation for dropping TARGET_PHYS_ADDR_SPACE_BITS, add a
> a runtime function to correctly represent the size of the physical
> address space for EV4-6 based on the current CPU version.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   linux-user/alpha/target_proc.h | 23 ++++++++++++++++++++++-
>   1 file changed, 22 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

