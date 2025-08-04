Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE935C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 22:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj3be-0002Xs-U6; Mon, 04 Aug 2025 18:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uj3bR-0002Tc-BM
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 18:24:22 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uj3bP-0007Q8-Vm
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 18:24:21 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-23aeac7d77aso43268115ad.3
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 15:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754346258; x=1754951058; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2/GT1eil0PYGsfNkOP9X0CTcVsrSycNOuC/hkSQ7Tf0=;
 b=ytIbOfCshwMbvtQ5HAunvmsMTLBz6npBaxsNjq7ascuUqXx8XgsArVf4Ei/9f+xQs2
 o+jv5mSiA3/0wtZF56qh1axMdpVWBqCb7MhUq42G3isU5q/6DUGD/dGBC8yiGVK4Rkah
 MYPDi/49ay8yDE7MLBmXrwEgsbJ7pJmfy+/7d4v3x1MT7jrvA+3DXIhGOspW2PV32sL5
 fiKVWgkunhbxCBV1cabggzDK0biP1YZ2XNS9ctm0JEmJCoFAxh7tI92PI/pF2FJZhGon
 l/cxSEh/SY6R4F8KjAfgh4QAABFgWn5qWVX3kHe5cjJVtgfvCfeNLzSF31eM+guhKhmV
 Wi1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754346258; x=1754951058;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2/GT1eil0PYGsfNkOP9X0CTcVsrSycNOuC/hkSQ7Tf0=;
 b=aq5JoTx8AlElCe24kJDrvyShWs8zVuZY1m6av/G3xDpzH2M/tlpa06W8RlxT+NnAJW
 B/LIHwc8K5kQdEt8Olk0wn49Qf8qartSdeJ7zqrGIsqnbIglsSdU00vx0b0avkUdKWqN
 gzkKcpA/Z1rLsc4ehcOyonL66Z8xQqnTb/ExyatiZQGVBXaZkEovMtc1TY15vNrxzZz+
 XQ5AjnmzltMfJ14DXuJRU133jnCKXWIu7tfo+b3xX5dfIPaCHYurZDJt8X0/Jan1/1JZ
 yDimnhXmn/F762o/xJ2ydEk7L4PR0HsIuRQYv6mfnE9sqNqk57712e3cueXn6Bkx0RDk
 S+2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMFy3ISsk0wdV1DSVRIIKWDvzNqpxniMfp+ULPZwW5p8iKpy9N3HlvCX+Y4sd4qcRObatUbgNHa28c@nongnu.org
X-Gm-Message-State: AOJu0YwdkKDJv0FgHNNS0x5ZZvFIIa2v/9XJt/OSbiUAkpyIweJcpDmM
 arBAfKthjQ+CGR9VPrkWMykDNOJV8xHsnWnLK2wlljvJhb32BNsLHXL0oGXJsQbbBJI=
X-Gm-Gg: ASbGncshejV7GaT8QXrQeX+H3vTgn2o+mjlHPyviUTKd2HD6KT/wIBnJ8Dmec9+veka
 J4EWNYCOW0TUs4vzEW8cyKXs3Wif3NLhYM+lw+99G92032/rAUSlOHD0vgk/88Uwdq8OszVduQw
 UvH3KVGLMla0azl4UcxG9U6vD8JJ1bgPrX1miOd0M+FbzqjGvm28syas3KJHmr6Nn8FyuF4Lh3k
 oIUwh6xha9zzE9Had29URfubBP5EUcAu2Bk3tV/dzhhtnGou2vTdJSktQDAd+isdwhuByoNL9jl
 0gOArslLw9d/XK0AnPYllxl26PmpIAXMT9OQRTG4CS5BpTxFhSsawBnl1ZY9RVbD57nbSdbyS5L
 cQVPFCIsmu1k8oeWsuqRSmLG+aM/IRQgmvidYdN/e
X-Google-Smtp-Source: AGHT+IHZNtV4kjH9UEZk4umFwpRlV88ZUVBkqvM7UeZk3oBeu7bqoHphOMwG1QBfv8vp6SR+sRs63A==
X-Received: by 2002:a17:902:d487:b0:240:4d19:8797 with SMTP id
 d9443c01a7336-24246f8c70amr179479245ad.22.1754346258502; 
 Mon, 04 Aug 2025 15:24:18 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef7562sm117168125ad.24.2025.08.04.15.24.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 15:24:18 -0700 (PDT)
Message-ID: <21f751ba-27f6-47ca-a3e5-2683d0f76e03@linaro.org>
Date: Tue, 5 Aug 2025 08:24:10 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] target/riscv/common-semi-target: remove
 sizeof(target_ulong)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, Weiwei Li
 <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20250804183950.3147154-1-pierrick.bouvier@linaro.org>
 <20250804183950.3147154-6-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250804183950.3147154-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/5/25 04:39, Pierrick Bouvier wrote:
> Only riscv64 extends SYS_EXIT, similar to aarch64.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/riscv/common-semi-target.h | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

