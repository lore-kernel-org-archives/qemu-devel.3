Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21851C54734
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 12:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sivWf-000364-8p; Tue, 27 Aug 2024 08:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sivWa-00035R-Sb
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 08:42:16 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sivWV-0000ZS-1C
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 08:42:14 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7143ae1b48fso3123736b3a.1
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 05:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724762526; x=1725367326; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+RCOx7NhJxT+21DYhDzE/U/IJYE0PUzrNMq1dTUiz4U=;
 b=OYQI3gUoQs874xuD/Km+4ilxPr+h7uheMusHb1cOuyyeoRVQjoB85ras5wd0MmvKci
 CQDaW/sISu5x2l+L+cQ2+h7yCTCqqNBIXo0qBJOv94fe6rxU69AEeuEexLyDDw4TObzg
 ss6E4eCZzIJCJjSTwEeNT/djVZWbYCpFGNxjzrW75l0U6UY/Qn0mD/iFXDI3WyvyuZUd
 3kCRFeZeq7MQotPaA7kizWZ369q0PHXMGDMoVx7LjrmKM/p+exLuAPKylw06F5xrsDZL
 ALi5Z6FpJcKdclfTHNkzH851s+nOMAYv+/XqXUxnnUHcUZRUT0pX/LinGTzAYn4OSq/n
 Alxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724762526; x=1725367326;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+RCOx7NhJxT+21DYhDzE/U/IJYE0PUzrNMq1dTUiz4U=;
 b=d3T5Hb9HEI4gCNZbpFRZqbLhtL3NeaqhvgL7JgW0XLG+3USIfQwP6OVV8MJAjqwys2
 6L85jZG6YaFx8cehjcisk0tHTHPPmQLK8KNKbJarnfiE48IpzGTj3e+aVtlvcaBaSiRS
 Kowm9jTma5vmnf4ZSuNtEClAeg42UZzuLIzPFGFE48SVK46aPgV3HtFQpWhoOoOG3Wus
 GO5RIOg3xM2x3ueCOo0WrpYNijXRfSWke7iVZfEZJXRH6j0Vbjh9fA4L6XZLvWuQbVKU
 8wwEpw8hOshfGv2EIxGJwx/lTAWhSsokL5Zi6oFaC6CyBqsL83l8wr9HUqULUOPJnk+Q
 CmVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI/wDfWMRUS/UJewqnJB9NtIrp+uju6megSKHAgqQztWWqib5b0OVwHYtb1Zi75E9uP6DvAMyJPy53@nongnu.org
X-Gm-Message-State: AOJu0Yxk3rFDs1/tAd5YyMrDlwulgm1ZZIFxwVVBHh85dPpQaR5CkYkk
 WWnvNdIbORMARg2Oil8+yKoAsy59D82xRu5RY3lz9j3SzqfjyCX0r3LELx4pQPZn4FM914rm3Tb
 u
X-Google-Smtp-Source: AGHT+IEyB586Fgg9HwguT0VKSlQXVIfpVsvWMB3tVWju8+yKf1a8ivTVs49w3uvBSRgI2PQql9Pt8w==
X-Received: by 2002:a05:6a00:2395:b0:714:37ca:ed72 with SMTP id
 d2e1a72fcca58-71445d32c5amr13004277b3a.10.1724762526160; 
 Tue, 27 Aug 2024 05:42:06 -0700 (PDT)
Received: from ?IPv6:2804:7f0:b400:bb79:4bdf:de43:1f6c:1151?
 ([2804:7f0:b400:bb79:4bdf:de43:1f6c:1151])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-714342732b5sm8727852b3a.92.2024.08.27.05.42.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Aug 2024 05:42:05 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] tests/tcg/aarch64: Extend MTE gdbstub tests to
 system mode
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: peter.maydell@linaro.org
References: <20240825145208.46774-1-gustavo.romero@linaro.org>
 <20240825145208.46774-5-gustavo.romero@linaro.org>
 <64200fe4-b824-4903-b5f5-fc48c9e00945@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <69229d7b-15d5-feda-ee4b-1c48992297f3@linaro.org>
