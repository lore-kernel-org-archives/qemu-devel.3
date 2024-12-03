Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B567E69E88
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 10:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIPvv-0003go-AW; Tue, 03 Dec 2024 05:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tIPvt-0003fH-0l
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 05:15:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tIPvr-00008y-2k
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 05:15:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733220902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=132oPmzfFYpbJvCDiaa2YBCQLErs5TXW0m/pytmDa0s=;
 b=AOkuYtTnrJRjPUNQk5GPSwB4DbQiJhpPrQ7WvMxK0P2l+RQuovsQjs2bkdcwid5REPre8v
 TALhzIMMyMlORrHPNfNE7Mtv3LtVZULGHRhxmhVijABYTJhejfWZBv2mC2UWyeXQy2I3Cq
 ZWa4GeSCx8pnpfUgue5/4cnYiScWSN8=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-W6Rs_VnKOgiQl-Vi-L3G1g-1; Tue, 03 Dec 2024 05:15:00 -0500
X-MC-Unique: W6Rs_VnKOgiQl-Vi-L3G1g-1
X-Mimecast-MFC-AGG-ID: W6Rs_VnKOgiQl-Vi-L3G1g
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-85b9d3180a6so1278755241.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 02:15:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733220900; x=1733825700;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=132oPmzfFYpbJvCDiaa2YBCQLErs5TXW0m/pytmDa0s=;
 b=qWmEq34VfZVG4gV+L2Ez4iPl9v17wWu87e2GsQUgmWLtAowjRex24ldgYxbjt3mLO6
 Y441p//Tz8aahooJbnf4U/XgsU6mBR73HduTkUrBBlv0XgGvjlgBAoqIUXA74kTMh/pN
 Ey7v9cozeYU0FPRHHPdHtVeliMUap/4BcBEjLtZC9T0h+ncM+fR0kgergpcAw88/XOD+
 XKY3eCJVbCZdIYECbEWvq7fRMX352D2GEVl9x5lAh3zURx0AATkD9uOyD7P8KlkEhrZw
 xcXtgeXRV2iDu9yFb6SNO0MrRcNt5qMkGyu+B8i0TSPOFNZee6n8DbW39uBI+7Oq1ap1
 xwKA==
X-Gm-Message-State: AOJu0YyCTft7KNoxfLUtbWTz0YnmituczxuHjgShWjW0911xgQ3WUIQD
 9AvQoa4pViYPcmMyzz5CalXiXVGAeK0ypXMW6+vDYF1KWinHuhT7NpIG5X9xHkbkw75edqGce4s
 vHWPNbSXC0/8YzJhLNlJJzkJdP9VQppcG04tocsLVfeT2ikSemP+w
X-Gm-Gg: ASbGncuqpmqWVkZJ/EWj/qg25j+GUwumSjQ5/tUj4ASz7/RKUjudocLm6h+q2Yj3JPe
 v6zMLKDIbK2IwCckhclx5oB6lF9MuZhTkfk8Xn93FCsR8L+6dafphvZjB186bbCIASvjGjLfC61
 1/88jKZZvnbgc/gf5sGA9GXaDfJrkGXc1zSfk8L7DQQryr8zd1CqKkpDhogXIkdQPuK51+NJ3O0
 1gVGzdKJJeJJmUj7Me7Kz3Qe0aic6hKSADJ+2k9c2j09CvKSy3MJQxvcWR5hC16vjvlFrRK0nmA
 QyoaSA==
X-Received: by 2002:a05:6102:a47:b0:4af:2d25:c46f with SMTP id
 ada2fe7eead31-4af973ae009mr2236084137.21.1733220900071; 
 Tue, 03 Dec 2024 02:15:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjtIMKz7DttErUo5vOfJG1GJlQdJlrNlIIc4m8x9L5XyV7W+diZhaVSxA+sMscOOHdJxg2GA==
X-Received: by 2002:a05:6102:a47:b0:4af:2d25:c46f with SMTP id
 ada2fe7eead31-4af973ae009mr2236057137.21.1733220899698; 
 Tue, 03 Dec 2024 02:14:59 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-199.web.vodafone.de.
 [109.42.51.199]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8a9d0ee80sm19695316d6.44.2024.12.03.02.14.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 02:14:59 -0800 (PST)
