Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C46CE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 21:39:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOkhq-0001tp-MO; Fri, 20 Dec 2024 16:38:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOkhp-0001tZ-5a
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 16:38:45 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOkhn-0008U8-Df
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 16:38:44 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso1419960f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 13:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734730722; x=1735335522; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OQ+Qgg2lQm9HweMWxEy4+d9KGSU7ybkIam/uoWuw7I4=;
 b=t49mVrEpQCu5WfTt0wtCeOa+OOE7mLa+bURBsoT0/VdUvwImfgSyUxLnrwMPNmmVUn
 XcIf5Qe4024/ZyquMXNy9dKfPIR6k5OPftnf/0p+SjjSoPUNeiLcA2mTZxYRtSrLBBr+
 OZeU+JAQ1iezW8rAXZb//Cbf5rWif9ePRkChGG9FFrNVvc/ZL4CrJTuF3SYN/8YdqP7b
 hPMk6mn0MPUx/3VEwAepzsMEsICNkco/UWlyAss8u7BIp/D0rYL1+AJcl1Nsu/YfCwXs
 vn4Rnd+4VuFTjlTWisnxdebKWw9b5EHkMvhVNA+QdsaS5B9MxwcPlFmIC+1tpqsrUsmt
 E+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734730722; x=1735335522;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OQ+Qgg2lQm9HweMWxEy4+d9KGSU7ybkIam/uoWuw7I4=;
 b=M0f/uXh7sTwOclXizO8QbyMOsnimTapNgIH1bmDbRQuqR2+FoyUvKcsG+d50+qT1Xf
 8GfJ7bVJXhF1mT7qVVL5SNT6jPG/8azmqeDD9uMuegmTwKL9IRTjrMM85jX9tZ/fvPqK
 Ln//F9CxwpiYGhVzyKvFVyRyo+yz1hNNDsI2Dbe/Wq4GYIyxfGuPRH9OzyrySDJTDF1U
 X/60tOFJfXuCHJxb6lbOVCt5YIEa4k13pEKrwxoux4ohGVTLJwNjZiS24feUqFRbWnAK
 WJZ2UUr3vayuSXwpsz0kBVRTvGrW5aBlujK4c8XAEQywkYyt3LfGzdysyW5+ppvxox5F
 f9lg==
X-Gm-Message-State: AOJu0YxwWxTGycsdBZ7qDkUVV6+K/6tw5Jb6jmaL5sYMN60uoDak0v7F
 UWywc7U0za4rsdPivYMSGJCeA0L4q/PzPjFdAdB/IAOiMzUn3j14wSpf4bYss1Er6OmYD3IfeKI
 1
X-Gm-Gg: ASbGncvA+kVKnlYlaIfHdjJHXH2T9yEw5VrSLeAbLKWu/ctAxEnty1PR1lvm7+POE7t
 YDs0i5mLTBTrmjMa7nBFlhUpDMFs5Mdp4dWeyGN+ygzrmpuUkfGSd6tzcHjj0VDS8EmBxNRnFQs
 E+VSMKnei02irjKwe9YkZXd2HRdQOg2uW0n13hDjq3F31luTQXtinGcdBhS2sbtwV+1OySoyjjJ
 G+tIEOEruWsqanB/T1FkXadrv0rMDXP16/4CH/j6aUOUiKd9uoQAGyiRsCzRVbLfg==
X-Google-Smtp-Source: AGHT+IGcbaBsEQfjpZL557Lb3Sr/6irWvIIwSEX0OliJjDwIeiwv5QzziDG2se+e2BUA8ZRgeKAqpA==
X-Received: by 2002:a5d:47a7:0:b0:385:f398:3e2 with SMTP id
 ffacd0b85a97d-38a223ff39cmr3862501f8f.37.1734730721734; 
 Fri, 20 Dec 2024 13:38:41 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8472d5sm5016091f8f.47.2024.12.20.13.38.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 13:38:41 -0800 (PST)
Message-ID: <1c425eb2-6f67-49a9-8e4e-f7477d54ed55@linaro.org>
Date: Fri, 20 Dec 2024 22:38:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] qdev: Make qdev_get_machine() not use
 container_get()
To: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20241121192202.4155849-1-peterx@redhat.com>
 <20241121192202.4155849-9-peterx@redhat.com>
 <dbe21846-ea9e-47b6-83c4-6ee350e891e5@linaro.org>
 <a0e5950d-2de8-4500-8376-88c231818aed@linaro.org>
 <fe9d34bf-5a68-42e3-ad00-c8f22551865c@linaro.org> <Z2WoVxB8GfdJj6KM@x1n>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z2WoVxB8GfdJj6KM@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 20/12/24 18:24, Peter Xu wrote:
