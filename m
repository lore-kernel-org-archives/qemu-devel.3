Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB46C021B2
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 18:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmGLj-0002Ld-Or; Sun, 23 Feb 2025 13:05:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmGLf-0002IO-LR
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 13:05:05 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmGLc-0002Z9-A2
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 13:05:01 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22101839807so77861395ad.3
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 10:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740333899; x=1740938699; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6o9ppRmpF5TRP9xIHNmFEPVUDScJcIX4BgT+x2tZm9A=;
 b=Uy7zLEZvibm2hojNn5ZEukGk9/yl5eGBKV0RLm21Vi2NGUyPKSvG62jNunNeBa66ey
 DGW77ZDS8U+VqgA3fHnXqmfafORAz+Wf6L7P1DWcdiU5IFaIzUMgilEcI3oXEM84XyXQ
 w76u3mezoxIpdJhAR7SHrXnla7fc7Do5R4NPVOQ+iBHka6+ZemWeXCXG5USvj8HO0+SM
 V4fXfFFmcT5hvID66wQRBrdAViYavkG+Fj0h1/16/x+W2U2yzNHqfmlduWVLBEcxGT0l
 JjIwWEjeYNFfgS6A09M5llPpio3/ggWzEjA3nfwCjSRXoEe/WgdLD3O9vxUo1F88ZDRZ
 wYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740333899; x=1740938699;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6o9ppRmpF5TRP9xIHNmFEPVUDScJcIX4BgT+x2tZm9A=;
 b=HtJWsq3n9zX8aJJzgmR6extc5yBatt07v8Qz2dzN9R99dkyAwuPu6UdPp3QK1bEtVD
 F70a9zXxLB5zxmITmX6cImgJXBDImdo4BfYjAnRoryY4KAU9R6RTUfw+aqXQYxxPlppd
 orfX8FCRdybblE6ESYXrUgu0HUBKaJxQh/Gfb6PJ4pwcs9ip4HCKVa2HxzNzj3h3PzNP
 LXv4e9+Q9jVyoLEjWnJ98BPwDkxnmfLu5DNsvAPnl2bWY2NAfaRYE+nRtjyDIDc44+us
 DdjbeSnQawS4KQ7MxKx7kzKRaXbXU7B35/hAjY6QjKCVUoQmzWrfUKZewovWBhTvZ3Nt
 gy4g==
X-Gm-Message-State: AOJu0Yy6dwk4xBEvC5ictnlNK/pvRfsovtUOPvDSA8Amb4fj2Hm2UzvV
 ZRUcPZmjYBewkGTPQuZHf69OneK1v8k5j8fMaoaF6Wz8Z01abwAPVLY6zbqOdiKj+qfGgOZolFU
 I
X-Gm-Gg: ASbGnctDv8HTOv86AeyA34SkGAlBb4/pRLWB36jFu6HaTy8znUAZmzkzHf+DvZUU3m/
 gzLKGbVQ5HJ8VQFPpaOAdJ02ORJa5IQrkMSo83wyErMgNSk1EEZfkwh+HUBxQG2crIkFPv6uDyK
 4s89MkIsrXv+YY07f+5jVMoxuuRHNWyhXREP1bu23kWit0Ieo6mGlJu8etrMzmj0MjhEedBOfO3
 ytBtIKVlJZOhFsFlZlLo8g01dk6WK0J+a9eyKLVhJEE3WmVlqAiWmKP5hkTQUrzZMoA6nwUus4l
 FKZIKiuoj1zuI1z8+b1jRx9FgTNtbA11P7WJLI9Ty4D9STxYVYa9ZC8vYarc1YL49/7vCy4ip+0
 IzywDFXA=
X-Google-Smtp-Source: AGHT+IFczpm93ZgfkOSf83zZQVW7nQPSmBWg8D1qmYiFvnrRcqMnK4ZFdECZgoP3GiQhZca35ft2iA==
X-Received: by 2002:a05:6a00:84a:b0:732:623d:beee with SMTP id
 d2e1a72fcca58-73426c8434cmr15323693b3a.2.1740333898804; 
 Sun, 23 Feb 2025 10:04:58 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732425467d1sm19670781b3a.12.2025.02.23.10.04.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Feb 2025 10:04:58 -0800 (PST)
Message-ID: <82bc2cfc-a11f-4ed3-9812-f9c9a338fe77@linaro.org>
Date: Sun, 23 Feb 2025 10:04:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] hw/char/mcf_uart: Really use RX FIFO depth
To: qemu-devel@nongnu.org
References: <20250220092903.3726-1-philmd@linaro.org>
 <20250220092903.3726-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250220092903.3726-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 2/20/25 01:29, Philippe Mathieu-Daudé wrote:
> While we model a 4-elements RX FIFO since the MCF UART model
> was introduced in commit 20dcee94833 ("MCF5208 emulation"),
> we only read 1 char at a time!
> 
> Have the IOCanReadHandler handler return how many elements are
> available, and use that in the IOReadHandler handler.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Luc Michel <luc.michel@amd.com>
> ---
>   hw/char/mcf_uart.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

