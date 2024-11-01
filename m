Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9F6E6F073
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 17:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6vYt-0000IC-Ck; Fri, 01 Nov 2024 13:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t6vYr-0000Hc-P6
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 13:35:50 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t6vYq-0000r6-79
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 13:35:49 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-72041ff06a0so1913598b3a.2
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 10:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730482546; x=1731087346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6YQgS2hpBgZ5ghGtSY895dOQSRXnBOOFFhhl2VnynL8=;
 b=H/TOz9s2DVdCqmCPm3fDRlEinrVTUngoO/1uvxkF3qyJLXIn4kBz0xiviXszmEgHxA
 qK3sq5DZEfp3W/Ag/dBG2/w8Tc19dDSql2tYnOa7w/SMikzrkhTWiDD4b7Anb9kSt+Gs
 Pdkz1+OvjPXXSDWK2Ey7In6NWnizXdMUmqh7vPbgsO4g1Ob7gdq4ta96O4zeTS7I8peH
 qpaCEAoBpA9VRc2DMFurp0CnTXMRLtBirtZ6lYq974hTLxoow/bfD67aTGZQX+kqx8ci
 r8XAxnki7wkHYo6kn4SPirg/8mGl+e160D8aFnCAIgbtQSA/d94PIMz5PJpU4lgm4+Zi
 jIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730482546; x=1731087346;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6YQgS2hpBgZ5ghGtSY895dOQSRXnBOOFFhhl2VnynL8=;
 b=pFhNbeanV6JjzJQdqItH5TiaRh6bI2EkkwmJR/bn6Ba8x1kdJTsrpf65GCak9NYK7O
 L21yOSRdSgPV9ph0DU3mXPoRpQstMCB5TgLI1WVZJx4MmLYGHA9PpZP5pupUtoDufOGC
 QGpr2PPWNuIYhpTzWlqFZ7S3VN3jHcL9vWDf+GmpECHsoYaatLi5PcEFbYO/vvqH4pWg
 8VGYzTKFtg2wpaX4CtxDVv5shHGbGX7dGOWJ98nhQ1I+3l0AMPzG6VcEadM1lldgHmp1
 ocPaRntHsD2mhg1HyztM+sQMsM0DxMtpaOSfwjlP4vxAQqUCSiiPDeIcSdOZbNUQydwM
 P2Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2Aj9DiunodXiDXjrYEL0qO8eIyF/OtGfuZsDzVe0I0bulhV5XfwnEXm6hvWvTQwGeRCvDkPY5dnk7@nongnu.org
X-Gm-Message-State: AOJu0YzjxwXEcYcdSONURuJoKrvdPxilPa4L6CDaF14cCyjnsGdqiKEM
 mGpBdh4+rZP4KCh0Kmfool93VH4hF29n7DhRbyrf7Slx79yJp2O0W3R4U5fxgZE=
X-Google-Smtp-Source: AGHT+IELvEhUGxN2DyqiJrfWAiRULu6kPLHSQ3UCZnMCGCUHRFiKsdd2k104fIYcMfKGmMuYVw/TNg==
X-Received: by 2002:a05:6a21:3a43:b0:1d8:ae07:bf8 with SMTP id
 adf61e73a8af0-1dba54a496dmr4690461637.31.1730482546557; 
 Fri, 01 Nov 2024 10:35:46 -0700 (PDT)
Received: from [192.168.68.110] ([191.8.109.222])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0de9csm2677061a12.78.2024.11.01.10.35.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Nov 2024 10:35:46 -0700 (PDT)
Message-ID: <2e1af830-a90a-447f-ab47-1c3d49463134@ventanamicro.com>
Date: Fri, 1 Nov 2024 14:35:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv: fix build error with clang
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, qemu-riscv@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, John Snow <jsnow@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Michael Roth <michael.roth@amd.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20241101170833.1074954-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241101170833.1074954-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x433.google.com
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



On 11/1/24 2:08 PM, Pierrick Bouvier wrote:
> Introduced in 0c54ac, "hw/riscv: add RISC-V IOMMU base emulation"
> 
> ../hw/riscv/riscv-iommu.c:187:17: error: redefinition of '_pext_u64'
> 
>    187 | static uint64_t _pext_u64(uint64_t val, uint64_t ext)
> 
>        |                 ^
> 
> D:/a/_temp/msys64/clang64/lib/clang/18/include/bmi2intrin.h:217:1: note: previous definition is here
> 
>    217 | _pext_u64(unsigned long long __X, unsigned long long __Y)
> 
>        | ^
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/riscv/riscv-iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index feb650549ac..f738570bac2 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -184,7 +184,7 @@ static void riscv_iommu_pri(RISCVIOMMUState *s,
>   }
>   
>   /* Portable implementation of pext_u64, bit-mask extraction. */
> -static uint64_t _pext_u64(uint64_t val, uint64_t ext)
> +static uint64_t pext_u64(uint64_t val, uint64_t ext)

I suggest name it 'riscv_iommu_pext_u64' to be clear that this is a local scope function,
not to be mistaken with anything available in clang or any other compiler.


Thanks,

Daniel

>   {
>       uint64_t ret = 0;
>       uint64_t rot = 1;
> @@ -528,7 +528,7 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
>       int cause;
>   
>       /* Interrupt File Number */
> -    intn = _pext_u64(PPN_DOWN(gpa), ctx->msi_addr_mask);
> +    intn = pext_u64(PPN_DOWN(gpa), ctx->msi_addr_mask);
>       if (intn >= 256) {
>           /* Interrupt file number out of range */
>           res = MEMTX_ACCESS_ERROR;

