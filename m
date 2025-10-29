Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D884CCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 12:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE59x-00064N-5g; Wed, 29 Oct 2025 08:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vE59o-0005yz-De
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:20:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vE59i-0007BS-4n
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761740390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RCimj6Hw41iF24qx9ko5qQ2OLM5x0wg84Rprba27BVQ=;
 b=NoOMyVCkEiinypTMZmzRZfZZpmQEI8Gs9+L/z0FNNSmTOd9u1FdZEs2HjNOpn9tk83kMLh
 nI2caVvznkvUTeQEj567MT7pBUh7S6NV2CRz0zpl90MzqHeN7d/0+exseTJicWzQ1yREBE
 G2GFvIm7HSoxkCk/XaoDA73ouFPPcjk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-A52Clx-qNSCjighsl9nFbQ-1; Wed, 29 Oct 2025 08:19:49 -0400
X-MC-Unique: A52Clx-qNSCjighsl9nFbQ-1
X-Mimecast-MFC-AGG-ID: A52Clx-qNSCjighsl9nFbQ_1761740388
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-427013eb71dso6363202f8f.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 05:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761740388; x=1762345188;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RCimj6Hw41iF24qx9ko5qQ2OLM5x0wg84Rprba27BVQ=;
 b=sTYYuTI7yfq/OkVWPFW0/S9Ux4evtB2IlYS0H23SPmO6cjxLEjDcnhjf+B2mjLKtC/
 Bx/HauW1M8RgyszXQPGz2JiMsEJ3BqJKJFnfzUTNGJoGz7y6DcVyKqZratcL7hIqaw1W
 UFGMZ7a7rcvZtZlBZ3RetWM6bez74ULiETUvGd09xzvsJUB1HEI3INdJEB1wqNUHYDpN
 DRw+3KaJFV12I4ZNkSM1nOvnW8OWgJ4HaHX2+Cycd7gwXDezTd/DgjiFfFT8AzV2KpIv
 0KQ4WzHMOB5DpTrisC40KFDwK5ahsM6Cq4J4Oh1qg3BGVTcbF1t9//wCRWRWvZBqdkpB
 Fx6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0C/IL+6/u4cQbP/VeG/9M04yeycRUAJvR9HkuycA7zEMCYFTdhGeuB+Y0+t6qZSpDjrr1cDRoaM8c@nongnu.org
X-Gm-Message-State: AOJu0YykgI/fWgPYSogghUvLL0DfboMk4eG+jkxvqkPFElOhptgjcXUS
 41d1KgWx0nnv3wQJbIRML8J+A2lpZ/M1xFMVED+VDHQ/hYyKfGGzoCVF9PloI96t+Nu4ckLMBuv
 alqhrqhwAkfYZIUX0WEqWhBoGd5ILNrd0GRbtKSvXRRsnxqJlWpGx38O2
X-Gm-Gg: ASbGncsJjrup1ydRA/JWYxTzlwbT1+6+x3NpnhpJmujkn0ujHwKO1SkREpO8VWmK9fR
 mxyeHaNN3FckPokeBC327GDMWiaTqh9hW3gJhunIgitsFpMYIqD5S2FwvYjKfs0fot7TCVwpic4
 gh+c6WbUiZ55Gl0rlV7nw5WzZbAhZ5ZjGOM/CzBHQaRJVsFql76bOCiw5NcxCPtbiSegVHP6Xx0
 btuNXbmxBz+dRv5jmKKfgaLyV5az8pehsVXvFLMSTwM9gOTZfYq5Fs6gX6+/7HkH3e1smfZ+7/g
 mB9sY12UYyrW/Vw7KT87uk2nzW9UYWYG6aJ+vsNKjUwBi6CxW08EhjIcoNJzHOMQUPb58Eo=
X-Received: by 2002:a05:6000:4210:b0:425:825d:2c64 with SMTP id
 ffacd0b85a97d-429aef86311mr2486182f8f.17.1761740387884; 
 Wed, 29 Oct 2025 05:19:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnGZSmkWGTkHfBrbDqAR6MGoPmfZEbncQLiLcFnKP6LLUr7cDTz4Hvmh/GjmLAXsuBkkGMWg==
