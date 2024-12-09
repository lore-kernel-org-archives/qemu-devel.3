Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1543BE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 19:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKjW8-0007Gv-5n; Mon, 09 Dec 2024 14:34:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tKjW6-0007FU-DR
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 14:34:02 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tKjW3-0004qj-I5
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 14:34:02 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-725ee6f56b4so1200947b3a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 11:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1733772837; x=1734377637; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9k9Pg+8y3c3UnD4hkh++q33Ep4J6N5eaCzFv/CJ1XXQ=;
 b=SOfXiJasxp1ZZcTfmD6Ac6p4A9dVm3RvE9zFyt78Qi6amhhHhPo1uBMtFzRcQK/0MH
 tLV9HchwNRjsFm/75qg8gfSmxSbjUcYCqlBU+H9wvWRXtpnR5FkLfxfRWZdIxavpoyv/
 CDjEp3TCvFNkoizxlNYs8wlS7YcYazaY2CbGRWxQzOLOftPirYlNvnxqnY/fTNJkVbPq
 FKT7oYh0SovBzTB2SRfym3LjRsSco87QaxTK4hNhF4Jh/05QFUZPjkIxMulOfT350jsL
 JO0Dmdkb8Cs4pRsakjU1KXyW9DBnVKicJZzpTNQScv1m7760Oc56lNgVwAuu3elYDaEi
 1qrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733772837; x=1734377637;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9k9Pg+8y3c3UnD4hkh++q33Ep4J6N5eaCzFv/CJ1XXQ=;
 b=mbVtnELVYTwUgvhOpbGLRTc+4Vhl6eQhKSFAUK6fuDp55cxhDhKwBUxNZxkfbl7rP0
 BtnSDNXHQShYS0vTDD4DXwhyAqnozablm5VQqXWbLSYhNVqN+bTC5QmNWnYT7Wu0P8ws
 HiPRGO+21x/9ee3/NYGovBJLEgXJxWkw801oedSMkJMl5f3kpT6eVB6quDy/g4E1jF8O
 SSraDnn5rxB9ot8dFOhtrpQUhwXXCHr84iWp0yMxtYXGP7N3TXRIN0XCH3qEcA0OrTR/
 bDxmdXLWcZLik4ItJDOAs14Zqg77ovbdSy+YU4210xTZ3mUKXGN1F+kvHgVpSBbxrNYM
 OZvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYNwdk3X8Uw0mRY8/raJ3hkZJQMmmyCbaf/J7/c/SFjjC3jZxqRQ/DIZq1Ho69jgZ4+fyJKo19RDbP@nongnu.org
X-Gm-Message-State: AOJu0YxgElSiPBBfs23g576fG8jiq9yrVAU2BN+nOTMdPhoYv3I9WIIz
 vPNJyrOSWIOx89Aum4LiQrTHiEs6vAzE6yGR/O7HxiTcLxy2sk4uiENcrPIwVoBvBaI/ygMS1mO
 Q
X-Gm-Gg: ASbGncusRlCSIAo0z1P3kuOS+dsxATU8VEBlCkiDVVQ+qknWoSuePavSV6ozblfo3YM
 jmqJst8v6MSLwsuZD82XGnWSNSlFl6uhO7Eue1HqIr61zhWS1GOqauY/VZFjkZMRDhAygfySMXC
 cUJ+pZl23fy5wSHK/oi8taA5zMMkTkak7vlwUBgaxTKKur9M5y4HbKK1a20c5wheQ+axO0Ry/5a
 SYGWK/8oScbgjHFXU/7kF0unyKrnryul8t6dR76XQPBZdaEFIWa4A0i9sJDL4Cwhaifuefvfcky
 Q8MbCT/cIMy4A4EGX8SaUNiNBzac
X-Google-Smtp-Source: AGHT+IGfL1Uh2J5eG5iR8/oZnE4ckhqCcaCENSziSfsgAYw3MN8tLn350cgtMsJ0gl+lbbXQoGQZrQ==
X-Received: by 2002:a05:6a00:b42:b0:727:3c37:d5f9 with SMTP id
 d2e1a72fcca58-7273c37d849mr2452909b3a.26.1733772837543; 
 Mon, 09 Dec 2024 11:33:57 -0800 (PST)
Received: from ?IPV6:2804:7f0:bcc0:5756:767e:ee4e:f9a8:ee18?
 ([2804:7f0:bcc0:5756:767e:ee4e:f9a8:ee18])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725e2f2d5f0sm3360965b3a.40.2024.12.09.11.33.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 11:33:57 -0800 (PST)
Message-ID: <9261868b-40a4-4ed5-a887-0b56fe0c8fed@ventanamicro.com>
Date: Mon, 9 Dec 2024 16:33:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/9] target/riscv: fix henvcfg potentially containing
 stale bits
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue <ved@rivosinc.com>,
 Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org,
 Frank Chang <frank.chang@sifive.com>
References: <20241128141230.284320-1-cleger@rivosinc.com>
 <20241128141230.284320-2-cleger@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241128141230.284320-2-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x430.google.com
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



On 11/28/24 11:12 AM, Clément Léger wrote:
> With the current implementation, if we had the following scenario:
> - Set bit x in menvcfg
> - Set bit x in henvcfg
> - Clear bit x in menvcfg
> then, the internal variable env->henvcfg would still contain bit x due
> to both a wrong menvcfg mask used in write_henvcfg() as well as a
> missing update of henvcfg upon menvcfg update.
> This can lead to some wrong interpretation of the context. In order to
> update henvcfg upon menvcfg writing, call write_henvcfg() after writing
> menvcfg. Clearing henvcfg upon writing the new value is also needed in
> write_henvcfg() as well as clearing henvcfg upper part when writing it
> with write_henvcfgh().
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


>   target/riscv/csr.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 5d8d0d7514..98c683df60 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2383,6 +2383,8 @@ static RISCVException read_menvcfg(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> +static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
> +                                    target_ulong val);
>   static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
>                                       target_ulong val)
>   {
> @@ -2403,6 +2405,7 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
>           }
>       }
>       env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
> +    write_henvcfg(env, CSR_HENVCFG, env->henvcfg);
>   
>       return RISCV_EXCP_NONE;
>   }
> @@ -2414,6 +2417,8 @@ static RISCVException read_menvcfgh(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> +static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
> +                                    target_ulong val);
>   static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
>                                        target_ulong val)
>   {
> @@ -2424,6 +2429,7 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
>       uint64_t valh = (uint64_t)val << 32;
>   
>       env->menvcfg = (env->menvcfg & ~mask) | (valh & mask);
> +    write_henvcfgh(env, CSR_HENVCFGH, env->henvcfg >> 32);
>   
>       return RISCV_EXCP_NONE;
>   }
> @@ -2513,7 +2519,7 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
>           }
>       }
>   
> -    env->henvcfg = (env->henvcfg & ~mask) | (val & mask);
> +    env->henvcfg = val & mask;
>   
>       return RISCV_EXCP_NONE;
>   }
> @@ -2546,7 +2552,7 @@ static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
>           return ret;
>       }
>   
> -    env->henvcfg = (env->henvcfg & ~mask) | (valh & mask);
> +    env->henvcfg = (env->henvcfg & 0xFFFFFFFF) | (valh & mask);
>       return RISCV_EXCP_NONE;
>   }
>   


