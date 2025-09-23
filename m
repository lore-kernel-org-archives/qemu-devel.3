Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEEACAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 07:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0xNn-0008LP-QR; Tue, 23 Sep 2025 03:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0xNj-0008Kn-07
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 03:24:11 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0xNe-0001fu-PU
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 03:24:09 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e21249891so1105245e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 00:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758612244; x=1759217044; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hOf6+FgHZARfA0BIboFuaeYKn2SHBYZw3Wud8I5pHhY=;
 b=Bz8nan+CuakgJtrzGsQxI3xL9sbmaHO47HcVLx+GEwWboqqp4bRgy5reetYBIBpcun
 fiXLSODX5bzeJvYglM0DUYTEdBfFWUCqgD54Mn8KG/IwveDthAaqZivBW/xxWsIkcVZ2
 PsodQNmVTK39c4SylqvtzFhKKsBLw2Tqp1VGmJ1oGAnt/RPH6ofA8UvoBrObrR9eySva
 DCOO1NMhzLOvpfwsUKFxabrp8C/DR4KFhEJ6BrqPq3bE/EbRnRawlYMV5oBPgerE8DX4
 XNWhANAqCkO0sAHRnNHiP1mE1QWstwOjhPWQYClZ/xFesIEVW4IQVKRWdVCb7LWdND7T
 zvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758612244; x=1759217044;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hOf6+FgHZARfA0BIboFuaeYKn2SHBYZw3Wud8I5pHhY=;
 b=nH7mMWiZOeMWazkM6C0HkgQmDrtItnq/f8Nh4BtQ/s/nv8jd8aGsAFdsTMD3E9I98n
 w8fbW0Nofn/xYrMmqHa4TNSyrorkohZLhY8aSini7innfGuvGukLYApHy+dUyIEYtWvJ
 Fw5n20jcECLIU/eDXbbCRG7oUUiardQxBXN7A9QNNZocCFb9N8lEoxDCyt1G00H2cDKr
 Ru5KcTruECOzQcsCjagUXdKx34zQV280r5GBAQvKScYWveu6KvlJw6b5YQj70cQznVEp
 a7WEuNdVk6FIkrkbV33eMu+KiO4de+vkwcrQJBrsBWPsrQ29CMkmvD1h0sDQxf6NmDxQ
 rE9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ2x1SXTiYJP3AS2qLHAOXVUwLkC/b9yG28+ySIiFDr14HSg37pTkMAjdk1+283XkdMlyKWfIyj6vy@nongnu.org
X-Gm-Message-State: AOJu0YxgH8a6XW4ET2zgNVO94kSQoJbuMdb5Lb7Ge1qvz1/3aCidnWT9
 GXgHB0tMELE56J8aCYsTCShohijdn+wPEblaoOSR+/csulvJhg6i2+2WuKQgHp6MzQA=
X-Gm-Gg: ASbGncu8ns7qJH1F14qDAGqVg4Q9Uz1GqMWou4sLUII25G59ryyMkxA8eznJgT6IkWO
 KaV2ixYWxg2+Etr9Adi+QpYfC8dqvHmSA+i2Mjx/qKWlG+JJV9ELaMdegyOZwzv20WowA2BpR+1
 EiY/Z43A3AF9M7aTQ8xfvYsbkCzwq37/aLGviiyzVQeDnIrUj9A3rH83iOhtFy4C9zmkmJmO4gT
 Ev72CoMvu+4HN44JeD6WJaTQ8Pb2fq5v3K/91/jRREQdOlVtnAWLJBxFEz5V2ekUiTL6TOGick6
 2t+1pM02ul6OiMy1xp9TIFDXwmIJYE6j/KrWH2fIjkAQnpShYH7x2zq8vC5/hBuOF5tdqIIuA+N
 ZS/RQvYzwuegmokV+nfCabYtruRNqgvmkq/wg2PpAmX9XFy3uxw0qWsDSqzNSovwu4w==
X-Google-Smtp-Source: AGHT+IHaginjEMp0I8QFj/V94Pb+sP8LNUG8y6bLiTHfcBAJkqLucUHqSMtPOxs0eLokHpTnLzRLbA==
X-Received: by 2002:a05:600c:4343:b0:46e:1ebb:49af with SMTP id
 5b1f17b1804b1-46e1ebb4ab3mr8258915e9.24.1758612243678; 
 Tue, 23 Sep 2025 00:24:03 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46dd9a69466sm52722585e9.1.2025.09.23.00.24.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 00:24:03 -0700 (PDT)
Message-ID: <72bb54c0-4e40-4f0c-87fa-493b3a5f2f40@linaro.org>
Date: Tue, 23 Sep 2025 09:24:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] accel/tcg: Remove tb_flush
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
 <20250923023922.3102471-12-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250923023922.3102471-12-richard.henderson@linaro.org>
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

On 23/9/25 04:39, Richard Henderson wrote:
> All uses have been replaced with tb_flush__exclusive.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/tb-flush.h | 15 ---------------
>   accel/tcg/tb-maint.c    | 22 ----------------------
>   2 files changed, 37 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


