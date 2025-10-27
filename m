Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C2CCCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 19:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDT2C-0000YO-F1; Mon, 27 Oct 2025 15:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDT28-0000Xn-Cj
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 15:37:38 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDT21-0008A1-Ae
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 15:37:35 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-426fd62bfeaso2472306f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 12:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761593842; x=1762198642; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RUA6XkTACLfZVlrcW1bD/5d1YZcWJdLhmh+Xga5jA4g=;
 b=PoILuwRDhC0kJmaZ86XqZCXXTa5LP3ZyR35oVxxHKLJCJQh9NE9T/yDTWWDKG2IiWi
 iVHZxhSsWr7+/WNNksw5GLQ6mzw0BxxRgMA34UxwnOMrfIoylV4+Qlmu+347tWYRVmFq
 T/9LnDFS1LZH9YYAVII9K7EijVjg3eeFyZoyajo82zsKi5MkDXyeVouAl1FlDXxL/Mmu
 jB0am1gntQVX5nLUWZ9J7InTdYMeBADsgQa4oOyrVsiMG/PicOcskJpl4ri7sGohrWhd
 Qt3OhBdua9AMdCKXFNEqyQ4BeiZZ9tLnpF54QguB/Hokj5n1I4wG44vfPRqfBV+O8KE/
 Qmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761593842; x=1762198642;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RUA6XkTACLfZVlrcW1bD/5d1YZcWJdLhmh+Xga5jA4g=;
 b=bdd6WPRsiwk/FX76SJlE+rh0BvSKIeZ9QPsrrO84cpL1nhJOB3yEuafNCdDTs1+iu7
 EwnWIIDOZfyLNBEKJRTMeUOEnkBvfqhSuJIhs9HRH6e1FTd1ZTs8XEi5jYrLM9SXkmK4
 ZWSFsKrC6VHbXsHp/tDUf51zPDYCBtOkgRpphYipqANLHgtuC8Qinq70dlHjjZZueJnZ
 InBGgYMdx7R3XpBqlbjwLi8n8bt1bUmBBriA7ebh+kUP33Kcxp/g4BRZ+Rvor0BKC6pQ
 mIRpRB2/IFM/rYmEfXJwyVlLPqdNKimcj7SyJBbKLeqp0qkq+BabuCDLm/FNK1LJqtPM
 FtSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpwU6jrwjIu8Zr9Xso9ZeJGQmQ2AMwmypJjQayAWRli65LAWbzG2TUTHaxaj0fW9WFzk+SutXTkSze@nongnu.org
X-Gm-Message-State: AOJu0YzimCJ1ynx5zSOrGbnKQQzz3xcSAsWcuDNLfoTMwWFPbMDbtOMh
 GW5LwBUAsSe99qCD+CTYHNSz+QsqHfs0D8U3VhDzkTDien3UFAOq9QZlFRH7bu9k0kQ=
X-Gm-Gg: ASbGncvD6tzO1Ju2UDVJDRGA7qHrZSphjbrRsG1dlBs6xUJZ/Tr9sgXOBQm3thzj+m7
 93aGt5vO0iq8wY26srRiY3bgcV3WJYX6r2hA9jJTP7Aw9FfDqKry97fMOYe/O/b6Psl+76g0E++
 wfSyV0UITT5Bvj2FOT4rR17TSPwa3E6N5Ngsdw2IhD9upqOVCbGrIB4G34ZHDDrmsBb9znD3v5u
 UVaPkvLwMqae8dl0xNlli21kXoA9eGaBb6buwTblv262+yc6lPS+oWJgSxd6S07bCkc3ZNJDcG7
 M9BBz0UGZDGDgjDETTwzMzJ1nNZrMwC3qv7O0aDd3DI6Xz4YNHn/BB87ozSXVlf166WZqAOPZWD
 LFbXj1/7KwVtmIjNRt5RjaRiRgLtGIObV+cSHyu51t7pNWUPoTnt8GF3OD82yPzwT4vBF5L8lrN
 8kv7MOsiKhBx2d3r7jd72dHPKzHvVzIiucnQ3DZ7HTXQahEqYMhFNvBQ==
X-Google-Smtp-Source: AGHT+IEhZOAYTPgYdoik0Jki6nz6otrCdEX7F9xi1o5NSpsiMM2FacQUDB6bJdTbQnw6z6EbQ0n1lg==
X-Received: by 2002:a05:6000:2502:b0:427:630:4106 with SMTP id
 ffacd0b85a97d-429a7e76b56mr777204f8f.34.1761593842241; 
 Mon, 27 Oct 2025 12:37:22 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952df5c9sm15840318f8f.41.2025.10.27.12.37.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 12:37:21 -0700 (PDT)
Message-ID: <1e5e5d37-d89b-417a-8b71-b1c7db8ca70d@linaro.org>
Date: Mon, 27 Oct 2025 20:37:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] hw/ppc/pegasos: Update documentation for pegasos1
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1761346145.git.balaton@eik.bme.hu>
 <f86b90f6839a0cf9426c0d89e95e6ca33704728c.1761346145.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f86b90f6839a0cf9426c0d89e95e6ca33704728c.1761346145.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 25/10/25 01:31, BALATON Zoltan wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   docs/system/ppc/amigang.rst | 29 +++++++++++++++++------------
>   1 file changed, 17 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


