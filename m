Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD8BCFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 19:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNcPY-0000Fe-WD; Mon, 24 Nov 2025 14:39:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vNcPX-0000F1-En
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 14:39:43 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vNcPU-0005wK-Gs
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 14:39:43 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3436d6ca17bso4721603a91.3
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 11:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764013178; x=1764617978; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O7w8gtE4EzvMsEwEIE9ywIyWuvpQpoBXsD0ceIMd8rM=;
 b=bnZyVX8uiSwg/+lS3HsX8Nui42f7LCYrW9lgryXbFlEhpfgBhqbJ01SYEKa8fyGZ2T
 lyPy6itLT4GOyW7V3487yQfTG8QYnGUCy1CjzL4SAdf1ZcO3p12NCuRaTjCwsMftyKpT
 9n3jL659txcRaMfNguWwamHf8oWaTA4zfzcLCUYOh9DS3+YlZV0NwxHmMJm/UIoKtnre
 H4VwvGRaO55vVGxEGVuVIU1SauOWBU/1iA1uyYPPdp2vKjzW5EOcV4Uori+rOrj2eAmp
 c1Uu0dA+wIZa7WjiLc+R/trqtIDFrxPV/kCLnUS52jUpjim0jnElFpcPjPaWPVlgphLg
 2K2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764013178; x=1764617978;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O7w8gtE4EzvMsEwEIE9ywIyWuvpQpoBXsD0ceIMd8rM=;
 b=mxSGKPOd/nQ63Y34a5jxH1of4Jt+xJ8TUwQ1TwfUQaIJClpYBom1HvQnp/nYDsU7pZ
 dllBSDTMW0hJp+QroDu0yjFgDbHpin0FcBg7yCNV7diKirDRII7KC2xx7EppSmcOPAlo
 8NKEFwYkp7poylUqUzto3Lvl6rwCVQ+QhR72QaEJquQnSeRMTGaLzdQORZPeruORhImq
 rWx+4jYzYTSgaTpCXH44tEalN+kJ4Xl60siC3zl5kgQbSfKOou59p6+Q/Kb6yNRgiCYR
 HKaRrgX+lhHk1kswKY6+/kC3pnxMB+3EQjwBuDfHlW63cuiNM9a8WQYT8ypUs4uGa6ht
 e4JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU63ZcyvDrTkfkBcMdk7QoQSWzH+cdegbMYyUhpHe5Sbcg6Wf0NN+kYMpEenMlnB1623bG9bFgMj2Kp@nongnu.org
X-Gm-Message-State: AOJu0Yz5TNfwe894o/BI4gXzWn/XT37jIar6Z4YuM+ELUGzyVUmNWA3H
 O1dRsBJwoxCwIxFEaltvYisxnr/uG3N8aA2l6sGc+qgfFzTIWwywNb4feZfYkLIBnCU=
X-Gm-Gg: ASbGncs48hNMrRLGAJ3E0B16HcxP2eHmouDZCmU6o9MVwM7jbKGwRw/8MBdrhAP5CTB
 G8EFykWzioOxmwprSZEljjnT7nYfmt5oqEMcjxGHjmhEy/PGuFQfXOo0tt+WqiWYL01lwMQgeqJ
 03eWTtqRgI9aJM5jbvxHPJDQkz2scX+0QDeR9/zGTUs2Y4FKpQXS8MSNyxpt1Ab/PykbfedNOdh
 +kS2HgmWdcx3KBooheCupMr44weba5f15/ByO4w4f7e7GqiOorapVskqGJYYfvXBi62jiNHoX9Z
 sh3kxzaDTbFYgolaXsxavmf/FWTmnG3sGaCMB/646Kk2s5C8on8+7vhENKkNbSWHau/uAzEFZqo
 XhVqdBmn6FysTKWNSfoNcBz5E2wa2IrBq1D8bVtZ9nC25x71LvkogIO9aHohgcnkzGcey7z+jhf
 VXVbMWhiAWz9cXhI9CPRtnRd3j36Gwq0zmZyvmb3PGidyStY6oXA==
X-Google-Smtp-Source: AGHT+IH1PBGFdOtkE6luO9te/lAjEKTSfEOuM4FCsLIKOViSpU+cftKMk5xEJugLf/3I8wlIGVObBA==
X-Received: by 2002:a17:90b:2f84:b0:343:7714:4c9e with SMTP id
 98e67ed59e1d1-34733e46f2amr9531384a91.2.1764013177605; 
 Mon, 24 Nov 2025 11:39:37 -0800 (PST)
Received: from [192.168.0.4] (174-21-76-60.tukw.qwest.net. [174.21.76.60])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34727be33dbsm14140138a91.8.2025.11.24.11.39.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 11:39:37 -0800 (PST)
Message-ID: <39b0c93d-30e9-46aa-aacb-09f7b3e2ebe6@linaro.org>
Date: Mon, 24 Nov 2025 11:39:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC-PATCH-for-11.0 v3 01/21] accel/tcg: Add endianness variants
 of cpu_ld{uw,l,q}_code()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20251121134503.30914-1-philmd@linaro.org>
 <20251121134503.30914-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251121134503.30914-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 11/21/25 05:44, Philippe Mathieu-Daudé wrote:
> Allow target with fixed-endianness to not use the MO_TE definition.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/accel/tcg/cpu-ldst.h | 43 +++++++++++++++++++++++++++++++-----
>   1 file changed, 37 insertions(+), 6 deletions(-)

There are 28 uses left.
Perhaps we can finish the conversion to cpu_ld*_code_mmu.


r~

