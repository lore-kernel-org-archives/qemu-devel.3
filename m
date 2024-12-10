Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9DDE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 10:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKxLx-0000Bx-Hc; Tue, 10 Dec 2024 05:20:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKxLw-0000Bm-8n
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 05:20:28 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKxLu-0004qg-KI
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 05:20:28 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-434e8aa84f7so27892705e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 02:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733826024; x=1734430824; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WLJJKR4g8Lf6ZhMTdgf/fSQxGiDG9nvJadsF9I5oKK0=;
 b=yrOzsytZg0jgywpMDg1xVqa802xiJFyEhKCIT6TA5XVAX/mk0zvMvnp+4dKd6uIegE
 /kbmpC+W6YgouTZhmHxWqTfqOXPo0juTYwfcEMmIncotn4xh537ICP+xtTRLg9jMh7Vf
 Bo2vhLS+A8FjBqnjO62uCHA5VyRcMUIVgJ2pmsByaeOGBN3/UBKEVGb120kzSxz1x+da
 0iuRj6+Vyegm1HCA4mLsPzndl+pVbjrqL5dg5v6DPJKPgPoNby8mXjfYXTBTycLLaZkZ
 rpBllNJitpky/MAx1OuAUwSjpM4p+p11OoOBFOyCs7fLT6URFoPW3Atid9kcdhDDgfeJ
 9Stw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733826025; x=1734430825;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WLJJKR4g8Lf6ZhMTdgf/fSQxGiDG9nvJadsF9I5oKK0=;
 b=YFXuYIZi0742CqYViQ9yj/wgS1TlG+OsdXu8EAN8VNNFe/IaXuRprpFvo7OsPdklZs
 eXyNnXjKKhm+F4bOd1skIlW8/bxVf3OJ2PlUwbuDACdWZryuO/b2z51lNqB72crLsKVP
 MlP487ZSRyjYjQOklZTC7GLSrzsjIt9HLuv0hSy8wkvqFW0SBdMNiNHYD3uGeNTybdVK
 I2IHNs/a0dCxu4MRcAp707cyaBulcw5JDFHWuyIikIc0p2gOY8fq8Ox4C5dJcizCG9a5
 lmS0Lw3HwoIDoF06CfwnOs5NLZQuOUPrAxsw5+RxxIxMNLcUXJm8+CAAbSfjCnhRDs8w
 dpvA==
X-Gm-Message-State: AOJu0YzScrRwpRrtUg+vmJUicgE0MarTSigbmBDJNt/7Um1MY1cyCFJY
 Ikw5JzBHbPcggRZY3VAPXR0/krUK9VG5P1ixqybWSftF3T+vBe0R0YD2SXennt8=
X-Gm-Gg: ASbGncvr3yU2a0q5PGV7F1q/28EjzXtarwY1bkB0RdozN6E2Ms/fWVj4GumkxKtfNKK
 a4qDmgPI8K0nescfk7WJd1wfJYNIJNX2pgv+2pPlTRoFQXUxlywC5wYmKTJxHbqidwYw9TfD1ri
 ZvUDsz+CfEYNmo06bitJ8y1mgnh5af3VqUPAJzzrhujyzgFky+j+0ExlIzorCnfwQN9r3O5CSha
 JKcjGGKZQTu0VxE7cvjA02Pe5X9kHjnQdfwQX25IIdqNj1b74F8KGFwSsyY7btBxgxApM09UjKb
 HaUtEx5NLnOEZTsH9893ZA8F75pGxgg=
X-Google-Smtp-Source: AGHT+IFU1V4F6COziuz8QMpN9LcTIMT6BlE1gAJcJn95+76AC6IkqtmtFzFYZZ8LMiONifOfzQGkTA==
X-Received: by 2002:a05:600c:6b69:b0:435:9ed3:5698 with SMTP id
 5b1f17b1804b1-4359ed35940mr12464715e9.24.1733826024671; 
 Tue, 10 Dec 2024 02:20:24 -0800 (PST)
Received: from [192.168.224.213] (1.red-95-127-47.staticip.rima-tde.net.
 [95.127.47.1]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4359b4073f5sm14142525e9.17.2024.12.10.02.20.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 02:20:24 -0800 (PST)
Message-ID: <0406480e-29aa-4207-970c-818db3de0291@linaro.org>
Date: Tue, 10 Dec 2024 11:20:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0] system/qtest: Access memory using
 cpu_physical_memory_rw() API
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20241127191914.34146-1-philmd@linaro.org>
 <CAFEAcA-H2kS0GdXpDpA3mFm1eOZnudZCn8REYNo34+PsvimfmQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-H2kS0GdXpDpA3mFm1eOZnudZCn8REYNo34+PsvimfmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 10/12/24 11:03, Peter Maydell wrote:
> On Wed, 27 Nov 2024 at 19:20, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> There is no vCPU within the QTest accelerator (well, they
>> are stubs doing nothing, see dummy_cpu_thread_fn).
>> Directly use the cpu_physical_memory_rw() API -- which
>> amusingly prefixed 'cpu_' does not use vCPU -- to access
>> memory. This reduces accesses to the global 'first_cpu'.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   system/qtest.c | 42 ++++++++++++++----------------------------
>>   1 file changed, 14 insertions(+), 28 deletions(-)
>>
>> diff --git a/system/qtest.c b/system/qtest.c
>> index 12703a20455..a2de9a7d5a4 100644
>> --- a/system/qtest.c
>> +++ b/system/qtest.c
>> @@ -18,6 +18,7 @@
>>   #include "chardev/char-fe.h"
>>   #include "exec/ioport.h"
>>   #include "exec/memory.h"
>> +#include "exec/cpu-common.h"
>>   #include "exec/tswap.h"
>>   #include "hw/qdev-core.h"
>>   #include "hw/irq.h"
>> @@ -514,23 +515,19 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>>
>>           if (words[0][5] == 'b') {
>>               uint8_t data = value;
>> -            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
>> -                                &data, 1);
>> +            cpu_physical_memory_write(addr, &data, 1);
> 
> I'm not a huge fan of this, because cpu_physical_memory_write()
> is one of those old APIs that it would be nice to see less
> use of, not more. Ideally anything issuing memory transactions
> should know what it's issuing them to, i.e. should be using
> address_space_* functions and passing an AddressSpace.

I totally agree with you. I'm chasing one problem at a time
starting by first_cpu, and you are already seeing ahead :)

Do you mind posting a documentation patch clarifying the
cpu_physical_memory_*() methods we want to deprecate?

> If you don't want to use first_cpu, then you could use
> address_space_write(address_space_memory, ...), which is
> what cpu_physical_memory_write() is doing under the hood.
> The qtest protocol assumes a single address space anyway.

Correct, good idea.

Next problem I have here is to understand what 'endianness'
means for QTest framework. Use case: heterogeneous ZynqMP
with ARM and MicroBlaze cores.

Thanks,

Phil.

