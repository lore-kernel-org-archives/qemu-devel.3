Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FC4C369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 21:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5WRH-00038z-BH; Thu, 17 Apr 2025 17:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u5WRD-000380-Ui
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 17:06:24 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u5WRB-0002bx-HO
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 17:06:23 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-226185948ffso14422615ad.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 14:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744923979; x=1745528779; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2SX7Ep+ot7gpgj7NWTMdX4Ce49Ly0lymB8IyE/t7pOY=;
 b=R3EEQ45K0l5pDmr8zbrxeF+shNT1mSCw5JieqgoPH0kmqbo2LeJQUAAhY0qYXY/iIq
 golAqP7OO2wzjP/7xItfRoDJdvfr4DWTlxwhuc1iHyCS9hkl6b8yKwKhsUN45muBKfVu
 YrNgC2jbt656GzGP56Di43FiLL9SnFQoKBIK7BfpCIDHyyyhngapbml8vlCRyYnSoDpk
 KJBgUbg1MdTRGMcrGO71757cmjRUOVVSnh/5QjdXGnFndbOHRYuHSn0aFMBHrJQPyCCE
 mXRSS6t+q9TACDbbHLDDKvv94ZTbLkP2rRP/tHsMY3gd7zwEXSzUEZa5j1hIttGkAaGb
 UMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744923979; x=1745528779;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2SX7Ep+ot7gpgj7NWTMdX4Ce49Ly0lymB8IyE/t7pOY=;
 b=gFDWuI0XtCFAQDxlD5T00MkINzJ7ZVAaBFkcHodAilqDAVtQklvwMKTs47MNXOLHK3
 zeSOYnNF4flCkC5xCsHQVGpv0ekmU7FVVFABei7sFE5Iz6FtD3M3jcYJ554C/g0YOmQo
 fvQ0wQ7IvrZBZ6tuQPJqCIE/hnZ7RB+k+uusews2w8vRxAjfcSyM5BJ4XsZyU5j4npzJ
 cANUW/E9o53Js0pqiOkWMJ0eXGGQjB4sVayaVCoRfFiB9ym/2BWXv7S8UgEAifDN+gsc
 5J3m8uZvNNwNgX8BcZ41HZvVQ5QMyViXtEQ744deAllRRvo5RYqZBYW85M3+z/Mm1zf1
 6KtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU59N1FEc7ydxaoC79WloaGHFQ5/+kbcLXNaG6TnwW3thR8Tnuzfecm4eJpl9xolvKLbjxR4PyMnFej@nongnu.org
X-Gm-Message-State: AOJu0YyOVPHYaquw/hZQ3lAYWr/8WNLBuY9H7zZi0sfjXLwXN0pFdOF+
 nwi4t4xM0gbuHPtR8ypUdkYwmrbADN8tWplz5mBl70ErrvW0P/7oJhc8rmxZolM=
X-Gm-Gg: ASbGncu54ISqwBI4FeQgFUis0qgxEtH7AO2sHdvzCNkTdulUMmt8U3mKw0TMn7538t5
 GT9+0SmMQq5t4+ase84mxfhKbSB2VX/xUQUuQCZaKkyZ+uhozr1QLKc1Rj4H4aRbAGKuNrEY3XS
 iKYse+2sIWGScXmnk974wC0SvuvBkBm+H2dOteczuhwEaG2Qx+K4fVfHH4F2ZkB9XyOkGPdv5ck
 yMscs6/VyJMcCozS5W36eC38AH2rdKgKM+ZTwAHcR6iDdAi8mYULA8Z526aBgiz2b7O2pCW//4l
 9ml2L+uOv13Ih6lw8f882b0+OuDXHWYaMklPjl83SiVJP2PnKU8K
