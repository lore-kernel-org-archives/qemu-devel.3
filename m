Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42418D6D250
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 00:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGSrO-0002ut-8e; Wed, 27 Nov 2024 19:58:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGSrJ-0002tK-Ks
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 19:58:17 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGSrH-0000JB-Jf
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 19:58:17 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-724ffe64923so364313b3a.2
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 16:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732755493; x=1733360293; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w6COmy/st1Q48PbL91QS9wtPG+BimSamS/GjQkfvA3w=;
 b=NT4wYv0j5Suhpbd9vdHri6U4mLBcTe5sm+Ry0j3ohWP/XFTwjQa8R8AyzW3jA2YuIB
 qtZxOUrKFMMUYEbhS06aMhyaz3doI//snck89gwcUNbi5ov6tFvknAsFgQb0fKLk1uA8
 qbgVk44HouJ1070vOLBSdJf9l5R6W+q/TQKIJzEFT3VkQh2eGHyQRLCqtWMX2ebZJjbP
 6yXl97DNWW/sxu9Ez9B7XP/IzCdVtSYDka37KjZ+UDdYj0ftF/xRa8Gx7zRU9W4G1CLP
 RbJUlNjDIC0RxLYgfcmlTphbxczpc599xrMoNaGDBp6y1UpvL7Idn1vXDVFvNPGGEbT2
 JLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732755493; x=1733360293;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w6COmy/st1Q48PbL91QS9wtPG+BimSamS/GjQkfvA3w=;
 b=ZGQlm0pRjQ8Qv3jShYJ2FIFyRV1UhMPeoljNGaPHmi5g7VAJaSR1+uocku19xnkyB3
 My760QnQ1wJDs/+6/8TJnZ3LKBkW/CXTRe9gLlZrUdAscvOmWdBvOwf9ip36mmOtsR1Y
 EQEqmke2AVx0w1vEuXGSNlshHW7VAZzgws1gnJbtlaZK0hlN0JdQQGdGJLxVgLOmGfm+
 vi/7MNRC4CGq+RXG/i5cygd+V6RS3RSQXwmBhsgAp/D9GXsZR4S25Iwr+rsrQ1oXhO71
 ezShiBmUfEU/PytceqA6N86WOUsqL1XjOvs3/+URdHEUm7of6qlU25Ndy/uhbiuuYJfq
 eCoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzAuKSGhVBPeGyVBkHg7QLDYf4KE0yf/HKiQ7vQB5FMPi/2IsVpX0HXlHrh4rRhb/sGKIi+zrp+jjs@nongnu.org
X-Gm-Message-State: AOJu0YyLbxPufUll4Dg1ZTKOHYrBrY3pQXxRFHyLO8ILMnfnVP8b8Hrn
 RqMbmwEd2esmBEktMjRhO7/VWKIGNSFjX0mSaEwxsa/5RupxA4gmx4lnRqO7Sl8=
X-Gm-Gg: ASbGncus4gcZEPcsis6GkxHlCamzWI0HytltHgWIsbR1oA2w/uCXzk5cdrrOWMMUMuE
 fCiQWtCC5/UO7g6DUUamV7paLrlte1cn79FJ4WBJhwM2D86x4AJOEvQ490tzngLpK4A14ibxRq8
 INjLtQOAmsby3dKsiN4/YibRCEP1k5HCE9/PC8mgfU07QK6ia+MvOrUq6I2OtDWK44ZOp04t7c0
 ogsWqhzykEb1IqT0bAI9l4ueFuMrSEs1kZuh4W6XRrvu/hIZOL7zPJJYsu9AteGm+7PjE6QMq/K
 X650vMVp586GCo6FL1TRlA==
X-Google-Smtp-Source: AGHT+IGdWyo74dSpZzTfyUL1M/W5fQkVLXYJ4Aj4v3bRH1GiPn6Kq+eKt3Aihupl3IOURatglX8BEA==
X-Received: by 2002:a05:6a00:2381:b0:71e:55e2:2c43 with SMTP id
 d2e1a72fcca58-7253005a02bmr7184472b3a.14.1732755493219; 
 Wed, 27 Nov 2024 16:58:13 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7254180f78asm205539b3a.133.2024.11.27.16.58.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 16:58:12 -0800 (PST)
Message-ID: <38e5b015-c2a5-45a9-bdd5-9ac5c72865a0@linaro.org>
Date: Wed, 27 Nov 2024 16:58:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] docs/devel/style: add a section about bitfield,
 and disallow them for packed structures
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20241126211736.122285-1-pierrick.bouvier@linaro.org>
 <20241126211736.122285-3-pierrick.bouvier@linaro.org>
 <59a3b2b4-3a9a-47c4-bbaa-6cea6b6c50e4@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <59a3b2b4-3a9a-47c4-bbaa-6cea6b6c50e4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 11/26/24 22:38, Thomas Huth wrote:
> On 26/11/2024 22.17, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    docs/devel/style.rst | 10 ++++++++++
>>    1 file changed, 10 insertions(+)
>>
>> diff --git a/docs/devel/style.rst b/docs/devel/style.rst
>> index 2f68b500798..13cb1ef626b 100644
>> --- a/docs/devel/style.rst
>> +++ b/docs/devel/style.rst
>> @@ -416,6 +416,16 @@ definitions instead of typedefs in headers and function prototypes; this
>>    avoids problems with duplicated typedefs and reduces the need to include
>>    headers from other headers.
>>    
>> +Bitfields
>> +---------
>> +
>> +C bitfields can be a cause of non-portability issues, especially under windows
>> +where `MSVC has a different way to layout them than gcc
>> +<https://gcc.gnu.org/onlinedocs/gcc/x86-Type-Attributes.html>`_.
>> +For this reason, we disallow usage of bitfields in packed structures.
> 
> I'd maybe add a "in new code" in above sentence - otherwise people will
> complain that there are pre-existing examples with packed structures that
> have bitfields in them.
> 
>    Thomas
> 

I'll add this, with other changes Peter suggested.

> 
>> +For general usage, using bitfields should be proven to add significant benefits
>> +regarding memory usage or usability.
>> +
>>    Reserved namespaces in C and POSIX
>>    ----------------------------------
>>    
> 


