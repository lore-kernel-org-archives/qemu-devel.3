Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80640C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 21:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg9Eh-00053q-0P; Thu, 06 Feb 2025 16:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg9Ee-00051w-DW
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 16:16:32 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg9Ec-0002of-If
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 16:16:31 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21f2339dcfdso22231455ad.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 13:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738876588; x=1739481388; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qK82DaLTLsMpaERRCfs7oo5CSIGuhsKLVE98tN2O95g=;
 b=oohore/EuvXx0hfyZfkPSZa80uyo11VN5Yr1ii7syRHSvSUrU4igf7fhijJUU63iGT
 M1GgHpXoR0rulZGwfC987F97VcoM3JtQgPXKk3rHXLq74zUPlYIxhuhW+wDakpdFeFop
 3/4htWXaTJxTxhra2Mfl6kmmpc07tBWyRgEe6WHzdhsFiz1gO/msBCDibw8xYsC53roq
 wJ+IA0U/LSr/ClvD/8VoipLVB8dkI8QbYde1SAfJASNEM4Nqg0BglxLLqiPd2t7d/X5n
 LjLm/rgCl/Atbh8lEbXVZBzIkhWPe6YvH7AQKTd6+4focWFx0tgazRK3F5JmCLEX9EyR
 aqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738876588; x=1739481388;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qK82DaLTLsMpaERRCfs7oo5CSIGuhsKLVE98tN2O95g=;
 b=asdN4GFv5QkWi0kNL4KOyZyy4BSF2defERQzH2CLd8WcEETfa3uqOLLlB/ltykbIQk
 KMgzXLYos7a3E90mDAsVJVal+styGJt6Qxiwxw+pqkwIIuAVITdz80ICS01MptHw4bAj
 5hBRUunmwz9p7DT88dap8FuIDG4EqldwtQRIR766uNEabx6orLR9QZGxbhxq+6qqo8jb
 Ihk+zqVKnXtTVymiSc1tH0ksIS9jxQwjosEoLfTAg29eoWl9xNz9NNT2zws3cO9RoBcg
 3K1H0Xz+5g+vK4yz81bTjripDHTvXZCndS2UqNe/4KDxcDi2PLFzBpkhnfc/iE+dEQJc
 C5JA==
X-Gm-Message-State: AOJu0Yy8ZBF+hYkJ+yh9on1xX7A+H2Jq483eCtj4AZCcuhihFR1rYSvp
 J0FFwaFkq4Dot6vtpOO51Hwg2OzzcY/wO3wl/wEZ9FEq3TmJ1BgjHW4q5keKXWDCCj5sc6fctbc
 v
X-Gm-Gg: ASbGncs6XplHkwiW3AVeiI6+EL00Hp+ydueNa89VbI22hjFRxm5G3QX8Wzh+6DNStuy
 bGPvHTuUFTBM3NcgunOd3zEsadIiN8838565Qai7xcKXZ67PWbeCkTihW+7etUm7tUrSRK/QFpd
 QGqZqdFFkzdEZ+X1RbY5KVDh44q7t5wrUc5TXaWvyXm96L4SHaoTwv+RM16Bj4+cYn4VYa1URyT
 wTLMo0L9NWOicEn9xo3nrmP2wEFDblCOF8FS44+tYC+oWwpyF4GPh0ueyo087A14bzAvBk1iQC6
 yI9tziLzqMIBA+4YUO8dCh47QcLY1KN16kkvq4QwCC7PaIVxAUDsIF4=
X-Google-Smtp-Source: AGHT+IHLYIDThchzE98UoGi+wEUowZHRsqQPwgqMot1pbC+2HdEoX0Ntph7Re4gvK2iN4QxT2rej2g==
X-Received: by 2002:a17:902:d50c:b0:21f:1348:10e6 with SMTP id
 d9443c01a7336-21f4f170a37mr7759085ad.13.1738876588584; 
 Thu, 06 Feb 2025 13:16:28 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3689a2dcsm17193825ad.210.2025.02.06.13.16.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 13:16:28 -0800 (PST)
Message-ID: <f4ec871d-e759-44bc-a10b-872322330a3f@linaro.org>
Date: Thu, 6 Feb 2025 13:16:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/22] target/riscv: introduce RISCVCPUDef
To: qemu-devel@nongnu.org
References: <20250206182711.2420505-1-pbonzini@redhat.com>
 <20250206182711.2420505-3-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250206182711.2420505-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 2/6/25 10:26, Paolo Bonzini wrote:
> Start putting all the CPU definitions in a struct.  Later this will replace
> instance_init functions with declarative code, for now just remove the
> ugly cast of class_data.
...
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ed9da692030..29cfae38b75 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2955,7 +2955,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
>   {
>       RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
>   
> -    mcc->misa_mxl_max = (uint32_t)(uintptr_t)data;
> +    mcc->misa_mxl_max = ((RISCVCPUDef *)data)->misa_mxl_max;
>       riscv_cpu_validate_misa_mxl(mcc);
>   }
>   
> @@ -3051,40 +3051,48 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
>   }
>   #endif
>   
> -#define DEFINE_DYNAMIC_CPU(type_name, misa_mxl_max, initfn) \
> +#define DEFINE_DYNAMIC_CPU(type_name, misa_mxl_max_, initfn) \
>       {                                                       \
>           .name = (type_name),                                \
>           .parent = TYPE_RISCV_DYNAMIC_CPU,                   \
>           .instance_init = (initfn),                          \
>           .class_init = riscv_cpu_class_init,                 \
> -        .class_data = (void *)(misa_mxl_max)                \
> +        .class_data = &((RISCVCPUDef) {                     \
> +             .misa_mxl_max = (misa_mxl_max_),               \
> +        }),                                                 \

Drop the unnecessary ().

It would be nice if this were const, i.e.

   .class_data = (void *) &(const RISCVCPUDef){
       ...
   },

This will in fact create an anonymous object in .rodata.

We have other uses that do the extra casting away const,
e.g. armsse_variants in hw/arm/armsse.c.  Although I suspect
*all* usage of .class_init can and should be with const data.
An unrelated cleanup, to be sure.


r~

