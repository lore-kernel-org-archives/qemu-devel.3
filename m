Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D67EFF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcTt-0000OR-47; Wed, 06 May 2026 09:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wKcTj-0000Ff-FF
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:39:57 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wKcTh-0006zK-CB
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:39:54 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-797ab169454so64727237b3.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778074791; x=1778679591; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WKVgFAzVfqzQY9IEe4RfflolbrKsfqDi1J4nmML3MUA=;
 b=sjgalF2OhjxmjJVzhIWd79kKuLmtLyxfD5aNlJ/V2BDxKoVQbjTWW3HlqwWNtNf924
 2mlQ4kMHt29BmKZw74fx2+p2CyjXJBrCQ/sChewQEXkQXZdx5vkt7dhNCT/VwSoEVAr1
 rkiGC0LPlxE7+lShDpIpTzDYD7Fd+9zE/XLSOlaoEG2mAcIHgKjDoICAo8cDPAmCaxlC
 XYeaemKFQrd6wSfLvGiYRrDLaKxDRyfOJ5dcV76CnK/8fWeOLxlZbH/qgfKUDiWyU1CB
 yjKsQYVVBpCela56fwUhKeW0SlofCOPczB1AIALDqPeaHyIjpG7LeweB3JuF6oetxV1Y
 ILRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778074791; x=1778679591;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WKVgFAzVfqzQY9IEe4RfflolbrKsfqDi1J4nmML3MUA=;
 b=RVU4OQA6x2xM12m56F/6UqPTsROZGArtYXNf9RDLsz61t66l9bC9I14/Nafe1pGXQH
 zTv+0TNLaEhwR8BsloMbHixWd6lKn8GUpjT9/zKBS95vINoKM4E4QXq05cyZNRDLpV7r
 BN6OfYSYVLKQJLOU4xN2DVCUPeIGd1SRl8LEA4WS/Uid20C9dko+cBh0A2PrGwzHgn6C
 IlMxclfEhZdp28iYIhr007QAqSUmdmWXTh5/VFXYn+SVjoxacSWq3JLiWdQY6/gV8ILw
 RliY8M4QYDvn+n/cITKI5pww+BxlHInSFursqg/fFs4ZTw+FKJkQr5Cqv+1NH1P9iYkz
 z2IA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8RF3/q1v9l2QpW7diFJ0SG3Ldjw3Y3MUaKQITolio3YtWqSvF6k86xpuFjZXD1V5QyK2On9amcvTjF@nongnu.org
X-Gm-Message-State: AOJu0YwizWS6oyF7/+Hw1T6N1QkK6HBq2pwjbMoE2we/abneWxzjL3GN
 tJ1oAOxKHp/9ch8xgqnKm+72FbMvVVMApw3zzcahYg3cvZDHWZ+b+H4SlURQiWckBqA=
X-Gm-Gg: AeBDievN1U+rdaQmQHZrTKMm/odf17zx4p+DqhVwwCvGbBetzt5wmdBqFNQLMy1W8T3
 GlsFnAXHxzGVtif5GmcrtX3e6KD7KnhsQ4Mdh0/M7eaGqi1GAqcbh4AXMgt8necMDOmzXENQvmf
 hXuvqMI0+gKtddZoZXerEHjXBVK35Wz7D0gLJYcLc/8JH44mDoyZSa/5mFoiLMxlI4NTGpZTXNP
 dFwnTAeKQb0gnnwkqNVPSKmFQLvD6H6jEXna9FrR692lEoHvcocCpgJ56T5JSToCTgyH4GiNCtA
 aid21KSj4BvjltEE4iOl8aATpuaztVv+aLp9BZd6NIzjThs86CwAdGfmUEAsHoBidgrj9lwIbo/
 WLvTwJ8j9OPlUtFZBXWXQRB4XqbAymGw4sBJA3zIO+nuuE5JlWFM6MKDA9QW7CqtdPaH2Wg6/LN
 1D69jg8/+23Y3OI0RxF/f7j531VopUNJas0Q/JilkwKR6FA4utTX+D3twfXuUTzU18C60e6Cc6d
 r+gaEtC1NwUDyittNp2
X-Received: by 2002:a05:690c:ed6:b0:7bd:5d03:dc1a with SMTP id
 00721157ae682-7bdf5d7f3a4mr42062777b3.1.1778074791164; 
 Wed, 06 May 2026 06:39:51 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:5307:cd92:1ec8:e891?
 ([2600:381:c938:6375:5307:cd92:1ec8:e891])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7bd66527421sm77820107b3.2.2026.05.06.06.39.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 06:39:50 -0700 (PDT)
Message-ID: <31bac9a2-e91c-49bc-ac99-0ba88f83e6ed@linaro.org>
Date: Wed, 6 May 2026 08:39:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/15] target/arm: emit tag check when MTX without TBI
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260504-feat-mte4-v5-0-232a648e63c6@gmail.com>
 <20260504-feat-mte4-v5-5-232a648e63c6@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260504-feat-mte4-v5-5-232a648e63c6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1131.google.com
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

On 5/4/26 10:50, Gabriel Brookman wrote:
> Previously, the TBI bit was used to mediate whether tag checks happened.
> With MTE4, if the MTX bits are enabled, then tag checking happens even
> if TBI is disabled. See AccessIsTagChecked.
> 
> Signed-off-by: Gabriel Brookman<brookmangabriel@gmail.com>
> ---
>   target/arm/helper.c         | 10 ++++++++++
>   target/arm/internals.h      | 13 ++++++++-----
>   target/arm/tcg/helper-a64.c |  7 ++++---
>   target/arm/tcg/hflags.c     |  9 +++++----
>   target/arm/tcg/mte_helper.c |  9 ++++++---
>   target/arm/tcg/sme_helper.c |  4 ++--
>   target/arm/tcg/sve_helper.c |  6 +++---
>   7 files changed, 38 in

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

