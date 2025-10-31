Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F58CCFA04
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vElwK-0008A6-Sy; Fri, 31 Oct 2025 06:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vElwD-000889-DY
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 06:00:55 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vElw1-0001P7-Pq
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 06:00:49 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b3b3a6f4dd4so398469666b.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 03:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761904838; x=1762509638; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BNBnEeG6++egCk9q/ndavQd68bgd6HWdd2DgomeQEk0=;
 b=ChIQxbji18FgYozPkLYcOdAQ7uJO9zNqcPxSY0UQ53AZrumzu9OHJO6H/mg9jq5+nA
 2RpsefuCawsxXpeFZp/sAWci+Y8uOzQW/eav9Ndn+7jZE5BdhmNbhY1pOjV19uYS2nIN
 R6756A+5uujC6DPJl1Yo4NNTDWLNxTC1ZvNTidSaaC9vs5TcByDgcBg02NWFgmLqU235
 tHscbeAtReQP4nfpoLNkYESH3sp6+odRAmzJIkmXvjadaknQzWGjhumwIJ3dBs/F9o7P
 BZUoBQnHva3YM/07j1YMheZOBdoIgkxsOwYDHrW5ATo7Wj/PiYhhrpsPLMp7aeYNhHv0
 t5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761904838; x=1762509638;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BNBnEeG6++egCk9q/ndavQd68bgd6HWdd2DgomeQEk0=;
 b=IFVdo+y7+GJvJKU1u7VKQ+VSPl/vXV/eJ6dRIMX1RbNUsZjhdA11TtpmzMThC7oFqC
 BWA+T4DeJJ+bo8XJGRAL09BKfcAtp7dHzvCheKRMF5lSpar6iCOjnVzWMOxHFcgLYsgQ
 q/JnV9c60GbTp3azcHu/Zyfm8kE2DOE936k/HbnFGQenXHVefJrg3XNZDSUbO5DpLokl
 iVo/01B+8VA2NWJy+wbjxVPxIHpjVAvt70tQGgQVIBf2NGdwNjcm3GD25GGaMYJR5YSQ
 RmT+p6JCngVADWYkOAI9tdTgd8a7OeV1aa87bynXi3j6Ne1/BcVoyge5odkiJu33mGx6
 X+Xw==
X-Gm-Message-State: AOJu0YwqsTSAZdtp/p7EPnZFk4mqXbaG5kxnidOEk83qvQoQToYf45WT
 jVasYXO+xZEqEDmxppvtcDwkRaC4y8ljT1L958TR8O6rRBt2kcROsJJ5b3cCqKk/gp8Ib66tmal
 2zqvkUT0ogQ==
X-Gm-Gg: ASbGncs/SmsOo8MlWuPAM8OYcv2XTlo2yi1GZyGSQUq0X7xqndedzo/PnGHWCDyOlkv
 Ku1wgkK2BWnT3zGfCSg+xVoL0Y7mqOR1yCrBFuUQyMtGYEgoRR9LPNxhtCqGD7pW3Z5zcJIi7+P
 iP8xYdzn6AGPmABOqedAzgGh73f2Q3yDSFoRCYvRgv0iW81u0+ftTtCrcvniTeQV2eMtyKuZpC9
 g6St2AmFK02uukh7xV2JJEXyObnX8/KGrNukY+enEEntseFo86KgtjYx02RHEr2ZI/ecQ33UeNG
 kyRCaosTzN5MPIGx0IdXgJ0Cw6pGHn1AMPS11L70C27dj9OZuj1HWnIONGGOnwBXycKXPdzsSQe
 ZGzzRAVh9bKQ4y9fWGOHaFiI9g4UWDKmuuOmLwhhLHP0Pwd0VJZWd96C2NeZJtJdg9AwjeEHSTB
 KpxInftlnz0Co4t4EwrE5TGt3HCAVqLfY9/KkNmbQk1+J3h/GFHQ8=
X-Google-Smtp-Source: AGHT+IHdpkZrsYq9UPfpCfkI34MiF1IewJsaLp8UISeJ4Y+QA50eq1rx8GG0PU0WcjQT40ka+raAZQ==
X-Received: by 2002:a17:907:7b9f:b0:b6d:42cb:7fb6 with SMTP id
 a640c23a62f3a-b70708a8b81mr247386566b.60.1761904838386; 
 Fri, 31 Oct 2025 03:00:38 -0700 (PDT)
Received: from [10.240.88.227] (C3239BBB.static.ziggozakelijk.nl.
 [195.35.155.187]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7077c9dc34sm132163966b.55.2025.10.31.03.00.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 03:00:38 -0700 (PDT)
Message-ID: <f30f2246-dec8-43a1-a7bb-cb8fddfdbf2a@linaro.org>
Date: Fri, 31 Oct 2025 11:00:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tests/functional: Mark the MIPS replay tests as flaky
To: qemu-devel@nongnu.org
References: <20251031094118.28440-1-philmd@linaro.org>
 <20251031094118.28440-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251031094118.28440-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x632.google.com
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

On 10/31/25 10:41, Philippe Mathieu-Daudé wrote:
> +    @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/2013")

If you're going to reference this, you might want to re-open it.

r~

