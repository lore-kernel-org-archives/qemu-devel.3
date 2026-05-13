Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF9ACD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 05:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN2T0-0005xr-Lu; Wed, 13 May 2026 01:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN2Sx-0005xA-7T
 for qemu-devel@nongnu.org; Wed, 13 May 2026 01:49:08 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN2Sv-0001i3-Kp
 for qemu-devel@nongnu.org; Wed, 13 May 2026 01:49:06 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4526a8170ceso3449862f8f.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 22:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778651344; x=1779256144; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T7U3dnYliEnZ0hswGaO8WeaviWRFQ1mtvI2QHV6jPTc=;
 b=f+D2cUgNbSs6Rc2dUQKbWe0wg5Vp5GOgKvqQ7PxfVJLqnmg6leg0ojrt0dhsjCijBI
 XIpfbybvPg7WA8qT485EJUByHEZPXWm04BJt5u3seG1HyD/hdOYH3ABVlUOF+JPX8jVI
 lr1boNNj+wApKmQI+I6kcY455mDv+mYqgcmc8Zqi5pFIaAICOAxlNA1ETCO7D2GzwWyk
 rvGGF3oj53xWXXyRchZhp/U3545OpjjweFcK52rGpjparlVN0VBqCdQDG1jzHzX+mVGj
 dCH4KGyFRCNQp5EKPoUvtgpQuQPE4OsggI56A9KBPwOhJ3VBRN1od3H2JtU2vlm05MAD
 lWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778651344; x=1779256144;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T7U3dnYliEnZ0hswGaO8WeaviWRFQ1mtvI2QHV6jPTc=;
 b=fXlCTGQ8kWS5y/sQvqTHNoTomT+5AYXAwmykhBFzUiGsAzdv43m1OSURFENbiXTRKU
 hd/LesiPYAccnVv6p32OyDYsQSqkJrmtl6N8t9384vP+TrgKFsoqiGCMBQXLe9sTLhMx
 C74HgyPb/fFwxlf6dhSa0URusj1YSmmzgoFUEsxdp9OkdXTcHpDXCISMKkmGFcghxphI
 6vGV3ypIQWbK9diDTFRi+2qv5SVdWCd7DaMUOsDA8UGSC1x864qiAfzuskh4DC4/wyQE
 PKOWFHoJNU/aEYni3VYRMGqIR5ELo3AHtJqgUj6rLw0ZB3zxyHQXt8sHZSOUZomf76qt
 BdNg==
X-Forwarded-Encrypted: i=1;
 AFNElJ96SkDUBBSqL1L557bcnFcLzawBTmypAhwFs1xGZW5hmfKxSKcUg7zmtmlkxMTfIY4HJvac8m5C6Fdq@nongnu.org
X-Gm-Message-State: AOJu0Yy4UeU6iYBSfogexOmHBWLqGjcs6HpuF7esayhtOeYMIihnoCe9
 HvLXN1YZgCrjx1qg9TbH/gar8KM13908ZaOiUFzUOsoObfUKXhtFIx/d5/T2IC0qIQE=
X-Gm-Gg: Acq92OHqmEzOvIYn9FWmp80ARdQ/1S7nVbGzioCdmDgL5qa3+OFph/7xOx9iQ+kD1en
 uZfNDaN+GuibXGnXA+5qyfNtvSBnlCH4rRY259ZJDlnpuugLKsW+pZX9ZqU0bf0dFK0nGYy3UjK
 3qJSx7j93uyzYQ3inlllx0hiExkw0FO9BDv9bLkv5ieJHnfIdG8LKCegMiIHRXB1fGYgmDi84LD
 iSPNrR1XB04125RTPlKZlRQmNSf2c8G5WvLIFixx04mBq6h303pEYZMMaxlG17g2Ft7nSfvKL2o
 yDCcQXGOqaIxl41zE5hWEMCVZcGsDWuA7bYFXj5V8N7VhRjynveSciAsXXOND02WeyOb0nRILQk
 vTFD9wOnQlgUDZLQ3NSGJcVO8PQ3jMwE7s70FpvwwjN6LCqyltu+uhIZGlHHDVb9xoXJiEoHF8Q
 5LLAX/Ec635atcIiLg5YF1auaN86lsFaVfaE3QlrmSzED04Ybj2lA90Q3hGweHg7umfg==
X-Received: by 2002:a05:6000:2903:b0:452:87de:d3a6 with SMTP id
 ffacd0b85a97d-45c5970318fmr2497753f8f.33.1778651344032; 
 Tue, 12 May 2026 22:49:04 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e6a66bfsm33363837f8f.4.2026.05.12.22.49.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 22:49:03 -0700 (PDT)
Message-ID: <3a73fb90-ad00-468d-adc2-a01dec9f8ff6@linaro.org>
Date: Wed, 13 May 2026 07:49:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] hw/dma/omap_dma: Drop model argument to
 omap_dma_init()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260512203414.3633237-1-peter.maydell@linaro.org>
 <20260512203414.3633237-13-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260512203414.3633237-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 12/5/26 22:34, Peter Maydell wrote:
> The model argument to omap_dma_init() is always omap_dma_3_1, and all
> we do with it now is assert this; drop the argument and the enum.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/omap1.c        |  2 +-
>   hw/dma/omap_dma.c     |  8 +++-----
>   include/hw/arm/omap.h | 12 +++---------
>   3 files changed, 7 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