X-Google-Smtp-Source: AGHT+IE5Sx0i+sJQdJZr9MjI/6tY42ww3fBwjDghN2gv/lQD0a8Bmfwx11UQcsAZS4q1sVxry9+nuw==
X-Received: by 2002:a17:902:d50b:b0:220:c813:dfd1 with SMTP id
 d9443c01a7336-22c53607db6mr5220135ad.36.1744923979293; 
 Thu, 17 Apr 2025 14:06:19 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.52.65])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50ed0eb5sm4485605ad.202.2025.04.17.14.06.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 14:06:18 -0700 (PDT)
Message-ID: <0dffbcec-ca2a-47d0-b837-2400865371f7@linaro.org>
Date: Thu, 17 Apr 2025 18:06:14 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v3 6/9] qtest/bios-tables-test: Whitelist
 aarch64/virt 'its_off' variant blobs
From: Gustavo Romero <gustavo.romero@linaro.org>
To: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 Udo Steinberg <udo@hypervisor.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>
References: <20250403204029.47958-1-philmd@linaro.org>
 <20250403204029.47958-7-philmd@linaro.org>
 <671a6c82-ae10-4f3b-9d83-cecc32755206@linaro.org>
 <20250409160531.341c205e@imammedo.users.ipa.redhat.com>
 <98b2676d-ad21-4c05-a165-12ae5e1b9c64@linaro.org>
 <20250410085042.6aa5593d@imammedo.users.ipa.redhat.com>
 <ec5cec94-4d02-442e-94e6-c0c2e79f3684@linaro.org>
Content-Language: en-US
In-Reply-To: <ec5cec94-4d02-442e-94e6-c0c2e79f3684@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62b.google.com
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

Hi Igor and Michael,

