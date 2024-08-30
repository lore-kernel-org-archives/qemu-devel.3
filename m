Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F000ECA101A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 22:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skADX-0000QP-Rr; Fri, 30 Aug 2024 18:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1skADT-0000Pl-6t
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 18:35:40 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1skADR-00040v-FU
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 18:35:38 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-70f645a30dcso1241693a34.3
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 15:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725057335; x=1725662135; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IpAonu19r4dMqNwVZTCOJorhGvtN6w+x7pc+eH7/rEU=;
 b=ewa7OdiQjFI2d5i7b8F1ICdMhglLp8dthsh4eKlw8FJI9+aan+UJZa4GRrvJ5vDnWu
 m9RnhH/Qo2kOMuOCFQ8Hj6RZFDBSDq1chxPS62sYQyWnHYdGj2XRiKdXG176SMxoY94H
 8rngW0OLafNNnl7nZk9OGFNbH8n4CsQw6QxKqgfSfX+ZPyVmtpP9xeFgCfVRcnU0/wD+
 EGu9nsaJlqXRjWYWHYIbz/hmjblF1ydonk+8JZUCxOTZ5unBndYsQ1qdv7EXjWJ2ebMm
 lzA4Xnl4Kpi1tr7K5csr8uuRfZpMCUDWRcqWtO+572qTfOJyNw426U70aZYfccV+R9/d
 HHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725057335; x=1725662135;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IpAonu19r4dMqNwVZTCOJorhGvtN6w+x7pc+eH7/rEU=;
 b=lr8upxfKBRzLquagavF3a0NrCswv2dBqmtULoEBEAhH8WuCxdQby8Q/M7Uk9E/CtYP
 MtRSN2DPuwYuUpS0t3NjgCJ5X3Cilj1KxZbfhJ25T9vtOmKlHjTltS0f+qUBKD5YVJ3W
 JYWuG1c2PoiDro97rv9qVOtQ8My48LF2fBL761YycZtuyqo7dlQ+DlYA3b26C3fintXm
 YYJ4w2+MJQyWViJxCQFoj1IAntVlf+76OMaqstRXf8FoGZCU+iiWQnLqxmnB+keYY8f4
 1HiBGXetlN+ChEfgKNNhF5JYV2iEzSmakcs+8QhcTZkPJ57wYoRPk7NIg08UxYlMxvVf
 3pIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXucupj0Hhbd1fSOok3pqA0Z2AbEmjs9NEhVJ2Z8cmNQutqpNBXjcSnDLdh5009hnfY0zweyhWFhVnx@nongnu.org
X-Gm-Message-State: AOJu0YyOErPVhkQLsYNhPHAEir2jck7+/aGeopHAOzJXqz1kpbpakaLc
 r4YWIEZ8pAbVVP38CsfGlFkkr4CFemLzc92p6HZNHa8eUoXaslI+uVNf+nD4Zaw=
X-Google-Smtp-Source: AGHT+IFteTDu/wY4lfhdlTz4LGZSa+u0KsIFZ7clebvJF2ZozirGXNesNiLANRt5JZqe9PGc9feS/A==
X-Received: by 2002:a05:6358:7691:b0:1b5:f95a:5a67 with SMTP id
 e5c5f4694b2df-1b7ef6e2e90mr99466955d.15.1725057335392; 
 Fri, 30 Aug 2024 15:35:35 -0700 (PDT)
Received: from ?IPv6:2804:7f0:69c1:b154:b8d3:5878:6442:40b3?
 ([2804:7f0:69c1:b154:b8d3:5878:6442:40b3])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-715e569e715sm3330804b3a.98.2024.08.30.15.35.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Aug 2024 15:35:34 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] tests/tcg/aarch64: Extend MTE gdbstub tests to
 system mode
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, alex.bennee@linaro.org
Cc: peter.maydell@linaro.org
References: <20240825145208.46774-1-gustavo.romero@linaro.org>
 <20240825145208.46774-5-gustavo.romero@linaro.org>
 <64200fe4-b824-4903-b5f5-fc48c9e00945@linaro.org>
 <69229d7b-15d5-feda-ee4b-1c48992297f3@linaro.org>
 <2c2813aa-5671-7705-7170-d3e8e25d2f7b@linaro.org>
 <65e4c975-83f9-4d9b-a8aa-37d9543afac7@linaro.org>
 <f5b66bb8-bf39-40f6-e641-64ddcfd6ac13@linaro.org>
 <58dbf60e-9f37-498e-80d1-19ed25d8b91f@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <14a98d2d-e12e-3572-4cd4-f9cbfd90358a@linaro.org>
Date: Fri, 30 Aug 2024 19:35:30 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <58dbf60e-9f37-498e-80d1-19ed25d8b91f@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=gustavo.romero@linaro.org; helo=mail-ot1-x330.google.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.937,
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

