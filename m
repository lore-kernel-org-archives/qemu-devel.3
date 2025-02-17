Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875DFC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 14:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk26P-0003Uu-Ti; Mon, 17 Feb 2025 09:28:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tk26N-0003UI-Kf
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:28:03 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tk26L-0001d8-Qo
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:28:03 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38f3913569fso970818f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 06:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739802480; x=1740407280; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nYfrGSIDxdchE3ANH3gk9IIefX1mYNMdAm4HKnvo4cw=;
 b=ONLEebNI6LlY49FikmjsMvkQcjdC8uKVRgRsrcCg8gbUwujrPloO3JACSe/msf1k0A
 c3qTYkIsx44r7rq4tprZJAE6zDqkUROCTwO0AJzGqjDm6Cob1Dqhv5X0rsbWTuqPRtXN
 +SwDvNxFnWLY+fRhqq2LHo8rKOYSOzMs46MtaLIV5s5ErFxJhe7oaspZ9agI5MCBd2Jc
 DsJV+nc73vpZVeeiUcUjNrwXiQhsmf5x4kaHLk4j4KCOm6kOHtct3NNEtesyWZQFsZ3p
 Af8MiahKomumkUL9JfqD+JtI5Cpz/2e89Z12BBuEXfxi+SWv0JFIYLeHMs0vGWtYqu9r
 HBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739802480; x=1740407280;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nYfrGSIDxdchE3ANH3gk9IIefX1mYNMdAm4HKnvo4cw=;
 b=ATP8nhTTRvlmEt/QcuPLmC7quxudHO6iVfYgEl1Z7GbkpKgNWmp2sInSucjk7J9kjg
 0g7zwN6pOdwlEk7jKewRZTTjwtLDoppX7eL/CmRPUpeQtGJ9xt1kE7WhyT7tM/F+TZKD
 8/gjOZsboxIxvQg1GKF/7iYLPXzOs+2Lc0+KSKevaL595aJksWPxp+e9PAYC8S5JUn/O
 LngcDB/eHqOS/aWgV7gOTN/FmhGP+6pqCAFC1mV49kTJQtx3FNiDz8tnbk4iCx12T2Lk
 KLHOfYDtWJHM7tzXoMvAkE6SE/HYVhHFTvdCjuGkPFAZnFRBRfgYhzdfz3wOu6X2tMi0
 J9kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+kYN/kD/JQTaVMaB6GB272DubBHZ895dW2PhLRUBgXTuEKo4gEhx41lP6jbBCR9QmHgSyfqqy97Ns@nongnu.org
X-Gm-Message-State: AOJu0YyrDKBnofet4dcoR3VbYj9svC3xS4cqNG/SVcnPRdh1AK3jHS2+
 PDmyx+KE5x193QLkNO6fEgQ0FFgZrArzgcvQ15CZVrKwyR3h3THwa4pCzeJ9+wQ=
X-Gm-Gg: ASbGncsIGNt9/S8sU1yfsRKCsv12e6EwRtJvD5K5MXdSGm9t7PaS7RJhK3tE9c+ATWu
 cdbQ7H/2MV9zk3AcRTvfzlOMSYURb5rXyTw/jtLGgk0UVN6bJzduYqeQ7BeqYEI33ygpvIwzs32
 rXTnm+HKe1nZ92Sxe/XyL1672juZKFLOm2j/SbJ08XYdT6/mTxjTJT+LZkO8wx6WExhWyotloT0
 gAeTJsIvwEy2lhBAUy/CuAZksNTJm2EHtvE/upcyC9n3GPpTrGB0SWoTjySEANRzIScS94QROHo
 iko9xDNgCY8UiJbsrMcVsqe7GbOWy86HFsU=
X-Google-Smtp-Source: AGHT+IGt2az7ERmV+OxHYS82tkIzi6q/Gx8/VzaBUY/nnFl+Hz8P9Kdj7Os8rNAZluuc8+84e2gGcg==
X-Received: by 2002:a5d:64e6:0:b0:38d:e3da:8b4f with SMTP id
 ffacd0b85a97d-38f3398735amr9744788f8f.0.1739802480191; 
 Mon, 17 Feb 2025 06:28:00 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f25913f5asm12570331f8f.52.2025.02.17.06.27.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 06:27:59 -0800 (PST)
Message-ID: <1acf5b50-cce6-4750-abe7-9283436f8439@linaro.org>
Date: Mon, 17 Feb 2025 15:27:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 01/24] tcg: Remove last traces of
 TCG_TARGET_NEED_POOL_LABELS
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216000109.2606518-1-richard.henderson@linaro.org>
 <20250216000109.2606518-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216000109.2606518-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 16/2/25 01:00, Richard Henderson wrote:
> These should have been removed with the rest.  There are
> a couple of hosts which can emit guest_base into the
> constant pool: aarch64, mips64, ppc64, riscv64.
> 
> Fixes: a417ef835058 ("tcg: Remove TCG_TARGET_NEED_LDST_LABELS and TCG_TARGET_NEED_POOL_LABELS")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tci/tcg-target.h | 1 -
>   tcg/tcg.c            | 4 ----
>   2 files changed, 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