> On Fri, Dec 20, 2024 at 12:25:44PM +0100, Philippe Mathieu-Daudé wrote:
>> On 19/12/24 19:27, Philippe Mathieu-Daudé wrote:
>>> On 19/12/24 19:20, Philippe Mathieu-Daudé wrote:
>>>> On 21/11/24 20:21, Peter Xu wrote:
>>>>> Currently, qdev_get_machine() has a slight misuse on container_get(), as
>>>>> the helper says "get a container" but in reality the goal is to get the
>>>>> machine object.  It is still a "container" but not strictly.
>>>>>
>>>>> Note that it _may_ get a container (at "/machine") in our
>>>>> current unit test
>>>>> of test-qdev-global-props.c before all these changes, but it's probably
>>>>> unexpected and worked by accident.
>>>>>
>>>>> Switch to an explicit object_resolve_path_component(), with a
>>>>> side benefit
>>>>> that qdev_get_machine() can happen a lot, and we don't need to split the
>>>>> string ("/machine") every time.  This also paves way for making
>>>>> the helper
>>>>> container_get() never try to return a non-container at all.
>>>>>
>>>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>>>> ---
>>>>>    hw/core/qdev.c | 7 ++++++-
>>>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>>>>> index 5f13111b77..b622be15ee 100644
>>>>> --- a/hw/core/qdev.c
>>>>> +++ b/hw/core/qdev.c
>>>>> @@ -817,7 +817,12 @@ Object *qdev_get_machine(void)
>>>>>        static Object *dev;
>>>>>        if (dev == NULL) {
>>>>> -        dev = container_get(object_get_root(), "/machine");
>>>>> +        dev = object_resolve_path_component(object_get_root(),
>>>>> "machine");
>>>>> +        /*
>>>>> +         * Any call to this function before machine is created
>>>>> is treated
>>>>> +         * as a programming error as of now.
>>>>> +         */
>>>>> +        assert(dev);
>>>>
>>>> This fails for user-emulation:
>>>>
>>>> ./qemu-x86_64 /bin/echo foo
>>>> qemu-x86_64: ../../hw/core/qdev.c:825: qdev_get_machine: Assertion
>>>> `dev' failed.
>>
>> OK so I guess I might have found a "fix" which is to simply not
>> call qdev_get_machine() for user emulation, but this involves some
>> invasive refactoring -- so will take time --.
> 
> Thanks for taking a look, Phil.  Yes this sounds clean.
> 
>>
>> I'm dropping this series for now, planning to merge it again on top
>> of my refactor once it is ready. Any clever / simpler fix is
>> obviously welcomed first.
> 
> I initially thought about this, which could also be clean but I then
> noticed LINUX_USER is poisoned..
> 
> ===8<===
> diff --git a/qom/object.c b/qom/object.c
> index 58897a79a7..da26e8d69b 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1729,7 +1729,19 @@ const char *object_property_get_type(Object *obj, const char *name, Error **errp
>       return prop->type;
>   }
> 
> +/*
> + * Create all QEMU default containers.
> + *
> + * For system emulations, "machine" and its sub-containers are only created
> + * when machine initializes (qemu_create_machine()).
> + *
> + * For user emulations, create "machine" before hand to make qdev realize()
> + * work by default.
> + */
>   static const char *const root_containers[] = {
> +#ifdef CONFIG_LINUX_USER
> +    "machine",
> +#endif
>       "chardevs",
>       "objects",
>       "backend"
> @@ -1740,10 +1752,6 @@ static Object *object_root_initialize(void)
>       Object *root = object_new(TYPE_CONTAINER);
>       int i;
> 
> -    /*
> -     * Create all QEMU system containers.  "machine" and its sub-containers
> -     * are only created when machine initializes (qemu_create_machine()).
> -     */
>       for (i = 0; i < ARRAY_SIZE(root_containers); i++) {
>           object_property_add_new_container(root, root_containers[i]);
>       }
> ===8<===
> 
> Maybe we could still move it somewhere that LINUX_USER is not poisoned
> (plus "unattached" be created too, more below)?
> 
> OTOH, this works for me:
> 
> ===8<===
> diff --git a/linux-user/main.c b/linux-user/main.c
> index b09af8d436..009b7695f2 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -819,6 +819,11 @@ int main(int argc, char **argv, char **envp)
>       set_preferred_target_page_bits(ctz32(host_page_size));
>       finalize_target_page_bits();
>   
> +    Object *fake_obj = object_property_add_new_container(object_get_root(),
> +                                                         "machine");
> +    object_property_add_new_container(fake_obj, "unattached");
> +
>       cpu = cpu_create(cpu_type);
>       env = cpu_env(cpu);
>       cpu_reset(cpu);
> ===8<===

I like it, simple enough, allowing to remove container_get() now.

> 
> So we need both "/machine" and "/machine/unattached" so far to make
> linux-user work.  Not sure if bsd-user/main.c needs similar care, but none
> of these look as clean.

Maybe add a common method in hw/core/qdev-user.c?
qemu_create_machine() or qdev_create_fake_machine()?

