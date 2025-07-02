Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24484C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWzRt-0006x3-5c; Wed, 02 Jul 2025 11:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWzRo-0006v7-ML
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:32:32 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWzRk-0005Ln-SM
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:32:31 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-73b0efea175so2442315a34.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 08:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751470344; x=1752075144; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZrCMtlLS8n6NH99jPbfdSslL5BC5CrHBtaVXV+mK7N8=;
 b=RcC2M5Ui8mA+PiqPJ2YMxajPMwX83C1O30AEU0Qxu6t17n2H4cMSvTf87vFqxoNvgb
 l5zjk/pRZDesv3yRSSZYrv8+PdqwgK6xyKN2n5Gds4sqE3QmCS15lnDzLV9jBwDNROuB
 A7e6jQC81OKQP5Y5/mzztorzd++9kI/b9thKpdFjeAl98e7OyUHtmaxj1f29pP2gHsch
 dXCPXtKVDtxbLWkD2UUMmqnruMmzEFCTt52hSyBtrDmNl7C0qHMAgWEp96/PzSXyuHo/
 Mz1W6ZEyFW4YaOSnf9v19W3p9KrmeaFk7+RCPwN4mVhb1gwQjymSxI5X0IYzaIahsuHT
 nnzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751470344; x=1752075144;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZrCMtlLS8n6NH99jPbfdSslL5BC5CrHBtaVXV+mK7N8=;
 b=QRozdxJxP0h6SFE4pdA7d8duKdFZksXKYW8VJG44A4H9aSVLWNC7QeyE9jDVFq64ix
 TTLdiQJq9PvWlUJNbmMDmTvI0NMBvQCzniBKNgjA//ZHiuqKQEO4C7lJmEGqmTSs8Q7r
 pVk+cJQwYAGtQVRvgxdywW6kYMFfuyavuymWIzRwG2XW9Cif8/h6A+jVgklRE/+Fx90N
 izbsi7it3P5zzZrc4pMCA8BTe03BceazTstVgR5kw6yvSOHPwvpc6NL5JmETOZYKRqPT
 dmn2b5RB0DCGvla+zGiTBrmPepxoPXKVDP7TtM05aBmRpqRN9LbgWAkNeLEwJ2dcNrAJ
 XR4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwsZcPwGKQuvfg4NAZWmNlFN1RFEauaa5A8dbuYAiPs1yB4tHeGJa9iOtub9vsyrcfeBPdpZS70iOk@nongnu.org
X-Gm-Message-State: AOJu0Yzy0mHJno7e7S/ILcnyF/DdpFJbc2zPAPT3LuVP/tvnLpgl4JD8
 yPftgls3t2hW9Dn3Ud8zEuq7CQuRNdUGllctCqGkYHqi4m5KxDdnc1OZrBIHXS8dAPnX7WMwyEQ
 yY9PVPMk=
X-Gm-Gg: ASbGnctzWs06DBeu2U4u41cuUC7fP1uM4qsrwgeEPcc9/Ah/rJmYo8SVV0cV3Gwh8jz
 HWerreGSXH9jJQGWmHDM/fQxlWfRb/lS2HMfFMyy9pRc4MOsMGJvLfN1Y3wvpEs7PcoA57YrFru
 V0opeT5SyPuHIdCsIw1ohkVqMWNp17JIDHkYuaG8iaHEri11MFKa+yH+7o94WQr+xXq1D0CrcZE
 SJZdCZvJnTKrzUcDsqXwqKMBuWteMIZlVqx6e8MEEz+YF3oso3yUNFvw4b93Ro11POIp/U95YlW
 BZDG18SCBvwOaknNpkwDwEGk5uOaujRLfn6yOf4pBVq/vEHrQpW7wPkF2Vht6ZBtV778ayPsyj1
 u
X-Google-Smtp-Source: AGHT+IGAg5b6gP/BwiMdpX75A5yZ8/+6Acix9jUGQl4pDgN4yVYzDcNC4ykxHwwnW7Sf6xbyzyy8lw==
X-Received: by 2002:a05:6830:2113:b0:735:b4ef:acb3 with SMTP id
 46e09a7af769-73b4ca1ee25mr2578286a34.10.1751470344287; 
 Wed, 02 Jul 2025 08:32:24 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afaff296esm2529078a34.12.2025.07.02.08.32.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 08:32:23 -0700 (PDT)
Message-ID: <67bc51ea-a772-4cb9-940c-6ec3a0baae2a@linaro.org>
Date: Wed, 2 Jul 2025 09:32:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 66/68] accel/system: Pass old/new interrupt mask to
 handle_interrupt() handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-67-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701144017.43487-67-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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

On 7/1/25 08:40, Philippe Mathieu-Daudé wrote:
> Update CPUState::interrupt_request once in cpu_interrupt().
> Pass the old and new masks along.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/tcg-accel-ops-icount.h |  2 +-
>   accel/tcg/tcg-accel-ops.h        |  2 +-
>   include/system/accel-ops.h       |  2 +-
>   accel/tcg/tcg-accel-ops-icount.c |  8 +++-----
>   accel/tcg/tcg-accel-ops.c        |  4 +---
>   system/cpus.c                    | 12 +++++++-----
>   6 files changed, 14 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


