Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AA5E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 11:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOb8v-00056l-CY; Fri, 20 Dec 2024 06:26:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOb8n-000568-Kz
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 06:25:57 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOb8l-0002Xx-HC
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 06:25:57 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2161eb95317so16828535ad.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 03:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734693952; x=1735298752; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WMbmZxKiks9BsDS7rjSZkFd+weOW1sksuqaURUEJMU8=;
 b=P/2sjmyfTChAfESTJR+F8f5c1zag31Mm4FTtoG8q7/cHw/STXCce9EqGXecBnkj7zy
 /F/7dp8zrBgQh57LMXuX50Kw/PmSqxE2RHSSWaDMqWJDmJd7M8WI2gIsgG2+GBunqdMX
 OlbMvppEPu26b9dCuosz2pI5jHBin+el/CMWVw7Q3ZC2faw1KO2fN2mXLGGBcS8xVP1x
 wTIfItVoIRa7h6Y8rKQ2a3zA7gBmvb1g02Qe/MWWT47UwsUhgglFDHMd4biSvCWjkuQ3
 ki9SD0G2sq8q6QKnMv2gqgrF0X8sCJLhqAsHhx/Yw0T/QZhHfAwJdgWMngfmtl3fBucL
 wyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734693952; x=1735298752;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WMbmZxKiks9BsDS7rjSZkFd+weOW1sksuqaURUEJMU8=;
 b=kaAvHmY6XhqwqFRda/OaH8PwastXLVbIvw4b5TO41Y5zzHlU6ypw4xi0Zf5GZnvyH6
 9dDBgPN/YGEWKdlJxkjqHP0e/JbQ7ntOFMY8MKKy29vj6ZNQnwIChHvcr2bDVYGJKQHh
 0cavNAGSFVp0Zd3sLq0k+mG4hSGGfaz9kRJyG3occz9+xlsS7f6utjY+YoTMRMMiUBrr
 OGPG4s3MnTSaRQFx+NjyNOvp9RWoZfBaPwK54QLw8bwywu2H4E41Mg00hLjkSy3z/Gev
 frrBYZ37Qd+ViRVMfG5OLwJLnUsrtCBnU1TMWv/7UrJsW4khKW2hV6mP91lJ/Pzzt4w8
 qh4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuD1ESnuXhSofF6vfB97tPFU0PEqlgGyt1iu9oifZvEuNYAjptfkvI/UoX4EqBuDpwubHEThayaJqR@nongnu.org
X-Gm-Message-State: AOJu0Yz68BfGABOIk1tNlAraTryA64UlywiQujP/VzkPqhrn74VGwFOB
 ig+x3P/lhETONuJd/bJPLEkYfqUlGGNECmZfCSibYm6QQomBbQpWRA9FjT0sns0=
X-Gm-Gg: ASbGnctT4wyNNCvQ/EjaU/jef91jOuXHfKa71/PsRTTfdVB8pq1SVN20M69aho/Pkaj
 wBc7SsQnxC7lS0Dm8T8qZcPUs++DbKarPnub0DB6ZBy51iOU679aLJ9CSmdvlCDZIMzKADiy8Jx
 TkmkRJSXW4SL5FwR4KftJE8bdkhjO+5SxHmL0v9TQO0OtA+dVPkemj03pO+Mq0Uli4j6puNTbxD
 tJjn7Rb3gjT3fy0RcaZxNL671r2f9Ao8pJNiDq7gbLULJADrCsJ8nWLt2zYseLlzWS8+wk=
X-Google-Smtp-Source: AGHT+IFHS8qAfn6mOS/9yujU3XY+E7rYv7xqvDGkcD5WfbwLe0brWGEWMO/ztyuJq/awVO9on9AGAw==
X-Received: by 2002:a17:902:d592:b0:215:97a3:5ec5 with SMTP id
 d9443c01a7336-219e6e9fdf2mr36443165ad.22.1734693952287; 
 Fri, 20 Dec 2024 03:25:52 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9f6922sm27032645ad.223.2024.12.20.03.25.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 03:25:51 -0800 (PST)
Message-ID: <fe9d34bf-5a68-42e3-ad00-c8f22551865c@linaro.org>
Date: Fri, 20 Dec 2024 12:25:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] qdev: Make qdev_get_machine() not use
 container_get()
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20241121192202.4155849-1-peterx@redhat.com>
 <20241121192202.4155849-9-peterx@redhat.com>
 <dbe21846-ea9e-47b6-83c4-6ee350e891e5@linaro.org>
 <a0e5950d-2de8-4500-8376-88c231818aed@linaro.org>
Content-Language: en-US
In-Reply-To: <a0e5950d-2de8-4500-8376-88c231818aed@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x636.google.com
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

