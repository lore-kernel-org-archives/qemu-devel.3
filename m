Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0754C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 11:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFWVA-0006EE-7I; Thu, 15 May 2025 07:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uFWV3-00064c-NX
 for qemu-devel@nongnu.org; Thu, 15 May 2025 07:11:41 -0400
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uFWV1-0005TZ-Rp
 for qemu-devel@nongnu.org; Thu, 15 May 2025 07:11:41 -0400
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-86d6fd581f4so1157737241.1
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 04:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1747307498; x=1747912298; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iJ5uLHQR2o5tqtu2r5fD3H76NuaknHqx3UXQ5rPSCEE=;
 b=DW47O6al2IsAdggS1p/6+CVhIjrul2KzDEbBhMa/QqW3B7aQxQFah6ZmbLZgsZMQXp
 g+kVQku1yRDiW7osYqmUcpeZxc8O1sXw5oEtDFltGDmqKqWHTvMTVGT3V/MnYgaYtf/V
 JuIEPHVEy81byS2PitqVvXKASBIJF7vR/bOXuMPOsM3weSBao+jwjccj5itjbXoTH6w2
 skXeZIOkiaaW5Ka8i7qdIjQfE05WeykmI0oSXEpbtz5f4EGqlKtprBhxtfBqYCHTed/5
 mRBfDwfiYI9BcpV1UXTnjKAXQF4+PGAowgfR+fENcveU/tu5uNKZgrZENuyYBi6487ac
 pGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747307498; x=1747912298;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iJ5uLHQR2o5tqtu2r5fD3H76NuaknHqx3UXQ5rPSCEE=;
 b=Ah+yJTDJ6C9YPMmzFqCl15TTmwhdgzqciukA1wDHg1ZJanmaJ+7bjTzooIZkomMeAn
 nU3fFHn8i/hvhNogiYimIX6eRS44sRszkZ7KEI7DDZDGIghd3/Vt6vPPL0wu/UUxrUUu
 JPwgFNzHo92jINFAp1It7JAnXPa9vhJ2Z0YTpiQeERsbTiUa4bt5Z6a09e5BReUJWiVE
 QXe456AO2UmkPrmjXIpkaS0VtQfRmuIkdGPdKSeSUYyE6Z8SuAYyzfZAuT2hPnB07iUc
 skwnDhLMDGR5y/7Z+wCD1uunExj+95Iev0nqDkC87o1t+e7ep99+HHWzCFusQXEPXeXN
 jhyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSPcCRN2xdXJ5+alXXP/QbW5Ha9zFWKCPq4xK2zD52TQt2VJ1eVXcvMDMfYuT+cIukI//H1DScqYWp@nongnu.org
X-Gm-Message-State: AOJu0YytWTIxgej2AaGv8EkLPdEbZWDv4ySmRXw97AHU8Ex95BiLnY2X
 hyfyvis9UT0AXCVlgm5qi32pRBcztc+fMPgmFtqjQPdfSWAiTXsghr3/0jD57D5Jv3w=
X-Gm-Gg: ASbGnctAMv7jJ+7kq68S9fMUx2qvTFFsKCXSCE+GrmtvHRji08XfewqERp/09ug4uKX
 AExSRr1uxHiw2Y6oE8knQVyfm9lvb6z9SAlA1ew7jXnnOCTl7hUXCUSzqfBQrvUlnUbRknAg2oi
 /IfZTowqv4l5bLSewlBaeUnmzZGD5fw2yFlG09bGIs4jNgHpilAKUJjL5rjfdGQndOPI0vSSsTi
 MA8vOb43yGFGWC6A2w7oqblz/NQyoJDpcVq8jXRqjtd8/RcnGXww3OKVAEni1rsyh4xjSS5pAPb
 bx8Cl0j9TVo0DB8u1MFCakbVCqGFdFp6H07Z2Q6aQDRIzwKQ9oD3/8IMMUCFoaxm7UBFWiyD3yh
 EWRBzQlhb7IgBhuvJJ7TK9rJPVuy3cA==
X-Google-Smtp-Source: AGHT+IEuh+CM1GikSMpXFJGO8XYjIsmPmxK4STzIxSdNIthzKu1AFZ+qo5Ct7au4nIYDKRYfC64H7w==
X-Received: by 2002:ac5:ce87:0:b0:527:b804:ff78 with SMTP id
 71dfb90a1353d-52da902fc0emr2244992e0c.1.1747307498501; 
 Thu, 15 May 2025 04:11:38 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:906e:57d5:dca2:1ab3:20de?
 ([2804:7f0:bcc0:906e:57d5:dca2:1ab3:20de])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-52c53865814sm11023821e0c.38.2025.05.15.04.11.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 04:11:38 -0700 (PDT)
Message-ID: <fee247fc-d7b4-4ac6-8723-28feb3a2cfdb@ventanamicro.com>
Date: Thu, 15 May 2025 08:11:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/riscv: Add the implied rule for G extension
To: frank.chang@sifive.com, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Jim Shu <jim.shu@sifive.com>
References: <20250514041118.1614-1-frank.chang@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250514041118.1614-1-frank.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ua1-x934.google.com
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



On 5/14/25 1:11 AM, frank.chang@sifive.com wrote:
> From: Jim Shu <jim.shu@sifive.com>
> 
> Add the missing implied rule from G to imafd_zicsr_zifencei.
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> ---


Patch LGTM. I believe this will deprecate everything we're doing in
riscv_cpu_validate_g() in tcg-cpu.c and we should remove it in this same
patch.


Thanks,

Daniel

>   target/riscv/cpu.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d92874baa0..27edd5af62 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2520,6 +2520,18 @@ static RISCVCPUImpliedExtsRule RVV_IMPLIED = {
>       },
>   };
>   
> +static RISCVCPUImpliedExtsRule RVG_IMPLIED = {
> +    .is_misa = true,
> +    .ext = RVG,
> +    .implied_misa_exts = RVI | RVM | RVA | RVF | RVD,
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_zicsr),
> +        CPU_CFG_OFFSET(ext_zifencei),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>   static RISCVCPUImpliedExtsRule ZCB_IMPLIED = {
>       .ext = CPU_CFG_OFFSET(ext_zcb),
>       .implied_multi_exts = {
> @@ -2898,7 +2910,7 @@ static RISCVCPUImpliedExtsRule SSCTR_IMPLIED = {
>   
>   RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
>       &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
> -    &RVM_IMPLIED, &RVV_IMPLIED, NULL
> +    &RVM_IMPLIED, &RVV_IMPLIED, &RVG_IMPLIED, NULL
>   };
>   
>   RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {


