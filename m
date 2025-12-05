Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882D4D32D9C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 15:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRXS5-0001zm-7B; Fri, 05 Dec 2025 10:10:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vRXS4-0001zX-5j
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:10:32 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vRXS2-0001Kx-Jo
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:10:31 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42f762198cbso1479869f8f.3
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 07:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764947429; x=1765552229; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rbhpjym1vgkeLDHAgNjEb/30rxftnXX/M3jxKOIEln4=;
 b=Lr9jiFfDS0I5rcN93wFBMMBZt/TcrqiuJIYPSe5sewDz85CRgnLWQbpSg0WHd93m3d
 ZX/foU3x0qFkepbPSd1ylKpF3ibrXJ6MU5ayR25edjmsTnkoM2M/NHpIsEMv20cI9TrF
 ec+Gcbtk5IMikqlXO3h27ZUZprmZ6gP+tbEQfEIXPtUpxp0Msv+cPo3omQFSK62cWg8D
 Xp0w+GSEwwtKfcyL3qqR0wqROm4sACHww2oo+gIVrpiJb+Spabg0zenFyZzFU716RQnV
 QXYgX3J0bWTNNV+FBhZCCSjsdruw2V1Dh6v0dnTaS1vnu0CJ0XhOq4RLuZnkTR4bWVze
 NQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764947429; x=1765552229;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rbhpjym1vgkeLDHAgNjEb/30rxftnXX/M3jxKOIEln4=;
 b=cQSolnqhSa8YRgM+6E+MJLfw38DcDtkCNFczQv3hbC0lQciDZbdqMf8jcVoI5AaEo6
 LLjieivMItH0h+Bg+G/94qHqXtNJqsZq9mjNhJhXfBf0Wskf0siRKZGZHBAYZbzQHBys
 JnlSFxgTOrMhSTANfmC/hVOeGL1hnRkB0srVx5BZa7jneJlszVajOtF0e/y0xiNJfOIX
 760AkwNnQdMsae+iGC0GIH6I7K4F9xmQ6oeQVWr1mUNdi5+6GwzC2AdF4xlzZ8mILqVk
 Ylff6ZgGGc/R6vQpoOLA0OI/GjL7viLcLZtz2k16l/zDFJAIE6A/HHI5zk+MTThiKBbm
 aScw==
X-Gm-Message-State: AOJu0Yzh/qfTf/bAg12Bs0wTVyyuRSjZY3gRpGWANN8cxas6OnxbEoCJ
 I7pUaylO/j4eIAXmG7qNLOlxKewOUlEKyvt684e3I3DLTykYQyjd2nM/2n24sn77hAI=
X-Gm-Gg: ASbGnctIbzquqHY20GiTEtsPIsYYaU00g6LWBY/yz4DH7iR/sMWLYNWue/VqlkRauQO
 /gsqtrMLA1HQPQCP6orb+qYofNrD/kh53fwcuFL7ucoTV2yy2ZsVmZM8EPL6um3qCTxrasyxgK0
 f+7K4x48c2VX317mJ6H3R/3ed44Z4Zh8WtHlfu4V16vQBW5/XJtiXwKQwkDjKY76QKtSzQ524+n
 XoXH9Tr3weGvfZN1hMVZ3fVoU5f569N+t1NNJjryITB3Wkwp/Ff+oTVidLGcxHvAacjYFR6bljq
 ADYTuyYnyt2ghyF4aLT8poL4/gAU1XcnAE3bXG3iUSH3YVPv6+bENfY+jJd2Qr927w2jCfmL65B
 p2WyUo/wGpr2H6aohYuCJyz+q9M/EbZBsTzEWvAS3AfH/ljm2D3ZGC3birUFV8utQEU7Oih2ams
 L3ftx2vVKT1aHFN0cKbhqv4UW/7vfyjXjaFOt6e9+i1BOXhidEn2KrEQ==
X-Google-Smtp-Source: AGHT+IHSx6szBGFAAiidE5ektQ6MfWZgy2XygW/btVoxfhCy2svX5p3opu98FgHLguPbG2Amhv+tWA==
X-Received: by 2002:a05:6000:2310:b0:42b:41d3:daf9 with SMTP id
 ffacd0b85a97d-42f795147dfmr8626606f8f.2.1764947428774; 
 Fri, 05 Dec 2025 07:10:28 -0800 (PST)
Received: from ?IPV6:2a10:d582:31e:0:901:1329:d82a:8818?
 ([2a10:d582:31e:0:901:1329:d82a:8818])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d3319ccsm8975469f8f.34.2025.12.05.07.10.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Dec 2025 07:10:28 -0800 (PST)
Message-ID: <4df48949-bf78-4169-b72f-8871d31a66da@linaro.org>
Date: Fri, 5 Dec 2025 15:10:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/dma/omap_dma.c: Use 64 bit maths for
 omap_dma_transfer_setup
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20251204193311.1281133-1-jim.macarthur@linaro.org>
 <CAFEAcA_s2fDnr6PQfvjjYT_wnmMg1YUw=tVY5SnM2-QrDAh68A@mail.gmail.com>
Content-Language: en-US
From: Jim MacArthur <jim.macarthur@linaro.org>
In-Reply-To: <CAFEAcA_s2fDnr6PQfvjjYT_wnmMg1YUw=tVY5SnM2-QrDAh68A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x433.google.com
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

On 12/5/25 10:33, Peter Maydell wrote:
> On Thu, 4 Dec 2025 at 19:34, Jim MacArthur <jim.macarthur@linaro.org> wrote:
>> If both frame and element count are 65535, which appears valid from my
>> reading of the OMAP5912 documentation, then some of the calculations
>> will overflow the 32-bit signed integer range and produce a negative
>> min_elems value.
>>
>> Raised by #3204 (https://gitlab.com/qemu-project/qemu/-/issues/3204).
> The real hardware is surely not doing 64-bit arithmetic though.
> It's presumably working with elements * frames as unsigned 32 bit
> multiplication.
>
> -- PMM

I agree it's unlikely that the hardware would use 64 bit maths, but 
without any spec (that I've found so far) or real hardware to test on, I 
can't be sure what the expected behaviour is.

If we think that uint32_t is a more likely situation than the current 
`int` then I'm happy to change it to that.

Jim


