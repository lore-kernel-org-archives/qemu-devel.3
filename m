Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BD9D6B6B3
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 17:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Cu4-0007C3-P7; Wed, 30 Oct 2024 13:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t6Cu2-0007BT-Lr
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 13:54:42 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t6Cu0-0006fW-U5
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 13:54:42 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2e2cc47f1d7so116652a91.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 10:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730310878; x=1730915678; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q0/AP20vmL68Bvii795PVUGfoyosM6ikp5RYWOpNf6c=;
 b=ZUn77vVqQMfwQG2NsWdU1tGbL7sKC9+bBUwqN0MV9GF7TaaRy1FZhYxJNVC+rMX1Rs
 3pbSJiChEKn/aPHMfJ4pMzKP6AyaxWzeL8wym0k6crhEiG1HWOCq/X6QTp1QLz1UJpyo
 MQNUV3lzll2ccHCitKGdC1yMupRn3qxIDkZuoROwrAnTehmidIb73mSHRkKoBb0rlORz
 UMFQm8LARsWUD5hozINRvaT4c9DI5L8v90OoSXAnUChKA+qfXorqLRuy01J0giAQMm/r
 mSRum/mAfgo0Za35acZeGvVycgJ3JTI8+kyDZpmCxVd5BC5sNdSfpirDHX8+TzE0hPMw
 QwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730310878; x=1730915678;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q0/AP20vmL68Bvii795PVUGfoyosM6ikp5RYWOpNf6c=;
 b=IktLSX5xHqvLrhUc9NJ/vo3VV0iMLEkB7km6ctyfIwL5HPri5T3umhpoqb9hVXbHOy
 HTEYDxLLrT6ZG6fcLUMgYZPCbrJLIoGshqF9iX4bqHoJnqNBEWifdXAHwgLa06bz73EZ
 +0VwpAg+yyWNsXafRQLAkwsrqKi4cexDuPvKwrdUHIq5D5J7SH6LsKyodWRfXiq5YlV2
 5uJLzisAUCHyzKgSv3EY5fC5cuFmaeyt9XifRaxb/rrIXLvYTamZVmpRljuwcOKuf8BO
 Q0b3CLHy4TwIPuRTqkkrNJTscptXP3G82diCZkz8C95FyOXngOCSMGrX4qEw1lbP6Hhh
 oQnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+fHZeAiTGXndtuQY4/mcI+N7XjT2dJovfYJQfd1ADuYTZKxScY6n6qaMfm1J2+hZGR7zbMr+mB26U@nongnu.org
X-Gm-Message-State: AOJu0Yycs8DFdjDRGqU651gBUp3jK4ByefRRwXTOZ+q0x6BbpZJlw0WQ
 MbknxqXej3JZDxh8zDqb2XGdpXzbYe74X2Vvx77AbubLfkEX0yX9/RuJUJUjs+I=
X-Google-Smtp-Source: AGHT+IFJHPbyk9ode4EwAEDiOqeVY6+4w1Lmcz3JsxVk6B1slBGlWAYiBrP1dPNdDmqDlcQusokpzw==
X-Received: by 2002:a17:90b:2703:b0:2e2:b94c:d6a2 with SMTP id
 98e67ed59e1d1-2e9221928e3mr10609293a91.0.1730310878442; 
 Wed, 30 Oct 2024 10:54:38 -0700 (PDT)
Received: from [192.168.68.110] ([191.8.109.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e92fa634b3sm2096213a91.27.2024.10.30.10.54.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2024 10:54:38 -0700 (PDT)
Message-ID: <7a1640d3-e738-4044-b37b-ba05fbbf4111@ventanamicro.com>
Date: Wed, 30 Oct 2024 14:54:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: Fix vcompress with rvv_ta_all_1s
To: Anton Blanchard <antonb@tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20241030043538.939712-1-antonb@tenstorrent.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241030043538.939712-1-antonb@tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102a.google.com
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



On 10/30/24 1:35 AM, Anton Blanchard wrote:
> vcompress packs vl or less fields into vd, so the tail starts after the
> last packed field. This could be more clearly expressed in the ISA,
> but for now this thread helps to explain it:
> 
> https://github.com/riscv/riscv-v-spec/issues/796
> 
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/vector_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 072bd444b1..ccb32e6122 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -5132,7 +5132,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
>       }                                                                     \
>       env->vstart = 0;                                                      \
>       /* set tail elements to 1s */                                         \
> -    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
> +    vext_set_elems_1s(vd, vta, num * esz, total_elems * esz);             \
>   }
>   
>   /* Compress into vd elements of vs2 where vs1 is enabled */

