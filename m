Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27549CCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 17:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7zwX-0002iD-5K; Sun, 12 Oct 2025 13:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v7zwV-0002hX-Vm
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 13:33:12 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v7zwU-0001rB-Bv
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 13:33:11 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-28a5b8b12a1so32083235ad.0
 for <qemu-devel@nongnu.org>; Sun, 12 Oct 2025 10:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1760290389; x=1760895189; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a3PkN/GVqDV06zGkaedtS+BHGMg7p4ZW5b08sBkYNtg=;
 b=I43y4QOCxfEZpyy//me4tr+7wnVw1JxhPCOis/rqikKTzJ87mvpN5ok58hkxz3OD+S
 OsKo3ZmYinjHhaWRL3WLAODLTrArL3Byd3ZgGRZZCxen0ujCdGBwK2zA1F+HXNBW0h3u
 JXMRlI6C9XGOTA6OfGfhr48s1xEayWk8bgo/oo8rbkEdBvIdz9oqX7AbBXKWOLAA76gx
 tUTe9eOFIzus6PUrrYPtEmo2XQ4qYFzqwF7yHLCa4dk9daooqMjA4bocXgYkaAoJDusv
 OOFKeRKOEqDHAt/t3uXoX5BATXIduHztpIv49ESQ16qC1av2JTsKCNyeO0BKAKZ51wng
 IFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760290389; x=1760895189;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a3PkN/GVqDV06zGkaedtS+BHGMg7p4ZW5b08sBkYNtg=;
 b=dG+zuWwzT7wh+Dyy96R0/aiUeceSPZhZU+DVLYTNiqyYl6Bn/vX3eay9GEu7zFySVc
 Z/hQyqExOnHyREQ9Lgc1kf2GjvG4BAwWjhAk2QfXnZ9dJbfGJ4ZeRNY/cby6PrcT4wmH
 IaBsXTE1hN4jbcpY6SxygsAGmF13XZcGusemk6DTgho9FD5iXTEp7xmN3pgovRUAoMBC
 T5/z1nyHxbkvbozjfxAeDmci0a3G+c3lF5i/nJImk79MYOeMjtjXnwwRHaPcjbdHdFJ5
 XUcwHCyepv6xBFS3U9pk0tCVE3++BvBrTa9DYuxpWg97XxzxszL9aZp8SMhRqHSkVbWT
 u/tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2mKImMYJVwQhNlOJr0ifzM7ItXeoo0RFqobFmt2zdkr/zGk2iLk1MMmpBOxSmuQlkmZRoIloYYGaF@nongnu.org
X-Gm-Message-State: AOJu0Yzb8GJJv5lvKAT0pNcnQIeMNhar3llzXUETfbQNn7EmHFJ6J/13
 88H4ajChux5oTU5MObI07GvM8iobwYYUU4unl4KzGGQY0s6Vs4tMQUMor09803BqwBo=
X-Gm-Gg: ASbGncvWgB47EssOB/EkvTl0Va8f0jQoisHmFO2tw6ib9YbjFvwKCewVZn6ZxE1y3Po
 qvVnieV9yR430bj9mCfuBVSv4dsR1+mI5Hy8b8v7e9RUox9RjvuxPP/qAQw5j21c2hYaGxVn+Ds
 QvQhjf0wKX67Iz/HpQis9U7Ozcy7d0a3D5mXem1wgnas21fJ0M3aA7CBhEwupRUN/4t7AbEKPOb
 9uvPcJ411lTTFa5qZ9ieeopKmnLP/TZruUKHhVRgnk1nENbEZ9wNgT3/Fmbocbz90GAZwzjfDL5
 ZsTM/xC7/u5/JO59IovZlSktvdR14qYGMKDmvQSoUcW66gHTPOnd63kuBqA7a75+tg2cUI/rEIC
 4qFp30cYmMt++1fcbBb4e7EYp5c4r9ppBNulTS168NZnA29bM0RPmBwZ7lGzenojnLeBmG/ZQIk
 YjNA==
X-Google-Smtp-Source: AGHT+IFNaLcfgOyFuP5DushofQvKG81/8LWGchhmf0Poy0QFicWX/3rB1n7f3fpEtWklShWpe0AGQA==
X-Received: by 2002:a17:902:f64a:b0:277:9193:f2da with SMTP id
 d9443c01a7336-29027356c8emr248187675ad.5.1760290388892; 
 Sun, 12 Oct 2025 10:33:08 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.122.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e1cc10sm110544385ad.31.2025.10.12.10.33.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Oct 2025 10:33:08 -0700 (PDT)
Message-ID: <8c69502e-f181-4fb2-a3d9-761957248aa4@ventanamicro.com>
Date: Sun, 12 Oct 2025 14:33:05 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] target/riscv: Fix smrnmi isa alphabetical order
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com
References: <20250918061911.904-1-zhiwei_liu@linux.alibaba.com>
 <20250918061911.904-6-zhiwei_liu@linux.alibaba.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250918061911.904-6-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x636.google.com
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



On 9/18/25 3:19 AM, LIU Zhiwei wrote:
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Suggested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d055ddf462..ad5597c9ac 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -203,9 +203,9 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
>       ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
>       ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
> -    ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
>       ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
>       ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
> +    ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
>       ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>       ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
>       ISA_EXT_DATA_ENTRY(ssccfg, PRIV_VERSION_1_13_0, ext_ssccfg),


