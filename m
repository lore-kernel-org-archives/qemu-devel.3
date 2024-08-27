Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60417C54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 18:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj0Vc-0004xx-EH; Tue, 27 Aug 2024 14:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sj0Vb-0004tU-Dy
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 14:01:35 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sj0VZ-0002Fj-2a
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 14:01:35 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2023dd9b86aso46235935ad.1
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 11:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724781691; x=1725386491; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CozyPju00hQ9Ty40RisdR+WDP+BWU9DlcOR/i1kAFAU=;
 b=AuX9E9XDgEkXTNI7mz8tBrYgCOWa5J/bWWbfhy68ZAOI6SsNRT/ha7EjqvuC6kPEJh
 eXJlKqCwCfC8gWJ2DD9DJ00/EI9Ez/kHXnIUYFe+IpSGXf3yg5dJk6RWjvjGmRQluOAI
 EgZBYSccYMtm2IPZUdO0IaSsrcdzKH9ijcL1yLp4OvXlMCcA8A+9WhQB6qoGl8zIXWyH
 gP5daXIgR5uAFVEOOGdIHeN6CfpGcxVoEgtu6eHMICuEqYIPESlan1kb6fBNY4Rckh+s
 7rXC4W3g6dhxJMG7RMQzr8xFdHx663GEUWaDTMwhD5CHe46JglzBpHEeruypoeohu13m
 PqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724781691; x=1725386491;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:references:cc:to:from:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CozyPju00hQ9Ty40RisdR+WDP+BWU9DlcOR/i1kAFAU=;
 b=f1iKW4mXVbbRHFIu2hIiQjyUSKRQd2zu6NkrCpdO+kSL3bmcAdwHTPhBYR9v+dB2/1
 RbPC9dCXfFN5PwL0J+Rum4TT5mcGjEiNOovbdPNfH+qMdMAiNHcRjjchQewawNjEZWf6
 gDVNsXP30VWtcVBJR3iqO0GQtSaaFqDtj3J7svQazw0DwzP6+fCGjGDTPQhYXOPkM0TK
 jPmmEpQIbx5NQEyFwy6E0GL6aWWmnEkhm34TnLGW27IlDLRVqW4CubVzjtflh2OFol7j
 c8tnuKjfKCC4/vYIAAJEDl7/7wFdYJkeSqZxjwaOdNlYfq+st9eGaei4vIBn9Do+ZMnL
 XJyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9ML0lg0x79k83+IU04b3DXaJJl7rnR9V2rqdZyhWpCFHf5x+tBTWgd3/27hnfL08lzmg9a8//Qw+z@nongnu.org
X-Gm-Message-State: AOJu0Yx6HE80otOxf3w5EMkUuc0K0jlosjTW0LzZ3f6CKTEPOChrp0IM
 DekIWotWzxvrwRSF3JF8vZXlT055Wt/+jTCURM+FG8yIaNFPTo//Ni+iIfe9L+0=
X-Google-Smtp-Source: AGHT+IGtCBAlgk3PwtcZ3umarbjOYxnjqxLOgkXMh9dMRQybGweELdaJ5KoEai8Mdca7W7CGSOzLuQ==
X-Received: by 2002:a17:902:f68f:b0:202:47d3:c46d with SMTP id
 d9443c01a7336-2039e538450mr143778565ad.52.1724781690976; 
 Tue, 27 Aug 2024 11:01:30 -0700 (PDT)
Received: from ?IPv6:2804:7f0:b400:bb79:4bdf:de43:1f6c:1151?
 ([2804:7f0:b400:bb79:4bdf:de43:1f6c:1151])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203855dbf13sm86602565ad.163.2024.08.27.11.01.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Aug 2024 11:01:30 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] tests/tcg/aarch64: Extend MTE gdbstub tests to
 system mode
From: Gustavo Romero <gustavo.romero@linaro.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: peter.maydell@linaro.org
References: <20240825145208.46774-1-gustavo.romero@linaro.org>
 <20240825145208.46774-5-gustavo.romero@linaro.org>
 <64200fe4-b824-4903-b5f5-fc48c9e00945@linaro.org>
 <69229d7b-15d5-feda-ee4b-1c48992297f3@linaro.org>
Message-ID: <2c2813aa-5671-7705-7170-d3e8e25d2f7b@linaro.org>
Date: Tue, 27 Aug 2024 15:01:27 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <69229d7b-15d5-feda-ee4b-1c48992297f3@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x632.google.com
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

Hi Phil,

