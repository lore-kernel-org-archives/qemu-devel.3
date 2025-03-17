Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4F5C35FF3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 15:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuCXM-0000d5-QK; Mon, 17 Mar 2025 11:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuCXK-0000cV-8M
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:37:54 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuCXI-0005m2-BZ
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:37:53 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5497e7bf2e0so5358704e87.3
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 08:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742225870; x=1742830670; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LXemVvvfchk5QEIj7ECTgKr8v53oqc8w4tDIBZfOENc=;
 b=ViMR08e+5EBM5cy9aSyWQiYUmYD52p2WMvbQYIcBfzSSvFRTTsKBthXGMqMM80PX2/
 6ZiQka/zKlvuKLIa+Ia51hn50NQS7f3pu7Dq2MXi50K3Vn5jwB7hRzqQ1ZfFFbZGQWKv
 6g8cax7kVHwliCf9UC3YdIfAYHID7gKH3BJSfecPBB4YSnpEgcGZvWMgndNE9S2WTrQK
 jgEppq0wJv2LWUZOQbuQIlu/YOoQp01c+M5G1wihVnNpQPI15BUuF4nTGBuCOMhtaZMM
 n61IlpqtqRWPEmkDWvn4ElvpY+bzY5KBVzb2VzY3nleO/5e303BZYgvzycmxmNEHtA0T
 JSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742225870; x=1742830670;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LXemVvvfchk5QEIj7ECTgKr8v53oqc8w4tDIBZfOENc=;
 b=GhvNsXOEkmGDRhK9IIV280IphSiDZqe4ITBdDpbrdfxl596GYEUu7lHHQFgp3yrRh1
 lUflE8VJi+QZjQ1HaRDEnf3FTYof9y5FNo0bUPAY4F+CHYTEjDlp9BgwUwnhizGmV0z7
 eZcBTVG73n2ZCh++tI1Bxg+TCwHQu7Vd3xCwG6jF67JJ7EBGAJ/E5kD9svIhrNE3JpH7
 GOIge5DBDmOB0PmDH70/r/NFAysw6n3zmnvPcMtJNvp90Dze92zktRPjC23ks6ahnxiL
 kDVTgEW/H5Vu8QjF8zCpFkWkqQBHiLY8bCxGuw3AQ1XW46ND6nzKSOCZp0hjuVDD56mS
 vtYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+L9FAvFZGTFk75m8QaXyfTbXRNG5Q2M8krfZGqb/RO9n5YB0qggiyc3tK6fbm0l4404dYPZAfOE8T@nongnu.org
X-Gm-Message-State: AOJu0YxlNm41ZgFHvPLIQTSfbvi+umFhe/cPBuaXHBnje0Wg56611MdG
 hpTDEcBRo/+ZMbwIPRVvCQ/DwZzecoH5Wbyizej2Zdk3MERqehmLcT5QcaSmXUA=
X-Gm-Gg: ASbGncslkWoCCS/Lsf2shNN9pvKrsXE2dvcTuu1cyoh3TV4FB0DaMsCX2GhehZBy6ht
 tcd+Aqem4n8LHNZxICw5o2bpr7j+SusM5jCTqiMmeEBbPCADdYeX/GT/HsZAf5hcCB5twKxPt/o
 lx0o3yYidM7nIzh0CXxZNHciiJxJiD5e7y2BGZf1lvHU6UTtuW8zZCALOTqfDHIwL0eY7ZF+5Dt
 pbBF+Has9g5IsyNv0PovfxjukSF5eWLqetUY5eErK0RCg0GgmgkgatDv47Ewb1Wdfijr5Bch/4h
 Ppup5+munKRTEkuLOsEM8cCP9O0+DLGjqb+18MFKGkghjM+LzY7KeTxLXFctOb6KICvDg7o6E9k
 b7ZzXgJkQpQ==
X-Google-Smtp-Source: AGHT+IFAkhDY94D7VrVtFRU2y+ZJw+f8EM/Z2DTo8J3XlNWsTGicUPipA71AEt9tQaYajlxZo/zOqQ==
X-Received: by 2002:a05:6512:ba3:b0:549:59d2:9ac0 with SMTP id
 2adb3069b0e04-54a03d0293dmr265185e87.47.1742225870087; 
 Mon, 17 Mar 2025 08:37:50 -0700 (PDT)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-549ba7c07b0sm1338592e87.79.2025.03.17.08.37.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 08:37:49 -0700 (PDT)
Message-ID: <329771e4-e9b7-46a6-b49e-497033857a31@linaro.org>
Date: Mon, 17 Mar 2025 16:37:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 7/9] target/arm: Move aarch64 CPU property code
 to TYPE_ARM_CPU
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250317142819.900029-1-peter.maydell@linaro.org>
 <20250317142819.900029-8-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250317142819.900029-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

On 17/3/25 15:28, Peter Maydell wrote:
> The only thing we have left in the TYPE_AARCH64_CPU class that makes
> it different to TYPE_ARM_CPU is that we register the handling of the
> "aarch64" property there.
> 
> Move the handling of this property to the base class, where we make
> it a property of the object rather than of the class, and add it
> to the CPU if it has the ARM_FEATURE_AARCH64 property present at
> init.  This is in line with how we handle other Arm CPU properties,
> and should not change which CPUs it's visible for.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu.c   | 36 ++++++++++++++++++++++++++++++++++++
>   target/arm/cpu64.c | 33 ---------------------------------
>   2 files changed, 36 insertions(+), 33 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


