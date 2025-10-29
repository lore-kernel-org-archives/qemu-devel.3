Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E30ACCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE1pj-0006lN-Ff; Wed, 29 Oct 2025 04:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1pd-0006jX-VV
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:47:03 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1pY-0000ki-A6
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:47:01 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42420c7de22so3489773f8f.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 01:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761727611; x=1762332411; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H8q/s9CLBXy+4jmZ1rxdJZUdlZSdqNF1PZtwApe8Jlo=;
 b=Mi0Xx0HkPNhweXB9ZSJotA80VrOeF1plTDoFxj+2F4fsLrfiP+Y3ZOp66yaIvpbpoL
 lhqrUb5z3ZvMywEgm76/mKFsJ4mM8bB/ZU6kVi9Wo/cDA5+QXY5WPxx95o5+PZakfZaA
 7nGdXDWWw3xIn4nDd8NHXUHjtMwdL0AMg4jd9prPb/KQdncxYPTGoOP/2oyYc6l2oRVc
 PbyDulOOx04umr7VwtvkST/z3S3LfoywoX0mRbJcPrtgC0a0Zxa4DgJqcyuXPHp/NeU0
 ifMn2tGqE4du6f+Hc7QL0yd/e8W8DXoo8Js2HVt6SC/4vtHQDVCyHYmxIb7GFu38Hh4O
 acpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761727611; x=1762332411;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H8q/s9CLBXy+4jmZ1rxdJZUdlZSdqNF1PZtwApe8Jlo=;
 b=cHwVRfF2OJ91zmDzljuDZTNnwhLgFSseH8gtOlPZWv+yW4sm0gdJ0zuFy7v81j9hUv
 9AxT65pHYAhjQevvTi1E544zPeu8bnMdD2uZ78iNhDqStEZu5+xWXTasU0MP/2RGVZGS
 sTE4HBR9Wy7aANy1ko7bTE2yJweAb15TOE0RmidJbWGbKcUwv4I2aSwTdYBejE4wzLzl
 XH+R5JdbSlo4RstwnEfHLxV3fnUDXovd40yL6oB8iqqY33xI480c1h6t6Eo/0Mjo/+wh
 gsOcFDIhdAYF5Zf5y9xnS5tqf03GdjrCBp5m44aycLyIew8DeBjS2dMSYFhtnUsDqCC+
 gE2w==
X-Gm-Message-State: AOJu0Yy1CWMmaCJablm4V2bU6kmweZFEtRmnkKAMer1g/e5Yr5ht37Lx
 jHwtpKhoGn+v9PVQsDsXVXE6BuLzSTHlCzGFzjECDnIg6uRefRz1zsczOtbVko3twLqp2VV9lBh
 idBO0Omc=
X-Gm-Gg: ASbGncvDrerDGPvP0O3C7y7huRkWZC0JmElrxAwdvlZao3GAmH3AMBADuorAQ9fRoEH
 3SlsgHsGQPuDhZHoGqNa75cpkln2ltNH7blqCr4bjFXRaXCWXiGcrdCt8ZVcU3YUpCMPHhmEcg5
 GIiOIm5OV5uq6W+F0OAXwMiClCOO0ozR/aIPNVxE7dqf9PxIT23BDnrfUD/N+5z4TS021yGSPUj
 bd4MftYWSsrM8Y6e2a4nRzIue2EA/0XJRzDKKBnweF5OiOLoiJ+JI025SqdsJG6+4AMBwtE/gi8
 hpWx/t7PZus3lwk2cKy6VWymyMfW0T8Tixk/aNRCNtAZOyo2FKkp0XIsgNeyjAHTXFx0bcUPk2Y
 IP9gTyCjqgTMktOC0maD1i2SQCDZ3l+6JaKyLiw2abnGIRMow2YipFRVhQopfzhGFw/ZDz0Tu0Q
 m+DNiARFpYdxczUVHv
X-Google-Smtp-Source: AGHT+IHGic95wxIS69RAQM35bMgPrMMU7M4KAL7m1o5IUVxisMmRwVhJM+zMu9YHLTew5BXbi8cVIQ==
X-Received: by 2002:a05:6000:2283:b0:427:6eb:8499 with SMTP id
 ffacd0b85a97d-429aef84ae7mr1492008f8f.24.1761727610837; 
 Wed, 29 Oct 2025 01:46:50 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e196a4bsm37641125e9.6.2025.10.29.01.46.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 01:46:50 -0700 (PDT)
Message-ID: <83b15bc2-68bc-4538-ba50-aad479289f60@linaro.org>
Date: Wed, 29 Oct 2025 09:46:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/25] hw/watchdog/aspeed: Use
 memory_region_get_address()
To: qemu-devel@nongnu.org
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-19-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028181300.41475-19-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
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

On 10/28/25 19:12, Philippe Mathieu-Daudé wrote:
> MemoryRegion::addr is private data of MemoryRegion, use
> memory_region_get_address() to access it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/watchdog/wdt_aspeed.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

