Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0DDE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 11:05:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrqU-00042J-Sz; Wed, 18 Dec 2024 06:04:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tNrqP-00041T-17
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:03:57 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tNrqH-0001cI-8g
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:03:55 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21634338cfdso75945865ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 03:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1734519827; x=1735124627; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5X8wu85NI9VQoYk+JtbHSheI96U8+39HiJCa2Lyf14A=;
 b=MP9C3EYVjtkisGFo1tu4ZKLmhta9njqrkdt/chIjeeAL6yaoOBVBz6VWfGSd//7ESH
 aJDMKtMrIOmp12CliiU6ZyXAAKEhP6Cg1CuUQ6yMZLX7rvStN1OXBoc2N/ESEJ9IbDY0
 FXRN4lEA3lJJprJIbY7N1lYkdQN48VBjKPQxVP8kdr0Rpl/15dM1nbBFiSJNahjmmGWk
 yppaqsvvgAERn9qv632jUAbhdX7hsofeEu9dJebCJ4ZGxpOp52QB8gU91t6rCWnm6SLN
 5NpzdOofdBh26KkliYscf1V/h2bJBX+YSxAlUw0juuFKDtJcTzN+i/d+6j1TFPnLytRb
 pAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734519827; x=1735124627;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5X8wu85NI9VQoYk+JtbHSheI96U8+39HiJCa2Lyf14A=;
 b=GCobEIfRMZ8dk3lYjnddXHS+G1H07M8pzOxRJa3QtXPrtSsO4YZ3ER0kU2qMxuNxZP
 OnBO2oxOMCLCiWTfOwpW0I975ZxSXYFpM8mKhsmOjLgGHXUBhjDGkjrgZXgXjV4dDkx8
 nWPap/1hHIBFLgpG6unjgiHqwn+7i3pK/kjQBjuDOm5ZQE7zOmXhV1DH0Rv45w4HAT2S
 iPFxt+mH7rP0/d5uSWqVCfSD4E3vJVXT3p4AdQmdHCwDkjHocbsaJ/Bh/WJlRnaQ4/PI
 99BqRr8cDLmR4axZF78fOn1is0/qWSAS95Frii3oVdrbW09/PlXe/38bwFqVV0okcI7h
 v0AQ==
X-Gm-Message-State: AOJu0Yw7J8PXFuDR9TSexoQRBKEKWP/cPePOcHxUkCdNnR0hmwYajUTL
 4wTYbPNdIsCz7v1MBDVToSSWuKZ6RKWJGM27qao5s8gufaUnND1/NxpFz1a8p6h8s5sula1L273
 d
X-Gm-Gg: ASbGnct8X5ecblXDCoa4NaVOe1dcZDQtntRke84IHEwXpLjJLAhqRpCrlo8+OVv9Sm9
 PQE5jYfzEUvL/Unc5YdNbzg2TmqkK4gwskGmzvGi2pfFztfbbrRBPI58/gQz4soiJLz+3pmP4Lc
 eLqZnA7LSnMk8ciQ3+N1hdNEQnkpdaRAEV21tSzlSLA8MJ1gKCPtkxyuoggaoYfwMUCyu+ztc1R
 BE0j01dxsC5u1aRo6e+P9KlLn5h+NqlrXzfTMLT8dGYhcu+nTjA3UkSCpnWemB9NjpX2yj+iZ/Y
 SmH4bGcbpc36+sVo+SNyo8e7KERThRly
X-Google-Smtp-Source: AGHT+IGCc3s+Gl6vriD+LrydMSVCcztnPvCe9b/V7J7RGKPnnOo5M8xSOaHGjMxfmfrKFLir2ATd9w==
X-Received: by 2002:a17:902:eccc:b0:215:5ea2:654b with SMTP id
 d9443c01a7336-218d6fcd6famr37115435ad.1.1734519827049; 
 Wed, 18 Dec 2024 03:03:47 -0800 (PST)
Received: from ?IPV6:2804:7f0:bcc0:51cf:9cf:d2f2:d49e:7bd9?
 ([2804:7f0:bcc0:51cf:9cf:d2f2:d49e:7bd9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218d31fde88sm16047415ad.231.2024.12.18.03.03.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 03:03:46 -0800 (PST)
Message-ID: <53a8a96b-e727-4f9a-b3a3-a92100ca580e@ventanamicro.com>
Date: Wed, 18 Dec 2024 08:03:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 3/9] target/riscv: add shcounterenw
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com
References: <20241113171755.978109-1-dbarboza@ventanamicro.com>
 <20241113171755.978109-4-dbarboza@ventanamicro.com>
 <CAKmqyKMiFAduuiQDuo2Zcs0FXHG3e+VT2BsB5cE1rQjL2+5FFg@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAKmqyKMiFAduuiQDuo2Zcs0FXHG3e+VT2BsB5cE1rQjL2+5FFg@mail.gmail.com>
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



On 12/17/24 9:34 PM, Alistair Francis wrote:
> On Thu, Nov 14, 2024 at 3:20 AM Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>>
>> shcounterenw is defined in RVA22 as:
>>
>> "For any hpmcounter that is not read-only zero, the corresponding bit in
>> hcounteren must be writable."
>>
>> This is always true in TCG so let's claim support for it.
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> 
> This seems to break `make check`, specifically the
> `qtest-riscv64/bios-tables-test` test

In fact every patch that ended up adding a new riscv,isa that is always
enabled in rv64 will trigger a change in bios-tables-test. Figures.

I`ll re-send. Thanks,


Daniel

> 
> Alistair
> 
>> ---
>>   target/riscv/cpu.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 4ad91722a0..6bfb1b1530 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -183,6 +183,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>>       ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
>>       ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>>       ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>> +    ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
>>       ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
>>       ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
>>       ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>> --
>> 2.47.0
>>
>>


