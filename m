Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB62C369B5
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 10:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4HGI-0008I7-3l; Mon, 14 Apr 2025 06:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4HG9-0008Gt-08
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 06:41:50 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4HG6-0006pc-Vx
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 06:41:48 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso34345095e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 03:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744627305; x=1745232105; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WJmSUqu4/wyH3LbStDr4VqeqU0bzGwgTmENUKvepGMU=;
 b=pP2XckdsVWkR583xiNlQucqnjhM6gg/bq46RqqkfhkwSLQPPXBkqyj6uZaF36T2/rt
 vblThNdWcFluDyaoDY9f1Aigu3kTh9likWhxfMIqQTBrxCz/o3d61NqNi86MSGXVZrS4
 G2RwPTI2QQ3lT87cEFqMmPEswY2WU6OAlmYNq+2lu55li//9OMKc4pNiNCTJRCkjxQBS
 lbg9bomgCMlpkltiY2F4cRdQwQaiPkrxrHnGQoCokH2XwpK6aOjmSr4MEoX+gC0Bh+PS
 l0Fb0u4UZYT38EDhIMlSdsQlwxOfcSxushk370tYL/qsqyaWc8nPZxhbcPUT7boq5MUl
 XhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744627305; x=1745232105;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WJmSUqu4/wyH3LbStDr4VqeqU0bzGwgTmENUKvepGMU=;
 b=DkHM3aLlxjf98+yVUXPox06cAlfYdq3GX4DCNNGzPCj5CY39vhmQRf9z9FSQoFhbTv
 XFxzic0Bfcr2ULxYhYPEvuOJAYuQSleO4e4ZeG/OyR6B5ypgNBbk0FFktmwtkTuOaasc
 BJkvdFdGFuvG5gQ7EjakYuvGf3q9iSfk2C9WUoEvktby22X+8tbTSKsVQWkqBPVy78fY
 jHaAq6mXOHhrIf+5dYuJi+MvH6VY9i6zVT0skjyAWfKdzPuUmbjMmgAaDpXwMeALfXBP
 ucgX4tNM3G145AoXsY3WeDo+a1r61od8bHhkFX5hHdBLHaRA/pnOzOgOFf9B2isuuq9u
 PjZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcvOvj9mGUodAhZ0vZlcr1xTmoLPuAqyIh+/nU/D2pBcMn8gmBIAASMWE8nYi74JN38v3ncApQc2KQ@nongnu.org
X-Gm-Message-State: AOJu0Yz7u9aTcVjemVGHJllYoHWcPkpKkmFSmB03GJe01Wvo0RThy9OH
 IQUwe0NnmikYMZCmQb4eEcbh/4iTUblrHRmld1UNT7LPGZKupBwy20i/ozk6TKk=
X-Gm-Gg: ASbGncu/J9rrFQFvX0rU9z5cR9qpQPPhajZk5qfXcRjkF6eF1/Zt8S0w580ryMKNNFm
 TxV4NHiSBXIGQVt9E1wSRyHyr96uoo33JFKcqnqj5MtFVWVPR6h0BtPEMW6E8YLAsLMVI3z2prp
 ll0P5Jq5vavhQFlVFckZoQTB4y+K7Rv0MAeTRQThqBKv+KQifbSMwGz6WDfWBb2A74YngzgQuy8
 HmYZQUhebERSI807JKCG5kI/ewqkRM6G9onrML/EZeKZ3AZZPwZRnIM8cJarRxr3QEuifP0GZJr
 0pQycl28zwC8NYCt78g+u+Ml5YBOk4na41MgU0Gl6bLB/qO+Sh9Z10LuE84Wm9G2u/LtQ3c50dc
 vc8RQsuUn
X-Google-Smtp-Source: AGHT+IFcW0DuYx1j0nJvQntYExNNkbpAiUyP8M98Yv8H6/mbVhKtShRj9vz6Q3zYmQFY9ueIByGSlQ==
X-Received: by 2002:a05:600c:3d86:b0:43c:f87c:24d3 with SMTP id
 5b1f17b1804b1-43f569710bdmr16207805e9.20.1744627304777; 
 Mon, 14 Apr 2025 03:41:44 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f2066d109sm177501265e9.20.2025.04.14.03.41.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 03:41:44 -0700 (PDT)
Message-ID: <3c9e1adc-eb4e-49f4-be32-b273a5a161b8@linaro.org>
Date: Mon, 14 Apr 2025 12:41:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] target/riscv: fix endless translation loop on big
 endian systems
To: Ziqiao Kong <ziqiaokong@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, alistair.francis@wdc.com,
 richard.henderson@linaro.org
References: <20250414034626.3491489-1-ziqiaokong@gmail.com>
 <20250414034626.3491489-2-ziqiaokong@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250414034626.3491489-2-ziqiaokong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Hi,

On 14/4/25 05:46, Ziqiao Kong wrote:
> On big endian systems, pte and updated_pte hold big endian host data
> while pte_pa points to little endian target data. This means the branch
> at cpu_helper.c:1669 will be always satisfied and restart translation,
> causing an endless translation loop.
> 

Cc: qemu-stable@nongnu.org
Fixes: 0c3e702aca7 ("RISC-V CPU Helpers")

> Signed-off-by: Ziqiao Kong <ziqiaokong@gmail.com>
> ---
>   target/riscv/cpu_helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 6c4391d96b..bc146771c8 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1662,9 +1662,9 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>               target_ulong *pte_pa = qemu_map_ram_ptr(mr->ram_block, addr1);
>               target_ulong old_pte;
>               if (riscv_cpu_sxl(env) == MXL_RV32) {
> -                old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, pte, updated_pte);
> +                old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, cpu_to_le32(pte), cpu_to_le32(updated_pte));
>               } else {
> -                old_pte = qatomic_cmpxchg(pte_pa, pte, updated_pte);
> +                old_pte = qatomic_cmpxchg(pte_pa, cpu_to_le64(pte), cpu_to_le64(updated_pte));
>               }
>               if (old_pte != pte) {
>                   goto restart;

If PTEs are always stored in LE order, maybe what we want is earlier:

-- >8 --
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 619c76cc001..b6ac2800240 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1464,5 +1464,5 @@ static int get_physical_address(CPURISCVState 
*env, hwaddr *physical,
          if (riscv_cpu_mxl(env) == MXL_RV32) {
-            pte = address_space_ldl(cs->as, pte_addr, attrs, &res);
+            pte = address_space_ldl_le(cs->as, pte_addr, attrs, &res);
          } else {
-            pte = address_space_ldq(cs->as, pte_addr, attrs, &res);
+            pte = address_space_ldq_le(cs->as, pte_addr, attrs, &res);
          }
---

