Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E97C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 08:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFTtM-0001B4-9b; Thu, 15 May 2025 04:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uFTt7-0000eC-Ty
 for qemu-devel@nongnu.org; Thu, 15 May 2025 04:24:26 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uFTt3-00037t-Ox
 for qemu-devel@nongnu.org; Thu, 15 May 2025 04:24:20 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-442e9c00bf4so4658875e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 01:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747297454; x=1747902254; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5IAW0PFIDOtiezZIXpSkH44py7GX9CW6xcPzLnISuQE=;
 b=feUJp0cITNY2cJtqWxMQNNT0r2trFAtG9hAlILSFWSdETMKPWYbAB+42umiNGBYhTG
 h5sGDVFakSWjdWBCUXRk7JYyKNviWLYw9NfcgtNGkQV8Q82fgEC27cS3tJh/lzWpa63z
 4w7+gZGay6/rGJfI3K6mEX/2Mz7BxIrVd1VKWbJcyhWrmQqOoEK/H9k5RlKuz+gVsaox
 cFr6MWAYrrLWgV/a69wc8c8KzPZUc77lPxbVaYN3gb2i077/1BBS2j9EQrYJz7DIXwUH
 zX9StukxunvqyEUYY20aMCZFr784rqIi/kPUwyiYzUFb0/zAlqTH7qa+8yJIOQ2gX4uw
 z1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747297454; x=1747902254;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5IAW0PFIDOtiezZIXpSkH44py7GX9CW6xcPzLnISuQE=;
 b=tIYP7i3SFm+gnhtSWbEaEMd61sUisnHp5Q4WJHt/RBwqfPAcQ04eH7qwmV9YsYUCFW
 TWkNA03LobjbHHFMz7WGYkXtUeYjzGN7fE9E1VTe5iUfgiZakT84D+f/Ooxaoni4pLmo
 37/WpNUOQPRuSVnNOU2rikXfiRP3AhB+V4aJY83fxi7kAYfKUis1dO5ryHKVqlUKjdFI
 cW3XGRO5cjDGlXbPGxiZjV7D9xPeL/lOhynwRaxS9zD/IMVFoDlM/YQstd+DtDdB+9Rm
 QAJYaAn63JHTg6sKMH7N2vcv+dZEZ6P/2O2LF5/XMgn4MN26Oo+wdKT7nBS1FKu9F4tY
 QVFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwXRgOUxEDyo+LhiiMUQQt2IkEIF4r++I0qlnRf8dupyBCttiwMSBf2tFgZTe7doX8ZKupjSzTETFY@nongnu.org
X-Gm-Message-State: AOJu0Yx2Hyip/Vtdc9mGBMPolnTPmWpiXT3kmJZuKvlxurErOzjjGPwG
 UkyGVAOv7c29f+GN4U0kRGuE/mO/yb3f+CHMpDIWx/6uIAFYOFSSvZlMDa2E5ys=
X-Gm-Gg: ASbGncuUNOtbXrojMbxK14v5jVq6V/GhpdQULi8ra08GMRaBhW7wYt2SGDkRrP00c5l
 +rh19x9vZQ6O35AoUvLaqd9WOzZIdI9GnpuuGAwnkcqlewavzOH34p8ZiOrmlBSWwVOzozhHyo0
 6M1mtiT+FxsZYx9lBHCdXjwd2djlgFr2q6OyMEpzCF7bK0OOmXbM2uPqi0sqSBddHrpqT1Kd0SZ
 F+Rck0WH4rpIQV6kjrWxQKLNew3qMnpzUh4Oj5OYHSW1nE+ej8XgPlEXzyoHVefGr1G1Fp4KSI0
 AahMUyZsPhAByO/nBzzKc4fcQVp/buM6qTddgV/msqcp0416+bJxyHeWPaLlb2D/R3AKc88H3ko
 AJP3cxg75BPynevU=
X-Google-Smtp-Source: AGHT+IFwHp0/ejzupOmGQm2OjYjZiyapJCG+oNefOLBeewE3j7JKtmqynkcQVP0WCp3u/PG/Z3bA8Q==
X-Received: by 2002:a05:600c:540f:b0:43c:f513:958a with SMTP id
 5b1f17b1804b1-442f96e9baamr13756635e9.13.1747297454566; 
 Thu, 15 May 2025 01:24:14 -0700 (PDT)
Received: from [10.61.1.10] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f39ef87asm57968375e9.36.2025.05.15.01.24.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 01:24:14 -0700 (PDT)
Message-ID: <176d584d-386e-4c27-ad2d-57838f599016@linaro.org>
Date: Thu, 15 May 2025 09:24:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] qapi: make most CPU commands unconditionally
 available
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, peter.maydell@linaro.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250514234108.3746675-1-pierrick.bouvier@linaro.org>
 <20250514234108.3746675-10-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250514234108.3746675-10-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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

On 5/15/25 00:41, Pierrick Bouvier wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 476dcb46683..c2a6e6d1c1c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1927,7 +1927,6 @@ F: hw/core/numa.c
>   F: hw/cpu/cluster.c
>   F: qapi/machine.json
>   F: qapi/machine-common.json
> -F: qapi/machine-target.json
>   F: include/hw/boards.h
>   F: include/hw/core/cpu.h
>   F: include/hw/cpu/cluster.h

This hunk should be in patch 7.

r~

