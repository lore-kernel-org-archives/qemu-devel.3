Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7414FC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trewn-0001q2-Hl; Mon, 10 Mar 2025 11:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trewU-000152-O9
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:21:23 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trewN-0000rD-QV
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:21:21 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-223378e2b0dso63170105ad.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 08:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741620072; x=1742224872; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xCu5wClogF1cqK+FBGtK+idRtIUi5dh1LEqfQ+MCZbY=;
 b=Fs4kUOLY3PEkwqlzjBMYpTtFnu/pa9XqMp/HLD+z+Juiz8U0gIel7xHK4uzTFOg51x
 V1ZZykYDPL8h8i+zo6J99U1zpoKMC+jNQIxlUvpwGcfjcLgaColQCbST/8WeswCT9H4k
 7e0Yg5WXEUKtWN+zJrLaBgp+sYo0Skz1Bpg9idCgXlglKbl3gzv2UQS1LgdTcTrY++B7
 GIni5nGyL9vg8KrmBB0C+ZDAhblsVoWSik9E0NIerzE3mHHDI/r+orXn75By7GGcwpo0
 40DykOZs17zAyxckWkdxnzMB9dfgFTUh4WDVeJsbIhqAA2lG+0GgzyhCCBEl9FVtEVAV
 raRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741620073; x=1742224873;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xCu5wClogF1cqK+FBGtK+idRtIUi5dh1LEqfQ+MCZbY=;
 b=WzW1+VM+wP+nXY+2AxsNzfJa65QbpeCoS87w13AjvDgMX7aAEzkgX17AbJpvTmRn0n
 EhWhoJDhnig7hiVgdH8PR+csD+GgAhEK3JDNqEarwFMAbkBJcCDS9neE0QSlta5O9w85
 +X2j31Ye0GqrIUm/7nRH+5E5LutplNZr6SoCvfK0IE7JXWBFvE52v1673ly9wSncBz9W
 k6TQcwQqxPYzeGDPT67zovVSCnTcapuaDoESHNlHydUdlcAhvnUWCsQtNqSGMERuHKBR
 slBnNapbtJYNVJZ9Bqbg8LVQuz8wAoedafNvd25nSl50sAKxjE+Pq77LOUEP/YPY7DZF
 Do3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMFisqCH+CVQuQDoii6akL67bRjGL/1gDpCpoClcJFLgn69d9/qM0fq8oiTSbyi8I8Zv0xhih6Kz9x@nongnu.org
X-Gm-Message-State: AOJu0YyVLJ6qR7qjcsk6MbtbH3Slzp8LVqyJlx3jR7ivD8iyP3uO6y1K
 F5NFlWNwPV2eaBo6vjm4mcSE+eyUTv1iDfKdiKNae5xfk1j59GXSUnxfetrdlns=
X-Gm-Gg: ASbGnctZZFAe60emtsM40zzHdowWnu9t2MX7eb5829m64EbPkphd4ke73bEHl8SO0S2
 kH+nI9+BenYlo44T2gaD2bHkNaPCdbWmQtfCQrZnEX4dzdiTqvc8NydCwpnBeN/iYAq02iaDHLz
 9ImFoSTcwyHVIx+xRZJE/ClgE57B4aN8QwS5U/7dXk8RCLXxOgBYTjZwnbAlnzs9MCjo9GOUgp9
 j4/P9qOhZMGtps6T4IPQLZHvinE/MmYJRH62ZXedgH4aY1M/Rj37/aPMlvEDBNM6ifL57Tueck8
 Lsvckf+0NSNr1bC9hL9y+RULi8IyNY0p6YEYBoT5fP75XYquaLh2eF1qGuMvaB1MCzJTVUFnzPV
 5rTgZdPSq
X-Google-Smtp-Source: AGHT+IEJ/yLlb7exx+W8O+I9PfawHokfXmQvHVfT6dSymHd73hvIq83YldOuRYDmA8JNeXsE0e4rMQ==
X-Received: by 2002:a05:6a21:6e4a:b0:1f3:37c4:5005 with SMTP id
 adf61e73a8af0-1f544c36174mr21722476637.33.1741620072445; 
 Mon, 10 Mar 2025 08:21:12 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af53e2a6e37sm1035535a12.71.2025.03.10.08.21.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 08:21:12 -0700 (PDT)
Message-ID: <c5ff9020-8780-4358-84e7-0b729d783008@linaro.org>
Date: Mon, 10 Mar 2025 08:21:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] include: move target_words_bigendian() from tswap
 to bswap
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-4-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250310045842.2650784-4-pierrick.bouvier@linaro.org>
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

On 3/9/25 21:58, Pierrick Bouvier wrote:
> This is needed for next commits (especially when implementing st/ld
> primitives which will use this function).
> As well, remove reference to TARGET_BIG_ENDIAN, as we are about to
> remove this dependency.

Where is the TARGET_BIG_ENDIAN reference being removed?

> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index b915835bead..ebf6f9e5f5c 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -1,6 +1,8 @@
>   #ifndef BSWAP_H
>   #define BSWAP_H
>   
> +#include <stdbool.h>

You shouldn't need this.  It is included by osdep.h, for every file.


r~

