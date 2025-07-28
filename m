Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64135C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 15:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugQ9a-00059s-He; Mon, 28 Jul 2025 11:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugQ9X-0004K8-SU
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 11:52:39 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugQ9O-0003c0-7l
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 11:52:31 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-455b00339c8so28210495e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 08:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753717948; x=1754322748; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lq8YSIl3Pl9bTjpBcJX9r9CEWTYSDctT1Ilq9xEmYvA=;
 b=G4bB4fZYlm1iK+EG9c1BCqOLg6p7/Lh2dUW9K9dY952zLial4V8GTAhhs6aTnUq1Gt
 2iggQDPxZCwJ7johWyhnLJuMdv/ygG96M//auBmqq4BvOEICkt34jl9thj6W3jSARV/d
 5cvS4jMNoY1MhIM7hMgx1jxA57o9g6CAHW0U0hhTP9u7lNIEgyMOYfOct9rOSbPyDsI5
 LdUZ2XK8kaLWADs0rFgwunOoFg6JFeBU0rmv2Nv691MYtpKIl0gLZriegzqDRr8NKBe5
 Pvs2QgoOY0/FU5ezJm4D1c2t5LJG1l+Ll47EP7cWxrNLkBGlSxYmnI+z1XYxErAKKccE
 P7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753717948; x=1754322748;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lq8YSIl3Pl9bTjpBcJX9r9CEWTYSDctT1Ilq9xEmYvA=;
 b=PwYpZHwAbq9TCkRt156E5yF4kd4Wms8/+NQL9qvQ3vJ2h0bdwX8FOFggZR1vGrA69G
 9cbJu+LohdZngdk2hqLdUKVa7EYGMvRJjM7q9zpa8URuVFKsi3aweJSODHcUiu95UC2g
 SQr4BD+RuOyJ7APadl7u1TNsYMeFN4TUKEVd9MKgIxckA8VprVsY2Sdt3B17klQpRytj
 rmwhXC4l076nN4kzpIQPAP/fm/2N9Y1/lXMlpR+LXJkhOznFN9bTcYHpDKYMv0PkAPlJ
 SwzPcjhg04znNog0otLlIUViySMpZ7XRYrTphCmp31Ebt5kDUEPyWO9isPOHvnqaZvet
 JNaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXP+hSZMe8N3teYtoNcX78ikn1QQgQmqGV42Pv8G3qMRaF37Hevics++QRrYMj9LE0p3WpWkV9+UeC@nongnu.org
X-Gm-Message-State: AOJu0YxdYBthugL1hELI5WYpQ6lBAQZUPP8Wt2kLPb2bG3wsOwJ8ywwf
 y1E2KnutYWd0HHL8lhgBqo2sAnfb1LD4NayQJlQxIH44TxO1X56OhdUxn0XGo9wkuTzvEU2fFDL
 fudxw
X-Gm-Gg: ASbGncvoMfAgq+GD3oqlip00mktkrdL9lZg6rbEOzctb1y2ljrn8MTYcfqhvZRUqOl0
 by2XvaUZOm64EKaBb73hajFBYaosLxfKBERArzyHPPOSKatgQnPAc9Kb84L+d/r8j5tam/XlqMF
 cnRkECW2lg6550CyWxVnEXjlFrvzigh9GHGHs1U8tMa3RSM9rwfoeXVhfwlQ8CNrRSqRO9cgMTI
 TqmhUEJa9AjxdzGeVQz089l+TSD/rGx9tDRwL8Kn0GVzw0kRxzdMam1rEhO/UMinWUcRBt8wRwN
 uBbiH9vb8TzcpGC5rHl/ngtQxY5JHsyfd27yWbXA/GDASRfbjOa4HDryNzb+s1/+VaaRk/vQDRU
 zQjJBG8LV+iHhWjnQt6mPNJWT9CJ2RXu0GPKHTht3EuGE2ZoLlnPBE7avQRW7VSmdJg==
X-Google-Smtp-Source: AGHT+IHkeGi7IP0eUfZaP8iHinZ572KNycvHYxsunLh0j2mXuYLF85EznRvA8qtQL61cW0FQB4Vgcw==
X-Received: by 2002:a05:600c:860b:b0:456:285b:db24 with SMTP id
 5b1f17b1804b1-4587654e50cmr92240985e9.28.1753717948207; 
 Mon, 28 Jul 2025 08:52:28 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587054f27dsm160707155e9.11.2025.07.28.08.52.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 08:52:27 -0700 (PDT)
