Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD42E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 21:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLUbA-0005nN-Rs; Wed, 11 Dec 2024 16:50:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLUb4-0005lN-3D
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 16:50:19 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLUb2-0007l0-Hw
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 16:50:17 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3eb441c2f28so1104328b6e.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 13:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733953813; x=1734558613; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zytopXsjfKW0YG03hiqlTIupNrqbCSYJESIoPoUDkmU=;
 b=Km2uRzup76XamzFAQHmYc8J3mmMzl6TenWIvGGyg4Cq8shv11Y9dNFA2ODAXYlyQ0U
 QLCdWBJThN/KDqoJCoW9360/qVsV14FqOYHe0UGONYpoQkNRVBXmWgQNkL5e308++5RW
 HU90Gl7Xih3Dyf3urR1JQYoRxQWgxdi7C/ZD/8F7EE0MvIJY0YJZL47ytV2Xi6gtsoHa
 5WnBm2HZiWVDLjVC4xF1BDv6pNNnobxO7onu0FSlyJOkTYUQcBda6T/yh0SnaHB8FTs3
 vX/uwfxFCqy5dgofJ4S69OnU+DCThxo8qwgQijw7smgT546Bl9rNYBzp2ts/4zBdS0NH
 4jvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733953813; x=1734558613;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zytopXsjfKW0YG03hiqlTIupNrqbCSYJESIoPoUDkmU=;
 b=C5WPqQKB42CnZHB/5HJEZ7C/X+yGR1u4Jtf2C6qIFRl8hpBxPyHkmaoODhzpkKvwEK
 1CTAf+K30oetkDk3LVIVr9hno4MeI9a4Ei5CwEtuVGNRnECEwBAggYktIorgcqu5/eu4
 2OtFgPk0DdKe3Qq2EPmlcvmfTl8W7JQ/sBOyYPZYv5oVebvy1DC9qoIu1TWXOw24l2Ul
 /T/SymxRHWTnNuhOb8Jpm6nvBy+f1ZCs8+FoShdcGVd91mE2KThOoN5oghYvdkqVq5Rx
 6Cbcg2y9BTp7gAdHftUkzGIgdH2fNrIUQzr90l+JKL6b/hZN7Ptp+NsJ6Nu+BPLaR6ap
 gSAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXXrS40pMkZpd4cV5AB5PhRug77cu3egO6kVLr/TmOtR7okfFFMFpgzfslCeqnDYp5ow/Ef4PNL1A6@nongnu.org
X-Gm-Message-State: AOJu0YwtUFJXIXNIJUa07n6hBaSronUYWRDXb+SQVYhtc6KCDwe9y82+
 qJBKuqB1WdefWawu/HC+ci2nvadbitoO28BXw53GPvjU9SdNBferU0CVy8NEMBY=
X-Gm-Gg: ASbGncujXoYNtQpY+wLdrmyZqFjYa4xVlYaxFVohE3E0zI/1SVW/E1iTMcw33j4i2S3
 sadjiDHN+NvnMUOgv8DGU9e6B3Q4RmYtbCr4XHy9STqEl2AFIqkFr4KdYahV4tu4IpPAefbJhG8
 DRq9sDELS4lbQxsPGnjP2falyRCBSx8hkJ7273k8xhS3jPt3LwO1Qcz2YIVIlPmX+4IDOmdwXvr
 cwNS7ikSghKHDZrrpx5EQBmKVStEZlHiATd301VtPeAy5KgO2c3dBfdhCcLbeVJDrACrVQgw5fC
 EUG7zO/gAuMYUBj1eamkDdh6gjUvSJ4k
X-Google-Smtp-Source: AGHT+IG4p1MtyLJMwBx+zn7XHkMwxIVTdEB9/0WqrRKdhmqd47m5dJwl43ymxmO4h6awwNFrFH0gPQ==
X-Received: by 2002:a05:6808:f8f:b0:3eb:5cdb:f47f with SMTP id
 5614622812f47-3eb85b422c6mr2161229b6e.14.1733953813326; 
 Wed, 11 Dec 2024 13:50:13 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb8184b93esm681160b6e.43.2024.12.11.13.50.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 13:50:12 -0800 (PST)
Message-ID: <19c34ee9-f121-4dc2-8c73-2d06333a7d27@linaro.org>
Date: Wed, 11 Dec 2024 15:50:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/riscv: generate misaligned access trap for rvi
 insn
To: Frederic Konrad <fkonrad@amd.com>, qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, qemu-devel@nongnu.org,
 francisco.iglesias@amd.com, Luc.Michel@amd.com
References: <20241211211933.198792-1-fkonrad@amd.com>
 <20241211211933.198792-3-fkonrad@amd.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241211211933.198792-3-fkonrad@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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

On 12/11/24 15:19, Frederic Konrad wrote:
> Now there is an option to enable misaligned accesses traps, check the alignment
> during load and store for the RVI instructions.  Do not generate them if the
> zama16b extension is there.
> 
> Signed-off-by: Frederic Konrad <fkonrad@amd.com>
> ---
>   target/riscv/insn_trans/trans_rvi.c.inc | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
> index 96c218a9d7..1283207fc7 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -323,6 +323,10 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
>   {
>       bool out;
>   
> +    if (ctx->cfg_ptr->trap_misaligned_access && !ctx->cfg_ptr->ext_zama16b) {
> +        memop |= MO_ALIGN;
> +    }
> +
>       if (ctx->cfg_ptr->ext_zama16b) {
>           memop |= MO_ATOM_WITHIN16;
>       }
> @@ -424,6 +428,9 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb *a, MemOp memop)
>   
>   static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
>   {
> +    if (ctx->cfg_ptr->trap_misaligned_access && !ctx->cfg_ptr->ext_zama16b) {
> +        memop |= MO_ALIGN;
> +    }
>       if (ctx->cfg_ptr->ext_zama16b) {
>           memop |= MO_ATOM_WITHIN16;
>       }

I would imagine that ext_zama16b would disable or conflict with trap_misaligned_access at 
startup.


r~