Message-ID: <a7d66166-b2ce-4e9a-81ee-2121199832ab@redhat.com>
Date: Tue, 3 Dec 2024 11:14:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.2? v2 1/2] tests/functional/test_version: Use QTest
 accelerator
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>, Markus Armbruster <armbru@redhat.com>
References: <20241203091036.59898-1-philmd@linaro.org>
 <20241203091036.59898-2-philmd@linaro.org> <Z07M4jpxZo9Ns0Rj@redhat.com>
 <884bb70b-bb7a-4676-ab74-fd19a2758955@linaro.org>
 <9124df54-a9a7-401b-8b0e-b81ac4dab365@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <9124df54-a9a7-401b-8b0e-b81ac4dab365@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 03/12/2024 10.38, Philippe Mathieu-Daudé wrote:
> On 3/12/24 10:26, Philippe Mathieu-Daudé wrote:
>> On 3/12/24 10:18, Daniel P. Berrangé wrote:
>>> On Tue, Dec 03, 2024 at 10:10:35AM +0100, Philippe Mathieu-Daudé wrote:
>>>> When testing with a HVF-only binary, we get:
>>>>
>>>>     3/12 qemu:func-quick+func-aarch64 / func-aarch64- 
>>>> version                                      ERROR            0.29s exit 
>>>> status 1
>>>>    stderr:
>>>>    Traceback (most recent call last):
>>>>      File "tests/functional/test_version.py", line 22, in 
>>>> test_qmp_human_info_version
>>>>        self.vm.launch()
>>>>      File "machine/machine.py", line 461, in launch
>>>>        raise VMLaunchFailure(
>>>>    qemu.machine.machine.VMLaunchFailure: ConnectError: Failed to 
>>>> establish session: EOFError
>>>>        Exit code: 1
>>>>        Command: build/qemu-system-aarch64 -display none -vga none - 
>>>> chardev socket,id=mon,fd=5 -mon chardev=mon,mode=control -machine none - 
>>>> nodefaults
>>>>        Output: qemu-system-aarch64: No accelerator selected and no 
>>>> default accelerator available
>>>>
>>>> Explicit the QTest accelerator to be able to run the HMP command.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>   tests/functional/test_version.py | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/tests/functional/test_version.py b/tests/functional/ 
>>>> test_version.py
>>>> index 3ab3b67f7e3..d3da796991f 100755
>>>> --- a/tests/functional/test_version.py
>>>> +++ b/tests/functional/test_version.py
>>>> @@ -18,6 +18,7 @@ class Version(QemuSystemTest):
>>>>       def test_qmp_human_info_version(self):
>>>>           self.set_machine('none')
>>>> +        self.vm.add_args('-accel', 'qtest')
>>>
>>> IMHO this is wrong. The functional tests are there to test the
>>> real functional behaviour under an actual accelerator not qtest.
>>
>> It works using '-accel hvf'. The issue is:
>>
>>    "No accelerator selected and no default accelerator available"
>>
>> So we should select HVF over QTest by default? I tend to not
>> enforce any default because we always get troubles with them,
>> what is today's default is unlikely tomorrow's one.
> 
> So by using:
> 
> -- >8 --
> diff --git a/system/vl.c b/system/vl.c
> index 54998fdbc7e..2f855d83fbb 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2362,6 +2362,7 @@ static void configure_accelerators(const char *progname)
>               /* Select the default accelerator */
>               bool have_tcg = accel_find("tcg");
>               bool have_kvm = accel_find("kvm");
> +            bool have_hvf = accel_find("hvf");
> 
>               if (have_tcg && have_kvm) {
>                   if (g_str_has_suffix(progname, "kvm")) {
> @@ -2374,6 +2375,8 @@ static void configure_accelerators(const char *progname)
>                   accelerators = "kvm";
>               } else if (have_tcg) {
>                   accelerators = "tcg";
> +            } else if (have_hvf) {
> +                accelerators = "hvf";
>               } else {
>                   error_report("No accelerator selected and"
>                                " no default accelerator available");
> 
> ---
> 
> All test suites pass on my HVF-only build directory. If this is
> OK with you then this is also OK for me.

Yes, looks like we're doing the same for KVM already, so IMHO this should be 
done for HVF, too.

  Thomas


