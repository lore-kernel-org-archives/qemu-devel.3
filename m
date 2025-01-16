Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB208C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 13:03:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYPWR-0005f2-7m; Thu, 16 Jan 2025 08:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tYPWP-0005el-SH
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 08:02:53 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tYPWN-0000cT-3K
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 08:02:53 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so5444795e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 05:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1737032569; x=1737637369;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=769Ka4bk9YQufsJviFzWsdT1q/0/E1441hXfAmRS0e0=;
 b=v2PGumFQ7ic0VPByOQXqMtzmf5jrM7n+ZmHYe4gYNnTxnq+wYgiCAeNF7wP8vQn/63
 ZDjutX7Q3+MDMlaz98G/JMFLs9KmJdqJzNiqvVby9OgZRayl9oURRZtWgpakA7FM02Xe
 V4Gp+iBajjyCpElApZVgSfh9vLV2Y68fBa72NmetGQ7DyQkz8ZQj4SKe8/JwjaFFZ3Mz
 IhoLnI7QRfh+i/dJQYz9DsyF1kMIq7FgLttToaEzDXXS5A0PxyEM8jVNtYqKwXjOrIfE
 W8i05FaAo+S2qL/KxMiJgtIiZqJFbVnWtYblQjdOoqp/ZkgPXV//WmM4kKi2qpFSixfL
 XfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737032569; x=1737637369;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=769Ka4bk9YQufsJviFzWsdT1q/0/E1441hXfAmRS0e0=;
 b=E1FoDWmJFHGbBZ8LIiKrxZ+t5LGlgHvZr1nm9ACsQmkNIV1cHc2Nal6YyFn7dZRqKy
 L2X+TGPi0h66mYAX7W/ZWfC2tlBTz1jtkxVExBLkWHdqvuSXnuEtKuMnWpq1hvqRxI/1
 oaLWe2SWWpWqbQ1bAyIEAkAaKL+AJ+xjKhaxL8VgAZ3ESliHD9vKGVhBQYRjcC23Gs39
 QhoT2ddICNtcRtWxSTlkCEPChAau7+C+SkNr9+CZtD/SPVErzAwz1Ui87JFdQqVs+mRE
 rGM6ojnJWH9UUWtl3+kqlR/qiCel1MgRnxMS7oFFSM6MSFQS4CgSZzfg6zZ3M3BzUT8Q
 iLzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFqmKGG1eGbysz/uuUXuI6orcff7ySX6yfMJqrWpw2YoCVScP4BWiUdB7jU/jf+xTkxnzYaLi6DtXl@nongnu.org
X-Gm-Message-State: AOJu0YzkLLVo+JBYoJfAtCYfAhngAtiRRF6PL7kX5XzwqSyTsRoSGbyo
 3licSQRxmP7Dedd3RXwTJ+Vg+O+Pjyr3Jj0Mr6TVGeAviBN9AmzBRcrC9gwL/UA=
X-Gm-Gg: ASbGncuWoFhBsiE0bhBzEKW9peMKdFiedyhuCOmW9ieggS38buZ1yZm3EbRtUDzc2lO
 xIqq8EGUZqhMX06y9kEjWV1wMZePcjDvx7JxyEWklY6fQUmBrmhWhBZ9ZVFA2Vjf1R29swq870R
 q3nw/uXsDy3fPUYNJKxNGRZc5kdzDXPS+KLXuAV7dxQZUAQW5kbqR8/gOzmg7Uj8vM5Ds2RuRNa
 AtE9SC//CQ8ZuuaPIiPUO9XjxHgA1q0Z+/0F3pKqqFdLOM/P1k1agSooG374UNUXYetvovfzQ/b
 TopRhEPuXYXfAMgHO3cjH/rXaA==
X-Google-Smtp-Source: AGHT+IEx+fpgV2iXYSYtwC0+4+T9nULOXuUrj+61cFZcVmZcCas9CsasZT9tOEKfgCwuVaKF9K2qGw==
X-Received: by 2002:a5d:6da6:0:b0:385:f573:1f78 with SMTP id
 ffacd0b85a97d-38a8730abc6mr27372061f8f.24.1737032568798; 
 Thu, 16 Jan 2025 05:02:48 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626?
 ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7527fc4sm58940525e9.27.2025.01.16.05.02.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 05:02:48 -0800 (PST)
Message-ID: <a00e11c7-4f68-4ab9-b098-061be8184b93@rivosinc.com>
Date: Thu, 16 Jan 2025 14:02:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: disable Smdbltrp for the max cpu
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
References: <20250116092352.1630278-1-cleger@rivosinc.com>
 <9c58515e-bdbd-4183-9587-a7fd205717db@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <9c58515e-bdbd-4183-9587-a7fd205717db@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x335.google.com
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



On 16/01/2025 13:15, Daniel Henrique Barboza wrote:
> 
> 
> On 1/16/25 6:23 AM, Clément Léger wrote:
>> When present, Smdbltrp is enabled by default and MDT needs to be cleared
>> to avoid generating a double trap. Since not all firmwares are currently
>> ready to handle that, disable it for the max cpu.
>>
>> Reported-by: Atish Patra <atishp@rivosinc.com>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>
> 
> This breaks 'make check-functional' indeed. Not sure why we didn't
> notice it
> earlier.
> 
> The change is fine but it should be made in the patch that introduced
> the error
> since it's not merged upstream yet. The patch is:
> 
> [PATCH v8 9/9] target/riscv: Add Smdbltrp ISA extension enable switch
> 
> Otherwise we'll have a gap of patches where 'make check-functional'
> won't work
> and it'll make our lives harder when bisecting stuff. This is the same
> review I
> gave Frank in the v10 of the 'smrnmi' series:
> 
> https://lore.kernel.org/qemu-riscv/26ecf1ca-07eb-4aed-9d06-
> a12c036c0723@ventanamicro.com/
> 
> You can re-send "target/riscv: Add Smdbltrp ISA extension enable switch"
> as a v9 (I
> believe it's fine to send it standalone, no need to re-send the whole
> series) with
> this patch squashed in. Alternatively Alistair can squash in this change
> in his tree
> if he's up to it. Whatever works.

I'll send a V9, thanks for the explanations.

> 
> But an extra patch is only justifiable if the change that broke stuff
> already made
> upstream and there's nothing we can do about it. This is not the case,
> and  we should
> fix it properly while we can.

Yes, this perfectly makes sense,

Thanks,

Clément

> 
> 
> Thanks,
> 
> Daniel
> 
> 
>> ---
>>   target/riscv/tcg/tcg-cpu.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
>> index 48be24bbbe..0a137281de 100644
>> --- a/target/riscv/tcg/tcg-cpu.c
>> +++ b/target/riscv/tcg/tcg-cpu.c
>> @@ -1439,6 +1439,16 @@ static void
>> riscv_init_max_cpu_extensions(Object *obj)
>>           isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smrnmi), false);
>>           qemu_log("Smrnmi is disabled in the 'max' type CPU\n");
>>       }
>> +
>> +    /*
>> +     * ext_smdbltrp requires the firmware to clear MSTATUS.MDT on
>> startup to
>> +     * avoid generating a double trap. OpenSBI does not currently
>> support it,
>> +     * disable it for now.
>> +     */
>> +    if (cpu->cfg.ext_smdbltrp) {
>> +        isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smdbltrp),
>> false);
>> +        qemu_log("Smdbltrp is disabled in the 'max' type CPU\n");
>> +    }
>>   }
>>     static bool riscv_cpu_has_max_extensions(Object *cpu_obj)
> 


