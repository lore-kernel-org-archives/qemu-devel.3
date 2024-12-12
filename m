Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38DAE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 19:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLpIX-0006du-8z; Thu, 12 Dec 2024 14:56:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLpIU-0006dm-Ib
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 14:56:30 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLpIT-0005RH-15
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 14:56:30 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7265c18d79bso1152644b3a.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 11:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734033385; x=1734638185; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=z4tnqRbK1UsN3rQRBVeIU5TGgYpJcQ5zEWroekWczvo=;
 b=u+v+yGwD3cSeR+EXDDEySE8ZWtVVYnXjPdIZgDI77SnRmNBLqc64TYwZ4e6y4J3tXj
 ZPUQuBCqc6pbyKgumiEyqDHjcYCy4Nj4ij0z0fZiP7XTCgDQHYXHQmROKG+m3MYyPx0d
 BPV0i2SKVMWfcXWggqj2+KoHBwNYJqzLapPMcT2yNnF54Dj8jvdW/SzrkUWHtW5dT4SR
 BLBg/P++60ucPnvOmGryWFiQji40pkOAaGmJWuHcTaBKECvXixQ2n460DfVkkhyWqRbS
 SBPQOiCvcQaB17hV3sws7xUQqJeFp1rqAyNkhDc4sLeqzKX2EXwdrU5nZBY2J/2lFKd9
 TcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734033385; x=1734638185;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z4tnqRbK1UsN3rQRBVeIU5TGgYpJcQ5zEWroekWczvo=;
 b=T/jaDJGllgULWgrYiCide+m1qPusTn0Kmg3xSj1xWoQvzd9QpOMXumMQCCoI0cZZEl
 JSYqfRr6bs4BP3weTgd7a18w0JGyN07rZsnqBe8SqPflz1AUfqojNACWnA3lbtv53m9k
 aFvFlAsf0V4iIwEEMaQSUST7sfd1xLLCPb1cSEma8m3Cp5SJBfZ6dwXdeCuxFE952QEW
 ch6oGR5ZLCDFIK/TK5RjztUnz+UaThasGmf2YCy7isclYvG8Ft35JH/w9UlR6JI5Mqfa
 neEIdgKu+we3mAF08ia0VzbB2iJqO1Jq7il0IdV6r5vDoorB6ynbJw84blqz4xXgEyPT
 cQhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6sK8kj+zsl0ZFv0HzH6QN1ggNSU1V0KQtoRSpt7ZTr+99wwa3A+0Al2OIdF3AWf1dI4jsltIb/7Ai@nongnu.org
X-Gm-Message-State: AOJu0YzYrbPZIb94cYA9d5qDjovdEGKW3XquHR8WG6Pc5/12VWADUHY7
 PUHbN9gGX2SLROYBZlA3EgxWGwy0EFl0arrShPFNAx97oWW6+tXB/ufjbYltmMk=
X-Gm-Gg: ASbGncsgHhHQK2x5HyUSqSjKepy2CMdQYpW2PUeo1VpZzutT813D3wA0FtCns/VwWMS
 nr6dFZZb9RfNzO18CygrgsImKxBXrLBefkg3yRsI62Xj5JDoigiCk+yOmVLhkYP4rHf6eAy+Ny3
 d+kSVjCGCI8CDE4cQy9W5oyjWnG4ibKcNr/zS0d3MOngAIi8jfVfje1/hM5d1Mp0oSnyDooaDI5
 NPK4jqBXWcq/IJR9cjv1koZvphRpN//CMBFiw53HryXsC3WhKgpmM3R3gdqmI6JZ2o6W+Fesg==
X-Google-Smtp-Source: AGHT+IHwgVJnKHTWt+zQPvhYi6EXJkRLND4cMebxS8cdiNsexK/RQuNfoHcrnfLPwjIO4EI69e1QbA==
X-Received: by 2002:a05:6a00:ccb:b0:729:597:4fb2 with SMTP id
 d2e1a72fcca58-729068160d7mr2552055b3a.0.1734033385718; 
 Thu, 12 Dec 2024 11:56:25 -0800 (PST)
Received: from [172.20.4.119] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725c7cba42fsm10927299b3a.123.2024.12.12.11.56.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 11:56:25 -0800 (PST)
Message-ID: <57e8f25a-951a-401a-8d8d-c69eeec60321@linaro.org>
Date: Thu, 12 Dec 2024 13:56:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/18] accel/tcg: Move 'exec/translate-all.h' ->
 'tb-internal.h'
From: Richard Henderson <richard.henderson@linaro.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
 <20241212185341.2857-9-philmd@linaro.org>
 <925369cc-aa5b-438e-bbf6-c9692251af59@linaro.org>
Content-Language: en-US
In-Reply-To: <925369cc-aa5b-438e-bbf6-c9692251af59@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 12/12/24 13:54, Richard Henderson wrote:
> On 12/12/24 12:53, Philippe Mathieu-Daudé wrote:
>> "exec/translate-all.h" is only useful to TCG accelerator,
>> so move it to accel/tcg/, after renaming it 'tb-internal.h'.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   accel/tcg/internal-target.h  |  2 +-
>>   accel/tcg/tb-internal.h      | 14 ++++++++++++++
>>   include/exec/translate-all.h | 28 ----------------------------
>>   accel/tcg/cputlb.c           |  2 +-
>>   accel/tcg/tb-maint.c         |  2 +-
>>   accel/tcg/translate-all.c    |  2 +-
>>   accel/tcg/user-exec.c        |  1 +
>>   accel/tcg/watchpoint.c       |  2 +-
>>   8 files changed, 20 insertions(+), 33 deletions(-)
>>   create mode 100644 accel/tcg/tb-internal.h
>>   delete mode 100644 include/exec/translate-all.h
> 
> Move it into accel/tcg/internal-common.h rather than create a new header.

Hmm. Nevermind, I should have read to the end.

r~