Date: Tue, 27 Aug 2024 09:42:02 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <64200fe4-b824-4903-b5f5-fc48c9e00945@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.192,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Phil!

On 8/26/24 3:10 AM, Philippe Mathieu-Daudé wrote:
> Hi Gustavo,
> 
> On 25/8/24 16:52, Gustavo Romero wrote:
>> Extend MTE gdbstub tests to also run in system mode (share tests between
>> user mode and system mode). The tests will only run if a version of GDB
>> that supports MTE on baremetal is available in the test environment and
>> if available compiler supports the 'memtag' flag
>> (-march=armv8.5-a+memtag).
>>
>> For the tests running in system mode, a page that supports MTE ops. is
>> necessary. Therefore, an MTE-enabled page is made available (mapped) in
>> the third 2 MB chunk of the second 1 GB space in the flat mapping set in
>> boot.S. A new binary, mte.S, is also introduced for the tests. It links
>> against boot.S and is executed by QEMU in system mode.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>   configure                                 |   5 +
>>   tests/tcg/aarch64/Makefile.softmmu-target |  49 +++++++++-
>>   tests/tcg/aarch64/Makefile.target         |   3 +-
>>   tests/tcg/aarch64/gdbstub/test-mte.py     |  71 +++++++++-----
>>   tests/tcg/aarch64/system/boot.S           |  11 +++
>>   tests/tcg/aarch64/system/kernel.ld        |   7 ++
>>   tests/tcg/aarch64/system/mte.S            | 109 ++++++++++++++++++++++
>>   7 files changed, 227 insertions(+), 28 deletions(-)
>>   create mode 100644 tests/tcg/aarch64/system/mte.S
> 
> 
>> diff --git a/tests/tcg/aarch64/system/kernel.ld b/tests/tcg/aarch64/system/kernel.ld
>> index 7b3a76dcbf..46f1092522 100644
>> --- a/tests/tcg/aarch64/system/kernel.ld
>> +++ b/tests/tcg/aarch64/system/kernel.ld
>> @@ -18,6 +18,13 @@ SECTIONS
>>       .bss : {
>>           *(.bss)
>>       }
>> +    /*
>> +     * Align the MTE page to the next 2mb boundary (i.e., the third 2mb chunk
>> +     * starting from 1gb) by setting the address for symbol 'mte_page', which is
>> +     * used in boot.S to setup the PTE and in the mte.S test as the address that
>> +     * the MTE instructions operate on.
>> +     */
>> +    mte_page = ALIGN(1 << 22);
> 
> Comment says 2MiB but you use 4MiB.
> Matter of taste, 2MiB is easier to review as:
> 
>        mte_page = ALIGN(2 << 20);
>

This is incorrect. Aligning here at 2MiB will clash with r/w data section. I tried to
clarify it when I wrote "[...] third 2mb chunk starting from 1gb". The memory layout
so is:

0         ---- 1GiB range: avoid/skipped
1GiB      ---- 1GiB+2MiB (1st 2MiB chunk): text
1GiB+2MiB ---- 1GiB+4MiB (2nd 2MiB chunk): data
1GiB+4MIB ---- 1GiB+8MiB (3rd 2MiB chunk): MTE-enabled page

ALIGN implicitly uses "." (current position), so we're defining consecutive sections
here starting from 1GiB.

All the other parts of the code uses the 1 << n form, which I prefer, specially when
reading asm code, so I prefer 1 << 22 instead of 4 << 20.

But apparently my comment failed miserable to explain the situation here, so I'm
happy to change the wording to make it clearer if you have any suggestion.


Cheers,
Gustavo

>>       /DISCARD/ : {
>>           *(.ARM.attributes)
>>       }
> 

