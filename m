Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C60C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 23:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSmEU-00007B-9K; Wed, 24 Jan 2024 18:00:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSmEO-00005k-Bn
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:00:28 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSmEM-0005js-DM
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:00:28 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d73066880eso38267475ad.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 15:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706137224; x=1706742024; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yGvWD4EsJlOZxmCltkddz3e6uGuCuwQSjOUv+6C6CxQ=;
 b=hGqrM3bd2umfXP6TtUJjBe9v4ERamA5OCfa99OwGhoIBuwe6iZS1BzKuckQawjfB3R
 0hyMBSWMvvoeQFlq0TOWBxKFAPJttMk6paXZg0ZUN8uiI9GeF8ILcsqpZCLCrxeokjrW
 u8CYzzyPwtpNGl4pVmgdo5FMwCZOXT+7sErr+dITD8hw1gR88vMSTkBFTr6FK7DjDJJa
 0+k8gWcQN+sblgNBd1bv6cIhSqiCPOMqDrdDlHl3uvIY+9dyraA57Mjk3NbcIxmHizcA
 dvy/MoeJ/IiiD1rojlvqTkJl92GaLa8nHG74TwaWfwjdcyGoVj9O9RqzDk3yHDmd7Mpx
 Affg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706137224; x=1706742024;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yGvWD4EsJlOZxmCltkddz3e6uGuCuwQSjOUv+6C6CxQ=;
 b=RXXDDggaopJNx1HJpVw1xBzzd0y6ofx5hCdlqKsQ615tmozFslzWlehUmx7Tx6Gn1H
 wC69GjLXijvGgKbIWqGl9L0r7hNfIIvf7Z7qYH1u8zcp1y+joF6C1VwjQAhsoiatDSSB
 0ckB5kFMfbWd7Ux22CCU3KalQ/QgMQcZwxMCd8oKyCyC/DJHWavKq4bmzY9FUYHonAyY
 jjbdWON8iBYyEfqCqsWz/67AAgSteOvweRFT4GyhAc5lM9IOnB8j340vhEODxMgMfFjJ
 LWwcFt5on2wf9y3ltgQ/FVMYhv5MACjdnvGtOa7u6sdZFaYihpMNK+YcYyP9QQWcaaP+
 Y3Bw==
X-Gm-Message-State: AOJu0YyNa0VGQN/UonNvA+GCj0fN0OdqrhZ8PDEbbvfM64d5yjzN3F/C
 jpGDJEiVAXG8/fp3omW4lJkVFzt4YRUZmLed21djvR+6NZDnIRhgFxqi3EaCB8k=
X-Google-Smtp-Source: AGHT+IGic0Duu4lvTh/abAL649bwGfT5YrgZa+5/ZjuQenMKYOGqa44jOM00aID7DRlsSx6OWKWPQg==
X-Received: by 2002:a17:90b:19d0:b0:28d:4bdb:941b with SMTP id
 nm16-20020a17090b19d000b0028d4bdb941bmr73483pjb.32.1706137223513; 
 Wed, 24 Jan 2024 15:00:23 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:5fcf:9e3:2e58:9c7?
 (2001-44b8-2176-c800-5fcf-09e3-2e58-09c7.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:5fcf:9e3:2e58:9c7])
 by smtp.gmail.com with ESMTPSA id
 r5-20020a17090ad40500b00290cfffee0asm176910pju.1.2024.01.24.15.00.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 15:00:22 -0800 (PST)
Message-ID: <974cc1e5-b656-406a-a014-cc23ba78b4b8@linaro.org>
Date: Thu, 25 Jan 2024 09:00:19 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] accel/tcg: Introduce
 TCGCPUOps::need_replay_interrupt() handler
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Claudio Fontana <cfontana@suse.de>
References: <20240124101639.30056-1-philmd@linaro.org>
 <20240124101639.30056-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240124101639.30056-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/24 20:16, Philippe Mathieu-Daudé wrote:
> In order to make accel/tcg/ target agnostic,
> introduce the need_replay_interrupt() handler.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/core/tcg-cpu-ops.h | 5 +++++
>   accel/tcg/cpu-exec.c          | 5 ++++-
>   2 files changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

