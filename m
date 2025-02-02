Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7AFC0218F
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2025 22:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tei50-0005kp-56; Sun, 02 Feb 2025 17:04:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tei4y-0005kQ-GW
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 17:04:36 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tei4w-0004xk-Om
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 17:04:36 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2efe25558ddso4614643a91.2
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2025 14:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1738533872; x=1739138672; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=r/4P68+8VYI8SlmvuLMztsv2GjTHFmqq0Lz3EhmItok=;
 b=aDqdoaxP10Ly3P5qDRAi2/vQGPsWM3+6IS485wRDHsdnbWEEZH+AFjrWEgSf3FOE5F
 eYgAY/L8QAC7ZnqgaGztfLV6zbUDnElnpUMsTE6MonRm/c2cicYOWj1x0m4HaQK37clE
 Pd9b9oUsR11N0mi1/FcFoCtcRiBY0AhhrSmTPndQqpcZb60lIg8lGrjX0TLkX0pDTkX/
 tewQDyDvpz5KuKep18bs8ykYPiiQgcDJ6nqV4oLVQMt6QbZplPJbI/EQSnu/yGHOjYKP
 F8zVbBrl9EIzcQM7KkPNDlrnTKvuvssgxvjdIGdXO/DPRcJmOU3JqEhs0ogXK1bHhVeS
 P0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738533872; x=1739138672;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r/4P68+8VYI8SlmvuLMztsv2GjTHFmqq0Lz3EhmItok=;
 b=UCNKfERsc06OKPa+atiq2VUjICeXfWiejjeiKR+N2+yhRrsRgbNjuOKMuh7oZQcJCi
 Q40WcAnOciR82fgbpVVILmRYPIurSssNgSxDiOeIUHQI+1jdtefTVOXZlJiSbCIB3rf1
 33G2zHzrnHvvZR+5iKSgOLE8qJKqdt2fKyBhTbpbR2wgAEieQ6ZABegbjjx5hf/PMuPM
 ephgI8AA85H1UjeJA/V8exxptQGz6DaziW2oDVQ3gZ4eUidI5LELIYunNmYZhIMabLAf
 BiC6K9nOj/hRuutd1mEx4R6AVSwtqC8Fcn4UU0q5ubAGItiSFwLLe+vJheFgKa3HSHbH
 Uvig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrMEsP8dKUkUwgok51et59YoE2td5OgLgXvLO49FjVovgUgovPDKPJmcu5Wq6jhqEjGeEyGrhiHzfG@nongnu.org
X-Gm-Message-State: AOJu0YxF8mnVx8E9HSLH1oy2Dq0DNYYFYbhe6NV7qCClN1iOdQXf7LW2
 bmJaTz4a63L7nBqVcrrofskQ5X3BhOAAYlDzkbrZYJoY+bOave5fi7oV8C+oPFo=
X-Gm-Gg: ASbGncvQYmtB6s0ox5IycGZeSEFrvFXIns73em2T6/PpRGxJHp6x7bDD7o8b7gcBTw2
 jmuGApD/QQ6pR6VA1hTF5SN0lt7WOXL5LzqJy3J0Or1lvxQ0yz7ZD7Ia/0+b/k024sdN+tSAXje
 YhqPhmZHIK0AYRMbnW3FMyr3wCiXiW3YCwoYa9qiEBvI0Y/iitQLX37Noqbs3isLFqGBsbntvVr
 zIILjioySVaPQyKrJEDqMm3mmuIHloeXP8L8bcBVTsoYaFkXYvBUny9OlkgWA8JqlP3r5RCaWNd
 Wv25J0IuvSKftjLrKcYeo6Xq7ksM4WI=
X-Google-Smtp-Source: AGHT+IHxSq9fqsBvD/uBGmI1dsYZDRP4Apn8xooLpjBsQo/xO5GV4EiHFST5Ht0luZMNoCjV3c08tw==
X-Received: by 2002:a17:90b:1f81:b0:2ee:bc1d:f98b with SMTP id
 98e67ed59e1d1-2f83ac8ac3amr26112942a91.31.1738533872084; 
 Sun, 02 Feb 2025 14:04:32 -0800 (PST)
