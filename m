Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A134BC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 09:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp3ZQ-0002cH-Vo; Tue, 26 Mar 2024 05:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp3ZP-0002bA-2B
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 05:58:15 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp3ZN-0007G9-Kn
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 05:58:14 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4148c72db39so6440355e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 02:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711447091; x=1712051891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K90a5QLkWJdKQ2GPIov4eBLWBjScp75e4YxbVtg3CG0=;
 b=cPub/af1bLekaGzS5FKgtPI7hb8SlgNIyQ/qesdnwXrFwMfAu/9SNtRny6Un7iTg1G
 JEKK4vTVPGTWlK4JZp6DfzUwqh2QVcTHJtw8kitRJBElhaRD9eNqfeS+CmubHpQbrYkR
 O0kR2aPwY7sizqpV+PvejdRnIeSCUPk6Ng+qc5oMJjAk6hjvKKPamr5TFNPh6DtZdiBQ
 rCLNwIUQqa6sdCbSuJD6Vv4UMxtKXJeWrqNhjaCnEMZuIYBe9Vw2by+/VRSkCrKSlvwo
 kQHIz0KUD6qIStkChl2iXCGNmOLNmcNMRnFF9u5NqOprc0hSdDXTaakSvliFiIvaX/OG
 bGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711447091; x=1712051891;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K90a5QLkWJdKQ2GPIov4eBLWBjScp75e4YxbVtg3CG0=;
 b=AuM5CZ8U2i0dANd0cIg538EdCeSMotpw96sBHDrFucgisV3xQrs7+uCe1E6VBf9fYx
 LwuavcNKlgoRevKUUBrUPKNg2yv/nkYH/EkvfC+g5xaAeS1uQaqlHoCmxwGzNinU35aP
 pCTqqWUpZ1jsOz8AkXHnooDwpzviPQcAU2ggFbnTMEcYooKgzlSdP82+gJv2nZZudDYO
 voLmZPgoapRgI15CVSf+PXHeDfLrxy2Is6UmKIrnHSqkajJKDPSRZvrAEs5o7S7bGCGH
 6f0cm160qZqfYtfIoehwayXymT/Awdywf4jRzH2EG7+TVpQvZmR69sZemwQzyyGLvdJU
 aHZQ==
X-Gm-Message-State: AOJu0YykN91Ip2pGkGCr3qYyiJeK/Jyd2w/pYT/8bBOjlJzmbJAMz3rN
 /AXoT18LoUWj1CLC6d72EPtc/KJORigBWSzVzJHvYz7WpG+OhAaWCUXusv3ZA3TTT0rhnGV9zde
 2
X-Google-Smtp-Source: AGHT+IEDVKQRhWCiW3zO0YfrxmOt4UlD9d++ANtVUsIoUVn9ncqJsTJADb3DI3x6ZBAgv3g5KG/F8Q==
X-Received: by 2002:a05:600c:1686:b0:414:860:bdc5 with SMTP id
 k6-20020a05600c168600b004140860bdc5mr491109wmn.17.1711447091246; 
 Tue, 26 Mar 2024 02:58:11 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 g4-20020a05600c310400b0041462294fe3sm11043010wmo.42.2024.03.26.02.58.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 02:58:10 -0700 (PDT)
Message-ID: <35d66d48-f881-476a-8ffd-310a568df8fe@linaro.org>
Date: Tue, 26 Mar 2024 10:58:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/tricore/helper: Use correct string format in
 cpu_tlb_fill()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
References: <20240319051413.6956-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240319051413.6956-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 19/3/24 06:14, Philippe Mathieu-Daudé wrote:
> 'address' got converted from target_ulong to vaddr in commit
> 68d6eee73c ("target/tricore: Convert to CPUClass::tlb_fill").
> Use the corresponding format string to avoid casting.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/tricore/helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, patch queued.

