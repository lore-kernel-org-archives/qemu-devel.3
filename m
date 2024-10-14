Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147DBCFC501
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 07:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Fk8-0002Wg-7S; Mon, 14 Oct 2024 03:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t0Fk5-0002W8-5T
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 03:43:49 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t0Fk3-0000Sd-Lk
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 03:43:48 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37d3ecad390so3118893f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 00:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728891826; x=1729496626;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pn3SPeQwUAgcP1X8D6/08OscfvO9XUSwAb0aJ4hF6O4=;
 b=RL/CrJunJTEAIzQGovkcWDNVIQEBJVR4kfscw+TwARcw2RJYyYD9K0KY2/Uyk20KFL
 qM0PV3AgeKkByd4zgV0zqeAjNDxmy1ImEn9KNHwqHE7/YQb9q0fuigtEm3x5LesfnX1c
 F9f1xj7NdAWY6hLJavGGSFxejkAIXCH8/KwD+hXCmrFqn+WcYVmz3vLiDxxVlB55zt3P
 6d8cuGAg5Fp3b4MnHQMMNP/aA5TtMilQ6hRNwq+eHLRIBDvjaXuVWs97TofBaZIKxuMt
 GfT8blApRYv7SMMoP2c9Ne3R48zaxZCNhkqOQshio0g5GoTmzTu/YS/9tLKa8C/XskhC
 iaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728891826; x=1729496626;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pn3SPeQwUAgcP1X8D6/08OscfvO9XUSwAb0aJ4hF6O4=;
 b=XAvct9nHejMN5Zq/W1MavfixU0AAKx6O7hO0X5TzGDnLHN4TbP79VxMc1fjHH4FOvX
 WRtNHOotehTiQIRTUZ8dHAcM3VX5pgaOiMwUxg8YSxyFwnRvERDcle6Yt+7Ldbgro2mt
 TFFirB8eDZY+MIKAl76h+f7msml4NN/1Iek1SjIikkzAjYWa0FFPjV6zfPhvz3ONoheO
 WL7um9KxKLEzKu9SQulfKhkkt+OfNGX7fkJQcNE9JbLvz1yBLf+cyLXTne7UNO4clxFv
 YbQckbUuSMwtlJ8ZKNJPSaAWUIfUOLH/2vPwnh1BmF6DLx98N1TS99w4PWv3Ir3bxANy
 Bq1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ3Z1E9uAQJcsgt+NCbkpz/9SerpgccqmoS6FxCT91AguTWdaX+7GFtsxqSgeQF4fVtR5/z2BPJh9L@nongnu.org
X-Gm-Message-State: AOJu0Yyy/1FeoJc7J2Zuy/SVmEsnwiVA+0RV3QaQFobULGUoWXwpPFib
 1p0G54W6zxYYDntixyvm3zHPPoW+Eglo4ivom4EqlRSeibNI62+znySsQt/TDqM=
X-Google-Smtp-Source: AGHT+IGXyXvhWlFXCLSKW3b8cDwaUmjUYhvrd3cvOKknFYfmX1PsfxHscWcMckM9hus8YP6tXumqug==
X-Received: by 2002:a05:6000:dd2:b0:374:c21a:9dd4 with SMTP id
 ffacd0b85a97d-37d5529cb8dmr7760960f8f.20.1728891826038; 
 Mon, 14 Oct 2024 00:43:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626?
 ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d4b6d0217sm10655519f8f.60.2024.10.14.00.43.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2024 00:43:45 -0700 (PDT)
Message-ID: <06a45858-e10a-4a85-8944-fc1f9d071a36@rivosinc.com>
Date: Mon, 14 Oct 2024 09:43:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] target/riscv: Add Ssdbltrp ISA extension enable
 switch
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue
 <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
References: <20240925115808.77874-1-cleger@rivosinc.com>
 <20240925115808.77874-5-cleger@rivosinc.com>
 <CAKmqyKP9-WQLvMqf_kfb3tSH55qP9hw+swGjsg3uVWD1QhFVDA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CAKmqyKP9-WQLvMqf_kfb3tSH55qP9hw+swGjsg3uVWD1QhFVDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x430.google.com
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



On 11/10/2024 05:24, Alistair Francis wrote:
> On Wed, Sep 25, 2024 at 9:59 PM Clément Léger <cleger@rivosinc.com> wrote:
>>
>> Add the switch to enable the Ssdbltrp ISA extension.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>  target/riscv/cpu.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 65347ccd5a..4f52cf7ac0 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -190,6 +190,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>>      ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
>>      ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
>>      ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
>> +    ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_12_0, ext_ssdbltrp),
> 
> Shouldn't this be PRIV_VERSION_1_13_0?

Oups, yes indeed.

Thanks,

Clément

> 
> Alistair
> 
>>      ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
>>      ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
>>      ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
>> @@ -1492,6 +1493,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>>      MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
>>      MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
>>      MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
>> +    MULTI_EXT_CFG_BOOL("ssdbltrp", ext_ssdbltrp, false),
>>      MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
>>      MULTI_EXT_CFG_BOOL("svadu", ext_svadu, true),
>>      MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
>> --
>> 2.45.2
>>
>>