Message-ID: <187caaa6-ddc4-4e20-8c51-60bd7f254311@linaro.org>
Date: Mon, 28 Jul 2025 17:52:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] hw/mips: Proper multi core support
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU devel <qemu-devel@nongnu.org>
References: <20240506-mips-smp-v1-0-3cc234786910@flygoat.com>
 <632e091b-9af7-4363-8ce6-73cb6bde41b4@app.fastmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <632e091b-9af7-4363-8ce6-73cb6bde41b4@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 15/7/25 21:08, Jiaxun Yang wrote:
> 
> 
> 在2024年5月6日周一 下午4:31，Jiaxun Yang写道：
>> Hi all,
>>
>> This series implemented propper multiple core support for MIPS
>> CPS systsm.
> 
> Ping :-)
> 
> This is a really long outstanding series, I just want to get some
> review before respin.

Tagged for review, sorry I missed it...

> 
> Thanks
> Jiaxun
> 
>>
>> Previously all CPUs are being implemented as a smt thread in a
>> single core. Now it respects topology supplied in QEMU args.
>>
>> To test:
>> Build a latest kernel with 64r6el_defconfig (tested on 6.6,
>> next-20240506).
>>
>> Then run:
>> ```
>> qemu-system-mips64el -M boston -cpu I6500 -kernel ~/linux-next/vmlinux
>> -smp 4,cores=2,threads=2 -append "console=ttyS0,115200" -nographic
>> ```
>> In dmesg of guest kernel:
>> ```
>> [    0.000000] VP topology {2,2} total 4
>> ...
>> [    0.085190] smp: Bringing up secondary CPUs ...
>> [    0.090219] Primary instruction cache 64kB, VIPT, 4-way, linesize 64
>> bytes.
>> [    0.095461] Primary data cache 64kB, 4-way, PIPT, no aliases,
>> linesize 64 bytes
>> [    0.096658] CPU1 revision is: 0001b000 (MIPS I6500)
>> [    0.096718] FPU revision is: 20f30300
>> [    0.124711] Synchronize counters for CPU 1: done.
>> [    0.940979] Primary instruction cache 64kB, VIPT, 4-way, linesize 64
>> bytes.
>> [    0.941041] Primary data cache 64kB, 4-way, PIPT, no aliases,
>> linesize 64 bytes
>> [    0.941256] CPU2 revision is: 0001b000 (MIPS I6500)
>> [    0.941289] FPU revision is: 20f30300
>> [    0.965322] Synchronize counters for CPU 2: done.
>> [    1.260937] Primary instruction cache 64kB, VIPT, 4-way, linesize 64
>> bytes.
>> [    1.261001] Primary data cache 64kB, 4-way, PIPT, no aliases,
>> linesize 64 bytes
>> [    1.261172] CPU3 revision is: 0001b000 (MIPS I6500)
>> [    1.261209] FPU revision is: 20f30300
>> [    1.285390] Synchronize counters for CPU 3: done.
>> [    1.346985] smp: Brought up 1 node, 4 CPUs
>> ```
>>
>> Please review.
>>
>> Thanks
>>
>> To: qemu-devel@nongnu.org
>> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>> Jiaxun Yang (5):
>>        target/mips: Make globalnumber a CPU property
>>        hw/msic/mips_cmgcr: Implement multicore functions
>>        hw/msic/mips_cpc: Implement multi core support
>>        hw/mips/cps: Implement multi core support
>>        hw/mips/boston: Implement multi core support
>>
>>   hw/mips/boston.c             |  37 +++++++++-
>>   hw/mips/cps.c                |  66 ++++++++++-------
>>   hw/misc/mips_cmgcr.c         | 168 +++++++++++++++++++++++++++++++++++--------
>>   hw/misc/mips_cpc.c           |  97 ++++++++++++++++++-------
>>   include/hw/mips/cps.h        |   1 +
>>   include/hw/misc/mips_cmgcr.h |  87 +++++++++++++++++++---
>>   include/hw/misc/mips_cpc.h   |  15 +++-
>>   target/mips/cpu.c            |  16 ++++-
>>   target/mips/cpu.h            |  10 ++-
>>   target/mips/sysemu/machine.c |   5 +-
>>   10 files changed, 403 insertions(+), 99 deletions(-)
>> ---
>> base-commit: 248f6f62df073a3b4158fd0093863ab885feabb5
>> change-id: 20240506-mips-smp-9af9e71ad8c2
>>
>> Best regards,
>> -- 
>> Jiaxun Yang <jiaxun.yang@flygoat.com>
> 


