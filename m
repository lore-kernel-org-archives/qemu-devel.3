Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F2CCFB42B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 18:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx9AH-0005uA-BN; Sat, 05 Oct 2024 14:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx9AG-0005u0-76
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 14:06:00 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx9AE-0000yz-NJ
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 14:05:59 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7db54269325so2442109a12.2
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 11:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728151557; x=1728756357; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KycAgWTjsOGivsVmhg6CBFqDuSJHqUU8Ns5zSlTyp5Y=;
 b=bRIR4U1WFJca5pKVsZwE/nyI1vzDnkV7TVXfiAwldvXFEUzQVLhyIu+22cy6ujl9bG
 54TTQAUtx3DeZMIHS6J6Ye7kz+ZH02DCdHwLHirI9Jga/HOatUdvQ9+pPp4c9BjzEMOs
 4kmzkcRtAqMGO+P4G9PLa5sWAqJ+GZdDO7EBEsY8eqnB32BQr0xoBlWSlk0AWqfI4cqw
 BdjD22rzDQXQap92i6ReocqF+mvu4WU+bcWX6Q0WoHzcb11pIraC6qrqDkBhSBLBGTJz
 ipMSs4mp1oIWIBUjTfNEf9UhuZ4G/b7PZ8O247OQszlyv8LtvNEy/zmKCoVSOxn+vE78
 ZR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728151557; x=1728756357;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KycAgWTjsOGivsVmhg6CBFqDuSJHqUU8Ns5zSlTyp5Y=;
 b=Py8ZhzFSXbqG/9e9SYjq7KC+2gb1uOnj8IcEVk8bKs//Fxs2IdfVOvrkXn6mHqJ+iD
 TKT7Dtwe4LubS0F8o4j1lMfqrSetrhVOT97MPzZmTnrxPKW+T4YazWMjN3cOeK+qImNW
 iaGMLU2ZkLKrj61Nyb3rBY7JRnjQnWZpomF8PUXYC6tkDDttusPhrQ1MrUbA8AMckw3J
 xZzjpNYP3pHXhIENpRLGiNGBuF59fArUo5WWABX0TLTDlTSoCdDtxdhODQLMV2Xi2V+F
 UVAm86nkmnVDl8BP3OXAZ7Uuo43KC0iNl03Q7wJisA/HpoWIq/OJjl6w3yNkiS0Iu5Mg
 ltwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1czL+AOgLIHkgMgnsmvd19dkR97TLv80l7JSuqgUH8NPEp9A5QKs2jbDKPAmzIm0Q8auLKzfQpJCU@nongnu.org
X-Gm-Message-State: AOJu0Yz0o7dkzmeaN5Dr7/64rNBzIoBYEwMFDZcUgZLkwA9xLcUo0VZe
 Io2tTb4d/zQMml+sVK/Q8IHVzHvdXMj4hy/fDFE6xJ5TfkgcE8/ZhxwCApFHGas=
X-Google-Smtp-Source: AGHT+IFygOzvGx98yO4M0UAoWX2ixALyB+QdxkqaJ4ffXSir48g7OXtuMzQ0BcyDLIAyqRT72ZAUiQ==
X-Received: by 2002:a05:6a20:d704:b0:1d5:388f:275c with SMTP id
 adf61e73a8af0-1d6dfa354a0mr10031184637.20.1728151557131; 
 Sat, 05 Oct 2024 11:05:57 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0cbc4c4sm1747374b3a.44.2024.10.05.11.05.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Oct 2024 11:05:56 -0700 (PDT)
Message-ID: <669f8dfd-84cf-4514-b7d9-398103125d25@linaro.org>
Date: Sat, 5 Oct 2024 11:05:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] linux-user: Correct print_sockaddr() format
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zach van Rijn <me@zv.io>, Laurent Vivier <laurent@vivier.eu>
References: <20240807124306.52903-1-philmd@linaro.org>
 <20240807124306.52903-2-philmd@linaro.org>
 <476e5647ed10327c955809de9a4bafd45e8c2c1f.camel@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <476e5647ed10327c955809de9a4bafd45e8c2c1f.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 10/2/24 00:54, Ilya Leoshkevich wrote:
> On Wed, 2024-08-07 at 14:43 +0200, Philippe Mathieu-Daudé wrote:
>> When the %addr argument can not be accessed, a double comma
>> is logged (the final qemu_log call prepend a comma). Call
>> print_raw_param with last=1 to avoid the extra comma.
>> Remove spurious space.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   linux-user/strace.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/linux-user/strace.c b/linux-user/strace.c
>> index b4d1098170..73f81e66fc 100644
>> --- a/linux-user/strace.c
>> +++ b/linux-user/strace.c
>> @@ -434,9 +434,9 @@ print_sockaddr(abi_ulong addr, abi_long addrlen,
>> int last)
>>           }
>>           unlock_user(sa, addr, 0);
>>       } else {
>> -        print_raw_param("0x"TARGET_ABI_FMT_lx, addr, 0);
>> +        print_raw_param("0x"TARGET_ABI_FMT_lx, addr, 1);
>>       }
>> -    qemu_log(", "TARGET_ABI_FMT_ld"%s", addrlen, get_comma(last));
>> +    qemu_log(","TARGET_ABI_FMT_ld"%s", addrlen, get_comma(last));
>>   }
>>   
>>   static void
> 
> I see why this works, but it feels a bit wrong semantically: addr is
> not the last argument.
> Wouldn't it be better to add commas to the preceding switch's cases?

It would indeed.
Adding the comma manually in the final log is odd.


r~