On 19/12/24 19:27, Philippe Mathieu-Daudé wrote:
> On 19/12/24 19:20, Philippe Mathieu-Daudé wrote:
>> On 21/11/24 20:21, Peter Xu wrote:
>>> Currently, qdev_get_machine() has a slight misuse on container_get(), as
>>> the helper says "get a container" but in reality the goal is to get the
>>> machine object.  It is still a "container" but not strictly.
>>>
>>> Note that it _may_ get a container (at "/machine") in our current 
>>> unit test
>>> of test-qdev-global-props.c before all these changes, but it's probably
>>> unexpected and worked by accident.
>>>
>>> Switch to an explicit object_resolve_path_component(), with a side 
>>> benefit
>>> that qdev_get_machine() can happen a lot, and we don't need to split the
>>> string ("/machine") every time.  This also paves way for making the 
>>> helper
>>> container_get() never try to return a non-container at all.
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>   hw/core/qdev.c | 7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>>> index 5f13111b77..b622be15ee 100644
>>> --- a/hw/core/qdev.c
>>> +++ b/hw/core/qdev.c
>>> @@ -817,7 +817,12 @@ Object *qdev_get_machine(void)
>>>       static Object *dev;
>>>       if (dev == NULL) {
>>> -        dev = container_get(object_get_root(), "/machine");
>>> +        dev = object_resolve_path_component(object_get_root(), 
>>> "machine");
>>> +        /*
>>> +         * Any call to this function before machine is created is 
>>> treated
>>> +         * as a programming error as of now.
>>> +         */
>>> +        assert(dev);
>>
>> This fails for user-emulation:
>>
>> ./qemu-x86_64 /bin/echo foo
>> qemu-x86_64: ../../hw/core/qdev.c:825: qdev_get_machine: Assertion 
>> `dev' failed.

OK so I guess I might have found a "fix" which is to simply not
call qdev_get_machine() for user emulation, but this involves some
invasive refactoring -- so will take time --.

I'm dropping this series for now, planning to merge it again on top
of my refactor once it is ready. Any clever / simpler fix is
obviously welcomed first.

Regards,

Phil.

>> Aborted (core dumped)
> 
> (gdb) bt
> #5  0x00007ffff747171b in __assert_fail_base (fmt=0x7ffff7626130 
> "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=0x555555725150 
> "dev",
>      file=0x55555571aff9 "../../hw/core/qdev.c", line=824, 
> function=<optimized out>) at ./assert/assert.c:92
> #8  0x000055555565e400 in qdev_get_machine () at ../../hw/core/qdev.c:824
> #9  machine_get_container (name=0x55555571b052 "unattached") at ../../ 
> hw/core/qdev.c:834
> #10 0x000055555565ea2d in device_set_realized (obj=0x5555558b6760, 
> value=<optimized out>, errp=0x7fffffffdb50) at ../../hw/core/qdev.c:479
> #11 0x000055555566181a in property_set_bool (obj=0x5555558b6760, 
> v=<optimized out>, name=<optimized out>, opaque=0x555555813350, 
> errp=0x7fffffffdb50)
>      at ../../qom/object.c:2375
> #12 0x00005555556649f8 in object_property_set 
> (obj=obj@entry=0x5555558b6760, name=name@entry=0x55555571b03e 
> "realized", v=v@entry=0x5555558c0680,
>      errp=errp@entry=0x7fffffffdb50) at ../../qom/object.c:1450
> #13 0x0000555555668754 in object_property_set_qobject 
> (obj=obj@entry=0x5555558b6760, name=name@entry=0x55555571b03e 
> "realized", value=value@entry=0x5555558be490,
>      errp=errp@entry=0x7fffffffdb50) at ../../qom/qom-qobject.c:28
> #14 0x00005555556650c9 in object_property_set_bool (obj=0x5555558b6760, 
> name=name@entry=0x55555571b03e "realized", value=value@entry=true,
>      errp=errp@entry=0x7fffffffdb50) at ../../qom/object.c:1520
> #15 0x000055555565dd52 in qdev_realize (dev=<optimized out>, 
> bus=bus@entry=0x0, errp=errp@entry=0x7fffffffdb50) at ../../hw/core/ 
> qdev.c:276
> #16 0x0000555555593dc9 in cpu_create (typename=<optimized out>) 
> at ../../hw/core/cpu-common.c:61
> #17 0x00005555555925de in main (argc=3, argv=0x7fffffffe308, 
> envp=<optimized out>) at ../../linux-user/main.c:823
> 
> 
>>
>> We need to skip this test for user emulation, but this file is in
>> hwcore_ss[] so the CONFIG_USER_ONLY definitions is not available.
>>
>> Any simple enough idea to not block this?
>>
>>>       }
>>>       return dev;
>>
> 