X-Received: by 2002:a05:6000:4210:b0:425:825d:2c64 with SMTP id
 ffacd0b85a97d-429aef86311mr2486155f8f.17.1761740387462; 
 Wed, 29 Oct 2025 05:19:47 -0700 (PDT)
Received: from [192.168.0.7] ([47.64.112.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952db9c6sm26563957f8f.36.2025.10.29.05.19.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 05:19:47 -0700 (PDT)
Message-ID: <c3d0c83a-f1e9-4e93-8a35-41f58da56e61@redhat.com>
Date: Wed, 29 Oct 2025 13:19:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH PING v4 0/3] target/s390x: Fix missing clock-comparator
 interrupts
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20251016175954.41153-1-iii@linux.ibm.com>
 <f27dace00e0e89c5b16ac555f92c976575d0c4ab.camel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <f27dace00e0e89c5b16ac555f92c976575d0c4ab.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 29/10/2025 10.55, Ilya Leoshkevich wrote:
> On Thu, 2025-10-16 at 19:58 +0200, Ilya Leoshkevich wrote:
>> v3:
>> https://lore.kernel.org/qemu-devel/20251016120928.22467-1-iii@linux.ibm.com/
>> v3 -> v4: Add a patch for the missing address generation affecting
>>            interrupts. Slightly adjust the test, keep Thomas' R-b.
>>            Add Thomas' R-b to the timer rearm fix.
>>
>> v2:
>> https://lore.kernel.org/qemu-devel/20251015142141.3238-1-iii@linux.ibm.com/
>> v2 -> v3: Rearm the timer on control register load (Thomas).
>>            Add Thomas' R-b to the test.
>>
>> v1:
>> https://lore.kernel.org/qemu-devel/20251014160743.398093-1-iii@linux.ibm.com/
>> v1 -> v2: Add Thomas' R-b.
>>            Cc: stable (Michael).
>>            Improve formatting, commit messages, and test (Ilya).
>>
>> Hi,
>>
>> While trying to reproduce [1], I found two bugs in the clock
>> comparator
>> handling. This series fixes all three issues and adds a test.
>>
>> [1]
>> https://lore.kernel.org/lkml/ab3131a2-c42a-47ff-bf03-e9f68ac053c0@t-8ch.de/
>>
>> Best regards,
>> Ilya
>>
>> Ilya Leoshkevich (4):
>>    target/s390x: Fix missing interrupts for small CKC values
>>    target/s390x: Fix missing clock-comparator interrupts after reset
>>    target/s390x: Use address generation for register branch targets
>>    tests/tcg/s390x: Test SET CLOCK COMPARATOR
>>
>>   target/s390x/tcg/mem_helper.c           | 11 ++++-
>>   target/s390x/tcg/misc_helper.c          | 12 +++--
>>   target/s390x/tcg/translate.c            | 11 +++--
>>   tests/tcg/s390x/Makefile.softmmu-target |  1 +
>>   tests/tcg/s390x/sckc.S                  | 63
>> +++++++++++++++++++++++++
>>   5 files changed, 89 insertions(+), 9 deletions(-)
>>   create mode 100644 tests/tcg/s390x/sckc.S
> 
> Hello,
> 
> I would like to ping this series.
> 
> Patches 1, 2, and 4 are already reviewed (thanks, Thomas!).
> Patch 3 still needs a review.

  Hi Ilya,

I still got it on my radar, and indeed, it would be great to get an Ack from 
Richard or David for patch 3.

However, the main problem is that we need the fix for the C23 problem in the 
fourth patch first before this could get merged 
(https://gitlab.com/qemu-project/SLOF/-/merge_requests/2). It should 
hopefully get fixed with Harsh's next ppc pull request, see:

  https://lore.kernel.org/qemu-devel/21a94013-c3ef-49e4-abfa-a277277a03b0@linux.ibm.com

  Thomas


