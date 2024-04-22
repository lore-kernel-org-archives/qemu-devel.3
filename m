Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64609C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 13:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rytJG-0000ZT-QN; Mon, 22 Apr 2024 09:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1rytJ9-0000YT-Cq
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 09:02:07 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1rytJ5-0000CB-Qx
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 09:02:07 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-349bd110614so773478f8f.3
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 06:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713790921; x=1714395721;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=msJIZBAlNSRvum4JVDHS8jLA1sUyfGdrKRHLEguwhEU=;
 b=c3rXlBbmn8fbd5Bzyip3hpplzE1tWZkXPqgOvDFv5xSiXpAK2hCNIm7XLTtWTPqttj
 fNrqEUJZkWsSgUShBzZedPFLJ++gYg0i6keYzHCmRa6gvjnONBzK+arPLOzIBwPyO/kj
 3+9us/0vjAgqSxU6vhkPSJ2uOZe6B1SWSr+nZPloAScnaFODjjB78SDsNIw6dLsRaDow
 YvbvGSydgHWNRJWH+VEyr+RtCOuC8+D803KZOTLe64HgAp26YvZGnXkIuedizYI+Aniu
 tCVXUShZonps412QogNUj8PoIqdUhOkjNRn4YEqd3dOrB4FFTtlyNp8tSC7oDOWktymg
 0LuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713790921; x=1714395721;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=msJIZBAlNSRvum4JVDHS8jLA1sUyfGdrKRHLEguwhEU=;
 b=bFcoGADZwcI/NfZy7+DoZiiLNuvcE5D4bdOCa9pGDMm32lBURy58e2o5Th/DEkrGSU
 mHf+aVMyveTlv8oGnzkhItNca4vbzBS21+EQnmzyGSK3D+ZRqUowyl4ChGxW98vHhCa6
 1mcu/MgZPlnvwowYHcwRXfl9jGpC6c01/pyuHzDbjcLGv/8LpDszsU9GUTP+LZ1j+gTd
 rYLVUKDy3DBOdv6yUTBf+XsR6IgV51pPS8UI4rQ6ucRuIjbWbNsDJq9ERmQ6jGQ2IaoF
 C7UNStVIgZk61IUlpD5H7ac4qJkkY6yzeA1cfsWtOgFmygoDtv/LWEfeuqLBymTRTzlB
 NBMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnYiBkMXo1R3fH1NzuIftzAiT/5Rjtu2VuhU1wmQf/js4PKDGs+1v+wc3Ld1wXG0SOQC5i/rjYY/AjzDmGeisLCTJ+RPo=
X-Gm-Message-State: AOJu0YyIh/AOxUIdIHvVDDXp/+FJGwYQGQdgRydBMsEQP68DTEQqD4dA
 G0V+eIlNvruXE/tZhU/wHSYAVMircaV67in5ErKYfZyt8RZ4TB0GcDHWZ9B1jWw=
X-Google-Smtp-Source: AGHT+IFK81k8uPi2VWArzTS61C9PYgxnGWb72u0mhGETeimKHXhztYOcDgcxHxuBa50U7zhpnWBzHQ==
X-Received: by 2002:a5d:4a90:0:b0:34a:ce2:e2c9 with SMTP id
 o16-20020a5d4a90000000b0034a0ce2e2c9mr6171329wrq.3.1713790920385; 
 Mon, 22 Apr 2024 06:02:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:9f43:3ca4:162c:d540?
 ([2a01:e0a:999:a3a0:9f43:3ca4:162c:d540])
 by smtp.gmail.com with ESMTPSA id
 w14-20020adfee4e000000b00343d6c7240fsm11925679wro.35.2024.04.22.06.01.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 06:01:59 -0700 (PDT)
Message-ID: <bdc875c7-4581-4608-a76d-3e3469a8bc9a@rivosinc.com>
Date: Mon, 22 Apr 2024 15:01:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] target/riscv: change RISCV_EXCP_SEMIHOST
 exception number
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue
 <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
References: <20240418133916.1442471-1-cleger@rivosinc.com>
 <20240418133916.1442471-2-cleger@rivosinc.com>
 <CAKmqyKOcYwAgEnV-gyUYu19dLCKx94-rMoaE5m-8FB0fq7AL+g@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CAKmqyKOcYwAgEnV-gyUYu19dLCKx94-rMoaE5m-8FB0fq7AL+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



On 22/04/2024 05:25, Alistair Francis wrote:
> On Thu, Apr 18, 2024 at 11:40 PM Clément Léger <cleger@rivosinc.com> wrote:
>>
>> The double trap specification defines the double trap exception number
>> to be 16 which is actually used by the internal semihosting one. Change
>> it to some other value.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Hi Alistair,

Ved actually told me that even 17 is reserved so I'll move the semihost
one to 63, which is in a range designated for custom use.

Regards,

Clément

> 
> Alistair
> 
>> ---
>>  target/riscv/cpu_bits.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
>> index fc2068ee4d..9ade72ff31 100644
>> --- a/target/riscv/cpu_bits.h
>> +++ b/target/riscv/cpu_bits.h
>> @@ -670,7 +670,7 @@ typedef enum RISCVException {
>>      RISCV_EXCP_INST_PAGE_FAULT = 0xc, /* since: priv-1.10.0 */
>>      RISCV_EXCP_LOAD_PAGE_FAULT = 0xd, /* since: priv-1.10.0 */
>>      RISCV_EXCP_STORE_PAGE_FAULT = 0xf, /* since: priv-1.10.0 */
>> -    RISCV_EXCP_SEMIHOST = 0x10,
>> +    RISCV_EXCP_SEMIHOST = 0x11,
>>      RISCV_EXCP_INST_GUEST_PAGE_FAULT = 0x14,
>>      RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT = 0x15,
>>      RISCV_EXCP_VIRT_INSTRUCTION_FAULT = 0x16,
>> --
>> 2.43.0
>>
>>

