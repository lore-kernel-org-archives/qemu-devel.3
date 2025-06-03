Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F56EC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 07:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMGR-0001yT-VZ; Tue, 03 Jun 2025 03:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMGI-0001xo-Lb
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 03:40:44 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMGF-0001mD-Dc
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 03:40:42 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-450cfb6a794so31831905e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 00:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748936437; x=1749541237; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nI5+iX1Ap1I7p2hPaIWHc8kcqMcI1xAcqyfDcopnGso=;
 b=o5ur8UBbVZh9y1fxMMH/X4YgeVGC84vl5FD9e7tDbGbo2Lu0JHFMwcW8/ElDOm2FuP
 AQvBzTm7vyCGUwEkk/H3ShTwGhVtFSX1uD+E3wQe0D+nZIxy9vJbM4Ezl1cK/GlTtW++
 43kWtdjADKKxFb5Fu5p1VxcDUnrU42T5DA/E9E+0gBJ/M5GEWhshrcVYNfl521p1eOJV
 RWCwpVfvop2FHFWIRlhQC6J8xrwVppxqxFHdkZ/qvtEGNnjXq725ob7TRO/7rOXSoHgz
 T7Y/rE3SuX53/Zz48bH97s6J1Q1gokevyZLTkU3eHihke5IT3phymcRzV3+Js08m913e
 YtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748936437; x=1749541237;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nI5+iX1Ap1I7p2hPaIWHc8kcqMcI1xAcqyfDcopnGso=;
 b=jCL4SGeUqiHFwUNpmbwxuvEZDuvqF/SqI9DLhkkgKZ3z2i40+i2wjV8laIXImBHXoj
 gOyy9NyWFGIe9jyphZE/P8mToURWwIZeDmCG0WlaF+q8WrjxZTdrj9NpKMqE57YavcrH
 mENGLJP6YU6pb5LX17t/E1tSbw9zQpxAS3fH2yvLfbVXYhV95jvS8CIhIVhdB/EOafEj
 ljZ0GYa6THmuHAzw0xkDoKaJ2qLhWjKAj2whuo+pmJSFAdXtDptdmCAUysBHBfi5mjJz
 8BAW4EiXkiOtICNFngui9Oohc/dTf/VXD1whaYD7XsevFpixsMsjhM1ixAhGXBcwaeLw
 JL/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5j+CKmcBIAgkzbrOyl07b4R9vNh9tufXa1/oxR1yp3i5QhIkcldZiIDMRTSk9MjNWDivCwA9L7cQ0@nongnu.org
X-Gm-Message-State: AOJu0YxCzsvpbPrGmxhtXTa7qmHG7tEK85fOKld0u5Yv4kUiJk/Knt7g
 lGPPLHdGi4Re6s0wIGShVcaUWqcU0UF37k3F+7wqJ1YxiLmJKjUsDLZDLV5rZTJm/M8=
X-Gm-Gg: ASbGncvtu+4aqY2kf9z7zX+rIBSnAQTG2MdOBJ8xzE1mexfVl9n2R20NDkyttt5Kaqj
 HNc6UtVhsogKSY5JvjAZxzlPu0j8o+EbuOCN2FLpoIYvg/FL0OVp70jZoTYd8KyL4RMCZmAInmH
 oPFuhCU2EmVJkfV97iBKk7dAIIIGsE3iuP4YSfP+CZgYbgkxPDboklcAmtIktveO3bMy9wmMdQF
 K2dyf2c/pSe3gZBDistFQUiFB/cQxE+uSZ5er3baiDGjbcgsQG73SMek8HxVhFGjdkv0tDGfAXS
 A0hoph8a4pBghVSDxwIkCfigS1+i0R3WCYoCk3gno8F22+F/sQt/SKU5EMMjj3X2AwZLT/TB61X
 IFCrka4qsPW0Q5NPaC5Z0
X-Google-Smtp-Source: AGHT+IHo3GHoSyul5hAl5f3LuZvOaakwBeA9kb0aillfCmuruGqUChSDyH5YSlsL/H9bcOtFS0SdyQ==
X-Received: by 2002:a05:600c:8509:b0:442:ffa6:d07e with SMTP id
 5b1f17b1804b1-450d64c31bemr123049585e9.1.1748936436752; 
 Tue, 03 Jun 2025 00:40:36 -0700 (PDT)
Received: from [192.168.1.127] (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451e505d454sm12109035e9.0.2025.06.03.00.40.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 00:40:36 -0700 (PDT)
Message-ID: <71feb259-63b6-468e-a013-d48f0c3f434d@linaro.org>
Date: Tue, 3 Jun 2025 08:40:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/loongarch: add check for fcond
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, philmd@linaro.org, lorenz.hetterich@cispa.de,
 qemu-stable@nongnu.org
References: <20250603024810.350510-1-gaosong@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250603024810.350510-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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

On 6/3/25 03:48, Song Gao wrote:
> fcond only has 22 types, add a check for fcond.
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/2972
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   .../loongarch/tcg/insn_trans/trans_fcmp.c.inc | 25 +++++++++++++------
>   .../loongarch/tcg/insn_trans/trans_vec.c.inc  | 16 +++++++++---
>   2 files changed, 30 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

