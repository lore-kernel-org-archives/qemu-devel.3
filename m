Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C81AE77182
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 10:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKxWj-000238-Gj; Tue, 10 Dec 2024 05:31:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKxWb-00022e-S6
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 05:31:30 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKxWZ-0006Ju-Jq
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 05:31:29 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-434a1833367so31576915e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 02:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733826685; x=1734431485; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2S4UKBM/zZpdKLdp8wtDNjWkAVE4tJbEPcjrJ4K7Vcw=;
 b=yE5rKtg7GioIX6SuG2TKrCN7S+Rkr1erIKlQjHtvgzETTo/WElOO05/IIzXCXJV0Q6
 iVqhka+fiT4C66uML1cQ9ZyyU8dqInMWw8hFhv2ZL/Cb9My/r4f8zPxLzTyNfNLHCket
 mJjWU7CBS6Tx2DpLl4j+Q8Y2RIVE2+R2Kz8eDxn/o8Zt/cvGAjKbzikTMrufUKCMfVU9
 OKRZDFLo2+rdv+Irg6xLMWD3To5bIwINlEs0JVb8sYfr0Y/ou3t3+eJd/+rnAyUbpGiO
 roQBm78sZTBBkqDFY/kz7wY5TEfN7JkNY2bohoYihduImS9VCkl5VCTSksYGNw9ptFaF
 KvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733826685; x=1734431485;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2S4UKBM/zZpdKLdp8wtDNjWkAVE4tJbEPcjrJ4K7Vcw=;
 b=OJ8/qcemg7PTwttPiVNMTRZnUYb89yb5tmq3FBIkXR3JLq0sH9AArXU8ir4YMrPogi
 sYSOE3K8OMcyGHcJkMd+bUyaqZbeCmILGRBnyRt6kjju6n9x+ehS4rE/7fjWzZwNBUDg
 SNXbqSBSaxv72wXb9rD01g0JWAtL9aCVCBLd+YMzxeleEZuG3DalSWpq9UOsYVrZouwC
 ECTY+wkT05u4df7RvAGw+E1YHl4ln/Njk1HnpC/fYdW79rhjUikiS6021ZigEmWW0hSX
 aIqX0tBb+PwdaNaCyap3ACorfoPlH1+GjwCcEzueidlydEe8qb8s9Idq+vgRlqDy7mVX
 ON6A==
X-Gm-Message-State: AOJu0YzF+fKtj1MNdZuEW7a66u0uNRP2VQguPaIWlgGNwlJBIBs8vOJR
 mfHkz0PEfpxnT8EuImDG0rW5IjZPpHiXkYEu4GsrpqTDwf1nJpPo2TUoR12UK3hNk7MwAgB1Rhb
 Sfqs=
X-Gm-Gg: ASbGnctXB8TcUXP3CY0KaRfmlLy/uHEyhcF9PluxFrIdyGpPXqHx14CIoVAKjhknO1+
 uSYzyY3Jx4QdJ2rt8q4dikNdUtN7rn3k5XRGl7arHJU+aZSQ923Sj7/nvv/A3/crE8Qeu8PHmPS
 2C7YbgcWWUSsUFQAqG3ioykuOhiGTHCAeYmhILQj/ZPbBluwf6267tdshg5s6ywzc2lIifFkCjc
 FGLahfrV4MSPnXMwIiN7Twj/sFIN/pKWPqZYf2VvQkH9L9JArA+NUgixQW4Ce8VZ086CdbSPrg0
 to8+H5/Qop8bb+lp
X-Google-Smtp-Source: AGHT+IGrY1chkl0ehu43A9ULpoJRFiW1TgEXP3NpXoy/UbY7bNu36hkWPhGObhtkpaXOHj7qjQFfzA==
X-Received: by 2002:a05:600c:3659:b0:434:fbc5:e8f0 with SMTP id
 5b1f17b1804b1-43502192875mr19190295e9.8.1733826685191; 
 Tue, 10 Dec 2024 02:31:25 -0800 (PST)
