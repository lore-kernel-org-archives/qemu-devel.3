Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389CFC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 06:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdNi1-0005CY-JU; Thu, 30 Jan 2025 01:07:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tdNhx-0005Bl-FS
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 01:07:21 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tdNht-0001kN-No
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 01:07:20 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2164b1f05caso6575285ad.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 22:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1738217236; x=1738822036; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BBpuuOuknC+jAqDB9OMywypbLwlgMHnDfYW2K8Sj1ZM=;
 b=O2v1e0PSEp+/YE2zhynG1pbp6nUQg/OlDSgc4hMz30Hncj6JSV3mvasrngxroxRpoT
 3/a9p8Jxv0nAc3FIYd/tuWSuiROSmYWadsm+QZPr7CGY6D+ImCU+q67rzSv2uAvltOva
 0s88ohslse3L3i5vpmvbdMdEDge85F6oSPjHhLyMDEODgqlQ0Ndj7yPQQsITMMeyib0p
 bpNkfXUuj01CzCFqCtU21AmvJW2P/gQ/4B/yx/bk5NLuly1hBD6jb+fN9W7RKIbuYo91
 w09NSsWYdGVZYJ39XKvWDvnxHVPFUx9Hs7tet8YUAyM8nEv2GYrOOUdq9U7NI07fIRBo
 uUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738217236; x=1738822036;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BBpuuOuknC+jAqDB9OMywypbLwlgMHnDfYW2K8Sj1ZM=;
 b=NTWk8NEuTDv9/RkJ+mQjkdMBbz7/UXJHkniXZS/RfKeTbAQUxjAvHg6T2Vi/osoZ9n
 n088u/RHW+dCZddT1grDbmK5dm3H41ikkyseqe1UQ5jlcDvorCkcNlzCh6hfnODzeoaX
 evv0NUWDt444AS3oCAgKY1T7t80e7IBY8A5aZGNuuNfJ112fwMKEmggNnG6K0+JIf+Y/
 We8YlbyCknbUNPBVnoBDl186Vu665FOcdYvIkVml10NbIlEokg+CmhdlI9qRhsLiyE6W
 FXIc7fYYbP4+++BnUzhnSwcickqew9/JJdyrH19ADeQ8era5c7fFRlw1ZIc6re8TkBC2
 RLqQ==
X-Gm-Message-State: AOJu0YyQ8siC52kKLGkMoXSGIXzjIJ08c2i3VMBRhX1FuoY6pFOpCI7w
 GpiDeuMwKuZi1RUMOK6FrN1zl2SQIhof8JH5wHXAu4ai0U3b6u5vm5zE9EDm9sA=
X-Gm-Gg: ASbGncv4XEV3O5KUpIA2uRZAwr67aeP/VycFqXLnaoXROC3GXAkIn2/Qe9gK2cwB1zY
 I4yV3Uzc644VdGsKVdRWfywCpb4iFIZXICkz3L8qXF+uf33CGUnvkDcTpmaN7ca2WA9KW9bPUaD
 oH8RjEBM483NGk07Q5Baqi8sdPtO9IAjOoKhXqQ0TTYWM+fTeEijvQHM0GW1f1+u4mRbt082u4d
 F5jxzk01HOr7a+vpg6BI21BZgoHnJ+mN7dLRlMZh9uUWiqRJlB67S/YHT0eHD2+2tsUHcN2NPt0
 m85XMJWxzaCKnkzZwwgKv6h+DJwPYxg=
X-Google-Smtp-Source: AGHT+IFjXiB3VtXqs1hRL3sQbUDriLwKng1ApLCqRea3KhNWYrrtWbkQv0a5tm/6ttbjvNWyEyhMRQ==
X-Received: by 2002:a05:6a21:3416:b0:1e1:afa9:d39b with SMTP id
 adf61e73a8af0-1ed7a5a5102mr10810684637.7.1738217235612; 
 Wed, 29 Jan 2025 22:07:15 -0800 (PST)
