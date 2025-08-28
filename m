Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A574CA0FF2
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 09:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urZ4p-0000l4-J7; Thu, 28 Aug 2025 05:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1urZ4j-0000gT-GM
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 05:37:46 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1urZ4f-00083v-KN
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 05:37:43 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-327b3e24637so253401a91.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 02:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1756373858; x=1756978658; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZNqqbmsJO3IFpQkWwKrQ4GThmbM/ferEW/+t1C2XHN4=;
 b=iI5E7ahIf6YPvh4yX5l7FXMTzFskkfauDBBufG3+b5QIfwxpTUx8X5ghnzejRiOfOf
 BKBLEUmnov0w5x0D+whp1KgslNVzrc5Y+aRI970M/ybDgVBse48wkS3ScuE6FPfJ5LEZ
 6KRgdo/EGoShWMyteiuyjzN1F28xvvzR1RRC9IkN6iUZH43oiHzan3dXf2WdrsmxNVbB
 RLs7OrjH3Keq1peoxg46msCZZVLKPexGrejhd85u8qWDS2Em8NecfXq0eZ3PrBGyHgSM
 Gi3GtvgFGul3Anuccd1V/PypCm0ar9I/Yo73q0fZjHnnco45r7ZAhldLttwPpjGfP21c
 nhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756373858; x=1756978658;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZNqqbmsJO3IFpQkWwKrQ4GThmbM/ferEW/+t1C2XHN4=;
 b=i1E15GqKhFKq/YznbGUSfuNLGfv7zFkPjRWlicN/8qcJuhhuJYkHTEcbO8EFLPTYMw
 iYyAbyIxcrEbFDpXD0S093xGoPQH9SjORHemmvfjpEAut+Avg9YA8Xr3vKBwP/2jf9hk
 g345v/gEdExL6JKONBVpLyeRKEs1NP2Zn+rMUB/3/pW8VacoEdVOei3PZRSyInnOYBGd
 7Vk+8dpTX2oScXjTZU1Djgsc/G2E/5GZbxS+i/A3K3b9YCMwSBoGB08f4Lj1g+L7DG5o
 xvtFdbKPHIRuCL+PEGZaomzT3hYryRuBxfje4j9rNg1o5nqTE11n05dEW3BzjS3z/+Zh
 i7xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDqwpDKpUQcBKWzdxU/8l0JYgUvskegW1RkIZIQu5NkHLXNcMrzMWwM20jZ/6aV0KxQCceBL9mThZL@nongnu.org
X-Gm-Message-State: AOJu0YydrvpCyziRG1EPdaE5IVasKZ3Meo87gvaLtyyG4QzbtMt7Dz8+
 dgXFAzjb9WJwSU1ANVHDtSGPL3JEbWM3/NnRCjH2DsS41/1nMWCCCiZAw+p+vi1VaLs=
X-Gm-Gg: ASbGncvzD5PjiWD02qfdR7cfvMDI1jQxEf/Ra8GmEgxVu9KG4gD+M1BknyX8kGAnNwc
 dJL0OpbZ5bNZbd91QH3/9NnQrY1V89Pg8RojHXtl1+P+0LEqPB99CVPQCt6WFPiOoCKL52ApLfK
 uiwCNkQSxdy1mPXQjdbNLVxMUzUfyqWTvey8xZRdQe0iQhENDTWPQT8HHSJxIVPzDambDfQFj3K
 SV9FnbERJQIeRgnoQGNNwAd/6uIw+ZkCQTnSlcQupK8EfcOddhL/87tfPluOWZGZWr+BmvlYv8p
 tblbFepkS63m6+iHWzd08fgiNGEw7cZTECmZg2bO+owOJWZr/JSp/wqZqjYLTvs2HDxtHrF3Dif
 XD1RLyEfnKSn64dJJxuHZGT9RTWOZWH3gKL1fUctkaiTdo5qe
X-Google-Smtp-Source: AGHT+IHlFmLxsz86hfiUnOiwYwNPhDio0ujdoM63z6vAfv55uUUmwih3hjAWqJtLoKwCKyV/V0n6pQ==
X-Received: by 2002:a17:90b:5644:b0:327:70b9:9d68 with SMTP id
 98e67ed59e1d1-32770b99e1bmr6964846a91.16.1756373858478; 
 Thu, 28 Aug 2025 02:37:38 -0700 (PDT)
Received: from [192.168.68.110] ([191.202.238.136])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77210e226a8sm2794141b3a.33.2025.08.28.02.37.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 02:37:37 -0700 (PDT)
Message-ID: <dccc6ea0-d173-4a55-8c69-9313e2accbff@ventanamicro.com>
Date: Thu, 28 Aug 2025 06:37:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: use riscv_csrr in riscv_csr_read
To: stove <stove@rivosinc.com>, qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20250827203617.79947-1-stove@rivosinc.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250827203617.79947-1-stove@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Cc: qemu-stable

On 8/27/25 5:36 PM, stove wrote:
> Commit 38c83e8d3a33 ("target/riscv: raise an exception when CSRRS/CSRRC
> writes a read-only CSR") changed the behavior of riscv_csrrw, which
> would formerly be treated as read-only if the write mask were set to 0.
> 
> Fixes an exception being raised when accessing read-only vector CSRs
> like vtype.
> 
> Fixes: 38c83e8d3a33 ("target/riscv: raise an exception when CSRRS/CSRRC writes a read-only CSR")
> 
> Signed-off-by: stove <stove@rivosinc.com>
> ---


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


>   target/riscv/cpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 4a862da615..dca8edff6d 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -873,7 +873,7 @@ static inline void riscv_csr_write(CPURISCVState *env, int csrno,
>   static inline target_ulong riscv_csr_read(CPURISCVState *env, int csrno)
>   {
>       target_ulong val = 0;
> -    riscv_csrrw(env, csrno, &val, 0, 0, 0);
> +    riscv_csrr(env, csrno, &val);
>       return val;
>   }
>   