On 8/27/24 9:42 AM, Gustavo Romero wrote:
> Hi Phil!
> 
> On 8/26/24 3:10 AM, Philippe Mathieu-Daudé wrote:
>> Hi Gustavo,
>>
>> On 25/8/24 16:52, Gustavo Romero wrote:
>>> Extend MTE gdbstub tests to also run in system mode (share tests between
>>> user mode and system mode). The tests will only run if a version of GDB
>>> that supports MTE on baremetal is available in the test environment and
>>> if available compiler supports the 'memtag' flag
>>> (-march=armv8.5-a+memtag).
>>>
>>> For the tests running in system mode, a page that supports MTE ops. is
>>> necessary. Therefore, an MTE-enabled page is made available (mapped) in
>>> the third 2 MB chunk of the second 1 GB space in the flat mapping set in
>>> boot.S. A new binary, mte.S, is also introduced for the tests. It links
>>> against boot.S and is executed by QEMU in system mode.
>>>
>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>> ---
>>>   configure                                 |   5 +
>>>   tests/tcg/aarch64/Makefile.softmmu-target |  49 +++++++++-
>>>   tests/tcg/aarch64/Makefile.target         |   3 +-
>>>   tests/tcg/aarch64/gdbstub/test-mte.py     |  71 +++++++++-----
>>>   tests/tcg/aarch64/system/boot.S           |  11 +++
>>>   tests/tcg/aarch64/system/kernel.ld        |   7 ++
>>>   tests/tcg/aarch64/system/mte.S            | 109 ++++++++++++++++++++++
>>>   7 files changed, 227 insertions(+), 28 deletions(-)
>>>   create mode 100644 tests/tcg/aarch64/system/mte.S
>>
>>
>>> diff --git a/tests/tcg/aarch64/system/kernel.ld b/tests/tcg/aarch64/system/kernel.ld
>>> index 7b3a76dcbf..46f1092522 100644
>>> --- a/tests/tcg/aarch64/system/kernel.ld
>>> +++ b/tests/tcg/aarch64/system/kernel.ld
>>> @@ -18,6 +18,13 @@ SECTIONS
>>>       .bss : {
>>>           *(.bss)
>>>       }
>>> +    /*
>>> +     * Align the MTE page to the next 2mb boundary (i.e., the third 2mb chunk
>>> +     * starting from 1gb) by setting the address for symbol 'mte_page', which is
>>> +     * used in boot.S to setup the PTE and in the mte.S test as the address that
>>> +     * the MTE instructions operate on.
>>> +     */
>>> +    mte_page = ALIGN(1 << 22);
>>
>> Comment says 2MiB but you use 4MiB.
>> Matter of taste, 2MiB is easier to review as:
>>
>>        mte_page = ALIGN(2 << 20);
>>
> 
> This is incorrect. Aligning here at 2MiB will clash with r/w data section. I tried to
> clarify it when I wrote "[...] third 2mb chunk starting from 1gb". The memory layout
> so is:
> 
> 0         ---- 1GiB range: avoid/skipped
> 1GiB      ---- 1GiB+2MiB (1st 2MiB chunk): text
> 1GiB+2MiB ---- 1GiB+4MiB (2nd 2MiB chunk): data
> 1GiB+4MIB ---- 1GiB+8MiB (3rd 2MiB chunk): MTE-enabled page
> 
> ALIGN implicitly uses "." (current position), so we're defining consecutive sections
> here starting from 1GiB.
> 
> All the other parts of the code uses the 1 << n form, which I prefer, specially when
> reading asm code, so I prefer 1 << 22 instead of 4 << 20.
Alex suggested using the M suffix to make it more clear, so how about:

diff --git a/tests/tcg/aarch64/system/kernel.ld b/tests/tcg/aarch64/system/kernel.ld
index 46f1092522..3a28412b2f 100644
--- a/tests/tcg/aarch64/system/kernel.ld
+++ b/tests/tcg/aarch64/system/kernel.ld
@@ -2,16 +2,18 @@ ENTRY(__start)
  
  SECTIONS
  {
-    /* virt machine, RAM starts at 1gb */
+    /* Skip first 1 GiB on virt machine: RAM starts at 1 GiB. */
      . = (1 << 30);
+    /* Align text to first 2 MiB. */
+    . = ALIGN(0 * 2M);
      .text : {
          *(.text)
      }
      .rodata : {
          *(.rodata)
      }
-    /* align r/w section to next 2mb */
-    . = ALIGN(1 << 21);
+    /* Align r/w section to next 2 MiB. */
+    . = ALIGN(1 * 2M);
      .data : {
          *(.data)
      }
@@ -19,12 +21,12 @@ SECTIONS
          *(.bss)
      }
      /*
-     * Align the MTE page to the next 2mb boundary (i.e., the third 2mb chunk
-     * starting from 1gb) by setting the address for symbol 'mte_page', which is
-     * used in boot.S to setup the PTE and in the mte.S test as the address that
-     * the MTE instructions operate on.
+     * Align the MTE page to the next 2 MiB boundary (i.e., the third 2 MiB
+     * chunk starting from 1 GiB) by setting the address for symbol 'mte_page',
+     * which is used in boot.S to setup the PTE and in the mte.S test as the
+     * address that the MTE instructions operate on.
       */
-    mte_page = ALIGN(1 << 22);
+    mte_page = ALIGN(2 * 2M);
      /DISCARD/ : {
          *(.ARM.attributes)
      }


Cheers,
Gustavo

> But apparently my comment failed miserable to explain the situation here, so I'm
> happy to change the wording to make it clearer if you have any suggestion.
> 
> 
> Cheers,
> Gustavo
> 
>>>       /DISCARD/ : {
>>>           *(.ARM.attributes)
>>>       }
>>

