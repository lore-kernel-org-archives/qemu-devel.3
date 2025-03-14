Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CADC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 12:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt4Iv-0000eZ-ES; Fri, 14 Mar 2025 08:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tt4Io-0000dT-JW
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 08:38:14 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tt4Im-0000zP-An
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 08:38:14 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-219f8263ae0so36156595ad.0
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 05:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1741955886; x=1742560686; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IJs8f30yW55SOit8VJw/gcB0+E9RfFJXCWxehHrW5m0=;
 b=FycQCiTL1zHXE/Qsu56RFi6D1pPgWFFis9fdvICvtyoPghz4FYJrOAF3Lgie7Ry4cL
 p1ALLg5MCwknAqeDG7CHkokmJoZc+2d6qHiSe7mrE2+5GjfDtrnIs6G4CLYTG1TJV+19
 jkFb0VLiktc5GReHoLPDs2IXXgNlNbYljON4KqC2kdFyJN+mc/JA9W3ybOhWyR2hYU8S
 2WC9AYRWmQdNQTvLhLyInJlTh83CCzN3zbPi5JTRErUjt9VUCFh8rgfiIpjkDscwy+su
 DvQtUPnp7LdWwNdWEO0On20fyWcxvysvSmPCqOhwIgx8zL8cL8wLeuTB/eJGTDcERGt8
 yYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741955886; x=1742560686;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IJs8f30yW55SOit8VJw/gcB0+E9RfFJXCWxehHrW5m0=;
 b=xL99VHy5CYqCYOBzesFt/W0rA0Bg2QDycva8trl27YmTgIE5s0CWPyl6hzzhgbnjJT
 J/3cPzXo5B1wmEjku0/ZBxlVBqJJ2rvbYpjl59HE00DgVFO1aahO2A5qf+waxIaPvct4
 EPs0TcmyQ6u0ZeD8P6gUa1dQBNGGAznO0dq9h7WVtsBz70Uhg1RGdfJLT4SEO3nA5jlE
 /L15o0GlTMdEQxrOPJXKOq8GZoqLNXGj3ZdafBSWIJ8HmLycmPGl3gzQ4hgUocWrb3QK
 Pu4QzNSIkrgeYrR94VPBB+SEuPnEdfX0LNqWdVZBiG/t2b2cK/BPtYB0tsJqsfSb9a61
 wknQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW23oJGQvIH6AUNX5MiuCtjPkliJUjrViFoEOQjEquEvNNebhcL4BK9B/TKzXueDSpnoEWVwplAYbr@nongnu.org
X-Gm-Message-State: AOJu0YzMcNMfYK+5PSvVSkmJwhWv3BsjIZdW2Cc+dFg6QEIMSdAV4aUy
 lm7Gj7zO4rkfQxS14/Qoxa+ozIQI2DcOnPef++R/adgkulNJAcUAXLf5CqkgsJ8=
X-Gm-Gg: ASbGnctn3R22RU0qkr4Hb5b9Zv1XqzXgb2M04l4dY80x63dD5HsLVCVIBhyCYUastP8
 v+NZUwL7R5XYI1ejE5whDdSX1gkwFLKSjcOJcyaBddCSCEn3Bi7cmR2Y2tIplIS/ijr1x1dua1u
 EmYJd02AvCbR5JKTlgZxljhh56QsjFhZmVL9KObAOoGqWJhW96JXbSh03yU+PW0QG40D9njWvwO
 0TUrsLIFY6/EF3HQC7TfPyP2i521hcQjDZQGsXA1P8DG/KoVwepcv8JQ5GPMeoZjycfk+lLBplI
 PGmpK4pcfPQW2P0P0IkwCyfJTdQ+eR01vaOlVXSoFNf2kjY7+LXW4ATBruwHyBFNOYPyPg==
X-Google-Smtp-Source: AGHT+IFAVi2WeNu0Uahx0rrz+HrO8KZI25eAlacle+vpmlOMIjvfjF8u5cLUC125hsEwBXwj8C6PEQ==
X-Received: by 2002:a17:903:f86:b0:220:c4e8:3b9f with SMTP id
 d9443c01a7336-225e08605f9mr30309315ad.0.1741955885686; 
 Fri, 14 Mar 2025 05:38:05 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.117.79])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bd4e0dsm27816515ad.221.2025.03.14.05.38.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 05:38:05 -0700 (PDT)
