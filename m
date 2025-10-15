Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8F7CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 20:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v98PQ-0002l6-5p; Wed, 15 Oct 2025 16:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v98PO-0002kb-Jn
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 16:47:42 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v98PH-0005ha-Vq
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 16:47:37 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-426edfffc66so1020882f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 13:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760561253; x=1761166053; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vSwPULsQD7VLuV1SvB+GEFhB3KvNAvneyy25czbHzq4=;
 b=FcV9yb821py5jzU3SniNFy96azaZvJfVRwSA4nwg3cgnP6v+IUm59XUyyiVOE469lo
 BJRKG+SWHjP8YfimAheyzfAyaE0+zIvmgClblP8k0Qo9OjEptIo1kwDDBHV2UOIZO1zu
 IkuHcbiJsuq4TX667tfAhHB2t3tR0C43gX/tsjL5UueT49FtEkzGkCbzOMI7J3UW+/gh
 ivSFsMcy1SIDwUOlyzeBCVeatNOfUVNeWVib/wERB6vhVgtLOgVNaVdjqJVCqXVgM7pS
 LG/+oHw766b1WEBlKuS1mjubNcJafL9/zZhxASxYPdP9o1NyhnwQaCUval6NJFRjL9KK
 Z5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760561253; x=1761166053;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vSwPULsQD7VLuV1SvB+GEFhB3KvNAvneyy25czbHzq4=;
 b=O6YR5v0lv4HZtePMzEvOjoT3xo/wnzT8WD66rrHSzigH53WGyvI/ExoT8NQePYETig
 VqJ/q4suHYz1wM1krVwhZN1OKjrgwynCBM9p+p0vETvTqiH7rVqeNDQnvT230E0o691f
 KDOeGRneplrsMErD9x58UKlRnRHBGHV+t3FqKFAXzGLVxGVWuij76E3MsRbrLQaY9Icx
 pmUMdWQ6btMt2Q1BJQimUgwXVi7sOV8T9+aU/S6bOOYqwAEnyoBt+tW+mFUOHxqbW2iR
 vBjfHu+NB71Wkq9Uhm0qzhwwGWaz1PyAOYpMngauDZJfUMYSYNurMEdaETg1b+6ykvb9
 kDqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpRTWosjdKr8GwCOiWBOhyZOLZZFh3VnnWGELnV6u/u+IUersEM6NH+g4PudcCR1fYg1U+ct29UfN/@nongnu.org
X-Gm-Message-State: AOJu0YzeCG7GcujuMis32HEO27Et0GVjURxnCC6UKqhbVYNKW4xLaUa9
 MLOn7bm5gz2vp9FZ9u/+dFjhJix/9ewKZ/UprD2Sun2LUA3lgcx8KsGQSqpcQPIXydI=
X-Gm-Gg: ASbGncsT79y+vklndBUs/N1uaw0NoC6hijym3a+XueiNcEa3ZcF2HeK1vK4+BESJyiV
 5BwnnjW9Viz9e4wP4b+PxVR8DbQN0gXuCkzt1UWipwqB6jse8rj1o8htCi5YQhwr0EyvbcdLVlx
 2wGeVAyH+dFRg60MwlrUAwyzp1R7y60nXYtBicKeNFZoouPyJwoGwetiZ++/kiigS5BUk3y/skZ
 3BNup9l4trzHr0lD3z3zvA1NqdWwe9P0uVmLqg56SMcK36GQxJTrwXt5OFeY9VCZ1usGWk24xC7
 lcb980MMPjoUzUA7t0+u6iWxPZs1Ke1NN6cZr+ZkPOGAIKoLdZyOmBvAcChijHXdBstgEsT4kdE
 7nc4J5YbW2UII+n1GXYk+LDsjamCBUlPCU8ppAb39pVvhiShyvtSgKzSfPYoPrfvyaokvUoS/QZ
 b7aoKvYl7zYgc9JqHhHVaXmAw=
X-Google-Smtp-Source: AGHT+IF48V1gPtKIf1KyVAjt5u/AEYA5cO4nM0/MgQywp04WdW8i7J7ptb1g3rJ4Tx/8VDyVXBVEpQ==
X-Received: by 2002:a05:6000:1843:b0:3f5:3578:e538 with SMTP id
 ffacd0b85a97d-426fb8b7789mr1110054f8f.21.1760561252729; 
 Wed, 15 Oct 2025 13:47:32 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5cfe74sm30497262f8f.35.2025.10.15.13.47.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 13:47:32 -0700 (PDT)
Message-ID: <8c5b223d-2095-481c-aeff-ad9517c0a7af@linaro.org>
Date: Wed, 15 Oct 2025 22:47:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 31/34] target/riscv: Move debug.h include away from
 cpu.h
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251014203512.26282-1-anjo@rev.ng>
 <20251014203512.26282-32-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251014203512.26282-32-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 14/10/25 22:35, Anton Johansson wrote:
> All debug.h definitions except for RV_MAX_TRIGGERS are internal to
> target/riscv.  Move RV_MAX_TRIGGERS to cpu.h and include debug.h from
> all translation units which relied on the cpu.h include.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/riscv/cpu.h         | 2 +-
>   target/riscv/debug.h       | 2 --
>   target/riscv/cpu.c         | 3 +++
>   target/riscv/csr.c         | 3 +++
>   target/riscv/debug.c       | 1 +
>   target/riscv/tcg/tcg-cpu.c | 1 +
>   6 files changed, 9 insertions(+), 3 deletions(-)


> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f169eb4bba..f4dd3b48d5 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -37,6 +37,9 @@
>   #include "kvm/kvm_riscv.h"
>   #include "tcg/tcg-cpu.h"
>   #include "tcg/tcg.h"
> +#if !defined(CONFIG_USER_ONLY)
> +#include "debug.h"
> +#endif

For target specific header, we prefer the path relative to $srcdir:

   #include "target/riscv/debug.h"

Otherwise,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


