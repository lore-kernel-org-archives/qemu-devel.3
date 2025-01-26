Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74983C0218D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 21:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcAao-0007pj-Ld; Sun, 26 Jan 2025 16:54:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcAal-0007om-FO
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 16:54:56 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcAak-0006CF-4F
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 16:54:55 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21654fdd5daso63423715ad.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 13:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737928491; x=1738533291; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ffEZpz3v0M/irEE8yth40wZ74SwfVWMRm1d3CYWuQSE=;
 b=Y9vq40WXv0ledCjVUvgQR07zvFyi3pHg77OQae7/l6AikPG5fVlFnmtrvfQwJWN8tu
 9J1uaDCkUOxhghgVBBEyjkiShNzy3hfa4tyMZ6d+VEdboD9metuFe+VY05EfqvrcKfR1
 o2kEstFo92vkvKISUrbcwmt+ZYxoqToZCeE4ReoT+3JfBG+vNL663oGWOVeVmuXe82B7
 9F+c571EdV+bU12kCcDVze5NrOyLEiu0xtc0jpyUSnFu19t67UqhboASA4J9FjyQTLw1
 PRrL4sgWWZBX+3Hg8abSc6Gr3F9AHSyKiWnlZTrUam9p0J0SqrUurAeXhd2gk2mGkz+R
 5XAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737928491; x=1738533291;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ffEZpz3v0M/irEE8yth40wZ74SwfVWMRm1d3CYWuQSE=;
 b=JKJ+LZ8IUZf5tmF0mLmB4NrppCebvPuK6q3Bop5K6UseqI85dYaIfgaUr18aIWD1M0
 NTcmgj9i7213wYAGiEQWtxjCdZ6sOcTEkuSiAVQD5Hh78AHcpMWK01u5NlxLhN9mgVFj
 zvwbsQpNy1dyF2RrotIyni6HZpzPd2sLk8eM9xPldKL5JAEpEMi2pQuzLElpvEktmUa5
 XR/q/65IBTz1LiGMKO6yRnP/cWKK8eF1+A0PzkCvQzmmwC1WqDpW4AaC9I5bFnuGjDKC
 hUPtqOdeWN+NEFAxhM3jG9jae9hRQWRfwC50kglc4QBusTgOIbAZUx812sLk5P4kPsRI
 GFQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmFDYGmyYoOIwyVVX+w/gwqsWVNpBHQ6Go7hxjYC9OqPY9e7Sg54CbVVtc8liysvz0z/1yBktupyv0@nongnu.org
X-Gm-Message-State: AOJu0YwMkaYGsdueD/QFpwxvMere0UaeV0JGURRLk0tlt0l4QUSsu9aU
 KKXMndVJfbrUKUjqVAiAYy0b/ufM2xMWIQSIcONyKMT3FpyYXt0YR6MMwqF+xds=
X-Gm-Gg: ASbGncvXJaM1rLLKV17OKALDH6BWHM0rGTqTJuXcizODvpy/UtUO0Xoqw20ylWnXqBH
 pe7oA1uBWWfFJLdiMBY0pfV3AAuT+y0eTcuzmIkP3gPEUGwtrigIUSzg2eWkCYWIf6enLymQDmL
 P9lBimASijWRvP0S7BZi+P18FY/D4KNybcAm9jeDScyMi6bHSmhE+sEyyXXX+h5f2VFZE2kXy8Q
 sLHGzPFWAgf0/NP7nOIcRn2iyuJjp75ZG7qHlg7VYpyFtXH6MmuK9Q+z7mx2WvZ/tUcfM4xicXd
 A63EdPbUR5LCXzgGixnBLFS9mQd6GwahQsvnsyUzzwdKtDs=
X-Google-Smtp-Source: AGHT+IFIWJCj7Khb7BxA7AUT+6bLoqxKXiEUIeJc6aixgxHk7LI1FnnihQltAjGu4WhUtNoHh+aA2g==
X-Received: by 2002:a05:6a00:bd7:b0:72d:b2ed:8788 with SMTP id
 d2e1a72fcca58-72db2ed89dbmr37433047b3a.10.1737928491319; 
 Sun, 26 Jan 2025 13:54:51 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a69f401sm5679767b3a.29.2025.01.26.13.54.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 13:54:51 -0800 (PST)
Message-ID: <cf54c2fc-f22c-4704-9a70-e0955d75d0b6@linaro.org>
Date: Sun, 26 Jan 2025 13:54:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] hw/net: Have eTSEC device inherit from
 DYNAMIC_SYS_BUS_DEVICE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250125181343.59151-1-philmd@linaro.org>
 <20250125181343.59151-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250125181343.59151-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/25/25 10:13, Philippe Mathieu-Daudé wrote:
> Because the network eTSEC device can be optionally plugged on the
> TYPE_PLATFORM_BUS_DEVICE, have it inherit TYPE_DYNAMIC_SYS_BUS_DEVICE.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/net/fsl_etsec/etsec.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