Received: from [192.168.68.110] ([177.170.227.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe69cea77sm549397b3a.150.2025.01.29.22.07.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 22:07:14 -0800 (PST)
Message-ID: <0d10a8ed-2775-4207-8d9d-a243c04b9db1@ventanamicro.com>
Date: Thu, 30 Jan 2025 03:07:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] target/riscv: add RVA23U64 profile
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, ajones@ventanamicro.com
References: <20250114190001.1650942-1-dbarboza@ventanamicro.com>
 <20250114190001.1650942-4-dbarboza@ventanamicro.com>
 <CAKmqyKPc6OuKjf3PdY9AzyUzNBzP8AtyQD6+koBSqQsu9=Z=KA@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAKmqyKPc6OuKjf3PdY9AzyUzNBzP8AtyQD6+koBSqQsu9=Z=KA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x636.google.com
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



On 1/28/25 10:22 PM, Alistair Francis wrote:
> On Wed, Jan 15, 2025 at 5:02 AM Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>>
>> Add RVA23U64 as described in [1]. Add it as a child of RVA22U64 since
>> all RVA22U64 mandatory extensions are also present in RVA23U64. What's
>> left then is to list the mandatory extensions that are RVA23 only.
>>
>> A new "rva23u64" CPU is also added.
>>
>> [1] https://github.com/riscv/riscv-profiles/blob/main/src/rva23-profile.adoc
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Thanks for the review! If you could take a look at the latest version of this
work that would be great too:

[PATCH v4 0/6] target/riscv: RVA23 profile support

All patches are acked. Drew's points that were raised in this version (and v3)
were addressed.


Thanks,


Daniel

> 
> Alistair
> 
>> ---
>>   target/riscv/cpu-qom.h |  1 +
>>   target/riscv/cpu.c     | 32 ++++++++++++++++++++++++++++++++
>>   2 files changed, 33 insertions(+)
>>
>> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
>> index d56b067bf2..53ead481a9 100644
>> --- a/target/riscv/cpu-qom.h
>> +++ b/target/riscv/cpu-qom.h
>> @@ -40,6 +40,7 @@
>>   #define TYPE_RISCV_CPU_RV64E            RISCV_CPU_TYPE_NAME("rv64e")
>>   #define TYPE_RISCV_CPU_RVA22U64         RISCV_CPU_TYPE_NAME("rva22u64")
>>   #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
>> +#define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
>>   #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
>>   #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
>>   #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 6fb4d5f374..371a7d63fa 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -2395,9 +2395,33 @@ static RISCVCPUProfile RVA22S64 = {
>>       }
>>   };
>>
>> +/*
>> + * All mandatory extensions from RVA22U64 are present
>> + * in RVA23U64 so set RVA22 as a parent. We need to
>> + * declare just the newly added mandatory extensions.
>> + */
>> +static RISCVCPUProfile RVA23U64 = {
>> +    .parent = &RVA22U64,
>> +    .name = "rva23u64",
>> +    .misa_ext = RVV,
>> +    .priv_spec = RISCV_PROFILE_ATTR_UNUSED,
>> +    .satp_mode = RISCV_PROFILE_ATTR_UNUSED,
>> +    .ext_offsets = {
>> +        CPU_CFG_OFFSET(ext_zvfhmin), CPU_CFG_OFFSET(ext_zvbb),
>> +        CPU_CFG_OFFSET(ext_zvkt), CPU_CFG_OFFSET(ext_zihintntl),
>> +        CPU_CFG_OFFSET(ext_zicond), CPU_CFG_OFFSET(ext_zimop),
>> +        CPU_CFG_OFFSET(ext_zcmop), CPU_CFG_OFFSET(ext_zcb),
>> +        CPU_CFG_OFFSET(ext_zfa), CPU_CFG_OFFSET(ext_zawrs),
>> +        CPU_CFG_OFFSET(ext_supm),
>> +
>> +        RISCV_PROFILE_EXT_LIST_END
>> +    }
>> +};
>> +
>>   RISCVCPUProfile *riscv_profiles[] = {
>>       &RVA22U64,
>>       &RVA22S64,
>> +    &RVA23U64,
>>       NULL,
>>   };
>>
>> @@ -2884,6 +2908,13 @@ static void rva22s64_profile_cpu_init(Object *obj)
>>
>>       RVA22S64.enabled = true;
>>   }
>> +
>> +static void rva23u64_profile_cpu_init(Object *obj)
>> +{
>> +    rv64i_bare_cpu_init(obj);
>> +
>> +    RVA23U64.enabled = true;
>> +}
>>   #endif
>>
>>   static const gchar *riscv_gdb_arch_name(CPUState *cs)
>> @@ -3163,6 +3194,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>>       DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64,  rv64e_bare_cpu_init),
>>       DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_profile_cpu_init),
>>       DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,  rva22s64_profile_cpu_init),
>> +    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23U64,  MXL_RV64,  rva23u64_profile_cpu_init),
>>   #endif /* TARGET_RISCV64 */
>>   };
>>
>> --
>> 2.47.1
>>
>>


