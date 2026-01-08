Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8940DD1D48A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 21:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdxNA-0005n5-UV; Thu, 08 Jan 2026 16:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxN9-0005ka-Ql
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:16:47 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxN8-0005Pc-Bu
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:16:47 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7b8e49d8b35so3406238b3a.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 13:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767907004; x=1768511804; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SubnAnKT99qu4BjtspnI2l5ATM1miaYA7vlNAOMLvAQ=;
 b=yvHxIaxlIgH737m/Rcehq9xJIPF8IeIIkWEGJ9XWXQqJuKNjpPig+mGrdFAqe5Zsyz
 RvsUCJXZ3RBtMtKJcwi7iwNsByIjmoyLjOzlcwtQLTDGnh017IhdCjd3OAy3INK44oMc
 XLcvkGBv6vwBvzmU2QiXj7xAovH35whm0qAtUh0T/rNtmFqaHbDlE8Uu+7hJc6McekRW
 IR3vB+/dTj/mqI9D8GXqWJ/H1bHtiqjpe5ISAjtP05yFLB2m8XQJO+MBakGDYWzjrFkO
 xsShTeQ79AoNyWjmI9vzR4oL0ZoT+IXyYg2BtiVpClO/KzIVRQk24wK4P/0qKcvc1AYu
 nhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767907004; x=1768511804;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SubnAnKT99qu4BjtspnI2l5ATM1miaYA7vlNAOMLvAQ=;
 b=RT0xii8/6gWiKViZZGTiJVENcCHWu0nEmyzP9SGJxNhrxOh+5KqilO+45d2YJfMBoK
 0YCeoJeV+IGwOcJSReMjlE5MGtIUrmPxxqFlITsA1+WY3VI2TWK/+h6bzotTUXtanZB7
 RtY9rnBTMnIuJ/Ul/VtfwTtxlHGBRuoFgeQarjTGR6vnKJlC3uVZ8Nuo7D50K9aD/HnV
 3fp3P0zZN9DSqf61uMoyOhgE8uxtLkTsGFLsRnFmFMWvRNZClxKL72OvJQ+0LvtuAnuM
 YhHfK2mehHdOS4glHaTCCX2QJJ24m3mu0u2cBNRbI5K1zOdC2fsNU2U7Z0LVTK+XH83E
 166Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA4Ljb7hw2k7dfJ2Wy0qn4LG1yGSYIqe2ml6E6DkSqF4jENOfbptlhJerTPi0KOzoXZik5Zup46Mvk@nongnu.org
X-Gm-Message-State: AOJu0Yyhn9cAvK9ylYBndLsmvB3wosCiNcLqRDZqEFDVPggi7O7QEPPf
 +duwA8Te4TsS8qB8pxiOZJqzFPQC2CgfUsp9To6j1ekZ6KHg/46IOxR4HPpoM9dF23w=
X-Gm-Gg: AY/fxX5jmK/8JgK/Yq3i6gc6lzUL49Sq0fwVVehB/5c9H+HP9jwKFM9wKIYkpxq2O7u
 /7KwXjOJem39HJMAg2C+xpimdFvP/Wl5ceOkHY9/OELjX3o31zmFff9TFeHpSXURYmGbmEoxetA
 Hkwg6aPrwbt6n3I30YKtfOdlCHHWJd7v9RRfgRO0umlEqeWgXnK5CLttxWL+FmLrpIYr4J9/Ajb
 l9+UZKKZERAR6fLhs1H1An4PPLgFcIgsNVPTNJwWWyvSgIHYeVxmC6asnphtjiLVY0h9tNdu7mP
 DXfrDxnF0YYDJNvVC+WWcAyJZglFI0v4N5fkhzQx2wGFjaFQ5cFvEtJzc1VcM8K1tqsFd4DdoEz
 HPkQg0HpLITW2sN7iDvtF9TZ6YT6omMRPKNz/n/D80wiFgjU9r8wAnUw4e4E5ArB5NWWL47Uwa3
 KwukVtV5IksCM+DmI8gTZsnMp7tYHe4Val7zxC+/aX0IP6e03R+Jn1WBjc
X-Google-Smtp-Source: AGHT+IEVDo6AgcQDZ+ihTan+6S7N4SD6PROdri4Qd7m0VydcY++pJsiW63quc3ga8NyRMmZNm5mnOA==
X-Received: by 2002:a05:6a20:258e:b0:352:d5b:c427 with SMTP id
 adf61e73a8af0-3898f88f227mr7047105637.3.1767907004390; 
 Thu, 08 Jan 2026 13:16:44 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cbfc2f481sm8681882a12.10.2026.01.08.13.16.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 13:16:43 -0800 (PST)
Message-ID: <8be84ac2-0a83-43e7-a0ee-7fe56d49eadc@linaro.org>
Date: Thu, 8 Jan 2026 13:16:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 48/50] include/qemu/atomic: Drop qatomic_{read, set}_[iu]64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-49-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-49-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

On 1/7/26 9:30 PM, Richard Henderson wrote:
> Replace all uses with the normal qatomic_{read,set}.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/atomic.h      | 22 ----------
>   accel/qtest/qtest.c        |  4 +-
>   accel/tcg/icount-common.c  | 25 ++++++-----
>   system/dirtylimit.c        |  2 +-
>   tests/unit/test-rcu-list.c | 17 ++++----
>   util/atomic64.c            | 85 --------------------------------------
>   util/cacheflush.c          |  2 -
>   util/qsp.c                 |  8 ++--
>   util/meson.build           |  3 --
>   9 files changed, 27 insertions(+), 141 deletions(-)
>   delete mode 100644 util/atomic64.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

