Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2271D4A601
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 06:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgcux-0006Ng-4E; Fri, 16 Jan 2026 01:02:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgcuv-0006K7-Cq
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 01:02:41 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgcut-0008G8-W1
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 01:02:41 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42fb2314eb0so1285727f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 22:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768543358; x=1769148158; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a+5XjihCwRa7pqzSfdJQi7aISOCOGah2+KIPwg9qKPk=;
 b=zv5URtS4aQ3/sEjx6MlYGEljBkouy7wHfJb3X8sdQPmsfRx6zxxr53SuyK7zDFTWVj
 WHcbUG6ELlcUcVhzJqPXfQzfGw8fl8LO1LBRmu75rsxa2Q9OsRkP1eG2iMmBOsKIjvFf
 uCFWhMso4QZImFUy3gqoKwIEe1HfKDPJaAKIRcT8uKkwogQSO1xuHMU84b5ir2RYR5i6
 PlJK9HIWlVKR+z2NXOQpEuFXpRkp6Xb22KbjBVYFYuZepB4zxCh162z28fkVqLUGSrJZ
 L6ePV4Ewsg0jX+yeTADCw6LCMezHBA4Kww8UjlXSPFhXXd2d62ayKg50+yPnwPGzAb8k
 t5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768543358; x=1769148158;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a+5XjihCwRa7pqzSfdJQi7aISOCOGah2+KIPwg9qKPk=;
 b=YECBBO19KY4FtiFlfAJKIEv41FqJFPO3YPI0VtgnjcTPR29aaE7rO7ikmApeXsYowZ
 WsXruKbULZ/qVwEK83ftpir3KSDvMMcJCJjVu2Xf69+5bnxnLRMVFtFFa1hSwDy7dHJa
 k+9ZQbNX1P/KGmDVwP+xux9ZizlQuWe5VqWNZ6VYwdtnHk5Qq9hMkSJRc0T4gzUi3zip
 e4Waau2FrJjZDxYG7jdTnX5wYDciDPgi6+7GUT447trfNU9/SX47Tyd0sYk9dgW7dUfN
 BqWIxhson8JIOE4Ggr6resNljMVqzTulP7eiSX8uPXCNTHgiSLONIptyz9kO97aJtRWl
 pKNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9hp8rYg/jK9NLXuGwHtBnVtXLUsufEze5ggmwjSbNUvFZhXHQBHSuSHFar1JGh38UymAtQ2qLzAwF@nongnu.org
X-Gm-Message-State: AOJu0YyHdfnkxAeWOqvczM8a0XyJF+KeLLsw7iZQdo3yp2TrurAj2B2N
 Jd/LCAJ0N3lX2Ih7p4Sh7KTgdWM1zpocEbfa8DezChcXH+7emrV9jdC+6Jk5KQ3MTjk=
X-Gm-Gg: AY/fxX78eWhHfLcLe0nFzo1wOb5B6/J425Q9lYcwHty/gvEUKWwnD0xaeIjRjkzyZm6
 1PV5GwXakXVMwDyxbYM8CPTrI44F8k6OrXeEz1Fo6b6vondZIDmiNg7S08gMfjN6kfXtg6rr46N
 Id4P1Lzs/zviVlmkfCKYfpFtI5/lox/1S6rSFVhYUUo60vLIdDlrnqR0/UPuZ3KYLaiZO6DDZZH
 2Wft69q0ZVYYiYXf85bA/uYXcoINbYOIKPt0IEda427xQjXaGediIur/gy4BJS0lowtR6vG9KYK
 nGhgyX16p3yjSs2BNKf24u1jR8NhEsCz9Y+DIAx7no6/9hLMktJhxjP711wRpve6LRr/YbCNrAk
 wnBpXbq18FLFafsdFjVGTZpdUFlc+R76EPeaBdEtBDzrkCaxHbpVedm45DsyHGnoAACs7sn98Pm
 sNwaBV2DvFY7xrXSVh8FCkPh9iSrlZi1vWXDDuNIhRc0uHiTitBA4Gdw==
X-Received: by 2002:a05:6000:1861:b0:432:b956:663e with SMTP id
 ffacd0b85a97d-43569bc68e2mr2178216f8f.52.1768543358295; 
 Thu, 15 Jan 2026 22:02:38 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996e2d8sm3088804f8f.28.2026.01.15.22.02.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 22:02:37 -0800 (PST)
Message-ID: <bc76f083-8522-4edf-bd2f-d9954a6ba327@linaro.org>
Date: Fri, 16 Jan 2026 07:02:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/58] meson: Remove cpu == riscv32 tests
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com,
 pierrick.bouvier@linaro.org, thuth@redhat.com, pbonzini@redhat.com
References: <20260116033305.51162-1-richard.henderson@linaro.org>
 <20260116033305.51162-23-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260116033305.51162-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 16/1/26 04:32, Richard Henderson wrote:
> The 32-bit riscv host is no longer supported.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   configure   | 10 +++-------
>   meson.build |  4 +---
>   2 files changed, 4 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

