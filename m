Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79989C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 05:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sepDJ-0004Zk-1D; Fri, 16 Aug 2024 01:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sepDH-0004Yf-BC
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 01:09:23 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sepDF-0003Fj-Fo
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 01:09:23 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2020e83eca1so780575ad.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 22:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723784959; x=1724389759; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PqUdHDZ58haMc40q5KCHeB8MXoyG21bVQogvTyL2J1E=;
 b=KRLvdYlGMafdKsdVCpxx0BEt+NYk5dRxZjmW369+ABXgZaxByJ3ZYHYciVe2GBd3mh
 ir3RIdD9SPi+3A4w4dkWRohorbrzW4a8r5TarQ2ckIMIFyYKK2We4J4nevhbwHzGNT+R
 n+6seU/MyFw+jOWF0VZesNUlgWLPNdVeK50KJnNhyMdINSYU+7z1zVTwL4eli+nNQqvv
 CP6VZBbMM17dRqW+Q1lPA9CNsEKVYNumWL05BMmqqJ0uwxf5hilkCGmCyaEDUyoLw7bz
 kTVvGELLMWUtJ0r6UhQYLdGh4mrcurh180S/qyxw2Z1MOu4KPrq2sg+e5eRPrYbZzSMH
 MjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723784959; x=1724389759;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PqUdHDZ58haMc40q5KCHeB8MXoyG21bVQogvTyL2J1E=;
 b=R5v2ztZroG7fbh9Jk2ZCHY20FI7IuF3dHHB+/Kd/dQtfonVW+aUVvRxt1ouq6W6/RC
 Sporfnkr0NaPteQWF5rfwN9QEgHLP/P3Lw85mBP0ICS6rvdszOIEEXonLYf6/iN4uJK0
 tN5ssTeq+/FOwNqU8T3yIta8h585XccV5ShEQ32xj6SCD2no4lVMYZQEcPvvuv9Hqtko
 ZYA6GfVaKP6KGmvd8fzmIJbsiE2Rtz5Rwd5alVv+vFsj+xp1D/uXb+CwBvmMZP8R9rg6
 TfgblvLL4AjYWS/65eSUZg1Fc3d2yveFKkhizB7m/seYFZ4Ok/icVjFD1iaP16EJUSfJ
 QoVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhJvMU8zocNmeRkDZWi/BATlczycw8TuK/h0ekHiUiTBgEkDjOBjlYp7MKDYb01B7UdOZqjq9B9pg/@nongnu.org
X-Gm-Message-State: AOJu0YxDcW7XNSiQ4o6vg6O7gCh5rlRwDvuJ874A7EZSogngGlYnF+IO
 Y2BIli8U8G2noMYpoBMIB6mJ9Jf4IwxM7NbXSv6ZplERBFtWpCc6v4+F39WiYfs=
X-Google-Smtp-Source: AGHT+IG3SA0U/lY5sGjG3m+d+kl9Cmc62Z2O9b+RLxDvymoSMWjhKlsYtSVwufXiSaPa+Iz+15qSIA==
X-Received: by 2002:a17:902:ec81:b0:1fa:fc6a:858a with SMTP id
 d9443c01a7336-20203e8c6damr20947815ad.15.1723784959212; 
 Thu, 15 Aug 2024 22:09:19 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:1b6b:8c7b:90f9:144f?
 (2403-580a-f89b-0-1b6b-8c7b-90f9-144f.ip6.aussiebb.net.
 [2403:580a:f89b:0:1b6b:8c7b:90f9:144f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f02fb4fcsm18100435ad.21.2024.08.15.22.09.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 22:09:18 -0700 (PDT)
Message-ID: <794021c3-02f2-4b64-8d1c-a56125e09462@linaro.org>
Date: Fri, 16 Aug 2024 15:09:10 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/16] target/riscv: compressed encodings for sspush
 and sspopchk
To: Deepak Gupta <debug@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com, jim.shu@sifive.com,
 andy.chiu@sifive.com, kito.cheng@sifive.com
References: <20240816010711.3055425-1-debug@rivosinc.com>
 <20240816010711.3055425-14-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240816010711.3055425-14-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 8/16/24 11:07, Deepak Gupta wrote:
> sspush/sspopchk have compressed encodings carved out of zcmops.
> compressed sspush is designated as c.mop.1 while compressed sspopchk
> is designated as c.mop.5.
> 
> Note that c.sspush x1 exists while c.sspush x5 doesn't. Similarly
> c.sspopchk x5 exists while c.sspopchk x1 doesn't.
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Co-developed-by: Jim Shu <jim.shu@sifive.com>
> Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
> ---
>   target/riscv/insn16.decode                    |  2 ++
>   target/riscv/insn_trans/trans_rvzicfiss.c.inc | 12 ++++++++++++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
> index 3953bcf82d..3b84a36233 100644
> --- a/target/riscv/insn16.decode
> +++ b/target/riscv/insn16.decode
> @@ -140,6 +140,8 @@ sw                110  ... ... .. ... 00 @cs_w
>   addi              000 .  .....  ..... 01 @ci
>   addi              010 .  .....  ..... 01 @c_li
>   {
> +  c_sspush        011 0  00001  00000 01 rs2=1 rs1=0 # c.sspush x1 carving out of zcmops
> +  c_sspopchk      011 0  00101  00000 01 rs1=5 rd=0 # c.sspopchk x5 carving out of zcmops
>     c_mop_n         011 0 0 n:3 1 00000 01
>     illegal         011 0  -----  00000 01 # c.addi16sp and c.lui, RES nzimm=0
>     addi            011 .  00010  ..... 01 @c_addi16sp
> diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
> index 05d439c1f6..67f5c7804a 100644
> --- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
> @@ -109,3 +109,15 @@ static bool trans_sspush(DisasContext *ctx, arg_sspush *a)
>   {
>       return gen_sspush(ctx, a->rs2);
>   }
> +
> +static bool trans_c_sspopchk(DisasContext *ctx, arg_c_sspopchk *a)
> +{
> +    assert(a->rs1 == 5);
> +    return gen_sspopchk(ctx, a->rs1);
> +}
> +
> +static bool trans_c_sspush(DisasContext *ctx, arg_c_sspush *a)
> +{
> +    assert(a->rs2 == 1);
> +    return gen_sspush(ctx, a->rs2);
> +}

This indirection is pointless.  Have the decoder invoke the proper insn in the first 
place.  Identically with how we're treating 'addi', for instance.


r~


