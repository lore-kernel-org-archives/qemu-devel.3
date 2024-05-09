Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567AFC10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 17:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s57Un-00009T-Ij; Thu, 09 May 2024 13:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s57Um-00009C-Dw
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:23:52 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s57Uj-0001k1-Oy
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:23:52 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5af03aa8814so687740eaf.2
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 10:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1715275427; x=1715880227; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xwF/nbCURBpkQ4nID4bntEGUs6wHd4GNufxv7rbFTw8=;
 b=aGTbNc2b6cWY/gxgz8GndFH05isorOgJm1BVhFZZ7XdIIwvdZuXVPiOp2m0V2TP3iZ
 4brguKfyVNjZl53GtXprXGUuT/SJxWkEVc6YcF53VceHyPBxSI0jGhzEUVflYQRIzheK
 RVZ3AFK8eYOWSWSK1sw3k/HseeqkS3zbTcSz0t9QGMMkm4MMmYWDh9Mi5lx1/JMqylot
 PEllM9+QAEd/LvgsZEQDSOVnro1EcF/yNKY4NLMomxui1ZBW/jMtnqXKB5cg2mzsJmE8
 /+8HWREFtvfWtgip0Vg0BhjBEI4aCX4mirHg2+UxuSqr4gLspdUUvTdto+QRo83qQEgu
 JGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715275427; x=1715880227;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xwF/nbCURBpkQ4nID4bntEGUs6wHd4GNufxv7rbFTw8=;
 b=sNayy3YIq8o8hSUa4trPXWz+yUtgqc5arlusuLPaU28wTITir84EZKYpHj0e/sfKNc
 MpOkhR8+chs96qaqd9o6vEVzPqhnTW7gxm8nRAXwXap5yw0qxBMGM8ZQ4vXWN5GxFu+b
 A6mGUDYggkhdLv2BFQaUQq3qswapOjf43QkJYq0N7oCbVSGm3xYBWVdjnkBPRdjWXBz2
 ZxEuHfNtUIio8VcGdOAwQGonpYgE1ACcyhZAYNdAsWXSYk4QiBLTbofvmnjHUhG4MPlJ
 1ld/hNCuPQ1D86616uTuxPOYbuyZNxHwYryveDNVsCHB9ueSuljaTZDlRmJOlncANZP5
 r0HA==
X-Gm-Message-State: AOJu0Yz8qHtUumxo8BtDlbWrIbXnvIhBAXDeVItTWIJChzu6D1Gfu9JA
 zTfKM9nlUkzXnR5MN1ypYE+72HzI1f//S8zh2Rs1kOx+8EvgGhWel7DYHHVGp5s=
X-Google-Smtp-Source: AGHT+IFOAyvnNp+WnyYOD56KMdfUSmCE/bbac2IFvWwfxltD7ziRP2bno90IMEr9h5f3rJ+VMlaOCA==
X-Received: by 2002:a05:6358:8aa:b0:183:f636:8a46 with SMTP id
 e5c5f4694b2df-193bd0078b5mr3883455d.27.1715275427031; 
 Thu, 09 May 2024 10:23:47 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.42.168])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-63411904351sm1572753a12.91.2024.05.09.10.23.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 May 2024 10:23:46 -0700 (PDT)
Message-ID: <a53ac495-4656-4786-ba90-d83169aaffad@ventanamicro.com>
Date: Thu, 9 May 2024 14:23:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Remove experimental prefix from "B"
 extension
To: Andrew Jones <ajones@ventanamicro.com>,
 Rob Bradford <rbradford@rivosinc.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
References: <20240507102721.55845-1-rbradford@rivosinc.com>
 <20240508-ff6bfb7f94499a3a8d6382f6@orel>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240508-ff6bfb7f94499a3a8d6382f6@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc29.google.com
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



On 5/8/24 08:22, Andrew Jones wrote:
> On Tue, May 07, 2024 at 11:27:21AM GMT, Rob Bradford wrote:
>> This extension has now been ratified:
>> https://jira.riscv.org/browse/RVS-2006 so the "x-" prefix can be
>> removed.
>>
>> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
>> ---
>>   target/riscv/cpu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index eb1a2e7d6d..861d9f4350 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -1396,7 +1396,7 @@ static const MISAExtInfo misa_ext_info_arr[] = {
>>       MISA_EXT_INFO(RVJ, "x-j", "Dynamic translated languages"),
>>       MISA_EXT_INFO(RVV, "v", "Vector operations"),
>>       MISA_EXT_INFO(RVG, "g", "General purpose (IMAFD_Zicsr_Zifencei)"),
>> -    MISA_EXT_INFO(RVB, "x-b", "Bit manipulation (Zba_Zbb_Zbs)")
>> +    MISA_EXT_INFO(RVB, "b", "Bit manipulation (Zba_Zbb_Zbs)")
>>   };
>>   
>>   static void riscv_cpu_validate_misa_mxl(RISCVCPUClass *mcc)
>> -- 
>> 2.44.0
>>
>>
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> 
> I think we should also either change the false to true for RVB in
> misa_ext_cfgs[] or at least ensure RVB is set for the 'max' cpu
> type in riscv_init_max_cpu_extensions().

I prefer if we keep misa_ext_cfgs[] as is. Changing the defaults in this array
will also change the defaults for rv64. IMO we should enable RVB manually in
riscv_init_max_cpu_extensions().

We already have some precedence for it: RVV is enabled in 'max' while is default
'false' for rv64.


Thanks,

Daniel


> 
> Thanks,
> drew