Received: from [192.168.224.213] (244.36.22.93.rev.sfr.net. [93.22.36.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861f59ceb6sm15668054f8f.42.2024.12.10.02.31.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 02:31:24 -0800 (PST)
Message-ID: <e979b3ba-e701-4ac6-962a-19e4598ba947@linaro.org>
Date: Tue, 10 Dec 2024 11:31:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0] system/qtest: Access memory using
 cpu_physical_memory_rw() API
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20241127191914.34146-1-philmd@linaro.org>
 <CAFEAcA-H2kS0GdXpDpA3mFm1eOZnudZCn8REYNo34+PsvimfmQ@mail.gmail.com>
 <0406480e-29aa-4207-970c-818db3de0291@linaro.org>
Content-Language: en-US
In-Reply-To: <0406480e-29aa-4207-970c-818db3de0291@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 10/12/24 11:20, Philippe Mathieu-Daudé wrote:
> On 10/12/24 11:03, Peter Maydell wrote:
>> On Wed, 27 Nov 2024 at 19:20, Philippe Mathieu-Daudé 
>> <philmd@linaro.org> wrote:
>>>
>>> There is no vCPU within the QTest accelerator (well, they
>>> are stubs doing nothing, see dummy_cpu_thread_fn).
>>> Directly use the cpu_physical_memory_rw() API -- which
>>> amusingly prefixed 'cpu_' does not use vCPU -- to access
>>> memory. This reduces accesses to the global 'first_cpu'.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   system/qtest.c | 42 ++++++++++++++----------------------------
>>>   1 file changed, 14 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/system/qtest.c b/system/qtest.c
>>> index 12703a20455..a2de9a7d5a4 100644
>>> --- a/system/qtest.c
>>> +++ b/system/qtest.c
>>> @@ -18,6 +18,7 @@
>>>   #include "chardev/char-fe.h"
>>>   #include "exec/ioport.h"
>>>   #include "exec/memory.h"
>>> +#include "exec/cpu-common.h"
>>>   #include "exec/tswap.h"
>>>   #include "hw/qdev-core.h"
>>>   #include "hw/irq.h"
>>> @@ -514,23 +515,19 @@ static void qtest_process_command(CharBackend 
>>> *chr, gchar **words)
>>>
>>>           if (words[0][5] == 'b') {
>>>               uint8_t data = value;
>>> -            address_space_write(first_cpu->as, addr, 
>>> MEMTXATTRS_UNSPECIFIED,
>>> -                                &data, 1);
>>> +            cpu_physical_memory_write(addr, &data, 1);
>>
>> I'm not a huge fan of this, because cpu_physical_memory_write()
>> is one of those old APIs that it would be nice to see less
>> use of, not more. Ideally anything issuing memory transactions
>> should know what it's issuing them to, i.e. should be using
>> address_space_* functions and passing an AddressSpace.
> 
> I totally agree with you. I'm chasing one problem at a time
> starting by first_cpu, and you are already seeing ahead :)
> 
> Do you mind posting a documentation patch clarifying the
> cpu_physical_memory_*() methods we want to deprecate?

I was looking for docstring in "exec/cpu-common.h" but now see
commit b7ecba0f6f6 ("docs/devel/loads-stores.rst: Document our
various load and store APIs"):

   ``cpu_physical_memory_*``
   ~~~~~~~~~~~~~~~~~~~~~~~~~

   For new code they are better avoided:

   ``cpu_physical_memory_read``

   ``cpu_physical_memory_write``

   ``cpu_physical_memory_rw``

>> If you don't want to use first_cpu, then you could use
>> address_space_write(address_space_memory, ...), which is
>> what cpu_physical_memory_write() is doing under the hood.
>> The qtest protocol assumes a single address space anyway.
> 
> Correct, good idea.
> 
> Next problem I have here is to understand what 'endianness'
> means for QTest framework. Use case: heterogeneous ZynqMP
> with ARM and MicroBlaze cores.
> 
> Thanks,
> 
> Phil.