Message-ID: <d6295353-33d8-4816-b815-49958634d263@ventanamicro.com>
Date: Fri, 14 Mar 2025 09:38:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] target: riscv: Add Svrsw60b59b extension support
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20250314104833.369365-1-alexghiti@rivosinc.com>
 <CAHVXubjJ_oCKqjYBFRjn-BM-cB4JUsFJ-dX3Dqs6j=6vTh+yHA@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAHVXubjJ_oCKqjYBFRjn-BM-cB4JUsFJ-dX3Dqs6j=6vTh+yHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x635.google.com
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



On 3/14/25 9:11 AM, Alexandre Ghiti wrote:
> On Fri, Mar 14, 2025 at 11:48 AM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>>
>> The Svrsw60b59b extension allows to free the PTE reserved bits 60 and 59
>> for software to use.
> 
> I missed that the extension had been renamed to Svrsw60*t*59b, I'll
> fix that in v2 later after I collect some feedback.

Just to be clear: the extension is going to be named Svrsw60t59b, not
"Svrsw60*t*59b". Correct?


Aside from that code LGTM. Thanks,

Daniel


> 
> Thanks,
> 
> Alex
> 
>>
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> ---
>>
>> I tested it by always setting the bits 60 and 59 in Linux which booted
>> fine.
>>
>>   target/riscv/cpu.c        | 2 ++
>>   target/riscv/cpu_bits.h   | 3 ++-
>>   target/riscv/cpu_cfg.h    | 1 +
>>   target/riscv/cpu_helper.c | 3 ++-
>>   4 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 3d4bd157d2..ee89cdef46 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -219,6 +219,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>>       ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
>>       ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
>>       ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
>> +    ISA_EXT_DATA_ENTRY(svrsw60b59b, PRIV_VERSION_1_13_0, ext_svrsw60b59b),
>>       ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
>>       ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
>>       ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
>> @@ -1644,6 +1645,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>>       MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
>>       MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
>>       MULTI_EXT_CFG_BOOL("svpbmt", ext_svpbmt, false),
>> +    MULTI_EXT_CFG_BOOL("svrsw60b59b", ext_svrsw60b59b, false),
>>       MULTI_EXT_CFG_BOOL("svvptc", ext_svvptc, true),
>>
>>       MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
>> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
>> index f97c48a394..71f9e603c5 100644
>> --- a/target/riscv/cpu_bits.h
>> +++ b/target/riscv/cpu_bits.h
>> @@ -663,7 +663,8 @@ typedef enum {
>>   #define PTE_SOFT            0x300 /* Reserved for Software */
>>   #define PTE_PBMT            0x6000000000000000ULL /* Page-based memory types */
>>   #define PTE_N               0x8000000000000000ULL /* NAPOT translation */
>> -#define PTE_RESERVED        0x1FC0000000000000ULL /* Reserved bits */
>> +#define PTE_RESERVED(svrsw60b59b)              \
>> +               (svrsw60b59b ? 0x07C0000000000000ULL : 0x1FC0000000000000ULL) /* Reserved bits */
>>   #define PTE_ATTR            (PTE_N | PTE_PBMT) /* All attributes bits */
>>
>>   /* Page table PPN shift amount */
>> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
>> index b410b1e603..f6e4b0068a 100644
>> --- a/target/riscv/cpu_cfg.h
>> +++ b/target/riscv/cpu_cfg.h
>> @@ -89,6 +89,7 @@ struct RISCVCPUConfig {
>>       bool ext_svinval;
>>       bool ext_svnapot;
>>       bool ext_svpbmt;
>> +    bool ext_svrsw60b59b;
>>       bool ext_svvptc;
>>       bool ext_svukte;
>>       bool ext_zdinx;
>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> index e1dfc4ecbf..6546cea403 100644
>> --- a/target/riscv/cpu_helper.c
>> +++ b/target/riscv/cpu_helper.c
>> @@ -1156,6 +1156,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>>       bool svade = riscv_cpu_cfg(env)->ext_svade;
>>       bool svadu = riscv_cpu_cfg(env)->ext_svadu;
>>       bool adue = svadu ? env->menvcfg & MENVCFG_ADUE : !svade;
>> +    bool svrsw60b59b = riscv_cpu_cfg(env)->ext_svrsw60b59b;
>>
>>       if (first_stage && two_stage && env->virt_enabled) {
>>           pbmte = pbmte && (env->henvcfg & HENVCFG_PBMTE);
>> @@ -1225,7 +1226,7 @@ restart:
>>           if (riscv_cpu_sxl(env) == MXL_RV32) {
>>               ppn = pte >> PTE_PPN_SHIFT;
>>           } else {
>> -            if (pte & PTE_RESERVED) {
>> +            if (pte & PTE_RESERVED(svrsw60b59b)) {
>>                   return TRANSLATE_FAIL;
>>               }
>>
>> --
>> 2.39.2
>>


