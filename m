Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFDAC5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 09:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sisJu-0005WU-Uk; Tue, 27 Aug 2024 05:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sisJn-0005Vo-TL
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 05:16:53 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sisJm-0004po-15
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 05:16:51 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c09fd20eddso2324182a12.3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 02:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724750207; x=1725355007; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zHXQkUqodP/eNyr8h+Sf/+cLn8al6/gYDTwtdfsLbAQ=;
 b=hjvzxmL0Ncb6KbxUv5PNmBaas/ZUAGzZH/lc8U7nxuFSrTRm3X8whuYnfmS9ItoCBU
 sxparzVjHbe71SheyIJktlilhX8ONE8ta0DAZsHncwHNATfVfsY+NuoTyNw8L05w2+zE
 WJRRKpMLTUHyBs/HI+o2JvqMjTaIid3LmF4VxLf3kIFblqNHOJfIQ1E/cBbQmE4w5wNP
 uqWUNUluO3pYOhtSzaARsDEFF7MSI2Ype4WYZ+FsxoXBmTY6K5hOoviX4C4b/tWajUHI
 ZsHRtJwHYjhW+zMeISYWBlBBkq6wyCKhxnQqYM+J5dlcXEY4HdRzD3Wb++vn5JrLtJmN
 GXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724750207; x=1725355007;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zHXQkUqodP/eNyr8h+Sf/+cLn8al6/gYDTwtdfsLbAQ=;
 b=CbMhwx9UquPm/U7kRCh+V2qWRPz4NfxLYmW/Xmg5WBeYiZxnpd0ddKGv7wIIJV23OY
 b48eBW+BxBwp7mpcrl0tKzNw0hRr78jwePKkw4TJP3b61G2oGd7NG4MxmZOR8U6pwO05
 EWzrELjbCfldjnnk3WvfGmqNomTyAwgMbH5tM1r3pZcpxGuhZrg4ROQnJPHzRqy4uHX+
 zMbVoxwOnPQDBoensPmXksG3Zan2cuhPgivIG8lg3fu53i2Eol+hcz7gm7+m9JPnv4ea
 saXYjcsxsCLshFZrmRm8ExMq4Oj45vCrvIyh4r0J6vCI89jWZllNheH6Y68PHYc5QknG
 HPZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXezJEAhcMRyvPclYi04/llhG8HTKqf9tXijZ4tGh7UBeb1gzgFgTeZGwHNxpoMXC9AHruyFs9L/0J5@nongnu.org
X-Gm-Message-State: AOJu0Yy3SGZVUmNbgDDGfpYDqCqJ7MSU7dj0TEr6VzE4mEfeoojqBbUI
 5/FbKRam6zoZ1ZstUA9/9EtavhK582sXdLBvMrZ4Ud1G8ysBuJNF/cWqYF5WIDg=
X-Google-Smtp-Source: AGHT+IGtYaJxIwp4OIvaJyqVSvBWjduR2J3A5dqnbpweHz5AFYALx7jf3C/yCyPV9OJlqFvCiU9xiA==
X-Received: by 2002:a17:906:f5a9:b0:a86:79a2:ab12 with SMTP id
 a640c23a62f3a-a86e3a4b27emr181947966b.38.1724750207431; 
 Tue, 27 Aug 2024 02:16:47 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.206.45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e592dadasm82976766b.200.2024.08.27.02.16.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Aug 2024 02:16:47 -0700 (PDT)
Message-ID: <9910ebc8-b7c4-4505-a987-3a5e308fb3d1@linaro.org>
Date: Tue, 27 Aug 2024 11:16:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] tests/functional: Convert mips64el Fuloong2e
 avocado test (2/2)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Cleber Rosa <crosa@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Huacai Chen <chenhuacai@kernel.org>,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20240824160829.27655-1-philmd@linaro.org>
 <20240824160829.27655-3-philmd@linaro.org>
 <e840b528-c48b-4b5e-9b2b-c7c0a0473ce7@redhat.com>
 <2f484cff-e227-47e3-b570-40e1945cee63@linaro.org>
 <2f741de8-84b5-4bdf-98a6-568139dfbfb9@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2f741de8-84b5-4bdf-98a6-568139dfbfb9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 27/8/24 07:27, Thomas Huth wrote:
> On 26/08/2024 22.59, Philippe Mathieu-Daudé wrote:
>> On 26/8/24 11:10, Thomas Huth wrote:
>>> On 24/08/2024 18.08, Philippe Mathieu-Daudé wrote:
>>>> Straight forward conversion. Update the SHA1 hashes to
>>>> SHA256 hashes since SHA1 should not be used anymore nowadays.
>>>>
>>>> Add extract_from_deb() method in qemu_test.utils package.
>>>
>>> Should we maybe rather copy the whole LinuxKernelTest class into a 
>>> new file in the qemu_tests folder, so that all the related tests can 
>>> simply inherit from that class? That way we would also get the 
>>> KERNEL_COMMON_COMMAND_LINE handling for free in all the tests that we 
>>> convert. What do you think?
>>
>> Except that variable, I'm not sure what can be reused. Most tests
>> are trivial. Maybe I'll realize after converting a few more :)
> 
> Apart from that variable and the extract_from_* functions, that class is

I don't see extract_from_deb() and extract_from_rpm() being specific
to a LinuxKernelTest class, IMO they belong to .utils with other
helpers such archive_extract().

I haven't added extract_from_rpm() there since I'd need to convert
a test using it to be able to test it, but it is planned.

Similarly image_pow2ceil_expand(), pow2ceil() and file_truncate()
are generic, not restricted to Linux console tests.

> also redefining wait_for_console_pattern():
> 
>      def wait_for_console_pattern(self, success_message, vm=None):
>          wait_for_console_pattern(self, success_message,
>                               failure_message='Kernel panic - not syncing',
>                               vm=vm)
> 
> So that failure_message handling is now missing in your converted test. 
> I think I'd feel better if we keep that, or do you think it is ok to 
> drop it?

Doh, I missed that.

