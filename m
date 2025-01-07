Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3E8E77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4Zv-000669-My; Tue, 07 Jan 2025 03:04:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tV4YU-0003lB-Vk
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:03:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tV4YS-00039a-G4
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736236990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wiMOOHV60q4eXagNMIOLvNFV+qq1RGRo7TL5T/ORWco=;
 b=GCR5ZqsDKBjLrldPsMf/oOmXQh5pYXSktrAL77G7O4pLwhPjfbGVLvl4GYIkKeVRH8iCFO
 FaNuX+Yv5NpwZjBZV0jvBtqNoXQ/zPDoJr68zIYl04epU5ud8ZcfCHF8BiuQdxD+d7gu4M
 UtL2WH9j0JJzKiqoULh1BD6OOtGs+Lc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-dexG0c9bPCytAkGVAn5SRQ-1; Tue, 07 Jan 2025 03:03:09 -0500
X-MC-Unique: dexG0c9bPCytAkGVAn5SRQ-1
X-Mimecast-MFC-AGG-ID: dexG0c9bPCytAkGVAn5SRQ
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d8f4a0df93so440714216d6.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:03:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236988; x=1736841788;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wiMOOHV60q4eXagNMIOLvNFV+qq1RGRo7TL5T/ORWco=;
 b=iA+LTFsZQ4bCP8+uNYgPpz9i1ZHJy7WWE3bMJPRU6tbL6X1tFUfHmvkTUX6UaVdXsI
 I2pv0Qyq7DNEjE/U3ApwRnjSsFeNqS4UrZ9cSkPjhyTtyTErlJ/RRuXnqRrG7QiyodLx
 qPiE70i4pL4MnPSeA6OyHFfdbwXs1lcoCr0RVy7YlJ2BelF+uFjsxBVBIxM62S4m9aea
 CMPEtwGnMMYCRrSityRnGAfLUoghrfcFM49acc5Qgf31RxiybtogQkha2utdYPO4FhxS
 IAtdIM4uEnElxCaGYDJbZUD+WahB+fyBkHbKc8d8+hyGk0dodpG4njvG4NqiPtWPUyMX
 IMpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz9Pw+eudDZi6Gq+qUMuJNtNbcq5hXtTQj7JYdve6Xw4aG05Vw2f0w2Iw1haxMnNFtpGQv/SH9TBVA@nongnu.org
X-Gm-Message-State: AOJu0YzZTiFTPdAWC+HiQRKlA3NuT4Em/+3JJh6QrDsjYIcSc5/NeTwC
 JL6eKLRxVhiito6eRCypRMOMh61iTzzUoZPbaB7CwudX2+8pojXnU+havODaNdSj35It9YOHkXc
 efBLv3NlBY1DrRgAEjAtgBFc1wnTKFLnKQQRxHZHrrIqteee4xXYW
X-Gm-Gg: ASbGncsXdMlbAR1GdpnUwbyyXNziJ1pq1T5mo6m9IWP0+o0xVqwNqLVnxrNXXxiXhJ2
 KyoI1Bs/CHzE/ZBV30jQWRPuBncHKgpAHfKeByoaES2+60fIouY/TZr5Y3eY2wPfughLcAsNNqT
 4+hRC67OVD6Zlord4EaTyIgX/A1J9CNiuMY9Q1NOrEgKniIhogOQZ/Hi+2037ET2ZgQr5OrR6Rv
 C5bYW8Sr4ntvqp42DEWCJorPASehqQAaVnVcr2RXUE7BsaKwoGAMsYdrsOMO+GLXImc8ouil525
 KYMH/jp8yu6d
X-Received: by 2002:a05:6214:240e:b0:6d8:9838:d3a9 with SMTP id
 6a1803df08f44-6dd23356042mr888122466d6.26.1736236988713; 
 Tue, 07 Jan 2025 00:03:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8uZCilvrTikPipyXzmXV/mRQyiOUa90t9VqaXjol/FeeAF5dRjdkc+PlrOJ4IIHjqQ/x7SQ==
X-Received: by 2002:a05:6214:240e:b0:6d8:9838:d3a9 with SMTP id
 6a1803df08f44-6dd23356042mr888122216d6.26.1736236988466; 
 Tue, 07 Jan 2025 00:03:08 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-182.web.vodafone.de.
 [109.42.49.182]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd18110450sm179182026d6.44.2025.01.07.00.03.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 00:03:07 -0800 (PST)
Message-ID: <3fb8281e-23f0-44a7-904b-34b8ea8ca7f3@redhat.com>
Date: Tue, 7 Jan 2025 09:03:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] qtest: Remove uses of 'first_cpu'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Bandan Das <bsd@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-arm <qemu-arm@nongnu.org>
References: <20241211233727.98923-1-philmd@linaro.org>
 <5d2a536d-9b68-4b31-8d92-6cc42ed72e5c@linaro.org> <87msg884mn.fsf@suse.de>
 <05820c9b-a683-4eb4-a836-e97aa708d5e5@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <05820c9b-a683-4eb4-a836-e97aa708d5e5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 04/01/2025 00.48, Philippe Mathieu-Daudé wrote:
> On 3/1/25 13:26, Fabiano Rosas wrote:
>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>
>>> Hi Fabiano,
>>>
>>> On 12/12/24 00:37, Philippe Mathieu-Daudé wrote:
>>>> Replace first_cpu->as by address_space_memory.
>>>>
>>>> Philippe Mathieu-Daudé (2):
>>>>     system/qtest: Remove uses of 'first_cpu'
>>>>     qtest/fuzz: Remove uses of 'first_cpu'
> 
>>> Ping :)
>>
>> Hi!
>>
>> Good that you pinged, I thought you were looking into the test failures
>> from v1. I copied you in this other thread that mentioned them as well:
>>
>> https://lore.kernel.org/r/87y10jctbd.fsf@suse.de
>>
>> Applying this series on top of master just now:
>>
>> Summary of Failures:
>>
>>   10/519 qemu:qtest+qtest-arm / qtest-arm/stm32l4x5_usart- 
>> test               ERROR            1.40s   exit status 1
>> 165/519 qemu:qtest+qtest-arm / qtest-arm/sse-timer- 
>> test                     ERROR            0.40s   killed by signal 6 SIGABRT
>> 185/519 qemu:qtest+qtest-arm / qtest-arm/stm32l4x5_exti- 
>> test                ERROR            0.19s   exit status 1
>> 187/519 qemu:qtest+qtest-arm / qtest-arm/stm32l4x5_rcc- 
>> test                 ERROR            0.19s   exit status 1
>> 515/519 qemu:qtest+qtest-arm / qtest-arm/microbit- 
>> test                      TIMEOUT         60.01s   killed by signal 15 
>> SIGTERM
> 
> Hmm interesting, I have a "quick-before-posting-series" set
> of tests, and a "full-before-posting-pullreq" one. The quick
> is quite extensive, but only include Aarch64. I thought, since
> it contains the ARM targets, they would also be tested, but
> no...

IIRC this was a deliberate decision once in the past to avoid double 
testing: qtests_aarch64 in tests/qtest/meson.build does not include 
qtest_arm, it's a separate set of tests indeed.

IMHO it's a little bit unfortunate, since in a couple of spots in the CI, we 
are taking the shortcut of only adding aarch64-softmmu to the target list, 
but not arm-softmmu.

Maybe we should add some logic to tests/qtest/meson.build so that if 
arm-softmmu is not in target_dirs, we add the tests to qtests_aarch64 ?

  Thomas



