Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BF1E9B24E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 10:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuq0D-0006Gu-Ru; Tue, 24 Feb 2026 05:50:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vuq0B-0006GA-GP
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 05:50:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vuq09-0004OC-ER
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 05:50:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771930248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sIxwiczDKxA0X8tHFOT3Jg/JVvMYpUduKApRa+fKb+Y=;
 b=B6quFpywcHpmUsENSRryMp4o05aiXxzeHFeyZrMiPSTcyTtmNvZ7fpcBESqUK3Qzz4XT0E
 LuCUPaJJY8YqJ6Bosfw0c31aOyheIBqSObVCvA8UYx9pH1CpyHaS1/f9fbo0yL4S93MJAL
 7vnB3BnGuKrWxBz7bklg+vuV0Hfx190=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-bNLkkGdlMKOxmDYqk-_wrA-1; Tue, 24 Feb 2026 05:50:46 -0500
X-MC-Unique: bNLkkGdlMKOxmDYqk-_wrA-1
X-Mimecast-MFC-AGG-ID: bNLkkGdlMKOxmDYqk-_wrA_1771930246
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4837b9913c9so52500445e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 02:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771930245; x=1772535045; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=sIxwiczDKxA0X8tHFOT3Jg/JVvMYpUduKApRa+fKb+Y=;
 b=Cw3lTxHUsyaJovjD3LYuV/K+0LqYlXdOEYs5vgBZRjx/QhIHRh2hAQmQuT4EFl9Qw1
 xahDJEM4g0xMKpD+vCAUYklSHYIQWlP/0qrESZmmlpDum32wZGaCORaLEXQnfI6w80VK
 9Z+4sU9cg5B+k5kI0T5X+pjanj3V6+xZTBhwi/BAy7pMVg1VWmATn6JQa5yHMMObLdix
 /fFSohb9l0WW7eRDW2P+NYgFgTByBl62IwuYSeLbWlzTjcZjo1kF1Q5YNCRBh3GTnVgK
 ynpvh5WmWhis4fK6CqjXt9My96qg7j8IWg5eiM7l4NrNQIq3ZHtmNIqHgSMyb4iSblAW
 KRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771930245; x=1772535045;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sIxwiczDKxA0X8tHFOT3Jg/JVvMYpUduKApRa+fKb+Y=;
 b=bFSD6n4pN97j9ttTDssy6IYyDZqWvo3I+Gi60syCGBzxYd3NPpKo0dmJVNTRhb6Vl2
 jHYdGLhO3Cao/H51WR3t7XHSlB3WW6wq7Oh3zABEFsh7Cclf9g7bLaXdgxsoPNmzIcS5
 ZijIWLjTsWik73Tf9P/FeyR2VKUennv1zaPuJ5UGkJqe5ODiQWqSabNvtT1RbdJ2A1HJ
 dl+09ywqIQmWvJ732i3Lf0wg+EUIJ6IAIC84b+RgiuJrdIF2ETBwyoXoNEqLiEvnoM6T
 RDAzwlpfTU2N30xFSmWZaw/KmyXh2EW+M2lpXdmHuWom6WJYzeNDOopo+vOnrsFxdjIP
 tVig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMPj9OEjDFXbI8o31T8a5hafxVonpcQoThK27z9GLKH9NwS6nYsalBXq8yW0Shq+DSmjmzIUOnqaMh@nongnu.org
X-Gm-Message-State: AOJu0YwO2W17bhcQI7hSfDo95CfoDM8LhC6eQC07v+tOb7E7hr22gdCQ
 mUBGuTfYQa3OqhqZ3GbAjCcxs7m/5/eQcIp36QkczmWDx24+1kSCme9fXtxg9Z2f5g8pufd2cIX
 l0Rbxa6GouvWJhYZ9/xHK6dS9aqcU/9nWX8TQ/Pm+XRopBZWefW1f8u6z
X-Gm-Gg: AZuq6aK1GZinnAz62IDRSVYkdfK5wo8XK9lvTKbrsk9ZD7T/CDWQHSMZXTjXxnvdyuv
 sr5bw3UDMEFEfHzEYw8idTcW8lTvibPwj15FGFmPwHvHlsudi/6iDUhe2pVyl5bMS77A3MBVkPP
 JNtehUgarWlXVJ2VAK5g+cInhI+9opM9NtS0HjQIJ4bq5ejay5iJaizIwgNYlTP6qh5tFiEh43P
 J7R95mtB98fSsFI3lyMEXIHrXxodMPGI7B98fryQF70mJd01Y6+zs1wYP+GUU9LM/4nKQ9HCvBD
 6j9T8lu/2JCnAjezh5wR7EqPlWJd4yessP3WCJ0cNhyRSJBpEYsu2YqLLNGJSHicCYaNwkXNpG+
 kU4LxmLwS8MtZfz/tfZydJd70KSU5x74EAEqoShNMvHQDpu+ZSVjlrPm4RA==
