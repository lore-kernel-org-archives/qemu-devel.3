Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F89C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 15:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7FX1-0000mu-Ra; Tue, 22 Apr 2025 11:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7FX0-0000lS-IG
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 11:27:30 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7FWy-0000yY-Dw
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 11:27:30 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39c14016868so5327975f8f.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 08:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745335646; x=1745940446; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rGqe0vrKRD3d7dAxkjp3EsATjdX2j+m1ddLHEV62E+s=;
 b=b3MmrdyJKkckGHf++IEJJ964nDzzWxCUWGlA4IEfjDFJLYAEJwqOg25U7qyxHcnc0e
 yoqGq7cUaeHGaIgyJOVoNAu0O3R33Pj39Q/BeaPdhLYetsyrGkMkcWkgaXO7uVHdQMdC
 eCAB4S7hTF6IOYz/5Sl2X5nY+X8WoAt7cH5YxdpVWFy6k4sAJmtqy16WPYf/ksY54Uio
 PXU+60oCzzD5arthxg5r0uKfbhz/HtKm2yVZLJr1k2yIUKyTMl/FTv6R+mK6X6vNkRIg
 itj3450b6MCnmU2FYAKuyGnY+DkQpH7ZUObyAD2DDEquEBSeWQXFe3lPPSdryyUy1Z9P
 Eqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745335646; x=1745940446;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rGqe0vrKRD3d7dAxkjp3EsATjdX2j+m1ddLHEV62E+s=;
 b=pzZmsD1rEVVdy0S9uzdHqc/21syHE2uAkF+G/v+55v6Pca3eqIcEdftn9Tx7tmCYvz
 ZT01VoDXgdgZQcQ8AY8R4XlP59GfgBEqJjbjvbo4NKWavaYuWsBDBveVJW6++82XXFYw
 SNLD23Z8JFuwTj9xjVAFQxNCeHbA3yQPB0kv4iiAsTs/WuKNNd3xqHNsvYOfZ8asfk1z
 OPFx3PnQ+T88OEU4R8yldW2gHR3BTvOQ9rv/Kov0QmW3F7YmW/TNp6YUUB6uPlReXb5P
 xc1oBB6lbG02yzQdoY3/8CBNPWxwNPI5O7j+rAzb4pIfqeAi5/dRgSsqXDYL4NBoBW32
 iPRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX20SrWBpUK8hczQdHfr7/ei1AkkAE77Tjf36QW6zouhfWZmlF4uSKBUXTgBTiXiPjxe+SJLsIEU18I@nongnu.org
X-Gm-Message-State: AOJu0Yw1MhICA3FpQYCbAx8+ZIgU0RHtYAwyCl7Goj172kcF9uXNLx7g
 HMBcI4nhPNtjrS/tQ3gtlRkue1+CYrqzHoe7v/gqfREPko9fhTQrN38dzOKrGCo=
X-Gm-Gg: ASbGncuOYrH9E2TPNnCGEbkKfxPoMnPMZ+htbr0A743pAym61mBxHEo0ijvpXeBw+Ll
 kU9todNhxyamZsjI0Q/wiMSwyLNJarQ3KJ6CUK8xAzwt6iplYgAOsXny3gBB/Lp7bjfmV9wP+UO
 k8AvudzSk8dyL5pTVIie/K7TJMNwLE0U4OU+UQ8K0zHLShSMFFf0GCQRcnudA3Pm4E6SBTow01r
 jQ4WJvWa8iULgUwq4hI4xPs2XSKWUd1NJrw81MIaagEY5+zR6rLYhgYwkQMBwQFJkYEgIgL7qqL
 k/zW5mkrwVG0rwfEthnlNry9dxQV7Kk1ldmll/mcbiitv7K4Qshqg9jxgIVV1VIkBNOZQIqnZ7/
 MiUSCqAI+
X-Google-Smtp-Source: AGHT+IHf1yTTBSUm+fKBTT6bvG4xaZ2zs5hJHDIAXV/Mitwx92WgvuwxYKKiN8cCYg1hwCoZAWzJjA==
X-Received: by 2002:a05:6000:40ce:b0:39c:1ef5:ff8b with SMTP id
 ffacd0b85a97d-39efbaf2652mr13067389f8f.48.1745335646225; 
 Tue, 22 Apr 2025 08:27:26 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4931b8sm15337390f8f.80.2025.04.22.08.27.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 08:27:25 -0700 (PDT)
Message-ID: <989ae0d7-b5be-4e62-a047-33657352a209@linaro.org>
Date: Tue, 22 Apr 2025 17:27:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 042/163] tcg: Merge INDEX_op_div_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-43-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250415192515.232910-43-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 15/4/25 21:23, Richard Henderson wrote:
> Rename to INDEX_op_divs to emphasize signed inputs,
> and mirroring INDEX_op_divu_*.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    |  3 +--
>   tcg/optimize.c           | 12 +++++++-----
>   tcg/tcg-op.c             | 16 ++++++++--------
>   tcg/tcg.c                |  6 ++----
>   tcg/tci.c                |  5 ++---
>   docs/devel/tcg-ops.rst   |  2 +-
>   tcg/tci/tcg-target.c.inc |  2 +-
>   7 files changed, 22 insertions(+), 24 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


