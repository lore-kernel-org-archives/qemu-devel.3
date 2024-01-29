Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BF9C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 22:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUa5G-0004UV-0N; Mon, 29 Jan 2024 17:26:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUa5E-0004UE-SY
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 17:26:28 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUa5D-0002EA-76
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 17:26:28 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d8d747a3bcso11121355ad.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 14:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706567185; x=1707171985; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2FxcmbLurVm2ccNViiNvlIGOAwLvLhPeCQi7MycRUbg=;
 b=n1agvTJUAQtbzq2BPOjNs9Db/etpkcCuM5J4gDXq0tZiZ5eGar2KJ3BbJySE5IudaS
 cCPvO92hjcH/7GYXXzzx2mLQLHIsWcEpE2vaQm4L35iCWUHR0oOJoO11rAKcevYjjapK
 gptSrVBZ/BdWAFKQhDAWUCJmfOxJ5wY8y23EgXXxxOukB4tFrM98negEe3zNUun/ccGq
 9Q7gnKjdKLcPIElCfq6LP321P3rZFaU7J10Z7MjAgByRG4Qbdk7Qm1nve5qAW1IrS9SJ
 2qUquPIO3HXWb0bu6TZ/x24SbbQvmicXP7usOluJroAY6VHpCTrWQ5gYkpSXQ1B1VoMO
 qUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706567185; x=1707171985;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2FxcmbLurVm2ccNViiNvlIGOAwLvLhPeCQi7MycRUbg=;
 b=JTLjv1oAPgaJjS0I/1A3fArWCDHZ/xfdLtCEpv0Kdcxdb1Qh6+3+6Wxh2ZVcNTYXw8
 9sZl58JYl8NpBRgksGq2txAGiBnB8hdRVaRriVYlM2fxDd1lIsSQx4MXAN0lGW3dkUmA
 EtMs/9CO/okg98d5Mxy2b91MXDlfcf3XgPDWLc/v9+FbfjyFBkzXCnbWHRrZGrqhKNDw
 aF/avLXMVJMovkfrCf4Yq3wZOhqiyoCWG9YpRVX8RYLx/VKPyeSf0eWMgc/6fgVDh1CR
 4r9pQOJptYqRf4H/obY+GRYzBe54bLx1gg3RxBoB8BuYy+8MvBqlixmXKLw1HEXdDSJZ
 9jew==
X-Gm-Message-State: AOJu0Ywn2kTzsrQWmFj55Dq8hZj/mm4IxVG17F1yRQxjGnBKiDbPMDcH
 AAigaz0nHha31mG/bkT14uPZjrylSwsLYZdfkxly7TkyJz0e5QQ8No1DEqsCzZw=
X-Google-Smtp-Source: AGHT+IH4F0gHcNCgPrjAN+ZdMhsOil0aSq54f3JmiAoHCwxgDDn12xnn/TEYo75HPeYlVFG70Ak/EQ==
X-Received: by 2002:a17:902:d58e:b0:1d8:e047:1249 with SMTP id
 k14-20020a170902d58e00b001d8e0471249mr3481771plh.19.1706567184831; 
 Mon, 29 Jan 2024 14:26:24 -0800 (PST)
Received: from [192.168.0.103] ([103.210.27.218])
 by smtp.gmail.com with ESMTPSA id
 ix2-20020a170902f80200b001d8db13fc8esm2660871plb.309.2024.01.29.14.26.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 14:26:24 -0800 (PST)
Message-ID: <98d081a9-6fcb-408a-8da9-e0ba9d2d8327@linaro.org>
Date: Tue, 30 Jan 2024 08:26:19 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] isa: clean up Kconfig selections for ISA_SUPERIO
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20240129133751.1106716-1-pbonzini@redhat.com>
 <20240129133751.1106716-2-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240129133751.1106716-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 1/29/24 23:37, Paolo Bonzini wrote:
> All users of ISA_SUPERIO include a floppy disk controller, serial port
> and parallel port via the automatic creation mechanism of isa-superio.c.
> 
> Select the symbol and remove it from the dependents.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   hw/isa/Kconfig | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

