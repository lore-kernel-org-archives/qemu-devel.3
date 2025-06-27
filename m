Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F74C77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 13:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV8x3-000243-VB; Fri, 27 Jun 2025 09:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uV8x0-00023j-0O
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 09:17:06 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uV8wx-0001pH-Me
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 09:17:05 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2ebb72384dbso644652fac.1
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 06:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751030219; x=1751635019; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lNECuvIGquJI3zSKbdXttEIu7fLwU8LMFtxR41SZIYk=;
 b=zhUIpgP8A4+3Mysl9wGi1k6ENjnM9DGWBk41BydomwGejE8xFQGUcb1JhFs7DafvWV
 xNm7O3xdibqc6Dyahte78YaXTyGiCIeJRmXqPHvXv+YDiaapu24MQkotWv3irrwPi5Qa
 gOj7WOMHIV3zOCJcz0wvwra/ZRjd7zdSk7Jir3xfPXdxSvKlsXylhOyB0vQ1SjkDX66M
 dWDqhwApIZ+dJvXyhIZSB55WfF7dkF3muSBXxD67fHP9HPGKv8tCFs5FiiT2olqb06Bi
 HFA3U3aEAfxg8dv0id+E6ACqyRhhmjZiVNhmdUsymdBTOnBmLImco+12p6oUHR5Nhjiz
 54sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751030219; x=1751635019;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lNECuvIGquJI3zSKbdXttEIu7fLwU8LMFtxR41SZIYk=;
 b=L04kbyo3gTshqvFr/2MYYv7J5+FWE7wHznWfDHsDRBmgOwGJLpoewNKei5aW0N2b6J
 kuEYYhKZhZui4HiD6vD/rTM+RAHHuAnnwCjTGmwx3Z+Pnala69nVT8hyd7GLRNoJQRGe
 ixtC8AaiH1e9aU9FKwOLMCHKbr0DYLLah50/5hDQyvJvp+k8j1+F7lgSXJ7z/eUr1t05
 QvSW/aH5CFSE8YUFGThAprjtUJpYNsjXqv1CxwQTrdIKOKF7xArJ2DAYgumoiFGCl655
 Qo3cLQsYgui89iJfh3BGoNzgJTQ6Qz+tJn7CWbF7vN9dWspBv3rPFAgS3LnMhooKOIi7
 TEUw==
X-Gm-Message-State: AOJu0YwyEE+BjTHHhrLB4tvzmMKdbj+VgFCORgZn+r4tJoVkjsKU6JmU
 sVAZ8k60Omf2T64M/arVXcSQsHqAE0dKKDFr0yHW34+ybUPJc/inQ/fTIjHnYJ2fYs0PCGcvpag
 dGwkL2vw=
X-Gm-Gg: ASbGnctruBoBreYSMZvizYpUeYAr4aTSuc8MjVwX/3KZt619e62mahCoKmOuVyiem5G
 /a08XLNLBDVkFGYEQ+80ZM4zUJP0n7axJPPH6fMsoYyUojYpCfnAisbXjjDiBT16eT8A7UTim4B
 YVYQazF/yd+ZXqiJaphJu4SkrmkmsSkbH+KSuhSKkPUlrFkuTrm6RszOljMQm0YZmFvm4HASEQw
 nOzUFRG2196vZ4HjS9km21ISouI9bKvZ7dvrz3sLARTWsPLQdUKjoIDv8e8MbeSfIVYHtXfmvbH
 s27LETRr9rVT5ZFNQetn1ZHnpTbxuKvOuzzofu2tMLW6zHxTthr9QCv31pKzxmXpMC5LuH/A/pQ
 7sEdlO7KRQf0=
X-Google-Smtp-Source: AGHT+IFfER1uI2qq+W0ytDtN/jJhotS2WVFfHkW4x5b6Vevi13SZISQBqpD+oIk9wkEDklWNo3Ulqw==
X-Received: by 2002:a05:6870:24a6:b0:2d5:1232:b081 with SMTP id
 586e51a60fabf-2efed70fb39mr2034906fac.29.1751030219321; 
 Fri, 27 Jun 2025 06:16:59 -0700 (PDT)
Received: from [10.25.7.30] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-611b848ba33sm235723eaf.10.2025.06.27.06.16.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Jun 2025 06:16:58 -0700 (PDT)
Message-ID: <c3a2c4f9-c750-4a0a-b6bc-e94b55784952@linaro.org>
Date: Fri, 27 Jun 2025 06:16:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 093/163] tcg: Convert extract to TCGOutOpExtract
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-94-richard.henderson@linaro.org>
 <CABJz62OFyaXitSdge4M9_oTk34a5aocLJLFYfkOGXc0BToOgVA@mail.gmail.com>
 <CABJz62OMmmbDjWpp6YkXu2d+hB4HeShgqaa05ZigAVqNQSwjZA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CABJz62OMmmbDjWpp6YkXu2d+hB4HeShgqaa05ZigAVqNQSwjZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
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

On 6/26/25 09:20, Andrea Bolognani wrote:
> On Mon, Jun 09, 2025 at 06:52:21AM -0700, Andrea Bolognani wrote:
>> On Tue, Apr 15, 2025 at 12:24:04PM -0700, Richard Henderson wrote:
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   tcg/tcg.c                        | 20 +++++++++
>>>   tcg/aarch64/tcg-target.c.inc     | 28 +++++++-----
>>>   tcg/arm/tcg-target.c.inc         | 23 +++++-----
>>>   tcg/i386/tcg-target.c.inc        | 77 +++++++++++++++++---------------
>>>   tcg/loongarch64/tcg-target.c.inc | 33 +++++++-------
>>>   tcg/mips/tcg-target.c.inc        | 35 +++++++--------
>>>   tcg/ppc/tcg-target.c.inc         | 35 +++++++--------
>>>   tcg/riscv/tcg-target.c.inc       | 54 +++++++++++-----------
>>>   tcg/s390x/tcg-target.c.inc       | 14 +++---
>>>   tcg/sparc64/tcg-target.c.inc     | 16 ++++---
>>>   tcg/tci/tcg-target.c.inc         |  8 ++--
>>>   11 files changed, 191 insertions(+), 152 deletions(-)
>>
>> Hi Richard,
>>
>> this seems to have introduced a regression when running on a riscv64
>> host.
>>
>> Before the change:
>>
>>    $ timeout --foreground 1 \
>>      ./build/qemu-system-riscv64 -machine virt,accel=tcg \
>>      -display none -serial stdio 2>&1 | grep -i opensbi
>>    OpenSBI v1.5.1
>>
>> After the change, no output is produced.
>>
>> This causes the
>>
>>    qemu:func-quick+func-riscv64 / func-riscv64-riscv_opensbi
>>
>> test to stall and eventually fail due to the built-in test suite
>> timeout kicking in.
>>
>> Interestingly, I can't reproduce this by running the exact same
>> commands and using the exact same git commits on an x86_64 host.
>>
>> Do you have any idea what could be going wrong? I'll happily
>> investigate further if you give me pointers.
> 
> Hi,
> 
> this is still an issue as of f9a3def17b2a.
> 
> Any idea where to look?

tcg/riscv/tcg-target.c.inc, tgen_extract(), must be at fault.

Oh, I see it:

--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2502,7 +2502,7 @@ static void tgen_extract
          }
      }
      if (ofs + len == 32) {
-        tgen_shli(s, TCG_TYPE_I32, a0, a1, ofs);
+        tgen_shri(s, TCG_TYPE_I32, a0, a1, ofs);
          return;
      }
      if (len == 1) {


Please test.

r~

