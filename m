Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49415C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 18:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8NjY-0007gt-Ua; Fri, 25 Apr 2025 14:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8NjX-0007gV-H6
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 14:25:07 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8NjQ-00041q-FI
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 14:25:07 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b041afe0ee1so2413754a12.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 11:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745605498; x=1746210298; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qW6fnXz5t+pg46xWOVvAG8nHBfNnncvM49jG0ilcnH8=;
 b=idTIl3OgDQJxaUhY7cLvpBqEeHoT3v/tENj6/poOjuaedLVrqZ4cCIIr1uugmPIT6+
 68zbWRtWJhappUIrplx97S406r5XZpldexGks8DMGbkFFnEpwdu+HLgItOoyZ6CJQf9b
 ZJT1T8RtSjm5953DYBcIqKotay6lMlW+eMAvr49nc2eQpv/c5kZJqt29+64ao1o15XZM
 g5mWbBwXTF2kHT+DysKpBJyOhSFB2WSOnCdSM4NQ35l4lY3a64dbKSO/jc2PzompiPX6
 Rzbm078FVmehnl5wDCN1lPNsU/h/dh+2Y2fBRsel+Gv4bhOTMWrFxF1DrXy+JhWql9sb
 HYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745605498; x=1746210298;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qW6fnXz5t+pg46xWOVvAG8nHBfNnncvM49jG0ilcnH8=;
 b=WVGA+mr+w1mUzYhvp58GjJ0hlkkwkwDyqh6lvOKlsigdFtQVfk6Td4iQig8QuykmkN
 bwZprinenXz7t4CE7D/x99pVRjbt3jE0mWI3VOWQE/qqrA53HxF17c9FAaSAcaSo5PCz
 2J+1dmniFe3XGBvFcMQi5OWlLXjBg8hBcWS8NuuHwKF1W9shwl+4gR9KTz42tjugOYoi
 CxUYpBS+CEE+E9SyI+8EDkzYXbOMpSoMsZcdHmQuvMysgVXSV+dZ359cgXK05Rvht8o1
 Qu9/PHo5t1XFbpRepOUJiRry3MTbZOi3WUnmFjHSujhCTG5yO/hYoort9aQqdSsnC/tX
 Z57Q==
X-Gm-Message-State: AOJu0YwVUrVWK4kpFRkpRSUY3zQz04yPAsUgZzeO/yz9/bLDj7e8IorL
 ZvoJmvP7baLS1s4EQ16xLYzVvgkk4rTJxOqmlkt8JW0Ond0b3LM4IvyUf2iNLyVb2Hs4fGXCBEY
 c
X-Gm-Gg: ASbGncu5FfNcVWOoySURmTd/AtHLT9ATQw29kXGDCRKQoMA6ZUJOOn94B/N9x7a9UTu
 U1+2HPcJdTZnTiq0vLtzo/rTr/TSCkys8Sf+dFcbbagq2eLY2wHNlidkMJAioEipmy2LzbXvvHp
 2F/RepumMY970Ms6OmVaI7/yW8i72Du2nb/TmmGclyfUNHC3YgEmb+6flkiJDOyNRF8sFgTZ38e
 SuuPeJAZu6AyWjV3US+xUQJAdREDPxMG2XFKclIwJ9rveXlersWaYyktdmzOPQ7mj08n578A/+v
 2ejkTszlC4Vr4bV3vfrk3hhUNa2phtBiF8e8OiqmuChv+Fk2oDOz5lqGFpj5+IOlqRjQBxU8EX2
 8tWwD3Q8=
X-Google-Smtp-Source: AGHT+IFEv5kvDUWshZ+maiv10ZaubdWmlgP3JC84uh0nvUFm5dwKiN7HHfT6w/bRdFpzkMwOFO1hbQ==
X-Received: by 2002:a05:6a20:9c90:b0:1f5:717b:46dc with SMTP id
 adf61e73a8af0-2045b98feefmr4569001637.27.1745605498036; 
 Fri, 25 Apr 2025 11:24:58 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25acde9bsm3510462b3a.180.2025.04.25.11.24.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 11:24:57 -0700 (PDT)
Message-ID: <47602bda-16f6-4b3d-9787-08b51c89ccea@linaro.org>
Date: Fri, 25 Apr 2025 11:24:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] target/riscv: Add mips.ccmov instruction
To: qemu-devel@nongnu.org
References: <20250425115912.912889-1-djordje.todorovic@htecgroup.com>
 <20250425115912.912889-6-djordje.todorovic@htecgroup.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250425115912.912889-6-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

On 4/25/25 05:01, Djordje Todorovic wrote:
> +# Fields
> +%rs3       27:5
> +%rs2       20:5
> +%rs1       15:5
> +%rd        7:5
> +
> +# Argument sets
> +
> +# Formats
> +@r4      ..... ..  ..... ..... ... ..... ....... %rs3 %rs2 %rs1 %rd
> +
> +# *** RV64 MIPS Extension ***
> +ccmov       .....11  ..... ..... 011 .....  0001011 @r4

Just write

ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011

since none of the fields or argument sets are reused.


r~


