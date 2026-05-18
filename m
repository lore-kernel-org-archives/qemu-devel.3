Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED548CD4F49
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 15:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP0Ll-0006Sz-PU; Mon, 18 May 2026 11:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wP0Lj-0006SM-MS
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:57:47 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wP0Li-0003Yh-9z
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:57:47 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2bccb978bd9so20797495ad.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 08:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779119865; x=1779724665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vJj5pLmCmDcL9WOR+5PRKLvaUjbgX/vw2+73/Js7pdI=;
 b=l3i67uoFWo3r6IMOipbngxKBd9S616sJCZlua/uWhqFOTkSN3JsbY75oBChibuIM1l
 yGnNda/1B6/MxPmlSn/9GevnAyPjwy6TVX4R2Yawv2dJlxdtWv3a4PnMD7K4+YvJvlXp
 FElM0IZC6fkEZ88wlMUEyrGgj8XI2KDnkRFy/BXa0Z7USG/nBBOnD6yTvLYQFSO6n2Cx
 EIZegFv3v5gWaSoDJSMMvAvLmMPoQ89BksKa1uT8njD+m3t6xVG23j1k0wRN2WEbGXjQ
 r19zojcgu/QbS4/InXJLbJ1LnnRkuA4G89epynF/RXwLF/PE8fZG2aHOjZcKPP4ippuf
 1WRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779119865; x=1779724665;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vJj5pLmCmDcL9WOR+5PRKLvaUjbgX/vw2+73/Js7pdI=;
 b=g3dLbb1YWBrPeS00KdXY5MHBSRy2TT8JTL3g3Xc8CUD94rMRsRru4u+7BXfQPJMiF0
 cLF+XSlX9AtPPLl09Im03LYRf2eCWyZMuunjjiJns6d6o9hMXf5drdYP61ZISlcoCjhN
 V74kklqg+SRdllHbATpeLJu8muRPoEdIcUn3dMvxNidMfmEr1Dp0He79KtJ80K5WwB59
 8QQhZfM/r1w/RR7QO1BVNYNtnTz4Hgizr4mctGksBIOCTmtiZXWa0eVcqtEbVlQZMrXI
 /e+qP0xjVV3ZJyZ9oZaXOP3KZa+Tzl/TsI2pXVVVWjdULETEu3lAQnJmNaZfhekCJnxO
 KLRg==
X-Gm-Message-State: AOJu0YxJFGAXWmmTfuJTQAMrTzIGxrjMOtK6EYGlis33f8kOEFObP2xb
 NjUaHhXfxAlHe11c9iDKDnl+PVsmDJUflWJsbl35Jqu0DyBdvXH+evKlBKAZV4VaeQ7qiphjUuX
 0mQb9y7M=
X-Gm-Gg: Acq92OGq3tRy4n3guJlHHZwQjNGY//Qp+JUUYTlv1VPJZL8FNkgWypTmPhjf7p5bXal
 5tD284uHN1485rFp+ZxBMSZmZySLViTXO6nYcm31TJ+LdfLxWio/8x91vWk4D/RNj+KGaaf01uW
 eRRPQWy9krmRQuh8gMPLCzrORUUdfTLZtK/CaCBizIu9yPtWE4A/q3XeeTQ9kvgY3Eug6jcniMp
 JrbAJnSyZDRGT6jsWfqe3bfudKOmG9nMpjqxlPfaFovA/Ew4LaiSRjf8MPFDNoxyy9b47g1OkQV
 ANt5nt7gK1A3BdkEi0SnlnpOSB9gEq1W6TFJ0dnDmt4PuiY9FnJaEzm/i+nut/RwaD9UIcC1Km7
 MjZGEN2lWQ3sPPoLYaHxjWLG+WToLj67ZciAkC47QYYFYJrvztJdQ0DtzHby6BGiltetrtDOoaw
 C7NYSE9kizGaNHPLhv+EI1cFcjaFFBhTHqHKgELZLPHEO2rd8=
X-Received: by 2002:a17:903:1ce:b0:2bc:dc1c:438e with SMTP id
 d9443c01a7336-2bd526fa071mr180866835ad.11.1779119864676; 
 Mon, 18 May 2026 08:57:44 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5d11d6easm168364765ad.72.2026.05.18.08.57.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 08:57:44 -0700 (PDT)
Message-ID: <b4d42918-85f9-4d60-a997-8dd0cae103d9@linaro.org>
Date: Mon, 18 May 2026 08:57:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/14] target/arm/ptw: Flip sense of
 arm_cpu_get_phys_addr return value
To: qemu-devel@nongnu.org
References: <20260515142541.571911-1-peter.maydell@linaro.org>
 <20260515142541.571911-13-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260515142541.571911-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/ptw.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

