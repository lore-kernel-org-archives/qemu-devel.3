Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496A0C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 18:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uACN3-0007Ov-Mw; Wed, 30 Apr 2025 14:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uACMs-0007NT-1Z
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:41:14 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uACMm-0007ZI-I6
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:41:12 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7fd35b301bdso230448a12.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 11:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746038465; x=1746643265; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mzSKvNAqsUnH5ctO4BhCeoMH5BT8Wk4EgybesA/rLfc=;
 b=l32jAnuJQTmLDpV100BhHggCoicwWDYCR74KG3ArN76CYnCg30SG77t9NrCCjyHQOA
 9rVwzJBDf/rHMW5NGSFRT1KP7lmVAJVaB7/I9NisPqDCKqpSoadnuoNyjJ14yBQ6riX/
 t1qwbgoKF6aEZGPHNi5TxTg6jkJHdWw+xsPgSFIPFmFkSN2yCLeYxx4t6/1SgUBMAzwH
 6JGPTFWMtVsxWjdXppL2+V1/cyW0zkTw3GvTmPvQc/mCWAoOzg25EZfpSMAWLAiPY4ey
 Voz7NNXpwTHBd6oGeJ5/R5hzrW0sbhPFHyGx7yDoLTk98LEBfYuEe7tiKKljWqXfVpcH
 Bulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746038465; x=1746643265;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mzSKvNAqsUnH5ctO4BhCeoMH5BT8Wk4EgybesA/rLfc=;
 b=VjvoHD+bHylGaqBDCRC5mzRwvmN/8Gyp4lMUsyl+8GYi51pXvIRQ57/pn0RVI28cMw
 Jaeeopjazcrcxx1HPIpNtHccmhvugrfv98sMzA+dH0G1N/IVPiheiqeJIHmlLuqFOcRs
 cQj84brJyaKDvvTzSM5yytt2PMNyWCA14bQqSWISlKNTS0l/eIQgvAnzCNrJdc1B+0qN
 ViOYUCBgTken2l1M4FAU/TekCLXGQF68HO84r3BQOSIXLKbqVAC5pz8wovSE3+APMoqx
 g9LKBGmMvnYRbDM3eXILQMCm17IApmZP/rvyA58ISihNkViWjPUkoIa2dIcYA5idfLX7
 QdKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9V4Il3tC55Xqjc+C55xMu4cSwxIX5bCfTE1EvVfzGR/gyz/LnLfUGyUKm6KY/iBjXXpX4iwkoTB1p@nongnu.org
X-Gm-Message-State: AOJu0YwV6ddYttiTT4CfbIqPtUKmbC7+84w1dMn/evsv7i6uvs97Sn3T
 GSH4XNJJU3n5JcL76x5cZ/fZsuCPFqpWjhcAnPjaVREhRKdSymW72B6OoVyguD0=
X-Gm-Gg: ASbGncueVnT+jjy3PgEWeTQ8bGByAdprMo/U6X2Y/iKZDi1rlv5ID5d80J56AJv/lYu
 aOUjJry0pc90ojV/yj7YTmhXXXr+v7enl4NGBT5P61KFlxVn2ALGtPs9cQTqhh5L8lLKzOfUEXI
 eLAnvPyD3wCTr0mCxTHw1Vy8Rlu6ZtdwODBQ/z+2Wh0EGEOzxa1XYhCzz++MjeWZ6LNQ8g1xOba
 MmFkb3LLMClD2G4jd+v9cv6z7Ql+pJyZD2Sxn6PbpEbP5StqZqYfPwwLCd6WzvmOJ+GDtV3lHSr
 wVhvPUO9y8dzogInjU3fXjgyuqcBr30g0CSDv7Eq6cQmK1fA3lKBdKAjEWkK8cMDpWKrZMUSN8a
 q8wFm/wo=
X-Google-Smtp-Source: AGHT+IHkVhvhoqpOiueBFVAVKu1bI6pPByHvnXhSTgpQBKrZ/5Kcp+BpBsGGNCJZP+3+hpNcQ9Z3wQ==
X-Received: by 2002:a05:6a20:c704:b0:1f5:790c:94a with SMTP id
 adf61e73a8af0-20aa30d3d00mr6118919637.25.1746038465521; 
 Wed, 30 Apr 2025 11:41:05 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740399415bcsm2026012b3a.73.2025.04.30.11.41.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 11:41:05 -0700 (PDT)
Message-ID: <9e612606-c7ba-4f81-bbff-9653aca9742c@linaro.org>
Date: Wed, 30 Apr 2025 11:41:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] target/arm/cpu: move arm_cpu_kvm_set_irq to kvm.c
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, anjo@rev.ng
References: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
 <20250430145838.1790471-7-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250430145838.1790471-7-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/30/25 07:58, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/kvm_arm.h  |  2 ++
>   target/arm/cpu.c      | 31 -------------------------------
>   target/arm/kvm-stub.c |  5 +++++
>   target/arm/kvm.c      | 29 +++++++++++++++++++++++++++++
>   4 files changed, 36 insertions(+), 31 deletions(-)

Nice.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