Received: from [192.168.68.110] ([177.170.227.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f83bd09ca3sm9826244a91.24.2025.02.02.14.04.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Feb 2025 14:04:31 -0800 (PST)
Message-ID: <b76bf940-ff55-4619-a9ae-fa65c47e864f@ventanamicro.com>
Date: Sun, 2 Feb 2025 19:04:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: Re: [PATCH 1/1] target/riscv: log guest errors when reserved bits are
 set in PTEs
To: julia <midnight@trainwit.ch>, qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20250202051505.1846933-1-midnight@trainwit.ch>
 <20250202051505.1846933-2-midnight@trainwit.ch>
Content-Language: en-US
In-Reply-To: <20250202051505.1846933-2-midnight@trainwit.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102e.google.com
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



On 2/2/25 2:15 AM, julia wrote:
> For instance, QEMUs newer than b6ecc63c569bb88c0fcadf79fb92bf4b88aefea8
> would silently treat this akin to an unmapped page (as required by the
> RISC-V spec, admittedly). However, not all hardware platforms do (e.g.
> CVA6) which leads to an apparent QEMU bug.
> 
> Instead, log a guest error so that in future, incorrectly set up page
> tables can be debugged without bisecting QEMU.
> 
> Signed-off-by: julia <midnight@trainwit.ch>

Usually the author line consists of a full name. You can set the author name by
using 'git config --global user.name <full_name>'. To amend an existing patch
you can use:

git commit --amend --author="Full Author Name <author@email>"

> ---
>   target/riscv/cpu_helper.c | 27 ++++++++++++++++++++++++++-
>   1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index e1dfc4ecbf..87adf16a49 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1226,14 +1226,27 @@ restart:
>               ppn = pte >> PTE_PPN_SHIFT;
>           } else {
>               if (pte & PTE_RESERVED) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "%s: reserved bits set in PTE: "
> +                              "addr: 0x%" HWADDR_PRIx " pte: 0x%" PRIx64 "\n",
> +                              __func__, pte_addr, pte);


This will fail to compile for riscv32 (riscv32-softmmu configure target) with errors
like this:

../target/riscv/cpu_helper.c: In function ‘get_physical_address’:
../target/riscv/cpu_helper.c:1230:48: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘target_ulong’ {aka ‘unsigned int’} [-Werror=format=]
  1230 |                 qemu_log_mask(LOG_GUEST_ERROR, "%s: reserved bits set in PTE: "
       |                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  1231 |                               "addr: 0x%" HWADDR_PRIx " pte: 0x%" PRIx64 "\n",
  1232 |                               __func__, pte_addr, pte);
       |                                                   ~~~
       |                                                   |
       |                                                   target_ulong {aka unsigned int}
/home/danielhb/work/qemu/include/qemu/log.h:57:22: note: in definition of macro ‘qemu_log_mask’
    57 |             qemu_log(FMT, ## __VA_ARGS__);              \
       |                      ^~~

This happens because 'pte' is a 'target_ulong' type that, for riscv32, will be
interpreted as uint32_t while the FMT being used is PRIx64.

You can fix it by using TARGET_FMT_lx instead of PRIx64:

+++ b/target/riscv/cpu_helper.c
@@ -1228,7 +1228,7 @@ restart:
          } else {
              if (pte & PTE_RESERVED) {
                  qemu_log_mask(LOG_GUEST_ERROR, "%s: reserved bits set in PTE: "
-                              "addr: 0x%" HWADDR_PRIx " pte: 0x%" PRIx64 "\n",
+                              "addr: 0x%" HWADDR_PRIx " pte:" TARGET_FMT_lx "\n",
                                __func__, pte_addr, pte);
                  return TRANSLATE_FAIL;


This change is needed in all qemu_log_mask() entries added. Thanks,


Daniel



>                   return TRANSLATE_FAIL;
>               }
>   
>               if (!pbmte && (pte & PTE_PBMT)) {
> +                /* Reserved without Svpbmt. */
> +                qemu_log_mask(LOG_GUEST_ERROR, "%s: PBMT bits set in PTE, "
> +                              "and Svpbmt extension is disabled: "
> +                              "addr: 0x%" HWADDR_PRIx " pte: 0x%" PRIx64 "\n",
> +                              __func__, pte_addr, pte);
>                   return TRANSLATE_FAIL;
>               }
>   
>               if (!riscv_cpu_cfg(env)->ext_svnapot && (pte & PTE_N)) {
> +                /* Reserved without Svnapot extension */
> +                qemu_log_mask(LOG_GUEST_ERROR, "%s: N bit set in PTE, "
> +                              "and Svnapot extension is disabled: "
> +                              "addr: 0x%" HWADDR_PRIx " pte: 0x%" PRIx64 "\n",
> +                              __func__, pte_addr, pte);
>                   return TRANSLATE_FAIL;
>               }
>   
> @@ -1244,14 +1257,19 @@ restart:
>               /* Invalid PTE */
>               return TRANSLATE_FAIL;
>           }
> +
>           if (pte & (PTE_R | PTE_W | PTE_X)) {
>               goto leaf;
>           }
>   
> -        /* Inner PTE, continue walking */
>           if (pte & (PTE_D | PTE_A | PTE_U | PTE_ATTR)) {
> +            /* D, A, and U bits are reserved in non-leaf/inner PTEs */
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: D, A, or U bits set in non-leaf PTE: "
> +                          "addr: 0x%" HWADDR_PRIx " pte: 0x%" PRIx64 "\n",
> +                          __func__, pte_addr, pte);
>               return TRANSLATE_FAIL;
>           }
> +        /* Inner PTE, continue walking */
>           base = ppn << PGSHIFT;
>       }
>   
> @@ -1261,10 +1279,17 @@ restart:
>    leaf:
>       if (ppn & ((1ULL << ptshift) - 1)) {
>           /* Misaligned PPN */
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: PPN bits in PTE is misaligned: "
> +                      "addr: 0x%" HWADDR_PRIx " pte: 0x%" PRIx64 "\n",
> +                      __func__, pte_addr, pte);
>           return TRANSLATE_FAIL;
>       }
>       if (!pbmte && (pte & PTE_PBMT)) {
>           /* Reserved without Svpbmt. */
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: PBMT bits set in PTE, "
> +                      "and Svpbmt extension is disabled: "
> +                      "addr: 0x%" HWADDR_PRIx " pte: 0x%" PRIx64 "\n",
> +                      __func__, pte_addr, pte);
>           return TRANSLATE_FAIL;
>       }
>   


