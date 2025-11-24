Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF40CFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 13:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNWzs-0002lY-5h; Mon, 24 Nov 2025 08:52:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNWzo-0002kj-N5
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 08:52:48 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNWzm-0003WF-90
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 08:52:47 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so29557365e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 05:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763992365; x=1764597165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1mtzd920aSFcSx708d9BvNhK1iUep1gCSqIiNNTfi6k=;
 b=lQQlypFg7nNT/YbB74Xo/aHEBUZHV86ntdSnqkV1uhzhjj+yi2rrDv3QkYLztW2K45
 q/2K6dR+k03v7k9q4qK8hex62bRB004GbtbG4TpxnbDJQHrwL0LHro9s4ijJmf9+TK+M
 AEFZMqLpH8jtsYrYm0bpfGw8vzkKwCshhFJaN+z+mkn4Q49HOKzfvfQlAqVWYY1sR63L
 ACP0opPDMIAzbonWxXZDmenqTY1mhA1M5E6RCJ7vXpR2CNbwBqVfp4RsBxaKcIQ1s82F
 zPStFSHrfWieSJAZ4Uqj4rV98nLWUMT4nPXB1JWVeN0UY86LUVCQLNCi6kZK+jXVWVUP
 fBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763992365; x=1764597165;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1mtzd920aSFcSx708d9BvNhK1iUep1gCSqIiNNTfi6k=;
 b=ZiT4dOwSAvjWw9ykvxkMiKXkZsFdjHhvrcyqANkAhStM71X7ZtkY7t3VyHU0Rg6LSo
 KwAG5FxlQ9Xk3k4otmRW/5Gqc2nExPtIxQnw1vZLsptN/WvPpjxSXGsMjHeBv8g23uNz
 m+wZAh9yZ4VxinxTeFKw37U8rMLpWqFqOfMJ/K4JEXcciRkKuehwHYG8urXL5OmxaS/q
 AV73y3uIMVI10HftPm7FO0v8uBrc1vspZpKODFS+wkREF/ySeDfO8GA7VN+t5JJuGAls
 vSdKv3uNFvjobuKPERId2gLlhT7uDBDqB+NikCZ2sy13/s1T56kaO8cS19kEgZIFcp9H
 K3Xw==
X-Gm-Message-State: AOJu0YzdYbC4+4DJhBBybC3c7FIDvVdm1XfGTDuRwJeuvcOcfTHkXABR
 PLfcBRzd9esWx8205YWVCmbXmRnmaRFGGAZQUblMbq9iJpsA115Uk4DsnhURHoN9D0Vk1UCzryy
 nJw7T
X-Gm-Gg: ASbGncuai94eBhs7vvs3qSGVqBSwwNfjTOKE1ZbeJc7F0jv06B1kLGvO3k/Xa+4vUQ8
 dv1EIwGeDDhhlbjA5HL8r38v8Dybs+stI/ila/CNJnAquwKxPJtqcQfEfZKa2w+/40rLuhaNv6u
 99AOofBYStEqLlRz1Qv0K0faCIushzHVkFrzS5DvC6f1OTIdFkVIG6McHcIFFobT2TvP5rXzC30
 llOMZYzhrX6ILnFZz0bjeEIxmBMBLcxxnuhcSDyS7/fKK3ktmsnyy5SsGbuNF603cS9Cty/OWSJ
 YKAH9GK7aCpJQ806gZ+pugIaE1KQO/m3JWFtRcpXlgfFSqEDeUXjNEIRKIuxWR56ZlcWtSSV2iD
 7J5BA7YdHYUhTRGiQwdBmtZIxtezFjb6kEgS8QoZCM2eyADheNeBkHMGUAeuRcA6f2GBjhihcmS
 3iKQHXOHlrqKN6EsBUALxDpQ==
X-Google-Smtp-Source: AGHT+IHQrZqIWWnC7MkzK/+nhcank57rOksdISHjqE7ep3QuHjm4yxlwT4XgznxjypEIBCl9LXEyfA==
X-Received: by 2002:a05:600c:1e89:b0:477:a1bb:c58e with SMTP id
 5b1f17b1804b1-477c04cfddcmr128763695e9.7.1763992364619; 
 Mon, 24 Nov 2025 05:52:44 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf22dfc1sm197425175e9.12.2025.11.24.05.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 05:52:44 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4306C5F83A;
 Mon, 24 Nov 2025 13:52:43 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] target/arm: Enable ASID2 for cpu_max, allow writes
 to FNG1, FNG0, A2
In-Reply-To: <20251120125833.123813-3-jim.macarthur@linaro.org> (Jim
 MacArthur's message of "Thu, 20 Nov 2025 12:54:15 +0000")
References: <20251120125833.123813-1-jim.macarthur@linaro.org>
 <20251120125833.123813-3-jim.macarthur@linaro.org>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Mon, 24 Nov 2025 13:52:43 +0000
Message-ID: <87ldjv8rmc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

Jim MacArthur <jim.macarthur@linaro.org> writes:

> This just allows read/write of three feature bits. ASID is still
> ignored. Any writes to TTBR0_EL0 and TTBR1_EL0, including changing
> the ASID, will still cause a complete flush of the TLB.
>
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>

I will defer to Peter on this but I'd potentially split the adding of
the feature from the enabling it automatically in -cpu max. But its a
minor thing given the size of the patch.

Could you also update docs/system/arm/emulation.rst with the feature.

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