X-Received: by 2002:a05:600c:4f93:b0:477:df7:b020 with SMTP id
 5b1f17b1804b1-483aaa15e35mr204905315e9.18.1771930245364; 
 Tue, 24 Feb 2026 02:50:45 -0800 (PST)
X-Received: by 2002:a05:600c:4f93:b0:477:df7:b020 with SMTP id
 5b1f17b1804b1-483aaa15e35mr204904695e9.18.1771930244713; 
 Tue, 24 Feb 2026 02:50:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:165:d60:2c1a:3780:4e49:dfcf?
 ([2a01:e0a:165:d60:2c1a:3780:4e49:dfcf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b6698asm433236275e9.2.2026.02.24.02.50.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 02:50:44 -0800 (PST)
Message-ID: <6be71017-6be7-4be1-9010-6a1cc4391bd8@redhat.com>
Date: Tue, 24 Feb 2026 11:50:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 02/16] tests/functional: Add SDK tests with Linux 5.15
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kane Chen <kane_chen@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
References: <20260212213955.2225662-1-clg@redhat.com>
 <20260212213955.2225662-3-clg@redhat.com>
 <CAFEAcA_oJgTc2SyRr11QTeTkmCPgvKiwngAaDiDNw5nUcTFA2w@mail.gmail.com>
 <CAFEAcA_9Np04vouA-m99xB8yU-JhduwxxLj_dTG0QM=AnDbHoQ@mail.gmail.com>
 <aZMwvfw4O5xeH-Gm@redhat.com>
 <98898cd4-de19-41b7-b519-541c48b462ea@redhat.com>
 <7b68fe15-f8fb-4d72-9559-8b6b89bd7563@redhat.com>
 <TYPPR06MB820657F01C98468E1F166C7FFC74A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <aa6cbbb8-d8db-451e-9f9d-c430b2e030d9@redhat.com>
 <TYPPR06MB82061B01B8E9B13A241A6AF8FC74A@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <TYPPR06MB82061B01B8E9B13A241A6AF8FC74A@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/24/26 10:33, Jamin Lin wrote:
> Hi Cédric,
> 
>> Subject: Re: [PULL 02/16] tests/functional: Add SDK tests with Linux 5.15
>>
>> On 2/24/26 03:53, Jamin Lin wrote:
>>> + Troy
>>>
>>> Hi Cédric,
>>>
>>>> Subject: Re: [PULL 02/16] tests/functional: Add SDK tests with Linux
>>>> 5.15
>>>>
>>>> Hello,
>>>>
>>>> + Jamin,
>>>>
>>>> On 2/16/26 16:08, Cédric Le Goater wrote:
>>>>> On 2/16/26 15:59, Daniel P. Berrangé wrote:
>>>>>> On Mon, Feb 16, 2026 at 11:17:38AM +0000, Peter Maydell wrote:
>>>>>>> On Mon, 16 Feb 2026 at 11:13, Peter Maydell
>>>>>>> <peter.maydell@linaro.org>
>>>> wrote:
>>>>>>>>
>>>>>>>> On Thu, 12 Feb 2026 at 21:42, Cédric Le Goater <clg@redhat.com>
>>>> wrote:
>>>>>>>>>
>>>>>>>>> Add functional tests for AST2500 and AST2600 machines using the
>>>>>>>>> OpenBMC SDK v11.00 with Linux kernel 5.15. These tests
>>>>>>>>> complement the existing SDK tests and verify that QEMU correctly
>>>>>>>>> boots older kernel versions on these platforms.
>>>>>>>>
>>>>>>>>
>>>>>>>>> +    ASSET_SDK_V1100_AST2600_515 = Asset(
>>>>>>>>> +
>>>>>>>>>
>>>> +'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.
>>>>>>>>> +00/ast2600-default-515-obmc.tar.gz',
>>>>>>>>> +
>>>>>>>>>
>>>>
>> +'ece1a934095378929780f03e7d092e562f4b33b2841b80ad7c3d12a85744c0f6
>>>>>>>>> +')
>>>>>>>>
>>>>>>>> This asset file is over a gigabyte in size, it takes forever to
>>>>>>>> download, and our functional test asset download framework has no
>>>>>>>> mechanism for giving any kind of progress indication for
>>>>>>>> downloads (or even for telling you the URL it is downloading
>>>>>>>> until after the download is complete).
>>>>>>>>
>>>>>>>> Can we have a size limit for test assets please, at least until
>>>>>>>> the framework can support large assets a bit better ?
>>>>>>>
>>>>>>> Followup: we have six test assets that are over 500MB in size, and
>>>>>>> they are all aspeed tests. Please can you have a look at slimming
>>>>>>> these down?
>>>>>>
>>>>>> I see 2 big assets from aspeed only
>>>>>>
>>>>>>      64d8926a7d01b649168be96c986603b5690f06391286c438a3a772c
>> 8c7
>>>> 039e93
>>>>>>      ece1a934095378929780f03e7d092e562f4b33b2841b80ad7c3d12a
>> 857
>>>> 44c0f6
>>>>>>
>>>>>>
>>>>>> what are the names of the other files in $HOME/.cache/qemu/download
>>>>>> you have that are over 500 MB ?
>>>>>>
>>>>>> With regards,
>>>>>> Daniel
>>>>>
>>>>> These are the files :
>>>>>
>>>>>
>>>>
>> 5732255d4617d98b76bbbc116d331d6ac89906fa212969eb8213fdc4aea86451
>>>>    166M
>>>>> ast2500-default-515-obmc.tar.gz
>>>>>
>>>>
>> 2768e2526bdd3f928df31341801cb6de3b9a40ca942b538a3d0800cd26fbdbfe
>>>>    166M
>>>>> ast2500-default-obmc.tar.gz
>>>>>
>>>>
>> ece1a934095378929780f03e7d092e562f4b33b2841b80ad7c3d12a85744c0f6
>>>>    1.1G
>>>>> ast2600-default-515-obmc.tar.gz
>>>>>
>>>>
>> 64d8926a7d01b649168be96c986603b5690f06391286c438a3a772c8c7039e93
>>>>     1.2G
>>>>> ast2600-default-obmc.tar.gz
>>>>>
>>>>
>> 4f8778be176ece1b57d33c4aee13bb989be114c3e4703150eaeb6f996bd5587f
>>>>    582M
>>>>> ast2700-a1-dcscm-obmc.tar.gz
>>>>>
>>>> d5ceed511cd0dfefbb102fff2d731159e0472948a28066dc0d90bcd54be76525
>>>> 520M
>>>>> ast2700-a1-obmc.tar.gz
>>>>>
>>>>
>> 0e93f7976139da71fab9df7952a58bdd80650e23e7abf5853b0eb6695deb02d0
>>>>    581M
>>>>> ast2700-dcscm-obmc.tar.gz
>>>>>
>>>>
>> e2b8f043fe8063dd3b6ded93422e38bd41914dc9c3202199507652df024de4dc
>>>>    519M
>>>>> ast2700-default-obmc.tar.gz
>>>>
>>>> The image size for v09.08 was around 250 MB for the ast2500,
>>>> ast2600 and ast2700 SoCs. It would be best to keep it like this for testing.
>>>>
>>>> Would it be possible in v12.00 ?
>>>>
>>>
>>>
>>> Thank you for your suggestion and for reporting this issue.
>>>
>>> To allow QEMU to accept the image tarball size, I will create new tarballs
>> specifically for QEMU functional testing.
>>>
>>> The "ast2600-default-image.tar.gz" tarball will be based on
>> "ast2600-default-obmc.tar.gz".
>>> It will contain only the necessary images from ast2600-default-obmc.tar.gz
>> for QEMU functional testing, such as image-bmc.
>>> Including only image-bmc in the tarball will significantly reduce its size. In
>> SDK v11.01, the size should be around 64MB.
>>
>> I think the increase in size comes mainly from the rsa* directories.
>> Removing these would save 1G.
>>
>> Can you keep the same v09.08 contents : u-boot.bin, kernel, dtb, rootfs etc ? It
>> is good to have the different OpenBMC files for tests too.
>>
> Okay.
>>
>>> I plan to create the following new tarballs for QEMU functional testing:
>>> 1. ast2600-default-image.tar.gz
>>> 2. ast2600-default-66-image.tar.gz
>>> 3. ast2700-default-image.tar.gz
>>> 4, ast2700-a1-image.tar.gz
>>> 5. ast2700-dcscm-image.tar.gz
>>> 6. ast2700-a1-dcscm-image.tar.gz
>> ok. No need to change the AST2500 tarballs.
>>
> Do we need to generate ast2700-dcscm-image.tar.gz and ast2700-a1-dcscm-image.tar.gz?

They slightly exceed the 512 MB limit that QEMU was planning
to enforce.

   581.6 MiB [#######            ]  ast2700-a1-dcscm-obmc.tar.gz
   580.3 MiB [#######            ]  ast2700-dcscm-obmc.tar.gz
   519.3 MiB [######             ]  ast2700-a1-obmc.tar.gz
   518.4 MiB [######             ]  ast2700-default-obmc.tar.gz

I suppose this is sufficient for the time being. If you find ways
to reduce their size, that would be welcome.


Coming back to your proposal, a longer-term solution would be
indeed to provide a new set of artifacts, one for each QEMU
machine, containing only what is required to run the functional
tests :

    <version>/<QEMU machine name>-qemu.tar.gz

What would be easier for you : change the existing tarballs or
add new ones for QEMU ?

Thanks,

C.



> These packages do not include signed images in v11.00 (e.g., the ecdsa384 and ecdsa384-lms directories).
> Furthermore, the contents of ast2700-dcscm-obmc.tar.gz are identical between versions v09.08 and v11.00.
> 
> Thanks,
> Jamin
> 
>>> ASPEED will release v11.01 this week. After the v11.01 release, I will update
>> these tarballs and the QEMU functional tests accordingly.
>>
>> Great !
>>
>> Thanks,
>>
>> C.
> 


