Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C971C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 01:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7m2s-0005ur-3C; Thu, 16 May 2024 21:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1s7m2q-0005uZ-0g; Thu, 16 May 2024 21:06:00 -0400
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1s7m2m-0000on-DA; Thu, 16 May 2024 21:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1715907942; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=eD5J0NZeEwo7qcrWq7uuHiPkYV62U+eoVLnoahoGqbw=;
 b=UP/DVPIaOQC+wZpj6iUzQNwuqTQbV5SUCoXhEKF1OlA5dWjVP3ecNsYybnCGuEr7T2FkLcnmiLnlePA6l6uKKRFksz7lfsBQUfS29Bi0M+NgiXpf3xmcLghYtnoPOzHCvhD+8zSUXlSyZGLIJH8Rv8u79P23/xynuQ+555jQkU4=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045075189;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=11; SR=0;
 TI=SMTPD_---0W6cmh59_1715907939; 
Received: from 30.198.0.221(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W6cmh59_1715907939) by smtp.aliyun-inc.com;
 Fri, 17 May 2024 09:05:40 +0800
Message-ID: <f3698a82-0760-4d7a-b5d6-0188d74e2082@linux.alibaba.com>
Date: Fri, 17 May 2024 09:04:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] riscv, gdbstub.c: fix reg_width in
 ricsv_gen_dynamic_vector_feature()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, palmer@rivosinc.com, akihiko.odaki@daynix.com,
 alex.bennee@linaro.org, mjt@tls.msk.ru, Robin Dapp <rdapp.gcc@gmail.com>
References: <20240516171010.639591-1-dbarboza@ventanamicro.com>
 <20240516171010.639591-2-dbarboza@ventanamicro.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240516171010.639591-2-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.119;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-119.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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


On 2024/5/17 1:10, Daniel Henrique Barboza wrote:
> Commit 33a24910ae changed 'reg_width' to use 'vlenb', i.e. vector length
> in bytes, when in this context we want 'reg_width' as the length in
> bits.
>
> Fix 'reg_width' back to the value in bits like 7cb59921c05a
> ("target/riscv/gdbstub.c: use 'vlenb' instead of shifting 'vlen'") set
> beforehand.
>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Reported-by: Robin Dapp <rdapp.gcc@gmail.com>
> Fixes: 33a24910ae ("target/riscv: Use GDBFeature for dynamic XML")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Zhiwei

> ---
>   target/riscv/gdbstub.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index d0cc5762c2..358158c42a 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -288,7 +288,7 @@ static GDBFeature *riscv_gen_dynamic_csr_feature(CPUState *cs, int base_reg)
>   static GDBFeature *ricsv_gen_dynamic_vector_feature(CPUState *cs, int base_reg)
>   {
>       RISCVCPU *cpu = RISCV_CPU(cs);
> -    int reg_width = cpu->cfg.vlenb;
> +    int reg_width = cpu->cfg.vlenb << 3;
>       GDBFeatureBuilder builder;
>       int i;
>   

