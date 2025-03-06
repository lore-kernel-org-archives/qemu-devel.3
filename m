Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4A7C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 06:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq4TH-00086J-N1; Thu, 06 Mar 2025 01:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1tq4TF-00085p-OS
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:12:37 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1tq4TD-00031F-4f
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:12:37 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2234bec7192so5372615ad.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 22:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741241552; x=1741846352;
 darn=nongnu.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rkEsEEwr4y9Cti1xkWS8KJTkUSom9OOmfKcwnvPhmNA=;
 b=hEvKpyPZL9/SyMu7ScFV3f6gUvWd0NQpM17McJ43GycvfMOn/TY1CDrtFNHFfFfDVg
 ejDEWn4gq9AMmEoHRG2vyOzFtUnDwwKSBNvQvqVc86Xfk0JXkh/+9nV3A/P/+P2Y/kJi
 kTBbz8R+MKJlcUIMGtZ2kIWw4VBIieMbes30DgxU3DujLJlv/oPm9gk+0MXy357cmNqf
 VkChR59o4LgW+GUiVDG0gFMQ8j3OPyldXMJDUvxas/3pbLf70VdUiKhGX+upE5IickKz
 a+/r49+eAX938KV1m4LBZnwT1RrxAB+p3uTOt5byhioCoiBxKjqY9FxRpj68as/Lw6dl
 ZYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741241552; x=1741846352;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rkEsEEwr4y9Cti1xkWS8KJTkUSom9OOmfKcwnvPhmNA=;
 b=Yj8NMvRrohzXzDnCIyxbD4Jlca7ugCQrrsyoJATaASfOzRYK24XBLGxE+UbKQz7YD2
 FIzfRhBVWAHPzu4jW+67Bp8FHnvleWU6agdz7qd8rAyNZ+LFuiey3kzDXp0Vh0+TiV/b
 dScNUOK/vJag2ZwpjW+GZajwTfXhPj4CwigUv8u7DxrkYjLDAo8h1kC3/uijysyJrT9E
 ZRrEWNwratxj0Ekek0IFWWfFeKdaBLBRDj4rlKb3CkggvAIRApdPY1bPvxXeWa6dyl1R
 fpJJwHsXBW/9sXAXP2bYL+SbexpNzPCLw1hb+LRHO3GwgtHFzp4H0r4HWT6roaCkaak1
 zYlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuNjYU+0Q4SbAwk3UWFtasOKquSg6eteg87KrO4jyBvOLWwePEgfuMGCRegmV4NYEdAoDXC2fD0NyP@nongnu.org
X-Gm-Message-State: AOJu0YwSWqhuiYoc4cNya+IIJoczT1VJSJhWiRWK3PVfWAlXxmCEfqja
 JzIs1r4YfSOURRxm4QIFnzGir/79a8Ra1BFfFa2ahDJvdtJeIW6kmsfMitcAkHo=
X-Gm-Gg: ASbGncs8NvljyXrz3U2HnN6Fk6lzh/rcqhZKyuPf9qflJkZk8SYntJeOc1vz0LTpadb
 5e2TvTXlO8lPrb5qSprdep0ReQitNCp9M2DNFXDnzjq9IBJa/y+/CPWjYNZul1Yz2taJ5QBX2LY
 FZKLvOSwjexvgucFxKZGJjTbrJ3DSRmrghcBn0aKpARgLryPt0iFN5DuX3Vbe/EeguC7ZBEC9+X
 M8TpKAIkv/JrJCCb4LC6zUj0+euBjaLScR3FUgoqCw8u/P8spMA3oZ/oiRmUn/rvQLoNAWZa863
 K73/VVKvwpop0F87C3OtKi1/2h3YuGASCxWJ3n23Wo8JA0McgL9V904=
X-Google-Smtp-Source: AGHT+IGZvko1GORcaZVbFJhepRYNWtqQL6u2ZIlENO1TLiMHvT01mL/TEAKQksA+DJ19HvJekExnPA==
X-Received: by 2002:a17:903:46ce:b0:223:faf3:b9c2 with SMTP id
 d9443c01a7336-223faf3c317mr67496635ad.27.1741241552653; 
 Wed, 05 Mar 2025 22:12:32 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a7f75dsm4221555ad.122.2025.03.05.22.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 22:12:32 -0800 (PST)
Date: Wed, 5 Mar 2025 22:12:30 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Adam Zabrocki <azabrocki@nvidia.com>
Subject: Re: [PATCH 1/2] target/riscv: fix access permission checks for CSR_SSP
Message-ID: <Z8k8zi3Moy/RxCWr@debug.ba.rivosinc.com>
References: <20250218025446.2452254-1-debug@rivosinc.com>
 <CAKmqyKMrod154GEdDFajnBMh0gg2zFGWxXYA0+xF=xW42SgEjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKMrod154GEdDFajnBMh0gg2zFGWxXYA0+xF=xW42SgEjg@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Mar 06, 2025 at 03:20:55PM +1000, Alistair Francis wrote:
>On Tue, Feb 18, 2025 at 12:56 PM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> Commit:8205bc1 ("target/riscv: introduce ssp and enabling controls for
>> zicfiss") introduced CSR_SSP but it mis-interpreted the spec on access
>> to CSR_SSP in M-mode. Gated to CSR_SSP is not gated via `xSSE`. But
>> rather rules clearly specified in section "2.2.4. Shadow Stack Pointer"
>
>Do you mean "22.2.1. Shadow Stack Pointer (ssp) CSR access contr" in
>the priv spec?

No I meant 2.2.4 of zicfiss specification. Section 22.2.1 of priv spec
says same.

>
>> of `zicfiss` specification. Thanks to Adam Zabrocki for bringing this
>> to attention.
>
>The thanks should probably be below the line

Sure

>
>>
>> Fixes: 8205bc127a83 ("target/riscv: introduce ssp and enabling controls
>> for zicfiss"
>>
>> Reported-by: Adam Zabrocki <azabrocki@nvidia.com>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>
>The actual change looks good:
>
>Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>
>Alistair
>
>> ---
>>  target/riscv/csr.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> index afb7544f07..75c661d2a1 100644
>> --- a/target/riscv/csr.c
>> +++ b/target/riscv/csr.c
>> @@ -191,6 +191,11 @@ static RISCVException cfi_ss(CPURISCVState *env, int csrno)
>>          return RISCV_EXCP_ILLEGAL_INST;
>>      }
>>
>> +    /* If ext implemented, M-mode always have access to SSP CSR */
>> +    if (env->priv == PRV_M) {
>> +        return RISCV_EXCP_NONE;
>> +    }
>> +
>>      /* if bcfi not active for current env, access to csr is illegal */
>>      if (!cpu_get_bcfien(env)) {
>>  #if !defined(CONFIG_USER_ONLY)
>> --
>> 2.34.1
>>
>>