On 4/10/25 13:22, Gustavo Romero wrote:
> Hi Igor,
> 
> On 4/10/25 03:50, Igor Mammedov wrote:
>> On Wed, 9 Apr 2025 12:49:36 -0300
>> Gustavo Romero <gustavo.romero@linaro.org> wrote:
>>
>>> Hi Igor,
>>>
>>> On 4/9/25 11:05, Igor Mammedov wrote:
>>>> On Fri, 4 Apr 2025 00:01:22 -0300
>>>> Gustavo Romero <gustavo.romero@linaro.org> wrote:
>>>>> Hi Phil,
>>>>>
>>>>> On 4/3/25 17:40, Philippe Mathieu-Daudé wrote:
>>>>>> We are going to fix the test_acpi_aarch64_virt_tcg_its_off()
>>>>>> test. In preparation, copy the ACPI tables which will be
>>>>>> altered as 'its_off' variants, and whitelist them.
>>>>>>
>>>>>> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>> ---
>>>>>>     tests/qtest/bios-tables-test-allowed-diff.h |   3 +++
>>>>>>     tests/qtest/bios-tables-test.c              |   1 +
>>>>>>     tests/data/acpi/aarch64/virt/APIC.its_off   | Bin 0 -> 184 bytes
>>>>>>     tests/data/acpi/aarch64/virt/FACP.its_off   | Bin 0 -> 276 bytes
>>>>>>     tests/data/acpi/aarch64/virt/IORT.its_off   | Bin 0 -> 236 bytes
>>>>>>     5 files changed, 4 insertions(+)
>>>>>>     create mode 100644 tests/data/acpi/aarch64/virt/APIC.its_off
>>>>>>     create mode 100644 tests/data/acpi/aarch64/virt/FACP.its_off
>>>>>>     create mode 100644 tests/data/acpi/aarch64/virt/IORT.its_off
>>>>>>
>>>>>> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
>>>>>> index dfb8523c8bf..3421dd5adf3 100644
>>>>>> --- a/tests/qtest/bios-tables-test-allowed-diff.h
>>>>>> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
>>>>>> @@ -1 +1,4 @@
>>>>>>     /* List of comma-separated changed AML files to ignore */
>>>>>> +"tests/data/acpi/aarch64/virt/APIC.its_off",
>>>>>> +"tests/data/acpi/aarch64/virt/FACP.its_off",
>>>>>> +"tests/data/acpi/aarch64/virt/IORT.its_off",
>>>>>
>>>>> I think your first approach is the correct one: you add the blobs
>>>>> when adding the new test, so they would go into patch 5/9 in this series,
>>>>> making the test pass without adding anything to bios-tables-test-allowed-diff.h.
>>>>> Then in this patch only add the APIC.its_off table to the bios-tables-test-allowed-diff.h
>>>>> since that's the table that changes when the fix is in place, as you did in:
>>>>
>>>> if APIC.its_off is the only one that's changing, but FACP/IORT blobs are the same
>>>> as suffix-less blobs, one can omit copying FACP/IORT as test harness will fallback
>>>> to suffix-less blob if the one with suffix isn't found.
>>>
>>> OK. Just clarifying and for the records, this is not the case for this series
>>>
>>>
>>>> if blobs are different from defaults then create empty blobs and whitelist them in the same patch
>>>> then do your changes and then update blobs & wipeout withe list.
>>>
>>> Thanks for confirming it. That's what I suggested to Phil in my first review and what
>>> I understood from the prescription in bios-tables-test.c.
>>>
>>> However, on second thoughts, for this particular series, isn't it better to have the following commit sequence instead:
>>>
>>> 1) Add the new test and the new blobs that make the test pass, i.e. APIC.suffix, FACP.suffix, and IORT.suffix (they are different than the default suffix-less blobs)
>>
>> blobs should be a separate commit (that way it's easier for maintainer to rebase them,
>> if they clash during merge with some other change.
> 
> I see. What is a bit confusing here is that the series consists in
> one blob addition act (for the new test) and one blob update/removal act (after the fix).
> 
> 
>>> 2) Whitelist only the APIC.suffix since that's the table that will change with the fix
>>> 3) Add the fix (which changes the APIC table so a new APIC.suffix blob is needed and also stops generating the IORT table, so no more IORT.suffix blob is necessary)
>>> 4) Finally, update only the APIC.suffix blob and remove the IORT.suffix blob and wipe out the whitelist
>>>
>>> This way:
>>>
>>> A) It's clear that only ACPI blob changed with the fix, because there is no addition of a FACP.suffix blob in 4) (it remains the same)
>>> B) It's clear that the IORT table is removed with the fix and is not relevant anymore for the test
>>
>> I'd just mention it in commit log so  that later no one would wonder why we are adding and then removing tables
>>
>> As for the rest of suggestions, it looks fine to me.
> 
> Well, 2) won't make sense anymore since APIC.suffix would be already in the
> whitelist in the previous patch that added the empty blobs. Since there won't
> be a commit that adds _only_ the APIC.suffix to the whitelist, in preparation
> for the fix, this info is "lost" in the series, even tho it's possible to
> mention in the commit message.
> 
> Hence, what I think is not ideal from a maintainer's/reviewer's perspective,
> is that in one commit all the blobs are updated/removed at once, which is
> confusing because the fix did not touch the FACP table (for instance) and
> this table is updated with APIC and with the removal of IORT, altogether,
> in the last commit.
> 
> So, for this series, which adds new blobs and _also_ updates and removes some
> of them, how about the following organization:
> 
> - Patch 1     : Add the new test, add the empty blobs *.suffix files, whitelist such a blobs
> - Patch 2     : Update the blobs in Patch 1 with the ones that make the new test pass and remove them from the whitelist
> 
> - Patch 3     : Add the APIC.suffix blob to the whitelist (the table that changes due to the fix)
> - Patch 4 - n : Fix(es)
> - Patch (n+1) : Update the APIC.suffix blob, remove IORT.suffix blob, and remove the APIC.suffix blob from the whitelist
>                * Add the APIC diff to the commit log
>                * Mention in the commit log that IORT.suffix is removed because IORT table is no long generated after the fix
> 
> This way: a) no commit fails the test and b) blobs are added/updated/removed in separate commits
> 
> What do you think?

I’d really appreciate it if you could confirm whether this organization makes sense.


Cheers,
Gustavo

