Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD5CC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 10:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7XWU-00045V-5q; Wed, 23 Apr 2025 06:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7XWP-00043q-OY
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:40:06 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7XWN-0006MH-MJ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:40:05 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39ee682e0ddso3619234f8f.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 03:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745404801; x=1746009601; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cOv5Dop1xVvYicU3Mg/rP8j/YAQRFqoJsCfR1KfAny0=;
 b=d4bR9XMUqOuHB8r1y6Oll3IuyKsFJL7616zd4N11/7FgbZTyoeTPgPbtqezeOIIcsp
 /KybKS/M6hSAYVVjWmm3xZdiZW7EZ2wTVbkt3xX/+Eu6IJoz4qygfxhOoJECreaDdCfa
 WOWX7cjjYpgveVl3ZOhNaJJUD8Aq6gKBLxN90iCX5T5kVoFeFszzeGgCnivg0h9xlNXs
 L/SwFGHOw2XvVvA+wierGk8FsdR93TKvzgxM/XvFBmRl4GveRvmr0q2Iy3HUSUzYkaxA
 gkWCj6iqMq015GxFo37S3U7A+VPOUHQEZH/xzME/GDkAaMTG1W6Ih1Rji1wlHkJm/UIy
 DshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745404801; x=1746009601;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cOv5Dop1xVvYicU3Mg/rP8j/YAQRFqoJsCfR1KfAny0=;
 b=JYfV1cdDp6oJtahGsrcCkecTeZTBgNJa4AI+MpBp1VW65GEY1EuJ0ZEJrZGyZbIRsS
 bBdCstAAchO8uVAF47ko3DXt+HA+H/ELh1e9rzUo3G/4fJ7d11utMQXfWJPKTZcmfWMD
 bDTmICaCmD4MmRdjuX9Qgevb1ERslN6TmyvKMmmn+CYXBcg5mzju+gRRbu3jKGB0bKjM
 rMXircFxjQMXGuISxopoT3IAx1lM216SsIbxheLv/v9n3K59h+3lCbz6LGabf4cyA12K
 drXxI5R1el1vqF9kcxa0dK9/D7mIe5WBb5apbmqt/gCQ72fqC8RzYnjBJ3QltoTzVknB
 YYqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXef3RsJ1B0u/IHBn4hoy43Lly/94f9b0WYfBCBpXudcQ3Yc1ciY1UNR59CeNGxtbz5GWWALNozVXIS@nongnu.org
X-Gm-Message-State: AOJu0YzDn3XLnU1lhj3DQW/2YirJJ8j/QGJKgYacBwzi9RKDvuvQKoIn
 crdi+Sw9rcu+46+RZR0K7QVU7oG79LMbdaHEkcAST8eJZLfF6ZnXvtA7tFZzMJk=
X-Gm-Gg: ASbGncve9alNEThzzpmwjzBmW0GZXq/vzSZgzW008l7mL38OLjEZqoQuAcsxBTFIU+R
 TdYklEl/hFrougrzHT11hpYEaxW9KqYLPQksk/9VUZKQan0mn6WOavUs4L5aCmz2WHHHKMgtTLi
 myRx7ApOXTuwZSpWKdTEqh466eOFDZn9um3207GoTaSzQFwGsCbnd2NbiUXZuMJLDPfxUCBEmIf
 XvPp/ASRkuhqo7emjRZPAyXp4SZZ9G+YP7942T0fCTyvfbpvcNoFk+l1P1bFNiw1iwNMXvntcDt
 H6BViUR03yz3UMVMSFwUK2K24NVcQEjU8j7mUfxB/zVx8RzvF5SBPE+RT2hmahPQN5UeCCjrpVb
 lol5h2XUe
X-Google-Smtp-Source: AGHT+IF3dwLhw+e/o0qfed9nEtP3xJRw+spP0XhUKsU8BuyPQHfkD7EagVCzLMFin5AoJo1xAEKChA==
X-Received: by 2002:a05:6000:4027:b0:392:c64:9aef with SMTP id
 ffacd0b85a97d-39efba473b3mr14285002f8f.20.1745404801166; 
 Wed, 23 Apr 2025 03:40:01 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4a4e9esm18717609f8f.96.2025.04.23.03.40.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 03:40:00 -0700 (PDT)
Message-ID: <16276eee-1d69-4903-a15d-25b7679dfc94@linaro.org>
Date: Wed, 23 Apr 2025 12:39:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 122/147] hw/arm/xlnx-zynqmp: prepare compilation unit to
 be common
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-123-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-123-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 22/4/25 21:27, Richard Henderson wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Remove kvm unused headers.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20250325045915.994760-28-pierrick.bouvier@linaro.org>
> ---
>   hw/arm/xlnx-zynqmp.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index d6022ff2d3..ec2b3a41ed 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -22,9 +22,7 @@
>   #include "hw/intc/arm_gic_common.h"
>   #include "hw/misc/unimp.h"
>   #include "hw/boards.h"
> -#include "system/kvm.h"
>   #include "system/system.h"
> -#include "kvm_arm.h"
>   #include "target/arm/cpu-qom.h"
>   #include "target/arm/gtimer.h"
>   

Included in commit 2a0ee672c9f ("xlnx-zynqmp: Use the in kernel GIC
model for KVM runs") for gic_class_name() declaration, but not
necessary at all.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


