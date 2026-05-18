Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922E8CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 15:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP0Jw-0005eh-Qw; Mon, 18 May 2026 11:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wP0Jv-0005du-Lf
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:55:55 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wP0Ju-00031r-0t
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:55:55 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-8353ca0f1f1so1079989b3a.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 08:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779119752; x=1779724552; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T2SGWvZjRYewSg0BLBd5MhiJpFaIHcp6FLPN1csftrs=;
 b=nNDortXcCgPDygWtSMA3fc+KHD4HlmE/bO0JDVX4+aRe+rnnUaLggjSKV7d8wVqbKT
 pt+HtoSsP7LBK7jFzcuXeS54XfB5p3ubnebtQjQx9agLRjWSL8dJEvVKlPllHx2uqDG8
 bJBrKPBFHSeE9fy+xuvHOH9y73GzWXNOC4l3dUIuYqGSZ6Ugsis9qJpkZpMVrOSCs0rY
 /zPx9beHA0d8ohfhzBBmFG11NpZFnzy39mlqfHnV/bx200/3MrbkeAmccm1hj8ymTxne
 8xtsiawHf8mnGnpWMa5KIx2rpeTY7ITK1FEg/AoI9VGXByx7rvpWzR6IVFi35e5hdBiO
 zMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779119752; x=1779724552;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T2SGWvZjRYewSg0BLBd5MhiJpFaIHcp6FLPN1csftrs=;
 b=ERwWqxz7xl/VdfI4NylXO3BEQtLk1TYzGQGpjygf6V8Agczrwq7tVo4m831NVT+9q/
 DJp0GtnjT/xIhzUeoh3V20xgfmEOSiDhTmkbJa9Sd7iaUUepTp+XvUwPbkO2ZRM2egbg
 q8mEW9ZHDdr1cBAjXSKtmeahS81VdJkqQ1Km/ek0QER0miVBorZAN+u30I7bCFoICGWl
 usC46YtGwgXWwKf4t494AMe9lnqye3IwhIEaFwzA02/Zd5FAutStEsRmYB8wkS4iRxhk
 tonErgLyR56I6u5ryZ3GBATYYxVS8EqubDxewpxWj0FPlq2uUH4oyeLr4zpmFo5KOwVj
 dyQQ==
X-Gm-Message-State: AOJu0Yzt2LB9Xdlva/pt4x4qCT+TfA5OqCASLUdg7zungv+C3+Y2O1Cu
 FxD6CpopbZmHZrWK1oatY41O4t3XO7PIsnMdEdNUBsoWhFSnb91KOKTrjAxS/eAsrJfVaY0wG9U
 EznKjJoE=
X-Gm-Gg: Acq92OGmbXtODamzvYvptwV+4yFrbeD+6WwnheD8cK6SOoZTQCkfy0P9Z1Ib7P6XnhF
 oRbJ+NhSCG10D0ToXC1fhdtubK/rwDihrrJ2uQ07o9XyUMTtBaodMqrNo1S89c2z9OJP+i3pkP0
 eMdzEetJtjMEX4d0v7a/yoPhhlyzqUJeXWzzEfxRbHM0RquBSZhpWqwq3MRGSkfjrk/4FUmgSyX
 E/gun7jOyQ/UuaBoLCQuq/d6fKKj408nEkQ3oapN5FgYLEyOhpgBORdejvktACG1Q9F69cwU2Hp
 DssD1aRlGSO5/Dw5FyXfxeMb9zuI9Ama6xefkSgcDCZ+uK6obcFRMRZTWPnqy5EoYmwSX7xTcHr
 SLqMDmJG3Sy3GISmfGm1QzlGDvzvSKyp+BcrWGnZP8PjF3HqMWvHBa6OGDsgaVYhdPbwSiRe4G4
 r3EvTGTOl/9vaHIyHIzdMoa2TDJm5/HI+P/1Bvsk77+mGbnp8qJ1Pvw3LCiA==
X-Received: by 2002:a05:6a00:3981:b0:82f:39df:dd54 with SMTP id
 d2e1a72fcca58-83f18d87730mr17619376b3a.8.1779119752012; 
 Mon, 18 May 2026 08:55:52 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f1977a570sm14215721b3a.20.2026.05.18.08.55.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 08:55:51 -0700 (PDT)
Message-ID: <74bdae3f-0267-4609-98af-e862f2558c09@linaro.org>
Date: Mon, 18 May 2026 08:55:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/14] target/arm/ptw: Flip sense of
 get_phys_addr_nogpc return value
To: qemu-devel@nongnu.org
References: <20260515142541.571911-1-peter.maydell@linaro.org>
 <20260515142541.571911-11-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260515142541.571911-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 5/15/26 07:25, Peter Maydell wrote:
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/ptw.c | 32 ++++++++++++++++----------------
>   1 file changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


