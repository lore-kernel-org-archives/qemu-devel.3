Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09886CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 22:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSjH1-0007rO-OF; Thu, 28 May 2026 18:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSjGz-0007n2-Fn
 for qemu-devel@nongnu.org; Thu, 28 May 2026 18:32:17 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSjGx-0008Bg-R0
 for qemu-devel@nongnu.org; Thu, 28 May 2026 18:32:17 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c82471904fcso5342034a12.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 15:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780007534; x=1780612334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hHv/FV/3zx/fudig478+NVKJKOIFAyYZJY+3lVapc+U=;
 b=GBxvV8Eugd/jzk82NPLb5iIInzYY1qrzZNtmmHX5RkdX9MkKKkcZyp6JjK1ml2De81
 w/OS7pYLqiV1cVX3Lj4bchONP85WJVNyA4bIn28p/FG/y/34A+Yg68/JXaflN9DwQpgw
 pEtP18JvJHnWe9/iRJE7DA+qXSjO/oGCcEDdCqlWn9j+Hn5qiEcd32Qsenj1nN8ws8fJ
 XIk53JQzB+2AoWiTNtAE5Fb6ZT3aOITeF5m6en527xuJ58dp62ispULSGPmA9KUF7VGx
 3XuEqTcmLecRxKpJyxps8fefQuWI7jLvv3MAyp8t3EytxU4i5QKHtV5BIRWXbxA5G303
 LqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780007534; x=1780612334;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hHv/FV/3zx/fudig478+NVKJKOIFAyYZJY+3lVapc+U=;
 b=SvqhgbPbBqIoZQ2Ut374CjgprbZ8UUxDf7lnjZYYqguKCf321SzxnOaaG1fByyRCvS
 hssKT59hHpX1Ezp+Qe8vIjFpP41f4jK+0tnSy69W63E6eZR64Lcb2EvA6ghKLYyTtWzr
 flkt1SxOU+S3YgeA27YJQZ1yzj1/37PsE95vlINPALneIT2POLKYiJMSdR8WCVsFGYRI
 Fe+RWgstazEVZbT9dl2yhQA1MA6/8pvsvYcqz73tNGFHViI6X36WS244+vsaX8uPm85k
 W6EGLnb2VyTESx4wr4GB7x7DUgPOfKFgRW5zj17R3Qd4w2dzs0ObWzT863UkWiJxfKwe
 g7Ig==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Pf8/QKS/rT0Mo5UlttPHeizG+IsXLYUhPRjIIDVt3GcDqo1EAbxKlqKFD76jE1DZ1rTfClr9tFIIP@nongnu.org
X-Gm-Message-State: AOJu0YwetXgqIY0e8AhFoUeWp+QbLhi4zGnyXrbGtRtQ7pD2EQsQCo/M
 PYGgQDhu/BXluu29j9kCVDT7EMpdUa1Jv4dhf+2gX5hfvSZ8LYV+xhgSlH2lKIWrhPBTtideyrO
 C22OsPKw=
X-Gm-Gg: Acq92OHOKhtLM5OFZQSPPrh+D5hU3K9DoGsvTohpfinVsE+Z4M7kueDaDOF+6ARppiB
 TcwJUifhB2ybGzypSn+IKEcNeebtYZqcEKv99FcvZN71zDjulaTYOxeYrEVKO6YZBLoBaV0ap/a
 vu5vcejwqS1rpsq/DQF+KX2vpg+OwQ5JKSf5ai7d1S6VR1amSEoKmjis2/4UqjKe9TG/YxoSCS7
 RA+qdgqFkRzVkpQmsjnGjKz9yDwSmL5p3QNsAd7Yl9BCaQ5ltrbIOsYpEHbIbsO1CKU1Ieb7loD
 SGbCCOx2YgSEaOq51Fo0u9rqv4Tk8Suwb4/L9JTa+SqY6Sorv5SgxlL1O4NLCG65gjlzrglvWRh
 Ll+nPUyO8Vf/GvaMiwExKeKURW9J7YBmXR9S51hiKJUwUyZJrsk0eFRHogpL3my12SqQUVsKcw2
 MvTFyKNXl2opwgtsJqgzPpLdLOFLHUE+XCbZ9PQEtR+dxZUAs=
X-Received: by 2002:a05:6a00:2884:b0:82f:85c8:fc19 with SMTP id
 d2e1a72fcca58-84212c15977mr125027b3a.11.1780007533659; 
 Thu, 28 May 2026 15:32:13 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8421310cd89sm5570b3a.18.2026.05.28.15.32.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 15:32:13 -0700 (PDT)
Message-ID: <5359e054-2bfa-4188-9b51-eb3d2177d8f6@linaro.org>
Date: Thu, 28 May 2026 15:32:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/15] target/arm: skip tag bit bounds check if MTX is
 on
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260511-feat-mte4-v6-0-8557cc1313b9@gmail.com>
 <20260511-feat-mte4-v6-11-8557cc1313b9@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260511-feat-mte4-v6-11-8557cc1313b9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 5/11/26 07:01, Gabriel Brookman wrote:
> Virtual address canonicity checks should ignore mismatch in tag bits
> during translation step if MTX is set. This mismatch is checked during
> the tag check instead, in that case.
> 
> Signed-off-by: Gabriel Brookman<brookmangabriel@gmail.com>
> ---
>   target/arm/helper.c    |  6 +++++-
>   target/arm/internals.h |  1 +
>   target/arm/ptw.c       | 35 ++++++++++++++++++++++++++++++-----
>   3 files changed, 36 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