Hi Richard,

On 8/29/24 7:16 PM, Richard Henderson wrote:
> On 8/30/24 06:13, Gustavo Romero wrote:
>>    1 .text         00001e60  0000000040001000  0000000040001000  00011000  2**12
>>    4 .data         00012000  0000000040200000  0000000040200000  00020000  2**12
>> 0000000040400000 g       .data    0000000000000000 mte_page
>>
>>
>> I was not able to make the MEMORY command work. I tried:
>>
>> index 46f1092522..dc39518a16 100644
>> --- a/tests/tcg/aarch64/system/kernel.ld
>> +++ b/tests/tcg/aarch64/system/kernel.ld
>> @@ -1,9 +1,13 @@
>>   ENTRY(__start)
>>
>> +MEMORY
>> +{
>> +    ram (rwx) : ORIGIN = 1 << 30, LENGTH = 16M
>> +}
>> +
>>   SECTIONS
>>   {
>>       /* virt machine, RAM starts at 1gb */
>> -    . = (1 << 30);
>>       .text : {
>>           *(.text)
>>       }
>> @@ -11,7 +15,7 @@ SECTIONS
>>           *(.rodata)
>>       }
>>       /* align r/w section to next 2mb */
>> -    . = ALIGN(1 << 21);
>> +    . = ALIGN(2M);
>>       .data : {
>>           *(.data)
>>       }
>> @@ -24,7 +28,7 @@ SECTIONS
>>        * used in boot.S to setup the PTE and in the mte.S test as the address that
>>        * the MTE instructions operate on.
>>        */
>> -    mte_page = ALIGN(1 << 22);
>> +    mte_page = ((1 << 30) + 4M);
>>       /DISCARD/ : {
>>           *(.ARM.attributes)
>>       }
>>
>> But it didn't work because data section is placed in the wrong place:
>>
>>    1 .text         00001e60  0000000040001000  0000000040001000  00011000  2**12
>>    4 .data         00012000  0000000040003000  0000000040003000  00013000  2**12
>> 0000000040400000 g       *ABS*    0000000000000000 mte_page
>>
>> Do you know why?
> 
> This is where using '.' gets tricky.
> For .data to be in the correct place, we need to place the ALIGN on .data:
> 
>    .data : ALIGN(2M) {
>       ...
>    }
> 
>> I also had to use 'mte_page = ((1 << 30) + 4M);' for the mte_page symbol because
>> the current location (.) seems to reset to zero for the sections, hence if I do:
>>
>> +    mte_page = ALIGN(2M);
>>
>> I get:
>>
>> 0000000040200000 g       .data    0000000000000000 mte_page
> 
> Right.  That's a consequence of not placing the symbol within a section for layout.
> 
> I suppose all this is a bit academic. The current method using '.' is sufficient, but it feels slapdash.
> 
> Thinking about this more, the proper way to use MEMORY is to describe the page tables that we're setting up:
> 
> MEMORY {
>    TXT (rx) : ORIGIN = 1 << 30, LENGTH = 2M
>    DAT (rw) : ORIGIN = (1 << 30) + 2M, LENGTH = 2M
>    TAG (rw) : ORIGIN = (1 << 30) + 4M, LENGTH = 2M
> }
> 
> SECTIONS {
>    .text : {
>      *(.text)
>      *(.rodata)
>    } >TXT
>    .data : {
>      *(.data)
>      *(.bss)
>    } >DAT
>    .tag : {
>      mte_page = .
>    } >TAG
> }
> 
> Or something close to that.

Thanks, that looks nice. So, the final version for v4 is:

ENTRY(__start)

MEMORY {
     /* On virt machine RAM starts at 1 GiB. */

     /* Align text and rodata to the 1st 2 MiB chunk. */
     TXT (rx) : ORIGIN = 1 << 30, LENGTH = 2M
     /* Align r/w data to the 2nd 2 MiB chunk. */
     DAT (rw) : ORIGIN = (1 << 30) + 2M, LENGTH = 2M
     /* Align the MTE-enabled page to the 3rd 2 MiB chunk. */
     TAG (rw) : ORIGIN = (1 << 30) + 4M, LENGTH = 2M
}

SECTIONS {
     .text : {
         *(.text)
         *(.rodata)
     } >TXT
     .data : {
         *(.data)
         *(.bss)
     } >DAT
     .tag : {
         /*
          * Symbol 'mte_page' is used in boot.S to setup the PTE and in the mte.S
          * test as the address that the MTE instructions operate on.
          */
         mte_page = .;
     } >TAG
     /DISCARD/ : {
         *(.ARM.attributes)
     }
}


@Phil Are you good with it?


Cheers,
Gustavo

