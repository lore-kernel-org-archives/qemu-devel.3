Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF599C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 17:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trgpv-0002aJ-RW; Mon, 10 Mar 2025 13:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trgpt-0002Zp-8F
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:22:41 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trgpp-0002WG-Uf
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:22:40 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-223378e2b0dso65832685ad.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 10:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741627355; x=1742232155; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KN5+NLKKTk5ZZBMsXEI1c+8LzaCeg5hjAmGjXHvj0u0=;
 b=DyKz5X3iVNMj9JO2jwpf9e4JoAPuQ+8v+3TDHu6LqzUzucp/c94mTTEMtFXiaR0iKl
 HHj//UTm6bWZnN46sYW8c3jBSqm9YRAJfKs5KmztRASYUhRti/mcPgnkNFgJsDsIc/wx
 IGOz9QhiuguJ8VIisbOL/3IHBMaiaXVcGdxN/LRpTV7jppgiWhXvg1N5+LKCouo6hl0T
 Zld04Cij4KUjf75N1HQrFC7UuczlTmswto7lCq4ktGPgUMWnaiSsFQa2f8DdJZwdS/gh
 BdVyhVK7oUEbKzBh5B4Zokj6J18BJPKfTkRdyYfPAZkJWha7uuXxhEVDIxG1pT6aWiBB
 Z5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741627355; x=1742232155;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KN5+NLKKTk5ZZBMsXEI1c+8LzaCeg5hjAmGjXHvj0u0=;
 b=UNQOH0toOYmTrDfn7l5Z3TmuvHAqr+eua5bSpXvzPeZFpUx5Vy5DfNXrnZC8Ik7vo3
 tH7FIYnkWjXNgIlsK6HG5gZ031D+VCsc9KjGr3Whw7nmDrJL8DiU8HnveyYaU/EJm/W1
 xRXmtQUfQ8jrZYt+SHrNTT8eQIk//vTgY9X2xDnD2EPAopi20SYQiMxVyKhrwuOCGz6V
 fNpBr7dWYHVdg8wjYrj0fJjdfWqFNr0LNKZImiNzd7Q0gCnN1KJIr496thRVbMeo7bC3
 qNTA07PGWmrwAkDXq65jI15C9JrqEsWWhlauLcIqWKTd1lQ+6DY73XjgjFfesSxxVkRb
 TAog==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2AQMYpbMpyErjnNr6Dq6iFeXxPfz5b5XJ1eWFeNe43WVZLwWgZ4ffdWikc0L+mAO7oaKT9wty6T7c@nongnu.org
X-Gm-Message-State: AOJu0YxE61NXsoubHCOdYsJqMqG9Pjjw6ULKmdNYnQX51lZLirCS2FhZ
 Tj16JsCNPMclDXwzTu5sEMsFETt88KDeGLGEYdPsz0X3nRXTgaEyZVOkMr4z+BU=
X-Gm-Gg: ASbGncunVx4rVK1kbX28PqrkvZhr0PZlkBSa5RvoWri7wu36dVOOf7ZqqstEzp4g03G
 uh3j0iAMagvmk1HEoZiezTJdT2519AG4KfabrKzSlaRJ4v6QahVX8nMZ0/0J66JdkBN1XQh/Hrg
 YOW5wte5iG3jcISmV5NLkwVM4SBN9VGVJVpeVgKlhBXLYRSxJ8QUAHYT3cOL7mfHbl1D+8nkNVf
 SJiAwkbqvobuwnI3xEWhigliCgxRUGJJ7sNEwLZKNGl2alP5OVgGNeJtmklVb7jbI0BkA/o/Fa9
 qdyUpBsSX8WAnZce3TH8YbqSRwbOJ2NxoNt2Jalm8Ln2AK748JXXTxWoB77pnkjdUJzoeM+YUwz
 gpiDsqjhBvnBMIzOIVfk=
X-Google-Smtp-Source: AGHT+IFxqhLusz/tSQ+2ETe6S2995DHvt1TyMbIAzbh4cUsuhYZoBWdT74s17YCjDRkiHYpnyZuyvg==
X-Received: by 2002:a17:902:e745:b0:223:fdac:2e4 with SMTP id
 d9443c01a7336-224288868e5mr256070315ad.1.1741627355356; 
 Mon, 10 Mar 2025 10:22:35 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a91cb0sm80827045ad.184.2025.03.10.10.22.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 10:22:34 -0700 (PDT)
Message-ID: <2d5e8e5f-e908-47a7-b127-698721f7bf0f@linaro.org>
Date: Mon, 10 Mar 2025 10:22:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] codebase: prepare to remove cpu.h from
 exec/exec-all.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-8-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250310045842.2650784-8-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 3/9/25 21:58, Pierrick Bouvier wrote:
> diff --git a/page-vary-target.c b/page-vary-target.c
> index 3f81144cda8..12fda410bb0 100644
> --- a/page-vary-target.c
> +++ b/page-vary-target.c
> @@ -20,8 +20,9 @@
>   #define IN_PAGE_VARY 1
>   
>   #include "qemu/osdep.h"
> -#include "exec/page-vary.h"
>   #include "exec/exec-all.h"
> +#include "exec/page-vary.h"
> +#include "exec/target_page.h"

You can remove exec-all.h here.

> diff --git a/target/riscv/bitmanip_helper.c b/target/riscv/bitmanip_helper.c
> index b99c4a39a1f..d93312a811c 100644
> --- a/target/riscv/bitmanip_helper.c
> +++ b/target/riscv/bitmanip_helper.c
> @@ -21,6 +21,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu/host-utils.h"
>   #include "exec/exec-all.h"
> +#include "exec/target_long.h"
>   #include "exec/helper-proto.h"
>   #include "tcg/tcg.h"

Likewise.

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

