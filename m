Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902EDC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 09:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN7Ai-00042S-BS; Thu, 05 Jun 2025 05:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uN7Ah-0003wr-0J
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:46:03 -0400
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uN7Ae-00022v-7R
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:46:02 -0400
Received: by mail-ua1-x944.google.com with SMTP id
 a1e0cc1a2514c-87ea63be17eso588180241.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 02:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1749116759; x=1749721559; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5uLtTHnui3FZB+pvN4W3jKkwDUlgYik0UvBfWH5ZE9E=;
 b=UNvtoHeoCd320+RHwdWctDUK+V3Z4ug9kz192hpFN/HrgkpwcShuMdVNmUAZWIlggR
 kZ3NS3sObwuhNtAfdm3H66a0eseEcHtSd5I/gjvGfUBAA5ASFnOj6tud6q6LMTQ9/Fs/
 MKDHsgJWsWsFSS8/mHN8hg/EK3hzxVohvLgXFC6WFu03F0esgp1PqtU2snoj38RlOZCh
 omwQxSRQzsG94XVdHYd64PpUSceqtv7bZxG9fp83sMefwDd80BIrlX6nHrEoU5VvKdOH
 xR309Tps7mJgcygq+T/X9ialQidOUCCyceM/KkcZ7Kh509tUVTTFukv3DKpr8vL0hTtA
 ytsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749116759; x=1749721559;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5uLtTHnui3FZB+pvN4W3jKkwDUlgYik0UvBfWH5ZE9E=;
 b=mtaaRCYb9ihyECseMNyV7G9OY1sgsJEYBTemVyZdvyjHXs2iYbpXjQuAuE+d2677fE
 lh/Ej1p6s5tILBjatZVaOLX2l2Pw/hpUEnmlRCzDbrZbfZOdKr2akffohPEXTKib+fAo
 kqN7uSOnnYwa5g/TzPdkYVnTDCg4fF8W1PD2prEvqqjtVs0r+zxRfvwyLPaD61p+cueJ
 XxFbJgOrWBdRP+Exxyy26AiJv/bypXUBO6VNmzKI28JNJjIj4dweJS46iFzGc/pmFIp0
 uI/Z70WkTGm7gL/c0GTCC4so9x5zgSNXcOxFaPHFj3ehf/MWKvKAviGQ+FGSlu/0uDv5
 rafA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN2+118SQYqWMmCf2vBJL28920cOoVrNcf3L4nl1ukozkMP1iq4S0inST3VdQfFFMHpiS/8RRh7vjG@nongnu.org
X-Gm-Message-State: AOJu0YzPAm1e7h1cR01kPMFtzAnA2jqtt4LpBdzVorl4SUA5EZGaaZPI
 8g1CEncgg2ukUzwcIrg4f1JqQrRe7WSxdsQP4xCRL4QGZCbPUPESd5xMwsdp0r24Aag=
X-Gm-Gg: ASbGnctZgKhFRZ+Vvxx9h4iUR1BY+o8CgtpveS3VnKz3a8tXbgFDVsaWsyI+oLJ7mAd
 R0TO8oQ0d2yWwBFIurwZF1qOvsZFKfdQIqrvzdRBTnCAtXX2MzRp8T8oNC1SiPEPsJnfGCopPOT
 1d5IFXgpsfqeGEZRe16Gqb56lBIjZibEoQFCYNC1S7aFVdxPDADQTneyp5pshhfGlFauZC2JLqa
 +LWBH+6DzyjdkoalrmqCtD438NVAY3kj1Zw+kUoTxAGbVwfqrFNVJsZCOWUEfgYCsIa1hSzRp7X
 HwE8jAZaQTQOWmRaA5p0Vt7qtMymqzDw5qE7SnWEneedkZkmqVTrGKxEI08oH1bpuNc=
X-Google-Smtp-Source: AGHT+IE4KVHmpyVIwQfdTHULoVRAUI+ppKQhm0O8jLD/BLfVPSq+8RqCs/k2JCS83Ej/21cj0C6ESw==
X-Received: by 2002:a05:6102:c88:b0:4e6:d9b8:ddd5 with SMTP id
 ada2fe7eead31-4e746e63862mr4721512137.17.1749116758962; 
 Thu, 05 Jun 2025 02:45:58 -0700 (PDT)
Received: from [192.168.68.110] ([177.188.133.196])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4e644499c7csm11249888137.15.2025.06.05.02.45.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 02:45:58 -0700 (PDT)
Message-ID: <57693dc5-b624-4697-a26b-097c0fa4cce9@ventanamicro.com>
Date: Thu, 5 Jun 2025 06:45:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/kvm: use qemu_chr_fe_write_all() in
 SBI_EXT_DBCN_CONSOLE_WRITE_BYTE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
References: <20250605090012.1268809-1-dbarboza@ventanamicro.com>
 <0b6b429a-a3bc-4707-9e94-67d9fe8cc363@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <0b6b429a-a3bc-4707-9e94-67d9fe8cc363@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::944;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ua1-x944.google.com
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



On 6/5/25 6:26 AM, Philippe Mathieu-Daudé wrote:
> On 5/6/25 11:00, Daniel Henrique Barboza wrote:
>> The SBI spec states, for console write byte:
>>
>> "This is a blocking SBI call and it will only return after writing the
>> specified byte to the debug console. It will also return, with
>> SBI_ERR_FAILED, if there are I/O errors."
>>
>> Being a blocker call will either succeed writing the byte or error out,
>> it's feasible to use the blocking qemu_chr_fe_write_all() instead of
>> qemu_chr_fe_write(). This is also how SBI_EXT_DBCN_CONSOLE_WRITE is
>> implemented, so we're also being more consistent.
>>
>> Last but not the least, we will duck possible changes in
>> qemu_chr_fe_write() where ret = 0 will have a 'zero byte written'
>> semantic [1] - something that we're not ready to deal in this current
>> state.
>>
>> [1] https://lore.kernel.org/qemu-devel/ CAFEAcA_kEndvNtw4EHySXWwQPoGs029yAzZGGBcV=zGHaj7KUQ@mail.gmail.com/
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/kvm/kvm-cpu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Thank you very much Daniel!

No problem :)

FYI I just sent a v2 with a small change in the commit msg. Your ack was kept.
Thanks,


Daniel

> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


